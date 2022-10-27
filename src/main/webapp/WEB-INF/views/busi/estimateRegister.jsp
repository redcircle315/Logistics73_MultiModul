<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ taglib prefix="J2H" tagdir="/WEB-INF/tags" %>   
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css">
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css">

    <script src="${pageContext.request.contextPath}/js/datepicker.js" defer></script>
    <script src="${pageContext.request.contextPath}/js/datepickerUse.js" defer></script>
    <script src="${pageContext.request.contextPath}/js/modal.js?v=<%=System.currentTimeMillis()%>" defer></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/datepicker.css">
 <!--   ========datepicker style 적용=====================================================================    -->  
    <script>
      $(function () {
        let end = new Date();
        let year = end.getFullYear();              //yyyy
        let month = (1 + end.getMonth());          //M
        month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
        let day = end.getDate();                   //d
        day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
        end =   year + '' + month + '' + day;
        //$('#datepicker').text(year + '-' + month + '-' + day);
        // o set searchDate
        $('#datepicker').datepicker({
          startDate: '-1d',
          endDate: end,
          todayHiglght: true,
          autoHide: true,
          autoaShow: true,
        })
        })
   
    </script>
    <style>
        * {
            margin: 0px;
        }

        h5 {
            margin-top: 3px;
            margin-bottom: 3px;
        }

        input {
            padding: 2px 0 2px 0;
            text-align: center;
            border-radius: 3px;
        }

        .ag-header-cell-label {
            justify-content: center;
        }
        .ag-cell-value {
            padding-left: 50px;
        }

        .estimate {
            margin-bottom: 10px;
        }

        .estimateDetail {
            margin-bottom: 10px;
        }

        .menuButton {
            margin-top: 10px;
        }

        .menuButton button {
            background-color: #506FA9;
            border: none;
            color: white;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            border-radius: 3px;
        }

        .menuButton__selectCode {
            display: inline-block;
        }
    </style>
</head>
  <!--   =============================================================================================================    -->  
<body>
<article class="estimate">
    <div class="estimate_Title">
        <h5>📋 견적등록</h5>
        <span style="color: black">견적등록일자</span><br/>
        <input type="text" id="datepicker" placeholder="YYYY-MM-DD👀" size="15" autocomplete="off" style="text-align: center">
                 <div class="menuButton">
                     <button id="estimateInsertButton" onclick="addRow(this)">견적추가</button>
                     <button id="estimateDeleteButton" onclick="deleteRow(this)">견적삭제</button>
                     <button id="batchSaveButton" style=" float:right;  background-color:#F15F5F"  >일괄저장</button>
                     <div class="menuButton__selectCode">
                         <button class="search" id="customerList" data-toggle="modal"
                                    data-target="#listModal">거래처코드
                         </button>
                     </div>
                 </div>
    </div>
</article>
<article class="estimateGrid">
    <div align="center">
        <div id="myGrid" class="ag-theme-balham" style="height:100px; width:auto; text-align: center;"></div>
    </div>
</article>
<article class="estimateDetail">
    <div class="estimateDetail__Title">
        <h5>📋 견적상세등록</h5>
        <div class="menuButton">
               <button id="estimateDetailInsertButton" onclick="addRow(this)">견적상세추가</button>
               <button id="estimateDetailDeleteButton" onclick="deleteRow(this)">견적상세삭제</button>
               <div class="menuButton__selectCode">
                         <button class="search" id="itemList" data-toggle="modal"
                                       data-target="#listModal">품목코드
                         </button>
                         <button class="search" id="unitList" data-toggle="modal"
                                      data-target="#listModal">단위코드
                         </button>
                         <button class="search" id="amountList" data-toggle="modal"
                                       data-target="#amountModal">수량
                         </button>
            </div>
        </div>
    </div>
</article>
<article class="estimateDetailGrid">
    <div align="center" class="ss">
        <div id="myGrid2" class="ag-theme-balham" style="height:50vh;width:auto;"></div>
    </div>
</article>

<J2H:listModal/>    <!-- 조회 모달 --> <!-- 견적상세등록 제목 바로 밑에 있는 버튼이 아니라 ag-Grid 큰 표에 있는 컬럼명? 이라고 볼 수 있다. -->

<%--Amount Modal--%>
<div class="modal fade" id="amountModal" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">AMOUNT</h5>
                <button type="button" class="close" data-dismiss="modal" style="padding-top: 0.5px">&times;</button>
            </div>
            <div class="modal-body">
                <div style="width:auto; text-align:left">
                       <label style='font-size: 20px; margin-right: 10px'>견적수량</label>
                       <input type='text' id='estimateAmountBox'  autocomplete="off"/><br>
                       <label for='unitPriceOfEstimateBox' style='font-size: 20px; margin-right: 10px'>견적단가</label>
                       <input type='text' id='unitPriceOfEstimateBox' autocomplete="off"/><br>
                       <label for='sumPriceOfEstimateBox' style='font-size: 20px; margin-right: 30px'>합계액  </label>
                       <input type="text" id='sumPriceOfEstimateBox' autocomplete="off"></input>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id ="amountSave" class="btn btn-default" data-dismiss="modal">Save</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!--  ============================================================================================================ -->
<script>
     const myGrid = document.querySelector('#myGrid');
     const myGrid2 = document.querySelector('#myGrid2');
     
     const datepicker = document.querySelector('#datepicker');
     const customerList = document.querySelector('#customerList');
     const itemList = document.querySelector('#itemList');
     const unitList = document.querySelector('#unitList');
     const amountList = document.querySelector('#amountList');
     const batchSaveButton = document.querySelector("#batchSaveButton");
  
     // O setup the grid after the page has finished loading
     document.addEventListener('DOMContentLoaded', () => { // 브라우저가 로드되기 전에 밑에 agGrid가 먼저 로드된다. 이것이 DOMContentLoaded
         new agGrid.Grid(myGrid, estGridOptions); // 첫번째 Grid에 estGridOptions이  걸려있다고 보면 된다. 
          new agGrid.Grid(myGrid2, estDetailGridOptions);  // 두번째 Grid에 estDetailGridOptions가 걸린다.
      })
  //================================================================================     
  // O DATEPICKER    => dbClick 하면 할 수 있게끔
  function getDatePicker(paramFmt) {
    let _this = this;
    _this.fmt = "yyyy-mm-dd";
    console.log(_this);

    // function to act as a class
    function Datepicker() {
    }

    // gets called once before the renderer is used
    Datepicker.prototype.init = function (params) {
      // create the cell
      this.autoclose = true;
      this.eInput = document.createElement('input');
      this.eInput.style.width = "100%";
      this.eInput.style.border = "0px";
      this.cell = params.eGridCell;
      this.oldWidth = this.cell.style.width;
      this.cell.style.width = this.cell.previousElementSibling.style.width;
      this.eInput.value = params.value;
      // Setting startDate and endDate
      console.log(paramFmt);
      let _startDate = datepicker.value;
      let _endDate = new Date(_startDate);
      let days = 14; // 유효 일자는 현재일자 + 14일
      if (paramFmt == "dueDateOfEstimate") {
        _startDate = new Date(_startDate)
        days = 9;
        _startDate.setTime(_startDate.getTime() + days * 86400000);
        let dd = _startDate.getDate();
        let mm = _startDate.getMonth() + 1; //January is 0!
        let yyyy = _startDate.getFullYear();
        _startDate = yyyy + '-' + mm + '-' + dd;
        console.log(_startDate);
        _endDate = new Date(_startDate);
        days = 19;
      }
      _endDate.setTime(_endDate.getTime() + days * 86400000);
      let dd = _endDate.getDate();
      let mm = _endDate.getMonth() + 1; //January is 0!
      let yyyy = _endDate.getFullYear();
      _endDate = yyyy + '-' + mm + '-' + dd;

      $(this.eInput).datepicker({
        dateFormat: _this.fmt,
        startDate: _startDate,
        endDate: _endDate,
      }).on('change', function () {
        estGridOptions.api.stopEditing();
        estDetailGridOptions.api.stopEditing();
        $(".datepicker-container").hide();
      });
    };
    // gets called once when grid ready to insert the element
    Datepicker.prototype.getGui = function () {
      return this.eInput;
    };

    // focus and select can be done after the gui is attached
    Datepicker.prototype.afterGuiAttached = function () {
      this.eInput.focus();
      console.log(this.eInput.value);
    };

    // returns the new value after editing
    Datepicker.prototype.getValue = function () {
      console.log(this.eInput);
      return this.eInput.value;
    };

    // any cleanup we need to be done here
    Datepicker.prototype.destroy = function () {
      estGridOptions.api.stopEditing();
    };

    return Datepicker;
  }
  
  // ======= myGridoptions ===========================================================
  // O customerList Grid  
  let estColumn = [
    {headerName: "거래처명", field: "customerName", editable: true},
    {headerName: "거래처코드", field: "customerCode", editable: true, hide: true},
    {headerName: "견적일자", field: "estimateDate"},
    {
      headerName: "유효일자", field: "effectiveDate", editable: true, cellRenderer: function (params) {
        if (params.value == "") { params.value = "YYYY-MM-DD";}
        return '📅 ' + params.value;
      }, cellEditor: 'datePicker1'
    },
    {headerName: "견적담당자", field: "personNameCharge", editable: true},
    {headerName: "견적담당자코드", field: "personCodeInCharge", hide: true},
    {headerName: "견적요청자", field: "estimateRequester", editable: true},
    {headerName: "비고", field: "description", editable: true},
    {headerName: "status", field: "status"},
  ];
  let estRowData = [];
  
  // event.colDef.field
  let estGridOptions = {
    columnDefs: estColumn,
    rowSelection: 'single',
    rowData: estRowData,
    getRowNodeId: function (data) {
      return data.estimateDate;
    },
    defaultColDef: {editable: false},
    overlayNoRowsTemplate: "추가된 견적이 없습니다.",
    onGridReady: function (event) {// onload 이벤트와 유사 ready 이후 필요한 이벤트 삽입한다.
      event.api.sizeColumnsToFit();
    },
    onGridSizeChanged: function (event) {
      event.api.sizeColumnsToFit();
    },
    onCellEditingStarted: (event) => { // 거래처명을 클릭했을 때 걸려있는 이벤트
      if (event.colDef.field == "customerName") { //만약 필드이름이 cutomerName거래처명인 경우 밑의 click메서드 실행
        customerList.click();
      }
    },
     getSelectedRowData() {
      let selectedNodes = this.api.getSelectedNodes();
      let selectedData = selectedNodes.map(node => node.data);
      return selectedData;
    },
    components: {
      datePicker1: getDatePicker("effectiveDate"),
    }
  }

//======= myGrid2options ============================================================================================
  //O estimateDetail Grid  견적상세등록
  let estDetailColumn = [
    {headerName: "품목코드", field: "itemCode",  suppressSizeToFit: true, editable: true, suppressSizeToFit: true, headerCheckboxSelection: true,
      headerCheckboxSelectionFilteredOnly: true,
      checkboxSelection: true},
    {headerName: "품목명", field: "itemName"},
    {headerName: "단위", field: "unitOfEstimate",},
    {headerName: "납기일", field: "dueDateOfEstimate", editable: true, cellRenderer: function (params) {
        if (params.value == "") { params.value = "YYYY-MM-DD";}
        return '📅 ' + params.value;
      }, cellEditor: 'datePicker2'},
    {headerName: "견적수량", field: "estimateAmount", editable: true,},
    {headerName: "견적단가", field: "unitPriceOfEstimate", hide: false},
    {headerName: "합계액", field: "sumPriceOfEstimate"},
    {headerName: "비고", field: "description", editable: true},
    {headerName: "status", field: "status"},
    {headerName: "beforeStatus", field: "beforeStatus", hide: true},
  ];
  let itemRowNode;
  let estDetailRowData = [];
  let estDetailGridOptions = {
    columnDefs: estDetailColumn,
    rowSelection: 'multiple',
    rowData: estDetailRowData,
    defaultColDef: {editable: false},
    overlayNoRowsTemplate: "추가된 견적상세가 없습니다.",
    onGridReady: function (event) {
      event.api.sizeColumnsToFit();
    },
    onGridSizeChanged: function (event) {
      event.api.sizeColumnsToFit();
    },
    onCellDoubleClicked: (event) => {
      if (event != undefined) {
        console.log("IN onRowSelected");
        let rowNode = estDetailGridOptions.api.getDisplayedRowAtIndex(event.rowIndex);  //getDisplayedRowAtIndex: 보이는 줄의 인덱스 얻기
        console.log(rowNode);
        itemRowNode = rowNode;
      } 
      if (event.colDef.field == "itemCode" || event.colDef.field == "itemName") { //     || A OR B
        itemList.click();
      } else if (event.colDef.field == "unitOfEstimate") {
        unitList.click();
      } else if (event.colDef.field == "estimateAmount") {
        amountList.click();
      }
    },
    onRowSelected: function (event) { // checkbox
      console.log(event);
    },
    onSelectionChanged(event) {
      console.log("onSelectionChanged" + event);
    },
    components: {
      datePicker2: getDatePicker("dueDateOfEstimate") // getDatePicker
    },

  }

// ====================================================================================================================
   // O add and Delete function 추가,삭제버튼 함수
  function addRow(event) {  // o 견적추가버튼
    if (event.id == "estimateInsertButton") {
         if (datepicker.value == "") { // 예외처리와 흡사 
              Swal.fire({
                text: "견적일자를 등록하셔야합니다.",
                icon: "info",
              });
              return;
         }  else if (estGridOptions.api.getDisplayedRowCount() > 0) {   // 견적추가를 제대로 하나 하지 않고 버튼을 또 누를 경우
              Swal.fire({ //아직 처리하지 않은 견적이 있으면 그리드에 행이 남아있기 때문이다. 
                text: "처리하지 않은 견적이 있습니다.", 
                icon: "info",
              });
              return;
      } 
      
      let row = {     // 그냥 견적추가, 값을 받아오는 아이
        estimateDate: datepicker.value,  // estimateDate: 견적일자
        personCodeInCharge: "${sessionScope.empCode}",  // personCodeInCharge: 견적담당자코드  위에서 선언되어 있는 거 찾아오면 됨.
        personNameCharge: "${sessionScope.empName}",   // 'ag-Grid에 띄워지는 아이들의 값을 받아온다'고 볼 수 있다.
        effectiveDate: "",
        estimateRequester: "${sessionScope.empName}",
        description: "",
        status: "INSERT"
      };
      estGridOptions.api.updateRowData({add: [row]});  // 위에서 받아온 값을 updateRowData에 추가시킨다. 이렇게 되면 agGrid의 형태가띄워지게 된다.
    // 이 위까지는 견적추가 이벤트
    } else if (event.id == "estimateDetailInsertButton") {    // 여기부터 견적상세추가버튼 이벤트가 실행
      console.log(event.innerText);
      let estDate = estGridOptions.getSelectedRowData(); // 선택된 기존 setting 값
      console.log(estDate);
      if (estDate.length == 0) { // 첫번째 그리드에서 가져온 값들의 로우값이 0일 경우
        Swal.fire({
          text: "견적 상세를 추가할 행을 선택 하세요.",
          icon: "info",
        })
        return;
      }
      let rowNode = estGridOptions.api.getRowNode(datepicker.value);
      console.log("견적상세" + rowNode.data); // ex) 견적상세 : 2022-02-14
      if (rowNode.data.customerName == undefined) {
        Swal.fire({
          text: "견적 거래처 코드를 등록하셔야 합니다.",
          icon: "info",
        })
        return;
      }
      if (rowNode.data.effectiveDate == "") {
        Swal.fire({
          text: "견적 유효일자를 등록하셔야 합니다.",
          icon: "info",
        })
        return;
      }
      
      let row = { // 버튼을 누르자마자 빈 그리드가 위치 되어지기 때문에 다 공백처리로 빈 값을 넣어놓는다고 볼 수 있다
       itemCode: "",
        dueDateOfEstimate: "",
        unitOfEstimate: "EA",
        status: "INSERT",
        description: "",
        beforeStatus: "",
        estimateAmount: "",
      };
      estDetailGridOptions.api.updateRowData({add: [row]});  // 여기에 다가 위의 변수들을 넣어준다. 하지만 이 상태에서 견적상세등록 칸에 ag-Grid가 들어가는 건 아니다.
    }
  }
//---------------------------------------------------------------------------------------
  function deleteRow(event) { // o 견적삭제 버튼
    let selected = estGridOptions.api.getFocusedCell();                   // 견적
    if (selected == undefined) {
      Swal.fire({
        text: "선택한 행이 없습니다.",
        icon: "info",
      })
      return;
    }
    if (event.id == "estimateDeleteButton") {
      estGridOptions.rowData.splice(selected.rowIndex, 1);
      estGridOptions.api.setRowData(estGridOptions.rowData);
    } else if (event.id == "estimateDetailDeleteButton"){
      console.log("견적상세삭제");
      let selectedRows = estDetailGridOptions.api.getSelectedRows();
      console.log("선택된 행" + selectedRows );
      selectedRows.forEach( function(selectedRow, index) {
        console.log(selectedRow);
   //     detailItemCode.splice(detailItemCode.indexOf(selectedRow.itemCode), 1); // 배열요소 제거
        estDetailGridOptions.api.updateRowData({remove: [selectedRow]});
      });
    }
  }
  //=========================견적추가, 견적삭제 버튼 끝===========================================================
  //O Button Click event
  // o ListModal Click 
  
  customerList.addEventListener('click', () => { // customerList 을 클릭했을 때 실행되는 메서드
         getListData("CL-01"); // ()안에 있는 값을 인자값으로 들고 getListData메서드를 찾으러 출발~
          $("#listModalTitle").text("CUSTOMER CODE");
  });


  itemList.addEventListener('click', () => {
   getListData("IT-_I");  // IT-_1 을 인자값으로 들고 출발
    $("#listModalTitle").text("ITEM CODE");
  });
  
  unitList.addEventListener('click', () => {
      getListData("UT");
       $("#listModalTitle").text("UNIT CODE");
     });
  
  amountList.addEventListener('click', () => {
    console.log(itemRowNode);
    if (itemRowNode == undefined) {return;}
    if (itemRowNode.data.itemCode != undefined) {
      getStandardUnitPrice(itemRowNode.data.itemCode, "EA"); // BOX이면
    }
  });
  //--------------------------------------------------------------------------------------------
 // 각 모달에 걸리는 메서드 호출 => function
  // o if customer modal hide, next cell
  $("#listModal").on('hide.bs.modal', function () {
     if( $("#listModalTitle").text() == "CUSTOMER CODE"){
          
          estGridOptions.api.stopEditing();
          let rowNode = estGridOptions.api.getRowNode(datepicker.value);
          console.log("rowNode:" + rowNode);
          if (rowNode != undefined) { // rowNode가 없는데 거래처 코드 탐색시 에러
            setDataOnCustomerName();
          }          
     } else if( $("#listModalTitle").text() == "ITEM CODE" ){
          if (itemRowNode != undefined) { // rowNode가 없는데 거래처 코드 탐색시 에러
              setDataOnItemName();
          }
     }
  });
  
//o change customerName cell
  function setDataOnCustomerName() {
    let rowNode = estGridOptions.api.getRowNode(datepicker.value);
    let to = transferVar();
    rowNode.setDataValue("customerName", to.detailCodeName);
    rowNode.setDataValue("customerCode", to.detailCode);
    let newData = rowNode.data;
    rowNode.setData(newData);
  }
   
//  let detailItemCode = [];
  function setDataOnItemName() {
    estDetailGridOptions.api.stopEditing();
    let to = transferVar();
    
    /* if (!detailItemCode.includes(to.detailCode)) {
      detailItemCode.push(to.detailCode);
      console.log("detailItemCode:" + detailItemCode);
    } else {
      Swal.fire({
        text: "중복되는 코드입니다.",
        icon: "info",
      });
      return;
    } */
    itemRowNode.setDataValue("itemCode", to.detailCode);
    itemRowNode.setDataValue("itemName", to.detailCodeName);
    let newData = itemRowNode.data;
    itemRowNode.setData(newData);
    console.log(itemRowNode.data);
  }
  //-------------------------------------------------------------------------------------------------
  
  
  // 모달이 띄워졌을때, 기존의 값을 to에 세팅 
     $("#listModal").on('show.bs.modal', function () { 
       let existingData;
        if( $("#listModalTitle").text() == "CUSTOMER CODE"){
             if(estGridOptions.api.getDisplayedRowCount()!=0){
                let rowNode = estGridOptions.api.getRowNode(datepicker.value);
                existingData = {"detailCode":rowNode.data.customerCode, "detailCodeName":rowNode.data.customerName};
             }  
        } else if( $("#listModalTitle").text() == "ITEM CODE" ){
             if (itemRowNode != undefined) { // rowNode가 없는데 거래처 코드 탐색시 에러
                existingData = {"detailCode":itemRowNode.data.itemCode, "detailCodeName":itemRowNode.data.itemName};
             }
        }
        to = existingData;
     });  
  
  $("#amountModal").on('show.bs.modal', function () {
    $('#estimateAmountBox').val("");
    $('#sumPriceOfEstimateBox').val("");
    $('#estimateAmountBox, #unitPriceOfEstimateBox').on("keyup", function() {  //estimateAmountBox, #unitPriceOfEstimateBox 견적수량과 합계액
      let sum = $('#estimateAmountBox').val() * $('#unitPriceOfEstimateBox').val();  //sum에는 견적수량과 견적단과가 곱해진 값이 들어간다.
      $('#sumPriceOfEstimateBox').val(sum);  //  그러면 합계액에는 위의 sum이 담김
    });
  });
  
  $("#amountModal").on('shown.bs.modal', function () {  // 실행하고자 하는 jQuery 코드
     $('#estimateAmountBox').focus(); //포커스를 얻었을 때 어떤 행위하기=> 견적수량 칸을 더블클릭해서 모달창이 띄워졌으면 바로 견적수량에 포커스가 위치하게 된다.
  })

     document.querySelector("#amountSave").addEventListener("click", () => { //modal창 밑에 있는 Save에 걸리는 이벤트
         if($('#estimateAmountBox').val()==0){
             Swal.fire({
                 text: "수량을 입력하지 않았습니다.",
                 icon: "info",
             })
             itemRowNode.setDataValue("estimateAmount", $('#estimateAmountBox').val(""))
             itemRowNode.setDataValue("sumPriceOfEstimate", $('#sumPriceOfEstimateBox').val(""))
         } else if (itemRowNode == undefined) {   return;}
         estDetailGridOptions.api.stopEditing();
         itemRowNode.setDataValue("estimateAmount", $('#estimateAmountBox').val());
         itemRowNode.setDataValue("unitPriceOfEstimate", $('#unitPriceOfEstimateBox').val());
         itemRowNode.setDataValue("sumPriceOfEstimate", $('#sumPriceOfEstimateBox').val());
         let newData = itemRowNode.data; // 바로 위에서 받아온 견적수량,견적단가,합계액의 데이터들이 newData라는 변수명에 담긴다.
         itemRowNode.setData(newData); // 그러면 itemRowNode에 set해준다.  그 다음 일괄저장으로 출발
     })

 // ================================================================================================================
//  ======================일괄저장======================================================================
  // 일괄저장 <= 선택된 항목만 저장
  batchSaveButton.addEventListener("click", () => {  //일괄저장에 걸려있는  id이름에 걸린 이벤트 처리 시즈악 !
    let newEstimateRowValue = estGridOptions.getSelectedRowData(); // '견적추가'그리드 배열 리턴 받음
    console.log(newEstimateRowValue); //
    let selectedRows = estDetailGridOptions.api.getSelectedRows();      // '견적상세추가'그리드 배열 리턴 받음
    if(selectedRows.length==0){ // 에러처리
       Swal.fire({
            text: "선택한 행이 없습니다.",
            icon: "info",
          })
       return;  //오류메세지를 띄우고 끝낸다는 말
    }
    if (newEstimateRowValue == "") {
      Swal.fire({
        text: "상세 견적을 추가하지 않았습니다",
        icon: "info",
      })
      return;
    } else if (newEstimateRowValue[0].customerCode == '' || newEstimateRowValue[0].effectiveDate == '') {  //거래처명값의 0번째와 유효일자 둘 중에 하나라도 충족되지 않을 경우
      Swal.fire({
        text: "거래처명과, 유효일자는 필수항목입니다.",
        icon: "info",
      })
      return ;
    }
    for(index in selectedRows){  // 선택된 행들 예로들면, 견적추가에서 한 행, 견적상세 추가 이렇게 한 행 있다고 하면, 총 인덱스 번호가 0,1 로 잡힌다.
       selectedRow=selectedRows[index];
       console.log(selectedRow);
       if (selectedRow.itemCode == ""   // 견적상세에서 품목코드
            || selectedRow.dueDateOfEstimate == ""  // 납기일
            || selectedRow.estimateAmount == "") {   // 견적수량  중에 하나라도 만족하지 않을 경우
      Swal.fire({
        text: "견적상세의 품목코드, 단위, 납기일, 견적수량은 필수항목입니다.",
        icon: "info",
      })
      return;
    }else if (selectedRow == null) {  // 단 한행이라도 없을 경우=> 즉 상세견적을 추가하지 않을 경우
        Swal.fire({
            text: "상세 견적을 추가하지 않았습니다",
            icon: "info",
          })
       return;
    }// 여기까지가 에러처리 
    }  
   //console.log(estGridOptions.getSelectedRowData())
    newEstimateRowValue = estGridOptions.getSelectedRowData()[0];  // 일단 견적상세(estGridOptions)그리드에서 첫번째 선택된 행의 데이터를 newEstimateRowValue에 담는다. 구길이 소스: newEstimateRowValue=newEstimateRowValue[0];
    console.log(newEstimateRowValue.estimateDetailTOList);
    newEstimateRowValue.estimateDetailTOList = selectedRows;    // 여기 코드가 이상해서 이 부분만 보면 될 듯
    //console.log('@@@@@@@@@@@@ HERE!!!@@@@@@@@@@@@@')
    console.log(newEstimateRowValue.estimateDetailTOList);
                                                                                                                      // *** 상세추가그리드 부분을 estimateDetailTOList에 담아서 위의 추가 그리드에 합쳐준 다음 일괄저장으로 같이 데이터를 넘겨준다고 생각하면 된다. ***
    newEstimateRowValue = JSON.stringify(newEstimateRowValue);  // 받아온 값들을 JSON형태로 바꾸어준다고 생각=> 문자열로 변환
    Swal.fire({
      title: "견적을 등록하시겠습니까?",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      cancelButtonText: '취소',
      confirmButtonText: '확인',
    }).then( (result) => {  // 위 SWAL창이 뜬 다음
      if (result.isConfirmed) {  //결과가 컨펌이 되었을 경우
      let xhr = new XMLHttpRequest();  
      xhr.open('POST', "${pageContext.request.contextPath}/logisales/estimate/new?method=addNewEstimate&estimateDate=" // 위의 값들을 addNewEstimate.do를 호출시켜서 던질거임
          + datepicker.value + "&newEstimateInfo=" + encodeURI(newEstimateRowValue),
          true);
      xhr.setRequestHeader('Accept', 'application/json');// (헤더이름,헤더값) HTTP요청 헤더에 포함하고자 하는 헤더 이름과 그 값인데 전에 무조건 open()뒤에는 send()메소드를 써주어야 한다.
      xhr.send();
      xhr.onreadystatechange = () => {  //callback함수 사용
        if (xhr.readyState == 4 && xhr.status == 200) { // 숫자값에 따라 처리상태가 달라지는 것. xhr.readyState == 4 : 데이터를 전부 받은 상태,완료되었다.xhr.status == 200 : 서버로부터의 응답상태가 요청에 성공하였다는 의미.
          // 초기화 
          estGridOptions.api.setRowData([]);
          estDetailGridOptions.api.setRowData([]);
          let txt = xhr.responseText;
          txt = JSON.parse(txt);
          let resultMsg =// 초기화가 완료되었으면 이 결과 메세지를 반환
              "<h5>< 견적 등록 내역 ></h5>"
              + "새로운 견적번호 : <b>" + txt.result.newEstimateNo + "</b></br>"
              + "견적상세번호 : <b>" + txt.result.INSERT  + "</b></br>"
              + "위와 같이 작업이 처리되었습니다";
          Swal.fire({
            title: "견적등록이 완료되었습니다.",
            html: resultMsg,
            icon: "success",
          });
        }
      }; 
    }})
  })
</script>
</body>
</html>