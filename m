Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726B1C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 23:22:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D56E910E1BA;
	Tue, 30 Jun 2026 23:22:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gMFurFjV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 092AA10E1BA
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 23:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782861722; x=1814397722;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=KouEiZEm/7V9k7+U0esL1m9ThviPIHx0Eb+SBQXtC8A=;
 b=gMFurFjVlEEUqOC6kr7nrHpnGpBWy+1vkyOgCGLa7TeXCYKu8wtg0V9K
 /cXsA0lCXAVpx7Jrmy3z1dTrWa+dw5XlOp+PDywCo//CimPXyeugvXgjy
 dZx+abGYOO4cdMwupmCdhL/BLMTwqptQvyNXqSST0PmvIv/bNITIGD1QP
 RtpR+0RCNfUPGFR9VEPjGwNsgqS3R07r65+tmXVOmsKdxl0QpuPbsG60+
 RsMaknoqKzYVAF3jVePcKTjGcZ01U2gvtgRncVc69/dWG5Qpro6VAp4hj
 aaJwIo/7fbgmMjJZ2bsPcbCzKRgtVgX3Mx02TzWGhW38kij3Ru1id6OSA Q==;
X-CSE-ConnectionGUID: 8AP0UOUMQh+atKAo98omJA==
X-CSE-MsgGUID: yWO8wQZyReWz9sLz0Axqkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="87420953"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="87420953"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 16:22:01 -0700
X-CSE-ConnectionGUID: GZCns/H7RGKXNbOjcyAKJQ==
X-CSE-MsgGUID: CyiWZ5L9QF+X0lA3TCcBtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="290523207"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 16:22:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 16:22:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 16:22:00 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 16:22:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqCZLwqWm31sbryDPcjpBbMZmsEKr8A/rOyHdOvqcZPoFm21v7xsP2wk3HhEtwsCH3KcagG4wh/2WJV0EWun5Bu6Fw4GtoMxYj1aLv6crKivN2uNaszyCx85t7gfRMZGVYoKohMWFLODGGay2uaBgr7K8HjsWyw8bJo+huR8aoUWRcTtLndHkm2bi6+FempNyGw3sTA7VF6W55wTyJV+pM/ARBRDDoN2M63rG23Zbtz6J49A8v1jSlMLAWHI5ZnhS5kAD3ofHwcq9ciwHJDlisRZeTsiNv3MGMoV8EoqkWxL4x1uPGUvCQrW56x76xU3lrByRPPmLShNk+Xg0O3/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzN6r0bpy0+vPDXKrxy0OCSvzaoUGYg+yy1eHMBWRkc=;
 b=b+LHN+cx/76H5nLwwI3odAwlIaQ9O6XD+Ys4uGu3KOix5m/MqW1nD1cmJj6uYyH1ViwEsrrxC3aotJGRnwJz7ISQQ6K6hVldK9zc5hP21ZyTbCkuTUw+jjKbKEa5+MVNlMkVF7Nbjj0O5Ij2NeUgxvVxivHDlYy8b78rfoyAi4lal6YusJbsSdDhYWCLCGNe01HR5zWQ4xiBTxuX8ZcbPAzUKb2uXGTFx/cwtwOKkTqWLcelyo7gZy0XdHY5g5xNaRkaafY+chfSEwYrcUkefvxLZ/3A8FDVsD384/Opxh7M5eiiS9SEGsXzSY/9v3DC3l6+yj9Eec7pI0YT1WSpqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CH3PR11MB8562.namprd11.prod.outlook.com (2603:10b6:610:1b8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 23:21:57 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 23:21:57 +0000
Date: Tue, 30 Jun 2026 16:21:54 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Dave Airlie <airlied@gmail.com>, dri-devel
 <dri-devel@lists.freedesktop.org>, <iommu@lists.linux-foundation.org>,
 Alistair Popple <apopple@nvidia.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: Re: iommu/smmu/PCI ATS + TTM unmaps + nouveau best way forward
Message-ID: <akRPkj5iNaNgIqNk@gsse-cloud1.jf.intel.com>
References: <CAPM=9tyu7JAF9GD8GbSbeb++i-UqX59_OcBVY-cFyDyB4tBO8A@mail.gmail.com>
 <20260630113919.GC7481@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630113919.GC7481@nvidia.com>
X-ClientProxiedBy: BY3PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:254::15) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CH3PR11MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ab521ff-0f99-4926-8fb3-08ded6fe6103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|11063799006|22082099003|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: kkqo2OnHaFWzV9wfEFEfFcBwBQSQRmr2WYDiJ0iVXGxmMpKwhw1XnnK6cZl3TBAeU4GOzIeZvovKLsRtTa8dUdE+AS3uYDu9sRQ8WeLksosKzApMByTURW/YJ6YcA1d/8bc7CnaO8jMBYIri2ZwQQIbM8ItoPOc7qBDavimO/6w2JiHkrteQtCeWLuFEDuhbbV3xF7PWYTWyaXZDhQxVsfRLeqNxpiUu7gvG5Cq9xaKOgt50fNqrLLOZhxJESpz7RK5GX/AVRoRroEeCleI8rdP5EIZ1WipmAU3a4DICAkj7Wn0GLC/9r1BMdhtbfaMCtg/aVOHIGX8BCSp14GwZNiUngtpiron+9drqjrShJ6oA+DJRCdHgjejRABKII9wQnnFjBcANkiji6MchJXpYmEJwcJJEYY2Io4m8clgy4F13RM+g/bmAKign3hMFfSuSxgx9MMEmZJ6QSYaEKvKzIgCqxXioiVJtB0YUehQLSglmnZ4o015vMKQvrpJik9K2hLzXcpbMOVkASiNIznVI3UKN54n4Nu8cSHKTB8jP96pAog4HF3JRTwafpn+rtjo/e0Mn2v9V8O7APBbLEIcgHt6kL/IMM3p5l8oLMzWbQR9MhsiJ5yH3S8t7CllHJcSHtBCyITZy4ifIWbBNGl1nXR60FER0xDIrOVqTg/fM364=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(22082099003)(4143699003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C8192ZWZ5avFO57u9HbO7NBicvJqUdcmPSqIN24FSIaXFeu9w/u266neWymi?=
 =?us-ascii?Q?pq//p2umT2ra5y+2lCoFitrU1P90HbpHZn0owmg7CMahHB49SJGzmOROR1+f?=
 =?us-ascii?Q?oz06r8voKKUXwBIGCZzpQWvZBaNSB6OHSFxX/kZsubXOVLrI4F3NAV10qM2U?=
 =?us-ascii?Q?qTu44ZJ3Fx9U6kTMLEjw7WEM+z+/61QvJVeX0ltlfJXaY7GY/ltLFOXE/A5r?=
 =?us-ascii?Q?5ursauoHU6SfAU5c7zryHp/JfY0gmbtJB77J80EJFM5QurI7hqjwEvtaMFw8?=
 =?us-ascii?Q?97iKwrbo7kI/649Dxuti2egswXPLPQnYPVs9NG+7cVlpNjAMZDtV5wvga/BB?=
 =?us-ascii?Q?/D48KkORJxoIyLu2iiGV4+3gequ+PunM7NGx3UVrBNPGfuGz/MQtG3CmMyrL?=
 =?us-ascii?Q?BY1kYIa4P8eXUh8n/PeyN2QTHYBNGKgrxMx0NkXq6RKK4Otb6GxK6jV+f79w?=
 =?us-ascii?Q?JmsoBbRHNvvltnEPuISLhSdzhvL9GskRMFVVBZZnfpBZ8btr4BPSihx5wLRs?=
 =?us-ascii?Q?QMPBkNI6FnRFVh7nfPGjPMMQsyombTO4+Y6qLejJzx5NNNJ5sCt85w7l9qHt?=
 =?us-ascii?Q?wnCMddWZNkCHdjH5WIfLUfzjK0BzxOugRohqtdfSl18JY/hiJmAXELnMnId1?=
 =?us-ascii?Q?0XVNk5qQ8cUVUQFxOv8oQuekRgbdjqfEMTpjqMfzocBpPdBUYAEnBnfPa9xi?=
 =?us-ascii?Q?ri2JbuXPybAUNXubsaLoeXxcxaIvyqg0EGJh0kzZ9Aj7txs1SYyDw0J/c6kc?=
 =?us-ascii?Q?xT2RdyzOdLEgZ7BRztHB9SeSEqyiIP/XE+YNffEzEKO7oje7ivx7eD0Raix8?=
 =?us-ascii?Q?yNYaxRb7iw3ZQJENkOf0ZOPogAFb3HrUed+9ybl+ie+xrfPtGaHWntkJ9Prz?=
 =?us-ascii?Q?Ow/4VgJ58tUvtnOXmqLXdgl3H1esYbSnQ+y4Q5aPZbfT+4S3Uca0Bj1faqs1?=
 =?us-ascii?Q?sfXOL+qLhhUV8T+o/V2fnkWZL5/HW5XS1UCH9Z57Yao8YBMpW5bLuPBQgzuK?=
 =?us-ascii?Q?DNa3SOwYhIDoc3GgsA+JCrUWi1hV3XsgKTdeMmOOLdW8AphWjsM8kHXEY6Dd?=
 =?us-ascii?Q?9g+GQZRIUqOM+sgbNCyu8qC5q6oNlWoaAd8neN0/4KSiXMovpnRzoQK61fMo?=
 =?us-ascii?Q?CJO1vh4ufSO1DaSZlVT8KHrpr6xK11YsmiNL+6ShKPoc4XZKGHRxq6EfUJNt?=
 =?us-ascii?Q?MC+CjSpK7sB1qmyRy24pdMC66kZo//84VgsLleJCpWmbczMZA5ebcde4jVu3?=
 =?us-ascii?Q?9GgeE8uzdi0lgufel1jqSo9ccc/4d/FDMYuD8+47rjSIiigWnQI91P07aB+E?=
 =?us-ascii?Q?/i1qCF5RibbKZKPkXkrmtPS8suMShtaF8jeji+R9/NS2kX4iHpjv+2Z+vSe0?=
 =?us-ascii?Q?3S+0HybPjsdcScb+Y34l3te8ToSNjxkJKX00Qhgrf45IQkz/vI4DUavcsW93?=
 =?us-ascii?Q?22q42JLcUpF4v5RP4oSar0jH9D20Lz9CXuPRORhtfvTco3zeDuv3ChTsZB+1?=
 =?us-ascii?Q?j3bkBOpWlBpAvR/hv/A4aM3am7vxPMOAiD7fZ1BVRJRgP5IZ3ojxpXpEGFn0?=
 =?us-ascii?Q?WmilM9QvDoKcsw+kx3awixxkMqzuHc6lMxSLu4+U6TfHFNJyLsddoEd2Voie?=
 =?us-ascii?Q?Zr0D7EkbSF4oiX4alNSAfVhCWFVvKqech/hLgacA2kCi0nB5CWC18vib++Kp?=
 =?us-ascii?Q?u8lKV8lkq7fvPedw7d4wC2yLTYz5THhy5hdCZVVyyzmDDiG22Gd56F1zzlJ0?=
 =?us-ascii?Q?El6mmo5nbA=3D=3D?=
X-Exchange-RoutingPolicyChecked: EYa7V0IL/EYL/MO+bGwAkKOoRiY69Q/DtzkpOUIQFtH0jjNpa2bzDkTEikOxoelXbq188sNvUhatT6Uptj/fZQiOu4mBAABcvDVQcX7qJV0xOFAkfJn0EFqUjKnFGlsQVS3pg4wHMAvIlmFuvPiX6RlZjdDZzXQUsKf4KxGqaKKA6tcaIN4vb1FoW4M7LmKAsPcbjbedl5gnHaRcb/rNHLP1EjLDTxQLV74l1fuXKdeG+z7dJD68EAK7CDq4zb6ee5J5YWrxKcjEBrlxJQEsW9Jyy6BDBLP0MOufxPcEW2Gc4XH2oKyIIulOXVfTMjsRomVQdtHGedN6Sv/saL4tBA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab521ff-0f99-4926-8fb3-08ded6fe6103
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 23:21:57.3148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JX8IbZbS8ewbn1BDG1n4Sw1OIuNzb3tOKC24dH+nNimdOiPmyPTbomORbJEQOz+7BlV8qyxDxIEYnmfLKCgsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8562
X-OriginatorOrg: intel.com
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

On Tue, Jun 30, 2026 at 08:39:19AM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 30, 2026 at 07:39:44PM +1000, Dave Airlie wrote:
> > I've been bringing up nouveau on NVIDIA Spark GB10 and fallen down a
> > hole of why is the GPU writing to pages I've released back to the CPU
> > page allocator. I've wasted a lot of time on GPU L2 cache and explicit
> > handling for it, which might be needed but hasn't solved my problem.
> > I've also invalidated and flushed the GPU TLB excessively.
> >
> > Today I finally hit up iommu.strict=1 makes things a lot happier,
> > non-strict IOMMU seems to allow a race between dma_unmap_page and
> > free_page where the unmap goes into the IOMMU flush queue, where the
> > actual unmap are delayed until something triggers a flush later, and
> > the ATS translations stay alive past when they should, and after the
> > page has been allocated by some subsequent user.
> 
> It is a driver/device bug if it continues to DMA to memory after
> dma_unmap is called. Strict mode is intended to increase security
> against malicious devices and to aid debugging buggy drivers, it must
> not be relied upon to have any functional effect on a correct driver.
> 

I think I agree here. In Xe, AFAIK, we never call dma_unmap until all
fences have been signaled (dma-fence or preempt-fence mode), after which
GPU translations are rebuilt before the next fence is installed, or
until the GPU page tables have been invalidated (GPU page faults). TTM
is a little harder to reason about, as we DMA-unmap via
->ttm_tt_unpopulate(), but I just audited the call sites and TTM looks
correct.

> This is not an API issue or an impedence mismatch, you have to follow
> the DMA API contract when using the DMA API - meaning before unmap is
> called the device is not doing DMA any more. It is a purely a
> driver/device bug that the device is not quieted prior to unmapping.
> 
> You cannot fix this with any of your proposed hacks, the driver must
> have control over the device and it must know when the device is done
> DMA. Presumably there is a missing flush or fence that is allowing the
> GPU to continue to DMA even after the OS thinks it has told it to
> stop. There are many unique things about the coherent GPUs, I would
> not be surprised if the driver needs some additional fencing
> operations to clear the fabric beyond simple cache invalidation, but I
> don't know.
> 
> Normally strict would convert these bugs from quiet corruptions into
> noisy IOMMU logging, however in this case the GPU is using ATS and the
> IOMMU does not log non-present ATS responses. Instead the GPU's
> internal attempt to DMA will fail and the GPU will do whatever it does
> to propogate that failure. Probably the driver has not noticed the
> fall out, or it ignored it.

Right. We only have ATS enabled in Xe for experimentation, but whenever
we've had issues with dma_unmap ordering in Xe without ATS, they have
resulted in DMAR-related dmesg spam.

So TL;DR I'm guessing Nouveau has dma_unmap before GPU idle bug
somewhere.

Matt

> 
> Jason
