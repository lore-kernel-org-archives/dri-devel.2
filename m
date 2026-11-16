Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45826606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 01:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kf8jSpja
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2A7410E93D;
	Mon, 16 Nov 2026 01:26:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B107110E900;
 Mon, 16 Nov 2026 01:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794792361; x=1826328361;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=s2WxC280Ky1U3JJ9u+VxKtRrkFH89DaLzPX3xWfs1Jw=;
 b=kf8jSpjanPLfjVg/8AxoU+rJWSxcAyzebLTZAZDUx8ZSK5/0/mvDyVvU
 UeZGk9ZdZFgMlcoM0ipr67OxPeBdgb40on68vAjCG6vgh3yBc7AQsEOtC
 89yFzsa0ypzcPh0eqdGzwK2zrRDP6EaK/8zwpXNhgCSaVi/4WnDRObMlI
 s+3x/Mwr8wPECtUeY1t3ObflQIOhG6uQJobLr3eVdy5hD1asxskWn0djd
 z0cqtTd3adfznYejTUiBLv3qrYIomxPVuNWDzVvWh9V1zFYtcS4Lx/m9n
 gO1/h5wwG/VEI684bHlhWXueAOCt+B9oDcAiU4mgtuMxN+8MeIO7VXeeB w==;
X-CSE-ConnectionGUID: kC+XHUDgQp2Q+jnA9nPKfw==
X-CSE-MsgGUID: jZKtT+sQS0mX3zQXHSrEug==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3398676"
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="3398676"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 17:26:01 -0800
X-CSE-ConnectionGUID: fc34BERvSC2BZkG/rVDrSA==
X-CSE-MsgGUID: vas2ycPNRcCdvbZyXg6g1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="9295543"
Received: from emr-371.sh.intel.com ([10.112.106.129])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 17:25:58 -0800
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
Subject: [PATCH 3/3] drm/xe/display: Free the KMS objects on DRM device release
Date: Mon, 16 Nov 2026 09:15:04 +0800
Message-ID: <20261116011504.3910139-4-baoli.zhang@linux.intel.com>
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

xe frees all the KMS objects on unbind, from the xe_display_fini_early()
devres action. If userspace still holds the DRM fd open at that point,
e.g. a display server with framebuffers created through ADDFB, those
framebuffers are freed while still linked on the file's list:

  WARNING: drivers/gpu/drm/drm_mode_config.c:571 at drm_mode_config_cleanup+0x2e7/0x300
  Call Trace:
   intel_display_driver_remove_noirq+0x55/0xb0 [xe]
   xe_display_fini_early+0x37/0x50 [xe]
   devres_release_all+0x94/0xe0
   device_release_driver_internal+0x1c3/0x200
   unbind_store+0xa4/0xb0

  xe 0000:00:02.0: [drm] drm_WARN_ON(!list_empty(&fb->filp_head))
  WARNING: drivers/gpu/drm/drm_framebuffer.c:833 at drm_framebuffer_free+0x87/0xa0

and drm_fb_release() touches the freed framebuffers when the fd is
closed later, a use-after-free.

Resources visible to userspace must only be freed with the last
reference to the DRM device, see the DRM device instance documentation
in drm_drv.c. drm_mode_config_init() already registers
drm_mode_config_cleanup() as a drmm action, and the display device is
freed by a drmm action registered before it, so it is still around when
the KMS objects get destroyed.

Stop calling intel_display_driver_mode_config_cleanup() from xe and let
drmm free the KMS objects instead. The encoder hardware teardown still
happens on unbind, through intel_display_driver_remove_noirq().

Fixes: 5b6937b65e45 ("drm/xe/display: move display fini stuff to devm")
Tested-by: Yanx L Liu <yanx.l.liu@intel.com>
Signed-off-by: Baoli Zhang <baoli.zhang@linux.intel.com>
---
 drivers/gpu/drm/xe/display/xe_display.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index d33052a98d942..1c7f08fb9d2ce 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -72,8 +72,11 @@ static void xe_display_fini_early(void *arg)
 	if (!xe->info.probe_display)
 		return;
 
+	/*
+	 * The KMS objects are freed by drmm when the last reference to the DRM
+	 * device is gone, as userspace may still hold the DRM fd open.
+	 */
 	intel_display_driver_remove_noirq(display);
-	intel_display_driver_mode_config_cleanup(display);
 	intel_display_driver_remove_nogem(display);
 	intel_display_power_cleanup(display);
 }
@@ -111,7 +114,6 @@ int xe_display_init_early(struct xe_device *xe)
 	return devm_add_action_or_reset(xe->drm.dev, xe_display_fini_early, xe);
 err_noirq:
 	intel_display_driver_remove_noirq(display);
-	intel_display_driver_mode_config_cleanup(display);
 	intel_display_power_cleanup(display);
 
 	return err;
-- 
2.43.0

