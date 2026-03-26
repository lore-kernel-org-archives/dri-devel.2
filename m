Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4BB109E52B
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 01:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E1C010E167;
	Thu, 26 Mar 2026 01:24:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gLMpKjxp";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5270610E112
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 01:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774488295; x=1806024295;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Eq6Xay26AJu925QH9dEoTNSTESWdI6fBXbTFQNVzJrc=;
 b=gLMpKjxptrQNrHE17huAy6AKgAjYqZVyFwQt3OfyiEICWLmIrr3t7S9+
 ixJCGAms66MnGBtbVLuAAZ/oP4qFKHLWWc7qyYTSVEvLUSEYt27LGg0OK
 EiYqd+SnRB4bGWekxFYNtWm0UbdUAu/6gwwie8pW6jLtG0xeaGaWBdxtB
 cpH3UvgA2aMXMRETlzEs5Uy/pizePCwJVe6ObiMuPxqboj0VobWD9GXLz
 1GNFJG+AlPzn32rMdmGBd11vYQ2mIpGmfkUrqMGmSVMtWbFGaWM2npspN
 N/tFzJkRUA//vOpjBUUMceGRux4rD1MGUUy6zgU/i85gSxUZeRwZVuKVA Q==;
X-CSE-ConnectionGUID: P09vzeyjS2etf5qpJORfcQ==
X-CSE-MsgGUID: ymKzWds9SdqONo3LQzQw4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="78135434"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="78135434"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 18:24:55 -0700
X-CSE-ConnectionGUID: Q+MclzIbSm+lrW2N1XA8Fw==
X-CSE-MsgGUID: ZoLMXqn5RwaIMsxxafBSzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="225107174"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
 by orviesa007.jf.intel.com with ESMTP; 25 Mar 2026 18:24:50 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w5ZSo-000000007xp-25Yb;
 Thu, 26 Mar 2026 01:24:46 +0000
Date: Thu, 26 Mar 2026 09:24:18 +0800
From: kernel test robot <lkp@intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] clk: mediatek: Add mt8173-mfgtop driver
Message-ID: <202603260926.gAEaAK0A-lkp@intel.com>
References: <20260325071951.544031-3-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325071951.544031-3-wenst@chromium.org>
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

[auto build test ERROR on clk/clk-next]
[also build test ERROR on robh/for-next drm-misc/drm-misc-next linus/master v7.0-rc5 next-20260325]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Yu-Tsai/dt-bindings-clock-mediatek-Add-mt8173-mfgtop/20260325-202618
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20260325071951.544031-3-wenst%40chromium.org
patch subject: [PATCH v2 2/5] clk: mediatek: Add mt8173-mfgtop driver
config: loongarch-randconfig-002-20260326 (https://download.01.org/0day-ci/archive/20260326/202603260926.gAEaAK0A-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260326/202603260926.gAEaAK0A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603260926.gAEaAK0A-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pmdomain/governor.c: In function 'default_suspend_ok':
>> drivers/pmdomain/governor.c:88:24: error: 'struct dev_pm_info' has no member named 'ignore_children'
      88 |         if (!dev->power.ignore_children)
         |                        ^
--
   drivers/pmdomain/core.c: In function 'genpd_queue_power_off_work':
>> drivers/pmdomain/core.c:941:20: error: 'pm_wq' undeclared (first use in this function)
     941 |         queue_work(pm_wq, &genpd->power_off_work);
         |                    ^~~~~
   drivers/pmdomain/core.c:941:20: note: each undeclared identifier is reported only once for each function it appears in
   drivers/pmdomain/core.c: In function 'genpd_dev_pm_qos_notifier':
>> drivers/pmdomain/core.c:1138:39: error: 'struct dev_pm_info' has no member named 'ignore_children'
    1138 |                 if (!dev || dev->power.ignore_children)
         |                                       ^
   drivers/pmdomain/core.c: In function 'rtpm_status_str':
>> drivers/pmdomain/core.c:3614:23: error: 'struct dev_pm_info' has no member named 'runtime_error'
    3614 |         if (dev->power.runtime_error)
         |                       ^
>> drivers/pmdomain/core.c:3616:28: error: 'struct dev_pm_info' has no member named 'disable_depth'
    3616 |         else if (dev->power.disable_depth)
         |                            ^
>> drivers/pmdomain/core.c:3618:28: error: 'struct dev_pm_info' has no member named 'runtime_status'
    3618 |         else if (dev->power.runtime_status < ARRAY_SIZE(status_lookup))
         |                            ^
   drivers/pmdomain/core.c:3619:45: error: 'struct dev_pm_info' has no member named 'runtime_status'
    3619 |                 p = status_lookup[dev->power.runtime_status];
         |                                             ^

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS
   Depends on [n]: PM [=n]
   Selected by [m]:
   - COMMON_CLK_MT8173_MFGTOP [=m] && COMMON_CLK [=y] && (ARCH_MEDIATEK || COMPILE_TEST [=y]) && COMMON_CLK_MT8173 [=m]


vim +88 drivers/pmdomain/governor.c

a5bef810ad9816 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-04-29   49  
b02c999ac325e9 drivers/base/power/domain_governor.c Rafael J. Wysocki 2011-12-01   50  /**
9df3921e026532 drivers/base/power/domain_governor.c Ulf Hansson       2016-03-31   51   * default_suspend_ok - Default PM domain governor routine to suspend devices.
b02c999ac325e9 drivers/base/power/domain_governor.c Rafael J. Wysocki 2011-12-01   52   * @dev: Device to check.
3b2714c5d2d26d drivers/base/power/domain_governor.c Randy Dunlap      2023-12-05   53   *
3b2714c5d2d26d drivers/base/power/domain_governor.c Randy Dunlap      2023-12-05   54   * Returns: true if OK to suspend, false if not OK to suspend
b02c999ac325e9 drivers/base/power/domain_governor.c Rafael J. Wysocki 2011-12-01   55   */
9df3921e026532 drivers/base/power/domain_governor.c Ulf Hansson       2016-03-31   56  static bool default_suspend_ok(struct device *dev)
b02c999ac325e9 drivers/base/power/domain_governor.c Rafael J. Wysocki 2011-12-01   57  {
66d29d802ef3bf drivers/base/power/domain_governor.c Ulf Hansson       2022-05-11   58  	struct gpd_timing_data *td = dev_gpd_data(dev)->td;
6ff7bb0d02f829 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-05-01   59  	unsigned long flags;
a5bef810ad9816 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-04-29   60  	s64 constraint_ns;
b02c999ac325e9 drivers/base/power/domain_governor.c Rafael J. Wysocki 2011-12-01   61  
b02c999ac325e9 drivers/base/power/domain_governor.c Rafael J. Wysocki 2011-12-01   62  	dev_dbg(dev, "%s()\n", __func__);
b02c999ac325e9 drivers/base/power/domain_governor.c Rafael J. Wysocki 2011-12-01   63  
6ff7bb0d02f829 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-05-01   64  	spin_lock_irqsave(&dev->power.lock, flags);
6ff7bb0d02f829 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-05-01   65  
6ff7bb0d02f829 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-05-01   66  	if (!td->constraint_changed) {
9df3921e026532 drivers/base/power/domain_governor.c Ulf Hansson       2016-03-31   67  		bool ret = td->cached_suspend_ok;
6ff7bb0d02f829 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-05-01   68  
6ff7bb0d02f829 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-05-01   69  		spin_unlock_irqrestore(&dev->power.lock, flags);
6ff7bb0d02f829 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-05-01   70  		return ret;
6ff7bb0d02f829 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-05-01   71  	}
6ff7bb0d02f829 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-05-01   72  	td->constraint_changed = false;
9df3921e026532 drivers/base/power/domain_governor.c Ulf Hansson       2016-03-31   73  	td->cached_suspend_ok = false;
0759e80b84e34a drivers/base/power/domain_governor.c Rafael J. Wysocki 2017-11-07   74  	td->effective_constraint_ns = 0;
8262331eaaf751 drivers/base/power/domain_governor.c Viresh Kumar      2019-07-04   75  	constraint_ns = __dev_pm_qos_resume_latency(dev);
6ff7bb0d02f829 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-05-01   76  
6ff7bb0d02f829 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-05-01   77  	spin_unlock_irqrestore(&dev->power.lock, flags);
6ff7bb0d02f829 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-05-01   78  
0759e80b84e34a drivers/base/power/domain_governor.c Rafael J. Wysocki 2017-11-07   79  	if (constraint_ns == 0)
a5bef810ad9816 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-04-29   80  		return false;
a5bef810ad9816 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-04-29   81  
a5bef810ad9816 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-04-29   82  	constraint_ns *= NSEC_PER_USEC;
a5bef810ad9816 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-04-29   83  	/*
a5bef810ad9816 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-04-29   84  	 * We can walk the children without any additional locking, because
6ff7bb0d02f829 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-05-01   85  	 * they all have been suspended at this point and their
6ff7bb0d02f829 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-05-01   86  	 * effective_constraint_ns fields won't be modified in parallel with us.
a5bef810ad9816 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-04-29   87  	 */
a5bef810ad9816 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-04-29  @88  	if (!dev->power.ignore_children)
a5bef810ad9816 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-04-29   89  		device_for_each_child(dev, &constraint_ns,
a5bef810ad9816 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-04-29   90  				      dev_update_qos_constraint);
b02c999ac325e9 drivers/base/power/domain_governor.c Rafael J. Wysocki 2011-12-01   91  
0759e80b84e34a drivers/base/power/domain_governor.c Rafael J. Wysocki 2017-11-07   92  	if (constraint_ns == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS) {
704d2ce6603f7e drivers/base/power/domain_governor.c Rafael J. Wysocki 2017-11-07   93  		/* "No restriction", so the device is allowed to suspend. */
0759e80b84e34a drivers/base/power/domain_governor.c Rafael J. Wysocki 2017-11-07   94  		td->effective_constraint_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
704d2ce6603f7e drivers/base/power/domain_governor.c Rafael J. Wysocki 2017-11-07   95  		td->cached_suspend_ok = true;
0759e80b84e34a drivers/base/power/domain_governor.c Rafael J. Wysocki 2017-11-07   96  	} else if (constraint_ns == 0) {
704d2ce6603f7e drivers/base/power/domain_governor.c Rafael J. Wysocki 2017-11-07   97  		/*
704d2ce6603f7e drivers/base/power/domain_governor.c Rafael J. Wysocki 2017-11-07   98  		 * This triggers if one of the children that don't belong to a
0759e80b84e34a drivers/base/power/domain_governor.c Rafael J. Wysocki 2017-11-07   99  		 * domain has a zero PM QoS constraint and it's better not to
0759e80b84e34a drivers/base/power/domain_governor.c Rafael J. Wysocki 2017-11-07  100  		 * suspend then.  effective_constraint_ns is zero already and
0759e80b84e34a drivers/base/power/domain_governor.c Rafael J. Wysocki 2017-11-07  101  		 * cached_suspend_ok is false, so bail out.
704d2ce6603f7e drivers/base/power/domain_governor.c Rafael J. Wysocki 2017-11-07  102  		 */
704d2ce6603f7e drivers/base/power/domain_governor.c Rafael J. Wysocki 2017-11-07  103  		return false;
704d2ce6603f7e drivers/base/power/domain_governor.c Rafael J. Wysocki 2017-11-07  104  	} else {
2b1d88cda32f81 drivers/base/power/domain_governor.c Ulf Hansson       2015-10-15  105  		constraint_ns -= td->suspend_latency_ns +
2b1d88cda32f81 drivers/base/power/domain_governor.c Ulf Hansson       2015-10-15  106  				td->resume_latency_ns;
704d2ce6603f7e drivers/base/power/domain_governor.c Rafael J. Wysocki 2017-11-07  107  		/*
0759e80b84e34a drivers/base/power/domain_governor.c Rafael J. Wysocki 2017-11-07  108  		 * effective_constraint_ns is zero already and cached_suspend_ok
0759e80b84e34a drivers/base/power/domain_governor.c Rafael J. Wysocki 2017-11-07  109  		 * is false, so if the computed value is not positive, return
0759e80b84e34a drivers/base/power/domain_governor.c Rafael J. Wysocki 2017-11-07  110  		 * right away.
704d2ce6603f7e drivers/base/power/domain_governor.c Rafael J. Wysocki 2017-11-07  111  		 */
704d2ce6603f7e drivers/base/power/domain_governor.c Rafael J. Wysocki 2017-11-07  112  		if (constraint_ns <= 0)
a5bef810ad9816 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-04-29  113  			return false;
704d2ce6603f7e drivers/base/power/domain_governor.c Rafael J. Wysocki 2017-11-07  114  
a5bef810ad9816 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-04-29  115  		td->effective_constraint_ns = constraint_ns;
704d2ce6603f7e drivers/base/power/domain_governor.c Rafael J. Wysocki 2017-11-07  116  		td->cached_suspend_ok = true;
704d2ce6603f7e drivers/base/power/domain_governor.c Rafael J. Wysocki 2017-11-07  117  	}
a98f1b78ecf325 drivers/base/power/domain_governor.c Ulf Hansson       2015-10-13  118  
a5bef810ad9816 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-04-29  119  	/*
a5bef810ad9816 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-04-29  120  	 * The children have been suspended already, so we don't need to take
9df3921e026532 drivers/base/power/domain_governor.c Ulf Hansson       2016-03-31  121  	 * their suspend latencies into account here.
a5bef810ad9816 drivers/base/power/domain_governor.c Rafael J. Wysocki 2012-04-29  122  	 */
9df3921e026532 drivers/base/power/domain_governor.c Ulf Hansson       2016-03-31  123  	return td->cached_suspend_ok;
b02c999ac325e9 drivers/base/power/domain_governor.c Rafael J. Wysocki 2011-12-01  124  }
b02c999ac325e9 drivers/base/power/domain_governor.c Rafael J. Wysocki 2011-12-01  125  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
