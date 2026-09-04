Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B18C79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E63310F9AC;
	Fri,  4 Sep 2026 09:08:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JQzQ+5rO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A730E10F9AC
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 09:08:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 901A940A59;
 Fri,  4 Sep 2026 09:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89CF1F00A3D;
 Fri,  4 Sep 2026 09:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788512893;
 bh=JFXRtZpSo/FsjZOR9vpvDMVCxxa199B4sLSjLF7/TN8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=JQzQ+5rOl4vXGbp4Mxr3jcM3cDELwF3+0jRRsIdxcdgBI/HLS0sDfzSlwX6JdmJMw
 5NKMwjTfgEN7BYFfeKJVq3JJ8tiu3vCat+o8PVpjDxZe6iFHK2SuECtoK/cef8PG7H
 3T5/O2qWCrBw3ih8pGC6jXzm5LN8oBs1tuaC8I1tUNakUXQnb4eGXB87hnSJAz8gio
 +zOIJXtc+fW+kQw8Gx3IBic/iWX0lEwzti1wgxgiJ8sihcxvFbOKP74D3k3YvUTO/E
 J1gDSyK5umKypVyVJVuX3WvDmVyKO3xhOPjM9xS3ZE8FrOvTMCQtomhPtecsCIQ2Ln
 6ZoakuqjuSMFQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 04 Sep 2026 11:07:29 +0200
Subject: [PATCH v3 11/13] drm/sitronix: st7920: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-drm-no-more-crtc-reset-v3-11-27d9891512ce@kernel.org>
References: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
In-Reply-To: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2423; i=mripard@kernel.org;
 h=from:subject:message-id; bh=L9F5T6gNIFEY9cwjRgXi5bgUMR32jle5xvpmPhh39ZY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmzuvz3T/8T16fitbQ379uqBdkCQo9LZ+hmzGyrkjqTK
 NP8O823YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEyk7iJjw5FrJa677Ll0F3tF
 bK2YyjjHprg1fjnfiv9ph6t3LTXcz35bw+C17xPrCTqFgf67918vZmx4V7Ta+ej/Ysa0Q9Lrvkt
 f6lw5LW79Bn1X/tn/TU5rtele4H07J1XllOYb97+yh+WPiH0FAA==
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

The st7920 crtc implementation provides a custom reset hook. However,
this hook only allocates the state, initializes it with
__drm_atomic_helper_crtc_reset(), and warns if there's a previous state.
It does not perform any hardware reset.

Since this is exactly what the atomic_create_state hook is meant to
do, minus the old state cleanup which the caller handles, convert the
implementation to use atomic_create_state with
__drm_atomic_helper_crtc_state_init() instead.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Iker Pedrosa <ikerpedrosam@gmail.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/gpu/drm/sitronix/st7920.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7920.c b/drivers/gpu/drm/sitronix/st7920.c
index 0a75e9319080..9887ed746ceb 100644
--- a/drivers/gpu/drm/sitronix/st7920.c
+++ b/drivers/gpu/drm/sitronix/st7920.c
@@ -573,21 +573,21 @@ static void st7920_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	drm_dev_exit(idx);
 }
 
 /* Called during init to allocate the CRTC's atomic state. */
-static void st7920_crtc_reset(struct drm_crtc *crtc)
+static struct drm_crtc_state *st7920_crtc_create_state(struct drm_crtc *crtc)
 {
 	struct st7920_crtc_state *st7920_state;
 
-	drm_WARN_ON_ONCE(crtc->dev, crtc->state);
-
 	st7920_state = kzalloc_obj(*st7920_state);
 	if (!st7920_state)
-		return;
+		return ERR_PTR(-ENOMEM);
 
-	__drm_atomic_helper_crtc_reset(crtc, &st7920_state->base);
+	__drm_atomic_helper_crtc_state_init(&st7920_state->base, crtc);
+
+	return &st7920_state->base;
 }
 
 static struct drm_crtc_state *st7920_crtc_duplicate_state(struct drm_crtc *crtc)
 {
 	struct st7920_crtc_state *st7920_state;
@@ -627,11 +627,11 @@ static const struct drm_crtc_helper_funcs st7920_crtc_helper_funcs = {
 	.atomic_enable = st7920_crtc_atomic_enable,
 	.atomic_disable = st7920_crtc_atomic_disable,
 };
 
 static const struct drm_crtc_funcs st7920_crtc_funcs = {
-	.reset = st7920_crtc_reset,
+	.atomic_create_state = st7920_crtc_create_state,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = st7920_crtc_duplicate_state,
 	.atomic_destroy_state = st7920_crtc_destroy_state,

-- 
2.55.0

