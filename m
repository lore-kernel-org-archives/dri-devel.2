Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF20E606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H9eCC52t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05D9210E375;
	Thu, 29 Oct 2026 07:01:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D77410E375
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793257258; x=1824793258;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=RsYIa3SqFjpZb1UpYbTUmweoNbFTAIhFfW6r4GISlO4=;
 b=H9eCC52t7MSNlgANPVWjfqnqTp4NwRo7GO09RErj5ZQfepDc40YdRXi1
 MuPfdxIrSyfdshyqn+JnM99yb2G9COG2T/u44DpOh1Tv+Oiyodmuclq9Y
 aum4n7cDBJftxRTud9YXt6WfsHzvlCaTlffoYdat0ZbnEYKvjvaWZN4j1
 m3ac/LSWKf5DKpoyn41Kly791nP0mdzoMPs1eR4740Ld1O4El8Ye5ay/G
 YUUqlHs39W+YWI0JykmFTXvSHD/46LQIVuu/QBsWAQB1iP1QeXa2ZR7Qm
 UifVcaBV1jNHJ+k4M+fjK4dbsq/xBbZQEtg1kG6Llng94qXg4APY/jB4P A==;
X-CSE-ConnectionGUID: qXfu6kAGS/aWLWC4vQ4fXA==
X-CSE-MsgGUID: F8nhMV7tQM2PHMm92sg9Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1880190"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1880190"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 00:00:57 -0700
X-CSE-ConnectionGUID: Qzg3tDeBSbqe5NpeZV+b0g==
X-CSE-MsgGUID: VdkRB7fnTnmInUtVd2+VTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5584505"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa010.fm.intel.com with ESMTP; 29 Oct 2026 00:00:55 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xMK84-00000000ZiS-1BTl;
 Thu, 29 Oct 2026 07:00:52 +0000
Date: Thu, 29 Oct 2026 15:00:27 +0800
From: kernel test robot <lkp@intel.com>
To: wuqianhai@loongson.cn, bhelgaas@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 wuqianhai <wuqianhai@loongson.cn>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, tzimmermann@suse.de,
 javierm@redhat.com, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] PCI/VGA: Fix boot device detection after framebuffer
 relocation
Message-ID: <202610291418.tlsEIHSu-lkp@intel.com>
References: <20261028094634.766723-1-wuqianhai@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028094634.766723-1-wuqianhai@loongson.cn>
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

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v7.3 next-20261028]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/wuqianhai-loongson-cn/PCI-VGA-Fix-boot-device-detection-after-framebuffer-relocation/20261028-174634
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20261028094634.766723-1-wuqianhai%40loongson.cn
patch subject: [PATCH] PCI/VGA: Fix boot device detection after framebuffer relocation
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20261029/202610291418.tlsEIHSu-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261029/202610291418.tlsEIHSu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610291418.tlsEIHSu-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: screen_info_apply_fixups
   >>> referenced by vgaarb.c
   >>>               drivers/pci/vgaarb.o:(vga_arb_device_init) in archive vmlinux.a

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
