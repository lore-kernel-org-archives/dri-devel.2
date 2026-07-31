Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A448C55175
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A86B910F329;
	Fri, 31 Jul 2026 16:21:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="SpA7qPM+";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C426910F315
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785514795;
 bh=9crytyeEMmKLDIScG8WR6xIWixXj3o7HvkGk8fyfNBE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=SpA7qPM+BxKLn0sW0UMffpxYpC/N9aUVYtIliZ1rklCW2a8nFLSRI4o668ngXzNwd
 4Tn1Ay0acvvsAwx48rtLE7xUEa+VcxZdk99RP/irJHpZAY9vAiZ6P3IUDvrdpJb5K2
 1718JP1WzZf4UY/qULHjay3aQKpRQl00Idv91ZwbCoT4aKFgqF6QPomuj+p8KhbQAY
 AE2YCIyGdZmAVaBxkAhLgU12KJoABSdTRjxOuZCM8m2N/+ih7PbwJOZ/9mYbmEXjJU
 zT3EX2nASs2OaTjsLPUMbV915A+1yshL1ByJsiYrwTZux3wZhMVULZz0o+OdcqKjYE
 sh1wWiBGuYm8A==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 41E2517E099E;
 Fri, 31 Jul 2026 18:19:55 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 31 Jul 2026 19:20:04 +0300
Subject: [PATCH v10 57/69] drm/tests: edid: Fix conformity for 1080p+4K
 YUV420 200MHz EDID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-dw-hdmi-qp-scramb-v10-57-294364b2cf15@collabora.com>
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

The test EDID added by commit 58fe1d78605e ("drm/tests: hdmi: Provide
EDID supporting 4K@30Hz with YUV420 only") fails 'edid-decode --check'
(v1.33.0) with the following issues:

  Warnings:

  Block 1, CTA-861 Extension Block:
    IT Video Formats are overscanned by default, but normally this should be underscanned.
    YCbCr 4:2:0 Video Data Block: Some YCbCr 4:2:0 timings are invalid for HDMI 2.1
      (which requires an RGB timings pixel rate >= 590 MHz).
  EDID:
    Base EDID: Some timings are out of range of the Monitor Ranges:
      Maximum Clock: 297.000 MHz (Monitor: 170.000 MHz)
    CTA-861: Multiple native progressive timings are defined.

  Failures:

  Block 0, Base EDID:
    Vendor & Product Identification: EDID 1.3 does not support week 0xff.
  Block 1, CTA-861 Extension Block:
    Vendor-Specific Data Block (HDMI Forum), OUI C4-5D-D8: Max TMDS rate is > 0 and <= 340 or > 600.
    YCbCr 4:2:0 Capability Map Data Block: Empty Capability Map.
    YCbCr 4:2:0 Video Data Block: YCbCr 4:2:0-only VIC 95 is also a regular VIC.
    Missing VCDB, needed for Set Selectable RGB Quantization to avoid interop issues.
  EDID:
    CTA-861: The maximum HDMI TMDS clock is 200000 kHz, but one or more video timings go up to 297000 kHz.

Address them while preserving the advertised maximum resolutions, BPC
and TMDS clock used by the existing KUnit tests:

- Week 0xff is not valid for EDID 1.3; set it to 0x00 so that the Model
  year field becomes a regular Year of Manufacture.
- The HDMI Forum VSDB Max TMDS Character Rate must be 0 when no rate
  above 340 MHz is supported.  The HDMI VSDB still advertises 200 MHz as
  Max TMDS Clock.
- VIC 95 (3840x2160@30Hz) was reported as YUV420-only but was listed in
  both the regular Video Data Block and the YCbCr 4:2:0 Video Data
  Block.  Drop it from the regular VDB (so it stays advertised in the
  4:2:0 VDB only) and remove the now unnecessary empty YCbCr 4:2:0
  Capability Map Data Block.
- Add a Video Capability Data Block advertising selectable RGB and YCC
  quantization range plus underscan for IT/CE formats; also set the 'IT
  Video Formats Underscanned' bit in the CTA-861 extension header to
  match.
- Bump the Display Range Limits max pixel clock from 170 MHz to 300 MHz
  so it covers the 297 MHz pixel rate of VIC 95.
- Drop the 'native' flag from VIC 16 in the Video Data Block so it is no
  longer flagged as a second native progressive timing alongside the
  preferred DTD.

The only remaining warning is HDMI 2.1 related and can be ignored, as it
requires that any mode listed in the YCbCr 4:2:0 Video Data Block must
have a corresponding RGB pixel clock >= 590 MHz.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_kunit_edid.c | 65 +++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_kunit_edid.c b/drivers/gpu/drm/tests/drm_kunit_edid.c
index 673a0ea8c2ae..4dff28fff796 100644
--- a/drivers/gpu/drm/tests/drm_kunit_edid.c
+++ b/drivers/gpu/drm/tests/drm_kunit_edid.c
@@ -766,22 +766,22 @@ EXPORT_SYMBOL(test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz);
  * edid-decode (hex):
  *
  * 00 ff ff ff ff ff ff 00 31 d8 34 00 00 00 00 00
- * ff 23 01 03 80 60 36 78 0f ee 91 a3 54 4c 99 26
+ * 00 23 01 03 80 60 36 78 0f ee 91 a3 54 4c 99 26
  * 0f 50 54 20 00 00 01 01 01 01 01 01 01 01 01 01
  * 01 01 01 01 01 01 02 3a 80 18 71 38 2d 40 58 2c
  * 45 00 c0 1c 32 00 00 1e 00 00 00 fc 00 54 65 73
  * 74 20 45 44 49 44 0a 20 20 20 00 00 00 fd 00 18
- * 55 18 5e 11 00 0a 20 20 20 20 20 20 00 00 00 10
- * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 bb
+ * 55 18 5e 1e 00 0a 20 20 20 20 20 20 00 00 00 10
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 ad
  *
- * 02 03 29 31 42 90 5f 6c 03 0c 00 10 00 78 28 20
- * 00 00 01 03 6d d8 5d c4 01 28 80 07 00 00 00 00
- * 00 00 e3 0f 00 00 e2 0e 5f 00 00 00 00 00 00 00
+ * 02 03 27 b1 41 10 6c 03 0c 00 10 00 78 28 20 00
+ * 00 01 03 6d d8 5d c4 01 00 80 07 00 00 00 00 00
+ * 00 e2 00 ca e2 0e 5f 00 00 00 00 00 00 00 00 00
  * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
- * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ca
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 9a
  *
  * ----------------
  *
@@ -790,7 +790,7 @@ EXPORT_SYMBOL(test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz);
  *   Vendor & Product Identification:
  *     Manufacturer: LNX
  *     Model: 52
- *     Model year: 2025
+ *     Made in: 2025
  *   Basic Display Parameters & Features:
  *     Digital display
  *     Maximum image size: 96 cm x 54 cm
@@ -813,21 +813,21 @@ EXPORT_SYMBOL(test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz);
  *                  Vfront    4 Vsync   5 Vback   36 Vpol P
  *     Display Product Name: 'Test EDID'
  *     Display Range Limits:
- *       Monitor ranges (GTF): 24-85 Hz V, 24-94 kHz H, max dotclock 170 MHz
+ *       Monitor ranges (GTF): 24-85 Hz V, 24-94 kHz H, max dotclock 300 MHz
  *     Dummy Descriptor:
  *   Extension blocks: 1
- * Checksum: 0xbb
+ * Checksum: 0xad
  *
  * ----------------
  *
  * Block 1, CTA-861 Extension Block:
  *   Revision: 3
+ *   Underscans IT Video Formats by default
  *   Supports YCbCr 4:4:4
  *   Supports YCbCr 4:2:2
  *   Native detailed modes: 1
  *   Video Data Block:
- *     VIC  16:  1920x1080   60.000000 Hz  16:9     67.500 kHz    148.500000 MHz (native)
- *     VIC  95:  3840x2160   30.000000 Hz  16:9     67.500 kHz    297.000000 MHz
+ *     VIC  16:  1920x1080   60.000000 Hz  16:9     67.500 kHz    148.500000 MHz
  *   Vendor-Specific Data Block (HDMI), OUI 00-0C-03:
  *     Source physical address: 1.0.0.0
  *     DC_48bit
@@ -838,40 +838,57 @@ EXPORT_SYMBOL(test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz);
  *     Extended HDMI video details:
  *   Vendor-Specific Data Block (HDMI Forum), OUI C4-5D-D8:
  *     Version: 1
- *     Maximum TMDS Character Rate: 200 MHz
  *     SCDC Present
  *     Supports 16-bits/component Deep Color 4:2:0 Pixel Encoding
  *     Supports 12-bits/component Deep Color 4:2:0 Pixel Encoding
  *     Supports 10-bits/component Deep Color 4:2:0 Pixel Encoding
- *   YCbCr 4:2:0 Capability Map Data Block:
- *     Empty Capability Map
+ *     VRRmin: 0 Hz
+ *     VRRmax: 0 Hz
+ *   Video Capability Data Block:
+ *     YCbCr quantization: Selectable (via AVI YQ)
+ *     RGB quantization: Selectable (via AVI Q)
+ *     PT scan behavior: No Data
+ *     IT scan behavior: Always Underscanned
+ *     CE scan behavior: Always Underscanned
  *   YCbCr 4:2:0 Video Data Block:
  *     VIC  95:  3840x2160   30.000000 Hz  16:9     67.500 kHz    297.000000 MHz
- * Checksum: 0xca
+ * Checksum: 0x9a  Unused space in Extension Block: 88 bytes
+ *
+ * ----------------
+ *
+ * edid-decode 1.33.0
+ *
+ * Warnings:
+ *
+ * Block 1, CTA-861 Extension Block:
+ *   YCbCr 4:2:0 Video Data Block: Some YCbCr 4:2:0 timings are invalid for HDMI 2.1
+ *     (which requires an RGB timings pixel rate >= 590 MHz).
+ *
+ * EDID conformity: PASS
  */
 const unsigned char test_edid_hdmi_1080p_rgb_yuv_4k_yuv420_dc_max_200mhz[] = {
 	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x31, 0xd8, 0x34, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0xff, 0x23, 0x01, 0x03, 0x80, 0x60, 0x36, 0x78,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x23, 0x01, 0x03, 0x80, 0x60, 0x36, 0x78,
 	0x0f, 0xee, 0x91, 0xa3, 0x54, 0x4c, 0x99, 0x26, 0x0f, 0x50, 0x54, 0x20,
 	0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
 	0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x02, 0x3a, 0x80, 0x18, 0x71, 0x38,
 	0x2d, 0x40, 0x58, 0x2c, 0x45, 0x00, 0xc0, 0x1c, 0x32, 0x00, 0x00, 0x1e,
 	0x00, 0x00, 0x00, 0xfc, 0x00, 0x54, 0x65, 0x73, 0x74, 0x20, 0x45, 0x44,
 	0x49, 0x44, 0x0a, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0xfd, 0x00, 0x18,
-	0x55, 0x18, 0x5e, 0x11, 0x00, 0x0a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+	0x55, 0x18, 0x5e, 0x1e, 0x00, 0x0a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
 	0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xbb, 0x02, 0x03, 0x29, 0x31,
-	0x42, 0x90, 0x5f, 0x6c, 0x03, 0x0c, 0x00, 0x10, 0x00, 0x78, 0x28, 0x20,
-	0x00, 0x00, 0x01, 0x03, 0x6d, 0xd8, 0x5d, 0xc4, 0x01, 0x28, 0x80, 0x07,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xe3, 0x0f, 0x00, 0x00, 0xe2, 0x0e,
-	0x5f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xad, 0x02, 0x03, 0x27, 0xb1,
+	0x41, 0x10, 0x6c, 0x03, 0x0c, 0x00, 0x10, 0x00, 0x78, 0x28, 0x20, 0x00,
+	0x00, 0x01, 0x03, 0x6d, 0xd8, 0x5d, 0xc4, 0x01, 0x00, 0x80, 0x07, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0xe2, 0x00, 0xca, 0xe2, 0x0e, 0x5f, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0xca
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x9a,
 };
 EXPORT_SYMBOL(test_edid_hdmi_1080p_rgb_yuv_4k_yuv420_dc_max_200mhz);
 

-- 
2.55.0

