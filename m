Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244E9C982C5
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E80D10E44B;
	Wed, 16 Sep 2026 08:56:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cO38XZeA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8749810E8E5
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 08:56:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 821B26053D;
 Wed, 16 Sep 2026 08:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51F91F00893;
 Wed, 16 Sep 2026 08:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789548963;
 bh=IxTtBrnJdBiEi2vAF9JJ92eynJfbWmFWcFfdtAJ2Gus=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=cO38XZeAV9Sn0rj+k5YrMBookFUr8RUVi8fFQg+xIp0uD7ZBEW9V7OBsX8ienlD/w
 /KG2j+AS466bAoZSRahlL9CdN19Kex67wpjwfp/ODr42/+m71L+h23U5sSdgyy1y7L
 OeujgOMMzR4uPIxCIzSVu2ZLJoSutgzjDDMfB5TiBu7Heubm5RDSruCvIyGeFNpWHh
 RFV38n4j8ZG6kP8AzzMDUzsQJLCxfBtCM3pkDFITpSQ7WnWHydo0aIPl7HxidYaLfP
 Uo/gGXkaQ4Zk2ZOIqgG5sfc46yWZ+9CoX5SS+IDO9rMtJu6wSxO8muxY7TbqV4Ua3t
 GPbQ5izG47vDA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 16 Sep 2026 10:55:45 +0200
Subject: [PATCH v5 2/9] drm/aspeed: Switch to
 drm_atomic_helper_plane_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-drm-no-more-plane-reset-v5-2-f590d2003f2c@kernel.org>
References: <20260916-drm-no-more-plane-reset-v5-0-f590d2003f2c@kernel.org>
In-Reply-To: <20260916-drm-no-more-plane-reset-v5-0-f590d2003f2c@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1207; i=mripard@kernel.org;
 h=from:subject:message-id; bh=mMjjlcHt6sBMSymWsCRQjKw04hH0XR1G6lUfunwSAO4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmrIqfI+TTdVQyJEZgucTIvM1e0z/x75jtDKYN9SazTN
 N2O8S7smMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABO5fJaxPrlS2FM7Oi110oWp
 tUbrjzLpJ3tFnmUXe7fxWeXj+IbPOg+WqmR+/bXa2yJmXeE1IQt+xoaLKzRbT90Qzft5NjxZgWX
 h2S9ZswQnp10ynXrj8Y/iaqefH/nTbJUCgze93bMu+H6ogRMA
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

The aspeed plane implementation uses the deprecated
drm_atomic_helper_plane_reset() as its reset hook.

Switch to drm_atomic_helper_plane_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
index 31e11322b2ab..918b8b4dc863 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
@@ -228,11 +228,11 @@ static const struct drm_plane_helper_funcs aspeed_gfx_plane_helper_funcs = {
 
 static const struct drm_plane_funcs aspeed_gfx_plane_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
 	.destroy		= drm_plane_cleanup,
-	.reset			= drm_atomic_helper_plane_reset,
+	.atomic_create_state	= drm_atomic_helper_plane_create_state,
 	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
 };
 
 static int aspeed_gfx_crtc_helper_atomic_check(struct drm_crtc *crtc,

-- 
2.55.0

