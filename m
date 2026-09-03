Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39EAC624D6
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 01:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62A0B10E039;
	Thu,  3 Sep 2026 01:13:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZzaGofF7";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010023.outbound.protection.outlook.com [52.101.85.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13F0E10E039
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 01:13:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/GZnve6ORx4L5TlvLa0ZBuOdijsuru71bRlp32u0Er59PmpGGAYsaewSVrl4jiNZwT2kD6VNTsCeKk9dDKgxxwOeu3stQ00ZXZzbc+4xbNy+eU9PCv7Wz0eNcIvpRReabt9XqIVY7914xh6txYIyS3Ou8TqGoaOByMxbL6Gpm5xpdKg5Z6uR+5f3cssKYyvgf545GWSH2i2wj5oC6FQOy8UP41FLWWl+hm7bzMgtcV9wmpqo7Q/k2ZCUe+MQdK2PHtb3WsNZjNx4j02Lgh6IihPM9im1u+1a+HEMbUmvelUYkvIciuA/OJ3LFggyGRdUyKC0+DKPX15D/ADULs4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EFveCLKy5rjMBBS6tdQVl0f1jLMnbLouzK/GyaM09w=;
 b=JT5UBYTIlX7PAPjzGi1exUUomO3cz5ooWU/WdZ55avt0qP/7l0BjhaaqIjQO2Epr1yWfL9H7gA6sUy+vmUQBD5WO5O14rIiRauMT6yd9ZcNx4TvRFMkgLOI+TWp5SlA4+bCE5i+I758imQyupVEQmY/cNQ5m1h3ZIiw1HbLIjyIaB3pyaspxEnsr32JFiacnbS4rwmCCTxQM1+2d8ipTa+/AYoyd9GW9YsuKNolC18/4XmJKrqoWEvdC9rUeuzOESopM9GOa1gPfC7/8Y/OcjV6sm/9JhXhYwM9VMc7kdagHoSu/Qq06GfS15MkgOGRk50hZZT1EeaTU4P7E1S8xBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EFveCLKy5rjMBBS6tdQVl0f1jLMnbLouzK/GyaM09w=;
 b=ZzaGofF7tFq3uEFcQEJamEVRnaCZP7zb8PRQU4FpmlB29KcG3nJUguAzJ7qQCjLD1H3/JIg1l0bYu65ONqvgO/qRhjjQEGnw1Khbu3qLX3J/sB+7kzJTBuseaNO67sMBepdT35Js5jDXICRKtVg6Wq8yRrNJpwyRUIlQplQouut96ZCmpGNgbGGhoL/uITWtq4hjFEa6nW8lO0oYNxqrHGjvTpm40nB/B4TPuYBXk7Pt5YDKonJNRNuPoOpaXF8npWHnI/GpKJ9Y9I+Gj8MSUiFO3su/EvmavFn+9ASF3wRUPL/63ySNkNGUkDuLHwLwZuTyDUxeMGQ5qB4ZRwaflQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by CH3PR12MB8259.namprd12.prod.outlook.com (2603:10b6:610:124::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 01:12:57 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 01:12:57 +0000
Date: Thu, 3 Sep 2026 11:12:51 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: nova-gpu <nova-gpu@lists.linux.dev>, 
 M Henning <mhenning@darkrefraction.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 05/11] drm: nova: Add an info ioctl
Message-ID: <apioGUDamrCur_oR@nvdebian.thelocal>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
 <DL3WXUPD5JKE.2GZ1CNJH539ID@kernel.org>
 <DL453EFS03T6.2VGI5TJEQ52QO@kernel.org>
 <apdvTgAp5eGezO5t@nvdebian.thelocal>
 <DL4QCAZXM8EU.2K8MLAM00VNTX@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DL4QCAZXM8EU.2K8MLAM00VNTX@kernel.org>
X-ClientProxiedBy: SY5P282CA0187.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:249::8) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|CH3PR12MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: d993d339-382e-4197-e59a-08df09587d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|6133799003|4143699003|56012099006|10067099003|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lNfCda2McWfe5O/zBCvx6HeZJ1OKNXLrq7bRJgeokjabJhyJ03WfFY/MCeXe7d5t3EcAL+Crf8KPmIF4OHT6ee3bQdOTqVPe8IuRx6Ok80zzo7d4p+I/larcMMUdnWuMS1so3polyZtjrHkFoTRkfZuIc+UDfj+LSEmzjZJHTW1JZwsG7JNTFbglwdFHH+ZXZgFV7kDPrKpIKBnvDBD9gziq3XgOdhjwji0hCipl0aKN5IWmpH1N7XIwrSfMf8+mbiKEw2DmLYknQhtkWMz9AzPTEtceqD5y397vxKpH8L9aORfV7Ct0RAamXBVamt+WicxY9twK4PfmtBgHJ9DR5kMhC6Vl/Z+8Ogdhc13DJh2iTYeP8iizCgdiDmb1CUjBqxiLbZ4m5y2i+AeP9b7o+xCab8NPi0pXqf041K1NSg8Eq1xy9zUxaLLDLxeGaAiULF1AF7KARZaP7KlY/MsgCAAujBHrdfKvM6cExyywWOhUM1dCifDAh1CbI/T5Dffa5qWcOw4R8q7rTm+jfaLTCl8xdDM6vfBh0c+BYn+FDQNHlmXPD5lJ15jPKtEbAlX6/ShWMMbgtVeA81eEDnKq/31BsHZ4Cjiq8z5ABmqNVVcYyQuQbuMlfmZzkYlC/c5KBy8iY+2zazqDLYmBc372Br/CoIQpnz1bJr7n+pgI8kI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(4143699003)(56012099006)(10067099003)(11063799006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/J/8RJfc9Oktv5S1P475ndgLBZaaSgXRIJpz++dk8oOueBXqQLACfpmngDga?=
 =?us-ascii?Q?m/ju20lsIm02ycdnWWYCWWDI6vEV6EkGtckXQzqSEtI4HoZblHaX0GfPanlb?=
 =?us-ascii?Q?9sFbDscTMCKC6er0Eim91NVm5z+g/4V3UVbzaZDMD1GI1e7A/e9eLbyyqCHI?=
 =?us-ascii?Q?jttGBEnDTHh7RNvUmWNBIDbH42Ei0Z9rkQ+dFbVGHZPkvaU8hwximjBjlE+3?=
 =?us-ascii?Q?buMqSo6elxJzUzdN33ef5HNaApsX7F1kN2aKmmCG2d8Ss9kdKEHGJVOS3Pt9?=
 =?us-ascii?Q?0zuOxcQNPvAfbJuTL7NNp0JuVOCHVVUiJRf3WN2OHWpfh7ERHeZd+/uHSutj?=
 =?us-ascii?Q?hb7KpNHYecSYPhQO4PRJDZm26lSLFLosu9KgqY6x+GkAkTeC3MJ9XR9cV1vh?=
 =?us-ascii?Q?HYIPjEdY3Dv8qG1tR0fYoPY8wDX4r3UfFrWDwwF7BPVOrHZ+2Y/I3b0E58hU?=
 =?us-ascii?Q?s6aHPqBkaNi2+9oTFrtx13mXqeoMZPSW6xH2op477emYIFoxr09HtwP6DrQ7?=
 =?us-ascii?Q?5FaOw0FnYjoBwL1HF+n8ePVyQ+npAeqs5kjARlcx+5+J3rApzxDi33lCmH4a?=
 =?us-ascii?Q?g7nC9qHV7QPadSZA2JP1717XDod2T6fTPew4g6kZELx9JdlSbUeeonPt6U9A?=
 =?us-ascii?Q?BNOA5zHtbU7Y2dRu40kL0jV3jb+vsgAZynRBFs1IXEdKscA56FB1KQ8pvz5R?=
 =?us-ascii?Q?PIlVQrIPjdtBuxLFZYWSyOsvV3kQy0h+OHQ5aQgvtVqr+FL5CNTIDnjKIcKZ?=
 =?us-ascii?Q?nYoTdU4iJf9sNcHFEvTA4ENLhfrKYrpaMHr2yBdY8jGFfubacJqTNnnHISrl?=
 =?us-ascii?Q?OHTPeollW1oHZAR/lkDyxkLkt53J7JhQ5NaH1aw8nUoa3yIc/GJt7Jvgh9i7?=
 =?us-ascii?Q?vSgh7rItPW0tHBsHQRBcs9t4UO0yksQQScCsdXWCjoRyk4vJVZPsJUjQBQRz?=
 =?us-ascii?Q?4oLU1N4GQexpcquQovztB7Bj1RBgXppXl/KYLDl9Ycg/e9c0Hl3S9sd14Irq?=
 =?us-ascii?Q?i68R/VGN/Uq09f/NxFdQEIJtgYGlGSmUBgeXeEDlVCB35pvH07pZKWl8VZAa?=
 =?us-ascii?Q?y7hH3x+C4/ItG3dnJrWn3h/PNYFzlJhLhTLwRykScBU+BfTMuu/2ypSr8VkA?=
 =?us-ascii?Q?IZmhqO5WCv9Y+32k+az+VfR8K+eYJJxm+2Ne55VLEI7l5neRsFaNYIu1UYEY?=
 =?us-ascii?Q?E8XYuYlqOfeVTS9kOJeuFvCFiT/EE0ZyMCQD38fd5lrbo1yrMHXT7d2VvKSw?=
 =?us-ascii?Q?tg/Q0NN/5d57rm7CYNzXA4X2VQulC1MpjsdJcDvxxRaHCwFVSg/XUV/XjPNS?=
 =?us-ascii?Q?+iNUPnxFNAcF8ufGaGzqS5wabYibt2d9+hK+HYAvr8F5cj/okoL0Q1IuO5O6?=
 =?us-ascii?Q?IrIHpIPeBtqF3GqopKM9fBa1l5UhCirsl22RebtfHbDgaebtuCo6mtLjeNxY?=
 =?us-ascii?Q?qpi2OVP27qBAUF6wafxSU8UiJ2QPBEr2EdSOPanm2JBS+l/Gb2jWxQH+gcyv?=
 =?us-ascii?Q?b3TIzFwZoQQV6rzM7JCtnI6hkvOtJRmgCt4inaqJ9gbB4BeR6aoi1v3RFfgW?=
 =?us-ascii?Q?VcEukNyPhIayfXkE1XXdJkNo1JYLADO2r/MJs/h+GNffKOm8wKaTfTMDxqgK?=
 =?us-ascii?Q?bJSjl3PJ+lGmWuvdgZ/oM2YBQJ+k3YZWDgTqBrsnrZMbukzV2h4O82MLSHw+?=
 =?us-ascii?Q?6uI/Uan1q6jIoYxkDxganq4x6eyu0w5C6pOnWSMnCcHwVw/YjFwToxOO8+xi?=
 =?us-ascii?Q?6XjsxcymSw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d993d339-382e-4197-e59a-08df09587d35
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 01:12:57.4001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQe/UNqHF0pbgwM4j8vaMo9iH/7VhmGhXD2V3Fo+3bYLD2HtF0ITgau9jxgiYhGKLxfIs30hE/3Q9QHpKSxEgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8259
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

On 2026-09-02 at 19:40 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Wed Sep 2, 2026 at 4:38 AM CEST, Alistair Popple wrote:
> > So I'm ok with providing either a decoded architecture and implementation
> > xor an opaque chip-id. Or alternatively maybe architecture includes the
> > implementation (ie. we rename the opaque chip_id to architecture). But treating
> > the implementation and architecture values differently and only providing one
> > directly doesn't make much sense IMHO.
> 
> I think this is you still thinking about this in terms of register encoding.

No, this is just me trying to figure out what user-space would use the
architecture value for, as on it's own it's a pretty a useless value from a
user-space perspective. For user-space to do anything useful it needs to know
the implementation as well regardless of how that's encoded. It can't for
example run anything reliably knowing only the arch AFAICT.

Originally I thought the point of providing the decoded arch rather than
chip-id might have been to allow a kernel to support chips with a known arch
but unknown implementation, because as you rightfully point out the kernel
doesn't (currently at least) care much about the implementation, so an updated
user-space could maybe run fine on the same arch, different implementation.

But we agreed that wasn't desirable, so now I'm still left figuring out why we
need to provide an arch value? The chip-id already entirely encapsulates the
concept, so what can/should user-space use the arch value for?

> > Except the architecture/implementation tuple is exaclty what user-space needs to
> > eg. figure out what SM to compile for.
>
> It doesn't need an architecture/implementation tuple, it needs a chipid for this
> lookup. (Although it might be questionable whether userspace should have this
> lookup table in the first place; see below.)

Maybe I could've been clearer here - what I meant is that userspace needs the
architecture *and* implementation. Whether or not that comes via opaque chip-id
or some other means doesn't matter to me, what matters is that user-space needs
both bits of information - the architecture on it's own is not very helpful.

> Both the KMD and the UMD only ever care about the architecture or the chipid.
> The fact that the chipid is defined by an architecture/implementation tuple is
> an irrelevant implementation detail not even the kernel cares about.
>
> > And to be clear we don't care about the specific encodings in this example. The
> > point is the SM version can't be looked up from architecture alone, it needs the
> > implementation as well and if the only way to get that is from opaque chip-id
> > that's all user-space will look at. Eg:
> 
> Again, it doesn't need the implementation, it needs the chipid. Which also your
> code below correctly considers.

Right. This is what we had agreed on previously - provide an opaque chip-id
userspace can use to lookup whatever chip info it needs. You asked for the arch
value to be provided separately, but I can't figure out what the use-case for it
is and I don't think we should be adding things to the uAPI that we can't even
imagine use-cases for. We can always add it to the uAPI later if we do find a
need, but it's much harder to remove stuff and right now I can't see any reason
to provide it.

Also for a bit of background on this series, which I should have put in the
cover-letter and will next time, the goal is to get a basic deviceQuery sample
running. That's why I started with these properties first, as they're what CUDA
or Mesa need to fully populate their device properties.

> That said, if we know that userspace will never need to do an architecture based
> check, but always a chipid specific check, it is obviously pointless to expose
> it in the first place. But otherwise it should just be chipid and architecture.

That is where I ended and what I had originally - lets just provide the opaque
chip-id. If we provide the chipid why would user-space ever need the arch? What
can it do with an architecture value that it can't do with the chipid? Again I
don't think we should be adding things to the UAPI that userspace has no known
use for.

But it sounds like you might actually be ok with us just providing chip-id?

We already know the full chip-id is needed, so it makes sense to expose that
now.

> > static uint8_t
> > sm_for_chipset(enum chip_id chip)
> > {
> > 	switch (chip) {
> > 		case NOVA_GPU_CHIP_GA100:
> > 			return 80;
> > 		case NOVA_GPU_CHIP_GA101:
> > 			return 86;
> > 		case NOVA_GPU_CHIP_GA102:
> > 			return 86;
> > 		case NOVA_GPU_CHIP_GA10B:
> > 			return 87;
> > 		...
> > 	}
> > }
> 
> That looks reasonable and much better than what mesa has, but if we'd ever care
> about the SM value in the kernel, then the kernel should be the single source of
> truth for this value and expose it to userspace.

Yes, no problem with this.

> Now, in this case I don't think the kernel really needs the value, but I think
> the value is provided by GSP through GR_INFO_INDEX_SM_VERSION?

Argh. There is, shall we say, some nuance here :-) HW have not made our lives
easy and actually figuring out what the version that matters to user-space is
is not as straight forward as one might like, and may well not match what the
kernel would want (if it ever needs it).

> Given that, the kernel should query it and provide it via its GPU info structure
> rather than having userspace invent another lookup table?

It really boils down to how much static config info we want to encode into
kernel lookup tables vs. user-space lookup tables. I don't this we should be
filling the kernel with a bunch of static struct lookups just to ship those
struct definitions to user-space. It seems more reasonable to put that in
user-space, unless of course the kernel needs it.

So I think your "does the kernel need this" is a reasonable benchmark for
deciding this.

As I think you're hinting at it would be ideal if GSP or some other firmware
table could just provide everything in some nice static config table, but I
don't think that's currently possible and looking at other user-space drivers
we're certainly not alone there.

 - Alistair
