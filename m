Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99CD606A32C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 01:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dDu6bUYY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FD4410E902;
	Mon, 16 Nov 2026 01:26:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EEC010E7C7;
 Mon, 16 Nov 2026 01:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794792356; x=1826328356;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=J8gzuBwMEItY6O5A/Sh2ReXTprxrj8eld9GNWTTlo7Y=;
 b=dDu6bUYYL5ppNlayfsPm6zFLPYGQfiomVPH+oDjs/t0GtITZRtP8lPNL
 LNQIOcJ1aPCF/EfotyIudaOeOeQgCoEEweqmQ39pO22X6vp8irThFML/g
 N7EGFSkCw/eN5lpkmKVHOeqKtSUirjqCeUTuNTwGFsrjeDeA9Yy2kqFgv
 ozYcXLY/BAZZXhT8gc9HRuCpLCtifHbtIi5JGV37vZhmmyKSL2npI1ZwP
 yeFsW1Wb6KumCuooFLhrM6zY8n2PF+zngXcCoe0OitieAB9Jm+8d0lOih
 u/VHtZjIu5yspmVi4w1vTaUbfsRovvI6EizF2TQ+ZRtWXkD53lMIfLjXA g==;
X-CSE-ConnectionGUID: 5E530h7ATZ+R5tvMG+fM3g==
X-CSE-MsgGUID: YT8iYRbQSTWVu4AOxJkJMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3398657"
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="3398657"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 17:25:56 -0800
X-CSE-ConnectionGUID: 9kfoSp3SQwGwNkvdVpLemA==
X-CSE-MsgGUID: o2oL/Q4jT2G2X24/vDNTww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="9295515"
Received: from emr-371.sh.intel.com ([10.112.106.129])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 17:25:53 -0800
From: Baoli Zhang <baoli.zhang@linux.intel.com>
To: intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 matthew.auld@intel.com, airlied@gmail.com, simona@ffwll.ch,
 andriy.shevchenko@linux.intel.com,
 Baoli Zhang <baoli.zhang@linux.intel.com>,
 Yanx L Liu <yanx.l.liu@intel.com>
Subject: [PATCH 2/3] drm/i915/display: Let the drivers free the KMS objects
Date: Mon, 16 Nov 2026 09:15:03 +0800
Message-ID: <20261116011504.3910139-3-baoli.zhang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116011504.3910139-1-baoli.zhang@linux.intel.com>
References: <20261116011504.3910139-1-baoli.zhang@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

intel_display_driver_remove_noirq() frees all the KMS objects through
drm_mode_config_cleanup(), while userspace may still hold the DRM fd
open with references to them, e.g. framebuffers it created. Such
objects must only be freed with the last reference to the DRM device.

As a first step, move drm_mode_config_cleanup() into the new
intel_display_driver_mode_config_cleanup() and call it from i915 and xe
right after intel_display_driver_remove_noirq(), so each driver can
then move it to the right place.

drm_mode_config_cleanup() now runs after the rest of the noirq teardown
(DP tunnel manager, overlay, GMBUS, workqueues and FBC). After the
previous patch the KMS object destroy callbacks no longer depend on any
of that.

No functional change intended.

Tested-by: Yanx L Liu <yanx.l.liu@intel.com>
Signed-off-by: Baoli Zhang <baoli.zhang@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_driver.c | 12 ++++++++++++
 drivers/gpu/drm/i915/display/intel_display_driver.h |  1 +
 drivers/gpu/drm/i915/i915_driver.c                  |  2 ++
 drivers/gpu/drm/xe/display/xe_display.c             |  2 ++
 4 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_driver.c b/drivers/gpu/drm/i915/display/intel_display_driver.c
index d513cfc881069..62a4d95d78b53 100644
--- a/drivers/gpu/drm/i915/display/intel_display_driver.c
+++ b/drivers/gpu/drm/i915/display/intel_display_driver.c
@@ -160,6 +160,18 @@ static void intel_mode_config_cleanup(struct intel_display *display)
 {
 	intel_atomic_global_obj_cleanup(display);
 	intel_encoder_remove_all(display);
+}
+
+/*
+ * Free the KMS objects, including the encoders torn down by
+ * intel_display_driver_remove_noirq(). Userspace can keep referring to them
+ * until the last reference to the DRM device is gone.
+ */
+void intel_display_driver_mode_config_cleanup(struct intel_display *display)
+{
+	if (!HAS_DISPLAY(display))
+		return;
+
 	drm_mode_config_cleanup(display->drm);
 }
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_driver.h b/drivers/gpu/drm/i915/display/intel_display_driver.h
index 1ae2ad7e95f6c..88d9028e86e4b 100644
--- a/drivers/gpu/drm/i915/display/intel_display_driver.h
+++ b/drivers/gpu/drm/i915/display/intel_display_driver.h
@@ -23,6 +23,7 @@ void intel_display_driver_register(struct intel_display *display);
 void intel_display_driver_remove(struct intel_display *display);
 void intel_display_driver_remove_noirq(struct intel_display *display);
 void intel_display_driver_remove_nogem(struct intel_display *display);
+void intel_display_driver_mode_config_cleanup(struct intel_display *display);
 void intel_display_driver_unregister(struct intel_display *display);
 void intel_display_driver_shutdown(struct intel_display *display);
 void intel_display_driver_shutdown_late(struct intel_display *display);
diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index aeb7b24c81c8b..d29b37ab2833e 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -906,6 +906,7 @@ int i915_driver_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	intel_display_driver_remove(display);
 	intel_irq_uninstall(i915);
 	intel_display_driver_remove_noirq(display);
+	intel_display_driver_mode_config_cleanup(display);
 	goto out_cleanup_modeset;
 out_cleanup_irq:
 	intel_irq_uninstall(i915);
@@ -951,6 +952,7 @@ void i915_driver_remove(struct drm_i915_private *i915)
 	intel_irq_uninstall(i915);
 
 	intel_display_driver_remove_noirq(display);
+	intel_display_driver_mode_config_cleanup(display);
 
 	i915_reset_error_state(i915);
 	i915_gem_driver_remove(i915);
diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index 506f26e9c59a8..d33052a98d942 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -73,6 +73,7 @@ static void xe_display_fini_early(void *arg)
 		return;
 
 	intel_display_driver_remove_noirq(display);
+	intel_display_driver_mode_config_cleanup(display);
 	intel_display_driver_remove_nogem(display);
 	intel_display_power_cleanup(display);
 }
@@ -110,6 +111,7 @@ int xe_display_init_early(struct xe_device *xe)
 	return devm_add_action_or_reset(xe->drm.dev, xe_display_fini_early, xe);
 err_noirq:
 	intel_display_driver_remove_noirq(display);
+	intel_display_driver_mode_config_cleanup(display);
 	intel_display_power_cleanup(display);
 
 	return err;
-- 
2.43.0

