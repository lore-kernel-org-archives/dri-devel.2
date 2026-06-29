Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2E8C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E82010E5D5;
	Mon, 29 Jun 2026 15:01:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="K/XRDLf4";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="c4PcCLcA";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A547510E5D5
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 15:01:14 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAXJoT2985526; Mon, 29 Jun 2026 16:01:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=qlmpRdDgXryv7ce/btMxHDSybJLCRSNy/KKBIs4cgH0=; b=K/X
 RDLf4jf/jNtDNiL5rpM4D2xRJnBvNtslDpRy6kCUGrQxpVnvV6Q7IKBGdlpmtTUL
 v6K0Mz5PpdCxaq8BsCavurErvYvKbWY0W8wkCxtv2Yb1EY6oY0NQmbamKo1yJpFq
 pqm8k0TUxPIuyvLKqbeRZiziBefVwhnEdUsIlbAcd9yncuWktm08VvOxN7xtSXwS
 AGlcvMC4B2GGxeHxa49cOUUmXwco2Xe5QV7byJnaNSp1YE92bpRoGnAed+x9keoR
 wAZ9Oalwb2xI69uBtGt1F88w/pAZUHnjRcbZdsL828dkoQLd8U9JXHsEjnvrJLfZ
 uv7IibrtmhE3G1yq+pA==
Received: from cwxp265cu010.outbound.protection.outlook.com
 (mail-ukwestazon11022103.outbound.protection.outlook.com [52.101.101.103])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4f24snsu3s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 16:01:09 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjNTJiVQksD7VwKu2nS0Ax8sr+nasQBpi5vm9VhdgBedSavF2tW7SSbahdQaHLrghuaEUM/NEw6N0lvlfthArHJXzRgm7KzggdLX7Omt2/TDlbR7Z6g9d3eRO3PoNqF16qljVhFdlk9KdLoxXr5N/3Nj61/zgnR4sEVWn9j5L+hPKoXW3TN4IgNW2RovTnt0JEqMLRr9SjaA2XbJVyiWyWiOLKp7Y/FYgI12z32Uu+OXRg0mjpjgcaEUZSGJRS+YWLYh+XJ8LYa1Fms2jf/U/aXzY+gg2g1z+V9l8PsHLiddFcnYsZ8Pyx2ut4UFckM38vmjv81Ff9f82sH//1QjpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlmpRdDgXryv7ce/btMxHDSybJLCRSNy/KKBIs4cgH0=;
 b=WN5YNU8Phxzxly/ZAqEgaF7KYrE8GBXJMy5KZViymUBuN2pUH/UWabM6dRo7PMOjdMcsTsijg78H5t1cfcvJv3BJ942iY/VPbgF8ERjVDROgn4CPnuHxLEuWJRIK0ch823HS0eCKk1AjqmjFx4eeiY3eo3FsTBl902JNETCzephisdwRfIlIJ0IeDM1B4dgsxEulXc0LydTdT6Bnxy32T3PjzFOeu40EQnBRJKGJtkMcLUCq0F+VjczqFlSPEuyfutl+dd7mB/nPkp0VoikHOkZCfi+ilQhPh4YXfIp00SZ93VytCHyj07MxQhbCopzWKiJqYrR/jGaKXBPRHjhL+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlmpRdDgXryv7ce/btMxHDSybJLCRSNy/KKBIs4cgH0=;
 b=c4PcCLcAYPsAPBXA6xbPswNnmFN1PlRR4G6Q1gRbxcX2RCgc1hjpfcllc9iJ9+vDcRYI5tTowMRy32N3Ss/xrrhGKkiXfBrEyLewhy/LXtKiZLvRkYXw7g/8opNxZZwblmCLhd3cRLxiH7fA1o21l+gGCPHilkOaKckhJED+mpE=
Received: from LOBP265MB8787.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:48c::10)
 by LO4P265MB6665.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2f5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:01:07 +0000
Received: from LOBP265MB8787.GBRP265.PROD.OUTLOOK.COM
 ([fe80::7f5b:307:2916:a6a6]) by LOBP265MB8787.GBRP265.PROD.OUTLOOK.COM
 ([fe80::7f5b:307:2916:a6a6%7]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 15:01:05 +0000
From: Luigi Santivetti <Luigi.Santivetti@imgtec.com>
To: Matt Coster <Matt.Coster@imgtec.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
CC: Frank Binns <Frank.Binns@imgtec.com>, "conor@kernel.org"
 <conor@kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>,
 Brajesh Gupta <Brajesh.Gupta@imgtec.com>,
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, Alessio Belle <Alessio.Belle@imgtec.com>
Subject: Re: [PATCH v2 0/3] drm/imagination: Maintainer updates
Thread-Topic: [PATCH v2 0/3] drm/imagination: Maintainer updates
Thread-Index: AQHdBWloqbqB7AIijUCn0V6G8jorbLZVpV4A
Date: Mon, 29 Jun 2026 15:01:05 +0000
Message-ID: <77b6e477577a8ce87ecb690ec202eb3c33286b95.camel@imgtec.com>
References: <20260626-maintainer-updates-v2-0-e1b3f246c44c@imgtec.com>
In-Reply-To: <20260626-maintainer-updates-v2-0-e1b3f246c44c@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOBP265MB8787:EE_|LO4P265MB6665:EE_
x-ms-office365-filtering-correlation-id: 673cfd8c-8f7d-473e-721d-08ded5ef3e44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|18002099003|38070700021|22082099003|56012099006;
x-microsoft-antispam-message-info: hLGGGdF6HiQ/+RSsrvT/nFCRVpJGnqziwoPi/S2GOk+LMjx1c/kFx0ieXdOoOecVUeKNEZokQT3TMoMUADTqjdxAB3/TadsAgrq+tOO672LJAPW15w868xuKepE2JIKQ2uVrU6mnLFJi5NmG8RZVpHpg0E9cHy+gIIg55r9Jq7E1I5AEh1vqqneSuFUGbQOWfh1t1bbCqytK5gR7g3B/ZTDk2GbLkfxZnpyBONgtD1wN4ttUGVXHXpPJP5dwYVwKd4992b/jM3Ik6mo5qliWS3AAI1WcMTP6xRfIzT9FJNplReARTS3qXLIh8WKxgyyAlvNHb6nHJVjVeQiO6tI+FnfrC3MTxAl7IDvx6YHyUu7OKG0FAdPDUeaTjx4bbINUhIg3xFOTn78GIXk6Ii0JR4vyrzhYOld7l0P+qCG3pDNKk+JrJwwfFugIO7ITmku48fTBFmDwPjf2qZ3ECNqiD01OI4peuCjHFgAnVYeXeNK5epoUW+Sv5w1pxhUmr0ApSqJWYpF8T1WIUxSirtI8UenpCBrjOcr9PCDMN0aHa2ebrKxrc5JgVdbj+kcEhoXcP8F+/TFzrpIjysOjQaJXARbO6edF477Pbana58vsMYU9+/w3PO4h8hTxI50g20+lcz5417YZrnLSI2zKUqcH8fc8wbj+okUGecoVGs3fjYo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOBP265MB8787.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(38070700021)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2VzRDg3QTZ2YXMzWkFxVHBaeGJoTS9FWC9ycTdGR0F4bGl3N2VPQlBTc1VR?=
 =?utf-8?B?TVluaGdSNzdXcVBzMXArZFpDUWFNdFVkYmVLaTc1d0dKNGMyczdGY0dIT21y?=
 =?utf-8?B?VlRSWktjbWt4TTZZTHptcWhhSEFpaUhKS25qWmNxVmplYnJkYUJjU3gxTHoy?=
 =?utf-8?B?WXduTS96eWJsRUpkVmF3SHV1L3JKczBHSzJjOTRIMjE3ZTZSODRnM2xIVnVQ?=
 =?utf-8?B?aldaNE9CcmJUNU1tbjBRanZ5d0o1MW9ka0dVbVVJWER6REJsSmM0OWNDeFdk?=
 =?utf-8?B?aGRrS2JST1FBb0RJNktTWG1BRTZTMUwraHM4RVlZKzFHK0tCeDduYXE3SVBI?=
 =?utf-8?B?aWxlSEhpaVdORXh4azJyTVVZK2ltZDNvNyszbXp4ZmgwVU9CeGFuR3ErU0oz?=
 =?utf-8?B?dmdjZ0hITURWekRHc2VHQzNoS0V5SG0rVEx4bUZLbmcrVVl3ZmVhcm9kNExa?=
 =?utf-8?B?b1dqRFROMStYZlJQeWJ2Rkt4KzJ2aXhGeDBacFkxK255bm90SWtpVDRCNlZr?=
 =?utf-8?B?OXJQNVNrVk9LM1RRQllSSG9nbW1sTHg5QkJ6L2xPbmhZOUhCcHppYTZUVVNa?=
 =?utf-8?B?a0ljVUluV1RhVC9Fc0NiRS9XRTZjTUJXeW9OdURyUUxEK09SS1pvc0RvKzY4?=
 =?utf-8?B?UXc0VHN3NHhLUURYVDduMzZNOW5hVUpJOXRMNUU2djdPVE5jb0FIeWVQeWV0?=
 =?utf-8?B?STVBYTlVcXZlRXVqSTNseE9CcnNRUDlXM1BieG5IRGhnYUZ6V2dFQUdmSWl4?=
 =?utf-8?B?S1U4dUdBT1hOWmNjQkhacUk4WW9VdS9kTVArNHlwVUk1SWtPbGVJVk9sbWpa?=
 =?utf-8?B?ZEIrNURvVEFlamIzWGw0dVk2SWJDUTVWc20raXdaRVlFekNldjhHUjUvTXFM?=
 =?utf-8?B?ZGtjdDFhZHZjYTlmK3hGQ0hSQ1ZpVExJZFhxbFc2OUVhbWJXaUgrd3V6YzlH?=
 =?utf-8?B?Y29RVU92clpNc3hTMng4a1JwUGZnb2tHWDZIU3hFN2x2bkdJQXZsODN1bmI1?=
 =?utf-8?B?WlR0QXBrVUtxSVdTTXNKcVFkaVVtSWZZTHhWTEJtTEFOZUdpVk96bWdyeWxW?=
 =?utf-8?B?V2xNWnNzYVd5ajZQWjdnT1VGWWVKNHNxcXVXU0lJWkZIbVZSd2RORG1GeXRq?=
 =?utf-8?B?bTI1NnlTMEw4UHBOd2N5bXJBK04rb09sNlNwNEpvSHk2YmRqZTFKY2VTd0FC?=
 =?utf-8?B?eGg4SkxLUE1tbmNCSXZ1MURaT1FwWFF6eFlmSDRDb3BGbzZBZFhDKzNNcCs3?=
 =?utf-8?B?cFIvWTBPS1grVHVwQ3JTZmJNWUFHbFJrOUE1STczUHJicnpzSlFZc2NEVTVO?=
 =?utf-8?B?UmU2N1phZitFRytjcUh5aHZGRzVMdkhTQzZvYlBpK2JLM1dqWFFvSmJUNFZ6?=
 =?utf-8?B?V2hLZHJoSGFJdHUyMHhqeWFmY3RNVFBRU1JwMHRieGUwZ2RhU3NOVi83Ym1O?=
 =?utf-8?B?aVRhNEM5cmtOS1ZqUENVazVSTkZYR1d2R205T0xtNm5jNWVaR3ltMmlXeWNt?=
 =?utf-8?B?VElTaHNQK1pwNE52NU90SmV5eDBINDNGZjg1a2RQTmQ1ek5IaWpqdmJiaC92?=
 =?utf-8?B?RkFLbWFwbC91VlgwV2Jtc0I4Z3VqaXkvdDQwcU1yM0Y0SDhLUkk5eEdpdGcy?=
 =?utf-8?B?WUtaWFJ1NURVbWY4RklNNWdaSWNHNXFoZjJKdHN6R1lHQUx5bVRrbDBXU1pm?=
 =?utf-8?B?cktnTGlERGFHc0lGa0ZWZzQ2RTdiTzRNQTJKN1hTSkJxMVdTU0dGeG56M21Y?=
 =?utf-8?B?YTgzTkhXcWVYV2xnTjlPeHNLcDdSQVhBWlVYYnZ3dVhiK2pCMFNQUWpNK1Zl?=
 =?utf-8?B?NnFHOE16Q29KRGdtRU1wZGlXeGZCVFpLY0Q4SDRZYy9UdnBBeVFxL1J2OEZT?=
 =?utf-8?B?emxvYjZ0bmJkK1BhTjBQL2dnVlppNkg0U285TEpqSE1QcG5LQ3A0bVpaN0Nj?=
 =?utf-8?B?Uk92dExrQU5zREk1MGc5NTFxNEFQVzNyQWlZT2xlMnhiajdYY0tNQ2tiV3A1?=
 =?utf-8?B?a3o5M0txZHNBaUhDTHZKS0Z5VG85WGh5bHlkYXczMkc5NEJCbTFGZWIvS1lR?=
 =?utf-8?B?OUl5emo3WmxNS0pmcFd0VW9Ka0k2RDQ3cWlMWXRpZUhkSmdJOG1INHlTRVBN?=
 =?utf-8?B?MG1ZOHh3eThHOUd5WmhZcGg1NEtyVU1zL3hzelU5aTRmS0RUTForbWg0YVQy?=
 =?utf-8?B?b2g5Y2hzMkNLUmhwYXVrTldJM0M3eVpUSnd2OUE5eHNNdzY0ek9kZm4wY1Uv?=
 =?utf-8?B?OVZ0TDV6NVFmNnJQeitHZkNvcVBvY3g5eU1zTVBWTndteWxhMWpRRzlocmpZ?=
 =?utf-8?B?UENtcWRvRzhQeEc3K0taVW1CRDU3T1B4K2tURldsUzRFOUdkbEQ3U3J2VGQy?=
 =?utf-8?Q?CiyMIJmJzunFxTyI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7322B93FA506F340BC7456D7BF4896EC@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OtwXHFTx6uHVE0tR0I5/Gn88nllz4CUXQn9eFSwKGc9H3ID1GwWRqokkETS9BrRCxMgJcMiiN0RUr/91i9552U32IBr5chBCW3YJG/CF70/bCiZ3dG/Ly99P2tPUtg1PeCsSydEsHAeKnApGarELk4pHmjzfeoizDVBba/PFcbWgtvWbMpVGJSgHTHEW5nuYTwPweZwIaOxNxl2NOdnddjpp1Xs08cH7AQqLosGUSoinQaRxOhyMme4krwozSvOEO9pOTkKHV1UF4LuZuJhWXGl0caDqSU6oOO+fLD8GTOv+S484CIQA3dLJqk6Pjr1n21jBAnDR/wM7KL9+7TA4Uw==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOBP265MB8787.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 673cfd8c-8f7d-473e-721d-08ded5ef3e44
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 15:01:05.1349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MgD+qqxgKHJqhf+UatUl5iXt5BDGNI3IIJ8OBRIWp6dD/1sHT1AkWoUNDa2/XbmsbqTsiOGjH7kJOKPht4SaWGz4kKfmYExH940b/qq19a8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6665
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEyNSBTYWx0ZWRfX4qOKisN48yE8
 J9RjPXPnClrl5hOy+jJz8nF5AqbWokyXWx36D/OucEflzkxUzHyLijqQbl2b4jTmArC51UkpKu7
 zswIg7Oo1CIZgyM6wG8Fnb/A+2Dj09U=
X-Authority-Analysis: v=2.4 cv=We48rUhX c=1 sm=1 tr=0 ts=6a4288b5 cx=c_pps
 a=HmraOUsOhfZOpJNHsUmbsw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=bC-a23v3AAAA:8
 a=r_1tXGB3AAAA:8 a=L2RzmchsezbkXKeWatgA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: x3fxWjvQyi7qJ5v-UCfL3bjKT7reAn34
X-Proofpoint-GUID: x3fxWjvQyi7qJ5v-UCfL3bjKT7reAn34
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEyNSBTYWx0ZWRfX6eMtegtGGjPt
 LtlAjCBZLSOY9OqfFiv8kP4OM+xmU/79u5Ff0oHZAV8nkj8XKB0I796eS77lCzqZ4uRHFAwEUBH
 4sm8NDSjq3WLeVGtm+V6zhVbzEL/Cgsl6vyUeF8dKD0lC/HGIfvO2i/aLfI1ptHX1a4TDod7jgM
 r5JgXtHCABTMlZrZ4Vlw0R2lQUKgKYOQQlD5KMV6nKK87pLl/VRP6e4wStHQ8A+FA/5/mS13t/P
 6Z2dalUWF7nu6/MMjQ5AVy5+GJY93bxkPAYY5Q9wLYnhjzYjVoUKQ6tGpU+5ojYOIqv/z73R4hB
 /OQQTIootike75Un6svJbOMtGv34MIGk5F2JA26tPr522wE/eAvBcl+DQkBNWz4ylGJKalK3aNo
 4Rx1nAxVzIOc1BD6XFYtKd3O/t//ImyGpF9N3fHgOs7pRQ8MJR32wWo8Fm8OBAgCwDH1kZF5OyR
 nYOYg6cMdn8QLPuCpFg==
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

T24gRnJpLCAyMDI2LTA2LTI2IGF0IDEzOjQzICswMTAwLCBNYXR0IENvc3RlciB3cm90ZToNCj4g
V2UndmUgZ290IHNvbWUgbmV3IHBlb3BsZSBzdGVwcGluZyB1cCB0byBoZWxwIG91dCB3aXRoIG1h
aW50YWluZXJzaGlwIG9mDQo+IHRoZSBpbWFnaW5hdGlvbiBkcml2ZXIsIHNvIGxldCdzIHRha2Ug
dGhpcyBvcHBvcnR1bml0eSB0byB1bmlmeSB0aGUNCj4gbWFpbnRhaW5lciBsaXN0IHdoZXJlIGl0
IGFwcGVhcnMgYWNyb3NzIG11bHRpcGxlIGZpbGVzLg0KPiANCj4gVGhlcmUgYXJlIGFsc28gc29t
ZSBuZXcgcmVzb3VyY2VzIChtYWlsaW5nIGxpc3QsIHBhdGNod29yaywgSVJDKSB0aGF0DQo+IGRp
ZG4ndCBwcmV2aW91c2x5IGV4aXN0IGFuZCBoYWQgbm90IHlldCBiZWVuIGFkZGVkLCBzbyBsZXQn
cyBkbyB0aGF0IG5vdw0KPiBhcyB3ZWxsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF0dCBDb3N0
ZXIgPG1hdHQuY29zdGVyQGltZ3RlYy5jb20+DQo+IA0KDQpBY2tlZC1ieTogTHVpZ2kgU2FudGl2
ZXR0aSA8bHVpZ2kuc2FudGl2ZXR0aUBpbWd0ZWMuY29tPg0KDQo+IC0tLQ0KPiBDaGFuZ2VzIGlu
IHYyOg0KPiAtIEVESVRNRTogZGVzY3JpYmUgd2hhdCBpcyBuZXcgaW4gdGhpcyBzZXJpZXMgcmV2
aXNpb24uDQo+IC0gRURJVE1FOiB1c2UgYnVsbGV0cG9pbnRzIGFuZCB0ZXJzZSBkZXNjcmlwdGlv
bnMuDQo+IC0gTGluayB0byB2MToNCj4gaHR0cHM6Ly9wYXRjaC5tc2dpZC5saW5rLzIwMjYwNjI1
LW1haW50YWluZXItdXBkYXRlcy12MS0wLTM1MTEyYjJmMDM4ZUBpbWd0ZWMuY29tDQo+IA0KPiAt
LS0NCj4gTWF0dCBDb3N0ZXIgKDMpOg0KPiDCoMKgwqDCoMKgIE1BSU5UQUlORVJTOiBVcGRhdGUg
aW1hZ2luYXRpb24gZGV0YWlscw0KPiDCoMKgwqDCoMKgIE1BSU5UQUlORVJTOiBVcGRhdGUgaW1h
Z2luYXRpb24gbWFpbnRhaW5lcnMNCj4gwqDCoMKgwqDCoCBkdC1iaW5kaW5nczogZ3B1OiBpbWcs
cG93ZXJ2ci0qOiBBZGQgbWFpbnRhaW5lciBlbnRyaWVzDQo+IA0KPiDCoERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUvaW1nLHBvd2VydnItcm9ndWUueWFtbCB8wqAgNCArKyst
DQo+IMKgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwdS9pbWcscG93ZXJ2ci1z
Z3gueWFtbMKgwqAgfMKgIDQgKysrLQ0KPiDCoE1BSU5UQUlORVJTwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMCArKysrKysrLS0tDQo+IMKgMyBmaWxlcyBjaGFu
Z2VkLCAxMyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiAtLS0NCj4gYmFzZS1jb21t
aXQ6IDYwYjVmYTZlZGZlZjg2NzMyMmZjZTdjODMwNmU1YzRiNDYyMTFiZTcNCj4gY2hhbmdlLWlk
OiAyMDI2MDYyNC1tYWludGFpbmVyLXVwZGF0ZXMtYmZjMTg5MjU0NTU1DQo+IA0KDQo=
