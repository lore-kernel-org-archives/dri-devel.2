Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC3E1094486
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 16:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F8DA10E04A;
	Sat, 21 Mar 2026 16:15:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Q7CsMcGJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3678F10E246
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 16:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774109739; x=1805645739;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=OfE6e8ObAXCUI3jTK/wiihBdS6FMdzwBM2QqFsHc6ds=;
 b=Q7CsMcGJkWtGQqgWkKvjXn1swXIm8GcDwSXsiJdMnYy9Mc6bLFLMjaZk
 lgKo3pAV9oK0zpspOVXG9y6budCj9Yx7Kxs96Xoambv2J375OXBqalQ9Z
 SDS9HT25qKJOUdDm4yBkMBktzVwVP6+yqQ22bD7ysgo1ctjENL3FJBnvy
 atq0KOgrzFOJAFIkAw7bK+rPnJ9/xZUNkw/Fu0r3PQ5Yc0HkGO61Za62X
 TQe8pxvQYdhHzpjVuykEuu8laP7izXUcxAluBolT17p+QCwOgVjVG5gbr
 sFE0szF8D9Kv2HRvnyXO13Rc0h13JinGm/9vm8khsOhzFb+1ysZQFficJ g==;
X-CSE-ConnectionGUID: KEJJ8LGhSV6+pJwDQKw18Q==
X-CSE-MsgGUID: H2Bil3g8RRSXZrkzYki/kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="86539274"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; d="scan'208";a="86539274"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2026 09:15:38 -0700
X-CSE-ConnectionGUID: kl85JanmTeCLFohsjzJgkQ==
X-CSE-MsgGUID: FCgKDydzRyG6TyDfVNiWCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; d="scan'208";a="247550206"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2)
 ([10.211.93.152])
 by fmviesa001.fm.intel.com with ESMTP; 21 Mar 2026 09:15:36 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w3yz8-000000006A1-1Oog;
 Sat, 21 Mar 2026 16:15:34 +0000
Date: Sat, 21 Mar 2026 17:15:26 +0100
From: kernel test robot <lkp@intel.com>
To: Alvin1 Chen <alvin1.chen@lcfc.corp-partner.google.com>,
 dianders@chromium.org, neil.armstrong@linaro.org
Cc: oe-kbuild-all@lists.linux.dev, jesszhan0024@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Alvin1 Chen <alvin1.chen@lcfc.corp-partner.google.com>
Subject: Re: [PATCH v3] drm/panel-edp: Add BOE NV153WUM-N42, CMN N153JCA-ELK, 
 CSW  MNF307QS3-2
Message-ID: <202603211757.qHunHQyW-lkp@intel.com>
References: <20260319050938.556235-1-alvin1.chen@lcfc.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319050938.556235-1-alvin1.chen@lcfc.corp-partner.google.com>
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

Hi Alvin1,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v7.0-rc4]
[cannot apply to next-20260320]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alvin1-Chen/drm-panel-edp-Add-BOE-NV153WUM-N42-CMN-N153JCA-ELK-CSW-MNF307QS3-2/20260320-084718
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260319050938.556235-1-alvin1.chen%40lcfc.corp-partner.google.com
patch subject: [PATCH v3] drm/panel-edp: Add BOE NV153WUM-N42, CMN N153JCA-ELK, CSW  MNF307QS3-2
config: i386-randconfig-2006-20250825 (https://download.01.org/0day-ci/archive/20260321/202603211757.qHunHQyW-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260321/202603211757.qHunHQyW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603211757.qHunHQyW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/panel/panel-edp.c:1893:1: error: expected expression before '{' token
    1893 | { \
         | ^
   drivers/gpu/drm/panel/panel-edp.c:2028:9: note: in expansion of macro 'EDP_PANEL_ENTRY'
    2028 | +       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0db3, &delay_200_500_e80, "NV153WUM-N42"),
         |         ^~~~~~~~~~~~~~~
   drivers/gpu/drm/panel/panel-edp.c:1885:33: warning: 'delay_80_500_e50_d50' defined but not used [-Wunused-const-variable=]
    1885 | static const struct panel_delay delay_80_500_e50_d50 = {
         |                                 ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/panel/panel-edp.c:1878:33: warning: 'delay_200_500_e50_d100' defined but not used [-Wunused-const-variable=]
    1878 | static const struct panel_delay delay_200_500_e50_d100 = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/panel/panel-edp.c:1870:33: warning: 'delay_50_500_e200_d200_po2e335' defined but not used [-Wunused-const-variable=]
    1870 | static const struct panel_delay delay_50_500_e200_d200_po2e335 = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/panel/panel-edp.c:1864:33: warning: 'delay_200_500_e250' defined but not used [-Wunused-const-variable=]
    1864 | static const struct panel_delay delay_200_500_e250 = {
         |                                 ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/panel/panel-edp.c:1858:33: warning: 'delay_200_150_e50' defined but not used [-Wunused-const-variable=]
    1858 | static const struct panel_delay delay_200_150_e50 = {
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/panel/panel-edp.c:1838:33: warning: 'delay_200_500_e200_d50' defined but not used [-Wunused-const-variable=]
    1838 | static const struct panel_delay delay_200_500_e200_d50 = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/panel/panel-edp.c:1831:33: warning: 'delay_200_500_e200_d10' defined but not used [-Wunused-const-variable=]
    1831 | static const struct panel_delay delay_200_500_e200_d10 = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/panel/panel-edp.c:1824:33: warning: 'delay_200_500_e200_d200' defined but not used [-Wunused-const-variable=]
    1824 | static const struct panel_delay delay_200_500_e200_d200 = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/panel/panel-edp.c:1805:33: warning: 'delay_100_500_e200' defined but not used [-Wunused-const-variable=]
    1805 | static const struct panel_delay delay_100_500_e200 = {
         |                                 ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/panel/panel-edp.c:1798:33: warning: 'delay_80_500_e80_p2e200' defined but not used [-Wunused-const-variable=]
    1798 | static const struct panel_delay delay_80_500_e80_p2e200 = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/panel/panel-edp.c:1792:33: warning: 'delay_80_500_e50' defined but not used [-Wunused-const-variable=]
    1792 | static const struct panel_delay delay_80_500_e50 = {
         |                                 ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/panel/panel-edp.c:1771:33: warning: 'delay_200_500_e50_d50_p2e200' defined but not used [-Wunused-const-variable=]
    1771 | static const struct panel_delay delay_200_500_e50_d50_p2e200 = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/panel/panel-edp.c:1753:33: warning: 'delay_200_500_p2e100' defined but not used [-Wunused-const-variable=]
    1753 | static const struct panel_delay delay_200_500_p2e100 = {
         |                                 ^~~~~~~~~~~~~~~~~~~~


vim +1893 drivers/gpu/drm/panel/panel-edp.c

490b30fbaca2ab Zhongtian Wu     2025-09-08  1891  
7d1be0a09fa621 Douglas Anderson 2021-09-24  1892  #define EDP_PANEL_ENTRY(vend_chr_0, vend_chr_1, vend_chr_2, product_id, _delay, _name) \
5540cf8f3e8dac Douglas Anderson 2021-09-14 @1893  { \
bf201127c1b8f2 Hsin-Yi Wang     2024-03-07  1894  	.ident = { \
5540cf8f3e8dac Douglas Anderson 2021-09-14  1895  		.name = _name, \
7d1be0a09fa621 Douglas Anderson 2021-09-24  1896  		.panel_id = drm_edid_encode_panel_id(vend_chr_0, vend_chr_1, vend_chr_2, \
7d1be0a09fa621 Douglas Anderson 2021-09-24  1897  						     product_id), \
bf201127c1b8f2 Hsin-Yi Wang     2024-03-07  1898  	}, \
5540cf8f3e8dac Douglas Anderson 2021-09-14  1899  	.delay = _delay \
5540cf8f3e8dac Douglas Anderson 2021-09-14  1900  }
5540cf8f3e8dac Douglas Anderson 2021-09-14  1901  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
