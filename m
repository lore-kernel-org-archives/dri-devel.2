Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D5B606A339
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 21:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hiHbLGgf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5850C10E203;
	Fri, 20 Nov 2026 21:18:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA4B4112D02
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 21:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795209497; x=1826745497;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=VayXO2obERxLTh/FIisCjx2Bi3BpVJ+zEUoxkoWvpiw=;
 b=hiHbLGgfAwCaRmh097WBjq/Av4qWMW7l8E7mN/mnxu4JnpXwGlAY3IWN
 1UDSXVsRi4t4tJgX0oBAFGOVX15nmkewy7d3iG7zHpNi88R0pVXA9Mylh
 q3ZhsFZUpk4jds0POfnGbNWITBKSiOXtQ/fTZEF5rpa5Cl89RSpc/xVsb
 zNz77CmRcpo0WvoeKgJBVcoirroco7CRhiIKSmaktb9XEe3PMgb2Aq8NQ
 fQ5+AZUuETPA9xJorBe+dzbUkvx21OAZJBcoO9bcAvw3Ba4y1sYtQ10SF
 VAfAMPv8GU6i6bPeffqGUF2XluboQs2E5iO/8aNCLQA0zvzEU+52uaRBZ g==;
X-CSE-ConnectionGUID: OOROy+T5SuKwEdVXDNnSjg==
X-CSE-MsgGUID: Wpt8aFjjQD+K2W7WTm4b4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4084727"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4084727"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 13:18:16 -0800
X-CSE-ConnectionGUID: BMjj23xJQqSojMr33lja1A==
X-CSE-MsgGUID: 4yEJNJXHQJ+q7NJzFHpFnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; d="scan'208";a="11364362"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa010.fm.intel.com with ESMTP; 20 Nov 2026 13:18:10 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xUVzi-00000001Iah-0bcq;
 Fri, 20 Nov 2026 21:18:06 +0000
Date: Sat, 21 Nov 2026 05:17:29 +0800
From: kernel test robot <lkp@intel.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-sound@vger.kernel.org,
 Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v2 02/11] iio: adc: stm32-mdf: add core registration
Message-ID: <202611210514.27XNsKFF-lkp@intel.com>
References: <20261118-upstream_mdf_v2-v2-2-7939d3c3720a@foss.st.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118-upstream_mdf_v2-v2-2-7939d3c3720a@foss.st.com>
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

Hi Olivier,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d922ed738439e1d5b4701df7f4cdd49a09925624]

url:    https://github.com/intel-lab-lkp/linux/commits/Olivier-Moysan/dt-bindings-iio-adc-add-stm32mp2-mdf-filter/20261118-161746
base:   d922ed738439e1d5b4701df7f4cdd49a09925624
patch link:    https://lore.kernel.org/r/20261118-upstream_mdf_v2-v2-2-7939d3c3720a%40foss.st.com
patch subject: [PATCH v2 02/11] iio: adc: stm32-mdf: add core registration
config: csky-allmodconfig (https://download.01.org/0day-ci/archive/20261121/202611210514.27XNsKFF-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261121/202611210514.27XNsKFF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611210514.27XNsKFF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/stm32-mdf-core.c:447:12: warning: 'stm32_mdf_core_runtime_resume' defined but not used [-Wunused-function]
     447 | static int stm32_mdf_core_runtime_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/adc/stm32-mdf-core.c:442:12: warning: 'stm32_mdf_core_runtime_suspend' defined but not used [-Wunused-function]
     442 | static int stm32_mdf_core_runtime_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/adc/stm32-mdf-core.c:407:12: warning: 'stm32_mdf_core_resume' defined but not used [-Wunused-function]
     407 | static int stm32_mdf_core_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/adc/stm32-mdf-core.c:388:12: warning: 'stm32_mdf_core_suspend' defined but not used [-Wunused-function]
     388 | static int stm32_mdf_core_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~


vim +/stm32_mdf_core_runtime_resume +447 drivers/iio/adc/stm32-mdf-core.c

   387	
 > 388	static int stm32_mdf_core_suspend(struct device *dev)
   389	{
   390		struct stm32_mdf *mdf = dev_get_drvdata(dev);
   391		struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);
   392		int ret;
   393	
   394		ret = pm_runtime_force_suspend(dev);
   395		if (ret)
   396			return ret;
   397	
   398		regcache_cache_only(priv->regmap, true);
   399		regcache_mark_dirty(priv->regmap);
   400	
   401		/* Balance regmap_mmio_attach_clk() clk_prepare() */
   402		clk_unprepare(priv->kclk);
   403	
   404		return pinctrl_pm_select_sleep_state(dev);
   405	}
   406	
 > 407	static int stm32_mdf_core_resume(struct device *dev)
   408	{
   409		struct stm32_mdf *mdf = dev_get_drvdata(dev);
   410		struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);
   411		int ret;
   412	
   413		ret = pinctrl_pm_select_default_state(dev);
   414		if (ret) {
   415			dev_err(dev, "Failed to set pins default state: %d\n", ret);
   416			return ret;
   417		}
   418	
   419		ret = clk_prepare(priv->kclk);
   420		if (ret) {
   421			dev_err(dev, "Failed to prepare kernel clock: %d\n", ret);
   422			goto err_clk;
   423		}
   424	
   425		regcache_cache_only(priv->regmap, false);
   426		ret = regcache_sync(priv->regmap);
   427		if (ret) {
   428			dev_err(dev, "Failed to sync cache: %d\n", ret);
   429			goto err_cache;
   430		}
   431	
   432		return pm_runtime_force_resume(dev);
   433	
   434	err_cache:
   435		clk_unprepare(priv->kclk);
   436	err_clk:
   437		pinctrl_pm_select_sleep_state(dev);
   438	
   439		return ret;
   440	}
   441	
 > 442	static int stm32_mdf_core_runtime_suspend(struct device *dev)
   443	{
   444		return 0;
   445	}
   446	
 > 447	static int stm32_mdf_core_runtime_resume(struct device *dev)
   448	{
   449		return 0;
   450	}
   451	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
