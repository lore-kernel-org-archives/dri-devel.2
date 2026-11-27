Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204CE606A324
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=nEr6J83C;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=LrSZxyAr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A71410E9D6;
	Fri, 27 Nov 2026 09:29:58 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A888B10E9D6
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:29:46 +0000 (UTC)
X-UUID: 127aa5a0ea4511f1b9cf3d4034dccee2-20261127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=o6QoRERfcHAdwtcZuoiolqsoLZy1yMakac8xdw8vqa0=; 
 b=nEr6J83CcyIjdGvkB0hsXP6Knkrjadw6VLI0UFZzXM8nbR17yIehRMXvdywx9ZK/bXQpNvr5Cf2bZw437h4yIp/6v4e4G83Le8VNBvYRNF8MQ867h9DNh8wl5PjhKM4snoq/fh3gHsx0tY3JNPU0HkAsXpMdMI5TrbkC3U+sloE=;
X-CID-CACHE: Type:Local,Time:202611271729+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:5bcbf686-0e1d-4dd5-83ba-f542ceb293e5, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:c2e4231a-ae4c-4a2b-b1c4-72e411efd0c9,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|136|836|865|888|898,TC
 :-5,Content:0|15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:
 nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
 C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 127aa5a0ea4511f1b9cf3d4034dccee2-20261127
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 845425232; Fri, 27 Nov 2026 17:29:40 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 27 Nov 2026 17:29:39 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.56 via Frontend Transport; Fri, 27 Nov 2026 17:29:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EY349JrRs+jHRCMBQaXUXhfLVC4nWrAnlC2sd7OScaoY0kTvbFqq99wwm9hQk6e943Dmz7eDVUBbphPw0pBq0rNFZYzW4xS/tHXj2Hxtc24G9SnZt7LJxMVgLYL2WN8kW1ECZMdQOuAH7ucMpEMEqrQFsasatZZ8wuSCKE6cFSrdQAf4ohRh9gwiWZ3sywvMQXAfPfydz+HmaDTFtBScQMgSMpdgwjyWxSdX0Kx379r7cTCcXQON1Zy8doeNyBJIVzEO6DfuSTVJalaaptvjigCBB+1lbI2bXEyDce9D7m2Wscl/+M1Ar3ULHUy4FJgERWaizpT3QYM4FqXXy3IrAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6QoRERfcHAdwtcZuoiolqsoLZy1yMakac8xdw8vqa0=;
 b=s/cZvIUIKzsRWU4CSuwkltx/POKsmgbkCZSVNfhVsqafNZ+PCZ1I5MVQtGNBvpb0oag5MZqEPOuiD3JNz/QTIthsk9bivPVDZKinNPKMc4e7gdKioaK8X2DqPhnbJMh+c+FMFLlDKwiUSLrQy0tUuEsPNvZ/unbOEKr3HYqp46AWUAe/B/Rij/SJajf3/DnQn/PL1AvZv2eUof6NZSjQmk8N0ocKgW/alyIuEJgqLezRss63YB+T+FiXaDKbVv24mOiOqb4AYHD1Zk1P9Q/kjBr3cQhRwHXBz924k3dlzTxHChW4ra/5z/KvW+3rh+jZsb3zMd/cbPPjYUGd9hPk0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6QoRERfcHAdwtcZuoiolqsoLZy1yMakac8xdw8vqa0=;
 b=LrSZxyArb/LhapzojPL9zcNLW8ZwwLa3DHvaly+UQMEQGJsVzfUOzKZYz5WksgLYlqipEI9TjHt8y4NqddrScHpFuGNPk40nzHlUhpSs4aqLOkdeEe7PoDhcA+9FASMtg9bKQz5vWZZxohse+CA6i2cZSc/b5beYg0HC9AEYLa8=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by SE3PR03MB10461.apcprd03.prod.outlook.com with HTTP via P2P;
 Fri, 27 Nov 2026 09:29:37 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 09:29:36 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "iasnezhkov@gmail.com"
 <iasnezhkov@gmail.com>, "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "simona@ffwll.ch" <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "airlied@gmail.com"
 <airlied@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>, "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] drm/mediatek: dsi: return tx_len for write transfers in
 mtk_dsi_host_transfer()
Thread-Topic: [PATCH] drm/mediatek: dsi: return tx_len for write transfers in
 mtk_dsi_host_transfer()
Thread-Index: AQHdfT3HbPUaYTlYTkSP7frD3qtkO7dBqSWA
Date: Fri, 27 Nov 2026 09:29:36 +0000
Message-ID: <b14890fcde4432e9eb81887166f76df65012ab9a.camel@mediatek.com>
References: <20261126003311.49008-1-iasnezhkov@gmail.com>
In-Reply-To: <20261126003311.49008-1-iasnezhkov@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|SE3PR03MB10461:EE_
x-ms-publictraffictype: Email
client-request-id: c8a13b73-0d14-4c95-b437-cbeb8a28bb2f
request-id: 0ed3e712-2acd-4814-8e41-08df4c68f444
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|366016|376014|7416014|1800799024|6133799003|261009223027099003|22082099003|18002099003|10067099003|11063799006|5023799004|56012099006|261102123227099003|261026121527099003|261028144727099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003;
x-microsoft-antispam-message-info: EpTfJQZiOHMTDz11cxFgITlCPTMjv5gmn6ksI25vmNTFGKi9sqQ3mGLCdlaw7fSxAiLrB8+1uJt+FQcHNY0CNmHfnpFmg7hehno9tAJP1C5Bj4KVOLFJfh4JmFV3lTdnxBnQQZw1Fh4i34lbmduwlFrz5LRdaxt5D+2U+XmVAb8JaQl84m61m+AeWo8csX0aDe3FkMMGJfA8YWQLB49WzzGLY3ywKw7vlUaZC7uyv5yhC8LF4gbCmg41xQXMHxYTakDhHEZafKGBNJG9c6PUaV5WDPO08CNTxkaBIZVxe18b2CwkAcwJZ4gV0B47i01HLoo7u9FUVZdYDIViCtBC2088xO50+WGqH73I8vwsgogFC6kUAQqmE309RPmfp09x6SrenROVfFu4ndjsOBPjmKlCUPwB7k4MMSfRY2tECNpmDy7aWGZilCYtG6LKwm3QIc1ETwMS+hRm8/w5aJ3O7fexMbHZZDuQ8x3PRfCkrH/R6g22VbPBxlGf4ydtenVxI0md7ERkRm6sAJo3mhaLjQXt19P9rvLVMR+1w6QSgFiqdZmQKs/SPlsmzl8DMWmfn2wvSvqB93HfWCtSQgmCHQdeufL7LLulbD3cUZyu9RfO2TCCBpTtI7IU8t1i7yhZU6PU5/B5+IqxTCbAmOFHAqLY6Nf/Vi3Yz316igz0V1g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(366016)(376014)(7416014)(1800799024)(6133799003)(261009223027099003)(22082099003)(18002099003)(10067099003)(11063799006)(5023799004)(56012099006)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWtMWThWT2JmUzJKdWdIemkvVEliYnh6VnVZS3RtTHByaXRlSEQyRWEzeFRp?=
 =?utf-8?B?VnppRHdEb1JNSTQyZjJIdmp2bGQ3RFI1cVF0NUJ1bUdxTUxhVnJxYjY2c3NK?=
 =?utf-8?B?R2VWcFNlV1g0U3k2b1g5d0Q1UVNjaC83Z0lXZ01CVXMrZUpENmREb3ZkbThO?=
 =?utf-8?B?c2ZYY2RGWEtXL3FTc2NLNUNYcFFCWTFIaUpJeGltSS9VZFJNZWdXNXYzd21U?=
 =?utf-8?B?T1dscGJtOXVndi80WDVYaHRtUjF6MS9sN2wzMHdTc21acTUwNWFpREdjWVdI?=
 =?utf-8?B?d001aWJiM2M1QUhINHJaMVoxS1IwSHJGVDVwUVhCVEM1S296MFE5UFRVM1Bj?=
 =?utf-8?B?R2pmVVlpd2hjYnpsRDVpWVV5NzdwRmtXem1xWmo1cmxZVFdjODJPa3NoZ0JH?=
 =?utf-8?B?MzlibEdDcHEvM3huTzZNU3RqRjJCNXVjZCtVRWZBbFV4bGhpT3ppZUZpUndC?=
 =?utf-8?B?Ni9HUmJwb0EvT1VoWEg0Q1FEc2RDNXExSXo2S1gxZkdGVnhSdnVtYzBVWlBn?=
 =?utf-8?B?cGc0bmovQWc5VEZKZTF2QlU3b3BYbnh2Q2h1bDh0SnZ6VXlkNENyN09lOXRz?=
 =?utf-8?B?Z2FyaWxBL1Q2a0ptMTdIZ0IvUjFHUGhPYTF2eVhKY3lacWpTd01SeCtVczh0?=
 =?utf-8?B?MnJUNWgvR2RnSjdpR0h5SWNGNmkwbS9BRS9ldVpNcTRCVU5lN094Ry9vSUVp?=
 =?utf-8?B?OWFHTy9RV3RjY3hPZUhWbnZuQ1ovT3o0djJRZTFuQTJ3eThsVW5iaFZFdjRH?=
 =?utf-8?B?NHZ2aG5aTm1LamxwMEpWRWxJOThvWkh4eVVGNkNLU0Q1SndLVEtaVDYvODZJ?=
 =?utf-8?B?Umh0UjlvQlFaajUrTnMrQjN0Uk5VTkVTemJZcUI4SmlNZUxzeG4vV0NMWWJ4?=
 =?utf-8?B?ZGNOOFp3dUx5QUQxUjdGMEQxekNOOHpoazR6VVVXbDA4VVpSeU1ZZDYwNGg1?=
 =?utf-8?B?WnVwNW5QaG4vdjZST0NpdGFaaGt0OENOdTEwbG9kbzY0WVNkWVhNbGhJUEhi?=
 =?utf-8?B?NGl3WG9VaGxoZW5ra0pEekp4bll1dk10ek9ndUNFOUordHV2d0h3eE05MUlp?=
 =?utf-8?B?RnJsQ21UeUpRNFZuT0ZwQnVmV0Y2RHZUSEwwZWl3amhaRUUzaTdQbFNQaFl6?=
 =?utf-8?B?UHl6L3pTanR5TjJYMUg2bTJiQ1VVa1h0VlVLSjRBTkZ5VzNXSXJDaVM2ZDlw?=
 =?utf-8?B?T0NzNmNJWEwrMnovVG50cTBpbmdvNUZ5aEFBRGVuZHRXOXgwc0J4MllrVWc3?=
 =?utf-8?B?ODJ0NXVYakxOTEprcmZQSVh0TUhOWWh1L01oNFRWenlvSzdOL1I2K1pPTGhp?=
 =?utf-8?B?S0lnZEwvRHR6dGxOQ05FUU9kSVpDQlAycllTTm9zTDY1V1NiWG0xR3NKaWhP?=
 =?utf-8?B?UEtZcU5PaHA0cmtDanY5V2dJR3RpZnJWY0NDbmZMR3NXVUprWGRJdEMyaWhk?=
 =?utf-8?B?cEMvanBmUktVNWcxVkZ1YXd6T0RiWUdlcGQ0OVU2UkVxWjYvUitidCtBdFQv?=
 =?utf-8?B?MWJ0YkN0T21XWmh3N2V5TUVqODA0Z3k0SkVuNGhXU3JzUmxUb05EbDVIenRC?=
 =?utf-8?B?QlRCSlkydlZJSmRDUUFxR0haWlFtZlFWQ1owa3pqOVc2VlcwRjFTSkJ0QWpn?=
 =?utf-8?B?cjMweTJDbGtNaEJCN0twWHd3SzAwd2dGZ1VYbnl4eGJKZEZ3elA4ZE56OU5j?=
 =?utf-8?B?OTdtVFFyTUw0Tk5ra2RxdzkxVy9SNVMrcXR2akovVEZQWE0wdDhLcGZwS0pt?=
 =?utf-8?B?YksrMlMwdkx4emUyWElhTFE0M0xRTVF0c2xFSzFTS1dKSkYvOHVrUURFbFhv?=
 =?utf-8?B?ODdDL0UwYWNSQmdzdEdENGxLRlJrYnNtWFpXOFVYbTlkREtTQlZsLzlEUHhG?=
 =?utf-8?B?MUh3aDg2dHh1VVpoOXJQcHZQcHBjOEhUci9VVlMwV2hsb0hjMkl6dlFucllN?=
 =?utf-8?B?bjUwQ2ZXSHB2UVYyWE5xTTF2R0JiWmpxVjZjb1FZZGw5dmlVQUYweEJPWnNJ?=
 =?utf-8?B?M3RkMDgzcFdpNjJ2R2hiWjB1OStnRWJXVlEwd1RmL3luWGhHSXJGK0dycHFx?=
 =?utf-8?B?eWlsUFZYMXFJMnJwRndvdTA4NFkySE85MTFLUnpsMGI0YUNIc1U5WHlNRThT?=
 =?utf-8?B?bEYwdEpxRm5WV1VZV3RSeTRHL1ZEZ2VyMWlKcUJsNzF3Z1NyQ1RqcmFxczBt?=
 =?utf-8?B?L3VGak1KOXVFMzVwVWFCODJIQUJMVGgwZkhaY1RkNjNZZnh2YW52cUx0VjUr?=
 =?utf-8?B?eExRMDhtMms3MENzeVEzcW40YmFRQTRMamptaWI5VHY1VU00U3FtQ1dFT2JL?=
 =?utf-8?B?eXNzK1k1K1BFMmRZbTJXRElEYTVHWU0zaHJUODg1WWRZZmNYZ2g2UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85E365AB3029A24E9D3E803A5A9FA1C1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EV/h+LRkLbVem+BwXMn47R2ltu8Lm+7scUDT9IBSNFRCS+Er7TM/qfwpcVL0IkSBsa3TJ9oINf844VZClhxU7dXD/Qo5TGnzOLffIfTo8GFLa0YATN08tttDKMNf22cL9jXvoOHgHquzWBEpcG09KA1lrWkO5uLQ6mf6hAr21vW30mwDEgal6lh/X/1u3Cp94HOSZOQgggFbTP7ynEHTz1VjBWkn0OzMGAUvXmUqPMpbxbLLb2DP0VI0FqOmWcsEn855mxlpwUEajiXMDLKZWL76s+FcaWkydAPGwzZorbAAD5Ij1joZbYxEm0GzBirhbvlHB23xpXTAqoW3iKQPyQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed3e712-2acd-4814-8e41-08df4c68f444
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 09:29:36.7499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z4ACcFGjwrJhRVco0Vvzm4R7SXNg3/gaoEHtVpzBdo/UqwHrqlqMZZkVi4W8J4Tc06SfHaThwGHHUw7OXV7xfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR03MB10461
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

T24gVGh1LCAyMDI2LTExLTI2IGF0IDAwOjMzICswMDAwLCBJbGlhIFNuZXpoa292IHZpYSBCNCBS
ZWxheSB3cm90ZToNCj4gRnJvbTogSWxpYSBTbmV6aGtvdiA8aWFzbmV6aGtvdkBnbWFpbC5jb20+
DQo+IA0KPiBQZXIgc3RydWN0IG1pcGlfZHNpX2hvc3Rfb3BzIC50cmFuc2ZlcigpIGRvY3VtZW50
YXRpb24gaW4NCj4gaW5jbHVkZS9kcm0vZHJtX21pcGlfZHNpLmgsIG9uIHN1Y2Nlc3MgLnRyYW5z
ZmVyKCkgbXVzdCByZXR1cm4gdGhlDQo+IG51bWJlciBvZiBieXRlcyB0cmFuc21pdHRlZCBmb3Ig
d3JpdGUgcGFja2V0cyBvciB0aGUgbnVtYmVyIG9mIGJ5dGVzDQo+IHJlY2VpdmVkIGZvciByZWFk
IHBhY2tldHMuDQo+IA0KPiBtdGtfZHNpX2hvc3RfdHJhbnNmZXIoKSBjdXJyZW50bHkgc2V0cyBy
ZWN2X2NudCA9IDAgZm9yIG5vbi1yZWFkDQo+IG1lc3NhZ2VzLCByZXR1cm5pbmcgMCBpbnN0ZWFk
IG9mIG1zZy0+dHhfbGVuLiBDYWxsZXJzIGNoZWNraW5nIGZvciBzaG9ydA0KPiB3cml0ZXMgYWdh
aW5zdCBtc2ctPnR4X2xlbiBvYnNlcnZlIGEgc3B1cmlvdXMgMC1ieXRlIHRyYW5zZmVyLg0KPiAN
Cj4gUmV0dXJuIG1zZy0+dHhfbGVuIG9uIHN1Y2Nlc3NmdWwgd3JpdGUgdHJhbnNmZXJzLg0KPiAN
Cj4gRm91bmQgYW5kIGRyYWZ0ZWQgd2l0aCBhbiBBSSBjb2RpbmcgYXNzaXN0YW50Lg0KDQpSZXZp
ZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gRml4ZXM6IDIxODk4
ODE2ODMxZiAoImRybS9tZWRpYXRlazogYWRkIGRzaSB0cmFuc2ZlciBmdW5jdGlvbiIpDQo+IFNp
Z25lZC1vZmYtYnk6IElsaWEgU25lemhrb3YgPGlhc25lemhrb3ZAZ21haWwuY29tPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMgfCAyICstDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jIGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kc2kuYw0KPiBpbmRleCBmODI1MDZlLi5lMjE3OWI0IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCj4gQEAgLTExNTYsNyArMTE1Niw3IEBAIHN0YXRpYyBz
c2l6ZV90IG10a19kc2lfaG9zdF90cmFuc2ZlcihzdHJ1Y3QgbWlwaV9kc2lfaG9zdCAqaG9zdCwN
Cj4gIAkJZ290byByZXN0b3JlX2RzaV9tb2RlOw0KPiAgDQo+ICAJaWYgKCFNVEtfRFNJX0hPU1Rf
SVNfUkVBRChtc2ctPnR5cGUpKSB7DQo+IC0JCXJlY3ZfY250ID0gMDsNCj4gKwkJcmVjdl9jbnQg
PSBtc2ctPnR4X2xlbjsNCj4gIAkJZ290byByZXN0b3JlX2RzaV9tb2RlOw0KPiAgCX0NCj4gIA0K
DQo=
