Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F90C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 997DD10F251;
	Fri, 28 Aug 2026 06:17:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="GK054EN3";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="X0ohG3JC";
	dkim-atps=neutral
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2A4110F251
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 06:17:40 +0000 (UTC)
X-UUID: 2a517a4ea2a811f1b1788b6acf885367-20260828
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=tM7sXLR+Z8DpFN8m0gL9Jzvi/Rt6619STMSYpvFYK3s=; 
 b=GK054EN3eCCT/658S5QPFiSVlx9owwZsXB9ImICxOyPNDKl6ALQ55rPPX4MxyeY41EJKTcM2YqQNJR/QNsx4WW3dfpEbi65MxPDaxnfQKN9OutE3DCJouy6r0Xl7m5N5L0D3iQDlPOZPUUgBf/3vF7/06zNQhXwCdUHWVQV0BTE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:aad30780-b8dd-4665-b834-7c6a9236a721, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:fa36036f-d4b4-449a-a450-812cb2b13b0e,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2a517a4ea2a811f1b1788b6acf885367-20260828
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 280977682; Fri, 28 Aug 2026 14:17:37 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 28 Aug 2026 14:17:36 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 28 Aug 2026 14:17:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q00lozJR+B1/D8yUDsEBT89S0GHjqOvZPVhveWtr5yfGa+Yrrn6jfIEaisQw/PKQJlu9m/t7pCPo1yxW32velt1LedFZLk5D8KKBTsJvoEMDB5Wfk8K6iu/yr9X8/9wut7+ysP9a+LasOmLqiwURVhbcPYglk5+EQkK7EtosSj2gOrtHJwfkWQhLzre8ZSBdGbeuTtUEBEbblG6gWPkVyXqsy8cLhZeM3OMPArAy/KrFw/ZiLc64OT5wTFhCqhWOZQQsZJHYBBcRRZdMwHQ6WEcd7XdaO2vwqTzPJpU3IayLLs1gbdKdtZDjiwamUyhMgOJ7hZ5H105dI5VBoe6SHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tM7sXLR+Z8DpFN8m0gL9Jzvi/Rt6619STMSYpvFYK3s=;
 b=lY5sH7ri0bNHVEyv5P75GXO2WQe6rAn9eYUIdepA/Yn3MYADxDCAvZDJlP1kj1POQ16M8RyvJyKp8NHwNh3hBDiWTNQo8QQjgt0nMe0zaJ60mwIUtZr7zKNy4nq3xgPsv5onhDHpEvPVhqJooXKF5tan35AkSnvvkIyejCx6vXL1GgO4Hb6KcezA/LQL+ylIkBS6qVYGIcOYb1X+HrYsnEsNl3lr3np09gGy6XAb4vWaZQOWyUSFnIkzvDSQgrUqjWNRTRgW2kimwlm+hZrn8yQa4dU7uwRpaH+rAk9a7IKICozRCGPVRrZZG6gGSfAHN0prXXPsZ7XRUUOehnXnnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tM7sXLR+Z8DpFN8m0gL9Jzvi/Rt6619STMSYpvFYK3s=;
 b=X0ohG3JCUk5qxtcd9cOMaeHOMaB//1OhF4xttMHuIY97xnt/obAp2PHlZ0KZFXgIRaMRQc0EBo8n+Y7AjmiVoI8W10QaNbqOEUG7V8YTugQ05Q9pStN0QBLRlmkWZhG/Kgv8/D3C+2GhpKWrVvDQV/Yg143lZsnhK7DZOm5IBGU=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KUZPR03MB10241.apcprd03.prod.outlook.com (2603:1096:d10:88::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 06:17:31 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 06:17:31 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "kernel@collabora.com" <kernel@collabora.com>, "robh@kernel.org"
 <robh@kernel.org>, Alexandre Mergnat <amergnat@baylibre.com>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>, "dmitry.osipenko@collabora.com"
 <dmitry.osipenko@collabora.com>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
 <jitao.shi@mediatek.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "granquet@baylibre.com"
 <granquet@baylibre.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "airlied@gmail.com" <airlied@gmail.com>,
 =?utf-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?= <Justin.Yeh@mediatek.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH v4 09/12] drm/mediatek: mtk_dp: Move max link rate to SoC
 specific data
Thread-Topic: [PATCH v4 09/12] drm/mediatek: mtk_dp: Move max link rate to SoC
 specific data
Thread-Index: AQHdD5auiUgzhov+90CWrB89Jny4l7azSqIA
Date: Fri, 28 Aug 2026 06:17:31 +0000
Message-ID: <69aeef9c35b79cfe693c8f0e3c1e3b1eded65648.camel@mediatek.com>
References: <20260709113148.49090-1-angelogioacchino.delregno@collabora.com>
 <20260709113148.49090-10-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260709113148.49090-10-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KUZPR03MB10241:EE_
x-ms-office365-filtering-correlation-id: 39c2b00a-3ace-46c5-e713-08df04cc0b09
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|42112799006|38070700021|6133799003|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: i21q+O+0/2OBR3QcIbfuPSIs5njJ/43RMMRWwjELBDTqWyqSi/AuK4sZiOd5r+RMHwuAjPhc86rHQ5xYMIHUhYtQBEVMIHSr3Jgz7AWyI3CmD++33NHPEJjvdFCmAxUCauVZ2TDi73E0uttsvF0WdJ0WijV6isRQWp18RLZiV5hbt2fy9UksZ6ryRomb1OX7ZGJS8U2SolnWdcSN5hI0iuDaNiTwJsAznm7OvWnBa6ujx+ehHLquAuC4qVI5T7XtVgiVYaku07ZUvV3pfPerTFAA7UvSooNRc7XRwino2ZOtZERsBGD06RRCxMiZNGQJYSimjbv1PFx/uCFf8wdYyC3TqFpwf8MCCYvm4p6YfuieSL18gYO8YsaurtZehzm09KubYQMtUKyXU19JHGIMuuH7SYurLtPMgMBWezgEmGVlmKsx17m1l4Bp2cVGQl7RfhKg59gb/vzntSpkPs6/GHldG+j7/jonTsce19Qw/3a0u5RYESgUwcgMYFGYlPSIQLewIVN43j/5X5jUFIJe+t0411wvzqDyh1ISY0/yGKbnJ7RuCdRfmuhw/fF7S0m763q0C0iEw2eS1g2gnHyw293YDvx9bxDM2bhf6ml0S/MfmeyYco1bsW8pafaO0VYZ3Lii1gxvz1NReCNWOf2FsKOmPP9mSAdQIqmsCqCshp3Ur4GPbRFNAODsnlu9KmKfyBlIubpU7lLuLMPgUKv/FeayVlaj4IA9vMHAqA7pKhw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(42112799006)(38070700021)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWRXT1Q3K09JK2dXdTBhUlM1SFFPdFhJZktKNm1DNHJROWtFZHQzQStTeVE2?=
 =?utf-8?B?ZlNDb1RJbVdtYVhHdzludVdlRXBrWklXd3hsSGl6N2doSTkwQVZiTWE3WlV6?=
 =?utf-8?B?RGJqUGgvUmdLVlRHbXFySFhBYzdYbCthN2dybWRZZ0t1Ymk3RkpnanUyU2FM?=
 =?utf-8?B?K2dkVzhBcnhFT01mVE9kTEViNWZ5dE0zc3ZaSzhHTHR0bkh1eHZEU1VWM3Mx?=
 =?utf-8?B?aVh1RW1idTRYSjRoaGlHYU83eHhpbUdkeGU1cms2Qktxd3M1WGl3NlJURUFY?=
 =?utf-8?B?Q1Z0eVY5SU9ackZoNStzSDJMWFVtam5tclE2YWxGSjBVLzcvYWJrSmRsODZV?=
 =?utf-8?B?K1J0ZWR3TDA5NFNPNlNpL1dFWnhKTTJicDBaVGkzOG5rRkpQTW9rbERYK1do?=
 =?utf-8?B?aUw1Mk5CNWhldENpRjdYbEZOcWFJM3Z0enVlOEJMa0M1b2JLUzVaZE91QWVT?=
 =?utf-8?B?cjd0UmhPd0l0VUdoYkhiNWdkTU9UWU5TZVMwYnZwVUZ6REY4eXJPamZGb3I1?=
 =?utf-8?B?YStSTTZ0KzhDMzkydXBrbm9YdUxwMlJvZ1JmdExVZ2VnbHN2NWwvbTNaRk5y?=
 =?utf-8?B?TEtYbG5wVEw3UUY3YmlVQ1I2NTJkQUd3QlV3eVZUUjVYbnhWNW5LY0hYUHJ6?=
 =?utf-8?B?VisybnE3c0NFUG8zTDVEcjlwek4vN2Y2bjdpMzVrbmorUGVkNDVUVXJpZjlt?=
 =?utf-8?B?QkNsakNxbkVrd3BDZTBndG1OK1RaejFUY2lzUWFnczRhSklGMUljYk5vT1Bm?=
 =?utf-8?B?bjBMMTR0Wmt4QXFyRkNpelROK0dSdDd4dnVOUDJOOXV0QU4rRld3RS9IaGx5?=
 =?utf-8?B?VjE3Vk0zYjlXZWFjVFVDSnBsbEpkOWJoOUg3UEpSVnBBTnA0TGpvd0NkVERI?=
 =?utf-8?B?L3duTlhabWUzM0RnU3hjc3Fvb2dxZTJjRjBldXVrL1FVN0RTTkRQOFlYNlJH?=
 =?utf-8?B?TmQ4UzkzN2xDdUN0Vlp5YUkrSExRQldSOCs3aUdjQnBRUEYvTERJMXZxMnhi?=
 =?utf-8?B?dm1lR2JMam85c2c0WmtqZGF5d09lRDhZaTBsNXRKV0ExTUZ2YzRaWngxZmhI?=
 =?utf-8?B?OHRBRlg5UmcwTkpjakxSbTFYZWFxNXFBY2UyQWlacURwMlgrbUlQaVEyUFpM?=
 =?utf-8?B?bzQ2ajNYSEJ2Q3lscXh6Z3E4bUN0UG0xUFkrNFI2b0FGUjBrL1VFNzhpZVhX?=
 =?utf-8?B?U1FVbWowWm1VTzI3RitleUpxMXRhV3MyWUl2UlNPYW1QdVlWZHhjeDFZYzVw?=
 =?utf-8?B?MjdnTVY2cVlsTWZwUzk2clNHanNvWG1VNUlCT2FtVFpnemRkc2wxVFNPeFBy?=
 =?utf-8?B?ZDQ2T2F5bHlhWVh1TlpLSm9TbE5WWGJzZWZtUDJmNlVoWHRRU2xqK2I2djUv?=
 =?utf-8?B?T1Qya2UxUzVIc3lQdURnaTRhS25DaWVXb1NSekxsamw3SHlWNXFpa0dLV3U1?=
 =?utf-8?B?b2UrN1pUeUl1dDBubWVtVUhYZk4wRDlQelpEUDNGNGlJa3VBRjFCRUFMSTVq?=
 =?utf-8?B?b0UrZFB4TU92bG1rek05M25Kc09scTh0TFdiZnRKL1FQakhWUE5TRlk2VnVn?=
 =?utf-8?B?aGx3ci9TdjJoY0d3VE9vKzRmT3VjNUxSZkw3S0hkaFc2ZnNocllTd2RtYTIv?=
 =?utf-8?B?dXZSTUxCYXhydVdyZjZVWUhCM2h1ejhUODh3U2l0azIvbFRrQTdmY1UyL3pt?=
 =?utf-8?B?VGNETEx3MlRhaWRRV29PaUJHbE02NUg1ckczVHJWNXBGM0FHcnNMZVp4VUp5?=
 =?utf-8?B?QkF1OW8zNHNYcTB3ZnNjN0p5YkJOa3RIRzlXeTAwYnJ6cWF4eEdoa1lsTlcw?=
 =?utf-8?B?MDN0c1JUQ3UwbDBPc1E4MkNOMVZ1Q3V0YUlyZ2c2WE90MENpMTcxVXZKYnQx?=
 =?utf-8?B?bmZtZVZheFhSbHdaamV2NGtoOWZaTjRaQkVzWm9XdTg0UTl6eWN2TTFSdlNs?=
 =?utf-8?B?NlkvYWkrR0hMeUdxSm9iY2N6bVVzbzM5STFlY0pXbTNSeDdPdHJEVlFZdTFi?=
 =?utf-8?B?NFUwZ2ZGYnZLNlp5QWRJUnZnM2w3VjI0cWlxTnI0UXRDb3JwME1hZHdPeXBM?=
 =?utf-8?B?SVI2WHVsQmhESVc0d3ZWS01yU2JQRldyMldvY2hFd2p0SFBhMzR4cHhUSHhv?=
 =?utf-8?B?WVl4anRXV0psci9VM01aaG9mdERiRDRud09jMnAwN0VnT0NORUQ4bEsyRUxj?=
 =?utf-8?B?SEh5WnBMUlc3dHFKTUYrcnVWSW1YMWVNWldBb3JHZEdiK0ZmMUlMVXBSVmFp?=
 =?utf-8?B?TUpOT0V3MU4wcmprQnUxamNpM2xBRjdUcUxIRUlTNHZRQ1JrVFVJaGN4V0Zl?=
 =?utf-8?B?SnlLSkhFeERNSHRXTlM3M2hYMkVzWUU2RENuVlpYb1Y3Z3hXWGI0UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <624AA33ADF46714CA4794CF51502CA31@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zadinyulOdaEPayrQnp3XSBFOiA/wNudP8BLqR3AbriyrXDjxr62NMvrZsjNE5dIQjDFuDB/qjD0DyUazv/g+ibob2xr1cs72wXiv+/tB9bxiuy16C5arRrIw7Kobzlw3FUrf8uspatFdsNeDeZwqaB5i+QEqw4Y6D6hynYnpj0cO/i4Jhq7FqQAWgPchEeZn3j+DDoa5hRoExzzsE0T4tbNlJE4tN+XfYVEXUox/Dzu6H5e+UxB8yVUEa754oTKr0mWhRXKkEi3Q+w9Y/ddh7QUZdT5QEWfsHklWWyoI+OP4e3VOqSF0kVTRnqEpUqnkDTC+WrR1sLcH1i+fhwsrw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c2b00a-3ace-46c5-e713-08df04cc0b09
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 06:17:31.4305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ld4R8nfi7Sh5a9LSxlNYo/21n8vpa6ca5pthBjkZ2Ejd2L0vHAldqU+P0qIuRH5KdRZx0inht5RAkEE59DXY1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB10241
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

T24gVGh1LCAyMDI2LTA3LTA5IGF0IDEzOjMxICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSW4gcHJlcGFyYXRpb24gZm9yIGFkZGluZyBzdXBwb3J0IGZvciB0aGUg
ZURQIElQIGZvdW5kIGluIHRoZQ0KPiBNVDgxOTYgU29DLCBoYXZpbmcgYSBoaWdoZXIgc3VwcG9y
dGVkIG1heGltdW0gbGluayByYXRlLCBtb3ZlDQo+IHRoaXMgcGFyYW1ldGVyIHRvIFNvQyBkYXRh
IGluc3RlYWQgb2Ygc3RhdGljYWxseSBhc3NpZ25pbmcgaXQNCj4gdG8gdGhlIHRyYWluaW5nIGlu
Zm8gZHVyaW5nIGluaXRpYWxpemF0aW9uLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1l
ZGlhdGVrLmNvbT4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwg
UmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMgfCA2ICsrKysrLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHAuYw0KPiBpbmRleCBlMmE2MDAxZmMwY2MuLmVhOTcwYTliZmU5MyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYw0KPiBAQCAtMTY3LDYgKzE2Nyw3IEBAIHN0
cnVjdCBtdGtfZHBfZGF0YSB7DQo+ICAJYm9vbCBhdWRpb19zdXBwb3J0ZWQ7DQo+ICAJYm9vbCBh
dWRpb19wa3RfaW5faGJsYW5rX2FyZWE7DQo+ICAJdTE2IGF1ZGlvX21fZGl2Ml9iaXQ7DQo+ICsJ
dTggaHdfbWF4X2xpbmtfcmF0ZTsNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
bXRrX2RwX2VmdXNlX2ZtdCBtdDgxODhfZHBfZWZ1c2VfZm10W01US19EUF9DQUxfTUFYXSA9IHsN
Cj4gQEAgLTE0NjksNyArMTQ3MCw3IEBAIHN0YXRpYyB2b2lkIG10a19kcF9pbml0aWFsaXplX3By
aXZfZGF0YShzdHJ1Y3QgbXRrX2RwICptdGtfZHApDQo+ICB7DQo+ICAJYm9vbCBwbHVnZ2VkX2lu
ID0gKG10a19kcC0+YnJpZGdlLnR5cGUgPT0gRFJNX01PREVfQ09OTkVDVE9SX2VEUCk7DQo+ICAN
Cj4gLQltdGtfZHAtPnRyYWluX2luZm8ubGlua19yYXRlID0gRFBfTElOS19CV181XzQ7DQo+ICsJ
bXRrX2RwLT50cmFpbl9pbmZvLmxpbmtfcmF0ZSA9IG10a19kcC0+ZGF0YS0+aHdfbWF4X2xpbmtf
cmF0ZTsNCj4gIAltdGtfZHAtPnRyYWluX2luZm8ubGFuZV9jb3VudCA9IG10a19kcC0+bWF4X2xh
bmVzOw0KPiAgCW10a19kcC0+dHJhaW5faW5mby5jYWJsZV9wbHVnZ2VkX2luID0gcGx1Z2dlZF9p
bjsNCj4gIA0KPiBAQCAtMjk5Niw2ICsyOTk3LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtf
ZHBfZGF0YSBtdDgxODhfZHBfZGF0YSA9IHsNCj4gIAkuYXVkaW9fc3VwcG9ydGVkID0gdHJ1ZSwN
Cj4gIAkuYXVkaW9fcGt0X2luX2hibGFua19hcmVhID0gdHJ1ZSwNCj4gIAkuYXVkaW9fbV9kaXYy
X2JpdCA9IE1UODE4OF9BVURJT19NX0NPREVfTVVMVF9ESVZfU0VMX0RQX0VOQzBfUDBfRElWXzIs
DQo+ICsJLmh3X21heF9saW5rX3JhdGUgPSBEUF9MSU5LX0JXXzVfNCwNCj4gIH07DQo+ICANCj4g
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RwX2RhdGEgbXQ4MTk1X2VkcF9kYXRhID0gew0KPiBA
QCAtMzAwNCw2ICszMDA2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHBfZGF0YSBtdDgx
OTVfZWRwX2RhdGEgPSB7DQo+ICAJLmVmdXNlX2ZtdCA9IG10ODE5NV9lZHBfZWZ1c2VfZm10LA0K
PiAgCS5hdWRpb19zdXBwb3J0ZWQgPSBmYWxzZSwNCj4gIAkuYXVkaW9fbV9kaXYyX2JpdCA9IE1U
ODE5NV9BVURJT19NX0NPREVfTVVMVF9ESVZfU0VMX0RQX0VOQzBfUDBfRElWXzIsDQo+ICsJLmh3
X21heF9saW5rX3JhdGUgPSBEUF9MSU5LX0JXXzVfNCwNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgbXRrX2RwX2RhdGEgbXQ4MTk1X2RwX2RhdGEgPSB7DQo+IEBAIC0zMDEyLDYg
KzMwMTUsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kcF9kYXRhIG10ODE5NV9kcF9kYXRh
ID0gew0KPiAgCS5lZnVzZV9mbXQgPSBtdDgxOTVfZHBfZWZ1c2VfZm10LA0KPiAgCS5hdWRpb19z
dXBwb3J0ZWQgPSB0cnVlLA0KPiAgCS5hdWRpb19tX2RpdjJfYml0ID0gTVQ4MTk1X0FVRElPX01f
Q09ERV9NVUxUX0RJVl9TRUxfRFBfRU5DMF9QMF9ESVZfMiwNCj4gKwkuaHdfbWF4X2xpbmtfcmF0
ZSA9IERQX0xJTktfQldfNV80LA0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBv
Zl9kZXZpY2VfaWQgbXRrX2RwX29mX21hdGNoW10gPSB7DQoNCg==
