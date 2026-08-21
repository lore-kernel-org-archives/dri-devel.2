Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73236C5DF93
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 474CC10F2EC;
	Fri, 21 Aug 2026 14:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oRAnMYL4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D05510F2EC
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:41:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9E4EC6187B;
 Fri, 21 Aug 2026 14:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1AA1F00A3E;
 Fri, 21 Aug 2026 14:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323309;
 bh=TBXd7/4Rqp6FiQW2cUZbg8tqHqkkn81QlQlR8YTCzTw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=oRAnMYL4ZLMIuGPbX8sz5CzD+LPHfx4DEe4wCg46X1xFzviJf1rdyJx0h6S/VMjqS
 KA0nbdQ8pHO3R34darHcuOAyKtUtGsqY6QY+6GRvJ7fBOAea9fsGanGv7K2ituc2Bq
 LYM9Z+WUxZ37+SzbfLvwOOgHcrwtNcSMdJdmb5S85oQG2rCTme6GuRZega55grgsDk
 BdR4wAgejHMAtbhyUFqdJJxACEJzQr2SZki4f23DAOTjubYmBouRcKT+YW9jDkul/N
 iFU3zBoH4ZkWlNJaHYOR6Hkj64RaSfdOEqyVf9+TA2FEs0y6tOst/WBJioXDNdIB4a
 OHdfv2f65v3aw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:37 +0200
Subject: [PATCH 61/70] drm/rockchip: vop: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-61-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Sandy Huang <hjc@rock-chips.com>, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2600; i=mripard@kernel.org;
 h=from:subject:message-id; bh=bfFf2guEIBmZHiLt3zPAdPPtsiW6cXZqlcuZTPqYWsA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdycI3E9Yt3CTDaZDn8NLuhrZ081PzC9cEO+/9ZFtvV
 disGNzYMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACby5y1jw2ePhqyvMRWFG5Wb
 BV5ci5wqvcqH3TFk+ivfzScuCzHJXL4efuPGwb1W56sFrH2PMoZuZqwvqNXdyzQ/K9Jue484l5Z
 jU9f3m9mmCQ+eMxt5VS6cJazDP+mfk98n9li5+eVe2WmOVQA=
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

The rockchip vop crtc implementation provides a custom reset hook.
However, this hook only allocates the state, initializes it with
__drm_atomic_helper_crtc_reset(), and frees the previous state. It
does not perform any hardware reset.

Since this is exactly what the atomic_create_state hook is meant to
do, minus the old state cleanup which the caller handles, convert the
implementation to use atomic_create_state with
__drm_atomic_helper_crtc_state_init() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: Sandy Huang <hjc@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 0090d8ff0c79..bd02597dc2d7 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1654,21 +1654,21 @@ static void vop_crtc_destroy_state(struct drm_crtc *crtc,
 
 	__drm_atomic_helper_crtc_destroy_state(&s->base);
 	kfree(s);
 }
 
-static void vop_crtc_reset(struct drm_crtc *crtc)
+static struct drm_crtc_state *vop_crtc_create_state(struct drm_crtc *crtc)
 {
-	struct rockchip_crtc_state *crtc_state = kzalloc_obj(*crtc_state);
+	struct rockchip_crtc_state *crtc_state;
 
-	if (crtc->state)
-		vop_crtc_destroy_state(crtc, crtc->state);
+	crtc_state = kzalloc_obj(*crtc_state);
+	if (!crtc_state)
+		return ERR_PTR(-ENOMEM);
 
-	if (crtc_state)
-		__drm_atomic_helper_crtc_reset(crtc, &crtc_state->base);
-	else
-		__drm_atomic_helper_crtc_reset(crtc, NULL);
+	__drm_atomic_helper_crtc_state_init(&crtc_state->base, crtc);
+
+	return &crtc_state->base;
 }
 
 #ifdef CONFIG_DRM_ANALOGIX_DP
 static struct drm_connector *vop_get_edp_connector(struct vop *vop)
 {
@@ -1736,11 +1736,11 @@ vop_crtc_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
 
 static const struct drm_crtc_funcs vop_crtc_funcs = {
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.destroy = drm_crtc_cleanup,
-	.reset = vop_crtc_reset,
+	.atomic_create_state = vop_crtc_create_state,
 	.atomic_duplicate_state = vop_crtc_duplicate_state,
 	.atomic_destroy_state = vop_crtc_destroy_state,
 	.enable_vblank = vop_crtc_enable_vblank,
 	.disable_vblank = vop_crtc_disable_vblank,
 	.set_crc_source = vop_crtc_set_crc_source,

-- 
2.55.0

