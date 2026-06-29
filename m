Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC024C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 064D410E09B;
	Mon, 29 Jun 2026 11:51:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="YiAxqz45";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E359110E09B
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 11:51:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnFQQVBo/qm0qJIxKzLsxCVAuQRQRfih6vAGk0yWB/D1frVnkrxyg5WFJuEEZDsymtggD4F8MHOsuFKgAzh63Gjh6YEXlUJ73Z6xI1hj1vmUGqcxOSm9Ed+gOFXdUrskonzlFhzhz28JtaucjtIOSmTtm/YMZ5Cyrs6xviI06k2Hu7IoOWcm6CXVGX0GoqKXEiRiJGDWmS3d3TZ8Rb6IHaJERHzH+MVWlYJZJaCvDk0n2EmCUlDYtHprhNsgTi5ZV4t3HFBmCtj/nJzFCFjNjoxwnoQDlo0Lg3ahPuCelf7CEfpGrMf38pxesaIq0zflLZGs/1v9Mp7Nv//qsa7xfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaQNbGfFmyq76MKyePWLfeVHdrBlydfqF1F9Y95kSFI=;
 b=TlwureIMk+l0ANSJG9AJ75BMRxHBYrbB44ZDL/hIPbQHsK2GnKbl9dwljtjRVZZuy0s/APdaZHVEKTInarb6AYYLNl3voSZOMiY4wSLt/wn4hp97E45HvWLLeneccqlxkG8CFe3d4LXlwFiLIQrLFe2LLfmsvpOgOwxWxx2R/71aaxYjhqspvb1o3VfZ1RY7NMFrvQ9IgTHEA6Ia/53DC2crE+J+D+B9fXNml5/jM5KqhZJLiqj0likED0BFy5WiolpC/7ky6vVyfxtORBlVARKUNJwr5FEXNRzDCEeRmg4PNK47xL5UEJwvryrQnasmLm4eOHL9JKsnFbFEywTF6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaQNbGfFmyq76MKyePWLfeVHdrBlydfqF1F9Y95kSFI=;
 b=YiAxqz45fqJ7pgLmIhdMTxN4vqtxbxNO44QC5obDVEh0NDddQzzoUDkd4G8jS5XXyc0gcgTotMaLdgsfGZq6bTfxeE1nUpj+cwNtF84o3zicBxunh+aWcb9KrxlPhFTJZtRC6owG/dD9zzaEHG1+4qHQjjecG8o+9LMUpuumrO+BlCUDbNb3+lTT35vw8yaNmZeqzL3ODiwJPY85abLW6qeWUa+HqUM8bYMSkbXtIh6uCNGeSzILP0XCRB2/NaNf6mgWCE36tjM+PTOVZ+hD0nCsNyestGXfoR2xhrDLSD7SfxPpW+ZLJKiVnZnM7o3tjbNcEcaKwEcW83jvNAV8BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Mon, 29 Jun
 2026 11:51:18 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 11:51:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 20:51:13 +0900
Message-Id: <DJLIEZJL9ZS6.J2642U4G4CT4@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2] gpu: nova-core: falcon: store bar and dev in falcon
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Tim Kovalenko" <tim.kovalenko@proton.me>, "Danilo Krummrich"
 <dakr@kernel.org>
References: <20260625-drm-bar-refactor-v2-1-9db6b890d92e@proton.me>
In-Reply-To: <20260625-drm-bar-refactor-v2-1-9db6b890d92e@proton.me>
X-ClientProxiedBy: TY6P286CA0010.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN2PR12MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: 26207bb5-8b0f-4991-0b42-08ded5d4baa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|23010399003|7416014|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: cwDQpZhE6eAPIX1mfyATlxVcTNxTVvNHGikOW6hYN26VVp7Tij49YY42vDNSqsRtpfDiiXJTlK8GhiyQ240MJ0GDyDFvkpdmUlL4hKz1/3YtDdXqsQ75hY1Qsn3Xpo2h4pVTs7zFASpobyrGN8jvEA8PV3OAq87M6ttLwp6Qxq4gdhz/6QR+/TTZTtCUg2PPmSZGUDc2otrpG6sVb8eut+Hi3Z5UnTJtJE0IMutmyzd2Vrf+U9tAKI0ZsPvmj5pPTztqGQLf3cV1V8xaFGxoTxbd/1uZYwf2U8cwUBaAulW75W2swBgIlEgIsxThx19iK34fSzXn1tsduIwZZz+qA/0ZO/9uXlT6KPGBuJxvpqcwj5iAwAq5eF5cR6QnXCLLcZKts9Mxd/iH6nkPKZ8HYr0NzXwblfaVXuU3emeA0JZ8eJx3zdzJadLf79Q7cS2LRwOI9A6TgoU3k3sLIn/Tp6i0FCdfbcSeHwzJXrHU57YAygXdKwLcE04e6/ydww00VUAlqvcfX05khOUSD06F+KLHeS/0VI2le4otexJb7E4PggbYzGN0xvda1z5lDSJ6+vhsEwaqqRaVmV2TBQSIQ/KkJbA33ft/sPGWbuE/Obju8x6vyN237FZCrN7eY/QE1rrN2xjQXpMkmXmVX8i99DOghOql2nOq5P+3MWDd/6w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(7416014)(376014)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFhCM3c2dllyZ0d4VUg3WGUrcmprbGIwUlQxdDNkQVJjeWs0NEQ0ZC8vemtI?=
 =?utf-8?B?aTd4aGIrTzltUVJHWURSVENlaVhVRHBJUDBYd0g2VkU4eDhGdVR0ZVR3TU1t?=
 =?utf-8?B?WjBvT0ZjYkJRTklSRU9XY1Rrc1I4V05saUtaMU9xcDFIdzVpRkdRNkE1bVRZ?=
 =?utf-8?B?c0ZxeHVFM0prR0lLNElYVHVsYkh0VkV5UEJwVWduSkZxSEVWRHZMRmpWMmxu?=
 =?utf-8?B?N3NqSStpK3lVamxNS0hUTE04SEJnTmdWQ0JVU29INXZyUTBYUUFJWXpqVFdW?=
 =?utf-8?B?R2tlRkN5NUdONzg0N3ltWDJNL0tmS0NzYXN4d080ckRaSHE5UmdzYW9DSERw?=
 =?utf-8?B?Nm1mMHBHSEZKYlpzSDBubEpEeWZ5ajFmM29HUEFnSGFmRjRlTXZiYXBDclRD?=
 =?utf-8?B?Smh5eHYzMkdmMlU0Yjh4SDYxclpCK2xmU0xERVV6Q0J6Q0FNWWdQME9CSVdu?=
 =?utf-8?B?d1B0bUFZMzQ5alFzaW5VRGorQjdDZU42TzRCSEdJOHFRNy9LbFFuU2J1bHhz?=
 =?utf-8?B?ZmVTcFhVaDd3MVp6cG9JRjZYb3BTNkRVMzRXMDg1RWlqZ0Z2VFpiTEVjZHJy?=
 =?utf-8?B?Nkl5bjdySTVXQVZjQklzSnBjNytDUTVheWNYRGdNc1N2UFJyamV4VEp2Uko3?=
 =?utf-8?B?QmhBQlo4ZVh4WVlTWDNNT045Umg4SmF6bWJhbnJtZEhJbUZpdXlDeXFRUDlJ?=
 =?utf-8?B?NWFqd1N2dzNYSW02UkhPSGdLSVVZTXcvSmpIS1pjK00wM2tUZnRDY3R3bVhF?=
 =?utf-8?B?SXZCWTZ3VkczYk9KdThNRVNLVVVyeU1GVlhXTmltd0tCeHRZN0pEZmpNcTVO?=
 =?utf-8?B?RWs2aVMrdElnSm9zdVYwY09GUFExWERvRmxRY2ZNWDQvRTg4d2t6WXpCMjR3?=
 =?utf-8?B?TlVydDNuUTZETWdEdFBJVldQQW04MGlOYUIvS3VRdG5GWFhRNnRMMGU0azdZ?=
 =?utf-8?B?anJiZjJUc2NCVG9ZZFZMZStzOTh0L2xEckNFSDkxM2Z0RjMwUFdIV0RpYlVB?=
 =?utf-8?B?RGVlZlJYQm1IMFBDNDYrVXNVdHl4UHNtRGhWbDZBVFNpbkV6WmkyWTd0OFUz?=
 =?utf-8?B?UFdhZDdRb2U3UkQ3ODRHWjd4bjJZWFk2bHlKanpyUDV5ZERNaDh1QjRMT2lK?=
 =?utf-8?B?aDF4dlNzTUR5d0pTMm9ib1BCTUdlYTRnd0xIY1JIVUVKSHExb1lrNXlncThE?=
 =?utf-8?B?alA0Q21qOG8zc1B5MUhiZm85a1ora0hzanZpZWZCYVl2Y0FBWXk0Yk43c2Vv?=
 =?utf-8?B?eXNSSWtJM21aRFFNQm1YcFpQd0ZlTXdOR2x5Q1JnZEg2b0JiUUFFdGNMbGJF?=
 =?utf-8?B?QytOSjMvT2JPZ1dPMjdobGVQdnRyNEVjN0NPaDhISlY2QXpPd2QwWmdVbVZQ?=
 =?utf-8?B?UkE0ZHQ5ci9uckVtaGxZbEdiQVFWZEhYcGFTUXp5MzdQanE5MzJVZ1lxa0F6?=
 =?utf-8?B?enVQVXNpTCszT0lEeHBPNG5aNHl4ejhlcnpIdGp1WWhHS0g0bjdCU0orSERs?=
 =?utf-8?B?d3B2Qko4R25BWkNWUmNJbmM2aWdpQU9MTHRVQmhXZVE1MldML3V3QWgwdnp6?=
 =?utf-8?B?MjlRUG45QUdVY2h6UXRnOEJXYVNQbEhsWlRsUFZRS2QxS2JMMzg0Nm91VlZG?=
 =?utf-8?B?ZlZHVXVHQ0JyeUVVOXZnWk03ekJEM0VrR0UwNWhGS053U1BtMWR0MGtjSEJx?=
 =?utf-8?B?VGdPVHE4YW1Ua1BEam9OejJLQ3VwUVk0dWJpaHd6K09ZNGxXRnE2dWowNGdp?=
 =?utf-8?B?eHlZbndNSHoxcGFZR2tGRkZvVG0zQ0swZFltQ1VYckdZOVlHblUrSTg4U1RP?=
 =?utf-8?B?QnFoQzIxZktoK1FsaUx3aHBZeHhsREZNL2xSU1pnemtidzIwRmZiUmdEekwz?=
 =?utf-8?B?OEp1MVRVU1hmbHVnOE1ReUNLekQ4MmRwK09IQzA1clVDSTFMZldPM2xna1FM?=
 =?utf-8?B?ZHBSbDVrSUNRc1ZwVTdmU3BWTGtUQ2ZqSmtBdzk3RStBNWhiS2NYTHo5M3Bn?=
 =?utf-8?B?Zlc3WjNFb1lkZ3dDRGdEMFdESlRRelFVQnI4UEl3NmkyWU4rckVSb2c1Mkk0?=
 =?utf-8?B?UmxOU05kS3o2MzUxMW5MN0psK1ZHd2hRVDB1SmpjbFJvMzRUeFRZSmVNemdm?=
 =?utf-8?B?Z2xlU09BOFpwVTlna05rU252SUwyWC9Ea2Zlb3FsbXN2cmlvQVllSVRkREdE?=
 =?utf-8?B?QzBobGxsVHdIMERsM1pkdGg4ZHBGQUFhdVgvNmVGajRYR1ZoS2VnZTdaQk56?=
 =?utf-8?B?RVJWUk5aakowYkRTVmEzZUQ4Z2k2aU9Vbm5ET3lSQkFsc1ROWHdQTmJxRUJm?=
 =?utf-8?B?T2FHTTVPcCt3VU9UQ2tsN1V1QWdWSm9kT3NKcVAwajBUYUw1aWhtOU9EdytY?=
 =?utf-8?Q?Ai2bQkIwRecsxZp9K0IOz65tVQiYRQBuh1zuoDsfn6W0Q?=
X-MS-Exchange-AntiSpam-MessageData-1: DRgMh0TkSaHsBQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26207bb5-8b0f-4991-0b42-08ded5d4baa4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 11:51:17.6243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87Wz5r3quMDPjZWL3GI+H8tk2CoE+WdlVvTtLQCIT/HujRe9O7Q2CrV9Itd+2ICrwR3LYfvze2aqeMa7drbevA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094
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

On Fri Jun 26, 2026 at 11:24 AM JST, Tim Kovalenko wrote:
> Store the bound device and `BAR0` mapping in `Falcon` instead of passing
> them through every `Falcon` operation. This simplifies the `Falcon` API a=
nd
> removes repeated `dev`/`bar` plumbing from reset, load, boot, mailbox, DM=
A,
> and GSP/FSP-specific Falcon helpers.
>
> `FalconHal` now receives a reference to a `Falcon` and uses its methods a=
nd
> members instead of passing them individually.
>
> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
> Link: https://rust-for-linux.zulipchat.com/#narrow/channel/509436-Nova/to=
pic/Storing.20driver-bound.20references.20into.20sub-devices/near/599137882
> Signed-off-by: Tim Kovalenko <tim.kovalenko@proton.me>
> ---
> Changes in v2:
> - Removed the ad-hoc `set_fbif_transcfg_phys_sysmem` method in falcon, it=
 can be re-implemented
>   in a better way in the future.
> - Made `FalconHal` receive `Falcon` instead of `bar` and/or `falcon`
>   separately. This allows for simpler usage of the said hal.
> - Link to v1: https://lore.kernel.org/r/20260624-drm-bar-refactor-v1-1-70=
62899163c5@proton.me
> ---
>  drivers/gpu/nova-core/falcon.rs                    | 195 +++++++++------=
------
>  drivers/gpu/nova-core/falcon/fsp.rs                |  44 ++---
>  drivers/gpu/nova-core/falcon/gsp.rs                |  21 +--
>  drivers/gpu/nova-core/falcon/hal.rs                |  14 +-
>  drivers/gpu/nova-core/falcon/hal/ga102.rs          |  29 +--
>  drivers/gpu/nova-core/falcon/hal/tu102.rs          |  24 +--
>  drivers/gpu/nova-core/firmware/booter.rs           |  25 +--
>  drivers/gpu/nova-core/firmware/fwsec.rs            |  19 +-
>  drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  15 +-
>  drivers/gpu/nova-core/fsp.rs                       |  23 ++-
>  drivers/gpu/nova-core/gpu.rs                       |   9 +-
>  drivers/gpu/nova-core/gsp.rs                       |   4 +-
>  drivers/gpu/nova-core/gsp/boot.rs                  |  22 +--
>  drivers/gpu/nova-core/gsp/hal.rs                   |   4 +-
>  drivers/gpu/nova-core/gsp/hal/gh100.rs             |  32 ++--
>  drivers/gpu/nova-core/gsp/hal/tu102.rs             |  68 +++----
>  drivers/gpu/nova-core/gsp/sequencer.rs             |  31 ++--
>  17 files changed, 263 insertions(+), 316 deletions(-)

Thanks, this looks exactly like what we discussed and the removal of 50
LoCs is always a pleasant sight.

Since this touches a lot of files, I would like to apply it before
something else conflicts with it (it applies cleanly as of today).
Danilo, any objection?
