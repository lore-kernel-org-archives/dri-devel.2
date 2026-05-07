Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60286CD343B
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 07:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1DC910EF96;
	Thu,  7 May 2026 07:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GXi1brSS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C24E10E1C1;
 Thu,  7 May 2026 07:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778138397; x=1809674397;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=GZYDBPb3tFKVFxShadY9aJaXxQYrVisltw5hUFkPj9I=;
 b=GXi1brSSoL14kn5EC8FsaNO6q/BqQYUi2ULqDP+m9VrQ6bruliU5f6JY
 dbiG/vCSF8i4EbzXk7RCgvzOqldD35phq+g0QjBOvMDqvcwHjkfsUIgA8
 qQfoCcoe67VvuNI40YVrzW2w5b4SAX5gpZMt0ZwARz++i53Wpw8fR/EoQ
 8LVyVegAOGeOGUFOWL+bUY6pGRYJFSkkHH+ZeC6yj5VHm/kciXWWA2rzF
 D++t1Ah50gZtkSlqe42VkDXvd1SFVteBEa6krtzYR2GF7pFv2DH8Ot4WB
 ERGWao109hLe9CbFLxyEi7utZMZiLGeZsyycG2HquGxNdeIdK6tbaVV8j A==;
X-CSE-ConnectionGUID: Kbi9o667RPyPUi/uZBA38Q==
X-CSE-MsgGUID: CqGBfpnAQsi4MRKOry4jmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79018301"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="79018301"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 00:19:57 -0700
X-CSE-ConnectionGUID: SQDEkOfXRx6SK6y9fineIw==
X-CSE-MsgGUID: JGPCaFpAT2KKYEarqqVe8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="238184677"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 00:19:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 00:19:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 00:19:55 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.42) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 00:19:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9fQV8DrqOKqfzrXSGLe7Yq7qnTa4ogBmM5BbHA+z0qMTzILTFkmoX+7fW/G1N1vA7HrP454qK6tMOOgs8CpuBhQs6dLfU9B4k+gJCkY6J2OsCBKK28fAeK9aV2VXPxsG1KfQOtXeI91p5wKW+gC4HZjlvsTr8U/Fdya8phG+50mGWOtPKJxjF2KVjQvkWa+UhyLLoM8TdIkMn9s5Zduvv9/jbeqCvtO8cJTRFodUUjUve2NxjwxLtd9RnpsItyEM/dHnLke/T3VZKxZ/0UOQP7CD7SIqLdYOH0b++Fdzc9wXPSAwm68kluJHrnhZVj2Ap4WAsAa0h8vURt6U/Vwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWpbJuPYlcl6X7x6PoM29Edn2ciMOkQt12N37zI06OE=;
 b=kXzm4ii0U7hMmZabv/TOuqxT3a5TPj7EEx2c/MBztVH5ve7Lg5B92di7wFNG1Ow32KUPtcVNEebPyb1gspbKdRgl/6yMAgpPB0aHj+I98/gSKCut6trKXyG7R8qm8PF7Foso7z21b+jkb30EEmB8nMEznTq/uigH5Zq+1p+tcSIEhOo9+HMspBy8NQAUYUU45DVdsgrkONWx1tHXO7jDfuw6SzPhKrGYnDPgQIEAwfDiOYmUonaY2hl8dcLD/iFRQ1iBnSg0IteQV5YSmYmCo/PdnCjIdK/Fw1OZj8RBInTeLe1ZqQ2luMbDnD0U5R8A9C589nzUspeGvwPTtC+zGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by LVXPR11MB9780.namprd11.prod.outlook.com (2603:10b6:408:387::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 07:19:48 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 07:19:48 +0000
Date: Thu, 7 May 2026 00:19:45 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: "Lin, Shuicheng" <shuicheng.lin@intel.com>
CC: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>, "Auld, Matthew" <matthew.auld@intel.com>
Subject: Re: [PATCH v3] drm/gpusvm: Drop redundant @flags.* kernel-doc on
 struct drm_gpusvm_pages
Message-ID: <afw9EXpO/fvTamCq@gsse-cloud1.jf.intel.com>
References: <20260501175956.4054088-1-shuicheng.lin@intel.com>
 <afUrpqc4vd0zFekW@gsse-cloud1.jf.intel.com>
 <DM4PR11MB54566E418AC5AEEE8DCF1E4FEA3C2@DM4PR11MB5456.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM4PR11MB54566E418AC5AEEE8DCF1E4FEA3C2@DM4PR11MB5456.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::8) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|LVXPR11MB9780:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cada269-6e45-4d0b-84b8-08deac0905d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: TvF8KAg6oCkIogAlqZr3G9sXhIyWJroptlzWGUUy2muTfxP9Bx5WhUwph//1PVuUbAZG0ZQBhlv42aVFxB35tKxB/E9b5Xowr7MdFSBI8D56JRUl9bZhvRFfMQV2o8EsUw5w0NhT0ES2kmlRyXdjZsKLFy0kwTSnqjwQaGlHta62qS9TadErrY86YNnKeGM+XHoElJTro925R+d/2qNO40kmMRW/wTK5774QrDIig4wPDXezN57kBe4PnDzF6zNZ7GdMVPwele9FvOT4k+47Mp58kQGaBMyILZcKAH8RS6cxzpHXg9UgmmxX68Ih4uJkjlVF0VMmfMuhnLFE6tWRRADIcp3C0Rh+Q1OK25GrGa3FNhO8p7FkuRBIUg58siwZcSC2U7U0v9wYf0DidoP5hou0FKVvuGaccEoW+1WQOs9KIekKGYw1BVMt5ODZm1UDdhoK8nzZJ5NYCE9eMB/ewS7aNQlh9XeYgty3YN06p+5J1v6P6rLAIev6xXKrTkmFHxU+A47dM8u1HbBvwZ2uSbZxbX9uBayprq9YO4RUBh6uyqDyCY17bLsaavC6Zt9TCQE7rjsKjWrOYq7fUEWDhKtl7+7AOhpw+2jBdwheaYLOo0rnvAMGJZ9k2UVF0V0pJHnIfHhKs4JiIxL64TL/Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M9c3yc42wcFEfv2MTD2F0gYn2gIM4mf7XF9YxXiA4h+z7dW7HLv3EtmwnjbG?=
 =?us-ascii?Q?MJBs+o04VZcKecoSI+4H7WqMs6L6e0bwSR/InSxCR3bHYae4ZmaSwrSow4fz?=
 =?us-ascii?Q?Is+j/RmlxATj4gQopy9hPAyd9hoFQvlvl4Mj+uILue7mlmVAH0XVZ9sK43jl?=
 =?us-ascii?Q?N8chxf8ECxbKPCYYWEQjYjVGTxgaM6uDMyMJq01FyDPafaftYX0k3ki3T4C3?=
 =?us-ascii?Q?lsjuWPzJupwmk+rCg2KRuVJBqBetgjKzIioef+jyOKmqlu9Tqf30wXn+daM8?=
 =?us-ascii?Q?FhTJaFZM/KKEsQ5dzRUuRejY1G6Z92n8Uw3pjD8lVSec5X/PBazOkxpjVSls?=
 =?us-ascii?Q?yVMeZz4CfgoQ3DGFzZd8jvDUuDpluxEKGJcfCcQAgHbp2XO8/mRxFvjF2ize?=
 =?us-ascii?Q?08qadjkf+vkT7ACxlCCut9NfA8ozte0erlrYP+/JfEXuQqEHT+rnyrSiAdPT?=
 =?us-ascii?Q?zxWM46ak9UnEIK5f0UqZBU8YpbfzSq+GYyFmPh851sQ9HCaCmoZevgqKzLKa?=
 =?us-ascii?Q?1akhU/9DlVlkTyn8EctBhTItQrVsrw+XDZauf7fGVcqPQivaD0Z2NqO0oM3u?=
 =?us-ascii?Q?Nm8MWv64cZDS3CQUROu8PCmeHd54gXOSIHbb5Gi8uSGy8Q3GtGzR1AUS6xGG?=
 =?us-ascii?Q?3r3zwDw+NMNNo+1PRkmEAbFath2mfImuZt0BPbb2iItQtIPYTz/kzQThnT/y?=
 =?us-ascii?Q?LE1IURjg3Z2M0pGSULDseBLkiFqG50/wp0Ce6aQLew76HvL0WG0D9uHzsxW+?=
 =?us-ascii?Q?K7NWQmq6fpIy4ch9z/lcT0qQr6xIBI06nbays+JeHqE7s6E+hWEEbWbP3pKb?=
 =?us-ascii?Q?jqSQrbfK/OumCdiLAPrWg/s/bHyCSX1eo3wB1iiUczV+sfq6XUHsLuXUY58w?=
 =?us-ascii?Q?4SSUWSAkv3zDiacf7Z8wq5gs6pVBJrx/blva5FXbQFtFf8ZC1eStlxG/ygvm?=
 =?us-ascii?Q?GmjNNWoQjNUXJCwSt97xXZKJqu2txDjwU5Sgc0ScNEfA14XKMUJWTlk5PRS3?=
 =?us-ascii?Q?En6wKja+6kIpwJ1Wt8LgV5joFU7LYrpThVbFyVmCE3XRiT17CAPBVpopt6wD?=
 =?us-ascii?Q?G7geUprTQQP8se6AwK1j0lwX2H9HATz1UQlizcpR/RkN4M9CUC2SZW6PMmGD?=
 =?us-ascii?Q?r4xiyVyJxvXkrEbz3fb0HaJlgzYZCadjR1dcoYqotM6BecNyNzGfYFhus5Gu?=
 =?us-ascii?Q?OSNGKjsWPJVp9tLHijDpn9cwQGVKHzgbdMMB9fs/Ls6mJVp5SYzxbVJ9cKCE?=
 =?us-ascii?Q?ApUR0oerITQDSGHwbLJ1HoWegM26s2JkvlTngKoDRS+gZirLXuNCj7AUJ+hT?=
 =?us-ascii?Q?6gMeATiKK5IirHcAm7pwaKS1ulpWqYacf+ECKBImWmE13fxHwlYBuKxpxz/O?=
 =?us-ascii?Q?7lRGgkVswgeii96KxKRahH/8U0dMjGOMpigfJmCsHYhL3X+0HhBd+oLUP2nZ?=
 =?us-ascii?Q?oENahuDniqX8qYieOs3bZ8Vb3bRtY17XvuaFMpW9Fn+SpvO9MsTwO+uxnnlh?=
 =?us-ascii?Q?nOdmdrSO1soKRxKZqv/Blq3fc+8V3ixD7IDHkKulgrOV04v3tX54nCaDRsb6?=
 =?us-ascii?Q?c3QHrNFR4QzadhHKWiIZgadjp/bnyS0icVgAycTnle4v4p8rUnVTqY8EtNnn?=
 =?us-ascii?Q?Gy4bfbfbcIOViF35D/ZRqhMDnr83GOGcJKBX/0Q7e7GWtrJSd9U/meM1F7IB?=
 =?us-ascii?Q?McOXgfRtU+J5dwI1fTamlwgmPvqFSCapojkB/TP1eHZzyOR+FRHHReXxYsyT?=
 =?us-ascii?Q?t+nmHctm7wqTv3tXwb3ze4+okW/19VE=3D?=
X-Exchange-RoutingPolicyChecked: R8qTsEpudZKcd6aef0P5a5pNI0UpaTYlmxR/t4YvgB9eZwn9DNjH0eWeRe8HZUIaphN0astpVBARc89pQuX2ow7dSNZD4dYQmhpr9/SX6fqi2Ncj5lqnHnaqDyLFMpLtrs9tcCUK8C0lwbIyJT1LBuPXt8SCaAvqXU2pjzCLZdZOISv5PrH422fJPHlvBJlyxXM1xoH2HobN/mpooSONFWZRyff2lDF8vDgnJEnOAqhQsqTpe8wNe9GZrWxTug7Qluno8+Cpn4jPMDO+TjDuwPOuHtClrmMnfYmZID19fN1o7iEu9M7UMmqZSTwDTqjS3OUrf9oFybzPZCTtI/waeg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cada269-6e45-4d0b-84b8-08deac0905d3
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 07:19:48.7656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FrPGrxNaOo8rubgq9S2WaMwLfdzvJAOVbsmH0i6Lzv9ojS5T2/YwSPITji8E2S9pNOQuPJSRe/n9WV+pe1mMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9780
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

On Wed, May 06, 2026 at 07:17:51PM -0600, Lin, Shuicheng wrote:
> Thanks Matt for the review.
> 
> Hi drm misc maintainers,
> Could you please help me merge it?
> Thanks in advance for your support.
> 

Pushed to drm-misc-next.

Matt

> Shuicheng
> 
> On Fri, May 1, 2026 3:40 PM Matthew Brost wrote:
> > On Fri, May 01, 2026 at 05:59:56PM +0000, Shuicheng Lin wrote:
> > > The kernel-doc block above struct drm_gpusvm_pages duplicates the
> > > descriptions of the bit-flags that live in struct
> > > drm_gpusvm_pages_flags using dotted notation (@flags.migrate_devmem,
> > @flags.unmapped, ...).
> > > That dotted notation is intended for nested anonymous structs/unions
> > > that the parser flattens into the parent's parameter list.  Here,
> > > however, flags is of a named external type, so the parser does not
> > > flatten its members and the dotted entries do not match any member of
> > > drm_gpusvm_pages.  They also duplicate the canonical descriptions
> > > already present in the kernel-doc of struct drm_gpusvm_pages_flags itself.
> > >
> > > Drop the five @flags.* lines and replace them with a single @flags
> > > entry that cross-references the type via kernel-doc's "&struct ..." syntax.
> > > This eliminates the redundancy and removes warnings emitted by the new
> > > parameterdescs check in scripts/kernel-doc:
> > >
> > >   Excess struct member 'flags.migrate_devmem' description in
> > >    'drm_gpusvm_pages'
> > >   Excess struct member 'flags.unmapped' description in 'drm_gpusvm_pages'
> > >   Excess struct member 'flags.partial_unmap' description in
> > >    'drm_gpusvm_pages'
> > >   Excess struct member 'flags.has_devmem_pages' description in
> > >    'drm_gpusvm_pages'
> > >   Excess struct member 'flags.has_dma_mapping' description in
> > >    'drm_gpusvm_pages'
> > >
> > > No functional change.
> > >
> > > Assisted-by: Claude:claude-opus-4.6
> > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
> > 
> > Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> > 
> > > ---
> > > v2: change base to drm-misc.
> > > v3: correct the assisted-by tag.
> > >
> > > The failure is reported by the new kernel-doc check in:
> > > https://patchwork.freedesktop.org/series/164948/
> > > ---
> > >  include/drm/drm_gpusvm.h | 7 +------
> > >  1 file changed, 1 insertion(+), 6 deletions(-)
> > >
> > > diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h index
> > > cd94bb2ee6ee..8a4d7134a9a7 100644
> > > --- a/include/drm/drm_gpusvm.h
> > > +++ b/include/drm/drm_gpusvm.h
> > > @@ -140,12 +140,7 @@ struct drm_gpusvm_pages_flags {
> > >   * @state: DMA IOVA state for mapping.
> > >   * @state_offset: DMA IOVA offset for mapping.
> > >   * @notifier_seq: Notifier sequence number of the range's pages
> > > - * @flags: Flags for range
> > > - * @flags.migrate_devmem: Flag indicating whether the range can be
> > > migrated to device memory
> > > - * @flags.unmapped: Flag indicating if the range has been unmapped
> > > - * @flags.partial_unmap: Flag indicating if the range has been
> > > partially unmapped
> > > - * @flags.has_devmem_pages: Flag indicating if the range has devmem
> > > pages
> > > - * @flags.has_dma_mapping: Flag indicating if the range has a DMA
> > > mapping
> > > + * @flags: Flags for the range; see &struct drm_gpusvm_pages_flags
> > >   */
> > >  struct drm_gpusvm_pages {
> > >  	struct drm_pagemap_addr *dma_addr;
> > > --
> > > 2.43.0
> > >
