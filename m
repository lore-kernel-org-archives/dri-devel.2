Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97B9CD4F21
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 03:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5206A10E1BB;
	Sat, 16 May 2026 03:43:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="I/tJEmJS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D53E10E1BB
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 03:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778902998; x=1810438998;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ID9tdn2gYJjBbnWVxJgcOf7EQejKZETrIpsg4qqVtHY=;
 b=I/tJEmJS4CYF06UuAfmFimH6OoQRz2Zc6XhQvIrv809/eprSqce+W2ei
 9IpEFjwTggXzCAYbfSm41HEQ0+r6Vr2aZ/RVy/9vHhmbYZFuOqfEHeIak
 9BX1QT2GHZfDd0aoYVeyqt7RGzkM+mGPDuIIXWMzcaT1h+s8xHNibtISu
 oxiQB/lnPaeLMIN92ogj3pP6gY2XnMHUtw5Zb/r6LLYM1tLhvJ7x5Aw2C
 OsOgo1t6evzLxoAwMNje+ZUuhdEpN27WO8lSgaayFy8NG79i/TLAqZoCd
 WVKEBavcZnTj1Tn6oHSI2ur2ZmEtAy+rnnj+Sb1sOQE97EybYqH3dtRAP w==;
X-CSE-ConnectionGUID: xKBLTrGbSzSxCZHGHAuqPw==
X-CSE-MsgGUID: toSSL3a1Q6isP5gwFD1qzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="79886302"
X-IronPort-AV: E=Sophos;i="6.23,237,1770624000"; d="scan'208";a="79886302"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2026 20:43:18 -0700
X-CSE-ConnectionGUID: s5Ygh37dSiCMUGCwRldduA==
X-CSE-MsgGUID: 3wjoSGchQBmh5FEgL/7rQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,237,1770624000"; d="scan'208";a="276974691"
Received: from lkp-server01.sh.intel.com (HELO d94e5e629b2d) ([10.239.97.150])
 by orviesa001.jf.intel.com with ESMTP; 15 May 2026 20:43:14 -0700
Received: from kbuild by d94e5e629b2d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wO5vj-000000000RJ-1Wna;
 Sat, 16 May 2026 03:43:11 +0000
Date: Sat, 16 May 2026 11:43:03 +0800
From: kernel test robot <lkp@intel.com>
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, mario.limonciello@amd.com,
 karol.wachowski@linux.intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Lizhi Hou <lizhi.hou@amd.com>, linux-kernel@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 christian.koenig@amd.com, simona@ffwll.ch, max.zhen@amd.com,
 sonal.santan@amd.com
Subject: Re: [PATCH V1] accel/amdxdna: Remove mmap and export support for ubuf
Message-ID: <202605161116.6FTLJOlI-lkp@intel.com>
References: <20260515155332.743097-1-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515155332.743097-1-lizhi.hou@amd.com>
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

Hi Lizhi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lizhi-Hou/accel-amdxdna-Remove-mmap-and-export-support-for-ubuf/20260516-000523
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260515155332.743097-1-lizhi.hou%40amd.com
patch subject: [PATCH V1] accel/amdxdna: Remove mmap and export support for ubuf
config: x86_64-randconfig-002-20260516 (https://download.01.org/0day-ci/archive/20260516/202605161116.6FTLJOlI-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260516/202605161116.6FTLJOlI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605161116.6FTLJOlI-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/accel/amdxdna/amdxdna_ubuf.c:86:42: warning: unused variable 'amdxdna_ubuf_vm_ops' [-Wunused-const-variable]
      86 | static const struct vm_operations_struct amdxdna_ubuf_vm_ops = {
         |                                          ^~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/amdxdna_ubuf_vm_ops +86 drivers/accel/amdxdna/amdxdna_ubuf.c

bd72d4acda1069 Lizhi Hou 2025-07-16  85  
bd72d4acda1069 Lizhi Hou 2025-07-16 @86  static const struct vm_operations_struct amdxdna_ubuf_vm_ops = {
bd72d4acda1069 Lizhi Hou 2025-07-16  87  	.fault = amdxdna_ubuf_vm_fault,
bd72d4acda1069 Lizhi Hou 2025-07-16  88  };
bd72d4acda1069 Lizhi Hou 2025-07-16  89  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
