Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64594C2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 20:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4532310E45D;
	Fri,  7 Aug 2026 20:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KVMbhvN+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC4B410E45D
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 20:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786134321; x=1817670321;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Ek0FI4RlDQRZz2CcaSBsfFD5xoAO6NG0pAYHUew1mig=;
 b=KVMbhvN+Fj2mSrMLWeqWhKCXuQWVginIzhr+HPIfa+qwPosFE3lHmKwt
 p/JiWjHMPG1tk23iaIRQU1kHd3P7S/sJyWMhxuxPnVYGk2N8vUcko5aWz
 semfUQqydmrHgHWSP+ahnZDSABHJpNdleM6PV32/BD8IWsE3OdcM1Ss66
 D8zMDt0/N7o1QdH5OdRW1aAHFGmTMWDP5Lyy61iCWSs8VR9oEyXrrNgJa
 FWyrkgFtcQKyjqsSRwp7m5AtJLrOaItpxApL9F0d5q1D3PjJUq6AHH67K
 lsLv0jX1mmmYtcsPOjQ/OQoVxc/DVSbjBMwoBnF5WYGBhzYf+X6AygkCQ w==;
X-CSE-ConnectionGUID: vKVaBTGAR8e69mFYEfWGIA==
X-CSE-MsgGUID: RWQDWMgSQ+mhxAElB7lLzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="98115796"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="98115796"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 13:25:20 -0700
X-CSE-ConnectionGUID: KWC8zIN6RgeMGPaJXnCdwg==
X-CSE-MsgGUID: yHo2ZRhbQdKhCYO3C7CXpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="287178434"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by fmviesa001.fm.intel.com with ESMTP; 07 Aug 2026 13:25:17 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wsR7y-00000000JAj-1PoN;
 Fri, 07 Aug 2026 20:25:14 +0000
Date: Sat, 8 Aug 2026 04:24:30 +0800
From: kernel test robot <lkp@intel.com>
To: WenTao Liang <vulab@iscas.ac.cn>, Zack Rusin <zack.rusin@broadcom.com>,
 dri-devel@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, bcm-kernel-feedback-list@broadcom.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Thomas Hellstrom <thellstrom@vmware.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, WenTao Liang <vulab@iscas.ac.cn>
Subject: Re: [PATCH] fix: drm/vmwgfx: vmw_user_shader_alloc: fix base object
 refcount leak on ttm_base_object_init failure
Message-ID: <202608080444.GqlrPBjd-lkp@intel.com>
References: <20260626150142.49732-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626150142.49732-1-vulab@iscas.ac.cn>
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

Hi WenTao,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on daeinki-drm-exynos/exynos-drm-next drm/drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes drm-tip/drm-tip linus/master v7.2-rc6 next-20260806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/WenTao-Liang/fix-drm-vmwgfx-vmw_user_shader_alloc-fix-base-object-refcount-leak-on-ttm_base_object_init-failure/20260807-080356
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260626150142.49732-1-vulab%40iscas.ac.cn
patch subject: [PATCH] fix: drm/vmwgfx: vmw_user_shader_alloc: fix base object refcount leak on ttm_base_object_init failure
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20260808/202608080444.GqlrPBjd-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260808/202608080444.GqlrPBjd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608080444.GqlrPBjd-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/vmwgfx/vmwgfx_shader.c: In function 'vmw_user_shader_alloc':
>> drivers/gpu/drm/vmwgfx/vmwgfx_shader.c:727:39: error: passing argument 1 of 'ttm_base_object_unref' from incompatible pointer type [-Wincompatible-pointer-types]
     727 |                 ttm_base_object_unref(&ushader->base);
         |                                       ^~~~~~~~~~~~~~
         |                                       |
         |                                       struct ttm_base_object *
   In file included from drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:27,
                    from drivers/gpu/drm/vmwgfx/vmwgfx_shader.c:32:
   drivers/gpu/drm/vmwgfx/ttm_object.h:192:60: note: expected 'struct ttm_base_object **' but argument is of type 'struct ttm_base_object *'
     192 | extern void ttm_base_object_unref(struct ttm_base_object **p_base);
         |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~


vim +/ttm_base_object_unref +727 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c

   684	
   685	static int vmw_user_shader_alloc(struct vmw_private *dev_priv,
   686					 struct vmw_bo *buffer,
   687					 size_t shader_size,
   688					 size_t offset,
   689					 SVGA3dShaderType shader_type,
   690					 uint8_t num_input_sig,
   691					 uint8_t num_output_sig,
   692					 struct ttm_object_file *tfile,
   693					 u32 *handle)
   694	{
   695		struct vmw_user_shader *ushader;
   696		struct vmw_resource *res, *tmp;
   697		int ret;
   698	
   699		ushader = kzalloc_obj(*ushader);
   700		if (unlikely(!ushader)) {
   701			ret = -ENOMEM;
   702			goto out;
   703		}
   704	
   705		res = &ushader->shader.res;
   706		ushader->base.shareable = false;
   707		ushader->base.tfile = NULL;
   708	
   709		/*
   710		 * From here on, the destructor takes over resource freeing.
   711		 */
   712	
   713		ret = vmw_gb_shader_init(dev_priv, res, shader_size,
   714					 offset, shader_type, num_input_sig,
   715					 num_output_sig, buffer,
   716					 vmw_user_shader_free);
   717		if (unlikely(ret != 0))
   718			goto out;
   719	
   720		tmp = vmw_resource_reference(res);
   721		ret = ttm_base_object_init(tfile, &ushader->base, false,
   722					   VMW_RES_SHADER,
   723					   &vmw_user_shader_base_release);
   724	
   725		if (unlikely(ret != 0)) {
   726			vmw_resource_unreference(&tmp);
 > 727			ttm_base_object_unref(&ushader->base);
   728			goto out_err;
   729		}
   730	
   731		if (handle)
   732			*handle = ushader->base.handle;
   733	out_err:
   734		vmw_resource_unreference(&res);
   735	out:
   736		return ret;
   737	}
   738	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
