Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF0E606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Ml5LoWjh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D57B510F0AD;
	Sat, 14 Nov 2026 18:05:22 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C90F310E7B5
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794679468;
 bh=j3e7EFN41vJ1dD4gJizeAlRY2frMxmYDW42o64nfSsY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Ml5LoWjhEI3m4VdTyDXdm6zAYjGwaKl0bGy377UoHx3zCO6nTcvw9kUFvlFI+qvyZ
 rvz+yUqqe4Y14BGa+sCJ/o96RIvi1cgBklI1qGI7/eJysSGjjxH+3ii7QtzVyx/xM0
 H+ZyLZxDSFXOSonLSc1YDVOAihxg5p+EoZ1iVQENPPTBQPIpG/aLINQ1rqazLmpgzS
 IYohfUQAnjsyjO70N9KSVNPqq+A4rteGNfNP+8cWaUSHfNztR6XqK3vWfEnnYUKTv0
 H+Avr/GX7UX4bH0BTzjDV5XomNt7Oqp4FwC8ilmqc60ShuF8oJ0V2Ic0fzZ28sj2ct
 XXOAh1d3yaAlQ==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7C72417E0F3F;
 Sat, 14 Nov 2026 19:04:28 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:39 +0200
Subject: [PATCH 15/25] drm/tests: edid: Add 4K@60Hz EDID with 600MHz TMDS
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-15-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
To: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>, 
 Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a new test EDID advertising the following capabilities:

Max resolution: 3840x2160@60Hz with RGB, YUV444, YUV422, YUV420
Max BPC:        16
Max TMDS clock: 600 MHz

This is needed to exercise the new HDMI infrastructure that decides
whether scrambling needs to be enabled for a given display mode and
to validate that high-rate modes are properly rejected/accepted
depending on the source/sink scrambling capability.

The EDID is derived from test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz
with the following changes:

- Upgraded the first DTD from 3840x2160@30 (297 MHz) to 3840x2160@60
  (594 MHz).  The H/V totals (4400x2250) and porches already match the
  HDMI 2.0 4K@60Hz standard timing, so only the pixel clock had to be
  bumped.
- Widened Display Range Limits descriptor to cover the new timing, i.e.
  24-140 kHz H, max dotclock 600 MHz.
- Updated CTA-861 Video Data Block to advertise VIC 97 (4K@60Hz) instead
  of VIC 95 (4k30).
- Bumped HF-VSDB Max TMDS Character Rate to 600 MHz, keeping
  SCDC_Present set so that the sink advertises scrambling support.
- Cleared HDMI VSDB Max TMDS clock byte, as required by HDMI 2.0 when
  the HF-VSDB declares a Max TMDS Character Rate above 340 MHz.
- Provided a Video Capability Data Block advertising selectable RGB and
  YCC quantization range plus underscan for IT/CE formats; also set the
  'IT Video Formats Underscanned' bit in the CTA-861 extension header to
  match.
- Aligned base block image size with the DTD (160x90 cm) and set the
  Week of Manufacture to 0x00 instead of 0xff, since the Model Year
  flag is not supported by EDID 1.3, so that the Model year field
  becomes a regular Year of Manufacture.  Both fix inherited EDID
  conformity failures.
- Dropped the empty YCbCr 4:2:0 Video Data Block inherited from the
  parent EDID, which is flagged as a failure by edid-decode v1.33.0

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_kunit_edid.c | 129 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tests/drm_kunit_edid.h |   1 +
 2 files changed, 130 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_kunit_edid.c b/drivers/gpu/drm/tests/drm_kunit_edid.c
index c41ddfc0e32a..a6c5e8d6077a 100644
--- a/drivers/gpu/drm/tests/drm_kunit_edid.c
+++ b/drivers/gpu/drm/tests/drm_kunit_edid.c
@@ -1026,6 +1026,135 @@ const unsigned char test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz[] = {
 };
 EXPORT_SYMBOL(test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz);
 
+/*
+ * Max resolution: 3840x2160@60Hz with RGB, YUV444, YUV422, YUV420
+ * Max BPC:        16 for all modes
+ * Max TMDS clock: 600 MHz
+ *
+ * edid-decode (hex):
+ *
+ * 00 ff ff ff ff ff ff 00 31 d8 34 00 00 00 00 00
+ * 00 23 01 03 80 a0 5a 78 0f ee 91 a3 54 4c 99 26
+ * 0f 50 54 20 00 00 01 01 01 01 01 01 01 01 01 01
+ * 01 01 01 01 01 01 08 e8 00 30 f2 70 5a 80 b0 58
+ * 8a 00 40 84 63 00 00 1e 00 00 00 fc 00 54 65 73
+ * 74 20 45 44 49 44 0a 20 20 20 00 00 00 fd 00 18
+ * 55 18 8c 3c 00 0a 20 20 20 20 20 20 00 00 00 10
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 a9
+ *
+ * 02 03 28 b1 41 61 6c 03 0c 00 10 00 78 00 20 00
+ * 00 01 03 6d d8 5d c4 01 78 80 07 00 00 00 00 00
+ * 00 e2 00 ca e3 0f 01 00 00 00 00 00 00 00 00 00
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 54
+ *
+ * ----------------
+ *
+ * Block 0, Base EDID:
+ *   EDID Structure Version & Revision: 1.3
+ *   Vendor & Product Identification:
+ *     Manufacturer: LNX
+ *     Model: 52
+ *     Made in: 2025
+ *   Basic Display Parameters & Features:
+ *     Digital display
+ *     Maximum image size: 160 cm x 90 cm
+ *     Gamma: 2.20
+ *     RGB color display
+ *     Default (sRGB) color space is primary color space
+ *     First detailed timing is the preferred timing
+ *     Supports GTF timings within operating range
+ *   Color Characteristics:
+ *     Red  : 0.6396, 0.3300
+ *     Green: 0.2998, 0.5996
+ *     Blue : 0.1503, 0.0595
+ *     White: 0.3125, 0.3291
+ *   Established Timings I & II:
+ *     DMT 0x04:   640x480    59.940476 Hz   4:3     31.469 kHz     25.175000 MHz
+ *   Standard Timings: none
+ *   Detailed Timing Descriptors:
+ *     DTD 1:  3840x2160   60.000000 Hz  16:9    135.000 kHz    594.000000 MHz (1600 mm x 900 mm)
+ *                  Hfront  176 Hsync  88 Hback  296 Hpol P
+ *                  Vfront    8 Vsync  10 Vback   72 Vpol P
+ *     Display Product Name: 'Test EDID'
+ *     Display Range Limits:
+ *       Monitor ranges (GTF): 24-85 Hz V, 24-140 kHz H, max dotclock 600 MHz
+ *     Dummy Descriptor:
+ *   Extension blocks: 1
+ * Checksum: 0xa9
+ *
+ * ----------------
+ *
+ * Block 1, CTA-861 Extension Block:
+ *   Revision: 3
+ *   Underscans IT Video Formats by default
+ *   Supports YCbCr 4:4:4
+ *   Supports YCbCr 4:2:2
+ *   Native detailed modes: 1
+ *   Video Data Block:
+ *     VIC  97:  3840x2160   60.000000 Hz  16:9    135.000 kHz    594.000000 MHz
+ *   Vendor-Specific Data Block (HDMI), OUI 00-0C-03:
+ *     Source physical address: 1.0.0.0
+ *     DC_48bit
+ *     DC_36bit
+ *     DC_30bit
+ *     DC_Y444
+ *     Maximum TMDS clock: 0 MHz
+ *     Extended HDMI video details:
+ *   Vendor-Specific Data Block (HDMI Forum), OUI C4-5D-D8:
+ *     Version: 1
+ *     Maximum TMDS Character Rate: 600 MHz
+ *     SCDC Present
+ *     Supports 16-bits/component Deep Color 4:2:0 Pixel Encoding
+ *     Supports 12-bits/component Deep Color 4:2:0 Pixel Encoding
+ *     Supports 10-bits/component Deep Color 4:2:0 Pixel Encoding
+ *     VRRmin: 0 Hz
+ *     VRRmax: 0 Hz
+ *   Video Capability Data Block:
+ *     YCbCr quantization: Selectable (via AVI YQ)
+ *     RGB quantization: Selectable (via AVI Q)
+ *     PT scan behavior: No Data
+ *     IT scan behavior: Always Underscanned
+ *     CE scan behavior: Always Underscanned
+ *   YCbCr 4:2:0 Capability Map Data Block:
+ *     VIC  97:  3840x2160   60.000000 Hz  16:9    135.000 kHz    594.000000 MHz
+ * Checksum: 0x54  Unused space in Extension Block: 87 bytes
+ *
+ * ----------------
+ *
+ * edid-decode 1.33.0
+ *
+ * EDID conformity: PASS
+ */
+const unsigned char test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz[] = {
+	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x31, 0xd8, 0x34, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x23, 0x01, 0x03, 0x80, 0xa0, 0x5a, 0x78,
+	0x0f, 0xee, 0x91, 0xa3, 0x54, 0x4c, 0x99, 0x26, 0x0f, 0x50, 0x54, 0x20,
+	0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
+	0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x08, 0xe8, 0x00, 0x30, 0xf2, 0x70,
+	0x5a, 0x80, 0xb0, 0x58, 0x8a, 0x00, 0x40, 0x84, 0x63, 0x00, 0x00, 0x1e,
+	0x00, 0x00, 0x00, 0xfc, 0x00, 0x54, 0x65, 0x73, 0x74, 0x20, 0x45, 0x44,
+	0x49, 0x44, 0x0a, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0xfd, 0x00, 0x18,
+	0x55, 0x18, 0x8c, 0x3c, 0x00, 0x0a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+	0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xa9, 0x02, 0x03, 0x28, 0xb1,
+	0x41, 0x61, 0x6c, 0x03, 0x0c, 0x00, 0x10, 0x00, 0x78, 0x00, 0x20, 0x00,
+	0x00, 0x01, 0x03, 0x6d, 0xd8, 0x5d, 0xc4, 0x01, 0x78, 0x80, 0x07, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0xe2, 0x00, 0xca, 0xe3, 0x0f, 0x01, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x54,
+};
+EXPORT_SYMBOL(test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
+
 MODULE_AUTHOR("Maxime Ripard <mripard@kernel.org>");
 MODULE_DESCRIPTION("EDID Definitions for KUnit tests");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tests/drm_kunit_edid.h b/drivers/gpu/drm/tests/drm_kunit_edid.h
index 28b4df93a555..fb5b0295e35e 100644
--- a/drivers/gpu/drm/tests/drm_kunit_edid.h
+++ b/drivers/gpu/drm/tests/drm_kunit_edid.h
@@ -12,5 +12,6 @@ extern const unsigned char test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz[256];
 extern const unsigned char test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz[256];
 extern const unsigned char test_edid_hdmi_1080p_rgb_yuv_4k_yuv420_dc_max_200mhz[256];
 extern const unsigned char test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz[256];
+extern const unsigned char test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz[256];
 
 #endif // DRM_KUNIT_EDID_H_

-- 
2.56.0

