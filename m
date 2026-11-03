Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88342606A328
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=Pso5taZz;
	dkim=pass (1024-bit key, unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-IMGTecCRM-onmicrosoft-com header.b=eiWnYxMR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E406610E811;
	Tue,  3 Nov 2026 20:15:42 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0976B10E811;
 Tue,  3 Nov 2026 20:15:30 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3JiI8U611541; Tue, 3 Nov 2026 20:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=MWojQI2laDuoXi+7hCB4omtgurHFIrtAA7vRTgb0Jeg=; b=Pso
 5taZzoC5To/ajWyBymYJ9BMWT9jZx3tdPCtEOXR2dPRvE9SiSCLmi6yGX+Gwiree
 tLLl8Tuoi+aB8HuJqqP+aOZg3LR80uZJoEamDCAbTZAR6xh1oRHnJ7OAc2NmCyLh
 1qSLAC6mHi9SDAcMJWUdt/q8Kvg/AB3v3bhbBJdJHCFbJO4O85P+kPmQe5QioEFO
 WKgT84w6+bRObblD8Y9Xbya3Zd7RrNRHWZNISFKHfhRCEdfF/7Ufc6kfPi/cUgvv
 oG3Fv/ZvYHBdNrwfb3ggOOlehOmCyf5OArtgI+3kLm6p3jgsg+Ikj8mm8tZpuWsF
 NEtDW1JoAGTSW3rtb/A==
Received: from cwxp265cu008.outbound.protection.outlook.com
 (mail-ukwestazon11020102.outbound.protection.outlook.com [52.101.195.102])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hn7ft2hsu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2026 20:15:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jiUiKpfSxOjHplJcMx4TNeDLOGMF/VSai/72yEFIxMueCqqMAzTClb4uvBFe3hbvojl6dS3JKEho7qXrq0SXYSyDrUKN6IVbFWOJLFVskGV1/L9PfZ1Yb/Gj/UHXBxgjdB+Q3O4sdawFFyngl/b4a1Kn/4RvFb+BiEn0awAY0y6fw5iBlL3LxwvMDlEoXLhA67LEXa662izb8QuVhMst6bBv3HMZhJiGVmgksjZ33oCm1yI1KnTuK3rigJVEiHHuQJkIxKOywcWE0jZE21IVnHWoRRrM3XyTD+tGLO8gW823lXaIKTsSGXKGnIVY2U/p868pp3S7gPraee9EbcmZ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWojQI2laDuoXi+7hCB4omtgurHFIrtAA7vRTgb0Jeg=;
 b=MhMMnT4aX5POqAhvH1JeOXD0gQy/JygGMDyATFWDrlgd0mD46+P9reQEKlLomQMz+S8ZEysQDjM+2wrKyJFb8iYnhDAaFauSTzYSVxEiAB2Qzcfy95SJWFG7bOnBHVLgErKbiPHyPSLn5byJZd3t6b+8uK2VOr2j8YexxsSTpm9G/WbTTkkZjVvUqI8mSirtdj3xWRWjO1Iq9oP+759Lh2KYZ3BCQ3BUcyctABukTx1it6WGGJcB4SVp2xdQtijux3BrCwShYbwOfahkGr+2WlCEdv/wKUpK94PB3CRpoFXuBgUBmIwBU/EQNGpcaM8p679c/bfNwFWf65EUURu8Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWojQI2laDuoXi+7hCB4omtgurHFIrtAA7vRTgb0Jeg=;
 b=eiWnYxMRIcFF9a1kFx9fGN/6MJziouxchHKBo1lWhxqOTbRoiehgUr0tUSGK5QznpEc2etlVAW2m1me3eFj85c53bormHFicC2DzNhWX9M3q04Aerm9MLIogMCLmV9Z9JzMjlLek2Xy9P/bAA4WqcTmIk5SEM64cx8tMyC+aRZM=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by LO2P265MB5759.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:26c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 20:15:18 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 20:15:18 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Alexandru Dadu <Alexandru.Dadu@imgtec.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "imagination@lists.freedesktop.org"
 <imagination@lists.freedesktop.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>
Subject: Re: [PATCH v2 0/2] drm/imagination: MMU defines updates and
 improvements
Thread-Topic: [PATCH v2 0/2] drm/imagination: MMU defines updates and
 improvements
Thread-Index: AQHdWjNnysrelLP+x0C2c4lG+OnOVrcc666A
Date: Tue, 3 Nov 2026 20:15:17 +0000
Message-ID: <61bdf5689057fa6bdb3329e01cd38b1a9c55923c.camel@imgtec.com>
References: <20261012-b4-include-mmu-defines-only-in-mmu-code-v2-0-8aec58777ab6@imgtec.com>
In-Reply-To: <20261012-b4-include-mmu-defines-only-in-mmu-code-v2-0-8aec58777ab6@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|LO2P265MB5759:EE_
x-ms-office365-filtering-correlation-id: f939f9d9-73f5-4d58-2832-08df39e72ddb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|261102123227099003|56012099006|10067099003|261009223027099003|261022115727099003|261022105027099003|261021121427099003|261021123027099003|261022075727099003|38070700021|261028144727099003|261026121527099003|261026140227099003;
x-microsoft-antispam-message-info: NfRi+Cz4D8VZ2LHdGLOD0Q1UzqdlLp4RYIpzbKGu5WHkeY735YsN59bways4sNZ5stF7CUP6yLYiOcicyYBK2IxWTWoho3g9lYGZ/XMMxgCDgujDJIHZ5BT5jq/T0XtIp6M2jSpQUne0oNDYnQkJkQLSZlb8RHzqKXaaXuPn1B3KQqi+bboMedeJnozrEYBu+RJ4p3s+Yty6AyRYCEul6uxWUsiV3cuhqojS2Hjqtn9sEPh5GB92B4Jjqn2kdyRoIptcW0kH2qJTc1Pur3OM8c2XNgizQy1ZovK4I46rH7ugmta44j4MXz7u1RcytdXYAB9WpDtsc0DEbbv9l6K5iBM2W6OBsDPMyxuG2FHIjEkmeRHkcpX3GTfKd2JQdnZNLZOxccX1mpEdxO8hjtyKtAtA8+VbREf0JG6jMeFUQSYqGMwchHGHb/16hNbdhBDW9Y4m857qAO0cVrJO3J+EMLz9tdn/uGFH93MOgEzuuf2NJR41JsPgke/Ssu8t/wCsiDMVxnj0llRPv0DV3bMKJTGnTtGFIxY41RCnC6tORG+EzPcpd3h1+nFvMpNebrpBd4AuE6J8rw1CWTGBDM1vNRGEtwQaxbVVaNNvgGcL0lzMERkb4zUSFYvGtUB1fs5+xlQyHnUzJoKIDEkvi6bXC1sgB36rA8kfSGQ4mby/qnk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(261102123227099003)(56012099006)(10067099003)(261009223027099003)(261022115727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(38070700021)(261028144727099003)(261026121527099003)(261026140227099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVU0cWxvZlJCQWFPVlNzcVJyWXN1M1orc2dQMnhoeHhhdW00LzJSdUsrcStZ?=
 =?utf-8?B?RS9Da2YrZlQ2bElXM1BTcUd6Ny9raC9wSDFTZ29GTHJBeGRJWmNjN2c5Lzg2?=
 =?utf-8?B?ejZMK3hDWW9LVnBUcUNRVzZnOGI2c1FSTkdSWWY4UmZxU3YwbXZ5ekJ3RDl5?=
 =?utf-8?B?Y1FYdWo3SnRWdmhGd2VwSFM4bDlaZXltTlMvOVpaMi82K2Zra0c5RTFkbDZw?=
 =?utf-8?B?eGw0UGN1NGh2Zyt1RmZ6bjh0SVZaR1BtTmtacnBNYUp5cC9kZWgxcEk2V3pl?=
 =?utf-8?B?RTRyanMxSDVkc05Ea2tUOG9HQ2xVMHlYWXFiTmlxcUFtUGxqamVBWW5qSzVw?=
 =?utf-8?B?Q3BDYXc4Q01RZzNNTk9vNVB5L2U3NmJYMkYrR1VuWW1ONEFyV3cySzhMa1Ew?=
 =?utf-8?B?eUxVZmtIRVFTcENESjlLRUxVU3NONlpqdlVKbVhCYUdPMm5Zbm1ML2cwMHlI?=
 =?utf-8?B?djZReFlwRGtXcXp0SEZ6ZytGeHh4Nndwd0Q4SHVnb2Nab3A5azlTT3dNclg2?=
 =?utf-8?B?U0J5QThUT0RBN21Ba1MwTlVUanZtNkZxS3lPNVZBZDhWM3RBNDRPL2h0dnB0?=
 =?utf-8?B?NCtTc3NGMlk2SzBHL2FSTGtCckJjWWhmTVhja2VEYUR5b3d0YmhQUC9FMWZ6?=
 =?utf-8?B?b3FtdStaLzE5dnB1YTBZcmVNdTkrT09CRGFGMENXNEc4VFdtU1pESWNSQW9C?=
 =?utf-8?B?SFpwZUVMUHoxQ1JIS3dQaGhjQXJJYnJMZ2lZN2JONzVJSjU5TmRBTVZTOTJu?=
 =?utf-8?B?eHB6d3VtQVV0ZnYyRnVPWFh4UWhCdm1uNnN5bmZ1VHdkYjZyeHlvd3UybkRi?=
 =?utf-8?B?M214K1FGK05VYnowdWs1aC9wVWYvVzhHeUhlc1ZxcG1peitMcnZ4M0RRcVJL?=
 =?utf-8?B?QXR4akNDUSsyUmV4amFDVmtrRFJoa3E4cGo5SHZpcFRCa3Y4bU1GNUdjMkEy?=
 =?utf-8?B?S0E2c2I5dmgyMkZmckdUbXg0Yy9aK2pEb0N6LzlJKzkzMmpHVjhzZFIrVDQ1?=
 =?utf-8?B?OWVjNmZuTW5ORlljeE9XUXNLdU1uWnErYUZJSmF5UzFpeTM0Vk9wVTFoVFhW?=
 =?utf-8?B?RDJiRHFPaGY1dW00NW9SUjJ2WGlMTzVPbk5xeUxxS1FjdXYvNUg4MS9ZQ05q?=
 =?utf-8?B?NXRlTUh0ZVRybjl1NGo3UjNhR2NDRVhoVlBtcmErM3dvcmo2ak9YdFdNbVNW?=
 =?utf-8?B?RDdDUlhwVWtQUE1qaVk5RXdHRmNnZFJocHZZaS9FODJzYlNDdTU5UXNNMlVh?=
 =?utf-8?B?dEswOHBRNmZzWFRZNG1mcjZNNzNIQ2o3ZkRRVXpkZjBSZ2JSZkZabTBpU1h3?=
 =?utf-8?B?V2JGYUloY1NrSWt4VmdnVkRXdVJ4anc5RzFRM1hQVlZrbFVwLzdDR0h0MjJO?=
 =?utf-8?B?YTNHNzB2LzJobDhoc0JVckkxNGtFQ2l6YmM1Y2NSbDk1bHhqL1JOU1JuNU0w?=
 =?utf-8?B?RjlWd0dQd25aRDN5bG5LNEJIdFZzMklvWWpyS0pWTGdWNS9Vd3ZLRUYrdWx2?=
 =?utf-8?B?UlpIeUNmMkE2ZmdycEZ4SGJVY243Q0VMVERjYzdDUnBWQkNMSkhJLzBLRVp6?=
 =?utf-8?B?WWFyU3ZGRkd2RG9aSzFqejd5K2luZTI1MGdGT3ZuVmliTnhNZ0dXOHF6Z1lI?=
 =?utf-8?B?WGxGK0J0SGxDZDdHeFo2QmVDQU9saU1ZNFVMeVlHS08wQ3F5MUdhL2VNKzlR?=
 =?utf-8?B?Mnd5VEgwM3JmQ3RwNDBnNjFhZXMvRjZrZUMxQnhFWlFZV2EwM1pKalNRUFpH?=
 =?utf-8?B?aEM2Wkg2NEhaNDVJbjlicFJjdEMrMkcrVXJHa2xhU1FFRGRXeVprRlZEOFNM?=
 =?utf-8?B?MFdkL0ZTODllWXcwYkdHaG1aM2NJMWlkQ1poSmZxTSt5czh2VU1CdFBBVDFF?=
 =?utf-8?B?TTE5b2dVQnJpQ0EwZjNGYlJYc1hUNjc0STRLOS9yWlpLYVpzZ0UrT0ZtdlRi?=
 =?utf-8?B?MjVBWmZ3NFdUUHNNZ05TQThJME5yRi91MnUwSlNGNmF4UWhNUUhZOFVkb0p2?=
 =?utf-8?B?bWR1cDVJT09lcWFDRW9XWHVhY1NUaFYvbGtzQ1FEV09DNlVHMUdKSW1UcEU2?=
 =?utf-8?B?elJOSTF6WURtM1c1RVJvaFRWS0JPWGZGaTN1L2pFUHNYNWhVT0FPdkNGb05I?=
 =?utf-8?B?Y3g0cy9FR0pDY0t5UWplNE9oWjlvY1lpVEdEaEpxVmVzRnVPUnlhUm1CZjJK?=
 =?utf-8?B?NnhPenVqYm9QYkgvVUQ1RDFjSm8xOXZrZDdpL3BPd2diZy9vc1RVZHRJaUhY?=
 =?utf-8?B?OWxtN0VUZzRTanRNVDVhY2dsenNOd1NHL2ZuSlZqODdlcStGU21EY09uODdT?=
 =?utf-8?B?dlNOUzYwQ1JnZEc1UGVPekpkSzZ4cFRLZkg4L1V4S3FJL3dBVmV0aEdOUDBh?=
 =?utf-8?Q?WHNWkdEkld5vr8u8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEABFB0770BB9A45BFC4BA3DF10EE1F9@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4/HmRpXx6a4FqtV3p820YkfykPKBCnhBgV58MWO1F79xdDRb+DB55KoyV3O0/BLJSf+Hb8TZNyZ/zEEaJrRXt0hQBc57aiy0D+3PlXSE4p9t/Hs5wIL4WnSpZgq5oEZHFe8HIgTCZ/s3JJAzdli9ZTaZ1nLLt6feysTC+ZCIBdM3US6PuyMRpKlmKGhBgqoA6hZU6T6QxZpseYtqDKA+ETNiJe+H6ZSVVo/p9dxVXa2IXQeYbqdcCSzo7hihKIwBWlkNqbPJNVZPPUJxeWIlko7a8bQttAeOCsUWlgdHXB49KFTnDzzYipZegSqp1ytT6Uoq2Bx3E2XqmAwHYYzUEw==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f939f9d9-73f5-4d58-2832-08df39e72ddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 20:15:17.9191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7/kQAA+N/R5UpDBD5PqDEsuBdK8dp9fxltQPZzFBHUUkAzJdQKKj7h2ZgAH5Tpb/VCrZom6MHx+uM5f6L+nABQu/kT+ZP+qm2D+6JN2Cz6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5759
X-Proofpoint-ORIG-GUID: 2kaDlkp4DibZI8NdCbOUfZ5U42L4Ti3Z
X-Proofpoint-GUID: 2kaDlkp4DibZI8NdCbOUfZ5U42L4Ti3Z
X-Authority-Analysis: v=2.4 cv=HaSB3SE8 c=1 sm=1 tr=0 ts=6aea40d9 cx=c_pps
 a=cKUkX1iUh92DVrayS81nfA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=bC-a23v3AAAA:8
 a=r_1tXGB3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=e5mUnYsNAAAA:8 a=g-DLbdlCvdM8k0VslvEA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA4MCBTYWx0ZWRfXzvktQlRIjUzE
 XEQXRFNxLtNquWVkWmRLzcVC2kJHF6nVKBZ+sl785tdhE1NyI8dU3nEM3girWI9GIIguVGV2hiJ
 YtP8NIhqRRkd+Yt3qNTAw8KPlNdl7jQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA4MCBTYWx0ZWRfX1A04RRvrOEhJ
 wWlaVbFzl8ECBz0Hje9N5jBwf0G5zc8bk69C9KEfOR5QGLty3OMiuRXaMYnwtT+FKS8iRO26AiW
 jsBCdsdLWMUbbbWHWKNUXqA5kiEm4gQE/sbYYiyqoLdnSnCIwQzkOMd0sYIWEObQQzx/kgOHR9P
 RftnDxU0gzwZt6ZcQW2Li9tOSW1Daa1pPSnu3Pou37MoyjM/VMx7t+A/I9cK3LmD58Tr/yEkWpm
 LZz6g+aldBGGGWeGJc5o9zHKs1v6kMnKIQTkYVZgsZzBBFgiyPRoqMQ7ml4mIxcklNZmzZU7ZpZ
 TVmF4aVvuqajCi8MLxn8zYnY1dEJiTFDkuRmvhsq98bkC8O8aOGSmlrVbXsFo7v4n6n2VGWx0uy
 664zl94uZF/TcpHTnNIznwXLA25NyR2MJ12lk48Wq1XXy6+Tt4UqX9zAEDlx69eORHJznZRDMf8
 +FNR0SGcOlUjlokaoOA==
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

SGkgQWxleGFuZHJ1LA0KDQpPbiBNb24sIDIwMjYtMTAtMTIgYXQgMTM6MjAgKzAzMDAsIEFsZXhh
bmRydSBEYWR1IHdyb3RlOg0KPiAtIFJlc3RyaWN0IHRoZSBpbmNsdXNpb24gb2YgTU1VIGRlZmlu
ZXMgdG8gTU1VIGNvZGUuDQo+IC0gUmVmYWN0b3IgTU1VIGRlZmluZXMgdG8gdXNlIGtlcm5lbCBz
dHlsZSBhbmQgYWNjZXNzLg0KDQpDb3VsZCB5b3UgcmViYXNlIHRoZXNlIHBhdGNoZXMgb24gdG9w
IG9mIGxhdGVzdCBkcm0tbWlzYy1uZXh0LCB0aGF0IG5vdyBpbmNsdWRlcw0KYWxsIHRoZSByZWNl
bnQgTU1VIGZpeGVzPw0KDQpDb21taXQgNzg5ZjI5MGIyZTgxICgiZHJtL2ltYWdpbmF0aW9uOiBT
aXplIHBhZ2UgdGFibGUgcHJlYWxsb2NhdGlvbiBieSBkZXZpY2UNCmFkZHJlc3MiKSBpbiBwYXJ0
aWN1bGFyIGFkZGVkIG1vcmUgdXNhZ2VzIG9mIHNvbWUgU0hJRlQgZGVmaW5lcyB0aGF0IGhhdmUN
CmJlZW4gcmVtb3ZlZCBieSB0aGlzIHNlcmllcy4gSXQgbWlnaHQgYmUgc2ltcGxlc3QgdG8gcmVh
ZGQgYWxsIHRocmVlIHRvDQpwdnJfcm9ndWVfbW11X2RlZnMuaCBhcw0KDQojZGVmaW5lIFJPR1VF
X01NVUNUUkxfVkFERFJfW1BDfFBEfFBUXV9JTkRFWF9TSElGVCBfX2JmX3NoZihST0dVRV9NTVVD
VFJMX1ZBRERSX1tQQ3xQRHxQVF1fSU5ERVhfTUFTSykNCg0KZm9sbG93aW5nIHRoZSBNQVNLIGRl
ZmluZXMsIHBsdXMgbGludXgvYml0ZmllbGQuaCBhdCB0aGUgdG9wIG9mIHRoZSBmaWxlLg0KDQpB
bHNvLCBib3RoIEd5ZXlvdW5nJ3MgKHYxKSBhbmQgQnJhamVzaCdzICh2MikgUmV2aWV3ZWQtYnkg
dGFncyBzaG91bGQgYmUNCmFwcGxpZWQuDQoNClRoYW5rcywNCkFsZXNzaW8NCg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQWxleGFuZHJ1IERhZHUgPGFsZXhhbmRydS5kYWR1QGltZ3RlYy5jb20+DQo+
IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIFVwZGF0ZSB0aGUgcHZyX3BhZ2VfdGFibGVfbDJf
ZW50cnlfcmF3X3NldCgpIGRlc2NyaXB0aW9uIHRvIGJldHRlciByZWZsZWN0IHRoZSBnZW5lcmFs
IGNoYW5nZXMuDQo+IC0gTGluayB0byB2MTogaHR0cHM6Ly9wYXRjaC5tc2dpZC5saW5rLzIwMjYw
OTMwLWI0LWluY2x1ZGUtbW11LWRlZmluZXMtb25seS1pbi1tbXUtY29kZS12MS0wLTI5MWVhZGZk
ZTIzYkBpbWd0ZWMuY29tDQo+IA0KPiBUbzogQWxlc3NpbyBCZWxsZSA8YWxlc3Npby5iZWxsZUBp
bWd0ZWMuY29tPg0KPiBUbzogTHVpZ2kgU2FudGl2ZXR0aSA8bHVpZ2kuc2FudGl2ZXR0aUBpbWd0
ZWMuY29tPg0KPiBUbzogTWFhcnRlbiBMYW5raG9yc3QgPG1hYXJ0ZW4ubGFua2hvcnN0QGxpbnV4
LmludGVsLmNvbT4NCj4gVG86IE1heGltZSBSaXBhcmQgPG1yaXBhcmRAa2VybmVsLm9yZz4NCj4g
VG86IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPg0KPiBUbzogRGF2aWQg
QWlybGllIDxhaXJsaWVkQGdtYWlsLmNvbT4NCj4gVG86IFNpbW9uYSBWZXR0ZXIgPHNpbW9uYUBm
ZndsbC5jaD4NCj4gQ2M6IGltYWdpbmF0aW9uQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzog
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiANCj4gLS0tDQo+IEFsZXNzaW8gQmVsbGUgKDIpOg0KPiAgICAgICBkcm0v
aW1hZ2luYXRpb246IFN3aXRjaCB0byBrZXJuZWwtc3R5bGUgTU1VIGRlZmluZXMgYW5kIGFjY2Vz
cw0KPiAgICAgICBkcm0vaW1hZ2luYXRpb246IERvbid0IGluY2x1ZGUgTU1VIGRlZmluZXMgb3V0
c2lkZSBvZiBNTVUgY29kZQ0KPiANCj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJf
bW11LmMgICAgICAgICAgICB8ICA5MSArKysrLS0tLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFn
aW5hdGlvbi9wdnJfcm9ndWVfbW11X2RlZnMuaCB8IDIzOSArKysrKysrKysrKy0tLS0tLS0tLS0t
LQ0KPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl92bS5oICAgICAgICAgICAgIHwg
ICAyIC0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTUxIGluc2VydGlvbnMoKyksIDE4MSBkZWxldGlv
bnMoLSkNCj4gLS0tDQo+IGJhc2UtY29tbWl0OiA2ZTM3NWRlOTlkMGM0MjAxNjk0ODFmY2QzNjA2
NDE3N2FiNTViMDlkDQo+IGNoYW5nZS1pZDogMjAyNjA5MzAtYjQtaW5jbHVkZS1tbXUtZGVmaW5l
cy1vbmx5LWluLW1tdS1jb2RlLWExMzk4ODBmN2ZjZQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAt
LSAgDQo+IEFsZXhhbmRydSBEYWR1IDxhbGV4YW5kcnUuZGFkdUBpbWd0ZWMuY29tPg0KPiANCg0K
