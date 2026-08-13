Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225EDC5AC67
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 04:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2339510E4A0;
	Thu, 13 Aug 2026 04:44:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="B2XiL2ZL";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="ElPu4egj";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CF6810E4A0;
 Thu, 13 Aug 2026 04:44:17 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D4gFgD881456; Thu, 13 Aug 2026 05:44:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=0Ot0Qdb4eE1vB4MJ4TD/m9Hk5/0abH4+LMHZbEuN8DI=; b=B2X
 iL2ZLT35fIvkaR9WGdab9DS4NOmFtFZJAjt05HzsCKYNrZWAOEXcoVWUdLVKd0R4
 Dm5koSKVW4Z4lWNSe7P6JaxHfXO5i5IhrxjBYKaAMPib98/zd5Bl/ieVOmb+ffTi
 x3p0ggLmrI+oEKb217MuaOuw2wjyOqo4w+1AO36r9XDPcrlzUxBNtpNpOhkZyazZ
 OCJet9WWeOi8Uj062MTwqymwYc3JapcrqEs1cEW2xBGOr+8rwS+m3I77VSDb1N+8
 xCHqBCVLWT148HbhyIQHvtN/ThNlss+lsQiErKil6CfQrG6rlui3Tu3KtJiKs4FY
 bz7zun9y/ET9b4noJaA==
Received: from cwxp265cu009.outbound.protection.outlook.com
 (mail-ukwestazon11021126.outbound.protection.outlook.com [52.101.100.126])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fysk3j8bd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 05:44:07 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFAwdWwZPoXI/jw2IlWqafVdSCHN0S6kuw5iaxdmlnrcCSbZhmZKF6urkeh3Jgg8ANCp03EcK9y94GvayeMDZPj2g0gBAsLyjXfvWrZqausE6jqrV3CyIs/+Wp9n1NAZLJzK9S9r8uzKLE5pMJ/B1sIuhtj7iruVTVxBEJlqh0BZsgOoYdRQDAcEv6T0pNLyKMt6uX6SoNGV1YamLBMRIM/BKIRUUvY69UOR4tgr9f2LSob7AoYlZq0aGq2HCanCcxdAbFSwET39BRs1wDHOArOT/hzoxR9BUpTA9xJCWSaCoXXksAFZJj2kl2C3O6sfIkQvmPs11KLKiqxH2YSflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ot0Qdb4eE1vB4MJ4TD/m9Hk5/0abH4+LMHZbEuN8DI=;
 b=iNeKud0F9PrW8+KCpZ2g4Em45AxfK+iUHNi0XWzV1CnbIbDGLcVpPGZZk1geMA6IPKQ8sZmRxCcYtbCOmt7+CHUeqAGx4kL4Lh+VP6/GSAmhovxzQlnWGCYgy254DC8vxEL8UNRYN+5reUN6zOXVek/U7tAWe6ImF9ZfOGd8MQLgzZJqkdFcaYAaFKt2eupw27LuStQChMKNAgrmdFOAEmqCyHJxwAv1qi3mHwXj+MnfxRIbO8q88k/Mr6MhJzW8wgjW3PKQ9dlyvZqONZsmNQdhFNZw1uvV6CFkVwEhMbWw3HwiSB807OoEbWpjlXHILUtJ9Q4karh79VI0REqHWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ot0Qdb4eE1vB4MJ4TD/m9Hk5/0abH4+LMHZbEuN8DI=;
 b=ElPu4egjHKQOO8366O29kL19thaPCGvI3M4TAazMhGf1khzy+yTb/h+FjIPkTDat11GLcXxQs8nc9Tw0XGK4MuUUDdB7DAgYUYqbBqbrJxQvhayyV2lrXM9EJd1D2RlnPp3N7Ibw30cAmFWFoGWn57FJ8EYvSwA9A9dsKkw5BIM=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by LO0P265MB5957.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:289::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 04:44:03 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%3]) with mapi id 15.21.0315.011; Thu, 13 Aug 2026
 04:44:03 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "airlied@gmail.com" <airlied@gmail.com>, Alessio Belle
 <Alessio.Belle@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, Alexandru Dadu
 <Alexandru.Dadu@imgtec.com>, "mripard@kernel.org" <mripard@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/imagination: Remove duplicated CCB control
 initialisation
Thread-Topic: [PATCH] drm/imagination: Remove duplicated CCB control
 initialisation
Thread-Index: AQHdKt5dMMEJLyiB/keOgqkZnd4vYg==
Date: Thu, 13 Aug 2026 04:44:03 +0000
Message-ID: <87972fb865f1438ef46bc31e3a42dd49ce15d8a8.camel@imgtec.com>
References: <20260810-b4-upstream-remove-duplicate-ccb-control-init-v1-1-4ea79b116b40@imgtec.com>
In-Reply-To: <20260810-b4-upstream-remove-duplicate-ccb-control-init-v1-1-4ea79b116b40@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|LO0P265MB5957:EE_
x-ms-office365-filtering-correlation-id: 383177d8-9388-4499-ad0a-08def8f58033
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|10070799003|376014|38070700021|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: hH4He8jNiaaepFLBu/KrXkver4ISz/hNPD24ZDvuuHk0CCTFXpBR1bK6K+8252CBRcQh0xa/8KyPUGn1ilZhg6iTtTcIosx3tZ8e1tJJdDWhye4kL3cTxOsclAmMAUlIuXqDlUQ/blw1hZcuynQtYKNOxg73jkGww9i5ikfPMCtuZvzBLx7L9pGKidXCcQP3jVgA/LWHocBDt1+Uq0yQlyZ+Aiy+uk2l6JbbSb4wAdkIl1LEEl1FQDKaJSNcDHnUmu1TGCsou627YJvUqH9iJfBW/7tBJTpXzqfTwtKnDmjbZrqtFipbLT1N5gIHazFWyiCDhtugNTwsp1YhLLbtpA5ahlNg2Hp5GRdV/br0HvbqOCP/StKgTcn8aQpvItpmYrjI/i+3U71rZNsDz1TKD0FMFQ8jw5D/TBKrULIsODv74xf+QeyIuE61ChjbaKAF/PCvWMnm4UNZNg5LGPumbRTDOQ7ciTm5dp/WvLVkUO223AVEp5EfR8AU4SUXqYdpla5Y2RxNSDnwcIQMueFZX24VtsARkCfjEya59mJz3vud3B5H0iuzFIzgafC4f+4O9heffUrY/yb8mpAlI8P99/n0El0HkNBii2sSpR/ewCI50rfetL7PaEmqJr4thxiMMJPEfsa9dfrS5tlfqjv36uGH/8HEHX2GGRXilUL+WWSPfyYVh3+e3vBRXjQW4+AkSaH6PBCMlhyR+c/VFaNnJUQIigjKjMOyySsX6LrzAH8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(10070799003)(376014)(38070700021)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmZtY2FENXQ2Z2k0WmRKSmJHcDVDanF1ZXR2NTQ1bEpabGlUZGwwTHpzRHox?=
 =?utf-8?B?eFJNb0Q5b2NWYjA5UnFJUlRxUUhrc2ZtZVBBajg2VndTdzJmc1FwcENEMytY?=
 =?utf-8?B?MnVtcEw1Ky9ER1gxT0dEeFdPckZrVVRyMDk4UURiRUxYc09IOE1wVnBXUFlY?=
 =?utf-8?B?eEtKNkhhdmZuYVE3eXB3NE9sQnB5dDBXaEFZZ3hjVFpwNDJ1M1Uwc2hLSFFo?=
 =?utf-8?B?MjJ5Q0tDWk5pWVdGRWErSjYxeTN4YkRCalNNZDYvM0EyRk5XOTQwQ214UWVv?=
 =?utf-8?B?azBDUXBzaFhSdkxZVTlvUXZMZE81amNJM1lhVTgvVlYrZjZhUVB1RHd1L1Er?=
 =?utf-8?B?UmExejJXUnBtcktUaUdnQm1aTFBTZFpwMll3QnJUZXNOMXNTejlEcUpoQmla?=
 =?utf-8?B?MTY0VlBidkQ0c04zVkVVUzQxUnJxWC9yZ3F4azFrMGx2QTNDRWxaWEZuWU54?=
 =?utf-8?B?RXNMSGs0YThYU1A3VG80TzkwN3o0STA4bWlUbjdabXhBYXl6SEJaS2hjYWZN?=
 =?utf-8?B?Z3VDQ1Z2OGRxRFJwQWtKREZzQ0FWWjZEcDdwTGFyMEJlTHBXK3ZkOEhvT0oz?=
 =?utf-8?B?dXFpeTN6RVNFKzArZEc2c1dyOEZ1anVxcEhwMmpEV2ZwYTNJcDdFU3VtSHlj?=
 =?utf-8?B?OHR0bklEcm5aODh5NmZIajRVakhzUGhpM012ekFsVncvWWtjUUw2OWVHc20r?=
 =?utf-8?B?eDg2TDBZV0t6S1E1c0lOSkhqNmZQdG5LcWJZbWVwTGJtYWdRS29QODBQQ3ZE?=
 =?utf-8?B?alhXVkdUV2xCdFNxR1hPc1l6ek5YSDZaUUpOVGlOZUZkUnVOU0JQa051MmVJ?=
 =?utf-8?B?WThNRWhlYWo5ZjFKU1BNWWkxb3o1bURJRVJHL3Rac3FGdXZlM2cxMGFJWGI0?=
 =?utf-8?B?d0pWeGRqcThFb3ZLaFM1cEdMSnJtU2JKNUVZMjc3Y0gyTThWdjV1Vm00a25B?=
 =?utf-8?B?WkFmNmlDWEFCUTY1MDRMbzRnV0FLRFRmeEY1OVVzcGhsY0kzUjFKVW43Q3Z0?=
 =?utf-8?B?dFR5TWRaMzcyUzMzeVhqT3NJZVZnVUxiR2RYZlkycUlSTnd3bjMzck9WTUl3?=
 =?utf-8?B?MnZrSUhDNHYvKzBtRE05Q0FPdmJkTmxJNVRCbTJuS2UyZzJ2b2w0NE9SM3RT?=
 =?utf-8?B?ZDlsR1ltM2NGNGNkY1U0RTdINlBnUm5yWlJYUGxIbklVclB5ZDZuM1RJMUlt?=
 =?utf-8?B?YmJOV0lwbm1TVEk1b2NLM1BWN1RDajJoVS9sWkdmdWw0L2gwV3haNWtrNmZu?=
 =?utf-8?B?b2F5bDFPOUN1T3dYdjhFelQxekRQZUdOazVIRXRpZFo2QXhETnBQSHptd05w?=
 =?utf-8?B?NHFLekFyMXVueFFxeGZ5cFdNRHJCMlFFT3dqL1VyTW1yNVZIem5XYm1ZVGpP?=
 =?utf-8?B?MnA3MDBrZ3RUNzlaS21ZRGRYTFMydWV4c3JHaVlsSEZVQnBiTmF1cUtPTjVs?=
 =?utf-8?B?MzRocTV2ZXgwbUpOL2I3UzB1d3B5VWdrMmxwbWZqRlF5LzUwZHdSbDRWd0JL?=
 =?utf-8?B?UVd2T2hGMmVOL3JEQmRxUDNJbkQwUDlpQmFVZEVQTXhSTGFMWXVIWC9pZHVD?=
 =?utf-8?B?bFduWXk5ZUxLVy9FalduUzlyTmwxWG94SUhVTmpzTTgwbU14V1B0VFgya2dG?=
 =?utf-8?B?cTFpRE9qaldwRUlGVjZEblhBTVdkQWFsckUyWDdkSnYxbG9tSlhFV1NuWjhT?=
 =?utf-8?B?bzhjdm45T2dwYUJaS0xYSnBnaFBMdUl4V1NzUVVtNTBhKzZkZXhUV3YxUGxj?=
 =?utf-8?B?TEJ6YXJTendRRU9XbGt0Zm9aRVYwcis2Zk1sdmNMM25VeitUc3AxekkrYS9N?=
 =?utf-8?B?SVljMjZQMzVpdytjY1BQQmlaUW9ML0hWelFIYnBNdW1QTzBNVE5WWkdqWXZt?=
 =?utf-8?B?V3B0SHowWm1oRVJtQ2pvSWJQdHIxSHRDYVJWbGthUjk3a3o0eThDTVpaL3h6?=
 =?utf-8?B?RnFMSUhTWlRSNGxjY0g3TTU2MHVhMUFzaDUvNFlDZ3dHSjlVNHlZNG9RUFlY?=
 =?utf-8?B?NXF0bEFFNCtYZXpxVDcwY2pMaU5tRGNaUFhDR1RodGdZakpHaTBuQkxrQUJF?=
 =?utf-8?B?ajFleGE3MGVOd0tDcmZpWExCRUI5U3dRcDNWR0xGZzFJd3VXMlE2TWY2UGtq?=
 =?utf-8?B?UVdOMUQ4WUZnVS9rZ1Y1MnU2RHZIZ0dJaGRlZnRCKzFOODZ6YWNQNHZUNjVl?=
 =?utf-8?B?ZDduc0Z4U2lOdmY1U3dhbXBKOCtzRkN0cW1qNTlUay9QcUkzM0Z0MmFqYkFV?=
 =?utf-8?B?d2d3bWpFYXNHYUlmS3lHbWlnd1h1ZnBjdCs2Y3dWMzlub2wxM256YTBKQU9k?=
 =?utf-8?B?SUFBandDZXhkdTRSUE1BQy9CQzkycUg2TDFoajFPVVM3MkZ3Zk1ocTNyMFA2?=
 =?utf-8?Q?htdbptMQE1WlHziHyp5a7VoPgp/Bfj6vWw/AIUKtGM5Y9?=
x-ms-exchange-antispam-messagedata-1: Ew9h7jS1BZ+iFs651osQMxXsS+x5VNRUfJk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4716D2E706EC5448A3EA153A52B82DD1@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DarhTowLhA3DvE+HAOdXj+FWUYtj3Shn+z/85AtYVASZWfVimZK5foHYQCtCG0OVj8c79z+pa37L1z3wp/56y0pdl7r3MwyEGjCxS87CxrAX/KmQ1IWLVLBwGC0Od6+l6vTtRYxNLOGiX4xk5v8HjKaqvLmmy1fUYbZgYCRUMMDN31eVUOvs19tGfR0J8M7agZs2+6GtVP3B+6OB7XjeJHD43M41aIiBUCb8O6qtpRv8s/g5dHcR1W/bkp5Q0dIQMjRIr66KgzirJNekXKWlfxSHXm1TUyb+Rzs93uRuCwZzEa7tHthZc0Yb9dz6EYukHjwT4O9GMR+vPhOn9cD1KQ==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 383177d8-9388-4499-ad0a-08def8f58033
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 04:44:03.4487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KlbWZsyry2LcLWVTDJeR7/z8Lzik0QkRbFlissQxYAJuxA+NgDXXd+FjU7apJdVx+HfAUPFqBwy/hHCbhL+aKvaPKNSHWj+lQt8z0qq36t4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5957
X-Authority-Analysis: v=2.4 cv=DcwnbPtW c=1 sm=1 tr=0 ts=6a7d4b97 cx=c_pps
 a=A0iqGUCyZdlyWs06AcuuUw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=r_1tXGB3AAAA:8
 a=yvHXnGe9GhCXaYnihIgA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDAzMCBTYWx0ZWRfX17i/Mk1pDjjg
 qTgXMxHFdyK22WMyyLGxSvcXCei9N5Nqk0afW4cvGg80ZDEk9XJmMvlCV3FeU2A3G/OREvHasEp
 zrovPOcsFAQAUJdJToeJCv8rGF84toQHMuIgvvodm/S3C9Bsa2ks1el6u5iMdoQJ+mA+gCu1oe/
 NdEDbiw8o0nfjt0pz7X3O8HJPYHubOJDMEXK9ZECCXO2mJ4ZrquCJVEp9eAtiZuu5SzAlHeqKR1
 IOR6zqPzaLuqiiVOxj8wmQiMAh9mfBknzrcgzVbdysI3Fx37S/faUsiU3gaezfI8YQqKG52XUaa
 WT4EmMRcuAA85HLOrHg6bVaca4vQLcquVbymOshZ2z5U5l6lbER7wFpeGgLczcJHBMzQTMcOfMj
 FEQHu2H6bQuyFrYkpGgwhZHpjKgh3N+/l2AwSGs5nfM2h93XTn8VV/Zw6mokQETc9BmgP6QSDz4
 7Wly9wO+XwaALp9C4rQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDAzMCBTYWx0ZWRfXy9etvcVXTigK
 dqyxNhceMiJjPJ4V86QIR4UZhS9M5em2QXDbtollb+3omiMyo9QDk69hyLaYbcdlMv6TDPQHLxR
 EBULaxJJSDWLeDC/rP0quiFgeu8YK2g=
X-Proofpoint-GUID: DtSto23Ss7bpgq0DNMW4u5SjBRLW5WpQ
X-Proofpoint-ORIG-GUID: DtSto23Ss7bpgq0DNMW4u5SjBRLW5WpQ
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

T24gTW9uLCAyMDI2LTA4LTEwIGF0IDE2OjAzICswMzAwLCBBbGV4YW5kcnUgRGFkdSB3cm90ZToN
CkhpIEFsZXhhbmRydSwNCj4gRnJvbTogQWxlc3NpbyBCZWxsZSA8YWxlc3Npby5iZWxsZUBpbWd0
ZWMuY29tPg0KPiANCj4gVGhlIHNhbWUgaXMgYWxyZWFkeSBkb25lIGJ5IHRoZSBjY2JfY3RybF9p
bml0KCkgY2FsbGJhY2suDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGVzc2lvIEJlbGxlIDxhbGVz
c2lvLmJlbGxlQGltZ3RlYy5jb20+DQo+IC0tLQ0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUg
RGFkdSA8YWxleGFuZHJ1LmRhZHVAaW1ndGVjLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9k
cm0vaW1hZ2luYXRpb24vcHZyX2NjYi5jIHwgNSAtLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0
aW9uL3B2cl9jY2IuYyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfY2NiLmMNCj4g
aW5kZXggNGFjY2YxOGUyMzQxLi40ODY3MmE4NmNhMmYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfY2NiLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2lt
YWdpbmF0aW9uL3B2cl9jY2IuYw0KPiBAQCAtODIsMTEgKzgyLDYgQEAgcHZyX2NjYl9pbml0KHN0
cnVjdCBwdnJfZGV2aWNlICpwdnJfZGV2LCBzdHJ1Y3QgcHZyX2NjYiAqcHZyX2NjYiwNCj4gIAlw
dnJfZndfb2JqZWN0X2dldF9md19hZGRyKHB2cl9jY2ItPmN0cmxfb2JqLCAmcHZyX2NjYi0+Y3Ry
bF9md19hZGRyKTsNCj4gIAlwdnJfZndfb2JqZWN0X2dldF9md19hZGRyKHB2cl9jY2ItPmNjYl9v
YmosICZwdnJfY2NiLT5jY2JfZndfYWRkcik7DQo+ICANCj4gLQlXUklURV9PTkNFKHB2cl9jY2It
PmN0cmwtPndyaXRlX29mZnNldCwgMCk7DQo+IC0JV1JJVEVfT05DRShwdnJfY2NiLT5jdHJsLT5y
ZWFkX29mZnNldCwgMCk7DQo+IC0JV1JJVEVfT05DRShwdnJfY2NiLT5jdHJsLT53cmFwX21hc2ss
IG51bV9jbWRzIC0gMSk7DQo+IC0JV1JJVEVfT05DRShwdnJfY2NiLT5jdHJsLT5jbWRfc2l6ZSwg
Y21kX3NpemUpOw0KPiAtDQo+ICAJcmV0dXJuIDA7DQo+ICANCj4gIGVycl9mcmVlX2N0cmw6DQo+
IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IGU1NWZlYWQyMmZmOWVlMDQ3YWI5ZjE5MDM4NjBjNGI0
MzA0MzUxNGUNCj4gY2hhbmdlLWlkOiAyMDI2MDgxMC1iNC11cHN0cmVhbS1yZW1vdmUtZHVwbGlj
YXRlLWNjYi1jb250cm9sLWluaXQtZWQxMGU2NDFkODFiDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+
IC0tICANCj4gQWxleGFuZHJ1IERhZHUgPGFsZXhhbmRydS5kYWR1QGltZ3RlYy5jb20+DQo+IA0K
DQpSZXZpZXdlZCBieTogQnJhamVzaCBHdXB0YSA8YnJhamVzaC5ndXB0YUBpbWd0ZWMuY29tPg0K
DQpUaGFua3MsDQpCcmFqZXNoDQo=
