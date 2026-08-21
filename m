Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BB2C5DF87
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 00:29:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64C2E10E0A3;
	Fri, 21 Aug 2026 00:29:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KbW6TAJK";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 909B710E0A3
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 00:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787272162; x=1818808162;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=PmhnE36F/dgYkeJ+H6lXW4sx7C9Wu4TDdQEoD+EkJMw=;
 b=KbW6TAJKjaHiDvmHS7eu1dpcsjlLgodFzyQdz1WWNAPflL2MObvAp600
 /VC3j7GRNLhsXMz0uG0wQdqf0h1KzgFIm6dR8CWD3IKoqH8DztEfFftqO
 zZSQz+dlCk4HzIvUGdoAKWsSGvEVAgJ0u2BPwQXX+hKfZ7NV/q5JSaAQk
 izl8KhCtc9/sZsYHEbtTH0y9+9ToTSTKhu5cYncQzHXZkg3ZatbpQc2Z2
 efNqLfYF7pK30A8IQpXMWepD12TJs/q7dj+Z9Q0Q9vVNyn2/5r+L3vr/f
 rwi3NQ+CxvJsZRubd3Icfyeixp7Rr5HsO0gnlhHkl5isdNq1+lLcuvcVW w==;
X-CSE-ConnectionGUID: rcFZI6hgQX6+X8gM2Ihj5Q==
X-CSE-MsgGUID: fMN9kYJfSgG7XCkPGmq+kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="105356674"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; d="scan'208";a="105356674"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 17:29:22 -0700
X-CSE-ConnectionGUID: jQIY0Ts/QAOBsW4rpJyPaw==
X-CSE-MsgGUID: o5NXq30DTYSdEVni4r7l0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; d="scan'208";a="270002012"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by orviesa004.jf.intel.com with ESMTP; 20 Aug 2026 17:29:20 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wxD8G-00000000ooj-3QEF;
 Fri, 21 Aug 2026 00:29:16 +0000
Date: Fri, 21 Aug 2026 08:28:30 +0800
From: kernel test robot <lkp@intel.com>
To: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
 jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, zachary.mckevitt@oss.qualcomm.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, ogabbay@kernel.org,
 lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Troy Hanson <thanson@qti.qualcomm.com>
Subject: Re: [PATCH] accel/qaic: Add support for AI200 virtual functions
Message-ID: <202608210811.E9e3fBWz-lkp@intel.com>
References: <20260814164125.3652876-1-youssef.abdulrahman@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814164125.3652876-1-youssef.abdulrahman@oss.qualcomm.com>
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

Hi Youssef,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v7.2 next-20260819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Youssef-Samir/accel-qaic-Add-support-for-AI200-virtual-functions/20260814-184125
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260814164125.3652876-1-youssef.abdulrahman%40oss.qualcomm.com
patch subject: [PATCH] accel/qaic: Add support for AI200 virtual functions
config: i386-randconfig-005-20260821 (https://download.01.org/0day-ci/archive/20260821/202608210811.E9e3fBWz-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260821/202608210811.E9e3fBWz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608210811.E9e3fBWz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/accel/qaic/qaic_drv.c:81:40: warning: unused variable 'aic200vf_config' [-Wunused-const-variable]
      81 | static const struct qaic_device_config aic200vf_config = {
         |                                        ^~~~~~~~~~~~~~~
   1 warning generated.


vim +/aic200vf_config +81 drivers/accel/qaic/qaic_drv.c

    80	
  > 81	static const struct qaic_device_config aic200vf_config = {
    82		.family = FAMILY_AIC200_VF,
    83		.bar_mask = BIT(0) | BIT(1) | BIT(2) | BIT(4),
    84		.mhi_bar_idx = 1,
    85		.dbc_bar_idx = 2,
    86	};
    87	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
