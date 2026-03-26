Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D8710A1E81
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 11:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68CD710E989;
	Thu, 26 Mar 2026 11:46:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="B3kK2qHN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6E2B10E989
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774525589; x=1806061589;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ofJzlAWKgixcp4+wTysf5ew1gWizcxE8ZddUuSZ46FE=;
 b=B3kK2qHNicrnJ4eotRid50udhNbiqGdJ2BCYD7bpRbfwvDG5FS+wyKbN
 Rr0XaWYQXlGqenCijXc1gtaPKAIxd/umh04KDz0kMt3MYiZ5UX347hivm
 uQnW92lKwtWPWn2p5D3KeBXdGel8Lih74xckhS1+hJoXLr4lnsOZ5hpx9
 pXvuX2LZzG45vba2qHX2LpHmVfvu24tegFtOj0ZoRmeq4dy8HeNRCtKiA
 f9Tptqk5vUYox0e+3ey49i5Xxu7ZQmz8rVtCeoliZmF8HbEy00kU+I9Pn
 323hTO9gl+9lB8LZdMAyWnRNyho5e8TO8UTfae/PEHi5tP+BJsf4tThck A==;
X-CSE-ConnectionGUID: Yw11hCiKQk6kdmwZ7lWwFg==
X-CSE-MsgGUID: 1CUid4bQSKu+ceDTgcAXJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75469569"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; d="scan'208";a="75469569"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 04:46:29 -0700
X-CSE-ConnectionGUID: ljPFRTexQ8ye6RJur4lN3A==
X-CSE-MsgGUID: AiWrJJphTGGDsFLxII67gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; d="scan'208";a="229052926"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
 by orviesa003.jf.intel.com with ESMTP; 26 Mar 2026 04:46:22 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w5jAI-000000008oL-3xnO;
 Thu, 26 Mar 2026 11:46:18 +0000
Date: Thu, 26 Mar 2026 19:46:14 +0800
From: kernel test robot <lkp@intel.com>
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Eliot Courtney <ecourtney@nvidia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH v4 08/10] gpu: nova-core: convert falcon registers to
 kernel register macro
Message-ID: <202603261919.gCMgXdPS-lkp@intel.com>
References: <20260325-b4-nova-register-v4-8-bdf172f0f6ca@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325-b4-nova-register-v4-8-bdf172f0f6ca@nvidia.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on dff8302ca1d0e773c90dbeeb05e759f995c95482]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Courbot/gpu-nova-core-introduce-bounded_enum-macro/20260326-064653
base:   dff8302ca1d0e773c90dbeeb05e759f995c95482
patch link:    https://lore.kernel.org/r/20260325-b4-nova-register-v4-8-bdf172f0f6ca%40nvidia.com
patch subject: [PATCH v4 08/10] gpu: nova-core: convert falcon registers to kernel register macro
config: loongarch-randconfig-001-20260326 (https://download.01.org/0day-ci/archive/20260326/202603261919.gCMgXdPS-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260326/202603261919.gCMgXdPS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603261919.gCMgXdPS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: unused import: `num::Bounded`
   --> drivers/gpu/nova-core/falcon.rs:24:5
   |
   24 |     num::Bounded,
   |     ^^^^^^^^^^^^
   |
   = note: `#[warn(unused_imports)]` on by default

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
