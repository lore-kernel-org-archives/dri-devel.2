Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A771410F2867
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 20:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B8D910E061;
	Fri, 27 Mar 2026 20:04:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IatmHvzQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 172A110E061
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 20:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774641856; x=1806177856;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ifxJQiV/BAd1iZRjjlWQBoU0Qh3X3MZNgFKrZ5/Pzpw=;
 b=IatmHvzQX3ItmmLZEno8pgoeD5P79Rw3tUTpT8RLKk7dg5arNk2ozcs/
 8L1yp/Qd9NpW/VGpsK5hLH9uJFrODRr8nRG6MB+UM1gQZKD2e4inq+i9F
 X4KVkkg5kWEQMRsUarAZ4Nn21CSqhTF1jQ+ItoswLdYkervXpUmmrTpKR
 ixsIMu+pLdhU+XjihZgGDFHQk/9oYNj9Dim4BV8ttQTUW4YIzzCsfvwr6
 vlTAzoYz7ED93eyoCIgjQJxFQ6Iy3m8xGic7Fc3o/I9PdtvCei1xMN2jf
 PJrG6/W8tSAdoDmEXX0rcx6LJ5VAitc0vlVmagKQBjf4zXFdxmsAfW9oG A==;
X-CSE-ConnectionGUID: 0CrOAmjFT8aT76khsUvy+A==
X-CSE-MsgGUID: mFoOj2TXTTibPT2lj5JGDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="86799067"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="86799067"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 13:04:15 -0700
X-CSE-ConnectionGUID: 3TRS2icCS8maXwYpSxAeWA==
X-CSE-MsgGUID: h370f/YRRpanq+og1/SoMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="263364334"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
 by orviesa001.jf.intel.com with ESMTP; 27 Mar 2026 13:04:10 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w6DPb-00000000Aft-3iYQ;
 Fri, 27 Mar 2026 20:04:07 +0000
Date: Sat, 28 Mar 2026 04:03:38 +0800
From: kernel test robot <lkp@intel.com>
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alistair Popple <apopple@nvidia.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 John Hubbard <jhubbard@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Eliot Courtney <ecourtney@nvidia.com>,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH v3] gpu: nova-core: gsp: fix undefined behavior in
 command queue code
Message-ID: <202603280326.ucDKVaf2-lkp@intel.com>
References: <20260326-cmdq-ub-fix-v3-1-96af2148ca5c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-cmdq-ub-fix-v3-1-96af2148ca5c@nvidia.com>
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

Hi Alexandre,

kernel test robot noticed the following build errors:

[auto build test ERROR on dff8302ca1d0e773c90dbeeb05e759f995c95482]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Courbot/gpu-nova-core-gsp-fix-undefined-behavior-in-command-queue-code/20260327-003216
base:   dff8302ca1d0e773c90dbeeb05e759f995c95482
patch link:    https://lore.kernel.org/r/20260326-cmdq-ub-fix-v3-1-96af2148ca5c%40nvidia.com
patch subject: [PATCH v3] gpu: nova-core: gsp: fix undefined behavior in command queue code
config: um-randconfig-002-20260327 (https://download.01.org/0day-ci/archive/20260328/202603280326.ucDKVaf2-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 054e11d1a17e5ba88bb1a8ef32fad3346e80b186)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260328/202603280326.ucDKVaf2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603280326.ucDKVaf2-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: warning: .tmp_vmlinux1 has a LOAD segment with RWX permissions
   /usr/bin/ld: drivers/gpu/nova-core/nova_core.o: in function `<core::ops::range::Range<usize> as kernel::ptr::projection::ProjectIndex<[[u8; 4096]]>>::index::{closure#0}':
>> rust/kernel/build_assert.rs:28:(.text+0xfb16): undefined reference to `rust_build_error'
   clang: error: linker command failed with exit code 1 (use -v to see invocation)


vim +28 rust/kernel/build_assert.rs

614724e780f587 Miguel Ojeda 2024-11-23   7  
0f595bab9d1c1a Gary Guo     2022-11-10   8  /// Fails the build if the code path calling `build_error!` can possibly be executed.
0f595bab9d1c1a Gary Guo     2022-11-10   9  ///
0f595bab9d1c1a Gary Guo     2022-11-10  10  /// If the macro is executed in const context, `build_error!` will panic.
0f595bab9d1c1a Gary Guo     2022-11-10  11  /// If the compiler or optimizer cannot guarantee that `build_error!` can never
0f595bab9d1c1a Gary Guo     2022-11-10  12  /// be called, a build error will be triggered.
0f595bab9d1c1a Gary Guo     2022-11-10  13  ///
0f595bab9d1c1a Gary Guo     2022-11-10  14  /// # Examples
0f595bab9d1c1a Gary Guo     2022-11-10  15  ///
0f595bab9d1c1a Gary Guo     2022-11-10  16  /// ```
0f595bab9d1c1a Gary Guo     2022-11-10  17  /// #[inline]
0f595bab9d1c1a Gary Guo     2022-11-10  18  /// fn foo(a: usize) -> usize {
0f595bab9d1c1a Gary Guo     2022-11-10  19  ///     a.checked_add(1).unwrap_or_else(|| build_error!("overflow"))
0f595bab9d1c1a Gary Guo     2022-11-10  20  /// }
0f595bab9d1c1a Gary Guo     2022-11-10  21  ///
0f595bab9d1c1a Gary Guo     2022-11-10  22  /// assert_eq!(foo(usize::MAX - 1), usize::MAX); // OK.
0f595bab9d1c1a Gary Guo     2022-11-10  23  /// // foo(usize::MAX); // Fails to compile.
0f595bab9d1c1a Gary Guo     2022-11-10  24  /// ```
0f595bab9d1c1a Gary Guo     2022-11-10  25  #[macro_export]
0f595bab9d1c1a Gary Guo     2022-11-10  26  macro_rules! build_error {
0f595bab9d1c1a Gary Guo     2022-11-10  27      () => {{
614724e780f587 Miguel Ojeda 2024-11-23 @28          $crate::build_assert::build_error("")
0f595bab9d1c1a Gary Guo     2022-11-10  29      }};
0f595bab9d1c1a Gary Guo     2022-11-10  30      ($msg:expr) => {{
614724e780f587 Miguel Ojeda 2024-11-23  31          $crate::build_assert::build_error($msg)
0f595bab9d1c1a Gary Guo     2022-11-10  32      }};
0f595bab9d1c1a Gary Guo     2022-11-10  33  }
0f595bab9d1c1a Gary Guo     2022-11-10  34  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
