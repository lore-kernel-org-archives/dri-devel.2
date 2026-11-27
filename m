Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6316606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lWmKQ5AA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EEFE10E0F2;
	Fri, 27 Nov 2026 06:56:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1B7410E0F2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 06:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795762600; x=1827298600;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=q4wWwKEJt+Fmd9rHF4mSHyulkd1InNpZ23yH0MiQ/MA=;
 b=lWmKQ5AAGuH00Nnioqs+3w6ICfZLnFwGzf2tMdG6vrGURtVA4sryPegu
 yq7T/vjaNaA8+1d6PtcTQqPeYB1f0jmhnMzt/kGpOAk7jJAboxlhruhXA
 Nd2iAu/u5qRxuk7s6ZnLy4fFZjxLoC88tukwV4MydzERfa5pqAWWMgTHe
 pJyWRSdNNBfaLreEKWX0UgU27PI89VJZmLYgxtOTk6BLJEOEoUDTmx3AA
 tyZzMsSXyP2SV61/q5kK3FLH5bZ53yCLPhUBDAkalMxbN+3mn7vOmP970
 IH/kG1+eZ3KkMXeN2jsUXEPVWcJfYmBde4KtjDkrZSMKcrVt3qlcEdxPT w==;
X-CSE-ConnectionGUID: 39olXWb4RMOZoUc+rxiEfA==
X-CSE-MsgGUID: TdKXoqQ6SNKzsHMr1DwO2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4684798"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4684798"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 22:56:39 -0800
X-CSE-ConnectionGUID: dtiZKUw9SDW9Na3YbDJATA==
X-CSE-MsgGUID: GE1v8WysQyO0/HmhIUs1lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; d="scan'208";a="12576530"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa002.fm.intel.com with ESMTP; 26 Nov 2026 22:56:35 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xWpsl-00000001VVi-2tw3;
 Fri, 27 Nov 2026 06:56:31 +0000
Date: Fri, 27 Nov 2026 14:56:03 +0800
From: kernel test robot <lkp@intel.com>
To: Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Boris Brezillon <bbrezillon@kernel.org>,
 Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Akash Goel <akash.goel@arm.com>,
 Karunika Choo <karunika.choo@arm.com>,
 Chris Diamand <chris.diamand@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Mihail Atanassov <mihail.atanassov@arm.com>
Subject: Re: [PATCH v8 1/3] drm/panthor: Add perf setup and session management
Message-ID: <20261127145121.RsArEiu5-lkp@intel.com>
References: <20261126-panthor-performance-counters-v8-1-6e7db0ec33f5@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126-panthor-performance-counters-v8-1-6e7db0ec33f5@arm.com>
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

Hi Lukas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 97429bac371273886238bfcf63d78e7405cacb46]

url:    https://github.com/intel-lab-lkp/linux/commits/Lukas-Zapolskas/drm-panthor-Add-perf-setup-and-session-management/20261126-205737
base:   97429bac371273886238bfcf63d78e7405cacb46
patch link:    https://lore.kernel.org/r/20261126-panthor-performance-counters-v8-1-6e7db0ec33f5%40arm.com
patch subject: [PATCH v8 1/3] drm/panthor: Add perf setup and session management
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20261127/20261127145121.RsArEiu5-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261127/20261127145121.RsArEiu5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261127145121.RsArEiu5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/dma-mapping.h:5,
                    from include/linux/dma-buf.h:21,
                    from include/drm/drm_gem.h:38,
                    from drivers/gpu/drm/panthor/panthor_perf.c:6:
   drivers/gpu/drm/panthor/panthor_perf.c: In function 'panthor_perf_bo_get':
>> include/drm/drm_print.h:615:46: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     615 |         dev_##level##type(__drm_to_dev(drm), "[drm] " fmt, ##__VA_ARGS__)
         |                                              ^~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   include/drm/drm_print.h:615:9: note: in expansion of macro 'dev_err'
     615 |         dev_##level##type(__drm_to_dev(drm), "[drm] " fmt, ##__VA_ARGS__)
         |         ^~~~
   include/drm/drm_print.h:628:9: note: in expansion of macro '__drm_printk'
     628 |         __drm_printk((drm), err,, "*ERROR* " fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~
   drivers/gpu/drm/panthor/panthor_perf.c:254:17: note: in expansion of macro 'drm_err'
     254 |                 drm_err(ddev,
         |                 ^~~~~~~
   include/drm/drm_print.h:615:46: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     615 |         dev_##level##type(__drm_to_dev(drm), "[drm] " fmt, ##__VA_ARGS__)
         |                                              ^~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   include/drm/drm_print.h:615:9: note: in expansion of macro 'dev_err'
     615 |         dev_##level##type(__drm_to_dev(drm), "[drm] " fmt, ##__VA_ARGS__)
         |         ^~~~
   include/drm/drm_print.h:628:9: note: in expansion of macro '__drm_printk'
     628 |         __drm_printk((drm), err,, "*ERROR* " fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~
   drivers/gpu/drm/panthor/panthor_perf.c:254:17: note: in expansion of macro 'drm_err'
     254 |                 drm_err(ddev,
         |                 ^~~~~~~
   In file included from <command-line>:
   drivers/gpu/drm/panthor/panthor_perf.c: In function 'session_read_extract_idx.isra':
   include/linux/compiler_types.h:702:45: error: call to '__compiletime_assert_559' declared with attribute error: Need native word sized stores/loads for atomicity.
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:683:25: note: in definition of macro '__compiletime_assert'
     683 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:702:9: note: in expansion of macro '_compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:705:9: note: in expansion of macro 'compiletime_assert'
     705 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/barrier.h:69:9: note: in expansion of macro 'compiletime_assert_atomic_type'
      69 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
     176 | #define smp_load_acquire(p) __smp_load_acquire(p)
         |                             ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/panthor/panthor_perf.c:378:16: note: in expansion of macro 'smp_load_acquire'
     378 |         return smp_load_acquire(&session->control->extract_idx);
         |                ^~~~~~~~~~~~~~~~


vim +615 include/drm/drm_print.h

d05386a3fdf373 Jani Nikula 2025-01-23  612  
fb6c7ab8718eb2 Jani Nikula 2019-12-10  613  /* Helper for struct drm_device based logging. */
fb6c7ab8718eb2 Jani Nikula 2019-12-10  614  #define __drm_printk(drm, level, type, fmt, ...)			\
d05386a3fdf373 Jani Nikula 2025-01-23 @615  	dev_##level##type(__drm_to_dev(drm), "[drm] " fmt, ##__VA_ARGS__)
fb6c7ab8718eb2 Jani Nikula 2019-12-10  616  
fb6c7ab8718eb2 Jani Nikula 2019-12-10  617  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
