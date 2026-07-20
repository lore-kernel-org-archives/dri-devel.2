Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40361C4451B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:22:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9515C10E80E;
	Mon, 20 Jul 2026 08:22:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="m0MrS5Jk";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A53E10E80E;
 Mon, 20 Jul 2026 08:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784535765; x=1816071765;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kI9HX11AHtPLvfep3qW1CdbbEBM12C4Ad1vHVWm3A3k=;
 b=m0MrS5Jk0seWRZv5QnKY/PYwrLkg4X3/DxF6Ie+PE+m/4SVhmsAOYCSq
 +YO7hG9QqQ9BiOOgYorUsV762awpiyF0EiDT043PCecPnhQbYGMKWM3Mv
 w7n8Y/7IN1ORET9EbizqN0u4QI2/zqX3JcUOtOZ7aI/BlTkJt8iE+STPd
 R/4kK5wXnBJZNlXOzCVIGOjlM8nvGHl6GueQmhy/zUb3SaVUMD0ceKd6H
 QAVmd36o72MLTgsMjmdYaztoJafI+f1w+XSsQChAjN8VQrxyOBu3Yo/i2
 6UqFO9tZgham5PqKUl6y5iVt75/Ncitmuxa5SUqVy6tTGr/b1SErOtQXp w==;
X-CSE-ConnectionGUID: V7Y5S9b9TMuS7kKi7tlrjA==
X-CSE-MsgGUID: Z/l1N0qiS9mNuTiD3y946A==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85228613"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="85228613"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 01:22:44 -0700
X-CSE-ConnectionGUID: wMWxhp9xQ16lkWhtuHL9bQ==
X-CSE-MsgGUID: OKUUQJ96SwWBJUDdaugmUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="258034751"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 01:22:40 -0700
From: Riana Tauro <riana.tauro@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: aravind.iddamsetty@linux.intel.com, anshuman.gupta@intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com, kuba@kernel.org,
 simona.vetter@ffwll.ch, airlied@gmail.com, pratik.bari@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
 raag.jadav@intel.com, maarten.lankhorst@linux.intel.com,
 mallesh.koujalagi@intel.com, soham.purkait@intel.com,
 Riana Tauro <riana.tauro@intel.com>
Subject: [PATCH v5 3/3] drm/xe/xe_ras: Report uncorrectable error events to
 userspace
Date: Mon, 20 Jul 2026 13:52:12 +0530
Message-ID: <20260720082208.2648279-8-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260720082208.2648279-5-riana.tauro@intel.com>
References: <20260720082208.2648279-5-riana.tauro@intel.com>
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

When the firmware reports uncorrectable errors in response to an AER
interrupt, deliver a drm-ras error event to userspace for each affected
component. Multiple errors for the same component within a single firmware
response are collapsed into one event to avoid duplicate notifications.

Signed-off-by: Riana Tauro <riana.tauro@intel.com>
---
 drivers/gpu/drm/xe/xe_ras.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index b08c664778ff..cd1307539912 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -449,6 +449,7 @@ enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
 	enum xe_ras_recovery_action final_action;
 	u32 remaining = XE_SYSCTRL_FLOOD_LIMIT;
 	struct xe_ras_get_soc_error response;
+	u8 sent = 0;
 	size_t rlen;
 	int ret;
 
@@ -492,6 +493,12 @@ enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
 			xe_info(xe, "[RAS]: %s %s detected\n", comp_to_str(component),
 				sev_to_str(severity));
 
+			/* Send event once per component */
+			if (!(sent & BIT(component))) {
+				sent |= BIT(component);
+				ras_send_error_event(xe, severity, component);
+			}
+
 			switch (component) {
 			case XE_RAS_COMP_CORE_COMPUTE:
 				action = handle_core_compute_errors(arr);
-- 
2.47.1

