object MyForm: TMyForm
  Left = 0
  Top = 0
  Caption = 'MyForm'
  ClientHeight = 340
  ClientWidth = 921
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 13
  object _service_manager_pnl: TPanel
    Left = 0
    Top = 0
    Width = 595
    Height = 340
    Align = alClient
    TabOrder = 0
    object service_status: TLabel
      Left = 25
      Top = 165
      Width = 170
      Height = 33
      Caption = 'service status:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object _service_name_lbl: TLabel
      Left = 25
      Top = 25
      Width = 165
      Height = 33
      Caption = 'service name:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object _customParams_lbl: TLabel
      Left = 25
      Top = 100
      Width = 239
      Height = 33
      Caption = 'custom parameters:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object _defaults_file_lbl: TLabel
      Left = 25
      Top = 65
      Width = 147
      Height = 33
      Caption = 'defaults file:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object install_service_btn: TButton
      Left = 25
      Top = 250
      Width = 90
      Height = 25
      Caption = 'install service'
      Enabled = False
      TabOrder = 0
      OnClick = install_service_btnClick
    end
    object uninstall_service_btn: TButton
      Left = 24
      Top = 290
      Width = 92
      Height = 25
      Caption = 'uninstall service'
      Enabled = False
      TabOrder = 1
      OnClick = uninstall_service_btnClick
    end
    object service_name: TEdit
      Left = 200
      Top = 25
      Width = 316
      Height = 32
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnChange = service_nameChange
    end
    object application_service_check: TCheckBox
      Left = 25
      Top = 210
      Width = 246
      Height = 17
      Caption = 'Manage only my application services'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = application_service_checkClick
    end
    object customParams: TEdit
      Left = 280
      Top = 100
      Width = 236
      Height = 32
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnChange = service_nameChange
    end
    object defaults_file: TEdit
      Left = 280
      Top = 65
      Width = 236
      Height = 32
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnChange = service_nameChange
    end
  end
  object _workThread_manager_pnl: TPanel
    Left = 595
    Top = 0
    Width = 326
    Height = 340
    Align = alRight
    TabOrder = 1
    object status_lbl: TLabel
      Left = 35
      Top = 25
      Width = 81
      Height = 33
      Caption = 'status:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object resume_pause_btn: TButton
      Left = 95
      Top = 140
      Width = 111
      Height = 25
      Caption = 'start_stop_btn'
      TabOrder = 0
      OnClick = resume_pause_btnClick
    end
    object start_stop_btn: TButton
      Left = 95
      Top = 100
      Width = 111
      Height = 25
      Caption = 'start_stop_btn'
      TabOrder = 1
      OnClick = start_stop_btnClick
    end
  end
end
