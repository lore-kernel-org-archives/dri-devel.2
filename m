Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E70ACA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 04:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93D5F10E1A5;
	Thu,  1 Oct 2026 04:47:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="KZVb9A1k";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="aayuGMLU";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA29510E058;
 Thu,  1 Oct 2026 04:47:35 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6914Z2Yb2139957; Thu, 1 Oct 2026 05:47:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=61nqf2oRhVebyDRQRS2LaNp1S19yCVo2iBZYhXVyGu0=; b=KZV
 b9A1kvVxj8ZwNn/GUAcF6hhIa96AXx6nI3Rc1txraKDM6he+cB8oU7/7H7pppXt7
 Tj3edHCG35coGGO0SghUQjRUfSWdaKGBH8qdpLCTHKfEQ8vRaJRDfx6wBERaudQD
 lIcQBtJFAPWJUvnfyp9fyFHyCdNif7RTYyzxlZg3nKE7Qf2SEmsPzTwT1I70VoYs
 WsAJjcrtRBK6Rkv7X1MKvFFIOAYvkLCXolCjeTctDev5XmHrLTQ0SYyDBd5ek2HJ
 LCKRNaPN/ofbhluxxS+a44nImFP9ZAy7XuHFjgU+96TaIJhFGecdQJl68N3b/UAH
 TfyNPIWjM1xfH1IvZSQ==
Received: from lo3p265cu004.outbound.protection.outlook.com
 (mail-uksouthazon11020120.outbound.protection.outlook.com [52.101.196.120])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gx4as3qds-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 01 Oct 2026 05:47:25 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+e3tU59lH135iWYSYAJ3hCWMbkWGIFpDGkptVssGrDdP0NMFANI5vQSBAw2UchPsYlXtoogq4fwzkOnpzuIJt+Ae24e6Ie9WXCUvSsEnc+t9/N19wqevTg9k9mLnu7pLvxDDB/ehW0EkUU8sUGPPcFrwCUpwROxWe8VzlnfPiW/kIMcrX9dQ2wfGjugNYmA9lrUhDirk06tmoFheApjtOWCPkqvH4LEDfbLnn9QN2iJfHorzpXf5Df9UWpxqR/FfvjTET3j+tWbS7U0tavlWL9fHHeJPJCpRX3b6E/tNRdBVLRm7ipP1Lxawdxb+7PPZOrmVilNFX5JXaMfMI2b3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61nqf2oRhVebyDRQRS2LaNp1S19yCVo2iBZYhXVyGu0=;
 b=quW67s5rl3QsNKWGVLW4L8IC9Oh8QxhL9Sk2aBXcqgW2KiZw97FukMBEEvqrJXIzA1LO7iUQBhlUjj/lpVA6zLsbQhqY32c+hIpu8f/4w4Obn+J5qISwP5PkZCPXjgMCH6xob7kU+JaOq0POX6Ms1Q2qQs7ZkbNuSgA5StwkU3rUh32LyKBxhp8RmmMWkhw4lLO59P51P8iRzfPITY8oe4FSwU+9GSAbDU1rqhmNVvT3p6MLg+JQYRf70X6IrGXy10xbVl4pcIRAWU+YRilK68h3tm4SxSWDaAio2Q/iISjcha5xQ6PpapOi9WLPZ1Xw2q69L+IcB0L1sS1H3evXMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61nqf2oRhVebyDRQRS2LaNp1S19yCVo2iBZYhXVyGu0=;
 b=aayuGMLURK52CyMhb4fXGSd6qgv2CO+uNBYvqZMBja06fWxVuerTcoOxelhzSEgp6dYyG9MUWclOeW4JJelLqyMkAKwoMsBd713o4v4PIu0eOtD/k1Jks/tr9vRNCta92UkO6R3mvLgd1HyNBWOATsoK9F1zjb8xGJQZfJJGyzc=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by LO7P265MB957598.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:603::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 04:47:22 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%3]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 04:47:22 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "airlied@gmail.com" <airlied@gmail.com>, Alessio Belle
 <Alessio.Belle@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "gye976@gmail.com" <gye976@gmail.com>,
 "mripard@kernel.org" <mripard@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] drm/imagination: Size page table preallocation by
 device address
Thread-Topic: [PATCH 3/3] drm/imagination: Size page table preallocation by
 device address
Thread-Index: AQHdTxgwcmDXWx9sGkKHVzvoZwnqG7bjslEAgARvYAA=
Date: Thu, 1 Oct 2026 04:47:22 +0000
Message-ID: <b15cab8d1c5074d702f8acc1924911e06076e25f.camel@imgtec.com>
References: <20260927-pvr-fixes-a-v1-0-7f5b18ab989a@gmail.com>
 <20260927-pvr-fixes-a-v1-3-7f5b18ab989a@gmail.com>
 <26a436bd27cc66407d776947c5f91ea7ae518600.camel@imgtec.com>
In-Reply-To: <26a436bd27cc66407d776947c5f91ea7ae518600.camel@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|LO7P265MB957598:EE_
x-ms-office365-filtering-correlation-id: 8e5961c5-63ae-4a93-6f93-08df1f771512
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|13003099007|38070700021|4143699003|6133799003|10067099003|56012099006|22082099003|9063799003|18002099003;
x-microsoft-antispam-message-info: XPanyZb3MYCLOUFJjRVMOurGaRQNRmfNVKUaHdYxWwAxm3pIsR/7pnykqKXVmVvSycqrgPycmQJ9OPiyTN0wcMnRO6soYHe7HGbDRs03VRClItL1U8YV9STeXoeUF5aql5IfrJSOXiYFPpX7tQ+2W4ajm9+PB6OjQNd082BdreCru93dGAtZGFFO5O1Rc1DbH5G0mx/3OkWKHtpaw1qauQruwDPrAalXvnirIv9D1Mi7/bjB282hT4j9Mnr5LYPPAdkou8LB27l4FJKcVx2vIBOjI9gJVmenMuwJLSEb+MIDNO71z+Kn9FUGG7pdz1bTbgPLiHeSi9Np8+osLqVSmTVa9SFuJAK9DtiNWt33APuaWNCe2w/SuHz2SmurdyAV2MFBxM7PD15//GNcHmZ2Kp/2I2u+mdWUdvy7sY69ZNgjBFxTbjVfeKsQ8gIPLC2tgK/26Iqo8QMXhCkI01mYJeQjLA/i6dArW5lnG96N7s4RaX+e8iNZNv4E/POxV9gDlIMD+35+V6ubPNXZTCmzoFEFkJZcxDe2Wq5QTGorJP2SSXva+/3KVf12+bCRToc0VultT7qNb1BarlJxD7kIUN031YmMrhVF3YuzxNNlPH2aAarCeZWsUyEl+ME0/EzyyowHTowjhQIJQ42lIpAMrgFl+tnS3jlqejn7ZTcGsrs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(13003099007)(38070700021)(4143699003)(6133799003)(10067099003)(56012099006)(22082099003)(9063799003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGQ0UlA0NEZZSTVYRXJrZlNRTEdhaW9obG5hOWtxVCsrRlNYR0xwRnZwYXpN?=
 =?utf-8?B?NUR2U0ZlaUJ1Vk9hWGNodjFPcU84bCtXK0g0bGFmVnZkM2JBYldnQjZOb1JS?=
 =?utf-8?B?cUlYQ0VOUkEzbUROcmJpMTBjMnJydEhRNDFWSFZudExzYnVHYkwrdFdSZGNw?=
 =?utf-8?B?NGlyaWNEK08wSjRVaGVNYUI5a2dlS2VaeUFkNERUelJEYjNUbEd2WU5qVTFC?=
 =?utf-8?B?cEhvdTdjc0lZdDg1VGhDNlpGa3pCUm9sWWxWM1dEQzhNbE1pWGxtbWw3Z2ty?=
 =?utf-8?B?cVRwWkNSbjdYY2hvZSs1cnRpWmVlVW9SWXVsbFg1bnpBL1pEeUNoaWF4a0tt?=
 =?utf-8?B?czBCTWsxZmtvK2Q5aUhwbWhtOWVsKzRHVWZpUU9vUlBKTUxIbWwzdlJnenlm?=
 =?utf-8?B?VWJhWEQ4MnhVL3BwVE94dzdoODN6MEJWVi8vaHBJUjI1SnE1M1VibDNDdXQ5?=
 =?utf-8?B?OCtKU1dxZFZtdDF3c2pIUk5CMURWdHlHTmVZSkI2S0dGZHVmSVBwRTlockZi?=
 =?utf-8?B?eUliUjBwSXk1K3ZKVGJaL3Z6c0kvRExjMjVNbGh6ZVRwZkZsRTVhQlk3b2Vk?=
 =?utf-8?B?VUM1OUNUN0UxRjhmTUxUOVBSYWFZemx5a1RQeENmREZNQzNrcndpcVVYZVE5?=
 =?utf-8?B?eUVmV29EVzFUV21qK2w3b3huUzBDRFV2MmEvcTJ0bGsxQmR4dnpjOXN3Vmtu?=
 =?utf-8?B?WEIzNDlpNlpXL1gyVnNPN0hVR2hpVjNPb0N2MENmSEltVXVLSEQ2RnFuQjJS?=
 =?utf-8?B?TWZsVFdPekxlQlc2M2JXL0VMNDFkMmRtT0swT3dnUnpNYlVva256RUFpam4v?=
 =?utf-8?B?L3JDV1ZXeE5wcGEySzlPTjlHUEN5b0tIdCsyb2hINVpGQ29SdmRPMjNPVGJM?=
 =?utf-8?B?QkQ4SW9Nb3FrbEE4c0NDWWx1cHRaOFFXM3J1aVZjd1VubnBBMHR0STE2bm9L?=
 =?utf-8?B?S0ZOT3JVaHJFN2pBRVNGc3NDek1BTUVvWE83aXNnSFYvU3h1OGRqaEl6dzU2?=
 =?utf-8?B?OXlPRkhjODNhckxRVEdmMVhQd1JYNGdIUFZWUUxkNEtxVjhXbTBOWTRxbDdz?=
 =?utf-8?B?WUtQYzM1YzhFd1RDS1Jib1hLZDhTUThGOGgyTW9JS1lua1pVK0JlUXZOTzN5?=
 =?utf-8?B?NzA4MFlHOU5pdWw2Z0VoY3F1UUhoN21ycU92bEozTUFDZTF4ZDZ4N1cxR2c4?=
 =?utf-8?B?UFd4aHJDSml0MTA4RGdJTnZPYURPeG92SmtzS0M2UC9keVhieVNHbWU0S0Rl?=
 =?utf-8?B?dlVRbTRIMU51YURJRC9IS3IrZ1NFNjI4S3ljaXhUNnd2ZS8xQkVEL2w1QzdE?=
 =?utf-8?B?SVRXVEI5RlprTGRCcU1zSGw4SHE1cEdvUFo4UDk0dWFjRUxpM2RoUWgyUUts?=
 =?utf-8?B?citRdjhobHdteHNyMTNMWVFSTTdOZjA4VUFnelg1YkYwUjNGZGdkUDdJNnRE?=
 =?utf-8?B?NHhkVVc2am1la0kwR1ZYQUpnV05EK3VNc3hHUjdxbEJiUjVjZmZrTDRXODVk?=
 =?utf-8?B?QVZ6NTNDU3hoNFFzWCtpVU9SMFgxRm1Hb2hLb1NWUVRKQjVwV0VjeHRYQUI5?=
 =?utf-8?B?dWZqcUVBRmNVWGJZcHhra1JiRHEzUVhCN3lBS3ltamphZ0VpUU9aQjVYUnl4?=
 =?utf-8?B?MEN0emJxcm93N2FLeHJzWnozK0FOMUtkV3M5QjgrNFVCUEpCSEVvMlRFLzQz?=
 =?utf-8?B?SE9PUkRvcFJ2dmh0WVkra3NYZi80TkVJV2MzZVkzOGN5N2ZOaTc2STgvNG1m?=
 =?utf-8?B?UUJXeVI1ZUVPbkFpNWp2RWgzU3JYM1d6ZWZ3Rmh1eTdiN2RZc1FOUGt6WHp5?=
 =?utf-8?B?bGMrZ1VJVVk0UVlCRHFDSGdzYUd3eXhpeXlaYUs1SGhWdm1VMGdKaitsODF0?=
 =?utf-8?B?RlNYUEplUml0dDhQMVRqZmhyWHV3aXFXY1hZSXJtY0RHWE9yNTdURGJXMDNr?=
 =?utf-8?B?REIvNzJCbzJTNEMwUUJ4YSs5NldYeTJjWnNXUHdtVkdZbTJtK0xJNis4b1Qv?=
 =?utf-8?B?b1o4S3RrdjZwZUdTYnNSTTI3MVpOd05yVDZkaVpqQ2JhOWluQzdkRVBkOW1B?=
 =?utf-8?B?cTNmNjVWNFFlR3ZBU0YvNFVXVWFmVkpQVGtiU2lSTTVnTVZMdXRhMFhuZW5k?=
 =?utf-8?B?Sm9hY3dseWloc1duZkZIZGVJVXRYOWt4RDFnWlhBZkFmbEtBUmZvV2pTYzFw?=
 =?utf-8?B?VC8yQTJTVEFFTmtMRWU3UGk1RS85S1Z4YUoveUZwM0dtM1JBV3JwKzhlNkw2?=
 =?utf-8?B?U2ZIMW9qNXRSR09ZNFhwK2JPRUtyV2lSMm44V1JhUUptTitEYXY5Y0RXVm1L?=
 =?utf-8?B?TVI1ejlPUitoQ1NYdW0vZ2tDdFpVR3ZDZStrbVZPb2VaeEZSRG5Ec1RKb0FV?=
 =?utf-8?Q?LGq7FnkVWl28/AVQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B57E5A621E98B748A5915E3BD4D7E557@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hIJ8y1puPECKhvTIDOVoHnewVi+t6tiW6D8j2UQjroRC31WCqHHnoQXicG0qCI3u2W1zLlHj9w0ReJ/+LgVpio+zIZbJs3bJt18itYx3oqhiTgP3PbU6RzosPPjSnMXi09dkOsaf+JQz2WOrZqDRkQGUINrH72mPNtH+lVZ4nrUA4dALRyw2pJ+1nTOsPP1lmnqA7w1zMWH38f4ZRAxwWAqSIc1050qPQLO6zMDzTntjyr06QN6fM1EXgyRUgzI5/GWo9sn8ZGzciYYHtJo9S0iGd0SfUixbeLIoNfbkqZazDR9WZFyDsJg7bHVJuZd6MmV23FBCF4+GxKt3IHcMcw==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5961c5-63ae-4a93-6f93-08df1f771512
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 04:47:22.4433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EYqyLSLAQwhgJzzSV3DUk8V+KPvk6fE9yOBV+ZChwkyte9EXTmdX9P7121Cuigg+Uqno8NZWnqZ0NVs0VALuw3BpMrnMW8s2NQSDqKZ5UZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB957598
X-Authority-Analysis: v=2.4 cv=BPomP1QG c=1 sm=1 tr=0 ts=6abde5dd cx=c_pps
 a=GVLDO2oxNd/rNn+uHu8Ung==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=e5mUnYsNAAAA:8
 a=pGLkceISAAAA:8 a=kMXzMdBa-lr6u1VwV7MA:9 a=QEXdDO2ut3YA:10
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: aQ2Ir3ZZ3uHytVH83uA2_sJ-3KqRUmOR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAxOCBTYWx0ZWRfX08hDrNJ3AyOt
 n2plY/opO3Y4eqDXULaxPyok6LZ+pq/RhDULNjZuIOSH5d2Fa7lKYlu0boNk8V9S9YmD12C2YWL
 JzuP16juIrR2SMud2jCnwaKh3hRFK+I=
X-Proofpoint-GUID: aQ2Ir3ZZ3uHytVH83uA2_sJ-3KqRUmOR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAxOCBTYWx0ZWRfXwBbAqHbZw2QY
 hmBC+nkSuWSKSMbqyCxyAeO8tjGTLc7zvqIjCrFE6NgXnd9zkNpDM/O97KecRqIgO7PseIz9WJQ
 u7q+8aPb0CHYa30wVUf5n2w8+wumJcY/JP4ctQ93Ctyw/yPCBHI08CxavkdyKXHh4AiFM8FXkrR
 R2dSaowEogU3hu2vmZ5vMv0DiX2Di+iP/c/4cdup2XZ32SFMu6YJ8vk4EMOEqTFU2TgCxT7UMW2
 u4SHH66OOW7n3PYIvfbB+IGwwx2NrDqDTjc1DtOsv3fwXSAvHTai2C2n+WPXarsIv4l6Fxrv7mw
 uIapnzII7sswQcRWZGjWFrrGcX/eJMannPl4Ho02ctrtt81aix1k5fCABfudy66ms0nTesRUrnS
 is+Dvc6Qb8PCGJZsPYuTd0wEWezJEA1LW2ebfMEw3X7Lm/x0SobadgO13eGmcml0LmHVf4cn5oc
 SmF8WN7344bVmdiiRxw==
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

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDA5OjAzICswMDAwLCBCcmFqZXNoIEd1cHRhIHdyb3RlOg0K
PiBPbiBTdW4sIDIwMjYtMDktMjcgYXQgMTc6MjUgKzA5MDAsIEd5ZXlvdW5nIEJhZWsgd3JvdGU6
DQpIaSBHeWV5b3VuZywNCj4gSGkgR3lleW91bmcsDQo+ID4gcHZyX21tdV9vcF9jb250ZXh0X2Ny
ZWF0ZSgpIHByZWFsbG9jYXRlcyB0aGUgcGFnZSB0YWJsZXMgYSBtYXBwaW5nDQo+ID4gbmVlZHMu
IEhvdyBtYW55IGlzIHNldCBieSB0aGUgZGV2aWNlLXZpcnR1YWwgYWRkcmVzcyBiZWluZyBtYXBw
ZWQsIG5vdA0KPiA+IGJ5IHRoZSBvZmZzZXQgaW50byB0aGUgb2JqZWN0J3MgcGFnZXMsIHdoaWNo
IGl0IHVzZWQgaW5zdGVhZC4NCj4gPiANCj4gPiBTaXplIHRoZSBwcmVhbGxvY2F0aW9uIGZyb20g
dGhlIGRldmljZSBhZGRyZXNzIGluc3RlYWQuDQo+ID4gDQo+IFRoaXMgaXNzdWUgaXMgcmVjZW50
bHkgZml4ZWQgdW5kZXINCj4gaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3BhdGNo
Lzc1NTI3NC8uIFBsZWFzZSBoYXZlIGEgbG9vay4NCj4gDQo+IFRoYW5rcywNCj4gQnJhamVzaA0K
PiA+IEZpeGVzOiBmZjVmNjQzZGUwYmYgKCJkcm0vaW1hZ2luYXRpb246IEFkZCBHRU0gYW5kIFZN
IHJlbGF0ZWQgY29kZSIpDQo+ID4gU2lnbmVkLW9mZi1ieTogR3lleW91bmcgQmFlayA8Z3llOTc2
QGdtYWlsLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2
cl9tbXUuYyB8IDI3ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPiA+ICBkcml2ZXJzL2dw
dS9kcm0vaW1hZ2luYXRpb24vcHZyX21tdS5oIHwgIDMgKystDQo+ID4gIGRyaXZlcnMvZ3B1L2Ry
bS9pbWFnaW5hdGlvbi9wdnJfdm0uYyAgfCAgNSArKystLQ0KPiA+ICAzIGZpbGVzIGNoYW5nZWQs
IDE5IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX21tdS5jIGIvZHJpdmVycy9ncHUvZHJt
L2ltYWdpbmF0aW9uL3B2cl9tbXUuYw0KPiA+IGluZGV4IDNlNDk0YmZhOTM2Li5kZDVmNmQzMjg2
NCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX21tdS5j
DQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9tbXUuYw0KPiA+IEBA
IC0yMzM1LDcgKzIzMzUsOCBAQCB2b2lkIHB2cl9tbXVfb3BfY29udGV4dF9kZXN0cm95KHN0cnVj
dCBwdnJfbW11X29wX2NvbnRleHQgKm9wX2N0eCkNCj4gPiAgICogcHZyX21tdV9vcF9jb250ZXh0
X2NyZWF0ZSgpIC0gQ3JlYXRlIGFuIE1NVSBvcCBjb250ZXh0Lg0KPiA+ICAgKiBAY3R4OiBNTVUg
Y29udGV4dCBhc3NvY2lhdGVkIHdpdGggb3duaW5nIFZNIGNvbnRleHQuDQo+ID4gICAqIEBzZ3Q6
IFNjYXR0ZXIgZ2F0aGVyIHRhYmxlIGNvbnRhaW5pbmcgcGFnZXMgcGlubmVkIGZvciB1c2UgYnkg
dGhpcyBjb250ZXh0Lg0KPiA+IC0gKiBAc2d0X29mZnNldDogU3RhcnQgb2Zmc2V0IG9mIHRoZSBy
ZXF1ZXN0ZWQgZGV2aWNlLXZpcnR1YWwgbWVtb3J5IG1hcHBpbmcuDQo+ID4gKyAqIEBzZ3Rfb2Zm
c2V0OiBPZmZzZXQgaW50byBAc2d0IG9mIHRoZSBzdGFydCBvZiB0aGUgcmVxdWVzdGVkIG1hcHBp
bmcuDQo+ID4gKyAqIEBkZXZpY2VfYWRkcjogRGV2aWNlLXZpcnR1YWwgYWRkcmVzcyBhdCB0aGUg
c3RhcnQgb2YgdGhlIHJlcXVlc3RlZCBtYXBwaW5nLg0KPiA+ICAgKiBAc2l6ZTogU2l6ZSBpbiBi
eXRlcyBvZiB0aGUgcmVxdWVzdGVkIGRldmljZS12aXJ0dWFsIG1lbW9yeSBtYXBwaW5nLiBGb3Ig
YW4NCj4gPiAgICogdW5tYXBwaW5nLCB0aGlzIHNob3VsZCBiZSB6ZXJvIHNvIHRoYXQgbm8gcGFn
ZSB0YWJsZXMgYXJlIGFsbG9jYXRlZC4NCj4gPiAgICoNCj4gPiBAQCAtMjM0Niw3ICsyMzQ3LDcg
QEAgdm9pZCBwdnJfbW11X29wX2NvbnRleHRfZGVzdHJveShzdHJ1Y3QgcHZyX21tdV9vcF9jb250
ZXh0ICpvcF9jdHgpDQo+ID4gICAqLw0KPiA+ICBzdHJ1Y3QgcHZyX21tdV9vcF9jb250ZXh0ICoN
Cj4gPiAgcHZyX21tdV9vcF9jb250ZXh0X2NyZWF0ZShzdHJ1Y3QgcHZyX21tdV9jb250ZXh0ICpj
dHgsIHN0cnVjdCBzZ190YWJsZSAqc2d0LA0KPiA+IC0JCQkgIHU2NCBzZ3Rfb2Zmc2V0LCB1NjQg
c2l6ZSkNCj4gPiArCQkJICB1NjQgc2d0X29mZnNldCwgdTY0IGRldmljZV9hZGRyLCB1NjQgc2l6
ZSkNCj4gPiAgew0KPiA+ICAJaW50IGVycjsNCj4gPiAgDQo+ID4gQEAgLTIzNjIsMTggKzIzNjMs
MTggQEAgcHZyX21tdV9vcF9jb250ZXh0X2NyZWF0ZShzdHJ1Y3QgcHZyX21tdV9jb250ZXh0ICpj
dHgsIHN0cnVjdCBzZ190YWJsZSAqc2d0LA0KPiA+ICANCj4gPiAgCWlmIChzaXplKSB7DQo+ID4g
IAkJLyoNCj4gPiAtCQkgKiBUaGUgbnVtYmVyIG9mIHBhZ2UgdGFibGUgb2JqZWN0cyB3ZSBuZWVk
IHRvIHByZWFsbG9jIGlzDQo+ID4gLQkJICogaW5kaWNhdGVkIGJ5IHRoZSBtYXBwaW5nIHNpemUs
IHN0YXJ0IG9mZnNldCBhbmQgdGhlIHNpemVzDQo+ID4gLQkJICogb2YgdGhlIGFyZWFzIG1hcHBl
ZCBwZXIgUFQgb3IgUEQuIFRoZSByYW5nZSBjYWxjdWxhdGlvbiBpcw0KPiA+IC0JCSAqIGlkZW50
aWNhbCB0byB0aGF0IGZvciB0aGUgaW5kZXggaW50byBhIHRhYmxlIGZvciBhIGRldmljZQ0KPiA+
IC0JCSAqIGFkZHJlc3MsIHNvIHdlIHJldXNlIHRob3NlIGZ1bmN0aW9ucyBoZXJlLg0KPiA+ICsJ
CSAqIFRoZSBwYWdlIHRhYmxlcyBuZWVkZWQgYXJlIHNldCBieSB0aGUgZGV2aWNlLXZpcnR1YWwg
cmFuZ2UNCj4gPiArCQkgKiBiZWluZyBtYXBwZWQ6IG9uZSBsZXZlbCAxIHRhYmxlIHBlciAxR2lC
IHJlZ2lvbiBhbmQgb25lDQo+ID4gKwkJICogbGV2ZWwgMCB0YWJsZSBwZXIgMk1pQiByZWdpb24g
dGhlIHJhbmdlIHRvdWNoZXMuIFRhYmxlcyB0aGF0DQo+ID4gKwkJICogYWxyZWFkeSBleGlzdCBh
cmUgbm90IGNvbnN1bWVkLCBzbyB0aGlzIGlzIGFuIHVwcGVyIGJvdW5kLg0KPiA+ICAJCSAqLw0K
PiA+IC0JCWNvbnN0IHUzMiBsMV9zdGFydF9pZHggPSBwdnJfcGFnZV90YWJsZV9sMl9pZHgoc2d0
X29mZnNldCk7DQo+ID4gLQkJY29uc3QgdTMyIGwxX2VuZF9pZHggPSBwdnJfcGFnZV90YWJsZV9s
Ml9pZHgoc2d0X29mZnNldCArIHNpemUpOw0KPiA+IC0JCWNvbnN0IHUzMiBsMV9jb3VudCA9IGwx
X2VuZF9pZHggLSBsMV9zdGFydF9pZHggKyAxOw0KPiA+IC0JCWNvbnN0IHUzMiBsMF9zdGFydF9p
ZHggPSBwdnJfcGFnZV90YWJsZV9sMV9pZHgoc2d0X29mZnNldCk7DQo+ID4gLQkJY29uc3QgdTMy
IGwwX2VuZF9pZHggPSBwdnJfcGFnZV90YWJsZV9sMV9pZHgoc2d0X29mZnNldCArIHNpemUpOw0K
PiA+IC0JCWNvbnN0IHUzMiBsMF9jb3VudCA9IGwwX2VuZF9pZHggLSBsMF9zdGFydF9pZHggKyAx
Ow0KPiA+ICsJCWNvbnN0IHU2NCBsYXN0X2FkZHIgPSBkZXZpY2VfYWRkciArIHNpemUgLSAxOw0K
PiA+ICsJCWNvbnN0IHU2NCBsMV9jb3VudCA9DQo+ID4gKwkJCShsYXN0X2FkZHIgPj4gUk9HVUVf
TU1VQ1RSTF9WQUREUl9QQ19JTkRFWF9TSElGVCkgLQ0KPiA+ICsJCQkoZGV2aWNlX2FkZHIgPj4g
Uk9HVUVfTU1VQ1RSTF9WQUREUl9QQ19JTkRFWF9TSElGVCkgKyAxOw0KPiA+ICsJCWNvbnN0IHU2
NCBsMF9jb3VudCA9DQo+ID4gKwkJCShsYXN0X2FkZHIgPj4gUk9HVUVfTU1VQ1RSTF9WQUREUl9Q
RF9JTkRFWF9TSElGVCkgLQ0KPiA+ICsJCQkoZGV2aWNlX2FkZHIgPj4gUk9HVUVfTU1VQ1RSTF9W
QUREUl9QRF9JTkRFWF9TSElGVCkgKyAxOw0KPiA+ICANCldlIGlkZW50aWZpZWQgb3ZlciBhbGxv
Y2F0aW9uIG9mIHBhZ2UgdGFibGVzIGR1ZSB0byBpbmNvcnJlY3QgY2FsY3VsYXRpb24gb2YgZW5k
DQpvZmZzZXQuIEFuZCB5b3VyIGNoYW5nZSBpcyBjb3JyZWN0bHkgdGFrZXMgdGhhdCBpbnRvIGFj
Y291bnQuIA0KQ2FuIHlvdSBwbGVhc2UgdXBkYXRlIHlvdXIgcGF0Y2ggb24gdG9wDQpodHRwczov
L3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvcGF0Y2gvNzU1Mjc0Pw0KDQpBbHNvIHVwZGF0ZSBm
aXhlcyB0YWcgdG8gaW5jbHVkZSBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvcGF0
Y2gvNzU1Mjc0Pw0KDQpUaGFua3MsDQpCcmFqZXNoDQoNCj4gPiAgCQkvKg0KPiA+ICAJCSAqIEFs
bG9jIGFuZCBwdXNoIHBhZ2UgdGFibGUgZW50cmllcyB1bnRpbCB3ZSBoYXZlIGVub3VnaCBvZg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX21tdS5oIGIv
ZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9tbXUuaA0KPiA+IGluZGV4IGE4ZWNkNDYw
MTY4Li43MDg4ZjgwODA1ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2lu
YXRpb24vcHZyX21tdS5oDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2
cl9tbXUuaA0KPiA+IEBAIC05OSw3ICs5OSw4IEBAIGRtYV9hZGRyX3QgcHZyX21tdV9nZXRfcm9v
dF90YWJsZV9kbWFfYWRkcihzdHJ1Y3QgcHZyX21tdV9jb250ZXh0ICpjdHgpOw0KPiA+ICB2b2lk
IHB2cl9tbXVfb3BfY29udGV4dF9kZXN0cm95KHN0cnVjdCBwdnJfbW11X29wX2NvbnRleHQgKm9w
X2N0eCk7DQo+ID4gIHN0cnVjdCBwdnJfbW11X29wX2NvbnRleHQgKg0KPiA+ICBwdnJfbW11X29w
X2NvbnRleHRfY3JlYXRlKHN0cnVjdCBwdnJfbW11X2NvbnRleHQgKmN0eCwNCj4gPiAtCQkJICBz
dHJ1Y3Qgc2dfdGFibGUgKnNndCwgdTY0IHNndF9vZmZzZXQsIHU2NCBzaXplKTsNCj4gPiArCQkJ
ICBzdHJ1Y3Qgc2dfdGFibGUgKnNndCwgdTY0IHNndF9vZmZzZXQsDQo+ID4gKwkJCSAgdTY0IGRl
dmljZV9hZGRyLCB1NjQgc2l6ZSk7DQo+ID4gIA0KPiA+ICBpbnQgcHZyX21tdV9tYXAoc3RydWN0
IHB2cl9tbXVfb3BfY29udGV4dCAqb3BfY3R4LCB1NjQgc2l6ZSwgdTY0IGZsYWdzLA0KPiA+ICAJ
CXU2NCBkZXZpY2VfYWRkcik7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pbWFn
aW5hdGlvbi9wdnJfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfdm0uYw0K
PiA+IGluZGV4IGM1YWUwYjc5ZmU2Li43YmI1OGNhMTRlNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3ZtLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vaW1hZ2luYXRpb24vcHZyX3ZtLmMNCj4gPiBAQCAtMjc2LDcgKzI3Niw4IEBAIHB2cl92bV9i
aW5kX29wX21hcF9pbml0KHN0cnVjdCBwdnJfdm1fYmluZF9vcCAqYmluZF9vcCwNCj4gPiAgCQln
b3RvIGVycl9iaW5kX29wX2Zpbmk7DQo+ID4gIA0KPiA+ICAJYmluZF9vcC0+bW11X29wX2N0eCA9
DQo+ID4gLQkJcHZyX21tdV9vcF9jb250ZXh0X2NyZWF0ZSh2bV9jdHgtPm1tdV9jdHgsIHNndCwg
b2Zmc2V0LCBzaXplKTsNCj4gPiArCQlwdnJfbW11X29wX2NvbnRleHRfY3JlYXRlKHZtX2N0eC0+
bW11X2N0eCwgc2d0LCBvZmZzZXQsDQo+ID4gKwkJCQkJICBkZXZpY2VfYWRkciwgc2l6ZSk7DQo+
ID4gIAllcnIgPSBQVFJfRVJSX09SX1pFUk8oYmluZF9vcC0+bW11X29wX2N0eCk7DQo+ID4gIAlp
ZiAoZXJyKSB7DQo+ID4gIAkJYmluZF9vcC0+bW11X29wX2N0eCA9IE5VTEw7DQo+ID4gQEAgLTMx
OCw3ICszMTksNyBAQCBwdnJfdm1fYmluZF9vcF91bm1hcF9pbml0KHN0cnVjdCBwdnJfdm1fYmlu
ZF9vcCAqYmluZF9vcCwNCj4gPiAgCX0NCj4gPiAgDQo+ID4gIAliaW5kX29wLT5tbXVfb3BfY3R4
ID0NCj4gPiAtCQlwdnJfbW11X29wX2NvbnRleHRfY3JlYXRlKHZtX2N0eC0+bW11X2N0eCwgTlVM
TCwgMCwgMCk7DQo+ID4gKwkJcHZyX21tdV9vcF9jb250ZXh0X2NyZWF0ZSh2bV9jdHgtPm1tdV9j
dHgsIE5VTEwsIDAsIDAsIDApOw0KPiA+ICAJZXJyID0gUFRSX0VSUl9PUl9aRVJPKGJpbmRfb3At
Pm1tdV9vcF9jdHgpOw0KPiA+ICAJaWYgKGVycikgew0KPiA+ICAJCWJpbmRfb3AtPm1tdV9vcF9j
dHggPSBOVUxMOw0KPiA+IA0KPiANCg0K
