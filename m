Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029FDCA9EDA
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCA1410E4C2;
	Mon, 12 Oct 2026 04:15:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27BED10E486;
 Mon, 12 Oct 2026 04:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778522; x=1823314522;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w065VMrjy391/TRCuqGOI/huMLewLyvhh6aRajdaMGw=;
 b=XxDnr/0YEq8KbGIvTneb+c6t2wykcZqq9dob/iq3Go228CZfLx6+rTck
 8rL3QW8PJi0DJrEO/PWE572pEC+sADuK45Jf2UhUR0gXB+I5Eja5xgWSB
 0uUklIp0rBD8HqyLYJlaILkv2v+7hwu/N0auKVJOPQFI+EfRSFHsqCe2r
 4+dfSIwliP+gBu7R/Z6/lSZ+DN1xatl3v5y1uwzjh2cnPZtMrSdzfqFGl
 Y6aMYHYvY7kfy6ZVnWrRARt1Uk0cEmYzeL1BtY86gjj7PV5pl2lpD8pKp
 vTtTdYIdWbmADncysacJyxCqh9bzfPX1To7dMFFC4dE47SebFePS+0oJv Q==;
X-CSE-ConnectionGUID: CKHt3cYuRGSZ7kkXoS3aHQ==
X-CSE-MsgGUID: RQpcsJfVSGWHis6AwgWRYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380907"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380907"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:15 -0700
X-CSE-ConnectionGUID: YDZR9GAKT8uLqJhmp7EZ6A==
X-CSE-MsgGUID: XKhOgDZSSleHgSu46N76tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256517"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:14 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 27/56] drm/i915/hdmi_frl_dfm_regs: Define DFM registers
Date: Mon, 12 Oct 2026 09:27:36 +0530
Message-ID: <20261012035806.3361439-28-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
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

