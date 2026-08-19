Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7099C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 20:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23ED810E0B4;
	Wed, 19 Aug 2026 20:07:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="Zjps0+PR";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022087.outbound.protection.outlook.com [52.101.96.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D16E010E0B4
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 20:07:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvNR+dO5xUiyzNhkGxLvgN2GPSB+pVOoJvaTHtCqEBfq4LKU7OvqJhG5zdtzM99FvmAdtd9YuDAqPyNTOlnNSJqaILKc/KaqNHugpD74wyl9EXUuq1uw3Ep+57IDM5DvTAaymZNPBtKUDBXe4MtqhhfCujLFxRSObSX0woPWJiz2wP8JqEA2AM2n4JjenIfaquv/kjcBEP52Scw8JwVBE6kGqhnicYzUzEyaDhL7Y35u3a5hFlYYmuY12eLSCNDUlLfqSPJY6r5Kp+eAeV5oBW4lCpv81yvL8LUcOd0ccUdjKzxeiMwgf4EIKjt1N13MhhMDoZDMehiClb8qUXGqpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CApNQP8UEJUeF0k5/FEQeKuwmPFUQaqP1WeUIuK8rd4=;
 b=CqBo7/2i/9DVsjRv9YGcAF0wKZBeoNEstfUHw2ihp5RJgMvkvEMdu79mMxv+tgNRwuiKQ2JJnAto7WjIRJg+OmTFaa2QGQb0kwaqSJReQsbC/Uf9tbu6nC8CNB+0CiBjA2MPCKAJqyDThPFBbnM+/AhsuwYh4sN4EhMaZaNBtVhEXw1DPLO9r1YiRKYnFQQ2byCBImEO8JRFFaUidM+/iTOw6D+ZYp0fn7FLHVGMMsNakDXbrD20pQDchZA1lN9aG1Nm6BDmF8QzGfL46OrLnIdqWXPwyET+9T3raMZVyEWdyTPENLGSnuEAolcNQgsFNq8wwP/etQvH4FSIZJNfOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CApNQP8UEJUeF0k5/FEQeKuwmPFUQaqP1WeUIuK8rd4=;
 b=Zjps0+PRMA742D8u9aUzQoPjrXf5X6uqQlNrljm3+ctTOXKor1aqHGYzWTUeIjYJ0i0J98c5JTT3QY6bx+cWhjzJ35bKOdIqM6RMH2GX9YhYfaU09xTIXzXqfFMvfC1ay5g/k/fhIMgqf8Uf4fyVEw/Qps4ptuSk12Il5JjBWQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO4P265MB6951.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 20:07:24 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 20:07:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 21:07:23 +0100
Message-Id: <DKT6WNPI2OA5.3RCBNYHHAFAD9@garyguo.net>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v7 03/10] rust: num: add nz! macro for compile time
 NonZero values
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Burak Emir" <burak.emir@gmail.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.22.0
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-3-a5872e64d8f4@nvidia.com>
In-Reply-To: <20260817-chid-v7-3-a5872e64d8f4@nvidia.com>
X-ClientProxiedBy: LO4P123CA0654.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::12) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO4P265MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb688f7-83ff-43ba-5e9d-08defe2d7c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|10070799003|7416014|376014|10067099003|56012099006|18002099003|4143699003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: XQ3qxmvK1OLcXyBps+JzYom/omn52GDBlKBV4DQKVzkYOrwjwyrw+GBNqN/TgDvWDO9qIsIrziR1IuQ+Mc7hKigdf6u8x+iKcgjQX7G0JcLBSOMRRDsirtq2WvkW6tBebL9Ei1O1IRbLpHaxtDFSKJl4JjRZYQpgl+sNluvOyhVmieOKJJYB5902QHSshEOPOSQoH3ix2vTdkExvqUPE8inAyIhISfy0gxlktzuYviN0QOMYnEAu4rT0/WVChRu2T3bO54aQ90S//3jS30NlSix2MlmgtdwDyJ+NvRVvFNwcwU8S7J39WvXzDXXwqJqS00PNjPo1s3RCcJfzLoJ0QLaDeJ2wjvOEgJ6q7Tt6r6AS2wPN1HjTaNE2s4TpAl43I0E622IFTnBlUw4UmA81kgC8yoV7TNqocRsT34iW0H3P5ZhyJw4e5MkOYXoqDcsIWqa3UspVZQm7NttCb2RjmDzdEk1otYJkVMV4VvidU5kT5PpKHsvGU17emNWN/l/A5A+3GnJMvtzx0kQeufsr/SDBHp6ca1Rlw2/WW38TbnzB2GLZKg7ztnrCC+CEAPpmmIsL2kTMjOQTVKKudlhJvX6LKUPHOTNcwtzNQnBfkPt/l0R+5XFN2IBWB2vYjhVTbCW6+MQcE741A8aH0Gf9vnr0rHdp4bk9vrHmbAEy5xU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(10070799003)(7416014)(376014)(10067099003)(56012099006)(18002099003)(4143699003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ri90WHZSVVg0Y3VuS2R6bndnSWRnamRVRzZvNTR5ZGN4d3U4M3ZoamlMclll?=
 =?utf-8?B?Q1g0aURlSGtEdWk5ZnNtUlo0R3BvZExvVm9sMlBvTFd6eWMxdFFObHhzL3Rl?=
 =?utf-8?B?dkFMQUJOdDVrVll3SkRCMjVpdXJBTXVTZDZKWDhYR2pPWTRackRTdHpNNzdV?=
 =?utf-8?B?VnVzV2VOdDlaeUdEbTV0U0l1UWZCN3h1SkFVTzV4SUkwZHNnNkZXNkNJU3c5?=
 =?utf-8?B?Nms1a1JMVGdkWEpnYktMdjRZNU93QTdPNHNvazBxWVA5SlBUZFp2OGpwUGw0?=
 =?utf-8?B?eDhDRWJrZUtqaHg5dHhKRHBneFNxTXQvZ3AvOGVNVFRObHhldjUxa25jeDRO?=
 =?utf-8?B?UzZXS0d1NE0xNTZuRm1KVDFibEhvbE13eGw2VkZ0NDJqSWt4NkR2c1pwSERy?=
 =?utf-8?B?cEhCVDM5eHNYVm5hVGxwUVdPZkVCb2g5THRYR29ISUQzeG9pNGI4MnVXMmVR?=
 =?utf-8?B?WEs3THF5M1V1WkxaSTJYT0JXaG05L3dLMDc0WkozYnJxYlg3NmFNdTR1RS9U?=
 =?utf-8?B?NlpVUFo0R1BhRDFLRGtXQUxJaVlMeTU2NVpNN0pGWGRNbVRnalRiM3JHaW4v?=
 =?utf-8?B?RXNQTnVOd0tpd0JBdmdGWmVIdjF2SHBNeW5lYjd2aGhaVHh2SGM5UG83Y0Rm?=
 =?utf-8?B?czlYdjAvOWt3Ym41M2hhSXVUM0xSSWpoajMzNXpYNmk4NlBNS2VXM0h1Nkpi?=
 =?utf-8?B?Q0JrbHcrZWE5ZlhvSUoxa1p4ZVJudVV0ZTZJS3lBZDVvOUNuL0tpU3hXUFJn?=
 =?utf-8?B?YnRQSlJoZGIyVSs3ZWwxWnhvZ3hIamF1WVkvZDRiNXJJaFc0YzRObVpsNzlO?=
 =?utf-8?B?SkUyUXVFeENrMk81U1NidzNXdWFUQk82M0NsUXRQYjBVcjA4Qm1XcHFRRlNz?=
 =?utf-8?B?ODFPYnV3MWxiQ0RybkNlMmZSdUtJWVl1WHpBRlFCNUdrdFFVUkIyOUIxNlpr?=
 =?utf-8?B?ZDdNME1YTFpxaFpHdUxqRVFtS00wWklrMmx3d29GeUUzYWNiUGIyYTAzeFBn?=
 =?utf-8?B?UkxWYW5ES24wcktmMnZESVdYM0dROE82WTNKVkNlUVQ1RmpGeThWZ2dCTE0z?=
 =?utf-8?B?aVZsSVcwQUo1OS92V0syb1ZsZEhoNXQyUTJKYytsY29YZVJ5aUR6cDZ5VXdh?=
 =?utf-8?B?ODVhRnJZOHZzdjJGOXBSMldlZ0cvTU5TRmFFN3VYNWxFVFhNbm91a0VHYmNK?=
 =?utf-8?B?ZTBSMEgzcGpEWnJyZUtVMHJqL0dtbDNNWHM5QXBsM2Eyc3NyV0kyRnhjT2h2?=
 =?utf-8?B?ZnVWdklWdUhhVFhQTS91TVZOcEQyNndqZ21idTlwK3BuTk5RUStjeXlSRzA1?=
 =?utf-8?B?RFdOSXdhWmNHblY1djExblVtM1l6SjNJeU50Yy9GQ1V5UjE1d2RlSWdjTW4w?=
 =?utf-8?B?dzZkRjZxVHVKK0x1VFBDQlBVT0N0UUl1c3BENi9mQkR2cFhnMEJsUElEb3BT?=
 =?utf-8?B?cXRsL1ZYZWxweXpuSU9ZNSt3OW9La0RSZUF6OXBJZ3VsSWVybG1Ic2ZOeGRr?=
 =?utf-8?B?ZTF0NXp0c3J1OUQzQWNLR2hwTDd3cTIyNENpQXZsaldXYk1JZXc5aDdicEcz?=
 =?utf-8?B?cGQ3MUtYRlZ0NTlCT0pPWjFmSFBBN1Q4dDUyenJwTllpMG01Qjh1WjN4eHFn?=
 =?utf-8?B?djVIbmhwRllWSE1iRTV1dzFRVkVxYTUvNWNNWDIvMUc4WnFWQ0hhSEJTQitN?=
 =?utf-8?B?RHk3T1lpKzMyTnpKTUxYaXZ1WnZUSC9UMUdESExOaHJ1ZGJNREkwUmtvdDRP?=
 =?utf-8?B?YXRiZW9ZSExUV3JlWm9tL1hzSkRiV2VHRE9LZXBkekY0clBLYUdSUks1bFY5?=
 =?utf-8?B?di9IVDhEQklpaUplc1o1RmxucHhhUExSSU1GVkJuUzVuUlQvSHcwUUJxTG5F?=
 =?utf-8?B?ek1FeU8vUXBVeTg1S0ZQNWxGcnAxaGdBSlZtWG9RRUF0cm9mdU5oZW9TRUl1?=
 =?utf-8?B?T0FQeVdqb0J2M2drbVZ4enRIMCtHZDhmQWt3eGUvOFpnQnFxRVQvenc5N0Fj?=
 =?utf-8?B?NTdJOTdpVUtjNjQrSnJZN0FmR2g5UENlYkxGYXF0VlkyaU1nRjJvMjVLOXdK?=
 =?utf-8?B?RExDWnRlaVVQbG5ZSUo1Yk5hbWVzcEtuRHlCOHlzaSt4eE4rb2NjaFpPSm5G?=
 =?utf-8?B?SlRPZzkrcHZnUllSVlkyOVA3bEpsRU96eG4vYkNDclR2SEM4VVJkem5TQ2dj?=
 =?utf-8?B?UE1SZm1IM2dndjh5czZRMm5hR2hmQklwaWZSay9iMEhyS0l3eEE0Ym9aa1Fx?=
 =?utf-8?B?UnRPbWZJemFQTFBYOVJsT0Z0a3A0bUZZVXpWc25sRWxmMTNwakowcmJLT0Fx?=
 =?utf-8?B?anJNWi85bjA4YWlQSWt6aUt4SkJzMU5SRUNDWEFMV2VGZUZBRmFOZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb688f7-83ff-43ba-5e9d-08defe2d7c15
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 20:07:24.3099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tm4vSryVFN1p1QEeOFsA0uVjDeiOtG31rBD8U6JWhBiNCoMtx8ZiKjOWPL0PnSCVoxaSI/LrraeyMw61zQkEbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6951
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

On Mon Aug 17, 2026 at 8:04 AM BST, Eliot Courtney wrote:
> Currently, using NonZero constants is quite verbose. It's unfortunate
> because it disincentivizes using it in interface boundaries. Introduce a
> macro to make it nicer to use.
>
> Link: https://lore.kernel.org/DKO414SNC0B2.248FUBGJGSPLU@kernel.org
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  rust/kernel/num.rs | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
> index 8532b511384c..055d23ca7fd1 100644
> --- a/rust/kernel/num.rs
> +++ b/rust/kernel/num.rs
> @@ -7,6 +7,29 @@
>  pub mod bounded;
>  pub use bounded::*;
> =20
> +/// Infallibly creates a [`NonZero`] value from a constant expression.
> +///
> +/// [`NonZero`]: core::num::NonZero
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use core::num::NonZero;
> +/// use kernel::nz;
> +///
> +/// let v: NonZero<usize> =3D nz!(8);
> +/// assert_eq!(v.get(), 8);
> +///
> +/// const N: NonZero<u32> =3D nz!(0x10);
> +/// assert_eq!(N.get(), 0x10);
> +/// ```
> +#[macro_export]
> +macro_rules! nz {
> +    ($v:expr) =3D> {
> +        const { ::core::num::NonZero::new($v).unwrap() }
> +    };
> +}

I wonder if if we can have a generic macro for creating types from literals=
,
given that this is needed for bounded too. Something like

    trait FromLiteral {
        fn from_literal<const N: i64>() -> Self;
    }

    impl FromLiteral for NonZero<u32> {
        #[inline]
        fn from_literal<const N: i64>() -> Self {
            const_assert!(N > 0 && N < u32::MAX as i64);
            const { NonZero::new(N as u32).unwrap() }
        }
    }

    macro_rules! lit {
        ($x:expr) =3D> {
            FromLiteral::from_literal::<{$x}>()
        }
    }

    let nz: NonZero<u32> =3D lit!(1);
    let bounded: Bounded<..> =3D lit!(1);

I think the only downside is that this expression isn't const expr anymore.=
 We
can change this to be

    const trait FromLiteral {
        fn from_literal(v: i64) -> Self;
    }

when const trait impl is stable upstream and we have MSRV bumped high enoug=
h to
have an impl of it.

Best,
Gary

