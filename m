Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE799CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50F9E10FEB8;
	Wed, 14 Oct 2026 17:28:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FE9D10FEBE
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:28:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 87FA04184E;
 Wed, 14 Oct 2026 17:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E521B1F000C4;
 Wed, 14 Oct 2026 17:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998901;
 bh=N1u6G1o3UUqJ1FoMAyhjhEGWylyxD8b/RPmzMUWwR1U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Q6Tw3qst6OOtHuoWR7QrMq2K2KQYDvwO+DYKqEFuxW3EUOO0Qwrnz6csGsvLrtw73
 KCoupuImIr6Xr3TJtbG8oAEt3KrwSQ2RLlkjstuly4W+37y1xpd6GQS2X2vkn62jZe
 mICZ8FlQBOnzQBNvlLywrNPlFp1wDODqzJaIbPSXs7Hee2SEjlxL1gSELffIaC5lhe
 Pm56+npYCqR0IxWzsV6jvBK5Vb7AXJfzYj5Fn763eRY8K/Cb7tEVAfCDkn4qgi34PX
 c8P0KpQ+iZ4mdZQyCoN1JvwtQ+b/m38wCXzcN+oj9YbH+FRhtlatxtdknVCkbznkwz
 yrsPjOnOwMH/w==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:42 +0200
Subject: [PATCH 19/75] drm/bridge: tda998x: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-19-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Russell King <linux@armlinux.org.uk>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1227; i=mripard@kernel.org;
 h=from:subject:message-id; bh=2sB61rLTbrOVEbOz1uqa43bFJV27XfyMwGWQQ429Ea4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnndwfNcOUN/LVtc82nvtthypFnzflrBZrNg/0mR3vtY
 9jOzPitYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExER4uxobGzKMfs+iSB9Jjj
 m+x+M6b672cT3fSVqaR4ze976VdfrvlWtj35KL/Yyd3tJzmOSh6wYqz3KUyzz+86Hn2Pa7W61Ze
 2q4dKYpj+ZJb67jf7Wrn7jVz60l4hQcP2y6ZzDY6UtComcAEA
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

The bridge: tda998x connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Russell King <linux@armlinux.org.uk>
---
 drivers/gpu/drm/bridge/tda998x_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tda998x_drv.c b/drivers/gpu/drm/bridge/tda998x_drv.c
index 0b966c9844e7..b9185bd3d8e1 100644
--- a/drivers/gpu/drm/bridge/tda998x_drv.c
+++ b/drivers/gpu/drm/bridge/tda998x_drv.c
@@ -1208,11 +1208,11 @@ tda998x_connector_detect(struct drm_connector *connector, bool force)
 
 	return tda998x_conn_detect(priv);
 }
 
 static const struct drm_connector_funcs tda998x_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = tda998x_connector_detect,
 	.destroy = drm_connector_cleanup,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

