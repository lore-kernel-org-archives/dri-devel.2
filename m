Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D8810F3DF3
	for <dri-devel@archiver.kernel.org>; Sat, 28 Mar 2026 19:16:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CA2B10E011;
	Sat, 28 Mar 2026 19:16:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="b/TIOwp+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FF4810E011
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 19:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774725416; x=1806261416;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Xi4KHjD3HwXhk0uReoN+g21GwT4k86mOjEuUDpZkY6I=;
 b=b/TIOwp+98/w1oxHQ4ttjXbjCmXylaA+NjiN4LbCTr2jxKi9Na7c2fsw
 QjoIF9w10iFxUXbs0UFchM5TAhTWzYRSBJQ1lTKBPoJ5ZSOF+6vjK4e8a
 irWZ7CBLyyrux2BqKFY+K4RYveR4vx3n/Pmke+sUl9AwVssgtOlbraRln
 uUGhGJTHpUYgdeXFCeZnPvaa8AnvfXQzI7Ktr/U96DpkjGA2Kofs/kvSC
 fTIiJDlU9jm/WZcA+f1cpASTiIj4BoSy76ue+8sUB6p8Rfh5KgyYcCNVB
 +tFpf/Q86W6J5bHSC3pofwqWVWro+NAdieZqcRHWOoIz4dJcWb0pmf/yu w==;
X-CSE-ConnectionGUID: TFQ2LG13QEuhJjRG+8DNmw==
X-CSE-MsgGUID: nsFjvFEVQWCaqVY8fTofLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="74951693"
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; d="scan'208";a="74951693"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2026 12:16:55 -0700
X-CSE-ConnectionGUID: Bi6e9WZjTFGfUJ6pscOXrQ==
X-CSE-MsgGUID: q0TWhhlOSjmSh9srGREixg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; d="scan'208";a="230399835"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
 by fmviesa005.fm.intel.com with ESMTP; 28 Mar 2026 12:16:52 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w6Z9N-00000000Bi1-1tAL;
 Sat, 28 Mar 2026 19:16:49 +0000
Date: Sun, 29 Mar 2026 03:16:11 +0800
From: kernel test robot <lkp@intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v3 2/3] drm/gem-dma: Use the dma_*_attr API variant
Message-ID: <202603290350.pIgD9ufQ-lkp@intel.com>
References: <20260326100248.1171828-3-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326100248.1171828-3-wenst@chromium.org>
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

Hi Chen-Yu,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on next-20260327]
[cannot apply to sunxi/sunxi/for-next linus/master v7.0-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Yu-Tsai/drm-Introduce-DRM_MODE_DUMB_KERNEL_MAP-flag/20260328-141115
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260326100248.1171828-3-wenst%40chromium.org
patch subject: [PATCH v3 2/3] drm/gem-dma: Use the dma_*_attr API variant
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20260329/202603290350.pIgD9ufQ-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260329/202603290350.pIgD9ufQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603290350.pIgD9ufQ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c:297:11: error: expected ')'
     297 |                                                     gem->dma_attrs);
         |                                                     ^
   drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c:295:31: note: to match this '('
     295 |                         ret = dma_get_sgtable_attrs(rcdu->dev, sgt, gem->vaddr,
         |                                                    ^
   1 error generated.


vim +297 drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c

   258	
   259	int rcar_du_vsp_map_fb(struct rcar_du_vsp *vsp, struct drm_framebuffer *fb,
   260			       struct sg_table sg_tables[3])
   261	{
   262		struct rcar_du_device *rcdu = vsp->dev;
   263		unsigned int i, j;
   264		int ret;
   265	
   266		for (i = 0; i < fb->format->num_planes; ++i) {
   267			struct drm_gem_dma_object *gem = drm_fb_dma_get_gem_obj(fb, i);
   268			struct sg_table *sgt = &sg_tables[i];
   269	
   270			if (gem->sgt) {
   271				struct scatterlist *src;
   272				struct scatterlist *dst;
   273	
   274				/*
   275				 * If the GEM buffer has a scatter gather table, it has
   276				 * been imported from a dma-buf and has no physical
   277				 * address as it might not be physically contiguous.
   278				 * Copy the original scatter gather table to map it to
   279				 * the VSP.
   280				 */
   281				ret = sg_alloc_table(sgt, gem->sgt->orig_nents,
   282						     GFP_KERNEL);
   283				if (ret)
   284					goto fail;
   285	
   286				src = gem->sgt->sgl;
   287				dst = sgt->sgl;
   288				for (j = 0; j < gem->sgt->orig_nents; ++j) {
   289					sg_set_page(dst, sg_page(src), src->length,
   290						    src->offset);
   291					src = sg_next(src);
   292					dst = sg_next(dst);
   293				}
   294			} else {
   295				ret = dma_get_sgtable_attrs(rcdu->dev, sgt, gem->vaddr,
   296							    gem->dma_addr, gem->base.size
 > 297							    gem->dma_attrs);
   298				if (ret)
   299					goto fail;
   300			}
   301	
   302			ret = vsp1_du_map_sg(vsp->vsp, sgt);
   303			if (ret) {
   304				sg_free_table(sgt);
   305				goto fail;
   306			}
   307		}
   308	
   309		return 0;
   310	
   311	fail:
   312		while (i--) {
   313			struct sg_table *sgt = &sg_tables[i];
   314	
   315			vsp1_du_unmap_sg(vsp->vsp, sgt);
   316			sg_free_table(sgt);
   317		}
   318	
   319		return ret;
   320	}
   321	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
