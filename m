Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D917DC5AD5A
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 02:56:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 072F910E48C;
	Thu, 13 Aug 2026 02:56:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SR2f5t6P";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01A9910E48C
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 02:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786589796; x=1818125796;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=H6R1Oop2pAed3ZR69V6eOEDdx6T0GrrLSFXvyYWrJlg=;
 b=SR2f5t6P//whE28Nb5/C46dPeYaui4F8ERZuXazg4z9D+ZltjKKNQk2k
 WwD5HhM99gxlIrSWRNwm7w7HKbx2HWwTpShr4IzAJKpZR7vBgKB3cedTu
 YFPNeynczj+VtbAT/RqGTSKBwMV1ruM9EE2DR8z5m65YS1kX4yQ7/c/Ag
 u/gUgnfJ7RpzR217Gp7eNTqgLVZ832kP3Y8wZhudy4wgChKttGEyeSYw7
 8Xnnl7IDjGfeLAK/F0i5jzGMr/TqKCCRdCXzHU9lsoKIg+bO/EqNcaTSM
 jG6acbajxv6mMbN4mPdj+NxOv1Qq+OiIDofxjyuNeW6x+qcQYVR5jPzxv w==;
X-CSE-ConnectionGUID: bdSfCqzuT1OtsCUXzjGf0g==
X-CSE-MsgGUID: CkwIKNgHTDy/bNdOGkglzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="97822096"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; d="scan'208";a="97822096"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 19:56:35 -0700
X-CSE-ConnectionGUID: n8j4yROPS+K1WaEczThwlw==
X-CSE-MsgGUID: 6U/vO0LJTR6Ee8aQeG4d3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; d="scan'208";a="262507827"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by orviesa010.jf.intel.com with ESMTP; 12 Aug 2026 19:56:34 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wuLcN-00000000SbS-3Vig;
 Thu, 13 Aug 2026 02:56:31 +0000
Date: Thu, 13 Aug 2026 10:55:58 +0800
From: kernel test robot <lkp@intel.com>
To: Liam Zuiderhoek <zuiderhoekl@gmail.com>, tzimmermann@suse.de
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Liam Zuiderhoek <zuiderhoekl@gmail.com>
Subject: Re: [PATCH] GPU: drm: meson inline drm_simple_encoder_init()
Message-ID: <202608131017.r8RRcaja-lkp@intel.com>
References: <20260622180832.28143-1-zuiderhoekl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622180832.28143-1-zuiderhoekl@gmail.com>
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

Hi Liam,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on daeinki-drm-exynos/exynos-drm-next drm/drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes drm-tip/drm-tip linus/master v7.2-rc7 next-20260811]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Liam-Zuiderhoek/GPU-drm-meson-inline-drm_simple_encoder_init/20260813-051125
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260622180832.28143-1-zuiderhoekl%40gmail.com
patch subject: [PATCH] GPU: drm: meson inline drm_simple_encoder_init()
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260813/202608131017.r8RRcaja-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260813/202608131017.r8RRcaja-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608131017.r8RRcaja-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/drm/drm_property.h:30,
                    from include/drm/drm_connector.h:33,
                    from include/drm/drm_modes.h:33,
                    from include/drm/drm_crtc.h:32,
                    from include/drm/drm_atomic_helper.h:31,
                    from drivers/gpu/drm/meson/meson_encoder_hdmi.c:21:
   drivers/gpu/drm/meson/meson_encoder_hdmi.c: In function 'meson_encoder_hdmi_probe':
>> include/uapi/drm/drm_mode.h:358:33: error: passing argument 3 of 'drm_encoder_init' makes pointer from integer without a cast [-Wint-conversion]
     358 | #define DRM_MODE_ENCODER_TMDS   2
         |                                 ^
         |                                 |
         |                                 int
   drivers/gpu/drm/meson/meson_encoder_hdmi.c:411:32: note: in expansion of macro 'DRM_MODE_ENCODER_TMDS'
     411 |                                DRM_MODE_ENCODER_TMDS, NULL);
         |                                ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/drm/drm_modeset_helper_vtables.h:33,
                    from include/drm/drm_atomic_helper.h:32:
   include/drm/drm_encoder.h:212:54: note: expected 'const struct drm_encoder_funcs *' but argument is of type 'int'
     212 |                      const struct drm_encoder_funcs *funcs,
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:5,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/powerpc/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:369,
                    from include/linux/err.h:5,
                    from include/linux/clk.h:12,
                    from drivers/gpu/drm/meson/meson_encoder_hdmi.c:8:
>> include/linux/stddef.h:8:14: error: passing argument 4 of 'drm_encoder_init' makes integer from pointer without a cast [-Wint-conversion]
       8 | #define NULL ((void *)0)
         |              ^~~~~~~~~~~
         |              |
         |              void *
   drivers/gpu/drm/meson/meson_encoder_hdmi.c:411:55: note: in expansion of macro 'NULL'
     411 |                                DRM_MODE_ENCODER_TMDS, NULL);
         |                                                       ^~~~
   include/drm/drm_encoder.h:213:26: note: expected 'int' but argument is of type 'void *'
     213 |                      int encoder_type, const char *name, ...);
         |                      ~~~~^~~~~~~~~~~~
>> drivers/gpu/drm/meson/meson_encoder_hdmi.c:410:15: error: too few arguments to function 'drm_encoder_init'; expected at least 5, have 4
     410 |         ret = drm_encoder_init(priv->drm, &meson_encoder_hdmi->encoder,
         |               ^~~~~~~~~~~~~~~~
   include/drm/drm_encoder.h:210:5: note: declared here
     210 | int drm_encoder_init(struct drm_device *dev,
         |     ^~~~~~~~~~~~~~~~
--
   In file included from include/drm/drm_property.h:30,
                    from include/drm/drm_connector.h:33,
                    from include/drm/drm_modes.h:33,
                    from include/drm/drm_crtc.h:32,
                    from include/drm/drm_atomic_helper.h:31,
                    from drm/meson/meson_encoder_hdmi.c:21:
   drm/meson/meson_encoder_hdmi.c: In function 'meson_encoder_hdmi_probe':
>> include/uapi/drm/drm_mode.h:358:33: error: passing argument 3 of 'drm_encoder_init' makes pointer from integer without a cast [-Wint-conversion]
     358 | #define DRM_MODE_ENCODER_TMDS   2
         |                                 ^
         |                                 |
         |                                 int
   drm/meson/meson_encoder_hdmi.c:411:32: note: in expansion of macro 'DRM_MODE_ENCODER_TMDS'
     411 |                                DRM_MODE_ENCODER_TMDS, NULL);
         |                                ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/drm/drm_modeset_helper_vtables.h:33,
                    from include/drm/drm_atomic_helper.h:32:
   include/drm/drm_encoder.h:212:54: note: expected 'const struct drm_encoder_funcs *' but argument is of type 'int'
     212 |                      const struct drm_encoder_funcs *funcs,
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:5,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from arch/powerpc/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:369,
                    from include/linux/err.h:5,
                    from include/linux/clk.h:12,
                    from drm/meson/meson_encoder_hdmi.c:8:
>> include/linux/stddef.h:8:14: error: passing argument 4 of 'drm_encoder_init' makes integer from pointer without a cast [-Wint-conversion]
       8 | #define NULL ((void *)0)
         |              ^~~~~~~~~~~
         |              |
         |              void *
   drm/meson/meson_encoder_hdmi.c:411:55: note: in expansion of macro 'NULL'
     411 |                                DRM_MODE_ENCODER_TMDS, NULL);
         |                                                       ^~~~
   include/drm/drm_encoder.h:213:26: note: expected 'int' but argument is of type 'void *'
     213 |                      int encoder_type, const char *name, ...);
         |                      ~~~~^~~~~~~~~~~~
   drm/meson/meson_encoder_hdmi.c:410:15: error: too few arguments to function 'drm_encoder_init'; expected at least 5, have 4
     410 |         ret = drm_encoder_init(priv->drm, &meson_encoder_hdmi->encoder,
         |               ^~~~~~~~~~~~~~~~
   include/drm/drm_encoder.h:210:5: note: declared here
     210 | int drm_encoder_init(struct drm_device *dev,
         |     ^~~~~~~~~~~~~~~~


vim +/drm_encoder_init +358 include/uapi/drm/drm_mode.h

8cf5c917715153 include/drm/drm_mode.h      Jesse Barnes     2011-11-14  355  
f453ba0460742a include/drm/drm_mode.h      Dave Airlie      2008-11-07  356  #define DRM_MODE_ENCODER_NONE	0
f453ba0460742a include/drm/drm_mode.h      Dave Airlie      2008-11-07  357  #define DRM_MODE_ENCODER_DAC	1
f453ba0460742a include/drm/drm_mode.h      Dave Airlie      2008-11-07 @358  #define DRM_MODE_ENCODER_TMDS	2
f453ba0460742a include/drm/drm_mode.h      Dave Airlie      2008-11-07  359  #define DRM_MODE_ENCODER_LVDS	3
f453ba0460742a include/drm/drm_mode.h      Dave Airlie      2008-11-07  360  #define DRM_MODE_ENCODER_TVDAC	4
a7331e5cb2cc68 include/drm/drm_mode.h      Thomas Hellstrom 2011-10-22  361  #define DRM_MODE_ENCODER_VIRTUAL 5
b89232732f642b include/uapi/drm/drm_mode.h Shobhit Kumar    2013-08-27  362  #define DRM_MODE_ENCODER_DSI	6
182407a6ed5333 include/uapi/drm/drm_mode.h Dave Airlie      2014-05-02  363  #define DRM_MODE_ENCODER_DPMST	7
0b27c02a7f1c69 include/uapi/drm/drm_mode.h Eric Anholt      2016-03-18  364  #define DRM_MODE_ENCODER_DPI	8
f453ba0460742a include/drm/drm_mode.h      Dave Airlie      2008-11-07  365  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
