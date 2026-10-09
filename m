Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883AACA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 06:57:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCED810FEDA;
	Fri,  9 Oct 2026 06:57:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="aSG73Zc/";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A47210FEE1
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 06:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1791529056; bh=Iw/ZLCNV53Y0bK2SE3FJKi1UCBzg1qTnswZ6Yw7hiNc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=aSG73Zc/7ZcQ74JjOGuSzrZvUwqJPUPd3E/fW6T2oxYi1RgDb0al8DTHFMiRDS1Wg2Jue3Q4ERU/Ocaurf1Ke21MBddOcvAUtqJKV62CXszVbR/Gb8GHXSEYr9fF6g3g3ykBX712ky7HoBWFBOx/2tCdyw5aayUGCt9WDPtzYHy4GZD8cjxvDIfbDYU7j/BQQ5hBkOhN4E1HgN88Vz8qFyukb+zffu/CMRUxsbe+x8AT/OaNrmBWJflA3bpDODalueQESSovzVHwz1ZpMPQK7M5634jX8dqf5Y0JcHel+Oidyh7fz5ScbCQ1p7Rwsn7XwwD3nSqFcd8Y4dt6ldkcUA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1791529056; bh=LysxEuhHDaiT1NCtYsZ6IuZrgF5QkyKqrPMaTcjPqiT=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=JQLG8y0CdG7Oo/89J+3Nb6yZ1fqfcJBlc2pTiB1WZNB82xwHogQ+EoCAyMpf4ozS5aURIguwh1FaW7807DiThYn1kstJaB0/TSoqSghcZnizlKxFJd46DMueJaZCEmKUCiRcth2b8mJO8+3vEQ4yA4y7wyaEtpMuUO2Hkc+XEZhBbcrT/vx+x80Zh1IwPPFZHFpRo8WU05wTFfzHKsYEOJ+LwNwVLCK97ExLUuX2Zfl//cA0kgTYrH0Xfa6yp57ussygLdfj0V7zq5z4YIDqEKxB0ujv9ZmHnKZgT9L0eyvuCleQx1oAV/6BkiUxgiOVR/5J8vXs8xmGzouUYb+qyw==
X-YMail-OSG: I1QNoUEVM1nP0mP9nAemyQvQSJFbB6BrKVohJxTYekKlqu0WOCuJ3jouZuSNEQx
 IFSyjgaZ_JXJ5DOmmUxv1VSnpHAX5NPoDInMlCIpBfguL7N9_TXRENezg_7AG9xxQmO_aEL9ArAR
 smjvA79vmzyN4fX4GXLLs0e_wcLW0h.cu4npkv08YSL8jaUddWzcD_tk2exdxvMHIUW_GJI23gri
 W__nyfKd6b7L1U5CuCr6If7ECv0EiWOWLpP9uamtHL8jcZ8zj56NNN7OOylqNLqw1Q4Vrt.yMBmD
 a8._5t5zhvm.dgvEZ9UJcOIZaBCvcZQ2Eplnb67R7V2.GmoA6pwvxrEJIhqfg6OqaTzNuwghy_v8
 VmQaVSHy3Vg0ooqvSL1J01Z1xJygoXtYOxCqMZDNnttWflLJ5QZlgp_LKmx1L6RtpJSxp2UD7jgi
 oucBjL9StWBoa_DR7TqeCD8.DprWkkiTSi4.krf0KdeXewgehcdWabnRjunaFo0A6INHg4IzSkUM
 Zc7YUyLCqzAfrVEeTCSn7P62PlLOHoagyRMqf4Ucjqh3.kdnCHUfxCy_6CvqU07nSJHg7uf.1Y9A
 qqYkobtRwoRJIJFeI0qxh5Z3fbfbDN4WmNJGiNb1_TPgiI1o8.GYfcfsyRW1vcfd0yn1ngC7Hu1e
 inecKKPLNFl7f1.rS1oNoC.x5_3LuWw8bYTYc.7VwV8Z_TXAakP74Q1PZcxvbyy8q3Pk3RyK3WHN
 by2fTU.EIq8gVucPTZsrjDRUUyhsVdjO4mjvjokea2qS1SUZz5lbCceEOtJckZ8mzjIgXbBtNtek
 GuyG7ZEQ1S1dHdEWzmxR9keZtKTdTwCVXU4qwuKSrZV5yE2hcBtI_d86njeV4rDxIJ8FvAXWwKvU
 K4DvNrCFjqmtQT6JcmKdSIeo43btnMN6bR63IIs_gRJKGEgM9qGPspuylgojzvx0OqHrPQsiaLSv
 v_DOTBSmiy8j2h7AcbwbLdnmlcRt608.gafszgI..pEFLJK4McEscznx4x8ktTWjyrnBTuSdd38I
 9Nrk7YxbA1Xymm8_8WnDHveHWJlgJtO8bHMrBOF7I0hN7vjdafB4JfsooO6O8On8ouTgzl12V0Hd
 8urDbJxwFsY4VyUhQuXqDxOtudL7YbFJoNupYSDiBH8FVN.vwe7I3UzIXG07OTuq3yQRl..gr7KQ
 wFPouiAa92Y0LFghKXumS0vG01PImk.XvouWs70WU0eNWajnvG9SXpiuVJUPkMohx_WZjMNWrFSw
 IhhdYqP0ljuWkMiITzthFwJnMHOdf6rO9CKEK4YG8VgfqXsG8uMKzY18UvhylRO5NObIRrFk2ufC
 ADxVjDmCINwuCajoI1mYvYrPsjDXNqC2K4F5DS_L1Z9sAQtkTEGpw4styqulp.sOHCYB9NS60V_9
 tG7l3krgh91d0n18kitU9TPKKNOxV77lUba3w.sWj8aMAtOojqxfgHCMPtc0yAnNyBcSCzcHEJRV
 4t1Ns.eYqByMgQfq6WW2xTcriSUrZJpHDPCfPnwPiXtzbfAu1d1CX1sKx3rZtdr7fVEl8Aj2_CfH
 iZckE1bVMyTd8XIssMB.WYx.D4TIGeMVLKzKAfc7fNTA9xQ3bCr6w5EU7Oc_44wu8cFe.JKwkCog
 wTQCcTpbJ2CMK5bNTVYdggAKzzd.UmwPRbm2QaE3X2Nzi2uCe14Az4x77cinmswq833DdnBrdDZ9
 65oH.zizhZz8J0ALQc4WjQXWfjzfaYmDzrmnwUA9uuwRUWV3DIMaEvFcbJ3XXzBMHC5UVDTZ1FFK
 kzsXnl3awuYGpm_WGTqwCe1YzNRP17jBUzbHFbJshw.VaRl5GaKGrd85qqXqIQzVBr45ffmU8qYF
 In8IBDBY5JlLTF9ZD90saOeX7j9m5332zdCkt8zxEUe0aHB129acKB4uSI9MsDs3zSkBvKCyV4ms
 gMftsCfYPS9csNHU5bAa1DdJ4Wk54WwXzBu5iQZCDQWLUy0Oxn4hu0Muz1RC8Qs_C9DhIiGbYCjU
 65RzwzG7sslvwgVp2mkGPXYoguluiTUJQ1je2FywkVc5C5ozsW.qY9K0-
X-Sonic-MF: <Capitain_Jack@yahoo.com>
X-Sonic-ID: 0d4c5a8c-1b9e-4e2a-b8e0-aef6d6ea5f45
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-101 with HTTP;
 Fri, 9 Oct 2026 06:57:36 +0000
Received: from dip109.lsn.bf1.yahoo.com ([67.195.177.118])
 by hello (SMTP) with SMTP ID c876e35fe2f2b7cd9ee5c8b0d50dabd2;
 Fri, 09 Oct 2026 06:57:33 +0000 (UTC)
From: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] drm/vkms: Add KUnit tests for stereo modes
Date: Fri, 09 Oct 2026 03:57:29 -0300
Message-ID: <179152904903.1726604.8586921343759594120@yahoo.com>
In-Reply-To: <179152903254.1726604.8785647683993800694@yahoo.com>
References: <179152903254.1726604.8785647683993800694@yahoo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Mailer: WebService/1.1.26668
 mail.core.serving.mcws.prd.acl:role.token.mcws.jsmtp.yahoo
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

Build a device from the default configuration with vkms_output_init(),
its connector reading an EDID that declares 3D in its HDMI
Vendor-Specific Data Block, and check that:

- the connector lists the stereo modes the EDID declares, frame packing,
  top-and-bottom and side by side (half), and no other;
- the writeback connector accepts a buffer of the frame that holds both
  eyes and refuses other sizes, for each of these layouts and for a 2D
  mode.

Export vkms_output_init() for KUnit and select the DRM KUnit helpers.

Assisted-by: LLM
Signed-off-by: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
---
 drivers/gpu/drm/vkms/Kconfig                  |   1 +
 drivers/gpu/drm/vkms/tests/Makefile           |   1 +
 drivers/gpu/drm/vkms/tests/vkms_stereo_test.c | 476 ++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_output.c            |   2 +
 4 files changed, 480 insertions(+)
 create mode 100644 drivers/gpu/drm/vkms/tests/vkms_stereo_test.c

diff --git a/drivers/gpu/drm/vkms/Kconfig b/drivers/gpu/drm/vkms/Kconfig
index 3977bbb99f..d0b7f772cc 100644
--- a/drivers/gpu/drm/vkms/Kconfig
+++ b/drivers/gpu/drm/vkms/Kconfig
@@ -19,6 +19,7 @@ config DRM_VKMS
 config DRM_VKMS_KUNIT_TEST
 	tristate "KUnit tests for VKMS" if !KUNIT_ALL_TESTS
 	depends on DRM_VKMS && KUNIT
+	select DRM_KUNIT_TEST_HELPERS
 	default KUNIT_ALL_TESTS
 	help
 	  This builds unit tests for VKMS. This option is not useful for
diff --git a/drivers/gpu/drm/vkms/tests/Makefile b/drivers/gpu/drm/vkms/tests/Makefile
index 92cfa7262b..cad869aa61 100644
--- a/drivers/gpu/drm/vkms/tests/Makefile
+++ b/drivers/gpu/drm/vkms/tests/Makefile
@@ -5,5 +5,6 @@ vkms-kunit-tests-y := \
 	vkms_format_test.o \
 	vkms_color_test.o \
 	vkms_configfs_test.o \
+	vkms_stereo_test.o \
 
 obj-$(CONFIG_DRM_VKMS_KUNIT_TEST) += vkms-kunit-tests.o
diff --git a/drivers/gpu/drm/vkms/tests/vkms_stereo_test.c b/drivers/gpu/drm/vkms/tests/vkms_stereo_test.c
new file mode 100644
index 0000000000..9229d5ae17
--- /dev/null
+++ b/drivers/gpu/drm/vkms/tests/vkms_stereo_test.c
@@ -0,0 +1,476 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <kunit/test.h>
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_uapi.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_kunit_helpers.h>
+#include <drm/drm_modeset_lock.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_writeback.h>
+
+#include "../vkms_config.h"
+#include "../vkms_connector.h"
+#include "../vkms_drv.h"
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+/*
+ * edid-decode (hex):
+ *
+ * 00 ff ff ff ff ff ff 00 31 d8 3d 00 00 00 00 00
+ * 00 21 01 03 81 a0 5a 78 0a 00 00 00 00 00 00 00
+ * 00 00 00 20 00 00 01 01 01 01 01 01 01 01 01 01
+ * 01 01 01 01 01 01 02 3a 80 18 71 38 2d 40 58 2c
+ * 45 00 40 84 63 00 00 1e 00 00 00 fc 00 53 74 65
+ * 72 65 6f 20 45 44 49 44 0a 20 00 00 00 fd 00 17
+ * 4c 0f 8c 1e 00 0a 20 20 20 20 20 20 00 00 00 10
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 b4
+ *
+ * 02 03 1d 81 46 10 04 20 13 1f 22 6e 03 0c 00 10
+ * 00 00 3c 20 a0 04 01 00 06 50 e2 00 4a 00 00 00
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+ * 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 7f
+ *
+ * ----------------
+ *
+ * Block 0, Base EDID:
+ *   EDID Structure Version & Revision: 1.3
+ *   Vendor & Product Identification:
+ *     Manufacturer: LNX
+ *     Model: 61
+ *     Made in: 2023
+ *   Basic Display Parameters & Features:
+ *     Digital display
+ *     DFP 1.x compatible TMDS
+ *     Maximum image size: 160 cm x 90 cm
+ *     Gamma: 2.20
+ *     RGB color display
+ *     First detailed timing is the preferred timing
+ *   Color Characteristics:
+ *     Red  : 0.0000, 0.0000
+ *     Green: 0.0000, 0.0000
+ *     Blue : 0.0000, 0.0000
+ *     White: 0.0000, 0.0000
+ *   Established Timings I & II:
+ *     DMT 0x04:   640x480    59.940476 Hz   4:3     31.469 kHz     25.175000 MHz
+ *   Standard Timings: none
+ *   Detailed Timing Descriptors:
+ *     DTD 1:  1920x1080   60.000000 Hz  16:9     67.500 kHz    148.500000 MHz (1600 mm x 900 mm)
+ *                  Hfront   88 Hsync  44 Hback  148 Hpol P
+ *                  Vfront    4 Vsync   5 Vback   36 Vpol P
+ *     Display Product Name: 'Stereo EDID'
+ *     Display Range Limits:
+ *       Monitor ranges (GTF): 23-76 Hz V, 15-140 kHz H, max dotclock 300 MHz
+ *     Dummy Descriptor:
+ *   Extension blocks: 1
+ * Checksum: 0xb4
+ *
+ * ----------------
+ *
+ * Block 1, CTA-861 Extension Block:
+ *   Revision: 3
+ *   Underscans IT Video Formats by default
+ *   Native detailed modes: 1
+ *   Video Data Block:
+ *     VIC  16:  1920x1080   60.000000 Hz  16:9     67.500 kHz    148.500000 MHz
+ *     VIC   4:  1280x720    60.000000 Hz  16:9     45.000 kHz     74.250000 MHz
+ *     VIC  32:  1920x1080   24.000000 Hz  16:9     27.000 kHz     74.250000 MHz
+ *     VIC  19:  1280x720    50.000000 Hz  16:9     37.500 kHz     74.250000 MHz
+ *     VIC  31:  1920x1080   50.000000 Hz  16:9     56.250 kHz    148.500000 MHz
+ *     VIC  34:  1920x1080   30.000000 Hz  16:9     33.750 kHz     74.250000 MHz
+ *   Vendor-Specific Data Block (HDMI), OUI 00-0C-03:
+ *     Source physical address: 1.0.0.0
+ *     Maximum TMDS clock: 300 MHz
+ *     Extended HDMI video details:
+ *       3D present
+ *       All advertised VICs are 3D-capable
+ *       3D: Side-by-side (half, horizontal)
+ *       3D VIC indices with specific capabilities:
+ *         VIC  16:  1920x1080   60.000000 Hz  16:9     67.500 kHz    148.500000 MHz (top-and-bottom)
+ *         VIC  34:  1920x1080   30.000000 Hz  16:9     33.750 kHz     74.250000 MHz (frame packing)
+ *   Video Capability Data Block:
+ *     YCbCr quantization: No Data
+ *     RGB quantization: Selectable (via AVI Q)
+ *     PT scan behavior: No Data
+ *     IT scan behavior: Always Underscanned
+ *     CE scan behavior: Always Underscanned
+ * Checksum: 0x7f
+ */
+static const u8 test_edid_hdmi_3d[] = {
+	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x31, 0xd8, 0x3d, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x21, 0x01, 0x03, 0x81, 0xa0, 0x5a, 0x78,
+	0x0a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20,
+	0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
+	0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x02, 0x3a, 0x80, 0x18, 0x71, 0x38,
+	0x2d, 0x40, 0x58, 0x2c, 0x45, 0x00, 0x40, 0x84, 0x63, 0x00, 0x00, 0x1e,
+	0x00, 0x00, 0x00, 0xfc, 0x00, 0x53, 0x74, 0x65, 0x72, 0x65, 0x6f, 0x20,
+	0x45, 0x44, 0x49, 0x44, 0x0a, 0x20, 0x00, 0x00, 0x00, 0xfd, 0x00, 0x17,
+	0x4c, 0x0f, 0x8c, 0x1e, 0x00, 0x0a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+	0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xb4, 0x02, 0x03, 0x1d, 0x81,
+	0x46, 0x10, 0x04, 0x20, 0x13, 0x1f, 0x22, 0x6e, 0x03, 0x0c, 0x00, 0x10,
+	0x00, 0x00, 0x3c, 0x20, 0xa0, 0x04, 0x01, 0x00, 0x06, 0x50, 0xe2, 0x00,
+	0x4a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x7f,
+};
+
+struct vkms_stereo_test_priv {
+	struct vkms_device *vkmsdev;
+	struct drm_connector *connector;
+	struct drm_writeback_connector *wb_connector;
+	struct drm_crtc *crtc;
+	struct drm_plane *primary;
+};
+
+struct vkms_stereo_test_mode {
+	int hdisplay;
+	int vdisplay;
+	int vrefresh;
+	u32 layout;
+};
+
+/* The stereo modes the EDID above declares, without the interlaced ones */
+static const struct vkms_stereo_test_mode test_edid_stereo_modes[] = {
+	/* 3D_present: the mandatory formats of the 2D formats listed */
+	{ 1920, 1080, 24, DRM_MODE_FLAG_3D_FRAME_PACKING },
+	{ 1920, 1080, 24, DRM_MODE_FLAG_3D_TOP_AND_BOTTOM },
+	{ 1280, 720, 60, DRM_MODE_FLAG_3D_FRAME_PACKING },
+	{ 1280, 720, 60, DRM_MODE_FLAG_3D_TOP_AND_BOTTOM },
+	{ 1280, 720, 50, DRM_MODE_FLAG_3D_FRAME_PACKING },
+	{ 1280, 720, 50, DRM_MODE_FLAG_3D_TOP_AND_BOTTOM },
+	/* 3D_Structure_ALL: side by side (half) for every VIC */
+	{ 1920, 1080, 60, DRM_MODE_FLAG_3D_SIDE_BY_SIDE_HALF },
+	{ 1280, 720, 60, DRM_MODE_FLAG_3D_SIDE_BY_SIDE_HALF },
+	{ 1920, 1080, 24, DRM_MODE_FLAG_3D_SIDE_BY_SIDE_HALF },
+	{ 1280, 720, 50, DRM_MODE_FLAG_3D_SIDE_BY_SIDE_HALF },
+	{ 1920, 1080, 50, DRM_MODE_FLAG_3D_SIDE_BY_SIDE_HALF },
+	{ 1920, 1080, 30, DRM_MODE_FLAG_3D_SIDE_BY_SIDE_HALF },
+	/* 3D_Structure_X */
+	{ 1920, 1080, 60, DRM_MODE_FLAG_3D_TOP_AND_BOTTOM },
+	{ 1920, 1080, 30, DRM_MODE_FLAG_3D_FRAME_PACKING },
+};
+
+static void vkms_stereo_test_config_destroy(void *config)
+{
+	vkms_config_destroy(config);
+}
+
+static void vkms_stereo_test_fb_destroy(struct drm_framebuffer *fb)
+{
+	drm_framebuffer_cleanup(fb);
+}
+
+static const struct drm_framebuffer_funcs vkms_stereo_test_fb_funcs = {
+	.destroy = vkms_stereo_test_fb_destroy,
+};
+
+static void vkms_stereo_test_fb_put(void *fb)
+{
+	drm_framebuffer_put(fb);
+}
+
+static struct drm_framebuffer *vkms_stereo_test_create_fb(struct kunit *test,
+							  int width, int height)
+{
+	struct vkms_stereo_test_priv *priv = test->priv;
+	struct drm_framebuffer *fb;
+	int ret;
+
+	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fb);
+
+	fb->dev = &priv->vkmsdev->drm;
+	fb->format = drm_format_info(DRM_FORMAT_XRGB8888);
+	fb->width = width;
+	fb->height = height;
+	fb->pitches[0] = width * 4;
+
+	ret = drm_framebuffer_init(fb->dev, fb, &vkms_stereo_test_fb_funcs);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = kunit_add_action_or_reset(test, vkms_stereo_test_fb_put, fb);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	return fb;
+}
+
+static int vkms_stereo_test_init(struct kunit *test)
+{
+	struct vkms_stereo_test_priv *priv;
+	struct vkms_config_connector *connector_cfg;
+	struct vkms_config_plane *plane_cfg;
+	struct vkms_config_crtc *crtc_cfg;
+	struct vkms_config *config;
+	struct device *dev;
+	int ret;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+	test->priv = priv;
+
+	config = vkms_config_default_create(false, true, false, false);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+	ret = kunit_add_action_or_reset(test, vkms_stereo_test_config_destroy, config);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	vkms_config_for_each_connector(config, connector_cfg) {
+		vkms_config_connector_set_edid_enabled(connector_cfg, true);
+		vkms_config_connector_set_edid(connector_cfg, test_edid_hdmi_3d,
+					       sizeof(test_edid_hdmi_3d));
+	}
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	priv->vkmsdev = drm_kunit_helper_alloc_drm_device(test, dev, struct vkms_device, drm,
+							  DRIVER_MODESET | DRIVER_ATOMIC);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->vkmsdev);
+
+	priv->vkmsdev->config = config;
+	config->dev = priv->vkmsdev;
+
+	ret = vkms_output_init(priv->vkmsdev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	vkms_config_for_each_crtc(config, crtc_cfg) {
+		priv->crtc = &crtc_cfg->crtc->crtc;
+		priv->wb_connector = &crtc_cfg->crtc->wb_connector;
+		plane_cfg = vkms_config_crtc_primary_plane(config, crtc_cfg);
+		priv->primary = &plane_cfg->plane->base;
+	}
+
+	vkms_config_for_each_connector(config, connector_cfg)
+		priv->connector = &connector_cfg->connector->base;
+
+	return 0;
+}
+
+static void vkms_stereo_test_probe(struct kunit *test)
+{
+	struct vkms_stereo_test_priv *priv = test->priv;
+	struct drm_device *drm = &priv->vkmsdev->drm;
+	int count;
+
+	mutex_lock(&drm->mode_config.mutex);
+	count = drm_helper_probe_single_connector_modes(priv->connector, XRES_MAX, YRES_MAX);
+	mutex_unlock(&drm->mode_config.mutex);
+
+	KUNIT_ASSERT_GT(test, count, 0);
+}
+
+static bool vkms_stereo_test_mode_matches(const struct drm_display_mode *mode,
+					  const struct vkms_stereo_test_mode *expected)
+{
+	return mode->hdisplay == expected->hdisplay &&
+	       mode->vdisplay == expected->vdisplay &&
+	       drm_mode_vrefresh(mode) == expected->vrefresh &&
+	       (mode->flags & DRM_MODE_FLAG_3D_MASK) == expected->layout;
+}
+
+static const struct drm_display_mode *
+vkms_stereo_test_find_mode(struct kunit *test, const struct vkms_stereo_test_mode *expected)
+{
+	struct vkms_stereo_test_priv *priv = test->priv;
+	const struct drm_display_mode *mode;
+
+	list_for_each_entry(mode, &priv->connector->modes, head) {
+		if (vkms_stereo_test_mode_matches(mode, expected))
+			return mode;
+	}
+
+	return NULL;
+}
+
+/*
+ * The connector lists the stereo modes of its EDID next to the 2D ones, and
+ * no other stereo mode. Formats at 24, 30 and 60 Hz are listed twice, at
+ * the integer rate and at 1000/1001 of it, both covered by one entry.
+ */
+static void vkms_stereo_test_edid_modes(struct kunit *test)
+{
+	static const struct vkms_stereo_test_mode mode_2d = { 1920, 1080, 60, 0 };
+	struct vkms_stereo_test_priv *priv = test->priv;
+	const struct drm_display_mode *mode;
+	int i;
+
+	vkms_stereo_test_probe(test);
+
+	for (i = 0; i < ARRAY_SIZE(test_edid_stereo_modes); i++) {
+		const struct vkms_stereo_test_mode *expected = &test_edid_stereo_modes[i];
+
+		KUNIT_EXPECT_NOT_NULL_MSG(test, vkms_stereo_test_find_mode(test, expected),
+					  "%dx%d@%d layout %u not listed",
+					  expected->hdisplay, expected->vdisplay,
+					  expected->vrefresh, expected->layout >> 14);
+	}
+
+	list_for_each_entry(mode, &priv->connector->modes, head) {
+		bool expected = false;
+
+		if (!(mode->flags & DRM_MODE_FLAG_3D_MASK))
+			continue;
+
+		for (i = 0; i < ARRAY_SIZE(test_edid_stereo_modes); i++)
+			expected |= vkms_stereo_test_mode_matches(mode, &test_edid_stereo_modes[i]);
+
+		KUNIT_EXPECT_TRUE_MSG(test, expected, "unexpected " DRM_MODE_FMT,
+				      DRM_MODE_ARG(mode));
+	}
+
+	KUNIT_EXPECT_NOT_NULL(test, vkms_stereo_test_find_mode(test, &mode_2d));
+}
+
+struct vkms_stereo_test_frame_case {
+	const char *name;
+	struct vkms_stereo_test_mode mode;
+	int width;
+	int height;
+	int bad_width;
+	int bad_height;
+};
+
+/*
+ * The frame of a mode is the buffer that holds both eyes: frame packing
+ * adds vtotal lines (1080 + 1125 for these modes), the other layouts keep
+ * the size of the mode. Each case also names a writeback buffer size that
+ * must be refused.
+ */
+static const struct vkms_stereo_test_frame_case vkms_stereo_test_frame_cases[] = {
+	{ "2d", { 1920, 1080, 60, 0 }, 1920, 1080, 1920, 2205 },
+	{ "frame-packing", { 1920, 1080, 30, DRM_MODE_FLAG_3D_FRAME_PACKING },
+	  1920, 2205, 1920, 1080 },
+	{ "top-and-bottom", { 1920, 1080, 60, DRM_MODE_FLAG_3D_TOP_AND_BOTTOM },
+	  1920, 1080, 1920, 2205 },
+	{ "side-by-side-half", { 1920, 1080, 60, DRM_MODE_FLAG_3D_SIDE_BY_SIDE_HALF },
+	  1920, 1080, 3840, 1080 },
+};
+
+static void vkms_stereo_test_frame_case_desc(const struct vkms_stereo_test_frame_case *t,
+					     char *desc)
+{
+	strscpy(desc, t->name, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(vkms_stereo_test_frame, vkms_stereo_test_frame_cases,
+		  vkms_stereo_test_frame_case_desc);
+
+/*
+ * Checks an update showing a primary plane of the frame size and writing
+ * the composed frame back to a buffer of wb_width x wb_height.
+ */
+static int vkms_stereo_test_check_update(struct kunit *test,
+					 const struct drm_display_mode *mode,
+					 int width, int height,
+					 int wb_width, int wb_height)
+{
+	struct vkms_stereo_test_priv *priv = test->priv;
+	struct drm_device *drm = &priv->vkmsdev->drm;
+	struct drm_framebuffer *fb, *wb_fb;
+	struct drm_connector_state *conn_state, *wb_state;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_plane_state *plane_state;
+	struct drm_crtc_state *crtc_state;
+	struct drm_atomic_commit *state;
+	int ret;
+
+	fb = vkms_stereo_test_create_fb(test, width, height);
+	wb_fb = vkms_stereo_test_create_fb(test, wb_width, wb_height);
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+	crtc_state = drm_atomic_get_crtc_state(state, priv->crtc);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+	ret = drm_atomic_set_mode_for_crtc(crtc_state, mode);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	crtc_state->enable = true;
+	crtc_state->active = true;
+
+	conn_state = drm_atomic_get_connector_state(state, priv->connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+	ret = drm_atomic_set_crtc_for_connector(conn_state, priv->crtc);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	plane_state = drm_atomic_get_plane_state(state, priv->primary);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_state);
+	ret = drm_atomic_set_crtc_for_plane(plane_state, priv->crtc);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	drm_atomic_set_fb_for_plane(plane_state, fb);
+	plane_state->crtc_w = width;
+	plane_state->crtc_h = height;
+	plane_state->src_w = width << 16;
+	plane_state->src_h = height << 16;
+
+	wb_state = drm_atomic_get_connector_state(state, &priv->wb_connector->base);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, wb_state);
+	ret = drm_atomic_set_crtc_for_connector(wb_state, priv->crtc);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	ret = drm_writeback_set_fb(wb_state, wb_fb);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = drm_atomic_check_only(state);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+
+	return ret;
+}
+
+/*
+ * The writeback connector takes a buffer of the frame size, so it receives
+ * both eyes, and refuses any other size.
+ */
+static void vkms_stereo_test_writeback_frame(struct kunit *test)
+{
+	const struct vkms_stereo_test_frame_case *t = test->param_value;
+	const struct drm_display_mode *mode;
+	int ret;
+
+	vkms_stereo_test_probe(test);
+
+	mode = vkms_stereo_test_find_mode(test, &t->mode);
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+
+	ret = vkms_stereo_test_check_update(test, mode, t->width, t->height,
+					    t->width, t->height);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	ret = vkms_stereo_test_check_update(test, mode, t->width, t->height,
+					    t->bad_width, t->bad_height);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
+static struct kunit_case vkms_stereo_test_cases[] = {
+	KUNIT_CASE(vkms_stereo_test_edid_modes),
+	KUNIT_CASE_PARAM(vkms_stereo_test_writeback_frame,
+			 vkms_stereo_test_frame_gen_params),
+	{}
+};
+
+static struct kunit_suite vkms_stereo_test_suite = {
+	.name = "vkms-stereo",
+	.init = vkms_stereo_test_init,
+	.test_cases = vkms_stereo_test_cases,
+};
+
+kunit_test_suite(vkms_stereo_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Kunit test for vkms stereo modes");
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index ad901340ba..b484255c43 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -5,6 +5,7 @@
 #include "vkms_drv.h"
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
+#include <kunit/visibility.h>
 
 int vkms_output_init(struct vkms_device *vkmsdev)
 {
@@ -130,3 +131,4 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(vkms_output_init);
