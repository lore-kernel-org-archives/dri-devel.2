Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29CA606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P9AvNkWS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CF3810E606;
	Fri, 23 Oct 2026 09:47:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5382610E606
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792748826; x=1824284826;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gQ9nQ7BayhpQi7/501DcO0lJ2Sxa5ZeozNJ37s/HH+M=;
 b=P9AvNkWSa9Qs+tEOhMvWH1bdVlJMNnZHhLpr2dVLpO+PNZkmEzuLtjlu
 BCuug3MQ0zias7X9rXRL/6qO1M+aB1hld7otQeF+lHdyBgDaN9x4aYIWG
 d3sVSFfaIpHyhFlVtOm4vIZKO4QnqxWJJxFJ7U8NKiPD4cI63RDmVgMI4
 rya27TkHZQevyRPRgH2E36YQVpxz3Tspu5Y1vrnRIMami+G4z10vNo1Hs
 LSumaMpDHIz4z8B3ExfXkdhpCWW7nKoutOzwhhwOGoTlkRyxVJF1RYXcH
 dZfGZNJENfPWtd9qlzWXUZlLtU9f4U3G+VA8s+DcUttxJCaFqiWEvAR79 g==;
X-CSE-ConnectionGUID: 75MV8lS8TluZ+qb4lKM19g==
X-CSE-MsgGUID: KGKVVZXCQl2dlu8AxGllnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1383347"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1383347"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 02:47:05 -0700
X-CSE-ConnectionGUID: CtmiaNT2Qe610YGnKfB18Q==
X-CSE-MsgGUID: 72CUuvjpQs6P+tCXdd0VJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3691885"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa003.fm.intel.com with ESMTP; 23 Oct 2026 02:47:01 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xKBrW-00000000SVu-2fyk;
 Fri, 23 Oct 2026 09:46:58 +0000
Date: Fri, 23 Oct 2026 17:46:48 +0800
From: kernel test robot <lkp@intel.com>
To: Lars Rask <lars.rask@axis.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kernel@axis.com, Lars Rask <lars.rask@axis.com>
Subject: Re: [PATCH 1/2] drm/sitronix/st7571-spi: Add support for ST75156
 controller
Message-ID: <202610231738.0gNssMIn-lkp@intel.com>
References: <20261022-add_st75156_support-v1-1-582525a39a39@axis.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022-add_st75156_support-v1-1-582525a39a39@axis.com>
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Lars,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8d3ae59288f1e7d58d76558a6ee96d533bc5019f]

url:    https://github.com/intel-lab-lkp/linux/commits/Lars-Rask/drm-sitronix-st7571-spi-Add-support-for-ST75156-controller/20261022-173105
base:   8d3ae59288f1e7d58d76558a6ee96d533bc5019f
patch link:    https://lore.kernel.org/r/20261022-add_st75156_support-v1-1-582525a39a39%40axis.com
patch subject: [PATCH 1/2] drm/sitronix/st7571-spi: Add support for ST75156 controller
config: i386-buildonly-randconfig-1001-20261023 (https://download.01.org/0day-ci/archive/20261023/202610231738.0gNssMIn-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261023/202610231738.0gNssMIn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610231738.0gNssMIn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/sitronix/st7571-spi.c:121:43: warning: variable 'regmap' is uninitialized when used here [-Wuninitialized]
     121 |                 return dev_err_probe(&spi->dev, PTR_ERR(regmap),
         |                                                         ^~~~~~
   drivers/gpu/drm/sitronix/st7571-spi.c:116:23: note: initialize the variable 'regmap' to silence this warning
     116 |         struct regmap *regmap;
         |                              ^
         |                               = NULL
   1 warning generated.


vim +/regmap +121 drivers/gpu/drm/sitronix/st7571-spi.c

   112	
   113	static int st7571_spi_probe(struct spi_device *spi)
   114	{
   115		struct st7571_device *st7571;
   116		struct regmap *regmap;
   117		struct spi_device_data *spi_data;
   118	
   119		spi_data = devm_kzalloc(&spi->dev, sizeof(*spi_data), GFP_KERNEL);
   120		if (IS_ERR(spi_data))
 > 121			return dev_err_probe(&spi->dev, PTR_ERR(regmap),
   122					     "Failed to initialize spi data\n");
   123	
   124		spi_data->spi = spi;
   125		spi_data->dc_gpio = devm_gpiod_get(&spi->dev, "dc", GPIOD_OUT_LOW);
   126	
   127		if (IS_ERR(spi_data->dc_gpio))
   128			/* init regmap for 3 line SPI */
   129			regmap = devm_regmap_init_spi(spi, &st7571_spi_regmap_config);
   130		else
   131			/* init regmap for 4 line SPI */
   132			regmap = devm_regmap_init(&spi->dev, &regmap_spi_dc_bus,
   133						  spi_data, &st7571_spi_regmap_config);
   134	
   135		if (IS_ERR(regmap))
   136			return dev_err_probe(&spi->dev, PTR_ERR(regmap),
   137					     "Failed to initialize regmap\n");
   138	
   139		st7571 = st7571_probe(&spi->dev, regmap);
   140		if (IS_ERR(st7571))
   141			return dev_err_probe(&spi->dev, PTR_ERR(st7571),
   142					     "Failed to initialize regmap\n");
   143	
   144		st7571->spi_data = spi_data;
   145		spi_set_drvdata(spi, st7571);
   146	
   147		return 0;
   148	}
   149	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
