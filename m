Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A657CA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE17510E528;
	Mon, 12 Oct 2026 07:34:57 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 888B710E528
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:34:46 +0000 (UTC)
X-UUID: 61c61bb2c60f11f1b1788b6acf885367-20261012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=+DMRKqfXgKn0yChTCHhUfBwuVKVVAsKSydkPpQYozO4=; 
 b=gmueJOQuQUKNKyvfn6cgtmcx9walNAr7BgTbeljnxM9Cngtdnr5q5N0idPi2GI2ZlSgz0Tb4IWZu1HkZc9Gvv33UV7C7gWoOrUNOSSrC/RFwukn7ey/O+1TE2yufGz6rnWsHKtmX4CmmWbxfMk/ez4Men5MMbJElla4cLUbpNSk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20, REQID:bf70d19c-114e-4d47-9ce2-b3a8fdd707e5, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:291e20b, CLOUDID:99dac151-2bcb-4293-91ab-60717b78e7b4,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 61c61bb2c60f11f1b1788b6acf885367-20261012
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 730991188; Mon, 12 Oct 2026 15:34:39 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Oct 2026 15:34:37 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 12 Oct 2026 15:34:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/dnqSBQ8vLlk6c0aOvYteJ/P4TkJyw/voMPcmppMfsr3q088GfFphn+27bAeug/DlNOHHd7mUbHlzEfghIJKn6VsMcZoqPnP3ldS3P/M+tYkGMISH+nmeIaFBrhfW4UfJihiMqw82NpyY0xhLYXLYRo6+GlBGLRKlOdWu7GVPxxjv2IKJn/HjqKRLxJ9+k1BKhjRMoxJh4VtjtImo1GZCflMwnTFbFA2og6BAov8ZA+C2Cnr1A2IRF3u5fzoJUaPYgUMPIGL+7z0udkkcgCLlm2JlOYDIknBEqwvF6xpxp0nmASMAr3GFH6yWu9/D2O9Yd/c0YhAPGRR004vVsCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DMRKqfXgKn0yChTCHhUfBwuVKVVAsKSydkPpQYozO4=;
 b=uIIbHcyv/3U0Pi392BtJ2ucQBkfMIr3x7GYCyExsJfdo6aHnHJADqQzphHOKR7sDRtLs+NV6vxptPYVJjVfMnPNtQ04vGvc5J1yqHqS4a9AdJfLf+H5/+KkXBwlIgcwucATn2ZuMFjKvWR7PHpe3Jti+ID9NQUxihFNsYujxosIv8jqNfs8lxcNaZx4SxGYCDdF2r6XrO4Tlz/EnwNM/HoxGHCndR7Vy9i2WMyFi6fWmcX2cPOhkufjUFiGsTeYty89/e5Lftq10P+sdLEJpD9NbZQxo/CrnM3ZADSCJz6hPuBa8ONox1oCEQsGClIcU4iEStBlj6ErmapqmF34ZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DMRKqfXgKn0yChTCHhUfBwuVKVVAsKSydkPpQYozO4=;
 b=i5jDmRCckPDpb8AxLVDmRPEpcmlMulnM27cG+GsK9rcSyPto/wzcZ8UspG5A3Jt4bvcLZlzlBPSd/IdajS3WsN7pfYxW3no/tQ4SQp1UAWzapXN8hqCZmAg+CYZSogNymLdjRgVFE/ZdPo5XoOgHtcSM8kq3kBHSulDC2CR1hwU=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by SG2PR03MB6633.apcprd03.prod.outlook.com (2603:1096:4:1dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 07:34:34 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 07:34:34 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "peng.fan@oss.nxp.com" <peng.fan@oss.nxp.com>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>, "chunkuang.hu@kernel.org"
 <chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "airlied@gmail.com"
 <airlied@gmail.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>
CC: "peng.fan@nxp.com" <peng.fan@nxp.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/mediatek: hdmi: use regmap_assign_bits() for
 conditional set/clear
Thread-Topic: [PATCH] drm/mediatek: hdmi: use regmap_assign_bits() for
 conditional set/clear
Thread-Index: AQHdTAAFD0vspj/P706TOdPmONKhDrb5oEAA
Date: Mon, 12 Oct 2026 07:34:34 +0000
Message-ID: <57deb2ae1a6235e9e0b84458ee228b1ce8ed418a.camel@mediatek.com>
References: <20260924083456.461815-1-peng.fan@oss.nxp.com>
In-Reply-To: <20260924083456.461815-1-peng.fan@oss.nxp.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|SG2PR03MB6633:EE_
x-ms-office365-filtering-correlation-id: 8772536f-e9db-4642-8227-08df28334331
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|42112799006|366016|1800799024|23010399003|11063799006|38070700021|56012099006|22082099003|18002099003|10067099003;
x-microsoft-antispam-message-info: 15wJdlPeBKeZHr+IfBH4+mH0eY47DM7p+IFhPvDo159djr4HODce6ebmaHekMD58+CERHTT6biT/+dFO+xjFSsUJ1yVJTW6VHPwUcCLQuS5bC1Pelr0+2VoM6eLbnFJ3BdGAZ3WUorfqsuvKWLE0yJjwCx7cJqnfrrs5Jp2GXOs/S4YjU0+UKDhtlO82msLnzgGKF4R0VEA4C/Rhbfuo8kcuYlK5/Bv/DA4YG+6MF0/qfnOXVzQRUqTKV2qW53oxx1VujL6z/KJYo/h2vXKikCNieZDQH2gTbCNopoeJIz8KhIVbuhapM+8E2MdjhY4yTCBpjooW71A0RRlpOqFu4FKwuf8/6QtcoBaFeRED4MLV7B20X9svPq484QTPK5w1wN0B6wEz71nlgQ3gdq7XrsKY4oHaqtAQ+uFRamysQuUFblvXQo0xpdNIaY8Dj8oKMInTCbW1A9a6GPeEDo7rdJV/ysEU8g6Fh6iQKN0DdF4l7BBNjN67UNlMNxJTKYG5nTQpAwymkJdN3UxYIJeAfNceHVbpwGkNVkvso59XW5tl3qExeUJEafGzzCgBywO++q+YoBiYECwx7gMEawSV+MC6l69JJcP3e7Ba2WZ5BLiTHP9E0jVmwz8v9/QuSr+tfoPVKU5ArHgRS65Y7+IJGVOjydBGQoxypm+hRtgVy+40nRZrYIOYebi69ZCuJV+HFWFiyUHBjrYxSfhwcTuz+uQBDiX8xoR9jfY5SrE6T+k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(42112799006)(366016)(1800799024)(23010399003)(11063799006)(38070700021)(56012099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2J0VFg1VFk2dnJNTWZUOFM3SXR3MTVPZjNvNFdLeXlqREhmZnhFbDFuTHp1?=
 =?utf-8?B?emZyaU5tRUFQZTluYWp3OEdUbFBUdnB3QUFNdS9yVFlVaEhqNFFPaXBNL0lI?=
 =?utf-8?B?aklpY21pbmxNNkFKUTJ4NTlZU3BaUzdyQnRSYXIwamM2WlY2TXZTMjBGRW5u?=
 =?utf-8?B?L2lHS1BSWFFIaEdrVzYvcnVlR2w0SURZYUt1cUJGMXgzeXB0RStYa2V1blpM?=
 =?utf-8?B?ZTZmeUFmeHRYSHg4cUhSZWZZYTQzckFyZkFKVXozTjl3ZmtJaXdqTy9NSmkr?=
 =?utf-8?B?bWFhWXJoM2oxQTJIdzJzR3U0dGJhdUtEQ1QvWkgyMy9iRER6MlhpSHRDSU0v?=
 =?utf-8?B?RGtpTWk1VW42WXZvWjFjYjlEWG9sQmZuaVB6b3NvMFI2UGRyWHVDNDNkeEVH?=
 =?utf-8?B?MFI2SVJ3MGlkZFdRSWs3MWNic0NtM1haTTRqNXdTN3pTd3lPRXN3S0hscXc1?=
 =?utf-8?B?RjdsVGRuV3QvL1ljcFVIM1VqUVNYUVNNTUR2SWNWV2RBYm0vQXdZRUx5YjZz?=
 =?utf-8?B?OTgwd1JYbHB4N2Z6SXRaOGVLUXYxWlZxaEd4YStiV0prblE0QXhTdUR2cmxI?=
 =?utf-8?B?dUhjRUVqb3VMenVQY2ZqZjJtR1NqRkttY2dLUGRZVFMrZkp3NHhCcWEySDZi?=
 =?utf-8?B?VFZ4WUNPNGJCaWdzOWp4UHJ5Qm9VWGlTd0svM2RTYXFYUjNGVzdQMHZZN0g0?=
 =?utf-8?B?Wm5Dek9CV1pON0s2cGF6czJhbnYyaTRkS3VIMmtaM1psSzdQN1p3aU9PUHpT?=
 =?utf-8?B?V0l6Z0VOQkhBOWpUVFVZNzdBWmNvNlE1RldWdmMrZGpHZytOV1ZhZzlHcENJ?=
 =?utf-8?B?QUJXOVpxalAwMStqa2xYdVZRWkxMUzVRclJCZXdKVjBKWStiZ05sM1BhTmdr?=
 =?utf-8?B?a2g5azlyZ2VkOFkvVEYwcHFEdmNLY3hDeHNyWUo3Kyt2T1I0L21HM1grR3d0?=
 =?utf-8?B?aG5ETXNQd1gvZFdsSHU5WHlaeUR5cmFIOWRabkFRK0loaVY5Q1l1bUg4MWdX?=
 =?utf-8?B?UkxXS1lDaTlhWXc5bUk1T2xkNFRoU05KUHI3ajdPcDZVbkp0VWNNZnlaNEho?=
 =?utf-8?B?T1M0ZFdRWVBUSEhZY1VEWmNYYTRrR0c3NDNYK1piejZ0aGpVbXFGNExKd2dT?=
 =?utf-8?B?WHI3QXNYSy9SU3VXdlVYbS9rajUwai9MMDA2d25oRjl5TUlnVlVZMGJTa2wy?=
 =?utf-8?B?Zi9YYTdmbHQ2dWpjbkZuRTRWWXA4Tko4b0tHMVkvTUxUSkRpOXZPWGdIRWFK?=
 =?utf-8?B?dEt6QnpBZkcwa0J5WXUyZVlrSDNoaVN6MEI1VUxqVFFKdXkzZ3JmZ05YQkxR?=
 =?utf-8?B?UmM4bWJjTXRGbGhtTHlGb2dxZDVuNHhEVVNRMCt0MVJyVmNad21LSHRsakNm?=
 =?utf-8?B?WXRZd3RIdDUvVC9Xc1pIN0JCRXl2RzNYY0xUZThPbnV0R0pURTZMTGl0S0FG?=
 =?utf-8?B?QXNGMzV0SWpUaGJQMng0aEdxU1M2dkhWQ3A4eVlta1ZNTlNBNFh0WFV0MUxi?=
 =?utf-8?B?aHllb3VPSFNsT0JXbzM0UTBpU1AvUldMbkd2bytjMCs0WGZURFRGQ0Y2bmE2?=
 =?utf-8?B?OWJhc1E1ak5NZHBYbE1CeCt0N1JBNlZORjdPT3JsTXdoczhsKzFPUklFVXZj?=
 =?utf-8?B?TCtETC9FeW1FampRS0NYc1FiTDl3T2FOK05CVklpUHVVL2RCQURBMnVwZERU?=
 =?utf-8?B?NTROSkRLRmpudkQ3Z1A4TkYzbW1kb1pJSS9vUGZ2NnJhRGtVdEwvR1BNK3NM?=
 =?utf-8?B?b2k1a1Q2ZGhPeEMzQVJnZ1lWWWMrNTJYU240clhWcWN0MzR0Y1Y5YlRhYXVr?=
 =?utf-8?B?WFo0TXMwcjAvU2dzN1dWeDdnWWRGMVZaTkdTZFNoMVpqNW9saGRsWkpibDdU?=
 =?utf-8?B?cU9OYWZCVW15T2U3WmpwcVZHUHJQMkkxYXJXQStYR05MVm53OGVST016VWVs?=
 =?utf-8?B?RkRkV2V4VWNVb1JWeENnUHZ3dkl6eTQ2cjA3ZnZoYWJSOUpGdDBPQ284Nmk3?=
 =?utf-8?B?ZklDUGdiQWFnNlBCazdXQjdqMnNXdWVyNXZzQ3BjSE9RTVc5bUExU0ZBVjNX?=
 =?utf-8?B?V1g1eXYwN1Fob2lMUWw0ZUtXR0lMb3NCSnpXd0h0anRTQjh5Yk04aURUYzRM?=
 =?utf-8?B?a0xjdXpvYi85RGxGOVNkd1RJRExVanpPeXA5Q2pSb0k2dlhCZGVFR1Q1cTZy?=
 =?utf-8?B?NENqdklkajA4U0VaMnpaQ3ZGcHQ4MkkyRHh5ejJoOEw0SGJlR1hmQnF6S2M1?=
 =?utf-8?B?ZWNUVkhLOFR1Wmc1Qk9nR1pVc3ExWTVrTDMyN09sNUJNWlBtYlMxdUhpTEFZ?=
 =?utf-8?B?T295TTNQdTFvTzBlSjBmaHE2YnVzVkN6akl4ZkxPU1AxU0Fzam9Hdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8B7D9881C964246BC87A200C19A5AFB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nBVpohTqvmUrdnRx/rye/YJJFch/L0cDxUTl9PtSj9WUNimU+Ug30GzivbGLTr39XFRM1emjYSIDt1BLDlabMHAAElHp7EEMH8MMCQH2CIGQrZnfwyOFlFv6tPU3DihF7/pFlmk814CIILzB7bz3dRjrwwIwSllSqT3Y2rMVIp+us18EIRQgKbl8SXyKhiX/ucJFG1mTipDVQwAXCkYZC4ECXqzJBrELbmJej/ODIPjSNYC1D7euwRQFBHCvjADp589CNtP13a9pWOulJxHmZyH4MZz0/8gxifQ0QkTnfS93kK7CT/7bcvJgxzQal9gOnpJRX1qvMFczatF5RrErtw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8772536f-e9db-4642-8227-08df28334331
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 07:34:34.5322 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HMFJuSz90oXg8LyZVFhE8sFNc4IrEBJCeghP+Q/T7p7JC4pUvmdqczkS/vul76JnBGiCSwFQ9+3M5P9vsfZ8CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6633
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

T24gVGh1LCAyMDI2LTA5LTI0IGF0IDE2OjM0ICswODAwLCBQZW5nIEZhbiAoT1NTKSB3cm90ZToN
Cj4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IA0KPiBSZXBsYWNlIG11bHRp
cGxlIGlmL2Vsc2UgYmxvY2tzIHVzaW5nIHJlZ21hcF9zZXRfYml0cygpL3JlZ21hcF9jbGVhcl9i
aXRzKCkNCj4gd2l0aCB0aGUgc2ltcGxlciByZWdtYXBfYXNzaWduX2JpdHMoKSBjYWxscyB0aHJv
dWdob3V0IHRoZSBIRE1JIHYyIGRyaXZlci4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBt
ZWRpYXRlay5jb20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBu
eHAuY29tPg0KPiAtLS0NCg==
