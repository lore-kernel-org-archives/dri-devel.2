Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F12ACD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 11:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0285710F075;
	Thu,  7 May 2026 11:53:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="QMHzAoqu";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9067710F075
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 11:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778154836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3GsJmkqThUnt2brR26qwGZz8nLewh8d7g9i4bVblI9s=;
 b=QMHzAoquXjRd/A7r+skImkzmmixc0j6PlSNy9otL/8tFitJZ3McXo6wrbt6yaoS8BrqVLn
 ihM+uTbeaHAyuoO78ShvPQRzPMdGpy3C3/uTt9qjP96t4Mv7uhhsrvs+qcT6d46axX80wd
 LFdhbV+SHY21dlrduHDaZNnyWCMRqoc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-D4PP_y0hNjSp49tgXQo6Tw-1; Thu,
 07 May 2026 07:53:53 -0400
X-MC-Unique: D4PP_y0hNjSp49tgXQo6Tw-1
X-Mimecast-MFC-AGG-ID: D4PP_y0hNjSp49tgXQo6Tw_1778154831
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF37E19560AE; Thu,  7 May 2026 11:53:51 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 722F81953947; Thu,  7 May 2026 11:53:48 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 07 May 2026 13:53:08 +0200
Subject: [PATCH 10/10] drm/panel: Make drm_panel_init() static
MIME-Version: 1.0
Message-Id: <20260507-drm_panel_init_rm-v1-10-51f448c7c291@redhat.com>
References: <20260507-drm_panel_init_rm-v1-0-51f448c7c291@redhat.com>
In-Reply-To: <20260507-drm_panel_init_rm-v1-0-51f448c7c291@redhat.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Michael Tretter <m.tretter@pengutronix.de>, 
 Michael Walle <mwalle@kernel.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Albert Esteve <aesteve@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778154793; l=3300;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=NyPU5Jyr7qYKLrnlxqRHJQCdjHevA3vSn9eS4E//z44=;
 b=hDmsOdt+AL9ztiUPAR8EaGgiY0RhwtPsxPkX10H/DSptpCKU7+QUolnEU/TRNCX9NPV8OuRzu
 mBrhnVXudEZDY0dVDkql64SG5q5vs+If3OMle0AR7dPoEnFyICBAkR6
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 8KkD93WZzuwBDPv85P-sSMvxua5j2dc_XbeFruc_z-I_1778154831
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Now that all panel drivers use devm_drm_panel_alloc(),
there are no external callers of drm_panel_init().
Make it static to prevent new users from bypassing the
refcounted allocation path.

Remove stale references to drm_panel_init() in kdocs.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 2 +-
 drivers/gpu/drm/drm_panel.c             | 8 ++++----
 include/drm/drm_panel.h                 | 4 ----
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index a697cc227e289..380ebf0fad2be 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -4626,7 +4626,7 @@ static const struct backlight_ops dp_aux_bl_ops = {
  * Backlight will then be handled transparently without requiring
  * any intervention from the driver.
  *
- * drm_panel_dp_aux_backlight() must be called after the call to drm_panel_init().
+ * drm_panel_dp_aux_backlight() must be called after devm_drm_panel_alloc().
  *
  * Return: 0 on success or a negative error code on failure.
  */
diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index d1e6598ea3bc0..e3e1c5ceb8ff8 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -56,8 +56,9 @@ static LIST_HEAD(panel_list);
  * Initialize the panel structure for subsequent registration with
  * drm_panel_add().
  */
-void drm_panel_init(struct drm_panel *panel, struct device *dev,
-		    const struct drm_panel_funcs *funcs, int connector_type)
+static void drm_panel_init(struct drm_panel *panel, struct device *dev,
+			   const struct drm_panel_funcs *funcs,
+			   int connector_type)
 {
 	if (connector_type == DRM_MODE_CONNECTOR_Unknown)
 		DRM_WARN("%s: %s: a valid connector type is required!\n", __func__, dev_name(dev));
@@ -69,7 +70,6 @@ void drm_panel_init(struct drm_panel *panel, struct device *dev,
 	panel->funcs = funcs;
 	panel->connector_type = connector_type;
 }
-EXPORT_SYMBOL(drm_panel_init);
 
 /**
  * drm_panel_add - add a panel to the global registry
@@ -708,7 +708,7 @@ EXPORT_SYMBOL(devm_drm_panel_add_follower);
  * A typical implementation for a panel driver supporting device tree
  * will call this function at probe time. Backlight will then be handled
  * transparently without requiring any intervention from the driver.
- * drm_panel_of_backlight() must be called after the call to drm_panel_init().
+ * drm_panel_of_backlight() must be called after devm_drm_panel_alloc().
  *
  * Return: 0 on success or a negative error code on failure.
  */
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 2407bfa60236f..55cbc51512240 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -320,10 +320,6 @@ void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t offset,
 					offsetof(type, member), funcs, \
 					connector_type))
 
-void drm_panel_init(struct drm_panel *panel, struct device *dev,
-		    const struct drm_panel_funcs *funcs,
-		    int connector_type);
-
 struct drm_panel *drm_panel_get(struct drm_panel *panel);
 void drm_panel_put(struct drm_panel *panel);
 

-- 
2.53.0

