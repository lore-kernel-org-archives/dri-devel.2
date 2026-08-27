Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF89CC61DBD
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 03:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67BA810E38F;
	Thu, 27 Aug 2026 03:03:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="p2hzhG+b";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="hh93Hvav";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CA2A10E38F
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 03:02:59 +0000 (UTC)
X-UUID: cba64680a1c311f18dc8c9802ae25ab1-20260827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=hbgi0cgX2u/AiOf8gwpWHJcDL6CAqDtAD+jhgXPJA94=; 
 b=p2hzhG+bIm3XfTkV5Cwy6e/dfS2HgNYDrR6geumfHIpkozcBHvOyW3PHe4CTaDBXnz6xvGUVcc0rX+h2vBaGxAKrpQVO25LeQRh89SqdSPfjdk/u7SFPA8+I7ESQKzxdx/Zy6m0lKSKowtfgnA2BT2HhDfsSfTanbmKRo+xa9Yc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:4a0b2b8e-c90b-4ea9-8a72-9f9ce16b8928, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:9a01cb33-ff6e-463b-a101-7a11e23b69a5,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cba64680a1c311f18dc8c9802ae25ab1-20260827
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 178351111; Thu, 27 Aug 2026 11:02:53 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Aug 2026 11:02:52 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 27 Aug 2026 11:02:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTML5PHjafHTEkq5eoKw5fKPfvSjHghBmobzSMl9+ZCcc0eU9JZvm2j7ERgEmcHdv0KqULCuTKRobatfljr5I6D363p+8RI/+MxnDYEzRODRmBI4K/FdguV+vDXJEBIrV2BgUrDGb9waoqwULUwEL4dse6D9PExTqLL0xRnRsBr+mlBGsrdEvAsCwHm/a+rqsPYKtantsDBcrgMm4EPfODJhuC0Fj/E9hhWq/O+Je/p4C8zys+LiRJOEMYW7KgoJFORPTOza/s+YKjWRjRt6vUKDE9XFUi9uOdJWKpeBlxWthTznvYqHqajRYttAVBtjlOOO1vDg10arnfvgguKb9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbgi0cgX2u/AiOf8gwpWHJcDL6CAqDtAD+jhgXPJA94=;
 b=VDH9v+EUfWoOc9RZQEoxek1CEaS7hzcqnjbKJz/QbfEcFgtYaar7opqLcay/yg32RIjfrnkhbsnHVCIw4TjGx7fOsUGkimfZXrdkwe1p0CsInICbi22+Ap2XlpJWSY0sXYnVz8aPVku1q8ooz0TcKEat5kqShFHbQIEPBjep/vkb7ohD2LXa5UC4o2p1351N9JKaOUFTMvWjx1BnEeu4uXNPxnatVFu+r3Otm2sFYkUbZjuUfu4I8EUrqIVS1LHV4xUp8M5iHELXS5UHD8DUOAD57t2P65+LPs0u5ciF4akzCgoXxP7JbV2qEWc6aRTu9J5dydXkzmCoO5eOgK4Gcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbgi0cgX2u/AiOf8gwpWHJcDL6CAqDtAD+jhgXPJA94=;
 b=hh93HvavCBbV3BIh/xIUZSAxb1ZPBbjXf6fQThWJP18LbrKyeWQ46vJclIz9LFMNcFhcp92T2rDzS0+5H1iTBLrjd6vdRG14WVlEnqSbPwmVCrkTn8PWEXH3Y5pw2xM2Nnu0UADZXgkTI6kVEm9tlD/w03rUrY1Q5wPPu0I1z4E=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SG2PR03MB6429.apcprd03.prod.outlook.com (2603:1096:4:1c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 03:02:48 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 03:02:48 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "kernel@collabora.com" <kernel@collabora.com>, "robh@kernel.org"
 <robh@kernel.org>, "krzysztof.kozlowski@oss.qualcomm.com"
 <krzysztof.kozlowski@oss.qualcomm.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "mripard@kernel.org" <mripard@kernel.org>,
 =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "airlied@gmail.com"
 <airlied@gmail.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>, =?utf-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?=
 <Justin.Yeh@mediatek.com>, =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?=
 <Jason-JH.Lin@mediatek.com>
Subject: Re: [PATCH v6 10/11] dt-bindings: display: mediatek: wdma: Add
 compatibles for more SoCs
Thread-Topic: [PATCH v6 10/11] dt-bindings: display: mediatek: wdma: Add
 compatibles for more SoCs
Thread-Index: AQHdFGH/qywlhHtq1EumacPUpsFlGraxeE+A
Date: Thu, 27 Aug 2026 03:02:48 +0000
Message-ID: <1bae03bfa7e29cbf744e51da3e552b5358896552.camel@mediatek.com>
References: <20260715135703.46540-1-angelogioacchino.delregno@collabora.com>
 <20260715135703.46540-11-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260715135703.46540-11-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SG2PR03MB6429:EE_
x-ms-office365-filtering-correlation-id: 8c27db2e-e630-4233-9cdf-08df03e7ace3
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|42112799006|366016|1800799024|23010399003|10067099003|56012099006|18002099003|22082099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: ZWcozwhGA0dDFUmDfzEpFvQtjXEc/uCs8GC5JehuK1sBuqrxpxS8Pn3CrEC+Q6oNRlMKqsRzQymJDgXD3mopS4loT6EpsH4Z3h1Sz0CKT4NX2g21PVofXkOaCp6XKkOpi67x/AEzAq/24b+clTxl84vQ9n24ZCDCpsdKlDWwB4ppQ9Bh4CFZ31kHRiI9IR/sNdXNtfvhc4p+QYUVD1Pc+5bLMoS3YVrLAM3RaTFenmvvjqC4hL3oIIE87xBtGaY+4XvV36xq8ZcH19Vk0/39l53jUF58IM30rVn/ro9DRtfpx2l/0o/6D57YAmRr2ppg2yCKSN6AhriOOrsfAhArgfmp+G17TXdnfXPyUQu/kIVNqw68XsqvOuo1EwiwrX4xmkJXXcmc/8YP5YrzLgY3rItzSd+9Pm4L1ImbqlT1hXMeTml+kK9JajYkea7mX2JXyij4HTEQayE7AhvIuWPzlNfQq4az3kLOTkZCVWOLIg+R1wHfyoy/C3jsmiRMswuRsC2fjU02g4X50MLyvHH73w+FLN/nViPzbylUBcXaQqu4gNhsVailkQHvj9YzE/JfzmO/aXhLlLk6Az5SIDSml3aKLsSF4Gkzjyxl25M+QLWEj9GiGG1y7emCPe8BGvb0y/J2i5sK+wQJKyAHl+idoHWr+xVdVxRCv3Dkcuezor7EMgU3laL7efDw2kKrQVaaoJdAYAs8YzdETBsUuQJUKNO7hs82mM7yd257kPX9UpE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(42112799006)(366016)(1800799024)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3c3VW9mK3ppaFZvVHdzZjlMS1pWNlpuZ0dLQzRRYll3elVZOVd5QlBtSjlD?=
 =?utf-8?B?MkJWUy9QaFQ0MmtsTjcxcGF0YnczSEMweHFrL2JQNW1FR2RwWnE4NkZZQUJO?=
 =?utf-8?B?RXBTUGNXNGFKUHN2TjN0bkFsLzU2SHpVYzNPaUg1K2gvRkZ1ejZwYXFRY3Ja?=
 =?utf-8?B?RGh3bW84Z2pLMFRraXYrbFlFeldOM09kaG9qaHBkYlNSdXRjY21yUnBsZUlq?=
 =?utf-8?B?RUJUV1JwQVhhamd0a1BjRlIrRXg3RzlQM21Jd3VSYVRzcHh6S3J0NXdaSFR6?=
 =?utf-8?B?bmNIVVFNc2hvb2t6dndYTDVQWXlDK3dHazBJRS83djFkNXRZeUxlWWVsOTh2?=
 =?utf-8?B?ZDJ0QUc3eTkwdTZGREdaWThhV0tSTTJ4V3FPZUttZXRKaDEyYTRva29yN3Rs?=
 =?utf-8?B?MUphWjlyV1doekJyNHg0Zjk5MlRHb1JHS1ZndEhrYTdVWlVFWk0rLzJUL1Yx?=
 =?utf-8?B?b2VzTk1JKzVHWklheHFKbHczenZYU2M1MDVXT1hXZjlMalEzWU42SkthK0ll?=
 =?utf-8?B?VUpRbmZUbHJVeDRndG1ZejZaK05DYnk1SkU3MnI1T3lrdEVxS3dNVWtCYSt5?=
 =?utf-8?B?T2M0Q3dPaXJsM0dhNjRBUDBuRCs1LzRWZ3V0LzZWYUxwZ1pEbEh0dTBDYmJm?=
 =?utf-8?B?a0hFQkxUMGo1TkdsZXV6ajlwYWRoYUJyOUdpZDRIT1FKTEJhTlhzTk9mRHFV?=
 =?utf-8?B?djIyT2YvL2hYNnUwaThtVEhyMTE2N0N4aDBxY0VKL3ZGM0p4alBZbW14bng4?=
 =?utf-8?B?dFg5UElvckdMVEpvb1RXNjc2cVlRa3planAyOXpQVnNNSXVJMW83THBRMU8y?=
 =?utf-8?B?VC82M2wxdGhCSXhFRCtlaFJoc3BadkxMMHFWdTgxeDZuTlQzUC9OSDAyUXhZ?=
 =?utf-8?B?SnB5b2txRUZTcVBWSEVaZHoxaG45VzFjYVpXVE5VVy83L1QyTEJBSXpkT1pr?=
 =?utf-8?B?cTBaRk1Vbi9GNnNVTDc3cVdUbmlBMlM0Q2c4R2psdnFtYjBQd21ZbFZpQVQr?=
 =?utf-8?B?bHBqcC9WVVNBOFU0emFxUEtZUDB6cFl6MDBaemd6WTYzZmNERXVLUHA0RVQ5?=
 =?utf-8?B?Slc4M0g2ZG5sUDJzRUt5K01XZTZaY1RlTWJ0U1lUV2x1U2ZjUjFyL1U5VHc0?=
 =?utf-8?B?RmxxN3RFUjdZUnBYME5HL1YzR2lDMzhZVDBuam1rQnJFSjlWblFFU25VOWJD?=
 =?utf-8?B?YVlHb0tJZ1RCRHNMT0d4TldpdXZOd2duTldKaGdBOWpJbzVhaGtiY0RxbFJi?=
 =?utf-8?B?cHIxYmFOaWdVcFhpSzBReWRrc2JIMzAxb0E5U0N3Q3lLOUJ0MEY2QllIeGRu?=
 =?utf-8?B?RFNlSFBYVTlZR0xIcDR4QkRwYm5Idnc3T2NLT3BCUmQxTEpDcEs2T21QRVRY?=
 =?utf-8?B?aCtOYS9HRVcwNUdUejFITlEzV3A2eWNXYUFsYkhKMGttbjZObzlYejRVdU1h?=
 =?utf-8?B?MXJPVVdUUlBLT3RRU0pjakFMWENTdFVtRm1ZK3dxVlVVeXpLeWFkMFJFT1lm?=
 =?utf-8?B?Si91QkhtWDlNdXBDS1o0YzFYUE9MZWx1eEdUTm1TTFVIZXZjMDlHNXd5OHdk?=
 =?utf-8?B?UHROYThPcERXZVVTam56dzQvT1lhcDQ4Q2JyM0dNRDZ2ZGRuT215ZGtOOU9u?=
 =?utf-8?B?bkhhMm0vL25ldTJFTHZKOURJempRWi9CdGhDMStka3N6cjVxdFRQZ3ZBL3V5?=
 =?utf-8?B?RS9BNGRUc2h2ZXVDcUJJTnhadVJaNlhET1E1OGFYZW5BamhvbzJlUDhNMmNM?=
 =?utf-8?B?NWlrVXI5NXk1bS8xMkFoN3ZDQms1Zy9JZUNVTjJiTnZMWGg0SGNsdEpncnlW?=
 =?utf-8?B?YUl4c0lsZ1V3cTFqOWFCWDN6aCtYRmt2cGxnTFdIL0xHMTRVcnUxa2EybnNi?=
 =?utf-8?B?NjFMbzIxQzUweTNackZVSmEwL1RzZWs1WWlDRDV6RkF5TkgyN0U3aWpHcWdW?=
 =?utf-8?B?RUtkK2o5ek8vK0oxUmpURVZCT0F6RnhHczRBQWl2TzNjV3RrWDhpUG9iWVBi?=
 =?utf-8?B?RUlQNzg0WndUWEFnSTFQMTVqdE42eHVkM2RDa0dZcVJTUVA0b0FVc1F0N0dS?=
 =?utf-8?B?eEVzT1ZxczN1bmR0RVJhZy9hSkVMQmNWMFdNNHdhUEFqK2pIa3NZUGdpdVlE?=
 =?utf-8?B?UTFubDZtejFYWWdPRnYxQmQvSDNlT2I2MEhFTU9PZzRyY0NENW4wcG81VzBr?=
 =?utf-8?B?eTRNU0NpTUQ0clovdnZFMkFoSmFtdVpqcUx5MGlCcXo4eURVTUNxUlJwYmF5?=
 =?utf-8?B?WXkvd2ZDV001em82Mnk5UFI5S0lwcUhGN3dYTXRSa2FsUjNqeFNuNFcvVkNj?=
 =?utf-8?B?WFNiZ2FxKzZ4VjdhaFdHZ1gxR25LTGFKb240d29hZUVHUnVLcTB6dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3B937EDE3644945B2B130F76457F079@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: q7BP/EDjs1oV2S8imC9kjTZ6pNopwY8Z/ATZic941rQTak5l5pqIxT2jbWeqwLB5AAR8wZgd+WxZ+ykYL8LbqCuvT1SbFfYRRDBfq1uIUEKRtKQAsmbGVkxaVZRClpAagJxy3K0qxzApgqeHQGx4ew4ezhY7Upcq80lm0vHaCqo7V+Kpgg3F8gMCr/EtGppVL/Tn9bJ/DTHfr6vs858gUhJVOvtu85TdfQH0DdwZSItLZ2+VIK5t10g4mtw87117P09seZFK03UpCR9IxGpMQMAp+apI7XoiG4NutlG79/0Jiww/ensqiSYY7iUz/RpRxWwuEaHOnbpKUZzpAA7oWA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c27db2e-e630-4233-9cdf-08df03e7ace3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 03:02:48.2229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gDr1IVi7Ga6wDQOhNFaVntovEdrYZY02ZgTI6dmVrtlbY3dA6ZMhE+UdcJJV5hsgRCPX9g0YJBzJZVggPRjBmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6429
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
ZWdubyB3cm90ZToNCj4gTXVsdGlwbGUgTWVkaWFUZWsgU29DcyBoYXZlIHRoZSBXcml0ZSBETUEg
aGFyZHdhcmUgaW4gdGhlaXIgRGlzcGxheQ0KPiBDb250cm9sbGVyOiBhZGQgdGhlIG1pc3Npbmcg
Y29tcGF0aWJsZXMgZm9yIERpbWVuc2l0eSAxMjAwIChNVDY4OTMpDQo+IGFuZCBmb3IgS29tcGFu
aW8gNTAwLzUyMC84MjAvMTIwMCAoTVQ4MTgzL01UODE4Ni9NVDgxOTIvTVQ4MTk1KS4NCj4gDQo+
IE5vdGUgdGhhdCBNVDY4OTMgaXMgbm90IGNvbXBhdGlibGUgd2l0aCBNVDgxNzMgYXMgaXQgaW50
cm9kdWNlcw0KPiBzdXBwb3J0IGZvciBkZXN0aW5hdGlvbiBhZGRyZXNzZXMgbGFyZ2VyIHRoYW4g
MzIgYml0cyBieSBhZGRpbmcNCj4gb25lIGFkZGl0aW9uYWwgcmVnaXN0ZXIgZm9yIHRoZSB1cHBl
ciAzMiBiaXRzIG9mIHRoZSBhZGRyZXNzLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1l
ZGlhdGVrLmNvbT4NCg0KPiANCj4gQWNrZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlz
enRvZi5rb3psb3dza2lAb3NzLnF1YWxjb21tLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxv
R2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3Jh
LmNvbT4NCj4gLS0tDQoNCg==
