Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E69CD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 08:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20EDE10E046;
	Wed, 13 May 2026 08:03:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="QhdOrG/d";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="nbQfD2kB";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28C8C10ED47
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 08:03:24 +0000 (UTC)
X-UUID: 339952d44ea211f1a3561939bc42ff46-20260513
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=XsXjHGRbDcpn5Y4XVAJQBztKIl7X09qZhT1NOs80g9Q=; 
 b=QhdOrG/dfjNrlR70q1rz2bcUM9/+i3XUESyz4624xrnx/0tbooLkZHbdTWUbxgUovNpR5PnAxL7w9mXSWM02tD15QyA8DtH+uxlk24+QU9/wTJotZ+5ubr4jkY6SmGSxSegBq1/iiUh24pzlzW7UHH/bK4txHUtxtCYjpxcZwdA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.14, REQID:654cda51-0455-467f-9db1-479884102078, IP:0,
 U
 RL:12,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:12
X-CID-META: VersionHash:9091e75, CLOUDID:a8ab4dbf-65a8-4b41-ac18-3671578a914d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|11|97|83|106|80|1,File:130,
 RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:
 0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 339952d44ea211f1a3561939bc42ff46-20260513
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 689767018; Wed, 13 May 2026 16:03:18 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 13 May 2026 16:03:17 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 13 May 2026 16:03:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ntl8nX74xR6mcT2SXUZf2/luQ0HuW5a4/BgKcVjGZnfCbTvc4Ft/Pk1K8c/HBfZ5ZsbItjy3SwBu62FoxQvKPaAQ1ho9RMlNt9WS2b9jIzUiwp77UTapuKACRI8qJ9y9tuTKX2omB+pZ/O6KgbVZaOGqZNsVwc/xRejQhsfdVMYrcE9qD9gVzr2a+BvUvTKZh1GGL+izNtbhkD8SSv7QCCo9gRwFqQElUI9nZYAqPCjlvk7NwyzNJCniI2GZ/XFQ34SDITBRBDXvKd1ERZjOGFoFOtPSxU1TZkbCF3AfmF6KoFxD1N1KDOjMp/aiR+ZjmDj8wMPmwmX3mEFg3Dbwvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsXjHGRbDcpn5Y4XVAJQBztKIl7X09qZhT1NOs80g9Q=;
 b=AbcDcoJF58gyoW8srJStvsM2pOkNLs2NF8AtqkqKDIDwK/VUtC8T/FLWvs2YtMLK2LJqlUqR/JbtfnOoOLaajUmUOgQEeAnrW03/tATnwTWRbqgi291zSxQNxZq845k6Kw1EtSzo6pO1ykJBs8ijGcQ5TveiGCnf4i9JssF6ngsD7hvLUsXxKf3jdnzXQXqcOdxGlb1J3S9yBH1FTmxbqKeawoBJQxucyIdnrShG/zBAzB4EgfB0WWHqNfPsxMkB15VGS+7LOTx9Qu1RqGmoneg1BCYvkBGa2RZXLe2vilVmXAlkQznA5p6BxG9sKFU3DxEeMnJuUY3QVI5Lx3P3cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsXjHGRbDcpn5Y4XVAJQBztKIl7X09qZhT1NOs80g9Q=;
 b=nbQfD2kBRFt+Qk9z3BMqJV0GzzgUB/mDWvCaigkiVuU9Jx6+zL58Tlbf0O88vRdcoCGa3Vobr/MR55Wk3tNrgvnucCGqf8B7Y2yjKB4J7RUSw8zarHVsHqz+9Q0uI/pHSwR5pIvSejM96QxKusXUB3tRAKDfQ38OK3GSpPi5l9A=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB8264.apcprd03.prod.outlook.com (2603:1096:101:1b3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.16; Wed, 13 May
 2026 08:03:13 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0025.012; Wed, 13 May 2026
 08:03:13 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>,
 =?utf-8?B?SmF5IExpdSAo5YiY5Y2aKQ==?= <Jay.Liu@mediatek.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 4/6] dt-bindings: display: mediatek: tdshp: Add support
 for MT8196
Thread-Topic: [PATCH v5 4/6] dt-bindings: display: mediatek: tdshp: Add
 support for MT8196
Thread-Index: AQHc1jgnGNYj2FGDfUS/CZYHisf8TLYLsXIA
Date: Wed, 13 May 2026 08:03:12 +0000
Message-ID: <c9ed6676f1ae77e21b2ba2daf75a76f3a9a13389.camel@mediatek.com>
References: <20260427112131.23423-1-jay.liu@mediatek.com>
 <20260427112131.23423-5-jay.liu@mediatek.com>
In-Reply-To: <20260427112131.23423-5-jay.liu@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB8264:EE_
x-ms-office365-filtering-correlation-id: 475fc948-85a1-4efa-898f-08deb0c614a9
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|366016|7416014|1800799024|376014|38070700021|921020|56012099003|11063799003|4133799003|18002099003|22082099003|3023799003;
x-microsoft-antispam-message-info: rTrIFQhRyQU/kB7mlWxtp3wzGgXSp6urUA6Wydu8yr8Ag3sEMdUqs+LpbBWQR+W0x82V/sxQ9lDM0iHS5+gimJDAOPMP8CK7nQ8khEHACdX3Y8Hryug97DEjGWgeEHa44jLuNIoZXXlPy9lq9gO7gRIV/IBAQIdo23S3APTHMs2hEsLKwfAbu4UYlPxUmTd82k6ehn3XivrBupoBLfwZsQgNB3Z521GIOU+3bmGI9oqU9QYVe/jWUSC304LPK1EPQu8oOljnleXb5gHWLgGf4JDpUcUSUFz5oLjM3fW6KK9F2XkgBG/arqQC3A1qiC/hzCyhejqECdsAo+f0vXQtm41HGGXuWwucebAjPK9pIEtVCEqOaSJrAoiRTrqLRUk6UmDse21cH2T8FarN1KF3s0rN3ldEer9oF2XguMm7wLCX0W8DP1E70KISpR3eWvCVktutUlkTH2quO5c0uga8JBmo3QqYs4A+DWh8QBXk3rvIbi1oTatyeJaZ6Lh1GO2lmBRUCwsyPXNifzcG2luJlxRoaiR6U5CRlOoWtPqS1NZEvEqggMR8TCpC+2Wk1GzcxrbH5e3TerYbbeXBuKQBwFdMJ37CbcGZo0LJbBre4xrsYYrldEIEhN8tmeNWJDuV9/FgZEdMBx/4F2h3L3gV6pLmAP55ZEuYk5KuuEF/jRkVx1SK7k6rKEXasitDfohxPK4axxPT25bZGn0JIMFBAdaE4mfOGmwM9rujyUf7vFk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(366016)(7416014)(1800799024)(376014)(38070700021)(921020)(56012099003)(11063799003)(4133799003)(18002099003)(22082099003)(3023799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGc0OW1BNmVISzE4QWVQQVVQeVdHVnFQSEtjZ3UvSGl5WUV4NUQ4Z0paQ1hH?=
 =?utf-8?B?SlJJQW9CdjRtQ3lKZE9DUXJwL2ZoSHlJM3BUM1R1aDkwRkJUcDluOXVjTlBI?=
 =?utf-8?B?dFdwQ2x3V0gvdnRVMCt0cDd6QlEwQ1pPTmpJS1FuTmdYc2ZLZkVEb2Vzc2Fo?=
 =?utf-8?B?cS9ueGRCUXVHMkFhMkVzMEhGNUhjTUNsSzhLTytSNTU1RmVLREpjcjNpaE0x?=
 =?utf-8?B?QndROGhHMll5Q3ByOUU4RG0vV0pxVUVicFFneUtLRGlWbHlwMlB5a0Fvd1pu?=
 =?utf-8?B?S09mWnhuVk1YRUFKcXg0eUVlRWxnS3VtSy9RRzNzWWxpMThMbUN1dXVHWER3?=
 =?utf-8?B?dTNQWFVleWkyc3FhaEd5elZ2ZzVON1Jnd3FzWDFTajBRY28zUmlScWxKalli?=
 =?utf-8?B?UHVjRnZucnJGaSt0OFdkMHQzbkl1M1ozOWxrNW1pcWF5dEUvZG1ERWY0RFZ0?=
 =?utf-8?B?elVXNUNYdFJvVnZlUE5nQndJem1BQ3JNMnJVSGsySTN3dHBXbzc1U01rL2Vn?=
 =?utf-8?B?aElVbUhGSTJyMGR3K0lUSjNuU1FRbkdndG1VSWpTbFpBb3J6SC9Wb21UNnpN?=
 =?utf-8?B?Q2xEc1JQVFVUbGFBRTFkZWFzS0tJTDhPQXdoc1cyeVRQcE8wMGIxcjVPQmNl?=
 =?utf-8?B?VmhYTWREZzhiV09zYVg2UVFoNEFRMzJIc25vMEVDVkREMHg2NklFUk9zUWMw?=
 =?utf-8?B?OTZORDdwTXRaSFQzOUgzKzdPdzNTZ2crTFFqR2hta1FzTG01QzlNMjBUOUg1?=
 =?utf-8?B?QytocDdmdk9NamZaem1jMWErSGVUNEd0U1A0WVpmZng4dmdxaXVmK1BxNWZQ?=
 =?utf-8?B?MGJuVkp2RlRxN0tRRkUzUjlCZk1SWm5Hb05SMXFhSnZsa3VsSVMxeEUvb0hY?=
 =?utf-8?B?ejAyTE4zQmtYMC9SU3FaOU14UGZhVGVpMXBIam1ET1gvakV0M3I4NGdGVEVE?=
 =?utf-8?B?REJQUXo4TDFoQUZjTnRPUFJQaFJrcXh0RXkvaklPTGhJTTBVSEI3KzBiZEVm?=
 =?utf-8?B?T3ZETUJPZ2pQV3hZQlIzZnNNZEppZGRReGpBMEdjQ3NEZlp3c29uT3RGSW1k?=
 =?utf-8?B?aXhKUnhaQkxCYmM3Z2J2QmpUdnIrUUUxRzU5cnZ2NHdVMEsramNCQzArdHln?=
 =?utf-8?B?ZlREWEN3eFh1OXB1Tnl4MlAyMVE0R1E2R2JNVUVybEdJQkFXdG0zbmV2QmhC?=
 =?utf-8?B?dkNSMUh1VnR6Z0IrbjN0N1AxTlF2bVFVMDYzRmZxb09iT29XSklSdlpZQUxy?=
 =?utf-8?B?MkRNWVZIVE9pb3lGVFJhQ1ZMZ2xxMzBwQldMVk9VeEU1N3puS0xyUXUxZjBy?=
 =?utf-8?B?KzV4Sy84cldoVzUrN1VDUXZaMXdwUHVuUUFoSk12VjhJbmN2QzdmSmZDTTVw?=
 =?utf-8?B?dnA0VFdrNlFxVUVGcFN6N0JLL2xHcjhJWU94a1dOcHQxZitKZVk1ejFBak1V?=
 =?utf-8?B?bjZubUw3MjhBOGV0M1lhM1h5WnYyVWJXZ3dqWHpCMVI0d0RUNEYya0lqR2sz?=
 =?utf-8?B?UC8xZVJWci8xM0RHMk9hZnVDbDNtQWRPZjZKb1N0Ull2Z1VnZWEvbGdGaTJG?=
 =?utf-8?B?RzA5K051azJMUW8zRVZHMlhEMnA1L2FJMGRVOEx1SnFBVmZuKzhDR0M3dkcr?=
 =?utf-8?B?UGptWmt6QTlhbnFPOGVmV2FIei9Ecnd5eWNRcjQyV29lQktsRCtCNmswcGlZ?=
 =?utf-8?B?ejIrdnRGUEVnZjluNjU3Ym95Z0YwTGZtZkFIT0FQSkVlbE43SVF3azZvZng0?=
 =?utf-8?B?L2FLcUZHTlpFV1pCdk4xbUNYenJUaGFNbE9BQi85dkhTRDJDMmdRRW9teFMz?=
 =?utf-8?B?LzZMVTRZNkpSakRhVWtUVG40RUhoK1RacmdDeHhZdGhyU21lOTZmOHhYaTNS?=
 =?utf-8?B?ZDRsK2J3b2NMVzMvZzdmT3dlUCthMXdXS2tpZk1JaCtScVhXbXVxZjBSdlFS?=
 =?utf-8?B?N0pScnlUSW5ILytQZlZTSzhDeDNpU1QzL3ZsZ2hic0xVMG55ZTkwQ2FoNEZJ?=
 =?utf-8?B?eGoyS2EwenQ5TEJJVWxLaXFCSjN0VHhITDRCUEorWVU1QU1CT1lwcnQ3cElm?=
 =?utf-8?B?MExmN0VHbzJrcnZhWVdWNnZzY1BsRVNsT1NkdS9yYnZkeGZoNE1BV1NNaUVL?=
 =?utf-8?B?R05FdnlWQ1hDYUlhbXliZTZsZ2xRVWtCUThGazdSSWVpanZVSmloc2doVmJr?=
 =?utf-8?B?VEZ2dFVnZUNDUlNKOUQvTTNNRWJCNTlLdDFtZmZ4a3dqR2E0U3ZsTVY0cXUw?=
 =?utf-8?B?ZktOeDVUTlNMQ0p6V3p1SFBhcExQMEEvdHY5bmlOUjR3ejJTQnBiSDlBb0M5?=
 =?utf-8?B?Y2FvSTU4N3JGR3JjTDJXQ2ppSHh4ZGR5cmh5OVYxdGd3NFhJRWZNQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0C8940AF9211C45AABC041E1950E593@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XVfRqsir9Fd2io6PbcLaOCc84FFLc6Wi30XVyb4HbflRWgREY6BRCVwEDYp1C53pceASGmupDHv59S4Wlr464Q4gvP+q5DVY3Lo5+Utc2ACHe8QfpENcIzImrjIfQkqZNbCjRNV6PMBmT/WHkc29iDx/tXedeAoWUKsWC1RarzP3z6ejEdhSw4NzjpGElSCG+JwNIHbvFYQ84RFmYzoMEyWTX6eynRXmvNbsoG7u5PCOZFvWb20nRO0xVQlqZJGRKJKq4Wu6Grv+eNWMDOdr03tx2BSkdKV79n2N0GVfdx+56JW6ZT4lL9/IvoG6AzHEXEtpQwVoUYvCweWf6MBiXQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475fc948-85a1-4efa-898f-08deb0c614a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 08:03:12.9297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1MNzzKoLcy8A+QGta/skqkLqK6EXuoOtIYxO4GeaEcRww3in9JrpP1gj40rnVXntu4xisv7IG47IvpxrnpiivA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8264
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

T24gTW9uLCAyMDI2LTA0LTI3IGF0IDE5OjIwICswODAwLCBKYXkgTGl1IHdyb3RlOg0KPiBBZGQg
dGRzaHAgaGFyZHdhcmUgZGVzY3JpcHRpb24gZm9yIE1lZGlhVGVrIE1UODE5NiBTb0MNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEpheSBMaXUgPGpheS5saXVAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4g
IC4uLi9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLHRkc2hwLnlhbWwgICAgICB8IDQ2ICsrKysr
KysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspDQo+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3Bs
YXkvbWVkaWF0ZWsvbWVkaWF0ZWssdGRzaHAueWFtbA0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLHRk
c2hwLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRp
YXRlay9tZWRpYXRlayx0ZHNocC55YW1sDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4
IDAwMDAwMDAwMDAwMC4uNTBiMjRjYzIyNDIwDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWss
dGRzaHAueWFtbA0KPiBAQCAtMCwwICsxLDQ2IEBADQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gKyVZQU1MIDEuMg0KPiArLS0t
DQo+ICskaWQ6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5v
cmcvc2NoZW1hcy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLHRkc2hwLnlhbWwqX187SXchIUNU
Uk5LQTl3TWcwQVJidyFqdkxpTDZ3N1NjSnFoa00wSXlpTG9rNGN3emItZTFnTUUtbU85cjVsTFQz
SlRyZ2FCQmlpVjFqOExGa21Ka0lhZmFHaUJ5YTJHSk42aDM4ZSQgDQo+ICskc2NoZW1hOiBodHRw
czovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1h
cy9jb3JlLnlhbWwqX187SXchIUNUUk5LQTl3TWcwQVJidyFqdkxpTDZ3N1NjSnFoa00wSXlpTG9r
NGN3emItZTFnTUUtbU85cjVsTFQzSlRyZ2FCQmlpVjFqOExGa21Ka0lhZmFHaUJ5YTJHQ1BmbHJG
eiQgDQo+ICsNCj4gK3RpdGxlOiBNZWRpYVRlayBkaXNwbGF5IDJEIHNoYXJwbmVzcyBwcm9jZXNz
b3INCj4gKw0KPiArbWFpbnRhaW5lcnM6DQo+ICsgIC0gQ2h1bi1LdWFuZyBIdSA8Y2h1bmt1YW5n
Lmh1QGtlcm5lbC5vcmc+DQo+ICsgIC0gUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25p
eC5kZT4NCj4gKw0KPiArZGVzY3JpcHRpb246IHwNCj4gKyAgTWVkaWFUZWsgZGlzcGxheSAyRCBz
aGFycG5lc3MgcHJvY2Vzc29yLCBuYW1lbHkgVERTSFAsIHByb3ZpZGVzIGENCg0KYSAtPiBhbg0K
DQo+ICsgIG9wZXJhdGlvbiB1c2VkIHRvIGFkanVzdCBzaGFycG5lc3MgaW7CoGRpc3BsYXkgc3lz
dGVtLg0KPiArDQo+ICtwcm9wZXJ0aWVzOg0KPiArICBjb21wYXRpYmxlOg0KPiArICAgIGVudW06
DQo+ICsgICAgICAtIG1lZGlhdGVrLG10ODE5Ni1kaXNwLXRkc2hwDQo+ICsNCj4gKyAgcmVnOg0K
PiArICAgIG1heEl0ZW1zOiAxDQo+ICsNCj4gKyAgY2xvY2tzOg0KPiArICAgIG1heEl0ZW1zOiAx
DQoNClJlZmVyIHRvIG90aGVyIGRpc3BsYXkgYmxvY2sgYmluZGluZyBkb2N1bWVudCwgYW5kIGZp
bmQgb3V0IHRoZSBjb21tb24gcHJvcGVydHkuDQpTdWNoIGFzIHBvd2VyLWRvbWFpbnMsIGdjZS1j
bGllbnQtcmVnLCBwb3J0cy4NCg0KUmVnYXJkcywNCkNLDQoNCj4gKw0KPiArcmVxdWlyZWQ6DQo+
ICsgIC0gY29tcGF0aWJsZQ0KPiArICAtIHJlZw0KPiArICAtIGNsb2Nrcw0KPiArDQo+ICthZGRp
dGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gKw0KPiArZXhhbXBsZXM6DQo+ICsgIC0gfA0KPiAr
ICAgIHNvYyB7DQo+ICsgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KPiArICAgICAgICAj
c2l6ZS1jZWxscyA9IDwyPjsNCj4gKw0KPiArICAgICAgICB0ZHNocEAzMjFlMDAwMCB7DQo+ICsg
ICAgICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Ni1kaXNwLXRkc2hwIjsNCj4g
KyAgICAgICAgICAgIHJlZyA9IDwwIDB4MzIxZTAwMDAgMCAweDEwMDA+Ow0KPiArICAgICAgICAg
ICAgY2xvY2tzID0gPCZkaXNwc3lzX2NvbmZpZ19jbGsgMTA3PjsNCj4gKyAgICAgICAgfTsNCj4g
KyAgICB9Ow0KDQo=
