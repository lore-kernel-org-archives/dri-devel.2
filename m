Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F17CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C83F210E40F;
	Mon, 12 Oct 2026 04:14:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9915B10E102;
 Mon, 12 Oct 2026 04:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778463; x=1823314463;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dzkUlA3J6BDfXX9HfiMZlNbHMtIVoAmYcXmgoircsgU=;
 b=U0nfXXlt7FBn/gXkGjAU6t8AZWqo3NvIoqPVU18B1dDKpjMF7qz/EYk6
 uguS5eZuaMpZ8f7J8Z8vvEUjJwb0XAm8rZzmDaUPBR0wRbt0p2zoHsn0o
 oUIgDiFEDTRQyry2gT87gczGWFGMYdWa1Jj8i26QL9R8wgArLXTbDHrzS
 MNU/75zAOnxU/JP8c2QBsH/JAsZCwlkMxhc4XjubyRuoj8kPh93Oj9JMS
 UmQgiwe7dVUPBCFLPitUQBW8gfJCMH1WLQJNceDOlStMeU6NZGQJnXK/F
 ohFVXjar22rmZW56ShmohdJrGhX+uwno0ZgAAkIg8nSi4Nf3jY7nz7qbe Q==;
X-CSE-ConnectionGUID: yG6YmxVGQFC7UhDmyXX5Mg==
X-CSE-MsgGUID: HkQs/SyUTLCKcOEwF3QjCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380816"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380816"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:23 -0700
X-CSE-ConnectionGUID: hyMtFLbYQQu2SEVFAhIkMA==
X-CSE-MsgGUID: 66FsQZ7KQA+XPFPjv+ofGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256331"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:22 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 04/56] drm/drm_scdc_helper: Add SCDC helper funcs for FRL
Date: Mon, 12 Oct 2026 09:27:13 +0530
Message-ID: <20261012035806.3361439-5-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
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
 drivers/gpu/drm/display/drm_scdc_helper.c | 109 ++++++++++++++++++++++
 include/drm/display/drm_scdc.h            |   3 +
 include/drm/display/drm_scdc_helper.h     |  23 +++++
 3 files changed, 135 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/drm/display/drm_scdc_helper.c
index 74388481fc55..968a6587585f 100644
--- a/drivers/gpu/drm/display/drm_scdc_helper.c
+++ b/drivers/gpu/drm/display/drm_scdc_helper.c
@@ -350,6 +350,115 @@ int drm_scdc_set_source_version(struct drm_connector *connector, u8 ver)
 }
 EXPORT_SYMBOL(drm_scdc_set_source_version);
 
+int drm_scdc_read_update_flags(struct i2c_adapter *adapter, u8 *update_flags)
+{
+	return drm_scdc_readb(adapter, SCDC_UPDATE_0, update_flags);
+}
+EXPORT_SYMBOL(drm_scdc_read_update_flags);
+
+int drm_scdc_clear_update_flags(struct i2c_adapter *adapter, u8 update_flags)
+{
+	if (update_flags & SCDC_READ_REQUEST_TEST)
+		return -EINVAL;
+
+	return drm_scdc_writeb(adapter, SCDC_UPDATE_0, update_flags);
+}
+EXPORT_SYMBOL(drm_scdc_clear_update_flags);
+
+int drm_scdc_read_status_flags(struct i2c_adapter *adapter, u8 *status_flags)
+{
+	return drm_scdc_readb(adapter, SCDC_STATUS_FLAGS_0, status_flags);
+}
+EXPORT_SYMBOL(drm_scdc_read_status_flags);
+
+int drm_scdc_config_frl(struct i2c_adapter *adapter, int frl_rate,
+			int num_lanes, int ffe_levels)
+{
+	enum drm_scdc_frl_rate rate;
+	u8 config;
+
+	if (ffe_levels < 0 || ffe_levels > 3)
+		return -EINVAL;
+
+	switch (frl_rate) {
+	case 3:
+		if (num_lanes != 3)
+			return -EINVAL;
+		rate = SCDC_FRL_RATE_3X3;
+		break;
+	case 6:
+		if (num_lanes == 3)
+			rate = SCDC_FRL_RATE_6X3;
+		else if (num_lanes == 4)
+			rate = SCDC_FRL_RATE_6X4;
+		else
+			return -EINVAL;
+		break;
+	case 8:
+		if (num_lanes != 4)
+			return -EINVAL;
+		rate = SCDC_FRL_RATE_8X4;
+		break;
+	case 10:
+		if (num_lanes != 4)
+			return -EINVAL;
+		rate = SCDC_FRL_RATE_10X4;
+		break;
+	case 12:
+		if (num_lanes != 4)
+			return -EINVAL;
+		rate = SCDC_FRL_RATE_12X4;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	config = FIELD_PREP(SCDC_FRL_RATE, rate) |
+		 FIELD_PREP(SCDC_FFE_LEVELS, ffe_levels);
+
+	return drm_scdc_writeb(adapter, SCDC_CONFIG_1, config);
+}
+EXPORT_SYMBOL(drm_scdc_config_frl);
+
+int drm_scdc_disable_frl(struct i2c_adapter *adapter)
+{
+	u8 config;
+	int ret;
+
+	ret = drm_scdc_readb(adapter, SCDC_CONFIG_1, &config);
+	if (ret)
+		return ret;
+
+	config &= ~SCDC_FRL_RATE;
+
+	return drm_scdc_writeb(adapter, SCDC_CONFIG_1, config);
+}
+EXPORT_SYMBOL(drm_scdc_disable_frl);
+
+int drm_scdc_get_ltp(struct i2c_adapter *adapter,
+		     enum drm_scdc_frl_ltp ltp[4])
+{
+	u8 status_flags;
+	int ret;
+
+	ret = drm_scdc_readb(adapter, SCDC_STATUS_FLAGS_1, &status_flags);
+	if (ret)
+		return ret;
+
+	ltp[0] = FIELD_GET(SCDC_LN_EVEN_TRAIN_PTRN, status_flags);
+	ltp[1] = FIELD_GET(SCDC_LN_ODD_TRAIN_PTRN, status_flags);
+
+	ret = drm_scdc_readb(adapter, SCDC_STATUS_FLAGS_2, &status_flags);
+	if (ret)
+		return ret;
+
+	ltp[2] = FIELD_GET(SCDC_LN_EVEN_TRAIN_PTRN, status_flags);
+	ltp[3] = FIELD_GET(SCDC_LN_ODD_TRAIN_PTRN, status_flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_scdc_get_ltp);
+
 static void
 drm_scdc_parse_status0_flags(u8 val, struct drm_scdc_status_flags *flags)
 {
diff --git a/include/drm/display/drm_scdc.h b/include/drm/display/drm_scdc.h
index 7f0b05b2f280..694f10b81dd6 100644
--- a/include/drm/display/drm_scdc.h
+++ b/include/drm/display/drm_scdc.h
@@ -29,8 +29,11 @@
 #define SCDC_SOURCE_VERSION 0x02
 
 #define SCDC_UPDATE_0 0x10
+#define  SCDC_LIP_UPDATE (1 << 7)
 #define  SCDC_RSED_UPDATE (1 << 6)
 #define  SCDC_FLT_UPDATE (1 << 5)
+#define  SCDC_FRL_START (1 << 4)
+#define  SCDC_SOURCE_TEST_UPDATE (1 << 3)
 #define  SCDC_READ_REQUEST_TEST (1 << 2)
 #define  SCDC_CED_UPDATE (1 << 1)
 #define  SCDC_STATUS_UPDATE (1 << 0)
diff --git a/include/drm/display/drm_scdc_helper.h b/include/drm/display/drm_scdc_helper.h
index 6a8be1f16ce0..616afd0cf8b2 100644
--- a/include/drm/display/drm_scdc_helper.h
+++ b/include/drm/display/drm_scdc_helper.h
@@ -33,6 +33,20 @@ struct drm_connector;
 struct i2c_adapter;
 struct dentry;
 
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
 struct drm_scdc_status_flags {
 	/* Status Register 0 */
 	bool clock_detected;
@@ -174,4 +188,13 @@ int drm_scdc_read_state(struct drm_connector *connector,
 			struct drm_scdc_state *state);
 void drm_scdc_debugfs_init(struct drm_connector *connector, struct dentry *root);
 
+int drm_scdc_read_update_flags(struct i2c_adapter *adapter, u8 *update_flags);
+int drm_scdc_clear_update_flags(struct i2c_adapter *adapter, u8 update_flags);
+int drm_scdc_read_status_flags(struct i2c_adapter *adapter, u8 *status_flags);
+int drm_scdc_config_frl(struct i2c_adapter *adapter, int frl_rate,
+			int num_lanes, int ffe_levels);
+int drm_scdc_disable_frl(struct i2c_adapter *adapter);
+int drm_scdc_get_ltp(struct i2c_adapter *adapter,
+		     enum drm_scdc_frl_ltp ltp[4]);
+
 #endif
-- 
2.50.1

