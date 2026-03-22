Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B864DFC72AD
	for <dri-devel@archiver.kernel.org>; Sun, 22 Mar 2026 14:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7CDD10E281;
	Sun, 22 Mar 2026 14:47:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ab1repuk";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81B6F10E281
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 14:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774190838; x=1805726838;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=4CuJLFo5P0QwW8OdcIzkP4cLzHaoF1RmcqeEapDcW6Q=;
 b=ab1repukzb9uliyu2eK6gPN+Iyc2jUWy+XHopEoJ3KgJXl4QMc5ewxox
 6cM++7WuphpDp3XadFdKJak6M6WDHIscpFwRDKgwNym4Vmy+ADg0uQvdD
 UbOAf5qfkJNRkxyfq4lI9HdVRS+s6L4va2SoyMReEiOu3paH426DOJZyS
 p9YpBt5MmEcohBwzbgJV9fBcb1MDgrH7em2zBRtksACUDxbF41jwUbWQa
 TRY0RLlZqhEArVJM2vKFZDNDl95GIxLpUwbZwlGbZh5m7akNjW63rDgT0
 Da+xBPcf59mIAyuS4TiFhw5JN6sW3Dvn1vL+AaTGWqZaYrF6kwqK3b+/3 A==;
X-CSE-ConnectionGUID: C2k3Mtj2S3CJGgA+pazLJg==
X-CSE-MsgGUID: M+LkDI6IRjyIuPD4cJjmYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="86282433"
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; d="scan'208";a="86282433"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2026 07:47:17 -0700
X-CSE-ConnectionGUID: BnK2MdicQbacO98ZZ3s+MA==
X-CSE-MsgGUID: zav4hKkJTd6G3gT+FXBPEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; d="scan'208";a="228505602"
Received: from lkp-server02.sh.intel.com (HELO d7fefbca0d04) ([10.239.97.151])
 by fmviesa005.fm.intel.com with ESMTP; 22 Mar 2026 07:47:15 -0700
Received: from kbuild by d7fefbca0d04 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w4K5A-000000002Fd-0GZZ;
 Sun, 22 Mar 2026 14:47:12 +0000
Date: Sun, 22 Mar 2026 22:46:33 +0800
From: kernel test robot <lkp@intel.com>
To: Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: oe-kbuild-all@lists.linux.dev, Frank Binns <frank.binns@imgtec.com>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Matt Coster <matt.coster@imgtec.com>
Subject: Re: [PATCH v2 1/2] drm/imagination: Define packed BVNCs in the uapi
Message-ID: <202603222211.A2XiR1YU-lkp@intel.com>
References: <20260320-bvnc-cleanup-v2-1-49c3c1453289@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-bvnc-cleanup-v2-1-49c3c1453289@imgtec.com>
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

Hi Matt,

kernel test robot noticed the following build errors:

[auto build test ERROR on fbef867cf6614178bc6afd15ee15f85cddf19eab]

url:    https://github.com/intel-lab-lkp/linux/commits/Matt-Coster/drm-imagination-Define-packed-BVNCs-in-the-uapi/20260322-112647
base:   fbef867cf6614178bc6afd15ee15f85cddf19eab
patch link:    https://lore.kernel.org/r/20260320-bvnc-cleanup-v2-1-49c3c1453289%40imgtec.com
patch subject: [PATCH v2 1/2] drm/imagination: Define packed BVNCs in the uapi
config: arm64-randconfig-002-20260322 (https://download.01.org/0day-ci/archive/20260322/202603222211.A2XiR1YU-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260322/202603222211.A2XiR1YU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603222211.A2XiR1YU-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/build_bug.h:5,
                    from include/linux/bits.h:30,
                    from drivers/gpu/drm/imagination/pvr_rogue_fwif.h:7,
                    from drivers/gpu/drm/imagination/pvr_ccb.h:7,
                    from drivers/gpu/drm/imagination/pvr_device.h:7,
                    from drivers/gpu/drm/imagination/pvr_device.c:4:
   drivers/gpu/drm/imagination/pvr_device.c: In function 'pvr_gpu_support_level':
>> include/linux/compiler.h:203:82: error: expression in static assertion is not constant
     203 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                                  ^~~~
   include/linux/build_bug.h:17:9: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
      17 |         __BUILD_BUG_ON_ZERO_MSG(e, ##__VA_ARGS__, #e " is true")
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:160:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     160 |                 BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/imagination/pvr_device.h:474:10: note: in expansion of macro 'FIELD_PREP_CONST'
     474 |         (prep(DRM_PVR_BVNC_B, b) | \
         |          ^~~~
   drivers/gpu/drm/imagination/pvr_device.h:496:43: note: in expansion of macro '__PVR_PACKED_BVNC'
     496 | #define PVR_PACKED_BVNC_CONST(b, v, n, c) __PVR_PACKED_BVNC(FIELD_PREP_CONST, b, v, n, c)
         |                                           ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/imagination/pvr_device.c:550:14: note: in expansion of macro 'PVR_PACKED_BVNC_CONST'
     550 |         case PVR_PACKED_BVNC_CONST(33, 15, 11, 3):
         |              ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:203:82: error: expression in static assertion is not constant
     203 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                                  ^~~~
   include/linux/build_bug.h:17:9: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
      17 |         __BUILD_BUG_ON_ZERO_MSG(e, ##__VA_ARGS__, #e " is true")
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:141:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     141 | #define __BF_CHECK_POW2(n)      BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:162:17: note: in expansion of macro '__BF_CHECK_POW2'
     162 |                 __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
         |                 ^~~~~~~~~~~~~~~
   drivers/gpu/drm/imagination/pvr_device.h:474:10: note: in expansion of macro 'FIELD_PREP_CONST'
     474 |         (prep(DRM_PVR_BVNC_B, b) | \
         |          ^~~~
   drivers/gpu/drm/imagination/pvr_device.h:496:43: note: in expansion of macro '__PVR_PACKED_BVNC'
     496 | #define PVR_PACKED_BVNC_CONST(b, v, n, c) __PVR_PACKED_BVNC(FIELD_PREP_CONST, b, v, n, c)
         |                                           ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/imagination/pvr_device.c:550:14: note: in expansion of macro 'PVR_PACKED_BVNC_CONST'
     550 |         case PVR_PACKED_BVNC_CONST(33, 15, 11, 3):
         |              ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:203:82: error: expression in static assertion is not constant
     203 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                                  ^~~~
   include/linux/build_bug.h:17:9: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
      17 |         __BUILD_BUG_ON_ZERO_MSG(e, ##__VA_ARGS__, #e " is true")
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:160:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     160 |                 BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/imagination/pvr_device.h:474:10: note: in expansion of macro 'FIELD_PREP_CONST'
     474 |         (prep(DRM_PVR_BVNC_B, b) | \
         |          ^~~~
   drivers/gpu/drm/imagination/pvr_device.h:496:43: note: in expansion of macro '__PVR_PACKED_BVNC'
     496 | #define PVR_PACKED_BVNC_CONST(b, v, n, c) __PVR_PACKED_BVNC(FIELD_PREP_CONST, b, v, n, c)
         |                                           ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/imagination/pvr_device.c:551:14: note: in expansion of macro 'PVR_PACKED_BVNC_CONST'
     551 |         case PVR_PACKED_BVNC_CONST(36, 53, 104, 796):
         |              ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:203:82: error: expression in static assertion is not constant
     203 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                                  ^~~~
   include/linux/build_bug.h:17:9: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
      17 |         __BUILD_BUG_ON_ZERO_MSG(e, ##__VA_ARGS__, #e " is true")
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:141:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     141 | #define __BF_CHECK_POW2(n)      BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:162:17: note: in expansion of macro '__BF_CHECK_POW2'
     162 |                 __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
         |                 ^~~~~~~~~~~~~~~
   drivers/gpu/drm/imagination/pvr_device.h:474:10: note: in expansion of macro 'FIELD_PREP_CONST'
     474 |         (prep(DRM_PVR_BVNC_B, b) | \
         |          ^~~~
   drivers/gpu/drm/imagination/pvr_device.h:496:43: note: in expansion of macro '__PVR_PACKED_BVNC'
     496 | #define PVR_PACKED_BVNC_CONST(b, v, n, c) __PVR_PACKED_BVNC(FIELD_PREP_CONST, b, v, n, c)
         |                                           ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/imagination/pvr_device.c:551:14: note: in expansion of macro 'PVR_PACKED_BVNC_CONST'
     551 |         case PVR_PACKED_BVNC_CONST(36, 53, 104, 796):
         |              ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:203:82: error: expression in static assertion is not constant
     203 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                                  ^~~~
   include/linux/build_bug.h:17:9: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
      17 |         __BUILD_BUG_ON_ZERO_MSG(e, ##__VA_ARGS__, #e " is true")
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:160:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     160 |                 BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/imagination/pvr_device.h:474:10: note: in expansion of macro 'FIELD_PREP_CONST'
     474 |         (prep(DRM_PVR_BVNC_B, b) | \
         |          ^~~~
   drivers/gpu/drm/imagination/pvr_device.h:496:43: note: in expansion of macro '__PVR_PACKED_BVNC'
     496 | #define PVR_PACKED_BVNC_CONST(b, v, n, c) __PVR_PACKED_BVNC(FIELD_PREP_CONST, b, v, n, c)
         |                                           ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/imagination/pvr_device.c:554:14: note: in expansion of macro 'PVR_PACKED_BVNC_CONST'
     554 |         case PVR_PACKED_BVNC_CONST(36, 52, 104, 182):
         |              ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:203:82: error: expression in static assertion is not constant
     203 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                                  ^~~~
   include/linux/build_bug.h:17:9: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
      17 |         __BUILD_BUG_ON_ZERO_MSG(e, ##__VA_ARGS__, #e " is true")
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:141:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     141 | #define __BF_CHECK_POW2(n)      BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:162:17: note: in expansion of macro '__BF_CHECK_POW2'
     162 |                 __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
         |                 ^~~~~~~~~~~~~~~
   drivers/gpu/drm/imagination/pvr_device.h:474:10: note: in expansion of macro 'FIELD_PREP_CONST'
     474 |         (prep(DRM_PVR_BVNC_B, b) | \
         |          ^~~~
   drivers/gpu/drm/imagination/pvr_device.h:496:43: note: in expansion of macro '__PVR_PACKED_BVNC'
     496 | #define PVR_PACKED_BVNC_CONST(b, v, n, c) __PVR_PACKED_BVNC(FIELD_PREP_CONST, b, v, n, c)
         |                                           ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/imagination/pvr_device.c:554:14: note: in expansion of macro 'PVR_PACKED_BVNC_CONST'
     554 |         case PVR_PACKED_BVNC_CONST(36, 52, 104, 182):
         |              ^~~~~~~~~~~~~~~~~~~~~


vim +203 include/linux/compiler.h

230fa253df6352 Christian Borntraeger 2014-11-25  199  
cb7380de9e4cbc Kees Cook             2025-02-05  200  #ifdef __CHECKER__
243c90e917f5cf Vincent Mailhol       2025-03-29  201  #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) (0)
cb7380de9e4cbc Kees Cook             2025-02-05  202  #else /* __CHECKER__ */
243c90e917f5cf Vincent Mailhol       2025-03-29 @203  #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
cb7380de9e4cbc Kees Cook             2025-02-05  204  #endif /* __CHECKER__ */
cb7380de9e4cbc Kees Cook             2025-02-05  205  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
