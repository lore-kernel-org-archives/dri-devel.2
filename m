Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585E2F99C63
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 21:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD72C10EAAD;
	Fri, 17 Apr 2026 21:21:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="G2WiY7bj";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67DE810EAAA;
 Fri, 17 Apr 2026 21:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776460906; x=1807996906;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NbQ6WR+oGMWv16zpBRdIVtEzLrs6ykwNXTAZSCGP1IM=;
 b=G2WiY7bjfBRkDIMR4uWZ/Cn39GqQDtV6KqIx+k4SxaagYd5n7sy3+Nc7
 bol2CwoEuoLs75lB7nwvfnSd0c7GWC7b2spKaVHD4rIYnW8UcUj1l7s79
 qHtcS1TCH5wHXjntzFc9ABQqfaGbQQFVW6SHIZ3QRExDwmJyKFaAu1R2M
 IHRrLgMlwP1j/mJXDiigrA43SnZQXW7lTaqVuvLgZRhnQvI7Jd6xmf1oq
 WSw2ccEg4d87161KQ0jxDCsi6wROHWJumLwSRXAewBi1++2MkwYgA82uq
 aVG/8pFO5YKM0yQeQQpDtA8UuWF029id7JN0InNptfh1gsw2NRCv+wVTT w==;
X-CSE-ConnectionGUID: vmO+FeLGT/6JuR6iitM1Gg==
X-CSE-MsgGUID: muyliI0WS5+u8fxp+2KKww==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="95046182"
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; d="scan'208";a="95046182"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 14:21:46 -0700
X-CSE-ConnectionGUID: +DKyFXsBTpGpFbfXCNySPw==
X-CSE-MsgGUID: Ex+vtyDiQ4W/lnOCFnwciA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; d="scan'208";a="235503860"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa004.jf.intel.com with ESMTP; 17 Apr 2026 14:21:40 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: simona.vetter@ffwll.ch, airlied@gmail.com, kuba@kernel.org,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, maarten@lankhorst.se,
 zachary.mckevitt@oss.qualcomm.com, rodrigo.vivi@intel.com,
 riana.tauro@intel.com, michal.wajdeczko@intel.com,
 matthew.d.roper@intel.com, umesh.nerlige.ramappa@intel.com,
 mallesh.koujalagi@intel.com, soham.purkait@intel.com,
 anoop.c.vijay@intel.com, aravind.iddamsetty@linux.intel.com,
 Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 07/11] drm/xe/ras: Introduce correctable error handling
Date: Sat, 18 Apr 2026 02:46:42 +0530
Message-ID: <20260417211730.837345-8-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417211730.837345-1-raag.jadav@intel.com>
References: <20260417211730.837345-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Add initial support for correctable error handling which is serviced
using system controller event. Currently we only log the errors in
dmesg but this serves as a foundation for RAS infrastructure and will
be further extended to facilitate other RAS features.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
---
 drivers/gpu/drm/xe/Makefile           |  1 +
 drivers/gpu/drm/xe/xe_ras.c           | 92 +++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_ras.h           | 15 +++++
 drivers/gpu/drm/xe/xe_ras_types.h     | 73 +++++++++++++++++++++
 drivers/gpu/drm/xe/xe_sysctrl_event.c |  3 +-
 5 files changed, 183 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/xe/xe_ras.c
 create mode 100644 drivers/gpu/drm/xe/xe_ras.h
 create mode 100644 drivers/gpu/drm/xe/xe_ras_types.h

diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index 1c863b711ae9..22f17bd1082d 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -114,6 +114,7 @@ xe-y += xe_bb.o \
 	xe_pxp_submit.o \
 	xe_query.o \
 	xe_range_fence.o \
+	xe_ras.o \
 	xe_reg_sr.o \
 	xe_reg_whitelist.o \
 	xe_ring_ops.o \
diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
new file mode 100644
index 000000000000..08e91348c459
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+#include "xe_printk.h"
+#include "xe_ras.h"
+#include "xe_ras_types.h"
+#include "xe_sysctrl.h"
+#include "xe_sysctrl_event_types.h"
+
+/* Severity of detected errors  */
+enum xe_ras_severity {
+	XE_RAS_SEV_NOT_SUPPORTED = 0,
+	XE_RAS_SEV_CORRECTABLE,
+	XE_RAS_SEV_UNCORRECTABLE,
+	XE_RAS_SEV_INFORMATIONAL,
+	XE_RAS_SEV_MAX
+};
+
+/* Major IP blocks/components where errors can originate */
+enum xe_ras_component {
+	XE_RAS_COMP_NOT_SUPPORTED = 0,
+	XE_RAS_COMP_DEVICE_MEMORY,
+	XE_RAS_COMP_CORE_COMPUTE,
+	XE_RAS_COMP_RESERVED,
+	XE_RAS_COMP_PCIE,
+	XE_RAS_COMP_FABRIC,
+	XE_RAS_COMP_SOC_INTERNAL,
+	XE_RAS_COMP_MAX
+};
+
+static const char *const xe_ras_severities[] = {
+	[XE_RAS_SEV_NOT_SUPPORTED]		= "Not Supported",
+	[XE_RAS_SEV_CORRECTABLE]		= "Correctable Error",
+	[XE_RAS_SEV_UNCORRECTABLE]		= "Uncorrectable Error",
+	[XE_RAS_SEV_INFORMATIONAL]		= "Informational Error",
+};
+static_assert(ARRAY_SIZE(xe_ras_severities) == XE_RAS_SEV_MAX);
+
+static const char *const xe_ras_components[] = {
+	[XE_RAS_COMP_NOT_SUPPORTED]		= "Not Supported",
+	[XE_RAS_COMP_DEVICE_MEMORY]		= "Device Memory",
+	[XE_RAS_COMP_CORE_COMPUTE]		= "Core Compute",
+	[XE_RAS_COMP_RESERVED]			= "Reserved",
+	[XE_RAS_COMP_PCIE]			= "PCIe",
+	[XE_RAS_COMP_FABRIC]			= "Fabric",
+	[XE_RAS_COMP_SOC_INTERNAL]		= "SoC Internal",
+};
+static_assert(ARRAY_SIZE(xe_ras_components) == XE_RAS_COMP_MAX);
+
+static inline const char *sev_to_str(u8 sev)
+{
+	if (sev >= XE_RAS_SEV_MAX)
+		sev = XE_RAS_SEV_NOT_SUPPORTED;
+
+	return xe_ras_severities[sev];
+}
+
+static inline const char *comp_to_str(u8 comp)
+{
+	if (comp >= XE_RAS_COMP_MAX)
+		comp = XE_RAS_COMP_NOT_SUPPORTED;
+
+	return xe_ras_components[comp];
+}
+
+void xe_ras_counter_threshold_crossed(struct xe_device *xe,
+				      struct xe_sysctrl_event_response *response)
+{
+	struct xe_ras_threshold_crossed *pending = (void *)&response->data;
+	struct xe_ras_error_class *errors = pending->counters;
+	u32 counter_id, ncounters = pending->ncounters;
+
+	if (!ncounters || ncounters > XE_RAS_NUM_COUNTERS) {
+		xe_err(xe, "sysctrl: unexpected counter threshold crossed %u\n", ncounters);
+		return;
+	}
+
+	BUILD_BUG_ON(sizeof(response->data) < sizeof(*pending));
+	xe_warn(xe, "[RAS]: counter threshold crossed, %u new errors\n", ncounters);
+
+	for (counter_id = 0; counter_id < ncounters; counter_id++) {
+		u8 severity, component;
+
+		severity = errors[counter_id].common.severity;
+		component = errors[counter_id].common.component;
+
+		xe_warn(xe, "[RAS]: %s %s detected\n",
+			comp_to_str(component), sev_to_str(severity));
+	}
+}
diff --git a/drivers/gpu/drm/xe/xe_ras.h b/drivers/gpu/drm/xe/xe_ras.h
new file mode 100644
index 000000000000..ea90593b62dc
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_ras.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+#ifndef _XE_RAS_H_
+#define _XE_RAS_H_
+
+struct xe_device;
+struct xe_sysctrl_event_response;
+
+void xe_ras_counter_threshold_crossed(struct xe_device *xe,
+				      struct xe_sysctrl_event_response *response);
+
+#endif
diff --git a/drivers/gpu/drm/xe/xe_ras_types.h b/drivers/gpu/drm/xe/xe_ras_types.h
new file mode 100644
index 000000000000..4e63c67f806a
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_ras_types.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+#ifndef _XE_RAS_TYPES_H_
+#define _XE_RAS_TYPES_H_
+
+#include <linux/types.h>
+
+#define XE_RAS_NUM_COUNTERS			16
+
+/**
+ * struct xe_ras_error_common - Error fields that are common across all products
+ */
+struct xe_ras_error_common {
+	/** @severity: Error severity */
+	u8 severity;
+	/** @component: IP block where error originated */
+	u8 component;
+} __packed;
+
+/**
+ * struct xe_ras_error_unit - Error unit information
+ */
+struct xe_ras_error_unit {
+	/** @tile: Tile identifier */
+	u8 tile;
+	/** @instance: Instance identifier specific to IP */
+	u32 instance;
+} __packed;
+
+/**
+ * struct xe_ras_error_cause - Error cause information
+ */
+struct xe_ras_error_cause {
+	/** @cause: Cause/checker */
+	u32 cause;
+	/** @reserved: For future use */
+	u8 reserved;
+} __packed;
+
+/**
+ * struct xe_ras_error_product - Error fields that are specific to the product
+ */
+struct xe_ras_error_product {
+	/** @unit: Unit within IP block */
+	struct xe_ras_error_unit unit;
+	/** @cause: Cause/checker */
+	struct xe_ras_error_cause cause;
+} __packed;
+
+/**
+ * struct xe_ras_error_class - Combines common and product-specific parts
+ */
+struct xe_ras_error_class {
+	/** @common: Common error type and component */
+	struct xe_ras_error_common common;
+	/** @product: Product-specific unit and cause */
+	struct xe_ras_error_product product;
+} __packed;
+
+/**
+ * struct xe_ras_threshold_crossed - Data for threshold crossed event
+ */
+struct xe_ras_threshold_crossed {
+	/** @ncounters: Number of error counters that crossed thresholds */
+	u32 ncounters;
+	/** @counters: Array of error counters that crossed threshold */
+	struct xe_ras_error_class counters[XE_RAS_NUM_COUNTERS];
+} __packed;
+
+#endif
diff --git a/drivers/gpu/drm/xe/xe_sysctrl_event.c b/drivers/gpu/drm/xe/xe_sysctrl_event.c
index 74163e0bafe2..e96af8be07a2 100644
--- a/drivers/gpu/drm/xe/xe_sysctrl_event.c
+++ b/drivers/gpu/drm/xe/xe_sysctrl_event.c
@@ -6,6 +6,7 @@
 #include "xe_device.h"
 #include "xe_irq.h"
 #include "xe_printk.h"
+#include "xe_ras.h"
 #include "xe_sysctrl.h"
 #include "xe_sysctrl_event_types.h"
 #include "xe_sysctrl_mailbox.h"
@@ -35,7 +36,7 @@ static void get_pending_event(struct xe_sysctrl *sc, struct xe_sysctrl_mailbox_c
 		}
 
 		if (response->event == XE_SYSCTRL_EVENT_THRESHOLD_CROSSED)
-			xe_warn(xe, "[RAS]: counter threshold crossed\n");
+			xe_ras_counter_threshold_crossed(xe, response);
 		else
 			xe_err(xe, "sysctrl: unexpected event %#x\n", response->event);
 
-- 
2.43.0

