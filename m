Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9C8606A68B
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lPURuigo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB2AC10EEBF;
	Wed, 25 Nov 2026 02:06:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1794E10EEBF;
 Wed, 25 Nov 2026 02:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795572375; x=1827108375;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=J6tI0oNu5ipgac+ZyULfo7Y10gS1m3hJ23/QN8OCwxg=;
 b=lPURuigo9ihLMOXBpAf/OUH7TzGdZGKLPCypgF4aUjvSOYgdg8jPt4Al
 oJ96zBaHStNx2wzhe62KvVPFLAfgEKHNAHhx1PIrF9aq8vDdZWbl5LoZZ
 Hs4EjeqwLM+s9R17UBZpZAmFSjwcNyFuRhW8AYXruynwrqmjzLL7VXKR1
 Mhg+8URgeZDECOyB+pjPjHfxBR2BY0LgRrskZEC2IQQcmqmNO/36nCp47
 scgZwVf9JBSKQ2A6RkYWXHICNjPTnhu4N+KatCrj4wKSXIHO1XGyhV+se
 Ki4kcunUvSs2xClhceT6S84Hqq+v36LO3sBC3026Lwa5yivEtIcPMXW0C A==;
X-CSE-ConnectionGUID: 5ASUCf0kTAycTHWXfDfJqQ==
X-CSE-MsgGUID: 2TLT2F2TRMWNO0cUqG/Vvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4322166"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4322166"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 18:06:15 -0800
X-CSE-ConnectionGUID: puKRDXZcRYeLkoNKbfjorw==
X-CSE-MsgGUID: ClHvdapeSayvNMoP7nMyIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="12161971"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa009.fm.intel.com with ESMTP; 24 Nov 2026 18:06:12 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xW2Of-00000001Qg2-44Mj;
 Wed, 25 Nov 2026 02:06:09 +0000
Date: Wed, 25 Nov 2026 10:06:00 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Brown <broonie@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20261125095513.u60l5aJo-lkp@intel.com>
References: <awXJ__-grexFFPb4@sirena.org.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awXJ__-grexFFPb4@sirena.org.uk>
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

Hi Mark,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20261123]
[cannot apply to drm-tip/drm-tip linus/master v7.4-rc4 v7.4-rc3 v7.4-rc2 v7.4-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mark-Brown/linux-next-build-failure-after-merge-of-the-drm-misc-tree/20261124-173143
base:   next-20261123
patch link:    https://lore.kernel.org/r/awXJ__-grexFFPb4%40sirena.org.uk
patch subject: linux-next: build failure after merge of the drm-misc tree
config: arm64-randconfig-1002-20261125 (https://download.01.org/0day-ci/archive/20261125/20261125095513.u60l5aJo-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 2012344e5da8e03ea4b8283ecd6fad6e13f09d64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261125/20261125095513.u60l5aJo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261125095513.u60l5aJo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c:217:3: error: call to undeclared function 'dma_buf_unmap_sgt_unlocked'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     217 |                 dma_buf_unmap_sgt_unlocked(buffer->attach, buffer->sgt,
         |                 ^
   drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c:217:3: note: did you mean 'dma_buf_vunmap_unlocked'?
   include/linux/dma-buf.h:596:6: note: 'dma_buf_vunmap_unlocked' declared here
     596 | void dma_buf_vunmap_unlocked(struct dma_buf *dmabuf, struct iosys_map *map);
         |      ^
>> drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c:437:8: error: call to undeclared function 'dma_buf_map_sgt_unlocked'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     437 |         sgt = dma_buf_map_sgt_unlocked(attach, DMA_BIDIRECTIONAL);
         |               ^
   drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c:437:8: note: did you mean 'dma_buf_vmap_unlocked'?
   include/linux/dma-buf.h:595:5: note: 'dma_buf_vmap_unlocked' declared here
     595 | int dma_buf_vmap_unlocked(struct dma_buf *dmabuf, struct iosys_map *map);
         |     ^
   drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c:437:6: error: incompatible integer to pointer conversion assigning to 'struct sg_table *' from 'int' [-Wint-conversion]
     437 |         sgt = dma_buf_map_sgt_unlocked(attach, DMA_BIDIRECTIONAL);
         |             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c:552:3: error: call to undeclared function 'dma_buf_unmap_sgt_unlocked'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     552 |                 dma_buf_unmap_sgt_unlocked(attach, sgt, DMA_BIDIRECTIONAL);
         |                 ^
   4 errors generated.


vim +/dma_buf_unmap_sgt_unlocked +217 drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c

   208	
   209	/*
   210	 * Cleans up imported dmabuf.
   211	 * Should be called with mutex held.
   212	 */
   213	static void vc_sm_clean_up_dmabuf(struct vc_sm_buffer *buffer)
   214	{
   215		/* Handle cleaning up imported dmabufs */
   216		if (buffer->sgt) {
 > 217			dma_buf_unmap_sgt_unlocked(buffer->attach, buffer->sgt,
   218						   DMA_BIDIRECTIONAL);
   219			buffer->sgt = NULL;
   220		}
   221		if (buffer->attach) {
   222			dma_buf_detach(buffer->imported_dma_buf, buffer->attach);
   223			buffer->attach = NULL;
   224		}
   225	}
   226	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
