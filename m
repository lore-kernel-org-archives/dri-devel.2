Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A185FC5ACAC
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:31:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BDC410F363;
	Fri,  7 Aug 2026 04:31:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="T8Bc2nDC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B68010F35C;
 Fri,  7 Aug 2026 04:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077100; x=1817613100;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LE8ZZ4kVuXHZbU3WnOHoYKBeWkI4lyO7sU6lQz2Ot0U=;
 b=T8Bc2nDCBOfm5UvPqcR4S6BLL1QTJQCl8ntL1c7b8yzadQ/7JGO5WjtR
 zDaIDb9cDgXRGNCTsdvlIsoWCMhJDMBgi6nvn3J0SFOBRQ24687KxM9YJ
 JmblRleXIN2mOKUxiAmbwMzfbkCA3I2YFYrFMs0P5uauBERjA1EJCFWvh
 gqRpSHJGziWip/WogtVLq6tP76XZ1j0aS4qQlpdZPSZO/+5Y7ZPl4P6O9
 UDXTPoFUnl7ROfi1ZszFsuISF3C0dOUFznl5WBif8MKrUQW3HGD1OCFce
 zF/zV0kWs4xAf8Y9b+gDg9cOfG2HrNVey7QeMaIvnQToL21xe3jdwDw5a A==;
X-CSE-ConnectionGUID: 2JmUTvp3T8ONvtYjhepT5A==
X-CSE-MsgGUID: yY9tg691RY6ER7D+BXvaSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619243"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619243"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:40 -0700
X-CSE-ConnectionGUID: ZWKXqdfbSR2BO2KasDTh2A==
X-CSE-MsgGUID: 0Awfutz6TDWnt4cdgwMC7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666079"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:37 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 05/44] drm/i915/display: Add registers for HDMI FRL
 configuration
Date: Fri,  7 Aug 2026 09:43:50 +0530
Message-ID: <20260807041430.229038-6-ankit.k.nautiyal@intel.com>
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

Add registers for HDMI FRL configuration and link training.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 .../gpu/drm/i915/display/intel_display_regs.h | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_regs.h b/drivers/gpu/drm/i915/display/intel_display_regs.h
index 0f5018482497..d05827dd1236 100644
--- a/drivers/gpu/drm/i915/display/intel_display_regs.h
+++ b/drivers/gpu/drm/i915/display/intel_display_regs.h
@@ -550,6 +550,32 @@
 #define _TRANS_MULT_B		0x6102c
 #define TRANS_MULT(dev_priv, trans)	_MMIO_TRANS2(dev_priv, (trans), _TRANS_MULT_A)
 
+/* HDMI FRL Configuration */
+#define _TRANS_HDMI_FRL_CFG_A				0x600b0
+#define TRANS_HDMI_FRL_CFG(dev_priv, trans)		_MMIO_TRANS2(dev_priv, \
+								     (trans), \
+								     _TRANS_HDMI_FRL_CFG_A)
+#define  TRANS_HDMI_FRL_ENABLE				REG_BIT(31)
+#define  TRANS_HDMI_TMDS_ENABLE				0
+#define  TRANS_HDMI_FRL_TRAINING_COMPLETE		REG_BIT(28)
+#define  TRANS_HDMI_DISABLE_DFM_MASKING			REG_BIT(20)
+#define  TRANS_HDMI_R_B_SCHED_ENABLE_MASK		REG_BIT(19)
+#define  TRANS_HDMI_R_B_SCHED_ENABLE(val)		REG_FIELD_PREP(TRANS_HDMI_R_B_SCHED_ENABLE_MASK, val)
+#define  TRANS_HDMI_ACTIVE_CHAR_BUF_THRESH_MASK		REG_GENMASK(18, 16)
+#define  TRANS_HDMI_ACTIVE_CHAR_BUF_THRESH(val)		REG_FIELD_PREP(TRANS_HDMI_ACTIVE_CHAR_BUF_THRESH_MASK, val)
+#define  TRANS_HDMI_MIN_BLANK_CHAR_MASK			REG_GENMASK(15, 12)
+#define  TRANS_HDMI_MIN_BLANK_CHAR(val)			REG_FIELD_PREP(TRANS_HDMI_MIN_BLANK_CHAR_MASK, val)
+#define  TRANS_HDMI_MIN_BLANK_CHAR_VAL			0xa
+#define  TRANS_HDMI_FRL_PKT_PAYLOAD_MAX_MASK		REG_GENMASK(9, 0)
+#define  TRANS_HDMI_FRL_PKT_PAYLOAD_MAX(val)		REG_FIELD_PREP(TRANS_HDMI_FRL_PKT_PAYLOAD_MAX_MASK, val)
+#define  TRANS_HDMI_PAYLOAD_UPPER_BOUND			0x3fe
+
+#define _TRANS_HDMI_FRL_TRAIN_A				0x600b4
+#define TRANS_HDMI_FRL_TRAIN(dev_priv, trans)		_MMIO_TRANS2(dev_priv, \
+								     (trans), \
+								     _TRANS_HDMI_FRL_TRAIN_A)
+#define  TRANS_HDMI_FRL_LTP(pattern, lane) ((pattern) << (lane) * 8)
+
 /* Hotplug control (945+ only) */
 #define PORT_HOTPLUG_EN(dev_priv)		_MMIO(DISPLAY_MMIO_BASE(dev_priv) + 0x61110)
 #define   PORTB_HOTPLUG_INT_EN			(1 << 29)
-- 
2.50.1

