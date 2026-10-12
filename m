Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EEFCA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 09:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E75110E545;
	Mon, 12 Oct 2026 09:20:22 +0000 (UTC)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C9C510EF8B
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 09:20:10 +0000 (UTC)
X-UUID: 1c2d12ccc61e11f18dc8c9802ae25ab1-20261012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=8CwrnfGGGmpROXk/i9aL/4YIKiE02+IuAUNTyF++4oI=; 
 b=unGuZjSRcd08QY5eENhOONjXY8+ey+rTRmoOIu1kskC441OPaRUl7LQpAuSL1DDI64SzJaCZx9F6AEN28GWwGr2ncDqU0JYL0L0Ex3fKuGXWCvoB28qwttTEd6lNk5n5DtSMO0eb8J0INm3P9ktfOx7oqDdUCRklkVqbmq6LARI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20, REQID:e78ff388-fa53-451a-84c1-e24104ed82ab, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:291e20b, CLOUDID:96fafdb8-514b-419b-be8a-53f1868a3ee6,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1c2d12ccc61e11f18dc8c9802ae25ab1-20261012
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2048851819; Mon, 12 Oct 2026 17:20:04 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Oct 2026 17:20:04 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 12 Oct 2026 17:20:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mp7SSvCm00Y80tFnbKQk7HIOf4nbv/OJeQrkOL886PpETWhcHCoO2ozMNDua+cb8bi6gl1Idm9neZ7NVtwA4zJPxLfNqn2h4uv451eBDuKSzb/wMtxye1S2BZvRCZ4jK+9iVs6e5gcxdsqe1I7NqPtj8Uxxt0JJq01GS+oaM/vgipArzp+GJZQ6j9E7lf8OYMl+WBuNNd0QSCeD0g3MAxxdgmA7vUB1I34k/rmO8Aq6jo2Zp0q9rksQx/zHdwHWfdLOH9lJufNT36+2zoLv9r/+bqLkRj7srMiS0D7l5vTyERsIHrLlBrUNi6dQBEHMJWxTg7ajwEycN2aizPFm0Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CwrnfGGGmpROXk/i9aL/4YIKiE02+IuAUNTyF++4oI=;
 b=CKAFajHffQKnhUhZKNVW9/KTfCdGdkFxCQFi1n7YZi0cIc9NaXt0VjTECVf7cjUbn8oJ8FVwNAXFo4rbonlw8PxZ2XrVbnJ6onuAnGJSum4t5asTgwZrN04p7iwrW4v7cAG9usBqWdCtQg6AwBc1IHFFky570zfzd/aPq2HfDzdbKIIemkb+6VaxBhf7T6QBXnDruk2NRDG8IUzOVIxdOA6XdmC+M3Ev9NPcB3aHJ28agMR4OcOEnam1w4Amol/EXy43xKHB1oiK/5hkmjJIDOYEb3BnpKhSQgzKTYt9j0l7CBp+hLuzO5pnOa4nroxXPM8+K5MyFkupxbPqW5NMTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CwrnfGGGmpROXk/i9aL/4YIKiE02+IuAUNTyF++4oI=;
 b=j9y4hEBQE924d3sFZxKS2iqC6CT+TfOmbO6segtXXEOdiPn3aVAGGyXyCJqgu48x/2HgsweYpqPzFMxNF4GOTI4ruBWpHlvbQKPhxVpG4Yci5++lbzgKjvvc6xvuPtBtvJ00qaJYCD0d0uGZHTezngcavhzA2fYpdD7yPuuSPFs=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by SE1PPFCD044E159.apcprd03.prod.outlook.com (2603:1096:108:1::868)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.18; Mon, 12 Oct
 2026 09:19:59 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 09:19:59 +0000
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
Subject: Re: [PATCH 1/7] dt-bindings: mediatek: hdmi-phy: Add compatible for
 mt8167
Thread-Topic: [PATCH 1/7] dt-bindings: mediatek: hdmi-phy: Add compatible for
 mt8167
Thread-Index: AQHdWK5j10lwqBxUrU+dwgeL1ZTR8Lb5pFeA
Date: Mon, 12 Oct 2026 09:19:59 +0000
Message-ID: <ecdf765641209f3d0f27fe8ae77fe9145884d932.camel@mediatek.com>
References: <20261010115539.9237-1-l.scorcia@gmail.com>
 <20261010115539.9237-2-l.scorcia@gmail.com>
In-Reply-To: <20261010115539.9237-2-l.scorcia@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|SE1PPFCD044E159:EE_
x-ms-office365-filtering-correlation-id: c519ceb9-0651-45b2-9192-08df2841fd1f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|7416014|42112799006|38070700021|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: +VvCgEU4GVb3cdejFnbg/GCEx1fCUEdQgBzhvlG80ONSJ1LQeTcu6cLCutOPGcJZNQe9FfDdvobFj92q+tjHr3EFl7SWIV+JZhfHT65wz/FEb5CcA2zsu+SUob8qVaID3Cmrfv0PiTzuv6dTm73XNnZLW83uNiz5Tp1+tUHAzizWpjGwi0d83FaWEDgTlOTYFNisJLfoG1Ctsa2wkPAC0DDBGAVFj5GnftQV+zzJQklVv4mNREcG4Fxq62Fb5CUgtabfbJ0pGMyXZluiUwSiDCPYsXInt0YGMkXycFt+XNesWrrPmhCEyJ8ZDh3p0YWnYGct/XakbgA/lbuQ4Qccx/mn+H37Tr4zKrjJeI1QzmCTlxig4Bs/9K5mcQ1k2rM0AsFpdoq9JMfBLiJH684fQ5N2/rKIFU06MMiJ0W5JlXJfYELfPUAw2+WKJlaJHDV6+BdSnqFaa3k9W2u53wDQvf5C9qxjNWDpeeLdr0Ag4RtabeMIvtQQy5hEylDl3dAxHYreoDzVbDKHXWBfbz8kmZmwR0OvDoznAJw0W4ES3ZX5eyY73x+Z50zd4/HdX2QvkHBz7D/b8cXgzt4OvbBsKoDiec70OV53KgsHHBLehGWZGcC2BWr1/VmOp8UTxqmFw2YX1tjC8YUs9YAJwjGMXYu/Vf/wN4jKiwqMiEdzpMlXmKbyCHgYrgwNGBSPSZ/DaMu3KjdMB3XU3EpeqsrBZ3KWR0H26IX7e28zlY4UlLM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(42112799006)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDArOGtFcHBOU2JLQ0FmWlV2eVdHK2NxS2loZFZUOVB3SzhMQitZc0ovTnNk?=
 =?utf-8?B?c0t1a29xMzE0eGxTY0MxbW45cjhPOWhzK1JuZVRybGNUSEFscm1BQkdPQ1Zw?=
 =?utf-8?B?SkJmY09iYmQ4TlI3b2p3MWxvOGE0RHJhT212ZEp5VkpYbzBlSlNZdURRRWIr?=
 =?utf-8?B?enJJK3pxMnVQakVnbFRva0FudGVCaENwZnpGYStjdFdUTFdvRnFWSFUwVEZh?=
 =?utf-8?B?bzI5aW5BQzdIV2lCcVg3MTR3S0dRSmI4eEg2VnZ3NktnSW96bUxCZm1yYjZP?=
 =?utf-8?B?bjlvamlSMVdwZkFFaDVZOEhoZWRmSU5SWlZTUWpnKzlWd2MyekRrVTNrbmZW?=
 =?utf-8?B?WnhFUlZDbk5nYjNiVXRYa2dGd2JocFZiSEE4WkFNTE5LS2pQc0lwQy9NNTZr?=
 =?utf-8?B?MWN3K0ZKR3crazlzOFdCRjV0UXdtS3lQQlBDYlc3Umo1WjM1TWttSnZOV0NX?=
 =?utf-8?B?bFdZT2hhaVRqbnFHZVg4U0U3L1hnUU1TZkFNWCswUm9ON25mK2JUa2M1Nzdr?=
 =?utf-8?B?KzZYV0tZUmFoaktsMEZ3Q2Y5R05PeVJwdHNhbTFibEpHaktzZHQ2YlFZWGc1?=
 =?utf-8?B?YUJwcjJkRlJmVmVNTW9TKzVXUVdGM2g1Vm4wdWY3c1BjMnNYRDlJOU93ZGZv?=
 =?utf-8?B?b1lXRzQ2ZVpNcFpHYThSUWVaMU9tTFBwaGZoT0hRSjBGV3FyNUlmUjRiaUhp?=
 =?utf-8?B?akM1eFlxKyt5b0ZnbTRmcmVicWcwNFREaktHbE15MDdLRWtWRWtLZk41a3JB?=
 =?utf-8?B?TGdXQ0l1aExldG1mZ0VCcmFESEw1QUg2Wk5pd1JqS1orQndRTlZmZGJVcnJq?=
 =?utf-8?B?UUJpVWxxeXJ0RjBObk1QUlhERnVJaFBka2Y5Z3FvRC9rT2dxcGtkR0NFUE1G?=
 =?utf-8?B?dXBTd2JXbU41S2UwNEpOaGxsOFBHUHJzNis1dThKeFN6RllLVE5qZmRwR21C?=
 =?utf-8?B?WFAxWGU3ay9YSGIranYwZnAvTGcxSDIwQk9iVGp6THFTTXJxZExhT24wSkNO?=
 =?utf-8?B?YXp2MUd3WTNiamY1OWpwV1VidERMWnE2TC9IOHdhQWFjZE5DdjI1c0UwTHBC?=
 =?utf-8?B?V1NxSWhnT2xtbnRNZDhNYy9Na2xiUTNXMElqa3N1WnA2QTd5Z0VGcTRTY3Q3?=
 =?utf-8?B?QVpueEs1VXl0N1RGaVBCTXh6Ynp0enZJY3lPUTNXV29tYVZGbExQbVEwNVd1?=
 =?utf-8?B?R3pGdlk1UUdGQ2o5Z1orSkVqNW9iODd6UVd2Q2lMRHN0NVhDeC82dWtyTHR5?=
 =?utf-8?B?dVZUWEZlNCtwa2ExdDJuNFlvSnpmSTFKOFRpdUFLbTdZc3owMjFWZ1c3UldT?=
 =?utf-8?B?dGI5b3JKVmNrSUY5NU9hMTIyL3o0anpHSk1ZSHBZWW5MUldMcGUvSW10NzNP?=
 =?utf-8?B?c0NGK294ZWViQmd0WVJtQllIV0NnbDY0aklJODIrVXBUSkVVUUwxeHlYVzVz?=
 =?utf-8?B?dElXYlE4V1hIRzNaOFBuc0x5UjkzU3NzSlpvRHRzNU1mVGg4Ym82R3UyZzhu?=
 =?utf-8?B?R3hzU1M5M0JlRnBoODVwWDVmemI3d3BHSkw2NWFYcWs5RitTYWg3K3JLdUJ1?=
 =?utf-8?B?UzZlV0M4TlFrTHNEayt4TTZLTFB6czN0RmtpZWZyZklMZ2dUL25qTGFnbFhl?=
 =?utf-8?B?ZjREQ2pseGFZUXJxRG9jTUpmdG5NNmVROE91d2gvZlk3UDg0UU9LVCt5MFow?=
 =?utf-8?B?aXJScSthQnJGYWcrYkpoamFqb012TDYvNGc4aHdJdVBBTGhvWEVMZllYbjJR?=
 =?utf-8?B?bE5BSFVqWXhQZU5tcmZWSklKTkRnVHJFbk9GR1crSEdqUGZBK1pFckMyM3pT?=
 =?utf-8?B?NENaaTdNcjZkN2hwakJPQVd4WDU0S0RrK0NucjVJRFJTUHJMUk03RmpTREtW?=
 =?utf-8?B?VWJHcFh2SHRqWWZZQW1IMDFPN3J4VnI2dXRPVkhYYXlFc1duNkdEcExoeXJD?=
 =?utf-8?B?RDFYK0w3UmtieGQ1ckdHbndxbnNXOEZZbWxKaVc3UjI5VmowMEFzQmF5dEg0?=
 =?utf-8?B?dmk1bHNqQW80cTV0eTBZeE1aaUFCUnk4QjBETjBmLzNQL3ZNWHRtWXdNSGtJ?=
 =?utf-8?B?TU05MElNa3JkMUE2Um5pU3oveUZyd3dOVDNxNEkzTEh6NUpaSFZsZXlodytj?=
 =?utf-8?B?OWVhczhQOTFFc2NiN2JTUlVMdGw5N1JOdFFSTmdUVm5Mc0VjQVZqa1ZqWXdJ?=
 =?utf-8?B?ZU5BaUxEcVNQd2xEdG00MXRtc0RCdUJFbTFuK0RPcE5IOHNLeFp2d01iSFpI?=
 =?utf-8?B?UlZHUkR0bjhRUi8vY3pZNEtzY2tzR0JBc1JlM2xhdmNMNmhBNG5ibDAxdEE4?=
 =?utf-8?B?aE1tcDl1b0lnT0svcVZta1JQR0w0VUdqRjBWWGF3WTdOVXJCek0zZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <061CC36C056B494AA2C2992CBB2FA68A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4lyWBB9ifLf3+QEYB448RREKKf/qZyZWk8CCihwrgewjSuzUT+oPGsBGIPrXtazbB+M5doomGZOgCmQFGDuLiHQHj4dxBBDEKF/2IminZjHmnOuvOrHtQVk0NlaFnsMFcNMqe9dPMCKstFY9pBO5Gl9SXY4sQYK+6KJEGPT73Xf3nDW1hRFslCtEO+LvjyyqDbZcNAPdRIuQtiTDsiTXZIOSptyTO2C/GeJ5ZJs3qTYtbxRErrT+LiBgHccgE2TgoNlELiZIZUG1hds8xo1HP541xnuDXhdKtZS9CouXmb9fGHPVBU9EpXrWGrEHWMq86021G/OtppS9OcZSuJLTXg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c519ceb9-0651-45b2-9192-08df2841fd1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 09:19:59.4234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hktu0hA47GxIZAaBpPUPk/4NaGECHhVoVw77qSvkbyEm4LFqNX9kpwLPfwhjzO7tYanuP6jM6jN0DXbbYnwkMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFCD044E159
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

T24gU2F0LCAyMDI2LTEwLTEwIGF0IDEzOjU0ICswMjAwLCBMdWNhIExlb25hcmRvIFNjb3JjaWEg
d3JvdGU6DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+IA0KPiANCj4gVGhlIGhkbWktcGh5IGZvciB0aGUgTWVkaWFUZWsgbXQ4MTY3
IFNvQyBpcyBub3QgY29tcGF0aWJsZSB3aXRoIGFueSBvZg0KPiB0aGUgZXhpc3RpbmcgaGRtaS1w
aHkuIEFkZCBhIHNlcGFyYXRlIGNvbXBhdGlibGUgdG8gZGVzY3JpYmUgaXQuDQoNClJldmlld2Vk
LWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBM
dWNhIExlb25hcmRvIFNjb3JjaWEgPGwuc2NvcmNpYUBnbWFpbC5jb20+DQo+IC0tLQ0KPiANCg0K
