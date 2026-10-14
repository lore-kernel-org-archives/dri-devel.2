Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F3BC3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:20:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 576B811203C;
	Wed, 14 Oct 2026 20:19:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C55F210FF42
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 20:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792009189; x=1823545189;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1JanGc8z8XRSLzMWj6La+OzYOvaT0VgU2qv4MPBJwVo=;
 b=aKnsNCdlK38J+ki5Asz+FZQjH5eOernAHOXSpocBYsU09ih0uoLwSpnT
 toq+DPZOABKirRYDttJSb0w8UIKLp5XIxUVnn67uxJhaaWC4qFF3ktvku
 ItZamDCsrkGnSMOZUvwcPmHqRGwnCn///bmZjEcdrOSB7YisoIdH28sIj
 pzrtBYaAAnAP3rofP5utYDFYsYto3j3L54YxwHSIC5mqMhilYiGVt4p5W
 bzGQZD4ndhnHl8uPSdRk8DIsS1maS6qM51WiSbrAJOTVq5tL93bkkurjw
 azbFxKD2ySUepMV8EadAkjV7VARN9GOGjxa77gR5gsOXXhx0A05TOnLCX A==;
X-CSE-ConnectionGUID: 5PxsJQatTvOXSQn4lJymGA==
X-CSE-MsgGUID: 5bpSYj78TqW27UuSS+D+jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="657744"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="657744"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 13:19:49 -0700
X-CSE-ConnectionGUID: TJkY2rBlRbOMRD9H9WtxqQ==
X-CSE-MsgGUID: nA9VK41wT4uagIMXmcl5Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1421822"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa005.jf.intel.com with ESMTP; 14 Oct 2026 13:19:45 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xH5Ru-00000000FAH-2yxg;
 Wed, 14 Oct 2026 20:19:42 +0000
Date: Thu, 15 Oct 2026 04:19:23 +0800
From: kernel test robot <lkp@intel.com>
To: Ketil Johnsen <ketil.johnsen@arm.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ketil Johnsen <ketil.johnsen@arm.com>
Subject: Re: [PATCH v4 03/12] drm/panthor: Pass drm_file instead of
 panthor_file
Message-ID: <202610150630.tAfOKlx3-lkp@intel.com>
References: <20261012125940.3291951-4-ketil.johnsen@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012125940.3291951-4-ketil.johnsen@arm.com>
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

Hi Ketil,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on next-20261012]
[cannot apply to linus/master v7.3-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ketil-Johnsen/drm-panthor-De-duplicate-FW-memory-section-sync/20261012-145929
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20261012125940.3291951-4-ketil.johnsen%40arm.com
patch subject: [PATCH v4 03/12] drm/panthor: Pass drm_file instead of panthor_file
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20261015/202610150630.tAfOKlx3-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261015/202610150630.tAfOKlx3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610150630.tAfOKlx3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/gpu/drm/panthor/panthor_mmu.c:1695 function parameter 'file' not described in 'panthor_vm_pool_destroy'
>> Warning: drivers/gpu/drm/panthor/panthor_mmu.c:1695 Excess function parameter 'pfile' description in 'panthor_vm_pool_destroy' (did you mean one of: 'file')
>> Warning: drivers/gpu/drm/panthor/panthor_mmu.c:1719 function parameter 'file' not described in 'panthor_vm_pool_create'
>> Warning: drivers/gpu/drm/panthor/panthor_mmu.c:1719 Excess function parameter 'pfile' description in 'panthor_vm_pool_create' (did you mean one of: 'file')
>> Warning: drivers/gpu/drm/panthor/panthor_mmu.c:2162 function parameter 'file' not described in 'panthor_vm_heaps_sizes'
>> Warning: drivers/gpu/drm/panthor/panthor_mmu.c:2162 Excess function parameter 'pfile' description in 'panthor_vm_heaps_sizes' (did you mean one of: 'file')
>> Warning: drivers/gpu/drm/panthor/panthor_mmu.c:1695 function parameter 'file' not described in 'panthor_vm_pool_destroy'
>> Warning: drivers/gpu/drm/panthor/panthor_mmu.c:1695 Excess function parameter 'pfile' description in 'panthor_vm_pool_destroy' (did you mean one of: 'file')
>> Warning: drivers/gpu/drm/panthor/panthor_mmu.c:1719 function parameter 'file' not described in 'panthor_vm_pool_create'
>> Warning: drivers/gpu/drm/panthor/panthor_mmu.c:1719 Excess function parameter 'pfile' description in 'panthor_vm_pool_create' (did you mean one of: 'file')
>> Warning: drivers/gpu/drm/panthor/panthor_mmu.c:2162 function parameter 'file' not described in 'panthor_vm_heaps_sizes'
>> Warning: drivers/gpu/drm/panthor/panthor_mmu.c:2162 Excess function parameter 'pfile' description in 'panthor_vm_heaps_sizes' (did you mean one of: 'file')
--
>> Warning: drivers/gpu/drm/panthor/panthor_sched.c:3929 function parameter 'file' not described in 'panthor_fdinfo_gather_group_mem_info'
>> Warning: drivers/gpu/drm/panthor/panthor_sched.c:3929 Excess function parameter 'pfile' description in 'panthor_fdinfo_gather_group_mem_info' (did you mean one of: 'file')
>> Warning: drivers/gpu/drm/panthor/panthor_sched.c:3929 function parameter 'file' not described in 'panthor_fdinfo_gather_group_mem_info'
>> Warning: drivers/gpu/drm/panthor/panthor_sched.c:3929 Excess function parameter 'pfile' description in 'panthor_fdinfo_gather_group_mem_info' (did you mean one of: 'file')

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
