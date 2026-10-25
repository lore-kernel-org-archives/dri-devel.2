Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BB6606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 22:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UGPQqJix
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFDBE10E0E8;
	Sun, 25 Oct 2026 22:11:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65F2210E0E8;
 Sun, 25 Oct 2026 22:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792966279; x=1824502279;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=SvvFyjxTb+lI7eFPlaBGniMfSYQ5Hlh9HQr+bDAhB9A=;
 b=UGPQqJixHs4KQvlseSjIzmnDmaPhcT6ZsGKM/eotpy6JKbA6DE2Pf2oz
 Wm5k6T5L18InTXvXqKJLw/8TmbRfbdJpmLXro/aqGeNUVvUO3Py1Py8Na
 vtIGIc33c7P3cKoZAXK8Vrmi7ukL4VLQK+RiZ6AmVAdOltrvtSd7YO98S
 mre0Hc6FiAW9u9Dfm7IqKc4jPlJmYi3nNlrcfqVvPLpGYuynkU7cuATbd
 imQq3AKXE6Frk4sLHQ1nHUvBaDzthFBiUXQFTzx4a+k8xzuJeC42To/2f
 nM4OIj81tf2rbbT1wwobCR3wt/vqblsIgaJt0liHfzahlp+Mc0ZzwtniN Q==;
X-CSE-ConnectionGUID: TQWt+wUmSOqNb9uqDf0RQg==
X-CSE-MsgGUID: bNrN7VSCRTix6SnESbdVMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1720258"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1720258"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 15:11:17 -0700
X-CSE-ConnectionGUID: WDJ+oOdBR7yGTPf6fHnIlg==
X-CSE-MsgGUID: uvV5O+jKRce54uh3Wj/RwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4458231"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa008.fm.intel.com with ESMTP; 25 Oct 2026 15:11:11 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xL6Qm-00000000VCU-1YQH;
 Sun, 25 Oct 2026 22:11:08 +0000
Date: Mon, 26 Oct 2026 06:10:19 +0800
From: kernel test robot <lkp@intel.com>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Andre Eikmeyer <dev@deq.rocks>, Bjorn Helgaas <helgaas@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "(maintainer:X86 ARCHITECTURE \\(32-BIT AND 64-BIT\\))" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hans de Goede <hansg@kernel.org>,
 Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org,
 "(open list:X86 ARCHITECTURE \\(32-BIT AND 64-BIT\\))"
 <linux-kernel@vger.kernel.org>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 03/13] platform/apple-gmux: Fix MMIO interface
Message-ID: <202610260503.TQjc0Dfl-lkp@intel.com>
References: <20261025040046.1602-4-atharvatiwarilinuxdev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261025040046.1602-4-atharvatiwarilinuxdev@gmail.com>
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

Hi Atharva,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v7.3]
[also build test WARNING on next-20261023]
[cannot apply to drm-misc/drm-misc-next pci/next pci/for-linus linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Atharva-Tiwari/platform-apple-gmux-Fix-power-for-MMIO-systems/20261024-235937
base:   v7.3
patch link:    https://lore.kernel.org/r/20261025040046.1602-4-atharvatiwarilinuxdev%40gmail.com
patch subject: [PATCH 03/13] platform/apple-gmux: Fix MMIO interface
config: x86_64-randconfig-1017-20261025 (https://download.01.org/0day-ci/archive/20261026/202610260503.TQjc0Dfl-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261026/202610260503.TQjc0Dfl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610260503.TQjc0Dfl-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/apple-gmux.c:253:6: warning: variable 'val' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     253 |         if (gmux_mmio_wait(gmux_data)) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/apple-gmux.c:263:9: note: uninitialized use occurs here
     263 |         return val;
         |                ^~~
   drivers/platform/x86/apple-gmux.c:253:2: note: remove the 'if' if its condition is always true
     253 |         if (gmux_mmio_wait(gmux_data)) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/apple-gmux.c:250:8: note: initialize the variable 'val' to silence this warning
     250 |         u8 val;
         |               ^
         |                = '\0'
   drivers/platform/x86/apple-gmux.c:290:6: warning: variable 'val' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     290 |         if (gmux_mmio_wait(gmux_data)) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/apple-gmux.c:301:9: note: uninitialized use occurs here
     301 |         return val;
         |                ^~~
   drivers/platform/x86/apple-gmux.c:290:2: note: remove the 'if' if its condition is always true
     290 |         if (gmux_mmio_wait(gmux_data)) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/apple-gmux.c:286:9: note: initialize the variable 'val' to silence this warning
     286 |         u32 val;
         |                ^
         |                 = 0
   2 warnings generated.


vim +253 drivers/platform/x86/apple-gmux.c

   247	
   248	static u8 gmux_mmio_read8(struct apple_gmux_data *gmux_data, int port)
   249	{
   250		u8 val;
   251	
   252		mutex_lock(&gmux_data->index_lock);
 > 253		if (gmux_mmio_wait(gmux_data)) {
   254			iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
   255			iowrite8(GMUX_MMIO_READ | sizeof(val),
   256				gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
   257			if (!gmux_mmio_wait(gmux_data))
   258				return 0;
   259			val = ioread8(gmux_data->iomem_base);
   260		}
   261		mutex_unlock(&gmux_data->index_lock);
   262	
   263		return val;
   264	}
   265	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
