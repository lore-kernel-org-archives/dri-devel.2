Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014F4CC6B2A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E7B810EB5C;
	Wed, 14 Oct 2026 23:19:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 374FE10E51F;
 Wed, 14 Oct 2026 23:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792019961; x=1823555961;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=14fwm+qs2LfHP2AYw5UxTvOWe2KpM80lcREWlHdOwfY=;
 b=PtRVZ/xrSRsMuNZGq4k9v15/VNyCCg75eQnkkOY4dyofVtrzqgtu1WAM
 TaLx2yaXgArvrZ2qaoe2tKYlziZtwulztDiPWGuyfplobmXLoJeFtlhmn
 GvS/5fh6ouMl1KsC4LtpNrbapSDN7TBf6/j9ypRoHzanatxka5xOY/BtY
 OpdbKGWw1E4Zr+sDnJANBJ0bTZ1m5XsGMaO2bSXrU/BnV5qcbyCotDnqv
 YQnPKzot6KvRrsVr9Ik4oFSwG3os/pMD5Vlnh6reZ0ChMKE9sRk0B9sMn
 A7lPqCGlq29UBjaTDAtEfBJfm6LAU6s3S4/3yRDPu//jrkJRxWOgJA0Hj w==;
X-CSE-ConnectionGUID: WdbBGNiDRwuDqdssdl8qyg==
X-CSE-MsgGUID: wo09KMSoSgioopZlbdI5tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="789640"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="789640"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 16:19:20 -0700
X-CSE-ConnectionGUID: HU1hmgqARpOcXQ3RXNimbg==
X-CSE-MsgGUID: 9iLD3PxMRIG0eQvuGenaXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1982607"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa010.jf.intel.com with ESMTP; 14 Oct 2026 16:19:18 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xH8Ff-00000000FLL-39jM;
 Wed, 14 Oct 2026 23:19:15 +0000
Date: Thu, 15 Oct 2026 07:19:03 +0800
From: kernel test robot <lkp@intel.com>
To: Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
 jani.nikula@linux.intel.com, uma.shankar@intel.com,
 ville.syrjala@linux.intel.com, suraj.kandpal@intel.com
Subject: Re: [PATCH v2 29/56] drm/i915/hdmi_frl_dfm: Add non dsc frl capacity
 computation helpers
Message-ID: <202610150708.Q1o3snO8-lkp@intel.com>
References: <20261012035806.3361439-30-ankit.k.nautiyal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012035806.3361439-30-ankit.k.nautiyal@intel.com>
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

Hi Ankit,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on drm-tip/drm-tip next-20261012]
[cannot apply to drm-i915/for-linux-next drm-i915/for-linux-next-fixes drm-xe/drm-xe-next linus/master v7.3-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ankit-Nautiyal/drm-i915-hdmi-Parse-FRL-max-link-rate-from-VBT/20261012-092710
base:   https://gitlab.freedesktop.org/drm/kernel.git drm-next
patch link:    https://lore.kernel.org/r/20261012035806.3361439-30-ankit.k.nautiyal%40intel.com
patch subject: [PATCH v2 29/56] drm/i915/hdmi_frl_dfm: Add non dsc frl capacity computation helpers
config: i386-buildonly-randconfig-1003-20261014 (https://download.01.org/0day-ci/archive/20261015/202610150708.Q1o3snO8-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261015/202610150708.Q1o3snO8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610150708.Q1o3snO8-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.o: in function `get_tactive_min':
>> drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c:181:(.text+0x78): undefined reference to `__udivdi3'
   ld: drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.o: in function `compute_link_characteristics':
   drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c:218:(.text+0xf8): undefined reference to `__udivdi3'


vim +181 drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c

   161	
   162	/*
   163	 * Determine the minimum time necessary to transmit the active tribytes
   164	 * considering frl bandwidth limitation.
   165	 * Given the available bandwidth (i.e after overhead is considered),
   166	 * tactive_min represents the amount of time needed to transmit all the
   167	 * active data
   168	 */
   169	static u32
   170	get_tactive_min(u32 num_lanes, u32 tribyte_active,
   171			u32 overhead_max_k, u32 frl_char_min_rate_k)
   172	{
   173		u32 active_bytes, rate_kbps, efficiency_k, effective_rate_kbps;
   174	
   175		active_bytes = (3 * tribyte_active) / 2;
   176		rate_kbps = num_lanes * frl_char_min_rate_k;
   177		efficiency_k = EFFICIENCY_MULTIPLIER - overhead_max_k;
   178		effective_rate_kbps = mult_frac(rate_kbps, efficiency_k, EFFICIENCY_MULTIPLIER);
   179	
   180		return div_u64(mul_u32_u32(FRL_TIMING_NS_MULTIPLIER, active_bytes),
 > 181			       effective_rate_kbps) / 1000;
   182	}
   183	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
