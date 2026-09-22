Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2040C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3D3510E6BB;
	Tue, 22 Sep 2026 10:17:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jgVqpHUL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D9E410E6AE;
 Tue, 22 Sep 2026 10:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790072259; x=1821608259;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1LmhrpdX6i71WfjQEpsK3yeOm61rJj9a2B0P0JXos0s=;
 b=jgVqpHULEb+XJ+v3Hev39BRhujxb/VJiFotImkugkOpvLrn+y4lfcmsc
 VlJCLtwivX5ru3BM3COd1kesXBWa26Bp5UbiRLNN30o37BnVmO4ZJnnQc
 YMnaB+lJogoqHH5xts2Ay9+dbK0JXbXZAbCGTQos9eQTHEZBEDnSavZGg
 JKSm8IbwpP+YEUPB88g7AUz/UzAteR8aUlLi6XT+CqBN+hW9vLjq9x96o
 3S4Jr4v6rFR4UJ53of3Pw0ura3+GU1+FuoYQ96oxO6x+3N+QpLSWi1fpW
 81BH5x2uXWjuRWRiE0h8yBPE6ABxZNJII6z4RTOixsq2AKgs3ENOQco4f g==;
X-CSE-ConnectionGUID: J9jgVHAHR96IvCujT54+Pg==
X-CSE-MsgGUID: KuOcATIRRYOiipwU5UVI6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101322781"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="101322781"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:17:39 -0700
X-CSE-ConnectionGUID: jcuL2g90RDeu62mnundEyQ==
X-CSE-MsgGUID: Q9RNZwRBTa6Ctft2+tVDMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="299307749"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:17:37 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH v2 02/15] drm/drv: Export drm_dev_srcu_synchronize()
Date: Tue, 22 Sep 2026 15:46:47 +0530
Message-ID: <20260922101721.1583542-3-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922101721.1583542-1-arvind.yadav@intel.com>
References: <20260922101721.1583542-1-arvind.yadav@intel.com>
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

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

drm_dev_unplug() marks a device as unplugged and waits for existing
drm_dev_enter() users to finish before releasing device resources.

Drivers may need the same publish-and-drain sequence for their own
device state without unplugging the device.

Export drm_dev_srcu_synchronize() so drivers can publish their state and
wait for existing DRM SRCU readers to finish.

The Xe driver will use this helper to block device access during PCI
error recovery and permanent wedge isolation.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/drm_drv.c | 17 ++++++++++++++++-
 include/drm/drm_drv.h     |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 0cdc606af8d1..0f25103e9037 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -476,6 +476,21 @@ void drm_dev_exit(int idx)
 }
 EXPORT_SYMBOL(drm_dev_exit);
 
+/**
+ * drm_dev_srcu_synchronize - Drain device SRCU readers
+ * @dev: DRM device whose state change is being synchronized
+ *
+ * Wait for existing drm_dev_enter() users to finish.
+ *
+ * The SRCU domain is shared by all DRM devices. Readers for other DRM
+ * devices may also delay this function.
+ */
+void drm_dev_srcu_synchronize(struct drm_device *dev)
+{
+	synchronize_srcu(&drm_unplug_srcu);
+}
+EXPORT_SYMBOL(drm_dev_srcu_synchronize);
+
 /*
  * Mark the device as unplugged and wait for any in-flight drm_dev_enter()
  * critical sections to complete.
@@ -489,7 +504,7 @@ static void drm_dev_synchronize_unplug(struct drm_device *dev)
 	 * finished.
 	 */
 	dev->unplugged = true;
-	synchronize_srcu(&drm_unplug_srcu);
+	drm_dev_srcu_synchronize(dev);
 }
 
 /**
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index b23830494ed4..27361fbad6dc 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -482,6 +482,7 @@ void drm_dev_put(struct drm_device *dev);
 void drm_put_dev(struct drm_device *dev);
 bool drm_dev_enter(struct drm_device *dev, int *idx);
 void drm_dev_exit(int idx);
+void drm_dev_srcu_synchronize(struct drm_device *dev);
 void drm_dev_unplug(struct drm_device *dev);
 int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
 			 struct drm_wedge_task_info *info);
-- 
2.43.0

