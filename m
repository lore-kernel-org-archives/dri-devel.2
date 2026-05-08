Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33924CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 06:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9997710E1B8;
	Fri,  8 May 2026 06:16:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Kn6E37IM";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="h6TWmF3W";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7704010E1B8
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 06:16:15 +0000 (UTC)
X-UUID: 668a84344aa511f1a4e839cc21f16abe-20260508
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From;
 bh=VQIc6lph6BzWaGhaovK+nbzbjHfLfhsWFpoATW/jUAM=; 
 b=Kn6E37IMRecwtG2ap856UwQE5aIsiHAvk3qvV+uPqanhaZVtb6u4U9HEPEXqp+oqHZUMzq4iAVYs9+THICIb6GsrU7MtKcZBLrai/KthYC5dlMHlWn+rysQk3Rt5iHNuB8/1La4W2ebFROHnjJ1jOg4p8ou+0VKW88t2yWDqmxM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:312dd637-ed2a-4b91-829a-8cdafcfe4a36, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:7fe34945-8360-4d24-8500-9b9380fa4b0d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 668a84344aa511f1a4e839cc21f16abe-20260508
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw02.mediatek.com (envelope-from <morris.pan@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1888127255; Fri, 08 May 2026 14:16:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 8 May 2026 14:16:06 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 8 May 2026 14:16:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlNCOfQWb704Tnvi3EYIt7MbpLkRvLau0bJB5R4IlW+XYZYpHz6yGRcMcZ4DGD9iR1HaWZRyQT7cCvaCuLb4xSX2W6lUpuiYIk9lSTf0IdV93h16S6j7lL3VEbJKy87ZQ4d7tIjiDiD/ncZa61/xomKPZQfg8lUD3PqUHaEK8PpS24MD+61XRbgz7q9XJJH2FNYyh9tQv2iKErTiI8ZGg6fC9H8WoXpq/BFQrkWoerKRoyKXk0fM5ZySgRUAkPD+V+a/WPDepzQqcXwnZ7esc0/TRa70kL/bUPySsvoLxBL7aTb3taVarmDM8RPuJ8uPh8eJEyHDjjr+Y9t4oJoNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQIc6lph6BzWaGhaovK+nbzbjHfLfhsWFpoATW/jUAM=;
 b=ICjSpHOvHK6kR4GVdYPyi/HLu58hAkimhzU6HiGoDNuTnTl4EkTB3HTsKTAqPElUdF5vL1EXtsdDoc8hYijtWIgYWbRsfUM6qhdm/c3p66lEYdkXOEVrnGZThJgWLa/cb4Ya2ECSnBx5OewrxwVIqWPqP/eMOuhROPnVvEUAlo/F8pbjGgV+hOxiWJ5Vs1eonkLRQaVbnZF0lNQvuCZN6HNKbOd3HrWlzkcKlwMv9MBsBMAV/mOGBciwETCo1KYjImN6rlcBYYMfv8s8arxlV9TbYRgqZJGjC9f7YY+0u/plidtaDveJfmq6yTo4aYABYXbGzToFImrxf4c1gr2NzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQIc6lph6BzWaGhaovK+nbzbjHfLfhsWFpoATW/jUAM=;
 b=h6TWmF3WVYj0RFmkgNHUbfSzSQzA5X5+BBUABxmwXjgQpsI4n0Vcm3lXBmlew3JAjM2EJgA1WwwJE1irMC31C31HTeSH/Mxt4IHQjgOQFET+Nv3l8zHyqLl36YANXxRJGouTlNIHDyjdjJJ1McJxChqJHl9FVeEV4p/EnJPlUEQ=
Received: from TYUPR03MB7137.apcprd03.prod.outlook.com (2603:1096:400:344::14)
 by SE2PPF5449A096D.apcprd03.prod.outlook.com (2603:1096:108:1::499)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.10; Fri, 8 May 2026
 06:16:01 +0000
Received: from TYUPR03MB7137.apcprd03.prod.outlook.com
 ([fe80::be01:24ff:a95d:a7e]) by TYUPR03MB7137.apcprd03.prod.outlook.com
 ([fe80::be01:24ff:a95d:a7e%4]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 06:16:01 +0000
From: =?utf-8?B?TW9ycmlzIFBhbiAo5r2Y5rOw54K6KQ==?= <Morris.Pan@mediatek.com>
To: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@redhat.com" <airlied@redhat.com>, "dongwon.kim@intel.com"
 <dongwon.kim@intel.com>, "dmitry.osipenko@collabora.com"
 <dmitry.osipenko@collabora.com>, "kraxel@redhat.com" <kraxel@redhat.com>
Subject: Re: [PATCH v8 1/3] drm/virtio: Freeze and restore hooks to support
 suspend and resume
Thread-Topic: [PATCH v8 1/3] drm/virtio: Freeze and restore hooks to support
 suspend and resume
Thread-Index: AQHc2B4B/ddrDpTVjE++bd2n0sXBv7YDtAsA
Date: Fri, 8 May 2026 06:16:00 +0000
Message-ID: <f1d45e9dcec1c4716e53cdc7e8c0442bc85d4321.camel@mediatek.com>
References: <20260429204729.993669-1-dongwon.kim@intel.com>
 <20260429204729.993669-2-dongwon.kim@intel.com>
In-Reply-To: <20260429204729.993669-2-dongwon.kim@intel.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR03MB7137:EE_|SE2PPF5449A096D:EE_
x-ms-office365-filtering-correlation-id: 1c6c02b5-55db-48b0-4894-08deacc946f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: MzOEM7Z56pu0WDER93FRBOLp0+aXXKsLS3/LHYvM2ZzjZluiOAJ+7cSrypo/VfrqDjvdPJgKZ+fd6Y4FjUHhxRc3+tRx+r/uHmZ9Yx5hCG5R1obUbyVCVGpi1G2a+lr2OZWVFMDa4z3SIZVd9qAz2YmRrfxaWzid+zWmEyEU0hUIPkv7i077cL1130muGZcL4Xf7NAPi8MJIfTESD6aSpTXHaTQHTYLQS9oaka58ncwCek18ZXLDAPzGg7TxaeRZN5k18eYrQb7IlBfeX9Len7qoHS7caPGTys+WXO/F2vm4+AJosAr9mWvKoM/K9Y6vc6KBJePC5NQr2cxyJ0p2u27e+MnWk8cmO0qpSgJX+VCZZtN7uQ12pfnTPZ3+zmJ4r6coFcKVNCDfyojN9/zJG8I+JkbAcA1LTt3IexEgczQElcFMUfbltx6q7zKnOv/Dx5TOdG+1bMZoO+P3hjCT0xE8rLzLOTZuyg4XxfWCjfqpjWlDDZLD8cAyPSzRG2jSpBebBJDRB7K4c1MRO3B8Z4CwRGMGDYXHGA69Ks/azLWbUUcqoB4NPq0ztGZk1SvAExNLHCIlvPliwuEVGg25SRm6JxGgmawSwTFix4xsM3JSXGRR3aHVw80QBu08UhGjA5NAdxxUOZITaGCrhrrewSQq4o1aLOHPHKXKvnA4dm6QhSQFUAWqDIGusHWElAzl54QDXAFC2qdENM7/a6hu9RdVDjqJBL4pqnoZ0PpXfS0NbbBOf50YX+V4BqG/V4Q8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYUPR03MB7137.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDNhaEVvaFpqZzBTTE4wSjNSRlpVZkRZUWFnR21FbEpjV3U0dUY5bGplcTg5?=
 =?utf-8?B?UXFZRHFJR1hQTHNESVoydEdDenRPYlZTUWlDMmJxeE1UY0Z1ZkpSeGRMUytN?=
 =?utf-8?B?Qm9vK1prR1RTY3c5Z0ZZQ2hGdXpsT0pEb0VpMkhyL2xzOU5VZG85MW83K0tQ?=
 =?utf-8?B?cHF6MlBscXB2ZEJ4aDdvaVMxeDJzckc1RWtMdUZTSFBza2lwams5VzkvV2Jh?=
 =?utf-8?B?TklKb1FqL050TzdwdXNIa2V6NFJ0VXEzdGFlWXVNQjRIUndKZGV2NlpNVDJw?=
 =?utf-8?B?OEhjb09GT3NhcTdiUm5ZNEZiTUxwaUhXTkYySDFsQVFyT1ZqQzZ2NWg2V2xs?=
 =?utf-8?B?TDZCR3U2TnpzWnV5M2pKQms3SGlwQSs5NXNrRUs5MHZ6MnpXdUVJTmxReGNa?=
 =?utf-8?B?bGxyOGxXVGV3RE8yeUMyQjFmUVRDaFBaeFduYzhyWEJwUngrNi9GdnhBdDhN?=
 =?utf-8?B?cm1keE5qaWhtVllLd2NJQUFMaE03b3lNUDA4WklwRVAyajJkd1E0SDUrRFFo?=
 =?utf-8?B?V3VHbUoyZnJXeDZidXZjRW1mdFVJbkNwZXZkRnB4TkI0enVDREZ2YkFiRUs4?=
 =?utf-8?B?c0pOd1IySWgxVFAxMWhTRjFJMUZMRUJrR1hOclEzYnd0N0xzZ3lEbXcvZmNn?=
 =?utf-8?B?TzEvYXFoMnFFT3ZFVEhqdTNvUWNmdzlyd1piUjJiUDhZNmYzOHMySHhFbWly?=
 =?utf-8?B?d0l0WFU3a3ZqZ3NpL1hXQjA0V2ZKWk04NEt5NHBBdWFBSGtMekc2Tmt0bG91?=
 =?utf-8?B?UWpBRXRtWWh3YkRpWUs0TnFlb3ZiaUVBWnVwcVlFUWJ0WXZsdzVXclVxK3Rq?=
 =?utf-8?B?d05kRVB1bnExbGRxS0VjS0ZPUnRoZmpPMVZ2c1ExUHphUjc0SVdGU0FmOFlQ?=
 =?utf-8?B?b21vY29xVnBtTE9hNWhXQzV6cm5ERXJZUnFsckNLL0VMZCt0VTczWHY3aVRk?=
 =?utf-8?B?cVZXSTA5WVBlVGVyTG03T2p0aFFKcjVRbXNCSCtUekhlSzkxQTRIVERjeXdm?=
 =?utf-8?B?TTA2blZVMGJXcWo1R2syaEFiSmo1MXd1c1c2SG5iZ0ZJNU1SUDhuYnJ4NkVC?=
 =?utf-8?B?bnZhblZIRkVSRURhcVQ5RGRTbFRHMHdMcGt3TDJwT0lBMzZRb1FlMVNpYU8x?=
 =?utf-8?B?QjRlRW5PODlLa3pPemdtRDBxbS9sSEVXd2NjR3R3QzFIaU01WDBSc3Jvd2t5?=
 =?utf-8?B?cUx2cGZDYVlYSlQrUkowOVltZEowRzluMnZPbFZKU2FUeWFLNWpFcEViM2JQ?=
 =?utf-8?B?WnBpRy9uZzl5djE1alFocEJrWXFZN3A0dVVkUEgxL2JzcWxXMHlveW9ONGF5?=
 =?utf-8?B?VGl3dHVqK2dvN2pWNjNkbVRiQXBqMjkwelA3Rm5ubVdBSnIwRmdYRjVnZ2JX?=
 =?utf-8?B?cnl0MUpQbitLOE5sbXpYOW9ycENjVlNPeGl1M0JKOUd5TDA5cjRTWnIyTzVo?=
 =?utf-8?B?T2trTm56Q2wxcTB2Ykx1eWkxQS94Q285cGljWWRPK0JkZ09GNmFwbDg0d0xS?=
 =?utf-8?B?QlJjb2NieUR3R1IzS3RHckh5c1RwL3ZUUkVpUTFNeUNaZXdxWExjWGYxNWdS?=
 =?utf-8?B?b1ZvbGNnYnN6dDhuVGZsZGw1N2I2bmk1WS9pVTJwVCtkRlYrNElpUVV2cDhq?=
 =?utf-8?B?TEk4QkJHbDd6RUZlVmVVbEFEVm9KSzEyQU9VWUJucmNhWk5RQkt3bUZTYVI0?=
 =?utf-8?B?QURFZDFnYnF5UEFCSG51MU10TDZWZjVBVENoVGZLNnZDd2xRcExzUUhaQ0Jk?=
 =?utf-8?B?dTB3V2xqQnlRdDdSUzZaTi9ncFdFM3Z5L0lIY2FhUi9rK1hJaUFoeW91QUJN?=
 =?utf-8?B?bzBNbjFTQ25mdXBEUmdOZWE3N1BmOGVURFBlNHdGSE56T2x1d3V6UGJpU1BJ?=
 =?utf-8?B?T2NSQjJRczUxWDQvVUNTaUdjUE9HdXNwTmRXYzNNUER1anF0TkJVSHpOdFRr?=
 =?utf-8?B?M3RYVWJtQ3kwQ0VHK0o3WVhlTGUydXFKOFhNQ3g1cXFZVERxa3NxZjY1dWdM?=
 =?utf-8?B?VTZJRU9leG8vNU0zeEVpYkJSZ09HMFRUU0YyNWtXVDJHZ2pWQVlndFNyZ3Fy?=
 =?utf-8?B?QnJsaUlrM2MrOHhMK016MWsyTmdnbHZYZ0dqQXpNeTFLaVFhYUFLVmdvQWFh?=
 =?utf-8?B?cmI1eFFoWE1FakJTL3o5NlhXWlRmd2NjQkVVRzFpcHpPQlRUaEhVZlZ1TjR0?=
 =?utf-8?B?eEx6L05INS9Nc0NDdURDMmZWZ3dHMlVjb21HVVU3M2NibUhyYldzYXpVNXlv?=
 =?utf-8?B?ODNXb0NQYnNmd09aZE9MOTY0b2ZyNVNCZW1mVitXVkRFdXdyd1ZCc2VnZk96?=
 =?utf-8?B?K29iR1E1V2Z1alZOVjhaQ3ZoVlc5YnM4akhXeGN2NDdOU1FoaGJ2YWtYSml4?=
 =?utf-8?Q?7TrqRLTDfPTIxguo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8E6674A8E9284428E380A4805992ECA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HgVi1SzIDUvgf5TLe0+OYfpSL1AxwU9WJbjDBmXzzcP2nqvzr5pWVorHiWuzWkHrthj11DgrZ42WZFFEe8yYefZf5tbUpHUYZnb2GMSfLs+c/uzOT5Uoebmr/fDWnMvC3Tm+d5MM2TXRxQQH9me0K6ZmHoXAGmBeQ2No5dNwxGzZfYKopNfAPNAaQ3SbPtbS4PM1Ag8mhhfb267u/LmcNaFmtr6H/jRSLsV+4LBBXowXmTA3fHG78pIO6MqvrmOR60G56/ohm+cKWMdARQXcHJ1QdTZDwehidBWsKWQceJdodWZnHCWJK1dAlG9nCyJpy4tw/gmAz7G86s9R/v1VOg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR03MB7137.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6c02b5-55db-48b0-4894-08deacc946f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 06:16:01.2268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Uo5aSrtJrpFkLS8qp+hpBYEIvN3KsQIyQzye4ftV6myEJAfguL4Yt+InburEK2Q9FEzfq6TZCQd1WJIPpaA8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF5449A096D
X-MTK: N
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

T24gV2VkLCAyMDI2LTA0LTI5IGF0IDEzOjQ3IC0wNzAwLCBkb25nd29uLmtpbUBpbnRlbC5jb20g
d3JvdGU6DQo+IEZyb206IERvbmd3b24gS2ltIDxkb25nd29uLmtpbUBpbnRlbC5jb20+DQo+IA0K
PiB2aXJ0aW8gZGV2aWNlIG5lZWRzIHRvIGRlbGV0ZSBiZWZvcmUgVk0gc3VzcGVuZCBoYXBwZW5z
DQo+IHRoZW4gcmVpbml0aWFsaXplIGFsbCB2aXJ0cXVldWVzIGFnYWluIHVwb24gcmVzdW1lDQo+
IA0KPiB2MjogMTBtcyBzbGVlcCB3YXMgYWRkZWQgaW4gdmlydGdwdV9mcmVlemUgdG8gYXZvaWQg
dGhlIHNpdHVhdGlvbg0KPiDCoMKgwqAgdGhlIGRyaXZlciBpcyBsb2NrZWQgdXAgZHVyaW5nIHJl
c3VtcHRpb24uDQo+IA0KPiB2MzogUGxhaW4gMTBtcyBkZWxheSB3YXMgcmVwbGFjZWQgd2l0aCB3
YWl0IGNhbGxzIHdoaWNoIHdhaXQgdW50aWwNCj4gwqDCoMKgIHRoZSB2aXJ0aW8gcXVldWUgaXMg
ZW1wdHkuDQo+IMKgwqDCoCAoRG1pdHJ5IE9zaXBlbmtvKQ0KPiANCj4gdjQ6IENoYW5nZSB3YWl0
X2V2ZW50IHRvIHdhaXRfZXZlbnRfdGltZW91dCB0byBwcmV2ZW50IHBlcm1hbmVudCB3YWl0DQo+
IMKgwqDCoCAoTmlybW95IERhcykNCj4gDQo+IFN1Z2dlc3RlZC1ieTogRG1pdHJ5IE9zaXBlbmtv
IDxkbWl0cnkub3NpcGVua29AY29sbGFib3JhLmNvbT4NCj4gVGVzdGVkLWJ5OiBEbWl0cnkgT3Np
cGVua28gPGRtaXRyeS5vc2lwZW5rb0Bjb2xsYWJvcmEuY29tPg0KPiBDYzogVml2ZWsgS2FzaXJl
ZGR5IDx2aXZlay5rYXNpcmVkZHlAaW50ZWwuY29tPg0KPiBDYzogTmlybW95IERhcyA8bmlybW95
ZEBudmlkaWEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBEb25nd29uIEtpbSA8ZG9uZ3dvbi5raW1A
aW50ZWwuY29tPg0KDQpUaGFua3MgZm9yIGZpeGluZyB0aGlzIGlzc3VlISANCg0KSSBjaGVycnkt
cGlja2VkIHRoaXMgcGF0Y2ggb250byBhIGtlcm5lbCA2LjEgYW5kIHRlc3RlZCBpdCB3aXRoIFFO
WA0KaHlwZXJ2aXNvci4gDQpJdCB3b3JrcyBhcyBleHBlY3RlZCBhbmQgcmVzb2x2ZXMgdGhlIHBy
b2JsZW0gaW4gb3VyIGVudmlyb25tZW50Lg0KDQpUZXN0ZWQtYnk6IE1vcnJpcyBQYW4gPG1vcnJp
cy5wYW5AbWVkaWF0ZWsuY29tPg0KDQpCZXN0IHJlZ2FyZHMsDQpNb3JyaXMgDQo=
