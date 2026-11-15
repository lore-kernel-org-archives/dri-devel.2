Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79C0606A323
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 23:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GKPa0Nw5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14ABD10E031;
	Sun, 15 Nov 2026 23:07:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A51810E031
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 23:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794784061; x=1826320061;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vBsIBFjd51c+RtM9uJ3edtPSSE5WdmPMwKgKgqr5zaI=;
 b=GKPa0Nw5jc4RE23sFO0EzH7zRvFJGIkoA3BQZ+ZVapFKRkk/5+KGxqDD
 moPuofS5PFudx6ZGA03Xq/MwYjv7ChA9hOof85xb+pRKgxJI/GZXbUweY
 gStnsZ9XYr1cUWmKRYyPI5GtD+l4wSCLwIje+aFdOzy4sbHK9YAx+oN+e
 jcmQVwA0MjowdoIq1MMrMi7B+gb93feJs/4mu7qQEZ3TO7TMtPxes/hJu
 x/dMtp/AH6npKmUeKxDYjv6s+VUEm0HZwy5afR9LzL4OQQlbOF8gTCF82
 PZ/vlFpMp2xehYMntcvwvX3VxGd0m3Q/dk/Be0/Q+Xm3qxOUfsF28+ovO A==;
X-CSE-ConnectionGUID: IEJAsBG8SECngitJR4IQVQ==
X-CSE-MsgGUID: 1bbjduYIRbCoXE2gBFPenw==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3507856"
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="3507856"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 15:07:40 -0800
X-CSE-ConnectionGUID: T0clSzB4Q+qj2I5XBNZXdA==
X-CSE-MsgGUID: oOzTsgjDSVa3mPwyHThFlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="9481327"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa001.jf.intel.com with ESMTP; 15 Nov 2026 15:07:36 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xSjJt-000000017Qg-0RDt;
 Sun, 15 Nov 2026 23:07:33 +0000
Date: Mon, 16 Nov 2026 07:07:09 +0800
From: kernel test robot <lkp@intel.com>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, dakr@kernel.org,
 aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 work@onurozkan.dev, boris.brezillon@collabora.com
Subject: Re: [PATCH v8 2/3] drm/tyr: add GPU reset infrastructure
Message-ID: <202611160607.TNmf1CMV-lkp@intel.com>
References: <20261113-tyr-reset-impl-v8-2-2ee298ac9808@onurozkan.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113-tyr-reset-impl-v8-2-2ee298ac9808@onurozkan.dev>
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

Hi Onur,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on daeinki-drm-exynos/exynos-drm-next drm/drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes drm-tip/drm-tip linus/master v7.4-rc2 next-20261113]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Onur-zkan/drm-tyr-add-GPU-reset-infrastructure/20261113-173227
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20261113-tyr-reset-impl-v8-2-2ee298ac9808%40onurozkan.dev
patch subject: [PATCH v8 2/3] drm/tyr: add GPU reset infrastructure
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20261116/202611160607.TNmf1CMV-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261116/202611160607.TNmf1CMV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611160607.TNmf1CMV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0432]: unresolved imports `kernel::workqueue::OwnedQueue`, `kernel::workqueue::ScopedWork`, `kernel::workqueue::ScopedWorkItem`
   --> drivers/gpu/drm/tyr/reset.rs:49:9
   |
   49 |         OwnedQueue,
   |         ^^^^^^^^^^ no `OwnedQueue` in `workqueue`
   50 |         Queue,
   51 |         ScopedWork,
   |         ^^^^^^^^^^ no `ScopedWork` in `workqueue`
   52 |         ScopedWorkItem, //
   |         ^^^^^^^^^^^^^^ no `ScopedWorkItem` in `workqueue`
--
>> error[E0433]: cannot find `new_scoped_work` in `kernel`
   --> drivers/gpu/drm/tyr/reset.rs:185:25
   |
   185 |                 kernel::new_scoped_work!("tyr::reset", Controller::new(pdev, iomem))
   |                         ^^^^^^^^^^^^^^^ could not find `new_scoped_work` in `kernel`

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
