Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC42A60A2606
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jMSzU8lD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24A3110F95E;
	Wed, 11 Nov 2026 08:30:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7D2210F95E
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794385842; x=1825921842;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=H0W8Zz8PVKmFdE5ZMrV+luI9PVA/1Nk64TB2CjqQiwY=;
 b=jMSzU8lDrFsb5ByU+06uKAfaXZt7GtJYMXAksp6Cgq2LzeEXRgePwnP9
 W+jyG52Bnd/o2JMes2ZyjtTQO2sOE6COVhUk+PmcOhA1NCmg5xbbi56YY
 rv3AUI24l/JzHGuJg0eM0YXrNyY/MHX+Ib0rAWOAQmL7hGP1gDlBLSSdO
 2aF177Ur3Dl7BYg4UUVZHU6pGxKwv2PDaLawI4ei4AKzJLG1oK3Sxx50m
 pvyifwdS5RQCRzIl9z6NynXjVgRXPsUW33+QWB8y/VwKtP6/s133G0Lm3
 Ph1ZFnByFxxfHL2XRViaG/MbChnuz7DU3fZsL9wg/Y24iWxI6d7oDbzBc g==;
X-CSE-ConnectionGUID: iNHHCaU1QNGQR+zYXXXWHg==
X-CSE-MsgGUID: V+RqVAdURBmaRKdPeOxW3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3048395"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3048395"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 00:30:42 -0800
X-CSE-ConnectionGUID: OHTFHgqTQ6e4jUbhOUFXiQ==
X-CSE-MsgGUID: RyF6L6LNQ7SkOiIf3oliag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8441282"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa001.jf.intel.com with ESMTP; 11 Nov 2026 00:30:39 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xR3j2-00000000yQt-1Loh;
 Wed, 11 Nov 2026 08:30:36 +0000
Date: Wed, 11 Nov 2026 16:30:08 +0800
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
Subject: Re: [PATCH v2 16/28] drm/panthor: Add AM_RESOURCE_GROUP support
Message-ID: <202611111629.kkrg6syk-lkp@intel.com>
References: <20261110153907.3241978-17-karunika.choo@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110153907.3241978-17-karunika.choo@arm.com>
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
patch link:    https://lore.kernel.org/r/20261110153907.3241978-17-karunika.choo%40arm.com
patch subject: [PATCH v2 16/28] drm/panthor: Add AM_RESOURCE_GROUP support
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20261111/202611111629.kkrg6syk-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project e73e336290028f26553b46c9fba844c13da38c9c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261111/202611111629.kkrg6syk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611111629.kkrg6syk-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c:341:12: error: call to undeclared function 'irq_get_irq_data'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     341 |         irqdata = irq_get_irq_data(irq);
         |                   ^
   drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c:341:12: note: did you mean 'irq_set_irq_wake'?
   include/linux/interrupt.h:486:12: note: 'irq_set_irq_wake' declared here
     486 | extern int irq_set_irq_wake(unsigned int irq, unsigned int on);
         |            ^
>> drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c:341:10: error: incompatible integer to pointer conversion assigning to 'struct irq_data *' from 'int' [-Wint-conversion]
     341 |         irqdata = irq_get_irq_data(irq);
         |                 ^ ~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c:343:15: error: call to undeclared function 'irqd_get_trigger_type'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     343 |                 irq_flags = irqd_get_trigger_type(irqdata);
         |                             ^
   3 errors generated.


vim +/irq_get_irq_data +341 drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c

   284	
   285	static int resource_group_init(struct panthor_arbitration *adev, int i)
   286	{
   287		struct panthor_resource_group *rg;
   288		struct device *dev = adev->dev;
   289		struct irq_data *irqdata;
   290		struct resource *res;
   291		void __iomem *iomem;
   292		u32 irq_flags = 0;
   293		char *name;
   294		int irq;
   295		int ret;
   296	
   297		if (adev->rg[i])
   298			return dev_warn_probe(dev, -ENODEV,
   299					      "resource-group %u already present", i);
   300	
   301		rg = devm_kzalloc(dev, sizeof(*rg), GFP_KERNEL);
   302		if (!rg)
   303			return -ENOMEM;
   304	
   305		name = devm_kasprintf(dev, GFP_KERNEL, "rg%d", i);
   306		if (!name)
   307			return -ENOMEM;
   308	
   309		res = platform_get_resource_byname(to_platform_device(dev),
   310						   IORESOURCE_MEM, name);
   311		if (!res)
   312			return -ENODEV;
   313	
   314		iomem = devm_ioremap_resource(dev, res);
   315		if (IS_ERR(iomem))
   316			return dev_err_probe(dev, PTR_ERR(iomem), "%s: Failed to ioremap", name);
   317	
   318		rg->name = name;
   319		rg->dev = dev;
   320		rg->iomem = iomem;
   321	
   322		spin_lock_init(&rg->irq_lock);
   323		rg->irq_suspended = true;
   324	
   325		rg->wq = devm_alloc_ordered_workqueue(dev, "panthor-%s-wq", WQ_FREEZABLE, name);
   326		if (!rg->wq)
   327			return -ENOMEM;
   328	
   329		INIT_DELAYED_WORK(&rg->msg_retry_work, rg_retry_messages);
   330	
   331		for (int i = 0; i < AM_ARB_MAX_AW_COUNT; i++)
   332			panthor_am_msg_init(&rg->aw_data[i].msg,
   333					    rg->iomem + AM_RG_AW_MESSAGE(i));
   334	
   335		irq = platform_get_irq_byname(to_platform_device(dev), name);
   336		if (irq < 0)
   337			return irq;
   338	
   339		rg->irq = irq;
   340	
 > 341		irqdata = irq_get_irq_data(irq);
   342		if (irqdata)
 > 343			irq_flags = irqd_get_trigger_type(irqdata);
   344	
   345		ret = devm_request_irq(
   346			dev, irq, rg_irq_raw_handler, irq_flags | IRQF_SHARED,
   347			devm_kasprintf(dev, GFP_KERNEL, "panthor-%s-irq", name), rg);
   348		if (ret)
   349			return ret;
   350	
   351		adev->rg[i] = rg;
   352	
   353		rg_irq_resume(rg);
   354	
   355		rg_handshake_init(rg);
   356	
   357		return 0;
   358	}
   359	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
