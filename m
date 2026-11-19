Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1366606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 01:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=QBgNlWnW;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=B2JvyogO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4839710ED0A;
	Thu, 19 Nov 2026 01:28:33 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1119210ED0A
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 01:28:20 +0000 (UTC)
X-UUID: 7f1aa2e8e3b811f1b1788b6acf885367-20261119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=UzK6ShchBbcL7TJDwNOiT7VxJS/5RQ4XLSmy7FDxKAA=; 
 b=QBgNlWnWhmEZuG9YUWEw/hJzf5Wh8mf5MdTlHOpBjPSxQjvcPLtwPnTM+RxP/p4a4i8PSTXR7j9LB1nnblm3o+Vmu4Rq4vzCMcqmgU8ThKUETOKBGQRG+QOvmdmKGcWFZFr/dIO+W8udbC5pAzSD5uJNDOOoTcn1rHyfvtijiPk=;
X-CID-CACHE: Type:Local,Time:202611190928+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:16dbd9fc-94d0-4243-936e-680c34eb81c3, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:12857d66-4b51-4c95-bb1b-80ac6aad9c96,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7f1aa2e8e3b811f1b1788b6acf885367-20261119
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1876278164; Thu, 19 Nov 2026 09:28:17 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 19 Nov 2026 09:28:15 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 19 Nov 2026 09:28:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sxek5LnAa413YwFe1EPdtYhszloslrxMZvCjNf76/Ub///uog7y2wAJhhkqgc1SU3v+XyM6kyrBuinTC7euJMDHZvEn30DcACph/f6w18MSQwfQM83EN9Bu+iyZ9msP6XPojjkLVEIh5vQXnH4TIP+ZH38ZWQ4BIUrbMA4vIl3qgqqo4pHgHFgOtX9gSR+Aw0BqM/E7bKd8A7aWevudn+jd/AHfofwUN+2NgMoC+dz+zByQDsXaII98h3yiK7TPKlBbEyymDqKF4uHyIeOSFDgFOo5a8GCXzNZqy39r/VTN43s0mjo4huhL3W4OtS/Wzpe/iIUc0kUFdTBoPvNEADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzK6ShchBbcL7TJDwNOiT7VxJS/5RQ4XLSmy7FDxKAA=;
 b=dry1bRGGK+iwq1FCa2ta5cU3It4rGIg5WUkEwMe2sIKKvwzZt5Pw979wD3TKrojLHa+p+NfEVGJMHt3oc6sLjFkz9GuegyqQFmxpYW1uDutwyEYME4FZJxgySvM4EBZ/EbTYyeTAw8tD8oHIlL6HRUGBNt76XGEpYQJpDv0h5fP8Zlhk7S2OrAZSpDqtU/myZKaVGBrZiFpUqelafc60HLoUqLR6YLT2DPyBUZT6sdvOFjO/doLSppnieb86NCWIQBnebnByXgvLYv9XodgHpsvS3SR9LIpvneP2vSskEHWClcfo1zf0ugrHKJc8sUyXQoKB3jk0z03/uBx6FFmPVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzK6ShchBbcL7TJDwNOiT7VxJS/5RQ4XLSmy7FDxKAA=;
 b=B2JvyogOkvDULK0rATLa5CDbBGGzutPGXJZMr5AqfcdrAW+UoNGQc/yGduFN64BJorLFUbm/LHGWJCF0aOKNxRXo8hiwnVhHB/3YXKqWB3Qnj1KeoGurWk4cvnFmWpAkwlmPuFC4v32zu3eCXhvQyzbRiXRa6PiidcQ4VPTUQFM=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by SEYPR03MB9587.apcprd03.prod.outlook.com (2603:1096:101:300::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 01:28:09 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 01:28:09 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>,
 =?utf-8?B?WmktaGFvIEh1YW5nICjpu4PmopPosaop?= <Zi-hao.Huang@mediatek.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "simona@ffwll.ch" <simona@ffwll.ch>,
 =?utf-8?B?U2hhb21pbmcgQ2hlbiAo6ZmI57uN5piOKQ==?=
 <shaoming.chen@mediatek.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>, "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2] drm/mediatek: dsi: Don't let a signal cut the IRQ wait
 short
Thread-Topic: [PATCH v2] drm/mediatek: dsi: Don't let a signal cut the IRQ
 wait short
Thread-Index: AQHddz/kX7eK8tYFzkqGS79HExAcKbczw08AgADYqAA=
Date: Thu, 19 Nov 2026 01:28:08 +0000
Message-ID: <26e896f79e5811514f2aa631d77f436c09ba1544.camel@mediatek.com>
References: <20261118-mtk-dsi-irq-wait-v2-1-8bda52993c6f@mediatek.com>
 <675eb0c5-96a1-4254-844e-234fb972d824@collabora.com>
In-Reply-To: <675eb0c5-96a1-4254-844e-234fb972d824@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|SEYPR03MB9587:EE_
x-ms-office365-filtering-correlation-id: a526d565-d2c1-485f-1565-08df45dc5e74
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|42112799006|7416014|366016|1800799024|376014|6133799003|18092099006|18002099003|22082099003|261009223027099003|56012099006|11063799006|4143699003|261102123227099003|261026140227099003|10067099003|261026121527099003|261028144727099003|261021123027099003|261022075727099003|261021121427099003|261022105027099003|38070700021;
x-microsoft-antispam-message-info: fh7slYChO8jsTc3n6tBJfBMvAC03mMR5nim+clJ1L/PryWxEMUxNKF6f+oWNFqhjyzCLo2Yi2NrQ2BmwM/AM4or7AsvdKXQhhJsKNDIdAYN4ZzKhugU4F76Otj8TOATIyB5h3Sh96hkYZi+3PBqIPlzSo6UuEJnOFD24ou7jSHn3aTMZjnearECEiak7+xFAqF1IcdtIw1I9OZTA22d2k1Lyht/cjNLjuwSlz04RfwY/Pyc31WtQqa9LpYz1Bu7KOdVgjDEE4xm9R8yyZuOsf3px8snX5xYs8J130OqsQSOq1i/stbzG8T21vqPzxO9+byN2VNw33UeZp3RktuPRuSqLO8KtxXSj4guXvSXjSuLlEDR5Ci3I5EqJeR0JbUMMry2cRj5Zr4rTI6juWXqfAwu3dT/2n+cUE8x7xUErZhZae3D8Q77GWyMHONkxcroP1YzeM+HoHKJ2EjFxI/17+XaKt00lxRxkk1Mcpylelx7B77xKR+Hbgux8ATTGSuWqWY8U2eLdURldgmRYay1fGHiLzhUDc1UKB+/A+P5wraUxnMIuZ5B7jjqzmmDFoUEfQPzo4vhGZk9F78QXP1VHBnRp6coYFcnJl3eChM4f9qb5GNY9xVBE+MG23N0ZnV3ApPXoRwtlnUwapyzj+tlsK0UFNqp8JGpo1ng0uzvsP9I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(42112799006)(7416014)(366016)(1800799024)(376014)(6133799003)(18092099006)(18002099003)(22082099003)(261009223027099003)(56012099006)(11063799006)(4143699003)(261102123227099003)(261026140227099003)(10067099003)(261026121527099003)(261028144727099003)(261021123027099003)(261022075727099003)(261021121427099003)(261022105027099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWt4U1d1WnRzaWMreE5PaytvZHh6R3cvRUdGQmhJQ3hxd2dTQ0d2QkpsVGNV?=
 =?utf-8?B?c2NFalRFU3p4TWM3TGwyZWdyQlZtb0tuMVNSVVhPS3hqZmx1QnF1WnVhbGdJ?=
 =?utf-8?B?QXJMK1RGcWF5S1U4SlhVU0xEUStEM1dXaHdYbjUwa0E3MEtzMXByelExOVpl?=
 =?utf-8?B?alp2bGFIcnc5MCtjbERCQkgxaXh1STZsUmNBNkJNRVRzWC9yY2F1bWZ3Mnhj?=
 =?utf-8?B?VENuNnZIWHdHczlMellZMkVXVVNpMzc0STNkWjExYU5YSzY4cVp3WmpIUEtQ?=
 =?utf-8?B?MzV3cEFlSjl2TEw3dnVOdXQyWVRsdzZNcTdyUFJoYnhJTW1yZVJCV2tnbk04?=
 =?utf-8?B?Q0R0eThzU0ZOWTBjbFVtblhKR3dUTllDZkc1V3YycVRtMW9wSWM1a3hBejd2?=
 =?utf-8?B?STZJUXpFQjNhQ2hGZ0V6MmRVL2RQQXNuWUVVMHc1OVBXb2RGdWFzeEhuUlE1?=
 =?utf-8?B?eHA5NVl2R3N6clBVUVRHeno1VXBHMUQ3TzhMd3A3cVJnWlF4V1JGemxHVXZY?=
 =?utf-8?B?NFpGKzUvZjI0N2JPeVdzbkVtN242Vllmd1BseVlOa0NtMkEyOVRnNjVWdTlV?=
 =?utf-8?B?M1p6MTE4SERpNU95bjd4N2JNaEZiWW0zZ2FWZFg0NiswTGxVSFpsdTZRY0hN?=
 =?utf-8?B?YmtrYXNHQTExVEpFcWd3TUVXTnlHU1VqenU0ZHdaNGRQVkpzRDhhb2ZOcERN?=
 =?utf-8?B?aEVHRXREdzNVWU9lT2wvRkFhQnZTWng4ZTVKYlZZeDUrMTBUMER1TzRvbU12?=
 =?utf-8?B?dFJoZXhOZU4wdDZpSnFrSFJZVlpPTUF1QS9ZUjY5dEVqYUk4aU45REd0OTU3?=
 =?utf-8?B?SFdVVi9mQnFRYU9FelN0V0x5Y0lhVU9weXdZSFAyb1JvY1p0aEh2UkFkL3NL?=
 =?utf-8?B?SkZvRXpjcnFKR05ENXdweEN3WDZwZ1dFcTlSVlZpYklxY0dvUVk5dy9PQWRD?=
 =?utf-8?B?ajN6Q0RiaXBSTEY0NnNId0sxRFNnRmlVQ3ZLZ2tESnp1TmNpZjgxbFZuYzdz?=
 =?utf-8?B?eWN0L1dDc1JJYkdSYzg4Mkh5TER0VktQU1B2UDZvcXJBbTNpUVFOZFZIbGt6?=
 =?utf-8?B?THF5MXVIeFpXdUU3M3pIMWZ2cExsODRZSVBReGFDdHptSGcyYkc3VVdJaStn?=
 =?utf-8?B?dVVMaUFEd2ZPYlUvOVFuRTFtT3RDOGxWSmNieGdua3NGUWZlOVQ2NkpHb1RQ?=
 =?utf-8?B?UjVNeStQdVM1WW54VXczMUFyRDZpaFBOdVlPU2lEMVBjcHNnaFZDNllhZ0o0?=
 =?utf-8?B?dUEyeHBrZC9SNTNyaTdPWXA1WTluSWVvRTVlQU9wZ2NiWXZSRkhTaERBUThs?=
 =?utf-8?B?VFFzWVRoZkt6NTdqRGtvNHlXRnVaL1l2SlBtR0t2YmU3WklEUVY1Q2lORG9s?=
 =?utf-8?B?bHY2eUMxb1BlZStLL0cySnRmWTFVVThUcFpoQnFMbHhDNlR1VDJSRjFpaFRP?=
 =?utf-8?B?Y3BTeGpwS3BzSnYydktkOEhYZVZDcG1MbGcvNjdhQUszT0NudHhyeUZ0Wmk1?=
 =?utf-8?B?cjgyaWJuMzRoNi9LNmx6Z2kwMG8zQVNlbFBwejJGeWtxM1ZSTnBnUlpnSjRa?=
 =?utf-8?B?MnZSWi9abmt1Y1VIbW9FeGQ4ZS8vdHJ4dlRUTkRBYWhGMHJDTVoydHd1T2dj?=
 =?utf-8?B?Ulk3Qk44Z0NOdzYxTzVlWERZOW1qNVhlVC9FUmVzS29aZVpoMlRiNU1jV1Y4?=
 =?utf-8?B?cWpQY3NNWEY5L3k5WFBvd2RnNzRUaGZJU3J6dmFWa1F2VTJIRTk2K3JKSHc0?=
 =?utf-8?B?a3NVdjAyNk9pcDdNaDRxU3Fzd2k3UUNadGpRVVZxcDM2VnMrKzE5bDAvMTlQ?=
 =?utf-8?B?UFo1MEZvMjNZNXd0V0w5a2Q4MjRnb09KVEpDTldENDlHSG04VTQyMzJhcmps?=
 =?utf-8?B?bGtjanIwWjJFemNjbGUxdU9wMzBhakx0TWRYbXpUVVpkRHVEV2QrUjNnZEY1?=
 =?utf-8?B?ZzhRTjZ3dW9WTW9UTEhWUGEyd1BvdHMvb05VdUl3ekgrSjVKa2hIbHFKY3d0?=
 =?utf-8?B?UFUvcHJFU0FmOFFCWU1GcUVSb0VDZm5keEx4Zlh2TG9vUzRtM21zK05Wbk9R?=
 =?utf-8?B?OVBqM1Z0SGZmb2xFTElJbm9xek11enJZT2F2V2JkN3BseFZMMWFkN0FXZEt1?=
 =?utf-8?B?cGdNRVJJQWVKclFTYmFrbXR6V0dBVTN1bk1abWdzSktsMWNYTTdJYmh4aTJI?=
 =?utf-8?B?VkluUlZESWZ0V0RramFLMFcralp3WVhYT1ZtYlZ0OWxtTENkNUoxTnVXeHZs?=
 =?utf-8?B?ckxnNlJtYzlzT3RoaEY0ZVV0V1V1YitRSlRNc2VITlZZM3UzbWU3Y2x6YXhO?=
 =?utf-8?B?RHdidUNpTVVJd25sYXNDd2k2SlU0TUxDYXpJUmtWL0JwLzVLOGR6Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67E77787BC6094428E74D82B877D8F19@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: c2GqhfnFcwfdiFOQcgoiUIy9IZZCVVcc672BoMvlP68sd4LGJ8U+W7ZdBiG/0ONPHL3wwXZKjABE4FbPtLq1WYf/O9xuib92QIa3297VUSteSFOYS5bJwKl9yiFD12+TYixOSEkkn6W/2TXJ900PorBtBnJQVy5P4lwD/tj2bs/RYVUYiJ4luQmGGeGypX0N5zyiOxJ7LN0YhIZC14uEVLD7NGEPkvSzTGEli7jqG620JFiSUlWaV11YXqY8zQhhViWPoRPCwF+EjRdbpsSInEqT6X2qomyZGPydgIRNCuNT0j6j5hjnVCwCIdjGida4cVWEa75c/QEl+zR/AHgU+A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a526d565-d2c1-485f-1565-08df45dc5e74
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 01:28:08.9431 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 83ZrPPe2lkMyLqSWR4/Ezw+nL+qC3zmdu91QV1dP9yptGMiwGV24XBL1RRSgKy+ptPUwyvtLQk4hI4MaGOelQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB9587
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCAyMDI2LTExLTE4IGF0IDEzOjMyICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gT24gMTEvMTgvMjYgMTA6MzMsIFppLUhhbyBIdWFuZyB2aWEgQjQgUmVs
YXkgd3JvdGU6DQo+ID4gRnJvbTogWmktSGFvIEh1YW5nIDx6aS1oYW8uaHVhbmdAbWVkaWF0ZWsu
Y29tPg0KPiA+IA0KPiA+IG10a19kc2lfd2FpdF9mb3JfaXJxX2RvbmUoKSB3YWl0cyBmb3IgdGhl
IERTSSBJUlEgd2l0aA0KPiA+IHdhaXRfZXZlbnRfaW50ZXJydXB0aWJsZV90aW1lb3V0KCkuIElm
IGl0IHJldHVybnMgZWFybHksIGZvciBleGFtcGxlDQo+ID4gd2l0aCAtRVJFU1RBUlRTWVMgd2hl
biBhIHNpZ25hbCBpcyBwZW5kaW5nLCBib3RoIGNhbGxlcnMgc3RpbGwgdHJlYXQgdGhlDQo+ID4g
Y29tbWFuZCBhcyBkb25lLCBiZWNhdXNlIHRoZXkgb25seSBoYW5kbGUgYSByZXR1cm4gdmFsdWUg
b2YgMCBhcyBhDQo+ID4gZmFpbHVyZS4NCj4gPiANCj4gPiBPbiBhbiBNVDgxOTYgYm9hcmQgdGhp
cyBsZWQgdG8gYSBoYXJkIGxvY2t1cCBkdXJpbmcgc2h1dGRvd24uIFRoZSB3YWl0DQo+ID4gcmV0
dXJuZWQgYmVmb3JlIHRoZSBJUlEgYXJyaXZlZCwgdGhlIHBhbmVsIGRpc2FibGUgc2VxdWVuY2Ug
d2VudCBvbiBhbmQNCj4gPiByZXN0YXJ0ZWQgdmlkZW8gbW9kZSwgYW5kIHRoZSBsYXRlIENNRF9E
T05FIGludGVycnVwdCB3YXMgdGhlbiBoYW5kbGVkDQo+ID4gYnkgbXRrX2RzaV9pcnEoKS4NCj4g
DQo+IFRoaXMgaGFwcGVucyBiZWNhdXNlIG9mIHRoZSBoYWNrcyB0aGF0IHlvdSBoYXZlIGRvd25z
dHJlYW0uDQo+IA0KPiBXaXRoIHRoZSByZXN0cnVjdHVyZWQgbWVkaWF0ZWstZHJtIGFkZGluZyBw
cm9wZXIgc3VwcG9ydCBmb3IgTVQ4MTk2J3MgRGlzcGxheQ0KPiBDb250cm9sbGVyIGFyY2hpdGVj
dHVyZSwgd2hhdCB5b3UncmUgZGVzY3JpYmluZyBkb2VzIG5vdCBoYXBwZW4sIGJlY2F1c2UgdGhl
DQo+IHRlYXIgZG93biBwYXRoIGlzIGNvcnJlY3QuDQoNClNvIEkgbmVlZCBtb3JlIGluZm9ybWF0
aW9uLg0KDQoxLiBIb3cgdGhpcyBidWcgaGFwcGVuIChpbmNsdWRlIGNhbGxzdGFjaywgdGltZSBz
ZXF1ZW5jZSkgYmVmb3JlIHJlc3RydWN0dXJlLg0KMi4gSG93IHJlc3RydWN0dXJlIGZpeCB0aGlz
Lg0KDQpJZiB0aGlzIGJ1ZyBpcyB0cmlnZ2VyIGJ5IHNvbWUgcGFuZWwsIHRoZSB1cHN0cmVhbSBT
b0MgbWF5IGhhdmUgdGhlIHNhbWUgcHJvYmxlbS4NCkkgd291bGQgbGlrZSBhIGVhc3ktYmFja3Bv
cnQgcGF0Y2ggcmF0aGVyIHRoYW4gYSByZXN0cnVjdHVyZSBzZXJpZXMuDQoNClJlZ2FyZHMsDQpD
Sw0KDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQo+ID4gVGhlIGhhbmRsZXIgd3JpdGVz
IFJBQ0sgYW5kIGxvb3BzIHVudGlsIERTSV9CVVNZDQo+ID4gY2xlYXJzLCBidXQgRFNJX0JVU1kg
c3RheXMgc2V0IHdoaWxlIHZpZGVvIG1vZGUgaXMgcnVubmluZywgc28gdGhlIENQVQ0KPiA+IG5l
dmVyIGxlYXZlcyB0aGUgaGFuZGxlciB1bnRpbCB0aGUgd2F0Y2hkb2cgZmlyZXMuIEZvcmNpbmcg
dGhlIHdhaXQgdG8NCj4gPiByZXR1cm4gZWFybHkgcmVwcm9kdWNlcyB0aGUgbG9ja3VwIGV2ZXJ5
IHRpbWUsIGFuZCBpdCBubyBsb25nZXINCj4gPiBoYXBwZW5zIG9uY2UgdGhlIHdhaXQgY2Fubm90
IHJldHVybiBlYXJseS4NCj4gPiANCj4gPiBUaGUgd2FpdCBzeW5jaHJvbmlzZXMgdGhlIGRyaXZl
ciB3aXRoIHRoZSBoYXJkd2FyZSwgYW5kIGl0IGlzIGJvdW5kZWQgYnkNCj4gPiBpdHMgdGltZW91
dC4gVXNlIHdhaXRfZXZlbnRfdGltZW91dCgpIHNvIHRoYXQgaXQgb25seSBlbmRzIG9uIHRoZSBJ
UlEgb3INCj4gPiB0aGUgdGltZW91dC4NCj4gPiANCj4gPiB3YWtlX3VwX2ludGVycnVwdGlibGUo
KSBjYW5ub3Qgd2FrZSBhIHRhc2sgaW4gdW5pbnRlcnJ1cHRpYmxlIHNsZWVwLCBzbw0KPiA+IHN3
aXRjaCBtdGtfZHNpX2lycSgpIHRvIHdha2VfdXAoKS4gV2l0aG91dCBpdCBldmVyeSB3YWl0IHdv
dWxkIGxhc3QNCj4gPiB1bnRpbCBpdHMgdGltZW91dC4NCj4gPiANCj4gPiBGaXhlczogZGQ1MDgw
YTU0ZGY4ICgiZHJtL21lZGlhdGVrOiBhZGQgZHNpIGludGVycnVwdCBjb250cm9sIikNCj4gPiBT
aWduZWQtb2ZmLWJ5OiBaaS1IYW8gSHVhbmcgPHppLWhhby5odWFuZ0BtZWRpYXRlay5jb20+DQo+
ID4gUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4g
Q2hhbmdlcyBpbiB2MjoNCj4gPiAtIERyb3AgdGhlIHJlbWFyayB0aGF0IHRoZSB3YWl0IGlzIG5v
dCBtYWRlIG9uIGJlaGFsZiBvZiB1c2Vyc3BhY2UsIHNpbmNlDQo+ID4gICAgYSB1c2Vyc3BhY2Ug
YmFja2xpZ2h0IGNoYW5nZSBjYW4gcmVhY2ggaXQgKENLKQ0KPiA+IC0gQ29sbGVjdCBSZXZpZXdl
ZC1ieQ0KPiA+IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI2MTEx
OC1tdGstZHNpLWlycS13YWl0LXYxLTEtMjA1ZjI1ZmFjOGIyQG1lZGlhdGVrLmNvbSANCj4gPiAt
LS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMgfCA3ICsrKy0tLS0N
Cj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+ID4gaW5kZXggZjgyNTA2ZTEw
ZmQ1Li4xMzE1ZGQzMWE4MzQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kc2kuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNp
LmMNCj4gPiBAQCAtNjI3LDkgKzYyNyw4IEBAIHN0YXRpYyBzMzIgbXRrX2RzaV93YWl0X2Zvcl9p
cnFfZG9uZShzdHJ1Y3QgbXRrX2RzaSAqZHNpLCB1MzIgaXJxX2ZsYWcsDQo+ID4gICAJdW5zaWdu
ZWQgbG9uZyBqaWZmaWVzID0gbXNlY3NfdG9famlmZmllcyh0aW1lb3V0KTsNCj4gPiAgIAlzdHJ1
Y3QgZHJtX2RldmljZSAqZHJtID0gZHNpLT5icmlkZ2UuZGV2Ow0KPiA+ICAgDQo+ID4gLQlyZXQg
PSB3YWl0X2V2ZW50X2ludGVycnVwdGlibGVfdGltZW91dChkc2ktPmlycV93YWl0X3F1ZXVlLA0K
PiA+IC0JCQkJCSAgICAgICBkc2ktPmlycV9kYXRhICYgaXJxX2ZsYWcsDQo+ID4gLQkJCQkJICAg
ICAgIGppZmZpZXMpOw0KPiA+ICsJcmV0ID0gd2FpdF9ldmVudF90aW1lb3V0KGRzaS0+aXJxX3dh
aXRfcXVldWUsDQo+ID4gKwkJCQkgZHNpLT5pcnFfZGF0YSAmIGlycV9mbGFnLCBqaWZmaWVzKTsN
Cj4gPiAgIAlpZiAocmV0ID09IDApIHsNCj4gPiAgIAkJZHJtX3dhcm4oZHJtLCAiV2FpdCBEU0kg
SVJRKDB4JTA4eCkgVGltZW91dFxuIiwgaXJxX2ZsYWcpOw0KPiA+ICAgDQo+ID4gQEAgLTY1Niw3
ICs2NTUsNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgbXRrX2RzaV9pcnEoaW50IGlycSwgdm9pZCAq
ZGV2X2lkKQ0KPiA+ICAgDQo+ID4gICAJCW10a19kc2lfbWFzayhkc2ksIERTSV9JTlRTVEEsIHN0
YXR1cywgMCk7DQo+ID4gICAJCW10a19kc2lfaXJxX2RhdGFfc2V0KGRzaSwgc3RhdHVzKTsNCj4g
PiAtCQl3YWtlX3VwX2ludGVycnVwdGlibGUoJmRzaS0+aXJxX3dhaXRfcXVldWUpOw0KPiA+ICsJ
CXdha2VfdXAoJmRzaS0+aXJxX3dhaXRfcXVldWUpOw0KPiA+ICAgCX0NCj4gPiAgIA0KPiA+ICAg
CXJldHVybiBJUlFfSEFORExFRDsNCj4gPiANCj4gPiAtLS0NCj4gPiBiYXNlLWNvbW1pdDogMDY3
YzVjMjRjZWYyM2Q5MTNiNjdlYWFmNzFhZTY3ZTcxNjlhNjYyMA0KPiA+IGNoYW5nZS1pZDogMjAy
NjExMTgtbXRrLWRzaS1pcnEtd2FpdC1hMjQ3MTJhZGE2MjcNCj4gPiANCj4gPiBCZXN0IHJlZ2Fy
ZHMsDQoNCg==
