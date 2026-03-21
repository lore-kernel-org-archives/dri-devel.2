Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421B2109446F
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 17:54:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B1A810E1F5;
	Sat, 21 Mar 2026 17:54:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EPFnoQ7H";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1999A10E1F5
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 17:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774115666; x=1805651666;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=phA3n1FI0i2gILdBKv5cLpKeoh9LNb10n3ic3rBMXB0=;
 b=EPFnoQ7H74ty6JYmnFwdQN0nouvV1Nlk+hwUYabpAhNIDFjT04p6TVp7
 92dal0SeAzz8mnxDds5aXVP5Ll4skB0XYkrHLc+kl66p56BhyrOnh6uu/
 DEJz+uMiuMOps0YHpsiiRM8AB508Y0ezFVPt5bdjv6GakiCuKKte5WPzw
 Jx6Qapn77RJB7TFz8aGFb7qsx5tTdHZtjgKbSjBmvPgM2DiTHgnjUezBN
 w1SdmiQtKitMQ3RIkmtwIbh98VKPIB/ppjFG1ceznptOz/ZZlCuomoUNq
 615Q4gGLtq0eBvZfqMQpGmUFXpldyBZUgTW59Rou0fO3fhVxMD+yUOIrS g==;
X-CSE-ConnectionGUID: zGXO7bpFQCedqhb6Lww12g==
X-CSE-MsgGUID: tSiGd6DlSJaOsJCx/NQbTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="74885840"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; d="scan'208";a="74885840"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2026 10:54:25 -0700
X-CSE-ConnectionGUID: j39btCx/Q7uwu5iTpc+wvw==
X-CSE-MsgGUID: GRnaCydwSe+QuzBTkKvZHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; d="scan'208";a="222827594"
Received: from lkp-server02.sh.intel.com (HELO d7fefbca0d04) ([10.239.97.151])
 by orviesa010.jf.intel.com with ESMTP; 21 Mar 2026 10:54:21 -0700
Received: from kbuild by d7fefbca0d04 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w40Vo-0000000017E-0732;
 Sat, 21 Mar 2026 17:53:49 +0000
Date: Sun, 22 Mar 2026 01:52:20 +0800
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
Message-ID: <202603220138.Su7vM0eR-lkp@intel.com>
References: <20260319050938.556235-1-alvin1.chen@lcfc.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v7.0-rc4]
[cannot apply to next-20260320]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alvin1-Chen/drm-panel-edp-Add-BOE-NV153WUM-N42-CMN-N153JCA-ELK-CSW-MNF307QS3-2/20260320-084718
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260319050938.556235-1-alvin1.chen%40lcfc.corp-partner.google.com
patch subject: [PATCH v3] drm/panel-edp: Add BOE NV153WUM-N42, CMN N153JCA-ELK, CSW  MNF307QS3-2
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20260322/202603220138.Su7vM0eR-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260322/202603220138.Su7vM0eR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603220138.Su7vM0eR-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/panel/panel-edp.c:1893:1: error: expected expression before '{' token
    1893 | { \
         | ^
   drivers/gpu/drm/panel/panel-edp.c:2028:9: note: in expansion of macro 'EDP_PANEL_ENTRY'
    2028 | +       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0db3, &delay_200_500_e80, "NV153WUM-N42"),
         |         ^~~~~~~~~~~~~~~
>> drivers/gpu/drm/panel/panel-edp.c:1885:33: warning: 'delay_80_500_e50_d50' defined but not used [-Wunused-const-variable=]
    1885 | static const struct panel_delay delay_80_500_e50_d50 = {
         |                                 ^~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/panel/panel-edp.c:1878:33: warning: 'delay_200_500_e50_d100' defined but not used [-Wunused-const-variable=]
    1878 | static const struct panel_delay delay_200_500_e50_d100 = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/panel/panel-edp.c:1870:33: warning: 'delay_50_500_e200_d200_po2e335' defined but not used [-Wunused-const-variable=]
    1870 | static const struct panel_delay delay_50_500_e200_d200_po2e335 = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/panel/panel-edp.c:1864:33: warning: 'delay_200_500_e250' defined but not used [-Wunused-const-variable=]
    1864 | static const struct panel_delay delay_200_500_e250 = {
         |                                 ^~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/panel/panel-edp.c:1858:33: warning: 'delay_200_150_e50' defined but not used [-Wunused-const-variable=]
    1858 | static const struct panel_delay delay_200_150_e50 = {
         |                                 ^~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/panel/panel-edp.c:1838:33: warning: 'delay_200_500_e200_d50' defined but not used [-Wunused-const-variable=]
    1838 | static const struct panel_delay delay_200_500_e200_d50 = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/panel/panel-edp.c:1831:33: warning: 'delay_200_500_e200_d10' defined but not used [-Wunused-const-variable=]
    1831 | static const struct panel_delay delay_200_500_e200_d10 = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/panel/panel-edp.c:1824:33: warning: 'delay_200_500_e200_d200' defined but not used [-Wunused-const-variable=]
    1824 | static const struct panel_delay delay_200_500_e200_d200 = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/panel/panel-edp.c:1805:33: warning: 'delay_100_500_e200' defined but not used [-Wunused-const-variable=]
    1805 | static const struct panel_delay delay_100_500_e200 = {
         |                                 ^~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/panel/panel-edp.c:1798:33: warning: 'delay_80_500_e80_p2e200' defined but not used [-Wunused-const-variable=]
    1798 | static const struct panel_delay delay_80_500_e80_p2e200 = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/panel/panel-edp.c:1792:33: warning: 'delay_80_500_e50' defined but not used [-Wunused-const-variable=]
    1792 | static const struct panel_delay delay_80_500_e50 = {
         |                                 ^~~~~~~~~~~~~~~~
>> drivers/gpu/drm/panel/panel-edp.c:1771:33: warning: 'delay_200_500_e50_d50_p2e200' defined but not used [-Wunused-const-variable=]
    1771 | static const struct panel_delay delay_200_500_e50_d50_p2e200 = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/panel/panel-edp.c:1753:33: warning: 'delay_200_500_p2e100' defined but not used [-Wunused-const-variable=]
    1753 | static const struct panel_delay delay_200_500_p2e100 = {
         |                                 ^~~~~~~~~~~~~~~~~~~~


vim +/delay_80_500_e50_d50 +1885 drivers/gpu/drm/panel/panel-edp.c

f4ccd9fea22707 Pin-yen Lin                2023-12-14  1752  
5540cf8f3e8dac Douglas Anderson           2021-09-14 @1753  static const struct panel_delay delay_200_500_p2e100 = {
5540cf8f3e8dac Douglas Anderson           2021-09-14  1754  	.hpd_absent = 200,
5540cf8f3e8dac Douglas Anderson           2021-09-14  1755  	.unprepare = 500,
5540cf8f3e8dac Douglas Anderson           2021-09-14  1756  	.prepare_to_enable = 100,
5540cf8f3e8dac Douglas Anderson           2021-09-14  1757  };
5540cf8f3e8dac Douglas Anderson           2021-09-14  1758  
349d4efadc1f83 Hans de Goede              2026-01-05  1759  static const struct panel_delay delay_200_500_p2e200 = {
349d4efadc1f83 Hans de Goede              2026-01-05  1760  	.hpd_absent = 200,
349d4efadc1f83 Hans de Goede              2026-01-05  1761  	.unprepare = 500,
349d4efadc1f83 Hans de Goede              2026-01-05  1762  	.prepare_to_enable = 200,
349d4efadc1f83 Hans de Goede              2026-01-05  1763  };
349d4efadc1f83 Hans de Goede              2026-01-05  1764  
5540cf8f3e8dac Douglas Anderson           2021-09-14  1765  static const struct panel_delay delay_200_500_e50 = {
5540cf8f3e8dac Douglas Anderson           2021-09-14  1766  	.hpd_absent = 200,
5540cf8f3e8dac Douglas Anderson           2021-09-14  1767  	.unprepare = 500,
5540cf8f3e8dac Douglas Anderson           2021-09-14  1768  	.enable = 50,
5540cf8f3e8dac Douglas Anderson           2021-09-14  1769  };
5540cf8f3e8dac Douglas Anderson           2021-09-14  1770  
1511d3c4d2bb30 Langyan Ye                 2025-07-23 @1771  static const struct panel_delay delay_200_500_e50_d50_p2e200 = {
e635b7eb7062b4 Zhengqiao Xia              2024-03-01  1772  	.hpd_absent = 200,
e635b7eb7062b4 Zhengqiao Xia              2024-03-01  1773  	.unprepare = 500,
e635b7eb7062b4 Zhengqiao Xia              2024-03-01  1774  	.enable = 50,
1511d3c4d2bb30 Langyan Ye                 2025-07-23  1775  	.disable = 50,
e635b7eb7062b4 Zhengqiao Xia              2024-03-01  1776  	.prepare_to_enable = 200,
e635b7eb7062b4 Zhengqiao Xia              2024-03-01  1777  };
e635b7eb7062b4 Zhengqiao Xia              2024-03-01  1778  
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1779  static const struct panel_delay delay_200_500_e80 = {
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1780  	.hpd_absent = 200,
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1781  	.unprepare = 500,
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1782  	.enable = 80,
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1783  };
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1784  
b889d89ad45f99 Yunlong Jia                2022-01-20  1785  static const struct panel_delay delay_200_500_e80_d50 = {
b889d89ad45f99 Yunlong Jia                2022-01-20  1786  	.hpd_absent = 200,
b889d89ad45f99 Yunlong Jia                2022-01-20  1787  	.unprepare = 500,
b889d89ad45f99 Yunlong Jia                2022-01-20  1788  	.enable = 80,
b889d89ad45f99 Yunlong Jia                2022-01-20  1789  	.disable = 50,
b889d89ad45f99 Yunlong Jia                2022-01-20  1790  };
b889d89ad45f99 Yunlong Jia                2022-01-20  1791  
51e1fb144f17c2 Dmitry Baryshkov           2024-06-14 @1792  static const struct panel_delay delay_80_500_e50 = {
51e1fb144f17c2 Dmitry Baryshkov           2024-06-14  1793  	.hpd_absent = 80,
51e1fb144f17c2 Dmitry Baryshkov           2024-06-14  1794  	.unprepare = 500,
51e1fb144f17c2 Dmitry Baryshkov           2024-06-14  1795  	.enable = 50,
51e1fb144f17c2 Dmitry Baryshkov           2024-06-14  1796  };
51e1fb144f17c2 Dmitry Baryshkov           2024-06-14  1797  
0d607a59a0f659 Zhengqiao Xia              2025-04-29 @1798  static const struct panel_delay delay_80_500_e80_p2e200 = {
0d607a59a0f659 Zhengqiao Xia              2025-04-29  1799  	.hpd_absent = 80,
0d607a59a0f659 Zhengqiao Xia              2025-04-29  1800  	.unprepare = 500,
0d607a59a0f659 Zhengqiao Xia              2025-04-29  1801  	.enable = 80,
0d607a59a0f659 Zhengqiao Xia              2025-04-29  1802  	.prepare_to_enable = 200,
0d607a59a0f659 Zhengqiao Xia              2025-04-29  1803  };
0d607a59a0f659 Zhengqiao Xia              2025-04-29  1804  
b889d89ad45f99 Yunlong Jia                2022-01-20 @1805  static const struct panel_delay delay_100_500_e200 = {
b889d89ad45f99 Yunlong Jia                2022-01-20  1806  	.hpd_absent = 100,
b889d89ad45f99 Yunlong Jia                2022-01-20  1807  	.unprepare = 500,
b889d89ad45f99 Yunlong Jia                2022-01-20  1808  	.enable = 200,
b889d89ad45f99 Yunlong Jia                2022-01-20  1809  };
b889d89ad45f99 Yunlong Jia                2022-01-20  1810  
f6ff4570e567b6 Nícolas F. R. A. Prado     2022-07-19  1811  static const struct panel_delay delay_200_500_e200 = {
f6ff4570e567b6 Nícolas F. R. A. Prado     2022-07-19  1812  	.hpd_absent = 200,
f6ff4570e567b6 Nícolas F. R. A. Prado     2022-07-19  1813  	.unprepare = 500,
f6ff4570e567b6 Nícolas F. R. A. Prado     2022-07-19  1814  	.enable = 200,
f6ff4570e567b6 Nícolas F. R. A. Prado     2022-07-19  1815  };
f6ff4570e567b6 Nícolas F. R. A. Prado     2022-07-19  1816  
bbe814bcb961ed Haikun Zhou                2026-02-26  1817  static const struct panel_delay delay_200_500_e200_d100 = {
bbe814bcb961ed Haikun Zhou                2026-02-26  1818  	.hpd_absent = 200,
bbe814bcb961ed Haikun Zhou                2026-02-26  1819  	.unprepare = 500,
bbe814bcb961ed Haikun Zhou                2026-02-26  1820  	.enable = 200,
bbe814bcb961ed Haikun Zhou                2026-02-26  1821  	.disable = 100,
bbe814bcb961ed Haikun Zhou                2026-02-26  1822  };
bbe814bcb961ed Haikun Zhou                2026-02-26  1823  
f4ccd9fea22707 Pin-yen Lin                2023-12-14 @1824  static const struct panel_delay delay_200_500_e200_d200 = {
f4ccd9fea22707 Pin-yen Lin                2023-12-14  1825  	.hpd_absent = 200,
f4ccd9fea22707 Pin-yen Lin                2023-12-14  1826  	.unprepare = 500,
f4ccd9fea22707 Pin-yen Lin                2023-12-14  1827  	.enable = 200,
f4ccd9fea22707 Pin-yen Lin                2023-12-14  1828  	.disable = 200,
f4ccd9fea22707 Pin-yen Lin                2023-12-14  1829  };
f4ccd9fea22707 Pin-yen Lin                2023-12-14  1830  
4d53cf81479500 Hsin-Yi Wang               2023-11-07 @1831  static const struct panel_delay delay_200_500_e200_d10 = {
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1832  	.hpd_absent = 200,
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1833  	.unprepare = 500,
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1834  	.enable = 200,
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1835  	.disable = 10,
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1836  };
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1837  
518867b0939421 Cong Yang                  2025-07-31 @1838  static const struct panel_delay delay_200_500_e200_d50 = {
518867b0939421 Cong Yang                  2025-07-31  1839  	.hpd_absent = 200,
518867b0939421 Cong Yang                  2025-07-31  1840  	.unprepare = 500,
518867b0939421 Cong Yang                  2025-07-31  1841  	.enable = 200,
518867b0939421 Cong Yang                  2025-07-31  1842  	.disable = 50,
518867b0939421 Cong Yang                  2025-07-31  1843  };
518867b0939421 Cong Yang                  2025-07-31  1844  
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1845  static const struct panel_delay delay_200_150_e200 = {
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1846  	.hpd_absent = 200,
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1847  	.unprepare = 150,
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1848  	.enable = 200,
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1849  };
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1850  
f4ccd9fea22707 Pin-yen Lin                2023-12-14  1851  static const struct panel_delay delay_200_500_e50_po2e200 = {
f4ccd9fea22707 Pin-yen Lin                2023-12-14  1852  	.hpd_absent = 200,
f4ccd9fea22707 Pin-yen Lin                2023-12-14  1853  	.unprepare = 500,
f4ccd9fea22707 Pin-yen Lin                2023-12-14  1854  	.enable = 50,
f4ccd9fea22707 Pin-yen Lin                2023-12-14  1855  	.powered_on_to_enable = 200,
f4ccd9fea22707 Pin-yen Lin                2023-12-14  1856  };
f4ccd9fea22707 Pin-yen Lin                2023-12-14  1857  
ae4a812a64dad3 Langyan Ye                 2024-11-13 @1858  static const struct panel_delay delay_200_150_e50 = {
ae4a812a64dad3 Langyan Ye                 2024-11-13  1859  	.hpd_absent = 200,
ae4a812a64dad3 Langyan Ye                 2024-11-13  1860  	.unprepare = 150,
ae4a812a64dad3 Langyan Ye                 2024-11-13  1861  	.enable = 50,
ae4a812a64dad3 Langyan Ye                 2024-11-13  1862  };
ae4a812a64dad3 Langyan Ye                 2024-11-13  1863  
6ce24b3450b8e8 Langyan Ye                 2025-01-23 @1864  static const struct panel_delay delay_200_500_e250 = {
6ce24b3450b8e8 Langyan Ye                 2025-01-23  1865  	.hpd_absent = 200,
6ce24b3450b8e8 Langyan Ye                 2025-01-23  1866  	.unprepare = 500,
6ce24b3450b8e8 Langyan Ye                 2025-01-23  1867  	.enable = 250,
6ce24b3450b8e8 Langyan Ye                 2025-01-23  1868  };
6ce24b3450b8e8 Langyan Ye                 2025-01-23  1869  
0e1daf2b32dc85 Damon Ding                 2025-02-05 @1870  static const struct panel_delay delay_50_500_e200_d200_po2e335 = {
0e1daf2b32dc85 Damon Ding                 2025-02-05  1871  	.hpd_absent = 50,
0e1daf2b32dc85 Damon Ding                 2025-02-05  1872  	.unprepare = 500,
0e1daf2b32dc85 Damon Ding                 2025-02-05  1873  	.enable = 200,
0e1daf2b32dc85 Damon Ding                 2025-02-05  1874  	.disable = 200,
0e1daf2b32dc85 Damon Ding                 2025-02-05  1875  	.powered_on_to_enable = 335,
0e1daf2b32dc85 Damon Ding                 2025-02-05  1876  };
0e1daf2b32dc85 Damon Ding                 2025-02-05  1877  
9b3700b15cb581 Langyan Ye                 2025-07-21 @1878  static const struct panel_delay delay_200_500_e50_d100 = {
9b3700b15cb581 Langyan Ye                 2025-07-21  1879  	.hpd_absent = 200,
9b3700b15cb581 Langyan Ye                 2025-07-21  1880  	.unprepare = 500,
9b3700b15cb581 Langyan Ye                 2025-07-21  1881  	.enable = 50,
9b3700b15cb581 Langyan Ye                 2025-07-21  1882  	.disable = 100,
9b3700b15cb581 Langyan Ye                 2025-07-21  1883  };
9b3700b15cb581 Langyan Ye                 2025-07-21  1884  
490b30fbaca2ab Zhongtian Wu               2025-09-08 @1885  static const struct panel_delay delay_80_500_e50_d50 = {
490b30fbaca2ab Zhongtian Wu               2025-09-08  1886  	.hpd_absent = 80,
490b30fbaca2ab Zhongtian Wu               2025-09-08  1887  	.unprepare = 500,
490b30fbaca2ab Zhongtian Wu               2025-09-08  1888  	.enable = 50,
490b30fbaca2ab Zhongtian Wu               2025-09-08  1889  	.disable = 50,
490b30fbaca2ab Zhongtian Wu               2025-09-08  1890  };
490b30fbaca2ab Zhongtian Wu               2025-09-08  1891  
7d1be0a09fa621 Douglas Anderson           2021-09-24  1892  #define EDP_PANEL_ENTRY(vend_chr_0, vend_chr_1, vend_chr_2, product_id, _delay, _name) \
5540cf8f3e8dac Douglas Anderson           2021-09-14 @1893  { \
bf201127c1b8f2 Hsin-Yi Wang               2024-03-07  1894  	.ident = { \
5540cf8f3e8dac Douglas Anderson           2021-09-14  1895  		.name = _name, \
7d1be0a09fa621 Douglas Anderson           2021-09-24  1896  		.panel_id = drm_edid_encode_panel_id(vend_chr_0, vend_chr_1, vend_chr_2, \
7d1be0a09fa621 Douglas Anderson           2021-09-24  1897  						     product_id), \
bf201127c1b8f2 Hsin-Yi Wang               2024-03-07  1898  	}, \
5540cf8f3e8dac Douglas Anderson           2021-09-14  1899  	.delay = _delay \
5540cf8f3e8dac Douglas Anderson           2021-09-14  1900  }
5540cf8f3e8dac Douglas Anderson           2021-09-14  1901  
9f7843b515811a Hsin-Yi Wang               2023-11-17  1902  #define EDP_PANEL_ENTRY2(vend_chr_0, vend_chr_1, vend_chr_2, product_id, _delay, _name, _mode) \
9f7843b515811a Hsin-Yi Wang               2023-11-17  1903  { \
bf201127c1b8f2 Hsin-Yi Wang               2024-03-07  1904  	.ident = { \
9f7843b515811a Hsin-Yi Wang               2023-11-17  1905  		.name = _name, \
9f7843b515811a Hsin-Yi Wang               2023-11-17  1906  		.panel_id = drm_edid_encode_panel_id(vend_chr_0, vend_chr_1, vend_chr_2, \
9f7843b515811a Hsin-Yi Wang               2023-11-17  1907  						     product_id), \
bf201127c1b8f2 Hsin-Yi Wang               2024-03-07  1908  	}, \
9f7843b515811a Hsin-Yi Wang               2023-11-17  1909  	.delay = _delay, \
9f7843b515811a Hsin-Yi Wang               2023-11-17  1910  	.override_edid_mode = _mode \
9f7843b515811a Hsin-Yi Wang               2023-11-17  1911  }
9f7843b515811a Hsin-Yi Wang               2023-11-17  1912  
5540cf8f3e8dac Douglas Anderson           2021-09-14  1913  /*
5540cf8f3e8dac Douglas Anderson           2021-09-14  1914   * This table is used to figure out power sequencing delays for panels that
5540cf8f3e8dac Douglas Anderson           2021-09-14  1915   * are detected by EDID. Entries here may point to entries in the
5540cf8f3e8dac Douglas Anderson           2021-09-14  1916   * platform_of_match table (if a panel is listed in both places).
5540cf8f3e8dac Douglas Anderson           2021-09-14  1917   *
5540cf8f3e8dac Douglas Anderson           2021-09-14  1918   * Sort first by vendor, then by product ID.
5540cf8f3e8dac Douglas Anderson           2021-09-14  1919   */
5540cf8f3e8dac Douglas Anderson           2021-09-14  1920  static const struct edp_panel_entry edp_panels[] = {
518867b0939421 Cong Yang                  2025-07-31  1921  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x04a4, &delay_200_500_e50, "B122UAN01.0"),
bcd752c706c357 Val Packett                2025-12-06  1922  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x0ba4, &delay_200_500_e50, "B140QAX01.H"),
f4ccd9fea22707 Pin-yen Lin                2023-12-14  1923  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x105c, &delay_200_500_e50, "B116XTN01.0"),
b68735e8ef58be Nícolas F. R. A. Prado     2022-07-20  1924  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1062, &delay_200_500_e50, "B120XAN01.0"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  1925  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x125c, &delay_200_500_e50, "Unknown"),
1ebc9f0365efa8 Laura Nao                  2023-06-07  1926  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x145c, &delay_200_500_e50, "B116XAB01.4"),
336dca397dcefc Pin-yen Lin                2024-05-27  1927  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1999, &delay_200_500_e50, "Unknown"),
ee50b002440864 Johan Hovold               2022-07-11  1928  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1e9b, &delay_200_500_e50, "B133UAN02.1"),
a70abdd994cb0e Sean Hong                  2022-09-23  1929  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1ea5, &delay_200_500_e50, "B116XAK01.6"),
e4f9fd9edbc22f Pin-yen Lin                2024-05-27  1930  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x203d, &delay_200_500_e50, "B140HTN02.0"),
5b50bb435629ab Svyatoslav Ryhel           2025-09-29  1931  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x205c, &delay_200_500_e50, "B116XAN02.0"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1932  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x208d, &delay_200_500_e50, "B140HTN02.1"),
962845c090c4f8 Hsin-Yi Wang               2023-11-07  1933  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x235c, &delay_200_500_e50, "B116XTN02.3"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1934  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x239b, &delay_200_500_e50, "B116XAN06.1"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1935  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x255c, &delay_200_500_e50, "B116XTN02.5"),
a4b4e3fd536763 Ernest Van Hoecke          2025-05-20  1936  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x30ed, &delay_200_500_e50, "G156HAN03.0"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1937  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x403d, &delay_200_500_e50, "B140HAN04.0"),
ca3c7819499e63 Hsin-Yi Wang               2024-03-07  1938  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAN04.0"),
ca3c7819499e63 Hsin-Yi Wang               2024-03-07  1939  	EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01.0",
ca3c7819499e63 Hsin-Yi Wang               2024-03-07  1940  			 &auo_b116xa3_mode),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  1941  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x435c, &delay_200_500_e50, "Unknown"),
518867b0939421 Cong Yang                  2025-07-31  1942  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x52b0, &delay_200_500_e50, "B116XAK02.0"),
981f8866754dc5 Bjorn Andersson            2023-03-24  1943  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x582d, &delay_200_500_e50, "B133UAN01.0"),
1a5e81de180e51 Hsin-Yi Wang               2024-02-13  1944  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1945  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x635c, &delay_200_500_e50, "B116XAN06.3"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1946  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x639c, &delay_200_500_e50, "B140HAK02.7"),
2976aeb0de77da Alexey Klimov              2025-12-03  1947  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x643d, &delay_200_500_e50, "B140HAN06.4"),
f4ccd9fea22707 Pin-yen Lin                2023-12-14  1948  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x723c, &delay_200_500_e50, "B140XTN07.2"),
d4b9b6da5777bb Terry Hsiao                2024-07-21  1949  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x73aa, &delay_200_500_e50, "B116XTN02.3"),
d049a24b15d8c1 Matthias Kaehlcke          2022-03-30  1950  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133UAN01.0"),
2cb217301e0df1 Terry Hsiao                2026-01-22  1951  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x89ba, &delay_200_500_e50, "B116XAT04.1"),
518867b0939421 Cong Yang                  2025-07-31  1952  	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8bba, &delay_200_500_e50, "B140UAN08.5"),
d4b9b6da5777bb Terry Hsiao                2024-07-21  1953  	EDP_PANEL_ENTRY('A', 'U', 'O', 0xa199, &delay_200_500_e50, "B116XAN06.1"),
0ca6d605885285 Langyan Ye                 2024-12-25  1954  	EDP_PANEL_ENTRY('A', 'U', 'O', 0xa7b3, &delay_200_500_e50, "B140UAN04.4"),
e3e41106106710 Zhongtian Wu               2025-09-15  1955  	EDP_PANEL_ENTRY('A', 'U', 'O', 0xb7a9, &delay_200_500_e50, "B140HAK03.3"),
d4b9b6da5777bb Terry Hsiao                2024-07-21  1956  	EDP_PANEL_ENTRY('A', 'U', 'O', 0xc4b4, &delay_200_500_e50, "B116XAT04.1"),
5f8f898b14b240 Zhengqiao Xia              2025-04-29  1957  	EDP_PANEL_ENTRY('A', 'U', 'O', 0xc9a8, &delay_200_500_e50, "B140QAN08.H"),
518867b0939421 Cong Yang                  2025-07-31  1958  	EDP_PANEL_ENTRY('A', 'U', 'O', 0xcdba, &delay_200_500_e50, "B140UAX01.2"),
1864c45deb770a Pin-yen Lin                2024-03-25  1959  	EDP_PANEL_ENTRY('A', 'U', 'O', 0xd497, &delay_200_500_e50, "B120XAN01.0"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1960  	EDP_PANEL_ENTRY('A', 'U', 'O', 0xf390, &delay_200_500_e50, "B140XTN07.7"),
5540cf8f3e8dac Douglas Anderson           2021-09-14  1961  
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  1962  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0607, &delay_200_500_e200, "Unknown"),
f4ccd9fea22707 Pin-yen Lin                2023-12-14  1963  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0608, &delay_200_500_e50, "NT116WHM-N11"),
e4f9fd9edbc22f Pin-yen Lin                2024-05-27  1964  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0609, &delay_200_500_e50_po2e200, "NT116WHM-N21 V4.1"),
336dca397dcefc Pin-yen Lin                2024-05-27  1965  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0623, &delay_200_500_e200, "NT116WHM-N21 V4.0"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  1966  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0668, &delay_200_500_e200, "Unknown"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  1967  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x068f, &delay_200_500_e200, "Unknown"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  1968  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x06e5, &delay_200_500_e200, "Unknown"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  1969  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0705, &delay_200_500_e200, "Unknown"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1970  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0715, &delay_200_150_e200, "NT116WHM-N21"),
f4ccd9fea22707 Pin-yen Lin                2023-12-14  1971  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0717, &delay_200_500_e50_po2e200, "NV133FHM-N42"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1972  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0731, &delay_200_500_e80, "NT116WHM-N42"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1973  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0741, &delay_200_500_e200, "NT116WHM-N44"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  1974  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0744, &delay_200_500_e200, "Unknown"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  1975  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x074c, &delay_200_500_e200, "Unknown"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  1976  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0751, &delay_200_500_e200, "Unknown"),
f4ccd9fea22707 Pin-yen Lin                2023-12-14  1977  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0754, &delay_200_500_e50_po2e200, "NV116WHM-N45"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  1978  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0771, &delay_200_500_e200, "Unknown"),
7d1be0a09fa621 Douglas Anderson           2021-09-24  1979  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0786, &delay_200_500_p2e80, "NV116WHM-T01"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  1980  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0797, &delay_200_500_e200, "Unknown"),
e4f9fd9edbc22f Pin-yen Lin                2024-05-27  1981  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x07a8, &delay_200_500_e50_po2e200, "NT116WHM-N21"),
7d1be0a09fa621 Douglas Anderson           2021-09-24  1982  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x07d1, &boe_nv133fhm_n61.delay, "NV133FHM-N61"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  1983  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x07d3, &delay_200_500_e200, "Unknown"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1984  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x07f6, &delay_200_500_e200, "NT140FHM-N44"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  1985  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x07f8, &delay_200_500_e200, "Unknown"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  1986  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0813, &delay_200_500_e200, "Unknown"),
f4ccd9fea22707 Pin-yen Lin                2023-12-14  1987  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0827, &delay_200_500_e50_p2e80, "NT140WHM-N44 V8.0"),
7d1be0a09fa621 Douglas Anderson           2021-09-24  1988  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x082d, &boe_nv133fhm_n61.delay, "NV133FHM-N62"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  1989  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0843, &delay_200_500_e200, "Unknown"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1990  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x08b2, &delay_200_500_e200, "NT140WHM-N49"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  1991  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0848, &delay_200_500_e200, "Unknown"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  1992  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0849, &delay_200_500_e200, "Unknown"),
3db2420422a591 Sheng-Liang Pan            2023-10-27  1993  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x09c3, &delay_200_500_e50, "NT116WHM-N21,836X2"),
43bee41415a6e7 Sean Hong                  2022-09-23  1994  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x094b, &delay_200_500_e50, "NT116WHM-N21"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  1995  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0951, &delay_200_500_e80, "NV116WHM-N47"),
a80c882183e36b AngeloGioacchino Del Regno 2023-04-05  1996  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x095f, &delay_200_500_e50, "NE135FBM-N41 v8.1"),
3330b71caff6cd Rob Clark                  2025-05-15  1997  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0964, &delay_200_500_e50, "NV133WUM-N61"),
f4ccd9fea22707 Pin-yen Lin                2023-12-14  1998  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x096e, &delay_200_500_e50_po2e200, "NV116WHM-T07 V8.0"),
3db2420422a591 Sheng-Liang Pan            2023-10-27  1999  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0979, &delay_200_500_e50, "NV116WHM-N49 V8.0"),
7d1be0a09fa621 Douglas Anderson           2021-09-24  2000  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x098d, &boe_nv110wtm_n61.delay, "NV110WTM-N61"),
f4ccd9fea22707 Pin-yen Lin                2023-12-14  2001  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0993, &delay_200_500_e80, "NV116WHM-T14 V8.0"),
f4ccd9fea22707 Pin-yen Lin                2023-12-14  2002  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x09ad, &delay_200_500_e80, "NV116WHM-N47"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  2003  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x09ae, &delay_200_500_e200, "NT140FHM-N45"),
9d6b59478cc574 Sean Hong                  2022-09-23  2004  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x09dd, &delay_200_500_e50, "NT116WHM-N21"),
a237f217bad50c Clayton Craft              2024-05-20  2005  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a1b, &delay_200_500_e50, "NV133WUM-N63"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  2006  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a36, &delay_200_500_e200, "Unknown"),
1511d3c4d2bb30 Langyan Ye                 2025-07-23  2007  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a3e, &delay_200_500_e80_d50, "NV116WHM-N49"),
b889d89ad45f99 Yunlong Jia                2022-01-20  2008  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a5d, &delay_200_500_e50, "NV116WHM-N45"),
490b30fbaca2ab Zhongtian Wu               2025-09-08  2009  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a6a, &delay_200_500_e80, "NV140WUM-N44"),
94124ea5a741b8 Daniel Thompson            2025-11-21  2010  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a84, &delay_200_500_e50, "NV133WUM-T01"),
2f24fe8c54cc8d Sean Hong                  2022-09-27  2011  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ac5, &delay_200_500_e50, "NV116WHM-N4C"),
993d36ac99efea Hsin-Yi Wang               2024-07-10  2012  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ae8, &delay_200_500_e50_p2e80, "NV140WUM-N41"),
c03dd019f0b56c Andy Yan                   2025-01-17  2013  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b09, &delay_200_500_e50_po2e200, "NV140FHM-NZ"),
1a304a2f8f7dbe Val Packett                2025-07-06  2014  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b1e, &delay_200_500_e80, "NE140QDM-N6A"),
1511d3c4d2bb30 Langyan Ye                 2025-07-23  2015  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b34, &delay_200_500_e80_d50, "NV122WUM-N41"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  2016  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b43, &delay_200_500_e200, "NV140FHM-T09"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  2017  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b56, &delay_200_500_e80, "NT140FHM-N47"),
51394119f64042 Abel Vesa                  2024-08-26  2018  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b66, &delay_200_500_e80, "NE140WUM-N6G"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  2019  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c20, &delay_200_500_e80, "NT140FHM-N47"),
349d4efadc1f83 Hans de Goede              2026-01-05  2020  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c26, &delay_200_500_p2e200, "NV140WUM-T08"),
c1bae6802ee9c8 Jens Glathe                2024-11-24  2021  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c93, &delay_200_500_e200, "Unknown"),
dcb6c8ee6acc6c Xuxin Xiong                2024-03-08  2022  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cb6, &delay_200_500_e200, "NT116WHM-N44"),
e3e41106106710 Zhongtian Wu               2025-09-15  2023  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cf2, &delay_200_500_e200, "NV156FHM-N4S"),
bbe814bcb961ed Haikun Zhou                2026-02-26  2024  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cf6, &delay_200_500_e200_d100, "NV140WUM-N64"),
d4b9b6da5777bb Terry Hsiao                2024-07-21  2025  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV116WHM-A4D"),
518867b0939421 Cong Yang                  2025-07-31  2026  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d45, &delay_200_500_e80, "NV116WHM-N4B"),
800c2180705a87 Zhengqiao Xia              2025-04-29  2027  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d73, &delay_200_500_e80, "NE140WUM-N6S"),
41bf3b0d7dff9b Alvin1 Chen                2026-03-19 @2028  +	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0db3, &delay_200_500_e80, "NV153WUM-N42"),
518867b0939421 Cong Yang                  2025-07-31  2029  	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ddf, &delay_200_500_e80, "NV116WHM-T01"),
5540cf8f3e8dac Douglas Anderson           2021-09-14  2030  
f4ccd9fea22707 Pin-yen Lin                2023-12-14  2031  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1130, &delay_200_500_e50, "N116BGE-EB2"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  2032  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1132, &delay_200_500_e80_d50, "N116BGE-EA2"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  2033  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1138, &innolux_n116bca_ea1.delay, "N116BCA-EA1-RC4"),
4ab5953f0af77f Sean Hong                  2022-10-21  2034  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1139, &delay_200_500_e80_d50, "N116BGE-EA2"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  2035  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1141, &delay_200_500_e80_d50, "Unknown"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  2036  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1145, &delay_200_500_e80_d50, "N116BCN-EB1"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  2037  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x114a, &delay_200_500_e80_d50, "Unknown"),
7d1be0a09fa621 Douglas Anderson           2021-09-24  2038  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x114c, &innolux_n116bca_ea1.delay, "N116BCA-EA1"),
8397d2984528b8 Sean Hong                  2022-09-27  2039  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1152, &delay_200_500_e80_d50, "N116BCN-EA1"),
3facae0649648d Sean Hong                  2022-10-21  2040  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1153, &delay_200_500_e80_d50, "N116BGE-EA2"),
43113fd4c5f562 Sean Hong                  2022-09-27  2041  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1154, &delay_200_500_e80_d50, "N116BCA-EA2"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  2042  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1156, &delay_200_500_e80_d50, "Unknown"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  2043  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1157, &delay_200_500_e80_d50, "N116BGE-EA2"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  2044  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x115b, &delay_200_500_e80_d50, "N116BCN-EB1"),
d4b9b6da5777bb Terry Hsiao                2024-07-21  2045  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x115d, &delay_200_500_e80_d50, "N116BCA-EA2"),
dcb6c8ee6acc6c Xuxin Xiong                2024-03-08  2046  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x115e, &delay_200_500_e80_d50, "N116BCA-EA1"),
518867b0939421 Cong Yang                  2025-07-31  2047  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x115f, &delay_200_500_e80_d50, "N116BCL-EAK"),
7acacca1b157fc Haikun Zhou                2024-05-22  2048  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1160, &delay_200_500_e80_d50, "N116BCJ-EAK"),
d4b9b6da5777bb Terry Hsiao                2024-07-21  2049  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1161, &delay_200_500_e80, "N116BCP-EA2"),
34a3554a1c7059 Langyan Ye                 2025-06-26  2050  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1163, &delay_200_500_e80_d50, "N116BCJ-EAK"),
3d65e4c276b32c Cong Yang                  2026-01-30  2051  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x117a, &delay_200_500_e80_d50, "N116BCL-EAK"),
758d7b3483b6ea Chen-Yu Tsai               2022-09-08  2052  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
518867b0939421 Cong Yang                  2025-07-31  2053  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x124c, &delay_200_500_e80_d50, "N122JCA-ENK"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  2054  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x142b, &delay_200_500_e80_d50, "N140HCA-EAC"),
f4ccd9fea22707 Pin-yen Lin                2023-12-14  2055  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x142e, &delay_200_500_e80_d50, "N140BGA-EA4"),
490b30fbaca2ab Zhongtian Wu               2025-09-08  2056  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1441, &delay_200_500_e80_d50, "N140JCA-ELK"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  2057  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x144f, &delay_200_500_e80_d50, "N140HGA-EA1"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  2058  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1468, &delay_200_500_e80, "N140HGA-EA1"),
e3e41106106710 Zhongtian Wu               2025-09-15  2059  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x148f, &delay_200_500_e80, "N140HCA-EAC"),
518867b0939421 Cong Yang                  2025-07-31  2060  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14a8, &delay_200_500_e80, "N140JCA-ELP"),
8229399486c4f0 Nikita Travkin             2023-08-01  2061  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d4, &delay_200_500_e80_d50, "N140HCA-EAC"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  2062  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d6, &delay_200_500_e80_d50, "N140BGA-EA4"),
4900e0396e59be Pin-yen Lin                2023-12-05  2063  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14e5, &delay_200_500_e80_d50, "N140HGA-EA1"),
e3e41106106710 Zhongtian Wu               2025-09-15  2064  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1565, &delay_200_500_e80, "N156HCA-EAB"),
41bf3b0d7dff9b Alvin1 Chen                2026-03-19  2065  +	EDP_PANEL_ENTRY('C', 'M', 'N', 0x156b, &delay_200_500_e80_d50, "N153JCA-ELK"),
126bf397bf5848 Jens Glathe                2025-05-24  2066  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x162b, &delay_200_500_e80_d50, "N160JCE-ELL"),
518867b0939421 Cong Yang                  2025-07-31  2067  	EDP_PANEL_ENTRY('C', 'M', 'N', 0x7402, &delay_200_500_e200_d50, "N116BCA-EAK"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  2068  
1511d3c4d2bb30 Langyan Ye                 2025-07-23  2069  	EDP_PANEL_ENTRY('C', 'S', 'O', 0x1200, &delay_200_500_e50_d50_p2e200, "MNC207QS1-1"),
1511d3c4d2bb30 Langyan Ye                 2025-07-23  2070  	EDP_PANEL_ENTRY('C', 'S', 'O', 0x1413, &delay_200_500_e50_d50_p2e200, "MNE007JA1-2"),
0547692ac14650 Xuxin Xiong                2023-12-18  2071  
a6325ad47bc808 Xuxin Xiong                2024-04-22  2072  	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1100, &delay_200_500_e80_d50, "MNB601LS1-1"),
29e93d0a04b6c5 Langyan Ye                 2024-12-27  2073  	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1103, &delay_200_500_e80_d50, "MNB601LS1-3"),
9b3700b15cb581 Langyan Ye                 2025-07-21  2074  	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1104, &delay_200_500_e50_d100, "MNB601LS1-4"),
490b30fbaca2ab Zhongtian Wu               2025-09-08  2075  	EDP_PANEL_ENTRY('C', 'S', 'W', 0x143f, &delay_200_500_e50, "MNE007QS3-6"),
0ca6d605885285 Langyan Ye                 2024-12-25  2076  	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1448, &delay_200_500_e50, "MNE007QS3-7"),
e3e41106106710 Zhongtian Wu               2025-09-15  2077  	EDP_PANEL_ENTRY('C', 'S', 'W', 0x144b, &delay_200_500_e80, "MNE001BS1-4"),
0d607a59a0f659 Zhengqiao Xia              2025-04-29  2078  	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1457, &delay_80_500_e80_p2e200, "MNE007QS3-8"),
518867b0939421 Cong Yang                  2025-07-31  2079  	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1462, &delay_200_500_e50, "MNE007QS5-2"),
518867b0939421 Cong Yang                  2025-07-31  2080  	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1468, &delay_200_500_e50, "MNE007QB2-2"),
490b30fbaca2ab Zhongtian Wu               2025-09-08  2081  	EDP_PANEL_ENTRY('C', 'S', 'W', 0x146e, &delay_80_500_e50_d50, "MNE007QB3-1"),
b1ea3babb67dcb Langyan Ye                 2025-11-27  2082  	EDP_PANEL_ENTRY('C', 'S', 'W', 0x147c, &delay_200_500_e50_d100, "MNE007QB3-1"),
e3e41106106710 Zhongtian Wu               2025-09-15  2083  	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1519, &delay_200_500_e80_d50, "MNF601BS1-3"),
41bf3b0d7dff9b Alvin1 Chen                2026-03-19  2084  +	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1529, &delay_200_500_e80_d50, "MNF307QS3-2"),
a6325ad47bc808 Xuxin Xiong                2024-04-22  2085  
0e1daf2b32dc85 Damon Ding                 2025-02-05  2086  	EDP_PANEL_ENTRY('E', 'T', 'C', 0x0000, &delay_50_500_e200_d200_po2e335, "LP079QX1-SP0V"),
0e1daf2b32dc85 Damon Ding                 2025-02-05  2087  
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  2088  	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d51, &delay_200_500_e200, "Unknown"),
21e97d3ca814ea Terry Hsiao                2024-08-02  2089  	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d5b, &delay_200_500_e200, "MB116AN01"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  2090  	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d5c, &delay_200_500_e200, "MB116AN01-2"),
5540cf8f3e8dac Douglas Anderson           2021-09-14  2091  
4d53cf81479500 Hsin-Yi Wang               2023-11-07  2092  	EDP_PANEL_ENTRY('I', 'V', 'O', 0x048e, &delay_200_500_e200_d10, "M116NWR6 R5"),
f6ff4570e567b6 Nícolas F. R. A. Prado     2022-07-19  2093  	EDP_PANEL_ENTRY('I', 'V', 'O', 0x057d, &delay_200_500_e200, "R140NWF5 RH"),
e22391454e3e8a Abel Vesa                  2022-12-31  2094  	EDP_PANEL_ENTRY('I', 'V', 'O', 0x854a, &delay_200_500_p2e100, "M133NW4J"),
9cce08cadc6ce8 Abel Vesa                  2022-12-31  2095  	EDP_PANEL_ENTRY('I', 'V', 'O', 0x854b, &delay_200_500_p2e100, "R133NW4K-R0"),
4d53cf81479500 Hsin-Yi Wang               2023-11-07  2096  	EDP_PANEL_ENTRY('I', 'V', 'O', 0x8c4d, &delay_200_150_e200, "R140NWFM R1"),
5540cf8f3e8dac Douglas Anderson           2021-09-14  2097  
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  2098  	EDP_PANEL_ENTRY('K', 'D', 'B', 0x044f, &delay_200_500_e80_d50, "Unknown"),
7d1be0a09fa621 Douglas Anderson           2021-09-24  2099  	EDP_PANEL_ENTRY('K', 'D', 'B', 0x0624, &kingdisplay_kd116n21_30nv_a010.delay, "116N21-30NV-A010"),
f4ccd9fea22707 Pin-yen Lin                2023-12-14  2100  	EDP_PANEL_ENTRY('K', 'D', 'B', 0x1118, &delay_200_500_e50, "KD116N29-30NK-A005"),
b889d89ad45f99 Yunlong Jia                2022-01-20  2101  	EDP_PANEL_ENTRY('K', 'D', 'B', 0x1120, &delay_200_500_e80_d50, "116N29-30NK-C007"),
a6cd27d92a96e1 Douglas Anderson           2024-05-02  2102  	EDP_PANEL_ENTRY('K', 'D', 'B', 0x1212, &delay_200_500_e50, "KD116N0930A16"),
ae4a812a64dad3 Langyan Ye                 2024-11-13  2103  	EDP_PANEL_ENTRY('K', 'D', 'B', 0x1707, &delay_200_150_e50, "KD116N2130B12"),
5540cf8f3e8dac Douglas Anderson           2021-09-14  2104  
65afe8b647a7c2 Zhijian Yan                2025-09-15  2105  	EDP_PANEL_ENTRY('K', 'D', 'C', 0x0110, &delay_200_500_e50, "KD116N3730A07"),
048deed5faf012 Zhijian Yan                2025-09-19  2106  	EDP_PANEL_ENTRY('K', 'D', 'C', 0x0397, &delay_200_500_e50, "KD116N3730A12"),
f4ccd9fea22707 Pin-yen Lin                2023-12-14  2107  	EDP_PANEL_ENTRY('K', 'D', 'C', 0x044f, &delay_200_500_e50, "KD116N9-30NH-F3"),
f4ccd9fea22707 Pin-yen Lin                2023-12-14  2108  	EDP_PANEL_ENTRY('K', 'D', 'C', 0x05f1, &delay_200_500_e80_d50, "KD116N5-30NV-G7"),
67a5f0ff342907 Pin-yen Lin                2023-12-07  2109  	EDP_PANEL_ENTRY('K', 'D', 'C', 0x0809, &delay_200_500_e50, "KD116N2930A15"),
a3436f63aa4f93 Langyan Ye                 2025-05-21  2110  	EDP_PANEL_ENTRY('K', 'D', 'C', 0x1220, &delay_200_500_e50, "KD116N3730A05"),
67a5f0ff342907 Pin-yen Lin                2023-12-07  2111  
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  2112  	EDP_PANEL_ENTRY('L', 'G', 'D', 0x0000, &delay_200_500_e200_d200, "Unknown"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  2113  	EDP_PANEL_ENTRY('L', 'G', 'D', 0x048d, &delay_200_500_e200_d200, "Unknown"),
f4ccd9fea22707 Pin-yen Lin                2023-12-14  2114  	EDP_PANEL_ENTRY('L', 'G', 'D', 0x0497, &delay_200_500_e200_d200, "LP116WH7-SPB1"),
f4ccd9fea22707 Pin-yen Lin                2023-12-14  2115  	EDP_PANEL_ENTRY('L', 'G', 'D', 0x052c, &delay_200_500_e200_d200, "LP133WF2-SPL7"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  2116  	EDP_PANEL_ENTRY('L', 'G', 'D', 0x0537, &delay_200_500_e200_d200, "Unknown"),
f4ccd9fea22707 Pin-yen Lin                2023-12-14  2117  	EDP_PANEL_ENTRY('L', 'G', 'D', 0x054a, &delay_200_500_e200_d200, "LP116WH8-SPC1"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  2118  	EDP_PANEL_ENTRY('L', 'G', 'D', 0x0567, &delay_200_500_e200_d200, "Unknown"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  2119  	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05af, &delay_200_500_e200_d200, "Unknown"),
7c8690d8fc80e6 Pin-yen Lin                2023-12-14  2120  	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05f1, &delay_200_500_e200_d200, "Unknown"),
6b3815c6815f07 Aleksandrs Vinarskis       2024-10-08  2121  	EDP_PANEL_ENTRY('L', 'G', 'D', 0x0778, &delay_200_500_e200_d200, "134WT1"),
f4ccd9fea22707 Pin-yen Lin                2023-12-14  2122  
9126ef85f2b865 Bjorn Andersson            2022-06-07  2123  	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1511, &delay_200_500_e50, "LQ140M1JW48"),
51e1fb144f17c2 Dmitry Baryshkov           2024-06-14  2124  	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &delay_80_500_e50, "LQ140M1JW46"),
336dca397dcefc Pin-yen Lin                2024-05-27  2125  	EDP_PANEL_ENTRY('S', 'H', 'P', 0x153a, &delay_200_500_e50, "LQ140T1JH01"),
7d1be0a09fa621 Douglas Anderson           2021-09-24  2126  	EDP_PANEL_ENTRY('S', 'H', 'P', 0x154c, &delay_200_500_p2e100, "LQ116M1JW10"),
754dbf164acd4d Christopher Orr            2025-08-05  2127  	EDP_PANEL_ENTRY('S', 'H', 'P', 0x158f, &delay_200_500_p2e100, "LQ134Z1"),
6b3815c6815f07 Aleksandrs Vinarskis       2024-10-08  2128  	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1593, &delay_200_500_p2e100, "LQ134N1"),
5540cf8f3e8dac Douglas Anderson           2021-09-14  2129  
749b5b279e5636 Douglas Anderson           2025-01-09  2130  	EDP_PANEL_ENTRY('S', 'T', 'A', 0x0004, &delay_200_500_e200, "116KHD024006"),
6ce24b3450b8e8 Langyan Ye                 2025-01-23  2131  	EDP_PANEL_ENTRY('S', 'T', 'A', 0x0009, &delay_200_500_e250, "116QHD024002"),
b889d89ad45f99 Yunlong Jia                2022-01-20  2132  	EDP_PANEL_ENTRY('S', 'T', 'A', 0x0100, &delay_100_500_e200, "2081116HHD028001-51D"),
b889d89ad45f99 Yunlong Jia                2022-01-20  2133  
518867b0939421 Cong Yang                  2025-07-31  2134  	EDP_PANEL_ENTRY('T', 'M', 'A', 0x0811, &delay_200_500_e80_d50, "TM140VDXP01-04"),
518867b0939421 Cong Yang                  2025-07-31  2135  	EDP_PANEL_ENTRY('T', 'M', 'A', 0x2094, &delay_200_500_e50_d100, "TL140VDMS03-01"),
518867b0939421 Cong Yang                  2025-07-31  2136  
5540cf8f3e8dac Douglas Anderson           2021-09-14  2137  	{ /* sentinal */ }
5540cf8f3e8dac Douglas Anderson           2021-09-14  2138  };
5540cf8f3e8dac Douglas Anderson           2021-09-14  2139  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
