Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E5DCD4855
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 09:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 744B610E9DC;
	Tue, 12 May 2026 09:04:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="g7CbNq7L";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="WVSwUnW2";
	dkim-atps=neutral
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0573110E9DC
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 09:04:33 +0000 (UTC)
X-UUID: 95118b424de111f1b96f91537e34a508-20260512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=JCZC7dWBLmi3ErpRxGVuooxoyNZltL2i7fBTkIYdQxI=; 
 b=g7CbNq7LSz15EJk9kHRXayfmhEoB5OUU7VcphcZxwLiQx+LL+qoKP+5WcD99C9SZRTeNQZVgKaJJpLg20skA9kTrnedUE9fc1KTk8FFWwFd4Qxb8XQXYlVW8+V6YZuD1Dh489/0XWKoqlMNtxtoa/z6wukpCjaoQsLEHSF9APKo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.13, REQID:3f376f88-5694-4c9e-9108-56c81a9dc0c2, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b1afecd, CLOUDID:fa3d3fbf-65a8-4b41-ac18-3671578a914d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 95118b424de111f1b96f91537e34a508-20260512
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1781144751; Tue, 12 May 2026 17:04:28 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 12 May 2026 17:04:28 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 12 May 2026 17:04:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzfXWbnhTk9QTv/FOrH+yVBZ1i28ONxslCLGAXORvofSG/rKMZ13En4mx3RtA0RQIoBu9HTgs7xNtQTudacFUky4fELsn5yzHz7JcRep+8ITUxnrwnDWAKAU/U8Ty2ypVYzETvi9cQRJWWpvsYUBd/CyJu98CqOuJaR3/F5Fi/w+W87U2GwF/9RS1SFZNHz7TDKkoidLHj45ESJzl9lhK2Tart0o33S+kz+K8KeApa2mVmEARlkZNjwOGgFofg3WCzn3xe/O1CegkS98KcnvWSqeCQnAd/R6uGhXb/k73LSMtBet73/d8/71Hm/Jpc6wg66t4QnVVC1xkARby7wVcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCZC7dWBLmi3ErpRxGVuooxoyNZltL2i7fBTkIYdQxI=;
 b=Y1YkOeQLh6A83ct2togc61y/bqU9IDoFubsqQ8hPfSuqHeILT5J0ca38z/6mhnWCr6NQFk++8znyMCzs7dKLThc0aSU8eVns6sclSQi8vgC/ba1ghR7Drhr1+CmV2X8WXI0+t4rG9w4rtIquXXxWYHYCg9sS9hE1l04JfMM/QIs8t4h/isNnhr+AtRISmFM3lMeCf31H5JodvnG8mr1YAJG+eMj5z4zMCVHvpokT/KeqAqUXSMIwFaV3psGuNSjdqIZh0U3nW7ZHhopHNfpf+KZJkrH6Db/ac4QrAuMXeRwgwsm9HtNQbzgOym4Ij+Limk3R+TQyutc8ucrkg/32mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCZC7dWBLmi3ErpRxGVuooxoyNZltL2i7fBTkIYdQxI=;
 b=WVSwUnW29eF3kpdm1te5A5p8ZfbGN7sXEHf9he7sJ2JmXkWctSWz/8QGdZWrT2Zg3wt/LQ3qV7jGmXkYGj4fWbrhVurqGMgbp28gpKlCXTHy25rFx4o3fUWJl4y2nLyXeZd0jA4VURSVDD7votiUHHc/ikOPo2sYbXyjTKNOw6I=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SE3PR03MB9917.apcprd03.prod.outlook.com (2603:1096:101:333::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.15; Tue, 12 May
 2026 09:04:22 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0025.012; Tue, 12 May 2026
 09:04:22 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "simona@ffwll.ch"
 <simona@ffwll.ch>, Alexandre Mergnat <amergnat@baylibre.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "kernel@collabora.com"
 <kernel@collabora.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] drm/mediatek: mtk_cec: Fix non-static global variable
Thread-Topic: [PATCH 3/4] drm/mediatek: mtk_cec: Fix non-static global variable
Thread-Index: AQHc177wrNewPQO/0Eez9ZbwSatQe7YKLSaA
Date: Tue, 12 May 2026 09:04:22 +0000
Message-ID: <5b21133f728785fa7857a3f57de583c404d308c6.camel@mediatek.com>
References: <20260429-mediatek-drm-fix-sparse-warnings-v1-0-d95c4d118b83@collabora.com>
 <20260429-mediatek-drm-fix-sparse-warnings-v1-3-d95c4d118b83@collabora.com>
In-Reply-To: <20260429-mediatek-drm-fix-sparse-warnings-v1-3-d95c4d118b83@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SE3PR03MB9917:EE_
x-ms-office365-filtering-correlation-id: 9db715e8-b26e-4285-049f-08deb0057563
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|366016|376014|7416014|38070700021|11063799003|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: nMXXv3/lDjkYJQtWEFz7Qs3jAiXl8IIUOCtGDijmi9l8gQGrGvlQB023Lp+LU4y7A0AQTt83CfAPmvSjj1Kz+l4gJPfR6rNdYJprj3TZ/Bxw7b0Laa5XDRIaLNMdZt/JIJtmbbTAzvO32nyR/3K3FYVtmOVphNQWVMPtrrnciWyg/xAr3tYThHuitRWfkPPT5bk1TN6ao01nMZb2uaC4ebwJ60D1B+y6J5Le4hzS1Xz8hFeHjUJ5ttjCX5QEEpee45JbepGvNdEdyxrPv/em6Mv273flX9XOQYIMm5XE6H+AvTDaIwPcGYzZ/KOJFhbr/2rKozvULmZR17fUoPzw7JzNALJRWoEaJ4TQf8ZKGRxecT7Kjff+JhmoWcSMLtFmWNzSKHEuqWnDr/9EQ+I/v4IMaOMnFU4av+RN19eb6aMDIaqYDGZQlS6K36LQZ8WlZQ0G0CEP0Z+GAKX2/salclP8GXlcVo1QhkfsBYHTSZw1+qMTHatBEHhoTRy/6J7PuOsV8JV8yC9dRBnSLWelTlr41xE5xgAZ/ifMM1DZwEkv1EGN8Q7bt6JBK8uGqFkmL7OTplhrattRbRdYh8Qv7OnVMTSgSG10LTRVgK7M8dwyOy7yNQinYUKl28KJqw587yULmNbSqX/qWwp3m/J7Qt4rlWKTL06mfXhZhi/PZ7Y2iE49HISeLySzTJkxbnS4kn3pFn0xrby3e7bjNtyMfN/T/gas+Wn4oTOs82zAia+BXr3EARUWDC2HaWcAFiHq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(366016)(376014)(7416014)(38070700021)(11063799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXVYeXQrUStkYnZmb2IwQXkxQWN4YU9hcDEvQ0lES1VOaEJjbU5ybFhuUTZk?=
 =?utf-8?B?bnAyK2h0YVBaM2gxQjJDWmRnNmg5YmZIVWkxRDUwR0FBR3A1VEtoeC9kUFBO?=
 =?utf-8?B?S0cvZllWZjdIek5BNFFGM0FmVFVnS0NJNHFCdTZCeUMyQ0FMaFpkVHZGUzJh?=
 =?utf-8?B?U2RrcTIrZmU4MWRlUzBLYVFXR1BvSlZONmtqeE51NDhiQmVVTjJEV1htQzU4?=
 =?utf-8?B?aUR5c09vcURWSWtrelVPL0xuYllHc2NYeHBBSkdvUEZIYjRHUStiNHZZZTJx?=
 =?utf-8?B?SXlneVdNRUlEK1NVRlB5aDVwMFNsdldlSk0rdE41UWdLUTBJeDFkOXJmcTNo?=
 =?utf-8?B?dC9DZDl1S0VBekRIem9VbXFEa0dGUUNFSkZKNEd3VUkrRTBNc3FPSGNyc0Yv?=
 =?utf-8?B?RkswdE5YK1pTeHNaMWtOV2R5Z2ZYRHhldSt2UzZqeGpISnJJSHVKWkt1ZExu?=
 =?utf-8?B?TXVBYWdDRXl2VEZ5dUhtZTk2Rm54elRXaVd6eUo5WWdlZElkM1p5MjhxRnFN?=
 =?utf-8?B?dFlXT1h5TUNoSjY0YXJ2Z3IveXA1L1Urbk5yMm5jN1FXV25xQTl0NUFqcmh3?=
 =?utf-8?B?YS8vdnJZcnRJNllhR2JkWXNaeVpSZE1kb3pOeG5SY3FhaFpLRVBwZ3JBMWN5?=
 =?utf-8?B?NTJSbC91UDRUN3B6RzNjZ1lDMVlYdFJxMkhGdytyTWlaQnhnMmErR1hOTGFF?=
 =?utf-8?B?eFBwcFE4M0cxNDJINldtY3JoV0hsN2FodEVYNUcrUmo2NW0xV091WFpnaTFI?=
 =?utf-8?B?aWFzUEtaUDc3R21VSEJPY2VKZTZXM2hGUDZTR3A0QWpuQXBsUXRKN2w0N0V3?=
 =?utf-8?B?Vmp6VFZmS3AzWjMzYUJUWW80MlVCRTRIUjJpOFpRYnd2Slhnb3ZqV1o4WFUv?=
 =?utf-8?B?aXZaZnFQZkdicGdLcDE4VzV4RVhMaSt5eHFqWktwN3Z2WnhmUytnTTRvRDRY?=
 =?utf-8?B?V0NyaEtPa3FxQkJ3QkUvSHNMNGxQS05jS3gxc2NKL0RIL1JtWXNCekdwVVox?=
 =?utf-8?B?a0E2TmM5RTdFMkFrRmltRFE3YUY0MFJJaVFZWTA1amgwYTdqZ3lCQzRlOXF1?=
 =?utf-8?B?ekkzZVZjcnVMcHJaZ0xMT242NkxGQzJsRTZWalpkZjM3bXlZeTVYY2xwa1h5?=
 =?utf-8?B?UStQOWh1OFFCWHNKM2hWOWVyZ0dJeEJBYWFtTTIrVFA5UGZMQTNZdU5CZTc1?=
 =?utf-8?B?VkNXNEhSc3BCUGxJdyt6ck5XRUdUeDR3UVQzMFVEaHNKUFByNDNnK2ZWY095?=
 =?utf-8?B?YjdpZUpadGhLUnhvZ04wc09rcnpUN21wVUdhbmVJNitoN3RaSi9tKzdmL21V?=
 =?utf-8?B?dzhWY29OS2VPV0ZYNDQ4ODFHdFJjL2JoVjFuYWo2TlA4Yi90MEdnVFRXMGJy?=
 =?utf-8?B?UDB1eE9LZ0FUV0lKQS9zbUVNMXlRMzg1eDNOTFVycGhNNnZzV1FZb2dudkcx?=
 =?utf-8?B?VG9LMzlhLytKclJCY3BuWDVNUUJadmVlTU13bWFwSVIrcCtHU3djV3M4T3oy?=
 =?utf-8?B?eWRLblo1V3VoVHpLVmltM0NXNHJtalJpZjkvQXg5L2pBNEpoSXBJZmQ4WXpL?=
 =?utf-8?B?NFg4bTJPNjZuUytiNzg2S3ZKVE5abEw5bUhoWndSVnZ6RkJQTTlnSklqa2NO?=
 =?utf-8?B?SGNwcVV2YUJHZHFibEtPaVMyVldER1hiYW56WHZabTM4ZzdBcldjZ1ByamU2?=
 =?utf-8?B?N1ZCRlFIRXNHU0Q0eUYyaGxVcHpva0h2WGZTSm1nZE9pUi96cGR1ZG5QdFc0?=
 =?utf-8?B?cjZwNitiUFdEMFY3QjIzeVlRZmdxbFZYNGJ3TjVDUEhjY2Y4VjRIbGxUK2Jh?=
 =?utf-8?B?TnVTVEVrN0ZpMkpwbm40UFNRK3F4S2F4QXdKYTNOVm51elNTS2JKdS9YMzdn?=
 =?utf-8?B?czRsdktZcjJndE1tYjIrdlNsNTRLR3ZKeDFHbER1UTNrNW5KczhrUGYrL2xq?=
 =?utf-8?B?YTkzSFA1Qk1xbHpxcmFmN0hhQ0trTnZhVzhqS2N3djJvTW4weU9LK0ZYc3U3?=
 =?utf-8?B?NXQ4L2VWZlY5bU56OVdWc2VRVXdSbG5qRFAzMk9rZTAxWGpWaTJTamlYQXpK?=
 =?utf-8?B?SjA0YkJDM3F5QWdxOXBpRnJjK3hXcUZNYVlRc0hTYkt2ME9EZHRRMk1kckVa?=
 =?utf-8?B?dnlrREpnU1hGWVdnbTBsYXN1dzBXanB6QUxUTmsydVRWMTRBNlorSThQZWx1?=
 =?utf-8?B?UXhXcGdlcXFqcnFyOUwweUlkR1hMT1llMmlXTElBcjFydXQwSmNrK0c5N2hh?=
 =?utf-8?B?QjFvOEpWeHJkLzB4TVFUNmtzVjl3NW5IbDR0SzhVc3hXMlpLV3V6VFVXVkd1?=
 =?utf-8?B?aEhxemxrTWdoazJhc2QxUXAxMzR6Vi80cVBiUS9UTjRGM0JMQ2RXdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40D159532D33B24DAB4FC1D70979EEFE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mUz8XyYdZd3mVQ3BUCODiSzvqiSDFPnG1K74yWOJ6LcQrfWQ9Sn4YXNKP/3G7R2lbYOB7SFKW7Xkg/+hZNT/t110aHx1HB0ZtuJpiBSn+FOJBJEVVl0frpphKqMlN3UfkVOqeN1FzFfDWlSvcYER7YLPYh/rf+6LBWgScE2v97klHLqZw4n7geNF/K9OdFtt+4RWqjLzqkB9kwykOFkndkEDZkdYqXJMa9TGG8/ostiV+EuSMNWYkCkiQxvUX9baAsAJR0yjAl74q8OkGpk0XET4qXz3SSPKfiyEexNmC2/GlcR7HUUWnvnLuFTF2WTD3fRwiNFys47/HnFv+zFnbw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db715e8-b26e-4285-049f-08deb0057563
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 09:04:22.3573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yUBKGzYF511dE6h4uSEYfDjgyfzVgn58R0cJA7zYvdFuYVtL6K3iEwg+aKIdlKdFRo77IcmDBSanh/tR+BrTbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR03MB9917
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

T24gV2VkLCAyMDI2LTA0LTI5IGF0IDExOjU5ICswMjAwLCBMb3Vpcy1BbGV4aXMgRXlyYXVkIHdy
b3RlOg0KPiBUaGUgc3RydWN0ICdtdGtfY2VjX2RyaXZlcicgaXMgbm90IHVzZWQgb3V0c2lkZSBv
ZiB0aGUNCj4gbXRrX2NlYy5jIGZpbGUsIHNvIG1ha2UgaXQgc3RhdGljIHRvIHNpbGVuY2Ugc3Bh
cnNlIHdhcm5pbmc6DQo+IGBgYA0KPiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NlYy5j
OjI0MzoyNDogc3BhcnNlOiB3YXJuaW5nOiBzeW1ib2wNCj4gJ210a19jZWNfZHJpdmVyJyB3YXMg
bm90IGRlY2xhcmVkLiBTaG91bGQgaXQgYmUgc3RhdGljPw0KPiBgYGANCg0KUmV2aWV3ZWQtYnk6
IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IEZpeGVzOiAxZTkxNGE4OWFiN2Ug
KCJkcm0vbWVkaWF0ZWs6IG10a19jZWM6IFN3aXRjaCB0byByZWdpc3RlciBhcyBtb2R1bGVfcGxh
dGZvcm1fZHJpdmVyIikNCj4gU2lnbmVkLW9mZi1ieTogTG91aXMtQWxleGlzIEV5cmF1ZCA8bG91
aXNhbGV4aXMuZXlyYXVkQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19jZWMuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfY2VjLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NlYy5jDQo+
IGluZGV4IGM3YmU1MzBjYTA0MS4uYjhjY2Q2ZTU1YmVkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NlYy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfY2VjLmMNCj4gQEAgLTI0MCw3ICsyNDAsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IG9mX2RldmljZV9pZCBtdGtfY2VjX29mX2lkc1tdID0gew0KPiAgfTsNCj4gIE1PRFVMRV9ERVZJ
Q0VfVEFCTEUob2YsIG10a19jZWNfb2ZfaWRzKTsNCj4gIA0KPiAtc3RydWN0IHBsYXRmb3JtX2Ry
aXZlciBtdGtfY2VjX2RyaXZlciA9IHsNCj4gK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVy
IG10a19jZWNfZHJpdmVyID0gew0KPiAgCS5wcm9iZSA9IG10a19jZWNfcHJvYmUsDQo+ICAJLnJl
bW92ZSA9IG10a19jZWNfcmVtb3ZlLA0KPiAgCS5kcml2ZXIgPSB7DQo+IA0KDQo=
