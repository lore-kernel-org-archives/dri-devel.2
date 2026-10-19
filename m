Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1398606A323
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=KnYqLxjG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B51D10E888;
	Mon, 19 Oct 2026 16:16:52 +0000 (UTC)
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022098.outbound.protection.outlook.com [52.101.96.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C10AA10E9B6
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:16:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdKQ3Q/Icx7HB7bzceLGWxrawHdpOZUgy2aOpAikIx3600lyKdWoKFDgAR2bxaT0xgx4m3/nO0oVRoMKS+RcgVLkO9tByg2kCUdA2gK3OZxnuRT6Rnvh8BBV8RubPUsUsN2x+2NK8lf1XPagturl9LVgxKmktQe8yy1VLntLzJX8ZVJTcXuuHEzcv8qgzCwUxqJjIi2ino2a3pLbclu8Z+rDgDMRFNzI7uZajoppesumHIvTRh+OXr8O0470l5VlJ9uf8grEtKHVWF/w00Vx+jqk90loJxeYRUHKObiTDhobLzN8Icc+Mp9Hp4B6Flsz1LvXBTZLx5gP9acFH+m7QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ydt0CLyOsOCLEfdPC6Vanczhg6KWP8Ljp09RX5WLWNU=;
 b=Z1xS2kMg7E0NMOUNCbDwInl0CkWQeEnbUFBKK3ijCy/3pclLftZw6emOLYz13dw4Uoo9/vjqEqWQUbZaXqpNvKfMOifmyTPqmExskp7tX2QuIiRomwxLU3T3dK7bhqzIkD3QAOLPYccu0vnpdRgnn14rpFi/GJjbGXp62RRzTaG3giusjVHh1cCC4WPU9PIj5UoiFk2Oy8gDiES3p3YSEcqTE+dVQbw3cR1CyUeAJ0axUY8T0yJjlDNszelmjZ9ZuG+IpFt8aHhGYWq2LWegET+gDQvf6cZCjOYb6Maln3MA25nfoPQKKQgYZjm/hvaqDYHB0gOeS+TCaP4DdcwpLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ydt0CLyOsOCLEfdPC6Vanczhg6KWP8Ljp09RX5WLWNU=;
 b=KnYqLxjGF0FWk9jfCRprW1g83qR8ghyQqWgwJEFqG/vf8jApigQVLWp/FmQjn9rRjqfh0R2TiRa456UUqxzswKqxN2Xv3DzIz7uS3yNIiqH6a2+TLVaaPEoEQ+4h41mjayPjx08oR8Fpop1lNXCI8YrsT7pVMKysIHtL58EMWlI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB3138.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:16:41 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 16:16:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Oct 2026 17:16:40 +0100
Message-Id: <DM8Y78VGDXM5.36K23TMPY8ZVZ@garyguo.net>
Cc: "M Henning" <mhenning@darkrefraction.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "Benno
 Lossin" <lossin@kernel.org>, "Eliot Courtney" <ecourtney@nvidia.com>, "John
 Hubbard" <jhubbard@nvidia.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v6 01/13] rust: auxiliary: let registration_data_with()
 closures return covariant sub-fields
From: "Gary Guo" <gary@garyguo.net>
To: "Gary Guo" <gary@garyguo.net>, "Alistair Popple" <apopple@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, "nova-gpu" <nova-gpu@lists.linux.dev>
X-Mailer: aerc 0.22.0
References: <20260909064506.910162-1-apopple@nvidia.com>
 <20260909064506.910162-2-apopple@nvidia.com>
 <DM8Y4G5JMZ64.9PYKH079V51H@garyguo.net>
In-Reply-To: <DM8Y4G5JMZ64.9PYKH079V51H@garyguo.net>
X-ClientProxiedBy: LO4P123CA0436.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::9) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB3138:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f95707-a234-40a9-9215-08df2dfc5c42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|1800799024|376014|7416014|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4dkEeSEGbbBARXMWLun48gYxcgPFwqKOK2netXgs4s8zbwiVEC0R57Rvbld2dw9ibSD9f/TP7Ti8ovtt4Zq4aGT7gSxjcl9jiAWkEsBLjOcCYulRaMZw09tvEYUzB3Huy0ivjKTtmtSZ8XU5d0+xavDrQrOiRgkxqS20BTHW4BnjlTRO4ZLLTbzD8uv+OkkEobrQ3EaJEk28zTruFi3IHBNzPXTHehtCjKY0/CVOGmGq5ugpalfKTqlf2c200sdwY+J5sQOZTyOmloAJ7KR3a+QAzps3WdP2QvhF5tNe895xzM+CN5FEwG/hNoNIKN6OEgPQ4svIN8JD8FmdICdePlgzg5KffiF4tA4qwewvYoohLVVq3nb5nF+YPZONU01n42KlJlztADZynVWRoFb/hRZNvYZRsN5liciW5CU8j1ILpCuTZseBTMzyGxB2DSFBOOEKKHzF3SGa3NcPOmGbxzZ7i+fmbJ7KVtQUWPdEtlaQjoi3LrIfM/eRr1+iR3icpESfpB6j+xUbaXDeF3jY2o8cUQXh4BaZJ96nDPCochY6BXrnN7Swsdtt2Yrnvfi6f9GDb1TGZHf+Su9o2bFI74CzqJJm2FBDfs2+tgPhfuywBhnuknxK3b55ZVeyjd+zJdcDKILX7p3iX3KRUWglM4LSyB5CPpRUeeQaY3Mram8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(376014)(7416014)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXllNndMV1NMR2paME9EL1FuU1RaWS85SDE2SXNmckVyNlp1TjNNTDRPSEEz?=
 =?utf-8?B?WklpTHd2My9iekxVcmZLdHFJYUowdGJWN05aZmhic1lpSVhoVU0rbG1zUFJI?=
 =?utf-8?B?dTVOOWgxMThRdmt0N3NSS2pGVDhTYVdQa21RekJLU1Bhd1JaQm1Sb2p6WHVp?=
 =?utf-8?B?WGdyL3M0Z2UvZy9vMWY2eTlIbTNkVTkwaXZYRElvdmlRWFRFSm40ZzVSV1ky?=
 =?utf-8?B?dm5tWU1UY1hTOEpMZWJlU0dzQmZWZi9weWZicGN4NkdNeWpPaks0M1VvdWFp?=
 =?utf-8?B?aE1YSS9rZGxOWnlSTWFMNEJCRmpBNUJuaVVNVWx0Y3FoYzFFSjY5T3hDeHV6?=
 =?utf-8?B?L3hxU0RHZ0hiek1IWExRNkhRemJKNkxIZ0MrV2N3SW5rejFzZ0tqblRxbEtj?=
 =?utf-8?B?QkRwSllVWTB4UUdSSzVBZlU0WXZpVzU1Q1A0TXREUE92RER0YVI0Q3VFWXJN?=
 =?utf-8?B?MWNxcllReG9zUlgzU1M0eGRzVkJiWkhwajhGb1VGNnVkUHhMY0MzN3RCY0Zu?=
 =?utf-8?B?L2ZIczNzdjBQWEl5WmU1ZFRPK0NGTVhkckZWL3RYZ0ZwWldSMGFrU2pWcm04?=
 =?utf-8?B?TElPQWc0VTZOeEhkTmpoS21QcWVVT0pyM3NyZXhaaGJHS2RrV0tMVURQZVRD?=
 =?utf-8?B?aFpBNFJDZ2NMdUxjWkw2RE50cWR3MTFxbnlrb3ZSZ2dkOFJleU9Rajh5czhM?=
 =?utf-8?B?Y3kvRDFCbjVBTDJHSVdNS05NdFluMkVlMkVIcXZjQWpqM0lWajlEcW1qNEFr?=
 =?utf-8?B?SjQ2WDlVZXpPQ0FWam9PMFAxVUVRQzZkT2RWZ3FFNm9ncnhXN3RrQlRaSXZ5?=
 =?utf-8?B?UWhqcXUwckdYbXZWTHZKcUswYjlxUER6Zkl4NlMrZGlJRElFa3ZjN05rZlV0?=
 =?utf-8?B?VXFyd2g2bE54SlNNckI4aHVlQllLYWdpVWU4VEMxcTI5WmJHRCtsYnJ1Mi9n?=
 =?utf-8?B?SUZEK00yNHdkRWdFbWNRRTEydjg4c0JDSERSRFlFL1NkTE5vNGs3T3dFT28v?=
 =?utf-8?B?ZTQ3L3cxSm14ZWVXT2pieEtoa2NzQm9qdlJwb1VzemhpZTIxR1pmblAyMUQr?=
 =?utf-8?B?UDVpR0NoSk1FM0htVTBWQjV6UHQxZTJqQXYrMGNHTWRYa0I1b2FRdm8zZklu?=
 =?utf-8?B?ZzFqVHJKa2xNOWpSSGo0bmNMYjBVSW5vb0YzUytYb2l5Mm8wWGh5STJ2UE5o?=
 =?utf-8?B?ZjNGTmxXN0k1eTRRQjY0RGMycGxycDVaVk16SGM5VWJtZ24zZThhL25OemR6?=
 =?utf-8?B?N0RXUHl0V2xjN2ExaS9IZERFNmNGR0FLODZ4bEJyWDBkckRRY0svL0ZSMWFP?=
 =?utf-8?B?TXcydmw5RUlYMTQzb1BOUXJicXFBSXZZaU5SYUE4QlJuR0g0Rmp6K0x4UWZ0?=
 =?utf-8?B?RmRZeXlwVnh0TUgyWjBCUE9wV3AyQ2dpY1JIRmZpbFp4K0Jxd1dPQmRndHI0?=
 =?utf-8?B?SFprN2FXTzNHeEpjQS9XZncrSldENXBTdHF6Qjc4UlhULzUzVzFhWTFWYXh4?=
 =?utf-8?B?Z2F4azh0aERpa2l4clF5TFk1V2FGaGd3bjB4R0taTXFIemc0QjdaYTZyNnUw?=
 =?utf-8?B?OVpXQjFWZXpvYlF3dU9obC9XYVVxWVpnYlYreUs1QUptL2RTRFlNQTAzYjF5?=
 =?utf-8?B?YllmS2ZMTmRHUFl2bXhoOUEyZkhqVHl2UmpLa2xHSjNjMitTRzlHMU1zamtk?=
 =?utf-8?B?d05NUDNZMmJxcVg3Mm5XMDRZcXRDVEFvak1udWsrZ1hvUmxBQXhGc1Vtd0N5?=
 =?utf-8?B?bVlXUEdCSi9zb2d1ODJmRjNWQlNNWkg3MTVjc09NL3pFU01aeG41WXhQUnFN?=
 =?utf-8?B?bFJ5T3dxbW5zS0xsR3JHODlSSE9iN1hnWm92UTZDTWl0a1Y3NHVGb0JNZ0wv?=
 =?utf-8?B?S2NvOFFGd1piVWJ5Y1RnYnVIQ2t0d3Y3NW8zNGxxQlRxVC9KVVZubGNOWXg3?=
 =?utf-8?B?QXFFSW9UUWp0MUFqYTg1UUU2WjVNUDFEUzFTT2J0azZnSFd3TmUyTEQ5MFJW?=
 =?utf-8?B?dmZ0ckE1UzZ0aGNXc2cyYklIZWE3NGxEb2ZBWmljSUQ4RzZ1dnVYazBXOStU?=
 =?utf-8?B?cHJvUWVjU1ZVdDFHbWlvSmtkZ2VyN1NzU2pqQ1dvUUNVaTVwdEZwY1hZNmJ4?=
 =?utf-8?B?alV6UVZUZ3dUUjRuN1BIcThReW10RUJzOVJTR0d6NkNHdFpYMCtXV1VnbmRM?=
 =?utf-8?B?V1Z4blhoSDRDZUVFNVQ5NldkVm1LbTExSUtveU9uVGJqaWtSLzFwdUNSelF2?=
 =?utf-8?B?THpRRUtQVXpyNmMwTm85RUJ4d3MwdXlBWkxHR1V4N2hIQWFhbk90L09ZZkg4?=
 =?utf-8?B?ZWFISjA1aDV5aytqQnNJaTJKMERZeXNHcTdtWnU5WWp6TmNDb1l5Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f95707-a234-40a9-9215-08df2dfc5c42
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:16:41.3399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLvRrPBXI7NI9t8lqbgk/OPUsw7/lQgM4A8NepfURExlYQD+qxG0Uj5hG2fum6SLv7Agv82a7FVNPJvu/6gg0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3138
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Oct 19, 2026 at 5:13 PM BST, Gary Guo wrote:
> On Wed Sep 9, 2026 at 7:44 AM BST, Alistair Popple wrote:
>> The closure passed to registration_data_with() currently receives
>> `Pin<&'a F::Of<'a>>` with `'a` universally quantified. This prevents the
>> closure from returning references derived from the registration data,
>> even for sub-fields that are covariant in their lifetime, because the
>> compiler cannot relate `'a` to any lifetime the caller knows about.
>>
>> Tie the outer reference to the `&self` lifetime instead, i.e. pass
>> `Pin<&'this F::Of<'a>>`. This gives the closure the implied bound
>> `'a: 'this`, so covariant sub-fields such as `&'a T` can be coerced to
>> `'this` and returned directly, while invariant fields still cannot be
>> coerced and therefore cannot escape with an incorrect lifetime.
>>
>> This allows auxiliary child drivers to project covariant data out of
>> invariant registration data without having to wrap every use in a
>> closure.
>
> Looking at this again I think the current API might be unsound where this=
 patch
> becomes fix rather than just a feature update.
>
> For an invariant `&'b F::Of<'a>`, it's actually a requirement that `'a` s=
trictly
> outlive `'b`. With the current API surface, we can obtain a `&'a F::Of<'a=
>`,
> then we can store it inside `F::Of<'a>` (because, well, F::Of<'a> being
> invariant, it can internally have a `Mutex<Option<F::Of<'a>>`), and then =
we're
> able to UAF within the destruction code of `F::Of<'a>`.
>
> The fix, is, well, this patch.
>
> Would you might pulling this patch out, rework the commit message a bit a=
nd send
> as a standalone fix?
>
> Best,
> Gary

Ah, I am looking at an old thread, this has been merged now.

Ignore the message please.

Best,
Gary

