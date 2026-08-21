Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB4DC5DF93
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8CA310F304;
	Fri, 21 Aug 2026 14:42:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ou+mmcKY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 530BC10F2F5
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:41:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C76816136F;
 Fri, 21 Aug 2026 14:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041971F00A3A;
 Fri, 21 Aug 2026 14:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323316;
 bh=Q/4ReWyyI2HPi1hP31P4u8lEn+jWrztKuZrnmd3345c=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Ou+mmcKYgyZ7Wib/a+gl0eKhwEupB1szBnXErvoKaWO5AtoACCo1IwO+kMsyL6iaQ
 QyQUuHrGpDEmj5qr9Te8Viv3238WB70qO/x6iMa0dsQ7KgyiKF4Crnquui1DlCxxiF
 gazt3TEsIF0soSyzqiCSLiBZeFUgNFzHZpNSbnzbu6C/gdjtZpRUJQqTkCJxaqlOFq
 KSjSSUClHMhXaxwfqX/afQGUFCmmNe1LWjFEi8Habzo6Y9Z4bpyo7PXcAH3D4OCRwy
 Mzw+KC33oVmJeBmFOEYVCEWdDDnqO1NpIclwbjLwGg6FwWR3XJn82XAx9huEinNS8W
 m2mMIyDwjt74g==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:40 +0200
Subject: [PATCH 64/70] drm/solomon: ssd130x: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-64-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2290; i=mripard@kernel.org;
 h=from:subject:message-id; bh=xCZIQg76b8+5IKkTJRUeCX+6NhiXKPbCay6Tj+7zeW0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdySKvzj6fpPfi/bEZuq/nPz1xwfFyWsnh2y379nTwv
 AjV/BIl0TGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAm4l3H2HAp5rdHnNaVbvub
 i4oj9n+1jnm3bnHc6uDFuoUrO9Yd8eo71KNgnlLtkP1wipP3dtkKDcaG5X63Tljva56stVlmJWe
 klf6e3S/fPdqbeEtv9c46rXfVTxgsv4UfUPbV3fU5/YGN+MJ8AA==
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

The ssd130x crtc implementation provides a custom reset hook. However,
this hook only allocates the state, initializes it with
__drm_atomic_helper_crtc_reset(), and frees the previous state. It
does not perform any hardware reset.

Since this is exactly what the atomic_create_state hook is meant to
do, minus the old state cleanup which the caller handles, convert the
implementation to use atomic_create_state with
__drm_atomic_helper_crtc_state_init() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 0b0fc6fe3df2..ff112d8094c3 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -1465,21 +1465,23 @@ static int ssd133x_crtc_atomic_check(struct drm_crtc *crtc,
 
 	return 0;
 }
 
 /* Called during init to allocate the CRTC's atomic state. */
-static void ssd130x_crtc_reset(struct drm_crtc *crtc)
+static struct drm_crtc_state *ssd130x_crtc_create_state(struct drm_crtc *crtc)
 {
 	struct ssd130x_crtc_state *ssd130x_state;
 
 	drm_WARN_ON_ONCE(crtc->dev, crtc->state);
 
 	ssd130x_state = kzalloc_obj(*ssd130x_state);
 	if (!ssd130x_state)
-		return;
+		return ERR_PTR(-ENOMEM);
 
-	__drm_atomic_helper_crtc_reset(crtc, &ssd130x_state->base);
+	__drm_atomic_helper_crtc_state_init(&ssd130x_state->base, crtc);
+
+	return &ssd130x_state->base;
 }
 
 static struct drm_crtc_state *ssd130x_crtc_duplicate_state(struct drm_crtc *crtc)
 {
 	struct ssd130x_crtc_state *old_ssd130x_state;
@@ -1532,11 +1534,11 @@ static const struct drm_crtc_helper_funcs ssd130x_crtc_helper_funcs[] = {
 		.atomic_check = ssd133x_crtc_atomic_check,
 	},
 };
 
 static const struct drm_crtc_funcs ssd130x_crtc_funcs = {
-	.reset = ssd130x_crtc_reset,
+	.atomic_create_state = ssd130x_crtc_create_state,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = ssd130x_crtc_duplicate_state,
 	.atomic_destroy_state = ssd130x_crtc_destroy_state,

-- 
2.55.0

