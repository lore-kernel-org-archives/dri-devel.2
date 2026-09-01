Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452EDC61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 03:47:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72F9610E380;
	Tue,  1 Sep 2026 03:47:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="HkQlqgw/";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2760310E372
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 03:47:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCWd28w6QPN5/bzywrepvEGRprv/245WCP/AoZbePXZsZnIGi8uuhlLNkzVzMx5HFojqoUZm74eydObwEKV26zqYj9akmrRs8YLPQX82DOQ10/rnrjD6xzAH/o/HONxMwskY/5oMHOsKkLluEd3hSnuxyOxXiKoS4orWd2nCp6Qf1m1UfbYewNVYfB3NSG8ESsp13q69ycS7kShp9rrKd11lc9YUTySNQsrizbkYQY7sdOVlWpVZDpuedLoyyfQGDenyF0B1RsjkWuDv1CFMtG8b5cEyH52M2KQu3TZQKzhe5KHcCGt5Mb8gEq4cnzxrCDTACpNy/dRl2G2YJYYt4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8AUUCwFwJfrhH0s8NhgUhJabZHt3RvHo5VixbUL5dk=;
 b=tE77Owg50vUseXjvLZwVyPslF9btw+HrIX5TKxyXKhIdgMAFwmtaG5mr44CZ6CDWsWbSRMCVMs0bQbVlL3dr0r1uc7GSBlPuVv6KsQPF5v3031jxVzXANj/l2zuGoMSkibZ9nHJUxRxBB9mRyzvpLsGW8UIIc3O3K1sLNUYAqYVrg5dOXdLxXWHU+EeCBbYzikZiDMHMTK3TRQ+FDzpkKmbzrHekLSjDmRFOFTt3DXZkCz4wcRFcXr7IDxIJMjCmwOnmrwz4cYM6wEyKY1IXge6Rp8Ppgd3FF20wWFMVSGCh9QJa8gkqdqnm+mCvV19ywu5FDK9Yccq6le4z1mXrJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8AUUCwFwJfrhH0s8NhgUhJabZHt3RvHo5VixbUL5dk=;
 b=HkQlqgw/rSxdc1YR5CTwjgG2LVB0RpbUaY2K4vVVfwT0rUHLw1mihj06R3ivE0Tp3CU4oJQ76Le2125PfIWle0I2+ila3MaSThijP/0nKkOsGFWe5SIdZ4QuMl19I+D/NVxpb10Uszp8RNNoaFyK/iE3O/NfBD6FILy2Iexgj2fDvdnWCbEVWnhOR7KOI+Dnzh7TYjlq/HNA/d7YRzsv/8XOxWVNpwovysF0F2oagAG7KCqkWdSaE+81A5H2Dj86HLDMZeICrqYV9nVVyDXPGdnycm8VXXw2guVXJ9wuuDW7kh2KajUQVWVORb51YQqg8JHJz/taUcM5X6GQXt7ROg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 03:47:36 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 03:47:36 +0000
Date: Tue, 1 Sep 2026 13:47:31 +1000
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
Message-ID: <apZCTUYiN5FHCkCm@nvdebian.thelocal>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
 <DL373JA1ZANX.21L51RTEUQ2UG@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DL373JA1ZANX.21L51RTEUQ2UG@kernel.org>
X-ClientProxiedBy: SY5PR01CA0106.ausprd01.prod.outlook.com
 (2603:10c6:10:246::24) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|MW3PR12MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: d7c48d3a-88c4-445b-94ab-08df07dbc347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|10067099003|56012099006|4143699003|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0I1OGK3m8pa8k9V6doL7tYtzfqVgoz1IzdwojKPvPQl/aZgpWvc4/39HocDbusx9zCRnV79g94xDFM4ObCHM43iBzJsGEvkMSRayKK1hhwePSJCfs0nJnlgWant2u0tbyZL7j+zGGtT6ddo79Hn1GAvcFu+ZPY4Yyr/LO/HSVlz2Z69yVIgsXEFozWFWrWkneJfC2K/u38L7s38kge8TuJvV60w/84Os0FkROMWPz1BPDZJOkgoG04OgY9mpw37c8BBFansQfLq+xzaJbT1zlfvzNOnADEid8d/DaBlFebmVCFD4OtR6zlVx2pnK8Z/F2rUC4ZUZ0pIwqmQo9x+YcxmNh1/0CZcxjZwTx0y49uC84jHfgRVb2sx2oBle2c9hqNAySRPmWDMT5MW++UoUNBl2jcam+c5FrJw+SOxNYElnCjDNvi0oMe7R2JOjB+kuBPE38hKOVbrklJslM/unNqFje+oK5ENp01mCJ9Z68K/1SqqNYSQRm7ECe6RHwr5HGTYZNE06DnqQgHGXXC+fnrGwDxtOZujIgyan3a40Grhkn9tIb9j2Y2l4vBY4lYiqm6bowzCm0jnz9gkfVdpsSzMYYgL6J8PeGZuxTlaNNY6enVssnuLAnUWj6XUhgXZnmNu2mW/By1/sfOkn84uTINqbPxW9HSfa4jYAPN3hZXY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10067099003)(56012099006)(4143699003)(6133799003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mNeysAJT9xbbctK55ASHcL0nEIjKjM8ZQ3g+llNqY6iUwmyu8hVbVYIRnTvt?=
 =?us-ascii?Q?VTAa5D2TqM77sT5B9CYQm0Lhu86h//IIefp95WR7HlLb2Hd6Ve65K1dp8Vpg?=
 =?us-ascii?Q?gq3GMDtapmuLBkn3nbStlJesiSUxH/gSkAUhB+I85lyhEOL4/kRBWJh+TBvl?=
 =?us-ascii?Q?aBHOUqdcqpf0VNX0L/VKFxdXMIu9u2KGxeCWSH+aopMfQf9gU0KyW5YZGPSx?=
 =?us-ascii?Q?2XaaMXYfHZVx+gok24lo4G9RuRITsTszJYFQ7F6KPteZx0+afAPrEWhwdWfd?=
 =?us-ascii?Q?hG2OD8j5BRUpwC4/CZhJal+uFmuCSNaJovr9cJWdyXxrzlqqWs4iNTc542xj?=
 =?us-ascii?Q?SJTKsTKo3mn1O3q8dArcR8s4EAJ6n3ntkbra/oZxb9zkxpkLaysvDjcbufjO?=
 =?us-ascii?Q?FjgVMa3JN3pmZbTHCAsW+tVK5MuQek5vJV7J/YjFMlnFbDNqAB9txBKw7mYU?=
 =?us-ascii?Q?A2cdzrQhzkGoTIZsODkWyPA7NmpBHTsPsZBP212ty4lKC75lPu/I7xiQd4m+?=
 =?us-ascii?Q?yJ8b9kz28FbXJ2Oi+LasGIpuAiRWeA9v5vTuF/nVtNUzUknKiAO3vHfQV8mt?=
 =?us-ascii?Q?+Semrc5XvUlcd9pCYVWbtmZAUfdnbcQka/myXKiiHaEY76W+PIrh+AA6wBLQ?=
 =?us-ascii?Q?9v35fd1v7vouIiYH74vX+RrJGu5pPM2xzuiTQTevgWHNoPPdhu9kcPBwqeXg?=
 =?us-ascii?Q?F+I38z2UG11yj/ugRo7NFzfwo9VpgXKlpXhSNOgda3F1ZLthbqUSpy6F9C5T?=
 =?us-ascii?Q?Q1vpVdNm23Kpze4k49lNYTHm+OXRh20PNPhoB9Bf79PfB42kYAgem1haSCHL?=
 =?us-ascii?Q?6xIdDe5MhPx0+l/gPoMrHQQFlzz0tJxXr6fMJ6bYAPMuxXm57qfSZALGvHpp?=
 =?us-ascii?Q?aWDBqE8EoIkr396P1onvs7gUcFPD8aJpwn1bUGPAwudhZYlJli7FEs2lIyqm?=
 =?us-ascii?Q?Xv3YpwzfDnAq3V9BKk1AJRNBREGZTjoNyklqFnqKBIi4TQOfCv7G5ZchDZfW?=
 =?us-ascii?Q?E6K04P10PlvxwvqHvbjXKxDgvnPsMQHhDOcXNuBZpLdbrak+6Rq+1TsRlOO6?=
 =?us-ascii?Q?l0N1ajoPMQ/osq8zsNo6w6rMdTczp1P8/oWuzEcG8ERnmEXkhYaa8C6l1vJG?=
 =?us-ascii?Q?Sn4XhD5jAODhNa4ompbDKLb6IzTr/sCK5pMaVy7skPGHQnobkTx5YCiLgB1K?=
 =?us-ascii?Q?azwt67iVNq4vMxpAog1lw+JiR323ubqGWh4GrxWAKNuyuPcoULpYr1poE5P4?=
 =?us-ascii?Q?YepZJa9oKZja+07EkJXyuMul6kFccrRDF32MuGBWklPCIbCZERFXF9Fuuq6z?=
 =?us-ascii?Q?MOLol/bsLhLQ6dfKUtWuoPsfvJ+u7PAPUM9iVf1Y5ghz1fL+pGBkcNLIqV3C?=
 =?us-ascii?Q?QFQ76UnfuqQ5gCp9KuzrG688dapTx+9ZPzWdlkcAv1/kiuSit4/4j4wHVgyz?=
 =?us-ascii?Q?tJCp8rRq9JW1bsY1hKQEU1c5x8osZeWoEbGtyuLjaHzuJEh9msZH3NBvDJ+t?=
 =?us-ascii?Q?bOQXxo97pcziSGeKh03/VFutfCDkF2QJcu9slfR/ubw20qaRtQ1jCaTS+B9g?=
 =?us-ascii?Q?//yl8buBiZXEev3aGGTmCQSTOJXY09V9Ltyn3Ec55Tu0pL2KsWEMs0ZHbiga?=
 =?us-ascii?Q?KkR0tWCw4MIPXv7h/F0DLiKG2SYdxt6Ntof0IlzR8dxp0/ay8mrXEhfdQiIX?=
 =?us-ascii?Q?wDtwoT6dAyPtxkxlHCs4J3HWuhYFv9xRnJvJxTv8N1ZD7xBp+y/F17w+BJoe?=
 =?us-ascii?Q?kJaxz53q5w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c48d3a-88c4-445b-94ab-08df07dbc347
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 03:47:36.6620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u768VKdjbfFf4IuIn22GXbBAsmo+tGPpewHp/qADIEi78kX36cjzoLTbPRXZVKL/L0BpofUae2AYBqGgL3jeFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379
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

On 2026-09-01 at 00:23 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Fri Aug 28, 2026 at 5:35 AM CEST, Alistair Popple wrote:
> > +/// GPU information returned to userspace.
> > +///
> > +/// # Invariants
> > +///
> > +/// - The layout of this type is identical to `struct drm_nova_gpu_info`.
> > +/// - All bytes in the value are initialized.
> 
> I don't think we need those invariants. The first one is covered by
> #[repr(transparent)] and the second invariant is trivally satisfied by the fact
> that we create a value of that type.

Ok.

> Maybe you meant to say that we explicitly initialized everything despite
> uapi::drm_nova_gpu_info being FromBytes (i.e. no "random" values)? But I think
> even that wouldn't need an invariant.

Yep, basically trying to justify why As/FromBytes is safe but if the safety
comments for these implementations on their own are adequate I will just use
those and remove this.

> > +#[repr(transparent)]
> > +struct GpuInfo(uapi::drm_nova_gpu_info);
> > +
> > +impl GpuInfo {
> > +    fn new(reg_data: &DrmRegData<'_>) -> Self {
> > +        Self(uapi::drm_nova_gpu_info {
> > +            architecture: reg_data.api.architecture(),
> > +            implementation: reg_data.api.implementation(),
> > +        })
> > +    }
> > +}
> > +
> > +// SAFETY: `GpuInfo` has no implicit padding, kernel pointers, or interior
> > +// mutability, and all of its fields are initialized before it is written to
> > +// userspace.
> > +unsafe impl AsBytes for GpuInfo {}
> > +
> > +fn write_info<T: AsBytes>(info: &mut uapi::drm_nova_info, value: &T) -> Result {
> 
> We could take T by value I guess? We don't need it anymore after it has been
> written to the user buffer.

Makes sense.

> > +    let mut writer =
> > +        UserSlice::new(UserPtr::from_addr(info.data as usize), info.size as usize).writer();
> > +
> > +    info.size = writer.write_truncated(value)? as u32;
> > +
> > +    Ok(())
> > +}
> > +
> >  impl drm::file::DriverFile for File {
> >      type Driver = NovaDriver;
> >  
> > @@ -78,4 +112,27 @@ pub(crate) fn gem_info(
> >  
> >          Ok(0)
> >      }
> > +
> > +    /// IOCTL: info: Query device information.
> > +    pub(crate) fn info(
> > +        _dev: &NovaDevice<Registered>,
> > +        reg_data: &DrmRegData<'_>,
> > +        info: &mut uapi::drm_nova_info,
> > +        _file: &drm::File<File>,
> > +    ) -> Result<u32> {
> > +        if info.data == 0 {
> > +            info.size = match info.id {
> > +                uapi::DRM_NOVA_INFO_GPU => size_of::<GpuInfo>() as u32,
> > +                _ => return Err(EINVAL),
> > +            };
> > +            return Ok(0);
> > +        }
> 
> I think this check can go into write_info(), so we don't have to repeat this for
> every info. I.e. we can just add
> 
> 	if info.data == 0 {
> 	    info.size = size_of::<T>() as u32;
> 	    return Ok(());
> 	}
> 
> at the beginning of write_info(). It may construct the value even if
> info.data == 0, but I don't think we care. :)

Heh. That was why I did it this way, in case obtaining the info was expensive
for some value of "expensive". But info should mostly be cached (ie. cheap) and
I don't mind keeping things simple :)

> 
> > +
> > +        match info.id {
> > +            uapi::DRM_NOVA_INFO_GPU => write_info(info, &GpuInfo::new(reg_data))?,
> > +            _ => return Err(EINVAL),
> > +        }
> > +
> > +        Ok(0)
> > +    }
> >  }
> > diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
> > index 610cfc01111e..cff730a38c1d 100644
> > --- a/drivers/gpu/nova-core/api.rs
> > +++ b/drivers/gpu/nova-core/api.rs
> > @@ -12,11 +12,12 @@
> >      types::CovariantForLt, //
> >  };
> >  
> > -use crate::gpu::Gpu;
> > +use crate::gpu::{
> > +    Gpu, //
> > +};
> >  
> >  /// API handle for the auxiliary bus child drivers to interact with nova-core.
> >  pub struct NovaCoreApi<'bound> {
> > -    #[expect(unused)]
> >      pub(crate) gpu: Pin<&'bound Gpu<'bound>>,
> >  }
> >  
> > @@ -26,4 +27,14 @@ impl NovaCoreApi<'_> {
> >      pub fn of(adev: &auxiliary::Device<Bound>) -> Result<Pin<&NovaCoreApi<'_>>> {
> >          adev.registration_data::<CovariantForLt!(NovaCoreApi<'_>)>()
> >      }
> > +
> > +    /// Returns the architecture identifier of this GPU.
> > +    pub fn architecture(&self) -> u32 {
> > +        self.gpu.spec.chipset.arch() as u32
> > +    }
> > +
> > +    /// Returns the implementation identifier of this GPU.
> > +    pub fn implementation(&self) -> u32 {
> > +        self.gpu.spec.chipset.implementation()
> > +    }
> 
> We should make the NovaCoreApi just provide an accessor for &Spec and make every
> subsequent method we need public. Otherwise we end up with endless forwarding
> methods. We can also add as_raw() methods to the specific types as needed.

Ok. This is where I don't have a good instinct for what we think should be an
accessor/forwarding method vs. where we should just expose the underlying data
structure and required methods to API users.

In the past it seems there's been some resistance to exposing nova-core or gsp
data structures like this which is why I added the forwarding methods. In future
we're going to have other data-structures that NovaCoreApi will need to access
so it would be good to understand what we should do here so we can keep things
somewhat consistent.

It seems pretty arbitrary to say expose self.gpu.spec externally
because of endless forwarding methods but to then require them for say
self.gpu.gsp_static_info. So maybe we can just have a NovaCoreApi method that
returns self.gpu directly instead of writing forwarding methods for each field
of self.gpu that we need to access? Access to genuinely internal nova-core
fields/methods can always be controlled through visibility modifiers.

 - Alistair
