Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94A21094478
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 14:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E225E10E1AE;
	Sat, 21 Mar 2026 14:03:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Aa2FkfzG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE52B10E1AE
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 14:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774101818; x=1805637818;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=FRv90kLZug3KRFd8xcLX0z+8Cuk8B1Spo/fRH5+xPaI=;
 b=Aa2FkfzGE5cHW2gEq+LVLgWj+G+pVp0TIHHDGsP9kNd/vjFSCekzxbS0
 +dtTKT+1o0h0HsX6HP2C2N4gvGmASAQO9vAnqN4Q9Wf7M4W4uKAyj76/h
 Px4F/W+kwIw4rzgbLIvlDmJDOfctbzE9IKs2aUm5nTYA8P24UlR62QsVf
 L8isWtL6ViBZyejA/pT0CgEUSxbVdzez3adRsAAOZYQ3fgZ7Cd5qHNrlg
 eT17S9/tfJk+liI3RzNK5+1KQFVCcJ8HF+ApebPjQF22XUhd2UqB/1sDv
 Mov1fUsV13JMPuLFVW9Sbsoi6w2rYYmTKYpn2Et0UzDeV2eHvZ7+GGUBA A==;
X-CSE-ConnectionGUID: rs2aCYTOQISD0JSE99xHYg==
X-CSE-MsgGUID: m+p8rgU6SsCHkQAtltFSzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="77775720"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; d="scan'208";a="77775720"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2026 07:03:37 -0700
X-CSE-ConnectionGUID: IgQPKnnxQJ6moIRSXUeleQ==
X-CSE-MsgGUID: TMAc5za6T0K/M+HzqOd4cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; d="scan'208";a="228506096"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2)
 ([10.211.93.152])
 by orviesa005.jf.intel.com with ESMTP; 21 Mar 2026 07:03:35 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w3wvM-00000000681-1JcY;
 Sat, 21 Mar 2026 14:03:32 +0000
Date: Sat, 21 Mar 2026 15:03:30 +0100
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
Message-ID: <202603211444.JZ4VbAPo-lkp@intel.com>
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
config: i386-randconfig-2006-20250825 (https://download.01.org/0day-ci/archive/20260321/202603211444.JZ4VbAPo-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260321/202603211444.JZ4VbAPo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603211444.JZ4VbAPo-lkp@intel.com/

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

f4ccd9fea22707 Pin-yen Lin            2023-12-14  1752  
5540cf8f3e8dac Douglas Anderson       2021-09-14 @1753  static const struct panel_delay delay_200_500_p2e100 = {
5540cf8f3e8dac Douglas Anderson       2021-09-14  1754  	.hpd_absent = 200,
5540cf8f3e8dac Douglas Anderson       2021-09-14  1755  	.unprepare = 500,
5540cf8f3e8dac Douglas Anderson       2021-09-14  1756  	.prepare_to_enable = 100,
5540cf8f3e8dac Douglas Anderson       2021-09-14  1757  };
5540cf8f3e8dac Douglas Anderson       2021-09-14  1758  
349d4efadc1f83 Hans de Goede          2026-01-05  1759  static const struct panel_delay delay_200_500_p2e200 = {
349d4efadc1f83 Hans de Goede          2026-01-05  1760  	.hpd_absent = 200,
349d4efadc1f83 Hans de Goede          2026-01-05  1761  	.unprepare = 500,
349d4efadc1f83 Hans de Goede          2026-01-05  1762  	.prepare_to_enable = 200,
349d4efadc1f83 Hans de Goede          2026-01-05  1763  };
349d4efadc1f83 Hans de Goede          2026-01-05  1764  
5540cf8f3e8dac Douglas Anderson       2021-09-14  1765  static const struct panel_delay delay_200_500_e50 = {
5540cf8f3e8dac Douglas Anderson       2021-09-14  1766  	.hpd_absent = 200,
5540cf8f3e8dac Douglas Anderson       2021-09-14  1767  	.unprepare = 500,
5540cf8f3e8dac Douglas Anderson       2021-09-14  1768  	.enable = 50,
5540cf8f3e8dac Douglas Anderson       2021-09-14  1769  };
5540cf8f3e8dac Douglas Anderson       2021-09-14  1770  
1511d3c4d2bb30 Langyan Ye             2025-07-23 @1771  static const struct panel_delay delay_200_500_e50_d50_p2e200 = {
e635b7eb7062b4 Zhengqiao Xia          2024-03-01  1772  	.hpd_absent = 200,
e635b7eb7062b4 Zhengqiao Xia          2024-03-01  1773  	.unprepare = 500,
e635b7eb7062b4 Zhengqiao Xia          2024-03-01  1774  	.enable = 50,
1511d3c4d2bb30 Langyan Ye             2025-07-23  1775  	.disable = 50,
e635b7eb7062b4 Zhengqiao Xia          2024-03-01  1776  	.prepare_to_enable = 200,
e635b7eb7062b4 Zhengqiao Xia          2024-03-01  1777  };
e635b7eb7062b4 Zhengqiao Xia          2024-03-01  1778  
4d53cf81479500 Hsin-Yi Wang           2023-11-07  1779  static const struct panel_delay delay_200_500_e80 = {
4d53cf81479500 Hsin-Yi Wang           2023-11-07  1780  	.hpd_absent = 200,
4d53cf81479500 Hsin-Yi Wang           2023-11-07  1781  	.unprepare = 500,
4d53cf81479500 Hsin-Yi Wang           2023-11-07  1782  	.enable = 80,
4d53cf81479500 Hsin-Yi Wang           2023-11-07  1783  };
4d53cf81479500 Hsin-Yi Wang           2023-11-07  1784  
b889d89ad45f99 Yunlong Jia            2022-01-20  1785  static const struct panel_delay delay_200_500_e80_d50 = {
b889d89ad45f99 Yunlong Jia            2022-01-20  1786  	.hpd_absent = 200,
b889d89ad45f99 Yunlong Jia            2022-01-20  1787  	.unprepare = 500,
b889d89ad45f99 Yunlong Jia            2022-01-20  1788  	.enable = 80,
b889d89ad45f99 Yunlong Jia            2022-01-20  1789  	.disable = 50,
b889d89ad45f99 Yunlong Jia            2022-01-20  1790  };
b889d89ad45f99 Yunlong Jia            2022-01-20  1791  
51e1fb144f17c2 Dmitry Baryshkov       2024-06-14 @1792  static const struct panel_delay delay_80_500_e50 = {
51e1fb144f17c2 Dmitry Baryshkov       2024-06-14  1793  	.hpd_absent = 80,
51e1fb144f17c2 Dmitry Baryshkov       2024-06-14  1794  	.unprepare = 500,
51e1fb144f17c2 Dmitry Baryshkov       2024-06-14  1795  	.enable = 50,
51e1fb144f17c2 Dmitry Baryshkov       2024-06-14  1796  };
51e1fb144f17c2 Dmitry Baryshkov       2024-06-14  1797  
0d607a59a0f659 Zhengqiao Xia          2025-04-29 @1798  static const struct panel_delay delay_80_500_e80_p2e200 = {
0d607a59a0f659 Zhengqiao Xia          2025-04-29  1799  	.hpd_absent = 80,
0d607a59a0f659 Zhengqiao Xia          2025-04-29  1800  	.unprepare = 500,
0d607a59a0f659 Zhengqiao Xia          2025-04-29  1801  	.enable = 80,
0d607a59a0f659 Zhengqiao Xia          2025-04-29  1802  	.prepare_to_enable = 200,
0d607a59a0f659 Zhengqiao Xia          2025-04-29  1803  };
0d607a59a0f659 Zhengqiao Xia          2025-04-29  1804  
b889d89ad45f99 Yunlong Jia            2022-01-20 @1805  static const struct panel_delay delay_100_500_e200 = {
b889d89ad45f99 Yunlong Jia            2022-01-20  1806  	.hpd_absent = 100,
b889d89ad45f99 Yunlong Jia            2022-01-20  1807  	.unprepare = 500,
b889d89ad45f99 Yunlong Jia            2022-01-20  1808  	.enable = 200,
b889d89ad45f99 Yunlong Jia            2022-01-20  1809  };
b889d89ad45f99 Yunlong Jia            2022-01-20  1810  
f6ff4570e567b6 Nícolas F. R. A. Prado 2022-07-19  1811  static const struct panel_delay delay_200_500_e200 = {
f6ff4570e567b6 Nícolas F. R. A. Prado 2022-07-19  1812  	.hpd_absent = 200,
f6ff4570e567b6 Nícolas F. R. A. Prado 2022-07-19  1813  	.unprepare = 500,
f6ff4570e567b6 Nícolas F. R. A. Prado 2022-07-19  1814  	.enable = 200,
f6ff4570e567b6 Nícolas F. R. A. Prado 2022-07-19  1815  };
f6ff4570e567b6 Nícolas F. R. A. Prado 2022-07-19  1816  
bbe814bcb961ed Haikun Zhou            2026-02-26  1817  static const struct panel_delay delay_200_500_e200_d100 = {
bbe814bcb961ed Haikun Zhou            2026-02-26  1818  	.hpd_absent = 200,
bbe814bcb961ed Haikun Zhou            2026-02-26  1819  	.unprepare = 500,
bbe814bcb961ed Haikun Zhou            2026-02-26  1820  	.enable = 200,
bbe814bcb961ed Haikun Zhou            2026-02-26  1821  	.disable = 100,
bbe814bcb961ed Haikun Zhou            2026-02-26  1822  };
bbe814bcb961ed Haikun Zhou            2026-02-26  1823  
f4ccd9fea22707 Pin-yen Lin            2023-12-14 @1824  static const struct panel_delay delay_200_500_e200_d200 = {
f4ccd9fea22707 Pin-yen Lin            2023-12-14  1825  	.hpd_absent = 200,
f4ccd9fea22707 Pin-yen Lin            2023-12-14  1826  	.unprepare = 500,
f4ccd9fea22707 Pin-yen Lin            2023-12-14  1827  	.enable = 200,
f4ccd9fea22707 Pin-yen Lin            2023-12-14  1828  	.disable = 200,
f4ccd9fea22707 Pin-yen Lin            2023-12-14  1829  };
f4ccd9fea22707 Pin-yen Lin            2023-12-14  1830  
4d53cf81479500 Hsin-Yi Wang           2023-11-07 @1831  static const struct panel_delay delay_200_500_e200_d10 = {
4d53cf81479500 Hsin-Yi Wang           2023-11-07  1832  	.hpd_absent = 200,
4d53cf81479500 Hsin-Yi Wang           2023-11-07  1833  	.unprepare = 500,
4d53cf81479500 Hsin-Yi Wang           2023-11-07  1834  	.enable = 200,
4d53cf81479500 Hsin-Yi Wang           2023-11-07  1835  	.disable = 10,
4d53cf81479500 Hsin-Yi Wang           2023-11-07  1836  };
4d53cf81479500 Hsin-Yi Wang           2023-11-07  1837  
518867b0939421 Cong Yang              2025-07-31 @1838  static const struct panel_delay delay_200_500_e200_d50 = {
518867b0939421 Cong Yang              2025-07-31  1839  	.hpd_absent = 200,
518867b0939421 Cong Yang              2025-07-31  1840  	.unprepare = 500,
518867b0939421 Cong Yang              2025-07-31  1841  	.enable = 200,
518867b0939421 Cong Yang              2025-07-31  1842  	.disable = 50,
518867b0939421 Cong Yang              2025-07-31  1843  };
518867b0939421 Cong Yang              2025-07-31  1844  
4d53cf81479500 Hsin-Yi Wang           2023-11-07  1845  static const struct panel_delay delay_200_150_e200 = {
4d53cf81479500 Hsin-Yi Wang           2023-11-07  1846  	.hpd_absent = 200,
4d53cf81479500 Hsin-Yi Wang           2023-11-07  1847  	.unprepare = 150,
4d53cf81479500 Hsin-Yi Wang           2023-11-07  1848  	.enable = 200,
4d53cf81479500 Hsin-Yi Wang           2023-11-07  1849  };
4d53cf81479500 Hsin-Yi Wang           2023-11-07  1850  
f4ccd9fea22707 Pin-yen Lin            2023-12-14  1851  static const struct panel_delay delay_200_500_e50_po2e200 = {
f4ccd9fea22707 Pin-yen Lin            2023-12-14  1852  	.hpd_absent = 200,
f4ccd9fea22707 Pin-yen Lin            2023-12-14  1853  	.unprepare = 500,
f4ccd9fea22707 Pin-yen Lin            2023-12-14  1854  	.enable = 50,
f4ccd9fea22707 Pin-yen Lin            2023-12-14  1855  	.powered_on_to_enable = 200,
f4ccd9fea22707 Pin-yen Lin            2023-12-14  1856  };
f4ccd9fea22707 Pin-yen Lin            2023-12-14  1857  
ae4a812a64dad3 Langyan Ye             2024-11-13 @1858  static const struct panel_delay delay_200_150_e50 = {
ae4a812a64dad3 Langyan Ye             2024-11-13  1859  	.hpd_absent = 200,
ae4a812a64dad3 Langyan Ye             2024-11-13  1860  	.unprepare = 150,
ae4a812a64dad3 Langyan Ye             2024-11-13  1861  	.enable = 50,
ae4a812a64dad3 Langyan Ye             2024-11-13  1862  };
ae4a812a64dad3 Langyan Ye             2024-11-13  1863  
6ce24b3450b8e8 Langyan Ye             2025-01-23 @1864  static const struct panel_delay delay_200_500_e250 = {
6ce24b3450b8e8 Langyan Ye             2025-01-23  1865  	.hpd_absent = 200,
6ce24b3450b8e8 Langyan Ye             2025-01-23  1866  	.unprepare = 500,
6ce24b3450b8e8 Langyan Ye             2025-01-23  1867  	.enable = 250,
6ce24b3450b8e8 Langyan Ye             2025-01-23  1868  };
6ce24b3450b8e8 Langyan Ye             2025-01-23  1869  
0e1daf2b32dc85 Damon Ding             2025-02-05 @1870  static const struct panel_delay delay_50_500_e200_d200_po2e335 = {
0e1daf2b32dc85 Damon Ding             2025-02-05  1871  	.hpd_absent = 50,
0e1daf2b32dc85 Damon Ding             2025-02-05  1872  	.unprepare = 500,
0e1daf2b32dc85 Damon Ding             2025-02-05  1873  	.enable = 200,
0e1daf2b32dc85 Damon Ding             2025-02-05  1874  	.disable = 200,
0e1daf2b32dc85 Damon Ding             2025-02-05  1875  	.powered_on_to_enable = 335,
0e1daf2b32dc85 Damon Ding             2025-02-05  1876  };
0e1daf2b32dc85 Damon Ding             2025-02-05  1877  
9b3700b15cb581 Langyan Ye             2025-07-21 @1878  static const struct panel_delay delay_200_500_e50_d100 = {
9b3700b15cb581 Langyan Ye             2025-07-21  1879  	.hpd_absent = 200,
9b3700b15cb581 Langyan Ye             2025-07-21  1880  	.unprepare = 500,
9b3700b15cb581 Langyan Ye             2025-07-21  1881  	.enable = 50,
9b3700b15cb581 Langyan Ye             2025-07-21  1882  	.disable = 100,
9b3700b15cb581 Langyan Ye             2025-07-21  1883  };
9b3700b15cb581 Langyan Ye             2025-07-21  1884  
490b30fbaca2ab Zhongtian Wu           2025-09-08 @1885  static const struct panel_delay delay_80_500_e50_d50 = {
490b30fbaca2ab Zhongtian Wu           2025-09-08  1886  	.hpd_absent = 80,
490b30fbaca2ab Zhongtian Wu           2025-09-08  1887  	.unprepare = 500,
490b30fbaca2ab Zhongtian Wu           2025-09-08  1888  	.enable = 50,
490b30fbaca2ab Zhongtian Wu           2025-09-08  1889  	.disable = 50,
490b30fbaca2ab Zhongtian Wu           2025-09-08  1890  };
490b30fbaca2ab Zhongtian Wu           2025-09-08  1891  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
