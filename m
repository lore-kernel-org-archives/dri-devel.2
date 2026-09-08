Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032D5C79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6431410E082;
	Tue,  8 Sep 2026 07:11:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="GAetne+S";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 801F210E082
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 07:11:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agVBW8a9HRS/IpRtQfFhjUqnIUEgpFE+2TOrmlAf72xOpOFnA2qjFoNpnQMCaAxUaZh0yckqv4fRZBpIOwNxkM1K2hShh7SwOFrr6pkrtvdB0z4YgKLoWhmk/LjTGu9jUposyV6aF60+QMpX6j/AooiFgMloJNktBrfg0TSbzx9yU4Mygz/5F3KBY/I9PQbuKyYl2Vd1Sp+bUOm6lcqxxgIhK/pl0TSGMkH/zj6IErL2hYQpHU+GG8amCYJ4CVmytMGdg3b47ahPcF/1g+L/riYE+wcK7CVDRO8UOcqG1n4CsS9sBNEBNGYmmJL4hhAnXPMmfDgXc/gLzReoSsHgxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxLxaoXIOgUgw86m83Q6lGxI93/j7+wNLJWjvU3ooTk=;
 b=mGJbm1e8l6JguRFgH+SSowgFA3dHXgd0/hIv8NKC0IX/LkLOuN3lecpR4LLbSWsH7d8JcEolKq+Bs9MdJN16lC/pPGdIFlfcCVBn4mZn5aaZ1j8tYcbHZ9ts4DRqXXO0EyFBa5u3N3sqOsP3omBqCI1nrl9mxs0MlmmXKwGAzrXWJum2CwerqcQ7Wpod0LnJBgRh0ha3W71bsEp+6Rtcoc6ODIXJlghtI+HiewgGklfc7lCWZU0PxZFlhzO5oFtezYem25Ya57NNjsSV6uSqPgysVpjFF/kpO4YyAGjuT+OxqF4rke8WLoRQHqj/oeobL2ObdgfVteELqkNtwFJ5XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxLxaoXIOgUgw86m83Q6lGxI93/j7+wNLJWjvU3ooTk=;
 b=GAetne+SQTdN8CNbRLh3sSzC6tBkOD30v1BEGXWp7nyt/hfFzfyXsz+biwjD5oIm40yrGCEy0uXGzFoPD9srqIXf9zH1317EeV9L8FvXrWszY1Kc8OgsDp6rXLlDfywsp2mD7RvwVgZpk2Kkyy7flZhsyD6gQP8y2n8WP2OirGtGXsx1EZ3E6Hl7t4dIF5JLr2ZrPFqDlh/gD6XHmwbjfID+BhwrzbfN4rJobVHTu6UYiEPtKN7sdIZDs79CaKFZtNaXpy7JazVzr5Gk4BnXnXCsFb7ZLHLe3IIZcZrrE7UkWwKV+lFvshDw3j/PSIhI4+Ci4lpKZN0J/9elBbkExA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Tue, 8 Sep
 2026 07:11:20 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Tue, 8 Sep 2026
 07:11:20 +0000
Date: Tue, 8 Sep 2026 17:11:15 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, nova-gpu <nova-gpu@lists.linux.dev>, 
 M Henning <mhenning@darkrefraction.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Benno Lossin <lossin@kernel.org>, Eliot Courtney <ecourtney@nvidia.com>, 
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 05/11] drm: nova: Add an info ioctl
Message-ID: <ap-vnh7KFJGJLW1s@nvdebian.thelocal>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
 <DL3WXUPD5JKE.2GZ1CNJH539ID@kernel.org>
 <DL453EFS03T6.2VGI5TJEQ52QO@kernel.org>
 <apdvTgAp5eGezO5t@nvdebian.thelocal>
 <DL4QCAZXM8EU.2K8MLAM00VNTX@kernel.org>
 <apioGUDamrCur_oR@nvdebian.thelocal>
 <DL5MA26KZEF9.3KHKQXZ4JD2G6@kernel.org>
 <DL6HKYRXHNFK.1D9HYNEPH4GCR@garyguo.net>
 <DL6IQKQDXY7P.1F6PSERSJ64PN@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DL6IQKQDXY7P.1F6PSERSJ64PN@kernel.org>
X-ClientProxiedBy: SY5P282CA0086.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:201::7) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 778f1696-5693-4416-c437-08df0d78620c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|7416014|10067099003|11063799006|6133799003|18002099003|3023799007|56012099006|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: Bc370Esse5dohH+ZyeYYQse7kMv6Mdr8vyh562x5tF4aVNOrkCCtZ9GwsMuY2DoJEotqSalg5TonW4yqfyigS2B49vntTmznfSaYzjzAnVSkjojjXsPqVIQqmSo+76HBUOciCi3JZ2HbhgUodB49SZNdtee2WZ+W++9gOCl7l3LjgJq+CYtnIaFwUfffWxTj4jwYEiqOAkku7apr68hIl6mBGqdpsJnlTErnHrKzIMQYhIW7+xL6XSGU5AGIIaR6liBjZiJ2RDMhdokEMJRTOH1zjtdurR9ONvQdzUCEJ+kZTCJNNLLaLX8VkKe2TIHDCbmreKVj7PdZnh+rXGxv2BoFhrgtLGStWzr7TbmJM6q6L6co/zgdBjxnN0vOfWq9x1EjbPLxcTmjWGpSAG4mlKx88VGBOKWxt9EJ15i77Dl+gWiMr3YE5QYwPnEiQ91i/1KZksyE0hgKT7yDgMHmxVqXXK2V4baLDMR5cBc82/cQLvtW3hRfNZLmxTZIIFvE0Tm2r40O3nVMGOyZfeUIjjn+MYc4fJITvsrbIuYOhv2ZGlratw/tJc83uDwkz2Y6gxr28mbfogL9InhjhtEL2nYHRIm3+VdL+8mYBgCwAYGSAL/PnpKnoC4fbVofxt6SvMPESPlZS84dB4SJTvBOmmFjUmnSkGLkaRtPytAoYXs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(7416014)(10067099003)(11063799006)(6133799003)(18002099003)(3023799007)(56012099006)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e5Ueb5xp84+2LaMWswxGjYdNXOHS2RnfSxdrEKnxWISkZanDbQiBUY3ywwlc?=
 =?us-ascii?Q?Tl00X3Ke3b4Tu4LACqaXuBVZXHb5FHj9VLyv7mLdHlI7p9fgc9lKt7O4WpI7?=
 =?us-ascii?Q?U3XLOE5RYq7iD5NA4CCc/2hSucgKmm1S/1YZkt9BUAqdSpG59OfPGFgF6g91?=
 =?us-ascii?Q?NRkK9jQk0M7MhNuKg/ixEREUfPlAhKgyWC4wX+EcsOfIUoMeLQGUGUd4iTJA?=
 =?us-ascii?Q?jz53M4q4nHZLWBGzOiQah6uNgo8/ylnDWvJn2Ea5dyUoLeqUIlrcauBoUTvC?=
 =?us-ascii?Q?rflXQdQ5RN02XE9+FK4ydqcfBB6hdPJuAlKccyBkZPycV+ZjXM791TMCqIP7?=
 =?us-ascii?Q?6qdKEuhh5PPxuUAU/4EbfTSNZouESh4ueDl7r5sR/ih3FxvHSEOV6m/iC3gz?=
 =?us-ascii?Q?Dc8tldhnOlpo3UnRX4SgoyqUtegXMOLqh4FEXD8nU6H1jZ8dM7P8m71Fu16B?=
 =?us-ascii?Q?BN+LTJdrXJW9Cha82y6hc4tuzktY9aUrCI8ywNEvwSBI/5yFON2YHTGUXM7a?=
 =?us-ascii?Q?dkuwOr/hbH4UZuBv9PxwrYUfa7zyG+49WoV/DaZhwyH8YCCH/A924Y45VOjv?=
 =?us-ascii?Q?nJCCe2IAIugkIY6ufeJMuC/bE2D9xtUAXOLUZ6/TCQDQy512uIvioLB27e0M?=
 =?us-ascii?Q?fHIV/3AULFC/fYyPLJ8Fe8kEZezPFU+Gh3myy5vujq8LSl+39rKziPDAzSf2?=
 =?us-ascii?Q?v/MMZ9A3axjLcZjIXpgp10GCjEXeM/ubACC1/FjcLyd5BHph8ps7nSlkWsAb?=
 =?us-ascii?Q?sjL+phOmR9Y3mmxwp/TubWZzWUg8jjA4lpHK/oZwZ+nQguISSTtUuLWl9IJF?=
 =?us-ascii?Q?wXXcLPR7/xEO3vdMxRx6SgThz9JxM6Cs4Q+W5sPoYdiQZymA9CU1PIeGjNWN?=
 =?us-ascii?Q?AFJeGM78Bxz408fJzA7WD23WGYGvYWDvDCwCgQrjJ1mkdR9igfA/FOB4kSYx?=
 =?us-ascii?Q?XP5icKgRgRtxuYpQVA1gN2yGOM1CiuTcMpFdSwIaqHPNXu98PFkS8tO5Dbrs?=
 =?us-ascii?Q?RXYqf3skNseMqgU5LNp+WlwttheB+Cv7DnjrHRizE57YAsJoyGrTupjseaca?=
 =?us-ascii?Q?2f1ILPGn2Eo6zeYL7duuFmZsQD2FuWmbjBLngEiZ0Q3IEdAJ9QKsp9U3vBVr?=
 =?us-ascii?Q?f5dfqHJX0EU4OkuuXIthV/RB/hBQAMzfDPEXt0hSxO8+wpk3ussoXsQ9JsfE?=
 =?us-ascii?Q?F+znr9jbqcg+eUa+svzPMhEjLHrTAr8y6oNPDJ7BXaFiNQ+l7HoBIQPaoH+X?=
 =?us-ascii?Q?c68urrYZbc3NGzOp9kavJAkwFe8wvJGjnwXw82I7r/TIiCIBuYI2IOAwTlv0?=
 =?us-ascii?Q?VrhzztzpiR4gYaWTN/evjodNdJo1B5cxOsoLrouIC1uBj/aPL8xKiouCwyBs?=
 =?us-ascii?Q?K3/HDpGKGwNQX815zbUN9sjhs3NXRB5vRGTqvw+nAhGbICZkAteZSY+vpsBb?=
 =?us-ascii?Q?nHolbCuz/vAkoCRwyTrjht3bnQuYEdFyylmJLdVqQlJVGmaww7n2zyJvhFU1?=
 =?us-ascii?Q?g/jlT3zCUcze6eaic/ocG8Z5IdrxXzfZW95tPtbaPzPC3LeAPeHncuXqksGt?=
 =?us-ascii?Q?lLqGS0MYTT5c1RkG7qY/84WGEYhzYzUXq2UW6rlt04+kINvjN3DbzvV16WxF?=
 =?us-ascii?Q?a6matpK35X0lIAgscuqwmpm7YS54wTdSwe6a3jN3+roICNHrokjXqxxXNo1w?=
 =?us-ascii?Q?JduSCDqPHMIABt1ktSFZ9ROMo9xcsJfkLfH0XeS/N8hHIeYwhQKTecxPn4wD?=
 =?us-ascii?Q?gCj2Nk00Kw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778f1696-5693-4416-c437-08df0d78620c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 07:11:20.5734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fc7882JXzOHCzIA0lp4j2oMGN0fElz+UjlZsU3CYi1Ig9oQCd+PVJKLzclSg7k0p3TY77DCrJS54RhXTDdyaaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103
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

On 2026-09-04 at 22:08 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Fri Sep 4, 2026 at 1:13 PM CEST, Gary Guo wrote:
> > You mentioned in an earlier email about the typing, but we could still have
> > meaningful impl IDs fully typed like this:
> >
> >     pub enum Arch {
> >         Turing(impl_id),
> >         Ampere(impl_id),
> >         ...
> >     }
> >
> > and some langauges can do better, e.g. TypeScript allow you to write
> >
> >     enumn ArchId {
> >         Turing,
> >         Ampere,
> >         ...
> >     }
> >
> >     enum TuringImplId { ... }
> >     enum AmpereImplId { ... }
> >
> >     type Id =
> >         { arch: ArchId.Turing, impl: TuringImplId } |
> >         { arch: ArchId.Ampere, impl: AmpereImplId };
> >
> > So I think it's a reasonable design to have it.
> 
> Of course we could encode this implementation detail, but I think there's no
> reason to do so.
> 
> For instance currently we refer to GA100 as
> 
> 	Chipset::GA100
> 
> but with the above we'd refer to GA100 as
> 
> 	Arch::Ampere(AmpereImpl::GA100)
> 
> which is not buying us anything, is it?
> 
> It also would be confusing because both the architecture and the specific chip
> would now be both represented by a type called Arch.
> 
> > True, but I think the chip ID is as bad as impl ID. Feature detections should
> > use dedicated featuire detection mechanism, not looking up IDs directly. I.e. we
> > should have userspace not having to use either chip ID or impl ID as much as we
> > can.

Yes, I agree this would be quite lovely for a whole host of reasons. But both
our HW and our FW are a long long way from being able to do that so I don't
think it's really feasible as of now.

> This I agree with, which is also why I mentioned we should export SM if GSP
> already provides it to us.

Yes, I did look into this. Unfortunately the SM version GSP currently reports is
different from the SM userspace code generation tools need (I have no idea why,
there appear to be way too many SM versions).

> > That said, I do think looking up tables are unavoidable, for getting names or
> > applying some quirk fixes. And I agree with Alistair that if we include it,
> > including impl ID is better than the chip ID, as we should rather not having
> > user space relying on an arbitrary encoded chip ID.

Yep. Sadly without better capability mechanisms I can't see how we're going to
avoid lookup tables in user-space. If we had better capability mechanisms maybe
we could, but we don't.

> No, the only thing userspace ever uses to distinguish between things is either
> by architecture or by chip. If we instead provide architecture and some ID
> userspace will just go
> 
> 	if (arch == Ampere && id == 0)
> 		chip = GA100;
> 	else if (arch == Ampere && id == 2)
> 		chip = GA102;
> 	[...]
> 
> and after that never care about the ID again. Whereas with giving userspace the
> chip and architecture as separate fields userspace is done.

Right. That's because what user-space needs and wants is the chip-id so it
can figure out the exact ISA, among other properties.

 - Alistair
