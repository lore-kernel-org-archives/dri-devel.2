Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9245C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 13:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D7F110E4E1;
	Wed,  2 Sep 2026 13:21:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="S2cyAPEO";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022091.outbound.protection.outlook.com [52.101.96.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D64B610E4E1
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 13:21:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwiuJyP8Rwpa7nXU4D1uF0/iEqSw/kFxKcdReZ9b2A8R3XGXTZRuAbCg/rra5AK15e55vtAOmM4HiuyD7UHjADpTkv/8zaYZvNxfyofm+Le9t8MY244n33nWUlx2fRa3IImwzk3qKy4HjY0OurOlD3y5y/19AMg9HYLQAGFG6M3gHziQ3rzphQ9QL5Dh8T4xvV/eQvyQFnDRXYJUdh6kbSqbyl5vjNuAyK//6BVqCwO6qxIOPoo5NEkkNo1j3MGwD5Q1ra8akvimJZhT0Q0zQeNuwDZ85vlMO8R2zD/F4jsH98cjRBWIqc78ORcGXqfdLROpHLpSR8L4Cx0ZavTQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jmmCgT/vjDnvuvYmlwHAHiVy3+KSqW1NUgN6bsbr3k=;
 b=q0LOZN225V03p52/1OkrdOpOvT1IdfdJGPPu1PNZq1J0OLv7IBw4Q+0vtVNCabXrMfX1snUH0+QV/7hjGlIFiDq1IYboLAoS0nYMvrX8odfxL7fNzxp/8SLpQglxpo/JpH1TWuPEY+Ut6Nssh1OnEmdBfZZ61l2d/4DoW6UgJUihRoL3ZBijVqjCjUETX+4KDrFOlyC6RGrrdgyt84ZmfSprdGR0T75s+Iz/URJ1BuP4GfXwNxEN4kNn3KtLmj1Tz8t6K/fmbMZg/CAiGPI+U/5Ip4z2EwNh0OfJ/g95EBLoQnBxZUKOGHRobDWGBLjFh0OxUOu5JCK9ZJwZ8l13vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jmmCgT/vjDnvuvYmlwHAHiVy3+KSqW1NUgN6bsbr3k=;
 b=S2cyAPEO27g/mx1uifOPmkge2eXTExLS9Aj7ngJr4AjGNpuoHIMkDudAoGclK2q8Qwvm2jdW9KRXI3jZDIxvXmA2ylOhmY5nEcC4bhWGs93UwzxNJQVhbfxQUxBl9B5P8PESZudQFgKwhBKnVZZzX4/wmxz8RQuxmXzQV7kRRMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO6P265MB6907.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:324::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:21:48 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 13:21:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Sep 2026 14:21:47 +0100
Message-Id: <DL4V1QCCPC8L.2D3JKJGXJ9CG4@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3 1/3] rust: num: add cv! macro to create values from
 constant expressions
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.22.0
References: <20260902-cv-v3-0-0f90659e711d@nvidia.com>
 <20260902-cv-v3-1-0f90659e711d@nvidia.com>
In-Reply-To: <20260902-cv-v3-1-0f90659e711d@nvidia.com>
X-ClientProxiedBy: LO4P302CA0035.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::11) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO6P265MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: f4dfb5d8-8d20-4430-bf13-08df08f52439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|366016|1800799024|23010399003|10067099003|18002099003|22082099003|4143699003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: nRE8yIHVHrMJtnGc3uFwRAgfnot1toU1iWbpST0yKgJHxNVJOrHBve/aeY2Sl/Gd1bQPlzHoqkayKrIjr/6tO/GM6QPtw4qWxsgEkUt58yA6CtHdzJscBUL0Fe4lmdCCFnPwE/whlDATfaYP+BqIHfXTFIbbxozsDjAPHhZyXXTN1igrZN+PN5HwuM2xKL/tKmrTyenK+gp5CzY3XRxSyhByz7zweGAsoPtOjr/fUdBiNBHDQaqvW/TUx6Objd5OafaEmJWqtnyXHXGP9VwDXl7yb4ixExyobZ31oQLs1VHrOTAaVs9yXLcqg63yCgpT0TjqQ7R14KkdAlfQIomrl2c1lIXx0faDbEWY7bWPMG8TzmIHiFwWPgubuexOjEcFJqdo5thtVsTPm/KVSqAXLh+zIWLNV8ebPxVSYwe0vvFWW915GcfgelNel7RMXuHL8brZLh8brwiX0Kc8k4jV+1W9SbQ2Ryh3y/H3VejcsgZZUxA8r2DDg/B3eE+R2VQiKgzkaIatDM5WbWFKG1FlwJCrwuF8yPruaidC/LshgAAuex9tmaY6pmy7e0nl+mVDc2V0W70xuQLZaNIUznCguI77z8tKSy10nP5thR5KIyUNB6H1T6pVLqJOs8VYo1XF0VTPwNS8Tu3Gb1O7LxLIMAkNlh8KJZMkOaqIYrL1d0gCqWu/25bCJTvO/euZcty4uml0cTBGjuBYCLGxVGFF3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(4143699003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUZTelVaRzFEbVY2NEU3KzVhMCtXelIwWEtYNFEyVW50eU84UG1idTZ1bldG?=
 =?utf-8?B?ZUFrZzJBalNKbW9WSEJDN3I5endZZnRyWEU5cHFieTdVa2NLZUFqNmQxZms1?=
 =?utf-8?B?Y01WUitwcUxmMDFIY0x6bnRHU0tuT2xoazlmUHROa2pCMEl0MkQ3VmVpWDk4?=
 =?utf-8?B?bkg5ajMzci8zTUdoWkhGYTQyMWJWR3R2V0ozMXdnWm1FVStaNThuUHpEcTF6?=
 =?utf-8?B?cWxQRnZNWTY4OHIvL1FPUm9rZVVqZzBvQzF1dGZ4VkExRHkydGdLaXVqY2c1?=
 =?utf-8?B?Z05ONlJnQlNwdHZFN1h3NWJGZjJFYXl5NjJNRVVzT2d3L3Z5RFdyN2RvbURo?=
 =?utf-8?B?Wlo0MUU0OUtJQUdERlVoWnJiaEpLaTFKRWNaTHBmblM2WmJXSEM3cG1LckR2?=
 =?utf-8?B?Q253UHlSN3F6SlRVVnNmVC9ydi9pakhZK0xZZWdJbDdORDJMcnlFQXNIMjNV?=
 =?utf-8?B?clJhVXFkdzFleU9UVVRvR25lWWtTOGVxaUZFSGtMYXRFeWdvdTVNR2ZtZ1hz?=
 =?utf-8?B?SU55d1puUWlXOVQycFFyVEVBVWNRQjVTbVpuWHNUNzhYWFJMQ3R6U2d0UXla?=
 =?utf-8?B?YlJRRUFLempPSDdocjIzRnVDWnRWdlQ3cWVEQjRyaXpjb1pBT29iaGRZakdL?=
 =?utf-8?B?ejdheExWTXBPWVFOZW9hYUdHb1dYQnlEbEplRnhOTFNlcWRhZzkxODZiZ2VP?=
 =?utf-8?B?Wi9nbUpWNEUxcTc2YmYyVzNFSHFSVTNCTEZ1T0lxYmM0MFEybVpCclpQL1cr?=
 =?utf-8?B?RCs1MTFZWm5KSnBCZ2lmbm1XWmF4eGF6SlNRTFdQRzI3c2hmTTRMYkM3cSt6?=
 =?utf-8?B?SUlCdmNuZWdTK3VmK3hwUDZDcUVHWXExbnZGVXhCdjNFZ3kwbXVSSW9NQXNk?=
 =?utf-8?B?L3oxSlRXVmMvQjJIcDVDMk4rWWlHYnVMTDNkV3FHS29sMzNCNzJ2Z0U3ancw?=
 =?utf-8?B?VjdYM29xUXlkNVhEc1ZlSUhZaStva0QyS0R3d2I4eG8zSkxEVDZFUmdYWTR4?=
 =?utf-8?B?TGJhL3FTLy8rNjRiQ1F1dXRyVG5zdmxnV0hQYW1pT2dBUHZRR2ZLWW5Ia1d0?=
 =?utf-8?B?QlgxZG9BeEVlTWoyNSttUXRncEg1a3l4cFQzNjhvTTVXNDBwUzh1L3RRWjFK?=
 =?utf-8?B?ZmloRkJTcUFVNmxiWmhTeUwwN05rNG9TbU9weThIWHhXcEExV25hQVlnaDh4?=
 =?utf-8?B?cEIrcUNvU1k3ck80OHJMbVQzOXFjMUNINllzaVR3RXcrZEdIYmZIVDJ0Zkt4?=
 =?utf-8?B?bFcvaWV4U1NiR3F6ZDVocE43Q3Z2elJiZGJteFBBeEtKWGlLcEZtNVpxcGpS?=
 =?utf-8?B?SDAwSWtUYXdjUitKcnRvV0UrOWk5V0tqbVBpaTNDQmhFUDdQTVZHNFhIU1pS?=
 =?utf-8?B?UENqaitrT1hUYU14ditOcWpTMXBpWGhuR1JLY0RHM1pjbThCbjNuQ3lsZCtF?=
 =?utf-8?B?V2syL21KMjA1cmN3UU9Fd0VkSjhwcW1tbFdnb2dmblpSc0RIUnQxMDJidHhF?=
 =?utf-8?B?RFV2SDlHVzdIVGYwL3ZoZGdZNExkdkNCSGtYUHZrM013eU02eUhyMW51NDE5?=
 =?utf-8?B?b0I3c0R6bllQQ2ZEY3BFSTBiK0pSbmsycUxYZjB2U245Z1V0SUdXejNMSjJN?=
 =?utf-8?B?YklmNGRjWmFGUDlHSzBTSzB4ajNpTXQvNmt1ZjRiTFRHSmtmUW1JLzA5YmVv?=
 =?utf-8?B?RkFRLzZHL0txaGgxd1U5K0NvYmRqeURKdFhDamJCMkowdWxvankzYUFGaE9X?=
 =?utf-8?B?a2RGUVEyRGtOM2xPQ3l6YWpncE9pcHEvakxWNnVlV3JWdGRKak9QL0VQSnVl?=
 =?utf-8?B?NEZVNGdpZHFPZURUZUhOUmRwNlR0TythV1liVFAyNjRuV3EzZHhkeGdFSXZD?=
 =?utf-8?B?bURoLzJsUTVodVp4R1VMckVDZzMraUN1OXZQOFZHUlFCdHU3ZWlrWklPNmhJ?=
 =?utf-8?B?QzdOazJqVlo0ZlVZNDZEek5FZFc4VDgvWDIvelcySnE3OWg1aEg5eHpwZmhp?=
 =?utf-8?B?REJ0KzZWZE5QbGp5NGZzRWpQN21TL0hHS3RQYWw5aWdTb2RhRWgwUlFWNUxa?=
 =?utf-8?B?dThWSGxNckx3MkRVRVdIZDhiRDIwamRjSnFaS2U1emVxRVN3OXpSa2lEV2N6?=
 =?utf-8?B?VjRyUDhnUGQzbTJYUGxXdkt2cUFLbGIwbFdPcS82M2FtR3JZT1BVVkJvcHFJ?=
 =?utf-8?B?QTViNks3S2gwS2VSOENJbjg3dDFaYVdQVVNwc0RGbnRQSU8rMlVoTHVtWmll?=
 =?utf-8?B?UE9wR1Z0Z1JzRXY4V0doMFF5QWUvc1dNWWk5L2hyM2tDUmEwblcrVXZyYTVF?=
 =?utf-8?B?V3hBT1R1Z2RJRHJVRU9US0EwZlMxRUlFWjh6cGRJYzdnelV2K2ZDUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f4dfb5d8-8d20-4430-bf13-08df08f52439
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:21:47.9424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOZbiDOenCuJgpFhAAFeGZ/jpoJSWhLMnNlZro38kl/do7KS6Xup/WI36lHWyUu4N+t76GwumHvI5cXtI2IxxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6907
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

On Wed Sep 2, 2026 at 10:16 AM BST, Eliot Courtney wrote:
> Currently, using NonZero/Bounded constants is quite verbose. It's
> unfortunate because it disincentivizes using it in interface boundaries.
> Introduce a macro to make it nicer to use. The macro `cv!` (for constant
> value) takes a const integer expression and widens it to i128 (at build
> time only) before passing it as a const generic value to a new trait
> `FromConst`. The value is then converted and appears in the
> associated constant `FromConst::VALUE`. The trait is implemented by
> NonZero, Bounded, and Alignment and lets values of each be constructed
> from constants without a verbose turbofish syntax.
> For example, `const { NonZero::new(1).unwrap() }` can be written as
> `cv!(1)`.
>
> Suggested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/num.rs         | 138 +++++++++++++++++++++++++++++++++++++++=
++++++
>  rust/kernel/num/bounded.rs |  19 +++++++
>  rust/kernel/ptr.rs         |  14 +++++
>  3 files changed, 171 insertions(+)
>
> diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
> index dbe848e30efe..9435459376a4 100644
> --- a/rust/kernel/num.rs
> +++ b/rust/kernel/num.rs
> @@ -2,6 +2,7 @@
> =20
>  //! Additional numerical features for the kernel.
> =20
> +use crate::const_assert;
>  use core::ops;

nit: commonly Rust code uses core/std -> dependency -> crate/super import
order (known as std/extern/crate order), so this would be

    use core::ops;

    use crate::const_assert;

under that order. But I don't think we require that (so no need to resend).

Best,
Gary
