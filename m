Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53240C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 23:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E40910E031;
	Wed, 19 Aug 2026 23:05:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="txaAWEii";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87D3010E031
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 23:05:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWcrAiGV8JBk2INpkTTx96e0QZ+lR0heF2CwP2JihP3UIUbYP6IRuEIu8467x15Z6qlfrXMIkA4pUBG/bzs/Pz8ZVJ0bUaFGcgFNw9dah6pRvmUDqQS3+qgmYx1FxrVr/TJqzuccGy+Li3s+FoWue3A3W4+hxXcs74TMsmAxVhonQQ7qq9jkeZxswGfr2DbRMuaByfWj56nVoUj8cwhyHdm8MBrkk2XLiHXpVVDs2Nup33Q68VZJvJQaWF3qWzlB/J8X/eATmqiyJBeTjctvEMS4iJzcfuMaqwK6mtFjIcSmLzIBd8c9KGwieS6t1WKqd5ZwwFPeBimpj1Y26+aWRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6SDO2pTFPqB5VXFbYsCcapUY2idjqivnsmRv5waWDQ=;
 b=vfeOhZEvRjG1M9PxUIBGdpZPnbRKAA8hXGBRr33pATTPbEO5hLcVRlnCosKyKkf0x0V3GEyJEftOf4JcS5e+temJusWvNqdOm991BAg5vBNI8a0a0uw05TybJEbTukhVMAO0nY4gafhgdsRXEO927c056BFobCOMHr7/lQoGvdxbZ72HG8QXR+kdV8eSjE/fmMKKnXPR1MgwR0ZAFqcNDt7bpD4E96UxHnPV+sTza9VvXG35w/NDED/KL37P5oEkdN4wmPNGJk7eodaEoSJTKxQ0qJp0ToNMcle1cbR0rOuvlBhB9vyajMdylgVYZ7nebnNZIyeNGArgk7MyL+GKxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6SDO2pTFPqB5VXFbYsCcapUY2idjqivnsmRv5waWDQ=;
 b=txaAWEiitsRgloObtG6QGGbgC2HnMeQhLf8SYkxJL566J1pzhcckwsgNrKMNB/q323V0T5xN3grxjiieJ6FzH5U9M/71wFqAeuqPVTGAZCCkvsl+VJYj7dZUjIsaxa+WP7bYUlRgewrcD9E7wJB+1ghjo67OYS4Kp6bzDC3jDFD9hcfASbyWoXIzCEtnWKcRtcELB3SR0Oq29PayXhRiF6L4Wbx/L9yjnx6xbeTJEV9k/HgHvhpO/OGeXLoxQM7iyXzl2ZMqsa52lZ1B+4HYj0Zb5Uctn/5O68Y35kLuPm9ri8XT5otFqsarFt3+WJ2S/VxoAmIouNh5FkrPxW2ujw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 23:05:49 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 23:05:49 +0000
Date: Thu, 20 Aug 2026 09:05:44 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>,
 Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, John Hubbard <jhubbard@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH v2 08/12] gpu: nova-core: mm: Add support to use PRAMIN
 windows to write to VRAM
Message-ID: <aoY1pT_TC1VSKMzQ@nvdebian.thelocal>
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
 <20260810-pramin-split-v2-8-65a00b3c7309@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-pramin-split-v2-8-65a00b3c7309@nvidia.com>
X-ClientProxiedBy: SY4P282CA0007.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA1PR12MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: e0361a85-aabb-4091-bcc1-08defe466867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|376014|366016|22082099003|18002099003|10067099003|56012099006|4143699003|11063799006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: k6Ze98XfvZTDuQA5UszAW7ojFAcYzvnxhDHfphvXp0CByawhG5TVRi77+Pydb4UjgzDg0R59UkY6yIHxwJs1lf15NhBs6T65pnhxeM/lhg7Tu2TrUX2xvUKV6i8BwDxcS9S+ONdb4jralLMgErsUqyfDC8cgn8HMQBbyebuyc0JwLOOeOdVZAnPKpjFQ2mdU6Z05fv4JLs8gHFY6PBym5+F9tfFEiI8ds7HofK8h24Fv1fSSarrxmKI8COafOwoSF+2fHrNvHk2RDYVVpVbihzuE3u5NtlMI1WmfEpNXIoH60UZW5w8BzFMtmAELOzKHkmRuN4CFZWacZOZTt/8/uZoLGu6Lz6bksGkYRiFW/LoySUMwa4YSu3tuoQtYFZb0gp3OsIfNy0KJDNVvS+Dk6kLcLDRxuMr40zG7BSsWGrYCYmHElk2uH3b8CfKoL8KGH7y7R9cVkyzfefU/mxCQw5Wm3PBIkSSzTldlOC2dQAVqdAREOi6THLT64wQqdjgTH8rPBs7RJPM0BrIg3gSWRNJ7UTK3thljt7JSw2ZUCuHgQVPR3JTeiFdE6wkXuChHDxhOSFs1USYbktIwIzLWPWUeMkkLFn58VRuhueY0SNeqvu+0UJDFhUXh24yF4cHGS2NFvWDXvVYSmBWYGnMZ0z+TMTAyOBsD0qTL5s/Qb5Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(22082099003)(18002099003)(10067099003)(56012099006)(4143699003)(11063799006)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rqmry2fUcdoX6Z13ksUWoiAA1xXMXrY+NjAReGLmPUytHbO+gOe3kZYIDY27?=
 =?us-ascii?Q?jttp3wQ1vbvs+j68tus2JVeruC/lUJ/qUhJ0yNhMdhPb1V9HvOJXmdjkEkj5?=
 =?us-ascii?Q?9FxsFnDNZWjwgDn9mvw/EVb6sIJAHh4DspVgC3PcmUjhg3cHJGRrp4IIvUjZ?=
 =?us-ascii?Q?ToSpzz3SofaqMRCe2iGEKyp1k2v45jSih2epd+PKNG/od7gasvwuj6MnB+fI?=
 =?us-ascii?Q?J+DPaPD+Ghst6MOwYQJQy7x7Cw7t39kuyIW2QntnE9BasFVHIvh24MLUMtlL?=
 =?us-ascii?Q?nXgZCi3xSyHoKnDkTh54PIJJpeGkJpyRpOmGOaU1sqT0HGeErBAo9wUvB4om?=
 =?us-ascii?Q?+7RtW5kiJS6q+ZUgGx8VPWygGrtBGFBuluQaU9GK5V4XbKZXFFms3fkfpn/d?=
 =?us-ascii?Q?SA7JVtNr2KSExxfC83p10MqIqAZ/S6v3lqrv0e15laQCYYL1SgfqAxG+CGlp?=
 =?us-ascii?Q?r3uSsFVomeyMXLPXlaMFM7OGoiZHsWOLn7dk59xoJo+GOgrZjRW+UYkIWD2p?=
 =?us-ascii?Q?sHtsBL+Cz9Nb03S4awRIjZF+FNTBGONmCr4EISSmxfTHyyo6QPxR3vJg9dmb?=
 =?us-ascii?Q?cYAlNWCKb/lXYy/jmL6bKR7nN1dE9PZMVvrsThmEPAu8Wqwar+fmoWNClf/G?=
 =?us-ascii?Q?9K6msuuf4XvV7ZGgkK0hypeBrmKqeiEzQCeqdOY7FHww9BkmVzItWKsEyRAP?=
 =?us-ascii?Q?y1zNLlswclZW875J7irfqwVb9Fb/gSMfMnAqXR8Xd0N7IQyob5h7juckYh6x?=
 =?us-ascii?Q?dBRBXVMDxOBwPgE7nYO4yehPDDykWdojE4j4PC6yHsT+KR4HS2c4m5r3UYtk?=
 =?us-ascii?Q?Ma99hZ3NyHdFkwP1oblyLZ14T0FikaMrS9r18+oRF9QYjEWc/7tI4FUOT5d0?=
 =?us-ascii?Q?tRrfqolWztUpaRH87YuHYV7dyCcU8E2SihI9GYAu5JzEPFwYeqlUEjnpHJnF?=
 =?us-ascii?Q?0KLoNNTIRWA/7Yqm94gzIkPg7Mx9GRrv/azCgK078s2RyyoITg6Vr5PVTMd3?=
 =?us-ascii?Q?K+m/RgVKprVvPHPEQ5Jznb3AuLcA6lbpg+opHxlwrBqV5h9m3+3nVA3/2241?=
 =?us-ascii?Q?NKFxxXTsV/rV7iHerlSgdOktUSTVNaUAKdB8VssQBwbVMMUYBNpwhtCdJiBg?=
 =?us-ascii?Q?iNuf7hy/CViz+6GIDmu0jjJtUn/jhtimFJuTuQTipAlkLVWIDtX61YvxWnHU?=
 =?us-ascii?Q?31uUh0qObKIOqWZVQgeKUf33Td3QArfZ1BTl+P4+RIUeseA+9pvN0O7cxkXe?=
 =?us-ascii?Q?cGSyj5vcFf/qT5YQUAPGU/+b7+Z4JGIlwkKMEYVNPpP5CHSyNq9tiCoe8e4o?=
 =?us-ascii?Q?6685CCup+8hbl431p/TtEiEWgRang7kp4JCzdShejgoOaW+ouBQpRQJV2zUo?=
 =?us-ascii?Q?QVyuciqFHjkBxxvVPgWi43RSRDbVmX3QxLpsY61KTZzYtt4uV0qanQuPEWDF?=
 =?us-ascii?Q?JU1bqEmKHkiyyLJ1c4N4FEQC0qqgXygWphU13raT0wQJr51hWOxxhrTOfpeB?=
 =?us-ascii?Q?I45jWNCgoUXXYLWt2rjRutkRGfSOpf/u9CZ7oRBF7mp0OY2kx9YdmxaLE3jk?=
 =?us-ascii?Q?upLgwnTMZ4EoAgyUTcjjql0sGiNHOA4I5tjhu8Z4BJFjdbZ08gMhiCWtBisu?=
 =?us-ascii?Q?4EftyxmTSuFAKWdccURd5OMHi8bPZ43fN51CNI3nS9zq/APpbiMoQYFBJMCT?=
 =?us-ascii?Q?Q7zVwLxPx7LESCymJTBUotBvBSf7SO/IbUWAj3+W/9JTsDesFTx+5TrZhVEu?=
 =?us-ascii?Q?bbcnscy1Tg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0361a85-aabb-4091-bcc1-08defe466867
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 23:05:48.9361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z98FQUwUxmTpOIEetDuWCQUPfEtUfcWy8no12Fu3cmeRIjRgQsZPaydiOwIkXpcxTpyyBBXbDmPyBaXpDhzLDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677
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

On 2026-08-10 at 23:55 +1000, Eliot Courtney <ecourtney@nvidia.com> wrote...
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> PRAMIN apertures are a crucial mechanism for direct CPU read/write to
> VRAM. Add a `Pramin` manager whose `window_at()` returns a typed MMIO
> view of VRAM through the 1 MiB PRAMIN aperture in BAR0, validating the
> view against the VRAM region and repositioning the window as needed for
> the accessed address.
> 
> A view borrows `Pramin` mutably, so the window cannot move while
> the view is in use, and it inserts an ordering point on Drop.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> [ecourtney: split the registers and HAL into the two preceding patches]
> [ecourtney: rebase w.r.t. Bar0 lifetime changes and register projections]
> [ecourtney: drop the window guard and mutex, use &mut self]
> [ecourtney: position at init to avoid reads, reposition in window_offset]
> [ecourtney: return typed MMIO views instead of read/write accessors]
> [ecourtney: insert an ordering read when a view drops]
> [ecourtney: declare the window location, drop the doc examples]
> [ecourtney: add the copyright header, doc and naming cleanups]
> [ecourtney: the pramin module is mm-internal]
> Co-developed-by: Eliot Courtney <ecourtney@nvidia.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/mm.rs        |   1 +
>  drivers/gpu/nova-core/mm/pramin.rs | 178 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 179 insertions(+)
> 
> diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
> index 07dce4ce2473..ef5b1cad56c3 100644
> --- a/drivers/gpu/nova-core/mm.rs
> +++ b/drivers/gpu/nova-core/mm.rs
> @@ -20,6 +20,7 @@
>  };
>  
>  mod hal;
> +mod pramin;
>  mod regs;
>  
>  /// Physical VRAM address in GPU video memory.
> diff --git a/drivers/gpu/nova-core/mm/pramin.rs b/drivers/gpu/nova-core/mm/pramin.rs
> new file mode 100644
> index 000000000000..20be3fc471ba
> --- /dev/null
> +++ b/drivers/gpu/nova-core/mm/pramin.rs
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> +
> +//! Utilities for accessing VRAM through the PRAMIN window.
> +
> +use core::ops::Range;
> +
> +use kernel::{
> +    io::{
> +        io_project,
> +        register,
> +        register::OffsetLoc,
> +        Io,
> +        Mmio, //
> +    },
> +    prelude::*,
> +    ptr::{
> +        Alignable,
> +        Alignment, //
> +    },
> +    sizes::{
> +        SZ_1M,
> +        SZ_64K, //
> +    },
> +};
> +
> +use crate::{
> +    driver::{
> +        Bar0,
> +        NovaRegisters, //
> +    },
> +    gpu::Chipset,
> +    mm::{
> +        hal::{
> +            self,
> +            MmHal, //
> +        },
> +        VramAddress, //
> +    },
> +    num::IntoSafeCast, //
> +};
> +
> +/// Size of the PRAMIN window (1 MiB).
> +const WINDOW_SIZE: usize = SZ_1M;
> +
> +/// The PRAMIN window, which is a 1 MiB window into VRAM at a fixed BAR0 offset.
> +#[derive(FromBytes, IntoBytes)]
> +struct PraminWindow([u8; WINDOW_SIZE]);
> +
> +register! {
> +    base: NovaRegisters;

I tried building this on drm-rust-next against the base commit
(4c9ba407018e8deb06dbc643112bac8f40404f95) but am getting some build errors:

error: no rules expected `:`
   --> /data/source/linux/drivers/gpu/nova-core/mm/pramin.rs:51:9
    |
 51 |     base: NovaRegisters;
    |         ^ no rules expected this token in macro call
    |
note: while trying to match `(`
   --> /data/source/linux/rust/kernel/io/register.rs:809:52
    |
809 |             $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
    |                                                    ^

I'm guessing maybe because this depends on some other series that isn't in
drm-rust-next or something in drm-rust-next has changed things here.

There are a couple of others with this series applied as well:

error: no rules expected `build`
   --> /data/source/linux/drivers/gpu/nova-core/mm/pramin.rs:115:39
    |
115 |         let window = io_project!(bar, build: PRAMIN);
    |                                       ^^^^^ no rules expected this token in macro call
    |
note: while trying to match `,`
   --> /data/source/linux/rust/kernel/ptr/projection.rs:319:21
    |
319 |     (@gen $ptr:ident, ) => {};
    |                     ^

error: no rules expected reserved keyword `try`
   --> /data/source/linux/drivers/gpu/nova-core/mm/pramin.rs:174:45
    |
174 |         let view = io_project!(self.window, try: OffsetLoc::new(offset));
    |                                             ^^^ no rules expected this token in macro call
    |
note: while trying to match `,`
   --> /data/source/linux/rust/kernel/ptr/projection.rs:319:21
    |
319 |     (@gen $ptr:ident, ) => {};
    |                     ^

error: no rules expected `:`
   --> /data/source/linux/drivers/gpu/nova-core/mm/regs.rs:29:9
    |
 29 |     base: NovaRegisters;
    |         ^ no rules expected this token in macro call
    |
note: while trying to match `(`
   --> /data/source/linux/rust/kernel/io/register.rs:809:52
    |
809 |             $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
    |                                                    ^

error: no rules expected `:`
   --> /data/source/linux/drivers/gpu/nova-core/mm/regs.rs:46:13
    |
 46 |         base: NovaRegisters;
    |             ^ no rules expected this token in macro call
    |
note: while trying to match `(`
   --> /data/source/linux/rust/kernel/io/register.rs:809:52
    |
809 |             $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
    |                                                    ^

error: no rules expected `:`
   --> /data/source/linux/drivers/gpu/nova-core/mm/regs.rs:62:13
    |
 62 |         base: NovaRegisters;
    |             ^ no rules expected this token in macro call
    |
note: while trying to match `(`
   --> /data/source/linux/rust/kernel/io/register.rs:809:52
    |
809 |             $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
    |                                                    ^

error: aborting due to 6 previous errors

 - Alistair

> +
> +    /// Location of the window inside BAR0.
> +    PRAMIN: PraminWindow @ 0x700000;
> +}
> +
> +/// Owner of the PRAMIN window state.
> +///
> +/// [`Pramin::window_at()`] repositions the window as needed and returns a typed MMIO view into
> +/// it, holding the manager borrowed for the lifetime of the view.
> +pub(super) struct Pramin<'gpu> {
> +    bar: Bar0<'gpu>,
> +    hal: &'static dyn MmHal,
> +    /// MMIO view of the PRAMIN window in BAR0.
> +    window: Mmio<'gpu, PraminWindow>,
> +    /// VRAM range to keep the PRAMIN window inside.
> +    vram_range: Range<VramAddress>,
> +    /// Cached window position.
> +    window_range: Range<VramAddress>,
> +}
> +
> +/// Typed view of VRAM through the PRAMIN window.
> +///
> +/// Inserts an ordering point after previous writes through the window on drop. Views returned
> +/// by [`PraminAccess::view()`] cannot outlive this access, so the ordering point covers every
> +/// write made through them.
> +pub(super) struct PraminAccess<'a, T>
> +where
> +    T: FromBytes + IntoBytes,
> +{
> +    view: Mmio<'a, T>,
> +}
> +
> +impl<T> PraminAccess<'_, T>
> +where
> +    T: FromBytes + IntoBytes,
> +{
> +    /// Returns the MMIO view of the accessed location.
> +    pub(super) fn view(&self) -> Mmio<'_, T> {
> +        self.view
> +    }
> +}
> +
> +impl<T> Drop for PraminAccess<'_, T>
> +where
> +    T: FromBytes + IntoBytes,
> +{
> +    fn drop(&mut self) {
> +        // Insert an ordering point after previous writes through this window.
> +        self.view.cast::<u8>().read_val();
> +    }
> +}
> +
> +impl<'gpu> Pramin<'gpu> {
> +    /// Alignment required by the PRAMIN window.
> +    const BASE_ALIGN: Alignment = Alignment::new::<SZ_64K>();
> +
> +    /// Creates the window manager for the given VRAM region.
> +    pub(super) fn new(
> +        bar: Bar0<'gpu>,
> +        chipset: Chipset,
> +        vram_range: Range<VramAddress>,
> +    ) -> Result<Self> {
> +        let hal = hal::mm_hal(chipset);
> +        let window = io_project!(bar, build: PRAMIN);
> +        let base = vram_range.start.align_down(Self::BASE_ALIGN);
> +        let window_range = Self::window_range(base)?;
> +        hal.write_pramin_window_base(bar, base)?;
> +
> +        Ok(Self {
> +            bar,
> +            hal,
> +            window,
> +            vram_range,
> +            window_range,
> +        })
> +    }
> +
> +    /// Returns the VRAM range a window based at `base` exposes.
> +    fn window_range(base: VramAddress) -> Result<Range<VramAddress>> {
> +        let end = base
> +            .checked_add(WINDOW_SIZE.into_safe_cast())
> +            .ok_or(EINVAL)?;
> +        Ok(base..end)
> +    }
> +
> +    /// Check the window covers `len` bytes at `addr`, moving it if needed.
> +    ///
> +    /// Returns the window offset at which to perform the access.
> +    fn window_offset(&mut self, addr: VramAddress, len: usize) -> Result<usize> {
> +        let end = addr.checked_add(len.into_safe_cast()).ok_or(EINVAL)?;
> +
> +        let inside = |r: &Range<VramAddress>| r.contains(&addr) && end <= r.end;
> +        if !inside(&self.vram_range) {
> +            return Err(EINVAL);
> +        }
> +
> +        // Reposition the window if the access falls outside it.
> +        if !inside(&self.window_range) {
> +            let base = addr.align_down(Self::BASE_ALIGN);
> +            let window_range = Self::window_range(base)?;
> +            if !inside(&window_range) {
> +                return Err(EINVAL);
> +            }
> +            self.hal.write_pramin_window_base(self.bar, base)?;
> +            self.window_range = window_range;
> +        }
> +
> +        Ok((addr - self.window_range.start).into_safe_cast())
> +    }
> +
> +    /// Return a typed MMIO view of a `T` at `vram_addr`.
> +    ///
> +    /// Returns an error if `vram_addr` is not aligned to `T`'s alignment, or if
> +    /// a `T` at `vram_addr` does not fit within the VRAM region.
> +    pub(super) fn window_at<'a, T>(
> +        &'a mut self,
> +        vram_addr: VramAddress,
> +    ) -> Result<PraminAccess<'a, T>>
> +    where
> +        T: FromBytes + IntoBytes,
> +    {
> +        let offset = self.window_offset(vram_addr, size_of::<T>())?;
> +        let view = io_project!(self.window, try: OffsetLoc::new(offset));
> +
> +        Ok(PraminAccess { view })
> +    }
> +}
> 
> -- 
> 2.55.0
> 
