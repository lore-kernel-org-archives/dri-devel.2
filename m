Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B338CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 17:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7243F10E87B;
	Wed, 27 May 2026 17:49:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="U0mvY+Ok";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020078.outbound.protection.outlook.com [52.101.196.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E216610E87B
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 17:49:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2aBbvyxgGspNqmXEQNjLdTUGpGODL2dEPCYAf+QGcvJjFNfKe+G7LxyaEgtviBgVgb/TqhZWY6dteBs+WS9qW9ZKWXoeOo7Oax9E01mk/L2gh/pc9ehNHjKILbS9Owlmps/YA+57JQEsSbj/4fIqsDoLulyp3/IAUjHnKpuEhg/Q81X+e6vW0NememF1xl5zhkkLRhi5rV+bSaDZOOrEr1wWsRuq0+u6Jb8wbp6YcjgOI9ntWvL+ZtM2EijRMNS1RUXaxHudijcbgvS058X0AEf2XwMqiPUbBoQ59YAME7muzJrBXMbWzrj/YUgWdyUjbZB32s+MQOFGpmKi8Q+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AFk0WYa9PPZSSonfLtrUTPVC1e/mLgqMs6K0Y4zr6k=;
 b=w1dNoWpPZ9eCoxUz/Ut+Ke2neWuUtCpWYl42RmBCOTNwIkUM42LSw6GywUzXOXd1hf9Y8taKwte+fD7chDymDRv6ciUyDQ/p60Q8stlEeoLgId33ejC4gYs0UipDqnTvai4i0b2gugRlPjuM5TUTyQEyFLdkUbCL9x2v9tegSLlBtCvA0znEu8dGLzQuJ5HK8zRhVz8SMIdUykQwhvZmLEOHw3RqkvT1ksYgLHIbtHxZx4s1U59PXcmpxpN6+cir0iBRUgTMLWnRRqaz+sf6fKDJ5HH2rxtC75yipUpgsbsfpmX1otmEjiaVwemr7g19S4sUbsSHn1CP5h5LkRwR0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AFk0WYa9PPZSSonfLtrUTPVC1e/mLgqMs6K0Y4zr6k=;
 b=U0mvY+OkSr/fCt/o7psFfz14SolpQwU++qhfBoKesnmUgp3ljnAJJmX85ns8aX88t7wtB1PHpTFtvepbe9pqmPrH7d2Ei3a/XJ5OVJBJSb3Cs0URJ46I+zxYG4FM5oPltYxrmNM3Sf2ddslSynwCen89m35aOhKTu3NKQmQkfyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO2P265MB2736.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:147::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 17:49:24 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 17:49:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 18:49:23 +0100
Message-Id: <DITND8OO1D7K.2694AAY23IQVT@garyguo.net>
Subject: Re: [PATCH v2 2/7] pin_init: always inline the #ident and
 #project_ident methods
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.21.0
References: <20260527-nova-exports-v2-0-06de4c556d55@nvidia.com>
 <20260527-nova-exports-v2-2-06de4c556d55@nvidia.com>
In-Reply-To: <20260527-nova-exports-v2-2-06de4c556d55@nvidia.com>
X-ClientProxiedBy: LO4P123CA0217.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::6) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LO2P265MB2736:EE_
X-MS-Office365-Filtering-Correlation-Id: 29269640-0c86-4c27-375e-08debc184a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7416014|921020|18002099003|22082099003|6133799003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: EqIjSUZpIEiVK6BIMODPZjkprdv0oUJ3NyU2Zj9ig/AB+xhXyLDqfLjlfwbqxqkS17kG5LqoFaS3mDnTFoFJRYcWZs6DMNUWUMqemuXBTy/S/1/apgXqqX3mDlD4PlZbAsuqgWQU/kABpOFys4SVQ50sM28RYfYGh2zv8dknJU0LQ7gJAqdV2ZaJ1qjr6blphH+ud8JKt7jCEy9ySk5zPyXq8ufpnJ+7uOXio3y6tljL4Jmuc6iZNcJN4sZcD2yEPD9a3SlbhVTlRmzJpHnErtTN/qx/Qzv52yBixbPqRGeTrFqFdZS4i+Nq4c/GP4k6POml6x0H8Zt4JfuI/cjvbq0Evwua/P7WE5Gq4Jbm69yM9SXhXP63wszbj63XSMZ4xbJmDBHUIPXWPloqgjhgCK/ouvGiLIyrhv2SFLIgl+wvcc+4ka/YWuNbe8gtfLNXRtemyus5J2yfJ+J1kqvDRKmLB6OybEN4yRoeEyhuLzc8gg0+6HHtV2qPq1caknw0GV3nafnp3KEFdJy3gylHWddl0CQsuc7O0XY4gFR3tz3swH6TiH2iJvSN2lNFrzlsDHxJ4CKBbQJNybwh2D8APhSwNsXZnIvMLJYQGnWVIx9V7Ct20leLHhYoravygi92LzTOfM7s3gw2rQZqeSfCLgz/klhL28zBHbkxxxhueJo1vKCAFGVaGoytj7ZHBz/8Ok+w7KeUfwUjnWTSINHCZUUL98vlMw/HbpEW6SULbJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(921020)(18002099003)(22082099003)(6133799003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFlHRzRRRFVrY3VHbGFsUFdnVVZyb2VRQytwM3k0S3VjeTZOUUxJWTNLWmJV?=
 =?utf-8?B?YXVaK2hSUkZTWitRelFNdFNTajAxT3h0bFdMcTRVUjBoRmRnS09qay9FY2xy?=
 =?utf-8?B?ekFvTGEzdzRJWno0OXVZSzN0ZHpFY2toRVk5WUVpSjJIeGpleWhoakhOdHJ3?=
 =?utf-8?B?UmptcDJNK3AwVURhNGJKdk5wZUlnSEFJa0Z2dUlIN0lJTkdMQ2lBaldRWlR3?=
 =?utf-8?B?dU5zZ2dNZlBSRStvbStIY0lKZ2lhb0lrZ1QyVDFZb2ZpejlSbHV3V0wrbEt3?=
 =?utf-8?B?eDJaeVcxM0ZBVCt0U2xKNGhLcExIQlVxejdWdGFGdU1GNHBEQk9sR3VuMWZL?=
 =?utf-8?B?anNCVkFSMjg0NDBBRUxJMGZUMDd5emVKREtNZVEydXJKNHhsZCtLY3RmTXNl?=
 =?utf-8?B?TzhLQkNlZ3dQY3pqRGZrUk1ZWXB4MHlBdDh6TFAwT3g4VUdaL2RKT1ZBUWtK?=
 =?utf-8?B?dEVhUW9hcC9LcEdYVG50Q0Y1YStnTWZhU0VadWl2eittUXdvSW13QzNPU1Rx?=
 =?utf-8?B?Y2FPeDgxOGhlSHgxN2xzY0RPbVJiZzlHTW9jYmFibUVyNG85eUxCSkdkenhq?=
 =?utf-8?B?bEdiajRjM0hyYldvdDY2SnhJdkpJOVVZL09JSElIOGRSd3ZRaVJ3ZTVUYTFw?=
 =?utf-8?B?ZUJ2NllUV3l4ODVWSEVhR2pkWGhCRVhqWHdVNWpGbFpybElJYllNQmRuL2wx?=
 =?utf-8?B?R2pXdSt5MjZIb2l5alV6dWs2eHBWMHE1Rlc4OTEzekhWS2NKbDVzdTJnRWVF?=
 =?utf-8?B?OEhkMkhwZm5kS0tuVEJIdkJORmZEUHU3NSttWjBWL1RMNUprVGFWTDRXeXVl?=
 =?utf-8?B?Ry91UTRtS09lZ0VjMlJyTGszOXFIbTZ2NHFtNVk0V2ZMaWpla3Z2ZWRmV21X?=
 =?utf-8?B?QnhiQVZjU2gvc2N4RU5zOCtuL2pOWFJiN3dMeXpxRTlXajRNZHA1Mm0rcGhZ?=
 =?utf-8?B?Sk5HdEZlTGhFUVBqTUFMZm1CNXBCRFllaUlXRTNmSTh1TE1kNlJsRVpKU0NR?=
 =?utf-8?B?WU85aTdUY3J4MVZJdkRwblRUZnRxUEJTVnhLckpoQmFxVU5HUitxUHRvN3FY?=
 =?utf-8?B?RUd3anZzQmgrbSsvY0F3aE52ZWJuUzVReDVOZWFvbXR3a3lMd05xc3AwejUr?=
 =?utf-8?B?TTc3dEFGd3hBU0g1R21OZlEzRnM5NDYxS0tzZkdLNWxXZytmM2NHVVNCK2gr?=
 =?utf-8?B?dE9lTDNyUWo5V3lhYnUyN0RkdFMxSEVVVFUrUytOUW5EZnVyZVhObjFHd3Jh?=
 =?utf-8?B?QUlGOGxnZVNNTVd3dU0xNG52eEZ1U3dQQmJ5aW9vR0o0dlYzbHdPZ2ppTS9k?=
 =?utf-8?B?cFRRSWRHQ3hnM0QyTFA1NzV0QTJwdWZKT25JYS9pL0hwbDE5YzFtd1NNZFR1?=
 =?utf-8?B?aE1vYnRMUkF3KzRZNHdKV01ENys2dmprenExa0N5RVlTYW56bkhxbWsxKzI3?=
 =?utf-8?B?b3c0aWtveVBJL0VYUnRva0dtamhEWHBKaGI2LzJlbkFzSXR4MU51Zk4xMFhy?=
 =?utf-8?B?eWROcSszSWk3ZTR6SVEwbW1DNmZEQ1owd1dvOUdqa2J5Z052K3NhTC9hUHZn?=
 =?utf-8?B?Qm5GWGpDcVkvV0hnNnptTGVMbElZbFJLR3p0ekNGTm1FUGh3SkRrQXUrcVdz?=
 =?utf-8?B?UldZamVFQkVXNXlpU05Idnh1Q0RBWUFyWHNVMklocFpMWE12d3VQcG83Yms3?=
 =?utf-8?B?aEJrQkFkK3FORURiaVQremRwN1c1YjlkMlFGKzNYWVNpUDNSb0RIbXJoQjhG?=
 =?utf-8?B?VnFiSGl5SVhkVk1JTG16SlNzTjhuTkFraEJMTjRCa3VyRVFMdkMzRy8xOC9C?=
 =?utf-8?B?bjByVFRaclBwbzR5VkhjNVJkL250RXZsbGVnWmFEZGtaMk1IcFNHY21Hb0dM?=
 =?utf-8?B?a2t5dWFFZTRRSGxNWmNoenVsbkwxd0FRR09uaGNVdlBpdWlvZlJuT2YrM29C?=
 =?utf-8?B?UW5ocXZOSlAyT1o4VmM0em16WUkrN3doWHlRUkpiYUtGbXYxSG5odGpwYjNo?=
 =?utf-8?B?TituZEUyN2pPaVIvUUw2bmVmdDA2SDZsQlU0Z3gyd0ZvbEhiZ05XNVl4VllU?=
 =?utf-8?B?N0lYbzB1czNzSE5CNDZQMTNiUkFMdHluM0d2aDlhWUlXZ25RVnhMK3pnSEI1?=
 =?utf-8?B?SWNWOHpPQlpwV01GaktXb0pBOXVzUTAvVGJlRDdpSE1FM3NmbFQ4MG1EMmxC?=
 =?utf-8?B?UUVOY2hVOTkzK2labDV4aTZPM0tYV1pHSlNjUXgyYWNmckZxTC9IcDZUM1o5?=
 =?utf-8?B?a0xaRVkzY0ZLMHNGOE1ucUM1QzhMWUJ1YUZGaTk2d2RqdWo4UG1OeXVnem9k?=
 =?utf-8?B?c0VDbitKS1RFV3k0a1pnaVg4b2Z4NGNTbGx4eDMzRGcreHZZSkJaZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 29269640-0c86-4c27-375e-08debc184a34
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 17:49:24.4184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juMtQwpDoCu+iDrSVzO0hGblKEQsW3cF0an+3jPnZTDjhfbThw65Yh9NXqDVl3OY8bh/7yPmmFL1obecHTTPog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2736
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

On Wed May 27, 2026 at 12:52 PM BST, Alexandre Courbot wrote:
> These methods should always be inlined for optimization reasons. Failure
> to do so can also produce symbol names larger than what `modpost`
> supports.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  rust/pin-init/internal/src/pin_data.rs | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/rust/pin-init/internal/src/pin_data.rs b/rust/pin-init/inter=
nal/src/pin_data.rs
> index 7d871236b49c..945254740f61 100644
> --- a/rust/pin-init/internal/src/pin_data.rs
> +++ b/rust/pin-init/internal/src/pin_data.rs
> @@ -395,6 +395,7 @@ fn handle_field(
>              ///   to deallocate.
>              #pin_safety
>              #(#attrs)*
> +            #[inline(always)]
>              #vis unsafe fn #ident<E>(
>                  self,
>                  slot: *mut #ty,
> @@ -409,6 +410,7 @@ fn handle_field(
>              ///
>              #[doc =3D #slot_safety]
>              #(#attrs)*
> +            #[inline(always)]
>              #vis unsafe fn #project_ident<'__slot>(
>                  self,
>                  slot: &'__slot mut #ty,

This code doesn't exist anymore on pin-init-next.

Best,
Gary
