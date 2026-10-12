Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB377CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6707410E446;
	Mon, 12 Oct 2026 04:14:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E05F710E400;
 Mon, 12 Oct 2026 04:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778466; x=1823314466;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+q1m4zYkD+Bq9XfknPGVNSMbdnoV/K8t+oTetkADwLg=;
 b=Njrhb458i0p53YukaM0PTXKA1MvFhtUJ6KtFxTTBUwCysV7AgI9O2na+
 N4ccTcx8KLv1PIEGwHjfdHwcCtBKbIa0+9lcEBu8U5il1fGS0rGqeAspk
 5mMwVk3VP6aJ8sI5mT0QO/3UoE963X3oMsbbVCAvpjf0XIU+50kMrNRJy
 gIttSBzJyKv2mpxKAfb8xRj3hMzRLOGF3prHFOWYI0T2hakeHuew6Kcyt
 iU1RcvWj9xQLq2eyQab09UEMHJx367Fcv9lfk/bREyBIwKCWfE0YsgPHj
 BjDiUO6mHGweV7r0/7lsAPlyTT86T3HZA6XzbwGdCS+l0hmK1GMcHU1gQ w==;
X-CSE-ConnectionGUID: dG52xs6QQnGvAL6XC8pgYQ==
X-CSE-MsgGUID: RdK2DykpQNGZRagSRVvt5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380821"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380821"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:25 -0700
X-CSE-ConnectionGUID: 9AWyvHjQRwq6IFHid3Ngqw==
X-CSE-MsgGUID: VssDYuuRSG2OKsVHk9reWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256340"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:24 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 05/56] drm/i915/display: Add registers for HDMI FRL
 configuration
Date: Mon, 12 Oct 2026 09:27:14 +0530
Message-ID: <20261012035806.3361439-6-ankit.k.nautiyal@intel.com>
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

Add registers for HDMI FRL configuration and link training.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 .../gpu/drm/i915/display/intel_display_regs.h | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_regs.h b/drivers/gpu/drm/i915/display/intel_display_regs.h
index 8251ec15190b..1abd221f966b 100644
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

