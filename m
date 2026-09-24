Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E280CC98304
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 02:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D737810E8EC;
	Thu, 24 Sep 2026 02:10:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="H29+z0G4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5733E10E8EC
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 02:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790215833; x=1821751833;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ACw+v8q9HJglXsBWYNk5QW21ScNlTem+t6YcCssEcOA=;
 b=H29+z0G4cq2nAfNGLRj54Ml3tWe+lNorkz5a3eu2aACCGEH0Na93rQGv
 L52NMM6DOPwO4gtHVHXQLdPTZyJp6Ump13dAxys+faUsWGCcOzTr0OjAL
 fUZ07IuXiJ1GqKS7OjluvNAhHdtqyfN5arB1DP2POEqJoNyU58ce3yr9Q
 qQCrXSjUv2bRo2hiXNcVSjhMYpQPnUNPafVek3t6B/f/FEn3EgkRaqTLq
 uYtVdjO0wrvfBtMW1DauFr/4iYG9Kn51mNUK9J/qS/CKgsPD1tFmR3sIg
 q/xIwiFY1ucIBO539leXe3w1/l/lQ+tf88jPOrudjvYCluwATUF8Gq+TM Q==;
X-CSE-ConnectionGUID: FOUZAGypQx613t/7JXxJHw==
X-CSE-MsgGUID: 7LmJBDOIQPWYPkgKiiD72Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="1483053"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="1483053"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 19:10:22 -0700
X-CSE-ConnectionGUID: 8oOBvtnYT5uuRb0qIqwBQA==
X-CSE-MsgGUID: 4jXlXmiHTn6WuPXX8lIZ0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; d="scan'208";a="300124716"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa002.fm.intel.com with ESMTP; 23 Sep 2026 19:10:18 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x9Yud-00000000I6E-2f8T;
 Thu, 24 Sep 2026 02:10:15 +0000
Date: Thu, 24 Sep 2026 10:09:35 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>,
 Dave Airlie <airlied@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] pci/vgaarb: pass a data pointer to be used in the decode
 callback
Message-ID: <202609241015.1yXHBzfy-lkp@intel.com>
References: <20260922064111.2468741-1-airlied@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922064111.2468741-1-airlied@gmail.com>
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

Hi Dave,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on pci/next pci/for-linus drm-tip/drm-tip linus/master v7.3-rc4 next-20260922]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Airlie/pci-vgaarb-pass-a-data-pointer-to-be-used-in-the-decode-callback/20260922-164111
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260922064111.2468741-1-airlied%40gmail.com
patch subject: [PATCH] pci/vgaarb: pass a data pointer to be used in the decode callback
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20260924/202609241015.1yXHBzfy-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260924/202609241015.1yXHBzfy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609241015.1yXHBzfy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/gpu/drm/radeon/radeon_device.c:1079 function parameter 'data' not described in 'radeon_vga_set_decode'
>> Warning: drivers/gpu/drm/radeon/radeon_device.c:1079 Excess function parameter 'pdev' description in 'radeon_vga_set_decode'
>> Warning: drivers/gpu/drm/radeon/radeon_device.c:1079 function parameter 'data' not described in 'radeon_vga_set_decode'
>> Warning: drivers/gpu/drm/radeon/radeon_device.c:1079 Excess function parameter 'pdev' description in 'radeon_vga_set_decode'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
