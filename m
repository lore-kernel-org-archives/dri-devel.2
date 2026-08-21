Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D14C5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 088CF10F2F8;
	Fri, 21 Aug 2026 14:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XW5AnUnH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A386810F2EC
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:41:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0C5556187C;
 Fri, 21 Aug 2026 14:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FB11F000E9;
 Fri, 21 Aug 2026 14:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323311;
 bh=SQV0RhKI0HjCxVM0ccESERvchiiNLBUT39W/zgICvGw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=XW5AnUnHi/JEFCOEzVvcBOnRRipMHBKbz35bNX42JWhIH21bKpzf6W18mp2ffn2Y+
 u3sEoHLzh6limfq9g9KsSFuTZAKiXXRvfvDYBrxoaYW/h31EfUQganCHqQgxt1TvyL
 ed2xVJ9Y9WoZDirU6m4PlicjjqeW6bEHIlj1YxMg0Cyt6DH8kotCKPSimxHvvwxRVT
 rDJJzcJLn/IWm7DmXmLJOsNgUAH/8xuVgu6QHeeLKt44LOdnbKlTAqkyb4NzRRa3W1
 Ba/ufRdE+Dw8GEW7Kv224/Bo885zhiIedxWj/O+plac8chJYGytklu4n6bHBFuYwgY
 yCZb13GxMtzEw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:38 +0200
Subject: [PATCH 62/70] drm/rockchip: vop2: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-62-fb793475c05a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2389; i=mripard@kernel.org;
 h=from:subject:message-id; bh=tIQAUDVM3QuR+HEdoF0CNR//Y7qOtSSSYkp0Z+DU4eA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdycLcxot59Msy1v0/N3dST8+VhGSXs1etz3z9M+1B+
 vkfj1OcOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEuHIZG6apr0tPMuzYcWKH
 letyp5M9vPmRPGvn7P105cGSp+ZdK10fy9kqr27zmOX4UXDNpFuR0ox1BiyRO6MCNf84q3EEXYn
 cE64+K2XfhUeJk//xv/N5uazIKtrbv3JRUNb7yuOsDu1zN20GAA==
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

The rockchip vop2 crtc implementation provides a custom reset hook.
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
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 4cce3e336f5b..b2f3a579bbe5 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -2298,28 +2298,28 @@ static void vop2_crtc_destroy_state(struct drm_crtc *crtc,
 
 	__drm_atomic_helper_crtc_destroy_state(&vcstate->base);
 	kfree(vcstate);
 }
 
-static void vop2_crtc_reset(struct drm_crtc *crtc)
+static struct drm_crtc_state *vop2_crtc_create_state(struct drm_crtc *crtc)
 {
-	struct rockchip_crtc_state *vcstate = kzalloc_obj(*vcstate);
+	struct rockchip_crtc_state *vcstate;
 
-	if (crtc->state)
-		vop2_crtc_destroy_state(crtc, crtc->state);
+	vcstate = kzalloc_obj(*vcstate);
+	if (!vcstate)
+		return ERR_PTR(-ENOMEM);
 
-	if (vcstate)
-		__drm_atomic_helper_crtc_reset(crtc, &vcstate->base);
-	else
-		__drm_atomic_helper_crtc_reset(crtc, NULL);
+	__drm_atomic_helper_crtc_state_init(&vcstate->base, crtc);
+
+	return &vcstate->base;
 }
 
 static const struct drm_crtc_funcs vop2_crtc_funcs = {
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.destroy = drm_crtc_cleanup,
-	.reset = vop2_crtc_reset,
+	.atomic_create_state = vop2_crtc_create_state,
 	.atomic_duplicate_state = vop2_crtc_duplicate_state,
 	.atomic_destroy_state = vop2_crtc_destroy_state,
 	.enable_vblank = vop2_crtc_enable_vblank,
 	.disable_vblank = vop2_crtc_disable_vblank,
 	.late_register = vop2_crtc_late_register,

-- 
2.55.0

