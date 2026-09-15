Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0FAC88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:25:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0447210EC40;
	Tue, 15 Sep 2026 14:25:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iqCPpk/3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75E6F10E57E
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 14:25:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E29943C77;
 Tue, 15 Sep 2026 14:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDC41F000FF;
 Tue, 15 Sep 2026 14:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789482301;
 bh=M5G8JqgBHThC6WLKefWMhzPYnuhWF5HN813geqTKkWk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=iqCPpk/3+vxAnDCpv6799Kq75WIYJwxeFwtxxpyXN4WYmAFVIDBbxFyp1duHEof4V
 gANufBP1JsWGRRAqtKx0pgsW3phHGXmGfLAGPLLfSizdhrKaJsIjrAeo8GnZNmdhYd
 i48PCW9+T6c3up8x1P9+MNdpRbvuLf/m438XxLJ7dNN2diu/whbxAywYTO8y2JWaTY
 20GtxwQqM6UhZb+m4bgp6KhPgA/TUbnoBVbWGVy9t2n1bkvNZEr96tc7zEpHNd+xEm
 z2io1wLer/DF7oqkWwumiLL/RZCoeQRVIK9yWRWxzLabLSe+gC55ZepB2I0XgVp6bO
 vltXUVMkIXdcA==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 15 Sep 2026 16:24:43 +0200
Subject: [PATCH v5 02/11] drm/aspeed: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-drm-no-more-crtc-reset-v5-2-bda007735748@kernel.org>
References: <20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org>
In-Reply-To: <20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1224; i=mripard@kernel.org;
 h=from:subject:message-id; bh=2V8EsL03ipDK5UNiGLELT9zDxwxCa8q8difPE/+SANo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkrQ3VvTeyZnHn2Wc7rkJxp19T8/9t/yOeKMP+8ZfntS
 y3e/xPqO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEQjwY6zSPXD3B7Bmi63nK
 yjmV69jJ/Ynfa04lH+c8GzPn5wyWbyENr+fNu7J/5r6+lSddzxXcvMNYK3Ilbb7d1GM9cx4+Wiy
 c/shu2tvs/Td6Iq7GreacY7DnjBmH2CG+3oZEJdnDQvkvTlq1AQA=
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

The aspeed crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
index e8c9a6040d75..31e11322b2ab 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
@@ -275,11 +275,11 @@ static const struct drm_crtc_helper_funcs aspeed_gfx_crtc_helper_funcs = {
 	.atomic_disable	= aspeed_gfx_crtc_helper_atomic_disable,
 	.atomic_flush	= aspeed_gfx_crtc_helper_atomic_flush,
 };
 
 static const struct drm_crtc_funcs aspeed_gfx_crtc_funcs = {
-	.reset			= drm_atomic_helper_crtc_reset,
+	.atomic_create_state	= drm_atomic_helper_crtc_create_state,
 	.destroy		= drm_crtc_cleanup,
 	.set_config		= drm_atomic_helper_set_config,
 	.page_flip		= drm_atomic_helper_page_flip,
 	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,

-- 
2.55.0

