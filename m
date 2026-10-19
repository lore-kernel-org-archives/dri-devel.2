Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D028D606A319
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 20:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E38UPn2r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3757210E464;
	Mon, 19 Oct 2026 20:46:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B06C10E464;
 Mon, 19 Oct 2026 20:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792442779; x=1823978779;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=QPaKfxrJTwuGXpNqJn91Xad8Zve1NjywuhAkFJLP6Tc=;
 b=E38UPn2rgH7rX4XIEs9xoUJF0ay0h7u8rHhC0ycQUpK7qz62HcvyN65O
 a1vh/zDjBA9AjjCqNkqZmT5YQdhmeaToXfo+xbLkjqkeNo+jzYMRkJjSd
 oID1OtbFXfK2YWCgQJAQJWit6ln+ZxQzncaJdOX9p8T+WZfK33jCjRFlV
 THOuNfgcMhE8/whpvV8W9ZEVCHh7szv+XdN3NunDPZvFddVNbwc1/K9Ax
 NoiWYF6JpBDIByIkBS6FAjGJ2RJnA0xlCu7GULaWttyWOiPiBcndbCjSY
 fRtJR9GmpO4cPWYf2HHWBiAwc5PfkIZcx0pGH+uRr6fI537EstDTPbK7p w==;
X-CSE-ConnectionGUID: t4GsJq75QKCzela8Ky8EOg==
X-CSE-MsgGUID: YgtV3N80TOalNtfHRFfx8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1041465"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1041465"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 13:46:18 -0700
X-CSE-ConnectionGUID: 46avrWP0QweOGadN9LhM5A==
X-CSE-MsgGUID: ak8vEZwiQ3KRBKTFOCEBoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2683900"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa003.fm.intel.com with ESMTP; 19 Oct 2026 13:46:15 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xIuFJ-00000000MNC-0m8k;
 Mon, 19 Oct 2026 20:46:13 +0000
Date: Tue, 20 Oct 2026 04:45:59 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 airlied@gmail.com, simona@ffwll.ch, bhelgaas@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Reza Nikzad Chaleshori <rezanikzadch@gmail.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: Gate VFCT bus fallback on pci=realloc
Message-ID: <202610200440.fq7Zgnxm-lkp@intel.com>
References: <20261015124843.203905-1-mario.limonciello@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015124843.203905-1-mario.limonciello@amd.com>
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mario,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus drm-misc/drm-misc-next daeinki-drm-exynos/exynos-drm-next drm/drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes drm-tip/drm-tip linus/master v7.3 next-20261016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/drm-amdgpu-Gate-VFCT-bus-fallback-on-pci-realloc/20261015-074842
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20261015124843.203905-1-mario.limonciello%40amd.com
patch subject: [PATCH] drm/amdgpu: Gate VFCT bus fallback on pci=realloc
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20261020/202610200440.fq7Zgnxm-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261020/202610200440.fq7Zgnxm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610200440.fq7Zgnxm-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: drivers/gpu/drm/amd/amdgpu/amdgpu.ko: symbol 'pci_realloc_enabled_by_user' undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
