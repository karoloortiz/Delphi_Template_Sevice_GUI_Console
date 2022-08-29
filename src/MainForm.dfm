object MyForm: TMyForm
  Left = 0
  Top = 0
  Caption = 'MyForm'
  ClientHeight = 245
  ClientWidth = 802
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object _service_manager_pnl: TPanel
    Left = 0
    Top = 0
    Width = 476
    Height = 245
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 481
    object service_status: TLabel
      Left = 25
      Top = 70
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
    object install_service_btn: TButton
      Left = 25
      Top = 135
      Width = 90
      Height = 25
      Caption = 'install service'
      TabOrder = 0
      OnClick = install_service_btnClick
    end
    object _uninstall_service_btn: TButton
      Left = 24
      Top = 175
      Width = 92
      Height = 25
      Caption = 'uninstall service'
      TabOrder = 1
      OnClick = _uninstall_service_btnClick
    end
    object service_name: TEdit
      Left = 195
      Top = 25
      Width = 236
      Height = 32
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  object _workThread_manager_pnl: TPanel
    Left = 476
    Top = 0
    Width = 326
    Height = 245
    Align = alRight
    TabOrder = 1
    ExplicitLeft = 235
    ExplicitTop = 5
    ExplicitHeight = 236
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
