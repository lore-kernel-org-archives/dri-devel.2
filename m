Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64143C5DF93
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 233B310F2DC;
	Fri, 21 Aug 2026 14:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YNYein4o";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 691B410F2D4
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:41:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E15BA6136F;
 Fri, 21 Aug 2026 14:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6A11F00A3A;
 Fri, 21 Aug 2026 14:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323287;
 bh=Nys7OmgNBHq6AwUH0BlpS/nXb/dH4O6UQW+gpEBQbi4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=YNYein4oH2ZXdjlAqI4kLnb3ebgX2IGx/7+loNycUe2yQfP0mm2UNG4xr3td7RqoZ
 R8FS0j7ZLDfXkANrBWLBlIoQ587DQ6FpDPCfC4EhAImXN/svvPsVFcrAIZ9U6t6FSY
 mOSXsyfnkrhIaBD5FQC4gw6URVLt0g/tSG9AKY399P7lAM/q+aHAUTULSYtD7qYkdn
 dIyfBiEJ9RYJVAMjTbYRWcnaoxsWF6a4mu6HHb0x79kf7k76ALJcVOM40fyQ9J30u4
 aWmqorqPvv59BCnwUm8xHkPNJ6E0bwTQJFDyJ8+Cv/GBG+Atxl8MJBNby2ycc3j+/8
 SaZHIUzaPATEA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:28 +0200
Subject: [PATCH 52/70] drm/mediatek: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-52-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2434; i=mripard@kernel.org;
 h=from:subject:message-id; bh=jMDM2v9tlh4PDvxici6b9CDdwOx9G6RPSkZCG5enZ8s=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyfx/T5z6JWJQ8/t8tF65eMmBiuhZrwSFPz5zXpH7d
 7WnrNa0jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRl3yMNfxXIuYYPA6cfMXN
 YUJtzX3dAq6Lh9bMEnb9tV+dJ+RGt5OcVuu/7Ct6zHn5Z9o/tZ2yZWzYJ+XzfNdrjoT4hbq3F+y
 YqfJI6caqbIH6GAEOhok3Wt6d2nHykLem8GLXIxrpzdcNPJ4CAA==
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

The mediatek crtc implementation provides a custom reset hook.
However, this hook only allocates the state, initializes it with
__drm_atomic_helper_crtc_reset(), and frees the previous state. It
does not perform any hardware reset.

Since this is exactly what the atomic_create_state hook is meant to
do, minus the old state cleanup which the caller handles, convert the
implementation to use atomic_create_state with
__drm_atomic_helper_crtc_state_init() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/drm/mediatek/mtk_crtc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index 8e552cdc3b53..fd4b19efee52 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -148,23 +148,21 @@ static void mtk_crtc_destroy(struct drm_crtc *crtc)
 	}
 
 	drm_crtc_cleanup(crtc);
 }
 
-static void mtk_crtc_reset(struct drm_crtc *crtc)
+static struct drm_crtc_state *mtk_crtc_create_state(struct drm_crtc *crtc)
 {
 	struct mtk_crtc_state *state;
 
-	if (crtc->state)
-		__drm_atomic_helper_crtc_destroy_state(crtc->state);
-
-	kfree(to_mtk_crtc_state(crtc->state));
-	crtc->state = NULL;
-
 	state = kzalloc_obj(*state);
-	if (state)
-		__drm_atomic_helper_crtc_reset(crtc, &state->base);
+	if (!state)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_atomic_helper_crtc_state_init(&state->base, crtc);
+
+	return &state->base;
 }
 
 static struct drm_crtc_state *mtk_crtc_duplicate_state(struct drm_crtc *crtc)
 {
 	struct mtk_crtc_state *state;
@@ -884,11 +882,11 @@ static void mtk_crtc_atomic_flush(struct drm_crtc *crtc,
 
 static const struct drm_crtc_funcs mtk_crtc_funcs = {
 	.set_config		= drm_atomic_helper_set_config,
 	.page_flip		= drm_atomic_helper_page_flip,
 	.destroy		= mtk_crtc_destroy,
-	.reset			= mtk_crtc_reset,
+	.atomic_create_state = mtk_crtc_create_state,
 	.atomic_duplicate_state	= mtk_crtc_duplicate_state,
 	.atomic_destroy_state	= mtk_crtc_destroy_state,
 	.enable_vblank		= mtk_crtc_enable_vblank,
 	.disable_vblank		= mtk_crtc_disable_vblank,
 };

-- 
2.55.0

