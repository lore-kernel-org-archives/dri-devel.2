Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAD1606A325
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 03:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=aBZiJqmb;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=u46+eg52
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D541F10E51F;
	Mon,  9 Nov 2026 03:48:01 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9618D10E169
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 03:47:50 +0000 (UTC)
X-UUID: 5256b5fadbf011f1b1788b6acf885367-20261109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=NQ5UXNYDOkTDB76B2OyosO2GYpxQlGXe94bO2WsiThA=; 
 b=aBZiJqmbbp+dPAWXNRD7buBPyleYiDFBr4+WqlcgDoEiCApy0GRUqKdeOa3SP2nJKoPZazCyHtxBzBkW8kc6BqJKrtiYnhcaqUsZ0dBX2sPHgSM1aZjBTmfhZeDveAEyG5bzjhpCIVSBvSVs2sPSYCdz6P2SA4F9izdLWjT4/ow=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:b49e30df-b2c8-48eb-8b84-d81df4c07f85, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:7fad8cbb-4006-44bb-949c-6e25a7b8dad4,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
 il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5256b5fadbf011f1b1788b6acf885367-20261109
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 504100700; Mon, 09 Nov 2026 11:47:44 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 9 Nov 2026 11:47:43 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 9 Nov 2026 11:47:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDaU0BnKvP97ikguafQwrYbvnnaTnm4o7SOylOyVeJDgpEaBm42nzQkTewf8FT1IHPS3CUa+84uibYHxuTAce5YLVSonCYRJnKJsMpg31/H9jOy4Wx+4cuNQc1aYnLJnNleLcG9zGEz5z8nigy6EZoYYO6rcZr0iJjsMDvTYhf+fktTaBFLzcKOb16+cqRTsFZZotALt6Y9bnYV6Rzli4H91ceoJTMvGzKepRezf+5X7ot8NgD6pDfaCULupxOo/VzMK9CyKMUT1iPti3/hrJ1t76bCU2fEcxWBNLeMxomjyR3Kzfo0SmHTponzaoL/cLulpa61KVZlmtnzd0prbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQ5UXNYDOkTDB76B2OyosO2GYpxQlGXe94bO2WsiThA=;
 b=KSWkxEMkoNBtG5mM2VVMEJ2BIQKyOt73bHuhuROQihsnVHPWamvmoCq28nZWMjzKHQ/A9AVZmPimfntVnchbwS9IYrQxm9ae/xUQPPvFXEbkivs0s6ZrN9OueT/2bz/gnqMaljW2FXt9fiFhwxdsrxn24r8aluE7XhatPmBQ2yrG04uh9ZdLxOneGvLrLXZDTO82rOHJ8DpZ5fgnfX3hkgRjeSTcrptaH/Fd5AM3Jsl5Y9L6vLQnx/AIeR/Z1Bt7wdvpRMWRwHpy+6c6eS7BwgnolqXkbIFZ2rxOe9xCGOkRA2PlXfIYW8jUiS8OGpIfP9F4iWIU2rtaRAne84GGzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQ5UXNYDOkTDB76B2OyosO2GYpxQlGXe94bO2WsiThA=;
 b=u46+eg52XCIzycJHhGCn+7Y7WuqBnfiUIqVkOClhBIEeJZKcGxdvwPBHeVxsn5rPFwmdcCMbsMd6qZT2zWDoz3xXaQEVc9nfK6f5oRfDeQaOYjleAljUDQ66oDjlCMf0wKXGOJqAB2UzuGKToM9UAnhodMvOV1gtJMXAYhTMBwI=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by SE3PR03MB10620.apcprd03.prod.outlook.com (2603:1096:101:322::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 03:47:38 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 03:47:37 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
 "l.scorcia@gmail.com" <l.scorcia@gmail.com>
CC: "fparent@baylibre.com" <fparent@baylibre.com>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "jbrunet+clk@baylibre.com" <jbrunet+clk@baylibre.com>,
 "bmasney+clk@redhat.com" <bmasney+clk@redhat.com>, "chunkuang.hu@kernel.org"
 <chunkuang.hu@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "linux-phy@lists.infradead.org"
 <linux-phy@lists.infradead.org>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "chunhui.dai@mediatek.com"
 <chunhui.dai@mediatek.com>, "wenst@chromium.org" <wenst@chromium.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "mani@kernel.org" <mani@kernel.org>, 
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "sboyd@kernel.org"
 <sboyd@kernel.org>, "nicolas.frattaroli@collabora.com"
 <nicolas.frattaroli@collabora.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 6/7] drm/mediatek: mtk_hdmi: Improve the secure output bit
 toggle
Thread-Topic: [PATCH 6/7] drm/mediatek: mtk_hdmi: Improve the secure output
 bit toggle
Thread-Index: AQHdWK5sVFZVsj5AiEudhrGlIjNZrrclSMKA
Date: Mon, 9 Nov 2026 03:47:37 +0000
Message-ID: <2b2f11fc12297cba279f70fc4ccbda59b1a2198a.camel@mediatek.com>
References: <20261010115539.9237-1-l.scorcia@gmail.com>
 <20261010115539.9237-7-l.scorcia@gmail.com>
In-Reply-To: <20261010115539.9237-7-l.scorcia@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|SE3PR03MB10620:EE_
x-ms-office365-filtering-correlation-id: e1068a42-e70a-4ed0-00da-08df3e14329c
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|376014|23010399003|7416014|366016|18002099003|22082099003|10067099003|3023799007|38070700021|4143699003|11063799006|261028144727099003|261102123227099003|261022105027099003|56012099006|261021121427099003|261026140227099003|261026121527099003;
x-microsoft-antispam-message-info: NvrZvji1HlVRM+uQDeKdfvzKIa0JNJlvlk7RT/9nrvJrjOyni4a20sp7ZJRjFASRHC2Dq1Gmupb6fsZytZ+FQtwB2ylPvvMNyt+6TEMNKBIQJqAIXOwOqjKxF+MNGY9ffQKWq54bXqUJg0pW63+gkm5QrSIwETN8n8TwiZL+2zbvE3VvqtOcvhqYPQ2o5MRYdR9OJ+muvvqpFfTU+hRMGFUh+bMfWPlj6KjBxTZUJjOuUHCjVGn1/1ALvsNugmhg4x8Wvwf9BOzuG8yqKU/JudjOr1yUSQ8M+ErfrXXyumG2pPZif68bmXUz4VdCj27A2LQRd79uLZ0ZYdJYico4QijHezJGxGhUPApppMuI34OMsF2hRTkwUoCUF2u1H8otLSkq4cfSzbWNZ+MgUDFPXJjL7L2R6N80W4+ZIlQH9RBQeqfazkNZzsbqvV9p+7ZOrMLK+y2nLInSj4gkE1ey8xh9Yhbyy8CVZS2drB6xwHPfHfoBxacgJloHfxpw3cMy3i6+OoIpELcxhH4y4JZxLl39huVv22yt3ozK5r933LxaQQ9Zx9su6NNj43h7Yn1CQB/qZCdWpcycWqWBhA5lkt123zHjDIM7sxIyLPLCcXLsL1WIFfPEqdmpYGY68UbIedy3LFe6kMXlGVG/rXy2NYNvvbVAYzkapM3iL7IkRkZbWpmUTk9cEKmfl1nshi+DyzUmm+JJeR7tP+l/0mOgOn/CYAgmfaFXrEssNuYCHrs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(376014)(23010399003)(7416014)(366016)(18002099003)(22082099003)(10067099003)(3023799007)(38070700021)(4143699003)(11063799006)(261028144727099003)(261102123227099003)(261022105027099003)(56012099006)(261021121427099003)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVlDOW11WkZTcEYzRUhMWGpaTks4K1lvZzdqSUdDRmZ1bjMyVEpvVkJTUFA5?=
 =?utf-8?B?bHpxbGo0VGYxYmUzWFdxcHNnWkh1MHY5dHR2RFBmaUl2SktJRXo4bnRaTGdx?=
 =?utf-8?B?RzZKVWNHY3lYYVlpSElFNmw1NXQ3Z25MVStCZGxOb3lQRUU3dUN0R054WXhz?=
 =?utf-8?B?alpuQm9zRDZMdTFWRVJ6dk1GUGhVL3lmbFc3SUd3TmFVMXZBTGlFN3ZZL2d2?=
 =?utf-8?B?Q00rNlFKVHNVNm12UjFkYm54NHdBMGg0MnZkUnA4MUFTTGYyN2dwTk1nSzJa?=
 =?utf-8?B?Y2NsRGkxWUc3MGsxcXlPWTI5M0h4b3M1aDBzTy9EQ3N3UzZDS3NRQU1ZZEVs?=
 =?utf-8?B?bGVoK2tFdzg5U0dhS2RZK0NhOEpBbkNVakkyWmFlaUV1ckJlS09HRHZkdXFU?=
 =?utf-8?B?a21CQVp3YVovL25tNVAvY2JVSG9Sa3Avek5wb3BJU1d2VVpYMTIyU1ozKy9M?=
 =?utf-8?B?RjFKS1Rya3NMSHJKTmsydmYzeHh6bE4vUlpjMG5CS01lT3ZmVXhjM0twSE12?=
 =?utf-8?B?MGc4UlIxMG9BTWlsZnE4bjNJc00zWnFWdXlRYkQvTTFXRGdRZTdQbVJoWTB2?=
 =?utf-8?B?U0RHb3NGMDNzQ0pnUUlubHgzVlZ4VWtzSGNFZXdzUjhoS2V6NmNCck1pMkYr?=
 =?utf-8?B?cmZGODBVTW56Ly9tVEpoTGZrV2pMTTB3Z2FkcS9FT3lIbTBJWVFlUXgvM2NJ?=
 =?utf-8?B?N3lGZFpIdkh6MGh3c25NUndqVFIwU0w2bzZDOVhsR21PTDBDMzFlOE5YaDdE?=
 =?utf-8?B?Z2wxRUtZeURNSTlyNklSQ3Frb1FYTmF2WkpUQzlFS1BvN3JHVk14clZsLy9Q?=
 =?utf-8?B?K21rYnorODZvR3duS1lKV3hQT2V3MUJtNUxWWUl4Tzc1dkovZ2NxMUluQ3Jt?=
 =?utf-8?B?alc4T1hrRldsUnFEdGdLekt2NDhEZjVXci9kWFpRUkQ2cEtpUzRDb2JZTjYv?=
 =?utf-8?B?RytDdjVzNHNNY2FrQ1k0ZVl4RDd0bk1wNlFYQVo5OG1aTEQ0dFFCdG9CRnEx?=
 =?utf-8?B?RHNYU1kyUWdpdytyb2xQZ1J2UVNPWDQ1OS92eWRUQUR4UDFGTDV4cGpUUkQ1?=
 =?utf-8?B?Y0l6K29URnhLMkFIaVRNNW0vK0dsMVptcnVoblF5THpCWUl3MkttRXBXRjVr?=
 =?utf-8?B?SjFaTFJmeEU4L2FubFh0MHRreUx4dmYrRDVWRFgrMHhNT3c0Tm85c3JYU0xy?=
 =?utf-8?B?cStDVFlXNW5YN1cvR1lVUGhXdDVQTU03c0d4Q0pIdHdXcTYvM0FmRjRzcDFI?=
 =?utf-8?B?OHBJY21kYW1xaXNSbG5SL0VlWGxvN1pidnF5Vk50NTFSSGt1Yy9sL3ZTaW1x?=
 =?utf-8?B?dURPN2FzZlkwa3kwQ1pzKzRHQXBwWVk3L3hJMEZsa0xZRFBKaTRIakltVHV0?=
 =?utf-8?B?aEJSOVRXUVdKL3o3d0lZNEk4cVZMQmh3T2FUcmI3WWllZk4yTnppdDhxV1Zq?=
 =?utf-8?B?TDF6UXc4UFZyNXBtYnNJbnJBbUw3VDNKVlMxaWgxMFduaXhFaTZ2aFJGK1M4?=
 =?utf-8?B?ZDBxVEsxckpKODdjaXVXNWs0WUwwVUdaVmdqUWZwQXJhZFRHYlRXWXpRbndp?=
 =?utf-8?B?ak5CTTBYMzVwY2lhakRMRmZ4SXJyanZuYjVGemQ5QUhJRnQxK2ROUTh1M2NF?=
 =?utf-8?B?bFEycTI4aFF3czhUTVA4Nk9BM2hIUVpJdmtBdVhjY1pXa2ErZWZ5RVlnamxv?=
 =?utf-8?B?Zk1hQWVDMVIvZmNEalJVQzcvS3dtRFJJNzZmTFJaTWZXM0Z1R1I5U21hUElS?=
 =?utf-8?B?MTRwWVlGVVdhcTdUaVkyL0RPNzVIMU83NE90T3VqWHFPN1N1T29TRUVJYWho?=
 =?utf-8?B?MTZWL0huamxKRGtjbFNzMnFvS2lDU2I5S2VvYzFaMisxZkZUck5YdEhqc20x?=
 =?utf-8?B?QzA0M2hjOE1zL2t0cEtyOFJUOWdrZkxpZzkrTFJ4OUJsUFRFRzQwWnU3SmpR?=
 =?utf-8?B?ZERUSDI4QW5taDFadjhtSFFaVzh2QlJhTVdXdmgxbnp4OUFYazhpZlhsUXY5?=
 =?utf-8?B?U3ZyZlVTUEVLNDlxYlFaazByWGJmb09RTWNuSWw2QlFBNkM0VlA1MisydERK?=
 =?utf-8?B?cXIva0JNa3hkVWhJK0g0cjFnMzZWNHFkeFA4UFczRlduZ3A0bkVkMmN3b3dH?=
 =?utf-8?B?REg5WUNiSlJDTEJLRXhvcWtOUjBjWXZNeUp5eFZ0dFlkS24vSStHazJhVERJ?=
 =?utf-8?B?UVpIL2lsZHR4VzhrL2pRUGh5M2VnbXNac0hXbWhZdytCRU9kckpUb2QvWDAr?=
 =?utf-8?B?cldzWGd6b1I5NlhLUWxqcjl5ZllVeGV4WWg3eVVTejI1Zkc4MjNyT0pCdy91?=
 =?utf-8?B?UUU2MEh3LzBWYUZmTnJLSnNLQm44NW82YVcxYnBYd0VydjQyZU9wdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BBF8273ABBA2042A16B4445E72CF041@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: v7yDxlPkzFtxhb1l83v49Ii4IWabuepiDYh+kvLDWkTdUB86uX+0FI0IfnszS/e8+dmjPnWfkBYuVfEw30fcjesarXHaiKB1rSv9P9ldXIgHuwp0LZ+IY3uH4V1fYiplT/nWfQUR4Osyjey3DjtFJjGvS2tHz6qGRrDnbhzT91Ymw8FRhl7s8yRYL17A66JKLkmvEBKBfIWivazUDadd5JJmnEBfhSdshg3AymsHz4NJyWENphrrcosMUHfnj+FPCGyb9HSwIELX7h+mo3HZKllD3KojEGN7vcmehtac6xfQL807USlMezzhPgPvWYV36+dSNjGmYmLVeBCoLZvYlA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1068a42-e70a-4ed0-00da-08df3e14329c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 03:47:37.9133 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8Y+W9/zqadhqT16eh+Cui9Kg0UnC/i4p6THJcGLwmvZVFBt5Jp3+rfBikxTd4cVqA9kSB4wUl9fpRhaVD9z9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR03MB10620
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
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gU2F0LCAyMDI2LTEwLTEwIGF0IDEzOjU0ICswMjAwLCBMdWNhIExlb25hcmRvIFNjb3JjaWEg
d3JvdGU6DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+IA0KPiANCj4gVGhlIHNlY3VyZSBvdXRwdXQgY29udHJvbCBiaXQgdG9nZ2xl
IGZvciBtdDI3MDEvbXQ4MTY3IGN1cnJlbnRseSBzZXRzDQo+IGJpdCAwIChERUVQX0NPTE9SX0VO
KSwgMS0yIChERUVQX0NPTE9SX01PREUpLCAxNSAoSERNSV9QU0VDVVJfRU4pIGFuZCAzMQ0KPiAo
SERNSV9QQ0xLX0ZSRUVfUlVOX0VOKSBpbiB0aGUgc2FtZSBvcGVyYXRpb24sIGJ1dCBvbmx5IGJp
dCAxNSBpcyBhY3R1YWxseQ0KPiBjb250cm9sbGluZyB0aGUgSERNSV9QU0VDVVJfRU4gYml0LCB0
aGUgcmVzdCBvZiB0aGVtIGFyZSBhbHJlYWR5IGJlaW5nIHNldA0KPiBpbiBzZXBhcmF0ZSBvcGVy
YXRpb25zIGxhdGVyLiBBZGQgYSBkZWZpbmUgZm9yIGJpdCAxNSBhbmQgY2xlYW4gdXAgdGhlIGJp
dA0KPiB1cGRhdGUgb3BlcmF0aW9uLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlh
dGVrLmNvbT4NCg0KPiANCj4gRml4ZXM6IDBmYzcyMWIyOTY4ZSAoImRybS9tZWRpYXRlazogYWRk
IGhkbWkgZHJpdmVyIGZvciBNVDI3MDEgYW5kIE1UNzYyMyIpDQo+IFNpZ25lZC1vZmYtYnk6IEx1
Y2EgTGVvbmFyZG8gU2NvcmNpYSA8bC5zY29yY2lhQGdtYWlsLmNvbT4NCj4gLS0tDQoNCg==
