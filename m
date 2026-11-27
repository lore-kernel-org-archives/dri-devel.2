Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99294606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=ZU4ndERl;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=RAun1pq1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 100A611211B;
	Fri, 27 Nov 2026 06:31:19 +0000 (UTC)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34ACE11211B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 06:31:07 +0000 (UTC)
X-UUID: 1cf3f978ea2c11f1a7aecdb2598be72c-20261127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=j55xhhTJBqa1ibQkqYtxJd350NbsozmOdbUKkY3EjGs=; 
 b=ZU4ndERlbE6jtqFhB7DdOFB6rw4k3fazCHESbqYhD+oq0Qqy60BTtNLqQ8K0ZvjKWvpy/wBgFR3I8254ILxIiOq7hoE0YwQUmnhpjjepGC3VSSxbHU8n4D+MOvwhpx27yZ/ZtHOhdDujDGXHEZQr+SZ/kSIYbBytVtV0lrjthyw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:780b9e2a-e82e-46d0-a796-e223d09dc9d1, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:f848db66-4b51-4c95-bb1b-80ac6aad9c96,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
 il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1cf3f978ea2c11f1a7aecdb2598be72c-20261127
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 198402396; Fri, 27 Nov 2026 14:31:01 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 27 Nov 2026 14:30:59 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.56 via Frontend Transport; Fri, 27 Nov 2026 14:30:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kbf3j5vU7mU1u05wiK9bfnpgGeIcamMARQAZi7eb3dm9OfTD7NmR4uC4d1UYmzuxU6mWxuhX+692DNZSNfF5oCaVEEK5fRk2VGC7Hx9ZinDH9x9r13pzckJ8a12zq2RCoLY0vuHHZdYZKdr4y+oBCZmTFN47HLpx8Eqt6lzSo1ZJ7sjTO7SItX3a2oD/U4oRRbqTc1aHxOojl6CY5zZ00qr1DP+OtrrV8h4TdIksd8Lotwd8Yf2waS442n6taWX/l2+xIK2G0f6nLOoanO3Xtzo7p7gmSjEh6x64o4orYUx62p1b81pCigPuTpYfEdn0WnGpdJ6gZpGm+60NZhYDNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j55xhhTJBqa1ibQkqYtxJd350NbsozmOdbUKkY3EjGs=;
 b=NHw4f59DJopxjM31xCWpTBaAE94JQBy+PTrKeuhf17aU00OI/jmxzStVgRvfYuu8jkZ9XppRre/WCnS0DaJytFhiQ2cPdMuYAxAuLFZQ1XSVc6eM5K+HAN4LW3yInakWsby9g7caqw6oboW/OZncdsmaX0zni8eYudkyZ6x8LNzLafXQ8DiDh8yr08OtQ1Z33uG0ZIzw2PoEyfzpehUpDHwS/3X3sixsc5yA+tXrwdyt7+NEudFpJbUA+qBl39XiErUskI2QlPIbFSftrqT8JPvdVhzS6yh5M4xbpXYl2A7mgC3t+NbpiHAk1JXNZA77XxSxuBeZ8E94d9ISRHRgww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j55xhhTJBqa1ibQkqYtxJd350NbsozmOdbUKkY3EjGs=;
 b=RAun1pq1QVYJ7OSz3yepZk7aD9qWqVkQVCTtoUFm2thGVQspcrJt+lHboCMBzgdKH+LHAx7aKTBVcEwEw4c8OyuPyX80du+me5KD8YwrHSytXq5wFWPubQ8QJs8IeSj6Uzryy53E0zIrgGNcl6We2yINP8cCNnD8BuBRdf3aEVQ=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by SEYPR03MB7433.apcprd03.prod.outlook.com with HTTP via P2P;
 Fri, 27 Nov 2026 06:30:55 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 06:30:55 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>, "airlied@gmail.com"
 <airlied@gmail.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "irogers@google.com" <irogers@google.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "llvm@lists.linux.dev"
 <llvm@lists.linux.dev>, "elkin@google.com" <elkin@google.com>
Subject: Re: [PATCH] drm/mediatek: Initialize ret in
 mtk_drm_of_ddp_path_build()
Thread-Topic: [PATCH] drm/mediatek: Initialize ret in
 mtk_drm_of_ddp_path_build()
Thread-Index: AQHdeEj/UmOmh0YwvU+LARc2cjZ/SLdBgSIA
Date: Fri, 27 Nov 2026 06:30:55 +0000
Message-ID: <63e0255e4387c5be78892a0fd73baa53cc90427d.camel@mediatek.com>
References: <20261119171053.1537233-1-irogers@google.com>
In-Reply-To: <20261119171053.1537233-1-irogers@google.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|SEYPR03MB7433:EE_
x-ms-publictraffictype: Email
client-request-id: 6d9e82ce-2b46-42e1-8f8a-6899dfbec193
request-id: 6f672efc-d476-4842-333e-08df4c4ffdc0
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|42112799006|10067099003|11063799006|56012099006|261021121427099003|261009223027099003|261102123227099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: 1jD1Yj8QCinHBB9pS4ygoUFKXeQ5v/q6w08u5MsaF0wQLpulMuzyKNpB8uDKG0QfUxfpZe/mHzHtL4+icUJaG7u/IASa3vNjiG3OnBWYR5iImNG+UgVitaVV4Hj916rsrvlO6nNTLe6HzCQPGN0ZFVT2u8YFU3nYFwS7/QqKE72XC4eHyOBlDSUWNhRPNpfz/s362ttMU7jZfmn044u50VzP08U+jv+rqhdxlDU15HnB2MUaJW5CMQaO5AHjh9Q9Zpd3uzkqRvWACe14bHJHlbCyt2lmDAyVAvQ4szJdTLNsBvFflVzXcv4lQaPiqF0+icU4+F0mLEXqiXiv2r7BYzQyhgmoHwje7kLZlwHfMlVp5mMVdN1OeeAqHGPSlLQeZIp6DgHXPNUCavQVS0oBgnWmesI84UGgjsn7ZULFTJUeBXAgEbtbaS4xhuvHogzFvl2GMwVdJAxn8fve155rAUalSYtbd9UQmdyv0diXcsCzQsP926OfFLPWYTfxZTLaL3xvM40mjLHbyWYxqC8zo7oo7iPw8a4e6tAZcDUajnWF0bA4jhRZ5HFfhe0a3URl+nnEwtPM2sM6l1ZnlUblGie3Zw98DlY5R2yqVhiiIKNE9G3wkL+HmYUCPEXLtvaFQmQRZFs6UC4Evb7bOackrI4A3ELac5/E2Bd7SsM8zxc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(42112799006)(10067099003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHcveHFiY3NsU0xVTlNSVk5zaGFXMGk1Uzcvd1BsMzVMUDJCTTFrUVVQVWZR?=
 =?utf-8?B?cFVnSmNXN3VSZUlLZ2c1Qlg1UCtQb2xXeERYR0prWjBZWUI2ZDdYS3BPVWJX?=
 =?utf-8?B?a1FDMnc5SEtEWUtLMzNYdGU0Y0Y2MjYrR2gvSURjZXg5QXNXcGFBRkMxSEkr?=
 =?utf-8?B?c2l6bjdNTzhpWFV1K1ZmQWVIQTBPd2o3RkZQeUVFTEZHZjRXblpXRTcvbGV1?=
 =?utf-8?B?Zm9wK2RsdW45QWFJUU5FZG5qSlAzTTEyNGF3ZTZkLzJZbXBZTVRqTXRuYzVk?=
 =?utf-8?B?VWlnUjZPSGR6NmZYWVo2ZDU1a3c3Uk1mcTJJSHp0STBwdThlOHZ2Yi9HQUpo?=
 =?utf-8?B?OE5ybHY1RzVZanNucXdDQVFWanZyTXpuMGlTWUxTQTN0bnBMMUhHdlZZWVV3?=
 =?utf-8?B?K0lxblBsUUh5RE5hazl2cTZlczVpSEkyS2p2bHdrNFVjL3A3VnhrUkZnTTFh?=
 =?utf-8?B?RGhtb1ZaMk40cUZPNWFhWnFRRFZQMkFwZ2R3QnZyczVJeHcwbWdKbms0MlE2?=
 =?utf-8?B?ZmRLbWg4TVU2dEdteDdwQVJZMThoTGRnTzJDYzJyU0syclloeTlWVWk1WUlX?=
 =?utf-8?B?b1dqUzVHSWNBWE9GUUJ0dUFidU5ENmxxRkhWZHo0Z2c1MldXOFdKU0hHZVNv?=
 =?utf-8?B?K2Nwdmxub3c1ZndNYXlLRmdocUdxWU1lQ3FxdWgrNXJCRXNQWUhYSzJmcDNl?=
 =?utf-8?B?Q0JEd2FTeUFBckRjRTFocVFPcS95ZllMWHpSaEZPS0tVV20vL1piUm9qNmUv?=
 =?utf-8?B?L0pmK0Z3ZVJvc2JORExjaEpiRnMxZkF2cjZycFlyS2U2a05WdkVmdDEwUVVw?=
 =?utf-8?B?QlFXZXpLUTZFN3VqYi9IVEtCMGhlbHNzd2R4aStEdXMxbXAwQVNUKzMvTXpJ?=
 =?utf-8?B?Q0FhUWROeDJSMHFGOCtwb09Pa3N2THNHdGlDQnhHRGJBZjNkNC9YQ3VqN3Vu?=
 =?utf-8?B?SU8weDl1Q0czc2VBWEZTdFpmMGtoN0s5UzJ1K3FIdjRta25KUzFMVGo0ZU5z?=
 =?utf-8?B?MDg5Z0JiZGFoNy9FcnV1VkxkQWd0ajBpZEZINFBVUTNBSnppcnphOUdFcmhB?=
 =?utf-8?B?V1Npb0d5RUltVGNKYXpSYnFpOTRkUjBiejRRcU5zVEpDRzRNb3RwajNUTUJH?=
 =?utf-8?B?RXpPSUdRUGdDRVpvdDVRaXkxbHhRc3NjbzY4bmlqSUxYQ0g2ZzZRTFRJb1kr?=
 =?utf-8?B?eDJ0RWpNbDNSWlJQZXVkTy9ITUdHZkpPdnNIblZZYTVLUTJoTTRCQXR1UVpQ?=
 =?utf-8?B?bnZlbWNoeXgwTnNYOXZkR3F3dU5hZnhYYk5PUmZFWVBtZ3RVZ0grOEdMNWFK?=
 =?utf-8?B?VXgvNFNwcUtoZURDOUx0ZTdqS04wVEEwV2RWUjRwdW1zVDEyOUZ4RXN2ZEZi?=
 =?utf-8?B?N2Y3QWlpWmJjYW8rS1h0MnRpZUtwQjlRN2VuZnhpa1lyVC9VS0FLY1pTRnJz?=
 =?utf-8?B?ZUYrdExHWmpaa1llNnJ1cU1rdGxaa3cxOVBUdVJPK0J1MUdvMHNmMjJpS21t?=
 =?utf-8?B?NmNYT1RVOUY5TmhSN3RQVzZOOFlvb2Q3eVJ0VExoTDN4dGJrclR5YU9UaGNF?=
 =?utf-8?B?MUNnTklsbko2YVdsQUZ5Y295bHBXdjRHc3REYVYvbm56ZHRRbG9EOVVhYVlC?=
 =?utf-8?B?VHRuN2tKL25vVitjbkRNSGFBNjVJMmkzMXJoaHdjZ3RvaG9GTDlaTTcwUkJ6?=
 =?utf-8?B?VWFRcHdKRkVzTDBaS2lpK0YvN0k2SUFxZ1NWY3lHTytiVFRhVXZ3RWd3bVg4?=
 =?utf-8?B?bElHTjhjakMwSW9UcjliYVA1QUlZYzBVek5UZUcrVEM4UURaMFFRUVkzR3JN?=
 =?utf-8?B?dU5tWGpDSGd1M2xuTVNpQmpaY1ZhRmZSL3FNclUzK1V1Y2hLTHJ1M25TYzY0?=
 =?utf-8?B?VTdIWTV6cHNsdStRQWI2UHNlcXU5MFBMVzJlYTVseklWcHBDS01XSWFZanpD?=
 =?utf-8?B?Q2c1UzEzTlYyOWNwRlhacnpreUdaVnRZbi9qT1JxaFUxaVNlTWtoOGFWMkkr?=
 =?utf-8?B?TWZjbzZJVFR1SGx2dEdvUUdJRlJwL1pIc09NOWs4L0FRZDNRWW9xWUVNbVRV?=
 =?utf-8?B?ekFJaU1HVTVsZkR5bzkrNjhxS1BZc0pTcFBaY2puM1VzMGxBL0k3clFWajdY?=
 =?utf-8?B?R3RsUEgxK1hGbElkQldIbVVZOFFMbk5XV1lQY1lySU40REN0Y2dQNkV2NHM5?=
 =?utf-8?B?M2FRRzZxQWxBRWdZaTA2V25HV3hocUxrSmdaVXN3ZGZhLytnTmx6SXRTR3BO?=
 =?utf-8?B?MzNHelI2NE50dXlpNEJBVFRuNVpxWHUyUC8zcDFzT2ZKNFovRUNHNFFSbHE4?=
 =?utf-8?B?RFE3N3ZiNzhSSzZEQW1BbnRGaW1PUEJidUt0YkFPMHNuTXhJTjNydz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <319295953575A64CB3883B8AFF367358@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iOepXTpdWBdX1clBvKg9pkq3FsKEX1Mz/GMYk0ZppYv6+vADmcjqvSZJPAeab+1cD6zrXu1+3ooTAtcUs+7zGHYUN7Ckp7zYeOUl4UJRoDTxVsU8PvO5jtuedJ+NzgBbYGLR4FK7vt9Cofw+sK5yeFsT0VsCZa3Ylhcem5OvEMPOJpX4GzLvTauL1TyczouAzuTYcxYnnpaBHAwTxrV9vR5Qln3XXVeImGTAyNvWCnNP3kxAefSFTmACmakUjiPllMrSNuKMRqSa93WBMgjozucxORn5EdaO/oF9AqNyYV2KwX3vnkxWDdGLRsuWaFC4dNNeZbfehBMhrUC8Qc/a9Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f672efc-d476-4842-333e-08df4c4ffdc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 06:30:55.2839 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZrPZJ1VW+w3KpQLQfqyCnwXbIvjfZ4KSCpggSnqMqZ0KROtqMzpi+pFxJ2KRnIhF4MfR/uLJnbKlJxi5yU98A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7433
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

T24gVGh1LCAyMDI2LTExLTE5IGF0IDA5OjEwIC0wODAwLCBJYW4gUm9nZXJzIHdyb3RlOg0KPiBv
Zl9ncmFwaF9pc19wcmVzZW50KCkgcmV0dXJucyB0cnVlIHdoZW4gYSBwb3J0IG9yIHBvcnRzIG5v
ZGUgZXhpc3RzIGluDQo+IERldmljZSBUcmVlIGV2ZW4gaWYgaXQgaGFzIHplcm8gZW5hYmxlZCBl
bmRwb2ludCBjaGlsZHJlbi4gSW4gdGhhdA0KPiBjYXNlLCBmb3JfZWFjaF9lbmRwb2ludF9vZl9u
b2RlKCkgaW4gbXRrX2RybV9vZl9kZHBfcGF0aF9idWlsZCgpDQo+IGV4ZWN1dGVzIHplcm8gaXRl
cmF0aW9ucyBhbmQgJ2lmIChyZXQpJyBldmFsdWF0ZXMgYW4gdW5pbml0aWFsaXplZA0KPiBzdGFj
ayB2YXJpYWJsZSwgYWJvcnRpbmcgcHJvYmUgd2l0aCBzdGFjayBnYXJiYWdlLg0KPiANCj4gSW5p
dGlhbGl6ZSByZXQgdG8gMC4NCj4gDQo+IEZvdW5kIHZpYSBDbGFuZyAtV2NvbmRpdGlvbmFsLXVu
aW5pdGlhbGl6ZWQgb24gYW4geDg2XzY0IGFsbHllc2NvbmZpZw0KPiBidWlsZC4gVmVyaWZpZWQg
YnkgYnVpbGRpbmcgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2Lm8NCj4gd2l0
aCBMTFZNPTEgVz0xICgtV2Vycm9yKSBhbmQgLVdjb25kaXRpb25hbC11bmluaXRpYWxpemVkOyBu
b3QNCj4gcnVudGltZS10ZXN0ZWQgb24gTWVkaWFUZWsgU29DIGhhcmR3YXJlLg0KDQpSZXZpZXdl
ZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gRml4ZXM6IDRjOTMyODQw
ZGIxZCAoImRybS9tZWRpYXRlazogSW1wbGVtZW50IE9GIGdyYXBocyBzdXBwb3J0IGZvciBkaXNw
bGF5IHBhdGhzIikNCj4gU2lnbmVkLW9mZi1ieTogSWFuIFJvZ2VycyA8aXJvZ2Vyc0Bnb29nbGUu
Y29tPg0KPiAtLS0NCg0K
