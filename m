Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF374C55171
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 01:02:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D24D710E252;
	Sat,  1 Aug 2026 01:02:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="g48YrFK7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E486110E1ED;
 Sat,  1 Aug 2026 01:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785546125; x=1817082125;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8uami1JZ98jEEVX2RifxoHz17GVE7lLrJMHHTlwMkQc=;
 b=g48YrFK7Ahso3SgM6yzxtayQ5zn4yp2wE9Skkw+bL2TyLn13rfSl35SN
 XNtoCf/t3Px/LgJ06eW32zI7QiSHW4AObeWLNXEQ/69nPtwaw9OkEA34E
 knrdrVb8EpJ3eeWXwL3/ih5/PMpYLW09rHopB+4JyFEh+T/B4kGrhqt8v
 RjJzcyZfa/9vNZAk9nKBLFmpoyU4vyHT12F1cd3xGemGh4e8DkLeWi0h+
 bKAkgNCku5I5kGf2ofIKdivV70pKHF52KVA9unVZ8zwqNsfobeEEEpm6W
 tRnfKmvcWmASfqEY5By1NPTZ6SyACmbOnNR8NtVP4Ihgy+sYJ1R3MhUDz w==;
X-CSE-ConnectionGUID: trsDcGoXTyG1wConyGljXw==
X-CSE-MsgGUID: tzHNXYHJSJyiiR079J2miA==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="96760891"
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; d="scan'208";a="96760891"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 18:02:04 -0700
X-CSE-ConnectionGUID: vNZVlXgzQ560r01QjC7xRw==
X-CSE-MsgGUID: 0BaM+TEsR2eQEwjWxo4+XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; d="scan'208";a="258915099"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by orviesa006.jf.intel.com with ESMTP; 31 Jul 2026 18:02:03 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wpy6y-000000002Vp-2Ywo;
 Sat, 01 Aug 2026 01:02:00 +0000
Date: Sat, 1 Aug 2026 09:01:42 +0800
From: kernel test robot <lkp@intel.com>
To: Maarten Lankhorst <dev@lankhorst.se>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <dev@lankhorst.se>
Subject: Re: [PATCH v9.6] drm/i915: Disable "busy" pmu event on
 CONFIG_PREEMPT_RT
Message-ID: <202608010845.CPpXaIeD-lkp@intel.com>
References: <20260623132734.227322-1-dev@lankhorst.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623132734.227322-1-dev@lankhorst.se>
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

Hi Maarten,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-i915/for-linux-next]
[also build test WARNING on drm-i915/for-linux-next-fixes drm-tip/drm-tip drm/drm-next drm-misc/drm-misc-next daeinki-drm-exynos/exynos-drm-next linus/master v7.2-rc5 next-20260731]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maarten-Lankhorst/drm-i915-Disable-busy-pmu-event-on-CONFIG_PREEMPT_RT/20260731-223850
base:   https://gitlab.freedesktop.org/drm/i915/kernel.git for-linux-next
patch link:    https://lore.kernel.org/r/20260623132734.227322-1-dev%40lankhorst.se
patch subject: [PATCH v9.6] drm/i915: Disable "busy" pmu event on CONFIG_PREEMPT_RT
config: i386-randconfig-141-20260801 (https://download.01.org/0day-ci/archive/20260801/202608010845.CPpXaIeD-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
smatch: v0.5.0-9187-g5189e3fb
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260801/202608010845.CPpXaIeD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608010845.CPpXaIeD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/i915/i915_pmu.c:560:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
     560 |         case I915_SAMPLE_WAIT:
         |         ^
   drivers/gpu/drm/i915/i915_pmu.c:560:2: note: insert 'break;' to avoid fall-through
     560 |         case I915_SAMPLE_WAIT:
         |         ^
         |         break; 
   1 warning generated.


vim +560 drivers/gpu/drm/i915/i915_pmu.c

b46a33e271ed81b Tvrtko Ursulin    2017-11-21  550  
109ec558370f781 Tvrtko Ursulin    2018-01-11  551  static int
109ec558370f781 Tvrtko Ursulin    2018-01-11  552  engine_event_status(struct intel_engine_cs *engine,
109ec558370f781 Tvrtko Ursulin    2018-01-11  553  		    enum drm_i915_pmu_engine_sample sample)
b46a33e271ed81b Tvrtko Ursulin    2017-11-21  554  {
109ec558370f781 Tvrtko Ursulin    2018-01-11  555  	switch (sample) {
b46a33e271ed81b Tvrtko Ursulin    2017-11-21  556  	case I915_SAMPLE_BUSY:
ae7243df39c4099 Maarten Lankhorst 2026-06-23  557  		/* The guc submission engine->busyness() callback has issues with CONFIG_PREEMPT_RT */
ae7243df39c4099 Maarten Lankhorst 2026-06-23  558  		if (IS_ENABLED(CONFIG_PREEMPT_RT) && intel_uc_uses_guc_submission(&engine->gt->uc))
ae7243df39c4099 Maarten Lankhorst 2026-06-23  559  			return -ENODEV;
b46a33e271ed81b Tvrtko Ursulin    2017-11-21 @560  	case I915_SAMPLE_WAIT:
b46a33e271ed81b Tvrtko Ursulin    2017-11-21  561  		break;
b46a33e271ed81b Tvrtko Ursulin    2017-11-21  562  	case I915_SAMPLE_SEMA:
651e7d48577ae28 Lucas De Marchi   2021-06-05  563  		if (GRAPHICS_VER(engine->i915) < 6)
109ec558370f781 Tvrtko Ursulin    2018-01-11  564  			return -ENODEV;
109ec558370f781 Tvrtko Ursulin    2018-01-11  565  		break;
109ec558370f781 Tvrtko Ursulin    2018-01-11  566  	default:
109ec558370f781 Tvrtko Ursulin    2018-01-11  567  		return -ENOENT;
109ec558370f781 Tvrtko Ursulin    2018-01-11  568  	}
109ec558370f781 Tvrtko Ursulin    2018-01-11  569  
109ec558370f781 Tvrtko Ursulin    2018-01-11  570  	return 0;
109ec558370f781 Tvrtko Ursulin    2018-01-11  571  }
109ec558370f781 Tvrtko Ursulin    2018-01-11  572  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
