Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E288CDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 693AE10EF17;
	Wed, 24 Jun 2026 13:04:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cqwoBYv1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D81A10EF17
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 13:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782306244; x=1813842244;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kiTOvM/hNnyxlhusTmCns63nmkO4Be0o5SF6htiXnYA=;
 b=cqwoBYv100RYfOEyvonpARmQfwN8NaAp7yc1nEaaiFJToUxUwBaTndrI
 /QebB190m/hAgiejIeSqqnwLjWsY22O3tNJFMiugzYU2NmbDBzZQ85x2l
 ClBuw6mRdIlPUzXtDJlnhv1HHNPBk07eCBIyoTyT/wzFdSkDCMwBh6Efr
 YCdMBnDCThXUqaxNfA+i53Bi1wF0eycBvV5fUoUSr3WMNAZL0ZGjBi2DU
 MSZANNl4RGJQhgkQNxetdRpj3CzJS1W3uMdAtA2MKLtZN4pd9u2ugwru5
 BI2GVAbadZI64fg5EeqHLJXUeXAVcgU4uMSAYUGr4XvWPTMXwn/6/2md5 g==;
X-CSE-ConnectionGUID: U6OK5FndRDupw3tPYfAMDA==
X-CSE-MsgGUID: eizGUk+8RGOOGgbBQuApxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="85623772"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="85623772"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 06:04:03 -0700
X-CSE-ConnectionGUID: 9ZERmlspSMWcak+c+6G67A==
X-CSE-MsgGUID: VKKqMC//ShymcweiQMaEEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="287974169"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
 by orviesa001.jf.intel.com with ESMTP; 24 Jun 2026 06:04:00 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wcNGn-000000003N3-0Z6f;
 Wed, 24 Jun 2026 13:03:57 +0000
Date: Wed, 24 Jun 2026 21:02:58 +0800
From: kernel test robot <lkp@intel.com>
To: Joyeta Modak <joyetamdk@gmail.com>, andy@kernel.org,
 gregkh@linuxfoundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Joyeta Modak <joyetamdk@gmail.com>
Subject: Re: [PATCH] staging: fbtft: use ARRAY_SIZE() in NUMARGS macro
Message-ID: <202606242026.MmYHG2FZ-lkp@intel.com>
References: <20260624073804.4391-1-joyetamdk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624073804.4391-1-joyetamdk@gmail.com>
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

Hi Joyeta,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Joyeta-Modak/staging-fbtft-use-ARRAY_SIZE-in-NUMARGS-macro/20260624-153912
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20260624073804.4391-1-joyetamdk%40gmail.com
patch subject: [PATCH] staging: fbtft: use ARRAY_SIZE() in NUMARGS macro
config: um-randconfig-002-20260624 (https://download.01.org/0day-ci/archive/20260624/202606242026.MmYHG2FZ-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260624/202606242026.MmYHG2FZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606242026.MmYHG2FZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/staging/fbtft/fb_ili9486.c:13:
   In file included from drivers/staging/fbtft/fbtft.h:8:
   In file included from include/linux/fb.h:5:
   In file included from include/uapi/linux/fb.h:6:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:27:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:24:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/staging/fbtft/fb_ili9486.c:51:11: error: initializer element is not a compile-time constant
      51 |                           0x80 | (par->bgr << 3));
         |                           ~~~~~^~~~~~~~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:240:47: note: expanded from macro 'write_reg'
     240 |         ((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))
         |                                                      ^~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:237:43: note: expanded from macro 'NUMARGS'
     237 | #define NUMARGS(...)  ARRAY_SIZE(((int[]){__VA_ARGS__}))
         |                                           ^~~~~~~~~~~
   include/linux/array_size.h:11:75: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                                           ^~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler.h:204:39: note: expanded from macro '__is_array'
     204 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                ^
   include/linux/compiler_types.h:610:63: note: expanded from macro '__same_type'
     610 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                               ^
   include/linux/compiler.h:200:84: note: expanded from macro '__BUILD_BUG_ON_ZERO_MSG'
     200 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                                    ^
   drivers/staging/fbtft/fb_ili9486.c:55:11: error: initializer element is not a compile-time constant
      55 |                           0x20 | (par->bgr << 3));
         |                           ~~~~~^~~~~~~~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:240:47: note: expanded from macro 'write_reg'
     240 |         ((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))
         |                                                      ^~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:237:43: note: expanded from macro 'NUMARGS'
     237 | #define NUMARGS(...)  ARRAY_SIZE(((int[]){__VA_ARGS__}))
         |                                           ^~~~~~~~~~~
   include/linux/array_size.h:11:75: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                                           ^~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler.h:204:39: note: expanded from macro '__is_array'
     204 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                ^
   include/linux/compiler_types.h:610:63: note: expanded from macro '__same_type'
     610 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                               ^
   include/linux/compiler.h:200:84: note: expanded from macro '__BUILD_BUG_ON_ZERO_MSG'
     200 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                                    ^
   drivers/staging/fbtft/fb_ili9486.c:59:11: error: initializer element is not a compile-time constant
      59 |                           0x40 | (par->bgr << 3));
         |                           ~~~~~^~~~~~~~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:240:47: note: expanded from macro 'write_reg'
     240 |         ((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))
         |                                                      ^~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:237:43: note: expanded from macro 'NUMARGS'
     237 | #define NUMARGS(...)  ARRAY_SIZE(((int[]){__VA_ARGS__}))
         |                                           ^~~~~~~~~~~
   include/linux/array_size.h:11:75: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                                           ^~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler.h:204:39: note: expanded from macro '__is_array'
     204 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                ^
   include/linux/compiler_types.h:610:63: note: expanded from macro '__same_type'
     610 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                               ^
   include/linux/compiler.h:200:84: note: expanded from macro '__BUILD_BUG_ON_ZERO_MSG'
     200 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                                    ^
   drivers/staging/fbtft/fb_ili9486.c:63:11: error: initializer element is not a compile-time constant
      63 |                           0xE0 | (par->bgr << 3));
         |                           ~~~~~^~~~~~~~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:240:47: note: expanded from macro 'write_reg'
     240 |         ((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))
         |                                                      ^~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:237:43: note: expanded from macro 'NUMARGS'
     237 | #define NUMARGS(...)  ARRAY_SIZE(((int[]){__VA_ARGS__}))
         |                                           ^~~~~~~~~~~
   include/linux/array_size.h:11:75: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                                           ^~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler.h:204:39: note: expanded from macro '__is_array'
     204 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                ^
   include/linux/compiler_types.h:610:63: note: expanded from macro '__same_type'
     610 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                               ^
   include/linux/compiler.h:200:84: note: expanded from macro '__BUILD_BUG_ON_ZERO_MSG'
     200 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                                    ^
   1 warning and 4 errors generated.
--
   In file included from drivers/staging/fbtft/fbtft-core.c:18:
   In file included from include/linux/fb.h:5:
   In file included from include/uapi/linux/fb.h:6:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:27:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:24:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/staging/fbtft/fbtft-core.c:204:15: error: initializer element is not a compile-time constant
     204 |                   (xs >> 8) & 0xFF, xs & 0xFF, (xe >> 8) & 0xFF, xe & 0xFF);
         |                   ~~~~~~~~~~^~~~~~
   drivers/staging/fbtft/fbtft.h:240:47: note: expanded from macro 'write_reg'
     240 |         ((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))
         |                                                      ^~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:237:43: note: expanded from macro 'NUMARGS'
     237 | #define NUMARGS(...)  ARRAY_SIZE(((int[]){__VA_ARGS__}))
         |                                           ^~~~~~~~~~~
   include/linux/array_size.h:11:75: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                                           ^~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler.h:204:39: note: expanded from macro '__is_array'
     204 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                ^
   include/linux/compiler_types.h:610:63: note: expanded from macro '__same_type'
     610 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                               ^
   include/linux/compiler.h:200:84: note: expanded from macro '__BUILD_BUG_ON_ZERO_MSG'
     200 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                                    ^
   drivers/staging/fbtft/fbtft-core.c:207:15: error: initializer element is not a compile-time constant
     207 |                   (ys >> 8) & 0xFF, ys & 0xFF, (ye >> 8) & 0xFF, ye & 0xFF);
         |                   ~~~~~~~~~~^~~~~~
   drivers/staging/fbtft/fbtft.h:240:47: note: expanded from macro 'write_reg'
     240 |         ((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))
         |                                                      ^~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:237:43: note: expanded from macro 'NUMARGS'
     237 | #define NUMARGS(...)  ARRAY_SIZE(((int[]){__VA_ARGS__}))
         |                                           ^~~~~~~~~~~
   include/linux/array_size.h:11:75: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                                           ^~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler.h:204:39: note: expanded from macro '__is_array'
     204 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                ^
   include/linux/compiler_types.h:610:63: note: expanded from macro '__same_type'
     610 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                               ^
   include/linux/compiler.h:200:84: note: expanded from macro '__BUILD_BUG_ON_ZERO_MSG'
     200 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                                    ^
   1 warning and 2 errors generated.
--
   In file included from drivers/staging/fbtft/fb_upd161704.c:17:
   In file included from drivers/staging/fbtft/fbtft.h:8:
   In file included from include/linux/fb.h:5:
   In file included from include/uapi/linux/fb.h:6:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:27:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:24:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/staging/fbtft/fb_upd161704.c:119:26: error: initializer element is not a compile-time constant
     119 |                 write_reg(par, 0x0006, xs);
         |                                        ^~
   drivers/staging/fbtft/fbtft.h:240:47: note: expanded from macro 'write_reg'
     240 |         ((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))
         |                                                      ^~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:237:43: note: expanded from macro 'NUMARGS'
     237 | #define NUMARGS(...)  ARRAY_SIZE(((int[]){__VA_ARGS__}))
         |                                           ^~~~~~~~~~~
   include/linux/array_size.h:11:75: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                                           ^~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler.h:204:39: note: expanded from macro '__is_array'
     204 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                ^
   include/linux/compiler_types.h:610:63: note: expanded from macro '__same_type'
     610 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                               ^
   include/linux/compiler.h:200:84: note: expanded from macro '__BUILD_BUG_ON_ZERO_MSG'
     200 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                                    ^
   drivers/staging/fbtft/fb_upd161704.c:120:26: error: initializer element is not a compile-time constant
     120 |                 write_reg(par, 0x0007, ys);
         |                                        ^~
   drivers/staging/fbtft/fbtft.h:240:47: note: expanded from macro 'write_reg'
     240 |         ((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))
         |                                                      ^~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:237:43: note: expanded from macro 'NUMARGS'
     237 | #define NUMARGS(...)  ARRAY_SIZE(((int[]){__VA_ARGS__}))
         |                                           ^~~~~~~~~~~
   include/linux/array_size.h:11:75: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                                           ^~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler.h:204:39: note: expanded from macro '__is_array'
     204 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                ^
   include/linux/compiler_types.h:610:63: note: expanded from macro '__same_type'
     610 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                               ^
   include/linux/compiler.h:200:84: note: expanded from macro '__BUILD_BUG_ON_ZERO_MSG'
     200 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                                    ^
   drivers/staging/fbtft/fb_upd161704.c:123:36: error: initializer element is not a compile-time constant
     123 |                 write_reg(par, 0x0006, WIDTH - 1 - xs);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/staging/fbtft/fbtft.h:240:47: note: expanded from macro 'write_reg'
     240 |         ((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))
         |                                              ~~~~~~~~^~~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:237:43: note: expanded from macro 'NUMARGS'
     237 | #define NUMARGS(...)  ARRAY_SIZE(((int[]){__VA_ARGS__}))
         |                       ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
   include/linux/array_size.h:11:75: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ~~~~~~~~~~~~~~~~^~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler.h:204:39: note: expanded from macro '__is_array'
     204 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                ^
   include/linux/compiler_types.h:610:63: note: expanded from macro '__same_type'
     610 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                               ^
   include/linux/compiler.h:200:84: note: expanded from macro '__BUILD_BUG_ON_ZERO_MSG'
     200 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                                    ^
   drivers/staging/fbtft/fb_upd161704.c:124:37: error: initializer element is not a compile-time constant
     124 |                 write_reg(par, 0x0007, HEIGHT - 1 - ys);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/staging/fbtft/fbtft.h:240:47: note: expanded from macro 'write_reg'
     240 |         ((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))
         |                                              ~~~~~~~~^~~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:237:43: note: expanded from macro 'NUMARGS'
     237 | #define NUMARGS(...)  ARRAY_SIZE(((int[]){__VA_ARGS__}))
         |                       ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
   include/linux/array_size.h:11:75: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ~~~~~~~~~~~~~~~~^~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler.h:204:39: note: expanded from macro '__is_array'
     204 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                ^
   include/linux/compiler_types.h:610:63: note: expanded from macro '__same_type'
     610 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                               ^
   include/linux/compiler.h:200:84: note: expanded from macro '__BUILD_BUG_ON_ZERO_MSG'
     200 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                                    ^
   drivers/staging/fbtft/fb_upd161704.c:127:36: error: initializer element is not a compile-time constant
     127 |                 write_reg(par, 0x0006, WIDTH - 1 - ys);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/staging/fbtft/fbtft.h:240:47: note: expanded from macro 'write_reg'
     240 |         ((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))
         |                                              ~~~~~~~~^~~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:237:43: note: expanded from macro 'NUMARGS'
     237 | #define NUMARGS(...)  ARRAY_SIZE(((int[]){__VA_ARGS__}))
         |                       ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
   include/linux/array_size.h:11:75: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ~~~~~~~~~~~~~~~~^~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
--
   In file included from drivers/staging/fbtft/fb_pcd8544.c:15:
   In file included from include/linux/spi/spi.h:17:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/staging/fbtft/fb_pcd8544.c:53:17: error: initializer element is not a compile-time constant
      53 |         write_reg(par, 0x04 | (tc & 0x3));
         |                        ^~~~~~~~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:240:47: note: expanded from macro 'write_reg'
     240 |         ((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))
         |                                                      ^~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:237:43: note: expanded from macro 'NUMARGS'
     237 | #define NUMARGS(...)  ARRAY_SIZE(((int[]){__VA_ARGS__}))
         |                                           ^~~~~~~~~~~
   include/linux/array_size.h:11:75: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                                           ^~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler.h:204:39: note: expanded from macro '__is_array'
     204 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                ^
   include/linux/compiler_types.h:610:63: note: expanded from macro '__same_type'
     610 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                               ^
   include/linux/compiler.h:200:84: note: expanded from macro '__BUILD_BUG_ON_ZERO_MSG'
     200 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                                    ^
   drivers/staging/fbtft/fb_pcd8544.c:63:17: error: initializer element is not a compile-time constant
      63 |         write_reg(par, 0x10 | (bs & 0x7));
         |                        ^~~~~~~~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:240:47: note: expanded from macro 'write_reg'
     240 |         ((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))
         |                                                      ^~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:237:43: note: expanded from macro 'NUMARGS'
     237 | #define NUMARGS(...)  ARRAY_SIZE(((int[]){__VA_ARGS__}))
         |                                           ^~~~~~~~~~~
   include/linux/array_size.h:11:75: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                                           ^~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler.h:204:39: note: expanded from macro '__is_array'
     204 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                ^
   include/linux/compiler_types.h:610:63: note: expanded from macro '__same_type'
     610 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                               ^
   include/linux/compiler.h:200:84: note: expanded from macro '__BUILD_BUG_ON_ZERO_MSG'
     200 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                                    ^
   drivers/staging/fbtft/fb_pcd8544.c:137:17: error: initializer element is not a compile-time constant
     137 |         write_reg(par, 0x80 | curves[0]);
         |                        ^~~~~~~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:240:47: note: expanded from macro 'write_reg'
     240 |         ((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))
         |                                                      ^~~~~~~~~~~
   drivers/staging/fbtft/fbtft.h:237:43: note: expanded from macro 'NUMARGS'
     237 | #define NUMARGS(...)  ARRAY_SIZE(((int[]){__VA_ARGS__}))
         |                                           ^~~~~~~~~~~
   include/linux/array_size.h:11:75: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                                           ^~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler.h:204:39: note: expanded from macro '__is_array'
     204 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                ^
   include/linux/compiler_types.h:610:63: note: expanded from macro '__same_type'
     610 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                               ^
   include/linux/compiler.h:200:84: note: expanded from macro '__BUILD_BUG_ON_ZERO_MSG'
     200 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                                    ^
   1 warning and 3 errors generated.
..


vim +51 drivers/staging/fbtft/fb_ili9486.c

8d64b032aa71963 Thomas Petazzoni 2014-12-31  45  
8d64b032aa71963 Thomas Petazzoni 2014-12-31  46  static int set_var(struct fbtft_par *par)
8d64b032aa71963 Thomas Petazzoni 2014-12-31  47  {
8d64b032aa71963 Thomas Petazzoni 2014-12-31  48  	switch (par->info->var.rotate) {
8d64b032aa71963 Thomas Petazzoni 2014-12-31  49  	case 0:
49475ed0cbb5623 Priit Laes       2015-12-20  50  		write_reg(par, MIPI_DCS_SET_ADDRESS_MODE,
49475ed0cbb5623 Priit Laes       2015-12-20 @51  			  0x80 | (par->bgr << 3));
8d64b032aa71963 Thomas Petazzoni 2014-12-31  52  		break;
8d64b032aa71963 Thomas Petazzoni 2014-12-31  53  	case 90:
49475ed0cbb5623 Priit Laes       2015-12-20  54  		write_reg(par, MIPI_DCS_SET_ADDRESS_MODE,
49475ed0cbb5623 Priit Laes       2015-12-20  55  			  0x20 | (par->bgr << 3));
8d64b032aa71963 Thomas Petazzoni 2014-12-31  56  		break;
8d64b032aa71963 Thomas Petazzoni 2014-12-31  57  	case 180:
49475ed0cbb5623 Priit Laes       2015-12-20  58  		write_reg(par, MIPI_DCS_SET_ADDRESS_MODE,
49475ed0cbb5623 Priit Laes       2015-12-20  59  			  0x40 | (par->bgr << 3));
8d64b032aa71963 Thomas Petazzoni 2014-12-31  60  		break;
8d64b032aa71963 Thomas Petazzoni 2014-12-31  61  	case 270:
49475ed0cbb5623 Priit Laes       2015-12-20  62  		write_reg(par, MIPI_DCS_SET_ADDRESS_MODE,
49475ed0cbb5623 Priit Laes       2015-12-20  63  			  0xE0 | (par->bgr << 3));
8d64b032aa71963 Thomas Petazzoni 2014-12-31  64  		break;
8d64b032aa71963 Thomas Petazzoni 2014-12-31  65  	default:
8d64b032aa71963 Thomas Petazzoni 2014-12-31  66  		break;
8d64b032aa71963 Thomas Petazzoni 2014-12-31  67  	}
8d64b032aa71963 Thomas Petazzoni 2014-12-31  68  
8d64b032aa71963 Thomas Petazzoni 2014-12-31  69  	return 0;
8d64b032aa71963 Thomas Petazzoni 2014-12-31  70  }
8d64b032aa71963 Thomas Petazzoni 2014-12-31  71  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
