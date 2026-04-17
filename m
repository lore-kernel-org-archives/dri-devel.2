Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAB8F99C6A
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 21:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52CCE10EAAE;
	Fri, 17 Apr 2026 21:22:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QKKD+d6g";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B86C10EAAF;
 Fri, 17 Apr 2026 21:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776460918; x=1807996918;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/3kSaMxamALPP59tiQydL6qyP3e8+FNL+x+6aj4Z2Ks=;
 b=QKKD+d6gLleJcl+C7HHnSf/lxWk0h3fPfs9duAoeRDjqo44AX6XNulQX
 1yxQwQ5cIFroeMmJSglJbOKz0gdha8XKHJVpqRMbPHLB6ru8k9nMOlvtg
 0ugwl/++Zt2FNbooKRgH++6QBCzIZX2Mmrr7cxbQd8/d/2XbCD5MI8Ugi
 PyGNbx2WowP0WRUkfxBvfp67RVmcbETXwYY0V2ciut0GW7iVQowW9HNg3
 I6ct5ZE0Qu6x0WzDO2vhpnrUqip2fcKHTWRIUsTNjQpaRbwHiTKDWevUc
 7NYEbnpCS/aTbTkI9yHlVdapmh5CQdu7YExe/NXy5jWSU9nwuTVSBylB4 Q==;
X-CSE-ConnectionGUID: 4rgPsgp4TKGnHVthpUft8A==
X-CSE-MsgGUID: ohVyY7/7RRaoDxu49oR5Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="95046208"
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; d="scan'208";a="95046208"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 14:21:58 -0700
X-CSE-ConnectionGUID: DgBZQ8TFTuKxRMkozXlxaQ==
X-CSE-MsgGUID: vT2cyOOqQgCK0Z18UZL37w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; d="scan'208";a="235503899"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa004.jf.intel.com with ESMTP; 17 Apr 2026 14:21:52 -0700
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
Subject: [PATCH v1 09/11] drm/xe/ras: Set error threshold support
Date: Sat, 18 Apr 2026 02:46:44 +0530
Message-ID: <20260417211730.837345-10-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417211730.837345-1-raag.jadav@intel.com>
References: <20260417211730.837345-1-raag.jadav@intel.com>
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

System controller allows programming per error threshold value, which
it uses to raise error events to the driver. Set it using mailbox
command so that it can be programmed by the user.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpu/drm/xe/xe_ras.c                   | 42 +++++++++++++++++++
 drivers/gpu/drm/xe/xe_ras.h                   |  1 +
 drivers/gpu/drm/xe/xe_ras_types.h             | 28 +++++++++++++
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |  2 +
 4 files changed, 73 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 3e93f838aa4a..26e063166c5f 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -163,3 +163,45 @@ int xe_ras_get_threshold(struct xe_device *xe, u32 severity, u32 component, u32
 	       comp_to_str(counter.common.component), sev_to_str(counter.common.severity));
 	return 0;
 }
+
+int xe_ras_set_threshold(struct xe_device *xe, u32 severity, u32 component, u32 threshold)
+{
+	struct xe_ras_set_threshold_response response = {};
+	struct xe_ras_set_threshold_request request = {};
+	struct xe_sysctrl_mailbox_command command = {};
+	struct xe_ras_error_class counter = {};
+	size_t len;
+	int ret;
+
+	counter.common.severity = drm_to_xe_ras_severities[severity];
+	counter.common.component = drm_to_xe_ras_components[component];
+	request.counter = counter;
+	request.threshold = threshold;
+
+	ras_command_prepare(&command, &request, sizeof(request), &response,
+			    sizeof(response), XE_SYSCTRL_CMD_SET_THRESHOLD);
+
+	guard(xe_pm_runtime)(xe);
+	ret = xe_sysctrl_send_command(&xe->sc, &command, &len);
+	if (ret) {
+		xe_err(xe, "sysctrl: failed to set threshold %d\n", ret);
+		return ret;
+	}
+
+	if (len != sizeof(response)) {
+		xe_err(xe, "sysctrl: unexpected set threshold response length %zu (expected %zu)\n",
+		       len, sizeof(response));
+		return -EIO;
+	}
+
+	if (response.status) {
+		xe_err(xe, "sysctrl: set threshold operation failed %#x\n", response.status);
+		return -EIO;
+	}
+
+	counter = response.counter;
+
+	xe_dbg(xe, "[RAS]: Set threshold %u for %s %s\n", response.threshold,
+	       comp_to_str(counter.common.component), sev_to_str(counter.common.severity));
+	return 0;
+}
diff --git a/drivers/gpu/drm/xe/xe_ras.h b/drivers/gpu/drm/xe/xe_ras.h
index 982bbe61461e..d1f71b1de723 100644
--- a/drivers/gpu/drm/xe/xe_ras.h
+++ b/drivers/gpu/drm/xe/xe_ras.h
@@ -14,5 +14,6 @@ struct xe_sysctrl_event_response;
 void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 				      struct xe_sysctrl_event_response *response);
 int xe_ras_get_threshold(struct xe_device *xe, u32 severity, u32 component, u32 *threshold);
+int xe_ras_set_threshold(struct xe_device *xe, u32 severity, u32 component, u32 threshold);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_ras_types.h b/drivers/gpu/drm/xe/xe_ras_types.h
index d5da93d65cf5..d7e4a02a661d 100644
--- a/drivers/gpu/drm/xe/xe_ras_types.h
+++ b/drivers/gpu/drm/xe/xe_ras_types.h
@@ -92,4 +92,32 @@ struct xe_ras_get_threshold_response {
 	u32 reserved[4];
 } __packed;
 
+/**
+ * struct xe_ras_set_threshold_request - Request structure for set threshold
+ */
+struct xe_ras_set_threshold_request {
+	/** @counter: Counter to set threshold for */
+	struct xe_ras_error_class counter;
+	/** @threshold: Threshold value to set */
+	u32 threshold;
+	/** @reserved: Reserved for future use */
+	u32 reserved;
+} __packed;
+
+/**
+ * struct xe_ras_set_threshold_response - Response structure for set threshold
+ */
+struct xe_ras_set_threshold_response {
+	/** @counter: Counter id */
+	struct xe_ras_error_class counter;
+	/** @threshold_old: Old threshold value */
+	u32 threshold_old;
+	/** @threshold: New threshold value */
+	u32 threshold;
+	/** @status: Set threshold operation status */
+	u32 status;
+	/** @reserved: Reserved for future use */
+	u32 reserved[2];
+} __packed;
+
 #endif
diff --git a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
index a1b71218deca..b865768e903b 100644
--- a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
+++ b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
@@ -23,10 +23,12 @@ enum xe_sysctrl_group {
  * enum xe_sysctrl_gfsp_cmd - Commands supported by GFSP group
  *
  * @XE_SYSCTRL_CMD_GET_THRESHOLD: Retrieve error threshold
+ * @XE_SYSCTRL_CMD_SET_THRESHOLD: Set error threshold
  * @XE_SYSCTRL_CMD_GET_PENDING_EVENT: Retrieve pending event
  */
 enum xe_sysctrl_gfsp_cmd {
 	XE_SYSCTRL_CMD_GET_THRESHOLD		= 0x05,
+	XE_SYSCTRL_CMD_SET_THRESHOLD		= 0x06,
 	XE_SYSCTRL_CMD_GET_PENDING_EVENT	= 0x07,
 };
 
-- 
2.43.0

