Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726ABCD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 13:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B89A910E14F;
	Wed, 20 May 2026 13:36:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="EaOFruzn";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D70E610E14F
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:36:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779284150; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Jj78TwIL/nnO+MZbLaakGl/J/oV3TGCTui4vaUfqYsyxZp2YqDehdjTKkqijDfEi6Cs1yY5b+9miWjkzW9NTGQa5IWGVgmz+UCeggWXK0xGiQlheLSuuxwGqU73mhtZooNosC+fK1bZzQLRCNy3N9Wger0bzJgKVmvZ2W/x1VJg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779284150;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Ke5hx67m62CM40Whc9CMxbRnFQn6KjsrZ7sJRAjlIZA=; 
 b=Z/7pDNpVx1unKTNZ34wu9kHwfqCLb2njT2xYS1NfykNNaR4Q4XJxOZEdobFlWi22jr2m4KMZuM3wy7dpBmqFX5yctoh1fVJRG7iZXAVtlwnQXp92KHgubwcsnMYWCdAHCbCdHoplKAh8P/UT0wW7ujPKGw+rqyo4ReWpYwvRXUw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779284150; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Ke5hx67m62CM40Whc9CMxbRnFQn6KjsrZ7sJRAjlIZA=;
 b=EaOFruznTHtAQMVqroZgWCzciEuskm1YmbaRTRtdGTAlZaNAwVy56w1xUEz+Vl8U
 7JxRC1sCsnBvIKL79DpMiIibx/wScqUUY3Kebx3iggZ368rtszy96mxQlrESMSB/slu
 3g/ZuIC6CKP4sQG+dHil3klbICheodNF8T13XdeM=
Received: by mx.zohomail.com with SMTPS id 1779284146269789.372916806077;
 Wed, 20 May 2026 06:35:46 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 20 May 2026 15:35:16 +0200
Subject: [PATCH v2 3/3] drm/scdc-helper: Implement parsing and printing
 HDMI 2.1 fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-scdc-link-health-v2-3-511af18cd64b@collabora.com>
References: <20260520-scdc-link-health-v2-0-511af18cd64b@collabora.com>
In-Reply-To: <20260520-scdc-link-health-v2-0-511af18cd64b@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Daniel Stone <daniel@fooishbar.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
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
 drivers/gpu/drm/display/drm_scdc_helper.c | 130 +++++++++++++++++++++++++++---
 include/drm/display/drm_scdc.h            |   9 +++
 include/drm/display/drm_scdc_helper.h     |  85 +++++++++++++++----
 3 files changed, 201 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/drm/display/drm_scdc_helper.c
index d582ba38a610..e9e59c7553a4 100644
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
 
+static __pure const char *drm_scdc_frl_rate_str(enum drm_scdc_frl_rate rate)
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
@@ -309,10 +342,41 @@ int drm_scdc_read_status0_flags(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_scdc_read_status0_flags);
 
+/**
+ * drm_scdc_read_status1_2_flags - Read SCDC "Status Flags" 1 and 2 Registers
+ * @connector: pointer to &struct drm_connector to issue the scdc request on
+ * @flags: pointer to the caller's &struct drm_scdc_status_flags to output to
+ *
+ * Reads the SCDC Status Flags 1 and 2 registers, and outputs their contents to
+ * the destination @flags. Contents of @flags.status1 and @flags.status2 are
+ * only valid if function returns 0.
+ *
+ * Returns 0 on success, negative errno on error.
+ */
+int drm_scdc_read_status1_2_flags(struct drm_connector *connector,
+				  struct drm_scdc_status_flags *flags)
+{
+	int ret;
+
+	ret = drm_scdc_writeb(connector->ddc, SCDC_UPDATE_0, SCDC_FLT_UPDATE);
+	if (ret)
+		return ret;
+
+	ret = drm_scdc_readb(connector->ddc, SCDC_STATUS_FLAGS_1, &flags->status1.data);
+	if (ret)
+		return ret;
+
+	return drm_scdc_readb(connector->ddc, SCDC_STATUS_FLAGS_2, &flags->status2.data);
+}
+EXPORT_SYMBOL(drm_scdc_read_status1_2_flags);
+
+#define ERR_DET_OFF(x) ((x) - SCDC_ERR_DET_0_L)
+
 /**
  * drm_scdc_read_error_counters - Read and clear SCDC error counters
  * @connector: pointer to &struct drm_connector to issue the scdc request on
- * @counter: Caller's u16 array with 3 elements to write the counter values into
+ * @counter: Caller's u16 array with 4 elements to write the counter values into
+ * @num_lanes: number of active lanes, either 3 or 4
  *
  * Read the SCDC channel error counters. If the count of channel *n* is valid,
  * write it into counter[n]. Otherwise, set counter[n] to 0. Reads all counters
@@ -320,19 +384,33 @@ EXPORT_SYMBOL(drm_scdc_read_status0_flags);
  *
  * Returns: %0 on success, negative errno on error.
  */
-int drm_scdc_read_error_counters(struct drm_connector *connector, u16 counter[3])
+int drm_scdc_read_error_counters(struct drm_connector *connector, u16 counter[4],
+				 unsigned int num_lanes)
 {
-	u8 buf[7] = { 0 };
+	unsigned int buf_sz;
+	u8 buf[9] = { 0 };
 	ssize_t ret;
 	u8 sum = 0;
 	int i;
 
+	switch (num_lanes) {
+	case 0:
+	case 3:
+		buf_sz = 7;
+		break;
+	case 4:
+		buf_sz = 9;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	ret = drm_scdc_writeb(connector->ddc, SCDC_UPDATE_0, SCDC_CED_UPDATE);
 	if (ret)
 		return ret;
 
 	/* why in the fucking fuck does this return a ssize_t */
-	ret = drm_scdc_read(connector->ddc, SCDC_ERR_DET_0_L, buf, ARRAY_SIZE(buf));
+	ret = drm_scdc_read(connector->ddc, SCDC_ERR_DET_0_L, buf, buf_sz);
 	if (ret)
 		return ret;
 
@@ -340,13 +418,13 @@ int drm_scdc_read_error_counters(struct drm_connector *connector, u16 counter[3]
 	 * Verify the "checksum", i.e. sum up everything including the checksum
 	 * register as a wrapping unsigned 8-bit addition and verify it's 0.
 	 */
-	for (i = 0; i < ARRAY_SIZE(buf); i++)
+	for (i = 0; i < buf_sz; i++)
 		sum = wrapping_add(u8, sum, buf[i]);
 
 	if (sum)
 		return -EPROTO;
 
-	for (i = 0; i < ARRAY_SIZE(buf) - 1; i += 2) {
+	for (i = 0; i <= ERR_DET_OFF(SCDC_ERR_DET_2_H); i += 2) {
 		if (buf[i + 1] & SCDC_CHANNEL_VALID)
 			counter[i / 2] = buf[i] | (buf[i + 1] & ~SCDC_CHANNEL_VALID) << 8;
 		else
@@ -355,9 +433,15 @@ int drm_scdc_read_error_counters(struct drm_connector *connector, u16 counter[3]
 		buf[i] = 0;
 		buf[i + 1] = 0;
 	}
-	buf[ARRAY_SIZE(buf) - 1] = 0;
+	buf[ERR_DET_OFF(SCDC_ERR_DET_CHECKSUM)] = 0;
+
+	if (num_lanes == 4)
+		counter[3] = buf[ERR_DET_OFF(SCDC_ERR_DET_3_L)] |
+			     (buf[ERR_DET_OFF(SCDC_ERR_DET_3_H)] & ~SCDC_CHANNEL_VALID) << 8;
+	else
+		counter[3] = 0;
 
-	return drm_scdc_write(connector->ddc, SCDC_ERR_DET_0_L, buf, ARRAY_SIZE(buf));
+	return drm_scdc_write(connector->ddc, SCDC_ERR_DET_0_L, buf, buf_sz);
 }
 EXPORT_SYMBOL(drm_scdc_read_error_counters);
 
@@ -377,6 +461,7 @@ int drm_scdc_read_state(struct drm_connector *connector, struct drm_scdc_state *
 	u8 upd_flags[2] = { 0 };
 	struct i2c_adapter *ddc;
 	struct drm_scdc *scdc;
+	int num_lanes;
 	int ret;
 	u8 val;
 
@@ -398,6 +483,17 @@ int drm_scdc_read_state(struct drm_connector *connector, struct drm_scdc_state *
 
 	state->scrambling_detected = drm_scdc_get_scrambling_status(connector);
 
+	ret = drm_scdc_readb(ddc, SCDC_CONFIG_1, &val);
+	if (ret)
+		return ret;
+
+	state->rate = FIELD_GET(SCDC_FRL_RATE, val);
+	num_lanes = drm_scdc_num_frl_lanes(state->rate);
+	if (num_lanes < 0)
+		return num_lanes;
+
+	state->ffe_levels = FIELD_GET(SCDC_FFE_LEVELS, val);
+
 	ret = drm_scdc_read(ddc, SCDC_UPDATE_0, &upd_flags, sizeof(upd_flags));
 	if (ret)
 		return ret;
@@ -408,8 +504,15 @@ int drm_scdc_read_state(struct drm_connector *connector, struct drm_scdc_state *
 			return ret;
 	}
 
+	if (upd_flags[0] & SCDC_FLT_UPDATE) {
+		ret = drm_scdc_read_status1_2_flags(connector, &state->stf);
+		if (ret)
+			return ret;
+	}
+
 	if (upd_flags[0] & SCDC_CED_UPDATE) {
-		ret = drm_scdc_read_error_counters(connector, state->error_count);
+		ret = drm_scdc_read_error_counters(connector, state->error_count,
+						   num_lanes);
 		if (ret)
 			return ret;
 	}
@@ -457,6 +560,8 @@ static int scdc_status_show(struct seq_file *m, void *data)
 
 	scdc_print_flag(m, "Scrambling Enabled", st->scrambling_enabled);
 	scdc_print_flag(m, "Scrambling Detected", st->scrambling_detected);
+	scdc_print_str(m, "FRL Rate", drm_scdc_frl_rate_str(st->rate));
+	scdc_print_dec(m, "FFE Levels", st->ffe_levels);
 
 	if (st->tmds_bclk_x40)
 		scdc_print_str(m, "TMDS Bit Clock Ratio", "1/40");
@@ -467,10 +572,17 @@ static int scdc_status_show(struct seq_file *m, void *data)
 	scdc_print_flag(m, "Channel 0 Locked", st->stf.status0.flags.ch0_locked);
 	scdc_print_flag(m, "Channel 1 Locked", st->stf.status0.flags.ch1_locked);
 	scdc_print_flag(m, "Channel 2 Locked", st->stf.status0.flags.ch2_locked);
+	if (drm_scdc_num_frl_lanes(st->rate) == 4)
+		scdc_print_flag(m, "Lane 3 Locked", st->stf.status0.flags.ln3_locked);
+
+	scdc_print_flag(m, "Sink Ready For Link Training", st->stf.status0.flags.flt_ready);
+	scdc_print_flag(m, "Sink Failed To Decode DSC", st->stf.status0.flags.dsc_fail);
 
 	scdc_print_dec(m, "Channel 0 Errors", st->error_count[0]);
 	scdc_print_dec(m, "Channel 1 Errors", st->error_count[1]);
 	scdc_print_dec(m, "Channel 2 Errors", st->error_count[2]);
+	if (drm_scdc_num_frl_lanes(st->rate) == 4)
+		scdc_print_dec(m, "Lane 3 Errors", st->error_count[3]);
 
 	return 0;
 
diff --git a/include/drm/display/drm_scdc.h b/include/drm/display/drm_scdc.h
index 3d58f37e8ed8..56cd909edac9 100644
--- a/include/drm/display/drm_scdc.h
+++ b/include/drm/display/drm_scdc.h
@@ -29,6 +29,7 @@
 #define SCDC_SOURCE_VERSION 0x02
 
 #define SCDC_UPDATE_0 0x10
+#define  SCDC_FLT_UPDATE (1 << 5)
 #define  SCDC_READ_REQUEST_TEST (1 << 2)
 #define  SCDC_CED_UPDATE (1 << 1)
 #define  SCDC_STATUS_UPDATE (1 << 0)
@@ -46,6 +47,10 @@
 #define SCDC_CONFIG_0 0x30
 #define  SCDC_READ_REQUEST_ENABLE (1 << 0)
 
+#define SCDC_CONFIG_1 0x31
+#define  SCDC_FRL_RATE   0x0f
+#define  SCDC_FFE_LEVELS 0xf0
+
 #define SCDC_STATUS_FLAGS_0 0x40
 #define  SCDC_CH2_LOCK (1 << 3)
 #define  SCDC_CH1_LOCK (1 << 2)
@@ -54,6 +59,7 @@
 #define  SCDC_CLOCK_DETECT (1 << 0)
 
 #define SCDC_STATUS_FLAGS_1 0x41
+#define SCDC_STATUS_FLAGS_2 0x42
 
 #define SCDC_ERR_DET_0_L 0x50
 #define SCDC_ERR_DET_0_H 0x51
@@ -65,6 +71,9 @@
 
 #define SCDC_ERR_DET_CHECKSUM 0x56
 
+#define SCDC_ERR_DET_3_L 0x57
+#define SCDC_ERR_DET_3_H 0x58
+
 #define SCDC_TEST_CONFIG_0 0xc0
 #define  SCDC_TEST_READ_REQUEST (1 << 7)
 #define  SCDC_TEST_READ_REQUEST_DELAY(x) ((x) & 0x7f)
diff --git a/include/drm/display/drm_scdc_helper.h b/include/drm/display/drm_scdc_helper.h
index b597e24a2976..1a95da3da5fe 100644
--- a/include/drm/display/drm_scdc_helper.h
+++ b/include/drm/display/drm_scdc_helper.h
@@ -24,6 +24,7 @@
 #ifndef DRM_SCDC_HELPER_H
 #define DRM_SCDC_HELPER_H
 
+#include <linux/errno.h>
 #include <linux/types.h>
 
 #include <drm/display/drm_scdc.h>
@@ -40,10 +41,10 @@ struct drm_scdc_status_flags {
 			bool ch0_locked : 1;
 			bool ch1_locked : 1;
 			bool ch2_locked : 1;
-			bool rsvd_4 : 1;
+			bool ln3_locked : 1;
 			bool rsvd_5 : 1;
-			bool rsvd_6 : 1;
-			bool rsvd_7 : 1;
+			bool flt_ready : 1;
+			bool dsc_fail : 1;
 		} flags __packed;
 		u8 data;
 	} status0;
@@ -51,19 +52,68 @@ struct drm_scdc_status_flags {
 	/* Status Register 1 */
 	union {
 		struct {
-			bool rsvd_0 : 1;
-			bool rsvd_1 : 1;
-			bool rsvd_2 : 1;
-			bool rsvd_3 : 1;
-			bool rsvd_4 : 1;
-			bool rsvd_5 : 1;
-			bool rsvd_6 : 1;
-			bool rsvd_7 : 1;
+			u8 ln0_training_pattern : 4;
+			u8 ln1_training_pattern : 4;
 		} flags __packed;
 		u8 data;
 	} status1;
+
+	/* Status Register 2 */
+	union {
+		struct {
+			u8 ln2_training_pattern : 4;
+			u8 ln3_training_pattern : 4;
+		} flags __packed;
+		u8 data;
+	} status2;
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
@@ -76,8 +126,12 @@ struct drm_scdc_state {
 	 * clock period, false if it's 1/10th of the clock period.
 	 */
 	bool tmds_bclk_x40;
-	/** @error_count: character error counts for each channel */
-	u16 error_count[3];
+	/** @rate: FRL rate set by the source */
+	enum drm_scdc_frl_rate rate : 4;
+	/** @ffe_levels: The FFE levels for @rate set by the source */
+	u8 ffe_levels : 4;
+	/** @error_count: character error counts for each channel/link */
+	u16 error_count[4];
 };
 
 ssize_t drm_scdc_read(struct i2c_adapter *adapter, u8 offset, void *buffer,
@@ -128,9 +182,12 @@ bool drm_scdc_set_high_tmds_clock_ratio(struct drm_connector *connector, bool se
 
 int drm_scdc_read_status0_flags(struct drm_connector *connector,
 				struct drm_scdc_status_flags *flags);
+int drm_scdc_read_status1_2_flags(struct drm_connector *connector,
+				  struct drm_scdc_status_flags *flags);
 int drm_scdc_read_state(struct drm_connector *connector,
 			struct drm_scdc_state *state);
-int drm_scdc_read_error_counters(struct drm_connector *connector, u16 counter[3]);
+int drm_scdc_read_error_counters(struct drm_connector *connector, u16 counter[4],
+				 unsigned int num_lanes);
 void drm_scdc_debugfs_init(struct drm_connector *connector, struct dentry *root);
 
 #endif

-- 
2.54.0

