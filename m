Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAC4606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PqxkAGBJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C635610EADF;
	Sun, 22 Nov 2026 22:21:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F41C510EADF
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 22:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795386057; x=1826922057;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lc/6luGnTfiYQ5L6WAjEeu9PRcuwZl5d6rQ3ClQHdbc=;
 b=PqxkAGBJ9HCoSjqoBLaPntnImoZARpPje8tKfvIQ6LOy+uE0rdjvQI7c
 XmBMTiydF2Cx4e+bDweFwQiBrBqU3uDdSvU50dcIhYKJSsEYOaN7TH4km
 y1EWECa3kNgKZlSvm1XvHq0iXupkN0Hga6rc/m+RROtFgmlk/FaozQ09z
 gbZ8+w0aJ9wk1o7KECWSx1ODAyP601m4Cn+us5t4ZjUSCLhY7XTp6aFHd
 +D2VfCl2kTQ2WnuxoLbtkGgnDmjiw5y4UwziH6i5Wp6TMamQ7H5Oi35HR
 eVUFL1Glaogov45UyOea3tan/hyg2BF2RihK9BRultF1XRVf15D9lm+cE A==;
X-CSE-ConnectionGUID: aYTprLH1T6e8/v0tjcBs+Q==
X-CSE-MsgGUID: Vtd4QEoOTZajiIjTCPKwTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4222461"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4222461"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 14:20:56 -0800
X-CSE-ConnectionGUID: RnvpdRQeRIyzEGL4W/QQFg==
X-CSE-MsgGUID: XHRIZMQGRly4H4OxIWPybQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11164227"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa002.jf.intel.com with ESMTP; 22 Nov 2026 14:20:54 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xVFvW-00000001M9S-2JJP;
 Sun, 22 Nov 2026 22:20:50 +0000
Date: Mon, 23 Nov 2026 06:20:09 +0800
From: kernel test robot <lkp@intel.com>
To: Jim Cromie <jim.cromie@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jason Baron <jbaron@akamai.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
 Linux Memory Management List <linux-mm@kvack.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jim Cromie <jim.cromie@gmail.com>
Subject: Re: [PATCH v3 6/6] drm-dyndbg: drop BROKEN on DRM_USE_DYNAMIC_DEBUG
 for testing (DONT_APPLY)
Message-ID: <202611230650.Ebz6km83-lkp@intel.com>
References: <20261121-rd-mostly-v3-6-89e74b23b491@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121-rd-mostly-v3-6-89e74b23b491@gmail.com>
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

Hi Jim,

kernel test robot noticed the following build errors:

[auto build test ERROR on aebb7274476403040d582c61478df8f4a7bf9cd3]

url:    https://github.com/intel-lab-lkp/linux/commits/Jim-Cromie/drm-print-Mark-__drm_debug-as-__read_mostly/20261121-142254
base:   aebb7274476403040d582c61478df8f4a7bf9cd3
patch link:    https://lore.kernel.org/r/20261121-rd-mostly-v3-6-89e74b23b491%40gmail.com
patch subject: [PATCH v3 6/6] drm-dyndbg: drop BROKEN on DRM_USE_DYNAMIC_DEBUG for testing (DONT_APPLY)
config: csky-randconfig-1001-20261123 (https://download.01.org/0day-ci/archive/20261123/202611230650.Ebz6km83-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261123/202611230650.Ebz6km83-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611230650.Ebz6km83-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/accel/ethosu/ethosu_job.c:15:
   drivers/accel/ethosu/ethosu_job.c: In function 'ethosu_ioctl_submit':
>> include/drm/drm_print.h:566:9: error: implicit declaration of function '_dynamic_func_call_cls' [-Wimplicit-function-declaration]
     566 |         _dynamic_func_call_cls(cat, fmt, __drm_dev_dbg,         \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/drm/drm_print.h:654:9: note: in expansion of macro 'drm_dev_dbg'
     654 |         drm_dev_dbg(__drm_to_dev(drm), DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~
   include/drm/drm_print.h:672:33: note: in expansion of macro 'drm_dbg_driver'
     672 | #define drm_dbg(drm, fmt, ...)  drm_dbg_driver(drm, fmt, ##__VA_ARGS__)
         |                                 ^~~~~~~~~~~~~~
   drivers/accel/ethosu/ethosu_job.c:527:17: note: in expansion of macro 'drm_dbg'
     527 |                 drm_dbg(dev, "Failed to copy incoming job array\n");
         |                 ^~~~~~~


vim +/_dynamic_func_call_cls +566 include/drm/drm_print.h

02c9656b2f0d69 Haneen Mohammed 2017-10-17  560  
84ec67288c10fb Jim Cromie      2022-09-11  561  #if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
e820f52577b14c Jim Cromie      2022-09-11  562  #define drm_dev_dbg(dev, cat, fmt, ...)				\
16deeb8e18cafd Jim Cromie      2022-09-11  563  	__drm_dev_dbg(NULL, dev, cat, fmt, ##__VA_ARGS__)
84ec67288c10fb Jim Cromie      2022-09-11  564  #else
84ec67288c10fb Jim Cromie      2022-09-11  565  #define drm_dev_dbg(dev, cat, fmt, ...)				\
16deeb8e18cafd Jim Cromie      2022-09-11 @566  	_dynamic_func_call_cls(cat, fmt, __drm_dev_dbg,		\
84ec67288c10fb Jim Cromie      2022-09-11  567  			       dev, cat, fmt, ##__VA_ARGS__)
84ec67288c10fb Jim Cromie      2022-09-11  568  #endif
e820f52577b14c Jim Cromie      2022-09-11  569  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
