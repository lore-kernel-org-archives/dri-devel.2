Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A366E606A31B
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 05:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ilaGBQmw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09FA410E402;
	Sat, 24 Oct 2026 05:17:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56F9E10E402;
 Sat, 24 Oct 2026 05:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792819020; x=1824355020;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=IIv2fZBANIicJi2ej+JSsJjS2vcWWkfUJDU36V78g9g=;
 b=ilaGBQmwM+/bA6NaCATu3sUxRk+cIfOEi+oYi4nnlWPf9W838HMXgAPX
 3+54sUVYcU7scprKVJza8Y0npZENCauGsW2IDh6pYbLMftS1jCUYQedds
 ZHzYiKnMWc7u8zGUEeFEyCQmMXAaHbYNso7dVznHczgnxWxGEtpNsmaeV
 YltRQgcUB3pgvHgQpayvD+3eyLVEA7lxZU8KuQ+VHMGCcRr9RqAQ9BRY7
 gAUKZAfrhH2RFD1vANHeNCalY4G7yePHDNNMAkv5xqy50AYZQnZU1snny
 VpxKpmrvhUQBdkJvgzhyTTVAjb/6W85Cqh3nYIE6rsxDtwNV/D08/0Vst g==;
X-CSE-ConnectionGUID: ulU8L/Z1QmyJBJy0c5v2mw==
X-CSE-MsgGUID: xiHPNRK6SVqRXYvzct9GHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1590963"
X-IronPort-AV: E=Sophos;i="6.27,175,1787036400"; 
   d="scan'208";a="1590963"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 22:16:59 -0700
X-CSE-ConnectionGUID: nHnj8W89SzyZwvB+ogGEmw==
X-CSE-MsgGUID: 1xz0TVDqSfuedbh7bk1LMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,175,1787036400"; 
   d="scan'208";a="5562893"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa012.fm.intel.com with ESMTP; 23 Oct 2026 22:16:54 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xKU7e-00000000TbW-3Xnc;
 Sat, 24 Oct 2026 05:16:50 +0000
Date: Sat, 24 Oct 2026 13:16:33 +0800
From: kernel test robot <lkp@intel.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/14] drm/msm/a8xx: devcoredump state capture support
Message-ID: <202610241330.82NsqXG7-lkp@intel.com>
References: <20261021204244.67160-12-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021204244.67160-12-robin.clark@oss.qualcomm.com>
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Rob,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on drm-tip/drm-tip next-20261022]
[cannot apply to linux-review/Rob-Clark/drm-msm-Import-adreno_snapshot-h/20261020-134615 drm-misc/drm-misc-next daeinki-drm-exynos/exynos-drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes linus/master v7.3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rob-Clark/drm-msm-Import-adreno_snapshot-h/20261021-134126
base:   https://gitlab.freedesktop.org/drm/kernel.git drm-next
patch link:    https://lore.kernel.org/r/20261021204244.67160-12-robin.clark%40oss.qualcomm.com
patch subject: [PATCH v2 11/14] drm/msm/a8xx: devcoredump state capture support
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20261024/202610241330.82NsqXG7-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261024/202610241330.82NsqXG7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610241330.82NsqXG7-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/msm/adreno/adreno_snapshot.h:510:33: note: in expansion of macro 'GENMASK'
     510 |         *(p->in++) = FIELD_PREP(GENMASK(63, 44), reg) | dwords;
         |                                 ^~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/compiler_types.h:682:23: note: in definition of macro '__compiletime_assert'
     682 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:702:9: note: in expansion of macro '_compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:51:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      51 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:74:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      74 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:91:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      91 |                 __BF_FIELD_CHECK_MASK(mask, val, pfx);                  \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:138:17: note: in expansion of macro '__FIELD_PREP'
     138 |                 __FIELD_PREP(_mask, _val, "FIELD_PREP: ");              \
         |                 ^~~~~~~~~~~~
   drivers/gpu/drm/msm/adreno/adreno_snapshot.h:510:22: note: in expansion of macro 'FIELD_PREP'
     510 |         *(p->in++) = FIELD_PREP(GENMASK(63, 44), reg) | dwords;
         |                      ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/gpu/drm/msm/adreno/adreno_snapshot.h:510:33: note: in expansion of macro 'GENMASK'
     510 |         *(p->in++) = FIELD_PREP(GENMASK(63, 44), reg) | dwords;
         |                                 ^~~~~~~
   include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/bitfield.h:92:50: note: in definition of macro '__FIELD_PREP'
      92 |                 ((typeof(mask))(val) << __bf_shf(mask)) & (mask);       \
         |                                                  ^~~~
   drivers/gpu/drm/msm/adreno/adreno_snapshot.h:510:22: note: in expansion of macro 'FIELD_PREP'
     510 |         *(p->in++) = FIELD_PREP(GENMASK(63, 44), reg) | dwords;
         |                      ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/gpu/drm/msm/adreno/adreno_snapshot.h:510:33: note: in expansion of macro 'GENMASK'
     510 |         *(p->in++) = FIELD_PREP(GENMASK(63, 44), reg) | dwords;
         |                                 ^~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/bitfield.h:92:50: note: in definition of macro '__FIELD_PREP'
      92 |                 ((typeof(mask))(val) << __bf_shf(mask)) & (mask);       \
         |                                                  ^~~~
   drivers/gpu/drm/msm/adreno/adreno_snapshot.h:510:22: note: in expansion of macro 'FIELD_PREP'
     510 |         *(p->in++) = FIELD_PREP(GENMASK(63, 44), reg) | dwords;
         |                      ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/gpu/drm/msm/adreno/adreno_snapshot.h:510:33: note: in expansion of macro 'GENMASK'
     510 |         *(p->in++) = FIELD_PREP(GENMASK(63, 44), reg) | dwords;
         |                                 ^~~~~~~
   include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/bitfield.h:92:60: note: in definition of macro '__FIELD_PREP'
      92 |                 ((typeof(mask))(val) << __bf_shf(mask)) & (mask);       \
         |                                                            ^~~~
   drivers/gpu/drm/msm/adreno/adreno_snapshot.h:510:22: note: in expansion of macro 'FIELD_PREP'
     510 |         *(p->in++) = FIELD_PREP(GENMASK(63, 44), reg) | dwords;
         |                      ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/gpu/drm/msm/adreno/adreno_snapshot.h:510:33: note: in expansion of macro 'GENMASK'
     510 |         *(p->in++) = FIELD_PREP(GENMASK(63, 44), reg) | dwords;
         |                                 ^~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/bitfield.h:92:60: note: in definition of macro '__FIELD_PREP'
      92 |                 ((typeof(mask))(val) << __bf_shf(mask)) & (mask);       \
         |                                                            ^~~~
   drivers/gpu/drm/msm/adreno/adreno_snapshot.h:510:22: note: in expansion of macro 'FIELD_PREP'
     510 |         *(p->in++) = FIELD_PREP(GENMASK(63, 44), reg) | dwords;
         |                      ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/gpu/drm/msm/adreno/adreno_snapshot.h:510:33: note: in expansion of macro 'GENMASK'
     510 |         *(p->in++) = FIELD_PREP(GENMASK(63, 44), reg) | dwords;
         |                                 ^~~~~~~
   drivers/gpu/drm/msm/adreno/adreno_snapshot.h: In function 'CD_WRITE':
>> include/linux/compiler_types.h:702:45: error: call to '__compiletime_assert_635' declared with attribute error: FIELD_PREP: mask is not constant
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:683:25: note: in definition of macro '__compiletime_assert'
     683 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:702:9: note: in expansion of macro '_compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
      40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:67:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      67 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:91:17: note: in expansion of macro '__BF_FIELD_CHECK_MASK'
      91 |                 __BF_FIELD_CHECK_MASK(mask, val, pfx);                  \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:138:17: note: in expansion of macro '__FIELD_PREP'
     138 |                 __FIELD_PREP(_mask, _val, "FIELD_PREP: ");              \
         |                 ^~~~~~~~~~~~
   drivers/gpu/drm/msm/adreno/adreno_snapshot.h:503:22: note: in expansion of macro 'FIELD_PREP'
     503 |         *(p->in++) = FIELD_PREP(GENMASK(63, 44), reg) | BIT(21) | BIT(0);
         |                      ^~~~~~~~~~


vim +/__compiletime_assert_635 +702 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  688  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  689  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  690  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  691  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  692  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  693   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  694   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  695   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  696   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  697   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  698   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  699   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  700   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  701  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @702  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  703  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
