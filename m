Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0D4CD342F
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 06:54:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19C9C88668;
	Fri,  8 May 2026 06:54:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="XrGQ4Ctf";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="TKwe0vON";
	dkim-atps=neutral
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2336C10F369
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 06:54:24 +0000 (UTC)
X-UUID: bb2fc4404aaa11f1b96f91537e34a508-20260508
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=Ae8ZM2jdkEo9J8wv2h3T31koaxxBShRHPqruV15KQ1I=; 
 b=XrGQ4CtfBkzpOrE7LrtxRk1v7RxXNBXiIYOutLG6PgXRnXa0J6Zd8o5+iEosuhrAA2xf6iGli99kaBGIkEOWMi1PPnXNQaiA/N5T0HbXPRukSH188bhwYUszK9cOAMskzOVaG4VhI/M/MGhfasT7FQjCP9pu41EaINZfurfK4kU=;
X-CID-CACHE: Type:Local,Time:202605081454+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:111d6cb0-877f-49dc-8677-d4dd32b2184c, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:77810ebf-65a8-4b41-ac18-3671578a914d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bb2fc4404aaa11f1b96f91537e34a508-20260508
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 500824660; Fri, 08 May 2026 14:54:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 8 May 2026 14:54:15 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 8 May 2026 14:54:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqBqiWZRXku5sx5B74A2xiQvLzNaG3FSIqU+4vlQ3+U2hAPPZOe5ivK7lh8V4y4e5/u55cEtaeatolhpsfJ6SgTJKj2gJUQ4ig8WO2I4SQ1HlT+bUPv6o3XylteDF107qBrTU2lKsllv7tJVVyvd6+CAZNZMDph7+7/aqTzAMMzVHBEbxopkgQid9GxtRX5pxFpCaN8Y+f+y79eveBqPYMrhR8bNHTVDZnj9e9ajEyWJlR0q39i99wVQSVGDatxSr3Fvr8bzTMqLwUSMIj86WMba2IeLno/9ZEnuigUanBP8KjhkEvE1AafwJoEdi0Fkvz8f726jM5yoe55ooqP7bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ae8ZM2jdkEo9J8wv2h3T31koaxxBShRHPqruV15KQ1I=;
 b=nofRuUs278QQuIF1BkWajk9dLV4flFkYcKsPYpbzjhhmSSxX/PayRj4PHxUty6bhplZIueLQc2arlBhRihUG6ki9aGTT3i5A2DiClTS6Tym4uElF4j/Nbsij/mk1QccwT+xBFgChKGCNcjf09A4tWBbD8wxED73ghSmH690aiy9hULjB6OMW4SvBVnoqrxS2EVO4uV72r9HFbOeKcDluvUS7V8QnU7fWgWJ+GFUOXdTa7C2KlHPCmxr+7RQLuFgt/g3Fp1ZIjKBuS/uGVD5Zh9sJMyomGORlEFQ7edGzrW5HEKuojjA7ntoxniYS4IpqFgiUAmRI4BXY6vaanVq+rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ae8ZM2jdkEo9J8wv2h3T31koaxxBShRHPqruV15KQ1I=;
 b=TKwe0vONs2VAj/f45B27YieHxmm8FykHT7fD0z68lRhyhin/6qkFNROCo+4Sc5K4s8mWMajEx4Qvc3bVsdkpZFAKmX5uIkbBlpJCmLa4A24vwJXbUnfj8Wg3hurPovnxk3AhhQMLDV5G/cglMTd7cJJyK8Q6yuqKA2XZInJK/NQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB6642.apcprd03.prod.outlook.com (2603:1096:101:7a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 06:54:08 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 06:54:06 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>, "airlied@gmail.com"
 <airlied@gmail.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "shivamkalra98@zohomail.in" <shivamkalra98@zohomail.in>, "simona@ffwll.ch"
 <simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>
Subject: Re: [PATCH] drm/mediatek: mtk_dpi: Open-code drm_simple_encoder_init()
Thread-Topic: [PATCH] drm/mediatek: mtk_dpi: Open-code
 drm_simple_encoder_init()
Thread-Index: AQHcw2GQJ0nehK1HRESTuOaiYKwTTrYD6CkA
Date: Fri, 8 May 2026 06:54:06 +0000
Message-ID: <994eb0bb21a12aa022ea37a2604032ca4a541381.camel@mediatek.com>
References: <20260403-drm-mediatek-opencode-encoder-init-v1-1-7be86241b876@zohomail.in>
In-Reply-To: <20260403-drm-mediatek-opencode-encoder-init-v1-1-7be86241b876@zohomail.in>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB6642:EE_
x-ms-office365-filtering-correlation-id: da9e15b6-f2ad-4dc5-ff35-08deacce9942
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|42112799006|366016|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: wFN4cZPInRcY7fn21Xh1Kp8J0IcSilINk+JyOtAAaiFd2q4TL6/TQkr8aG5feOa5gMun6FYev7YgeG1n7j8CxDTtP8Dvy2aBqZixViiAZDhdxMJGDudNFn+P5PcM8+67zr7LzW5F4A4svL7dUEDlp5jml3GXU4+Nt4A4bWsvf9YRm2ziGeKGbR1BsoYHp1fYgELfLYx7kzM/RQ7BU6NOiIQ9CPDpcC1Bmypo+PGxCi4YMvCQ4Clf3G2RKqArCnIt8DB6N8AaA8qKfGE8O8rCGs5B9nfrndZbVZEvdLMrjDWcDJaeaivXVqNBjpv/mhpL+JIsrAbiSGY754c10nG3Wb9CcQQE3u6pV/dOVksC2hThbpR+IV4Vfed/bCkV91/93kMR32MPMZQdSwzvHlXX3367KFwc0vVhmFumdVDbn9O5YkUoFCFZve0nUu6nDW6vtoyzh84Mx/cizz9wxyATe0mveQyT9fmM+GWlqtwxuLwkHgEr5BxFd8uWURsxt75ReJ1QAKLrl+9KpvZHSeV425cl+izQKAj5afpbHEswWazOEg8IB5mqypDqi4rl3qZHWbeG9si5IRRpLInMYUP2lMLWOUCdoyRumiE2gGCB8PnVsaVFKXPZV41hySjL5SfezVQPIfvtdgbd5nonpRHYUZ6mj3E88zPp6qNQw+9/jERI+p76N5v1w6822nK0ubKRWt4PT7UdVSTztihL3ga4QpRd3wqDHe2rhGy3EHKk+s5exK1rdLb6OSTmbjrnqrKW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(42112799006)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHUva3R5ZEg4RkxBYWlzUFgzL2trL3pFdkFTR2R2c0FWZFRKYjJ4ZS83QXla?=
 =?utf-8?B?UHhlUzRrMkdRUEZ1d1Vmb0lveFd4Mmk3SjJuTmNxZitmQ0V2ckkzajg4eGhw?=
 =?utf-8?B?K3IxQW1xajhFVFJhcjRWd1RiUjMrVVY0RFpNZno0bXA2R0dQMUpGa25YVFBq?=
 =?utf-8?B?elU5cU52dTI3aksyb3lIQzZ0V0J4NG9yUDQ4SUdjWWQrbkhLTVkvRDBsWmRP?=
 =?utf-8?B?c1lVaTFzeFNBbkl0ZW52cFZCM0V5aE5aRGYxMnloUFF1SlJPV0FFVVZvT2lr?=
 =?utf-8?B?UmpxZ0VyQWdZUzZuNTB6OS8rTzNqN3Z2VWFnN3lSeG14Y01UNzRoN3lSY0JL?=
 =?utf-8?B?b2U3WHFvRCtCN3FFQWhXYllVb1hpOElyYmpwUlF5UFZVZmxUMU0xYTBHK0Vx?=
 =?utf-8?B?VW9HV2xqNnRydG1zV2hvNnI4ZzJ5RDhRSzEyKzl5cUt0QVRjeDZVUW1DS0xR?=
 =?utf-8?B?TU5vMW1BZmtDSkhCbWF6VTBBWUxNcDBHOXI3NytCYlkybUcyZWtZRC84THN1?=
 =?utf-8?B?aTA5b1M3NVFpa09BVmNnS0NHd2lHbkFEbGx0RElSbDlEQTBlajV0NmE5RlMx?=
 =?utf-8?B?KzJ0NUhTY3RKOFJVYnB5SllldG5ZdTZGRzUwdWh3OTZzVGtTVEY4TjVkOXkz?=
 =?utf-8?B?ViszUWF5QXpHL3k5QXl0WTNmclVOREZJcFVLR1Bjbk9Sei80eFkxbjJJZ3NU?=
 =?utf-8?B?MTVFbTdDL09SQ25pVGhOZkEwZ08xdFlZK2F4dXpTNCtCWFJURnZuMG1Pak9C?=
 =?utf-8?B?Q0ZkdHRhSWR3OWxQUVdWUEhyMm5JWG4ySERzTGVPcEd6U3Jtdmh0cUl2Wkxh?=
 =?utf-8?B?eGlGdHdocWgrMmU3MkZQbDBpakdlekNLWUI5cXg4V2FuWmJrSmE4VXVEbXBB?=
 =?utf-8?B?QXZHd1ViZittcnk1Qks2R09FTVFORFZoZWdYTkIrOEtHbTVBT0dIKzFXV3ZK?=
 =?utf-8?B?aTJHcWNZbGpUelhHRTNtQjMwdXZUWUtRVFZMdHBDbjVJVUxhbmhCSzF2bVA1?=
 =?utf-8?B?Qmg2R041bFdpcVprOE9EOGhCbytzT3hPQTM2N2dya0o0dWZPYnNwbDRGVEhM?=
 =?utf-8?B?SUhJY3RmZXZEbUxTc0tudEdWOERrVFVlS0pDcjBEVWY1NzVTS0JZOUk3dlFL?=
 =?utf-8?B?L2ZJMzRlRTVnZ20zYWNLZWN0azVRK2NCK0Q2cUticnRTK0dCMDZuVFJ0ZlVv?=
 =?utf-8?B?N0NFRHVJMTVSUElCcTI4aEVrVXAzVXpMSEsxMzZhbkZSTHNFb2JQMitLTnBx?=
 =?utf-8?B?WjRaVmxNcDUxNGJpOWNydTZQUFNQbGxoVW5zREhsR3ZKNkdSVm1vZFA0Zy81?=
 =?utf-8?B?OVVPSXBweHdqT2E5MHIxcThaUjJFcmNOOU9JNGZzS2JXUXAvb3hSUnJWejhF?=
 =?utf-8?B?cVM1bEdLYTRJQkRNMVAzTEIwSVIrUXpHcGpySzVFdmdtU0VsbjBFbEoxRU5I?=
 =?utf-8?B?NHR6ZGN1Nkl4ZDkwbzRJRmd0RnFGckxEQUJ5emFid09OZThZbFJEazlnK29l?=
 =?utf-8?B?eHdiaEtsVjR5Ymw1K3pUMTNoNWtMN2x3dGVJQ2FJS0VUaTh4dnJrK3VtOUxY?=
 =?utf-8?B?eG5yeVpIeUp1amF0ODhubncra2lnOFN6QUNqdHBzeVhSTGFzU1IwS3BmemFI?=
 =?utf-8?B?Z2llblF3cmttWW1KenhkT1VIa1V6d1VxODgrd1k1NFc4NVlPazZXL3lwWEhx?=
 =?utf-8?B?VWJaNDB2a1J0bmthYWJyQkRzR1F1STdlbTZJVFhkdlJpdmJWVFZmZnpRTlNa?=
 =?utf-8?B?NHhPalIrQmlqaE1lM0Q3UmhrWXpOQmFIUGFrNXY3Y2hZaDNTUXhaYnhwZEl0?=
 =?utf-8?B?ODZPbXRMZmozQXRpL1VrZm5wR1diWXlHRWVjeEhFaVQvWGlwV1ppL0ZlTUIz?=
 =?utf-8?B?SXFVSFlLcnVpQmlCYVRKOG5VUEZxSXM3dlRHSHpyNzBaczlkekFZcVZ2ejBl?=
 =?utf-8?B?Y1AwMlpXaGxicjhEZ1QvREZSS2dHVE1KWUVPMlZMRHdvcFBGUkRRR0Y2Vy9C?=
 =?utf-8?B?ejJhYkczQVloMWNBOFhtV0l6S0c5YWErSGIvL0ZyZE4vb3QrQUh4WTZQQTVB?=
 =?utf-8?B?NXVNM2FHcSs4NHBPTmxGaGRtQVFHdnBibGhNblN6d2wzZGVSdiswUXkvV0xw?=
 =?utf-8?B?RHptUHNBNnM0UEdRM1B3b0drRDF3VXB5K3JEZzloQjBHVWtpaFpVRDFnZXdr?=
 =?utf-8?B?RWI3ZjIyR0M5YUtzMmU4YWZsUCtDZE5VYjFlczdVYVVtYytrVFZOOVlaMXNF?=
 =?utf-8?B?bmZTVTlNeE9nS1NsVFkxVlkrQXAxREdxU1hiYi9CZGd1b0M3dW1UWWhreFQr?=
 =?utf-8?B?TUZXRjdLTnhjTkRrb2svUnZ3RWh0d0x0aHg2eWFEbjZMWVpFSThBUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C0DE44DE497CD468CDFA809D33EE7F5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iWHaDuPzqBP8JmDGNm6B3wvosqWLr6J0BJuvCFjmxDiUcMOD+doO9Evl8xVdyFdGpJ2GNj2ED9E1d42lG02RLsk2ShhrdJgWzr3FS3SUBcDzwSaDxcX0gBY1iH18pjb5RCcj7Xxw8LCdoYUwglMm5DnX/UNQMrKR9jVg/zYYbt2HHsqEwa4hUN5qlqgWIzgjJmUC7aAtS0znvxRvIRcy7yxtnqjxj7MYrclht0OIt6Eb9RCxCqkQJArhNCsF5FU3slmG9WoFyETXYRaFx2D9seLuCuTG9YdHW1Ti083PfRbrwrZDsHYrfIvuMe32sXC9dLe7wvPzY0hSVOF64XOZBw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9e15b6-f2ad-4dc5-ff35-08deacce9942
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 06:54:06.7666 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HRzD1zjg38ukrOSRDo213/dyBVPmQDcUL4uuPIao7+bFJhA+4NZzVdnSUJKFgnSIfn2VAPtr0ijkXItNRUR5Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6642
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

T24gRnJpLCAyMDI2LTA0LTAzIGF0IDE3OjMwICswNTMwLCBTaGl2YW0gS2FscmEgdmlhIEI0IFJl
bGF5IHdyb3RlOg0KPiBGcm9tOiBTaGl2YW0gS2FscmEgPHNoaXZhbWthbHJhOThAem9ob21haWwu
aW4+DQo+IA0KPiBUaGUgaGVscGVyIGRybV9zaW1wbGVfZW5jb2Rlcl9pbml0KCkgaXMgYSB0cml2
aWFsIHdyYXBwZXIgYXJvdW5kDQo+IGRybV9lbmNvZGVyX2luaXQoKSB0aGF0IG9ubHkgcHJvdmlk
ZXMgYSBzdGF0aWMgZHJtX2VuY29kZXJfZnVuY3Mgd2l0aA0KPiAuZGVzdHJveSBzZXQgdG8gZHJt
X2VuY29kZXJfY2xlYW51cCgpLiBPcGVuLWNvZGUgdGhlIGluaXRpYWxpemF0aW9uDQo+IHdpdGgg
YSBkcml2ZXItc3BlY2lmaWMgaW5zdGFuY2Ugb2YgZHJtX2VuY29kZXJfZnVuY3MgYW5kIHJlbW92
ZSB0aGUNCj4gZGVwZW5kZW5jeSBvbiBkcm1fc2ltcGxlX2ttc19oZWxwZXIuDQoNClJldmlld2Vk
LWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFRo
b21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPg0KPiBTaWduZWQtb2ZmLWJ5OiBT
aGl2YW0gS2FscmEgPHNoaXZhbWthbHJhOThAem9ob21haWwuaW4+DQo+IC0tLQ0KPiBBZGRyZXNz
ZXMgdGhlICJPcGVuLWNvZGUgZHJtX3NpbXBsZV9lbmNvZGVyX2luaXQoKSIgdGFzayBmcm9tDQo+
IERvY3VtZW50YXRpb24vZ3B1L3RvZG8ucnN0Lg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHBpLmMgfCAxMCArKysrKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RwaS5jDQo+IGluZGV4IDUzMzYwYjVkMTJiYS4uNWI4M2NhNmFlY2IyIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHBpLmMNCj4gQEAgLTI1LDggKzI1LDggQEANCj4gICNpbmNsdWRl
IDxkcm0vZHJtX2JyaWRnZV9jb25uZWN0b3IuaD4NCj4gICNpbmNsdWRlIDxkcm0vZHJtX2NydGMu
aD4NCj4gICNpbmNsdWRlIDxkcm0vZHJtX2VkaWQuaD4NCj4gKyNpbmNsdWRlIDxkcm0vZHJtX2Vu
Y29kZXIuaD4NCj4gICNpbmNsdWRlIDxkcm0vZHJtX29mLmg+DQo+IC0jaW5jbHVkZSA8ZHJtL2Ry
bV9zaW1wbGVfa21zX2hlbHBlci5oPg0KPiAgDQo+ICAjaW5jbHVkZSAibXRrX2RkcF9jb21wLmgi
DQo+ICAjaW5jbHVkZSAibXRrX2Rpc3BfZHJ2LmgiDQo+IEBAIC05OTMsNiArOTkzLDEwIEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2JyaWRnZV9mdW5jcyBtdGtfZHBpX2JyaWRnZV9mdW5jcyA9
IHsNCj4gIAkuZGVidWdmc19pbml0ID0gbXRrX2RwaV9kZWJ1Z2ZzX2luaXQsDQo+ICB9Ow0KPiAg
DQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGRybV9lbmNvZGVyX2Z1bmNzIG10a19kcGlfZW5jb2Rl
cl9mdW5jcyA9IHsNCj4gKwkuZGVzdHJveSA9IGRybV9lbmNvZGVyX2NsZWFudXAsDQo+ICt9Ow0K
PiArDQo+ICB2b2lkIG10a19kcGlfc3RhcnQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgew0KPiAg
CXN0cnVjdCBtdGtfZHBpICpkcGkgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gQEAgLTEwMjYs
OCArMTAzMCw4IEBAIHN0YXRpYyBpbnQgbXRrX2RwaV9iaW5kKHN0cnVjdCBkZXZpY2UgKmRldiwg
c3RydWN0IGRldmljZSAqbWFzdGVyLCB2b2lkICpkYXRhKQ0KPiAgCWludCByZXQ7DQo+ICANCj4g
IAlkcGktPm1tc3lzX2RldiA9IHByaXYtPm1tc3lzX2RldjsNCj4gLQlyZXQgPSBkcm1fc2ltcGxl
X2VuY29kZXJfaW5pdChkcm1fZGV2LCAmZHBpLT5lbmNvZGVyLA0KPiAtCQkJCSAgICAgIERSTV9N
T0RFX0VOQ09ERVJfVE1EUyk7DQo+ICsJcmV0ID0gZHJtX2VuY29kZXJfaW5pdChkcm1fZGV2LCAm
ZHBpLT5lbmNvZGVyLCAmbXRrX2RwaV9lbmNvZGVyX2Z1bmNzLA0KPiArCQkJICAgICAgIERSTV9N
T0RFX0VOQ09ERVJfVE1EUywgTlVMTCk7DQo+ICAJaWYgKHJldCkgew0KPiAgCQlkZXZfZXJyKGRl
diwgIkZhaWxlZCB0byBpbml0aWFsaXplIGRlY29kZXI6ICVkXG4iLCByZXQpOw0KPiAgCQlyZXR1
cm4gcmV0Ow0KPiANCj4gLS0tDQo+IGJhc2UtY29tbWl0OiA0YjljMzZjODNiMzRmNzEwZGE5NTcz
MjkxNDA0ZjZhMjI0NjI1MWMxDQo+IGNoYW5nZS1pZDogMjAyNjA0MDMtZHJtLW1lZGlhdGVrLW9w
ZW5jb2RlLWVuY29kZXItaW5pdC0zNjMzNmU0YzRmZjMNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4g
LS0gIA0KPiBTaGl2YW0gS2FscmEgPHNoaXZhbWthbHJhOThAem9ob21haWwuaW4+DQo+IA0KPiAN
Cg0K
