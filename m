Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A29EFC72B0
	for <dri-devel@archiver.kernel.org>; Sun, 22 Mar 2026 07:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B3CF10E280;
	Sun, 22 Mar 2026 07:37:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="D0ZXphyW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1353410E13B;
 Sun, 22 Mar 2026 07:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774165070; x=1805701070;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=IZog6vZfmWjwdWuWG6ls62m9LSRpv6caOuuD1VjHHBY=;
 b=D0ZXphyWKpwrRXz7GW6M3yS+9dpxOTIWqZDtBOXOdhekb5oIjZe592Q4
 0zh323+TkpbNOaCO3Pd0bkgAevqgkJQ8biSm54LNz9YzkYQhmU2O76SkW
 BO3VXf3lJwILmPy+nsShDAqhGAkzCNRew/NaARTChOs13VDEBCHcQpVPk
 WlMULdg3KyLaSbiB3FxgOwHMNBKGkMiYTNQ1m9/IGK0AXI3RgTqUZ8V8L
 CIhgmNfqOujshOU2m0zL71N8q/4/zW8g43i9XyMzjthhR6ljjgUXpbWGl
 BINB0dvXyllIqOVSLAe2qFN2EJH8EaeKd70OdCdiTCDm0e/Fh1LcegM62 A==;
X-CSE-ConnectionGUID: ysl6bTe8TYitAoLzYXr7Cg==
X-CSE-MsgGUID: sz26SvmmRraq3rlXdEZFCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="78794256"
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; d="scan'208";a="78794256"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2026 00:37:50 -0700
X-CSE-ConnectionGUID: DDxc2F1RR5eD4dFWoAxdrQ==
X-CSE-MsgGUID: 7VQEZa6+Qd6c7fNUkmqF2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; d="scan'208";a="228205970"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2)
 ([10.211.93.152])
 by orviesa004.jf.intel.com with ESMTP; 22 Mar 2026 00:37:46 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w4DNX-000000006Jx-2jqd;
 Sun, 22 Mar 2026 07:37:43 +0000
Date: Sun, 22 Mar 2026 08:37:15 +0100
From: kernel test robot <lkp@intel.com>
To: guilhermeivo <guilhermeivob@gmail.com>, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch
Cc: oe-kbuild-all@lists.linux.dev, guilherme.bozi@usp.br,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, guilhermeivo <guilhermeivob@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Deduplicate DCN DDC register assignment
Message-ID: <202603220836.BdJJniAx-lkp@intel.com>
References: <20260321015654.105059-1-guilhermeivob@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321015654.105059-1-guilhermeivob@gmail.com>
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

Hi guilhermeivo,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v7.0-rc4 next-20260320]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/guilhermeivo/drm-amd-display-Deduplicate-DCN-DDC-register-assignment/20260322-024236
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260321015654.105059-1-guilhermeivob%40gmail.com
patch subject: [PATCH] drm/amd/display: Deduplicate DCN DDC register assignment
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260322/202603220836.BdJJniAx-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260322/202603220836.BdJJniAx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603220836.BdJJniAx-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/hw_factory_dcn20.c:35:
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/../hw_factory_dcn_ddc.h:15:30: warning: 'struct ddc_mask' declared inside parameter list will not be visible outside of this definition or declaration
      15 |                 const struct ddc_mask *mask)
         |                              ^~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/../hw_factory_dcn_ddc.h:14:30: warning: 'struct ddc_shift' declared inside parameter list will not be visible outside of this definition or declaration
      14 |                 const struct ddc_shift *shift,
         |                              ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/../hw_factory_dcn_ddc.h: In function 'dcn_define_ddc_registers_common':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/../hw_factory_dcn_ddc.h:35:29: error: invalid use of undefined type 'struct ddc_shift'
      35 |         ddc->shifts = &shift[en];
         |                             ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/../hw_factory_dcn_ddc.h:35:21: error: assignment to 'const struct ddc_sh_mask *' from incompatible pointer type 'const struct ddc_shift *' [-Wincompatible-pointer-types]
      35 |         ddc->shifts = &shift[en];
         |                     ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/../hw_factory_dcn_ddc.h:36:27: error: invalid use of undefined type 'struct ddc_mask'
      36 |         ddc->masks = &mask[en];
         |                           ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/../hw_factory_dcn_ddc.h:36:20: error: assignment to 'const struct ddc_sh_mask *' from incompatible pointer type 'const struct ddc_mask *' [-Wincompatible-pointer-types]
      36 |         ddc->masks = &mask[en];
         |                    ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/hw_factory_dcn20.c: In function 'define_ddc_registers':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/hw_factory_dcn20.c:191:17: error: passing argument 5 of 'dcn_define_ddc_registers_common' from incompatible pointer type [-Wincompatible-pointer-types]
     191 |                 ddc_shift,
         |                 ^~~~~~~~~
         |                 |
         |                 const struct ddc_sh_mask *
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/../hw_factory_dcn_ddc.h:14:41: note: expected 'const struct ddc_shift *' but argument is of type 'const struct ddc_sh_mask *'
      14 |                 const struct ddc_shift *shift,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/hw_factory_dcn20.c:192:17: error: passing argument 6 of 'dcn_define_ddc_registers_common' from incompatible pointer type [-Wincompatible-pointer-types]
     192 |                 ddc_mask);
         |                 ^~~~~~~~
         |                 |
         |                 const struct ddc_sh_mask *
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/../hw_factory_dcn_ddc.h:15:40: note: expected 'const struct ddc_mask *' but argument is of type 'const struct ddc_sh_mask *'
      15 |                 const struct ddc_mask *mask)
         |                 ~~~~~~~~~~~~~~~~~~~~~~~^~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/hw_factory_dcn21.c:35:
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/../hw_factory_dcn_ddc.h:15:30: warning: 'struct ddc_mask' declared inside parameter list will not be visible outside of this definition or declaration
      15 |                 const struct ddc_mask *mask)
         |                              ^~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/../hw_factory_dcn_ddc.h:14:30: warning: 'struct ddc_shift' declared inside parameter list will not be visible outside of this definition or declaration
      14 |                 const struct ddc_shift *shift,
         |                              ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/../hw_factory_dcn_ddc.h: In function 'dcn_define_ddc_registers_common':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/../hw_factory_dcn_ddc.h:35:29: error: invalid use of undefined type 'struct ddc_shift'
      35 |         ddc->shifts = &shift[en];
         |                             ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/../hw_factory_dcn_ddc.h:35:21: error: assignment to 'const struct ddc_sh_mask *' from incompatible pointer type 'const struct ddc_shift *' [-Wincompatible-pointer-types]
      35 |         ddc->shifts = &shift[en];
         |                     ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/../hw_factory_dcn_ddc.h:36:27: error: invalid use of undefined type 'struct ddc_mask'
      36 |         ddc->masks = &mask[en];
         |                           ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/../hw_factory_dcn_ddc.h:36:20: error: assignment to 'const struct ddc_sh_mask *' from incompatible pointer type 'const struct ddc_mask *' [-Wincompatible-pointer-types]
      36 |         ddc->masks = &mask[en];
         |                    ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/hw_factory_dcn21.c: In function 'define_ddc_registers':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/hw_factory_dcn21.c:179:17: error: passing argument 5 of 'dcn_define_ddc_registers_common' from incompatible pointer type [-Wincompatible-pointer-types]
     179 |                 ddc_shift,
         |                 ^~~~~~~~~
         |                 |
         |                 const struct ddc_sh_mask *
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/../hw_factory_dcn_ddc.h:14:41: note: expected 'const struct ddc_shift *' but argument is of type 'const struct ddc_sh_mask *'
      14 |                 const struct ddc_shift *shift,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/hw_factory_dcn21.c:180:17: error: passing argument 6 of 'dcn_define_ddc_registers_common' from incompatible pointer type [-Wincompatible-pointer-types]
     180 |                 ddc_mask);
         |                 ^~~~~~~~
         |                 |
         |                 const struct ddc_sh_mask *
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/../hw_factory_dcn_ddc.h:15:40: note: expected 'const struct ddc_mask *' but argument is of type 'const struct ddc_sh_mask *'
      15 |                 const struct ddc_mask *mask)
         |                 ~~~~~~~~~~~~~~~~~~~~~~~^~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/hw_factory_dcn30.c:35:
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/../hw_factory_dcn_ddc.h:15:30: warning: 'struct ddc_mask' declared inside parameter list will not be visible outside of this definition or declaration
      15 |                 const struct ddc_mask *mask)
         |                              ^~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/../hw_factory_dcn_ddc.h:14:30: warning: 'struct ddc_shift' declared inside parameter list will not be visible outside of this definition or declaration
      14 |                 const struct ddc_shift *shift,
         |                              ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/../hw_factory_dcn_ddc.h: In function 'dcn_define_ddc_registers_common':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/../hw_factory_dcn_ddc.h:35:29: error: invalid use of undefined type 'struct ddc_shift'
      35 |         ddc->shifts = &shift[en];
         |                             ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/../hw_factory_dcn_ddc.h:35:21: error: assignment to 'const struct ddc_sh_mask *' from incompatible pointer type 'const struct ddc_shift *' [-Wincompatible-pointer-types]
      35 |         ddc->shifts = &shift[en];
         |                     ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/../hw_factory_dcn_ddc.h:36:27: error: invalid use of undefined type 'struct ddc_mask'
      36 |         ddc->masks = &mask[en];
         |                           ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/../hw_factory_dcn_ddc.h:36:20: error: assignment to 'const struct ddc_sh_mask *' from incompatible pointer type 'const struct ddc_mask *' [-Wincompatible-pointer-types]
      36 |         ddc->masks = &mask[en];
         |                    ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/hw_factory_dcn30.c: In function 'define_ddc_registers':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/hw_factory_dcn30.c:208:17: error: passing argument 5 of 'dcn_define_ddc_registers_common' from incompatible pointer type [-Wincompatible-pointer-types]
     208 |                 ddc_shift,
         |                 ^~~~~~~~~
         |                 |
         |                 const struct ddc_sh_mask *
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/../hw_factory_dcn_ddc.h:14:41: note: expected 'const struct ddc_shift *' but argument is of type 'const struct ddc_sh_mask *'
      14 |                 const struct ddc_shift *shift,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/hw_factory_dcn30.c:209:17: error: passing argument 6 of 'dcn_define_ddc_registers_common' from incompatible pointer type [-Wincompatible-pointer-types]
     209 |                 ddc_mask);
         |                 ^~~~~~~~
         |                 |
         |                 const struct ddc_sh_mask *
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/../hw_factory_dcn_ddc.h:15:40: note: expected 'const struct ddc_mask *' but argument is of type 'const struct ddc_sh_mask *'
      15 |                 const struct ddc_mask *mask)
         |                 ~~~~~~~~~~~~~~~~~~~~~~~^~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/hw_factory_dcn315.c:35:
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/../hw_factory_dcn_ddc.h:15:30: warning: 'struct ddc_mask' declared inside parameter list will not be visible outside of this definition or declaration
      15 |                 const struct ddc_mask *mask)
         |                              ^~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/../hw_factory_dcn_ddc.h:14:30: warning: 'struct ddc_shift' declared inside parameter list will not be visible outside of this definition or declaration
      14 |                 const struct ddc_shift *shift,
         |                              ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/../hw_factory_dcn_ddc.h: In function 'dcn_define_ddc_registers_common':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/../hw_factory_dcn_ddc.h:35:29: error: invalid use of undefined type 'struct ddc_shift'
      35 |         ddc->shifts = &shift[en];
         |                             ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/../hw_factory_dcn_ddc.h:35:21: error: assignment to 'const struct ddc_sh_mask *' from incompatible pointer type 'const struct ddc_shift *' [-Wincompatible-pointer-types]
      35 |         ddc->shifts = &shift[en];
         |                     ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/../hw_factory_dcn_ddc.h:36:27: error: invalid use of undefined type 'struct ddc_mask'
      36 |         ddc->masks = &mask[en];
         |                           ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/../hw_factory_dcn_ddc.h:36:20: error: assignment to 'const struct ddc_sh_mask *' from incompatible pointer type 'const struct ddc_mask *' [-Wincompatible-pointer-types]
      36 |         ddc->masks = &mask[en];
         |                    ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/hw_factory_dcn315.c: In function 'define_ddc_registers':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/hw_factory_dcn315.c:200:17: error: passing argument 5 of 'dcn_define_ddc_registers_common' from incompatible pointer type [-Wincompatible-pointer-types]
     200 |                 ddc_shift,
         |                 ^~~~~~~~~
         |                 |
         |                 const struct ddc_sh_mask *
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/../hw_factory_dcn_ddc.h:14:41: note: expected 'const struct ddc_shift *' but argument is of type 'const struct ddc_sh_mask *'
      14 |                 const struct ddc_shift *shift,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/hw_factory_dcn315.c:201:17: error: passing argument 6 of 'dcn_define_ddc_registers_common' from incompatible pointer type [-Wincompatible-pointer-types]
     201 |                 ddc_mask);
         |                 ^~~~~~~~
         |                 |
         |                 const struct ddc_sh_mask *
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/../hw_factory_dcn_ddc.h:15:40: note: expected 'const struct ddc_mask *' but argument is of type 'const struct ddc_sh_mask *'
      15 |                 const struct ddc_mask *mask)
         |                 ~~~~~~~~~~~~~~~~~~~~~~~^~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/hw_factory_dcn32.c:35:
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/../hw_factory_dcn_ddc.h:15:30: warning: 'struct ddc_mask' declared inside parameter list will not be visible outside of this definition or declaration
      15 |                 const struct ddc_mask *mask)
         |                              ^~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/../hw_factory_dcn_ddc.h:14:30: warning: 'struct ddc_shift' declared inside parameter list will not be visible outside of this definition or declaration
      14 |                 const struct ddc_shift *shift,
         |                              ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/../hw_factory_dcn_ddc.h: In function 'dcn_define_ddc_registers_common':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/../hw_factory_dcn_ddc.h:35:29: error: invalid use of undefined type 'struct ddc_shift'
      35 |         ddc->shifts = &shift[en];
         |                             ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/../hw_factory_dcn_ddc.h:35:21: error: assignment to 'const struct ddc_sh_mask *' from incompatible pointer type 'const struct ddc_shift *' [-Wincompatible-pointer-types]
      35 |         ddc->shifts = &shift[en];
         |                     ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/../hw_factory_dcn_ddc.h:36:27: error: invalid use of undefined type 'struct ddc_mask'
      36 |         ddc->masks = &mask[en];
         |                           ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/../hw_factory_dcn_ddc.h:36:20: error: assignment to 'const struct ddc_sh_mask *' from incompatible pointer type 'const struct ddc_mask *' [-Wincompatible-pointer-types]
      36 |         ddc->masks = &mask[en];
         |                    ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/hw_factory_dcn32.c: In function 'define_ddc_registers':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/hw_factory_dcn32.c:212:17: error: passing argument 5 of 'dcn_define_ddc_registers_common' from incompatible pointer type [-Wincompatible-pointer-types]
     212 |                 ddc_shift,
         |                 ^~~~~~~~~
         |                 |
         |                 const struct ddc_sh_mask *
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/../hw_factory_dcn_ddc.h:14:41: note: expected 'const struct ddc_shift *' but argument is of type 'const struct ddc_sh_mask *'
      14 |                 const struct ddc_shift *shift,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/hw_factory_dcn32.c:213:17: error: passing argument 6 of 'dcn_define_ddc_registers_common' from incompatible pointer type [-Wincompatible-pointer-types]
     213 |                 ddc_mask);
         |                 ^~~~~~~~
         |                 |
         |                 const struct ddc_sh_mask *
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/../hw_factory_dcn_ddc.h:15:40: note: expected 'const struct ddc_mask *' but argument is of type 'const struct ddc_sh_mask *'
      15 |                 const struct ddc_mask *mask)
         |                 ~~~~~~~~~~~~~~~~~~~~~~~^~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/hw_factory_dcn401.c:15:
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/../hw_factory_dcn_ddc.h:15:30: warning: 'struct ddc_mask' declared inside parameter list will not be visible outside of this definition or declaration
      15 |                 const struct ddc_mask *mask)
         |                              ^~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/../hw_factory_dcn_ddc.h:14:30: warning: 'struct ddc_shift' declared inside parameter list will not be visible outside of this definition or declaration
      14 |                 const struct ddc_shift *shift,
         |                              ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/../hw_factory_dcn_ddc.h: In function 'dcn_define_ddc_registers_common':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/../hw_factory_dcn_ddc.h:35:29: error: invalid use of undefined type 'struct ddc_shift'
      35 |         ddc->shifts = &shift[en];
         |                             ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/../hw_factory_dcn_ddc.h:35:21: error: assignment to 'const struct ddc_sh_mask *' from incompatible pointer type 'const struct ddc_shift *' [-Wincompatible-pointer-types]
      35 |         ddc->shifts = &shift[en];
         |                     ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/../hw_factory_dcn_ddc.h:36:27: error: invalid use of undefined type 'struct ddc_mask'
      36 |         ddc->masks = &mask[en];
         |                           ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/../hw_factory_dcn_ddc.h:36:20: error: assignment to 'const struct ddc_sh_mask *' from incompatible pointer type 'const struct ddc_mask *' [-Wincompatible-pointer-types]
      36 |         ddc->masks = &mask[en];
         |                    ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/hw_factory_dcn401.c: In function 'define_ddc_registers':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/hw_factory_dcn401.c:203:17: error: passing argument 5 of 'dcn_define_ddc_registers_common' from incompatible pointer type [-Wincompatible-pointer-types]
     203 |                 ddc_shift,
         |                 ^~~~~~~~~
         |                 |
         |                 const struct ddc_sh_mask *
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/../hw_factory_dcn_ddc.h:14:41: note: expected 'const struct ddc_shift *' but argument is of type 'const struct ddc_sh_mask *'
      14 |                 const struct ddc_shift *shift,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/hw_factory_dcn401.c:204:17: error: passing argument 6 of 'dcn_define_ddc_registers_common' from incompatible pointer type [-Wincompatible-pointer-types]
     204 |                 ddc_mask);
         |                 ^~~~~~~~
         |                 |
         |                 const struct ddc_sh_mask *
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/../hw_factory_dcn_ddc.h:15:40: note: expected 'const struct ddc_mask *' but argument is of type 'const struct ddc_sh_mask *'
      15 |                 const struct ddc_mask *mask)
         |                 ~~~~~~~~~~~~~~~~~~~~~~~^~~~


vim +35 drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/../hw_factory_dcn_ddc.h

     8	
     9	static inline void dcn_define_ddc_registers_common(
    10			struct hw_gpio_pin *pin,
    11			uint32_t en,
    12			const struct ddc_registers *data_regs,
    13			const struct ddc_registers *clk_regs,
  > 14			const struct ddc_shift *shift,
  > 15			const struct ddc_mask *mask)
    16	{
    17		struct hw_ddc *ddc = HW_DDC_FROM_BASE(pin);
    18	
    19		switch (pin->id) {
    20		case GPIO_ID_DDC_DATA:
    21			ddc->regs = &data_regs[en];
    22			ddc->base.regs = &data_regs[en].gpio;
    23			break;
    24	
    25		case GPIO_ID_DDC_CLOCK:
    26			ddc->regs = &clk_regs[en];
    27			ddc->base.regs = &clk_regs[en].gpio;
    28			break;
    29	
    30		default:
    31			ASSERT_CRITICAL(false);
    32			return;
    33		}
    34	
  > 35		ddc->shifts = &shift[en];
  > 36		ddc->masks = &mask[en];
    37	}
    38	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
