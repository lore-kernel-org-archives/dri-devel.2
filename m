Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA80CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 23:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7AF010E27E;
	Wed, 30 Sep 2026 23:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="GMZQmSND";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013017.outbound.protection.outlook.com
 [40.107.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5382E10E27E
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 23:08:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfGc2jUnT3/tYT8TcVu16+KHh4HPZNtmpNGwVyByaS/K2ovJv3HLxFrS1AF9U8hMwc00k5eXxjuanZq+MtegbRhEWUnHa7hoQ78hEw1WVUfZjddDPNrEmIgrhlYbSl5ilck5Z9lEt2M0zylt4WiqNIMbvTXpAkTXLgtONYbb1eZqDeFaiwXeW4Ochjz1eHFfCDdvLmxftIkpDFACjQAckma1h/HbEhpZtR9FpZO3iM55DAj4kUBnmV1PMAGKpRMlmggDM0jy2wczoAlbO4E57xxnBs7yeYSUaUKe0iaaWXw/vYkg2qvz412mPB4Y2yKRdq6wY6t9op/EZWeD3NvFbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5pP3fvwKuAxQUlcI1EBqHqqGgV3BlIaWBl9f5lFVU0=;
 b=aOBNO8vUyZ+al8cQM009+nE1eRpdmCKLzotDLn7Y3U8L4cZR5pJ2/OvFiPO05nEclY23r6ENFNEtPO76R+C+g/URUZuZ5PkwHluobBc+sVVxz53LPgjaXdXUOzqyOk81KpS2iJ9UPQZojetS0zBcnN78fCYJqS9ioAa4iSCMAtaXB3XakSkFdgoi7BQ1ZEXrOAhzgeHD56jefvV7phz9m/eGdHK3j98GxK0U93h95fDHtV9PSApQeotW8B0xphR1iII5Yn69fc/lbiT1w1QPeA+Y+9osHE25GVxd6mSo9irWIYF3wyrNFLGjrGnARVvvgxl5JBysjTmvdNnwLqvygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5pP3fvwKuAxQUlcI1EBqHqqGgV3BlIaWBl9f5lFVU0=;
 b=GMZQmSNDTbLyZPPMHX4qwPMXu4E252IoQo1nCCHK1mtQ+UJXP9TWkQjNe8P35EOGH5HH8kkeN2KME0+dlpyBDMb1ai/oS6J58fSRsTaI+ISi8eeJkdKlycuruOqiwU2Q99h69x7F5kKVkXoYn0kyATvXNWGFVSYnjJAZ9GX34poMUF2CNznSln95An8O0Fu7fI+63H1/1gBRwXhzyLtaAnjol6RbvQeQxC8OppJ4FqWNiAkflJZ41RHCQlEteWHILuF1ew+R2Kb1hyHCPeyJakS7YjaX+FkqFdv5UXd8TSejgjDkW6GEI56ahztoBSfPMVz6+xcYbqkRF7IvuWdqlg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 23:08:40 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 23:08:40 +0000
Date: Thu, 1 Oct 2026 09:08:35 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, nova-gpu <nova-gpu@lists.linux.dev>, 
 M Henning <mhenning@darkrefraction.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 00/13] gpu: nova: Export parameters from nova-core to
 nova-drm
Message-ID: <ar2VtdBHgGqIPQQP@nvdebian.thelocal>
References: <20260909064506.910162-1-apopple@nvidia.com>
 <20260927121736.1186364-1-dakr@kernel.org>
 <DLQ3HW61LAW1.FLV9E4Z9B5S@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLQ3HW61LAW1.FLV9E4Z9B5S@kernel.org>
X-ClientProxiedBy: SY5P300CA0079.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:247::23) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b426f78-eb40-44d9-b206-08df1f47c3cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|18002099003|22082099003|4143699003|6133799003|3023799007|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: PFkeU1K+IlF8B9wxYv7NxVC4nWeMo1H1Gl6ALZDvr87mK21QM6Oncx5n4DMY1tu837VVycP1N8bkMqLieka0uxhqqO/erzAayV6UEAJwUUD+rXpJgIvlUonJpZ0Yttyd1QC+DGCAiQBgAICn/oqasmc2gbpiUbjTK2wBQvb+ZEKuNybyfB357go/SKwrkUAH5aFYfu2Yd7SbEgpuoPbYfGJzfSi2oDXwc8VLXHOPZ1voXiG0eHHFZ+ivBJY5gA223u/SeqxFBvmhwOk0iFLF0go3SuYUGGrLK05zNid0Y2oGcq38U3AvrglqHDWvZUF7WjNYpupw428CaMj2xznN+UDXCGlAK9dAFdCpoBLEPGJ1lYr9OsZvayRyqToHXd4cTcu+0SpW65Qt6QKGsDq81qIqr00Dx795NE5xLsCSt1bOyOppP2PpdmEOxaY2SeLSRPFD1Q8n8eTfMeHfueYELlW2OgTtIWNTxsk14xq2fCXDaMjJT2HbCl10quKZvHyCoiZv6TJ+d4q5f9kwfetnholv0gYsgt+yzKAzZj9Kygu0dVcb8qLdmfmy1CJvWAEyZiuceko8kiJ1P4F07eYZA7o8n2WJp6JUEQ9nthDbC3MBVSBqzFBvaTgPNnHtGHxBpkTNlkn0CdLhTco8uq5cXwI8ixw1QgPYSfs2emFNBdY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(4143699003)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ErXJ15WujbgNz/HWHjtdRtzXgYTJh3bN9anx/r2hrfuqF0u+U8hcJdzPQckV?=
 =?us-ascii?Q?/p8WE7t5TaFwZRA4YUn8ukCmhBlzNHgnOUz8+aZitRoATSPWHU4QYvp32EKN?=
 =?us-ascii?Q?1hIzT/rEiGgMUmWVRlb/oRL0UKXEmd0PcNhnI/PiULbxdK64f80lX5461+HD?=
 =?us-ascii?Q?T8mPfUk+MvV9qY5+zWM+XF+nL1fhNT99m1unF7z3cWkri35zrRbQpim0z/8Q?=
 =?us-ascii?Q?4MEx99AGBcF0pnAN3rXyJ9km7HkGxqoCBbn0QeiqG0juI0m4lIbHlGuqb4Vs?=
 =?us-ascii?Q?AiePAfkLUiq0YGZU6jSUm5RnGjfxo0aHS2HwBjIjP/UIDL4SXzcmyZakn4u9?=
 =?us-ascii?Q?QKNKtVTihDp8yhfTt7uK2k4SPC6txyhtva+A7JXXa8/nW/KZsHFWqHrv/T80?=
 =?us-ascii?Q?H9hZHmKn7oyAqlRA/V8PrBeb5Gk3Fi+XQRnKNfEYSOGUXCX7qXBwAjCqFw38?=
 =?us-ascii?Q?VV9LR4noD28XvMpbGk5CS3d7JUPMvWHEujmfS53RijRYrBvJcrc56ZkrPfNe?=
 =?us-ascii?Q?MICddbp5wSOLsTS8I7kf/+qkIRCwQBL3Or6/GWLtbYRDoPn+eU9W+uC516ik?=
 =?us-ascii?Q?2tCzwOcTWnlNuHFU7WZs4MY60LMcyhyZq1UTjiukP+4B1qiSk/gfsybh0HGV?=
 =?us-ascii?Q?J9KPrdqaUWAdyeG7wwpMb6FsGYlfar7JXg/PuRX2F0i1/51sQhlqEMOiLZ4c?=
 =?us-ascii?Q?WxacR5DJouKoYaMOcJmsaUq5kp0ENO2R2mbkP5AKyoHQoFmA5M9xJkIkae8b?=
 =?us-ascii?Q?V/uHE4xDA1duzgvocojSpX3cR1kCrudIDqHiF0ySLLkJTSrD3/7RzBYxx8Oi?=
 =?us-ascii?Q?hQq3jrlV7/DN15S8i96N/A6cjARMmMAzHzDZurXFI3OHmQOOKPL0x+vkJ8/9?=
 =?us-ascii?Q?+fZaPXNEJh32TCal8HL51FnMo8sgC7q+LknIi/6b89kwkFYnHc2MJnoTXaa3?=
 =?us-ascii?Q?3/MESZH8V1cfDuhSemHkNSgIIOlH6wchhUUGufSND6yYtNH1GrSN1NrP8scA?=
 =?us-ascii?Q?SW5mQUUrt53RZyESirPuJt5g049rTxzqWuv+HwFTq/v6nmWYQp+XWHrQlXmd?=
 =?us-ascii?Q?15idNaV2d4oRGEKcKvg0zIo9qeCbnLwokQQjhUHc9fALVpNbUO0sdTctjW0Y?=
 =?us-ascii?Q?YT8zkJbP5wg9wwvvoXZTO1aDt/Vxap/7YPN7Cj1d4S/pRVBhyCbSVX/BUpIX?=
 =?us-ascii?Q?Zyavttl1eo8G3zmbPttinGWV0zFtl7dsPot0wmfQuGoRt08UDB2I8vJt+6h3?=
 =?us-ascii?Q?/V9f5qDs9TZYJwIRzJhfjI0E+HDOfCIsO8qHg+70g/KDZB7tbT3Fs55NQBKh?=
 =?us-ascii?Q?olVplQ8HrFYZdYnIYNM8N+8eB4ZeE7r8TWDCMXBeTHYEThkX5T9iv5Djqp9q?=
 =?us-ascii?Q?8qa1+5aat+YQLV86TW0e9A2vCcjM5Y7NcjcF6NVHknEoxgxaPvdO20FJC5c2?=
 =?us-ascii?Q?2D9B7MRZD7Taqe7cYToGAOU6z3kKeR8P/UuvXFjHGasbVEKpvfhekhX0/W5w?=
 =?us-ascii?Q?NeTwCtW0q4gjiuuJ/ALBvJblNnLpXWWXIex5uy6soEteSsxl83+zoXLzrtfx?=
 =?us-ascii?Q?/ms5mQQwuX/lHU2xU0+bgsO+YMYEeooMNJhYfXo7b2uN2NN3etF075nhTaif?=
 =?us-ascii?Q?tAK7x8wNzXnpHwqavVqhvove/VeFSdVU5oCz4xJjHRUDDjIL/YhpgMYsIFpZ?=
 =?us-ascii?Q?0cGhtXTb7m4wL8rbtQE7HNo9gDksArbS7vOzKydbOGc7kqxO6sKNLJv5snFf?=
 =?us-ascii?Q?GXD4tTWszw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b426f78-eb40-44d9-b206-08df1f47c3cd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 23:08:39.9594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOOoO4f58NenqK0ST9vubVfYm2GGIditF6xF3GBTTRHXZupETok4a0odZztC2QiZI1PgnGWWRC/1inp4qxIGgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
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

On 2026-09-27 at 22:25 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Sun Sep 27, 2026 at 2:17 PM CEST, Danilo Krummrich wrote:
> > On Wed,  9 Sep 2026 16:44:53 +1000, Alistair Popple wrote:
> >> [PATCH v6 00/13] gpu: nova: Export parameters from nova-core to nova-drm
> >
> > Applied, thanks!
> >
> >   Branch: drm-rust-next
> >   Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git
> >
> > [1/13] rust: auxiliary: let registration_data_with() closures return covariant sub-fields
> >       commit: 4075acc9d489
> > [2/13] gpu: nova-core: Add public driver API to nova-core
> >       commit: 6e70b1719991
> >
> >       [ Rebase and use pin_chain() for Gpu::run_selftests(). - Danilo ]
> >
> > [3/13] drm: nova: Add DRM registration data
> >       commit: ecedc604e0aa
> > [4/13] drm: nova: Add GPU architecture enum to nova-drm UAPI
> >       commit: 342aaa7bb3cc
> > [5/13] drm: nova: Add chipid enum to nova-drm UAPI
> >       commit: a1678ed1f8a3
> > [6/13] rust: uaccess: add UserSliceWriter::write_truncated()
> >       commit: b40f5ed85c5f
> >
> >       [ Inline write_slice_partial() and use it to simplify write_truncated().
> >         - Danilo ]
> >
> > [7/13] drm: nova: Add an info ioctl
> >       commit: ce6e59897ba5
> >
> >       [ Avoid 'as' casts (add From<Chipset> for u32, From<Architecture> for
> >         u32 and use IntoSafeCast, IntoSafeCastArch); improve / simplify a few
> >         comments. - Danilo ]
> >
> > [8/13] drm: nova: Add usable VRAM size to GPU info
> >       commit: d9886a1a06cd
> > [9/13] drm: nova: Use nova-core to read VRAM_BAR_SIZE parameter
> >       commit: 7edc491f6fca
> > [10/13] drm: nova: Expose a render node
> >       commit: 843bb3ccde8e
> > [11/13] drm: nova: Report GPU name in GPU info
> >       commit: 391cc215d22c
> >
> >       [ Use ..pin_init::zeroed() instead of ..default::Default(). - Danilo ]
> >
> > [12/13] drm: nova: Report GPU short name in GPU info
> >       commit: e6d9c5b08c23
> > [13/13] drm: nova: Report GPU GID in GPU info
> >       commit: 10a6623a24a8
> >
> > The patches will appear in the next linux-next integration (typically within 24
> > hours on weekdays).
> >
> > The patches are queued up for the upcoming merge window for the next major
> > kernel release.
> 
> Alistair, I've also updated and merged your drm-test changes. I've also added a
> patch for a Chipset type with strum [1] (it would be nice to have something
> similar in the kernel as well).

Thanks! I was happy to update once this series was merged but am totally fine
with your updates as well.

 - Alistair

> [1] https://docs.rs/strum/latest/strum/
