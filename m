Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661E5CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 08:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7C5210E717;
	Mon, 18 May 2026 08:29:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="gYvKcKD+";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Vwl4Zpg9";
	dkim-atps=neutral
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB8D610E717
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 08:29:26 +0000 (UTC)
X-UUID: ab0472d2529311f1b5a00d44d12bea5a-20260518
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=FIEp/wPi3WeN3ZlmJfJasKlyYna/4FjxbFqBlqkDF98=; 
 b=gYvKcKD+AYuVJ9dRmtGJ2w3UEEBAf/h1NrYq1Bpxr7h+VLS44DqDU80+4+xo+zWMum00LNo0FcShBrc/NnxwRqRmHk7ap4PDSIOpBhQsXopXQ0nQA4kBUHSnKR29tnqK+PUMW63j0NgqrfSiA8K1+CoDcRxJbBl71GJbQ8/qLp0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.14, REQID:208abdba-eaff-476a-b754-6ac8c63624bc, IP:0,
 U
 RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:2
X-CID-META: VersionHash:9091e75, CLOUDID:583e83e1-02d4-4065-accc-97789b7ab0e5,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:4|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ab0472d2529311f1b5a00d44d12bea5a-20260518
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 38654071; Mon, 18 May 2026 16:29:20 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 18 May 2026 16:29:19 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 18 May 2026 16:29:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0oP/PfBNuWT6OO0kuLI/J0VqQdSUaoiK7fAEr3HSVr/9ssnarr/OiHSM8BdbWGYMBjOi/D64m1cG16e058wn/DrL5Swi2cuoyUvnntWtO0mN2AsUDlKtbtF/pke2ViC46E47VFH9gnWuoCIUVLG4HrvFbNanrbFvhMfhS2wBhuEtLMehCGcciR08YEndN+FTxHPPY3BpxOcDv54aEHHZjBpBRdvks2/6QWcz0+TdrFcEYq+fRTD2rnATT4KMQWxcTr94JwQ0bFC/hET9FgTIFHrds/PAWB1urgSAFeaJTyGhze9tbdR+ybngqCsS/oJv7nOsczv7FxKU2oh0rR74w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIEp/wPi3WeN3ZlmJfJasKlyYna/4FjxbFqBlqkDF98=;
 b=UHjuroMcacu9P6Hi8VdAHG7CoIyT2X05lhODDCc63aWhbtCmM0CqMKqPcRAfRmnyHKRBSulxbQWQ+aBZYz9V08ODIYQot5uVYbkfSukPbuiATv1UvFJBvMAE8z3Fa1s5Y3kgXZEsA8LJsy8w7xX7OWmekfYA8f3tpR0alWdDXnAFjna2qnl6RXLvE+iO0wk9qkO7j1SLJRWnCWCI7WdRnnA9vreUzVbejul1MCVNLCDTKkZEVnpmTu9IsrWRXtJXXY5tEb62yUCIPQcaxGGRz7WFYB8uVjL8i2t5AY64iZj8w3nFn7qgIE1UcEQRJrT3HYNDaTQAfA3emmPSTnZ1eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIEp/wPi3WeN3ZlmJfJasKlyYna/4FjxbFqBlqkDF98=;
 b=Vwl4Zpg9KR/FDxQQs1HiDPCEwLPMmIgMid6Wua9ZA9GetDTdT8sIdzL3LmZjqrBy1ideAYSpI2uN6LAYaBXBv/yvCCH9yP5d2o00h2JNu14KoIEG46Ei6qTpecyfO0xZVlDUoDtlxmZ7gG7wBlKZTpmMBl/Yd5w3FxLfVpGMyCs=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB8154.apcprd03.prod.outlook.com (2603:1096:101:180::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.11; Mon, 18 May
 2026 08:29:14 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 08:29:14 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>, "abhiraj21put@gmail.com"
 <abhiraj21put@gmail.com>, "chunkuang.hu@kernel.org"
 <chunkuang.hu@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/mediatek: Convert legacy DRM logging to drm_* helpers
 in mtk_dsi.c
Thread-Topic: [PATCH] drm/mediatek: Convert legacy DRM logging to drm_*
 helpers in mtk_dsi.c
Thread-Index: AQHc0IWCj/4znBxbTEWz3+0XAOaZubYTn8WA
Date: Mon, 18 May 2026 08:29:13 +0000
Message-ID: <2571f04d3d8f056780f73ba20eacb6d5b600dc61.camel@mediatek.com>
References: <20260420052008.5417-1-abhiraj21put@gmail.com>
In-Reply-To: <20260420052008.5417-1-abhiraj21put@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB8154:EE_
x-ms-office365-filtering-correlation-id: 77ad8285-0631-4c67-09d9-08deb4b78b3d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|42112799006|376014|366016|38070700021|11063799003|10063799003|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: NGlYPayKEkYGPpHOmmmUYaJHVuGjmnadgKrrYAiOfp/zsMhxq76Dvk+JlAj/2litL5FfXoWIkBD6UBu94WRZthmqKt0w4XnA7Yp6c8V2MVnnDrch+h5AsJrRYyR47wCpdGULwG3xPNgSK1Cif6UXQEczonNpgFwknSMgUxQoqG44YEhNy/YYiwrwQqN4rgcYaW6fM1B+x3fXWAspoqU8QaNOv3+zB6HmKAXz6JL3SNA4jcenjAnbsswBZNoimcjZiSpr9mlaKx4ZhZz0bnoxWlefO2eI+hcFaoCHexEnzcbuEJw0p3bPVydve9WQQPrn2keXMiG/vEBrXevm7UmmsvrtuEmkq2Wuu0K31814sdv4JOWi7OcxsWWvCU+lqIfx4ILJGrqdAzOnpSKjUUceaM97JaH900KX6ikAw3OU1JY9cRz4yN2ekIH6Jrsxdf7A3mvEb/gZY6VADY52XMg7turF3xbDBF54IKCUxNvcZ9PpGFx3biC+dn5JVsA9pWUjdBw6DFWGDsX5L+mSbc1vC91ua22QvF3s8m5pfwhpnVjAlpISvxZJZDHwtWng29iRPwwC51o9a6RgYYAHsxJcvltpsAYYEC01qN4AP3ru4b1YkU99R5J+HjsM7AxeyfFVEz3bLq0T3JjMke50W0NR2S50Izj7y8IweaVJ08fuAz0H+/x0BFJ93QJooxjZGBUQ7sLEeCGokyjzjjXuwMx/BDREVFMt6Iu48EyiOCmMYoyN583vlfKZ78xyzPtfJY7I
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(42112799006)(376014)(366016)(38070700021)(11063799003)(10063799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzFmSktabU54K3gyOU5MQlhZM2xDcWpBbStXV3owbFpOdHE0bytWN2NPbHpQ?=
 =?utf-8?B?eXljNVM2cUxac2xML2IxVTVkRTUvRFBPdEVuTHo3NDFHTm1Eb2h4N2NXdFgv?=
 =?utf-8?B?cWV2bzJhaFdEdjlMbGpoellKK3ZSRk9aOFRLdVhkNkZDMUxPMUVMOE95OUo0?=
 =?utf-8?B?SHZsM2xsQ0tFNEsyQTR0azhUc05RenpPY244NTVoaVpOWi9UWkxHbTRUcEpL?=
 =?utf-8?B?UlpxUG1XVUhxMDBHVC8xWjl2TGlhN2ZFSzlWZmhkU3lYK3VnOWlYWVlValkv?=
 =?utf-8?B?cEhqT0hyRmtQTTgxRExQV0VZMnYraDN6OS9aMUZkSENmSDBOUU1ONllhd0N6?=
 =?utf-8?B?SUN4V1Uya1FSRWFvV1JGUFIxSlJzaXJZd1JHamRWb2I0RmpBeHRzM3lNNDRD?=
 =?utf-8?B?YVlTU0x2dlhQR0sxZ0RXZHU4OVVTaVRaUXNmUjdPMlNvMzZPRjI4ZUE1d0RR?=
 =?utf-8?B?ZmNUZW4zSzI4OWJ1Vk5FVG0wYXpMTXRVOVZOSGhNWkY2bkVFamI5Z016SjBo?=
 =?utf-8?B?U05DSklSR1ZIeVg3SWtUMGFFUzRodDJTS1dSV2xIQ3Uycmg3eHB2VExyVmxJ?=
 =?utf-8?B?aG9kZXU1ekpaSVVGWUJFckF2a3pHU3cvQlA0cjhCZ2RBTndyKzVWcVVHSFd1?=
 =?utf-8?B?TUtBcnUvMjFoTThOWHIxclF1WnlkWVA1NjlhTDY3UDQ4THZJYTYramVwczJa?=
 =?utf-8?B?cTFrS2RudjFEQVNwa2cvSmpQNkVkTW1xU3A5Z0VqVEdMd3hKWkpRTGpKSklM?=
 =?utf-8?B?bUxBWlYrQzdlUHBnOWljMVUzVUhrN2tkUnhRR09xMFVnMmRpWXdOeDZnWWpm?=
 =?utf-8?B?TUhadkFUUjNyYUJMaE43NmwyRlpicURmYnRZTFRrekJBMFFhSVhSZ1RLTHM1?=
 =?utf-8?B?WUxoNkVZYTNTblZENWhiNGd5M1BXRDFBRUhBdEdDTC9vdlFiVitUT3BWbHUy?=
 =?utf-8?B?VGdUN2gxSzNld1I0ak1wM0FrNmVlY0RUWUdTU0NTallnanZycHU4eU1BWEFm?=
 =?utf-8?B?bXZ3SXhkZWkwbkMzR0tueGJsdFloQjkyMXpmWWlCenh1Tnl6Z3YxUHVnRStE?=
 =?utf-8?B?K2VJVndzcEZTZUhGTFpleTZMU2V0cWp0WGxPYUxNV3VZSmtLVUtudzJqbUhs?=
 =?utf-8?B?Z2ZQajdNaTlGTkEvSm5QQTFlMGNBQjdtT0llU0RrRTdPZWo4WXlLcmNnTEUx?=
 =?utf-8?B?Ylo5SmtlWUE3VDRuVVRlaUg0YU4xb09wZm81c0MvU1RIRnFaNHVuRXdWbWdH?=
 =?utf-8?B?MlFDeTE4anZlemI0QVhJRHJlOVN0bk5MQ3VMTmQvY1hjTW94THo0QUpUWklV?=
 =?utf-8?B?UEV0dW15WWxqVkRHWDJEMzhHN0VWOVpTb1lrd01jOVc1MXhNdmZHNXlmelo2?=
 =?utf-8?B?dUx5QTZSYWlhUDBvL254ZUpxakxObzhoS2lOa1BTOTZVNDN6N0lVN2UwZFBV?=
 =?utf-8?B?L1RBdVF2SXlGaW1hdmtQNzZNa3B3Mjl3Ulp3anFxQUxlSlRyWFBOcGhLTHVv?=
 =?utf-8?B?OE5CamxDSHFJUWVUOVFyalFPdmpWOU1pWU8wMzB4Q2FkWEVyWXdzdFJQRDlr?=
 =?utf-8?B?L2ZQQUlsTFA1NlVyZXkrQ3VFYWJDOUdNVWZLREh2ZXNsT21nSXd2OTQ1c1Zn?=
 =?utf-8?B?bGxPQmNOdThOVEJSVmtQMlFHeVpSWkRHVVhkT25UcnZrbkxxUFBNeUtxRGNH?=
 =?utf-8?B?Ry9pck5kYXdURGdyVjV5aTNTV3B1SnR2d3RYM2ZXQVRQZERpdlF0bndiTjIw?=
 =?utf-8?B?bXZkc2hKaHBpNHREMGlXeFluOW5XZ2ZpN3hneWVyK0IzWDdnVXYyclgrK2wx?=
 =?utf-8?B?L2ZJaTUzMFd3QUNCZHFmYWZha1dvVGxrMEZ4RW90eEFqV3FSaVJuUnZzbUhY?=
 =?utf-8?B?ZHdFOXZ5Q3ZGZCtxdnFBUUdQMllWUk03MlZINElrYTdHMW1jdDVvdklaeUZh?=
 =?utf-8?B?UWVrTmdjZ3BxT1Qya3Frd1ZhWGdGaWNSdFVVVVgrVjdTWThXcitoYUJSeC9D?=
 =?utf-8?B?dU41Z1JKQ0N3cVN0Wms1TnlZN1A2b1lmbkJ2eVE3R01aRHRIQlpzQjQ5REZ2?=
 =?utf-8?B?c083eG5jcDRlZm9TaWRpTXFZRWhNWlJUMkc1T3F3N21yazAxZitvRXl6K3dp?=
 =?utf-8?B?Umc3SjczcnlDd0pSSEhYNloxY2h2YndJMDhaSytoT2tzejUxSDg4WmIyU3VE?=
 =?utf-8?B?azFzWHhjU3U0cFpxL0VjTlArS2s1NXlqaGtrUmQwUzdnaWJMYSt0K2RFNzNL?=
 =?utf-8?B?QTlvYXAyaWR4TVIveTZPcFVwcVRWTFM4T1I5YXNpOWVndXhpOFlsblhMZUQ4?=
 =?utf-8?B?TWRaOTcwTlFjVDd1U2pickNOYmxQR0M0b3FEOEE0K3dneHlHaUFEQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F41C45C511013148AB3490E270FD6119@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bhVoXlujimxskoACyZ0+GuoHA179tgKBGWfCeWM2JwK7kXxVEfRDsVsmqDg7MuIZJo3lU1TmJDwi/MKP4VHkAF5v/f1q0CDxmkYkszTIP+vZINr/2IDMgw9uBqEvFibGuV/MRJunBIjmA1jiTC24SOzU5LdUahtUH2fmteqBSWO1yXokd4+9tbuWTJ8wiz8TZzQiqlzOS234WYBNbzKdJ0CbcIq7S+o7y4PZaFyVYDMIGaPHlMxq7rP3ANyCD9ZMGh/dH4uPdNYZ+76mUCKewBJ2umaJVyu0xzeQzzgg30z09U3us/3/yjyOnET13GF6456Di1tQvqR5umZDufDGdw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ad8285-0631-4c67-09d9-08deb4b78b3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 08:29:14.0491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+37quaK4FSjllfbwTPepI1dnEIoN6mSmyjCCiVgE/bxxICixSjrzXtHE4hdMwTg/jQbdS6gwv5l6HDiCXuE1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8154
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

T24gTW9uLCAyMDI2LTA0LTIwIGF0IDEwOjUwICswNTMwLCBBYmhpc2hlayBSYWpwdXQgd3JvdGU6
DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+IA0KPiANCj4gUmVwbGFjZSBEUk1fSU5GTygpLCBEUk1fV0FSTigpIGFuZCBEUk1fRVJS
T1IoKSBjYWxscyBpbg0KPiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jIHdpdGgg
dGhlIGNvcnJlc3BvbmRpbmcNCj4gZHJtX2luZm8oKSwgZHJtX3dhcm4oKSBhbmQgZHJtX2Vycigp
IGhlbHBlcnMuDQo+IA0KPiBUaGUgZHJtXyooKSBsb2dnaW5nIGhlbHBlcnMgdGFrZSBhIHN0cnVj
dCBkcm1fZGV2aWNlICogYXJndW1lbnQsDQo+IGFsbG93aW5nIHRoZSBEUk0gY29yZSB0byBwcmVm
aXggbG9nIG1lc3NhZ2VzIHdpdGggdGhlIGNvcnJlY3QgZGV2aWNlDQo+IG5hbWUgYW5kIGluc3Rh
bmNlLiBUaGlzIGlzIHJlcXVpcmVkIHRvIGNvcnJlY3RseSBkaXN0aW5ndWlzaCBsb2cNCj4gbWVz
c2FnZXMgb24gc3lzdGVtcyB3aXRoIG11bHRpcGxlIEdQVXMuDQo+IA0KPiBUaGlzIGNoYW5nZSBh
bGlnbnMgdGhlIHJhZGVvbiBkcml2ZXIgd2l0aCB0aGUgRFJNIFRPRE8gaXRlbToNCj4gIkNvbnZl
cnQgbG9nZ2luZyB0byBkcm1fKiBmdW5jdGlvbnMgd2l0aCBkcm1fZGV2aWNlIHBhcmFtZXRlciIu
DQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBYmhpc2hlayBSYWpwdXQgPGFiaGlyYWoyMXB1dEBnbWFpbC5jb20+DQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYyBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCj4gaW5kZXggMGUyYmNkNWY2N2I3Li5hNjdh
ZDU3NWY1ZjAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNp
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KPiBAQCAtNTEw
LDYgKzUxMCw3IEBAIHN0YXRpYyB2b2lkIG10a19kc2lfY29uZmlnX3Zkb190aW1pbmdfcGVyX2xp
bmVfbHAoc3RydWN0IG10a19kc2kgKmRzaSkNCj4gICAgICAgICB1MzIgZGVsdGE7DQo+ICAgICAg
ICAgc3RydWN0IG10a19waHlfdGltaW5nICp0aW1pbmcgPSAmZHNpLT5waHlfdGltaW5nOw0KPiAg
ICAgICAgIHN0cnVjdCB2aWRlb21vZGUgKnZtID0gJmRzaS0+dm07DQo+ICsgICAgICAgc3RydWN0
IGRybV9kZXZpY2UgKmRybSA9IGRzaS0+YnJpZGdlLmRldjsNCj4gDQo+ICAgICAgICAgaWYgKGRz
aS0+Zm9ybWF0ID09IE1JUElfRFNJX0ZNVF9SR0I1NjUpDQo+ICAgICAgICAgICAgICAgICBkc2lf
dG1wX2J1Zl9icHAgPSAyOw0KPiBAQCAtNTQzLDcgKzU0NCw3IEBAIHN0YXRpYyB2b2lkIG10a19k
c2lfY29uZmlnX3Zkb190aW1pbmdfcGVyX2xpbmVfbHAoc3RydWN0IG10a19kc2kgKmRzaSkNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaG9yaXpvbnRhbF9i
YWNrcG9yY2hfYnl0ZSAvDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGhvcml6b250YWxfZnJvbnRfYmFja19ieXRlOw0KPiAgICAgICAgIH0gZWxzZSB7DQo+
IC0gICAgICAgICAgICAgICBEUk1fV0FSTigiSEZQICsgSEJQIGxlc3MgdGhhbiBkLXBoeSwgRlBT
IHdpbGwgdW5kZXIgNjBIelxuIik7DQo+ICsgICAgICAgICAgICAgICBkcm1fd2Fybihkcm0sICJI
RlAgKyBIQlAgbGVzcyB0aGFuIGQtcGh5LCBGUFMgd2lsbCB1bmRlciA2MEh6XG4iKTsNCj4gICAg
ICAgICB9DQo+IA0KPiAgICAgICAgIGlmICgoZHNpLT5tb2RlX2ZsYWdzICYgTUlQSV9EU0lfSFNf
UEtUX0VORF9BTElHTkVEKSAmJg0KPiBAQCAtNjIzLDEyICs2MjQsMTMgQEAgc3RhdGljIHMzMiBt
dGtfZHNpX3dhaXRfZm9yX2lycV9kb25lKHN0cnVjdCBtdGtfZHNpICpkc2ksIHUzMiBpcnFfZmxh
ZywNCj4gIHsNCj4gICAgICAgICBzMzIgcmV0ID0gMDsNCj4gICAgICAgICB1bnNpZ25lZCBsb25n
IGppZmZpZXMgPSBtc2Vjc190b19qaWZmaWVzKHRpbWVvdXQpOw0KPiArICAgICAgIHN0cnVjdCBk
cm1fZGV2aWNlICpkcm0gPSBkc2ktPmJyaWRnZS5kZXY7DQo+IA0KPiAgICAgICAgIHJldCA9IHdh
aXRfZXZlbnRfaW50ZXJydXB0aWJsZV90aW1lb3V0KGRzaS0+aXJxX3dhaXRfcXVldWUsDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZHNpLT5pcnFfZGF0
YSAmIGlycV9mbGFnLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGppZmZpZXMpOw0KPiAgICAgICAgIGlmIChyZXQgPT0gMCkgew0KPiAtICAgICAgICAg
ICAgICAgRFJNX1dBUk4oIldhaXQgRFNJIElSUSgweCUwOHgpIFRpbWVvdXRcbiIsIGlycV9mbGFn
KTsNCj4gKyAgICAgICAgICAgICAgIGRybV93YXJuKGRybSwgIldhaXQgRFNJIElSUSgweCUwOHgp
IFRpbWVvdXRcbiIsIGlycV9mbGFnKTsNCj4gDQo+ICAgICAgICAgICAgICAgICBtdGtfZHNpX2Vu
YWJsZShkc2kpOw0KPiAgICAgICAgICAgICAgICAgbXRrX2RzaV9yZXNldF9lbmdpbmUoZHNpKTsN
Cj4gQEAgLTY2Myw5ICs2NjUsMTAgQEAgc3RhdGljIHMzMiBtdGtfZHNpX3N3aXRjaF90b19jbWRf
bW9kZShzdHJ1Y3QgbXRrX2RzaSAqZHNpLCB1OCBpcnFfZmxhZywgdTMyIHQpDQo+ICB7DQo+ICAg
ICAgICAgbXRrX2RzaV9pcnFfZGF0YV9jbGVhcihkc2ksIGlycV9mbGFnKTsNCj4gICAgICAgICBt
dGtfZHNpX3NldF9jbWRfbW9kZShkc2kpOw0KPiArICAgICAgIHN0cnVjdCBkcm1fZGV2aWNlICpk
cm0gPSBkc2ktPmJyaWRnZS5kZXY7DQo+IA0KPiAgICAgICAgIGlmICghbXRrX2RzaV93YWl0X2Zv
cl9pcnFfZG9uZShkc2ksIGlycV9mbGFnLCB0KSkgew0KPiAtICAgICAgICAgICAgICAgRFJNX0VS
Uk9SKCJmYWlsZWQgdG8gc3dpdGNoIGNtZCBtb2RlXG4iKTsNCj4gKyAgICAgICAgICAgICAgIGRy
bV9lcnIoZHJtLCAiZmFpbGVkIHRvIHN3aXRjaCBjbWQgbW9kZVxuIik7DQo+ICAgICAgICAgICAg
ICAgICByZXR1cm4gLUVUSU1FOw0KPiAgICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICAgICAg
ICByZXR1cm4gMDsNCj4gQEAgLTg0OSwxMSArODUyLDEyIEBAIHN0YXRpYyB2b2lkIG10a19kc2lf
YnJpZGdlX2F0b21pY19wcmVfZW5hYmxlKHN0cnVjdCBkcm1fYnJpZGdlICpicmlkZ2UsDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkcm1fYXRv
bWljX3N0YXRlICpzdGF0ZSkNCj4gIHsNCj4gICAgICAgICBzdHJ1Y3QgbXRrX2RzaSAqZHNpID0g
YnJpZGdlX3RvX2RzaShicmlkZ2UpOw0KPiArICAgICAgIHN0cnVjdCBkcm1fZGV2aWNlICpkcm0g
PSBicmlkZ2UtPmRldjsNCj4gICAgICAgICBpbnQgcmV0Ow0KPiANCj4gICAgICAgICByZXQgPSBt
dGtfZHNpX3Bvd2Vyb24oZHNpKTsNCj4gICAgICAgICBpZiAocmV0IDwgMCkNCj4gLSAgICAgICAg
ICAgICAgIERSTV9FUlJPUigiZmFpbGVkIHRvIHBvd2VyIG9uIGRzaVxuIik7DQo+ICsgICAgICAg
ICAgICAgICBkcm1fZXJyKGRybSwgImZhaWxlZCB0byBwb3dlciBvbiBkc2lcbiIpOw0KPiAgfQ0K
PiANCj4gIHN0YXRpYyB2b2lkIG10a19kc2lfYnJpZGdlX2F0b21pY19wb3N0X2Rpc2FibGUoc3Ry
dWN0IGRybV9icmlkZ2UgKmJyaWRnZSwNCj4gQEAgLTkxNiw3ICs5MjAsNyBAQCBzdGF0aWMgaW50
IG10a19kc2lfZW5jb2Rlcl9pbml0KHN0cnVjdCBkcm1fZGV2aWNlICpkcm0sIHN0cnVjdCBtdGtf
ZHNpICpkc2kpDQo+ICAgICAgICAgcmV0ID0gZHJtX3NpbXBsZV9lbmNvZGVyX2luaXQoZHJtLCAm
ZHNpLT5lbmNvZGVyLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERS
TV9NT0RFX0VOQ09ERVJfRFNJKTsNCj4gICAgICAgICBpZiAocmV0KSB7DQo+IC0gICAgICAgICAg
ICAgICBEUk1fRVJST1IoIkZhaWxlZCB0byBlbmNvZGVyIGluaXQgdG8gZHJtXG4iKTsNCj4gKyAg
ICAgICAgICAgICAgIGRybV9lcnIoZHJtLCAiRmFpbGVkIHRvIGVuY29kZXIgaW5pdCB0byBkcm1c
biIpOw0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gICAgICAgICB9DQo+IA0KPiBA
QCAtOTMyLDcgKzkzNiw3IEBAIHN0YXRpYyBpbnQgbXRrX2RzaV9lbmNvZGVyX2luaXQoc3RydWN0
IGRybV9kZXZpY2UgKmRybSwgc3RydWN0IG10a19kc2kgKmRzaSkNCj4gDQo+ICAgICAgICAgZHNp
LT5jb25uZWN0b3IgPSBkcm1fYnJpZGdlX2Nvbm5lY3Rvcl9pbml0KGRybSwgJmRzaS0+ZW5jb2Rl
cik7DQo+ICAgICAgICAgaWYgKElTX0VSUihkc2ktPmNvbm5lY3RvcikpIHsNCj4gLSAgICAgICAg
ICAgICAgIERSTV9FUlJPUigiVW5hYmxlIHRvIGNyZWF0ZSBicmlkZ2UgY29ubmVjdG9yXG4iKTsN
Cj4gKyAgICAgICAgICAgICAgIGRybV9lcnIoZHJtLCAiVW5hYmxlIHRvIGNyZWF0ZSBicmlkZ2Ug
Y29ubmVjdG9yXG4iKTsNCj4gICAgICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIoZHNpLT5jb25u
ZWN0b3IpOw0KPiAgICAgICAgICAgICAgICAgZ290byBlcnJfY2xlYW51cF9lbmNvZGVyOw0KPiAg
ICAgICAgIH0NCj4gQEAgLTk4NSw2ICs5ODksNyBAQCBzdGF0aWMgaW50IG10a19kc2lfaG9zdF9h
dHRhY2goc3RydWN0IG1pcGlfZHNpX2hvc3QgKmhvc3QsDQo+ICB7DQo+ICAgICAgICAgc3RydWN0
IG10a19kc2kgKmRzaSA9IGhvc3RfdG9fZHNpKGhvc3QpOw0KPiAgICAgICAgIHN0cnVjdCBkZXZp
Y2UgKmRldiA9IGhvc3QtPmRldjsNCj4gKyAgICAgICBzdHJ1Y3QgZHJtX2RldmljZSAqZHJtID0g
ZHNpLT5icmlkZ2UuZGV2Ow0KPiAgICAgICAgIGludCByZXQ7DQo+IA0KPiAgICAgICAgIGRzaS0+
bGFuZXMgPSBkZXZpY2UtPmxhbmVzOw0KPiBAQCAtMTAxMiw3ICsxMDE3LDcgQEAgc3RhdGljIGlu
dCBtdGtfZHNpX2hvc3RfYXR0YWNoKHN0cnVjdCBtaXBpX2RzaV9ob3N0ICpob3N0LA0KPiANCj4g
ICAgICAgICByZXQgPSBjb21wb25lbnRfYWRkKGhvc3QtPmRldiwgJm10a19kc2lfY29tcG9uZW50
X29wcyk7DQo+ICAgICAgICAgaWYgKHJldCkgew0KPiAtICAgICAgICAgICAgICAgRFJNX0VSUk9S
KCJmYWlsZWQgdG8gYWRkIGRzaV9ob3N0IGNvbXBvbmVudDogJWRcbiIsIHJldCk7DQo+ICsgICAg
ICAgICAgICAgICBkcm1fZXJyKGRybSwgImZhaWxlZCB0byBhZGQgZHNpX2hvc3QgY29tcG9uZW50
OiAlZFxuIiwgcmV0KTsNCj4gICAgICAgICAgICAgICAgIGRybV9icmlkZ2VfcmVtb3ZlKCZkc2kt
PmJyaWRnZSk7DQo+ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiAgICAgICAgIH0NCj4g
QEAgLTEwMzQsMTEgKzEwMzksMTIgQEAgc3RhdGljIHZvaWQgbXRrX2RzaV93YWl0X2Zvcl9pZGxl
KHN0cnVjdCBtdGtfZHNpICpkc2kpDQo+ICB7DQo+ICAgICAgICAgaW50IHJldDsNCj4gICAgICAg
ICB1MzIgdmFsOw0KPiArICAgICAgIHN0cnVjdCBkcm1fZGV2aWNlICpkcm0gPSBkc2ktPmJyaWRn
ZS5kZXY7DQo+IA0KPiAgICAgICAgIHJldCA9IHJlYWRsX3BvbGxfdGltZW91dChkc2ktPnJlZ3Mg
KyBEU0lfSU5UU1RBLCB2YWwsICEodmFsICYgRFNJX0JVU1kpLA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA0LCAyMDAwMDAwKTsNCj4gICAgICAgICBpZiAocmV0KSB7DQo+IC0g
ICAgICAgICAgICAgICBEUk1fV0FSTigicG9sbGluZyBkc2kgd2FpdCBub3QgYnVzeSB0aW1lb3V0
IVxuIik7DQo+ICsgICAgICAgICAgICAgICBkcm1fd2Fybihkcm0sICJwb2xsaW5nIGRzaSB3YWl0
IG5vdCBidXN5IHRpbWVvdXQhXG4iKTsNCj4gDQo+ICAgICAgICAgICAgICAgICBtdGtfZHNpX2Vu
YWJsZShkc2kpOw0KPiAgICAgICAgICAgICAgICAgbXRrX2RzaV9yZXNldF9lbmdpbmUoZHNpKTsN
Cj4gQEAgLTExMjMsNiArMTEyOSw3IEBAIHN0YXRpYyBzc2l6ZV90IG10a19kc2lfaG9zdF90cmFu
c2ZlcihzdHJ1Y3QgbWlwaV9kc2lfaG9zdCAqaG9zdCwNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBtaXBpX2RzaV9tc2cgKm1zZykNCj4gIHsNCj4g
ICAgICAgICBzdHJ1Y3QgbXRrX2RzaSAqZHNpID0gaG9zdF90b19kc2koaG9zdCk7DQo+ICsgICAg
ICAgc3RydWN0IGRybV9kZXZpY2UgKmRybSA9IGRzaS0+YnJpZGdlLmRldjsNCj4gICAgICAgICBz
c2l6ZV90IHJlY3ZfY250Ow0KPiAgICAgICAgIHU4IHJlYWRfZGF0YVsxNl07DQo+ICAgICAgICAg
dm9pZCAqc3JjX2FkZHI7DQo+IEBAIC0xMTUzLDcgKzExNjAsNyBAQCBzdGF0aWMgc3NpemVfdCBt
dGtfZHNpX2hvc3RfdHJhbnNmZXIoc3RydWN0IG1pcGlfZHNpX2hvc3QgKmhvc3QsDQo+ICAgICAg
ICAgfQ0KPiANCj4gICAgICAgICBpZiAoIW1zZy0+cnhfYnVmKSB7DQo+IC0gICAgICAgICAgICAg
ICBEUk1fRVJST1IoImRzaSByZWNlaXZlIGJ1ZmZlciBzaXplIG1heSBiZSBOVUxMXG4iKTsNCj4g
KyAgICAgICAgICAgICAgIGRybV9lcnIoZHJtLCAiZHNpIHJlY2VpdmUgYnVmZmVyIHNpemUgbWF5
IGJlIE5VTExcbiIpOw0KPiAgICAgICAgICAgICAgICAgcmV0ID0gLUVJTlZBTDsNCj4gICAgICAg
ICAgICAgICAgIGdvdG8gcmVzdG9yZV9kc2lfbW9kZTsNCj4gICAgICAgICB9DQo+IEBAIC0xMTc3
LDcgKzExODQsNyBAQCBzdGF0aWMgc3NpemVfdCBtdGtfZHNpX2hvc3RfdHJhbnNmZXIoc3RydWN0
IG1pcGlfZHNpX2hvc3QgKmhvc3QsDQo+ICAgICAgICAgaWYgKHJlY3ZfY250KQ0KPiAgICAgICAg
ICAgICAgICAgbWVtY3B5KG1zZy0+cnhfYnVmLCBzcmNfYWRkciwgcmVjdl9jbnQpOw0KPiANCj4g
LSAgICAgICBEUk1fSU5GTygiZHNpIGdldCAlemQgYnl0ZSBkYXRhIGZyb20gdGhlIHBhbmVsIGFk
ZHJlc3MoMHgleClcbiIsDQo+ICsgICAgICAgZHJtX2luZm8oZHJtLCAiZHNpIGdldCAlemQgYnl0
ZSBkYXRhIGZyb20gdGhlIHBhbmVsIGFkZHJlc3MoMHgleClcbiIsDQo+ICAgICAgICAgICAgICAg
ICAgcmVjdl9jbnQsICooKHU4ICopKG1zZy0+dHhfYnVmKSkpOw0KPiANCj4gIHJlc3RvcmVfZHNp
X21vZGU6DQo+IC0tDQo+IDIuNDMuMA0KPiANCg0K
