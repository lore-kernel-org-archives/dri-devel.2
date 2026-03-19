Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B821088E78
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 05:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3372F10E0D2;
	Thu, 19 Mar 2026 05:35:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="FNXHk7vl";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F36C10E0D2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 05:35:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSrPiy4d5y4k6kViQELdK8X80wK2gsBKVJxLvmbB0/zQbthA2pHl/577ldmf6TEOM+S5bBCn1Qu2YrjI++hrxBWxSm5bSAi+MKhwcMPIQNAqRtcJdmEeVQMxaXVOApSgVUgNu3K8Dvl85bsNL+Y5Co75xU4q2S8Mmy2xZlM436aId6KjzjNUvMKyr/yM038arVTG2mxHUJXp2CUJP2qzEii9sR6xIQkCT0zawxOEvm6NgJqMKtlNq632Y3biVOdphd87LbFy7GG/1HPiNP3+cEDArsZllISZX8vMdl1Gu3XPhd9Eq4NeP9qWmSeytaIU/pPDgH7Wu3yOX0WxnBzNQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAFG2vUHWQUpQID35qA1QmQ4+FJy/6Khs4F946Nvpvk=;
 b=u4OgRldNM5U0sV5rRj4qafdWaTsN+kJIFq1mqzuGXKGLEI+GEaGu6IL9+k13XKPYHIGXvkadtvQyS76qG4uUlu8HxN6VjYrIoN8UpSKU65v97IcBme36RFIwcdqFVTmy8GDs8jsnU9+LZiOOfXZUBdmbL2B8YVeyFKOzWjTGp3kNeL6cDs7RXPHJHj28U+5XYRmnFKx8DbL5RjgWtgTWac/xLHwWOXlpjtb4Xeaf9CTmQbontVqg4Vc9mkWtOB0PRsINQG/ZlbcXzwW+1yhW4zwKWc4J7MqNpwXXkSK+cv2yPAJkBt6Y/XfRURzpdikO8t93ZpiNBNelKerJ0CZETg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAFG2vUHWQUpQID35qA1QmQ4+FJy/6Khs4F946Nvpvk=;
 b=FNXHk7vl/HkBFEEC6+aKkHIeZPsVmbIlWiT+r59Fbp5i3nSO3UctwHg+RTIVwGg1/v2SfiN4IVVqK6iaMXP/shOoKoSWfNdTkSUOYYQj3GtUbjiEoPy186bM+TGDMMULNr7z6ZxtphvMh9m/+RrjkfC9IIW25hkMeo7nm3/AlBdExaOTjeqH8BF9Tb8/6S1z6JItiVw1T3GSLAdjQtsEe6bAcWPu655Ue0PXWNoFqJgyEG5U8FugH8xoV8fAtVe/FtzYLITtYrlmQ6lPfdIMZ+Ww0WNNqhjzouBGmJPpXUy0sKPN3aNWmkwKlPbQ69B/Er4UlWyfGdVz/4UoXzWWJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 05:35:23 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Thu, 19 Mar 2026
 05:35:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 14:35:17 +0900
Message-Id: <DH6IJKX25H7H.28NWD4KJSXX73@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 7/8] gpu: nova-core: convert falcon registers to kernel
 register macro
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
 <20260318-b4-nova-register-v1-7-22a358aa4c63@nvidia.com>
In-Reply-To: <20260318-b4-nova-register-v1-7-22a358aa4c63@nvidia.com>
X-ClientProxiedBy: TY4P301CA0061.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::17) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 72602630-0745-41fc-f104-08de857950d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|1800799024|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: ZAqEgWEBKEthowJU9pCi7TE4NqkNndtUgVKs1CmFyHujWp68kfUdJuLvT7XOoQQruHfqOS1TDZZaUJO3BGYgJyUJFiHDo1CopqOBAQb5cZr74f6dcEqDu7631BcHJi017ElkHFBgqyjjOirE8R3PIDoK9o1heAkWAmPgazzHrhFsYj9xOA3+/4EWa2zByK7YyDlw2XnYOxA25RwiYuhWyWqjUHAKqSeyrsBqfjFIt/6nEzWdUjp36k+cj7/V0r2Wu/7dK6iTBa4/SQ3fUFVJxLi2naLwYLc/nU3KRu+dM+mnn3+ywoCL67PnEjV3YZ+rNx4TSL1J401mEuX0i43nqIf7nTrIOqowbiqPrX4pVe/3HTk3jl8RRKCsFDZRD9OD/CSNn6ninp0f/N+ig9FSenmEFsAOF7fia6wH3PwC1z6VEKtTUqGrgVekzRhana0e6N1Vpn3mMylyWY1RG7xbjwpQ1c8BgTt6EZq5f8d9opmNZBwoBvT0ZKWjVpBJH2wsCxbRbbQ2q0CbT4PF/mkNT+njxD+UbgopazlwIzpEosGjoQ4tfrjW8HgtwC1dpNF40GQFXdMDbOdOhwrnY/hp/WczGv082WKR+78eKKWP9AHo6DyAUPbvoCf3qGQIqYFT90/j7b2VF/pEIVroCBR0o3SI4kcXFca6uNGazSP+zIdJa4OUhLocOxI+qWo59xvpaNoOTkfKnnT2TNbFo3LUf+QHr7jCudWFeXE9B8liJJE/wCwJ7kPuXth0L983iQAVwvdfvbQzUMQcIGydwiZB8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVphTm81d055U1VKaEl2ODFtKzg1TWVGb09zc3J5dmNNemRNdEZPTWpFcTEx?=
 =?utf-8?B?eHBpTUQwbnFXK0tVY1IxUlUzNkdlRHAyeXBoc3E0ckpreThPK1QyajgzS2ZG?=
 =?utf-8?B?ZUkzOExXTWJITm5ieDJPbm03ZVI5dWZ6OGRSZ0RQR0V6NjJFWkM4U251eVFN?=
 =?utf-8?B?cG1XMVRzQk9YWjFvNVhnQXBxUnZkOTNpQkhzQXBKd2Q0T2VSTXErUkVTVVpC?=
 =?utf-8?B?MUwxbU5XWTI1dE52NVQ0MzVoQkdNZGg3dFdHZkowcjZtUFlxcUFjLzBZOEhl?=
 =?utf-8?B?cWFaUDJUNjluZkhTVzcxazhXVE8waEFnVEprQVU3aXY0RUZ4RkNvN2VNVDZp?=
 =?utf-8?B?eTMxMDJtMDF3NEx5T1VqT0w0cHA5UlEvSXZ2TDZ5TDJVLzZ2RFVqUld0T3Vl?=
 =?utf-8?B?Nm1wSjdRNmxsMGdxUjhYNHlSS1VlRFVML1l2VUdBTUx4cTFjOEhvdlpDd0pN?=
 =?utf-8?B?d0hFVXFOM0hJL3kyVU5Mem9pUFduMldnL1Qyekw2ajUzcjBmMFZqYnJQTm1G?=
 =?utf-8?B?WTkxVFNybmJNSG12T3poK3JxalBqbVhMK2NreHRicjQxbGx6TjNqRm9MUk0v?=
 =?utf-8?B?Y29TZ3BDSTdSZ1VnNEM1VG5UZnpuSHZBUDJVMVVmVHcvNG9KMjFMOUg2Y3U5?=
 =?utf-8?B?V2RiZXIwb0w2Uys5WmZoeU9sdGgwK2I1MkxKL2wwQUUycEd0MGdQczZ3MU5U?=
 =?utf-8?B?ZmhxakNSWUJZbHNGZjhVZ3FiUjlWT3cwcHprRWFpaUhya1FpZ3BueHdJWThx?=
 =?utf-8?B?SFVjL3pmRjRnOEIxWEQ5dWhHMXZZTTA3Y1JKUEczSXlpNGZHMVEvWkhqRkFv?=
 =?utf-8?B?YnRFTjdiZG5wVjZYVlJka1FEcVkvOFFGOVR1Rmp0ZW1oZmFkTkYycjRya05a?=
 =?utf-8?B?bSt4MlcyK1UvSlBxQStJYXZKaWVKYmxyRnBFNTB1bU81MUV5T201OXVLSU16?=
 =?utf-8?B?ZEhyNGJtdW92dWYwbFoxaEFQcloybVQ0MWVIcUp6bm9rK3R0V1Y0QWhhRjh3?=
 =?utf-8?B?ditObjRjS3hObnIvS3d0SjMySVlRMEhLYnJuTjMyNHFYZTdWK3JXQ1E5VGt4?=
 =?utf-8?B?Yi9sTkFHM25uZXVRQVgwcGdpTGhPZ0Q2SUdBeC9wcEluK2sxNmdVZkZ2WGg3?=
 =?utf-8?B?YjNlQTdqK3RTV0U0Zm5IRFdPWHNVN1ZDcHdqL2k1aTF0QmpqQlVMaHhCY2R6?=
 =?utf-8?B?NEFsQmhBR2N1RzMrakcyZ1RFUGZ5bTQxTnVwdVRLd05tWHF0SW1RdnlTU1p2?=
 =?utf-8?B?S21iMXRrak9mbmQyOStxY21DeU56UUVWZzEvL1FUWTF6YVNaYmRuSXA1YTl3?=
 =?utf-8?B?Z0ZIc3lIcW1aMUszVU9FaW1pRUM4aDRDUWRFU0w3WFF4SGxlcWdwNzlqcU93?=
 =?utf-8?B?SmpaSU1Bdlk1WlpBRFVuTXAvNFZHRXhIT1lZakQwT3I1NXVKcmZiSm5CNVFH?=
 =?utf-8?B?RGVHSjJXRmh1a3FZRWc2UmJFN0FUb3NjRlRaY0RMaXR3S1JzZlQwVU8xNHI1?=
 =?utf-8?B?WFVHUU02T2U2cno4UUdDWFQ0cm5vVlYxQS80TzVNdUJFRGFSRHdiUFlJM1kx?=
 =?utf-8?B?MWRITjJ0dkhOeHpWTExPL0JocmxDdVJ1S2hHMERQODR0TDZXK1R5SEpkcGNi?=
 =?utf-8?B?MnlscXhZNVlodmkvK09jQktFaS80bW44WmF4ejBIMHpsZFZndXlkWlJpclk3?=
 =?utf-8?B?b1pZUVFFdEM1U2ppK3Z1c3phUld5d0dzdkxyKzJHcTI5UWcwajZZTDBHVTdQ?=
 =?utf-8?B?a1IyNzYreTVCMEgrUWJFWDhHcWR6TTZ1ZTN5Lzd1ZCtuRm9rSGo2ZElmckph?=
 =?utf-8?B?c3lOcWRabjMzZlVOeGRrR243ZzlUK0lhQmhkQWtHVmZKMzdOLzN5RVFMQnhr?=
 =?utf-8?B?YVBSRVkvaDliWmZkK3hvVjJXOWpacnRBVElKdWxCR1B6QW1YWjl0aDQzeG9a?=
 =?utf-8?B?dmlRWll2aklvY2NENkRGNkxvcHNEZSsveVJKTEY1aW1IQ3RSc094aWRQVXhL?=
 =?utf-8?B?RnhXMjNpY01IMzIyZmNxVTVzWTVDdCtETWNVZWxZcytqVURibkxNOVI2aUpR?=
 =?utf-8?B?V2M2WFNJdmlFTFB3c1I4dUI5Q0VZa2g0a0FLVWROeVhaaXRjQjRGbStGNlpt?=
 =?utf-8?B?K2hBVCtlT0dBQUpQdEI5N3ZDY3RRVFUrKzVzNUM0d0VFVkxLR21qTHdkN2tR?=
 =?utf-8?B?Tnc3ZDdlTzc5QWlUVDFDdUJkVml1QjFIaVo0SGExelQ0MU1SNXNVdTdyc1NJ?=
 =?utf-8?B?Nzk0NW11QzlJNEZna2xFSi9uN3hicmtjWjJPcTFLeUlmVmRrZmhDZmo4TDZG?=
 =?utf-8?B?bjFwaDV4MVlrN3llNzFvZXJPbGw5QXJKSGhWWVJHTHExL1ZXUlFvNkQxV1Fk?=
 =?utf-8?Q?NWd3mKmn9EP04lIi7cQiLN7BYKDeXTHXzZ1qqcdvvT+mw?=
X-MS-Exchange-AntiSpam-MessageData-1: B87hMaq9D15fjw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72602630-0745-41fc-f104-08de857950d4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 05:35:22.8746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mmiOLqFT3xJULPbQkiD5zOtnf3mumk2G1oiR0Y7Ft+dVZal7+VptxQI29ggH4NGqsMYcv5+cqv4O4p/oAdCCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305
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

On Wed Mar 18, 2026 at 5:06 PM JST, Alexandre Courbot wrote:
> Convert all PFALCON, PFALCON2 and PRISCV registers to use the kernel's
> register macro and update the code accordingly.
>
> Because they rely on the same types to implement relative registers,
> they need to be updated in lockstep.
>
> nova-core's local register macro is now unused, so remove it.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/falcon.rs                    | 333 +++++-----
>  drivers/gpu/nova-core/falcon/gsp.rs                |  22 +-
>  drivers/gpu/nova-core/falcon/hal/ga102.rs          |  55 +-
>  drivers/gpu/nova-core/falcon/hal/tu102.rs          |  12 +-
>  drivers/gpu/nova-core/falcon/sec2.rs               |  17 +-
>  drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  19 +-
>  drivers/gpu/nova-core/regs.rs                      | 350 +++++-----
>  drivers/gpu/nova-core/regs/macros.rs               | 739 ---------------=
------
>  8 files changed, 421 insertions(+), 1126 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falc=
on.rs
> index 4721865f59d9..90afef40acd0 100644
> --- a/drivers/gpu/nova-core/falcon.rs
> +++ b/drivers/gpu/nova-core/falcon.rs
> @@ -14,9 +14,14 @@
>          DmaMask, //
>      },
>      io::{
> -        poll::read_poll_timeout, //
> +        poll::read_poll_timeout,
> +        register::{
> +            RegisterBase,
> +            WithBase, //
> +        },
>          Io,
>      },
> +    num::Bounded,
>      prelude::*,
>      sync::aref::ARef,
>      time::Delta,
> @@ -33,7 +38,6 @@
>          IntoSafeCast, //
>      },
>      regs,
> -    regs::macros::RegisterBase, //
>  };
> =20
>  pub(crate) mod gsp;
> @@ -44,11 +48,14 @@
>  pub(crate) const MEM_BLOCK_ALIGNMENT: usize =3D 256;
> =20
>  // TODO[FPRI]: Replace with `ToPrimitive`.
> -macro_rules! impl_from_enum_to_u8 {
> -    ($enum_type:ty) =3D> {
> -        impl From<$enum_type> for u8 {
> +macro_rules! impl_from_enum_to_bounded {
> +    ($enum_type:ty, $length:literal) =3D> {
> +        impl From<$enum_type> for Bounded<u32, $length> {
>              fn from(value: $enum_type) -> Self {
> -                value as u8
> +                // Shift the value left by the number of unused bits.
> +                let b =3D Bounded::<u32, 32>::from((value as u32) << (32=
 - $length));
> +                // Shift back right to create a `Bounded` of the expecte=
d width.
> +                b.shr::<{ 32 - $length }, $length>()
>              }
>          }
>      };

This can silently truncate stuff if we typo the wrong bounded size.
Any reason not to use `Bounded::from_expr(value as u32)` for this?

> diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.r=
s
> index 4ac4e9126db8..08d9a9697adc 100644
> --- a/drivers/gpu/nova-core/regs.rs
> +++ b/drivers/gpu/nova-core/regs.rs
> @@ -1,13 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
> =20
> -// Required to retain the original register names used by OpenRM, which =
are all capital snake case
> -// but are mapped to types.
> -#![allow(non_camel_case_types)]
> -
> -#[macro_use]
> -pub(crate) mod macros;
> -
>  use kernel::{
> +    io::{
> +        register::WithBase,
> +        Io, //
> +    },
>      prelude::*,
>      time, //
>  };
> @@ -314,60 +311,147 @@ pub(crate) fn vga_workspace_addr(self) -> Option<u=
64> {
> =20
>  // PFALCON
> =20
> -register!(NV_PFALCON_FALCON_IRQSCLR @ PFalconBase[0x00000004] {
> -    4:4     halt as bool;
> -    6:6     swgen0 as bool;
> -});
> +nv_reg! {
> +    NV_PFALCON_FALCON_IRQSCLR @ PFalconBase + 0x00000004 {
> +        4:4     halt =3D> bool;
> +        6:6     swgen0 =3D> bool;
> +    }
> =20
> -register!(NV_PFALCON_FALCON_MAILBOX0 @ PFalconBase[0x00000040] {
> -    31:0    value as u32;
> -});
> +    NV_PFALCON_FALCON_MAILBOX0 @ PFalconBase + 0x00000040 {
> +        31:0    value =3D> u32;
> +    }
> =20
> -register!(NV_PFALCON_FALCON_MAILBOX1 @ PFalconBase[0x00000044] {
> -    31:0    value as u32;
> -});
> +    NV_PFALCON_FALCON_MAILBOX1 @ PFalconBase + 0x00000044 {
> +        31:0    value =3D> u32;
> +    }
> =20
> -// Used to store version information about the firmware running
> -// on the Falcon processor.
> -register!(NV_PFALCON_FALCON_OS @ PFalconBase[0x00000080] {
> -    31:0    value as u32;
> -});
> +    /// Used to store version information about the firmware running
> +    /// on the Falcon processor.
> +    NV_PFALCON_FALCON_OS @ PFalconBase + 0x00000080 {
> +        31:0    value =3D> u32;
> +    }
> =20
> -register!(NV_PFALCON_FALCON_RM @ PFalconBase[0x00000084] {
> -    31:0    value as u32;
> -});
> +    NV_PFALCON_FALCON_RM @ PFalconBase + 0x00000084 {
> +        31:0    value =3D> u32;
> +    }
> =20
> -register!(NV_PFALCON_FALCON_HWCFG2 @ PFalconBase[0x000000f4] {
> -    10:10   riscv as bool;
> -    12:12   mem_scrubbing as bool, "Set to 0 after memory scrubbing is c=
ompleted";
> -    31:31   reset_ready as bool, "Signal indicating that reset is comple=
ted (GA102+)";
> -});
> +    NV_PFALCON_FALCON_HWCFG2 @ PFalconBase + 0x000000f4 {
> +        10:10   riscv =3D> bool;
> +        /// Set to 0 after memory scrubbing is completed.
> +        12:12   mem_scrubbing =3D> bool;
> +        /// Signal indicating that reset is completed (GA102+).
> +        31:31   reset_ready =3D> bool;
> +    }
> =20
> -impl NV_PFALCON_FALCON_HWCFG2 {
> -    /// Returns `true` if memory scrubbing is completed.
> -    pub(crate) fn mem_scrubbing_done(self) -> bool {
> -        !self.mem_scrubbing()
> +    NV_PFALCON_FALCON_CPUCTL @ PFalconBase + 0x00000100 {
> +        1:1     startcpu =3D> bool;
> +        4:4     halted =3D> bool;
> +        6:6     alias_en =3D> bool;
> +    }
> +
> +    NV_PFALCON_FALCON_BOOTVEC @ PFalconBase + 0x00000104 {
> +        31:0    value =3D> u32;
> +    }
> +
> +    NV_PFALCON_FALCON_DMACTL @ PFalconBase + 0x0000010c {
> +        0:0     require_ctx =3D> bool;
> +        1:1     dmem_scrubbing =3D> bool;
> +        2:2     imem_scrubbing =3D> bool;
> +        6:3     dmaq_num;
> +        7:7     secure_stat =3D> bool;
> +    }
> +
> +    NV_PFALCON_FALCON_DMATRFBASE @ PFalconBase + 0x00000110 {
> +        31:0    base =3D> u32;
> +    }
> +
> +    NV_PFALCON_FALCON_DMATRFMOFFS @ PFalconBase + 0x00000114 {
> +        23:0    offs;
> +    }
> +
> +    NV_PFALCON_FALCON_DMATRFCMD @ PFalconBase + 0x00000118 {
> +        0:0     full =3D> bool;
> +        1:1     idle =3D> bool;
> +        3:2     sec;
> +        4:4     imem =3D> bool;
> +        5:5     is_write =3D> bool;
> +        10:8    size ?=3D> DmaTrfCmdSize;
> +        14:12   ctxdma;
> +        16:16   set_dmtag;
> +    }
> +
> +    NV_PFALCON_FALCON_DMATRFFBOFFS @ PFalconBase + 0x0000011c {
> +        31:0    offs =3D> u32;
> +    }
> +
> +    NV_PFALCON_FALCON_DMATRFBASE1 @ PFalconBase + 0x00000128 {
> +        8:0     base;
> +    }
> +
> +    NV_PFALCON_FALCON_HWCFG1 @ PFalconBase + 0x0000012c {
> +        /// Core revision.
> +        3:0     core_rev ?=3D> FalconCoreRev;
> +        /// Security model.
> +        5:4     security_model ?=3D> FalconSecurityModel;
> +        /// Core revision subversion.
> +        7:6     core_rev_subversion =3D> FalconCoreRevSubversion;
> +    }
> +
> +    NV_PFALCON_FALCON_CPUCTL_ALIAS @ PFalconBase + 0x00000130 {
> +        1:1     startcpu =3D> bool;
> +    }
> +
> +    /// IMEM access control register. Up to 4 ports are available for IM=
EM access.
> +    NV_PFALCON_FALCON_IMEMC[4, stride =3D 16] @ PFalconBase + 0x00000180=
 {
> +        /// IMEM block and word offset.
> +        15:0      offs;
> +        /// Auto-increment on write.
> +        24:24     aincw =3D> bool;
> +        /// Access secure IMEM.
> +        28:28     secure =3D> bool;
> +    }
> +
> +    /// IMEM data register. Reading/writing this register accesses IMEM =
at the address
> +    /// specified by the corresponding IMEMC register.
> +    NV_PFALCON_FALCON_IMEMD[4, stride =3D 16] @ PFalconBase + 0x00000184=
 {
> +        31:0      data;
> +    }
> +
> +    /// IMEM tag register. Used to set the tag for the current IMEM bloc=
k.
> +    NV_PFALCON_FALCON_IMEMT[4, stride =3D 16] @ PFalconBase + 0x00000188=
 {
> +        15:0      tag;
> +    }
> +
> +    /// DMEM access control register. Up to 8 ports are available for DM=
EM access.
> +    NV_PFALCON_FALCON_DMEMC[8, stride =3D 8] @ PFalconBase + 0x000001c0 =
{
> +        /// DMEM block and word offset.
> +        15:0      offs;
> +        /// Auto-increment on write.
> +        24:24     aincw =3D> bool;
> +    }
> +
> +    /// DMEM data register. Reading/writing this register accesses DMEM =
at the address
> +    /// specified by the corresponding DMEMC register.
> +    NV_PFALCON_FALCON_DMEMD[8, stride =3D 8] @ PFalconBase + 0x000001c4 =
{
> +        31:0      data;
> +    }
> +
> +    /// Actually known as `NV_PSEC_FALCON_ENGINE` and `NV_PGSP_FALCON_EN=
GINE` depending on the
> +    /// falcon instance.
> +    NV_PFALCON_FALCON_ENGINE @ PFalconBase + 0x000003c0 {
> +        0:0     reset =3D> bool;
> +    }
> +
> +    NV_PFALCON_FBIF_TRANSCFG[8] @ PFalconBase + 0x00000600 {
> +        1:0     target ?=3D> FalconFbifTarget;
> +        2:2     mem_type =3D> FalconFbifMemType;
> +    }
> +
> +    NV_PFALCON_FBIF_CTL @ PFalconBase + 0x00000624 {
> +        7:7     allow_phys_no_ctx =3D> bool;
>      }
>  }
> =20
> -register!(NV_PFALCON_FALCON_CPUCTL @ PFalconBase[0x00000100] {
> -    1:1     startcpu as bool;
> -    4:4     halted as bool;
> -    6:6     alias_en as bool;
> -});
> -
> -register!(NV_PFALCON_FALCON_BOOTVEC @ PFalconBase[0x00000104] {
> -    31:0    value as u32;
> -});
> -
> -register!(NV_PFALCON_FALCON_DMACTL @ PFalconBase[0x0000010c] {
> -    0:0     require_ctx as bool;
> -    1:1     dmem_scrubbing as bool;
> -    2:2     imem_scrubbing as bool;
> -    6:3     dmaq_num as u8;
> -    7:7     secure_stat as bool;
> -});
> -
>  impl NV_PFALCON_FALCON_DMACTL {
>      /// Returns `true` if memory scrubbing is completed.
>      pub(crate) fn mem_scrubbing_done(self) -> bool {
> @@ -375,147 +459,81 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
>      }
>  }
> =20
> -register!(NV_PFALCON_FALCON_DMATRFBASE @ PFalconBase[0x00000110] {
> -    31:0    base as u32;
> -});
> -
> -register!(NV_PFALCON_FALCON_DMATRFMOFFS @ PFalconBase[0x00000114] {
> -    23:0    offs as u32;
> -});
> -
> -register!(NV_PFALCON_FALCON_DMATRFCMD @ PFalconBase[0x00000118] {
> -    0:0     full as bool;
> -    1:1     idle as bool;
> -    3:2     sec as u8;
> -    4:4     imem as bool;
> -    5:5     is_write as bool;
> -    10:8    size as u8 ?=3D> DmaTrfCmdSize;
> -    14:12   ctxdma as u8;
> -    16:16   set_dmtag as u8;
> -});
> -
>  impl NV_PFALCON_FALCON_DMATRFCMD {
>      /// Programs the `imem` and `sec` fields for the given FalconMem
>      pub(crate) fn with_falcon_mem(self, mem: FalconMem) -> Self {
> -        self.set_imem(mem !=3D FalconMem::Dmem)
> -            .set_sec(if mem =3D=3D FalconMem::ImemSecure { 1 } else { 0 =
})
> +        let this =3D self.with_imem(mem !=3D FalconMem::Dmem);
> +
> +        match mem {
> +            FalconMem::ImemSecure =3D> this.with_const_sec::<1>(),
> +            _ =3D> this.with_const_sec::<0>(),
> +        }
>      }
>  }
> =20
> -register!(NV_PFALCON_FALCON_DMATRFFBOFFS @ PFalconBase[0x0000011c] {
> -    31:0    offs as u32;
> -});
> -
> -register!(NV_PFALCON_FALCON_DMATRFBASE1 @ PFalconBase[0x00000128] {
> -    8:0     base as u16;
> -});
> -
> -register!(NV_PFALCON_FALCON_HWCFG1 @ PFalconBase[0x0000012c] {
> -    3:0     core_rev as u8 ?=3D> FalconCoreRev, "Core revision";
> -    5:4     security_model as u8 ?=3D> FalconSecurityModel, "Security mo=
del";
> -    7:6     core_rev_subversion as u8 ?=3D> FalconCoreRevSubversion, "Co=
re revision subversion";
> -});
> -
> -register!(NV_PFALCON_FALCON_CPUCTL_ALIAS @ PFalconBase[0x00000130] {
> -    1:1     startcpu as bool;
> -});
> -
> -// IMEM access control register. Up to 4 ports are available for IMEM ac=
cess.
> -register!(NV_PFALCON_FALCON_IMEMC @ PFalconBase[0x00000180[4; 16]] {
> -    15:0      offs as u16, "IMEM block and word offset";
> -    24:24     aincw as bool, "Auto-increment on write";
> -    28:28     secure as bool, "Access secure IMEM";
> -});
> -
> -// IMEM data register. Reading/writing this register accesses IMEM at th=
e address
> -// specified by the corresponding IMEMC register.
> -register!(NV_PFALCON_FALCON_IMEMD @ PFalconBase[0x00000184[4; 16]] {
> -    31:0      data as u32;
> -});
> -
> -// IMEM tag register. Used to set the tag for the current IMEM block.
> -register!(NV_PFALCON_FALCON_IMEMT @ PFalconBase[0x00000188[4; 16]] {
> -    15:0      tag as u16;
> -});
> -
> -// DMEM access control register. Up to 8 ports are available for DMEM ac=
cess.
> -register!(NV_PFALCON_FALCON_DMEMC @ PFalconBase[0x000001c0[8; 8]] {
> -    15:0      offs as u16, "DMEM block and word offset";
> -    24:24     aincw as bool, "Auto-increment on write";
> -});
> -
> -// DMEM data register. Reading/writing this register accesses DMEM at th=
e address
> -// specified by the corresponding DMEMC register.
> -register!(NV_PFALCON_FALCON_DMEMD @ PFalconBase[0x000001c4[8; 8]] {
> -    31:0      data as u32;
> -});
> -
> -// Actually known as `NV_PSEC_FALCON_ENGINE` and `NV_PGSP_FALCON_ENGINE`=
 depending on the falcon
> -// instance.
> -register!(NV_PFALCON_FALCON_ENGINE @ PFalconBase[0x000003c0] {
> -    0:0     reset as bool;
> -});
> -
>  impl NV_PFALCON_FALCON_ENGINE {
>      /// Resets the falcon
>      pub(crate) fn reset_engine<E: FalconEngine>(bar: &Bar0) {
> -        Self::read(bar, &E::ID).set_reset(true).write(bar, &E::ID);
> +        bar.update(Self::of::<E>(), |r| r.with_reset(true));
> =20
>          // TIMEOUT: falcon engine should not take more than 10us to rese=
t.
>          time::delay::fsleep(time::Delta::from_micros(10));
> =20
> -        Self::read(bar, &E::ID).set_reset(false).write(bar, &E::ID);
> +        bar.update(Self::of::<E>(), |r| r.with_reset(false));
>      }
>  }
> =20
> -register!(NV_PFALCON_FBIF_TRANSCFG @ PFalconBase[0x00000600[8]] {
> -    1:0     target as u8 ?=3D> FalconFbifTarget;
> -    2:2     mem_type as bool =3D> FalconFbifMemType;
> -});
> -
> -register!(NV_PFALCON_FBIF_CTL @ PFalconBase[0x00000624] {
> -    7:7     allow_phys_no_ctx as bool;
> -});
> +impl NV_PFALCON_FALCON_HWCFG2 {
> +    /// Returns `true` if memory scrubbing is completed.
> +    pub(crate) fn mem_scrubbing_done(self) -> bool {
> +        !self.mem_scrubbing()
> +    }
> +}
> =20
>  /* PFALCON2 */
> =20
> -register!(NV_PFALCON2_FALCON_MOD_SEL @ PFalcon2Base[0x00000180] {
> -    7:0     algo as u8 ?=3D> FalconModSelAlgo;
> -});
> +nv_reg! {
> +    NV_PFALCON2_FALCON_MOD_SEL @ PFalcon2Base + 0x00000180 {
> +        7:0     algo ?=3D> FalconModSelAlgo;
> +    }
> =20
> -register!(NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID @ PFalcon2Base[0x0000019=
8] {
> -    7:0    ucode_id as u8;
> -});
> +    NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID @ PFalcon2Base + 0x00000198 {
> +        7:0    ucode_id =3D> u8;
> +    }
> =20
> -register!(NV_PFALCON2_FALCON_BROM_ENGIDMASK @ PFalcon2Base[0x0000019c] {
> -    31:0    value as u32;
> -});
> +    NV_PFALCON2_FALCON_BROM_ENGIDMASK @ PFalcon2Base + 0x0000019c {
> +        31:0    value =3D> u32;
> +    }
> =20
> -// OpenRM defines this as a register array, but doesn't specify its size=
 and only uses its first
> -// element. Be conservative until we know the actual size or need to use=
 more registers.
> -register!(NV_PFALCON2_FALCON_BROM_PARAADDR @ PFalcon2Base[0x00000210[1]]=
 {
> -    31:0    value as u32;
> -});
> +    /// OpenRM defines this as a register array, but doesn't specify its=
 size and only uses its
> +    /// first element. Be conservative until we know the actual size or =
need to use more registers.
> +    NV_PFALCON2_FALCON_BROM_PARAADDR[1] @ PFalcon2Base + 0x00000210 {
> +        31:0    value =3D> u32;
> +    }
> +}
> =20
>  // PRISCV
> =20
> -// RISC-V status register for debug (Turing and GA100 only).
> -// Reflects current RISC-V core status.
> -register!(NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS @ PFalcon2Base[0x0000=
0240] {
> -    0:0     active_stat as bool, "RISC-V core active/inactive status";
> -});
> -
>  // GA102 and later
> -register!(NV_PRISCV_RISCV_CPUCTL @ PFalcon2Base[0x00000388] {
> -    0:0     halted as bool;
> -    7:7     active_stat as bool;
> -});
> +nv_reg! {
> +    /// RISC-V status register for debug (Turing and GA100 only).
> +    /// Reflects current RISC-V core status.
> +    NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS @ PFalcon2Base + 0x00000240=
 {
> +        /// RISC-V core active/inactive status.
> +        0:0     active_stat =3D> bool;
> +    }

The above comment says "GA102 and later" but right after it has
"Turing and GA100 only" which seems incongruous.

