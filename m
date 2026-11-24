Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D7C606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=iDNLfs5Z;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=XOkrWLQ/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8667F10F3F2;
	Tue, 24 Nov 2026 09:42:41 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFFD110F3EA
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 09:42:29 +0000 (UTC)
X-UUID: 5990bd1ee7eb11f1b1788b6acf885367-20261124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=9TaK3hJ2603AOLTK1kYzsaZg6HvBVXM9vCpE06uZc6M=; 
 b=iDNLfs5ZNtsSecMQX7JSB9cr3aqVbXiAQGw0KlzFWfIkyoM11QoTapzdrNGH900A36EaotWxUEXWqWXNsuLyrANWbeKFvpB6gK+oX9Qf//kT72/BGKFU/6gRlzJhEh/MNvybuHcFRl5h5e11XMk3Efeb8LlB7IvediEJryKas00=;
X-CID-CACHE: Type:Local,Time:202611241742+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:d5c25608-a570-4778-8d8e-975a6d365831, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:8b0b4731-f289-4656-bb36-27baf4489f11,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|136|836|865|888|898,TC
 :-5,Content:0|15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:
 nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
 C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5990bd1ee7eb11f1b1788b6acf885367-20261124
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 334665609; Tue, 24 Nov 2026 17:42:23 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 24 Nov 2026 17:42:22 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.56 via Frontend Transport; Tue, 24 Nov 2026 17:42:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/dcj15V5kZD0wJ3udUgsswOz4vkaMSha7fXeA07L1onATlSicR6wsM/h6AnBaMnZ5h4oWC57vUVANS15d3g7bcodL3/L//xjuI2ihiQWskSNLMYr1tciJJ0HN5OoyRSA8hgW/fcEvTFN0owUmMelPdpWTySlLXKrQINXFujZbnhMqx0iPEKUaf5ZXCyG519BoRXN0Jv8XFtRkAAQlvHg8SlzX+2wsED9+rKfrYl+XiRO/2j9fFrGP3YzzcyLaXdNsKSKiqo1deMspa+/jkfcIFIht/e9Wbs7clhNaEkphclIQL2e04+9Jsween28c7CXexK2gTjmS8M+Lt//PEh2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TaK3hJ2603AOLTK1kYzsaZg6HvBVXM9vCpE06uZc6M=;
 b=id5SM2A3Q5+O01pF2e8RM6FVsywfufwp6TUXiOgsEZAm/xZoUqVHk74PbtuER7xNvzcd+qwdsc3JuUJQ+O7dfgH5Ke1qpMZ8mcZFJbiWBkGWyuRJAh2TLXWVnqEXAeFs/tDSVDgF05T1dNXGIIRZyVNuhypubYtvbwRybLpp6dGdAD0VLsIQRRPtAPnghd5C1qP6aFMM/JtU4djWGH6/0ET8E592Fage8b3q/CxST5LlTRVOZsWZCoCPGnBwWP877YjxyuAXRIFN1Ta3z7kw5RSnQpZYqY6WzXZ+wAOzjRx/upwRBj9Ut1D3IFNnU872qisl3fQMX7WCzYhoNgBM5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TaK3hJ2603AOLTK1kYzsaZg6HvBVXM9vCpE06uZc6M=;
 b=XOkrWLQ/l1qs109iwaLXw4c71DhxNetzLB64XFBh2pgZjtUlLuTX1KhaAfrTiX1glp2/wNjXIq1RQPFZQ+3PDS8AKCQfjNnU66/4n3huq6KDHe9lpmsHL1pSMEAOP6or52ew5zoNFMas1o0nlg+WSs5bq+a43mMwCDWpJcuVPUw=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by SI3PR03MB10055.apcprd03.prod.outlook.com (2603:1096:4:2a7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 09:42:19 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 09:42:19 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
 "granquet@baylibre.com" <granquet@baylibre.com>, "chunkuang.hu@kernel.org"
 <chunkuang.hu@kernel.org>, "haoxiang_li2024@163.com"
 <haoxiang_li2024@163.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "airlied@gmail.com" <airlied@gmail.com>,
 =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= <Rex-BC.Chen@mediatek.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>, Alexandre Mergnat <amergnat@baylibre.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/mediatek: dp: Unregister child devices on probe
 failure
Thread-Topic: [PATCH] drm/mediatek: dp: Unregister child devices on probe
 failure
Thread-Index: AQHdd81l1FLg9exphky76gD4sGZ0Grc9AJUA
Date: Tue, 24 Nov 2026 09:42:19 +0000
Message-ID: <0400e70251e3936fb51b018e276399e23ff5c213.camel@mediatek.com>
References: <20261119022523.2767735-1-haoxiang_li2024@163.com>
In-Reply-To: <20261119022523.2767735-1-haoxiang_li2024@163.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|SI3PR03MB10055:EE_
x-ms-office365-filtering-correlation-id: bcbae69e-82fb-43af-d021-08df4a0f3b8f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|366016|376014|7416014|1800799024|23010399003|6133799003|18002099003|22082099003|921020|56012099006|11063799006|261022105027099003|261022075727099003|261028144727099003|261021121427099003|261026140227099003|261026121527099003|261102123227099003|38070700021|10067099003;
x-microsoft-antispam-message-info: He9kMefbgGIQ5QBWmaKH0WvAx3youlnF8URlV+UruhxZk53Usc9CZL0rR/TK/y9OGcM0PT2aFM5sZ0w2GlnaI2giC99oepfPgA2dCR6nhKvqQmIMnVrCGakGkGc0FcEntiLK8mBkRAy6OwCM51xxKNzs87b0zH4hHRsIJpc0SxcoM5o0I8uEqpzC0jlI6kW9t5oHZH4icPwVOXiesdFuCq56w/y7IncBF8ExGB8Q3SMmrzVye5ywd3xpFbcgHCjL4RF/QCLo0WSTWScU6xTBcMk3z1Qb9ezHEP1F/iZcpfaMTVKqO/AcQ+G00y2/KP29SF1LF+rqFawZqYU1gID/fh5dO7ZdqMhTVa87JlzL+y4OxTEpuoc39DFOgzWPVhNgHY/Vgn8XcqH/uvq/5AVPtCuBIDpdeQKPg9CAwTZ57HDGVm146JG1EzkTPA4B6oiC5mJx4yiUZpChK+Jlim51R03ZaPjZr8Rda9En4sS4dmE0GLHcxQto59TdfqSwI+jsd0vkyOKiDiVMj+6CG23MuMXNdNOOAB9QQF2lZs+ao2UsHGzpoqqTCVm32Trua3QC4gfQcIhO6dALFDom6FY2TbsHou/OvwmIepMwu90t3Ll/OnCVNQ1EXlwWeBaB+IupYcn94IO9L8KHQjWcDMUJ9JGkM6D370+nTAK5xAbJZzNhzqdsTjhCXXb1M00tF8WT9jaL90xjMnqlXuQuxpDt34FDJ2pig6GB56oZZJMRmmhVfdN6Zd7smAZ3fLf+wSJs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(366016)(376014)(7416014)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(921020)(56012099006)(11063799006)(261022105027099003)(261022075727099003)(261028144727099003)(261021121427099003)(261026140227099003)(261026121527099003)(261102123227099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzhtM0oybTk4TGEySU84dlM5MHFHRDIvalVITy9PRTBwTkp0d0p3V1FTSHM5?=
 =?utf-8?B?QnJpd1pmWTdTaHhrWDBzM05hUTR3NlZyTStzaUEyLzhOcklVMDlNRTladlBz?=
 =?utf-8?B?c0FkMnc1dHl6TDhMdGhlNllBSEJQZm5Fd2JqSFpIT3RJMEV4NWF0OC9ueWJD?=
 =?utf-8?B?dEZHZ1Q0WmhseWR6d2V0QmlJOXFtUi9kL3dJMTNIOWRtODZncVE5a0dKQURo?=
 =?utf-8?B?T3RlbXJDL2w3UnJzaEYwL0xhaGwrcy9ybTA5SEFCVU1ZSkVyT3o4WklxS1BH?=
 =?utf-8?B?aGFsY09jWWdRenV6V2VwWnBGL3k4aFhiZE5XMmNPUElycWFKaHJ6eFBqYzZl?=
 =?utf-8?B?eEhMVUlsL0U2a1pycE9nczR3SUYxY0UyS0plNGxSelgvRDZ5alkvZkdVMFRM?=
 =?utf-8?B?OTR2aFQrck5rbDVsMHNNZjIvTENhM1dIVVoyRTc4V3Nuc3NVL0ZxS0lkR1ZM?=
 =?utf-8?B?MnhVMEE5ejlkTkJMMGlqQVBpWjNIb1o2Q3dZdit3YjVJQUF2SVNKK3loNEYz?=
 =?utf-8?B?SUc4K1Y3MVFhT1lWTVN0VE9KZjhRN1VIMHRic1YvMFRzMURWcHExR1BnTmN6?=
 =?utf-8?B?M2U0VThwK1gwaUVnakhoYVF1SW9kNG5xWVhqbDdsMEhaaTQ0bjYzYW84VWJF?=
 =?utf-8?B?MURjZzFxVHVZV2NYRnhTV01mT3ViZkpqZTh5WWYwWEZSQjJtYTlRbXNtMnEw?=
 =?utf-8?B?YlBxc3RyV2wreTlIbFM4VWlhRlVBa3dpS1kxZmhNRGhGOXFUM1pxQzFkRVZG?=
 =?utf-8?B?SFpuUjdDbDd4d2pOa09CUFEvSXBuY2N2UC9LRTJPbEJUTklzWnkxRU0zdWQ0?=
 =?utf-8?B?R0RmeFlCUHZ6ZTRodUFZUGJqWFpNM0NBakZXck1qVXFxY1NwbytjekNKM1Qv?=
 =?utf-8?B?VCs0VSszZ3lGbVdyWWFPdEtYcWNJVHpZS1hsS3BreWkyR0xoN29TMHY4NXZv?=
 =?utf-8?B?VkNqU3Q3aDlmTzRDMExKL0lUMmtPdFExSFdXWXR2YXRUZTJRbEdDWFBUb2JM?=
 =?utf-8?B?VkdjcVNZRDE2N0NMTWlTeGlkbzlKT1FNbUdnK0RPU1ZzNm1SSXRNNEYyejJh?=
 =?utf-8?B?dFpRUk84Z0s0TThldnIwNFRuK1FMR1p6ak1wdXU0ZE9QK3dnaVVnYngvdk9t?=
 =?utf-8?B?Y0JqT2c2dzRDcFoxOGtNTzQwbnFucWxUNWpyZFQyNlRpYjVQL0tWK0RPa3Bt?=
 =?utf-8?B?MU1qSHlXZHVVYW80bnorSDdaemwzbGlQRFhycFhDaG41Z0RHUml3ZEtqRzM5?=
 =?utf-8?B?NDh6ZGpXanFuV2dsTmF6RndmS3lsWC9mR1ZzWXhrNXhQTFQ1dlFSRWJSVkhQ?=
 =?utf-8?B?Y28rSEpuYWcxUWtUbkFKbWRQclRzWGV1TTZnRUJpa2I5UExGR1FZZkY1NFBy?=
 =?utf-8?B?VVpkY0lzclc1NkZhR1pWMVE2MUIwZUZZS09pYW96QkVrR3F4YldQcEpYaG9Y?=
 =?utf-8?B?S1I5NnYxY1hMTEtOUE5DcTJKbytReWhqc01RaU5tVWxOQnVyamZ1QzV4bHln?=
 =?utf-8?B?ZDJaVjRTbFlYcGh4WlRFR0RIek5WcFVpdXVaTzJKM0JSMXBSQkxySTZncEFW?=
 =?utf-8?B?VXlyM3grUDZxaVV1OE5RcnNndllBMjMwZTVYNDQzSjJIenNqbzVvdEVhL29i?=
 =?utf-8?B?bjhJR3JoWXZPbXo0LzY4dlpFT0xXaDhwbWVPYXJnckE1WTlDcmdObkdJcVlE?=
 =?utf-8?B?bHBoRVZzVEVCekYrNnNHNmJGSzJzRUpYYlZQaTgwQllqRG9TVUZIYnpVRGR0?=
 =?utf-8?B?c1hxMlpBK1dHaTJvZmo1Vjg5RWcxZGJsbkRXZXcvT2wrOUE2azVxUXVlazJU?=
 =?utf-8?B?N0IxeXVlb3RmOGE3MEduVXdQYko4S01xY2lmYU5na3JHYks1a05XVHViQStn?=
 =?utf-8?B?SS9LSmplUnk4Qy8xYjN4RFF2UDFoa29EN3FuWllsZFhSTWlneGxVQVczQjll?=
 =?utf-8?B?L1pkQnJNWjE5NTJQSmhiNGNjVjk5T0FodVppejJxNWEvY1FwbzR1MG9HblRR?=
 =?utf-8?B?MHdScm5YOUl1bmJFNnQ3VE1FYmpFZ2VIZlZWeG9MOVpIQTRVc0M0SzlVV2xM?=
 =?utf-8?B?SVVPbjJLaHhHZTFsSXhuRytCczR0MEE2VHhjN20vSVZNSmR4c0lRYk9JMEpX?=
 =?utf-8?B?TDBObkVEaGpKcWpxeVY5b0VVOXVFczVoUmd5NldmR2hGOWZIUER2b0tUaEFJ?=
 =?utf-8?B?WUw2cG5sTE9WVVJ3b002TVRmL3BFS1RTeUZDdW42L0NLMkJJMEFiK2dDL3dh?=
 =?utf-8?B?TExPQTRFOXJIWS93bzJkR3EwaXJPNjlQalpjaEJ6UEZTelRhbUorRG51Q3Vt?=
 =?utf-8?B?UXNDd2xxUElJSkwxM1I4UFl6eXZuSFNRTnlqS1crU3QzWTE4ZHBDZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF11B2CCFF82834693403D46CE0AF5FB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gbZLDaHK/XPIBzZzUGIHtdTRqRVCWcQ8RSSot8hvFXQ6yOuMvrfNxAhlwKQi4I93GaY7UDMzGq6Vpl3r/VUo+8BP/lwrpScLE9+IlriElCg77ZfpSLb1k7DBzy2NpjrEOcA17LU6v8rI/xSJbIEFwCIewkp/XYuxig4HLSVXWWsu8k8IXgTYxIeklLK/buyzKQjZFm6W0KN59S86+sBSFhsgo9is39IqH3MzPw2lk1e66EHA5FzBJldceDkiQcMNDXn2D/ExhuaOwSnV7+dh6Lyye70p+pDcNsB99Dgl5DxDtYw4Qf9l3ftg8WrQ2gi0rsYw63wNTp5of3bzrYXjHg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbae69e-82fb-43af-d021-08df4a0f3b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 09:42:19.3895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6cZ02ikq3D51AyQ3Ayss5v8CyekduFzON5K69Ri5qj42zqqwHi4EohXnfoUBLNCU2snlDdrYhHmMPMX+s1afew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR03MB10055
X-MTK: N
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTExLTE5IGF0IDEwOjI1ICswODAwLCBIYW94aWFuZyBMaSB3cm90ZToNCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4N
Cj4gDQo+IA0KPiBJZiBQSFkgaW5pdGlhbGl6YXRpb24gZmFpbHMgYWZ0ZXIgdGhlIGF1ZGlvIGNv
ZGVjIGRldmljZSBoYXMgYmVlbg0KPiByZWdpc3RlcmVkLCBtdGtfZHBfcHJvYmUoKSByZXR1cm5z
IHdpdGhvdXQgdW5yZWdpc3RlcmluZyB0aGUgYXVkaW8NCj4gZGV2aWNlLiBMYXRlciBmYWlsdXJl
cyBkdXJpbmcgZURQIEFVWCBidXMgc2V0dXAsIHBhbmVsIGxpbmtpbmcgb3INCj4gYnJpZGdlIHJl
Z2lzdHJhdGlvbiBhbHNvIGxlYXZlIHRoZSBQSFkgZGV2aWNlIHJlZ2lzdGVyZWQuDQo+IA0KPiBB
ZGQgZXJyb3IgbGFiZWxzIHRvIHVucmVnaXN0ZXIgc3VjY2Vzc2Z1bGx5IHJlZ2lzdGVyZWQgY2hp
bGQgZGV2aWNlcw0KPiBpbiByZXZlcnNlIG9yZGVyIGJlZm9yZSByZXR1cm5pbmcgdGhlIHByb2Jl
IGVycm9yLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiAN
Cj4gRml4ZXM6IGU3MWE4ZWJiZTA4NiAoImRybS9tZWRpYXRlazogZHA6IEF1ZGlvIHN1cHBvcnQg
Zm9yIE1UODE5NSIpDQo+IEZpeGVzOiAyMTRhMDk0NGU2NjQgKCJkcm0vbWVkaWF0ZWs6IGRwOiBV
c2UgZGV2bSB2YXJpYW50IG9mIGRybV9icmlkZ2VfYWRkKCkiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBI
YW94aWFuZyBMaSA8aGFveGlhbmdfbGkyMDI0QDE2My5jb20+DQo+IC0tLQ0K
