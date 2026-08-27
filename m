Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF41AC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 05:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E42E710E09A;
	Thu, 27 Aug 2026 05:33:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Shy4ecYO";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="g9q8Fnkm";
	dkim-atps=neutral
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71DA610E09A
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 05:33:20 +0000 (UTC)
X-UUID: ce5bbbfca1d811f1b1788b6acf885367-20260827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=ukeE022B9MsnytuX9VuY44/9VZCrWHjOEcTGzu18D3Q=; 
 b=Shy4ecYOnnbfiFQi/Zd6QnkORwviXtY0On4obekCmpm4Q9+OSoYIHZmuAIt6lz4dZ/DLB6EM4KYyOB1N7wPhABATg4hU5ZfzYo8WryOKoCIzKdIVX19fzycZcv4m2IAYy4IGqJHQR3AgW7qXjPSBdq8ew+d+LKwy/RGBYopgTHk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:3f71b26a-5db0-4e9a-b088-279227649f33, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:e95279fe-f4cb-4ad2-b022-e3ac6648bf25,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|136|836|865|888|898,TC
 :-5,Content:0|15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:
 nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
 :0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ce5bbbfca1d811f1b1788b6acf885367-20260827
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 971110780; Thu, 27 Aug 2026 13:33:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Aug 2026 13:33:16 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 27 Aug 2026 13:33:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yf31pXt5jz85/7EVsAp53PwFkslCN5yWTdi6xHJIotQAhFrvt+0ZD81mHcmIAcj/1YrcpPmAvrkeGWCATjQPvZyZdXdMxjr3TXy8aFJ8wqQrLR8lFFw5I/pRPlBgVQo07McrrJNSC4B/yfRxWD80ilV72owaVRlh+CZmSMEfmDkj2VZ75X/tBa6zOdtFv60nFSJXn36gvg4GZ4lq/zfsH34ZU6/oBni1bVgnjq5fFQSfkae7badAMsyHeSz3GIDHMsgktolnK6FT4MX7We3L6NLBCoJTDtQCjsDlrA6L5OA2mya8SMZw5kfWFyoH6NqAY//ASrNi9hbQqlkDgF/cjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukeE022B9MsnytuX9VuY44/9VZCrWHjOEcTGzu18D3Q=;
 b=jXIfcSbYSfewidcZjfcY7meMJoecPx+tJJOR5aYQIhEvSWuJpqUlisS6lJOUqqD7Fh1VmzEQmefGzlogvWhXwdlCx9w/5ff6onJCKMhKogJQHQMfYmoNAqy5CUXsdh53sGvG9ce1FYGbW8AAMOOkJEVWwYL7bdwsfZZ85yaRepj02KrkMTTmx4bNygu2t+sA8EcTKYrs3ZBSVKIn1HnlvjnEGvT0P6DJncxRSZqbRT0w9Y4rpUg04J9RSmLUjo3HaIwiZzjyTxOW7h+/PoKk4wM54/bvYUEbqlfWix2wtS+zXwKDHGSXP+lI6aG0InNXIRtUrT2tx4Oxcw879rxRNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukeE022B9MsnytuX9VuY44/9VZCrWHjOEcTGzu18D3Q=;
 b=g9q8FnkmKFiBgTHGtXcOLcUvWZl3Q0zLw0G/oUZThvbqeiqapnPmLf0rA+wzR5NVURr67Q95UJq8u5W1JRjVQj3njKTP89Ocay4ZbxsjJiBKns92/NdhBVyN3pSdYEJLn3uKts+zPfXDT3ZhY4PjfY4QfgEOtneLByBMTR2W5E0=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYNPR03MB10354.apcprd03.prod.outlook.com (2603:1096:405:3c2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Thu, 27 Aug
 2026 05:33:12 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 05:33:12 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "kernel@collabora.com" <kernel@collabora.com>, "robh@kernel.org"
 <robh@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
 <mripard@kernel.org>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
 <jitao.shi@mediatek.com>, "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>, =?utf-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?=
 <Justin.Yeh@mediatek.com>, =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?=
 <Jason-JH.Lin@mediatek.com>
Subject: Re: [PATCH v6 11/11] drm/mediatek: Add Write DMA (WDMA) Engine for
 Writeback support
Thread-Topic: [PATCH v6 11/11] drm/mediatek: Add Write DMA (WDMA) Engine for
 Writeback support
Thread-Index: AQHdFGH8SOBQUMKKBESgT1IFz8F2EbaxolSA
Date: Thu, 27 Aug 2026 05:33:12 +0000
Message-ID: <232cbc7ff5f2c50230eddf4db1f8eb7145a41d23.camel@mediatek.com>
References: <20260715135703.46540-1-angelogioacchino.delregno@collabora.com>
 <20260715135703.46540-12-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260715135703.46540-12-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYNPR03MB10354:EE_
x-ms-office365-filtering-correlation-id: 6eeda6b8-45f9-44c7-f2fa-08df03fcafb5
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|42112799006|1800799024|23010399003|38070700021|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: GOkDMsFrD1hIl5gC5tBEbQKgOvAEhNs681/GDZ2VR9FxucE4fgM9KE5+QihtFravBJn67EQ3ol4eXAXVeY6HRCUFcPViMX8b9p37Povj2NBxZpQ677wOHDcFxPc8Vkl4MduwEMpX5po84l7LjoIjC2rpFNSoQC0hjtEgE0bpfYA1AP4ZFduY6APiTdKW5M54MaRInXTHiWiuoVejQg5mBKLYVMldRdwOh2s8x9IZ8JwZmvGhZe08pZKpNWwKh+qy8pWFOwIcbAZLL1q9zX7cvtFNfCI3qqkNTvoA8V79YZuyAvKdFmy2Vu80N7PPhfQmI89HvlDLj1KnMJgip531XXWEpjksP1lYhzVIUunJyPEXa5Nv3IpCSenV/csMQgLm1A4AbabbMDRx9ksQxzzlaOIJtGENSz8u+fZSkLvMpoRTdtTLeiuNSmgL88vz52m6Z8ULglYF2/W16pmjwcsX18m6G2KYkxbqtuizPy1YmDXRVSJenx7Sb2VKRVg8gNDi0ggkqbMYA7/hFklO1fOqsoka/ATkAz5wZCngCrslxo0bVXRgPXsOjE/83kmK9hMLV7570oRPokSLZHKKZqZ/wQTcOv9gwrhJi9LCW9+jTqP3chPrJpnnKR1UCNhk3OxI+UJMkHrzl/y1n2gSgUSGmr2kghlha44yi1vH9PS0Ww0wX1qCjzPIflCCzaXWM45ZhyC7n59ySQydea4oa8MWxw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(42112799006)(1800799024)(23010399003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1hhbEN0VGNYNUF1OHBKK1p4YzRsdkd3aGtjWHVLek1hZWFJVTB3S0dzZFdu?=
 =?utf-8?B?VlpGS21laHJxbUloYmtRdVYwWTVkWEFXa3ZlU0pHTlduLzlya1NNUGlQTVVv?=
 =?utf-8?B?Smh4dlNBVGx4TFRUT09oMVJYWVVORkVxTWJ0UjVDTEpKMlVGUXNKTldXSU9Q?=
 =?utf-8?B?RllPVEozV1V2dmVFSEFoeDJXUU1BQUo3d1JUbXNqL0lRT1orWlNyWkRBOFI4?=
 =?utf-8?B?eHZzandsMU9VNkhUZ3p5d0V3RWMrdG1BOTlxWmpFQ0VMcmc3K1JpWDVKMGdK?=
 =?utf-8?B?czJIaDUwa0tQZVhCUEZ3dTVkQ3FTRFFWSStHMDFwVktlY1laNHdPdkJHVnBj?=
 =?utf-8?B?OWJzS0NTcUpWWVlibnMyRUJ1N3ZTNUpqVk93Zzdxd1dwNExlQ2Z0TE5zY05U?=
 =?utf-8?B?YUxpTmFZRTB3ZEUxVndQaTVOdUNjVGJyTTkxVExhSG1XY1Z3WVdsbnRaRzVh?=
 =?utf-8?B?cW95ekh2U1JZWnFjOVZCV2V3YllwV0RxaU5tUUR2YkROQzYwYkFIV29RUk9W?=
 =?utf-8?B?R25vZSszQ2U5eFdCcCtxVDYzbFZiS2hyeDJ6c1c2WW8wL1BETWNGWGtTdElV?=
 =?utf-8?B?Q1R5d2VYQnQ3SWdIUGJzYzlyQTVlK1lsL2k1VGpiZENnVFc4dW9HZ1FjeXdY?=
 =?utf-8?B?aHlpMFpEOWlVV0ZqQzBNa2lZbHFYWFRWUlg2ZW5pVVhMVVRrc1c2TmFaQStQ?=
 =?utf-8?B?VW9Ra1Q4VGVCbWFyWEdIRXVkeFZ1Y21lWXl0dVIzdzZGSHI0Y3BVUlp1djg3?=
 =?utf-8?B?OVRPZVVaM3RtNXhqb2ZqSWY2ZkhldWFHamRkTVlLemFKM0lyRzNNZVBOcGR1?=
 =?utf-8?B?OHQ1R2p4cFNZOFAyMmJ3aFNRdzZEdTd6b0NzdDdyeWF6dDdzRUcwc2JWcEFN?=
 =?utf-8?B?YzlUcjdkSDNQOE12cytZQ2tGUVRZUjVVOHlUN1I2N3h5Q2tVa1hSNXhlSkNt?=
 =?utf-8?B?RUlmbzFaWldQQ0Y5VU80SzZ6NWh3OVZpdmkzY2pZb0V6MWZ0cFRORGRKbi9k?=
 =?utf-8?B?V0hmRDg3QjBDS1FIbVhnNVQ3Y3NyZG8vRW9tSzJZelVoVFBIL0tnclBMcFpT?=
 =?utf-8?B?Wks0Z040eEZWSURVemRPU2RLdmdaS0ZoeDM2VWJ3dC9GN2dHQzR2aGdMV0pp?=
 =?utf-8?B?N3pMY25vejdsaUtwYWFtVHoreE5MVGpyR1l0WDN1TUV1QXBUUWY4NGVOZndF?=
 =?utf-8?B?QXl4NDFvcktRMzkxUmxYalJlL250SFJGeEpjbGJLNDVvbVY5UWpqd21wZGdr?=
 =?utf-8?B?RmdWeUMweTNhc1puaEVmZmFhTHNjdEx5UjVjWG1RSFdVWFhhTUJ2UGI2ZURB?=
 =?utf-8?B?QWV4ZVZ5QlcxYlVMNDhvWEpyTWtVRVRud3IyaE1GYVN6aVZqTkROb2pTa1dO?=
 =?utf-8?B?bmtmZ09iT0FXZUplVVdWSVRFRkd4VzF2dm1VZ1RiTCt0VGc3MG9LTjRkdFZn?=
 =?utf-8?B?YS9GOFB2QXg1NU1DQ00zVU9PSkpyRDF4eFFVVjBMWkgvQmFxRVVMYWdQNk9u?=
 =?utf-8?B?cVhrb1N1Sldna2hxZlQvQUVTNVFZeU5iT2w2ZGExNHFOMHdwZWk5d0pjNExa?=
 =?utf-8?B?bWhxcXZaYnpxdXgxL3lYdjQvTnQyNUd2cHFIaEFOUlRyczBEOTFTUmhQZ3JJ?=
 =?utf-8?B?WDZTUWlWUDhucERmQTJ2d2ZSU2dJM0pCUFdyUXZVK0pJVWQ2a0tRbjlsTExj?=
 =?utf-8?B?RERvL1pXcGJzckpXenAvZG16TkJjaXlUdDM1VXlkZlhzcWRqZnRoTXlZUXpK?=
 =?utf-8?B?ajdQNGNpOHp2U0hwT3V1SzdjTlN1ZWk4czJvaFA4bms1MkhRSGNpR2ovcG8w?=
 =?utf-8?B?cDJZcmhMcm41Zld3bSt1K2h5SmxFczlGWjcyUEhnNGNaTmM5M0Y0VThYc1Jj?=
 =?utf-8?B?SllmSnBBQTR4MXZpV2I2QmQ2UDZIVndaN2hVVEZlZ3ViL055S2dwTVJpcTBQ?=
 =?utf-8?B?SWFIMk9jYUpSWlVIeURyTU9xanBBNFFoTHRLeUJYT2gvZUpKUzBubXJQTnAv?=
 =?utf-8?B?d1VnZmpjWXBJb2ZCL1RNc1EvaXRuRThjRXhCNGlSajdOa09jeDFNTW00Z3Ir?=
 =?utf-8?B?d2xjd0hEejBNT29IWVQ0Q1JiTVBtU2M5eStRNU03VUdSZ3BOa1p4VENCQW5N?=
 =?utf-8?B?S1R3SWN4N3VHMkZYa2N4dDZRY3U1aVZyWU45QlpHeXhucHFGVVJrNEgwZVRQ?=
 =?utf-8?B?ckVEVDdWYzZOdkYxZ1o1cFR4QkNOZUloV2xheEpkTHhWNVFYTXBLVWdKL2ZD?=
 =?utf-8?B?cFRwOFI3V0FqS0F1a05vK2NZQTljSDFYMFVWVXBaSmRNUDhIU2l2MDlaVitn?=
 =?utf-8?B?SUpZRzIxeGFMWVRpU1NzWWFUU2YxQ3d5SlVpaFFMN0F1QzZIbi8wUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3556FD2BF2620E44A1FFC4E458F30CFD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hOsF/cS9EeBXbovPgA+yGahmyCr9i0HG9EbBVFnQbr7NZndMQscZM2VsSXDYQf68VFpdYq8i3NeEsnNXAxuMO42M2aoCzl+IpQMwD++b9D8EaVn2LunW1acPN7Nqz30PhI9ACxV2F9SZaboRqin3GhHCrnK+O6qoGWJiUi2rWxPXpMx5HruBJsPWfqnqVbqPOTrMqfpntO1oGp82C2khWHAPteABtweO+s+tFegQroqBWGlLhSneLg1L4Y68FEhRvgER/yS57qSG3tncAYKsuqT+HV5zqVybHd1qqd91IFymtHnbCc086fOogL6/kkMSOZua3F7I8pBnKOQn0Rr8ag==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eeda6b8-45f9-44c7-f2fa-08df03fcafb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 05:33:12.4318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: swl8Z+NE9Tf5RO5/zZWBex9axaRtrDxIL8lCqmuhbROUehez0ziX0+th4igDeIl4GRAxXhKV/xWYa2+KL+mUGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR03MB10354
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

T24gV2VkLCAyMDI2LTA3LTE1IGF0IDE1OjU3ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gQWRkIGEgYmFzaWMgZHJpdmVyIGZvciB0aGUgV3JpdGUgRE1BIEVuZ2lu
ZSBhbmQgaW5pdGlhbCBjb21wYXRpYmxlDQo+IGZvciB0aGUgTWVkaWFUZWsgTVQ4MTczIGFuZCBN
ZWRpYVRlayBEaW1lbnNpdHkgMTIwMCBNVDY4OTMsIGFuZA0KPiBob29rIGl0IHVwIHRvIHRoZSBt
dGtfZGRwX2NvbXAgYW5kIG10a19kcm1fZHJ2IGluIG9yZGVyIGZvciBpdCB0bw0KPiBwcm9iZS4N
Cj4gDQo+IFRoaXMgZGlzcGxheSBjb250cm9sbGVyIGNvbXBvbmVudCBpcyB1c2VkIHRvIGVuYWJs
ZSB0aGUgd3JpdGViYWNrDQo+IGVuZ2luZSB0aGF0IGNhbiBiZSB1c2VkIGZvciBmYXN0ZXIgZGlz
cGxheSBpbWFnZSBjYXB0dXJpbmcgaW4gdGhlDQo+IHVzZXJzcGFjZSAoZm9yIGV4YW1wbGUsIHNj
cmVlbnNob3RzIGFuZCBzY3JlZW4gcmVjb3JkaW5nKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFu
Z2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxh
Ym9yYS5jb20+DQo+IC0tLQ0KPiAgDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29t
cF9mdW5jcyBkZHBfd2RtYSA9IHsNCj4gKwkuY2xrX2VuYWJsZSA9IG10a193ZG1hX2Nsa19lbmFi
bGUsDQo+ICsJLmNsa19kaXNhYmxlID0gbXRrX3dkbWFfY2xrX2Rpc2FibGUsDQo+ICsJLmNvbmZp
ZyA9IG10a193ZG1hX2NvbmZpZywNCj4gKwkuc3RhcnQgPSBtdGtfd2RtYV9zdGFydCwNCj4gKwku
c3RvcCA9IG10a193ZG1hX3N0b3AsDQo+ICsJLnJlZ2lzdGVyX3ZibGFua19jYiA9IG10a193ZG1h
X3JlZ2lzdGVyX3ZibGFua19jYiwNCj4gKwkudW5yZWdpc3Rlcl92YmxhbmtfY2IgPSBtdGtfd2Rt
YV91bnJlZ2lzdGVyX3ZibGFua19jYiwNCj4gKwkuZW5hYmxlX3ZibGFuayA9IG10a193ZG1hX2Vu
YWJsZV92YmxhbmssDQo+ICsJLmRpc2FibGVfdmJsYW5rID0gbXRrX3dkbWFfZGlzYWJsZV92Ymxh
bmssDQo+ICsJLmxheWVyX25yID0gbXRrX3dkbWFfbGF5ZXJfbnIsDQo+ICsJLmxheWVyX2NvbmZp
ZyA9IG10a193ZG1hX2xheWVyX2NvbmZpZywNCj4gKwkuZ2V0X2Zvcm1hdHMgPSBtdGtfd2RtYV9n
ZXRfZm9ybWF0cywNCj4gKwkuZ2V0X251bV9mb3JtYXRzID0gbXRrX3dkbWFfZ2V0X251bV9mb3Jt
YXRzLA0KDQpJIGRvZXMgbm90IHNlZSB5b3UgbW9kaWZ5IG10ayBjcnRjLg0KbXRrIGNydGMgd291
bGQgdXNlIHNvbWUgaW50ZXJmYWNlIG9ubHkgb24gJ2ZpcnN0JyBkZHAgY29tcG9uZW50IG9mIGEg
cGlwZWxpbmUuDQpXRE1BIHdvdWxkIG5vdCBiZSB0aGUgZmlyc3QgY29tcG9uZW50LA0Kc28gcmVn
aXN0ZXJfdmJsYW5rX2NiLCB1bnJlZ2lzdGVyX3ZibGFua19jYiwgZW5hYmxlX3ZibGFuaywgZGlz
YWJsZV92YmxhbmssIGxheWVyX25yLCBsYXllcl9jb25maWcsIGdldF9mb3JtYXRzLCBhbmQgZ2V0
X251bV9mb3JtYXRzIGFyZSB1c2VsZXNzLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArfTsNCj4gKw0K
DQoNCg==
