Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594C2606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 05:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m6KcVsVN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F09510E197;
	Wed, 11 Nov 2026 05:44:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F93E10E197
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 05:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794375866; x=1825911866;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=N90weQI6DNfG9GLV/hBEqDcGtXwR/CCbY3cT0MFAMJk=;
 b=m6KcVsVNCa24QEXjRmyhaS9Ce9+MyxOk1NWbM3YaIeQx+jvyYVcjBhOg
 ypWmnOAM8owwXrFnqddyPy29leyX6LsPAwQVZ+YPyxLZ8ir6IHYUrlo/V
 hQzjObSgXtLqTz2mo/2esfjQD3K0vQaowv+OmlpWO68S+mLT8mOdUPPgm
 mbTNBmEU8oAOESzSA35JJd5Gg/bPebl+wIYTT5wCDjMirgADChCWzaV7a
 9aHCo80T8pZor/J/0oFzbrkt/0VC7N1kE/sVVk6xEBiFXI8yn93Tebvxs
 kkqaLsdoWpdhJjaIK1pVnlhzgyYLSgCq8CP+iDVta8iya44XfcPE69wOC A==;
X-CSE-ConnectionGUID: qX5uBEfcQiuDVKdw/wwnMg==
X-CSE-MsgGUID: J1rGmdOTTnCTacj6rj1S4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3021391"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3021391"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 21:44:04 -0800
X-CSE-ConnectionGUID: gxO1fCV/QI6o9nIVSOaVBA==
X-CSE-MsgGUID: LRDd3qJKSxi/LqUBiyuDug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; d="scan'208";a="10214917"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa013.fm.intel.com with ESMTP; 10 Nov 2026 21:44:01 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xR17l-00000000yDb-2Pp8;
 Wed, 11 Nov 2026 05:43:57 +0000
Date: Wed, 11 Nov 2026 13:43:01 +0800
From: kernel test robot <lkp@intel.com>
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, nd@arm.com,
 Boris Brezillon <bbrezillon@kernel.org>,
 Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v2 14/28] drm/panthor: Add AM_PARTITION_CONTROL support
Message-ID: <202611111301.KUTVMgUg-lkp@intel.com>
References: <20261110153907.3241978-15-karunika.choo@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110153907.3241978-15-karunika.choo@arm.com>
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

Hi Karunika,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm/drm-next drm-tip/drm-tip next-20261110]
[cannot apply to linux-review/Karunika-Choo/drm-panthor-Ignore-EOPNOTSUPP-for-shader-present-nvmem-lookup/20260922-214455 daeinki-drm-exynos/exynos-drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes linus/master v7.4-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Karunika-Choo/drm-panthor-Ignore-EOPNOTSUPP-for-shader-present-nvmem-lookup/20261110-153822
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20261110153907.3241978-15-karunika.choo%40arm.com
patch subject: [PATCH v2 14/28] drm/panthor: Add AM_PARTITION_CONTROL support
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20261111/202611111301.KUTVMgUg-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project e73e336290028f26553b46c9fba844c13da38c9c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261111/202611111301.KUTVMgUg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611111301.KUTVMgUg-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c:328:12: error: call to undeclared function 'irq_get_irq_data'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     328 |         irqdata = irq_get_irq_data(irq);
         |                   ^
   drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c:328:12: note: did you mean 'irq_set_irq_wake'?
   include/linux/interrupt.h:486:12: note: 'irq_set_irq_wake' declared here
     486 | extern int irq_set_irq_wake(unsigned int irq, unsigned int on);
         |            ^
>> drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c:328:10: error: incompatible integer to pointer conversion assigning to 'struct irq_data *' from 'int' [-Wint-conversion]
     328 |         irqdata = irq_get_irq_data(irq);
         |                 ^ ~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c:330:15: error: call to undeclared function 'irqd_get_trigger_type'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     330 |                 irq_flags = irqd_get_trigger_type(irqdata);
         |                             ^
   3 errors generated.


vim +/irq_get_irq_data +328 drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c

   278	
   279	static int partition_control_init(struct panthor_arbitration *adev, int i)
   280	{
   281		struct panthor_partition_control *pc;
   282		struct device *dev = adev->dev;
   283		struct irq_data *irqdata;
   284		struct resource *res;
   285		void __iomem *iomem;
   286		u32 irq_flags = 0;
   287		char *name;
   288		int irq;
   289		int ret;
   290	
   291		if (adev->pc[i])
   292			return dev_warn_probe(dev, -ENODEV,
   293					      "partition %u already present", i);
   294	
   295		pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
   296		if (!pc)
   297			return -ENOMEM;
   298	
   299		name = devm_kasprintf(dev, GFP_KERNEL, "pc%d", i);
   300		if (!name)
   301			return -ENOMEM;
   302	
   303		res = platform_get_resource_byname(to_platform_device(dev),
   304						   IORESOURCE_MEM, name);
   305		if (!res)
   306			return -ENODEV;
   307	
   308		iomem = devm_ioremap_resource(dev, res);
   309		if (IS_ERR(iomem))
   310			return dev_err_probe(dev, PTR_ERR(iomem), "%s: Failed to ioremap", name);
   311	
   312		pc->name = name;
   313		pc->dev = dev;
   314		pc->iomem = iomem;
   315	
   316		spin_lock_init(&pc->irq_lock);
   317		pc->irq_suspended = true;
   318	
   319		spin_lock_init(&pc->lock);
   320		pc->current_aw = AW_UNASSIGNED;
   321	
   322		irq = platform_get_irq_byname(to_platform_device(dev), name);
   323		if (irq < 0)
   324			return irq;
   325	
   326		pc->irq = irq;
   327	
 > 328		irqdata = irq_get_irq_data(irq);
   329		if (irqdata)
 > 330			irq_flags = irqd_get_trigger_type(irqdata);
   331	
   332		ret = devm_request_irq(
   333			dev, irq, partition_irq_raw_handler, irq_flags | IRQF_SHARED,
   334			devm_kasprintf(dev, GFP_KERNEL, "panthor-%s-irq", name), pc);
   335		if (ret)
   336			return ret;
   337	
   338		adev->pc[i] = pc;
   339	
   340		partition_irq_resume(pc);
   341	
   342		return 0;
   343	}
   344	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
