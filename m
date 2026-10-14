Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F37CC6B2D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 568AF10EB5D;
	Wed, 14 Oct 2026 23:09:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6F7E10EB5D
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 23:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792019359; x=1823555359;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tuNEW0tRRxjD3iYiFvttO3m8efqWqZN+P4eMjl89C60=;
 b=FsPM2NTi32inf/GSQLFRayGLSYiVKtPpS7xbBDxcoMOq6hM4teCryy2M
 ctVAKeLiduW5KarzuKx4lPGIMSRqIBwz+FZiznZcicETQQm427AfW302V
 by5eURfJra7XVQHzEGtHzT3PXbZkZCrGk8i7Rl6CTaq0Eg5FynS7+sOfW
 W/5XohWC93dGPslCHBuHx21y81yFPRRIwjm9LZFAcpt0mtm+y2s6HM9bF
 CE4CxUQT835fuJy0Wki+XMBM8M3Z2Qqk2Gk4n7hYAxLJBLf9l4ah4Sx73
 PGKJDuuTUJK+43rX4JwuzLnLXESpEuLOzl2nHPfhBy/r4hy3jNbyQb0kg A==;
X-CSE-ConnectionGUID: fa9SkjzjS9qnMd6SlmgkNQ==
X-CSE-MsgGUID: SUUqbVYmQA6p8ruakGQ42w==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="679175"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="679175"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 16:09:18 -0700
X-CSE-ConnectionGUID: wuYULF2ARVODPDifWii0/w==
X-CSE-MsgGUID: RiW5I2+FRGmozmoX2Rs65A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1511053"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa003.jf.intel.com with ESMTP; 14 Oct 2026 16:09:15 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xH85w-00000000FKf-0Urc;
 Wed, 14 Oct 2026 23:09:12 +0000
Date: Thu, 15 Oct 2026 07:08:36 +0800
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
 linux-kernel@vger.kernel.org, Florent Tomasin <florent.tomasin@arm.com>,
 Paul Toadere <paul.toadere@arm.com>,
 Samuel Percival <samuel.percival@arm.com>,
 Ketil Johnsen <ketil.johnsen@arm.com>
Subject: Re: [PATCH v4 05/12] drm/panthor: Add support for entering and
 exiting protected mode
Message-ID: <202610150946.AYfCvKtU-lkp@intel.com>
References: <20261012125940.3291951-6-ketil.johnsen@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012125940.3291951-6-ketil.johnsen@arm.com>
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
patch link:    https://lore.kernel.org/r/20261012125940.3291951-6-ketil.johnsen%40arm.com
patch subject: [PATCH v4 05/12] drm/panthor: Add support for entering and exiting protected mode
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20261015/202610150946.AYfCvKtU-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261015/202610150946.AYfCvKtU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610150946.AYfCvKtU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/gpu/drm/panthor/panthor_sched.c:353 Excess struct member 'active_group' description in 'panthor_scheduler' (did you mean one of: 'protm.active_group', 'reset.stopped_groups')
   Warning: drivers/gpu/drm/panthor/panthor_sched.c:4341 function parameter 'file' not described in 'panthor_fdinfo_gather_group_mem_info'
   Warning: drivers/gpu/drm/panthor/panthor_sched.c:4341 Excess function parameter 'pfile' description in 'panthor_fdinfo_gather_group_mem_info' (did you mean one of: 'file')
>> Warning: drivers/gpu/drm/panthor/panthor_sched.c:353 Excess struct member 'active_group' description in 'panthor_scheduler' (did you mean one of: 'protm.active_group', 'reset.stopped_groups')
   Warning: drivers/gpu/drm/panthor/panthor_sched.c:4341 function parameter 'file' not described in 'panthor_fdinfo_gather_group_mem_info'
   Warning: drivers/gpu/drm/panthor/panthor_sched.c:4341 Excess function parameter 'pfile' description in 'panthor_fdinfo_gather_group_mem_info' (did you mean one of: 'file')

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
