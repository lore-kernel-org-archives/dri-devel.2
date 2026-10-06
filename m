Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED98CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 03:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFACA10E2CE;
	Tue,  6 Oct 2026 03:43:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kseey+5s";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0730110E2CE
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 03:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791258230; x=1822794230;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3tgkAQgFnZ1KpY58GWODV6fxFp7Qx3kbvjbBmjjBKTM=;
 b=kseey+5sK5x4/yCKtoAEZ5jj7I5OJx+PoiTTPySS59QLxGZhMzmyIhsO
 W0qFHdaIFtgnYa8MiTw3gUz8/T6o9BqEbosWMGp5FslU8EfJi/K5cfrWI
 eHCGjqwL/H46tEmaFwOJu7g81WSJXqacSWZFUvNGuk7kbVWtuN/9sLDFF
 Ws/85xAtr3RqOVGaNbU1FBmui1gs5sJdoXcP3gKXrsyf5Xt7Tjdw1alds
 /HMDx0E9kTPpF9hrpzzD2bla58xXAVoPHrEwW/6FfI0sBm5cIgr7n68C3
 ykNvWmMLchewhmSWOufpkHipMl8S+BMRelmIMGyzmFVplDAIvuzbZ1r1J w==;
X-CSE-ConnectionGUID: o3KUFpAQRSWewVFJSgz6ig==
X-CSE-MsgGUID: xRsz72JAQ8u9rhTYKS8atw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="94812292"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="94812292"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 20:43:49 -0700
X-CSE-ConnectionGUID: kPfbZEwwRryQKtQgZMlbLA==
X-CSE-MsgGUID: rCb0w7q3R9Ccc2zH61qK/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="276530544"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa007.fm.intel.com with ESMTP; 05 Oct 2026 20:43:45 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xDw5e-0000000017k-15jA;
 Tue, 06 Oct 2026 03:43:42 +0000
Date: Tue, 6 Oct 2026 11:42:52 +0800
From: kernel test robot <lkp@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 4/7] drm/tegra: Add support for 8-bit CPU interface
Message-ID: <202610061119.aQ5vg3Ez-lkp@intel.com>
References: <20261004163114.181800-5-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004163114.181800-5-clamor95@gmail.com>
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

Hi Svyatoslav,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm/drm-next linus/master v7.3-rc6 next-20261005]
[cannot apply to tegra/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Svyatoslav-Ryhel/drm-tegra-dc-Expand-available-registers-layouts/20261004-193108
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20261004163114.181800-5-clamor95%40gmail.com
patch subject: [PATCH v2 4/7] drm/tegra: Add support for 8-bit CPU interface
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20261006/202610061119.aQ5vg3Ez-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261006/202610061119.aQ5vg3Ez-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610061119.aQ5vg3Ez-lkp@intel.com/

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/gpu/drm/tegra/dbi.o: in function `tegra_dbi_driver_init':
>> (.init.text+0x10): multiple definition of `init_module'; drivers/gpu/drm/tegra/drm.o:(.init.text+0x10): first defined here
   hppa-linux-ld: drivers/gpu/drm/tegra/dbi.o: in function `tegra_dbi_driver_exit':
>> (.exit.text+0x0): multiple definition of `cleanup_module'; drivers/gpu/drm/tegra/drm.o:(.exit.text+0x0): first defined here

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
