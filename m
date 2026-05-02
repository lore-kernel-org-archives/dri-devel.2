Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B9CCD13DA
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 15:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 280A910E290;
	Sat,  2 May 2026 15:42:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="uuJ6ZgnY";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62BB310E296
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 15:42:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsxxBSpHQkmK9Wrwihvv+c5wHQnssOzpry7nUipZtR6Kl4jbe8cqLnV3Ii0Rt6zvc/eDo98VvvvxB3tRr0SDf+mVO5xSRSjpntcJuuf98iS8m7tQPXV+XH3AR5AS1fvuuAOpVWt3F5ntAUzUw/MfyK3RiDOSsc1DDuFPhuqMf6HUk4hI+7GG1Ckoo0fRpg9e2w8GQ3+qzHW4FWofrNC/jLT/0T5uCkDh91TQGcGLlTZQd9sIozpS8WyRiPQolgncIYoLsCAoSwB/Ec2GfshZGkgTKP9um6RSgWPzSPTgZl7yWOsY5kKX8sFKcoCDH8/sFjMjNgXGc2qwHJcVYtC54A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFaSpUoi6gGcQS/7Jj4Sf7jqYj4ovznyeVM1R1gd53E=;
 b=yCavQteyZuutOgPBVeIh/QDigXYgIdOWNavd1CvZhK1hmGBWGq7V+m9/SKeRP4XXO6FRzruj/zi71plyavfaaPRtYMXB62njT6GNKSo516lnUHOK6EL91tkX2AP5Yg0sPkWn1YdXy5nGILfVCQc0a0801TTim6vy4Zy5QQnMEitBFJv+UBOLs9qLjOPPUdaVMK/3ysyei2aHXWb7p3tTefA3H797TecztYGC+xdR7GhkVF4BwAu6cUEJFDglF+kOyk78n+lYU8adfa8wEhK9w4E/kUshAj3w1tunDf1nDU6hFCvqS7KDt0IEthEA2GJy3c+5b9vj1ZGzEDzh7TaEfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFaSpUoi6gGcQS/7Jj4Sf7jqYj4ovznyeVM1R1gd53E=;
 b=uuJ6ZgnYhilxamrMVN4PGK7eFmhiEnmuDzktndj0gUvck73SA4byaZX1mQEyvKGhW27ZeVI62hVtjZ8mB5soSZ23nNK27twKkzoQPVi20zWtK6gCHDGXSCtEjqnTt57JGJ6DEmQBUAGaDYrnc67LzAiKy33FlLZ18+ckrumVJUf1xN+tIkOgPn6/s+B6rtm0da3W6xZNBC8Qsq1lKM19NtLP+ss4abE+T+Vg3urm7Xf1x1hAD9E9wRCHs2X8wdKHqRur1Pj9GeJMaoxnOK9bgagyEImYSUzR2L13Sh/87iV9M+h+H27DfnJPVt4FkAAH57t6Otezyx/8gon7QEeo5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Sat, 2 May
 2026 15:41:59 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 15:41:59 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 03 May 2026 00:41:55 +0900
Message-Id: <DI8B0103X0HQ.7C99YLBMS2X5@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Bjorn Roy
 Baron" <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Dave Airlie" <airlied@redhat.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>, "Nikola
 Djukic" <ndjukic@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Edwin Peer" <epeer@nvidia.com>, "Andrea Righi" <arighi@nvidia.com>, "Andy
 Ritger" <aritger@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Balbir Singh"
 <balbirs@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>,
 <alexeyi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <joel@joelfernandes.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v12 04/22] gpu: nova-core: mm: Add support to use PRAMIN
 windows to write to VRAM
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-5-joelagnelf@nvidia.com>
In-Reply-To: <20260425211454.174696-5-joelagnelf@nvidia.com>
X-ClientProxiedBy: TY4P286CA0137.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: b09c00e3-1147-4d0b-952d-08dea86158d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yFAa8OY65H0Y93yF8yX3+zT6bjdWxLUYTsJgBdZPmojrdn9ERSVp6iuVKfM3e4dvIwRKVMB7jMx7R84nVL1be7BZLURF+mISJ2kmbxUbsVcCJPKWphPTEYY9ktPAOIukpAqiKWXgUcwPz/utEU+aVa0eivpc9Kimzsg2aTClHgSEYKx2aOQnkB4gVSsXV7yaNHyM7+Es9W3l84h0xVaicT8B2uNYMdBdyG1F9q6Ry/Rz9uCVnjtBizrhw23zKlVhvZ+N4IZ5o55hQkDWAad1zRRmP0ximjWJVDJnRaZ3u1SpPMqDAVegfjhOo/K8Lko4H9fuck++Ym2cHcJ3fPoiaf5QIGat+DnPyLhjBzEWDAHi+9tExloLNWPVcBYuOSnrmZRKm6PcHsFP0tb95+TCeJDXRQKEBxhgR7y9SHt3OqV/V2BxyWI2dr75lNLTN1UW5m58/0ViaT+x2ybNJxh00U4z+vfmujY40o8vfcSKWBkI65+XFMxhFXdt13VaEQpKaxMju60y6xHx6SKGPyAJpDAOrK9tWFARYt+sMo10Lac2Y18gmtlshhvIU7Q8+dYCcr/oR4GBMGV7xTNNKb9rPUFo12+KLZlxD6pN97quAxW6o5UPAcJkYW0S8qzwttB+4Ve74cq62Gljaw6VrSRde8iVIAdfjiw6bXv/BYYwH7cawe6AeOwiudK6v29EyTOI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHFSZmpkbDBrWlBaZkxqMHlsZ0dBR3FoaEgwc2RzSmlGYisraFFxbU5pVnph?=
 =?utf-8?B?RzBReHJ0VHB4WWRwV0xwR3czZEdRTitjdmNSVG42YmFoYUgxWUpTVjhqVVZ3?=
 =?utf-8?B?Tk1lYmhLUW56Z0wxeG1YUGJsQ3YzQWZ3R0xIaGtXNWZGQnVpU3hpVUdnUUpN?=
 =?utf-8?B?eXN0N2g1WWNuV2lTWXJkenJuSW9ySXlhYlpUbjFPdit1TmZvaGpUVkU4NWZj?=
 =?utf-8?B?MTJ0d2ZZUkQxRGxoWWthcTJ5VENsU2lEK1VmdEJjN1p5MWtFb2NjNHZDZHJD?=
 =?utf-8?B?SkpscTluSm1kaXVLb3JhUHBIL0xDN1lFL1diMHljRnBLYTZybnZVN0hPdldY?=
 =?utf-8?B?QmJNdTUrVlU4ZVp5aUxxbVo4VFpjelRhTVd3RnBDaXFHNXp5M0lNbmpYVy9t?=
 =?utf-8?B?aUVDYzFDYjNpVysrOG9jVkdzbTNTdnVkOWdYeWNlQWJxcHVLY0YzN1FXNEwr?=
 =?utf-8?B?SnpTL0J2ZDdMUTNUVWRjVTU5NUo5VHVqbWNzOXNDUWdhakVqai96Ym81MUY0?=
 =?utf-8?B?UkJHaHFTczdCMnlicDMzMG5jREpaTUxUMGNUZ2Q1ZllZSVVEelNDdk9TaEV4?=
 =?utf-8?B?Yy9WS25PSHJFN1Q3dVVzcVEyQU9SbVk2WDBOd2dNN0JHZzVGWSt6MGZOTll5?=
 =?utf-8?B?WjZ6c3pwcHhDTDlmRnY4OTN2T0t3WHE4dzFSUXhlQllTTXcrNEQzQWxrRjZz?=
 =?utf-8?B?QVpUUkdRb2xJUk9yNW0xcUEwRkNMNHg4YUNseFJWc3FMRURpeFVxYTA2cjg2?=
 =?utf-8?B?RzNDRGlqZUYzMHFFSGFLdEhGUVVFRjdmNUhkNzdlV0lZRXRIUGJZVkI3RzR0?=
 =?utf-8?B?dlNCdE9kSzNvaC9MdnhtNWRnY1FFbnpNSVB3REovZCtjTmlrUUJRY2lCQU45?=
 =?utf-8?B?aENmQXQwTHpjZDZVQjRQK3VPWGhZVVVnQjRQY0hYYys4SmtlYWpYR3FSMHB2?=
 =?utf-8?B?Rk8wczBEMHdsMXFiSndKME9EM0xoU3NXSDlCNTBSaHRieDVMQlpvRUJxY0pu?=
 =?utf-8?B?RzFrVWYyWFJuMDFuUVIzZUREN242cnR3NjNNT05zWm51VTFDNXZZeDhEcWRJ?=
 =?utf-8?B?UVZrSDRabVhpeFRyVVlYakk4YkJwZEoyQU9OUHAyNGJPSFpJa09qSVFUeWN5?=
 =?utf-8?B?SUtJMG1ROSt4T1lHMGoreUVlSEhnSWRwTWFCanh1U09FSHpyZm9GcjUycG00?=
 =?utf-8?B?dFIwTFE1RmVTZVVoYkhTaEFVZmpWbFZZNnVqSC9rQVpHZzRtU2ppeVBhNUZU?=
 =?utf-8?B?eDAyNi9QOFVXNFlPNjRXdVVvMnRRUEVPaTJEMUZmc1N0U3loWkN3MVdWK2N5?=
 =?utf-8?B?QzJWaFdDUDJvTU5jNzk5T2xQYUxPbXU4YUlOUnBiampkNzJsc3JyQmVMQ2Nm?=
 =?utf-8?B?ZjdxQ2t1MEd5UTM4QmNHdndQS0xFNHBVRHJpb1ZxS3p1dGp0SXptY2c1QXMr?=
 =?utf-8?B?OWVrVkdQdVpnT0hOcmtkK1hIdDMxNEtsamJnTFgzR2o2M3BlZjl5TUhLRWJJ?=
 =?utf-8?B?Slp1bFF3cVJMQkIzb0wydmZzNkVSSFhPTUszd0NDVHBvT3dsYkdCS1FlaG5I?=
 =?utf-8?B?RE4rUW4wLzlTVDJmdjkrVmJXbHdPbGRzaHRjV1I2Y2dDNGRlSTJMRU9jejNm?=
 =?utf-8?B?RWYwS1BhS0puSlJmcG95YkUyWm4yQWlnMHpub01KQ21CblFMdU1tVGxrODY2?=
 =?utf-8?B?dWw2ZnZKUkNCaitmL0o0Q0lpSHBjT3BKY0I3Zm40VmlSdk9nSkh5NE9ZTFlR?=
 =?utf-8?B?TlVqMnJ1dkp2dFN1anVWeEo4bS92V1laVnRsQlI3bE4zZTRCVDk0MUQ5N3F0?=
 =?utf-8?B?emtoUGdYMzJqUTVCVyt1M1J6VklTbVArN1pMaUVHZ1ZIZk95T2pOUTdpUkgw?=
 =?utf-8?B?MnRxQ0dVcWM4dkt1NEFpa09ZcDVlV0JpRzdzYlZtK2JpTEFuVmIzSjU2QUYv?=
 =?utf-8?B?d1Z0aVlxR3FyMXJuMnFtL0ViL3hicUZnM2xLQ2kydlpWa0JNeStKcytwWlAw?=
 =?utf-8?B?eUUrRmhWMWQ5ZFpxMG94UXZxSVE2SGpnM2c0YUpIYkVPQ0FVaXI3TUpZaFN6?=
 =?utf-8?B?a2RVZ1JwVXR5YWxHbjB2amNHUHJIUUNrajREcHVhT0kvU3lJN0lHd0JDZHdy?=
 =?utf-8?B?Z3FHN01CUkdMZi81Mjd6VjNmditWbTR0VDEwZzREa0hkcWw5NGFmU1Zkemhj?=
 =?utf-8?B?WGtObkJRMVZteVdQSTFWUGFuVkcyRll1bTBka1lvb24wS1pnb0J5Vy85MGhj?=
 =?utf-8?B?SlB0YUlMOXpHNFkzRW9IUkZHZk0vVkRoaGFYMWQyTFVxWFYzcFB4emJTL2RQ?=
 =?utf-8?B?bHdYU2RIZ2VXVFRMSURnMm9VZ2M1dko2aEpyTndkTmNJUE9GdzNjTFR5WVBO?=
 =?utf-8?Q?niN2p2QarneCasJZ0oH8dmR9pdoYawn8GslTphCerwdWq?=
X-MS-Exchange-AntiSpam-MessageData-1: MtJkdRaxOAnzPg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09c00e3-1147-4d0b-952d-08dea86158d6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 15:41:59.1858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2r94uRj3Jmb2XJnxGfGc5MOgNObDo8Rjbx2ZUQblf4Ug1FNxDMZ3R5LSzCEjiNQuBfTYOeinDuJct3dGShQtGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9591
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

On Sun Apr 26, 2026 at 6:14 AM JST, Joel Fernandes wrote:
<snip>
> PRAMIN apertures are a crucial mechanism to direct read/write to VRAM.
> Add support for the same.
>
> Cc: Nikola Djukic <ndjukic@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  drivers/gpu/nova-core/mm.rs        |   5 +
>  drivers/gpu/nova-core/mm/pramin.rs | 300 +++++++++++++++++++++++++++++
>  drivers/gpu/nova-core/nova_core.rs |   1 +
>  drivers/gpu/nova-core/regs.rs      |  10 +
>  4 files changed, 316 insertions(+)
>  create mode 100644 drivers/gpu/nova-core/mm.rs
>  create mode 100644 drivers/gpu/nova-core/mm/pramin.rs
>
> diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
> new file mode 100644
> index 000000000000..7a5dd4220c67
> --- /dev/null
> +++ b/drivers/gpu/nova-core/mm.rs
> @@ -0,0 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Memory management subsystems for nova-core.
> +
> +pub(crate) mod pramin;
> diff --git a/drivers/gpu/nova-core/mm/pramin.rs b/drivers/gpu/nova-core/m=
m/pramin.rs
> new file mode 100644
> index 000000000000..57b560ae1e85
> --- /dev/null
> +++ b/drivers/gpu/nova-core/mm/pramin.rs
> @@ -0,0 +1,300 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Direct VRAM access through the PRAMIN aperture.
> +//!
> +//! PRAMIN provides a 1MB sliding window into VRAM through BAR0, allowin=
g the CPU to access
> +//! video memory directly. Access is managed through a two-level API:
> +//!
> +//! - [`Pramin`]: The parent object that owns the BAR0 reference and syn=
chronization lock.
> +//! - [`PraminWindow`]: A guard object that holds exclusive PRAMIN acces=
s for its lifetime.
> +//!
> +//! The PRAMIN aperture is a 1MB region at a fixed offset from BAR0. The=
 window base is
> +//! controlled by an architecture-specific register and is 64KB aligned.
> +//!
> +//! # Examples
> +//!
> +//! ## Basic read/write
> +//!
> +//! ```no_run
> +//! use crate::driver::Bar0;
> +//! use crate::gpu::Chipset;
> +//! use crate::mm::pramin;
> +//! use kernel::device;
> +//! use kernel::devres::Devres;
> +//! use kernel::prelude::*;
> +//! use kernel::sync::Arc;
> +//!
> +//! fn example(
> +//!     devres_bar: Arc<Devres<Bar0>>,
> +//!     dev: &device::Device<device::Bound>,
> +//!     chipset: Chipset,
> +//!     vram_region: core::ops::Range<u64>,
> +//! ) -> Result<()> {
> +//!     let pramin =3D Arc::pin_init(
> +//!         pramin::Pramin::new(devres_bar, dev, chipset, vram_region)?,

`Pramin::new` takes different arguments (also check the other examples).

> +//!         GFP_KERNEL,
> +//!     )?;
> +//!     let mut window =3D pramin.get_window(dev)?;
> +//!
> +//!     // Write and read back.
> +//!     window.try_write32(0x100, 0xDEADBEEF)?;
> +//!     let val =3D window.try_read32(0x100)?;
> +//!     assert_eq!(val, 0xDEADBEEF);
> +//!
> +//!     Ok(())
> +//! }
> +//! ```
> +//!
> +//! ## Auto-repositioning across VRAM regions
> +//!
> +//! ```no_run
> +//! use crate::driver::Bar0;
> +//! use crate::gpu::Chipset;
> +//! use crate::mm::pramin;
> +//! use kernel::device;
> +//! use kernel::devres::Devres;
> +//! use kernel::prelude::*;
> +//! use kernel::sync::Arc;
> +//!
> +//! fn example(
> +//!     devres_bar: Arc<Devres<Bar0>>,
> +//!     dev: &device::Device<device::Bound>,
> +//!     chipset: Chipset,
> +//!     vram_region: core::ops::Range<u64>,
> +//! ) -> Result<()> {
> +//!     let pramin =3D Arc::pin_init(
> +//!         pramin::Pramin::new(devres_bar, dev, chipset, vram_region)?,
> +//!         GFP_KERNEL,
> +//!     )?;
> +//!     let mut window =3D pramin.get_window(dev)?;
> +//!
> +//!     // Access first 1MB region.
> +//!     window.try_write32(0x100, 0x11111111)?;
> +//!
> +//!     // Access at 2MB - window auto-repositions.
> +//!     window.try_write32(0x200000, 0x22222222)?;
> +//!
> +//!     // Back to first region - window repositions again.
> +//!     let val =3D window.try_read32(0x100)?;
> +//!     assert_eq!(val, 0x11111111);
> +//!
> +//!     Ok(())
> +//! }
> +//! ```
> +
> +#![expect(unused)]
> +
> +use core::ops::Range;
> +
> +use crate::{
> +    bounded_enum,
> +    driver::Bar0,
> +    num::IntoSafeCast,
> +    regs, //
> +};
> +
> +use kernel::{
> +    devres::Devres,
> +    io::Io,
> +    new_mutex,
> +    num::Bounded,
> +    prelude::*,
> +    revocable::RevocableGuard,
> +    sizes::{
> +        SZ_1M,
> +        SZ_64K, //
> +    },
> +    sync::{
> +        lock::mutex::MutexGuard,
> +        Arc,
> +        Mutex, //
> +    },
> +};
> +
> +bounded_enum! {
> +    /// Target memory type for the BAR0 window register.
> +    ///
> +    /// Only VRAM is supported; Hopper+ GPUs do not support other target=
s.
> +    #[derive(Debug)]
> +    pub(crate) enum Bar0WindowTarget with TryFrom<Bounded<u32, 2>> {
> +        /// Video RAM (GPU framebuffer memory).
> +        Vram =3D 0,
> +    }
> +}
> +
> +/// PRAMIN aperture base offset in BAR0.
> +const PRAMIN_BASE: usize =3D 0x700000;
> +
> +/// PRAMIN aperture size (1MB).
> +const PRAMIN_SIZE: usize =3D SZ_1M;
> +
> +/// Generate a PRAMIN read accessor.
> +macro_rules! define_pramin_read {
> +    ($name:ident, $ty:ty) =3D> {
> +        #[doc =3D concat!("Read a `", stringify!($ty), "` from VRAM at t=
he given offset.")]
> +        pub(crate) fn $name(&mut self, vram_offset: usize) -> Result<$ty=
> {
> +            let (bar_offset, new_base) =3D
> +                self.compute_window(vram_offset, ::core::mem::size_of::<=
$ty>())?;
> +
> +            if let Some(base) =3D new_base {
> +                Self::write_window_base(&self.bar, base)?;
> +                *self.state =3D base;
> +            }
> +            self.bar.$name(bar_offset)
> +        }
> +    };
> +}
> +
> +/// Generate a PRAMIN write accessor.
> +macro_rules! define_pramin_write {
> +    ($name:ident, $ty:ty) =3D> {
> +        #[doc =3D concat!("Write a `", stringify!($ty), "` to VRAM at th=
e given offset.")]
> +        pub(crate) fn $name(&mut self, vram_offset: usize, value: $ty) -=
> Result {
> +            let (bar_offset, new_base) =3D
> +                self.compute_window(vram_offset, ::core::mem::size_of::<=
$ty>())?;
> +
> +            if let Some(base) =3D new_base {
> +                Self::write_window_base(&self.bar, base)?;
> +                *self.state =3D base;
> +            }
> +            self.bar.$name(value, bar_offset)
> +        }
> +    };
> +}
> +
> +/// PRAMIN aperture manager.
> +///
> +/// Call [`Pramin::get_window()`] to acquire exclusive PRAMIN access.
> +#[pin_data]
> +pub(crate) struct Pramin {
> +    bar: Arc<Devres<Bar0>>,

The HRT series [1] will allow you to greatly simplify all this by
storing a `&'a Bar0` directly in this structure. It will most likely
land this cycle, so I think it's a good idea to proactively depend on
them. It should apply cleanly (modulo the Tyr patches IIRC, but you can
skip them if you don't build the driver) on top of `drm-rust-next` - on
top of which this should also be rebased anyway.

[1] https://lore.kernel.org/all/20260427221155.2144848-1-dakr@kernel.org/

> +    /// Valid VRAM region. Accesses outside this range are rejected.
> +    vram_region: Range<u64>,

I don't think that checking the range in this type is particularly
useful, because this abstraction cannot validate VRAM ownership
completely: VRAM can be sparse, reserved, or protected, and with the
current bound access to these invalid areas is not prevented.

PRAMIN should only model the hardware windowing mechanism; address
validity belongs to the higher layers that allocate or obtain those
addresses. IIUC nothing will explode if we try to read or write into
areas that are not VRAM.

> +    /// PRAMIN aperture state, protected by a mutex.
> +    ///
> +    /// # Invariants
> +    ///
> +    /// This lock is acquired during the DMA fence signaling critical pa=
th.
> +    /// It must NEVER be held across any reclaimable CPU memory / alloca=
tions
> +    /// (`GFP_KERNEL`), because the memory reclaim path can call
> +    /// `dma_fence_wait()`, which would deadlock with this lock held.
> +    #[pin]
> +    state: Mutex<u64>,

The problem with this lock is that it is buried, alongside its usage
guide, deep into this type, ensuring that users won't ever see it. It
will create deadlocks rather than preventing them.

And when you look closer at it, you realize it is actually acquired for
any use of `Pramin`, since the only method it exposes is `get_window`,
which acquires the lock, and returns a `PraminWindow` which has exactly
the same layout as `Pramin`, except that the lock is acquired.

So what's the point? Let's just make `get_window` require a `&mut self`
and let the owner of `Pramin` decide how to manage concurrent accesses.
At least the doccomment for the lock will be visible from a higher
layer.

Currently `Pramin` mixes elements of hardware access, memory management,
and synchronization into the same type, squashing what should be
different layers into a single one. Now that the `Io` trait is merged
and available in `drm-rust-next`, it is a good time to implement the
feedback I gave on v8. Roughly:

- `Pramin` should just be the owner and arbiter of the
  `NV_PBUS_BAR0_WINDOW` register. Its `get_window(&mut self,
  window_base: Bounded<u64, 24>)` method simply returns a window to the
  1MB area starting from `base << 16`. It's the simplest possible
  abstraction.
- The returned window implements `Io` and `IoKnownSize`. This will allow
  users to do all the fancy stuff that comes with `Io`, including
  projections.

  This API will also be perfect for cases like e.g. setting a memory
  page to zero: just give the start of the page to `get_window`, zap the
  first 4K of the window, done.
- Random accesses to VRAM, which are needed for walking the page tables
  and updating them, can be built on top of this simple API. Either by
  adding read/write ops directly to `Pramin`, or by defining another
  type that owns a `&mut Pramin` and moves the window automatically if
  the next access is out of bounds. This should result in window
  management code that is simpler than the current `compute_window`.

That's really all we need. Then `GpuMm` can manage concurrency similarly
to the current model by wrapping `Pramin` inside a `Mutex`, and is also
free to experiment with different locking strategies, something the
current design doesn't allow.

> +}
> +
> +impl Pramin {
> +    /// Create a pin-initializer for PRAMIN.
> +    ///
> +    /// `vram_region` specifies the valid VRAM address range.
> +    pub(crate) fn new(
> +        bar: Arc<Devres<Bar0>>,
> +        vram_region: Range<u64>,
> +    ) -> Result<impl PinInit<Self>> {
> +        let bar_access =3D bar.try_access().ok_or(ENODEV)?;
> +        let current_base =3D Self::read_window_base(&bar_access);
> +
> +        Ok(pin_init!(Self {
> +            bar,
> +            vram_region,
> +            state <- new_mutex!(current_base, "pramin_state"),
> +        }))
> +    }
> +
> +    /// Acquire exclusive PRAMIN access.
> +    ///
> +    /// Returns a [`PraminWindow`] guard that provides VRAM read/write a=
ccessors.
> +    /// The [`PraminWindow`] is exclusive and only one can exist at a ti=
me.
> +    pub(crate) fn get_window(&self) -> Result<PraminWindow<'_>> {
> +        let bar =3D self.bar.try_access().ok_or(ENODEV)?;
> +        let state =3D self.state.lock();
> +        Ok(PraminWindow {
> +            bar,
> +            vram_region: self.vram_region.clone(),
> +            state,
> +        })
> +    }
> +
> +    /// Read the current window base from the BAR0_WINDOW register.
> +    fn read_window_base(bar: &Bar0) -> u64 {
> +        let reg =3D bar.read(regs::NV_PBUS_BAR0_WINDOW);
> +
> +        // TODO: Convert to Bounded<u64, 40> when available.

It's available. :)

> +        u64::from(reg.window_base()) << 16
> +    }

I think this method (and `write_window_base`) should be methods of the
`NV_PBUS_BAR0_WINDOW` register (`window_base` and `set_window_base`)

> +}
> +
> +/// PRAMIN window guard for direct VRAM access.
> +///
> +/// This guard holds exclusive access to the PRAMIN aperture. The window=
 auto-repositions
> +/// when accessing VRAM offsets outside the current 1MB range.
> +///
> +/// Only one [`PraminWindow`] can exist at a time per [`Pramin`] instanc=
e (enforced by the
> +/// internal `MutexGuard`).
> +pub(crate) struct PraminWindow<'a> {
> +    bar: RevocableGuard<'a, Bar0>,
> +    vram_region: Range<u64>,
> +    state: MutexGuard<'a, u64>,
> +}
> +
> +impl PraminWindow<'_> {
> +    /// Write a new window base to the BAR0_WINDOW register.
> +    fn write_window_base(bar: &Bar0, base: u64) -> Result {
> +        // CAST: After >> 16, a VRAM address fits in u32.
> +        let window_base =3D (base >> 16) as u32;
> +        bar.write_reg(
> +            regs::NV_PBUS_BAR0_WINDOW::zeroed()
> +                .with_target(Bar0WindowTarget::Vram)
> +                .try_with_window_base(window_base)?,
> +        );
> +        Ok(())
> +    }
> +
> +    /// Compute window parameters for a VRAM access.
> +    ///
> +    /// Returns (`bar_offset`, `new_base`) where:
> +    /// - `bar_offset`: The BAR0 offset to use for the access.
> +    /// - `new_base`: `Some(base)` if window needs repositioning, `None`=
 otherwise.
> +    fn compute_window(
> +        &self,
> +        vram_offset: usize,

This should be a `u64`, since it is a VRAM address.

Actually, I noticed that you introduced a `VramAddress` type in a latter
patch. It might be worth introducing it earlier and using it everywhere
a VRAM address is involved, that way we cannot make any mistake - not
critical for now, but feel free to do it if you think it helps.
