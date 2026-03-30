Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B1AFF494D
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 06:35:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F2AD10E3BD;
	Mon, 30 Mar 2026 06:35:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EGsNMCD/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9EC210E3B6;
 Mon, 30 Mar 2026 06:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774852528; x=1806388528;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3YEWEDFdGeb8+xmVBhVZgs3VmhzuMoNWRWo753eYyyg=;
 b=EGsNMCD/mBimXxBaAZjDywaEgW5bI0ERSDpqP+1e+WY5Gj8WhR6AV6tk
 mF7XCE4frqGnJFT1d8/WducTzpVvKJIlI9qvTkvncwEioCTmwT6iQgApB
 ImB6BZlVWr71YvjUOVDL85GduPhH8MJwVdwuIpoh0y2TV74hHkVq9aTvg
 ln+8xmFi+o3vWMU9veihETPcvvFEcTtLfQPZvkUOssSgle4JTG1VBkcDF
 0oAkBn7vy+X2hto6ThW1vVT2oI3VXF7SX774/0gO1/zA0KZWt5frfs6jt
 KHrVxlRbUPHT3cN0L9GzLCj1MFvPkHqYOerkyEReDHToeAK0rOG3i4oMO g==;
X-CSE-ConnectionGUID: esJjy2UhRHuZwYltEP5prg==
X-CSE-MsgGUID: 31Ri9+CjTuWoIZnH00ZkNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="79700318"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="79700318"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 23:35:26 -0700
X-CSE-ConnectionGUID: beCFwWSgS+2lbCcJcK8YAQ==
X-CSE-MsgGUID: CS8WvW4LQ5uO+j83pKobFQ==
X-ExtLoop1: 1
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2)
 ([10.211.93.152])
 by fmviesa003.fm.intel.com with ESMTP; 29 Mar 2026 23:35:25 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w76Da-00000000841-3q9D;
 Mon, 30 Mar 2026 06:35:22 +0000
Date: Mon, 30 Mar 2026 08:34:38 +0200
From: kernel test robot <lkp@intel.com>
To: Adriano Vero <litaliano00.contact@gmail.com>,
 dri-devel@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, jani.nikula@linux.intel.com,
 alexander.deucher@amd.com, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Adriano Vero <litaliano00.contact@gmail.com>
Subject: Re: [PATCH 1/2] drm/edid: populate monitor_range from DisplayID
 Dynamic Video Timing block
Message-ID: <202603300847.vflE6oJO-lkp@intel.com>
References: <20260328132027.22383-1-litaliano00.contact@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260328132027.22383-1-litaliano00.contact@gmail.com>
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

Hi Adriano,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on drm-i915/for-linux-next drm-i915/for-linux-next-fixes drm-tip/drm-tip linus/master v7.0-rc6 next-20260327]
[cannot apply to drm-misc/drm-misc-next daeinki-drm-exynos/exynos-drm-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Adriano-Vero/drm-amd-display-remove-manual-DisplayID-VRR-parsing-from-freesync-caps/20260330-002329
base:   https://gitlab.freedesktop.org/drm/kernel.git drm-next
patch link:    https://lore.kernel.org/r/20260328132027.22383-1-litaliano00.contact%40gmail.com
patch subject: [PATCH 1/2] drm/edid: populate monitor_range from DisplayID Dynamic Video Timing block
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260330/202603300847.vflE6oJO-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260330/202603300847.vflE6oJO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603300847.vflE6oJO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/gpu/drm/drm_edid.c:6525 function parameter 'connector' not described in 'drm_get_monitor_range_displayid'
>> Warning: drivers/gpu/drm/drm_edid.c:6525 function parameter 'drm_edid' not described in 'drm_get_monitor_range_displayid'
>> Warning: drivers/gpu/drm/drm_edid.c:6525 function parameter 'connector' not described in 'drm_get_monitor_range_displayid'
>> Warning: drivers/gpu/drm/drm_edid.c:6525 function parameter 'drm_edid' not described in 'drm_get_monitor_range_displayid'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
