Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603EBF53D6F
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 16:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B71C510E592;
	Mon, 16 Mar 2026 16:20:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mOPQwYgV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0D8410E025;
 Mon, 16 Mar 2026 16:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773678035; x=1805214035;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=K1bkxslnvLadwCYhsCw5Y9Vr7/H+1DpkgHoFCGbEG9I=;
 b=mOPQwYgVvhy0QRWg4N+l49bDFJ3vo/8KtTxUTvgA2YxhCJj5RinqEhE7
 wQ/nQphC5LPlq/LozCb/n66Y+1trlxlggOGEUlqABERE7sRS+TGWk1mEm
 cFi0UG07VYJcPZytC8Io7qQBWX5IY0bC6bzJ9WMttOTBdkPWza+6JNF9J
 k/QOL8kZ6ygyZhD/QSh1saeTIuAHm22wWWJAIqt+RGAd+Esx0ldc42R61
 u9kFwow4s8M7ZZiZ94zspapY9mW25Bf2buztj6HIUlGWKwrv4CKPXgSdr
 A1MTPjm8K8+MhYacIcaWFJt+XYsFsoZWrRbjHKWbq+7wyBFA9OwMY3TIQ w==;
X-CSE-ConnectionGUID: h40qfJ5pQu69n7pqWcKrig==
X-CSE-MsgGUID: 7ZDDj62ZQZKjkF+ort4qxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74884817"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="74884817"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 09:20:35 -0700
X-CSE-ConnectionGUID: yub8JZNDSjORX7akc/W3zA==
X-CSE-MsgGUID: VeIQz6gzQ0qPuTc3oeIBBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="244993919"
Received: from zzombora-mobl1.ger.corp.intel.com (HELO fedora)
 ([10.245.244.233])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 09:20:32 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 1/2] drm: Provide a drm_dev_release_barrier() function to wait
 for device release callbacks
Date: Mon, 16 Mar 2026 17:20:01 +0100
Message-ID: <20260316162002.13479-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316162002.13479-1-thomas.hellstrom@linux.intel.com>
References: <20260316162002.13479-1-thomas.hellstrom@linux.intel.com>
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

If helper components, like for example drm_pagemap hold references to
drm devices, it's typically possible for the drm driver module to be
unloaded without that reference being dropped, resulting in execution out
of freed memory. Such components are therefore required to hold a
module refcount on the module that created the drm device, and ensure
that module reference is dropped after all references to the drm
device are dropped.

To relax that, drivers can keep a drm device-count and ensure that the
module isn't unloaded until the drm device-count has dropped to zero
and that the caller that decremented the last device-count has finished
executing driver callbacks.

To help with the latter, add a drm_dev_release_barrier() function.
The function ensures that any caller that has started executing
device release callbacks has also finished executing them.

Use SRCU for the implementation.

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/drm_drv.c | 25 +++++++++++++++++++++++++
 include/drm/drm_drv.h     |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 2915118436ce..9fa72adf173d 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -898,21 +898,46 @@ struct drm_device *drm_dev_alloc(const struct drm_driver *driver,
 }
 EXPORT_SYMBOL(drm_dev_alloc);
 
+DEFINE_STATIC_SRCU(drm_dev_release_srcu);
+
 static void drm_dev_release(struct kref *ref)
 {
 	struct drm_device *dev = container_of(ref, struct drm_device, ref);
+	int idx;
 
 	/* Just in case register/unregister was never called */
 	drm_debugfs_dev_fini(dev);
 
+	idx = srcu_read_lock(&drm_dev_release_srcu);
 	if (dev->driver->release)
 		dev->driver->release(dev);
 
 	drm_managed_release(dev);
+	srcu_read_unlock(&drm_dev_release_srcu, idx);
 
 	kfree(dev->managed.final_kfree);
 }
 
+/**
+ * drm_dev_release_barrier() - Ensure drm device release callbacks are finished
+ *
+ * If a device release method or any of the drm managed release callbacks
+ * have been called for a device, wait until all of them have finished
+ * executing. This function can be used to help determine whether it's safe
+ * to unload a driver module.
+ *
+ * Assume for example the driver maintains a device count which is decremented
+ * using a drmm callback or a device release callback. From a drm device
+ * lifetime POV, it's then safe to unload the driver when that device-count
+ * has reached zero and drm_dev_release_barrier() has been called.
+ */
+void drm_dev_release_barrier(void)
+{
+	synchronize_srcu(&drm_dev_release_srcu);
+}
+EXPORT_SYMBOL(drm_dev_release_barrier);
+
+
 /**
  * drm_dev_get - Take reference of a DRM device
  * @dev: device to take reference of or NULL
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 42fc085f986d..b288a885cf45 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -489,6 +489,7 @@ void drm_dev_exit(int idx);
 void drm_dev_unplug(struct drm_device *dev);
 int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
 			 struct drm_wedge_task_info *info);
+void drm_dev_release_barrier(void);
 
 /**
  * drm_dev_is_unplugged - is a DRM device unplugged
-- 
2.53.0

