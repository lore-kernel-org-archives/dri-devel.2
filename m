Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE23CD6E41
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 14:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02C9C10E819;
	Wed, 27 May 2026 14:04:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="F0TOpfs/";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B2C810E577
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 14:04:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779890651; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FpnMQEhLNnuKwfoDAX9zUZ/P0hzDFmadDjhpCI+MyddxwCeiiSfvG48n8YuVuUBqILFaqZi3Ia++JdbYWH2CFAxPomKc7z08cdNCkhqmFX5yDPoSfW5v4USops/dB5slOzRH4CB324+9XkymoXClVxlFvnIizFlq85KrkRbAFVE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779890651;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=AePNlg/tPONqMp07nxRxcyXDUmpSdhz9BPkGf90Crqs=; 
 b=PVaGHNDOLa30CAPjdaV19T7VzoquHX1oa6nAq385aNSpMMS9o7HrToQ8IPdnAkScZd5bjz0/6Gp+s0vKAxa6KWOqyRMieeZxua2BopHg2t2fhd5gIXEzHhTG5AmI5o2oFILZrQ2LoRK3KG3OG7U+TevOJnHHhES+fYEIRP9gjsg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779890651; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=AePNlg/tPONqMp07nxRxcyXDUmpSdhz9BPkGf90Crqs=;
 b=F0TOpfs/GgObbMlbXejubESD84tHDGYkalcfjte1kut13LlZ4bGIu6Z3XEIAwPRD
 LXT9TfpG3J/1Vg57WFtaPk5xsH5S5af65BhaMXHtDYoAKSyUX2OQOWEx23O9rf6ApcU
 sEzOj+7pp9/SayyYtMiA5P6X06JOBONFJrSQWZhk=
Received: by mx.zohomail.com with SMTPS id 1779890650636147.08368009246385;
 Wed, 27 May 2026 07:04:10 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 27 May 2026 16:03:43 +0200
Subject: [PATCH v4 2/4] drm/scdc-helper: Add scdc_status debugfs entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-scdc-link-health-v4-2-622ea40a1f59@collabora.com>
References: <20260527-scdc-link-health-v4-0-622ea40a1f59@collabora.com>
In-Reply-To: <20260527-scdc-link-health-v4-0-622ea40a1f59@collabora.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
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

SCDC provides status information on the current display link. At the
very least, it may be useful to expose this info through debugfs.

Add a debugfs entry for it under the connector, which displays a few
more details parsed out of the SCDC registers. A new
drm_scdc_debugfs_init function can be called by the connector
implementation to initialise the debugfs file.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/display/drm_scdc_helper.c | 237 ++++++++++++++++++++++++++++++
 include/drm/display/drm_scdc_helper.h     |  32 ++++
 2 files changed, 269 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/drm/display/drm_scdc_helper.c
index 8403f2390ab6..7739fb5e77a1 100644
--- a/drivers/gpu/drm/display/drm_scdc_helper.c
+++ b/drivers/gpu/drm/display/drm_scdc_helper.c
@@ -24,11 +24,14 @@
 #include <linux/export.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
+#include <linux/overflow.h>
 
 #include <drm/display/drm_scdc_helper.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_device.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_print.h>
 
 /**
@@ -55,6 +58,11 @@
 
 #define SCDC_I2C_SLAVE_ADDRESS 0x54
 
+struct scdc_debugfs_priv {
+	struct drm_connector *connector;
+	struct drm_scdc_state state;
+};
+
 /**
  * drm_scdc_read - read a block of data from SCDC
  * @adapter: I2C controller
@@ -276,3 +284,232 @@ bool drm_scdc_set_high_tmds_clock_ratio(struct drm_connector *connector,
 	return true;
 }
 EXPORT_SYMBOL(drm_scdc_set_high_tmds_clock_ratio);
+
+/**
+ * drm_scdc_read_status0_flags - Read SCDC "Status Flags" Register
+ * @connector: pointer to &struct drm_connector to issue the scdc request on
+ * @flags: pointer to the caller's &struct drm_scdc_status_flags to output to
+ *
+ * Reads the SCDC Status Flags 0 register, and outputs its contents to the
+ * destination @flags. Contents of @flags are only valid if function returns 0.
+ *
+ * Returns: %0 on success, negative errno on error.
+ */
+int drm_scdc_read_status0_flags(struct drm_connector *connector,
+				struct drm_scdc_status_flags *flags)
+{
+	int ret;
+	u8 val;
+
+	ret = drm_scdc_writeb(connector->ddc, SCDC_UPDATE_0, SCDC_STATUS_UPDATE);
+	if (ret)
+		return ret;
+
+	ret = drm_scdc_readb(connector->ddc, SCDC_STATUS_FLAGS_0, &val);
+	if (ret)
+		return ret;
+
+	flags->clock_detected = val & SCDC_CLOCK_DETECT;
+	flags->ch0_locked = val & SCDC_CH0_LOCK;
+	flags->ch1_locked = val & SCDC_CH1_LOCK;
+	flags->ch2_locked = val & SCDC_CH2_LOCK;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_scdc_read_status0_flags);
+
+/**
+ * drm_scdc_read_error_counters - Read and clear SCDC error counters
+ * @connector: pointer to &struct drm_connector to issue the scdc request on
+ * @counter: Caller's u16 array with 3 elements to write the counter values into
+ *
+ * Read the SCDC channel error counters. If the count of channel *n* is valid,
+ * write it into counter[n]. Otherwise, set counter[n] to 0. Reads all counters
+ * in one read chunk, then clears every counter, as is mandated.
+ *
+ * Returns: %0 on success, negative errno on error.
+ */
+int drm_scdc_read_error_counters(struct drm_connector *connector, u16 counter[3])
+{
+	u8 buf[7] = {};
+	int ret;
+	u8 sum = 0;
+	int i;
+
+	ret = drm_scdc_writeb(connector->ddc, SCDC_UPDATE_0, SCDC_CED_UPDATE);
+	if (ret)
+		return ret;
+
+	ret = drm_scdc_read(connector->ddc, SCDC_ERR_DET_0_L, buf, ARRAY_SIZE(buf));
+	if (ret)
+		return ret;
+
+	/*
+	 * Verify the "checksum", i.e. sum up everything including the checksum
+	 * register as a wrapping unsigned 8-bit addition and verify it's 0.
+	 */
+	for (i = 0; i < ARRAY_SIZE(buf); i++)
+		sum = wrapping_add(u8, sum, buf[i]);
+
+	if (sum)
+		return -EPROTO;
+
+	for (i = 0; i < ARRAY_SIZE(buf) - 1; i += 2) {
+		if (buf[i + 1] & SCDC_CHANNEL_VALID)
+			counter[i / 2] = buf[i] | (buf[i + 1] & ~SCDC_CHANNEL_VALID) << 8;
+		else
+			counter[i / 2] = 0;
+
+		buf[i] = 0;
+		buf[i + 1] = 0;
+	}
+	buf[ARRAY_SIZE(buf) - 1] = 0;
+
+	return drm_scdc_write(connector->ddc, SCDC_ERR_DET_0_L, buf, ARRAY_SIZE(buf));
+}
+EXPORT_SYMBOL(drm_scdc_read_error_counters);
+
+/**
+ * drm_scdc_read_state - Update state from SCDC
+ * @connector: pointer to a &struct drm_connector on which to operate on
+ * @state: pointer to a &struct drm_scdc_state to fill
+ *
+ * Reads update flags from SCDC, and updates the parts of @state that SCDC
+ * claims have changed, as well as populating those where such a distinction
+ * can't be made.
+ *
+ * Returns: %0 on success, negative errno on failure.
+ */
+int drm_scdc_read_state(struct drm_connector *connector, struct drm_scdc_state *state)
+{
+	u8 upd_flags[2] = {};
+	struct i2c_adapter *ddc;
+	struct drm_scdc *scdc;
+	int ret;
+	u8 val;
+
+	if (!state || !connector)
+		return -ENODEV;
+
+	scdc = &connector->display_info.hdmi.scdc;
+	ddc = connector->ddc;
+
+	if (!scdc->supported)
+		return -EOPNOTSUPP;
+
+	ret = drm_scdc_readb(ddc, SCDC_TMDS_CONFIG, &val);
+	if (ret)
+		return ret;
+
+	state->scrambling_enabled = val & SCDC_SCRAMBLING_ENABLE;
+	state->tmds_bclk_x40 = val & SCDC_TMDS_BIT_CLOCK_RATIO_BY_40;
+
+	state->scrambling_detected = drm_scdc_get_scrambling_status(connector);
+
+	ret = drm_scdc_read(ddc, SCDC_UPDATE_0, &upd_flags, sizeof(upd_flags));
+	if (ret)
+		return ret;
+
+	if (upd_flags[0] & SCDC_STATUS_UPDATE) {
+		ret = drm_scdc_read_status0_flags(connector, &state->stf);
+		if (ret)
+			return ret;
+	}
+
+	if (upd_flags[0] & SCDC_CED_UPDATE) {
+		ret = drm_scdc_read_error_counters(connector, state->error_count);
+		if (ret)
+			return ret;
+	}
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
+	struct scdc_debugfs_priv *priv = m->private;
+	struct drm_scdc_state *st = &priv->state;
+	struct drm_connector *connector = priv->connector;
+	struct drm_scdc *scdc = &connector->display_info.hdmi.scdc;
+	int ret;
+
+	drm_connector_get(connector);
+
+	if (connector->status != connector_status_connected) {
+		ret = -ENODEV;
+		goto err_conn_put;
+	}
+
+	scdc_print_flag(m, "SCDC Supported", scdc->supported);
+	if (!scdc->supported) {
+		ret = 0;
+		goto err_conn_put;
+	}
+
+	scdc_print_flag(m, "Sink Read Request Capable", scdc->read_request);
+	scdc_print_flag(m, "Scrambling Supported", scdc->scrambling.supported);
+	scdc_print_flag(m, "Low Rate Scrambling Supported", scdc->scrambling.low_rates);
+
+	ret = drm_scdc_read_state(connector, st);
+	drm_connector_put(connector);
+	if (ret)
+		return ret;
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
+	return 0;
+
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
+	struct scdc_debugfs_priv *priv;
+
+	if (!root || !connector)
+		return;
+
+	priv = drmm_kzalloc(connector->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return;
+
+	priv->connector = connector;
+
+	debugfs_create_file("scdc_status", 0444, root, priv, &scdc_status_fops);
+}
+EXPORT_SYMBOL(drm_scdc_debugfs_init);
diff --git a/include/drm/display/drm_scdc_helper.h b/include/drm/display/drm_scdc_helper.h
index e9ccaeba56dd..3b3a4e0e48ba 100644
--- a/include/drm/display/drm_scdc_helper.h
+++ b/include/drm/display/drm_scdc_helper.h
@@ -30,6 +30,31 @@
 
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
+};
 
 int drm_scdc_read(struct i2c_adapter *adapter, u8 offset, void *buffer,
 		  size_t size);
@@ -77,4 +102,11 @@ bool drm_scdc_get_scrambling_status(struct drm_connector *connector);
 bool drm_scdc_set_scrambling(struct drm_connector *connector, bool enable);
 bool drm_scdc_set_high_tmds_clock_ratio(struct drm_connector *connector, bool set);
 
+int drm_scdc_read_status0_flags(struct drm_connector *connector,
+				struct drm_scdc_status_flags *flags);
+int drm_scdc_read_state(struct drm_connector *connector,
+			struct drm_scdc_state *state);
+int drm_scdc_read_error_counters(struct drm_connector *connector, u16 counter[3]);
+void drm_scdc_debugfs_init(struct drm_connector *connector, struct dentry *root);
+
 #endif

-- 
2.54.0

