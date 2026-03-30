Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51436FF4947
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 06:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72C5C10E1E8;
	Mon, 30 Mar 2026 06:01:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="acN+TZi9";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A6BF10E1E8;
 Mon, 30 Mar 2026 06:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774850496; x=1806386496;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jySG1KIvOafzDrhK78jjN+mtCezeE1d9n6IrV1UQ6Es=;
 b=acN+TZi9BGSCDdUDhElCrOAXn3XoXI6bv8OnJclF4ydZ02fCGaGPH07d
 wPBAk4EJkZ1zWFQQqkFiHpj+zQbo+Y7L/x6OsOv1gP09ScqL1pZB7FWmt
 hRwgW3lmRV0gTXFSDqPeXDdMUkBfHIZCnPZmYYBBelxJByETI9t74j/Ax
 wc8brGbM9AXveMbHDlB6qAETvvUjCeLgAqKopZgGfTU+rqtYpPgQU/TJQ
 0+skGgdlJdHFyhUTd+sbd0XuPWHoZUPl4POSe9kExYFvfOQcXVtJaf35Y
 yWZ2cTu2NtzEvsWU6Pf/ZMlaQNJV90UsidMnL/U5qj+Vec3lZAX2kUVkr A==;
X-CSE-ConnectionGUID: zguiNI4lQh29FQP6nP1mFg==
X-CSE-MsgGUID: PI2OQWmqRc6qHEQUzaHZ4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="78431260"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="78431260"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 23:01:35 -0700
X-CSE-ConnectionGUID: rb2WHALfSkudriBrzHvowg==
X-CSE-MsgGUID: 4AXn+Q48RcidA73i2y23YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="223086687"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
 by fmviesa008.fm.intel.com with ESMTP; 29 Mar 2026 23:01:30 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w75gl-000000000k5-3Hg2;
 Mon, 30 Mar 2026 06:01:27 +0000
Date: Mon, 30 Mar 2026 14:01:24 +0800
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
Message-ID: <202603301304.Vwu3Sqd7-lkp@intel.com>
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
config: alpha-randconfig-r073-20260330 (https://download.01.org/0day-ci/archive/20260330/202603301304.Vwu3Sqd7-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.3.0
smatch: v0.5.0-9004-gb810ac53
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260330/202603301304.Vwu3Sqd7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603301304.Vwu3Sqd7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/gpu/drm/drm_edid.c:6525 function parameter 'connector' not described in 'drm_get_monitor_range_displayid'
>> Warning: drivers/gpu/drm/drm_edid.c:6525 function parameter 'drm_edid' not described in 'drm_get_monitor_range_displayid'
>> Warning: drivers/gpu/drm/drm_edid.c:6525 function parameter 'connector' not described in 'drm_get_monitor_range_displayid'
>> Warning: drivers/gpu/drm/drm_edid.c:6525 function parameter 'drm_edid' not described in 'drm_get_monitor_range_displayid'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
