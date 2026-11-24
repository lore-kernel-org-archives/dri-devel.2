Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC494606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LCwewTvT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 657C410E23F;
	Tue, 24 Nov 2026 13:42:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FC8810E10A;
 Tue, 24 Nov 2026 13:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795527750; x=1827063750;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=xrF09vv+ciashULbO0v5LVsOaLbzLGwInEB/NeEGsQY=;
 b=LCwewTvTVFy0n/4FpSEiJC8ox5kpTKa5bkghlAdGU7I8Rm2F6BRv7ZuV
 7xePJoEILtshKfUB1FMYEc69IvezosWSOTkV/3ny7Syq5Zigunbe1KPoU
 GQWBDcqU8rZVAMvKg3hnPCEiqhCerO/dgZEQZ8lXAo2Ni8qPL3b7aiJtt
 ACUKeJE/YyKuL1ca5K8t8ThdDLgAoJkA2iCZcEeN9yXXtBbIxOQRN3y5W
 OfrD2Qq+5GNGhbYpTR9xwhX//V6MKB9KNs6MwBo4jtUELXWa8/mQ73c9/
 PJIhFtcv5GG8LNRYKjIz5BVvooVzrEi/7JoDQgm+0T7wRk3m6b6wwGega w==;
X-CSE-ConnectionGUID: XmG4E0KuTH+aCBnWeLJgKw==
X-CSE-MsgGUID: AC7pA/RlSDCUBdAvQQfmIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4244443"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4244443"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 05:42:30 -0800
X-CSE-ConnectionGUID: 3NJENb3hTNC/OsDt2BlJTQ==
X-CSE-MsgGUID: 9SLlxSfJS4mTQ6t0GI0CzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11923085"
Received: from igk-lkp-server01.igk.intel.com (HELO 1073a420ae3a)
 ([10.211.93.152])
 by fmviesa007.fm.intel.com with ESMTP; 24 Nov 2026 05:42:29 -0800
Received: from kbuild by 1073a420ae3a with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xVqmw-000000005Cf-1ltf;
 Tue, 24 Nov 2026 13:42:26 +0000
Date: Tue, 24 Nov 2026 14:42:21 +0100
From: kernel test robot <lkp@intel.com>
To: "Ville =?utf-8?Q?Syrj=C3=A4l=C3=A4"?= <ville.syrjala@linux.intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Jani Nikula <jani.nikula@intel.com>
Subject: [drm-i915:for-linux-next 5/6]
 drivers/gpu/drm/i915/display/intel_de.c:350:18: warning: use of bitwise '|'
 with boolean operands
Message-ID: <20261124143710.bu4mng1e-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

tree:   https://gitlab.freedesktop.org/drm/i915/kernel.git for-linux-next
head:   6d00cec4c9becea6540f75820bc0837d14ea7611
commit: 1a6684ee830ff0a15147e332991e1a5d34c55592 [5/6] drm/i915/de: Optimize the mmio_debug checks in intel_de_{read,write}()
config: riscv-randconfig-2005-20261124 (https://download.01.org/0day-ci/archive/20261124/20261124143710.bu4mng1e-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261124/20261124143710.bu4mng1e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261124143710.bu4mng1e-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/i915/display/intel_de.c:350:18: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
     350 |         return unlikely(!!READ_ONCE(display->params.mmio_debug) |
         |                ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                                 ||
     351 |                         READ_ONCE(display->mmio.mmio_debug_oneshot));
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:47:41: note: expanded from macro 'unlikely'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:32:34: note: expanded from macro '__branch_check__'
      32 |                         ______r = __builtin_expect(!!(x), expect);      \
         |                                                      ~^~
   drivers/gpu/drm/i915/display/intel_de.c:350:18: note: cast one or both operands to int to silence this warning
>> drivers/gpu/drm/i915/display/intel_de.c:350:18: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
     350 |         return unlikely(!!READ_ONCE(display->params.mmio_debug) |
         |                ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                                 ||
     351 |                         READ_ONCE(display->mmio.mmio_debug_oneshot));
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:47:68: note: expanded from macro 'unlikely'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   include/linux/compiler.h:34:19: note: expanded from macro '__branch_check__'
      34 |                                              expect, is_constant);      \
         |                                                      ^~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_de.c:350:18: note: cast one or both operands to int to silence this warning
   2 warnings generated.


vim +350 drivers/gpu/drm/i915/display/intel_de.c

   345	
   346	static __always_inline bool
   347	__mmio_debug_is_enabled(struct intel_display *display)
   348	{
   349		/* with || gcc emits two branches for this */
 > 350		return unlikely(!!READ_ONCE(display->params.mmio_debug) |
   351				READ_ONCE(display->mmio.mmio_debug_oneshot));
   352	}
   353	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
