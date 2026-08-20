Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF0AC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:58:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 163A610F00C;
	Thu, 20 Aug 2026 11:58:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eDunZS/z";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FE3E10F00B
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 11:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787227126; x=1818763126;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9SpD8W/pBMFw78YhGv8/2Fcjic1NtDIzErLrJ9qd19c=;
 b=eDunZS/zECU4u/Z0b2pUqgbv6x/sXDgTDLADkrBbaA193qGwtwmYkWmj
 w5NwXOEptyHGItqE2zEXYh3zTpyU5v4c/qQ+OmSUgklrUMqnPELESnOva
 RF0OC+U6pBXm/2eNz89lz3kF7N3dgQTmTnx5602VC6xusqTWhfADYu/1R
 5bUiwH06WWM4dg9WYJMofuvhatlzGaU5foXpeKmNc6faX4w1rbKr7i942
 n3kHqu2mIITa2JBK385IyPzNKDP7AN3ZokbhikhVray0a22KXqnyS5qbe
 ugpAKhHtYEluOkXSFiqKPZPjsMyUgyZZCR2cMz2YtkoJVOno0LY2MFbWn A==;
X-CSE-ConnectionGUID: 8npRyag2TEmEyx17ZLCwpg==
X-CSE-MsgGUID: D69b2etYRgKIAkrKxkwjMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="98092543"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="98092543"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 04:58:45 -0700
X-CSE-ConnectionGUID: 8yM+MwNlSvucnS86XmMcjg==
X-CSE-MsgGUID: xNJg0xCcSzO8GbN7GDN4Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="261743126"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by fmviesa006.fm.intel.com with ESMTP; 20 Aug 2026 04:58:42 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wx1Pq-00000000iuX-42o8;
 Thu, 20 Aug 2026 11:58:38 +0000
Date: Thu, 20 Aug 2026 19:58:25 +0800
From: kernel test robot <lkp@intel.com>
To: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
 jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, zachary.mckevitt@oss.qualcomm.com
Cc: oe-kbuild-all@lists.linux.dev, ogabbay@kernel.org, lizhi.hou@amd.com,
 karol.wachowski@linux.intel.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Troy Hanson <thanson@qti.qualcomm.com>
Subject: Re: [PATCH] accel/qaic: Add support for AI200 virtual functions
Message-ID: <202608201947.WZ2pipww-lkp@intel.com>
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
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20260820/202608201947.WZ2pipww-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260820/202608201947.WZ2pipww-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608201947.WZ2pipww-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/accel/qaic/qaic_drv.c:81:40: warning: 'aic200vf_config' defined but not used [-Wunused-const-variable=]
      81 | static const struct qaic_device_config aic200vf_config = {
         |                                        ^~~~~~~~~~~~~~~


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
