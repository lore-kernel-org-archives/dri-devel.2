Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B76606A325
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hpuPhNty
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 383F210E5F7;
	Tue, 20 Oct 2026 22:45:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60EF110E5F7
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 22:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792536312; x=1824072312;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=4qZsjXfVDronkzI5htlpTGEiOv4YO+QDYYMog/2uT5U=;
 b=hpuPhNtyG433z7do0RMqVI1+1Ca+nwYLYhHjcjuPQbAS+yzK5MVOT/ai
 +O7TlUSH/WjSayBgJNwHCQPuIA6pYjhawbhSjh3ciQDVdixNjJLgOvJt1
 82aAC6KOTvcAYbGes21ewCmxdJAnqnqiZHrKctcPaBoRAkiQvdztnp/lL
 yNsDihpXthaL5w39ia8QDE5+ImJVwqXkbo5JZqbR3a+RNPParenZVIL9Y
 bkzR53Ym0XskpfslGvFEy7yD5DjRJFgv/bGQxI2URF+iDvsCqB9454m54
 mZhZDHyU/S1CtX3iSu1mvY2IfOSltEbFo+WIcat1PMZPFWNKyuD9EPOcB w==;
X-CSE-ConnectionGUID: tlnV0a2qSiCH4/8HEU3BOQ==
X-CSE-MsgGUID: hBn6dbM2RjWKFqyIWMVtZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1263064"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1263064"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 15:45:11 -0700
X-CSE-ConnectionGUID: naZfbzKAQxWKEBuQXOviSw==
X-CSE-MsgGUID: 7/2ocfsSQbazXZov9lQ3BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2990709"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa005.fm.intel.com with ESMTP; 20 Oct 2026 15:45:06 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xJIZq-00000000Oby-3GFd;
 Tue, 20 Oct 2026 22:45:02 +0000
Date: Wed, 21 Oct 2026 06:44:18 +0800
From: kernel test robot <lkp@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 6/7] drm/panel: Add Hitachi TX10D07VM0BAA MIPI DBI
 Type B panel driver
Message-ID: <202610210605.HdtW8SAP-lkp@intel.com>
References: <20261019095705.91062-7-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261019095705.91062-7-clamor95@gmail.com>
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

Hi Svyatoslav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on drm/drm-next linus/master v7.3 next-20261019]
[cannot apply to tegra/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Svyatoslav-Ryhel/drm-tegra-dc-Expand-available-registers-layouts/20261019-125659
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20261019095705.91062-7-clamor95%40gmail.com
patch subject: [PATCH v3 6/7] drm/panel: Add Hitachi TX10D07VM0BAA MIPI DBI Type B panel driver
config: arm64-randconfig-1002-20261021 (https://download.01.org/0day-ci/archive/20261021/202610210605.HdtW8SAP-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 2c419645e808a6667eee9dbb16c828f77e2fd2f0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261021/202610210605.HdtW8SAP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610210605.HdtW8SAP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/drm_mipi_dbi.c:79:17: warning: unused variable 'mipi_dbi_dcs_read_commands' [-Wunused-const-variable]
      79 | static const u8 mipi_dbi_dcs_read_commands[] = {
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/mipi_dbi_dcs_read_commands +79 drivers/gpu/drm/drm_mipi_dbi.c

02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   78  
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22  @79  static const u8 mipi_dbi_dcs_read_commands[] = {
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   80  	MIPI_DCS_GET_DISPLAY_ID,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   81  	MIPI_DCS_GET_RED_CHANNEL,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   82  	MIPI_DCS_GET_GREEN_CHANNEL,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   83  	MIPI_DCS_GET_BLUE_CHANNEL,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   84  	MIPI_DCS_GET_DISPLAY_STATUS,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   85  	MIPI_DCS_GET_POWER_MODE,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   86  	MIPI_DCS_GET_ADDRESS_MODE,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   87  	MIPI_DCS_GET_PIXEL_FORMAT,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   88  	MIPI_DCS_GET_DISPLAY_MODE,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   89  	MIPI_DCS_GET_SIGNAL_MODE,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   90  	MIPI_DCS_GET_DIAGNOSTIC_RESULT,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   91  	MIPI_DCS_READ_MEMORY_START,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   92  	MIPI_DCS_READ_MEMORY_CONTINUE,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   93  	MIPI_DCS_GET_SCANLINE,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   94  	MIPI_DCS_GET_DISPLAY_BRIGHTNESS,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   95  	MIPI_DCS_GET_CONTROL_DISPLAY,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   96  	MIPI_DCS_GET_POWER_SAVE,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   97  	MIPI_DCS_GET_CABC_MIN_BRIGHTNESS,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   98  	MIPI_DCS_READ_DDB_START,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   99  	MIPI_DCS_READ_DDB_CONTINUE,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22  100  	0, /* sentinel */
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22  101  };
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22  102  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
