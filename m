Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD08606A327
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=KITex+3Q;
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-IMGTecCRM-onmicrosoft-com header.b=DS4vOiUF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F6B10E31F;
	Tue, 10 Nov 2026 17:36:10 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9138B10E1F7;
 Tue, 10 Nov 2026 17:35:59 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6AA7VWU3535336; Tue, 10 Nov 2026 17:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=/mJbnuQWGI10azK9GHasPnxfGlZxbkJRRABMbaFVeeQ=; b=KIT
 ex+3Q5HNwpoofqDOdaWUPNAH+p1esQDWj2epXMk8DndE2frOboixpbczk9MPlKAz
 M0MXRA5bQEISHtqW+I85NddN1I2OW++gXd2SGpUnIS8A9vdKWjFlOyzOIjmdzMxD
 26Tau4kKQsg2EZXSSVYDfW7cET5TsyrjPBSm+jUjfT4CC/KU7KBWVbqItw3JZgpg
 NbA/l6dg1MrujBYeHRtsGH04RuVhrtahtqVbFqkptEEQjB5MlHHuzjtsR5b9d0Zv
 ZjC78/0+Lh/WG0fEzf6UYhecR3qB6FRksTmqXzLIircBUvG+W5AngDC5CNaaHmac
 o1kfpvLfisnpRqJS4KA==
Received: from cwxp265cu008.outbound.protection.outlook.com
 (mail-ukwestazon11020097.outbound.protection.outlook.com [52.101.195.97])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hu8pn953t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT
 key_exchange=secp256r1); Tue, 10 Nov 2026 17:35:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CA454zLpWlCydaQnpcxIsiihgLwZhUgzDMkP0U3sgRLOhgTZVXq3D7aOV8SyUu/wng3oDxxsv6DOmz9/YOtfW01wqczDx//j8lchVWtdhfs6sAQi/ZZ7tihvUhNvGU9q55Gw7g8QmCQgfRFkPxp9XIdMYlvDEOKf6rOCet+9Tv+WNg0L7OrXhnzpDF21ZEg3Smmo5mA+xongJMaKOnhxjHhqxlI9ZtmE7pV/HsWNT1WAjRkOgTfcOgf2DE0PmmFkNhUpgHvLuE+R9I3zmqGe+APqRnKPGSF3Bj0j9Bp5k5l46eHnJHOlJIQOtXZNt0i+eW9eNFAocj4dKf5HD2307Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mJbnuQWGI10azK9GHasPnxfGlZxbkJRRABMbaFVeeQ=;
 b=OPalNXEEuJ9HqWBdoZnv5Zpk6NQmV19zJptBDAPMk2vRKIT8/Y0j35mVz7Q5IUkhiA8eem04fnC+sgWeaa2TaXt6U9D8Xc0UJUc3XMctxGdDfLo8iTHKTWVy51LN4uZbz34dNK+npCXT1VIzks0tzssv9L1fONtLXQec+iHgpbfooylH1oCDoj6BJcBND4YOWDSePOTLQFadfGfRjqxIhZWKAx6LbcYO9g2O4ve8mb+0xoi7uwZLSjETxf+ET61JmF3g+qT8mHhh7ArcGqCOenzmQH6XuMlNM9xo3CL1cOUmRHlxNx0bwjUfIXW5+eySbYIlxJxcc6SFsGqNOM3e3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mJbnuQWGI10azK9GHasPnxfGlZxbkJRRABMbaFVeeQ=;
 b=DS4vOiUF1VsJVmefRb2lH3/FkF2ANXUll11PjQfKTz2OMfDt8Gk7VCPlXShWEbdHe8T2Q/henMERhWl0+Gn1OHKEj6uMm1q5tMSPkJCKUglKJu9X+wX8wyuiHXAjyrtt4/5gkmGMHLoYGU5Coag5E4DA9wWeO7YgslovLTWoTd4=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by LO2P265MB3466.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 17:35:20 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%6]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 17:35:19 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>
CC: "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Frank Binns <Frank.Binns@imgtec.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 Brajesh Gupta <Brajesh.Gupta@imgtec.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>
Subject: Re: [PATCH 0/2] drm/imagination: minor code improvements
Thread-Topic: [PATCH 0/2] drm/imagination: minor code improvements
Thread-Index: AQHdbJLD3B+spkqs8ESnarCm0tblqLcnmpCA
Date: Tue, 10 Nov 2026 17:35:19 +0000
Message-ID: <33bab44e80be5809641e368df28250311ca3bcff.camel@imgtec.com>
References: <20261104-minor-improvements-v1-0-cc976128538e@imgtec.com>
In-Reply-To: <20261104-minor-improvements-v1-0-cc976128538e@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|LO2P265MB3466:EE_
x-ms-office365-filtering-correlation-id: 5ea3d991-f6a4-4904-f596-08df3f50fde2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|10067099003|56012099006|261009223027099003|261102123227099003|261021121427099003|261021123027099003|261022115727099003|38070700021;
x-microsoft-antispam-message-info: Rm6HJ/QJyyX8ueSHbAmDgWzTrUOOXwgccfK1zQHa08DuJM0cpB8rosuEKd7sGY5/SI2gM4BHq4i6WI4abkYGrznkt4MS3/+tekedUotqwAJwHyfzq9zua92kILkUVJs4fXQ4LQh8NtmqUAoGq8CuzzS9mYiXzevpZub7bum8xcDFNz/3dK+/eknV6g/xU/4uPhzFGv3sNJjXlvoqeMwzA61k8iTS74yTNKYdkbJYAtkQvY46/+P0HAdy5YJkQsOpYfxTetMKfx5pPpM9kyWuLYJm5ttcjo5R1zQ/U6vrww2DURULduF5Rtwpikpgp/F7bkn+6kIKGycJK+I3WJzLskBXVL890CGX/yVB/JaYU8tiP7LV6mNGCyT1dpT5WMaIu8WH7rRL6t5y2NpSwLxEs0gnRvVZaBzAfrW10H2Ds/PGFiQ4B2NyAkStE1QrjJAHWOeq0aEdm24Jq+s8TfV7bSWEX+OvBt3SbelQFL+4NP5MUByPYHIk6kgovgNpALuKPfZYUFHC6SCXKtb3kIhh76y5BVXACq49XRq1/5WMCJEsewv4eG7U5w8e8c4ktckZyaSYqL+NCVg5nXmq/W7DCSqYWbQk1CLGl3q8g3J7o9gRUsj6d6Y/pRhRQqGLGpiwhoqFXG3qfO8k0OgoTXyMlYdjQWLd6QvzuXfSXyPIxnGGY+op17PmrUDmfqQtREpMB/Z5rBRZf/yiWVRX059EPGOGzHmO4xt8nF54guqcHJ4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(56012099006)(261009223027099003)(261102123227099003)(261021121427099003)(261021123027099003)(261022115727099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmJpdzU0SG1Ob1Q4MjllaTdKMnRwRkpNc1RBVVBIbVd3THFLbTUyaFRrbCtV?=
 =?utf-8?B?ZTNTTitTeDZ3ejlCNjB5QU5tcHZ1dnFNOWFLNjRkVkV0NkZRRGZPSXkrbkg2?=
 =?utf-8?B?RjdVME1Ra1dnc1MzQVkvMlREQXRsS2pXT3J3VHNvMWpCdXhDTmYvUmZBdFZP?=
 =?utf-8?B?RDJBZ3U0N042c2ZTU3ByRnhqbG1jb3hER3FvZ3BZaFdRTGpJaURzVUFMcHlt?=
 =?utf-8?B?SWdLT0I0WGkyaDFRWElVTlF6VUt0ZnVJZS9QS216VVovQ25zdS9NN3lTamJR?=
 =?utf-8?B?OTgzS20xMDhjd015aXdmQmJZSzJYbzAwVER4RjdPZFNxd0QyT2c0NzEvUWw2?=
 =?utf-8?B?R0xvMTF4cytuNXRwT01FWUxZdnFlb0VlZ1YxM2g2cklGdWVkUUE3UGxDNHNJ?=
 =?utf-8?B?MTRjaE5HSzlMNnRySmVWZVlQVDJ6b0hBZ2pySTdYcE1sVDhaYjYraDJmNmpR?=
 =?utf-8?B?NzQ4VWJGT2xMcHptNVR0cHl1RjVLZHBtYVBvcEtwanZGaTRudEdQZVN1djQ3?=
 =?utf-8?B?WmZadUxFRk5RaUR4c1h6SW03S1NmRzZNSHRJV2V3RUV2ZFYrM2ZRNXEwMk1F?=
 =?utf-8?B?S0k1NmJYZ0hoaTJCY1IxRWhJeDFDS2Y5ZjkwdmZtR2tMb2xYNThMK0Y0aTNZ?=
 =?utf-8?B?RHBoUW4wSFBsWkxudDhWNHpIeExGRFVJYU9IeFZnUzI3bDVpcTRVS0EwZVVr?=
 =?utf-8?B?cERxdzJRd28za1NqM1l6T1o5YjBmaEdnMlNyczEyY2FaemNoUk1YaG1mRFRS?=
 =?utf-8?B?VDlsSGZ4eENsK0lDdWtKemd0Uzc5UTdDVEZrVXV3ZWFIcytTUDE4UkpNQ0Z0?=
 =?utf-8?B?eWQrbmZUdi9wL3ZvOEFjLzZXbm9WZCtYTWNoU2pJQTNsS0wvakZBNFA4UVhh?=
 =?utf-8?B?d2xPTzNadThWRHVrZHRlSitlQzdTWjJWWDJSQjJDTUxsQTZJN2MxTHFXLzlm?=
 =?utf-8?B?N3ZidWtHME9BaGJXenNvcFFCUU5nQ1RTSFFVSTFhMXU4YnhaOSt0YkYvaklm?=
 =?utf-8?B?eEE1cSt3eFU5V1JhRHhqTFEzUUphQ2xCV25mOHpCZjZUWEwvelY0c0JveENi?=
 =?utf-8?B?dzN4czh4OCtKbjVZbHRwMGRwNmp5STAxWTZtcDFnN1VWQTF4VVZRMjQ4d0JX?=
 =?utf-8?B?TGE2WXdaMThLOWYwckxGaDdzNTh5K1VKcDV0ZFhQVGJRS2s2VmV4R2VTUHNh?=
 =?utf-8?B?aFBFdU5RaEVSU0VHS3RrbzZOQ0xKMEg4cjkvU09Mbkp0d0creElXY3RzWGVs?=
 =?utf-8?B?Nm9WSnZneHVBS1h1SGV2NnNjazlVT042NEdELzUyOVBoTFYweSs4RlRZYkx5?=
 =?utf-8?B?K055SXRVNzRxOFg1eTFlNEJna24ydlFWdFN1bDVaeVdINnlHUFJzdXpKSWVO?=
 =?utf-8?B?RWl5R0tNRnY4OW96MXVySEpVSEY5RVNsV3Rvdk9SM211KzNVQXdzMTR1blow?=
 =?utf-8?B?MUhlSzFiY1FSZlNsUk4xUldIUC81aEpQcjNPY0lDcnNITXBqVitqNUlrNjhq?=
 =?utf-8?B?OTArTkhSaXMwSlJWWk9NdkZJbkhuQVdMcHFWcjZCY0NXNW5JQ1J5N2xlMWNx?=
 =?utf-8?B?VHdxRFVkTVIzSXVWeHltOGRqR2NzWi9HVFp1cXZETE1mb1dTdDByQTJTK0E0?=
 =?utf-8?B?aVdnYmF3U3NMN3BtQTVmcXdCYjh2ejBjTTJxck01TWVNZmRUcUpmSlVRZXpZ?=
 =?utf-8?B?RGdEN3NJV1huL0x6YzdzSHBVaDE5bEZ6WFQ1dVQvTGtKOXBFcUxpUUgrb2ww?=
 =?utf-8?B?NHp5aEE4cnRKR1A2RDJrdnBneE1nVUpKSEc0Tmd0a3Y5dTdaUFIzcHN4Rll6?=
 =?utf-8?B?RlhQMCswK0o4aVQxMFFoYnRvYWdhQ0FuUEZrRkowZDJkYmwrd0xkbWZyWitG?=
 =?utf-8?B?dFo0WjdOMWYxUHlsc2k2Y3MvMEZGZzUxcSs5QTdhRVpSWS9taUUrYy9VVVl4?=
 =?utf-8?B?MXlpZkJEVUhpQXQrR1ZNVU1Wejh5K0FVWXdPSkMvbG10ZDdjRWlWVFcvNStt?=
 =?utf-8?B?NkJzdVRMMDlmQWN5VkRta0lvZWFEeE1yeEtOMUM2d3lpdE5FV2E1T0V0R3JZ?=
 =?utf-8?B?SjN0UG9acTNpVkFrdEpvTTBEaGI1VWkzZHFtVmVFMnUzU3hOZUNLWndMaXpL?=
 =?utf-8?B?cWpCOVpKU3pYd2E5cy9Ydkg4U0pvSlRuVDZNSFkreVd0MjIvRjJPbG04d0NT?=
 =?utf-8?B?bks1MlV4a2U3NHI3eWVtM21mQVRQeE02aTZmTnQrY0EvdkN5TmtDdm9kTlQw?=
 =?utf-8?B?a3pwUDllcC91K0xWcDlMSHNuYjNTdEZZMU5vWU8xbk1PS2l0Z1VzSlpRbHF1?=
 =?utf-8?B?eERQZmJvTFF4Yyt4VGtERTJjbmZrajA2Mk9sTmx5VngzRjhWcnhOVmh6YmMr?=
 =?utf-8?Q?M6ZGDgKY5Fx+bsRA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5699B84E8BF4C4E90A5E9B62E2CC2BF@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hRQj/ty+niwe01cnXPf7KK2MwmQMa24ALbStYvKNfW5IKEa4JUMwgjlzUJ2Fk5HvyrlsZfjG46we6EV4m9zmTHxOXA89DuuwcetpW/zdbiQkipTP0ArfMf56dgVPbDKSKrhrEd3EJWd8z99aAFjssIqqKE0oQazJ4JwM7zd1x6FL/pQxsICLFXRPGIzMZ8TY7LKtJpJ5MulO2HAWe6A6JhumUvCwmIHA6Sqe9KZgEehtXuX7AYPz1OJM7a59MSamczakvXg4gR8NgL2xKGdwJl6TGWUviNVZ1lTtvyrwM48TMVzXXuob4+LHHsO3GVo3RX3zV5ro5QTRDUOkmyr0oQ==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea3d991-f6a4-4904-f596-08df3f50fde2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 17:35:19.8871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zazyrjmnf5Eu+Vny1GJGVDYl00qh/ubzFCgxO+qY6nxcP3zgt/AfBkZYpQbg8fjPnRoH7W2wfDSRw9wePuSXvwXIbPs9Aq2OtKcq3vhn6Bg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3466
X-Authority-Analysis: v=2.4 cv=P46vFSAu c=1 sm=1 tr=0 ts=6af355ef cx=c_pps
 a=IVmJKv+C1r54BxCvSYqOaQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=r_1tXGB3AAAA:8
 a=JzaErq5XTdvsNBmJpscA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA2OSBTYWx0ZWRfX3ymJUzhle+Tq
 Ga6syw4eM503ZQA1+Mq9WG1+ioEK8DBtkQ5NMbXFSj19TlxmXH9qGg9cbpNX2RCjXfIhHzxpH4L
 Sm+a9JyVggG56a8bcCz9ZvouSaXa/BgHkaggbCezHe8V+skfn8QM97BwCj8YDQY8pVAJN5VcpVr
 A9dbRR9jmdQktgSHC1kFYo2X77X1UUhP8ia63j8GqM2VmkS28v0kfh0WI+uXQt92Idw/1n8ssbB
 +xmmskts1yLSr9cqh7z2Bk+NiitWrs3JwM1B2PWM7jfTwFPP+6ET1jOODqqpEO9McWABxzRIYHh
 02OcKBU5JxBFPO52WrL4LeCJZCXSlmAN0LjruWCswOdSDkbVzxZ1apS+Jw/8oyGzF2VFi+5DFDu
 A1YZeF7zPWwR7EmRDQwpjhxx5/uJJxIFqymjMfXSqnnrTIQ3eRbI6FNEqYjTTQaDlYFByoOWzg/
 AVE837WXK84p2HB7V2Q==
X-Proofpoint-ORIG-GUID: uHKfNQ9F7-0eylQMcpWQ1bCxqYwyzyEH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA2OSBTYWx0ZWRfX6tlXqv6S+tCX
 GkGqZ2k5wGupjuTs5N8VK5XPAE535liHG4G5cfEbU9IpZpc+SYjkuYECMBRWIEYZ7lICXNg8BHN
 hQX/vdNGWma2GQcVEMZVIFRkF0cIVjg=
X-Proofpoint-GUID: uHKfNQ9F7-0eylQMcpWQ1bCxqYwyzyEH
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCAyMDI2LTExLTA0IGF0IDE5OjI4ICswMDAwLCBMdWlnaSBTYW50aXZldHRpIHdyb3Rl
Og0KPiBObyBmdW5jdGlvbmFsIGNoYW5nZSBpcyBhc3N1bWVkIGluIHRoaXMgc2VyaWVzLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogTHVpZ2kgU2FudGl2ZXR0aSA8bHVpZ2kuc2FudGl2ZXR0aUBpbWd0
ZWMuY29tPg0KDQpGb3IgdGhlIHNlcmllcywNCg0KUmV2aWV3ZWQtYnk6IEFsZXNzaW8gQmVsbGUg
PGFsZXNzaW8uYmVsbGVAaW1ndGVjLmNvbT4NCg0KVGhhbmtzLA0KQWxlc3Npbw0KDQo+IC0tLQ0K
PiBMdWlnaSBTYW50aXZldHRpICgyKToNCj4gICAgICAgZHJtL2ltYWdpbmF0aW9uOiBzd2l0Y2gg
dG8gaW5saW5lIGluaXQgb2Ygcm9ndWVfZndpZl9ydGFfY3RsDQo+ICAgICAgIGRybS9pbWFnaW5h
dGlvbjogZHJvcCB1bnVzZWQgYXJnIGluIGZyZWVfbGlzdF9jcmVhdGVfZndfc3RydWN0dXJlKCkN
Cj4gDQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2ZyZWVfbGlzdC5jIHwgIDMg
Ky0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2h3cnQuYyAgICAgIHwgMTIg
KysrKy0tLS0tLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMTAgZGVs
ZXRpb25zKC0pDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogMzNlZDI2MjM1ZGI5MzE2MjkzNWQxNzE5
YmM2ZjUzOGMzODRhMmZkOA0KPiBjaGFuZ2UtaWQ6IDIwMjYxMTA0LW1pbm9yLWltcHJvdmVtZW50
cy0yYzYyZmM2NzkyMzUNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0gIA0KPiBMdWlnaSBTYW50
aXZldHRpIDxsdWlnaS5zYW50aXZldHRpQGltZ3RlYy5jb20+DQo+IA0KDQo=
