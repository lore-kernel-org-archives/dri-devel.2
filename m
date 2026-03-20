Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FBF1098797
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB7FF10EB12;
	Fri, 20 Mar 2026 15:31:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="Lm+zSUA7";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="Wy599nJ0";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78EC110EB07
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 15:31:00 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K7v2rc3934120; Fri, 20 Mar 2026 15:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=dk201812; bh=kgdNFCn0IOMimioeAZJI5YO3T
 AgTLtlHVTO5vKb1VEI=; b=Lm+zSUA7Ej4q9XDcgMkp71lCALgeoOV14OeVlWxyR
 EaWP9NVyg72eYs7uM0isKNl3RpOW4Zzz7AvixoOKXeDMwlfB3kRFZ6luuNR0JPVZ
 exVtQbaVDXdd2LLj53j+I40ssUkP+9CD+ysDFEr7l8fiSX2hfos38yfds2HaePZQ
 WYEhUgzu3SildwlcBPgpZaLErlPl1FNws2EuNaKYfHELtLhZDImxOMzcoQ0ci2ex
 PbxYp+tDzz7Amw5vmvzYOORAX2Su9WLquX5ptdRYXAthN9ujphfqexCwT4dyG1yW
 GajgGq2y+15gDuhHWyCrfIkBkA0nDxBVMMiiuMkEIRaCw==
Received: from lo2p265cu024.outbound.protection.outlook.com
 (mail-uksouthazon11021075.outbound.protection.outlook.com [52.101.95.75])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4cw0mwdk0k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 15:30:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vz0kwyTvnt4RNJZ85CkLOCZVouBp/YTLS682nf1ta36ZhC9XJCfyqJKq1WjFutaztsi0MayneJKgBxFgpglecxUPh1YqVotQ9kxc9R+8BIBMHK0k0YjNkvumEOxQnhKFkCE+/1856vvlJKoNBJt8Imx1BXs8kryuknTCH2ptEkuyTHqK3eZnhj/WMGVTguCSJdLepmv0Fks7kdL3I37iNWbMB4WeUBu6aSR1LcrBckR/KhFw486l5NGsyXUbKfR/D5WZ0Zh5RpKn7lbHgud7RNOOZuXjZdBPMRhawL5+YJtCemVFT6MrXSp7J1ZsTQvvbPRUJZqIRv9tiQnO8gakBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgdNFCn0IOMimioeAZJI5YO3TAgTLtlHVTO5vKb1VEI=;
 b=VKBlS610h4USgdnLtWnias6mv6LhAyeGCLL8m1ZLGnrFWDlSUOycc2QVF8Prw69r9QRGbqNvsv/KyGz8w1UUANSIu9gOg+P6dDcfemyBd8WGSnxJZAcxRgNZqVhsWuxQFZqMBFKnRrtrO26bw8PdJnhdCelpTUz3Z7+xD9xUalKKqE27UP4+ADLSil43k+IMbtzetJyHzRpNPpgxN3PXWvDIP+Y+yJe5w4PaMZpF48eh/+uB14v4dMPYr0Djkfd5GRm9Rd6V4ZxVWUD2oEseDkfnFuvjxHL6mhlPdPYRS3Ykz8uC0FqkznmeynHBTQFrCkjHPHii8QjLq0PzTFM1IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgdNFCn0IOMimioeAZJI5YO3TAgTLtlHVTO5vKb1VEI=;
 b=Wy599nJ0u2qFbhm151Jnv47Tm+JCdbzdvBxUAa7KQG/FrynYRgXpvw2vCFYPFwrPvOgi/b2krK6gHPradnH7haWe3C7DUZteSuMIRhDAZ5WUu4ifUl2P0WtNDMdVqkkJenTpNZ4QXgFUQc6Oyz0o7zGYJ14d70qLppJadDZvFmU=
Received: from CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:e2::14)
 by LO0P265MB6945.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 15:30:46 +0000
Received: from CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f32f:ed34:4f98:6cd6]) by CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f32f:ed34:4f98:6cd6%6]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 15:30:46 +0000
From: Matt Coster <Matt.Coster@imgtec.com>
To: Alexandru Dadu <Alexandru.Dadu@imgtec.com>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Frank Binns
 <Frank.Binns@imgtec.com>, Brajesh Gupta <Brajesh.Gupta@imgtec.com>, Alessio
 Belle <Alessio.Belle@imgtec.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 0/3] drm/imagination: Firmware handling of context
 reset notification
Thread-Topic: [PATCH v2 0/3] drm/imagination: Firmware handling of context
 reset notification
Thread-Index: AQHcshUjTQedHTfEDkajOU0tO1z6Y7W3mN+A
Date: Fri, 20 Mar 2026 15:30:46 +0000
Message-ID: <1cd5f891-d671-4235-9a00-b29c2acadd27@imgtec.com>
References: <20260312-b4-firmware-context-reset-notification-handling-v2-0-aec5a64cb06f@imgtec.com>
In-Reply-To: <20260312-b4-firmware-context-reset-notification-handling-v2-0-aec5a64cb06f@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB3393:EE_|LO0P265MB6945:EE_
x-ms-office365-filtering-correlation-id: c3ee2d20-b8bb-4c34-b05f-08de8695a828
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|6049299003|4053099003|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: Uo/ggcoSkDxRv3dol2EWue7Ru2+zWmuGnnywsZ4ztcsaT7zQJTDE0rqxYB90is5q9hwkAdEeh42wShLHFCpht+yAbOrD060+TXAL5vsHpWlBVrvVfMeX9G5bcg58U+msv8r6ekcseG7H49YiC+wgAnTWhuYqIEuIeljH//rv488NF8sVn7fpeIETm6g/DaKkU8+y56t3iHiHUipE6uTjGokGB8g6pCutOgXsol8+Di8uWmA/PXWP1F/hUbDS7XMZA0/iMRGAdsPu30+S9FHwkNKoLFvOvG+9zs+owQoyk9DgT1q5kRIKdfvzyN5p7qCB+YrPl6e5TH9h+ZvpNC1+RZL+apHzeWDGNoMNHSo/GQ3BCPwnTOgb4fwLQxgX3fRjZ1Pu6QCNtLSjrUL6xx1S9okgEau9VJnFU2meU0VpxOS2U9CQB2gU1+I6Vh0zaXFAlQD5DZ9PgZPLU5QPd6VzGZ9nXlASKE15Rir1ERLxoJe3bmiQg6+F0Ebiee9zyz7AGS4UyJNtjArmNrmWvapO3MTUTy9NST0odE5JDAx5ZY+UI5JdK8y2kEpc11TOEYHrS5RjLF08a4ZZo7qrFXBnFuhHKmBY/1mN05lJhOsv3nCMKrNNtysju1mgarWgRccuO6VeziP+hNJgfIz2kitg0+moEdq9yvU86SfGFEWJ0TLplqPOkx/ZLxuY47l+hJTWcFNcfJvrPm3OLJTX7MMZmtzV76LyIM8EiGqI7knckKTi/h/VSYODsFDRVdUo9KQj4VGGVn0/iHgXYCamWnP2Liek9t/kxvXKPu3zOc0HDxY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(6049299003)(4053099003)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDJzTzIzN3VRWlNiQng5TnppRFFnWlc1dGV0ZW5sUWJSUUk0OFlwanlNSm1o?=
 =?utf-8?B?OFh2elpjOGpUT3FKMnMvYm5HQWNvclRkZHFZRFpFV0hpa0xKYWY1emVyNFZx?=
 =?utf-8?B?VWJnOUtjTkFTWlZGMFNiVW9EcndwT002cUlMOE0yUHBMb0FqM1JYQmgyQUtN?=
 =?utf-8?B?WElMeVhLYXl5RzVXSXBscGdsYlpsaURqcTFWN0djVzZhVDVYdGdJYnFpR1lp?=
 =?utf-8?B?dkZmbW9XdGdadEcwcFpRWnNhN01nVDJFYlhSS3V4ZmN6UTVkOFowS011NW1a?=
 =?utf-8?B?VXJnb1lPWXRsMjFjMW5sNEQ4eVpESlZiSGFBditmTXU4NnBZblhxWUx2RDF5?=
 =?utf-8?B?cnh6ZTl4OHQ1YUJVTXdhbCsvRHFTRFZqSytrRDV3VitmZ2xCR3YwVjl6dXM5?=
 =?utf-8?B?WWduNlQ4bTNwZGI2Q0RyYUJuaGEyZ2ppZVdXa2dhcGwwZnIrZGQvcVE5Nngx?=
 =?utf-8?B?MTladFg3S2xkNUY5ZXhoUzBRMHUwaXo1enRFTSsvMWhMb05oUGUzUHpZRWdl?=
 =?utf-8?B?WVFkWStjSFMxUE5lUTl5MWFtTURmVUlNRXBJbGRaUjROUnVoZkdDbURCSFZv?=
 =?utf-8?B?Z1NaNHNINWtYQ1pqYTF4ZUZkemx2VWRWTjB4U0pIbDE5RFB5RHRpdWovYk1C?=
 =?utf-8?B?UWNidWU2Q3l0eVB0dUdrNkJmdTN6d3Z6Wnc4TDEwckFMS2R0WVlWQlllWUI5?=
 =?utf-8?B?U1lTbzJLbFlQekQ2RzZEaTg2ZCtsanNjMHd3WE9NdldXbnJJMHZmUENXdWZT?=
 =?utf-8?B?WGVuWmhkQmZSdGptV21scDIra29SdWxEWm5IeFRBbHZpa2VZa0pKOXBaQi9B?=
 =?utf-8?B?T2FRVVlqckZ3TUc2bHdIcHFPMVNXL3E3NEdqZmJqSmkvQU1kdVY3NUtqRTRS?=
 =?utf-8?B?NWk2T1E4M0JlQ0NxYUtETHRtSkJxVm9jWTczV3dxZm5XZ2xsdTRXbkx4NXk5?=
 =?utf-8?B?Q3hITlRTajlZd2ZlWVprY1F3bnk5NEw2RGQ1SWsxSDZ6RnpkZjZCMm50V09j?=
 =?utf-8?B?dzJpSTJNU0xHYy9oZEhsT0luNUFGOVhlcjkvbGg4d1VKMW81aitEZXM4VmhM?=
 =?utf-8?B?U0M3ZnM3Sm5TZnRKZUNzc25JTi9vMkpuTDRVbldFVTJQVERMa3dqRGdqU2Z1?=
 =?utf-8?B?Z0VENEE2L1pHc3BsNGsxR0JtTGloakMrcHhmZ2JiSVhlcW9XTW1ZSVpPb2Fh?=
 =?utf-8?B?d2VSUmFjOWFoOUQ1ZlBuRTcrS0NtLy9uL28rTTA0dVBuSmk2OENYUXJ6eWtL?=
 =?utf-8?B?dFVOcHRIdmVUcmtoNGcrVElzdEpqMGtjVWc0QUdsU3Z1b0ZwQVNOaWVmSEhw?=
 =?utf-8?B?WWF0czVHM2NFOHdILzNZZWt3WUluak5NcmlqSjFwOTc5cWVjRHp1QW1KOG1X?=
 =?utf-8?B?MGVkOUMzTURCU05MbDNrdm1OZ0NsbHlwTVhoWGZOZGNRb0VpQ3dlUFNMY2w5?=
 =?utf-8?B?WGsvQW9ZOVZQQVlzeTlhK05xNnkyRTBJYkZpYnJvRVRabHpnbkg2R2ZTVkZK?=
 =?utf-8?B?ZlpVbVVnRVFCQTIySnNpSnhSNXRVbFVkYlc0elRJSWFaVS9LMit4MC9OWnRR?=
 =?utf-8?B?UTArUGZWUXlIeitHUktVNkg0M0hqU1ViMForeCtxM1RuL2ltaWRVL3ZqSjln?=
 =?utf-8?B?MVp4NWxKbExRMk1lckg0Y0lmbUtya0s5cnplLzNrcmVsL2RFWktKSDJmNTZK?=
 =?utf-8?B?OHhJRW1aREIzSzZ0eXBtTjUvRFNvQjdmaHNnSFR3Qm80VmVpSnY2eUpEZ0pR?=
 =?utf-8?B?bHVUOC9uZjJLdSt5dUR6eVQ1UlFxQzc5LysvbHZ3WFJjWUlybGlnOUJMVnVv?=
 =?utf-8?B?ZEQybzM4ODV0N2dhVGJZSUFvUVp4ei93UGVqS2lvRUk4TmFXb0lsRzJHWGda?=
 =?utf-8?B?YjllZWlrRllnMHpQWFMrRldoRlB2MUtHZndyWlk3M2xxWkRDS245SC9UbDJW?=
 =?utf-8?B?dDZ4dXhKcFRvdlBKSFgvMGJVSEhKT2FRT2VOOGZCS0xGV2hFMnN3RTF2RVpt?=
 =?utf-8?B?L01Vbkk5N3l6cFZhZ2czd2dydjFVV0FrTGRiY3VDVyswWTZRT1FtYmZEY09y?=
 =?utf-8?B?YlFRRHNCSkhHbUZKV2F3QWozSC9aSXRWakd4TXRYS0w5V1p6UnRZa0phNzRL?=
 =?utf-8?B?NlpDMkpoN0RyVGhTYlk0amM0VXQyViswdmxkV0JuL0RJUjVUb244bjBubnYz?=
 =?utf-8?B?MVFuU0xuV25FbVlWcG5YUGVOd2RSbWpLaUw3Ty8xU3JnZllOQ3FmaVlHdktU?=
 =?utf-8?B?MjZuSzU0RlVHem5qcDlBWW4wZHVvYlN2aDdzbnpMUTlEbEVsNS9qL0x6Rnpa?=
 =?utf-8?B?WUFtSmNZTkFDVWc3UTdYU0tpd3BYK1RWYkxCbm9QR2tNMHRjVENMeTFDWkhK?=
 =?utf-8?Q?Nfhywp/CjHf2p2fs=3D?=
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------gzcTP2kvjgy9Aavm1WbwKVwA"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sioefXowEgU33JG/yR2p051nbcQCt4viId3x023P27pe/0f8BHjCpoqAVNQ2pb6vzqWo6YK9qpyX36CJgpJkE1CHIdZHVfPVASnUVLnDGnVPTsxAbTGbbDe0iXIAhGNbKc6yuFmBi4NejDYWR9eokUuMM24IT4o0D0LCBCEyAfGeqPVkqHd+4zZ/JHzdi73h8IS/b0oi6aC0ihbdFtFvwYxWZ6B7y/UbOuGrQBhPoGZ17wb+iG48B8dxD+ttYHfts3p/1+QAnyDAL+5iuT9fA2bGvTA/xyZd5LN44i9wSOrsAWWDF0C0KVUNqSjRx8p7riX8lmxa9/JbM3i7sDiJxA==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ee2d20-b8bb-4c34-b05f-08de8695a828
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 15:30:46.2374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d7mpymj37RYED5W+47O+RHAu9XzKYqklFWNatrwe9XtTu0cHsDBdzz8NOcaGQ58ZG1lsUIJ95RBIJP0hrDD7tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6945
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEyNCBTYWx0ZWRfX2oMf+M8NSMlp
 YNqvqIjzsOZtA6TC7C/dgaUcG9xnxwDpMbEMlrjfvYWLBhuvngUpIo+OsRTlLb/wd8jy1vVMn/7
 IfrGiFvhjn6lZmAck5jMtm9hsxc1ecrpDQuZIo52WYTkXZaYZp2SJ07WSxm7D4Ik2RtS+PbRNxx
 PWeYb4T78YpJzPUg+x/BxePESAuDQ9Zps31FSb34K4FTU83dyrgapUBMxzQ78StFw/wAoivsVBy
 MmpN0OxD80VyokOLzlnUp/z3KOlc74PSqgdp/jykAYsLLDcEE5+h+0UTknUqI1pGjYlNximVZTN
 0QS3tE35L02NwLfYxvmIm1l6ldVRv48UFbfCvkJGOjx5pXKPQKEYMGrx/mCK/rnx4zYWwHPtYqt
 KAPTV6ur+xSjSWOAms1eveWPW8ArUyPFKbHirM/pmDzV+JuABuKNSF7YrBCBEKautapu2Pkshgt
 ARPrLVF9z3Te9tFuYKQ==
X-Authority-Analysis: v=2.4 cv=JaexbEKV c=1 sm=1 tr=0 ts=69bd6829 cx=c_pps
 a=lAJi8oEv/UnzmFg6RI4JLQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22
 a=7RYWX5rxfSByPNLylY2M:22 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8
 a=HN7odFmUDuJV3iD2VqMA:9 a=QEXdDO2ut3YA:10 a=SH9eNPgu9b-BoTFPAVAA:9
 a=FfaGCDsud1wA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: mfTz-5BSJs6JzMHEDwQchkKk0fPgbwSF
X-Proofpoint-ORIG-GUID: mfTz-5BSJs6JzMHEDwQchkKk0fPgbwSF
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

--------------gzcTP2kvjgy9Aavm1WbwKVwA
Content-Type: multipart/mixed; boundary="------------q9s7acmaFFSWyeMnnqEnHoaO";
 protected-headers="v1"
Message-ID: <1cd5f891-d671-4235-9a00-b29c2acadd27@imgtec.com>
Date: Fri, 20 Mar 2026 15:30:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] drm/imagination: Firmware handling of context
 reset notification
To: Alexandru Dadu <alexandru.dadu@imgtec.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Binns <frank.binns@imgtec.com>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>,
 Alessio Belle <alessio.belle@imgtec.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260312-b4-firmware-context-reset-notification-handling-v2-0-aec5a64cb06f@imgtec.com>
Content-Language: en-GB
From: Matt Coster <matt.coster@imgtec.com>
Autocrypt: addr=matt.coster@imgtec.com; keydata=
 xjMEYl2lchYJKwYBBAHaRw8BAQdAOYlooFfHTXzAQ9aGoSnT9JS9wq8xprG+KVLbkxJDF5DN
 JE1hdHQgQ29zdGVyIDxtYXR0LmNvc3RlckBpbWd0ZWMuY29tPsKWBBMWCAA+AhsDBQsJCAcC
 BhUKCQgLAgQWAgMBAh4BAheAFiEEBaQM/OcmnWHZcQChdH8KkDb5DfoFAmgHpowFCQlsaBoA
 CgkQdH8KkDb5DfqxDgEA81pbVLJDmpFyFZLRhAGig9rgoDY6l774yhTzRVm/SvkBAJLzpSlm
 wyQaQuB668TKOX9XvRLKFGjSq5kkdQcxqjkCzjgEYl2lchIKKwYBBAGXVQEFAQEHQCaVC8X5
 7NOv2jNbeXqjP9ekY7rzy7auiEZ5PxaDWUQVAwEIB8J+BBgWCAAmAhsMFiEEBaQM/OcmnWHZ
 cQChdH8KkDb5DfoFAmgHpowFCQlsaBoACgkQdH8KkDb5DfoK+AD/Q4aN/zUvP72RRE4cNWpM
 MXeRXg+LTN+OJ24U10LltxIA/2w3kDqMC/0t1oqO8TM+c2LMWO/x2IBkG7oRZ/hVw1QI
In-Reply-To: <20260312-b4-firmware-context-reset-notification-handling-v2-0-aec5a64cb06f@imgtec.com>

--------------q9s7acmaFFSWyeMnnqEnHoaO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/03/2026 11:40, Alexandru Dadu wrote:
> - patch 1: Adds missing context reset reasons.
> - patch 2: Fixes the reset_reason from enum to u32 in the fwif.
> - patch 3: Adds the implementation of the context reset notification.
>=20
> Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>

Just one minor nit (P2 still has the extra blank line between the git
tags) but I can fix that when applying so:

Reviewed-by: Matt Coster <matt.coster@imgtec.com>

I'll apply this to drm-misc-next shortly if there's no opposition.

Cheers,
Matt

> ---
> Changes in v2:
> - enum rogue_context_reset_reason update moved to a separate commit;
> - pvr_context_reset_notification() renamed to pvr_dump_context_reset_no=
tification();
> - added handling for PVR_FWIF_DM_TDM;
> - update include order in pvr_dump.c;
> - fixed enum type ambiguilty in fwif headers for the reset_reason struc=
t field;
> - small QOL and nits fixed.
> - Link to v1: https://lore.kernel.org/r/20260305-b4-firmware-context-re=
set-notification-handling-v1-1-46e2ce8d46ef@imgtec.com
>=20
> ---
> Alexandru Dadu (3):
>       drm/imagination: Add missing rogue context reset reasons
>       drm/imagination: Switch reset_reason fields from enum to u32
>       drm/imagination: Implement handling of context reset notification=

>=20
>  drivers/gpu/drm/imagination/Makefile               |   1 +
>  drivers/gpu/drm/imagination/pvr_ccb.c              |   5 +
>  drivers/gpu/drm/imagination/pvr_dump.c             | 113 +++++++++++++=
++++++++
>  drivers/gpu/drm/imagination/pvr_dump.h             |  17 ++++
>  drivers/gpu/drm/imagination/pvr_rogue_fwif.h       |   8 +-
>  .../gpu/drm/imagination/pvr_rogue_fwif_shared.h    |  18 +++-
>  6 files changed, 159 insertions(+), 3 deletions(-)
> ---
> base-commit: d2e20c8951e4bb5f4a828aed39813599980353b6
> change-id: 20260305-b4-firmware-context-reset-notification-handling-694=
a1b5e6b8c
>=20
> Best regards,
> --
> Alexandru Dadu <alexandru.dadu@imgtec.com>
>=20


--=20
Matt Coster
E: matt.coster@imgtec.com

--------------q9s7acmaFFSWyeMnnqEnHoaO--

--------------gzcTP2kvjgy9Aavm1WbwKVwA
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQS4qDmoJvwmKhjY+nN5vBnz2d5qsAUCab1oJQUDAAAAAAAKCRB5vBnz2d5qsCGt
AQCoG2AgNYYa+L1N5huLeZ7rEAvVJN06u7RO8RnDCVoEnQD/SP22TATFsW36fKq58h2kWyyCU37j
jq82fCG2TjbYlw4=
=BewB
-----END PGP SIGNATURE-----

--------------gzcTP2kvjgy9Aavm1WbwKVwA--
