Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40769CA9EDC
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:15:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F44510EAED;
	Mon, 12 Oct 2026 04:15:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACF1110E4C0;
 Mon, 12 Oct 2026 04:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778544; x=1823314544;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IQmRlmklJrGXHgo4v8TXtFvvc7A4rRDkhpc2MqAMzts=;
 b=V32aLn8BfbY1UQ37cNGOiStIGBjqrnzfbfjEyQMbgzDpaILmOWkf6T+W
 k7vrJxywrch1eRoY7dPSaVoQB0YHi++eZcSi0gdUDAgFpyfrI1ACc5eXc
 /QY1iLq3CVe2pZoDAwh2SIEp+CnRdo/juw/ePgQMkLceVASjdna57EyWC
 ciU6VTXebnOF6SH0tDS4ynY8I7/2YKRbZHTdjRoxCK7blL7/HG3wPJoJU
 Hw5XURlVnkZBZEhW0a8PllZCcc8GJURGYewWgl/ZMnpWEkh9FkqZkf7P1
 FgtpOcrjLzdVyU57GptBTAZQM2WWIcPlLYYsojSHKYUR0Db7pqmR0bHjG Q==;
X-CSE-ConnectionGUID: Jr/OTvQVQ1K3Nlk+vU9sMg==
X-CSE-MsgGUID: EIPe0BkLSRyxxXb9E0Xbcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380934"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380934"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:42 -0700
X-CSE-ConnectionGUID: V8lxF08HQT2GaQ1AzjKFiA==
X-CSE-MsgGUID: 9xNvJ1rsRsqxUOeMc0mwKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256633"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:41 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 39/56] drm/i915/hdmi: Add support for sending uevent to
 user for FRL training failure
Date: Mon, 12 Oct 2026 09:27:48 +0530
Message-ID: <20261012035806.3361439-40-ankit.k.nautiyal@intel.com>
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

In case of HDMI FRL training failure for a given mode, the user
should be sent a uevent signalling Link failure.

Add support for sending uevent to userspace in case of link training
failure.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 32 +++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 0391597c9847..69612ebe80f0 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -71,6 +71,8 @@
 #include "intel_snps_phy.h"
 #include "intel_vrr.h"
 
+#define HAS_HDMI_FRL(__display)		(DISPLAY_VER((__display)) >= 14)
+
 bool intel_hdmi_is_frl(u32 clock)
 {
 	static const u32 rates[] = { 300000, 600000, 800000, 1000000, 1200000 };
@@ -3397,6 +3399,31 @@ void intel_infoframe_init(struct intel_digital_port *dig_port)
 	}
 }
 
+/* Common code with DP, need to put in a common place */
+static void intel_hdmi_modeset_retry_work_fn(struct work_struct *work)
+{
+	struct intel_connector *intel_connector;
+	struct drm_connector *connector;
+
+	intel_connector = container_of(work, typeof(*intel_connector),
+				       modeset_retry_work);
+	connector = &intel_connector->base;
+	DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n", connector->base.id,
+		      connector->name);
+
+	/* Grab the locks before changing connector property*/
+	mutex_lock(&connector->dev->mode_config.mutex);
+	/*
+	 * Set connector link status to BAD and send a Uevent to notify
+	 * userspace to do a modeset.
+	 */
+	drm_connector_set_link_status_property(connector,
+					       DRM_MODE_LINK_STATUS_BAD);
+	mutex_unlock(&connector->dev->mode_config.mutex);
+	/* Send Hotplug uevent so userspace can reprobe */
+	drm_kms_helper_hotplug_event(connector->dev);
+}
+
 bool intel_hdmi_init_connector(struct intel_digital_port *dig_port,
 			       struct intel_connector *intel_connector)
 {
@@ -3470,6 +3497,11 @@ bool intel_hdmi_init_connector(struct intel_digital_port *dig_port,
 	if (!intel_hdmi->cec_notifier)
 		drm_dbg_kms(display->drm, "CEC notifier get failed\n");
 
+	/* Initialize the work for modeset in case of link train failure */
+	if (HAS_HDMI_FRL(display))
+		INIT_WORK(&intel_connector->modeset_retry_work,
+			  intel_hdmi_modeset_retry_work_fn);
+
 	return true;
 }
 
-- 
2.50.1

