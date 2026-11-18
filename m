Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DB5606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 03:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=c6Q0cWPi;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=rhyk1Moa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75DB510E086;
	Wed, 18 Nov 2026 03:06:36 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD9C010E086
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 03:06:24 +0000 (UTC)
X-UUID: 06b93578e2fd11f1b1788b6acf885367-20261118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=Tz5JIJ+Ebazhu2/zVFzTkwHTwq9SKzirPCktIJqP2S0=; 
 b=c6Q0cWPiv1p7zcvfypxaM1ySFAEZGx4sIT33Lw/EygNTuKjnLfsto9HUnc8S6RfgHZFPUDapLa4DTsYYuM9Yir/qdmeBR/nRRVKggJC1Of74CMO/Tb2HCBrTXRQvwrD4xC4QOI5mORUJU9gDUG0mU6Oyqk7NtqVsrdub9xYJPqY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:179a4bc8-c093-4c58-bd6f-309e46c4980b, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:4f22903e-3f0c-4ece-acc2-25cbb05a5e6c,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
 il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 06b93578e2fd11f1b1788b6acf885367-20261118
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 738990659; Wed, 18 Nov 2026 11:06:19 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 18 Nov 2026 11:06:18 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 18 Nov 2026 11:06:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNzvcSQsoi3vWKzcMBr839mWkyJfMxUK1TcKE+QfqAk1hPnmqyYutSwC3uscbS6LikrL1UBXirtWZXqEmY30ffUUyUEF8u+rYnt3nrMWnNrxJW0b1QB9vAAru19TbHEgEpebiDbQPEBeQf3FWOURBsQ8LGMjOJRSC6N98KwJfp5HbmQQiBjY40nRFnVV8MMYUpR+eXhxPDQuPAp8bjR1GRZbRAOVXojj1UP1PFuprWWY6YdPA43o7XfRLNJZTa4HGdIN1TAZqYXQhMYtC2V9N5SCWQx1iPukIuz8YfC+gDxutwRc14aoyAAtPuDToGPHJG3UkjTEzg6C1OiVC0uHXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tz5JIJ+Ebazhu2/zVFzTkwHTwq9SKzirPCktIJqP2S0=;
 b=DM1LgybV+Payv7lPEMP3lcZBnDWSZgNnWbQ0rtblL9ZIMY7711Io2/GVlXuA4roXh5S6chKS+zZJbJ9Kz5H+vWgf/YQG8NCSxVNoce3Ek2iu8+VaotcYXP6YZhiptGaL1VRZWcyLF/MhHVJSUyWzjgqHGdmHxT/a2rw9Cr+T7eWiCf/N6wj/XP5iAUbdzHuUtfsNa5QHZR8WJz15xRpI+jmHqQVUX81j3EfA1Fg8fqBgIL0Z/OW8FxGK6288PQkU+XFABO+zAuMvtBO1JeVl9JiRxt1KOCAyMPLQQ0dHMQY6C38+ghzkhasm7Q1MhFj+LS/sp4LdlMAyKobseGDQnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tz5JIJ+Ebazhu2/zVFzTkwHTwq9SKzirPCktIJqP2S0=;
 b=rhyk1Moa3xASAnmKmjjEzyVmKYr5XAf7zne/n1sd6qE7q60NEHH84W5pwQnqoM83JHoK/9NuSft9PQZO+uGvkNUYs/TPDmkM+5TQMkCLVl7WHq3ALmfnlThDZNMYig/G3a7rciQuyrVoEVm/dMhhz7MtZaHIvphqW73MhIrdzGY=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by KUXPR03MB9438.apcprd03.prod.outlook.com (2603:1096:d10:4d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 03:06:14 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 03:06:14 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "yidilin@google.com"
 <yidilin@google.com>
CC: "simona@ffwll.ch" <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] drm/mediatek: dp: Wait for the complete AUX reply before
 reading it
Thread-Topic: [PATCH] drm/mediatek: dp: Wait for the complete AUX reply before
 reading it
Thread-Index: AQHdcm2XAgCHNjmz30S34phUZXTZSbczLq6A
Date: Wed, 18 Nov 2026 03:06:14 +0000
Message-ID: <0964123eb95cd4a6516df05003f59f3cdb260d00.camel@mediatek.com>
References: <20261112061736.4014993-1-yidilin@google.com>
In-Reply-To: <20261112061736.4014993-1-yidilin@google.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|KUXPR03MB9438:EE_
x-ms-office365-filtering-correlation-id: e798a30a-c989-4ad1-59a9-08df4520e80b
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|376014|7416014|23010399003|366016|18002099003|22082099003|261009223027099003|3023799007|11063799006|56012099006|261102123227099003|261028144727099003|10067099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|261021123027099003|5023799004|38070700021;
x-microsoft-antispam-message-info: U45oJ5psQfKfstBZzSPXx9oZmztR9buCKKy3qN6Q/nm54Kdb9puoXIo79JNLapmn5FV0C6tb8Mbw/PSoY+NlrkK6kXcEOvLQDwx/2A8Ap8MF74yVEhDjWKjk9Fcsw/4n1qlF7CdGrzuCzBx77klL8y7rpdKJTWuSexdaW07piOtVFiB8dgD7JcZ+e92TwRBJontXrPn+isR1jgupt1Uhppw2JRKu36j7OmPn1hvm3Yj51gzuKsIUp7DAQ6kgtV1ms8CUIflBKrfq6DDtb5QPNDfA1jtmIvZgycy3bQFGHeUB1VMXcxWN5UiIPz2Wby8R6g5YMLh/mWBkfdlKXLT8eQSep363XPxcJ9rESCZ43l5S6mDDM4i00kBXdSgK8diJHCtz/+TOcRZg+LCRLZjncfT4uCzDPx4CmHgr+7K2W5CmBGhF8i1zqosFL5VE7gfuZTmdPjI5nfusnWzATgzrsfjjI2jk3d1Rvm+X4S09ar7+gb8GVX58hwnX5PBCiNo3vk96UqvmdzpxDjjMA7sZzyykQc3H41XMKs+QuwX4Pe6wBo5TW7Nnx28mkNztOVVoCG6sP+7H7ILbRT2VVUQeqQRf5eFBZi8MMB5bIDe5p4bM0Et7j6J/z5zBr+VflLJiy5puCZ0BfzuXI8fveLBDtPAZ7++sQJYRwU2lTaeGxKwgzhfP5JlhCJ5QcsjE792XyXpT5Nt5Y7K0aThe54j3RxjC8WXLDZYt0KoR+EB4XCc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(376014)(7416014)(23010399003)(366016)(18002099003)(22082099003)(261009223027099003)(3023799007)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(10067099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(261021123027099003)(5023799004)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGF5TEFUUTcySlJIVU5nZzFtWTFqWmJOTTVFbE52dXFIWUQvNmFaalV3b3ZY?=
 =?utf-8?B?OTc0R3JaMlkxVVdyTlROOFhYVENTY1pmTkhDMHlSUG9GOTQzSUs3cEh1djJD?=
 =?utf-8?B?L292bU1YeHZVcHB5b3JrTEx4TVVjWEl0K3pIWDJaYmlvTXF3dDg0dnowZ1pZ?=
 =?utf-8?B?QVIxOHpzY1R2R3kyVmxuZ0tKeHBSMFhMZlZEOG9qYlgxR0FXZ2xGdS9oN09E?=
 =?utf-8?B?TjdlV3dnWVMrbmVRcG5pUE1CZ1NNQ2hBZ0VjL2M0cVJHVThzRldsbllZVHBy?=
 =?utf-8?B?REVIQ0xiMlNuMzN5RTFiajQ4VWZrOU5mVVZSNno5VGlCVlpKSTQ4S2tZL1NO?=
 =?utf-8?B?VFY4bkJuNlA0MjNENlRsNTJyWDRYdHR2TlMxZElNbC9oMmJ6cDk4dTVhWW85?=
 =?utf-8?B?OWFNU3hsMGlSL04xZ3Flc1JKUE1PVjBEWVhQTjYySHZtSzY4WDdiNlFYYzA2?=
 =?utf-8?B?YXFCN3JHVUovSmFKc1NqNjQxaVN3OGRTQ3VCVEJObVV5RUp5VnBsVStqNWcr?=
 =?utf-8?B?MWVCbUdvZkNJQVR5M1JlK1F6a3BOcFNpQ2JVV0F6MGx6UVFSOWtSeGRMVjFV?=
 =?utf-8?B?RUNtNjBYanJYSmJ1MU8xL1U4K1JJc1JhSXFESURhclRZWVlLREJWeDZQODMz?=
 =?utf-8?B?YXJ2VFFWSVR0WlNxa0hQaExkMC9qbS9UMmF5MDVDWWEveUpVUlgrY0I0eStH?=
 =?utf-8?B?TjRBQlhERVU5dTRUUWZvSUt2akFvcmxwOTZQd3FZT284ZlFzWG1GNlVaZjFh?=
 =?utf-8?B?dVJFcmlHV1hCQk5aT2ZNMFpLKzVXa0M4dlBjRkY2TGpYVFNFSEw0U1hwMWt0?=
 =?utf-8?B?eTB0Z05DVVVLZVlGejY0Um5lOTVSNVNWZDRXd2REblpsQURDZEZKSVNMZWpI?=
 =?utf-8?B?bG5qSTk3Q2pzNlFkeGI1Tk11VkZ5cHJ0dlYwQnZ6YnpaM0hmS21ZNWhUakEw?=
 =?utf-8?B?elRIZjNidWNYU2lmalV3R1MrNVZ2dmhUc0VwQ2NobWRvRk54UU80Zk1BUm5s?=
 =?utf-8?B?TkF0KzZUVVBGcTZOdnVRWDNZY3VsdEN3VWdOci9wRUJWajhUUlZWdXoyeU1M?=
 =?utf-8?B?WGNCK29KM09pVFlUbER6VEJVUFFBUTFwNFVoRTRrNjVlWjgxOGFjdGNCdjNO?=
 =?utf-8?B?YmZqemZBK243RXdQbmIxQW9ORTFGSWVXa3dpZnRtMWJVUm1TRjNEdUVlMXRp?=
 =?utf-8?B?NG52ZGtpeVRBcWxjbU9PQnVqbVNwaDNmM0V1R3NxSWRBeEdmcXpXSXNKc0xO?=
 =?utf-8?B?Qy9BcVFKR1JPNzFwREx0TEhtR3dDSE1FZ2tVVDdhekljbzR4TENGVWtwRVNJ?=
 =?utf-8?B?ZUVoTWJEYnJCdklablhncEUxWU83RXEwVWpWa2FQTmhUU0VoK3ZUcGpWd1JQ?=
 =?utf-8?B?VGVNQ0tTdzA1Vi9PTm1NQlBrOTNNWTZFeVZ0ZGZ2TkM3MEZxREd2eElpNnFX?=
 =?utf-8?B?QnViOHN4eitrVTdlaWk2TU45ZFZCaytRb1hzVzhVb2NDTUdMZzFHcVpkSGR5?=
 =?utf-8?B?MSs0bzhlUkZFWGRPQktIM0RRRUtMajhDMERSdWZFNzRyZ21JUTk2dnZjN1Rv?=
 =?utf-8?B?a01Cc2I3dFo1Ly96S2kzM1cySmZHd09MQnpPbnBZeThXMXhZZHhKZE5iNHVN?=
 =?utf-8?B?NGllT00vRDEyM1RETXR1aXZLNnplZkswRDVvWWpIT0ltT3JzeS9TUHdXdytj?=
 =?utf-8?B?TGt5S1VoTTdNNURkS0I5b0xRUmlvZGdPWS9taWhxMlhkMEkydjJDb0w5WUgy?=
 =?utf-8?B?R1VmbE51OWhjdUhkcnJta1l2SXE5cUQ5VUpGR2dwMXdjYzVKWHBDM3lRNXlx?=
 =?utf-8?B?aGw4dVJHWFhNbkozeFNjT0FKNGV4emROV01nLytqTHczaEVjUnVyUEg0cVFS?=
 =?utf-8?B?QkVVSVZteXpRN3VrRTladE0wWnFtaDF3c1JzS0JoSmxYNTlhQ29qVkR0R0ZE?=
 =?utf-8?B?WWRlVHVvWU1Ec3hTN0kzUTROQU9TejBManBsT29LdHVPUEg5TWZXQ3hpSFpU?=
 =?utf-8?B?MlBVMWJrVHdWRWZoNFZqTWFqbE00MXM0SFRzYm1FajBvNS9pSENHR04rTzV6?=
 =?utf-8?B?dGNvTk5UK1FydkY2WGJveEkrTENza0IxVXovNFJkcXg5cCtTZC9BbU5wcS9L?=
 =?utf-8?B?Rzlhc1F1Y3ExZGFBeDJBOUhqSnZhWnpXcGtHL1lWdkJyd2pVRGxmenB6YTE5?=
 =?utf-8?B?bVdKTHM4eWIvME1UanNrRkVpYm5mOEN6bFlnVXY1VFpvM21FSFE0QnVqUkhw?=
 =?utf-8?B?MWxzMXdrM0Z6QmsxL09VbXB0TCswaTZ1bzZjWDF1eGlZUW9BZ3l3N3Y1NWF5?=
 =?utf-8?B?MzJVSEVDRkI0UW9BajFUY1MvM1A4bU40dnVvYWpScHFjcHFCSEFWdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B344872F249724AB2D15A7BBDFD50AF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kW/Y6g7xjvn5Ex4+pNGG0NmaZU81jUpPbvSJUDhx9YIsEq/vRq1A0TIjrA2wWmyiOychwv9gql3JAyQBWvqPAzYCxgR4QjkQKtZrLwceiTWT0CehPvmDgBP8sGXGFt4l2w9/3VsppgvIXrBf0X1bdlxzzxfwQHEy1GeF+CrISBJO5P7OVlaaNuArC2dTSPXgjj8UKlXkVc8qrcZ7EBQJKgjV7+evyk/nczx4cQth9k+ZC9Tsb/vm+OW9ENfrCZSoK7Wgn4ucbLMNtJUiNRHbA9qTIejQZmJxou1PDvZ0bx5fYpf7IdVi4KDzpY3PKUnwvB3aDRi8CzNnsN7wPYAcRQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e798a30a-c989-4ad1-59a9-08df4520e80b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 03:06:14.3553 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ij8p3EYwP/ytzV30o581Bm6+mJBXCCS7fDQdh1gYnDEamkeBBtdRquWe92UZPD9es27jgPaT0ls82N674chc5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR03MB9438
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

T24gVGh1LCAyMDI2LTExLTEyIGF0IDE0OjE3ICswODAwLCBZaWRpIExpbiB3cm90ZToNCj4gbXRr
X2RwX2F1eF93YWl0X2Zvcl9jb21wbGV0aW9uKCkgcmV0dXJucyBmb3IgYSByZWFkIGFzIHNvb24g
YXMgdGhlIFJYDQo+IEZJRk8gd3JpdGUgcG9pbnRlciBpcyBub24temVybywgaS5lLiB3aGVuIHRo
ZSBmaXJzdCBieXRlIG9mIHRoZSByZXBseQ0KPiBoYXMgYXJyaXZlZC4gVGhlIHJlc3Qgb2YgdGhl
IHJlcGx5IGlzIHN0aWxsIG9uIHRoZSBBVVggbGluZSwgc28NCj4gbXRrX2RwX2F1eF9yZWFkX3J4
X2ZpZm8oKSBzbGVlcHMgNTAwLTEwMDAgdXMgYmVmb3JlIHJlYWRpbmcgZWFjaCBieXRlDQo+IG9m
IGFuIEkyQy1vdmVyLUFVWCByZXBseSBhbmQgMTAwLTIwMCB1cyBiZWZvcmUgZWFjaCBieXRlIG9m
IGEgbmF0aXZlDQo+IHJlcGx5LiBUaGUgRklGTyBpcyBkcmFpbmVkIHRoaXMgd2F5IGV2ZW4gZm9y
IERFRkVSIHJlcGxpZXMsIHdoaWNoIGNhcnJ5DQo+IG5vIGRhdGEuDQo+IA0KPiBBIDE2LWJ5dGUg
RURJRCByZWFkIHRoZXJlZm9yZSB0YWtlcyBhYm91dCAxNiBtcywgYWx0aG91Z2ggdGhlIHJlcGx5
IGlzDQo+IGNvbXBsZXRlIHdpdGhpbiBhYm91dCAzMDAgdXMgb2YgdGhlIHJlcXVlc3QuDQo+IA0K
PiBXYWl0IGZvciB0aGUgQVVYIHJlY2VpdmUtY29tcGxldGUgKG9yIDQwMCB1cyB0aW1lb3V0KSBp
bnRlcnJ1cHQgc3RhdHVzDQo+IGluc3RlYWQsIHdoaWNoIHRoZSB3cml0ZSBwYXRoIGFscmVhZHkg
cmVsaWVzIG9uLCBhbmQgZHJhaW4gdGhlIFJYIEZJRk8NCj4gd2l0aG91dCBkZWxheXMuIFBvbGwg
ZXZlcnkgMjAgdXMgaW5zdGVhZCBvZiBldmVyeSAxMDAtNTAwIHVzLg0KPiANCj4gUmVhZGluZyB0
aGUgMjU2LWJ5dGUgRURJRCB0aHJvdWdoIHRoZSBEUCBBVVggRERDIGFkYXB0ZXIgZHJvcHMgZnJv
bSAyNjYNCj4gdG8gNi41IG1zIG9uIGFuIE1UODE4OSBDaHJvbWVib29rLCBhbmQgZnJvbSA1NDcg
dG8gMjMgbXMgb24gYW4gTVQ4MTk2DQo+IENocm9tZWJvb2sgd2hvc2UgcGFuZWwgZGVmZXJzIGV2
ZXJ5IDE2LWJ5dGUgcmVhZCBvbmNlLiBBIDE2LWJ5dGUgRFBDRA0KPiByZWFkIGRyb3BzIGZyb20g
YWJvdXQgNC43IHRvIDAuNSBtcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlpZGkgTGluIDx5aWRp
bGluQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cC5jIHwgNjQgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDI1IGluc2VydGlvbnMoKyksIDM5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHAuYw0KPiBpbmRleCBmNjU2Yjg1Yjg0MjEyLi5iMmY3ZjQyY2JlNzE1IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+IEBAIC00NSw3ICs0NSw4IEBADQo+ICAj
ZGVmaW5lIE1US19EUF80UDFUIDQNCj4gICNkZWZpbmUgTVRLX0RQX0hERSAyDQo+ICAjZGVmaW5l
IE1US19EUF9QSVhfUEVSX0FERFIgMg0KPiAtI2RlZmluZSBNVEtfRFBfQVVYX1dBSVRfUkVQTFlf
Q09VTlQgMjANCj4gKyNkZWZpbmUgTVRLX0RQX0FVWF9QT0xMX1VTIDIwDQo+ICsjZGVmaW5lIE1U
S19EUF9BVVhfVElNRU9VVF9VUyAxMDAwMA0KPiAgI2RlZmluZSBNVEtfRFBfVEJDX0JVRl9SRUFE
X1NUQVJUX0FERFIgMHg4DQo+ICAjZGVmaW5lIE1US19EUF9UUkFJTl9WT0xUQUdFX0xFVkVMX1JF
VFJZIDUNCj4gICNkZWZpbmUgTVRLX0RQX1RSQUlOX0RPV05TQ0FMRV9SRVRSWSAxMA0KPiBAQCAt
ODI1LDIwICs4MjYsMTggQEAgc3RhdGljIHZvaWQgbXRrX2RwX2F1eF9maWxsX3dyaXRlX2ZpZm8o
c3RydWN0IG10a19kcCAqbXRrX2RwLCB1OCAqYnVmLA0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9p
ZCBtdGtfZHBfYXV4X3JlYWRfcnhfZmlmbyhzdHJ1Y3QgbXRrX2RwICptdGtfZHAsIHU4ICpidWYs
DQo+IC0JCQkJICAgIHNpemVfdCBsZW5ndGgsIGludCByZWFkX2RlbGF5KQ0KPiArCQkJCSAgICBz
aXplX3QgbGVuZ3RoKQ0KPiAgew0KPiAgCWludCByZWFkX3BvczsNCj4gIA0KPiAgCW10a19kcF91
cGRhdGVfYml0cyhtdGtfZHAsIE1US19EUF9BVVhfUDBfMzYyMCwNCj4gIAkJCSAgIDAsIEFVWF9S
RF9NT0RFX0FVWF9UWF9QMF9NQVNLKTsNCj4gIA0KPiArCS8qIFRoZSBjb21wbGV0ZSByZXBseSBp
cyBpbiB0aGUgUlggRklGTywgc28gcmVhZCBpdCB3aXRob3V0IGRlbGF5cy4gKi8NCj4gIAlmb3Ig
KHJlYWRfcG9zID0gMDsgcmVhZF9wb3MgPCBsZW5ndGg7IHJlYWRfcG9zKyspIHsNCj4gIAkJbXRr
X2RwX3VwZGF0ZV9iaXRzKG10a19kcCwgTVRLX0RQX0FVWF9QMF8zNjIwLA0KPiAgCQkJCSAgIEFV
WF9SWF9GSUZPX1JFQURfUFVMU0VfVFhfUDAsDQo+ICAJCQkJICAgQVVYX1JYX0ZJRk9fUkVBRF9Q
VUxTRV9UWF9QMCk7DQo+IC0NCj4gLQkJLyogSGFyZHdhcmUgbmVlZHMgdGltZSB0byB1cGRhdGUg
dGhlIGRhdGEgKi8NCg0KV2UgYXNzdW1lIHRoZSBkZWxheSBpcyBqdXN0IGZvciBBVVhfUlhfQVVY
X1JFQ1ZfQ09NUExFVEVfSVJRX0FVWF9UWF9QMCBhbmQgbm8gdGhlIG90aGVyIGhhcmR3YXJlIGRl
bGF5Lg0KSXQgc2VlbXMgdGhpcyBhc3N1bXB0aW9uIGlzIHJpZ2h0LCBzbw0KDQpSZXZpZXdlZC1i
eTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiAtCQl1c2xlZXBfcmFuZ2UocmVhZF9k
ZWxheSwgcmVhZF9kZWxheSAqIDIpOw0KPiAgCQlidWZbcmVhZF9wb3NdID0gKHU4KShtdGtfZHBf
cmVhZChtdGtfZHAsIE1US19EUF9BVVhfUDBfMzYyMCkgJg0KPiAgCQkJCSAgICAgQVVYX1JYX0ZJ
Rk9fUkVBRF9EQVRBX0FVWF9UWF9QMF9NQVNLKTsNCj4gIAl9DQo+IEBAIC04NjQsMzMgKzg2Mywy
OCBAQCBzdGF0aWMgdm9pZCBtdGtfZHBfYXV4X3NldF9sZW5ndGgoc3RydWN0IG10a19kcCAqbXRr
X2RwLCBzaXplX3QgbGVuZ3RoKQ0KPiAgCX0NCj4gIH0NCj4gIA0KPiAtc3RhdGljIGludCBtdGtf
ZHBfYXV4X3dhaXRfZm9yX2NvbXBsZXRpb24oc3RydWN0IG10a19kcCAqbXRrX2RwLCBib29sIGlz
X3JlYWQpDQo+ICtzdGF0aWMgaW50IG10a19kcF9hdXhfd2FpdF9mb3JfY29tcGxldGlvbihzdHJ1
Y3QgbXRrX2RwICptdGtfZHApDQo+ICB7DQo+IC0JaW50IHdhaXRfcmVwbHkgPSBNVEtfRFBfQVVY
X1dBSVRfUkVQTFlfQ09VTlQ7DQo+IC0NCj4gLQl3aGlsZSAoLS13YWl0X3JlcGx5KSB7DQo+IC0J
CXUzMiBhdXhfaXJxX3N0YXR1czsNCj4gLQ0KPiAtCQlpZiAoaXNfcmVhZCkgew0KPiAtCQkJdTMy
IGZpZm9fc3RhdHVzID0gbXRrX2RwX3JlYWQobXRrX2RwLCBNVEtfRFBfQVVYX1AwXzM2MTgpOw0K
PiAtDQo+IC0JCQlpZiAoZmlmb19zdGF0dXMgJg0KPiAtCQkJICAgIChBVVhfUlhfRklGT19XUklU
RV9QT0lOVEVSX0FVWF9UWF9QMF9NQVNLIHwNCj4gLQkJCSAgICAgQVVYX1JYX0ZJRk9fRlVMTF9B
VVhfVFhfUDBfTUFTSykpIHsNCj4gLQkJCQlyZXR1cm4gMDsNCj4gLQkJCX0NCj4gLQkJfQ0KPiAt
DQo+IC0JCWF1eF9pcnFfc3RhdHVzID0gbXRrX2RwX3JlYWQobXRrX2RwLCBNVEtfRFBfQVVYX1Aw
XzM2NDApOw0KPiAtCQlpZiAoYXV4X2lycV9zdGF0dXMgJiBBVVhfUlhfQVVYX1JFQ1ZfQ09NUExF
VEVfSVJRX0FVWF9UWF9QMCkNCj4gLQkJCXJldHVybiAwOw0KPiArCXUzMiBhdXhfaXJxX3N0YXR1
czsNCj4gKwlpbnQgcmV0Ow0KPiAgDQo+IC0JCWlmIChhdXhfaXJxX3N0YXR1cyAmIEFVWF80MDBV
U19USU1FT1VUX0lSUV9BVVhfVFhfUDApDQo+IC0JCQlyZXR1cm4gLUVUSU1FRE9VVDsNCj4gKwkv
Kg0KPiArCSAqIFdhaXQgdW50aWwgdGhlIHdob2xlIHJlcGx5IGhhcyBiZWVuIHJlY2VpdmVkLiBU
aGUgUlggRklGTyB3cml0ZQ0KPiArCSAqIHBvaW50ZXIgYmVjb21lcyBub24temVybyBhcyBzb29u
IGFzIHRoZSBmaXJzdCBieXRlIG9mIHRoZSByZXBseQ0KPiArCSAqIGFycml2ZXMsIHdoaWxlIHRo
ZSByZXN0IG9mIHRoZSByZXBseSBpcyBzdGlsbCBvbiB0aGUgQVVYIGxpbmUsIHNvDQo+ICsJICog
aXQgY2Fubm90IGJlIHVzZWQgdG8gdGVsbCB0aGF0IHRoZSByZXBseSBpcyBjb21wbGV0ZS4NCj4g
KwkgKi8NCj4gKwlyZXQgPSByZWdtYXBfcmVhZF9wb2xsX3RpbWVvdXQobXRrX2RwLT5yZWdzLCBN
VEtfRFBfQVVYX1AwXzM2NDAsDQo+ICsJCQkJICAgICAgIGF1eF9pcnFfc3RhdHVzLA0KPiArCQkJ
CSAgICAgICBhdXhfaXJxX3N0YXR1cyAmDQo+ICsJCQkJICAgICAgIChBVVhfUlhfQVVYX1JFQ1Zf
Q09NUExFVEVfSVJRX0FVWF9UWF9QMCB8DQo+ICsJCQkJCUFVWF80MDBVU19USU1FT1VUX0lSUV9B
VVhfVFhfUDApLA0KPiArCQkJCSAgICAgICBNVEtfRFBfQVVYX1BPTExfVVMsIE1US19EUF9BVVhf
VElNRU9VVF9VUyk7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gIA0KPiAtCQkv
KiBHaXZlIHRoZSBoYXJkd2FyZSBhIGNoYW5jZSB0byByZWFjaCBjb21wbGV0aW9uIGJlZm9yZSBy
ZXRyeWluZyAqLw0KPiAtCQl1c2xlZXBfcmFuZ2UoMTAwLCA1MDApOw0KPiAtCX0NCj4gKwlpZiAo
YXV4X2lycV9zdGF0dXMgJiBBVVhfUlhfQVVYX1JFQ1ZfQ09NUExFVEVfSVJRX0FVWF9UWF9QMCkN
Cj4gKwkJcmV0dXJuIDA7DQo+ICANCj4gIAlyZXR1cm4gLUVUSU1FRE9VVDsNCj4gIH0NCj4gQEAg
LTkyOCw3ICs5MjIsNyBAQCBzdGF0aWMgaW50IG10a19kcF9hdXhfZG9fdHJhbnNmZXIoc3RydWN0
IG10a19kcCAqbXRrX2RwLCBib29sIGlzX3JlYWQsIHU4IGNtZCwNCj4gIAltdGtfZHBfYXV4X3Jl
cXVlc3RfcmVhZHkobXRrX2RwKTsNCj4gIA0KPiAgCS8qIFdhaXQgZm9yIGZlZWRiYWNrIGZyb20g
c2luayBkZXZpY2UuICovDQo+IC0JcmV0ID0gbXRrX2RwX2F1eF93YWl0X2Zvcl9jb21wbGV0aW9u
KG10a19kcCwgaXNfcmVhZCk7DQo+ICsJcmV0ID0gbXRrX2RwX2F1eF93YWl0X2Zvcl9jb21wbGV0
aW9uKG10a19kcCk7DQo+ICANCj4gIAkqcmVwbHlfY21kID0gbXRrX2RwX3JlYWQobXRrX2RwLCBN
VEtfRFBfQVVYX1AwXzM2MjQpICYNCj4gIAkJICAgICBBVVhfUlhfUkVQTFlfQ09NTUFORF9BVVhf
VFhfUDBfTUFTSzsNCj4gQEAgLTk1MiwxNSArOTQ2LDcgQEAgc3RhdGljIGludCBtdGtfZHBfYXV4
X2RvX3RyYW5zZmVyKHN0cnVjdCBtdGtfZHAgKm10a19kcCwgYm9vbCBpc19yZWFkLCB1OCBjbWQs
DQo+ICAJCQkJICAgQVVYX1RYX0FVWFRYX09WX0VOX0FVWF9UWF9QMF9NQVNLIHwNCj4gIAkJCQkg
ICBBVVhfUkVTRVJWRURfUldfMF9BVVhfVFhfUDBfTUFTSyk7DQo+ICAJfSBlbHNlIGlmIChpc19y
ZWFkKSB7DQo+IC0JCWludCByZWFkX2RlbGF5Ow0KPiAtDQo+IC0JCWlmIChjbWQgPT0gKERQX0FV
WF9JMkNfUkVBRCB8IERQX0FVWF9JMkNfTU9UKSB8fA0KPiAtCQkgICAgY21kID09IERQX0FVWF9J
MkNfUkVBRCkNCj4gLQkJCXJlYWRfZGVsYXkgPSA1MDA7DQo+IC0JCWVsc2UNCj4gLQkJCXJlYWRf
ZGVsYXkgPSAxMDA7DQo+IC0NCj4gLQkJbXRrX2RwX2F1eF9yZWFkX3J4X2ZpZm8obXRrX2RwLCBi
dWYsIGxlbmd0aCwgcmVhZF9kZWxheSk7DQo+ICsJCW10a19kcF9hdXhfcmVhZF9yeF9maWZvKG10
a19kcCwgYnVmLCBsZW5ndGgpOw0KPiAgCX0NCj4gIA0KPiAgCXJldHVybiAwOw0KDQo=
