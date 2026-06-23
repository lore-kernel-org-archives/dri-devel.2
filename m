Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49315CDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:15:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A38F910EA73;
	Tue, 23 Jun 2026 10:15:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FWIGJKnT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5048810EA5C;
 Tue, 23 Jun 2026 10:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782209708; x=1813745708;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7nFRWhx2b7/zkQyV1Nfv4q/nQAkcZpsSIqhW0oD0A3s=;
 b=FWIGJKnTahq4IpakVAVC4iVSwjtCir7teCPqC0YdmZ8XcN0wwF4fhXHc
 7lxjtJk3HCxVdfWWvqvMQiYmmoABj8FME0Y1rlCWjjwwmq9VXrn6s84AT
 GwXkoTOQG5KQ7ss1GKvlvUS6QwmfSFXZznJXMKPi/xiqsQIiMjHeNHdyG
 RdLAkKoyfceMNpplg4ljOglF2KchecQR3727qvhBSodQmNpuAH2y0lDZ8
 1nLRj5kuakMbBkj6SAdbUkK5cx27XYCrDxT6xw83oYvA0N7dLQMUSP4CL
 VIEVMPMGiW8luwe0l8PENSJ1bRghmUhu945kAUUdCsEg2mhvNDJcAaFrY w==;
X-CSE-ConnectionGUID: CR1XDjfdQ8uSfF9zbn7sqg==
X-CSE-MsgGUID: b7WSE3MbQL6nolx56M02ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82053186"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="82053186"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 03:15:07 -0700
X-CSE-ConnectionGUID: sR+4Y5WeRmiDy/zPDUyplw==
X-CSE-MsgGUID: HxKbzzz+TfyW2npcPWMX3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="273175526"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa002.fm.intel.com with ESMTP; 23 Jun 2026 03:15:02 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: simona.vetter@ffwll.ch, airlied@gmail.com, kuba@kernel.org,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, dev@lankhorst.se,
 zachary.mckevitt@oss.qualcomm.com, rodrigo.vivi@intel.com,
 riana.tauro@intel.com, michal.wajdeczko@intel.com,
 matthew.d.roper@intel.com, mallesh.koujalagi@intel.com,
 Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v4 3/5] drm/xe/ras: Add support for error threshold
Date: Tue, 23 Jun 2026 15:39:57 +0530
Message-ID: <20260623101043.255897-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623101043.255897-1-raag.jadav@intel.com>
References: <20260623101043.255897-1-raag.jadav@intel.com>
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

System controller allows getting/setting per counter threshold for
correctable errors, which it uses to raise error events to the driver.
Get/set it using the respective mailbox command.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
v2: Add RAS operation status codes (Riana)
v3: Reuse status codes and uapi mapping from counter series (Riana)
    Access request/response counter using local pointer (Riana)
    Mark unused field as reserved (Riana)
v4: Make debug logs consistent (Riana)
    Update kdoc (Riana)
---
 drivers/gpu/drm/xe/xe_ras.c                   | 105 ++++++++++++++++++
 drivers/gpu/drm/xe/xe_ras.h                   |   2 +
 drivers/gpu/drm/xe/xe_ras_types.h             |  51 +++++++++
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |   4 +
 4 files changed, 162 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 44f4e1a3455b..afee8202d24e 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -270,6 +270,111 @@ int xe_ras_clear_counter(struct xe_device *xe, u8 severity, u8 component)
 	return 0;
 }
 
+/**
+ * xe_ras_get_threshold() - Get error counter threshold
+ * @xe: Xe device instance
+ * @severity: Error severity to be queried (&enum drm_xe_ras_error_severity)
+ * @component: Error component to be queried (&enum drm_xe_ras_error_component)
+ * @threshold: Counter threshold
+ *
+ * This function retrieves the error threshold of a specific counter based on
+ * severity and component.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int xe_ras_get_threshold(struct xe_device *xe, u8 severity, u8 component, u32 *threshold)
+{
+	struct xe_ras_get_threshold_response response = {};
+	struct xe_ras_get_threshold_request request = {};
+	struct xe_sysctrl_mailbox_command command = {};
+	struct xe_ras_error_class *counter;
+	size_t len;
+	int ret;
+
+	counter = &request.counter;
+	counter->common.severity = drm_to_xe_ras_severity(severity);
+	counter->common.component = drm_to_xe_ras_component(component);
+
+	xe_sysctrl_create_command(&command, XE_SYSCTRL_GROUP_GFSP, XE_SYSCTRL_CMD_GET_THRESHOLD,
+				  &request, sizeof(request), &response, sizeof(response));
+
+	guard(xe_pm_runtime)(xe);
+	ret = xe_sysctrl_send_command(&xe->sc, &command, &len);
+	if (ret) {
+		xe_err(xe, "sysctrl: failed to get threshold %d\n", ret);
+		return ret;
+	}
+
+	if (len != sizeof(response)) {
+		xe_err(xe, "sysctrl: unexpected get threshold response length %zu (expected %zu)\n",
+		       len, sizeof(response));
+		return -EIO;
+	}
+
+	counter = &response.counter;
+	*threshold = response.threshold;
+
+	xe_dbg(xe, "[RAS]: get threshold %u for %s %s\n", *threshold,
+	       comp_to_str(counter->common.component), sev_to_str(counter->common.severity));
+	return 0;
+}
+
+/**
+ * xe_ras_set_threshold() - Set error counter threshold
+ * @xe: Xe device instance
+ * @severity: Error severity to be set (&enum drm_xe_ras_error_severity)
+ * @component: Error component to be set (&enum drm_xe_ras_error_component)
+ * @threshold: Counter threshold
+ *
+ * This function sets the error threshold of a specific counter based on
+ * severity and component.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int xe_ras_set_threshold(struct xe_device *xe, u8 severity, u8 component, u32 threshold)
+{
+	struct xe_ras_set_threshold_response response = {};
+	struct xe_ras_set_threshold_request request = {};
+	struct xe_sysctrl_mailbox_command command = {};
+	struct xe_ras_error_class *counter;
+	size_t len;
+	int ret;
+
+	counter = &request.counter;
+	counter->common.severity = drm_to_xe_ras_severity(severity);
+	counter->common.component = drm_to_xe_ras_component(component);
+	request.threshold = threshold;
+
+	xe_sysctrl_create_command(&command, XE_SYSCTRL_GROUP_GFSP, XE_SYSCTRL_CMD_SET_THRESHOLD,
+				  &request, sizeof(request), &response, sizeof(response));
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
+	ret = ras_status_to_errno(response.status);
+	if (ret) {
+		xe_err(xe, "sysctrl: set threshold command failed with status %#x\n",
+		       response.status);
+		return ret;
+	}
+
+	counter = &response.counter;
+
+	xe_dbg(xe, "[RAS]: set threshold %u for %s %s\n", response.threshold,
+	       comp_to_str(counter->common.component), sev_to_str(counter->common.severity));
+	return 0;
+}
+
 /**
  * xe_ras_init - Initialize Xe RAS
  * @xe: xe device instance
diff --git a/drivers/gpu/drm/xe/xe_ras.h b/drivers/gpu/drm/xe/xe_ras.h
index ba0b0224df23..1aa43c54b710 100644
--- a/drivers/gpu/drm/xe/xe_ras.h
+++ b/drivers/gpu/drm/xe/xe_ras.h
@@ -15,6 +15,8 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 				      struct xe_sysctrl_event_response *response);
 int xe_ras_get_counter(struct xe_device *xe, u8 severity, u8 component, u32 *value);
 int xe_ras_clear_counter(struct xe_device *xe, u8 severity, u8 component);
+int xe_ras_get_threshold(struct xe_device *xe, u8 severity, u8 component, u32 *threshold);
+int xe_ras_set_threshold(struct xe_device *xe, u8 severity, u8 component, u32 threshold);
 void xe_ras_init(struct xe_device *xe);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_ras_types.h b/drivers/gpu/drm/xe/xe_ras_types.h
index 6688e11f57a8..747b651880cd 100644
--- a/drivers/gpu/drm/xe/xe_ras_types.h
+++ b/drivers/gpu/drm/xe/xe_ras_types.h
@@ -121,4 +121,55 @@ struct xe_ras_clear_counter_response {
 	/** @reserved1: Reserved for future use */
 	u32 reserved1[3];
 } __packed;
+
+/**
+ * struct xe_ras_get_threshold_request - Request structure for get threshold
+ */
+struct xe_ras_get_threshold_request {
+	/** @counter: Counter to get threshold for */
+	struct xe_ras_error_class counter;
+	/** @reserved: Reserved for future use */
+	u32 reserved;
+} __packed;
+
+/**
+ * struct xe_ras_get_threshold_response - Response structure for get threshold
+ */
+struct xe_ras_get_threshold_response {
+	/** @counter: Counter ID */
+	struct xe_ras_error_class counter;
+	/** @threshold: Current threshold of the counter */
+	u32 threshold;
+	/** @reserved: Reserved for future use */
+	u32 reserved[4];
+} __packed;
+
+/**
+ * struct xe_ras_set_threshold_request - Request structure for set threshold
+ */
+struct xe_ras_set_threshold_request {
+	/** @counter: Counter to set threshold for */
+	struct xe_ras_error_class counter;
+	/** @threshold: Threshold to be set */
+	u32 threshold;
+	/** @reserved: Reserved for future use */
+	u32 reserved;
+} __packed;
+
+/**
+ * struct xe_ras_set_threshold_response - Response structure for set threshold
+ */
+struct xe_ras_set_threshold_response {
+	/** @counter: Counter ID */
+	struct xe_ras_error_class counter;
+	/** @reserved: Reserved */
+	u32 reserved;
+	/** @threshold: Updated threshold */
+	u32 threshold;
+	/** @status: Operation status */
+	u32 status;
+	/** @reserved1: Reserved for future use */
+	u32 reserved1[2];
+} __packed;
+
 #endif
diff --git a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
index 6e3753554510..10f06aa5c4b5 100644
--- a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
+++ b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
@@ -24,11 +24,15 @@ enum xe_sysctrl_group {
  *
  * @XE_SYSCTRL_CMD_GET_COUNTER: Get error counter value
  * @XE_SYSCTRL_CMD_CLEAR_COUNTER: Clear error counter value
+ * @XE_SYSCTRL_CMD_GET_THRESHOLD: Retrieve error threshold
+ * @XE_SYSCTRL_CMD_SET_THRESHOLD: Set error threshold
  * @XE_SYSCTRL_CMD_GET_PENDING_EVENT: Retrieve pending event
  */
 enum xe_sysctrl_gfsp_cmd {
 	XE_SYSCTRL_CMD_GET_COUNTER		= 0x03,
 	XE_SYSCTRL_CMD_CLEAR_COUNTER		= 0x04,
+	XE_SYSCTRL_CMD_GET_THRESHOLD		= 0x05,
+	XE_SYSCTRL_CMD_SET_THRESHOLD		= 0x06,
 	XE_SYSCTRL_CMD_GET_PENDING_EVENT	= 0x07,
 };
 
-- 
2.43.0

