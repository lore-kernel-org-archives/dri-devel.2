Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B651C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 08:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FB7C10F941;
	Fri, 25 Sep 2026 08:09:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="N16N/i3O";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="AN7WQSe7";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E770410F941;
 Fri, 25 Sep 2026 08:09:47 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P7FkT83819780; Fri, 25 Sep 2026 09:09:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=UfNef7UXct3R4efECQNlq+DUR1EO6f/YAVB52bj9VP4=; b=N16
 N/i3Omg6WAOyG8z2XL3eafX+XbRqszWdVCgfSev3EyAeN3l2ijl5P0jq2qNlMxgv
 921sQk9Sa6wgPuPuuDbqoLM2RU7ul0SMT0i/IsxBXlJ9CtAQrOGYlkBtBoSl03fc
 7iHBSI6ABio7nLvSb8BpftaKXmQAeSXhQY3TxPXPukaLzB9ajXBQJhxdMDPG2aNe
 1ZMWfx0WOfFFLLMTKncyYk6b4ejd+1Y1qPQ3EhpRHiaNRo3yjy18rlM5fC6mw1hW
 UjZN/8deDLDER7I+n0fys6EsIz6fkODo3p0TMpk2XdKP3gRo71bX2HFCyfuk8G/P
 2m+Do1uQ9yInbiAgvGQ==
Received: from cwxp265cu009.outbound.protection.outlook.com
 (mail-ukwestazon11021100.outbound.protection.outlook.com [52.101.100.100])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gwec2g82j-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 09:09:31 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3DJOMZmRt8O/5P1XSRgRWFffkqSBz8CAbc1GJSuXUlsU/LW2PIwEap2lzhD/s9rhbOKD/1ZBufzS9GmCV+TTETSnsuALO6jnb2ibH3b3XLlK1rer4IzCO1OSKTuZcV6+FKLSXggsUuQNz4mNw2gRIetWlB3qikGI2wVC2DEFMxijd5+CYseIW7Hd+7N98hfUAVAhFcsTiz4D5YKCYMn8+GgegyxcrRLtthRBZ/p6gzLyrPPleyJZp1TZ9JEwsd+pBwLSRF6viZ/dwrubQLGKBn01j1y5M+JVrWAsA79QeMIUHY7u3X/13/aioT9ceTkFbBF6UQLV/kXRFnlqU37/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfNef7UXct3R4efECQNlq+DUR1EO6f/YAVB52bj9VP4=;
 b=gLKjQKyth8AvVF+IFdM6rptiHtZkaD/dtUf8mXbhA1vbNlumHxxsWpuJtoefU866glS1u/KmqICfJNS7Ni+rUejrB7Xg7gHDZUSISCnI2N+PHDoa5KzhRI6EWCFKNHrbcvIW8J5pRV+N50ZLXWgeQdpvV6xRIx02SpUTRx5urAk/7dx0yZ+y34a6XR6Ab+DWKamVHKGPM2DIA5V/d8BNN0rebcQPaG0Ssmv/+Sd4gL9wfErWkBV2TNElU6Z9AwruAI/ZrQoYeA1BuVIGdC+bPXirkrhQ4yB8zcasevBYe/5lALNIbIYITKprIM7mKl79uaMUBGnNlIOBGusaSq2cXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfNef7UXct3R4efECQNlq+DUR1EO6f/YAVB52bj9VP4=;
 b=AN7WQSe7iAYBMEN+TENnvtZ1UCCIXCIv1rpXh8p+WjGPObSEIRZTJgBLumuT2scTbcn0S1JpRosGYpVLwM+cHsduqqZ6tHDtyIDCz9iRDe2+QZFLg5+/k5pigwA/q9LMjePJM65tZoT/rLGQank7Fp36RGgndqfX2ieQh0nG8d4=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by CW1P265MB9136.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:272::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 08:09:27 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%7]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 08:09:27 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Alexandru Dadu <Alexandru.Dadu@imgtec.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "imagination@lists.freedesktop.org"
 <imagination@lists.freedesktop.org>, "sashiko-bot@kernel.org"
 <sashiko-bot@kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH v4] drm/imagination: Fix parameter validation in
 pvr_fw_object_destroy()
Thread-Topic: [PATCH v4] drm/imagination: Fix parameter validation in
 pvr_fw_object_destroy()
Thread-Index: AQHdSlk/qBv5DbsdxU6WB2g83wCEFbbe9aoA
Date: Fri, 25 Sep 2026 08:09:27 +0000
Message-ID: <7612b0f891b829f1450538fd763f47d147880a31.camel@imgtec.com>
References: <20260922-fix-null-pointer-dereference-v4-1-6c7369b83437@imgtec.com>
In-Reply-To: <20260922-fix-null-pointer-dereference-v4-1-6c7369b83437@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|CW1P265MB9136:EE_
x-ms-office365-filtering-correlation-id: 8bc01d04-c264-4455-16f1-08df1adc51bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: qONh1x/r5RZyBHTRz2OA7xiKQEZZxYbFDHrxIptl2TZflwZoNi9Qe9HKVvGcPXF9+10pkiWrVtJUooJZm/RprLA2lga/OR639PN+16yf732tEz0SAj579EA+92XlgqwlRFXqEs2K7K+Nr5PqK48c2XmiSRay/fPlnVt9ojyTRsoHDFWysa+eK+CmUxKyI0jY68Ld4wULLfIBiiriYvcJ6qMih7hTmt5qBtiWPJ4HlDhAvAEagsxJ2JGM70yIZDUvbQJlpkE/nTiSS1D65+uL2CJGclHFylqBO/vV7H9h2ewm1CqSsMKImSdR6IjY/7g0+zYCzlKpu+39cnodMrujS7oMYTQ5fzGHZUY/us8OAweIaCmz5bBFgibyfN8Msb5AHtIMAaoXfKSPvmMUvaeSvBe9Apb5zAS7QirWYy8pQxTx7f689BTtsZt58ApUWpxYbSnc9+e3PjyZA/acZoiLpu+zjstP1wTK8ciFuEv8uCLy8PWwBHS6PQK7I/1xwPlyjCtWEoVTSX4jXC27U+WezSL1VkSN/q5gJifS/YWCnBf2NACbgbGwVleyiLnG5sJQOJjrowvyrPDlEpVsof8MzoWUsYxZOKFwlsmbrlULzTpXE2LTUdEVyJg/w6dwdma4Mbg9rmgXpVasPtoNgjUORdTMQKUZuq08ImflTIlx9m0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFl5NTI4MWtwOTRnVS9CVDdSTkVtZ3NrY1ZRcHl4T3dLTno2d2hxajRHWTc3?=
 =?utf-8?B?WVhzWmIwSE50Um5HSThMVkExVWFGOHBhUmIvYldJdXZEYmNnd3Q2TGhqMDlU?=
 =?utf-8?B?NW51RE5ZNHNiTjhwMGpGUGJONFIwMTJiRk1uOWZNdno5TUw0UnlOTVkvZ2Ry?=
 =?utf-8?B?REtPTytsWVpwZitva3dMajNFRkpkNVJTRCtIbUVwWmhqWWI3ZVFQTkpDVVB5?=
 =?utf-8?B?UTd1eFZzcjlhQmozcnF0Uk9nUEhLL1lWbDRWZXF1KzZCcE56aFpIUzZ3VEl2?=
 =?utf-8?B?UUFqVm5xV04wbTZQU1hyd1pyTTBYMFM5UVBBcGVSdWozZ0JaMkdXaGFUZ1pT?=
 =?utf-8?B?OWJOMmZrc2JQMUtSWHBiQWFMS0FmZmtsTklTNzRBUGVVQTNVd1A0N3JJaFk1?=
 =?utf-8?B?L2JaRHVLU3JwS083NzUrczZZVG5IUnNMaDB6Q1ZqWkpCbGsrZzd1NWlYVzNj?=
 =?utf-8?B?NlJ3WFVueFJ4d0tLQWU1c3Rqako0VmJHNS91Y1F6V2piUXJhbjJBSlBWUzZn?=
 =?utf-8?B?cG5zZFJvWjRPYXJORSt0TEk0R2dJb3dYaC9IQ2hpQUxwWXU0T1RtYVJxM2dv?=
 =?utf-8?B?Z1lGUG5zZ2oyeWRlWUxHWUxGV2VaQWtkQ2lQS1I2dk5oSFcrUXg3S3pKaEl1?=
 =?utf-8?B?ZmlNK0NTUGppMVY2R0UyU2xlY2pGUXYwZ09ubklTcXJxaXRIeG5zUnRsUjhU?=
 =?utf-8?B?UERKWkFpaUwyZlRFa0hDMUxMam9KUVFLbFJBdnpLcUVhMS9qVFRBNFAxb3Ri?=
 =?utf-8?B?YjIzTjN0NzdRUlpVRFNQSCtiVUl1T05vbXBxRk05RHRqSWlwOEdaUVRUTlV5?=
 =?utf-8?B?YTlXK3dpM0h6QW9YVjVzSTBQZEh2UlV4d3p4VlJKY0dSTEhtWG8xZUZ4cDBM?=
 =?utf-8?B?V1VnakJieUhRaXJLdUFyRlhHRTZCUFBiR3lzN2g0WWExWVpTTU5BUlZvZElT?=
 =?utf-8?B?cC9tbEZYdG5VaE1TSjNPcVFrK2J3bnJPSTFnY2p5dm5YQ1FHdjJxb0poVy9z?=
 =?utf-8?B?OHkxa1lEditoaThwZ2w0cmF6cWpwRmtGVkdVbDNPLzZEV0dYL2hONU1rcWxl?=
 =?utf-8?B?U2VIZHY4MUoxaVZxOERXNEtNKy9xR25aTmt2amI0MzRrdmJHYWRXQllxWkNL?=
 =?utf-8?B?bUJNMmJhRXhubEpldCttMEY1NFlSbC9GUm5XUENOdWxnSkE4WnU1bnBsYzY4?=
 =?utf-8?B?V01rd3BDNVZaMnROdDBPcEZscm1PR1pwNUp1Nkd4dmhHZDlEZ1hyL2ZMUnI5?=
 =?utf-8?B?dTdLQWtrVEhDRUxsT0VVY2VVN2tLWFBYeWc1eUM4a3FtZlpwb1FSc0JaeGZl?=
 =?utf-8?B?eEZNK0JoczF4RTh3WHE0UWUvWEwzU2tJLzhXcjZxT2ZqZUhrY1pjVXFUVmdV?=
 =?utf-8?B?OGFISjZkNDJuZnpqVXo0VTVTZEdBWnRTZjAvTmNoQzE0VDYxb280dk00S1V5?=
 =?utf-8?B?TmNsbllXSHFkNXFhZTcybjBmRVlsbGNzaE1BZEp1VjJsaU5FTnVBcjlKK1VV?=
 =?utf-8?B?d0h2YTkzd1AxOXVkU0kyQjJ6TnVPaFQwWGp4aGU3UlJ2SURCWFlDUEppWGRm?=
 =?utf-8?B?Qmc4dW15RzdpdFZicUYvNDdvRlFJY2crWnhNVzZpaXBMTW0zc0ZSR2xpb21X?=
 =?utf-8?B?ZzJISzMzM3NualdZMWVFTjl6NDVtU0xGVWxyZkVBYjF0emxtb2ZkMGdMeTBa?=
 =?utf-8?B?Tkp0cmdVODZFUTRIL2xvRUlNc2dGbnNyalBtTjZaemdseXEvb0x5aFBwSkhn?=
 =?utf-8?B?aXcxZCt2aGcvQUppVCsyUkVxRFdhcFZ6Q1dMV2RtVHBrZzhob3grSW5Xb0Yz?=
 =?utf-8?B?VFZqZDZnQmRickJSNmdLTFNmdUVGc1RSd2hKeDBBY3FTOHJYbnBrNWlvSlFx?=
 =?utf-8?B?d3llWTZwTWZnR3pTSVF3NEFsUjlHbVJBZXlaM3JZTFJiMkp6bEkwSjcwdTdl?=
 =?utf-8?B?K3E1bFB6MnoxRllyUFp5bTY0Q0pLaDFjSTBnQWlIRThheks2STVTc1N4N3ht?=
 =?utf-8?B?aVBISDBEMzJ3UDVzakdUOExiUFM1WTFoUlhyMXIyc2Eyajgxdm5LQnpaWDZR?=
 =?utf-8?B?ZzZnMlIzVGZIK1hPekxodDJYeGFmMUFGUTZLaHF2TytDYTZJYjF4UGtFQjVQ?=
 =?utf-8?B?VzhONWhPalJJYnJCVmZLNXl1UGRjUUljRmRheXE4ajgzWXlSMG1HSXZnTmtQ?=
 =?utf-8?B?S0ZFZTV1TUpVNDdsdTZ2V3k4UDVQZ2VRU0h0SUF1WU5iaFVWcGNwNkNQRFpX?=
 =?utf-8?B?VzZOa25mMlI0ZUczYk15Snp2MXZ3RUtOOEZvaS9HYVozUEFjVVo2VFdHY3k2?=
 =?utf-8?B?amNkVGlPSktuNExMOENzMnViNGt3WVpIdUVXOWtxTWxwa0VqOVJYQTIvdFdr?=
 =?utf-8?Q?VlLiLTEi031nM0cs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8597A219BB33743A57235689CBE773C@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qNX5EHsjmyr67HxMdipaBBAK7MSyr+Mvz43/vJvfi9ZlJ98TsTn9pZNvbVRlT11/AHjSEnEpM3geaUzgKerb7kXkSZx5qA8HHoVZwJb0dpxm/cvju8x//LhTs9Q2Kmm0nKQJD9Oap80s/u71RkoNmHHdnW/qL2jo3OOMuhd0hTkNZwkKH4D2fGfSM7+8eRxUVtbs/fj1EkxK2CQxkiIkLV2GY+7MpihKgQxI9+FKYws+6i5sO4kFaUe5BLlLQq1FqxyO9BXRk9XA/j/eU4IMdA8ENx/ND2wgC3jhoys+SI+dq7lmIww+gfz3vXjwNiPHjXg0H9kKyBknEHOG2Llpvg==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc01d04-c264-4455-16f1-08df1adc51bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 08:09:27.6105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U31N306c1N8XSXiremdSXv80l+mYntxdXiHi3oAhgwm/gtKtYQcLn7aU4KKoO02niqtxobULbgFfY14wIF7UXw9f9hIyVepHwO/bebYllqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB9136
X-Proofpoint-ORIG-GUID: XD8dvrIYOEU5hUa5XCxC0Tf1_5U1PULP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzMiBTYWx0ZWRfX8PND0y8iMAVJ
 BZqQGXAP3MJyG0feSj1MmIG57hVgudFwasbsozRNWU2UKz8KjQkCcc3XbxLc2/JtYNxJzt01ypT
 KQbQQLFu1ZZcdHFlV8aMmnkwf4SPJJo=
X-Authority-Analysis: v=2.4 cv=FsSQbGrq c=1 sm=1 tr=0 ts=6ab62c3b cx=c_pps
 a=oadnnpdogVhhPU8NEU1TIg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=VwQbUJbxAAAA:8
 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8
 a=e5mUnYsNAAAA:8 a=yquQxoIgQxfYBwPdRxMA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: XD8dvrIYOEU5hUa5XCxC0Tf1_5U1PULP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzMiBTYWx0ZWRfXxTdQ2amK9w96
 wL64BFZPgX61zXEv1YO2PU0JgB6nLBhp15NsBrKllDeeFCu4h1TifWwx6mpgrz+EnUOcPR5y6xQ
 wEgiaEZZMHNk7yBYS1BE9Iz08Ol/hFq5FDOAKdjZtr030xIWC1sLO+UszeQx6gUN/jkImOSGjQs
 vWsbcZ4GYeVnX3i/6JFhWCBTQtuIpkxI//+3VLLSlToXrq7fsL8nfJTfH0Qjk+HHQDUsFdZ3hqt
 gEFbSRWeXyTMmitbM53cPOtyP66d5twzseoZSMytMphe5lHtF17ZDj0EjTZfsvbB9R0gDyJuxVJ
 jPF0uEoc0nrQq4hKeHELdUsvbjiXKvzfoHVJaVY+FQvB+16nF24dZTyzEf5xpwj/C3TyVBKUqQc
 GhW/uFVZ71qwZ/LXrwlPbze7bXZNsCEOiE/b0KUnL+h0GswrN/RQE0mhETBPiiGN/jDexkbqDWt
 3e2UEA7mj6tDZTdZwsQ==
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

T24gVHVlLCAyMDI2LTA5LTIyIGF0IDA5OjExICswMzAwLCBBbGV4YW5kcnUgRGFkdSB3cm90ZToN
Cj4gRml4IHBhcmFtZXRlciB2YWxpZGF0aW9uIHRvIGF2b2lkIHBvc3NpYmxlIE5VTEwgcG9pbnRl
ciBkZXJlZmVyZW5jZSBmcm9tDQo+IHB2cl9md19vYmplY3RfZGVzdHJveSgpIHdoZW4gaGFuZGxp
bmcgYWxsb2NhdGlvbiBmYWlsdXJlcy4NCj4gDQo+IFNhc2hpa28gcmVwb3J0Og0KPiBJZiBwdnJf
Z2VtX29iamVjdF9jcmVhdGUoKSBmYWlscyBpbg0KPiBwdnJfZndfb2JqZWN0X2NyZWF0ZV9hbmRf
bWFwX2NvbW1vbigpLCBmd19vYmotPmdlbSBpcyBleHBsaWNpdGx5IHNldCB0bw0KPiBOVUxMIGJl
Zm9yZSBqdW1waW5nIHRvIHRoZSBlcnJvciBjbGVhbnVwIHBhdGguDQo+IFRoZSBjbGVhbnVwIHBh
dGggdGhlbiBjYWxscyBwdnJfZndfb2JqZWN0X2Rlc3Ryb3koKS4NCj4gDQo+IFJlcG9ydGVkLWJ5
OiBTYXNoaWtvIDxzYXNoaWtvLWJvdEBrZXJuZWwub3JnPg0KPiBMaW5rOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9kcmktZGV2ZWwvMjAyNjA4MTAxMzIyMDIuM0MxNkQxRjAwMEU5QHNtdHAua2Vy
bmVsLm9yZy8NCj4gRml4ZXM6IGNjMWFlZWRiOThhZCAoImRybS9pbWFnaW5hdGlvbjogSW1wbGVt
ZW50IGZpcm13YXJlIGluZnJhc3RydWN0dXJlIGFuZCBNRVRBIEZXIHN1cHBvcnQiKQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgRGFkdSA8YWxleGFuZHJ1LmRhZHVAaW1ndGVjLmNvbT4NCj4g
LS0tDQo+IENoYW5nZXMgaW4gdjQ6DQo+IC0gTW92ZSB0aGUgc3RydWN0cyBkZWNsYXJhdGlvbnMg
YWZ0ZXIgdGhlIGVhcmx5IHJldHVybiB0byBmaXggVjMuDQo+IC0gQWRkZWQga2ZyZWUoKSB0byB0
aGUgZWFybHkgcmV0dXJuIHBhdGguDQo+IC0gTGluayB0byB2MzogaHR0cHM6Ly9wYXRjaC5tc2dp
ZC5saW5rLzIwMjYwOTIyLWZpeC1udWxsLXBvaW50ZXItZGVyZWZlcmVuY2UtdjMtMS1mMDk5NzYz
ZWQ2NzZAaW1ndGVjLmNvbQ0KPiANCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSBTa2ltZWQgdGhlIGNv
bW1pdCBtZXNzYWdlIHJlbW92aW5nIHJlZHVuZGFudCBpbmZvcm1hdGlvbi4NCj4gLSBSZWZhY3Rv
cmVkIHRoZSBwYXJhbWV0ZXIgdmFsaWRhdGlvbiB0byByZXR1cm4gZWFybHkuDQo+IC0gTGluayB0
byB2MjogaHR0cHM6Ly9wYXRjaC5tc2dpZC5saW5rLzIwMjYwOTAzLWZpeC1udWxsLXBvaW50ZXIt
ZGVyZWZlcmVuY2UtdjItMS0xMzhmZjliNmY4MDVAaW1ndGVjLmNvbQ0KPiANCj4gQ2hhbmdlcyBp
biB2MjoNCj4gLSBDb21taXQgbWVzc2FnZSBhbmQgY292ZXIgbGV0dGVyIHVwZGF0ZXMuDQo+IC0g
TGluayB0byB2MTogaHR0cHM6Ly9wYXRjaC5tc2dpZC5saW5rLzIwMjYwODEyLWZpeC1udWxsLXBv
aW50ZXItZGVyZWZlcmVuY2UtdjEtMS1mNjliMmZmZTk1MjBAaW1ndGVjLmNvbQ0KPiANCj4gVG86
IEFsZXNzaW8gQmVsbGUgPGFsZXNzaW8uYmVsbGVAaW1ndGVjLmNvbT4NCj4gVG86IEx1aWdpIFNh
bnRpdmV0dGkgPGx1aWdpLnNhbnRpdmV0dGlAaW1ndGVjLmNvbT4NCj4gVG86IE1hYXJ0ZW4gTGFu
a2hvcnN0IDxtYWFydGVuLmxhbmtob3JzdEBsaW51eC5pbnRlbC5jb20+DQo+IFRvOiBNYXhpbWUg
UmlwYXJkIDxtcmlwYXJkQGtlcm5lbC5vcmc+DQo+IFRvOiBUaG9tYXMgWmltbWVybWFubiA8dHpp
bW1lcm1hbm5Ac3VzZS5kZT4NCj4gVG86IERhdmlkIEFpcmxpZSA8YWlybGllZEBnbWFpbC5jb20+
DQo+IFRvOiBTaW1vbmEgVmV0dGVyIDxzaW1vbmFAZmZ3bGwuY2g+DQo+IFRvOiBEb25hbGQgUm9i
c29uIDxkb25hbGQucm9ic29uQGltZ3RlYy5jb20+DQo+IFRvOiBTYXJhaCBXYWxrZXIgPHNhcmFo
LndhbGtlckBpbWd0ZWMuY29tPg0KPiBDYzogaW1hZ2luYXRpb25AbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0
aW9uL3B2cl9mdy5jIHwgMTEgKysrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2ltYWdpbmF0aW9uL3B2cl9mdy5jIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2
cl9mdy5jDQo+IGluZGV4IDg1MGEzZWM4ZTc3NS4uMzlkNzBmNTFmMTI2IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3LmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9mdy5jDQo+IEBAIC0xNDI1LDYgKzE0MjUsMTQgQEAgcHZy
X2Z3X29iamVjdF9jcmVhdGVfYW5kX21hcF9vZmZzZXQoc3RydWN0IHB2cl9kZXZpY2UgKnB2cl9k
ZXYsDQo+ICAgKi8NCj4gIHZvaWQgcHZyX2Z3X29iamVjdF9kZXN0cm95KHN0cnVjdCBwdnJfZndf
b2JqZWN0ICpmd19vYmopDQo+ICB7DQo+ICsJaWYgKCFmd19vYmopDQo+ICsJCXJldHVybjsNCj4g
Kw0KPiArCWlmICghZndfb2JqLT5nZW0pIHsNCj4gKwkJa2ZyZWUoZndfb2JqKTsNCj4gKwkJcmV0
dXJuOw0KPiArCX0NCj4gKw0KPiAgCXN0cnVjdCBwdnJfZ2VtX29iamVjdCAqcHZyX29iaiA9IGZ3
X29iai0+Z2VtOw0KPiAgCXN0cnVjdCBkcm1fZ2VtX29iamVjdCAqZ2VtX29iaiA9IGdlbV9mcm9t
X3B2cl9nZW0ocHZyX29iaik7DQo+ICAJc3RydWN0IHB2cl9kZXZpY2UgKnB2cl9kZXYgPSB0b19w
dnJfZGV2aWNlKGdlbV9vYmotPmRldik7DQoNCkkgaGF2ZSBhIHByZWZlcmVuY2UgZm9yIHZhcmlh
YmxlIGRlY2xhcmF0aW9ucyBhdCB0aGUgdG9wLCB0aGVuIGNoZWNrcywgdGhlbg0KYXNzaWdubWVu
dHMsIGJ1dCBkb24ndCBmZWVsIHN0cm9uZ2x5IGFib3V0IGl0LCBzbzoNCg0KUmV2aWV3ZWQtYnk6
IEFsZXNzaW8gQmVsbGUgPGFsZXNzaW8uYmVsbGVAaW1ndGVjLmNvbT4NCg0KVGhhbmtzLA0KQWxl
c3Npbw0KDQo+IEBAIC0xNDM5LDggKzE0NDcsNyBAQCB2b2lkIHB2cl9md19vYmplY3RfZGVzdHJv
eShzdHJ1Y3QgcHZyX2Z3X29iamVjdCAqZndfb2JqKQ0KPiAgCQkJcmV0dXJuOw0KPiAgCX0NCj4g
IA0KPiAtCWlmIChmd19vYmotPmdlbSkNCj4gLQkJcHZyX2dlbV9vYmplY3RfcHV0KGZ3X29iai0+
Z2VtKTsNCj4gKwlwdnJfZ2VtX29iamVjdF9wdXQoZndfb2JqLT5nZW0pOw0KPiAgDQo+ICAJa2Zy
ZWUoZndfb2JqKTsNCj4gIH0NCj4gDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogYmQ0ZjI4NGRmMDRk
NzZmZDY1ZTU3MTQxY2IxZTZlN2E0OWU0YzNjYg0KPiBjaGFuZ2UtaWQ6IDIwMjYwODEyLWZpeC1u
dWxsLXBvaW50ZXItZGVyZWZlcmVuY2UtMmM4OTExNDJkOTg4DQo+IA0KPiBCZXN0IHJlZ2FyZHMs
DQo+IC0tICANCj4gQWxleGFuZHJ1IERhZHUgPGFsZXhhbmRydS5kYWR1QGltZ3RlYy5jb20+DQo+
IA0KDQo=
