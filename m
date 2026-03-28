Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E7210F3DD5
	for <dri-devel@archiver.kernel.org>; Sat, 28 Mar 2026 05:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D56910E07D;
	Sat, 28 Mar 2026 05:53:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YZt+6wHK";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45D2310E07D
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 05:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774677237; x=1806213237;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=NovnRvKKD8DcWILq6IiXVqzkoes/2l5rAXk7H72hnKc=;
 b=YZt+6wHK4tKxCNmAs2d/+oiwKZArqyPoh2Kn+fIjGj5lcZ/+ZNwttrUZ
 Q3CsfTb/H33HuC/QpOaVrfsN+yeiyTO1X7T0McmKmPw3dM/E9I0J/a/ZS
 Ut5hP8OXcvG9QZ2d1vqGkrbAvjiN36oW+PCwM7GbUALEqGVcRN5We6g17
 aH8r1zC5VvjTRdfRZsN88FVMEzV6uo+Rj6XLcssErSJPSz+El4L2XhcCm
 EJA66q6X3yJ/cdGy1xfL6pJtjroq+Fc6ZEP4PPcYUKmcuAQwtSYXJ+e/W
 cTMcBIlDWhrTDLfqKRmc3Zq+0HoGF4KT2s3Yg+3/x5uKE6KtLEehTtt7V Q==;
X-CSE-ConnectionGUID: 8ceRu88iTAa1ISm5F62MCA==
X-CSE-MsgGUID: bCC4bQlaQDW3hr0+tn8RbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="75626518"
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; d="scan'208";a="75626518"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 22:53:56 -0700
X-CSE-ConnectionGUID: fiTMB2pTRdaD1Ju/PCFH7Q==
X-CSE-MsgGUID: tNxAW/sFQfSpkfmm/VY48w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; d="scan'208";a="224708881"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
 by orviesa010.jf.intel.com with ESMTP; 27 Mar 2026 22:53:52 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w6McH-00000000B6X-03aN;
 Sat, 28 Mar 2026 05:53:49 +0000
Date: Sat, 28 Mar 2026 13:53:20 +0800
From: kernel test robot <lkp@intel.com>
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alistair Popple <apopple@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, John Hubbard <jhubbard@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Eliot Courtney <ecourtney@nvidia.com>,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH v3] gpu: nova-core: gsp: fix undefined behavior in
 command queue code
Message-ID: <202603281331.1ESuqgfz-lkp@intel.com>
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
config: x86_64-randconfig-102-20260327 (https://download.01.org/0day-ci/archive/20260328/202603281331.1ESuqgfz-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260328/202603281331.1ESuqgfz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603281331.1ESuqgfz-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: rust_build_error
   >>> referenced by build_assert.rs:28 (rust/kernel/build_assert.rs:28)
   >>>               vmlinux.o:(<nova_core::gsp::cmdq::DmaGspMem>::allocate_command)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
