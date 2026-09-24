Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBDBC982FD
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 05:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74BF810E640;
	Thu, 24 Sep 2026 05:16:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NJPXDHMU";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD03E10E640
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 05:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790226992; x=1821762992;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=W6kGjGPuL2RAaFMOzy+i0OfCDOTh0BKPwO6VDeOmWJ0=;
 b=NJPXDHMUmuVKVxr7gRV4Hxz1/Ff2prvP5osJ9hS+TugO3vWB9f7pp083
 Z3z1EEM6KwrgLKOf7JR7qPDsU55yk7GV4L/a2PY7cB8/RlOj5kTMaHn34
 7JzlCNhMdzAqTuJpi7gZ3UKdg82lhkH3k3ZInZUqBj1UZw7OgauwFakCj
 NFVBfACbT5QgX0UepvhltT8lQT5mqFLdT6BYjOMJj4fzO0dmxluB/kwoD
 KzfRtS6RTz+J02EeIThj5UTEjX4/P6caIvXX2+5MM1HPUpOeEOxapdOxK
 mE7NAYaJelo/lL5OThrRrl8xzVtWO4D9xKbcUVVOBNFnr5YkXXs+fT2xY Q==;
X-CSE-ConnectionGUID: GepY8GtASWSYIs4Q9T9DaQ==
X-CSE-MsgGUID: ctQLR3H/QZa1svOSA43Ftg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="93878824"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="93878824"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 22:16:31 -0700
X-CSE-ConnectionGUID: xVQ2kuV2RGegVhDVvFEqbA==
X-CSE-MsgGUID: 4fJLjTRoTUeoQ1kpRlSAGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="5165893"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa013.fm.intel.com with ESMTP; 23 Sep 2026 22:16:28 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x9bon-00000000IEA-0azJ;
 Thu, 24 Sep 2026 05:16:25 +0000
Date: Thu, 24 Sep 2026 13:15:35 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>,
 Dave Airlie <airlied@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] pci/vgaarb: pass a data pointer to be used in the decode
 callback
Message-ID: <202609241323.5ZIGw7sZ-lkp@intel.com>
References: <20260922064111.2468741-1-airlied@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922064111.2468741-1-airlied@gmail.com>
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

Hi Dave,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on pci/next pci/for-linus drm-tip/drm-tip linus/master v7.3-rc4 next-20260922]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Airlie/pci-vgaarb-pass-a-data-pointer-to-be-used-in-the-decode-callback/20260922-164111
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260922064111.2468741-1-airlied%40gmail.com
patch subject: [PATCH] pci/vgaarb: pass a data pointer to be used in the decode callback
config: csky-allmodconfig (https://download.01.org/0day-ci/archive/20260924/202609241323.5ZIGw7sZ-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260924/202609241323.5ZIGw7sZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609241323.5ZIGw7sZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/loongson/lsdc_drv.c: In function 'lsdc_pci_probe':
   drivers/gpu/drm/loongson/lsdc_drv.c:294:35: error: passing argument 2 of 'vga_client_register' from incompatible pointer type [-Wincompatible-pointer-types]
     294 |         vga_client_register(pdev, lsdc_vga_set_decode);
         |                                   ^~~~~~~~~~~~~~~~~~~
         |                                   |
         |                                   unsigned int (*)(struct pci_dev *, bool) {aka unsigned int (*)(struct pci_dev *, _Bool)}
   In file included from drivers/gpu/drm/loongson/lsdc_drv.c:8:
   include/linux/vgaarb.h:36:32: note: expected 'unsigned int (*)(void *, bool)' {aka 'unsigned int (*)(void *, _Bool)'} but argument is of type 'unsigned int (*)(struct pci_dev *, bool)' {aka 'unsigned int (*)(struct pci_dev *, _Bool)'}
      36 |                 unsigned int (*set_decode)(void *data, bool state),
         |                 ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/loongson/lsdc_drv.c:257:21: note: 'lsdc_vga_set_decode' declared here
     257 | static unsigned int lsdc_vga_set_decode(struct pci_dev *pdev, bool state)
         |                     ^~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/loongson/lsdc_drv.c:294:9: error: too few arguments to function 'vga_client_register'; expected 3, have 2
     294 |         vga_client_register(pdev, lsdc_vga_set_decode);
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/vgaarb.h:35:5: note: declared here
      35 | int vga_client_register(struct pci_dev *pdev,
         |     ^~~~~~~~~~~~~~~~~~~


vim +/vga_client_register +294 drivers/gpu/drm/loongson/lsdc_drv.c

f39db26c54281d Sui Jingfeng      2023-06-15  261  
f39db26c54281d Sui Jingfeng      2023-06-15  262  static int lsdc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
f39db26c54281d Sui Jingfeng      2023-06-15  263  {
f39db26c54281d Sui Jingfeng      2023-06-15  264  	const struct lsdc_desc *descp;
f39db26c54281d Sui Jingfeng      2023-06-15  265  	struct drm_device *ddev;
f39db26c54281d Sui Jingfeng      2023-06-15  266  	struct lsdc_device *ldev;
f39db26c54281d Sui Jingfeng      2023-06-15  267  	int ret;
f39db26c54281d Sui Jingfeng      2023-06-15  268  
f39db26c54281d Sui Jingfeng      2023-06-15  269  	descp = lsdc_device_probe(pdev, ent->driver_data);
f39db26c54281d Sui Jingfeng      2023-06-15  270  	if (IS_ERR_OR_NULL(descp))
f39db26c54281d Sui Jingfeng      2023-06-15  271  		return -ENODEV;
f39db26c54281d Sui Jingfeng      2023-06-15  272  
f39db26c54281d Sui Jingfeng      2023-06-15  273  	pci_set_master(pdev);
f39db26c54281d Sui Jingfeng      2023-06-15  274  
f39db26c54281d Sui Jingfeng      2023-06-15  275  	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
f39db26c54281d Sui Jingfeng      2023-06-15  276  	if (ret)
f39db26c54281d Sui Jingfeng      2023-06-15  277  		return ret;
f39db26c54281d Sui Jingfeng      2023-06-15  278  
f39db26c54281d Sui Jingfeng      2023-06-15  279  	ret = pcim_enable_device(pdev);
f39db26c54281d Sui Jingfeng      2023-06-15  280  	if (ret)
f39db26c54281d Sui Jingfeng      2023-06-15  281  		return ret;
f39db26c54281d Sui Jingfeng      2023-06-15  282  
f39db26c54281d Sui Jingfeng      2023-06-15  283  	dev_info(&pdev->dev, "Found %s, revision: %u",
f39db26c54281d Sui Jingfeng      2023-06-15  284  		 to_loongson_gfx(descp)->model, pdev->revision);
f39db26c54281d Sui Jingfeng      2023-06-15  285  
f39db26c54281d Sui Jingfeng      2023-06-15  286  	ldev = lsdc_create_device(pdev, descp, &lsdc_drm_driver);
f39db26c54281d Sui Jingfeng      2023-06-15  287  	if (IS_ERR(ldev))
f39db26c54281d Sui Jingfeng      2023-06-15  288  		return PTR_ERR(ldev);
f39db26c54281d Sui Jingfeng      2023-06-15  289  
f39db26c54281d Sui Jingfeng      2023-06-15  290  	ddev = &ldev->base;
f39db26c54281d Sui Jingfeng      2023-06-15  291  
f39db26c54281d Sui Jingfeng      2023-06-15  292  	pci_set_drvdata(pdev, ddev);
f39db26c54281d Sui Jingfeng      2023-06-15  293  
f39db26c54281d Sui Jingfeng      2023-06-15 @294  	vga_client_register(pdev, lsdc_vga_set_decode);
f39db26c54281d Sui Jingfeng      2023-06-15  295  
0a9c56dd387605 Myeonghun Pak     2026-05-13  296  	drmm_kms_helper_poll_init(ddev);
f39db26c54281d Sui Jingfeng      2023-06-15  297  
f39db26c54281d Sui Jingfeng      2023-06-15  298  	if (loongson_vblank) {
f39db26c54281d Sui Jingfeng      2023-06-15  299  		ret = drm_vblank_init(ddev, descp->num_of_crtc);
f39db26c54281d Sui Jingfeng      2023-06-15  300  		if (ret)
f39db26c54281d Sui Jingfeng      2023-06-15  301  			return ret;
f39db26c54281d Sui Jingfeng      2023-06-15  302  
f39db26c54281d Sui Jingfeng      2023-06-15  303  		ret = devm_request_irq(&pdev->dev, pdev->irq,
f39db26c54281d Sui Jingfeng      2023-06-15  304  				       descp->funcs->irq_handler,
f39db26c54281d Sui Jingfeng      2023-06-15  305  				       IRQF_SHARED,
f39db26c54281d Sui Jingfeng      2023-06-15  306  				       dev_name(&pdev->dev), ddev);
f39db26c54281d Sui Jingfeng      2023-06-15  307  		if (ret) {
f39db26c54281d Sui Jingfeng      2023-06-15  308  			drm_err(ddev, "Failed to register interrupt: %d\n", ret);
f39db26c54281d Sui Jingfeng      2023-06-15  309  			return ret;
f39db26c54281d Sui Jingfeng      2023-06-15  310  		}
f39db26c54281d Sui Jingfeng      2023-06-15  311  
f39db26c54281d Sui Jingfeng      2023-06-15  312  		drm_info(ddev, "registered irq: %u\n", pdev->irq);
f39db26c54281d Sui Jingfeng      2023-06-15  313  	}
f39db26c54281d Sui Jingfeng      2023-06-15  314  
f39db26c54281d Sui Jingfeng      2023-06-15  315  	ret = drm_dev_register(ddev, 0);
f39db26c54281d Sui Jingfeng      2023-06-15  316  	if (ret)
f39db26c54281d Sui Jingfeng      2023-06-15  317  		return ret;
f39db26c54281d Sui Jingfeng      2023-06-15  318  
4269f5c878fc19 Thomas Zimmermann 2024-09-24  319  	drm_client_setup(ddev, NULL);
f39db26c54281d Sui Jingfeng      2023-06-15  320  
f39db26c54281d Sui Jingfeng      2023-06-15  321  	return 0;
f39db26c54281d Sui Jingfeng      2023-06-15  322  }
f39db26c54281d Sui Jingfeng      2023-06-15  323  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
