Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B8A606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ikf1b6UQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 556AA10F9BC;
	Wed, 21 Oct 2026 10:03:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D5E710F9CB;
 Wed, 21 Oct 2026 10:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792577023; x=1824113023;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=r29wKqh8FFTkl6aBu++bym1Bmt0c1OJOEQHQNaMSpTA=;
 b=ikf1b6UQ4fw5MEpzmx9I9K/GOihZaQaAUQJabYuvLrqrb/gnR/Pm16rq
 XSZF5Z1nIDNOUcHGSULW7Hu5JYy0UH9ZPLIG158V4B6gPSXBEuSAiiI0b
 DTUnGhK+F0770DkOpLsG8xAPgHVAN2e0mfdp3Go4uFcZdwUBRX3ylBXmS
 VeR5e3IysYF5cCrC1j05eJ2Lb46I/2YdwJoLCziVtbPw/RZajJoNrdC2D
 66Puf22PMM/wR++cc0nLO75YvNM6DG1/drcuRJ4+CEnUZ5Pdke3NuLzD5
 iffCbLVUaCvI6kJMF8xG7EaIvzjF9Qi2VkQjFOxFHuvaONVXmqkPHqzLD A==;
X-CSE-ConnectionGUID: NVcsW8NgQH6flBzmW7RqdQ==
X-CSE-MsgGUID: KPpMvOWETdKg/0je2G/VLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1290253"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1290253"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:03:43 -0700
X-CSE-ConnectionGUID: 60z3wXcgTlqxK2FaoXGLOw==
X-CSE-MsgGUID: /S+ktfvlTf6HMnt2Eg6TiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3382021"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:03:40 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [RFC v3 01/17] drm/drv: Export drm_dev_srcu_synchronize()
Date: Wed, 21 Oct 2026 15:33:02 +0530
Message-ID: <20261021100322.1014449-2-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021100322.1014449-1-arvind.yadav@intel.com>
References: <20261021100322.1014449-1-arvind.yadav@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

drm_dev_unplug() marks a device as unplugged and waits for existing
drm_dev_enter() users to finish before releasing device resources.

Drivers may need the same publish-and-drain sequence for their own
device state without unplugging the device.

Export drm_dev_srcu_synchronize() so drivers can publish their state and
wait for existing DRM SRCU readers to finish.

The Xe driver will use this helper to block device access during PCI
error recovery and permanent wedge isolation.

The SRCU domain is shared by all DRM devices, so synchronization also
waits for existing drm_dev_enter() sections on other devices.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: LLM
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

