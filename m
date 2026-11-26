Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60465606A32E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TfsMYLPm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0ABF1125DC;
	Thu, 26 Nov 2026 16:45:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9158F1125DC
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795711499; x=1827247499;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=u6RrqXr5k7GIgp+/6Jmq+EmTixoza/s1U4UKEnhwwJ0=;
 b=TfsMYLPm/IoWMeIFQAYXnwHt1p7wjCPqfSYxDxMDXpU6o2Z3Lmgo5FnO
 zkh7J7euVUr9pj5Hi7gC8ERhQj9/p1f3iuJA60kNKEpUm47HpFCeJ0/JD
 Bryf2a5Fv+hjP2QSCMgfhNtHxNDgMeh6rmAAD47k/tMiaw5bzEJSP/0Se
 KoP+yWFNYQZHs670svdT9otGTLzPy8cbmYdi83AhIfTjmdnFLb5oRUc9D
 s7C+G6hR4S7Post5uCP5e0QeQMu2dRFLoBIRhHjZUFr+A3FYNDvRrh/BO
 Iq9+kK2LPojeion0u91pSSdKiQOAapPmhC6HsAOOftv0kUmIz4geY5q+/ Q==;
X-CSE-ConnectionGUID: Ma1gTg2tRaWo4TP5R178yw==
X-CSE-MsgGUID: rO0cAVDLTMOUXnscCVov3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4536153"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4536153"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 08:44:59 -0800
X-CSE-ConnectionGUID: zjY3Oa3MQ4KN4+1MUlfLAQ==
X-CSE-MsgGUID: LQZ7A0CRRuyfMPUOXuK6Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="13894613"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa012.fm.intel.com with ESMTP; 26 Nov 2026 08:44:54 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xWcaY-00000001UTe-30KN;
 Thu, 26 Nov 2026 16:44:50 +0000
Date: Fri, 27 Nov 2026 00:44:33 +0800
From: kernel test robot <lkp@intel.com>
To: Abhash Kumar Jha <a-kumar2@ti.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 devarsht@ti.com, u-kumar1@ti.com, sjakhade@cadence.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, s-jain1@ti.com, y-d@ti.com,
 tomi.valkeinen@ideasonboard.com, benjamin.robin@bootlin.com
Subject: Re: [PATCH v4] drm/bridge: cdns-mhdp8546: Add suspend resume support
 to the bridge driver
Message-ID: <20261127003802.xAjhLSPU-lkp@intel.com>
References: <20261126060532.2379444-1-a-kumar2@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126060532.2379444-1-a-kumar2@ti.com>
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

Hi Abhash,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v7.4-rc4 next-20261125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abhash-Kumar-Jha/drm-bridge-cdns-mhdp8546-Add-suspend-resume-support-to-the-bridge-driver/20261126-113532
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20261126060532.2379444-1-a-kumar2%40ti.com
patch subject: [PATCH v4] drm/bridge: cdns-mhdp8546: Add suspend resume support to the bridge driver
config: x86_64-buildonly-randconfig-1005-20261126 (https://download.01.org/0day-ci/archive/20261127/20261127003802.xAjhLSPU-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261127/20261127003802.xAjhLSPU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261127003802.xAjhLSPU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c:2322:14: error: no member named 'no_hpd' in 'struct cdns_mhdp_device'
    2322 |                 if (!mhdp->no_hpd)
         |                      ~~~~  ^
   1 error generated.


vim +2322 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c

  2259	
  2260	static int cdns_mhdp_resume(struct device *dev)
  2261	{
  2262		struct cdns_mhdp_device *mhdp = dev_get_drvdata(dev);
  2263		unsigned int keep_alive, keep_alive_inc;
  2264		unsigned long rate;
  2265		int ret;
  2266	
  2267		ret = clk_prepare_enable(mhdp->clk);
  2268		if (ret)
  2269			return ret;
  2270	
  2271		rate = clk_get_rate(mhdp->clk);
  2272		writel(rate % 1000000, mhdp->regs + CDNS_SW_CLK_L);
  2273		writel(rate / 1000000, mhdp->regs + CDNS_SW_CLK_H);
  2274		writel(~0, mhdp->regs + CDNS_APB_INT_MASK);
  2275	
  2276		ret = phy_init(mhdp->phy);
  2277		if (ret) {
  2278			dev_err(mhdp->dev, "Failed to initialize PHY: %d\n", ret);
  2279			goto disable_clk;
  2280		}
  2281		ret = phy_power_on(mhdp->phy);
  2282		if (ret < 0) {
  2283			dev_err(mhdp->dev, "Failed to power on PHY: %d\n", ret);
  2284			goto phy_exit;
  2285		}
  2286	
  2287		/*
  2288		 * The KEEP_ALIVE register is incremented at every scheduler loop of the
  2289		 * firmware. If it changes between reads, the firmware is still running
  2290		 * (e.g. the suspend was aborted) and only needs to be activated. If it
  2291		 * does not change, the bridge lost power and the firmware must be loaded
  2292		 * again.
  2293		 */
  2294		keep_alive = readl(mhdp->regs + CDNS_KEEP_ALIVE) & CDNS_KEEP_ALIVE_MASK;
  2295		ret = readl_poll_timeout(mhdp->regs + CDNS_KEEP_ALIVE, keep_alive_inc,
  2296					 (keep_alive_inc & CDNS_KEEP_ALIVE_MASK) != keep_alive,
  2297					 2000, 2 * CDNS_KEEP_ALIVE_TIMEOUT);
  2298		if (ret) {
  2299			ret = cdns_mhdp_load_firmware(mhdp);
  2300			if (ret)
  2301				goto phy_off;
  2302	
  2303			ret = wait_event_timeout(mhdp->fw_load_wq,
  2304						 mhdp->hw_state == MHDP_HW_READY,
  2305						 msecs_to_jiffies(1000));
  2306			if (ret == 0) {
  2307				dev_err(mhdp->dev, "%s: Timeout waiting for fw loading\n",
  2308					__func__);
  2309				ret = -ETIMEDOUT;
  2310				goto phy_off;
  2311			}
  2312		} else {
  2313			ret = cdns_mhdp_set_firmware_active(mhdp, true);
  2314			if (ret) {
  2315				dev_err(mhdp->dev, "Failed to activate firmware (%pe)\n",
  2316					ERR_PTR(ret));
  2317				goto phy_off;
  2318			}
  2319	
  2320			spin_lock(&mhdp->start_lock);
  2321			mhdp->hw_state = MHDP_HW_READY;
> 2322			if (!mhdp->no_hpd)
  2323				cdns_mhdp_bridge_hpd_enable(&mhdp->bridge);
  2324			spin_unlock(&mhdp->start_lock);
  2325		}
  2326	
  2327		return 0;
  2328	
  2329	phy_off:
  2330		phy_power_off(mhdp->phy);
  2331	phy_exit:
  2332		phy_exit(mhdp->phy);
  2333	disable_clk:
  2334		clk_disable_unprepare(mhdp->clk);
  2335	
  2336		return ret;
  2337	}
  2338	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
