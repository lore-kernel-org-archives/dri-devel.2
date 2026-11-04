Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DE5606A329
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=fT6i72k8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5603510FBF4;
	Wed,  4 Nov 2026 13:26:44 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B97AA10E886
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 13:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793798797;
 bh=yTiTiM/lpOGg/CHrEbJpkmf8z47uryAwOXKud9OkCyk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=fT6i72k8HV9AaBl+Wu5CA4NVP6RxgABfD0fakaeowKH0rFYJCptVPUevYeUEVn6Ve
 pO6vl0LY3eL5095GudQgs6d+x+kHoI0kQVDPLUPZiIZA41jBUryXVQD2FdhJJm9wxZ
 rMmCzgX3wosXM+gv77CkfsX6kgAA8COwrJWxSPLDTwiJo4dPN7WU5XiEjv9y3EIKH1
 iryTW3pHUJj+FI8ldf+VfslzyIogWduJGlLuVKk/ZdNf1b0jD/dJz3XiWY3qrBQONQ
 jTA2kOQU60vf2vF3A5c4kI98/xFEiu+5Wpm/IzR+dUjv6wZjBEJpg5hLkkKaiQTNbP
 dsPLExq5q/IpA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id F0B0117E0400;
 Wed, 04 Nov 2026 14:26:36 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 04 Nov 2026 15:26:20 +0200
Subject: [PATCH 1/3] drm/display: hdmi: Prevent NULL pointer dereference in
 sync_scdc()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-hdmi-scdc-scramb-fixes-v1-1-16a9bb3d64a6@collabora.com>
References: <20261104-hdmi-scdc-scramb-fixes-v1-0-16a9bb3d64a6@collabora.com>
In-Reply-To: <20261104-hdmi-scdc-scramb-fixes-v1-0-16a9bb3d64a6@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The connector pointer is used to initialize the local variables hdmi and
dev before the NULL check takes place, leading to the following Smatch
complaint:

  drivers/gpu/drm/display/drm_hdmi_helper.c:663 drm_connector_hdmi_sync_scdc()
  warn: variable dereferenced before check 'connector' (see line 657)

Move those initializations after the sanity check to avoid a potential
NULL pointer dereference.

Fixes: d653818324ed ("drm/display: hdmi: Add HDMI 2.0 scrambling management helpers")
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/all/arJo7A7L5hud3tyc@stanley.mountain/
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/drm/display/drm_hdmi_helper.c
index f85cce3d6254..872f7e32e8d2 100644
--- a/drivers/gpu/drm/display/drm_hdmi_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
@@ -653,9 +653,9 @@ EXPORT_SYMBOL(drm_connector_hdmi_disable_scrambling);
 int drm_connector_hdmi_sync_scdc(struct drm_connector *connector, bool plugged,
 				 struct drm_modeset_acquire_ctx *ctx)
 {
-	struct drm_connector_hdmi *hdmi = &connector->hdmi;
-	struct drm_device *dev = connector->dev;
+	struct drm_connector_hdmi *hdmi;
 	struct drm_connector_state *conn_state;
+	struct drm_device *dev;
 	struct drm_crtc *crtc;
 	u8 config;
 	int ret;
@@ -663,6 +663,9 @@ int drm_connector_hdmi_sync_scdc(struct drm_connector *connector, bool plugged,
 	if (!connector || !plugged || !ctx)
 		return 0;
 
+	hdmi = &connector->hdmi;
+	dev = connector->dev;
+
 	/*
 	 * This is normally part of .detect_ctx() call path, which already holds
 	 * connection_mutex through @ctx.  However, re-acquiring it with the

-- 
2.55.0

