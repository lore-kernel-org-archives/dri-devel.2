Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D71ECD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5A0610F0BA;
	Thu, 11 Jun 2026 18:14:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kFO2neaT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B1EB10F0C8
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 18:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781201662; x=1812737662;
 h=date:from:to:cc:subject:message-id;
 bh=Dmhn5NBbMicHyzEwxsFunFxV35gePGUaDfSECAEgIZA=;
 b=kFO2neaTU8L8dyaV+vpEsflayhHb6GsyxF5pIwRsrkAE+ts3RuyVIVns
 p4fjcvcbGxAzrtgq/YIe/+5H1dhJKlfeKA1aigyq1N3dWIOFsaTkusKVM
 g4jnCiEnhY/O/Dl/zE88Y69n1QDeNJdoJIyD9HTlzS5P/qy1cG1NWTKsX
 ZBjcA47sW9wgySRMSk6CMoNhJw1vHQOIPgDkHRNo3tAroA97RfUFAMANW
 Ld0231PZmXPVdBs7UxoV+xK2Z8dcl1+jv4MbQ0bsgESVxwLJM+X9ks7PR
 FsEVo4Qobo/bbO/FLxpJYtJsGKi8S4v85C5KzHRbf+D89/OahEvhcvyaW A==;
X-CSE-ConnectionGUID: QXVpkJb4QUmOT8O9pVO0pQ==
X-CSE-MsgGUID: PtRceGzwR6ySQtRCFm2jig==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="99446014"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="99446014"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 11:14:21 -0700
X-CSE-ConnectionGUID: lw3F7Fx5TE+AV8ZbWcRSYQ==
X-CSE-MsgGUID: TMpCa0AXSYCa/MeN50yRYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="270225440"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
 by fmviesa002.fm.intel.com with ESMTP; 11 Jun 2026 11:14:19 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wXjuy-00000000Nds-2nHB;
 Thu, 11 Jun 2026 18:14:16 +0000
Date: Fri, 12 Jun 2026 02:14:05 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Daniel Stone <daniels@collabora.com>, Maxime Ripard <mripard@kernel.org>
Subject: [drm-misc:drm-misc-next 21/24]
 drivers/gpu/drm/tests/drm_kunit_edid.h:958:28: warning:
 'test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz' defined but not used
Message-ID: <202606120201.5E4O2N7N-lkp@intel.com>
User-Agent: s-nail v14.9.25
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

tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
head:   b0d3a2454333322d49ed65d5ef617aa7b305b607
commit: 082fbc179c012d2ab441575f1d9386088c0c88be [21/24] drm/tests: bridge: Add KUnit tests for bridge chain format selection
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20260612/202606120201.5E4O2N7N-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260612/202606120201.5E4O2N7N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606120201.5E4O2N7N-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/tests/drm_bridge_test.c:20:
>> drivers/gpu/drm/tests/drm_kunit_edid.h:958:28: warning: 'test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz' defined but not used [-Wunused-const-variable=]
     958 | static const unsigned char test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz[] = {
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/tests/drm_kunit_edid.h:726:28: warning: 'test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz' defined but not used [-Wunused-const-variable=]
     726 | static const unsigned char test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz[] = {
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/tests/drm_kunit_edid.h:612:28: warning: 'test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz' defined but not used [-Wunused-const-variable=]
     612 | static const unsigned char test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz[] = {
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/tests/drm_kunit_edid.h:498:28: warning: 'test_edid_hdmi_1080p_rgb_max_340mhz' defined but not used [-Wunused-const-variable=]
     498 | static const unsigned char test_edid_hdmi_1080p_rgb_max_340mhz[] = {
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/tests/drm_kunit_edid.h:390:28: warning: 'test_edid_hdmi_1080p_rgb_max_200mhz_hdr' defined but not used [-Wunused-const-variable=]
     390 | static const unsigned char test_edid_hdmi_1080p_rgb_max_200mhz_hdr[] = {
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/tests/drm_kunit_edid.h:271:28: warning: 'test_edid_hdmi_1080p_rgb_max_200mhz' defined but not used [-Wunused-const-variable=]
     271 | static const unsigned char test_edid_hdmi_1080p_rgb_max_200mhz[] = {
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/tests/drm_kunit_edid.h:163:28: warning: 'test_edid_hdmi_1080p_rgb_max_100mhz' defined but not used [-Wunused-const-variable=]
     163 | static const unsigned char test_edid_hdmi_1080p_rgb_max_100mhz[] = {
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/tests/drm_kunit_edid.h:57:28: warning: 'test_edid_dvi_1080p' defined but not used [-Wunused-const-variable=]
      57 | static const unsigned char test_edid_dvi_1080p[] = {
         |                            ^~~~~~~~~~~~~~~~~~~
--
>> Warning: drivers/gpu/drm/tests/drm_bridge_test.c:126 struct member 'in_fmt' not described in 'fmt_tuple'
>> Warning: drivers/gpu/drm/tests/drm_bridge_test.c:126 struct member 'out_fmt' not described in 'fmt_tuple'
>> Warning: drivers/gpu/drm/tests/drm_bridge_test.c:126 struct member 'in_fmt' not described in 'fmt_tuple'
>> Warning: drivers/gpu/drm/tests/drm_bridge_test.c:126 struct member 'out_fmt' not described in 'fmt_tuple'


vim +/test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz +958 drivers/gpu/drm/tests/drm_kunit_edid.h

58fe1d78605e78e Cristian Ciocaltea 2025-05-27  868  
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  869  /*
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  870   * Max resolution: 3840x2160@30Hz with RGB, YUV444, YUV422, YUV420
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  871   * Max BPC:        16 for all modes
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  872   * Max TMDS clock: 340 MHz
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  873   *
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  874   * edid-decode (hex):
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  875   *
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  876   * 00 ff ff ff ff ff ff 00 31 d8 34 00 00 00 00 00
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  877   * ff 23 01 03 80 60 36 78 0f ee 91 a3 54 4c 99 26
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  878   * 0f 50 54 20 00 00 01 01 01 01 01 01 01 01 01 01
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  879   * 01 01 01 01 01 01 04 74 00 30 f2 70 5a 80 b0 58
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  880   * 8a 00 40 84 63 00 00 1e 00 00 00 fc 00 54 65 73
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  881   * 74 20 45 44 49 44 0a 20 20 20 00 00 00 fd 00 18
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  882   * 55 18 5e 22 00 0a 20 20 20 20 20 20 00 00 00 10
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  883   * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 ce
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  884   *
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  885   * 02 03 27 31 41 5f 6c 03 0c 00 10 00 78 44 20 00
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  886   * 00 01 03 6d d8 5d c4 01 44 80 07 00 00 00 00 00
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  887   * 00 e3 0f 01 00 e1 0e 00 00 00 00 00 00 00 00 00
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  888   * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  889   * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  890   * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  891   * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  892   * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 84
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  893   *
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  894   * ----------------
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  895   *
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  896   * Block 0, Base EDID:
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  897   *   EDID Structure Version & Revision: 1.3
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  898   *   Vendor & Product Identification:
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  899   *     Manufacturer: LNX
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  900   *     Model: 52
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  901   *     Model year: 2025
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  902   *   Basic Display Parameters & Features:
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  903   *     Digital display
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  904   *     Maximum image size: 96 cm x 54 cm
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  905   *     Gamma: 2.20
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  906   *     RGB color display
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  907   *     Default (sRGB) color space is primary color space
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  908   *     First detailed timing is the preferred timing
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  909   *     Supports GTF timings within operating range
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  910   *   Color Characteristics:
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  911   *     Red  : 0.6396, 0.3300
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  912   *     Green: 0.2998, 0.5996
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  913   *     Blue : 0.1503, 0.0595
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  914   *     White: 0.3125, 0.3291
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  915   *   Established Timings I & II:
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  916   *     DMT 0x04:   640x480    59.940476 Hz   4:3     31.469 kHz     25.175000 MHz
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  917   *   Standard Timings: none
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  918   *   Detailed Timing Descriptors:
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  919   *     DTD 1:  3840x2160   30.000000 Hz  16:9     67.500 kHz    297.000000 MHz (1600 mm x 900 mm)
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  920   *                  Hfront  176 Hsync  88 Hback  296 Hpol P
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  921   *                  Vfront    8 Vsync  10 Vback   72 Vpol P
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  922   *     Display Product Name: 'Test EDID'
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  923   *     Display Range Limits:
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  924   *       Monitor ranges (GTF): 24-85 Hz V, 24-94 kHz H, max dotclock 340 MHz
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  925   *     Dummy Descriptor:
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  926   *   Extension blocks: 1
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  927   * Checksum: 0xce
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  928   *
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  929   * ----------------
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  930   *
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  931   * Block 1, CTA-861 Extension Block:
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  932   *   Revision: 3
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  933   *   Supports YCbCr 4:4:4
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  934   *   Supports YCbCr 4:2:2
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  935   *   Native detailed modes: 1
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  936   *   Video Data Block:
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  937   *     VIC  95:  3840x2160   30.000000 Hz  16:9     67.500 kHz    297.000000 MHz
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  938   *   Vendor-Specific Data Block (HDMI), OUI 00-0C-03:
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  939   *     Source physical address: 1.0.0.0
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  940   *     DC_48bit
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  941   *     DC_36bit
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  942   *     DC_30bit
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  943   *     DC_Y444
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  944   *     Maximum TMDS clock: 340 MHz
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  945   *     Extended HDMI video details:
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  946   *   Vendor-Specific Data Block (HDMI Forum), OUI C4-5D-D8:
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  947   *     Version: 1
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  948   *     Maximum TMDS Character Rate: 340 MHz
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  949   *     SCDC Present
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  950   *     Supports 16-bits/component Deep Color 4:2:0 Pixel Encoding
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  951   *     Supports 12-bits/component Deep Color 4:2:0 Pixel Encoding
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  952   *     Supports 10-bits/component Deep Color 4:2:0 Pixel Encoding
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  953   *   YCbCr 4:2:0 Capability Map Data Block:
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  954   *     VIC  95:  3840x2160   30.000000 Hz  16:9     67.500 kHz    297.000000 MHz
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  955   *   YCbCr 4:2:0 Video Data Block:
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  956   * Checksum: 0x84
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  957   */
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27 @958  static const unsigned char test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz[] = {
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  959  	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x31, 0xd8, 0x34, 0x00,
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  960  	0x00, 0x00, 0x00, 0x00, 0xff, 0x23, 0x01, 0x03, 0x80, 0x60, 0x36, 0x78,
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  961  	0x0f, 0xee, 0x91, 0xa3, 0x54, 0x4c, 0x99, 0x26, 0x0f, 0x50, 0x54, 0x20,
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  962  	0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  963  	0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x04, 0x74, 0x00, 0x30, 0xf2, 0x70,
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  964  	0x5a, 0x80, 0xb0, 0x58, 0x8a, 0x00, 0x40, 0x84, 0x63, 0x00, 0x00, 0x1e,
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  965  	0x00, 0x00, 0x00, 0xfc, 0x00, 0x54, 0x65, 0x73, 0x74, 0x20, 0x45, 0x44,
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  966  	0x49, 0x44, 0x0a, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0xfd, 0x00, 0x18,
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  967  	0x55, 0x18, 0x5e, 0x22, 0x00, 0x0a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  968  	0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  969  	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xce, 0x02, 0x03, 0x27, 0x31,
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  970  	0x41, 0x5f, 0x6c, 0x03, 0x0c, 0x00, 0x10, 0x00, 0x78, 0x44, 0x20, 0x00,
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  971  	0x00, 0x01, 0x03, 0x6d, 0xd8, 0x5d, 0xc4, 0x01, 0x44, 0x80, 0x07, 0x00,
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  972  	0x00, 0x00, 0x00, 0x00, 0x00, 0xe3, 0x0f, 0x01, 0x00, 0xe1, 0x0e, 0x00,
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  973  	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  974  	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  975  	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  976  	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  977  	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  978  	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  979  	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  980  	0x00, 0x00, 0x00, 0x84
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  981  };
54a5f1c4d5f84af Cristian Ciocaltea 2025-05-27  982  

:::::: The code at line 958 was first introduced by commit
:::::: 54a5f1c4d5f84af18a971c665df751ee3f0423dc drm/tests: hdmi: Provide EDID supporting 4K@30Hz with RGB/YUV

:::::: TO: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
:::::: CC: Maxime Ripard <mripard@kernel.org>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
