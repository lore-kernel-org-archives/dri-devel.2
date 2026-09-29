Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF0BCA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61F2F10EE2B;
	Tue, 29 Sep 2026 10:40:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KL4hZcP1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EDC510EE2B;
 Tue, 29 Sep 2026 10:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790678440; x=1822214440;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=FZ1cqMom+nM/ufpLvEALWDnV9xMF5TF3edELoBjiLaA=;
 b=KL4hZcP1tN5S9A8KYOuCxP5fSrse3l3OUQK6f19/c4KiVI3ZW+em7Ovo
 3vcgwhWZduPykqVefTvcbZO/nDnth0kuTenQdCvjfuICuQX5s4mQpU0nI
 Xz00DO9zN/aQz4SYE4jGv9jeVSEe+zK5NOi1X7YawCsU9mIGz2xkCBoS4
 1RgmBTeg51OuTVQWwwClTCDmRnT9DLWPxaZCBBo9OY6ERS3XLP15H5Crq
 szAw6II/nopq8WMwM2n3M7gyzIBWAImOzoHZUcZEp6y3fP+NgYDjfgONq
 lmBOQiW8Y0MJkut4HuoggF1Le+P8gYZkikfXRBWo7lXMJBjpApJoVIeqb Q==;
X-CSE-ConnectionGUID: tR4dbp/OQduF2eYsN/e3Jg==
X-CSE-MsgGUID: +i+aYwr5TOqaq2MJUjv3ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="102063194"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="102063194"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 03:40:39 -0700
X-CSE-ConnectionGUID: kcA/SDlOQj+CjZTRxXRg0g==
X-CSE-MsgGUID: 4F4dm+IvTe+Tl7d4yvBUmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="278550158"
Received: from kamilkon-desk.igk.intel.com (HELO localhost) ([10.211.136.201])
 by ORVIESA003-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 03:40:37 -0700
Date: Tue, 29 Sep 2026 12:40:34 +0200
From: Kamil Konieczny <kamil.konieczny@linux.intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 phasta@kernel.org
Subject: Re: [PATCH i-g-t v3] tests/intel/xe_sync_file: Exercise sync file
 access post queue destruction
Message-ID: <20260929104034.2suju2wafp3ggxap@kamilkon-DESK.igk.intel.com>
Mail-Followup-To: Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 phasta@kernel.org
References: <20260917101203.85009-1-tvrtko.ursulin@igalia.com>
 <20260917170104.ezdsuxezb7e3xm7q@kamilkon-DESK.igk.intel.com>
 <aa484472-1d5f-4973-8941-6e86f9a81fd2@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa484472-1d5f-4973-8941-6e86f9a81fd2@igalia.com>
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

Hi Tvrtko,
On 2026-09-25 at 09:01:10 +0100, Tvrtko Ursulin wrote:
> 
> On 17/09/2026 18:01, Kamil Konieczny wrote:
> > Hi Tvrtko,
> > On 2026-09-17 at 11:12:03 +0100, Tvrtko Ursulin wrote:
> > > A new test to roughly simulate the VK CTS suite where
> > > dEQP-VK.wsi.android.swapchain.render.* is hitting an use after free when a
> > > sync file is accessed after the xe submission queue has been destroyed.
> > > 
> > > Abbreviated KASAN report:
> > > 
> > >   [IGT] xe_sync_file: starting subtest sync_file_race
> > >   ==================================================================
> > >   BUG: KASAN: slab-use-after-free in drm_sched_fence_get_timeline_name+0xa1/0xb0 [gpu_sched]
> > >   Read of size 8 at addr ffff888126726020 by task xe_sync_file/2931
> > >   ...
> > >   Call Trace:
> > >    <TASK>
> > >    kasan_report+0xeb/0x130
> > >    drm_sched_fence_get_timeline_name+0xa1/0xb0 [gpu_sched]
> > >    sync_file_ioctl+0x3cb/0xb00
> > >   ...
> > >   Allocated by task 2931:
> > >    __kmalloc_cache_noprof+0x1c2/0x410
> > >    guc_exec_queue_init+0x1a8/0x1240 [xe]
> > >    xe_exec_queue_create+0xe72/0x13b0 [xe]
> > >    xe_exec_queue_create_ioctl+0x10d9/0x1770 [xe]
> > >    drm_ioctl_kernel+0x179/0x300
> > >    drm_ioctl+0x58f/0xcf0
> > >    xe_drm_ioctl+0xe8/0x140 [xe]
> > >   ...
> > >   Freed by task 1689:
> > >    kfree+0x106/0x3e0
> > >    __guc_exec_queue_fini_async+0x144/0x2d0 [xe]
> > >    process_one_work+0x610/0xdf0
> > >    worker_thread+0x7c8/0x14b0
> > > 
> > > Without KASAN this of course turns into a plain null pointer dereference.
> > > 
> > > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > Cc: Christian König <christian.koenig@amd.com>
> > > Cc: phasta@kernel.org
> > > Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com> # v2
> > LGTM
> > Acked-by: Kamil Konieczny <kamil.konieczny@linux.intel.com>
> 
> Thank you - okay if I push or Intel will do it?
> 
> Regards,
> 
> Tvrtko

I was blind, sorry, you already got r-b, I will merge it.

Regards,
Kamil

> 
> > 
> > Regards,
> > Kamil
> > 
> > > ---
> > > v2:
> > >   - igt_main and igt_fixture tweaks. (Rodrigo)
> > > 
> > > v3:
> > >   - Add driver name checks.
> > > 
> > > v4:
> > >   - Restore alphabetical ordering in the makefile. (Kamil)
> > > ---
> > >   tests/intel/xe_sync_file.c | 154 +++++++++++++++++++++++++++++++++++++
> > >   tests/meson.build          |   1 +
> > >   2 files changed, 155 insertions(+)
> > >   create mode 100644 tests/intel/xe_sync_file.c
> > > 
[cut]
