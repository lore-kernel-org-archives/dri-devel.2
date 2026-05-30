Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313F3CD5BD0
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78A5011283D;
	Sat, 30 May 2026 14:03:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DYEdlvcP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD23A11283E
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:02:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B598540878;
 Sat, 30 May 2026 14:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2624C1F008A0;
 Sat, 30 May 2026 14:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149753;
 bh=rIcYAqyZnzeCpwcv/SdJdhMKgVQqE4Y5D67Vid8jK6Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=DYEdlvcPWU8+IlQW/Elor8jKC321bkGTNrvmnktVfdXrBC3eyWYcw1bYBg5BofVej
 LsuRaSjGmRQjwtRa2XTzD4Rhcvy2IgHL8fczBmMyOT61lSRDqV1do42UHigG5C7Wby
 kv9DyDYtGSzaAPb9Ww+DVDj9Tm4pyI5TOEByJUGA0Gq37QHEvu1ayTlJvmFWw75gtF
 9Uv+54yLoOBYeGMto/Jrk/VvAuiVsv4fvSTLAVFgbXScElbV9Xt73KjhqUieuLM/CC
 +vKqB+9rSaMnpB849+lNAElUYf6D99fJxoINpNfUSBKy0KNg7oLOOAp2JZo8m9lst9
 qT9pMb38wDN4g==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 16:00:04 +0200
Subject: [PATCH 59/76] drm/renesas: rcar-du: lvds: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-59-875d828d31bc@kernel.org>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1603; i=mripard@kernel.org;
 h=from:subject:message-id; bh=YWxGgR3lMNyHxWzU2V/s1BnCMgdON7Fb65+tP9DASBY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb/19eGe+L3rdJPjl/vWo7vkHzC7KRSrVKkl2vrZZK
 5oqco21YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzkxDbGhiXm/e09T9yOrd/y
 /WVitdcTiaUHa0u+dF34xKT3NYptN9vEmjU53OWnPgYXapz9v/GjBGNDw9zFHq09+jMTZik/m/O
 j351d+PdK5vZVkbv9bYQKpBavKnEp9Mnb46MRtuzr31DrjF4A
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

The drm_bridge_funcs.atomic_reset callback and its
drm_atomic_helper_bridge_reset() helper are deprecated.

Switch to the atomic_create_state callback and its
drm_atomic_helper_bridge_create_state() counterpart.

Signed-off-by: Maxime Ripard <mripard@kernel.org>

---
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c b/drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c
index 154410745a74..e433ce61d431 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c
@@ -656,11 +656,11 @@ static int rcar_lvds_attach(struct drm_bridge *bridge,
 static const struct drm_bridge_funcs rcar_lvds_bridge_ops = {
 	.attach = rcar_lvds_attach,
 	.destroy = rcar_lvds_destroy,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_enable = rcar_lvds_atomic_enable,
 	.atomic_disable = rcar_lvds_atomic_disable,
 	.mode_fixup = rcar_lvds_mode_fixup,
 };
 

-- 
2.54.0

