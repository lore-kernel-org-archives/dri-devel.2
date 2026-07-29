Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85E1C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:24:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D0E210E00F;
	Wed, 29 Jul 2026 08:24:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="X6AMrAWB";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BFC810E00F
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:24:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htLwUb6/Przkm+zWjwu1ASmjjYB7BaXgV/mZiFtdri1XQLu9gbVskvgQPHUWnYOosuSCkIKwICvTmuKDBLCfYkH98ixDtgg7drRCxoHKvqpfia6X1uj5d69ENqqIc4ccExx9Jn01WaKTlMg9oUxs8Ye5/HJfcSj66HS4kCI4Se8LzjkSwZtNmhuhF4esVG0cgXLtJ+DX/J68IpG1fG3thaHIPv4IDWhMRq0Y+gtkZwdXcSfywWDU7vKr3URQQjFu7tCLekMVhn2wdGC5BfCGMwHw85j1Bx/xOkvGu8D3ueO3ltg51NLWg4mlPNlEfZ/jWPEjKradyUhnbSZHMbqKxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+aWvM/oIu5Faqa5qi/aQM1lqH+vroCXqj+a2tW284w=;
 b=OixzSHoKeorHry9DXOHVIUWhkDVi/hX+5BAYgeIhFYuum1Eu6FyPzjSmHIMfoIQac0m7ZWQKI+SOa2TSAQHmuof5B/G5+bzqz5KGAs8dYZAfcPxLe28yVDFwuaQvo0WiC3RlZW065+gAAvr6x5RVR2d3S6xK6jE9I5Rx90Hev0UNGutJFckBSN3rUqGTvgO7vPmDnOVwu+V2cigFzASW/01Q00rE+E2VNH/SXjpchS2m0c+DcCxv6SqvbN0CqzT6Rin/JO+rfJ4TdFouRuecAs3vaiQ4EdRQrbG4Wf2e+crn/Nm2kWIQUk2vh1oLm879Z0XJ87Qh39hr5lyKiUJtIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+aWvM/oIu5Faqa5qi/aQM1lqH+vroCXqj+a2tW284w=;
 b=X6AMrAWBOtoLpLeqRTT2xOXJ2j3/c7uw5CSyvcBW6/TUTp2TGRM6ozZjrKLZ2rstEB7yvEO3MKMfXT0/K8p/AOwxmbnYqhg8+zzCe/d9b2HN9iaeP+JO6m+TIYrlDtfE2SLjmAY2mtn2UT0ShiX6XyjTEhTGTJ8Eit3kjr/YkfUvlwQE76yfVt/no88J/DuK74PRq7WcwXqlW1IVXIXKHmIijshmynpqw3uQnnA+JIBeOEK/DB5qLswZgMlB5XoxTa/jeI4qWWPi1WgejvHS9KnlAxFh97/weq9eVClOBzi5kqGsgXYG5elKz0crDRiW5kwg2pwxDVJMU1QiGJbwzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CHXPR12MB999222.namprd12.prod.outlook.com (2603:10b6:610:2f9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 08:24:48 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 08:24:48 +0000
Date: Wed, 29 Jul 2026 18:24:45 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, nova-gpu@lists.linux.dev, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 3/7] drm: nova: Add chipid enum to nova-drm UAPI
Message-ID: <ammyfspYkXOwMsdU@nvdebian.thelocal>
References: <20260723063046.1265791-1-apopple@nvidia.com>
 <20260723063046.1265791-4-apopple@nvidia.com>
 <DK7R7PB91GUE.1PS77AQM8ZR99@kernel.org>
 <amhdA35CcMD_uY2f@nvdebian.thelocal>
 <DKAIVPSA45O9.1NZES5S3BII10@kernel.org>
 <57e2b956-89fd-43e8-8cb3-a15aee272660@nvidia.com>
 <DKAKR85QX9UM.1VYAAL82QBWJ5@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKAKR85QX9UM.1VYAAL82QBWJ5@kernel.org>
X-ClientProxiedBy: CY5PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:930:1e::31) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CHXPR12MB999222:EE_
X-MS-Office365-Filtering-Correlation-Id: 8151a86c-f293-4a2c-cbea-08deed4ada72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|4143699003|10067099003|6133799003|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: oBUhilEscaOZ//Zs7LFmc4I4q6xGGV52KR039FhbzMJl3rStxtJ7+ahK5pxCFRBeQkOq8Sj+oyARLntltGxE2+l3Rz0/AvjhysL5n4vSn84acmbcsLE0SUW8xKERn3yC5F92NbYXQaoBEE9TYKTWWvbJTb8UAy1kHi/kytaK9yST1BGP4vgQXJ2r5mGTUWYateCoS7SwsZReNhL4GCLQi973vqTFRGL6NzNLinw+0gvpGEP3rsURy6N+PJ6wqNYCjkhJe3Ka4iS+tmbGIJP8/10HjAwKts4AkW8/hvRQsD2gQIlnA9dRQB9G5hWl9E+mbSO+1dDYOlqpnyQxZrSH+PsfsAsWXXCsU8v0PWUig3cQ2N09/rpzru4aQQPXY2PrzbiSxO7MxK64IQsm1d0Wh9iandoXIJtuBLWmeEEUhYhmKdsW92jFxi20uuGx71Jr6prNbyosl3zWY5CDn5oKzjwqCBm8ej+R4xQkHwMt9htHH+WtFG7vngbWl4eW6dVDXWnEyMNM7Lf4NgZVQcDsBgg0pe7Vv3XXpn9OGyvGGfnDYIB7aE6r7vu0s8ksyTvYxVqvL0jSo8pP3t3odfy/8p5HUKyC10nDJt8xMdP6I9t+GzqZQ2+SIrXgwiGGTDPqhe3s/JBaTg9asTkchDmfQjIpMSO2G4tM9pKrYeGy1H0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(4143699003)(10067099003)(6133799003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ltjNwrvUPcM2Sk75VnD4SHp01bVutZe9faEeYAlK8AOOuOk8Tm3DO56CCBQ/?=
 =?us-ascii?Q?qRiBhMVW8Mu0t7SkQDTgl8iqtYSsS/0DQJRa22kZrJNSpIqGjMYji2HUG1XS?=
 =?us-ascii?Q?kw9WCGeHxPLKjUE/e7yGvha0JDF35lecZtzqpGxe3GGauyZ55kLLkWn3T6Ex?=
 =?us-ascii?Q?jjkkcYDqAOrzX5UxFPINQP5u+VoeY4zXS4UHm4B5Wjwic4XGJkDrftANvBjD?=
 =?us-ascii?Q?uXifJnXZyRJgIIl6g2wLSyzbEsd1kScSCoaMJ0zR6sTcxMwIezVgNlvnczNH?=
 =?us-ascii?Q?tX1cf70IrjBln5bdgJ2GOyV4x3Xofi9v3QMEM6pO23C3a4aTnMXf6j1vGkiA?=
 =?us-ascii?Q?7HjF3dtI5uBj+QkwbPGmvPTzKZq89UWCglIvClsg/bWYwKIaAcU0Z4DB7vs0?=
 =?us-ascii?Q?+ztyS+mqGkV0qFhGdnIAMH3cHQ01fheP2hz53jyyWaTca7e576mzvBAp9rP+?=
 =?us-ascii?Q?04V/K/tqK/QHYZnhbb1mecDqStrg/nSc3mA9Sj2Pyn5CaM4eYe31GDJzYAoz?=
 =?us-ascii?Q?p9aSRH07plNtOnApKJlxeZcO4oIXyEXQTWtyRT0TwSr9JNWDC5BFmbt0QWyw?=
 =?us-ascii?Q?o2AqY1kpIBZTl+ymoON3QW65U4G494EgmFNWKClJrHzkk5eMqfJt0gOmNZEb?=
 =?us-ascii?Q?Sp6viYFeuLiT5p4qIHWhQlWW7YYjZo/sN0S6CxWSuZQbA6Srja9kLqOQpkEX?=
 =?us-ascii?Q?08Bp1189t8/r4hPn+55aC1n11JEkciqaXBQD2UCIsQFqrMxowQVkmah6C3ye?=
 =?us-ascii?Q?meQa3S2EI++RK1pNvBkmfBPgoGU08Nu2HBsEN0A6SfhNg0fFnmxf59HcvSiV?=
 =?us-ascii?Q?qcNy5j5jRDAUz8tThDNLH1gnGYNmxhdy3pnAPupHnIgybq69iKCuz0/AX/Zd?=
 =?us-ascii?Q?TNF6q8zhVwy+oU8ZFS8komSUt9268GbxvyRzjBwwFI/gDuMSN+X2NmWIbmjZ?=
 =?us-ascii?Q?J7KXkPZKf9EqTQj0CVaqyPvle6Lqq3yc6/Z2Zxt8UYwZEka2GC0RPBqOcb2I?=
 =?us-ascii?Q?UBDekjD04M/PHiPq6ybyB0P5aVflD3dk7UyKKE2kg2VyxYpXVU4BhZlC6V0j?=
 =?us-ascii?Q?2n9zFzcapLlBljIGGLRXZPiV5FeeRA2p0T71PyJtHp1vS3g3k0uSJRP7VjEQ?=
 =?us-ascii?Q?P0f7Ugmq3L/WD6i60pvqxagyj4MsnT3x0t01I0dBTG/fO02dd21p4bIn6EE4?=
 =?us-ascii?Q?+1JuTnX++RlpLwQUuhGrPphcvT3cEHBDX3FpUMHoCRYzB1Et+1wamwpGhp51?=
 =?us-ascii?Q?tgAfyzjoWlvIltbFe768Ae9PS7ONuN5e9vuzs7lJD4JRfG10OFhbRXs4mUMk?=
 =?us-ascii?Q?My+rgJneCkoX7hHk8cLxTKYkID1CezZqf1/S5DrRCQRD03RGCCLhfyHlYJcX?=
 =?us-ascii?Q?blvabSM5YSIMntyHKqIkmX47EgjcdL58F1i4P6PwplVH+0J4uusdygkESX/N?=
 =?us-ascii?Q?81awI5fRd/aLqye07EgA20WXQFeRg586NRnkWnk8p/al+Nn8mCBi2l0fXFOs?=
 =?us-ascii?Q?qXa3FD/0XRmL4hyJuOw/LNSTG0O5kmgRSApZFTWe40/ICas1rGfaSs+uriYa?=
 =?us-ascii?Q?aBXRI53Lg+ObK8PvJQa0twwjsqpaw19bRdurhOAUm1duymbwHnkCK3DkTkeM?=
 =?us-ascii?Q?Pn+7E2lcmoWUTyvXtYIEFF2YByGnNmD3rzIHtpYa69d2s2MnxrvF5NIrs8Fc?=
 =?us-ascii?Q?anW0AsqUtpMUKvKvZ9ZYY0hV625cWTgYZGRg/daUyW6jhrc7VvJgfjoIDvCD?=
 =?us-ascii?Q?X/HkgkuJrQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8151a86c-f293-4a2c-cbea-08deed4ada72
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 08:24:48.2904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DQIcoe08U4E3UnqAwvC/ii8HXg+zfu6AHDpxcLmGUneI/yPzbF9+H5cJXXtzjVd0I6UbAvR0s5lxZgBxzfckw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999222
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

On 2026-07-29 at 08:57 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Tue Jul 28, 2026 at 11:49 PM CEST, John Hubbard wrote:
> > On 7/28/26 2:29 PM, Danilo Krummrich wrote:
> >> On Tue Jul 28, 2026 at 10:00 AM CEST, Alistair Popple wrote:
> >>> On 2026-07-26 at 01:23 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> >>>> On Thu Jul 23, 2026 at 8:30 AM CEST, Alistair Popple wrote:
> > ...
> >>>> For instance, what's valid for userspace to extract from this? Given chipid is a
> >>>> composed value, is userspace e.g. allowed to make assumptions on extracting the
> >>>> architecture? Or is this something we want to expose separately and tell
> >>>> userspace that the chipid is an opaque value identifying a specific chip only?
> >>>
> >>> I _think_ it makes sense for this to just be an opaque value, but it's a good
> >>> question that I should probably try and get some internal feedback on as well.
> >>> Reading the arch would then be a separate parameter.
> >> 
> >> I'd prefer exposing it as an opaque value and provide other information
> >> separately; the kernel already does the work anyway, so why duplicate it in
> >> userspace. It would also remain much cleaner if encoding details ever change.

Yep, I agree. Just want to make sure we get everyone in agreement.

> >
> > Just to orient myself, I'm assuming that by "opaque values", you mean using
> > something that just counts up from, say, 1, instead of using real boot42
> > values below, right?

No. We'd just document these as a unique magic value that identifies the GPU
chip rather than something that could be decoded into anything else.

> > That seems like a good approach to me, too. Because I can't imagine anything
> > particularly good coming from providing unnecessary details to user space
> > here. :)
> 
> I'd probably not be too worried about keeping it as is, but just document it as
> being an opaque value that shouldn't be messed with.

Yes, agree with this. I don't think we want to mess with the value. It just
makes life hard when a new chip is added thats only difference from the nova-drm
perspective is a new chipid. You don't want to have to worry about backporting
patches to distros and kernels just to add the identifier for say TU117 even
though it's functionally the same as TU116 from a Nova perspective.

Obviously chipid would still get added to the header and eventually backported,
but having been there and done that it's not a good user story to require it.

> If we expose the encoded information separately I don't see a huge incentive for
> userspace to redo the work and mess with it anyway.
> 
> The advantage of keeping the values as they are is that we avoid having to deal
> with mapping values back and forth. I kind of like that nova-core uses the
> values from the uAPI header to define the Chipset struct, passes it to nova-drm
> and nova-drm does use it to fill in the userspace exposed data.

So do I.

> Something else worth to consider in this context is whether we really want to go
> with the key-value pair GETPARAM approach, which can become a bit tedious.
> 
> I think for the basic GPU information we could have a struct drm_nova_gpu_info,
> which contains all the relevant information obtained at probe time, such as
> chipid, architecture, VRAM size, etc.
> 
> If everything is available in a single struct there should be no reason for
> userspace to mess with the chipid value. However, I'd also not object to make it
> a "real" opaque value.
> 
> In order to deal with additions to the struct we could take a two stage approach
> to obtain the information from userspace; probe size first, then allocate with
> the returned size:
> 
> We can have a DRM_NOVA_INFO ioctl, which takes a struct containing the info
> identifier (e.g. DRM_NOVA_GPU_INFO), a size and a pointer to the actual info
> structure.
> 
> 	struct drm_nova_info {
> 		__u32 id;
> 		__u32 size;
> 		__u64 info;
> 	};
> 
> Userspace can call the DRM_NOVA_INFO with the identifier (e.g.
> DRM_NOVA_GPU_INFO), size and info pointer set to zero, and the kernel fills in
> the size of the info struct (e.g. struct drm_nova_gpu_info).
> 
> Subsequently, userspace can allocate memory with the size reported by the kernel
> and call the same ioctl with the info pointer set to the allocated memory.
> 
> This way existing info structs remain extensible (as long as the layout isn't
> changed of course) and new ones can be added at any time.

I did consider an approach like this but having to do the two ioctl memory
allocation dance doesn't seem any less tedious. Also my experience is these
structs tend to just grow over time and become unwieldy as new bits of info get
added and old ones deprecated forcing userspace to allocate memory for things it
might no longer care about.

Ultimately though I'm thinking (hoping?) there will not be a huge number of
these - a lot of this info should probably get exposed via sysfs anyway.
