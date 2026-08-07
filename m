Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4962C2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:32:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94C6410F3C2;
	Fri,  7 Aug 2026 04:32:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gzgEUrla";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66E4210F3BB;
 Fri,  7 Aug 2026 04:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077164; x=1817613164;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w065VMrjy391/TRCuqGOI/huMLewLyvhh6aRajdaMGw=;
 b=gzgEUrlaPbmfE0GmrKtyJQo758XgT1E/ztCg9//jIXnDvCUJWaOOvfPd
 Le8t88dsEXCGMGGFMqmql5WEHO2H1E5zLTdqnetFE4YTAhCgn/utdI/yl
 eZ6YpMPAEvbUqvrHqdNIPk76VvB1MIdXhTHsXldmQqUc5WV7mC2Z/I+08
 133NtYhi8cWo0WssSApLDiaAhK4v94sAysV+Sp3WGMJo7A9BGuo773J1c
 PdbVZvkuXsEzG8AX4bqkB3BXDhIxkNO4yIixGzZP2uzznqw5ltP75DgEL
 mqdcNk3VPXpASexPkBeH2Enehlk+eohFGhbVH6eKKlqzHtzJZQo04K2Xb Q==;
X-CSE-ConnectionGUID: DYFYstSZRfOxJiYhClBaNA==
X-CSE-MsgGUID: dbo4ahFcQqqiJBzEbMdtpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619359"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619359"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:44 -0700
X-CSE-ConnectionGUID: 3msrh3maRA+if1vaPh/4Pg==
X-CSE-MsgGUID: /uSWqYgbSPCj41mYljRLpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666474"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:41 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 30/44] drm/i915/hdmi_frl_dfm_regs: Define DFM registers
Date: Fri,  7 Aug 2026 09:44:15 +0530
Message-ID: <20260807041430.229038-31-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
References: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Vandita Kulkarni <vandita.kulkarni@intel.com>

Add defines for HDMI FRL dataflow metering registers
to take care of DFM values.

Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 .../i915/display/intel_hdmi_frl_dfm_regs.h    | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm_regs.h

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm_regs.h b/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm_regs.h
new file mode 100644
index 000000000000..bb5cb76b3806
--- /dev/null
+++ b/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm_regs.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2022 Intel Corporation
+ */
+
+#ifndef __INTEL_HDMI_FRL_DFM_REGS_H__
+#define __INTEL_HDMI_FRL_DFM_REGS_H__
+
+#include "intel_display_reg_defs.h"
+
+#define _TRANS_HDMI_FRL_DFMRDCTL_A			0x600bc
+#define TRANS_HDMI_FRL_DFMRDCTL(dev_priv, trans)	_MMIO_TRANS2(dev_priv, \
+								     trans, \
+								     _TRANS_HDMI_FRL_DFMRDCTL_A)
+#define   TB_DIFF_MAX_OFFSET_MASK			REG_GENMASK(8, 0)
+#define   TB_DIFF_MAX_OFFSET(val)			REG_FIELD_PREP(TB_DIFF_MAX_OFFSET_MASK, val)
+
+#define _TRANS_HDMI_FRL_DFMWRCTL_A			0x600c0
+#define TRANS_HDMI_FRL_DFMWRCTL(dev_priv, trans)	_MMIO_TRANS2(dev_priv, \
+								     trans, \
+								     _TRANS_HDMI_FRL_DFMWRCTL_A)
+#define  TB_ACTUAL_OFFSET_MASK				REG_GENMASK(8, 0)
+#define  TB_ACTUAL_OFFSET(val)				REG_FIELD_PREP(TB_ACTUAL_OFFSET_MASK, val)
+
+#define _TRANS_HDMI_FRL_DFMTHRSH_A			0x600c4
+#define TRANS_HDMI_FRL_DFMTHRSH(dev_priv, trans)	_MMIO_TRANS2(dev_priv, \
+								     trans, \
+								     _TRANS_HDMI_FRL_DFMTHRSH_A)
+#define  RUN_LEN_THRESHOLD_MASK				REG_GENMASK(31, 24)
+#define  RUN_LEN_THRESHOLD(val)				REG_FIELD_PREP(RUN_LEN_THRESHOLD_MASK, val)
+#define  TB_MAX_THRESHOLD_MASK				REG_GENMASK(21, 12)
+#define  TB_MAX_THRESHOLD(val)				REG_FIELD_PREP(TB_MAX_THRESHOLD_MASK, val)
+#define  TB_MIN_THESHOLD_MASK				REG_GENMASK(9, 0)
+#define  TB_MIN_THESHOLD(val)				REG_FIELD_PREP(TB_MIN_THESHOLD_MASK, val)
+
+#endif /* __INTEL_HDMI_FRL_DFM_REGS_H__ */
-- 
2.50.1

