Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBD5C5AD5A
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 04:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47EF310E011;
	Sat, 15 Aug 2026 04:13:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MmLactf/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C855410E011
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 04:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786767204; x=1818303204;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=q0IMlX55DM75dfpUgO/pYE3hs4RFSj7CSuYjoCVrx1Y=;
 b=MmLactf/3ta9AgnxLSt6R1dP2U+8ZZ4H875odZuJOawd577tTeRl9Bna
 gOh0z+qAhNk0IcvE3xKIqcNpH+ZJzW7hv4KKXsvoEOsqIv0ADxo6vIIlr
 iD4vN5JjF/bBFpw3PpgW+lW7DpH0iOv7/dbyeK2KaT6YatwYSsiVXZhtF
 ztrlrW0sJ2Iml34CnXzS6ZWIZboK9rmW7AThKZoFhzNeVVShsccv4jlzK
 ULoUi1gxiMqTQkk2hCQCFa+zrl07WyYNaN3g/L1JWemqP8muyb+m2zD8u
 bHBxU92bp46g2CGByjoCaKrETj4CnVuZGwk3xlDeOEmAhrq2u7lygxoMs w==;
X-CSE-ConnectionGUID: N9wuZhQ6SsKdh0vFuM1lfg==
X-CSE-MsgGUID: mXrJRMo0R66Mjkc31dDIaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="87553206"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; d="scan'208";a="87553206"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 21:13:23 -0700
X-CSE-ConnectionGUID: zFuW32z+QSi794qZCben9A==
X-CSE-MsgGUID: mHVR9Ge+TN+lK61vJ9JZuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; d="scan'208";a="287868667"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by fmviesa002.fm.intel.com with ESMTP; 14 Aug 2026 21:13:21 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wv5ll-00000000b4w-3Tpb;
 Sat, 15 Aug 2026 04:13:17 +0000
Date: Sat, 15 Aug 2026 12:13:07 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Zhou <zhoulol888@gmail.com>, dri-devel@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, linux-kernel@vger.kernel.org,
 Andrew Zhou <zhoulol888@gmail.com>
Subject: Re: [PATCH] drm: make panel orientation quirks optional
Message-ID: <202608151239.Mo46Llie-lkp@intel.com>
References: <20260716065106.150760-1-zhoulol888@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716065106.150760-1-zhoulol888@gmail.com>
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

Hi Andrew,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on daeinki-drm-exynos/exynos-drm-next drm/drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes drm-tip/drm-tip linus/master v7.2-rc7 next-20260813]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrew-Zhou/drm-make-panel-orientation-quirks-optional/20260815-090825
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260716065106.150760-1-zhoulol888%40gmail.com
patch subject: [PATCH] drm: make panel orientation quirks optional
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20260815/202608151239.Mo46Llie-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260815/202608151239.Mo46Llie-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608151239.Mo46Llie-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/drm_panel_orientation_quirks.c:593:5: error: redefinition of 'drm_get_panel_orientation_quirk'
     593 | int drm_get_panel_orientation_quirk(int width, int height)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/drm_panel_orientation_quirks.c:15:
   include/drm/drm_utils.h:21:19: note: previous definition of 'drm_get_panel_orientation_quirk' with type 'int(int,  int)'
      21 | static inline int drm_get_panel_orientation_quirk(int width, int height)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/drm_get_panel_orientation_quirk +593 drivers/gpu/drm/drm_panel_orientation_quirks.c

404d1a3edc3873 Hans de Goede 2017-11-25  591  
8a445de79eeaed Andrew Zhou   2026-07-16  592  /* Fallback stub when DMI or the entire quirk module is disabled. */
404d1a3edc3873 Hans de Goede 2017-11-25 @593  int drm_get_panel_orientation_quirk(int width, int height)
404d1a3edc3873 Hans de Goede 2017-11-25  594  {
404d1a3edc3873 Hans de Goede 2017-11-25  595  	return DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
404d1a3edc3873 Hans de Goede 2017-11-25  596  }
404d1a3edc3873 Hans de Goede 2017-11-25  597  EXPORT_SYMBOL(drm_get_panel_orientation_quirk);
404d1a3edc3873 Hans de Goede 2017-11-25  598  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
