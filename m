Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03EB10F6FC2
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2102E10ECD3;
	Wed,  1 Apr 2026 15:08:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="Sf1Wzh7j";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022124.outbound.protection.outlook.com [52.101.101.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8CA310ECD3;
 Wed,  1 Apr 2026 15:08:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSqkItFkeZOMky5QXMbysaGeQpKwRCCvJ7xUFFSLJd48kZtTMWrYE4c5w0YnGljj+XSbeUpBj6YpSwVk+LuC4Jns9kYEPh0pcImtPMKqfo3i1sWwQ8IDvwVFNWQtGzbTbLhvdf32/Z/az3FbvL6CToA/+WliCoAyvRdjF5y/bjuaVnMOEUR7w3IUSAbQ8i1tqkNj6f8TUjopMdQfgjXUDvIMp4FOIko44wjxdntKdmLnLwszKgxxmm2rACq/brXfwxF0pCXPpZVoig0POOhGa2tTziG6ckXg6Fj8jdu40v/E6t3Vv3WrmbelJ15OJIXInsqkm4RDz+lVCtMroGeoaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQIHtD5R635iTlWBEEumPtw7FB2kP+38+FhRn5vThf8=;
 b=YMtYNYPH/oNju3Vcc7ZKyuxVlCjwKRa5RjJhkm2fZOfoCf68OC3xnu+tmX5/x69qZPXRF/hdoTHicOY64eYnJ1AJhSv4Sra9dJ6+nUDv/sG1DPKS4ccLQrxuRs6r2epyCzWrOC/E43xbfz0Jd+2njb52yuSmeKPeYJXa3jOW4ws1BIljElMqMw8bY3l7XsFzmXFbDdvDE254EKz2Vucx6g8B3oMgXKSkuWQ09ROVAxJZIAu4U8rHd3gJ7WJFVyO2OfcLjzdu2ARy6bvhtndTEnujjcRj7VwaIKrFCLX+d7AK9uIkuIdh4DSwTnblnvvMf7yYlW4JjZY3mJr68qN5AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQIHtD5R635iTlWBEEumPtw7FB2kP+38+FhRn5vThf8=;
 b=Sf1Wzh7j4zdFQjgapyivofamDgD0/SY3wv5Q1aNarISB9TYdtBcX8a2DFLj8aC6U1rTy2VeE0OsoOQ2nmBJ8CLE93yE/K5jBYg1JceXjsFudps1syMSr3HUYHVmB7KZnPwmLCHOkTsoAla7MxiK+WDtHXT9hY0/J4fapT+jXwro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB7497.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:214::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 1 Apr
 2026 15:08:50 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 15:08:50 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Apr 2026 16:08:49 +0100
Message-Id: <DHHWVSEAUS6Y.2W1OKQ3RQ2CYN@garyguo.net>
Cc: "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kbuild@vger.kernel.org>, "Lorenzo
 Stoakes" <lorenzo.stoakes@oracle.com>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 "Uladzislau Rezki" <urezki@gmail.com>, <linux-block@vger.kernel.org>,
 "moderated for non-subscribers" <linux-arm-kernel@lists.infradead.org>,
 "Alexandre Ghiti" <alex@ghiti.fr>, <linux-riscv@lists.infradead.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, "Rae
 Moar" <raemoar63@gmail.com>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, "Nick Desaulniers"
 <nick.desaulniers+lkml@gmail.com>, "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>, <llvm@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 21/33] gpu: nova-core: bindings: remove unneeded `cfg_attr`
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <ojeda@kernel.org>, "Nathan Chancellor"
 <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Paul
 Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Brendan Higgins" <brendan.higgins@linux.dev>, "David Gow"
 <david@davidgow.net>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, "Todd Kjos"
 <tkjos@android.com>, "Christian Brauner" <christian@brauner.io>, "Carlos
 Llamas" <cmllamas@google.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Jonathan Corbet" <corbet@lwn.net>
X-Mailer: aerc 0.21.0
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-22-ojeda@kernel.org>
In-Reply-To: <20260401114540.30108-22-ojeda@kernel.org>
X-ClientProxiedBy: LO2P265CA0053.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: 23305012-903b-4508-f881-08de900094bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|22082099003|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: s8Jf0GRIGhrJIAZcgGmzxtXHfnREzcBdgvebCGxBgvRKYI80ghyolRvZM4PPoUTOOuD4UJAL/5L60zO7uVWTwc00EyRWYqfRoU7MLGoeWBcDdIR8gtXpLE8BCyU1+TEnJ4o1Nq4ibgRQ5HVUgWE0uXm/yY6agg6QwYfgqT+C4vznEai+YKN0w+G2F1FuYpL5Ra4RUwAwiKn5fVaU/BGfyQGaLnFujaoUUJW/m6gFa37874PsO9x4ncC5smdqiIkhXXL4arovvGLXpvh/k4WuMFPVLGY/cgYCETm61a6Mdp0XCdoTiuaQOT4Pbf2fBj8zkzTEv+1R9URc/yyZh24Bur/GeTLF15xLlDliJ4CWmBXUR7twSi3NM/8s4owMH4y/jWBA+FzU8CXIlSYqQ3Mmgi+OapT0QaV/QxW5GB3iHS/tvwyz1FNL0l3ucpY/0XYWFV0KdUYtQEUkIn6w1DMhyWn+e2rQYrlKRplI3Si/lb+lNADbNTIoFmEPTVgXjOU1VHGfuL2oc+TrRJVRvPRZLlztBf+1kFOyGtF+y6elEHE6VM1fFhCicFor53M/SRmzuVKlW/sLz7zT1Hu0cDDTeDJh298TmTE4EpLcGZTGn/5vS02h4VqmTyzalArx4ov5jVnNWLPoPoHmTQU3A6l+YJWyg8w/L8sBJBAzRRyGQ333PdUijjt0iHjHipjQPub1ZlQIcwnTv/8sh95EGlDxPOw1El6ZorTYf7bcUGSeXrYJ4d8m+CZp88n4NVAz0JtgaSQqET+vhxqItLdT5wJzQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(22082099003)(921020)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDV5QjdoVS9RczFMYXE4Qk9SQ2s4aFpaaGFPZkdiNzhaeFNqd1M5UUkzSVJT?=
 =?utf-8?B?Qk1CMmloVmZvbCs4TDRUZkFHMXQ0amt3bkpady9ubnBFTEg2OUcxbTZ1RkVZ?=
 =?utf-8?B?M0g1bVpjdDNYNEV1eVhZdzR2SGlCbHFRTjZ5YytIY1F0WUg4ZzRpQk1MYWRa?=
 =?utf-8?B?VnNvU2d4bm1CWlpvcFpHOW9yN2YwdzFuTjRVM0VXWVRQaENYZUR1cXZiQWls?=
 =?utf-8?B?bnZiQTBYMXZpK2hEaWlyUDNCRTVwdVJHNUhEZVJKampDcmNHV0lkTW52S2Nr?=
 =?utf-8?B?YzNXQ2dmbGRIM1Ryck92eU1iZmhHUUtqN1dXdkFvdzVJRzU2ck04am9WZmZw?=
 =?utf-8?B?ZEMrT2pmS3FhdUlqVEMvdHBsS3BNSWQ1c0ZmNEQ0ZHlqMEorMHJJVmRYSnV5?=
 =?utf-8?B?RVBhQ2NxT2dtZG4vMmk0OXhzd0p4b0p6Vmw0c0MzRnZGR1VjbURXV1ZaM1lS?=
 =?utf-8?B?cDk2LzNpck5xWmpldGlHczBGQlA5ZzZJVmxxUTFWcDN5ZExEQ2FLek9xb25C?=
 =?utf-8?B?dHkwSkR1UlBNMGZ2aWxOWFc0VnpSdnU2YXViTXdpODVJbzJkT3A2Yy9BdnJk?=
 =?utf-8?B?MjBKMkZmZUVrZEgxWm9MSExpQmdsVDFUSmlLeTQ2UDByYWZIcHdUSXR1QnRQ?=
 =?utf-8?B?QXRGcnJXN2JLR1lrREFOZkZpRWVjWFR3bmlnMkVBUndjb2dzcEhnelp3WEtm?=
 =?utf-8?B?QzBPWHZ2RzJYYUFFZEhRbFp2WmN3bStRMzBzZDdoamt1Q2Z1bnpzY0NvSlJX?=
 =?utf-8?B?UjFRKzZ1c1lqNXA2SHRkMGNWQWk1S3QzOXU2K0liTENDNEFxVS9BOFhKdWE4?=
 =?utf-8?B?NCs3dFVhZ000Y1c3d0w5cWRjUG4vUGxITVdhK2FqZ2pWY0NucWtVU28xdDdX?=
 =?utf-8?B?ZWl4NHg1UkhBS21IWTZhczF5WlVFcDgwRkhVQWtXZ3BuOTR6aHRXYXVaNXM1?=
 =?utf-8?B?S0owSXdCNzMzUHVUNDRhTGx5UUt3YmRGTldFc3ZEcTM0M3dJN0VLVUU2OUdS?=
 =?utf-8?B?WXhsTUZOaUxrOFppVlQzeDV4MEtGTThMbXZvUHhGTHdPNTE4VDFTdFZJS0U0?=
 =?utf-8?B?R1JtNG1Od2hoRG5KTC9LbTVCY25DV3drNmdZM25oeEhId3R6amlOdnk2c3VB?=
 =?utf-8?B?RlIwZ0RndHpuRlIvUEZLMGhmbTFFN1NyMEtnN2p4akd1Zk5haHVsck5MMWha?=
 =?utf-8?B?VXZ1STJWYkw4NUgvYmsrQ0JaamtxeHNLVmlnZmpNUUVndjlhTEJPWGN5ZVdo?=
 =?utf-8?B?eDE2eVQ2Z2U3NlhqQlZ4dExtUVhrUzF1TGpncFROa2FyNGVZZ0svT2I1cmM2?=
 =?utf-8?B?MzVSS1V5aWVoZWVGdTVWUnJyTG5yeFhKZmZBM2Vjc2Y0T3pmMGpMSzZDOEFu?=
 =?utf-8?B?ajlmV0p1d2pPd2Z6S3NSc1BnNkREQUNlS3lMVGJIaWk0eDdDb1lqZG1YMyt0?=
 =?utf-8?B?bGNTRXo4dmtscVlDM0JSdGpLTlV6NFg1YmFod01ZeC9WTGpOZUhjVVIzeCtL?=
 =?utf-8?B?RUlWTWYvSTNOS2w3ZFEyeE5haWpDOGxraG5ZaDRmRU5NNmVTMGtZSHR3OEpz?=
 =?utf-8?B?WWN1ZzhjKy9oMmZDTVUyODdKSDdKdFNTQnpaNWV1VS9KbDM5cW1JUUlLa244?=
 =?utf-8?B?Qkw0cmpTRk9WT3B3NTE4L2swUDdrL2lPRFJyYmpqR3lOS2p1Z0NtSlg4RU5L?=
 =?utf-8?B?ZUdlbmdJRkp2Mmd3YU1GWUFYL1k4bGJiVGh1OEo1RTd4aE9MQkxWUi9RTXYz?=
 =?utf-8?B?S1N2Z2pZd2M5L1JRa2ZuY2lrNk9VWmxsK1owYldyN3l3WVd0bXhUM2h4Q0s5?=
 =?utf-8?B?TUFROEFBZjFOdlUvd3BZajdBRXE5L1UyVnY4Y2o1SzNBQjJqTFVIWEtnS1JN?=
 =?utf-8?B?VENzSVVGYzMyQ1pUeWJ1ZGRvZVFsY2hXcXh0SnZtT0RYbkFIZTBaRnBlWHR5?=
 =?utf-8?B?bTJ0N3c5RlNxbFhMVklZRjZrUU93cnlQUXd0Tm9LQThNYmdQTU1RTHVWWWNr?=
 =?utf-8?B?SUd0dU04ZEd0NXVTWTBUSDFna1ZoTHpYai9PeXdtZ2FMbkhvVHV4OVJtK25j?=
 =?utf-8?B?SUlSSlgyKzV2bHJSVnlJTVFxSmFPRnFySWFJbnUxc0dTRWdvOFhHREEyemd6?=
 =?utf-8?B?V0ZTZ05TMTJBRmRGYktrU3hyYzFSL2RDMU13NEpXZFdxK3gxaDUrRFBsVFpm?=
 =?utf-8?B?MmQ2K2ZjNlJ4WGMzeC80akdjMitJMVNjSjMrVGd2V1Z5L2lUL2M1MmQxQmdw?=
 =?utf-8?B?RXQvL0tTeEl3TWw0MUNRMHNhMllSSXczNk95VDFFZVI1dExFN013Ukk5dEN0?=
 =?utf-8?B?Vkd2SGR3M2wyZmdlL0YzMklPMTR3NHR0cERjaUVVVGNadzhRQ3Zrdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 23305012-903b-4508-f881-08de900094bd
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 15:08:50.3785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saZeuk5o4lPwmQqZrd/66ejXAnCGTCpAngN293wm805GN/nZhnspi22+0jdV9Bqu/BiYg+WW0xrQ9d37pBzKSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7497
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

On Wed Apr 1, 2026 at 12:45 PM BST, Miguel Ojeda wrote:
> These were likely copied from the `bindings` and `uapi` crates, but are
> unneeded since there are no `cfg(test)`s in the bindings.
>=20
> In addition, the issue that triggered the addition in those crates
> originally is also fixed in `bindgen` (please see the previous commit).
>=20
> Thus remove them.
>=20
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/gpu/nova-core/gsp/fw/r570_144.rs | 3 ---

I believe drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs is generated
manually and checked in to the source tree? It might be useful to actually =
have
the command line and bindgen version used to generate the file present
somewhere for knowing about possible compatibility issues like this one and
reproducibility..

Best,
Gary

>  1 file changed, 3 deletions(-)

