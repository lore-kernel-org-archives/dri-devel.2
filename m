Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51562C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A098510EB8A;
	Tue, 30 Jun 2026 08:11:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="VhqA2/0v";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="ebQUcZPA";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3865D10E1BB;
 Tue, 30 Jun 2026 08:11:56 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U5gj8o856564; Tue, 30 Jun 2026 09:11:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=dk201812; bh=HJTD8nhDHalJtTIRC30nRoKIu
 KHguz76vaOuY6HtXJE=; b=VhqA2/0v1qvlx+Lv1LCBO6nUGEYW4frdCe6jfW3tC
 /tNsjxzpvEVCA8m8cQqw7fxudpTPSrpvLFsaHcGERM+9U8/dmwuNM3cFkoe/RkyH
 2Kc/46w2CufHcEiBRkC9pLPl+j+oxJTaUEl+V+xWnBv2Gyomol4jc/wuwofmaEnX
 SztGpWmCZFZHyO8Qla0sqQMt0A2/CSDiWFcv71ZXva/NHl7OVkzYG60npU2cc1tY
 4/rd+KXLG5YuYQk+sE/fbm8OjLGi4rqNpP+Z6R7PtDMjmED6wUZveD/UoPSSYdw2
 oYqu72i/zszMzah8c5djI5ynr2yfZ36IdwEyoPDHcFNrg==
Received: from lo3p265cu004.outbound.protection.outlook.com
 (mail-uksouthazon11020091.outbound.protection.outlook.com [52.101.196.91])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4f24sntnw1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 09:11:51 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsUaaGGRwG1dSxsnhyOUFjMX+/1PQb/JtDpZ1FAlggGkvP/hpxdgKe8J4Wk37h7mtDs0HSW19JsXVHwfu6IV/Vdg71Gc+K6mGo/+B/oPLuUiIqCntuln9lWVpI0kFjsR7/tYLS0vxqiAlZw2IdAWMH+2SAzpcd5yWeXX9Ez5n41ET8mIDb4L4ZTkQMRpKq8Y6qA9JqSTPRAGMVhpDDCwPjXiph4aflKUCYBkzgXhCrzY9zXfs7LfJyjrwu8Vu3s5uTyrnYIhoaJ8JaTEcUz82Z1RVWYDVCh4erhBDeRNi03IcdSY94JVGAI63mQz7EgmDH5bLmuWrAagpRO/zj0dAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJTD8nhDHalJtTIRC30nRoKIuKHguz76vaOuY6HtXJE=;
 b=QUU62LI3nS7M4NsCruoYYgiDSo3tS4PlWxBkRlakaEVUNs5xbARukk8pcdUFSeQD5zUbiTcnRFHBP8FOYqN09ehwLgEyj6ZSQLMmCS5URIV/BGkAlMEXSHrZNWm+Zwjfs+S5EcyRM+giTpEMg3GFwh4TUrBn+RtwyxarcRN7oZfQuRQQvxF5gvFDod/sCWK53FavM9aWBrK2S0T1XGrHfEyFpaMDq64WloqPsVRNOhMN0i7BnsjThtS72tZ/L/1PW2PxP71dvSRaEG0h0AkXb9qHwWP9VW0lOXUKzbXNTu+ykmhIVmoXCbedthObDHsRN2MtNcRFW4p/nS/RGU6okw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJTD8nhDHalJtTIRC30nRoKIuKHguz76vaOuY6HtXJE=;
 b=ebQUcZPAuM7mHz5kjmUB/BIJ7lHZTqoBqOY7bKRsx+7wibP6NNKcIdaW3jS47AllOk2Hjj4D48rGNp0oeuPLf6o06ZQ2LWNMifzoodePy/FHvUhXHTRzaq4nIG1sXcMSeuhHX5ZEcoEpVeTtQh355a0HTcAgv0d+K9sdh9RBZ9Q=
Received: from CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:e2::14)
 by LO3P265MB2172.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 08:11:48 +0000
Received: from CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f32f:ed34:4f98:6cd6]) by CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f32f:ed34:4f98:6cd6%3]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 08:11:48 +0000
From: Matt Coster <Matt.Coster@imgtec.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 Matt Coster <opensource@mtcoster.net>, Alessio Belle
 <Alessio.Belle@imgtec.com>, Luigi Santivetti <Luigi.Santivetti@imgtec.com>,
 Frank Binns <Frank.Binns@imgtec.com>, Brajesh Gupta
 <Brajesh.Gupta@imgtec.com>, Alexandru Dadu <Alexandru.Dadu@imgtec.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: gpu: img,powervr-*: Remove Matt Coster
 as maintainer
Thread-Topic: [PATCH 2/2] dt-bindings: gpu: img, powervr-*: Remove Matt Coster
 as maintainer
Thread-Index: AQHdCGFEGQeInFZjHk2Nz8WEfRWsfbZWv26A
Date: Tue, 30 Jun 2026 08:11:48 +0000
Message-ID: <71deea83-92ef-4df5-9b0a-5b958d6eabd2@imgtec.com>
References: <20260629-goodbye-v1-0-3bab53a80c53@imgtec.com>
 <20260629-goodbye-v1-2-3bab53a80c53@imgtec.com>
 <20260630-electronic-lemon-oarfish-ccaeb6@quoll>
In-Reply-To: <20260630-electronic-lemon-oarfish-ccaeb6@quoll>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB3393:EE_|LO3P265MB2172:EE_
x-ms-office365-filtering-correlation-id: d5e56253-47c9-4e15-54a6-08ded67f3b88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|6049299003|23010399003|366016|376014|1800799024|4053099003|38070700021|18002099003|22082099003|3023799007|56012099006|4143699003;
x-microsoft-antispam-message-info: VyTqF2EKwyVXOD/LCjdOZp8Hlnk5TOBY5L3C4yNQkoSiNMi6zBIq+ZvZmgZuVSPa4Bru9hRdtoBPSnuviIMiCvrg+2RDTJ/qjbaOCLxvKZSPtsiplhMu9jqcZH2Qo2/dp9XOsmw0X5yvyjD9tcYSdG/c6nWyDRUQEKuS4kcTEtmlWTOGALfEzGcb/1p+SXv59dHAHAEz7yH9fnqakMGfCuPB+tLBRN8b6/33cDQ7Yxb+zoTgmNTTzOeMA5siRnx+mRGiunP4rnS2uZNif5KithjgplEO/hS43K+KoeY7v+O7qWTvMV3+CSX0Br1uRc6uNf8SvCIbrPohYxQxGo6PP+8scThKYSFxkAcK9NoR2CxYqjzYK9bVjsoKoc5Wo8jJ1HnYB6E5P2jfJgII5np3tKhDlZjil767wXKVhYB1xnLoUt+FxFghhfc8m2pD7Mnj87fixwKFLv5T0oTsfXXJpepKwoZu3HTvw7kRlMszGDYS5o1b6+Z1U2ggrqhHHMFF262/ceDQzsUdD3SlD1VPqL4KXhtoRjQMfV5PZRV6pJmJ2N9phCo9cKCmylrn6kDRQdvLpmoT81YhFxfOiKU8jhGJdaJ1wwlB+2Bs9Y+i3iicoDG9+hkJbES0jUM1mpcYrJXMhrXlkDXOueGzsKNmpGzKTNiPGlkB/H5AKzZhaOs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(6049299003)(23010399003)(366016)(376014)(1800799024)(4053099003)(38070700021)(18002099003)(22082099003)(3023799007)(56012099006)(4143699003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUF0aWFISUpqQXlZRURsK1YxUHNsRnhndFNhcGRNNTBKVFBZN1NVOHNyVDkv?=
 =?utf-8?B?ZFFnQVZrUUhucUFRYXc0ejBDVXAwQ1hjT0hlUm1rUFA3ZDJ6NTlraEZ6cWgw?=
 =?utf-8?B?b1dNL1B4cUc0cHZtdzNBTHdiTEN5alpKbC9OVkVKaDg1b2FjZGVtdWFsUENq?=
 =?utf-8?B?MWhrUWtTQnBJaVhBUW00MU9YelRmWHBuNjBuN1pLSXFob2JrWUNhc013NUcr?=
 =?utf-8?B?eUZLTjRiTnpoMEwzUDdiaTU1Z0s1VlJJU29RRHNlZ0Z1Q2thZys3S2pQeWQ1?=
 =?utf-8?B?a1AyRllKOCttNXB6Q3ordXpOREtCNEk0UnB2MGE5eUF6QTlhNHJzOE45b2Jl?=
 =?utf-8?B?ZGVodXVpM21tc0EzaTdJOGpVdk1jSDlNWnlteU00TUpWa3RRSTlYbnhycFh3?=
 =?utf-8?B?cnY4Z0hRZTkyWVdLVHFTeG9RcE4wVE50cGthbzNwZ0IvVmRDcnhGSUNTcWdm?=
 =?utf-8?B?b08zY0NUcTFSZnFhQU9RVFlQaG9DVW9UdGNGOVZ6SzByMVJTbTd5TmtabUZu?=
 =?utf-8?B?V1J3SHQxaWpNS29LdmJmVHVPUnovZ3VHVzBYM3hSeTA4WDB2RllYUzJhVGZD?=
 =?utf-8?B?WTNUQ05hQk83bFYvZFAyZ1FMVlhveEFUenN6ZjRuNzlaLzFnNzUzQTUrMFhX?=
 =?utf-8?B?dzAzL2paak9WN0x0MFdMV2hrNzhpcFJwOVdEWTZDMTV5eUpJclBYTENqaXhj?=
 =?utf-8?B?MHNoTDNrN1RkSXFZZG5EMWZPQlIzOVNObzZMUFN4a1dBbHljVWxFdUNmYkpr?=
 =?utf-8?B?cjRRRlF0V2V6dngvanBoS2krSUs1OUdoU3lvT1JxdHJOZCtVbVZmcEQ4UHRs?=
 =?utf-8?B?ZmNUWkt5UFRsQ3d0RTRvNmoxblR2KzNZdjFVaEQzb2RSME1xOW1UYUlzY1Mz?=
 =?utf-8?B?VDVuejNVZWlNeG1nM0hoZEY1U3V0c2J5T3Qxb3Y5Y005MWlJb1IvQ3R0Zy9N?=
 =?utf-8?B?dHByYWhYdlVGNEJsNWg2NmJRTnpaTWd0Y2FnT2lQNm1DYThJTjZDeTk5R1RP?=
 =?utf-8?B?dHBHUDg3ZTVXeFdOZXcwU05BT29rNHBUNWxmRm9lbnBWU3FFa3VLY25yTjll?=
 =?utf-8?B?dmw5WEkxS2xtTDhHSHhrSzg4aFd2RCtLcGVzVjkvQlRCRjdoMWllRWwzcVdN?=
 =?utf-8?B?Y0wvWi9yalVuTjZ0Y2NnMXY5eUFDYzhxdTRNZWcxWmdYSDF3SWZQUmlacVFH?=
 =?utf-8?B?NFdWNVFXR0xDTDAzVGN4OFhxallZWWpLLzVKaDk4Q1JoVTR2aUZHRVEyLzZO?=
 =?utf-8?B?M3U3UW5JRmo2c2NxdUhiVGhnYkNPRjRONDNFMHAyNURiZWFUbnZiSmxYOUx0?=
 =?utf-8?B?emw2Q1lTMS94VXp6YzgxSjl2ZHVxNUVJMU9UZFVtb2R6bzV4Y2krRmU5USth?=
 =?utf-8?B?Vk1JV0tEdHhGTHZlYlZyU0drWXNleW9vNDA2L0UwRjFaaDJOdE9UcSsweS8v?=
 =?utf-8?B?NXVSUEN4WkIvWmorcWFET0JaNTR4QWNGQ1F3TXYwUjBzY1puRUR1d1gxek4x?=
 =?utf-8?B?V2ZvaEhDeFRTc0ExZTlkM0Vqa2g2T2xYd3dZMkRDbk1JdUlHbzB5NHNSeGtK?=
 =?utf-8?B?Qzl2Zng5aGlHTE5VQUhLc28rTkdObmkxaGVPVHhjTC8zZnZkRFhoY2prWlpH?=
 =?utf-8?B?R0NnM1dBWmpLa3VLak1hOHFQbjZGamp6NWRSMnRUOTlBemlaNElXZmJjUTNj?=
 =?utf-8?B?c3RrRGE0NUo0OGhmb2FwdXlkekVnWkhuMUFXYXR5UEpiWXluWjd5TDVPTGsz?=
 =?utf-8?B?d0VMeUsvZTk2TjdqUm00RHl0NGVkVFg5QmhFRmlRemxLZ0tWNndaYWE1bzA1?=
 =?utf-8?B?QlE2QnhDSlExdkFqbXpnSG43ZFdpK3BEczlxRE4rSUEzMHFjajh5QnFzOWxW?=
 =?utf-8?B?Nk12UFdqVGlFUzdRTm1ZZ3lLdWdhZE9xaWp2SS9qeEsyblE3Q0RJeFQyRTVH?=
 =?utf-8?B?S2lOeDFPRm5Ob2hBOGxYR2YxL3paZkNlYkEyYVBKbUpubXR4R1NMSWpGQ0Jl?=
 =?utf-8?B?Z0Uyc0hFNUwyUFV4WXBwdGVnZE92UUl2cld4a3hoLzFyQmJ6WTl2OUlVaGl6?=
 =?utf-8?B?NUJCOUxUem5jSjZjQXU1S29CblR6ekcxQk9TTDVaVnRweXlUUzhQTjQxM1VJ?=
 =?utf-8?B?YlZkQXphcnZYMmpsYXZwUmlGT3hUeldNVURYL05kUklVSEozcnZ1WkV2VmN6?=
 =?utf-8?B?ekxrckYzMm03QU1yYkptWUo3S3d6dFJaTkxEckZNaUZoWHkvSUJ0TE1WenpP?=
 =?utf-8?B?dWR4cFlEcm1qUkdEQUxEWldYbGRlOUc0eVFSbUVvQUMwRXB1TkFDL09HREUz?=
 =?utf-8?B?RlA4SFZtMjNFRGVyZlFNZi94cG1FSm40U3dlV2ZOaGU2SklwTUF6Z2tUTDN4?=
 =?utf-8?Q?gc91T1l/x9oQotZU=3D?=
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------qn0z3f1PtjKe1ph33pXl0glb"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: n+2m6Kz9B74ZZr85Y/L0snd0EP34IaOVxTVkEi3A/EvIr0G11jok2D/ldf5SKwcBiMj57SSGw4CVTVXCj93jFOQURD99HcelNB3thCakLZdRD00Vq+7m6nsH/s3+DUA8IBQri9qmVLVQkmaxYO03EqoQJnBaVxyXlKJeUJzcNRDp1EzqgcAX3VHULbHrYTbx4tToD377e+YE/GUFsn1xsCq9kWFM+jetzpJE8e8pTXYd/wLay1ruuFeSLPO2tit1r/4wUAm67eWAVlvsnhfbLJV4nwxLvAyQCa9XsKtpe+8frHTPN6TlPpVAHAiq++ZYlr3SdjulJ2z69brWnoKB+w==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e56253-47c9-4e15-54a6-08ded67f3b88
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 08:11:48.0897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D6rR0zqsJTI2a6iPpo0StgepzGwDC5Ya/NGu/xze2+gnQMzx5ltNIWKmrjfqnNVet5vPNHxsrzjXkWF0LyK6AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB2172
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA3MSBTYWx0ZWRfXxav9frOIpdTr
 P4DdQ870F9f7tClTByqg3mX5GsQfsWaujDBnBdBns+aovG8iz9YUg3ko9k/v/oWReQKITnRlF/M
 +E/fXasQn6KvBALjGMRy5LhjUbiVMog=
X-Authority-Analysis: v=2.4 cv=We48rUhX c=1 sm=1 tr=0 ts=6a437a47 cx=c_pps
 a=DQ4dKxg0ONJ0l4AD5Jg6qw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22
 a=qZQ2PDNLMSdLoqI-hfl9:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8
 a=8ctbhBRKcH94D9lERgoA:9 a=QEXdDO2ut3YA:10 a=u-5bHYrC0TGZaMFvuhAA:9
 a=FfaGCDsud1wA:10 a=N-viIsX1QKl0kFOquewA:9 a=sptkURWiP4Gy88Gu7hUp:22
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: F3v9v0OyK_-cYrUBAsaOrmnsZVXLyNN3
X-Proofpoint-GUID: F3v9v0OyK_-cYrUBAsaOrmnsZVXLyNN3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA3MSBTYWx0ZWRfX1pzmOD9D6RLd
 ZwKHPt6W6wEr3G0cR4/1oMA4OvV6qMscpeMJr5Y1kdj+RJbKPBNjNQZ/Hf8VXpIwH6GC/51a5rC
 uphcfL4lNqiIpNpUvSfY80KZDqV6uS83RbK/VbZoZROv+98vl60xk+fZyX1uQAsl2o2KYd7Zhop
 B5hTCKz1+bGbzK/UmZR5EQFn0tZvHAAHQIzfYBoJod14uec5gFR72yahBLXu3qFuGvTiyQmiN9H
 Mo/KYCilLFaS3XcJb1ygd0iTQRimup8uruyXc3Hyt3eMBQ0zqdsNpRrXom4U5tWfCS/yioKuACz
 /VnGBwPEMZzSczWrBDiRv37byVIlHu6+LRnd/kXz8dbvCoZF2UA5rIH68AnDdYg+MYTa0LhPuJV
 B8z5ugpW+KNAfY6taO2x6B9VID4W2wGCaGVPoT8WharJokkh5oLtf2LctFb1zJdite7wr4zYDXJ
 aLrQ8pDnn4RWKRhaGCw==
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

--------------qn0z3f1PtjKe1ph33pXl0glb
Content-Type: multipart/mixed; boundary="------------X4NsfklWeA5pbI0rQ0FkOioz";
 protected-headers="v1"
From: Matt Coster <matt.coster@imgtec.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: imagination@lists.freedesktop.org, Matt Coster <opensource@mtcoster.net>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Frank Binns <frank.binns@imgtec.com>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <71deea83-92ef-4df5-9b0a-5b958d6eabd2@imgtec.com>
Subject: Re: [PATCH 2/2] dt-bindings: gpu: img,powervr-*: Remove Matt Coster
 as maintainer
References: <20260629-goodbye-v1-0-3bab53a80c53@imgtec.com>
 <20260629-goodbye-v1-2-3bab53a80c53@imgtec.com>
 <20260630-electronic-lemon-oarfish-ccaeb6@quoll>
In-Reply-To: <20260630-electronic-lemon-oarfish-ccaeb6@quoll>

--------------X4NsfklWeA5pbI0rQ0FkOioz
Content-Type: multipart/mixed; boundary="------------in1P0TdbD40pPMeCHs3t1Qjd"

--------------in1P0TdbD40pPMeCHs3t1Qjd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgS3J6eXN6dG9mLA0KDQpPbiAzMC8wNi8yMDI2IDA4OjIyLCBLcnp5c3p0b2YgS296bG93
c2tpIHdyb3RlOg0KPiBPbiBNb24sIEp1biAyOSwgMjAyNiBhdCAwNDo0NzozMFBNICswMTAw
LCBNYXR0IENvc3RlciB3cm90ZToNCj4+IEknbSBsZWF2aW5nIEltYWdpbmF0aW9uOyByZW1v
dmUgbXlzZWxmIGFzIGEgbWFpbnRhaW5lci4gQSBzZXBhcmF0ZSBwYXRjaA0KPj4gbGVhdmVz
IGEgcGVyc29uYWwgZm9yd2FyZGluZyBhZGRyZXNzIGluIHRoZSAubWFpbG1hcC4NCj4+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBNYXR0IENvc3RlciA8bWF0dC5jb3N0ZXJAaW1ndGVjLmNvbT4N
Cj4+IC0tLQ0KPj4gICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3B1L2lt
Zyxwb3dlcnZyLXJvZ3VlLnlhbWwgfCAxIC0NCj4+ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2dwdS9pbWcscG93ZXJ2ci1zZ3gueWFtbCAgIHwgMSAtDQo+PiAgIDIg
ZmlsZXMgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwdS9pbWcscG93ZXJ2ci1yb2d1ZS55
YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwdS9pbWcscG93ZXJ2
ci1yb2d1ZS55YW1sDQo+PiBpbmRleCA5MWU0ZmY2MWIzOTQuLmE2YmNjYjYwMGE1NyAxMDA2
NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUvaW1n
LHBvd2VydnItcm9ndWUueWFtbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2dwdS9pbWcscG93ZXJ2ci1yb2d1ZS55YW1sDQo+PiBAQCAtOCw3ICs4LDYg
QEAgJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlh
bWwjDQo+PiAgIHRpdGxlOiBJbWFnaW5hdGlvbiBUZWNobm9sb2dpZXMgUG93ZXJWUiBhbmQg
SU1HIFJvZ3VlIEdQVXMNCj4+ICAgDQo+PiAgIG1haW50YWluZXJzOg0KPj4gLSAgLSBNYXR0
IENvc3RlciA8bWF0dC5jb3N0ZXJAaW1ndGVjLmNvbT4NCj4gDQo+IE5leHQgZnJvbSBuZXh0
LTIwMjYwNjI5IGRvZXMgbm90IGhhdmUgdGhlc2UgZW50cmllcywgc28gbWF5YmUgaXQgd2Fz
DQo+IGFscmVhZHkgcmVtb3ZlZC4uLg0KDQpUaGF0J3MgbXkgYmFkLCB3ZSBhbHJlYWR5IGhh
ZCBhIHNlcmllc1sxXSBpbiBmbGlnaHQgKG5vdyBhcHBsaWVkKSB0aGF0DQpnb3QgZGVsYXll
ZCBiZWZvcmUgSSBzZW50IHRoaXMgb25lLCBpdCdsbCBqdXN0IGhhdmUgdG8gc2l0IGZvciBh
IG1pbnV0ZQ0KdW50aWwgdGhlIHByZXZpb3VzIHNlcmllcyBmaWx0ZXJzIHRocm91Z2ggZXZl
cnl3aGVyZS4gQXBvbG9naWVzIGZvciB0aGUgDQp1bm5lY2Vzc2FyeSBjaHVybi4NCg0KWzFd
OiANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2RyaS1kZXZlbC8yMDI2MDYyNi1tYWludGFp
bmVyLXVwZGF0ZXMtdjItMC1lMWIzZjI0NmM0NGNAaW1ndGVjLmNvbS8NCg0KQ2hlZXJzLA0K
TWF0dA0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCg0KLS0gDQpN
YXR0IENvc3Rlcg0KRTogbWF0dC5jb3N0ZXJAaW1ndGVjLmNvbQ0KDQo=
--------------in1P0TdbD40pPMeCHs3t1Qjd
Content-Type: application/pgp-keys; name="OpenPGP_0x747F0A9036F90DFA.asc"
Content-Disposition: attachment; filename="OpenPGP_0x747F0A9036F90DFA.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEYl2lchYJKwYBBAHaRw8BAQdAOYlooFfHTXzAQ9aGoSnT9JS9wq8xprG+KVLb
kxJDF5DNJE1hdHQgQ29zdGVyIDxtYXR0LmNvc3RlckBpbWd0ZWMuY29tPsKWBBMW
CAA+AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEBaQM/OcmnWHZcQChdH8K
kDb5DfoFAmgHpowFCQlsaBoACgkQdH8KkDb5DfqxDgEA81pbVLJDmpFyFZLRhAGi
g9rgoDY6l774yhTzRVm/SvkBAJLzpSlmwyQaQuB668TKOX9XvRLKFGjSq5kkdQcx
qjkCzjgEYl2lchIKKwYBBAGXVQEFAQEHQCaVC8X57NOv2jNbeXqjP9ekY7rzy7au
iEZ5PxaDWUQVAwEIB8J+BBgWCAAmAhsMFiEEBaQM/OcmnWHZcQChdH8KkDb5DfoF
AmgHpowFCQlsaBoACgkQdH8KkDb5DfoK+AD/Q4aN/zUvP72RRE4cNWpMMXeRXg+L
TN+OJ24U10LltxIA/2w3kDqMC/0t1oqO8TM+c2LMWO/x2IBkG7oRZ/hVw1QIzjME
Yl2l9BYJKwYBBAHaRw8BAQdARg6VNBqiDnBCguJLq7o5NoqPKLaZcpT1Zu3AL+/f
293CwDUEGBYIACYCGwIWIQQFpAz85yadYdlxAKF0fwqQNvkN+gUCaAemjAUJCWxn
mACBdiAEGRYIAB0WIQS4qDmoJvwmKhjY+nN5vBnz2d5qsAUCYl2l9AAKCRB5vBnz
2d5qsA/YAP9OgEeCHGN5sRCwnmUg07Q+WkJNJdevLchd2YVO+QRQeQD+ONoaVrki
YYf+rXFiO3RFsHJt+XNHuJutdygwWqQCogYJEHR/CpA2+Q36OXwA/j20F98iPHfW
KAYLkg/H1UcdfYPQ3iAYsrvCyDn10a/pAQDZ0fb4g4Nh9mbWrLFc+FUKVyJ3iSii
vYDewbGAeXGyAw=3D=3D
=3DKQS8
-----END PGP PUBLIC KEY BLOCK-----

--------------in1P0TdbD40pPMeCHs3t1Qjd--

--------------X4NsfklWeA5pbI0rQ0FkOioz--

--------------qn0z3f1PtjKe1ph33pXl0glb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQS4qDmoJvwmKhjY+nN5vBnz2d5qsAUCakN6QwUDAAAAAAAKCRB5vBnz2d5qsN3C
AQDaHcTqrk220+SSpqNiQN0LERz4VD6OeVtcI4nLB6lTKgEAo0Ap720DOwI0PS8xn0aiHU/4yZVa
5QmSRSrCmqxYhg0=
=ldbm
-----END PGP SIGNATURE-----

--------------qn0z3f1PtjKe1ph33pXl0glb--
