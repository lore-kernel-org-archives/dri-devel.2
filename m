Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A06C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:59:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D85E10E7D1;
	Tue, 21 Jul 2026 08:59:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="chtunv1K";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99A5410E7C8
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 08:59:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784624378; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=i5c4XB2ZKj1HOff+ACS5IPaJQpDdJPR9QijbJn26aGCIgUVlUdrY90Hgt2jWtgLdGSFJFpUrd00J7ZE6vYhzx5gAx6dfQOxHhALShgN07YqIXMXpcu0BTF+gE1P6orIGGODTteOtRB5W/aTN/XX2S7DSlZabJJwcuLlw3fxmG2I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784624378;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=YUzegxQOCx0DhpBoy3j5swxq9xMYgHzoyVro1T4oJ5k=; 
 b=iu3UN4ewVW+PFAf4osbj8abbxnvVer2XCw+D4WP5z8Tfajt1KZNpEBqnSZPE8+stcRehEZ1/SD8CByHsoiAY+MnO2u/zJqFvIvS4DpfeDrVygTCVXvaBp5iqVXVbcSpfrNXvyebLk8aWVZ8iGHLvGrOjMj4V0r60Sb20G/mii3I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784624378; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=YUzegxQOCx0DhpBoy3j5swxq9xMYgHzoyVro1T4oJ5k=;
 b=chtunv1KI/VyCpH7rYoETXY7poz0kQ8b5v853Hfv9IGEt+JTrHuXMXQzCpS5zMmk
 OBj7SVY0E0CzzwTcJfJzeWPcVGRzn3vFOIBvH93zRFw9184cMqVvG6DzMncaYUWS1x1
 7r0JjvOYvuqTLYkTtwNkL6Ky79C8TZZOAKS+83fU=
Received: by mx.zohomail.com with SMTPS id 1784624377061269.21949712132755;
 Tue, 21 Jul 2026 01:59:37 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 21 Jul 2026 10:58:59 +0200
Subject: [PATCH v7 3/5] drm/scdc-helper: Implement parsing and printing
 HDMI 2.1 fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-scdc-link-health-v7-3-92df1b6ad5fc@collabora.com>
References: <20260721-scdc-link-health-v7-0-92df1b6ad5fc@collabora.com>
In-Reply-To: <20260721-scdc-link-health-v7-0-92df1b6ad5fc@collabora.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Daniel Stone <daniel@fooishbar.org>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
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

HDMI 2.1 redefines previously reserved fields in SCDC for various new
uses. No version check needs to be performed, as an HDMI 2.0 sink's
reserved SCDC fields are well-defined to be 0, and any zero-ness of
these fields for an HDMI 2.0 sink is not a surprise for SCDC parsers for
HDMI 2.1.

Implement reading and outputting these fields over debugfs.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/display/drm_scdc_helper.c | 99 ++++++++++++++++++++++++++++++-
 include/drm/display/drm_scdc.h            | 21 ++++++-
 include/drm/display/drm_scdc_helper.h     | 69 ++++++++++++++++++++-
 3 files changed, 182 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/drm/display/drm_scdc_helper.c
index 5871fc101815..7e17272d52f2 100644
--- a/drivers/gpu/drm/display/drm_scdc_helper.c
+++ b/drivers/gpu/drm/display/drm_scdc_helper.c
@@ -21,6 +21,7 @@
  * DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/bitfield.h>
 #include <linux/export.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
@@ -63,6 +64,38 @@ struct scdc_debugfs_priv {
 	struct drm_scdc_state state;
 };
 
+static const char *drm_scdc_frl_rate_str(enum drm_scdc_frl_rate rate)
+{
+	switch (rate) {
+	case SCDC_FRL_RATE_OFF:
+		return "Off";
+	case SCDC_FRL_RATE_3X3:
+		return "3 Gbit/s x 3 lanes";
+	case SCDC_FRL_RATE_6X3:
+		return "6 Gbit/s x 3 lanes";
+	case SCDC_FRL_RATE_6X4:
+		return "6 Gbit/s x 4 lanes";
+	case SCDC_FRL_RATE_8X4:
+		return "8 Gbit/s x 4 lanes";
+	case SCDC_FRL_RATE_10X4:
+		return "10 Gbit/s x 4 lanes";
+	case SCDC_FRL_RATE_12X4:
+		return "12 Gbit/s x 4 lanes";
+	case SCDC_FRL_RATE_RESV_7:
+	case SCDC_FRL_RATE_RESV_8:
+	case SCDC_FRL_RATE_RESV_9:
+	case SCDC_FRL_RATE_RESV_10:
+	case SCDC_FRL_RATE_RESV_11:
+	case SCDC_FRL_RATE_RESV_12:
+	case SCDC_FRL_RATE_RESV_13:
+	case SCDC_FRL_RATE_RESV_14:
+	case SCDC_FRL_RATE_RESV_15:
+		return "(Reserved)";
+	default:
+		return NULL;
+	}
+}
+
 /**
  * drm_scdc_read - read a block of data from SCDC
  * @adapter: I2C controller
@@ -292,14 +325,41 @@ drm_scdc_parse_status0_flags(u8 val, struct drm_scdc_status_flags *flags)
 	flags->ch0_locked = val & SCDC_CH0_LOCK;
 	flags->ch1_locked = val & SCDC_CH1_LOCK;
 	flags->ch2_locked = val & SCDC_CH2_LOCK;
+	flags->ln3_locked = val & SCDC_LN3_LOCK;
+	flags->flt_ready = val & SCDC_FLT_READY;
+	flags->dsc_fail = val & SCDC_DSC_FAIL;
+}
+
+static void
+drm_scdc_parse_status1_2_flags(u8 val_flag1, u8 val_flag2,
+			       struct drm_scdc_status_flags *flags)
+{
+	flags->ln0_training_pattern = FIELD_GET(SCDC_LN_EVEN_TRAIN_PTRN, val_flag1);
+	flags->ln1_training_pattern = FIELD_GET(SCDC_LN_ODD_TRAIN_PTRN, val_flag1);
+
+	flags->ln2_training_pattern = FIELD_GET(SCDC_LN_EVEN_TRAIN_PTRN, val_flag2);
+	flags->ln3_training_pattern = FIELD_GET(SCDC_LN_ODD_TRAIN_PTRN, val_flag2);
 }
 
-static int drm_scdc_parse_error_counters(const u8 scdc[256], u16 counter[3])
+static int drm_scdc_parse_error_counters(const u8 scdc[256], u16 counter[4],
+					 unsigned int num_lanes)
 {
+	u8 end_reg;
 	u8 sum = 0;
 	int i;
 
-	for (i = SCDC_ERR_DET_0_L; i <= SCDC_ERR_DET_CHECKSUM ; i++)
+	switch (num_lanes) {
+	case 3:
+		end_reg = SCDC_ERR_DET_CHECKSUM;
+		break;
+	case 4:
+		end_reg = SCDC_ERR_DET_3_H;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	for (i = SCDC_ERR_DET_0_L; i <= end_reg; i++)
 		sum = wrapping_add(u8, sum, scdc[i]);
 
 	if (sum)
@@ -314,6 +374,12 @@ static int drm_scdc_parse_error_counters(const u8 scdc[256], u16 counter[3])
 			counter[i] = 0;
 	}
 
+	if (num_lanes == 4 && scdc[SCDC_ERR_DET_3_H] & SCDC_CHANNEL_VALID)
+		counter[3] =  (scdc[SCDC_ERR_DET_3_H] & ~SCDC_CHANNEL_VALID) << 8 |
+			      scdc[SCDC_ERR_DET_3_L];
+	else
+		counter[3] = 0;
+
 	return 0;
 }
 
@@ -331,6 +397,7 @@ int drm_scdc_read_state(struct drm_connector *connector, struct drm_scdc_state *
 	struct i2c_adapter *ddc;
 	struct drm_scdc *scdc;
 	u8 *buf = state->scdc;
+	int num_lanes;
 	int ret;
 
 	if (!state || !connector)
@@ -356,11 +423,26 @@ int drm_scdc_read_state(struct drm_connector *connector, struct drm_scdc_state *
 
 	state->scrambling_detected = buf[SCDC_SCRAMBLER_STATUS] & SCDC_SCRAMBLING_STATUS;
 
+	state->rate = FIELD_GET(SCDC_FRL_RATE, buf[SCDC_CONFIG_1]);
+	num_lanes = drm_scdc_num_frl_lanes(state->rate);
+	if (num_lanes < 0)
+		return num_lanes;
+	if (!num_lanes)
+		num_lanes = 3;
+
+	state->ffe_levels = FIELD_GET(SCDC_FFE_LEVELS, buf[SCDC_CONFIG_1]);
+
 	drm_scdc_parse_status0_flags(buf[SCDC_STATUS_FLAGS_0], &state->stf);
-	ret = drm_scdc_parse_error_counters(buf, state->error_count);
+	drm_scdc_parse_status1_2_flags(buf[SCDC_STATUS_FLAGS_1],
+				       buf[SCDC_STATUS_FLAGS_2], &state->stf);
+	ret = drm_scdc_parse_error_counters(buf, state->error_count, num_lanes);
 	if (ret)
 		return ret;
 
+	if (num_lanes == 4 && (buf[SCDC_ERR_DET_RS_H] & SCDC_CHANNEL_VALID))
+		state->rs_corrections = (buf[SCDC_ERR_DET_RS_H] & ~SCDC_CHANNEL_VALID) << 8 |
+					buf[SCDC_ERR_DET_RS_L];
+
 	return 0;
 }
 EXPORT_SYMBOL(drm_scdc_read_state);
@@ -412,6 +494,8 @@ static int scdc_status_show(struct seq_file *m, void *data)
 
 	scdc_print_flag(m, "Scrambling Enabled", st->scrambling_enabled);
 	scdc_print_flag(m, "Scrambling Detected", st->scrambling_detected);
+	scdc_print_str(m, "FRL Rate", drm_scdc_frl_rate_str(st->rate));
+	scdc_print_dec(m, "FFE Levels", st->ffe_levels);
 
 	if (st->tmds_bclk_x40)
 		scdc_print_str(m, "TMDS Bit Clock Ratio", "1/40");
@@ -422,10 +506,19 @@ static int scdc_status_show(struct seq_file *m, void *data)
 	scdc_print_flag(m, "Channel 0 Locked", st->stf.ch0_locked);
 	scdc_print_flag(m, "Channel 1 Locked", st->stf.ch1_locked);
 	scdc_print_flag(m, "Channel 2 Locked", st->stf.ch2_locked);
+	if (drm_scdc_num_frl_lanes(st->rate) == 4)
+		scdc_print_flag(m, "Lane 3 Locked", st->stf.ln3_locked);
+
+	scdc_print_flag(m, "Sink Ready For Link Training", st->stf.flt_ready);
+	scdc_print_flag(m, "Sink Failed To Decode DSC", st->stf.dsc_fail);
 
 	scdc_print_dec(m, "Channel 0 Errors", st->error_count[0]);
 	scdc_print_dec(m, "Channel 1 Errors", st->error_count[1]);
 	scdc_print_dec(m, "Channel 2 Errors", st->error_count[2]);
+	if (drm_scdc_num_frl_lanes(st->rate) == 4) {
+		scdc_print_dec(m, "Lane 3 Errors", st->error_count[3]);
+		scdc_print_dec(m, "Reed-Solomon Corrections", st->rs_corrections);
+	}
 
 	return 0;
 
diff --git a/include/drm/display/drm_scdc.h b/include/drm/display/drm_scdc.h
index 3d58f37e8ed8..7f0b05b2f280 100644
--- a/include/drm/display/drm_scdc.h
+++ b/include/drm/display/drm_scdc.h
@@ -29,6 +29,8 @@
 #define SCDC_SOURCE_VERSION 0x02
 
 #define SCDC_UPDATE_0 0x10
+#define  SCDC_RSED_UPDATE (1 << 6)
+#define  SCDC_FLT_UPDATE (1 << 5)
 #define  SCDC_READ_REQUEST_TEST (1 << 2)
 #define  SCDC_CED_UPDATE (1 << 1)
 #define  SCDC_STATUS_UPDATE (1 << 0)
@@ -46,14 +48,25 @@
 #define SCDC_CONFIG_0 0x30
 #define  SCDC_READ_REQUEST_ENABLE (1 << 0)
 
+#define SCDC_CONFIG_1 0x31
+#define  SCDC_FRL_RATE   0x0f
+#define  SCDC_FFE_LEVELS 0xf0
+
 #define SCDC_STATUS_FLAGS_0 0x40
+#define  SCDC_DSC_FAIL (1 << 7)
+#define  SCDC_FLT_READY (1 << 6)
+#define  SCDC_LN3_LOCK (1 << 4)
 #define  SCDC_CH2_LOCK (1 << 3)
 #define  SCDC_CH1_LOCK (1 << 2)
 #define  SCDC_CH0_LOCK (1 << 1)
-#define  SCDC_CH_LOCK_MASK (SCDC_CH2_LOCK | SCDC_CH1_LOCK | SCDC_CH0_LOCK)
+#define  SCDC_CH_LOCK_MASK (SCDC_LN3_LOCK | SCDC_CH2_LOCK | SCDC_CH1_LOCK | \
+			    SCDC_CH0_LOCK)
 #define  SCDC_CLOCK_DETECT (1 << 0)
 
 #define SCDC_STATUS_FLAGS_1 0x41
+#define  SCDC_LN_EVEN_TRAIN_PTRN 0x0f
+#define  SCDC_LN_ODD_TRAIN_PTRN 0xf0
+#define SCDC_STATUS_FLAGS_2 0x42
 
 #define SCDC_ERR_DET_0_L 0x50
 #define SCDC_ERR_DET_0_H 0x51
@@ -65,6 +78,12 @@
 
 #define SCDC_ERR_DET_CHECKSUM 0x56
 
+#define SCDC_ERR_DET_3_L 0x57
+#define SCDC_ERR_DET_3_H 0x58
+
+#define SCDC_ERR_DET_RS_L 0x59
+#define SCDC_ERR_DET_RS_H 0x5a
+
 #define SCDC_TEST_CONFIG_0 0xc0
 #define  SCDC_TEST_READ_REQUEST (1 << 7)
 #define  SCDC_TEST_READ_REQUEST_DELAY(x) ((x) & 0x7f)
diff --git a/include/drm/display/drm_scdc_helper.h b/include/drm/display/drm_scdc_helper.h
index e0b79d79e1ff..a3b20adaac7e 100644
--- a/include/drm/display/drm_scdc_helper.h
+++ b/include/drm/display/drm_scdc_helper.h
@@ -24,6 +24,7 @@
 #ifndef DRM_SCDC_HELPER_H
 #define DRM_SCDC_HELPER_H
 
+#include <linux/errno.h>
 #include <linux/types.h>
 
 #include <drm/display/drm_scdc.h>
@@ -38,8 +39,65 @@ struct drm_scdc_status_flags {
 	bool ch0_locked;
 	bool ch1_locked;
 	bool ch2_locked;
+	bool ln3_locked;
+	bool flt_ready;
+	bool dsc_fail;
+
+	/* Status Register 1 */
+	u8 ln0_training_pattern : 4;
+	u8 ln1_training_pattern : 4;
+
+	/* Status Register 2 */
+	u8 ln2_training_pattern : 4;
+	u8 ln3_training_pattern : 4;
+};
+
+enum drm_scdc_frl_rate {
+	SCDC_FRL_RATE_OFF = 0,
+	SCDC_FRL_RATE_3X3 = 1,
+	SCDC_FRL_RATE_6X3 = 2,
+	SCDC_FRL_RATE_6X4 = 3,
+	SCDC_FRL_RATE_8X4 = 4,
+	SCDC_FRL_RATE_10X4 = 5,
+	SCDC_FRL_RATE_12X4 = 6,
+	SCDC_FRL_RATE_RESV_7 = 7,
+	SCDC_FRL_RATE_RESV_8 = 8,
+	SCDC_FRL_RATE_RESV_9 = 9,
+	SCDC_FRL_RATE_RESV_10 = 10,
+	SCDC_FRL_RATE_RESV_11 = 11,
+	SCDC_FRL_RATE_RESV_12 = 12,
+	SCDC_FRL_RATE_RESV_13 = 13,
+	SCDC_FRL_RATE_RESV_14 = 14,
+	SCDC_FRL_RATE_RESV_15 = 15
 };
 
+/**
+ * drm_scdc_num_frl_lanes - get number of lanes for a given FRL rate
+ * @rate: one of &enum drm_scdc_frl_rate
+ *
+ * For a given @rate, return the number of lanes it uses.
+ *
+ * Returns: %-EINVAL if @rate is not a valid FRL rate, or the number of lanes
+ * for a given &enum drm_scdc_frl_rate on success (including %0 for "off")
+ */
+static inline __pure int drm_scdc_num_frl_lanes(enum drm_scdc_frl_rate rate)
+{
+	switch (rate) {
+	case SCDC_FRL_RATE_OFF:
+		return 0;
+	case SCDC_FRL_RATE_3X3:
+	case SCDC_FRL_RATE_6X3:
+		return 3;
+	case SCDC_FRL_RATE_6X4:
+	case SCDC_FRL_RATE_8X4:
+	case SCDC_FRL_RATE_10X4:
+	case SCDC_FRL_RATE_12X4:
+		return 4;
+	default:
+		return -EINVAL;
+	}
+}
+
 struct drm_scdc_state {
 	/** @stf: contents of the status flag registers */
 	struct drm_scdc_status_flags stf;
@@ -52,9 +110,14 @@ struct drm_scdc_state {
 	 * clock period, false if it's 1/10th of the clock period.
 	 */
 	bool tmds_bclk_x40;
-	/** @error_count: character error counts for each channel */
-	u16 error_count[3];
-
+	/** @rate: FRL rate set by the source */
+	enum drm_scdc_frl_rate rate : 4;
+	/** @ffe_levels: The FFE levels for @rate set by the source */
+	u8 ffe_levels : 4;
+	/** @error_count: character error counts for each channel/link */
+	u16 error_count[4];
+	/** @rs_corrections: number of Reed-Solomon Corrections */
+	u16 rs_corrections;
 	/** @scdc: raw SCDC data buffer */
 	u8 scdc[256];
 };

-- 
2.55.0

