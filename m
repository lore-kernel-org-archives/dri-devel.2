Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5D8CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 00:27:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B878A10E2B7;
	Thu,  1 Oct 2026 00:27:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="gYEoKGVb";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A65A10E1BC
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 00:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790814421;
 bh=9wXs1/kWiZoomTm6bm22OJnh/aetblOCG6s9VnYNbxM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=gYEoKGVbcl3LZth+b/O6nC5qnst2blJvJ0ed4DwHh47VFHWUfBr7y+AQC1bJrIPSv
 aykY5eW3lC3Bi2Dv8BiGqTwp4A91SUh7VDYwq1h4tQ7tHmUw/HIWYhnsDORBL/b5N9
 DSk2Hu7a9LvNgvczTYoxbn1v78/4gLFa6tVFHyUnmcXZ5UYxxsm/odZ9twlqXrB9Qx
 ZyQ4Lm/AWzr6nJLRJNwO+mFe+S9sYM2uEpODfP/jqvYwAyFn7YUbF0p3aD8/WnDetq
 XMjL1WgtVp3SIMSBEUgt5/iQ4hST4OWzc0j7Aec8nCVLauVU0odiGHY+NQwnOrJnqE
 X35KaICyrwVrA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C46A017E0FD9;
 Thu, 01 Oct 2026 02:27:01 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 01 Oct 2026 03:26:17 +0300
Subject: [PATCH 4/7] drm/vc4: hdmi: Propagate -EDEADLK to the top level
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-vc4-common-scramb-v1-4-51280460194b@collabora.com>
References: <20261001-vc4-common-scramb-v1-0-51280460194b@collabora.com>
In-Reply-To: <20261001-vc4-common-scramb-v1-0-51280460194b@collabora.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
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

drm_connector_helper_funcs.detect_ctx() is expected to propagate
-EDEADLK so that context owners, e.g. drm_helper_probe_detect_ctx(), can
perform the required backoff and retry.

vc4_hdmi_handle_hotplug() instead runs its own retry loop and calls
drm_modeset_backoff() on an acquire context it does not own.  This drops
all locks in the context, including connection_mutex held by the core.

Drop the local retry logic and propagate -EDEADLK to the caller instead.
This aligns VC4 with the expected detect_ctx() semantics.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 7c921a444e98..6bd5aa77538e 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -344,12 +344,11 @@ static int vc4_hdmi_reset_link(struct drm_connector *connector,
 	return drm_atomic_helper_reset_crtc(crtc, ctx);
 }
 
-static void vc4_hdmi_handle_hotplug(struct vc4_hdmi *vc4_hdmi,
-				    struct drm_modeset_acquire_ctx *ctx,
-				    enum drm_connector_status status)
+static int vc4_hdmi_handle_hotplug(struct vc4_hdmi *vc4_hdmi,
+				   struct drm_modeset_acquire_ctx *ctx,
+				   enum drm_connector_status status)
 {
 	struct drm_connector *connector = &vc4_hdmi->connector;
-	int ret;
 
 	/*
 	 * NOTE: This function should really be called with vc4_hdmi->mutex
@@ -368,17 +367,9 @@ static void vc4_hdmi_handle_hotplug(struct vc4_hdmi *vc4_hdmi,
 	drm_atomic_helper_connector_hdmi_hotplug(connector, ctx, status);
 
 	if (status != connector_status_connected)
-		return;
+		return 0;
 
-	for (;;) {
-		ret = vc4_hdmi_reset_link(connector, ctx);
-		if (ret == -EDEADLK) {
-			drm_modeset_backoff(ctx);
-			continue;
-		}
-
-		break;
-	}
+	return vc4_hdmi_reset_link(connector, ctx);
 }
 
 static int vc4_hdmi_connector_detect_ctx(struct drm_connector *connector,
@@ -416,10 +407,10 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_connector *connector,
 			status = connector_status_connected;
 	}
 
-	vc4_hdmi_handle_hotplug(vc4_hdmi, ctx, status);
+	ret = vc4_hdmi_handle_hotplug(vc4_hdmi, ctx, status);
 	pm_runtime_put(&vc4_hdmi->pdev->dev);
 
-	return status;
+	return ret == -EDEADLK ? ret : status;
 }
 
 static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)

-- 
2.55.0

