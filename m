Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AC5C5AC9F
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C39B210F352;
	Fri,  7 Aug 2026 04:31:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JyVtaokW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D1BC10F352;
 Fri,  7 Aug 2026 04:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077098; x=1817613098;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dEkqBqa56+hJU446tqUOM5EB+XIlTrZ5oTiqagn3alY=;
 b=JyVtaokWvozRiEoCVKYh3AfUVhsTcU308kdmtwlOwUlyzc91j9ic/Znx
 IKPduI2M93NlhTw/kRf15G52EdLzeySlTBohuarOuYMX8S7nRWyaut40k
 RAQn6H36d9iw3J94u/B70OBK2WR7oRdjh7r0AxDszpU9eoWBXbf3YscKR
 uJWa04xc28gGrDCdFupAsrHlPb1m+yWczA+5m2JaTQRVfrBeH+BV81RX6
 yJmAYnwpf0Qu6uJLSeagdDLh5sEpRfenwGAZc7PCKuwFJ1BMCilQUKx1R
 L0p/UL8l6tCydrKH48T6qNnxy9RVA1ajUbwZB9CtU7SwsKnTgRRApGjXV A==;
X-CSE-ConnectionGUID: I7T1hBdVSwe3R+0/qvfPlg==
X-CSE-MsgGUID: 4/+l7gTkQDSH7trtzyvi4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619241"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619241"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:38 -0700
X-CSE-ConnectionGUID: sJuc2pI2Qn6Nw+73urSqQw==
X-CSE-MsgGUID: p2Me0Lu9QIuJY0koLUunFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666063"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:34 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 04/44] drm/drm_scdc_helper: Add SCDC helper funcs for FRL
Date: Fri,  7 Aug 2026 09:43:49 +0530
Message-ID: <20260807041430.229038-5-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
References: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

FRL (Fixed Rate Link) uses a set of SCDC registers to configure and
monitor link training between the source and sink.

Add the register definitions and helper functions to read and
configure these SCDC registers for FRL link training.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/display/drm_scdc_helper.c | 212 ++++++++++++++++++++++
 include/drm/display/drm_scdc.h            |  26 +++
 include/drm/display/drm_scdc_helper.h     |  22 +++
 3 files changed, 260 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/drm/display/drm_scdc_helper.c
index df878aad4a36..8a074f674051 100644
--- a/drivers/gpu/drm/display/drm_scdc_helper.c
+++ b/drivers/gpu/drm/display/drm_scdc_helper.c
@@ -276,3 +276,215 @@ bool drm_scdc_set_high_tmds_clock_ratio(struct drm_connector *connector,
 	return true;
 }
 EXPORT_SYMBOL(drm_scdc_set_high_tmds_clock_ratio);
+
+/**
+ * drm_scdc_read_update_flags - read the SCDC update flags
+ * @adapter: I2C adapter for DDC channel
+ *
+ * Returns:
+ * 8bit SCDC update
+ */
+u8 drm_scdc_read_update_flags(struct i2c_adapter *adapter)
+{
+	u8 update = 0;
+	int ret;
+
+	ret = drm_scdc_readb(adapter, SCDC_UPDATE_0, &update);
+	if (ret < 0)
+		DRM_DEBUG_KMS("Failed to read scdc update: %d\n", ret);
+
+	return update;
+}
+EXPORT_SYMBOL(drm_scdc_read_update_flags);
+
+/**
+ * drm_scdc_clear_update_flags - Clears the given update flag bits by writing 1
+ * @adapter: I2C adapter for DDC channel
+ * @update_flags: update flag bits to be cleared
+ *
+ * Returns:
+ * 0 on success, negative error code otherwise.
+ */
+int drm_scdc_clear_update_flags(struct i2c_adapter *adapter, u8 update_flags)
+{
+	int ret;
+
+	/* Read Request Test is the only update flag the source cannot clear */
+	if (update_flags & SCDC_READ_REQUEST_TEST) {
+		DRM_DEBUG_KMS("SCDC Update flag/s 0x%x cannot be cleared\n",
+			      update_flags);
+		return -EINVAL;
+	}
+
+	ret = drm_scdc_writeb(adapter, SCDC_UPDATE_0, update_flags);
+	if (ret < 0) {
+		DRM_DEBUG_KMS("Failed to clear SCDC Update flag/s\n");
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_scdc_clear_update_flags);
+
+/**
+ * drm_scdc_read_status_flags - Read the status flags from offset 0x40
+ * @adapter: I2C adapter for DDC channel
+ *
+ * Returns:
+ * 8 bit value read from the offset 0x40
+ */
+u8 drm_scdc_read_status_flags(struct i2c_adapter *adapter)
+{
+	u8 update = 0;
+	int ret;
+
+	ret = drm_scdc_readb(adapter, SCDC_STATUS_FLAGS_0, &update);
+	if (ret < 0)
+		DRM_DEBUG_KMS("Failed to read scdc status flag: %d\n", ret);
+
+	return update;
+}
+EXPORT_SYMBOL(drm_scdc_read_status_flags);
+
+/**
+ * drm_scdc_config_frl - configure the sink for starting FRL training
+ * @adapter: I2C adapter for DDC channel
+ * @frl_rate: FRL rate per lane in Gbps (3, 6, 8, 10, 12, 16, 20 or 24).
+ * @num_lanes: no. of lanes required, can be either 3 or 4.
+ * @ffe_levels: max TxFFE level supported for the given FRL rate;
+ *              0-3 for rates up to 12 Gbps, 0-7 for 16/20/24 Gbps.
+ *              A prohibited value is clamped to 0 (per spec).
+ *
+ * Returns:
+ * 0 if the SCDC offsets for FRL training are successfully configured,
+ * negative error code otherwise.
+ */
+int drm_scdc_config_frl(struct i2c_adapter *adapter, int frl_rate,
+			int num_lanes, int ffe_levels)
+{
+	u8 write_buf = 0;
+	int ret;
+
+	if (num_lanes > 4 || num_lanes < 3) {
+		DRM_DEBUG_KMS("No. of lanes can be 3 or 4 only\n");
+		return -EINVAL;
+	}
+	if (ffe_levels > 7 || (frl_rate < 16 && ffe_levels > 3)) {
+		DRM_DEBUG_KMS("Prohibited Max FFE level %d, defaulting to Max FFE level 0\n",
+			      ffe_levels);
+		ffe_levels = 0;
+	}
+
+	switch (frl_rate) {
+	case 3:
+		write_buf |= (num_lanes == 3) ? SCDC_FRL_RATE_3GBPS_3LANES : 0;
+		break;
+	case 6:
+		write_buf |= (num_lanes == 3) ? SCDC_FRL_RATE_6GBPS_3LANES :
+			     SCDC_FRL_RATE_6GBPS_4LANES;
+		break;
+	case 8:
+		write_buf |= (num_lanes == 4) ? SCDC_FRL_RATE_8GBPS_4LANES : 0;
+		break;
+	case 10:
+		write_buf |= (num_lanes == 4) ? SCDC_FRL_RATE_10GBPS_4LANES : 0;
+		break;
+	case 12:
+		write_buf |= (num_lanes == 4) ? SCDC_FRL_RATE_12GBPS_4LANES : 0;
+		break;
+	case 16:
+		write_buf |= (num_lanes == 4) ? SCDC_FRL_RATE_16GBPS_4LANES : 0;
+		break;
+	case 20:
+		write_buf |= (num_lanes == 4) ? SCDC_FRL_RATE_20GBPS_4LANES : 0;
+		break;
+	case 24:
+		write_buf |= (num_lanes == 4) ? SCDC_FRL_RATE_24GBPS_4LANES : 0;
+		break;
+	default:
+		DRM_DEBUG_KMS("Invalid FRL rate =%dGbps\n", frl_rate);
+		return -EINVAL;
+	}
+
+	if (!write_buf) {
+		DRM_DEBUG_KMS("Invalid FRL rate and lane combination\n");
+		return -EINVAL;
+	}
+
+	write_buf |= (ffe_levels << SCDC_FFE_LEVELS_SHIFT);
+
+	ret = drm_scdc_writeb(adapter, SCDC_CONFIG_1, write_buf);
+	if (ret < 0) {
+		DRM_DEBUG_KMS("Failed to write SCDC config: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_scdc_config_frl);
+
+/**
+ * drm_scdc_disable_frl - Clear FRL Rate indicating TMDS
+ * @adapter: I2C adapter for DDC channel
+ *
+ * Returns:
+ * 0 if the FRL Rate is successfully reset, negative error code otherwise.
+ */
+int drm_scdc_disable_frl(struct i2c_adapter *adapter)
+{
+	u8 buf = 0;
+	int ret;
+
+	ret = drm_scdc_readb(adapter, SCDC_CONFIG_1, &buf);
+	if (ret < 0) {
+		DRM_DEBUG_KMS("Failed to read SCDC_CONFIG_1\n");
+		return ret;
+	}
+
+	buf &= ~SCDC_FRL_RATE_MASK;
+
+	ret = drm_scdc_writeb(adapter, SCDC_CONFIG_1, buf);
+	if (ret < 0) {
+		DRM_DEBUG_KMS("Failed to reset FRL rate\n");
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_scdc_disable_frl);
+
+/**
+ * drm_scdc_get_ltp - get the Link training patterns for the 4 lanes
+ * @adapter: I2C adapter for DDC channel
+ * @ltp: pointer array for reading Link training patterns for the 4 lanes.
+ *
+ * Returns:
+ * 0 on success also filling ltp out argument, negative error code otherwise.
+ */
+int drm_scdc_get_ltp(struct i2c_adapter *adapter,
+		     enum drm_scdc_frl_ltp ltp[4])
+{
+	u8 buf;
+	int ret;
+
+	ret = drm_scdc_readb(adapter, SCDC_STATUS_FLAGS_1, &buf);
+	if (ret < 0) {
+		DRM_DEBUG_KMS("failed to read link training pattern for lanes 0/1 ret = %d\n", ret);
+		return ret;
+	}
+
+	ltp[0] = buf & SCDC_LN_0_2_LTP_MASK;
+	ltp[1] = (buf & SCDC_LN_1_3_LTP_MASK) >> 4;
+
+	ret = drm_scdc_readb(adapter, SCDC_STATUS_FLAGS_2, &buf);
+	if (ret < 0) {
+		DRM_DEBUG_KMS("failed to read link training pattern for lanes 2/3 ret = %d\n", ret);
+		return ret;
+	}
+
+	ltp[2] = buf & SCDC_LN_0_2_LTP_MASK;
+	ltp[3] = (buf & SCDC_LN_1_3_LTP_MASK) >> 4;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_scdc_get_ltp);
diff --git a/include/drm/display/drm_scdc.h b/include/drm/display/drm_scdc.h
index 3d58f37e8ed8..7f8845ff6e72 100644
--- a/include/drm/display/drm_scdc.h
+++ b/include/drm/display/drm_scdc.h
@@ -29,6 +29,11 @@
 #define SCDC_SOURCE_VERSION 0x02
 
 #define SCDC_UPDATE_0 0x10
+#define  SCDC_LIP_UPDATE (1 << 7)
+#define  SCDC_RSED_UPDATE (1 << 6)
+#define  SCDC_FLT_UPDATE (1 << 5)
+#define  SCDC_FRL_START (1 << 4)
+#define  SCDC_SOURCE_TEST_UPDATE (1 << 3)
 #define  SCDC_READ_REQUEST_TEST (1 << 2)
 #define  SCDC_CED_UPDATE (1 << 1)
 #define  SCDC_STATUS_UPDATE (1 << 0)
@@ -46,7 +51,24 @@
 #define SCDC_CONFIG_0 0x30
 #define  SCDC_READ_REQUEST_ENABLE (1 << 0)
 
+#define SCDC_CONFIG_1 0x31
+#define  SCDC_FRL_RATE_MASK		0xF
+#define  SCDC_FRL_DISABLE		0
+#define  SCDC_FRL_RATE_3GBPS_3LANES	1
+#define  SCDC_FRL_RATE_6GBPS_3LANES	2
+#define  SCDC_FRL_RATE_6GBPS_4LANES	3
+#define  SCDC_FRL_RATE_8GBPS_4LANES	4
+#define  SCDC_FRL_RATE_10GBPS_4LANES	5
+#define  SCDC_FRL_RATE_12GBPS_4LANES	6
+#define  SCDC_FRL_RATE_16GBPS_4LANES	7
+#define  SCDC_FRL_RATE_20GBPS_4LANES	8
+#define  SCDC_FRL_RATE_24GBPS_4LANES	9
+#define  SCDC_FFE_LEVELS_SHIFT		4
+
 #define SCDC_STATUS_FLAGS_0 0x40
+#define  SCDC_DSC_DECODE_FAIL (1 << 7)
+#define  SCDC_FLT_READY (1 << 6)
+#define  SCDC_LANE3_LOCKED (1 << 4)
 #define  SCDC_CH2_LOCK (1 << 3)
 #define  SCDC_CH1_LOCK (1 << 2)
 #define  SCDC_CH0_LOCK (1 << 1)
@@ -55,6 +77,10 @@
 
 #define SCDC_STATUS_FLAGS_1 0x41
 
+#define SCDC_STATUS_FLAGS_2 0x42
+#define  SCDC_LN_0_2_LTP_MASK 0xF
+#define  SCDC_LN_1_3_LTP_MASK (0xF << 4)
+
 #define SCDC_ERR_DET_0_L 0x50
 #define SCDC_ERR_DET_0_H 0x51
 #define SCDC_ERR_DET_1_L 0x52
diff --git a/include/drm/display/drm_scdc_helper.h b/include/drm/display/drm_scdc_helper.h
index 34600476a1b9..0075bfd2e19d 100644
--- a/include/drm/display/drm_scdc_helper.h
+++ b/include/drm/display/drm_scdc_helper.h
@@ -36,6 +36,20 @@ ssize_t drm_scdc_read(struct i2c_adapter *adapter, u8 offset, void *buffer,
 ssize_t drm_scdc_write(struct i2c_adapter *adapter, u8 offset,
 		       const void *buffer, size_t size);
 
+enum drm_scdc_frl_ltp {
+	SCDC_FRL_NO_LTP = 0,
+	SCDC_FRL_LTP1,
+	SCDC_FRL_LTP2,
+	SCDC_FRL_LTP3,
+	SCDC_FRL_LTP4,
+	SCDC_FRL_LTP5,
+	SCDC_FRL_LTP6,
+	SCDC_FRL_LTP7,
+	SCDC_FRL_LTP8,
+	SCDC_FRL_CHNG_FFE = 0xE,
+	SCDC_FRL_CHNG_RATE = 0xF,
+};
+
 /**
  * drm_scdc_readb - read a single byte from SCDC
  * @adapter: I2C adapter
@@ -76,5 +90,13 @@ bool drm_scdc_get_scrambling_status(struct drm_connector *connector);
 
 bool drm_scdc_set_scrambling(struct drm_connector *connector, bool enable);
 bool drm_scdc_set_high_tmds_clock_ratio(struct drm_connector *connector, bool set);
+u8 drm_scdc_read_update_flags(struct i2c_adapter *adapter);
+int drm_scdc_clear_update_flags(struct i2c_adapter *adapter, u8 update_flags);
+u8 drm_scdc_read_status_flags(struct i2c_adapter *adapter);
+int drm_scdc_config_frl(struct i2c_adapter *adapter, int frl_rate,
+			int num_lanes, int ffe_levels);
+int drm_scdc_disable_frl(struct i2c_adapter *adapter);
+int drm_scdc_get_ltp(struct i2c_adapter *adapter,
+		     enum drm_scdc_frl_ltp ltp[4]);
 
 #endif
-- 
2.50.1

