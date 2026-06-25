Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9311CDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29B7510F1C8;
	Thu, 25 Jun 2026 13:53:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="P+ijcK4G";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F8D810F1C8
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782395637; x=1813931637;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3gWE6pRjmf5/L6XWnC/tL1qHBu5WeuMP/6/gGEEEuw8=;
 b=P+ijcK4GfnVRUfE1ZcdTUNrcYkXZVxytKe4XpjHFT2wcGNqjvQynGa+J
 y9juChZ2xY3auu1YZzwtlZis96oN0GYzelfK8K/ZAMweTaeHCGgiv3Pfr
 NGAZFzOileAGvgn7TtAR7uNboytmzEegiv9T7Flj/4LGeoIeL2mgthVcU
 +JC71LkIMe8mPUb9S2vq5AueDyZod9vCKj+sOR1+0AfKjYOjZb3QnXBlO
 U3RKzXv4gEN97Jh3t7LdW+DE9NsNXQiNVrqfxwtmUTYYEnAl75D/3+nq+
 YYhO6IlZvTg9jHx1EqOVzLwVybzE+BXEQBmRAwuBk2hEhPwOCsHSQUabi A==;
X-CSE-ConnectionGUID: 558MxfF4Qn+xgBO94mqmBg==
X-CSE-MsgGUID: /FZh+gbXSIqRstq5v2SckQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83055823"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="83055823"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 06:53:56 -0700
X-CSE-ConnectionGUID: KXNGTLFPTSmmQt5eKAQ+dA==
X-CSE-MsgGUID: 1RD6EuwfTpGnvlK/Rk39WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="248158427"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
 by fmviesa008.fm.intel.com with ESMTP; 25 Jun 2026 06:53:53 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wckWd-000000004AL-0Nhy;
 Thu, 25 Jun 2026 13:53:51 +0000
Date: Thu, 25 Jun 2026 21:53:26 +0800
From: kernel test robot <lkp@intel.com>
To: suryasaimadhu <suryasaimadhu369@gmail.com>, andy@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, suryasaimadhu <suryasaimadhu369@gmail.com>
Subject: Re: [PATCH] staging: fbtft: fix unaligned vmem writes when txbuf is
 byte-offset
Message-ID: <202606252144.F56jkpaD-lkp@intel.com>
References: <20260625110237.304435-1-suryasaimadhu369@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625110237.304435-1-suryasaimadhu369@gmail.com>
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

Hi suryasaimadhu,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/suryasaimadhu/staging-fbtft-fix-unaligned-vmem-writes-when-txbuf-is-byte-offset/20260625-190423
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20260625110237.304435-1-suryasaimadhu369%40gmail.com
patch subject: [PATCH] staging: fbtft: fix unaligned vmem writes when txbuf is byte-offset
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260625/202606252144.F56jkpaD-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 6cc609bb250b21b47fc7d394b4019101e9983597)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260625/202606252144.F56jkpaD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606252144.F56jkpaD-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/fbtft/fbtft-bus.c:157:4: error: call to undeclared function 'put_unaligned'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     157 |                         put_unaligned(cpu_to_be16(vmem16[i]), &txbuf16[i]);
         |                         ^
   1 error generated.


vim +/put_unaligned +157 drivers/staging/fbtft/fbtft-bus.c

   113	
   114	/*****************************************************************************
   115	 *
   116	 *   int (*write_vmem)(struct fbtft_par *par);
   117	 *
   118	 *****************************************************************************/
   119	
   120	/* 16 bit pixel over 8-bit databus */
   121	int fbtft_write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
   122	{
   123		u16 *vmem16;
   124		__be16 *txbuf16 = par->txbuf.buf;
   125		size_t remain;
   126		size_t to_copy;
   127		size_t tx_array_size;
   128		int i;
   129		int ret = 0;
   130		size_t startbyte_size = 0;
   131	
   132		remain = len / 2;
   133		vmem16 = (u16 *)(par->info->screen_buffer + offset);
   134	
   135		gpiod_set_value(par->gpio.dc, 1);
   136	
   137		/* non buffered write */
   138		if (!par->txbuf.buf)
   139			return par->fbtftops.write(par, vmem16, len);
   140	
   141		/* buffered write */
   142		tx_array_size = par->txbuf.len / 2;
   143	
   144		if (par->startbyte) {
   145			txbuf16 = par->txbuf.buf + 1;
   146			tx_array_size -= 2;
   147			*(u8 *)(par->txbuf.buf) = par->startbyte | 0x2;
   148			startbyte_size = 1;
   149		}
   150	
   151		while (remain) {
   152			to_copy = min(tx_array_size, remain);
   153			dev_dbg(par->info->device, "to_copy=%zu, remain=%zu\n",
   154				to_copy, remain - to_copy);
   155	
   156			for (i = 0; i < to_copy; i++)
 > 157				put_unaligned(cpu_to_be16(vmem16[i]), &txbuf16[i]);
   158	
   159			vmem16 = vmem16 + to_copy;
   160			ret = par->fbtftops.write(par, par->txbuf.buf,
   161							startbyte_size + to_copy * 2);
   162			if (ret < 0)
   163				return ret;
   164			remain -= to_copy;
   165		}
   166	
   167		return ret;
   168	}
   169	EXPORT_SYMBOL(fbtft_write_vmem16_bus8);
   170	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
