Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D44F10854D1
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 03:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 809FF10E6CC;
	Wed, 18 Mar 2026 03:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="etQovtqY";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7392A10E6CC
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 03:14:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRWe0MUpSF/gRJWDDXhT+V/4WgwWQpAyEnk/yFJqWDD4IdgOFmebXj4QppIrfvyJHo7r3tq3nyIf1AznxhFN+f0cy7blcULmySaJBKy7tfjvAFFeuZozCnoYRQhRHi32/N9MmGgvsW3FpipTYcvA4bw9LZWAcvGoEEQT0fIZ/ASyXzEd5yrKbqC7IYo0dq2wBGd4jVilKvM+9nCf8PZ5/eBPe+d+29kOavNljTYXY5OuSAION2kiwdXvVJyN7mhsD5r8Y6dNGMH6y+WdBpJqH96+dufiqqwOf+HjmfsKNZKCIvx5o752jma//MuQ5ZMyNj9QkvC2v9IYyA0DcLp0qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjp5c9WDGq3H7Q08Bp7lHR+1HUhkFZ/fDyzhTpc7MBI=;
 b=RM4R1JSKPUvkKfjLM2mC2FJYLI1anGnSPaR4H9fMsjWG4DGLJOdcT33VOwtCEG470pZrrPUsM/5tKqA45fxkcXS1/y+GIgwXWT3C6GnOPiIg3GQaz/r7d78OsGfmLwMmOKmcRZZm6zFUDuOB0YftUkAx7OPeUqdCCIEvpFErS8k9T8ob/LcWst3ZXmmWJzymn5ByTwbKhNDfjcrxuW16ux7m+QG4Ue8FO1J2kqnPxNjZbcZA5shSJigBlzyXpia/yzaweHeGe7rIZwLrHtQOmPQBdYGdRyXC+I460yHyhjs+oARtAYD+VjA85Gdli7otAyM5ZpdrByUDTtyxkAwB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjp5c9WDGq3H7Q08Bp7lHR+1HUhkFZ/fDyzhTpc7MBI=;
 b=etQovtqY2I7zmh9m97MSYP5pLaBcKGKiaVvltrcyBz422qT99G6eDmSsyJQs+2uFkecM8zS0BbYkU6S0ooY6wPIHU8FXqbx+dOckbjZ+jCAf8HRUgzLUyCTQF1vAB4z/R1K1BYwEbclT+5t1KK7YF8R3/msnafHDP1btC2I7a4S4XUuLgffnZVMCISGx1LZg5do7e8FA4V0NZrgqSQBrrlOpgHdaAHenaeunUE9jBn9dkIuXUz3IgZaPfwi/xvzOdoe4N9H/43KwX2qeB6+vK10t6Nxueng9dEh85aBWC+b9nIPrW1PJd/q0TtRwhjouiC2N5kMZmQm0LysYtTG6yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB8521.namprd12.prod.outlook.com (2603:10b6:8:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Wed, 18 Mar
 2026 03:14:31 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 03:14:31 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 12:14:26 +0900
Message-Id: <DH5KX6V4OK45.3LFJYY71RLOV0@nvidia.com>
Cc: <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Steven Price" <steven.price@arm.com>, "Boris
 Brezillon" <boris.brezillon@collabora.com>, "Dirk Behme"
 <dirk.behme@gmail.com>, "Boqun Feng" <boqun@kernel.org>
Subject: Re: [PATCH v2 1/5] drm/tyr: Use register! macro for GPU_CONTROL
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
Content-Transfer-Encoding: quoted-printable
References: <20260311-b4-tyr-use-register-macro-v2-v2-0-b936d9eb8f51@collabora.com>
 <20260311-b4-tyr-use-register-macro-v2-v2-1-b936d9eb8f51@collabora.com>
In-Reply-To: <20260311-b4-tyr-use-register-macro-v2-v2-1-b936d9eb8f51@collabora.com>
X-ClientProxiedBy: TY4P301CA0096.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::19) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: b2918d42-9085-460a-d422-08de849c7873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|10070799003|1800799024|7053199007|22082099003|18002099003|18092099006|56012099003;
X-Microsoft-Antispam-Message-Info: AixQa4GE6qRo61E0fq0F2JLTWXPQ6VvD0iNJZsrC46OOA+fYe9o30ehgRD3OUtqmSOM9MMJGVIwtNLyN2PBZx5uUZnj7qmcWf597rCyQK3kkouEdeCJhY+a9/yfJBihkvHtV9wb4itue45d/WeUwpqyDSM6vd4o2aXwfG5a3f8prJMoVku7vOCyhgiOYy+op/+ttceRTNGNFhEJH/GWlAlMUpNYAGE+F+0qCmxad2GTDSrEwvwSWc2jGzH7tzxWldw8JN6Fc7zDm4NbnNaHlZG3beBv8ip9/mBLRjygGssusNLL+A4iR3Su0HiAleSV8Fujxohveqik1Icp51hI6ZXpUYoKNIC7QtvqHvu1Kgqyfd2jJRh6aqMXNVl+63I2NvN7zlDFQGkJIuRGx3UTn+fm9onT+Ai/hGfTg9s80N6QMA2l8Q+H7bEZBWdWfcSeoLPHhdAEEUKneB/zFjFIBBTO3H/hSCr2MKpsgovlK94+OiQWae00UBPeXL6Ug0TV1Ba2qKZK2aDXQXWW4nf/t/zaaor5rw1zyIsK3Fil8QBhQgoOjCgAzYC34mm9R2ICbsW3CsqBVUbLX48eZsCsdzzmHuhOHBkDtidHNnyr9T8Ih4KpRf+Y1cNlQaxBJf9UFdvJrAtFRG3pF8lVMAOtiIig3MpZ2XHEvLmrbuPItB2f0qvwuT6nVzM7S3cjrbHTsAtMUdGNSlcR82ZI+3QZqYqklnaL50A7lLhRqzKLn2WU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(7053199007)(22082099003)(18002099003)(18092099006)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFR4dmtQU0Fkc1ZiaGZ3UDV6UTRzNHlhYURNY0pralVZK2VtQWI5aGtDZGlj?=
 =?utf-8?B?YVBkVFkyQW40Ni9sOTZBRklueDdhRWpKaG04NktEZ2oyak9UcllvR3JGaDR5?=
 =?utf-8?B?d1NJWW1CaFZldkpOU0hMdDVVME54UWFRRnBRTFIvVURGTGJ5T0NhWXVKVDh4?=
 =?utf-8?B?ZjVPSk4xOXRpRHBnWE96bFlKd3luQnBXaVhUbkRRVkpRMlpUV0xYZG13Z0s4?=
 =?utf-8?B?ZzZkaEk0TG83clA0SmIzTEFDVzBCS01VQnIvMTJKSURiTTBNWHhMZlE5M0VS?=
 =?utf-8?B?eVcyRnQ2Ukp5RVZkNXRzd21SbEFuNmhPU29hWUNyZThHRkFSZmMxeDB2dzY4?=
 =?utf-8?B?VzA2NEJrdnZrSzNyVEkwZTZidlZyM3VsWEx4U2ZyYStOT1M4TFNIRWpHWWNY?=
 =?utf-8?B?VTBsZUl4WjFKT1pQNWRCbWNnR2NPS1JZK2EwZXZUMk5LQUNIMmU0WG45KzdN?=
 =?utf-8?B?RmhxUGVOb29WS2lLM21zRXhQcnpUeElIc1VmeGRlaXRhR1UrTVczcit5OGZM?=
 =?utf-8?B?ckEwVHMxYVJSY3RXdGJFL0RheXgveWsvZmh4QnVKSWZrdzc5Snc2Tk1BMzVp?=
 =?utf-8?B?aEliZUxRSWRzNHh5N1I2UDVmRW5HOUhxR3htQnpYU3RnRVQ2dmpmSHBwNlFZ?=
 =?utf-8?B?OVRERDljenRKUzF5cGZYU25ZQUFVQm5GWHFKRVJTamZqTWNkcjIzbDJyL2N6?=
 =?utf-8?B?RHRJZ1FsbGEyYld1enNscmk3VExRR1hiRjRseDljSzl4Y2hnTHhxdWsrbzJ0?=
 =?utf-8?B?SVNJRkZoRmdyRUZuUEdZSUhLWEtsMjdVRytUZXRlMXd0TjdrbjRaNldHUVZo?=
 =?utf-8?B?d3ZKV0VMajF6OXFRMS9SRXp4NDIxeWtRck9DMC9EZVM2bXBrakZtNW9MRXhi?=
 =?utf-8?B?YVJLNVNqYk10eGVRemxkZHRIMExSU1lxYkZYYUV6bS9semZJS3F1MGFjcDJj?=
 =?utf-8?B?YitZZm9NTHp1bWN2OW9NUHBTZ2E3R3FIMTluU2ROamJGN3BDVGxlUFBKbTZ2?=
 =?utf-8?B?WjRURHZGS3d5RERrYTQ4OUxjSDFOV3pEYkhKT2lOcjZUaWJSazE0Y3I5Tlcy?=
 =?utf-8?B?dG1PSFFuMnJqUEUyZ3dEQVhUY3VCUEdmVE9ETXFuS2hWSjhIY25CbWJtS1ZC?=
 =?utf-8?B?TjJHU1FyL0U1U1pwVHZxWmgyblRNQVQ2cXBwaHNXUWljeFRMT0tjZXArZmZt?=
 =?utf-8?B?WElXRWEzNitVbmdWYjJML2FXKzkxdmxiYllSR1FCRFdFZS9GNWlsbFdXWFp1?=
 =?utf-8?B?eHJQVHZVbXhmUzRtU1Zqdm15TlZkd01GOEhXN1N4WUVmVW5uNklKbk51LzFl?=
 =?utf-8?B?b0t0ZEJ4bi9MaXIyaWVhNWpUcFZqUlNZY0pQalZXMVp1QzdhQ0NxY3ByL0Ex?=
 =?utf-8?B?ZFV4cXJjOE1Hai9CS2dqTG5TQjdQc2M5d1NXV1ZUNHhUSnllZGxpaHA3MzJJ?=
 =?utf-8?B?THlGUWgwTVF0WEtWUUhZWnVSOWV1K0Q1UnVJSDFIRmJwOVBrQ1krRjhjdE5K?=
 =?utf-8?B?TmVVNXVRTGY4WVB3c1JRd0RiQ0pjdkFwQ055cjcwSlRiY1RjaFpaNGxESzJw?=
 =?utf-8?B?bjV6bjIxc2tsUXJKZGJVai8xbjVQcWkrbXVuN2M3T1ZXTVpoVmRoSWtGTnVs?=
 =?utf-8?B?NjdEUG5iU25WUEVlRnRrak9DcGM1QzVKNmhyZ0dEY0NGejJ6elI5ZFJ5QWFk?=
 =?utf-8?B?aHpVWkExRlB0UGF4ZFFPV3dqUnI3RW5hcjJIem5oTTE5NkpUS21yQ0NVN3pF?=
 =?utf-8?B?NWh4OFZBRVhhRkNjU3ptc2NEZExnQXpvOVZPNTlWdWFwWUNvdkdLWkdEeU9F?=
 =?utf-8?B?aVV5MDB4aFY0eUdpcFR6K1l0VXZBeFhYSlJSRW1CYUNCOWcyVzFOa2F1akhW?=
 =?utf-8?B?T1ErbTFKRHRyb1BXZGN4dStxMjFLQnhWRzZ6YUhobTZTQ3k3Y1g3WUZSdjU0?=
 =?utf-8?B?ekRub0tIcmtlTi8vOEJPalZjbVQwMUJESUx4aTVIUHpBeHJtYnJxK1FXNjB5?=
 =?utf-8?B?MmVCT1R2c2QwUVRGc0U0RWZUbnpJajV4eG5hL3FndVRsTGFtU2kwK1hzZUl0?=
 =?utf-8?B?cUZaOWo0SnNCSnROazE0NWd0LyszL2o4YkhTazlicWpSbzVkVG1rcGFSVzZQ?=
 =?utf-8?B?SzB1TG9kZUZsNDEvQnNGaGlRVzFwYmFZcEk0WFJjYTQ2ZGVPR2U2N241K20x?=
 =?utf-8?B?MUtmSlo3Nzc4bXRmWnA5ZzVaWXN3NkdiZVhXRm9nZGQ5YWdWOERtRVk2TXBD?=
 =?utf-8?B?eWhPOFJYMVlDbWlwL0pNYVorczRlUEtQQmxWQnp4N2tXVmJoazBBZVIzMFk3?=
 =?utf-8?B?ZWlReVM5Yk9WaWVHTFdxN09YdVcvdjh1M3lMYjQvbFJPbGQyQzRXSEN0d0hD?=
 =?utf-8?Q?RkMB3oOqMRePYZ2jXVUOGY8iQ48szW7kiA4N2Pq6Amgah?=
X-MS-Exchange-AntiSpam-MessageData-1: phj/tLAj9QbEQA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2918d42-9085-460a-d422-08de849c7873
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 03:14:31.2685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6enD1yDJ2t2qXHmwa9nQzDUEuFnRwVZ/FibmhRvWxJr9Zo4YwBGnRt2v8x+3khCgwT8EdkYPaYkUxx4E+8ZCug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8521
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

On Thu Mar 12, 2026 at 8:03 AM JST, Deborah Brouwer wrote:
> From: Daniel Almeida <daniel.almeida@collabora.com>
>
> Convert the GPU_CONTROL register definitions to use the `register!` macro=
.
>
> Using the `register!` macro allows us to replace manual bit masks and
> shifts with typed register and field accessors, which makes the code
> easier to read and avoids errors from bit manipulation.
>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
>  drivers/gpu/drm/tyr/driver.rs |  26 +-
>  drivers/gpu/drm/tyr/gpu.rs    | 211 ++++++--------
>  drivers/gpu/drm/tyr/regs.rs   | 644 ++++++++++++++++++++++++++++++++++++=
++----
>  3 files changed, 687 insertions(+), 194 deletions(-)
>
> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.r=
s
> index 611434641580574ec6b5afa49a8fe79888bb7ace..10c212a3a01910858f02c6d63=
7edff8a263f017b 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -13,7 +13,10 @@
>      devres::Devres,
>      drm,
>      drm::ioctl,
> -    io::poll,
> +    io::{
> +        poll,
> +        Io, //
> +    },
>      new_mutex,
>      of,
>      platform,
> @@ -33,8 +36,11 @@
>      file::TyrDrmFileData,
>      gem::TyrObject,
>      gpu,
> -    gpu::GpuInfo,
> -    regs, //
> +    gpu::{
> +        gpu_info_log, //
> +        GpuInfo,
> +    },
> +    regs::*, //
>  };
> =20
>  pub(crate) type IoMem =3D kernel::io::mem::IoMem<SZ_2M>;
> @@ -78,11 +84,17 @@ unsafe impl Send for TyrDrmDeviceData {}
>  unsafe impl Sync for TyrDrmDeviceData {}
> =20
>  fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Resul=
t {
> -    regs::GPU_CMD.write(dev, iomem, regs::GPU_CMD_SOFT_RESET)?;
> +    let io =3D (*iomem).access(dev)?;
> +    io.write_val(
> +        GPU_COMMAND_RESET::zeroed().with_const_reset_mode::<{ GPU_COMMAN=
D_RESET::SOFT_RESET }>(),
> +    );

My biggest piece of feedback for this patchset: replace the const values
with enums and use the `?=3D>` (or `=3D>` where possible) syntax to directl=
y
convert your fields from and into them. It associates each field with
its possible set of values and guarantees you won't use a given constant
with the wrong field (and also that you cannot set invalid field values
at all).

It is a bit cumbersome at the moment because you will need to provide
`TryFrom` and `Into` implementations between the enum and the
corresponding bounded type, but it makes setting fields easier and is
the way the API was designed to be used. The `TryFrom/Into` derive macro
work will remove all the boilerplace once it is merged.

> =20
>      poll::read_poll_timeout(
> -        || regs::GPU_IRQ_RAWSTAT.read(dev, iomem),
> -        |status| *status & regs::GPU_IRQ_RAWSTAT_RESET_COMPLETED !=3D 0,
> +        || {
> +            let io =3D (*iomem).access(dev)?;
> +            Ok(io.read(GPU_IRQ_RAWSTAT))
> +        },
> +        |status| status.reset_completed().get() !=3D 0,

Here you can do the following in the declaration of `GPU_IRQ_RAWSTAT`:

    /// Reset has completed.
    8:8     reset_completed =3D> bool;

and change this line to just=20

    |status| status.reset_completed(),

You will probably want to do that for most of the single-bit fields,
unless their semantic is different from a boolean value.

An alternative is to use `into_bool` instead of `get` to at least get a
boolean value from the single-bit field.

<snip>
> +pub(crate) fn gpu_info_log(dev: &Device<Bound>, iomem: &Devres<IoMem>) -=
> Result {
> +    let io =3D (*iomem).access(dev)?;
> +    let gpu_id =3D io.read(GPU_ID);
> +
> +    let model_name =3D if let Some(model) =3D GPU_MODELS.iter().find(|&f=
| {
> +        f.arch_major =3D=3D gpu_id.arch_major().get() && f.prod_major =
=3D=3D gpu_id.prod_major().get()
> +    }) {
> +        model.name
> +    } else {
> +        "unknown"
> +    };
> +
> +    // Create canonical product ID with only arch/product fields, exclud=
ing version
> +    // fields. This ensures the same product at different revisions has =
the same ID.
> +    let id =3D GPU_ID::zeroed()
> +        .with_arch_major(gpu_id.arch_major())
> +        .with_arch_minor(gpu_id.arch_minor())
> +        .with_arch_rev(gpu_id.arch_rev())
> +        .with_prod_major(gpu_id.prod_major())
> +        .into_raw();

It might be simpler to just clear the values of the fields you don't want.

> +
> +    dev_info!(
> +        dev,
> +        "mali-{} id 0x{:x} major 0x{:x} minor 0x{:x} status 0x{:x}",
> +        model_name,
> +        id,
> +        gpu_id.ver_major().get(),
> +        gpu_id.ver_minor().get(),
> +        gpu_id.ver_status().get()
> +    );

Note that the `Debug` implementation of register types will display
their raw hex value and the individual values of all their fields - you
might want to leverage that.

> +
> +    dev_info!(
> +        dev,
> +        "Features: L2:{:#x} Tiler:{:#x} Mem:{:#x} MMU:{:#x} AS:{:#x}",
> +        io.read(L2_FEATURES).into_raw(),
> +        io.read(TILER_FEATURES).into_raw(),
> +        io.read(MEM_FEATURES).into_raw(),
> +        io.read(MMU_FEATURES).into_raw(),
> +        io.read(AS_PRESENT).into_raw(),
> +    );
> +
> +    dev_info!(
> +        dev,
> +        "shader_present=3D0x{:016x} l2_present=3D0x{:016x} tiler_present=
=3D0x{:016x}",
> +        io.read(SHADER_PRESENT).into_raw(),
> +        io.read(L2_PRESENT).into_raw(),
> +        io.read(TILER_PRESENT).into_raw(),
> +    );
> +    Ok(())
>  }
> =20
>  /// Powers on the l2 block.
>  pub(crate) fn l2_power_on(dev: &Device<Bound>, iomem: &Devres<IoMem>) ->=
 Result {
> -    regs::L2_PWRON_LO.write(dev, iomem, 1)?;
> +    let io =3D (*iomem).access(dev)?;
> +    io.write_val(L2_PWRON::zeroed().with_const_request::<1>());
> =20
>      poll::read_poll_timeout(
> -        || regs::L2_READY_LO.read(dev, iomem),
> +        || {
> +            let io =3D (*iomem).access(dev)?;
> +            Ok(io.read(L2_READY).into_raw())
> +        },
>          |status| *status =3D=3D 1,

Why not

    poll::read_poll_timeout(
        || regs::L2_READY_LO.read(dev, iomem),
        || {
            let io =3D (*iomem).access(dev)?;
            Ok(io.read(L2_READY))
        },
        |status| status.ready() =3D=3D 1,

?

<snip>
> +        /// Layout is interpreted differently depending on the command v=
alue.
> +        /// Default command is [`GPU_COMMAND::NOP`] with no payload.
> +        pub(crate) GPU_COMMAND (u32) @ 0x30 {
> +            7:0     command;
> +        }
> +    }
> +
> +    impl GPU_COMMAND {
> +        /// No operation. This is the default value.
> +        pub(crate) const NOP: u32 =3D 0;
> +        /// Reset the GPU.
> +        pub(crate) const RESET: u32 =3D 1;
> +        /// Flush caches.
> +        pub(crate) const FLUSH_CACHES: u32 =3D 4;
> +        /// Clear GPU faults.
> +        pub(crate) const CLEAR_FAULT: u32 =3D 7;
> +    }

So this should really be turned into an enum:

    #[derive(Copy, Clone, Debug)]
    #[repr(u32)]
    enum GpuCommand {
        Nop =3D 0,
        Reset =3D 1,
        FlushCaches =3D 4,
        ClearFault =3D 7,
    }

    impl TryFrom<Bounded<u32, 8>> for GpuCommand {
        ...
    }

    impl From<GpuCommand> for Bounded<u32, 8> {
        ...
    }

Then `GPU_COMMAND` becomes:

    pub(crate) GPU_COMMAND (u32) @ 0x30 {
        7:0     command ?=3D> GpuCommand;
    }

... and everything becomes easier, as you can only set valid commands.

I see you also define aliases that reassign the roles of bitfields
depending on the command. I think you can harden that by having an
`impl` block for `GPU_COMMAND` with constructor methods for each command
taking exactly the arguments it needs. These constructors could then
build the proper value using one of the aliases register, otherwise you
are at risk of setting e.g. the `Reset` command on the
`GPU_COMMAND_FLUSH` alias.

> +
> +    register! {
> +        /// GPU command register in reset mode.
> +        /// Set command to [`GPU_COMMAND::RESET`] to set reset_mode.
> +        pub(crate) GPU_COMMAND_RESET (u32) =3D> GPU_COMMAND {
> +            7:0     command;
> +            11:8    reset_mode;
> +        }
> +    }
> +
> +    impl GPU_COMMAND_RESET {
> +        /// Stop all external bus interfaces, then reset the entire GPU.
> +        pub(crate) const SOFT_RESET: u32 =3D 1;
> +        /// Force a full GPU reset.
> +        pub(crate) const HARD_RESET: u32 =3D 2;
> +    }
> +
> +    register! {
> +        /// GPU command register in cache flush mode.
> +        /// Set command to [`GPU_COMMAND::FLUSH_CACHES`] to set flush mo=
des.
> +        pub(crate) GPU_COMMAND_FLUSH (u32) =3D> GPU_COMMAND {
> +            7:0     command;
> +            /// L2 cache flush mode.
> +            11:8    l2_flush;
> +            /// Shader core load/store cache flush mode.
> +            15:12   lsc_flush;
> +            /// Shader core other caches flush mode.
> +            19:16   other_flush;
> +        }
> +    }
> +
> +    impl GPU_COMMAND_FLUSH {
> +        /// No flush.
> +        pub(crate) const NONE: u32 =3D 0;
> +        /// Clean the caches.
> +        pub(crate) const CLEAN: u32 =3D 1;
> +        /// Invalidate the caches.
> +        pub(crate) const INVALIDATE: u32 =3D 2;
> +        /// Clean and invalidate the caches.
> +        pub(crate) const CLEAN_INVALIDATE: u32 =3D 3;
> +    }
> +
> +    register! {
> +        /// GPU status register. Read only.
> +        pub(crate) GPU_STATUS(u32) @ 0x34 {
> +            /// GPU active.
> +            0:0     gpu_active;
> +            /// Power manager active.
> +            1:1     pwr_active;
> +            /// Page fault active.
> +            4:4     page_fault;
> +            /// Protected mode active.
> +            7:7     protected_mode_active;
> +            /// Debug mode active.
> +            8:8     gpu_dbg_enabled;
> +        }
> +
> +        /// GPU fault status register. Read only.
> +        pub(crate) GPU_FAULTSTATUS(u32) @ 0x3c {
> +            /// Exception type.
> +            7:0     exception_type;
> +            /// Access type.
> +            9:8     access_type;
> +            /// The GPU_FAULTADDRESS is valid.
> +            10:10   address_valid;
> +            /// The JASID field is valid.
> +            11:11   jasid_valid;
> +            /// JASID of the fault, if known.
> +            15:12   jasid;
> +            /// ID of the source that triggered the fault.
> +            31:16   source_id;
> +        }
> +    }
> +
> +    impl GPU_FAULTSTATUS {
> +        /// Exception type: No error.
> +        pub(crate) const EXCEPTION_OK: u32 =3D 0x00;
> +        /// Exception type: GPU external bus error.
> +        pub(crate) const EXCEPTION_GPU_BUS_FAULT: u32 =3D 0x80;
> +        /// Exception type: GPU shareability error.
> +        pub(crate) const EXCEPTION_GPU_SHAREABILITY_FAULT: u32 =3D 0x88;
> +        /// Exception type: System shareability error.
> +        pub(crate) const EXCEPTION_SYSTEM_SHAREABILITY_FAULT: u32 =3D 0x=
89;
> +        /// Exception type: GPU cacheability error.
> +        pub(crate) const EXCEPTION_GPU_CACHEABILITY_FAULT: u32 =3D 0x8A;
> +
> +        /// Access type: An atomic (read/write) transaction.
> +        pub(crate) const ACCESS_ATOMIC: u32 =3D 0;
> +        /// Access type: An execute transaction.
> +        pub(crate) const ACCESS_EXECUTE: u32 =3D 1;
> +        /// Access type: A read transaction.
> +        pub(crate) const ACCESS_READ: u32 =3D 2;
> +        /// Access type: A write transaction.
> +        pub(crate) const ACCESS_WRITE: u32 =3D 3;

Since these consts cover all the possible values of `access_type`, you
can use the `=3D>` syntax for it and implement `From<Bounded<u32, 2>>`
instead of `TryFrom`. This will make the getter infallible as there are
no invalid values.

> +    }
> +
> +    register! {
> +        /// GPU fault address. Read only.
> +        /// Once a fault is reported, it must be manually cleared by iss=
uing a
> +        /// [`GPU_COMMAND::CLEAR_FAULT`] command to the [`GPU_COMMAND`] =
register. No further GPU
> +        /// faults will be reported until the previous fault has been cl=
eared.
> +        pub(crate) GPU_FAULTADDRESS(u64) @ 0x40 {
> +            63:0    pointer;
> +        }
> +
> +        /// Level 2 cache configuration.
> +        pub(crate) L2_CONFIG(u32) @ 0x48 {
> +            /// Requested cache size.
> +            23:16   cache_size;
> +            /// Requested hash function index.
> +            31:24   hash_function;
> +        }
> +
> +        /// Power state key. Write only.
> +        pub(crate) PWR_KEY(u32) @ 0x50 {
> +            /// Set to [`PWR_KEY::KEY_UNLOCK`] to unlock writes to other=
 power state registers.
> +            31:0    key;
> +        }
> +    }
> +
> +    impl PWR_KEY {
> +        /// Key value to unlock writes to other power state registers.
> +        /// This value was generated at random.
> +        pub(crate) const KEY_UNLOCK: u32 =3D 0x2968A819;

Note that you can also create constants of the register type directly,
so you don't need to reconstruct one using this value.

> +    }
> +
> +    register! {
> +        /// Power manager override settings.
> +        pub(crate) PWR_OVERRIDE0(u32) @ 0x54 {
> +            /// Override the PWRUP signal.
> +            1:0     pwrup_override;
> +            /// Override the ISOLATE signal.
> +            3:2     isolate_override;
> +            /// Override the RESET signal.
> +            5:4     reset_override;
> +            /// Override the PWRUP_ACK signal.
> +            9:8     pwrup_ack_override;
> +            /// Override the ISOLATE_ACK signal.
> +            11:10   isolate_ack_override;
> +            /// Override the FUNC_ISOLATE signal.
> +            13:12   func_iso_override;
> +            /// Override the FUNC_ISOLATE_ACK signal.
> +            15:14   func_iso_ack_override;
> +            /// Maximum number of power transitions.
> +            21:16   pwrtrans_limit;
> +            /// Core startup throttling enabled.
> +            23:23   throttle_enable;
> +            /// Maximum number of simultaneous core startups.
> +            29:24   throttle_limit;
> +        }
> +    }
> +
> +    /// Power override mode constants (`pwr_override_t` in hardware spec=
).
> +    ///
> +    /// These constants can be used with any field in [`PWR_OVERRIDE0`] =
that ends with
> +    /// the `_override` suffix.
> +    impl PWR_OVERRIDE0 {
> +        /// The signal behaves normally.
> +        pub(crate) const NONE: u32 =3D 0;
> +        /// The signal is inverted (on when normally off, and off when n=
ormally on).
> +        pub(crate) const INVERT: u32 =3D 1;
> +        /// The signal is always kept on.
> +        pub(crate) const ON: u32 =3D 2;
> +        /// The signal is always kept off.
> +        pub(crate) const OFF: u32 =3D 3;
> +    }
> +
> +    register! {
> +        /// Power manager override settings for device manufacturer.
> +        pub(crate) PWR_OVERRIDE1(u32) @ 0x58 {
> +            31:0    pwrtrans_vendor;
> +        }
> +
> +        /// Global time stamp offset.
> +        pub(crate) TIMESTAMP_OFFSET(u64) @ 0x88 {
> +            63:0    offset;
> +        }
> +
> +        /// GPU cycle counter. Read only.
> +        pub(crate) CYCLE_COUNT(u64) @ 0x90 {
> +            63:0    count;
> +        }
> +
> +        /// Global time stamp. Read only.
> +        pub(crate) TIMESTAMP(u64) @ 0x98 {
> +            63:0    timestamp;
> +        }
> +
> +        /// Maximum number of threads per core. Read only constant.
> +        pub(crate) THREAD_MAX_THREADS(u32) @ 0xa0 {
> +            31:0    threads;
> +        }
> +
> +        /// Maximum number of threads per workgroup. Read only constant.
> +        pub(crate) THREAD_MAX_WORKGROUP_SIZE(u32) @ 0xa4 {
> +            31:0    threads;
> +        }
> +
> +        /// Maximum number of threads per barrier. Read only constant.
> +        pub(crate) THREAD_MAX_BARRIER_SIZE(u32) @ 0xa8 {
> +            31:0    threads;
> +        }
> +
> +        /// Thread features. Read only constant.
> +        pub(crate) THREAD_FEATURES(u32) @ 0xac {
> +            /// Total number of registers per core.
> +            21:0    max_registers;
> +            /// Implementation technology type.
> +            23:22   implementation_technology;

Here as well you will probably want an enum type for the values.
