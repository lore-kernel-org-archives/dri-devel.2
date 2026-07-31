Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B75C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F250410F327;
	Fri, 31 Jul 2026 16:23:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="hMkU4QD+";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FD0510F30D
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785514796;
 bh=+vnOPavb35iYOmhQFn+rlvlLoNLZ072zJc+5bQT07Uk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=hMkU4QD+O3UwnonlYRI/WnWqiZ06CLA4Wy59YLnpewwglhrw8GHpEj9KHkvatmHQz
 hJpEZS4oK+0elzsgZmGxHcgY6GPSStrGZj08N/iSWa2uu5fUt99vmfmsTw0a0ufA3g
 O6QXg2HjWNswjjTkko8RRjtfIGqNZTgunZ93Gev4wZR4ImJxjEjA6trLuPfeDmbRUK
 5p3JL+F7fFOZEdJ4IbD6EjhqvvdlepPtX3hwElMOoHZ4uk6N5cJBLJUWWGzbFNogvp
 hBeb8x/VPJpWi3N8g2ev1jB2rwqpDKGiHlJ4PwqIZFzOtYV+aVMWPeKSLS2//p3ABt
 Wj6clecD9reSA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EAD9A17E09A0;
 Fri, 31 Jul 2026 18:19:55 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 31 Jul 2026 19:20:05 +0300
Subject: [PATCH v10 58/69] drm/tests: edid: Fix conformity for 4K RGB/YUV
 340MHz EDID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-dw-hdmi-qp-scramb-v10-58-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org
X-Mailer: b4 0.15.2
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

The test EDID added by commit 54a5f1c4d5f8 ("drm/tests: hdmi: Provide
EDID supporting 4K@30Hz with RGB/YUV") fails 'edid-decode --check'
(v1.33.0) with the following issues:

  Warnings:

  Block 1, CTA-861 Extension Block:
    IT Video Formats are overscanned by default, but normally this should be underscanned.
    YCbCr 4:2:0 Capability Map Data Block: Some YCbCr 4:2:0 timings are invalid for HDMI 2.1
      (which requires an RGB timings pixel rate >= 590 MHz).

  Failures:

  Block 0, Base EDID:
    Vendor & Product Identification: EDID 1.3 does not support week 0xff.
    Detailed Timing Descriptor #1: Mismatch of image size 1600x900 mm vs display size 960x540 mm.
  Block 1, CTA-861 Extension Block:
    Vendor-Specific Data Block (HDMI Forum), OUI C4-5D-D8: Max TMDS rate is > 0 and <= 340 or > 600.
    YCbCr 4:2:0 Video Data Block: This Data Block is empty.
    Missing VCDB, needed for Set Selectable RGB Quantization to avoid interop issues.
  EDID:
    Base EDID: The DTD max image size is 1600x900mm, which is larger than the display size 960.0x540.0mm.

Address them while preserving the advertised maximum resolution, BPC and
TMDS clock used by the existing KUnit tests:

- Week 0xff is not valid for EDID 1.3; set it to 0x00 so that the Model
  year field becomes a regular Year of Manufacture.
- Align the DTD image size with the Basic Display Parameters maximum
  image size (96 cm x 54 cm).
- The HDMI Forum VSDB Max TMDS Character Rate must be 0 when no rate
  above 340 MHz is supported.  The HDMI VSDB still advertises 340 MHz as
  Max TMDS Clock.
- Drop the empty YCbCr 4:2:0 Video Data Block.  VIC 95 (3840x2160@30Hz)
  remains advertised as YUV420-capable via the YCbCr 4:2:0 Capability
  Map Data Block, which references the corresponding entry in the
  regular Video Data Block.
- Add a Video Capability Data Block advertising selectable RGB and YCC
  quantization range plus underscan for IT/CE formats; also set the 'IT
  Video Formats Underscanned' bit in the CTA-861 extension header to
  match.

The only remaining warning is HDMI 2.1 related and can be ignored, as it
requires that any mode listed in the YCbCr 4:2:0 Video Data Block must
have a corresponding RGB pixel clock >= 590 MHz.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_kunit_edid.c | 57 ++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_kunit_edid.c b/drivers/gpu/drm/tests/drm_kunit_edid.c
index 4dff28fff796..a6c5e8d6077a 100644
--- a/drivers/gpu/drm/tests/drm_kunit_edid.c
+++ b/drivers/gpu/drm/tests/drm_kunit_edid.c
@@ -900,22 +900,22 @@ EXPORT_SYMBOL(test_edid_hdmi_1080p_rgb_yuv_4k_yuv420_dc_max_200mhz);
  * edid-decode (hex):
  *
  * 00 ff ff ff ff ff ff 00 31 d8 34 00 00 00 00 00
- * ff 23 01 03 80 60 36 78 0f ee 91 a3 54 4c 99 26
+ * 00 23 01 03 80 60 36 78 0f ee 91 a3 54 4c 99 26
  * 0f 50 54 20 00 00 01 01 01 01 01 01 01 01 01 01
  * 01 01 01 01 01 01 04 74 00 30 f2 70 5a 80 b0 58
- * 8a 00 40 84 63 00 00 1e 00 00 00 fc 00 54 65 73
+ * 8a 00 c0 1c 32 00 00 1e 00 00 00 fc 00 54 65 73
  * 74 20 45 44 49 44 0a 20 20 20 00 00 00 fd 00 18
  * 55 18 5e 22 00 0a 20 20 20 20 20 20 00 00 00 10
- * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 ce
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 e6
  *
- * 02 03 27 31 41 5f 6c 03 0c 00 10 00 78 44 20 00
- * 00 01 03 6d d8 5d c4 01 44 80 07 00 00 00 00 00
- * 00 e3 0f 01 00 e1 0e 00 00 00 00 00 00 00 00 00
+ * 02 03 28 b1 41 5f 6c 03 0c 00 10 00 78 44 20 00
+ * 00 01 03 6d d8 5d c4 01 00 80 07 00 00 00 00 00
+ * 00 e2 00 ca e3 0f 01 00 00 00 00 00 00 00 00 00
  * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
- * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 84
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 8a
  *
  * ----------------
  *
@@ -924,7 +924,7 @@ EXPORT_SYMBOL(test_edid_hdmi_1080p_rgb_yuv_4k_yuv420_dc_max_200mhz);
  *   Vendor & Product Identification:
  *     Manufacturer: LNX
  *     Model: 52
- *     Model year: 2025
+ *     Made in: 2025
  *   Basic Display Parameters & Features:
  *     Digital display
  *     Maximum image size: 96 cm x 54 cm
@@ -942,7 +942,7 @@ EXPORT_SYMBOL(test_edid_hdmi_1080p_rgb_yuv_4k_yuv420_dc_max_200mhz);
  *     DMT 0x04:   640x480    59.940476 Hz   4:3     31.469 kHz     25.175000 MHz
  *   Standard Timings: none
  *   Detailed Timing Descriptors:
- *     DTD 1:  3840x2160   30.000000 Hz  16:9     67.500 kHz    297.000000 MHz (1600 mm x 900 mm)
+ *     DTD 1:  3840x2160   30.000000 Hz  16:9     67.500 kHz    297.000000 MHz (960 mm x 540 mm)
  *                  Hfront  176 Hsync  88 Hback  296 Hpol P
  *                  Vfront    8 Vsync  10 Vback   72 Vpol P
  *     Display Product Name: 'Test EDID'
@@ -950,12 +950,13 @@ EXPORT_SYMBOL(test_edid_hdmi_1080p_rgb_yuv_4k_yuv420_dc_max_200mhz);
  *       Monitor ranges (GTF): 24-85 Hz V, 24-94 kHz H, max dotclock 340 MHz
  *     Dummy Descriptor:
  *   Extension blocks: 1
- * Checksum: 0xce
+ * Checksum: 0xe6
  *
  * ----------------
  *
  * Block 1, CTA-861 Extension Block:
  *   Revision: 3
+ *   Underscans IT Video Formats by default
  *   Supports YCbCr 4:4:4
  *   Supports YCbCr 4:2:2
  *   Native detailed modes: 1
@@ -971,31 +972,49 @@ EXPORT_SYMBOL(test_edid_hdmi_1080p_rgb_yuv_4k_yuv420_dc_max_200mhz);
  *     Extended HDMI video details:
  *   Vendor-Specific Data Block (HDMI Forum), OUI C4-5D-D8:
  *     Version: 1
- *     Maximum TMDS Character Rate: 340 MHz
  *     SCDC Present
  *     Supports 16-bits/component Deep Color 4:2:0 Pixel Encoding
  *     Supports 12-bits/component Deep Color 4:2:0 Pixel Encoding
  *     Supports 10-bits/component Deep Color 4:2:0 Pixel Encoding
+ *     VRRmin: 0 Hz
+ *     VRRmax: 0 Hz
+ *   Video Capability Data Block:
+ *     YCbCr quantization: Selectable (via AVI YQ)
+ *     RGB quantization: Selectable (via AVI Q)
+ *     PT scan behavior: No Data
+ *     IT scan behavior: Always Underscanned
+ *     CE scan behavior: Always Underscanned
  *   YCbCr 4:2:0 Capability Map Data Block:
  *     VIC  95:  3840x2160   30.000000 Hz  16:9     67.500 kHz    297.000000 MHz
- *   YCbCr 4:2:0 Video Data Block:
- * Checksum: 0x84
+ * Checksum: 0x8a  Unused space in Extension Block: 87 bytes
+ *
+ * ----------------
+ *
+ * edid-decode 1.33.0
+ *
+ * Warnings:
+ *
+ * Block 1, CTA-861 Extension Block:
+ *   YCbCr 4:2:0 Capability Map Data Block: Some YCbCr 4:2:0 timings are invalid for HDMI 2.1
+ *     (which requires an RGB timings pixel rate >= 590 MHz).
+ *
+ * EDID conformity: PASS
  */
 const unsigned char test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz[] = {
 	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x31, 0xd8, 0x34, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0xff, 0x23, 0x01, 0x03, 0x80, 0x60, 0x36, 0x78,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x23, 0x01, 0x03, 0x80, 0x60, 0x36, 0x78,
 	0x0f, 0xee, 0x91, 0xa3, 0x54, 0x4c, 0x99, 0x26, 0x0f, 0x50, 0x54, 0x20,
 	0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
 	0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x04, 0x74, 0x00, 0x30, 0xf2, 0x70,
-	0x5a, 0x80, 0xb0, 0x58, 0x8a, 0x00, 0x40, 0x84, 0x63, 0x00, 0x00, 0x1e,
+	0x5a, 0x80, 0xb0, 0x58, 0x8a, 0x00, 0xc0, 0x1c, 0x32, 0x00, 0x00, 0x1e,
 	0x00, 0x00, 0x00, 0xfc, 0x00, 0x54, 0x65, 0x73, 0x74, 0x20, 0x45, 0x44,
 	0x49, 0x44, 0x0a, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0xfd, 0x00, 0x18,
 	0x55, 0x18, 0x5e, 0x22, 0x00, 0x0a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
 	0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xce, 0x02, 0x03, 0x27, 0x31,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xe6, 0x02, 0x03, 0x28, 0xb1,
 	0x41, 0x5f, 0x6c, 0x03, 0x0c, 0x00, 0x10, 0x00, 0x78, 0x44, 0x20, 0x00,
-	0x00, 0x01, 0x03, 0x6d, 0xd8, 0x5d, 0xc4, 0x01, 0x44, 0x80, 0x07, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0xe3, 0x0f, 0x01, 0x00, 0xe1, 0x0e, 0x00,
+	0x00, 0x01, 0x03, 0x6d, 0xd8, 0x5d, 0xc4, 0x01, 0x00, 0x80, 0x07, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0xe2, 0x00, 0xca, 0xe3, 0x0f, 0x01, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -1003,7 +1022,7 @@ const unsigned char test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz[] = {
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x84
+	0x00, 0x00, 0x00, 0x8a,
 };
 EXPORT_SYMBOL(test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz);
 

-- 
2.55.0

