Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E45F9D0C4
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 11:44:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36F3210E233;
	Tue, 14 Apr 2026 11:44:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eSTPwk4Y";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A58E810E233
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 11:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776167084; x=1807703084;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/uifXYhjkpn2JIQXVjganr+ngHnaC65t/JIBOoBeA2s=;
 b=eSTPwk4Ys48p22f0FooDaxOgVEzNZZ4Uae2lVUxsvBVxDgO4+CAtv5ud
 ZbgdFyV5lukVuSO2dR4YwJhGfWdpcomKF5T6DxUC810dr6e5V6474Xppu
 78LEHmDhbxvdQd5L83JwXxLk/I9bPd4YU5l8c9ZkX/samKskPmCMMzugO
 aCO0Y2jS38RdSelMUJYss2K8OsHEtHo8d3boO5/LyBPrs4ZJM7jtbMOC2
 pK1+RjKrFRV45RzBEp3NgjnTYS6auBvdtv8A1NXcdTq/EzeeXa+prVBM5
 Hq62Y4YhwpOfqpk7N/JEBj6aq0OuOXlQXMJRnmlNxHc5Zw3NAR+u4wiPu w==;
X-CSE-ConnectionGUID: o/p7NA5dTZSnMi/16GsEQg==
X-CSE-MsgGUID: 8je6EkG2SiOTKRssndrQqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="64656951"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="64656951"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2026 04:44:41 -0700
X-CSE-ConnectionGUID: T3APFrp+ROWWVa0psOuu0g==
X-CSE-MsgGUID: ViKU/xG9TGy2574E8oN0MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="227419138"
Received: from lkp-server01.sh.intel.com (HELO 7b0b59b3a0d4) ([10.239.97.150])
 by fmviesa008.fm.intel.com with ESMTP; 14 Apr 2026 04:44:38 -0700
Received: from kbuild by 7b0b59b3a0d4 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wCcC4-000000001PR-0SFf;
 Tue, 14 Apr 2026 11:44:36 +0000
Date: Tue, 14 Apr 2026 19:43:43 +0800
From: kernel test robot <lkp@intel.com>
To: Baker <mzndmzn@gmail.com>, andy@kernel.org, gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, Baker <mzndmzn@gmail.com>
Subject: Re: [PATCH] staging: fbtft: fix coding style issue in fbtft-bus.c
Message-ID: <202604141939.LhzKrfey-lkp@intel.com>
References: <20260412173317.3329-1-mzndmzn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412173317.3329-1-mzndmzn@gmail.com>
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

Hi Baker,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Baker/staging-fbtft-fix-coding-style-issue-in-fbtft-bus-c/20260414-101811
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20260412173317.3329-1-mzndmzn%40gmail.com
patch subject: [PATCH] staging: fbtft: fix coding style issue in fbtft-bus.c
config: arm-randconfig-r072-20260414 (https://download.01.org/0day-ci/archive/20260414/202604141939.LhzKrfey-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.4.0
smatch: v0.5.0-9007-gcf3ea02b
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260414/202604141939.LhzKrfey-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604141939.LhzKrfey-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/fbtft/fbtft-bus.c:65:53: error: macro "define_fbtft_write_reg" requires 4 arguments, but only 3 given
      65 | define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
         |                                                     ^
   drivers/staging/fbtft/fbtft-bus.c:14: note: macro "define_fbtft_write_reg" defined here
      14 | #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
         | 
>> drivers/staging/fbtft/fbtft-bus.c:65:23: error: expected ';' before 'void'
      65 | define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
         |                       ^
         |                       ;
   drivers/staging/fbtft/fbtft-bus.c:67:57: error: macro "define_fbtft_write_reg" requires 4 arguments, but only 3 given
      67 | define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
         |                                                         ^
   drivers/staging/fbtft/fbtft-bus.c:14: note: macro "define_fbtft_write_reg" defined here
      14 | #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
         | 
   drivers/staging/fbtft/fbtft-bus.c:67:23: error: expected ';' before 'void'
      67 | define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
         |                       ^
         |                       ;
      68 | 
      69 | void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
         | ~~~~                   


vim +/define_fbtft_write_reg +65 drivers/staging/fbtft/fbtft-bus.c

    64	
  > 65	define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
    66	define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
    67	define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
    68	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
