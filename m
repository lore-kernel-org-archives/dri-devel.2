Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322B2C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EECC10E6C3;
	Mon, 20 Jul 2026 06:47:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="ZTudHHD+";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="qd6QIHQk";
	dkim-atps=neutral
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59DB310E6B9
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:47:52 +0000 (UTC)
X-UUID: ea1c58aa840611f1b1788b6acf885367-20260720
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=IDFN6HS6yozfKeTEzF6W9ElXWk6KvNV78YmfnSJTE5Q=; 
 b=ZTudHHD+mz1AYCX59rroVmCg37XGCQNaaI+VNzST/FJwzVwSL/cyUY/TejJkmP6o7LKx0CGQMNTrsdQ2WzuCBTq96Qa2ts2xEJRkzCX/owgtaTubxCj8XsEdyt9hQeluDmIzu2MOPrTwQ3XiUjnfsyIcH89HAYCNzVuS7UjxZwM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18, REQID:1dc93d76-6787-4a9c-b03f-896f19342faa, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:8a735a6, CLOUDID:d522b05f-762a-4584-baab-4eebe609beea,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ea1c58aa840611f1b1788b6acf885367-20260720
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1425526843; Mon, 20 Jul 2026 14:47:45 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 20 Jul 2026 14:47:44 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 20 Jul 2026 14:47:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxSpa9cm4qQinKtTECh1aOD6lc8q5PsHghh4jick3qHBa7ZrfCzgeQPFNOHXdLswE9iIDcCpZ1TFTKhdECi6dj7QCDFY8sqafr0pjbQozPS72N1ERu7RDnHkJYfMpjUrIgVwljnZmiMTn6r33IHFksyj9cpxEcjjl+M9h0IYJTLHHXjYuIu0rCP4zseNsUdujk8vedHRT51pf5wwwXfMhzf/iW14uT/E5eSgRS6i6Gt+BUUSZczXib7YHF9VuiSAp5TS60wvXhk9VdQWjNETkt6HnMZKpg898C9wYK+AjS4pi5loxiPY0KGt2tW+y/PkElojejBQstHbowaAs0kWPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDFN6HS6yozfKeTEzF6W9ElXWk6KvNV78YmfnSJTE5Q=;
 b=D37ZCaejiA7GrVHfxW+cgF8bGqhDib6IXCkbKYbiSZ3EL4ZqLfzFYxH5kPsjfWZC7K5dem6MUlruYEUaygcwMlgOnEg+ZlV/cpPP1u6bZ2/XcxpEDmrqSQ8hnSZ2h0lj0vhkpMexqXVNc/ZBvohv5mLl6xmbxnJXza3iC2ViXa6fP5iRro5FgPxwzd0MKwjOYhtsJKRxaaTXeBVwOH/NPSxtGgiZKjp4Qa4EAS8ZShqNIhBtpmI/bydgV6m0ChgymgxNVbwPZBj/Qx9QwLlojJDM0LS2ELD/entu6aMy6xIWMiGhWmsQZfi3ydttRXJxYxa27YkPddcOg516CR/nEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDFN6HS6yozfKeTEzF6W9ElXWk6KvNV78YmfnSJTE5Q=;
 b=qd6QIHQkG7dl8ye56c5KQuZW0ZoozDGCAUKIvtgtBVfQ7YjTqbm67lqcr/fmJ6orhgXhuam/VDqAEN1y4xoNTot7mPryv3KO2/gYnUuISrGarLNefbjHh1w5k5/EUufPl+7zsC/G7m1SE95xi2P9CX5qpUoJ2aXZU36oBn5sC2U=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB6880.apcprd03.prod.outlook.com (2603:1096:101:b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 06:47:38 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 06:47:38 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
 <chunkuang.hu@kernel.org>, "ruoyuw560@gmail.com" <ruoyuw560@gmail.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/mediatek: Check CRTC state before freeing
Thread-Topic: [PATCH] drm/mediatek: Check CRTC state before freeing
Thread-Index: AQHdDiItTerlYerI3Uqs6q60L1QbUrZ2CwoA
Date: Mon, 20 Jul 2026 06:47:38 +0000
Message-ID: <f2ceaf2a6e43a05fc22350f61e4c072679f0eccc.camel@mediatek.com>
References: <20260707150528.2270739-1-ruoyuw560@gmail.com>
In-Reply-To: <20260707150528.2270739-1-ruoyuw560@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB6880:EE_
x-ms-office365-filtering-correlation-id: 71b59523-b049-43a0-888b-08dee62aca2a
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|42112799006|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: Fa1GgVlNu6Wmh/74k2UQVMn6Ssvv6XH7+In3M/VzA6AwafJ3E3yW9D8QUfFJbw+V5jcemXXrwd1ULA20C88708/MpXlZb2CWVbbJYlQNzxPgNjJudvSvrI5d+E1/mTo74Oakw613qyLM2CDGYCkrlC6Ldq+bsSOwcH2jQyt9XdqgtKbZcCLQ166jrRpRjBqUKo9fgsr45Q4CtHcSEZ+uVVKa8YS8NGWGvODLIAqyi61Zk7FxIwsdqArrrrGSIs5Ch75YX7xj0Ig4dtNtPyq6TV+lFeYaw2P26wRFF8xLm/HG4UXlC3uot9EckFNOZQ9e/O7+CA/r+NmPDDMuWQJEGJ2hRsc5W8LyPwmtH/6BGpukbV1rJ0D9B1VgX3oTQE5No5KZ6faltGkXPbKLel79N6wv7jdsjt3QZfhkgC9SqNhgWZjfBWg1kN0YP0D/Rrbb6dsJoQ76RwO3EWfJo61ZLea0R6uynLjNhV9g0v198SLAi5TCr+Kir/sZArEB648QXpqUkHsfnNcaNc4GP0MA2ZFClKQBWzRr7X6p+NebU2AYW22MLjK7NkijLuaS6irB5wOobPlzIHICp8DgI/q2cy27ra/kRdGycCXpoiHzKpRZINYPfggAil2bUIOiR2ksUD++4RuAT1+7bNcrs16ylT4lDraB+TAiUktc667lPxuDCguDlvdGz0cEUzqt2Oj20EV3xyJDgHES9Mgvgfp8NEtQWcad6uv5eXCFt7NWnMo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(42112799006)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekZDSmdXQ2ZHRi9URjIyR1N0WTd3U0FIYzJpTHJUdlVKNVhFYlVoUExQZkhH?=
 =?utf-8?B?b2FvUXNDYjNRckY2WFc5bFNIUDJDMHN1MzVaTEI4aUJLZE1SbVo1V25vWjkx?=
 =?utf-8?B?NmFNcS90QnJlMDhkdW5jUzM2dGUzQTJHbjh4dGlhQ2JyQVZaYUg5QUhSQlVh?=
 =?utf-8?B?dUNBVTJmdUVxQ1NIZ1lZTVJWby8weFk3TzJXUmh6ek55Tld5SWZsVmNucFpS?=
 =?utf-8?B?VTFnTERmY1BndG81VG0xNFc3YVBnemlFOVhKWHBScHBMVFZyelp2MkJianQx?=
 =?utf-8?B?cWJoM20vaFpkdVZ6VjRmcXIxNHJSYndxaDdBeWNrbEc3MFRvRUJWcUdRU3Zz?=
 =?utf-8?B?c3E3K0Jnb0JxVzhVcVNFc1JIM1YyQUdjVU9GR2lacS9VNW9wajhZb3h6ckZw?=
 =?utf-8?B?U0YxcFd5dHMyUTBnVkNOeUtURGhPR0IvL3MvaUx6N05SanBObmZIOFpOMXFU?=
 =?utf-8?B?WW1MdHVoZlZJcm1kMjVGcFl3b21xd3A1STBYVWZBWFRmY0czUy9PaUYvZXNN?=
 =?utf-8?B?RVRodnhoVDZyTUpzSUQyWjhSR2wwRzU2NW4zOTRteFFTblVuSkNXLzBWdURk?=
 =?utf-8?B?ZkdiYWFiQlM3eDdPMHp5WXZyWkFTRkVHOThmU244azR5K01UUjVYdlU5cUJV?=
 =?utf-8?B?UitmTHp0U0pyRUx0SFNOcE5DUFQ3R045VGZwY1psdEx4YmY0M2Y0ZmpOOGNK?=
 =?utf-8?B?WGkreGtSeDRSNlpnQmtSNlQyaTZhNWdaTmhDQ1hBN3VVMHBscnVKblNjODd0?=
 =?utf-8?B?NVBjcEFoNDRWcHdyS3pkZk9oc1V0RnV2K2Vrakd4SSs1MmdHak43UGs0YnB1?=
 =?utf-8?B?QmFDZ1psTVpwMlZrZHY1elJlRlIyUjVjb25xa1FKVmNhMlRiam5qWFVMVHRO?=
 =?utf-8?B?UERSNG4ybWtERXM2M1diaXNJZ1kzVVdZUkxTWHVRMFdnR3ZXL1ZhWnREN2xP?=
 =?utf-8?B?K0ZXM3krTjBXM1lzNXJFNWl0aC94cHB2OXJqc2xTOEU1cUZYOUh6cjNXKzI2?=
 =?utf-8?B?QmxMZUpKMWV2akFabXc5UytBK0YvWWF4aldtbHJHcGNtaXB3SnltTzZXMEd3?=
 =?utf-8?B?VmE2TE9WVDRVNjRySUEyVXA4eWlUMWNDRkZZbDUzQSt1T0NuWi9zNHJBdDN0?=
 =?utf-8?B?SWVTZmlIeEt3Z25YMFczeFAwQTdsWkptTlphTlVoWjBDemlORG81b29FNUhr?=
 =?utf-8?B?UHFmNjBpcnd6SUY4eEhSeWQwelZxeUhzNlNjcXZ1K1FQb1BtU3k1Ly94TXNr?=
 =?utf-8?B?aURXVE1iLzAyOE1VdWlJYkIxSmd4OXNBUVhZT0FWV2phNVRNeTFOUWpNWTA0?=
 =?utf-8?B?dkcxMXIxcFZaL21sTEYrOWNUMCtUbkdadWs5cmYrRGhXZnF3VGpPeHVvWUVz?=
 =?utf-8?B?bjg5SGxRVTBGNlFPN1QrNXB6M05JMk5zdGk0TzdKVHY1bStDRWQ0T1l5c2lW?=
 =?utf-8?B?aEZFWGVkUzZkYjdEQ1V0N0FTaFBIbDJZeWZoOVYwd3g3cUo3c0RSZklmOFBO?=
 =?utf-8?B?WXBaOElkYitrci9naHdMTTZtWkRNdGc0K2pnNU1zZFRpTXZkVGszeStzdHBV?=
 =?utf-8?B?OFlYdFJQczRGcENtbWFmQ1RvOUNoWTRtUVVieTM2b3RxSmZJeTMrMVdoQmtM?=
 =?utf-8?B?M2swL2RzVXBkME9YZVRZVllkaFhUdU1IdlNtY1YxN1doV2pnbElmWnJ0bStp?=
 =?utf-8?B?WWYzR2hXM2VaMXFZVFR2Mmw5OTZpS01DRlBVVXV3SVpiOW4xT04xd2F2cjNP?=
 =?utf-8?B?MHZORkFWKzA1T0Y4SmNMeXlsUmthS3krMGNvcFZ3MkszZ0R6YlI1MjBRQ2dJ?=
 =?utf-8?B?TThSVHNENEMxTGd1RXpHbW51UG5RYmFnZXJxckVuMkNpaHBGUkwvVURxdkpP?=
 =?utf-8?B?WjhvWGxPbllnNEFRd0ZvWEUvc0RyQlcwbFllQmUzbWlqalYybHlsYmdpSkNJ?=
 =?utf-8?B?YkI2RDNaaWlCZmhqTjdVeEFKakJqaG5EZkhvQnZYTVZXUzZQTVRTbmttRmlt?=
 =?utf-8?B?RUdkelYydzNDZkYxVXdjekhXT2xMdS9EODZOc3N6MnFXQUVUVFJCcWZQQklP?=
 =?utf-8?B?aGRJOHRYcENlY01oRitLSTIwQW9YLzVoMkFBaGJvYW53eVFNL2kwb3dNRzhU?=
 =?utf-8?B?Z0FGdGFMbXRZbEp4ZUZxcHhpVVB6NDhxV2VheGQ2M29LNjBsZVlqVUtpdFZy?=
 =?utf-8?B?dGdmMzdxVkI2cjlTYmJvZEtCQSsvVmk3MjBwOTNndEFBSi9EZnJXdGFYT3Z4?=
 =?utf-8?B?d3VYYkxJNG1ySmFRQWhhcmwzSmtadGNuOXZkS3lhdzVBUzQrdVdoNUlRUS9k?=
 =?utf-8?B?aDBzTUFidUhqNktwcHc3UzNlYkROeGZrWWtIVzN5VnhTeXJ0dGp6QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D715E29EB5C8024FAC96C136462E3CD1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sk2cEkNa+picXl7XqVGSmFTyJeINDoptqcfBf2q5Y6SCeNA4N8CMeCideIKHUh3oU1qCCXapIuWhhnMBt7+TUUVgoGOfHaoIrmnJKDI1HnMHOe5yqmXBAfGUkPPa7Y+8tkFcflA0VUGeXAx1GzXI2RlLRwajdKOCJYvKNa4MpRPPRxn6QzC0B/0p7cs4ot9maNw0nBxZWDQoJuyplWOsXzgzjKmlxtMV7kZ5fYDWnvQj4Zy8bxQOtKYVwb5nqLoXLJhpJxXAVYHeTrATsQ+yQoPcu0VQmOXnte1c3vMQnN9m6+cC/PBMaWA7DJGJWNiB2PMYvfAK6UODAXusHvgl/w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b59523-b049-43a0-888b-08dee62aca2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 06:47:38.5548 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TKxtpnjugDC0IEkAvt4xa/2jYbFYtklhzcdhRz+trXsyJmVy0cHEEajTrvcekcY8mFlfjxtkTEdQ5T2FARKfNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6880
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

T24gVHVlLCAyMDI2LTA3LTA3IGF0IDIzOjA1ICswODAwLCBSdW95dSBXYW5nIHdyb3RlOg0KPiBF
eHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0K
PiANCj4gDQo+IG10a19jcnRjX3Jlc2V0KCkgZGVzdHJveXMgdGhlIGN1cnJlbnQgQ1JUQyBzdGF0
ZSBvbmx5IHdoZW4gY3J0Yy0+c3RhdGUNCj4gaXMgbm9uLU5VTEwsIGJ1dCBpdCBhbHdheXMgY29u
dmVydHMgY3J0Yy0+c3RhdGUgdG8gc3RydWN0IG10a19jcnRjX3N0YXRlDQo+IGFuZCBwYXNzZXMg
dGhlIHJlc3VsdCB0byBrZnJlZSgpLg0KPiANCj4gV2hlbiByZXNldCBpcyBjYWxsZWQgd2l0aG91
dCBhbiBleGlzdGluZyBzdGF0ZSwgY29udGFpbmVyX29mKE5VTEwsIC4uLikNCj4gZG9lcyBub3Qg
cHJvZHVjZSBOVUxMLiBLZWVwIHRoZSBtdGsgc3RhdGUgZnJlZSBpbiB0aGUgc2FtZSBjcnRjLT5z
dGF0ZQ0KPiBndWFyZCBhcyB0aGUgaGVscGVyIHN0YXRlIGRlc3RydWN0aW9uLg0KPiANCj4gVGhp
cyBpc3N1ZSB3YXMgZm91bmQgYnkgYSBzdGF0aWMgYW5hbHlzaXMgY2hlY2tlciBhbmQgY29uZmly
bWVkIGJ5DQo+IG1hbnVhbCBzb3VyY2UgcmV2aWV3Lg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNr
Lmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gRml4ZXM6IDJkMjY3YjgxODk4ZSAoImRybS9tdGs6
IFVzZSBfX2RybV9hdG9taWNfaGVscGVyX2NydGNfcmVzZXQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBS
dW95dSBXYW5nIDxydW95dXc1NjBAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfY3J0Yy5jIHwgNiArKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19jcnRjLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2NydGMuYw0KPiBpbmRleCA4ZTU1MmNkYzNiNTNiLi45N2UzZmY0MTJlNmVlIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NydGMuYw0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NydGMuYw0KPiBAQCAtMTU0LDEwICsxNTQsMTAgQEAgc3Rh
dGljIHZvaWQgbXRrX2NydGNfcmVzZXQoc3RydWN0IGRybV9jcnRjICpjcnRjKQ0KPiAgew0KPiAg
ICAgICAgIHN0cnVjdCBtdGtfY3J0Y19zdGF0ZSAqc3RhdGU7DQo+IA0KPiAtICAgICAgIGlmIChj
cnRjLT5zdGF0ZSkNCj4gKyAgICAgICBpZiAoY3J0Yy0+c3RhdGUpIHsNCj4gICAgICAgICAgICAg
ICAgIF9fZHJtX2F0b21pY19oZWxwZXJfY3J0Y19kZXN0cm95X3N0YXRlKGNydGMtPnN0YXRlKTsN
Cj4gLQ0KPiAtICAgICAgIGtmcmVlKHRvX210a19jcnRjX3N0YXRlKGNydGMtPnN0YXRlKSk7DQo+
ICsgICAgICAgICAgICAgICBrZnJlZSh0b19tdGtfY3J0Y19zdGF0ZShjcnRjLT5zdGF0ZSkpOw0K
PiArICAgICAgIH0NCj4gICAgICAgICBjcnRjLT5zdGF0ZSA9IE5VTEw7DQo+IA0KPiAgICAgICAg
IHN0YXRlID0ga3phbGxvY19vYmooKnN0YXRlKTsNCj4gLS0NCj4gMi41MS4wDQo+IA0KPiANCg0K
