Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DA2C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 14:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A19AB10E060;
	Fri, 24 Jul 2026 14:23:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="PkhAokOL";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16C6D10E060
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 14:23:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784902997; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=feh4E2AUYLXSbZc8wRwtPBE89dCTouytyoCUH7No0Ojkp1PjWoDx/Nn5rSGHcHkKOMIvxkng8O7fCWEPMEHmAtDz42gv71+MMT3m/z9n50HtfYPbhr+D5H4aU+0aj+tP5wQxt7/P5RoofpG3E7GA3R4Kam9PIVw+aGV46KAwkx8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784902997;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=C4lOeSzX69UWcsgeROuSWqBsh0HASlGUr+L4G5DF0F0=; 
 b=CSSNSu93X87z5ScTJmriR2SxcpwkkXAIUGEp5tb3du4BHGnytHn4D3W8gdtBE8PkpoIyVYzzqS2apadDh0/fVSIdnn8dFumvTeC2zzidPap2Jm/cYYR430f9vh2ozL/vozvhIiUF9UhsE9D0LiDEfq6xzXvkRzDfwep2KOQFniY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784902997; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=C4lOeSzX69UWcsgeROuSWqBsh0HASlGUr+L4G5DF0F0=;
 b=PkhAokOLtwcOar9enESMrhKl0pWI0QJVkrW+t/u+EQ5ByRiHc/4refgrz/IxL69H
 EoUlMLOv6XInmwciG6n6U8EfOUA+dWL2Z8QhLRgEVtyHNAbkDbqXuB1gzqcLMKlVNdC
 +0ZlO8yaVUxM4XYe4LMwJ6LmBtXphJfNGQ0kUx5Y=
Received: by mx.zohomail.com with SMTPS id 1784902994433745.8102447774462;
 Fri, 24 Jul 2026 07:23:14 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 24 Jul 2026 16:22:37 +0200
Subject: [PATCH v9 2/5] drm/scdc-helper: Add scdc_status debugfs entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-scdc-link-health-v9-2-bdda406d016d@collabora.com>
References: <20260724-scdc-link-health-v9-0-bdda406d016d@collabora.com>
In-Reply-To: <20260724-scdc-link-health-v9-0-bdda406d016d@collabora.com>
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

SCDC provides status information on the current display link. At the
very least, it may be useful to expose this info through debugfs.

Add a debugfs entry for it under the connector, which displays a few
more details parsed out of the SCDC registers. A new
drm_scdc_debugfs_init function can be called by the connector
implementation to initialise the debugfs file.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/display/drm_scdc_helper.c | 186 ++++++++++++++++++++++++++++++
 include/drm/display/drm_scdc_helper.h     |  32 +++++
 2 files changed, 218 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/drm/display/drm_scdc_helper.c
index 8403f2390ab6..129a2b85527b 100644
--- a/drivers/gpu/drm/display/drm_scdc_helper.c
+++ b/drivers/gpu/drm/display/drm_scdc_helper.c
@@ -24,7 +24,9 @@
 #include <linux/export.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
+#include <linux/overflow.h>
 
 #include <drm/display/drm_scdc_helper.h>
 #include <drm/drm_connector.h>
@@ -276,3 +278,187 @@ bool drm_scdc_set_high_tmds_clock_ratio(struct drm_connector *connector,
 	return true;
 }
 EXPORT_SYMBOL(drm_scdc_set_high_tmds_clock_ratio);
+
+static void
+drm_scdc_parse_status0_flags(u8 val, struct drm_scdc_status_flags *flags)
+{
+	flags->clock_detected = val & SCDC_CLOCK_DETECT;
+	flags->ch0_locked = val & SCDC_CH0_LOCK;
+	flags->ch1_locked = val & SCDC_CH1_LOCK;
+	flags->ch2_locked = val & SCDC_CH2_LOCK;
+}
+
+static int drm_scdc_parse_error_counters(const u8 scdc[256], u16 counter[3])
+{
+	u8 sum = 0;
+	int i;
+
+	for (i = SCDC_ERR_DET_0_L; i <= SCDC_ERR_DET_CHECKSUM ; i++)
+		sum = wrapping_add(u8, sum, scdc[i]);
+
+	if (sum)
+		return -EPROTO;
+
+	for (i = 0; i < 3; i++) {
+		if (scdc[SCDC_ERR_DET_0_H + i * 2] & SCDC_CHANNEL_VALID)
+			counter[i] =  (scdc[SCDC_ERR_DET_0_H + i * 2] &
+				       ~SCDC_CHANNEL_VALID) << 8 |
+				       scdc[SCDC_ERR_DET_0_L + i * 2];
+		else
+			counter[i] = 0;
+	}
+
+	return 0;
+}
+
+/**
+ * drm_scdc_read_state - Update state from SCDC
+ * @connector: pointer to a &struct drm_connector on which to operate on
+ * @state: pointer to a &struct drm_scdc_state to fill
+ *
+ * Reads the entire 256 byte SCDC state and parses it.
+ *
+ * Returns: %0 on success, negative errno on failure.
+ */
+int drm_scdc_read_state(struct drm_connector *connector, struct drm_scdc_state *state)
+{
+	struct i2c_adapter *ddc;
+	struct drm_scdc *scdc;
+	u8 *buf = state->scdc;
+	int ret;
+
+	if (!state || !connector)
+		return -ENODEV;
+
+	scdc = &connector->display_info.hdmi.scdc;
+	ddc = connector->ddc;
+
+	if (!scdc->supported || !ddc)
+		return -EOPNOTSUPP;
+
+	/* Read in 128-byte chunks, to work around DP<->HDMI converters with issues. */
+	ret = drm_scdc_read(ddc, 0, buf, 128);
+	if (ret)
+		return ret;
+
+	ret = drm_scdc_read(ddc, 128, &buf[128], 128);
+	if (ret)
+		return ret;
+
+	state->scrambling_enabled = buf[SCDC_TMDS_CONFIG] & SCDC_SCRAMBLING_ENABLE;
+	state->tmds_bclk_x40 = buf[SCDC_TMDS_CONFIG] & SCDC_TMDS_BIT_CLOCK_RATIO_BY_40;
+
+	state->scrambling_detected = buf[SCDC_SCRAMBLER_STATUS] & SCDC_SCRAMBLING_STATUS;
+
+	drm_scdc_parse_status0_flags(buf[SCDC_STATUS_FLAGS_0], &state->stf);
+	ret = drm_scdc_parse_error_counters(buf, state->error_count);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_scdc_read_state);
+
+#define scdc_print_str(_f, key, s) \
+	(seq_printf((_f), "%-30s: %s\n", (key), (s)))
+#define scdc_print_flag(_f, key, val) \
+	(scdc_print_str((_f), (key), str_yes_no((val))))
+#define scdc_print_dec(_f, key, val) \
+	(seq_printf((_f), "%-30s: %d\n", (key), (val)))
+
+static int scdc_status_show(struct seq_file *m, void *data)
+{
+	struct drm_connector *connector = m->private;
+	struct drm_scdc *scdc = &connector->display_info.hdmi.scdc;
+	struct drm_scdc_state *st;
+	int i, ret;
+
+	drm_connector_get(connector);
+
+	ret = mutex_lock_interruptible(&connector->dev->mode_config.mutex);
+	if (ret)
+		goto err_conn_put;
+
+	if (connector->status != connector_status_connected) {
+		ret = -ENODEV;
+		goto err_unlock;
+	}
+
+	if (scdc->supported) {
+		st = kzalloc_obj(*st);
+		if (!st) {
+			ret = -ENOMEM;
+			goto err_unlock;
+		}
+		ret = drm_scdc_read_state(connector, st);
+		if (ret)
+			goto err_free_state;
+
+		for (i = 0; i < ARRAY_SIZE(st->scdc); i += 16)
+			seq_printf(m, "%*ph\n", 16, &st->scdc[i]);
+
+		seq_puts(m, "\n----------------\n\n");
+	}
+
+	scdc_print_flag(m, "SCDC Supported", scdc->supported);
+	if (!scdc->supported) {
+		ret = 0;
+		goto err_unlock;
+	}
+
+	scdc_print_flag(m, "Sink Read Request Capable", scdc->read_request);
+	scdc_print_flag(m, "Scrambling Supported", scdc->scrambling.supported);
+	scdc_print_flag(m, "Low Rate Scrambling Supported", scdc->scrambling.low_rates);
+
+	mutex_unlock(&connector->dev->mode_config.mutex);
+
+	drm_connector_put(connector);
+
+	scdc_print_flag(m, "Scrambling Enabled", st->scrambling_enabled);
+	scdc_print_flag(m, "Scrambling Detected", st->scrambling_detected);
+
+	if (st->tmds_bclk_x40)
+		scdc_print_str(m, "TMDS Bit Clock Ratio", "1/40");
+	else
+		scdc_print_str(m, "TMDS Bit Clock Ratio", "1/10");
+
+	scdc_print_flag(m, "Clock Detected", st->stf.clock_detected);
+	scdc_print_flag(m, "Channel 0 Locked", st->stf.ch0_locked);
+	scdc_print_flag(m, "Channel 1 Locked", st->stf.ch1_locked);
+	scdc_print_flag(m, "Channel 2 Locked", st->stf.ch2_locked);
+
+	scdc_print_dec(m, "Channel 0 Errors", st->error_count[0]);
+	scdc_print_dec(m, "Channel 1 Errors", st->error_count[1]);
+	scdc_print_dec(m, "Channel 2 Errors", st->error_count[2]);
+
+	kfree(st);
+
+	return 0;
+
+err_free_state:
+	kfree(st);
+err_unlock:
+	mutex_unlock(&connector->dev->mode_config.mutex);
+err_conn_put:
+	drm_connector_put(connector);
+
+	return ret;
+}
+DEFINE_SHOW_ATTRIBUTE(scdc_status);
+
+/**
+ * drm_scdc_debugfs_init - Initialize scdc files in connector debugfs
+ * @connector: pointer to &struct drm_connector to operate on
+ * @root: debugfs &struct dentry for the debugfs root of @connector
+ *
+ * Creates SCDC-related debugfs files for @connector. Must be called after
+ * @root is already created.
+ */
+void drm_scdc_debugfs_init(struct drm_connector *connector, struct dentry *root)
+{
+	if (!root || !connector)
+		return;
+
+	debugfs_create_file("scdc_status", 0444, root, connector, &scdc_status_fops);
+}
+EXPORT_SYMBOL(drm_scdc_debugfs_init);
diff --git a/include/drm/display/drm_scdc_helper.h b/include/drm/display/drm_scdc_helper.h
index e9ccaeba56dd..e0b79d79e1ff 100644
--- a/include/drm/display/drm_scdc_helper.h
+++ b/include/drm/display/drm_scdc_helper.h
@@ -30,6 +30,34 @@
 
 struct drm_connector;
 struct i2c_adapter;
+struct dentry;
+
+struct drm_scdc_status_flags {
+	/* Status Register 0 */
+	bool clock_detected;
+	bool ch0_locked;
+	bool ch1_locked;
+	bool ch2_locked;
+};
+
+struct drm_scdc_state {
+	/** @stf: contents of the status flag registers */
+	struct drm_scdc_status_flags stf;
+	/** @scramling_enabled: true if TMDS scrambling is on */
+	bool scrambling_enabled;
+	/** @scrambling_detected: true if the sink actually detected scrambling */
+	bool scrambling_detected;
+	/**
+	 * @tmds_bclk_x40: true if TMDS bit period is 1/40th of the TMDS
+	 * clock period, false if it's 1/10th of the clock period.
+	 */
+	bool tmds_bclk_x40;
+	/** @error_count: character error counts for each channel */
+	u16 error_count[3];
+
+	/** @scdc: raw SCDC data buffer */
+	u8 scdc[256];
+};
 
 int drm_scdc_read(struct i2c_adapter *adapter, u8 offset, void *buffer,
 		  size_t size);
@@ -77,4 +105,8 @@ bool drm_scdc_get_scrambling_status(struct drm_connector *connector);
 bool drm_scdc_set_scrambling(struct drm_connector *connector, bool enable);
 bool drm_scdc_set_high_tmds_clock_ratio(struct drm_connector *connector, bool set);
 
+int drm_scdc_read_state(struct drm_connector *connector,
+			struct drm_scdc_state *state);
+void drm_scdc_debugfs_init(struct drm_connector *connector, struct dentry *root);
+
 #endif

-- 
2.55.0

