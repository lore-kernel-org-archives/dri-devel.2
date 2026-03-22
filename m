Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91030FC72AE
	for <dri-devel@archiver.kernel.org>; Sun, 22 Mar 2026 08:23:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59FE810E34D;
	Sun, 22 Mar 2026 08:23:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iSTU3hY5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB8310E342;
 Sun, 22 Mar 2026 08:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774167818; x=1805703818;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=mvFNm4DoSBv3lSb1lpfV3/8wYJSyarhU/DcFgPEHNro=;
 b=iSTU3hY5DFhnEfi6gYP8G1tkTCisfZh7gdEdqhci4wCAdQEz2yvx5cUm
 FNvf7kIm+PJ3v3V06AB31GjEF4p1vZ+45A8qkv2F01wtVne8uqfogvEM1
 z7jAqBwlHHezB/vQSyn+pisAdSy5kova3648L5Rssb5oLtoxh1N2JJNPg
 aUS3gOiqt3vkvdxw7MwG8tBy5qUV6cGBh8DvZbKWL+VyncLbckxGDBPwK
 O927ZjL8dmknUkmoUTpshMIgNUBEe1K7ywwkwNCz9oy69IMEPovxhP/eO
 7YAsL260PpWrKcjQWoZ06iN3ivwnxQGn6TG2/GRVAF9aK8kra4HD3dW+3 g==;
X-CSE-ConnectionGUID: js4kEZDyRnmx48uVu64uRg==
X-CSE-MsgGUID: 4QfGaAp2T0288h+Zp9p0Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="85896330"
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; d="scan'208";a="85896330"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2026 01:23:38 -0700
X-CSE-ConnectionGUID: CZzaKRmmTFiuXMUFApyoYg==
X-CSE-MsgGUID: EBil/yrLSryODovLL26ZfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; d="scan'208";a="223700839"
Received: from lkp-server02.sh.intel.com (HELO d7fefbca0d04) ([10.239.97.151])
 by orviesa009.jf.intel.com with ESMTP; 22 Mar 2026 01:23:34 -0700
Received: from kbuild by d7fefbca0d04 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w4E5b-000000001rR-07KS;
 Sun, 22 Mar 2026 08:23:19 +0000
Date: Sun, 22 Mar 2026 16:22:43 +0800
From: kernel test robot <lkp@intel.com>
To: guilhermeivo <guilhermeivob@gmail.com>, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch
Cc: oe-kbuild-all@lists.linux.dev, guilherme.bozi@usp.br,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, guilhermeivo <guilhermeivob@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Deduplicate DCN DDC register assignment
Message-ID: <202603221654.UL8er52L-lkp@intel.com>
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
config: arc-randconfig-001-20260322 (https://download.01.org/0day-ci/archive/20260322/202603221654.UL8er52L-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260322/202603221654.UL8er52L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603221654.UL8er52L-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/hw_factory_dcn32.c:35:
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/../hw_factory_dcn_ddc.h:15:16: warning: 'struct ddc_mask' declared inside parameter list will not be visible outside of this definition or declaration
      const struct ddc_mask *mask)
                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/../hw_factory_dcn_ddc.h:14:16: warning: 'struct ddc_shift' declared inside parameter list will not be visible outside of this definition or declaration
      const struct ddc_shift *shift,
                   ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/../hw_factory_dcn_ddc.h: In function 'dcn_define_ddc_registers_common':
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/../hw_factory_dcn_ddc.h:35:22: error: invalid use of undefined type 'struct ddc_shift'
     ddc->shifts = &shift[en];
                         ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/../hw_factory_dcn_ddc.h:35:22: error: dereferencing pointer to incomplete type 'const struct ddc_shift'
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/../hw_factory_dcn_ddc.h:36:20: error: invalid use of undefined type 'struct ddc_mask'
     ddc->masks = &mask[en];
                       ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/../hw_factory_dcn_ddc.h:36:20: error: dereferencing pointer to incomplete type 'const struct ddc_mask'
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/hw_factory_dcn32.c: In function 'define_ddc_registers':
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/hw_factory_dcn32.c:212:3: error: passing argument 5 of 'dcn_define_ddc_registers_common' from incompatible pointer type [-Werror=incompatible-pointer-types]
      ddc_shift,
      ^~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/hw_factory_dcn32.c:35:
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/../hw_factory_dcn_ddc.h:14:27: note: expected 'const struct ddc_shift *' but argument is of type 'const struct ddc_sh_mask *'
      const struct ddc_shift *shift,
      ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/hw_factory_dcn32.c:213:3: error: passing argument 6 of 'dcn_define_ddc_registers_common' from incompatible pointer type [-Werror=incompatible-pointer-types]
      ddc_mask);
      ^~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/hw_factory_dcn32.c:35:
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/../hw_factory_dcn_ddc.h:15:26: note: expected 'const struct ddc_mask *' but argument is of type 'const struct ddc_sh_mask *'
      const struct ddc_mask *mask)
      ~~~~~~~~~~~~~~~~~~~~~~~^~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/hw_factory_dcn30.c:35:
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/../hw_factory_dcn_ddc.h:15:16: warning: 'struct ddc_mask' declared inside parameter list will not be visible outside of this definition or declaration
      const struct ddc_mask *mask)
                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/../hw_factory_dcn_ddc.h:14:16: warning: 'struct ddc_shift' declared inside parameter list will not be visible outside of this definition or declaration
      const struct ddc_shift *shift,
                   ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/../hw_factory_dcn_ddc.h: In function 'dcn_define_ddc_registers_common':
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/../hw_factory_dcn_ddc.h:35:22: error: invalid use of undefined type 'struct ddc_shift'
     ddc->shifts = &shift[en];
                         ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/../hw_factory_dcn_ddc.h:35:22: error: dereferencing pointer to incomplete type 'const struct ddc_shift'
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/../hw_factory_dcn_ddc.h:36:20: error: invalid use of undefined type 'struct ddc_mask'
     ddc->masks = &mask[en];
                       ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/../hw_factory_dcn_ddc.h:36:20: error: dereferencing pointer to incomplete type 'const struct ddc_mask'
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/hw_factory_dcn30.c: In function 'define_ddc_registers':
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/hw_factory_dcn30.c:208:3: error: passing argument 5 of 'dcn_define_ddc_registers_common' from incompatible pointer type [-Werror=incompatible-pointer-types]
      ddc_shift,
      ^~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/hw_factory_dcn30.c:35:
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/../hw_factory_dcn_ddc.h:14:27: note: expected 'const struct ddc_shift *' but argument is of type 'const struct ddc_sh_mask *'
      const struct ddc_shift *shift,
      ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/hw_factory_dcn30.c:209:3: error: passing argument 6 of 'dcn_define_ddc_registers_common' from incompatible pointer type [-Werror=incompatible-pointer-types]
      ddc_mask);
      ^~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/hw_factory_dcn30.c:35:
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn30/../hw_factory_dcn_ddc.h:15:26: note: expected 'const struct ddc_mask *' but argument is of type 'const struct ddc_sh_mask *'
      const struct ddc_mask *mask)
      ~~~~~~~~~~~~~~~~~~~~~~~^~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/hw_factory_dcn401.c:15:
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/../hw_factory_dcn_ddc.h:15:16: warning: 'struct ddc_mask' declared inside parameter list will not be visible outside of this definition or declaration
      const struct ddc_mask *mask)
                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/../hw_factory_dcn_ddc.h:14:16: warning: 'struct ddc_shift' declared inside parameter list will not be visible outside of this definition or declaration
      const struct ddc_shift *shift,
                   ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/../hw_factory_dcn_ddc.h: In function 'dcn_define_ddc_registers_common':
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/../hw_factory_dcn_ddc.h:35:22: error: invalid use of undefined type 'struct ddc_shift'
     ddc->shifts = &shift[en];
                         ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/../hw_factory_dcn_ddc.h:35:22: error: dereferencing pointer to incomplete type 'const struct ddc_shift'
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/../hw_factory_dcn_ddc.h:36:20: error: invalid use of undefined type 'struct ddc_mask'
     ddc->masks = &mask[en];
                       ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/../hw_factory_dcn_ddc.h:36:20: error: dereferencing pointer to incomplete type 'const struct ddc_mask'
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/hw_factory_dcn401.c: In function 'define_ddc_registers':
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/hw_factory_dcn401.c:203:3: error: passing argument 5 of 'dcn_define_ddc_registers_common' from incompatible pointer type [-Werror=incompatible-pointer-types]
      ddc_shift,
      ^~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/hw_factory_dcn401.c:15:
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/../hw_factory_dcn_ddc.h:14:27: note: expected 'const struct ddc_shift *' but argument is of type 'const struct ddc_sh_mask *'
      const struct ddc_shift *shift,
      ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/hw_factory_dcn401.c:204:3: error: passing argument 6 of 'dcn_define_ddc_registers_common' from incompatible pointer type [-Werror=incompatible-pointer-types]
      ddc_mask);
      ^~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/hw_factory_dcn401.c:15:
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn401/../hw_factory_dcn_ddc.h:15:26: note: expected 'const struct ddc_mask *' but argument is of type 'const struct ddc_sh_mask *'
      const struct ddc_mask *mask)
      ~~~~~~~~~~~~~~~~~~~~~~~^~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/hw_factory_dcn21.c:35:
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/../hw_factory_dcn_ddc.h:15:16: warning: 'struct ddc_mask' declared inside parameter list will not be visible outside of this definition or declaration
      const struct ddc_mask *mask)
                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/../hw_factory_dcn_ddc.h:14:16: warning: 'struct ddc_shift' declared inside parameter list will not be visible outside of this definition or declaration
      const struct ddc_shift *shift,
                   ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/../hw_factory_dcn_ddc.h: In function 'dcn_define_ddc_registers_common':
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/../hw_factory_dcn_ddc.h:35:22: error: invalid use of undefined type 'struct ddc_shift'
     ddc->shifts = &shift[en];
                         ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/../hw_factory_dcn_ddc.h:35:22: error: dereferencing pointer to incomplete type 'const struct ddc_shift'
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/../hw_factory_dcn_ddc.h:36:20: error: invalid use of undefined type 'struct ddc_mask'
     ddc->masks = &mask[en];
                       ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/../hw_factory_dcn_ddc.h:36:20: error: dereferencing pointer to incomplete type 'const struct ddc_mask'
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/hw_factory_dcn21.c: In function 'define_ddc_registers':
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/hw_factory_dcn21.c:179:3: error: passing argument 5 of 'dcn_define_ddc_registers_common' from incompatible pointer type [-Werror=incompatible-pointer-types]
      ddc_shift,
      ^~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/hw_factory_dcn21.c:35:
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/../hw_factory_dcn_ddc.h:14:27: note: expected 'const struct ddc_shift *' but argument is of type 'const struct ddc_sh_mask *'
      const struct ddc_shift *shift,
      ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/hw_factory_dcn21.c:180:3: error: passing argument 6 of 'dcn_define_ddc_registers_common' from incompatible pointer type [-Werror=incompatible-pointer-types]
      ddc_mask);
      ^~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/hw_factory_dcn21.c:35:
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn21/../hw_factory_dcn_ddc.h:15:26: note: expected 'const struct ddc_mask *' but argument is of type 'const struct ddc_sh_mask *'
      const struct ddc_mask *mask)
      ~~~~~~~~~~~~~~~~~~~~~~~^~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/hw_factory_dcn315.c:35:
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/../hw_factory_dcn_ddc.h:15:16: warning: 'struct ddc_mask' declared inside parameter list will not be visible outside of this definition or declaration
      const struct ddc_mask *mask)
                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/../hw_factory_dcn_ddc.h:14:16: warning: 'struct ddc_shift' declared inside parameter list will not be visible outside of this definition or declaration
      const struct ddc_shift *shift,
                   ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/../hw_factory_dcn_ddc.h: In function 'dcn_define_ddc_registers_common':
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/../hw_factory_dcn_ddc.h:35:22: error: invalid use of undefined type 'struct ddc_shift'
     ddc->shifts = &shift[en];
                         ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/../hw_factory_dcn_ddc.h:35:22: error: dereferencing pointer to incomplete type 'const struct ddc_shift'
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/../hw_factory_dcn_ddc.h:36:20: error: invalid use of undefined type 'struct ddc_mask'
     ddc->masks = &mask[en];
                       ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/../hw_factory_dcn_ddc.h:36:20: error: dereferencing pointer to incomplete type 'const struct ddc_mask'
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/hw_factory_dcn315.c: In function 'define_ddc_registers':
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/hw_factory_dcn315.c:200:3: error: passing argument 5 of 'dcn_define_ddc_registers_common' from incompatible pointer type [-Werror=incompatible-pointer-types]
      ddc_shift,
      ^~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/hw_factory_dcn315.c:35:
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/../hw_factory_dcn_ddc.h:14:27: note: expected 'const struct ddc_shift *' but argument is of type 'const struct ddc_sh_mask *'
      const struct ddc_shift *shift,
      ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/hw_factory_dcn315.c:201:3: error: passing argument 6 of 'dcn_define_ddc_registers_common' from incompatible pointer type [-Werror=incompatible-pointer-types]
      ddc_mask);
      ^~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/hw_factory_dcn315.c:35:
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn315/../hw_factory_dcn_ddc.h:15:26: note: expected 'const struct ddc_mask *' but argument is of type 'const struct ddc_sh_mask *'
      const struct ddc_mask *mask)
      ~~~~~~~~~~~~~~~~~~~~~~~^~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/hw_factory_dcn20.c:35:
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/../hw_factory_dcn_ddc.h:15:16: warning: 'struct ddc_mask' declared inside parameter list will not be visible outside of this definition or declaration
      const struct ddc_mask *mask)
                   ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/../hw_factory_dcn_ddc.h:14:16: warning: 'struct ddc_shift' declared inside parameter list will not be visible outside of this definition or declaration
      const struct ddc_shift *shift,
                   ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/../hw_factory_dcn_ddc.h: In function 'dcn_define_ddc_registers_common':
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/../hw_factory_dcn_ddc.h:35:22: error: invalid use of undefined type 'struct ddc_shift'
     ddc->shifts = &shift[en];
                         ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/../hw_factory_dcn_ddc.h:35:22: error: dereferencing pointer to incomplete type 'const struct ddc_shift'
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/../hw_factory_dcn_ddc.h:36:20: error: invalid use of undefined type 'struct ddc_mask'
     ddc->masks = &mask[en];
                       ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/../hw_factory_dcn_ddc.h:36:20: error: dereferencing pointer to incomplete type 'const struct ddc_mask'
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/hw_factory_dcn20.c: In function 'define_ddc_registers':
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/hw_factory_dcn20.c:191:3: error: passing argument 5 of 'dcn_define_ddc_registers_common' from incompatible pointer type [-Werror=incompatible-pointer-types]
      ddc_shift,
      ^~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/hw_factory_dcn20.c:35:
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/../hw_factory_dcn_ddc.h:14:27: note: expected 'const struct ddc_shift *' but argument is of type 'const struct ddc_sh_mask *'
      const struct ddc_shift *shift,
      ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/hw_factory_dcn20.c:192:3: error: passing argument 6 of 'dcn_define_ddc_registers_common' from incompatible pointer type [-Werror=incompatible-pointer-types]
      ddc_mask);
      ^~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/hw_factory_dcn20.c:35:
   drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn20/../hw_factory_dcn_ddc.h:15:26: note: expected 'const struct ddc_mask *' but argument is of type 'const struct ddc_sh_mask *'
      const struct ddc_mask *mask)
      ~~~~~~~~~~~~~~~~~~~~~~~^~~~
   cc1: some warnings being treated as errors


vim +35 drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/dcn32/../hw_factory_dcn_ddc.h

     8	
     9	static inline void dcn_define_ddc_registers_common(
    10			struct hw_gpio_pin *pin,
    11			uint32_t en,
    12			const struct ddc_registers *data_regs,
    13			const struct ddc_registers *clk_regs,
    14			const struct ddc_shift *shift,
    15			const struct ddc_mask *mask)
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
