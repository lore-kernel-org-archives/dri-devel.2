Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BB7C5DF93
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:41:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3444F10F2F1;
	Fri, 21 Aug 2026 14:41:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fqN+91z5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BD4610E1FA
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:41:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 21F7941E94;
 Fri, 21 Aug 2026 14:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806051F000E9;
 Fri, 21 Aug 2026 14:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323266;
 bh=+YqGyf8QxZHfQ0yeRaRkL7PN1OM+N2FsZnNMWQimJ0M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=fqN+91z5ZnEthBZOkM+Xw4KXKQ5kR9hjlDiAY4hLE0KP8VqLP6K25oEkVcUcUjYs1
 T8DmoLb3kvlfUaOycpopfbl7eDyF8WasjGq5jVCMTP02/6GaXjk6zabWYCWUU8Jvd9
 qEB6H2NYWMY3rQzpq5zFKeNoBoJpHaM9jZ4xR7Mgd1kOuKpYNwWnl9dnZe4gOkH7wr
 RpcZwbRaZvSHHqGv7yLzZPULMeCrsVCaPzy9YHz7OtDrg39gm9Rb/jAomrTuOKrdP9
 BroVi9WFWcniolGIWTPfSbR3U87Wxxsfnh69CC1KT2Ii5kwBGa7yd32IpDAufNNlYM
 E5F6+W7Pn7+tQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:19 +0200
Subject: [PATCH 43/70] sysfb: Convert to create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-43-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2993; i=mripard@kernel.org;
 h=from:subject:message-id; bh=zT/6WLpgNIeD7k3AwGg6FbDndIlcWPMafuLJ5qATRec=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdydyfNnjN/3Gl84iiYWx0tzfrUzuXF6lhF4+tOie2t
 EJD64RJx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZgImwBjwwcJodu+lTce8C45
 N+3wpcz9Kw8z5d/meip6I79aXvu82/SVMxUvbF/2/rNXQErDgSs1Nxjra+P+TUyPexav2XzAsXn
 WvDbLLP6XE0J4FNa+l2+LzbYqVOmQMX1dcX3DrnuV/acNRB8BAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/sysfb/drm_sysfb_helper.h  |  4 ++--
 drivers/gpu/drm/sysfb/drm_sysfb_modeset.c | 20 +++++++++-----------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_helper.h b/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
index 547f2327af5e..445eb5b5ca06 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
@@ -169,16 +169,16 @@ int drm_sysfb_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_
 
 #define DRM_SYSFB_CRTC_HELPER_FUNCS \
 	.mode_valid = drm_sysfb_crtc_helper_mode_valid, \
 	.atomic_check = drm_sysfb_crtc_helper_atomic_check
 
-void drm_sysfb_crtc_reset(struct drm_crtc *crtc);
+struct drm_crtc_state *drm_sysfb_crtc_create_state(struct drm_crtc *crtc);
 struct drm_crtc_state *drm_sysfb_crtc_atomic_duplicate_state(struct drm_crtc *crtc);
 void drm_sysfb_crtc_atomic_destroy_state(struct drm_crtc *crtc, struct drm_crtc_state *crtc_state);
 
 #define DRM_SYSFB_CRTC_FUNCS \
-	.reset = drm_sysfb_crtc_reset, \
+	.atomic_create_state = drm_sysfb_crtc_create_state, \
 	.set_config = drm_atomic_helper_set_config, \
 	.page_flip = drm_atomic_helper_page_flip, \
 	.atomic_duplicate_state = drm_sysfb_crtc_atomic_duplicate_state, \
 	.atomic_destroy_state = drm_sysfb_crtc_atomic_destroy_state
 
diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
index d2de29caf89e..ce11ac32fae4 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
@@ -513,27 +513,25 @@ int drm_sysfb_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_
 
 	return 0;
 }
 EXPORT_SYMBOL(drm_sysfb_crtc_helper_atomic_check);
 
-void drm_sysfb_crtc_reset(struct drm_crtc *crtc)
+struct drm_crtc_state *drm_sysfb_crtc_create_state(struct drm_crtc *crtc)
 {
 	struct drm_sysfb_device *sysfb = to_drm_sysfb_device(crtc->dev);
 	struct drm_sysfb_crtc_state *sysfb_crtc_state;
 
-	if (crtc->state)
-		drm_sysfb_crtc_state_destroy(to_drm_sysfb_crtc_state(crtc->state));
-
 	sysfb_crtc_state = kzalloc_obj(*sysfb_crtc_state);
-	if (sysfb_crtc_state) {
-		sysfb_crtc_state->format = sysfb->fb_format;
-		__drm_atomic_helper_crtc_reset(crtc, &sysfb_crtc_state->base);
-	} else {
-		__drm_atomic_helper_crtc_reset(crtc, NULL);
-	}
+	if (!sysfb_crtc_state)
+		return ERR_PTR(-ENOMEM);
+
+	sysfb_crtc_state->format = sysfb->fb_format;
+	__drm_atomic_helper_crtc_state_init(&sysfb_crtc_state->base, crtc);
+
+	return &sysfb_crtc_state->base;
 }
-EXPORT_SYMBOL(drm_sysfb_crtc_reset);
+EXPORT_SYMBOL(drm_sysfb_crtc_create_state);
 
 struct drm_crtc_state *drm_sysfb_crtc_atomic_duplicate_state(struct drm_crtc *crtc)
 {
 	struct drm_device *dev = crtc->dev;
 	struct drm_crtc_state *crtc_state = crtc->state;

-- 
2.55.0

