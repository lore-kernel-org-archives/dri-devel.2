Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3CFC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 10:42:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E956A10E482;
	Tue,  7 Jul 2026 10:42:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="D7DOEghC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC91A10E482;
 Tue,  7 Jul 2026 10:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783420969; x=1814956969;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=kaP8tHjcW0A9pGpz3ksd9zt0ofOEKXJKf9UEC9INPjw=;
 b=D7DOEghC0+lawCZE6AQrWQMbcQ1pQoFh6JU3yYlaXkwc/iQuBVvrHrUq
 KzOWuIh5qFCl0vFNkZ2jmUeN4iE2KaPwYRRZDW53XgnlDdBxROiNjhA4X
 koyNlnKi8G8uQWwjy7ERv2Ec2t8wNijSauZ9yD/MjkYh6Yeomf4MDUZ2T
 t1Paa6iCoKT0NMU9nb/5qlykv8rk9H4fkQkjqij6JU8yPybFsxCgsme2N
 KZgulcz9VGBHw35xgxKMFKxQdVDfMLuhuYYpMywdTU3u9gd1Ko1F9aZQt
 UvueRBGiIft37unQpurA01krIr0ZVGeVtmtkG+PJyG85evxgsilmYeHQD Q==;
X-CSE-ConnectionGUID: ij6/mVYgRpOR6JgqL7Q+FA==
X-CSE-MsgGUID: 9NgCI4WlTByhjlFEidLtqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="84254337"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84254337"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 03:42:48 -0700
X-CSE-ConnectionGUID: C2RiHyptRz6MveJaDbAikQ==
X-CSE-MsgGUID: MeCBRJYvTXmMTIIpZ9ZHrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="257541468"
Received: from kamilkon-desk.igk.intel.com (HELO localhost) ([10.211.136.201])
 by ORVIESA003-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 03:42:45 -0700
Date: Tue, 7 Jul 2026 12:42:42 +0200
From: Kamil Konieczny <kamil.konieczny@linux.intel.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: "Sokolowski, Jan" <jan.sokolowski@intel.com>,
 "igt-dev@lists.freedesktop.org" <igt-dev@lists.freedesktop.org>,
 "siqueira@igalia.com" <siqueira@igalia.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 Christian Koenig <christian.koenig@amd.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: [PATCH i-g-t v3 0/7] add dmem_cgroups test
Message-ID: <20260707104242.teljyquxek3hdppm@kamilkon-DESK.igk.intel.com>
Mail-Followup-To: Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 "Sokolowski, Jan" <jan.sokolowski@intel.com>,
 "igt-dev@lists.freedesktop.org" <igt-dev@lists.freedesktop.org>,
 "siqueira@igalia.com" <siqueira@igalia.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 Christian Koenig <christian.koenig@amd.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>
References: <20260702130108.1397444-1-cascardo@igalia.com>
 <IA4PR11MB9251D24975F81CFD242F88F299F42@IA4PR11MB9251.namprd11.prod.outlook.com>
 <akeamIYrRSTph5St@quatroqueijos.cascardo.eti.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <akeamIYrRSTph5St@quatroqueijos.cascardo.eti.br>
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

Hi Thadeu,
On 2026-07-03 at 08:18:48 -0300, Thadeu Lima de Souza Cascardo wrote:
> On Fri, Jul 03, 2026 at 09:54:14AM +0000, Sokolowski, Jan wrote:
> > I don't know if that's a problem or not, but your patches in patch series are titled as v2 instead of v3, at least that's how I see them.
> > 
> > Jan
> > 
> 
> I decided to name this one v3, though I did not call the previous one v2,
> because I have submitted a patchset earlier that was on top of Thomas
> Hellström patchset.
> 
> I think it tracks the history of the patchset better. I am sorry if this
> got confusing.
> 
> Cascardo.
> 

Please keep versioning the same across series, if your cover letter
has v3, all patches in series should also have v3.

Regards,
Kamil

> > > -----Original Message-----
> > > From: igt-dev <igt-dev-bounces@lists.freedesktop.org> On Behalf Of Thadeu
> > > Lima de Souza Cascardo
> > > Sent: Thursday, July 2, 2026 3:01 PM
> > > To: igt-dev@lists.freedesktop.org
> > > Cc: siqueira@igalia.com; Thadeu Lima de Souza Cascardo
> > > <cascardo@igalia.com>; dri-devel@lists.freedesktop.org; amd-
> > > gfx@lists.freedesktop.org; intel-xe@lists.freedesktop.org; Christian Koenig
> > > <christian.koenig@amd.com>; maarten.lankhorst@linux.intel.com; Thomas
> > > Hellström <thomas.hellstrom@linux.intel.com>; Kamil Konieczny
> > > <kamil.konieczny@linux.intel.com>; Janusz Krzysztofik
> > > <janusz.krzysztofik@linux.intel.com>; Vitaly Prosyak
> > > <vitaly.prosyak@amd.com>; Natalie Vock <natalie.vock@gmx.de>; Tvrtko
> > > Ursulin <tvrtko.ursulin@igalia.com>; kernel-dev@igalia.com
> > > Subject: [PATCH i-g-t v3 0/7] add dmem_cgroups test
> > > 
> > > v3 TLDR:
> > > Sending again for fixes when running on top of Xe.
> > > 
> > > This patchset is based on the work of Thomas Hellström at [1] and a
> > > followup I have submitted at [2]. This is now a v3, since I submitted [6].
> > > 
> > > With this version, I reverted the order in which to apply the patchsets, as
> > > this one adds the infrastructure and the drivers mechanisms, and a test for
> > > dmem.current and its behavior around dmem.max that is currently
> > > supported
> > > in the kernel.
> > > 
> > > As for the new dmem.max eviction behavior, introduced by [3], it has been
> > > pushed to a branch at [4]. If preferred, I can submit the two patches
> > > independently.
> > > 
> > > I have run the tests, including the ones that test dmem.max eviction
> > > behavior on a system with a 1GiB VRAM amdgpu card. Rodrigo Siqueira
> > > helped
> > > me run it on a Xe system. We have applied the patchset at [3] on top of
> > > current linux origin/master [5], with a fixup for the amdgpu driver.
> > > 
> > > Now, for the changes since v1 [2]:
> > > - Changed the test name from drv_dmem_cgroups to dmem_cgroups.
> > > - Have system includes before igt ones.
> > > - Documented the current SUBTEST.
> > > - Changed free_vram driver hook to only release a given BO. This allows for
> > >   the eviction trigger by a new allocation added by write_eviction_nonblock
> > >   subtest.
> > > - Changed allocate_vram to keep more state necessary for releasing a single
> > > BO.
> > > - Added a global free_vram helper to free all allocated VRAM.
> > > 
> > > Compared to v3 of [1]:
> > > - I have kept wait_for_usage_drop as release can be lazy and we test for it
> > >   on test_current SUBTEST, but had USAGE_DROP_TIMEOUT_MS be a little
> > >   longer.
> > > - Changed BO_SIZE and EVICT_STEP to allow for more than two eviction steps
> > >   on a 1GiB VRAM system.
> > > - Reduced USAGE_SLACK to avoid false positives, but still allow for some
> > >   page table accounting.
> > > 
> > > Compared to v2 of this one [6]:
> > > 
> > > - Ignore -ENOMEM and -ENOSPC when trying to fill VRAM.
> > > - When limiting max memory, allow for some slack, as there might be some
> > >   overhead.
> > > - On Xe, allocate GEM object with no deferred backing, and skip binding.
> > > 
> > > [1] https://patchwork.freedesktop.org/series/163935/#rev3
> > > [2] https://patchwork.freedesktop.org/series/166496/
> > > [3] https://lore.kernel.org/dri-devel/20260611173301.17473-1-
> > > thomas.hellstrom@linux.intel.com/
> > > [4] https://gitlab.freedesktop.org/cascardo/igt-gpu-tools/-
> > > /commits/dmem_max?ref_type=heads
> > > [5] 502d801f0ab0 ("Merge tag 'erofs-for-7.2-rc1' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs")
> > > [6] https://lore.kernel.org/dri-devel/20260623174319.4138648-1-
> > > cascardo@igalia.com/
> > > 
> > > 
> > > Thadeu Lima de Souza Cascardo (4):
> > >   lib/xe: Introduce dmem driver and implement Xe support
> > >   lib/amdgpu: add amdgpu_cgroup_region_name
> > >   lib/amdgpu: add amdgpu support to igt_dmem_driver
> > >   tests/dmem_cgroups: add test for dmem.current
> > > 
> > > Thomas Hellström (3):
> > >   lib/igt_cgroup: add cgroup v2 and dmem controller helpers
> > >   tests/cgroup_dmem: add dmem cgroup controller test
> > >   lib/xe: add xe_cgroup_region_name() helper
> > > 
> > >  lib/amdgpu/amd_dmem.c   |  99 +++++++
> > >  lib/amdgpu/amd_memory.c |  25 ++
> > >  lib/amdgpu/amd_memory.h |   2 +
> > >  lib/igt.h               |   1 +
> > >  lib/igt_cgroup.c        | 638 ++++++++++++++++++++++++++++++++++++++++
> > >  lib/igt_cgroup.h        |  56 ++++
> > >  lib/igt_dmem_driver.h   |  25 ++
> > >  lib/meson.build         |   3 +
> > >  lib/xe/xe_dmem.c        | 143 +++++++++
> > >  lib/xe/xe_query.c       |  32 ++
> > >  lib/xe/xe_query.h       |   2 +
> > >  tests/cgroup_dmem.c     |  92 ++++++
> > >  tests/dmem_cgroups.c    | 245 +++++++++++++++
> > >  tests/meson.build       |   2 +
> > >  14 files changed, 1365 insertions(+)
> > >  create mode 100644 lib/amdgpu/amd_dmem.c
> > >  create mode 100644 lib/igt_cgroup.c
> > >  create mode 100644 lib/igt_cgroup.h
> > >  create mode 100644 lib/igt_dmem_driver.h
> > >  create mode 100644 lib/xe/xe_dmem.c
> > >  create mode 100644 tests/cgroup_dmem.c
> > >  create mode 100644 tests/dmem_cgroups.c
> > > 
> > > --
> > > 2.47.3
> > 
