Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6308CDB466
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:26:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE4410F58C;
	Fri, 19 Jun 2026 12:26:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XZlRGwxr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D610710F585
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:26:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3E746601E1;
 Fri, 19 Jun 2026 12:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8131F000E9;
 Fri, 19 Jun 2026 12:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871967;
 bh=Lp21qpWXh1ZOuPmiZAgwNbziAL0lC7UyW+zBO2hxiAs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=XZlRGwxrcbZoHHGQxwCdXlmz2rD8AFHbBf/TMpEGxZZlro4ZJRuZ79Ce2QknAd5cJ
 RoZQthIJjLrkq4k3Mj0MsA16Se0HbnYzUb4TzHa0RCPqxYF6qxFTd7LBx+atm5Du3B
 2s9Eji1srBPe6iS3v/BRn04T2JzrBAPeA+VfWrduS4pE1e0+Tb+u/A4s4HBaZ5XMsu
 K94YHxiCK80SiuE7QgRRb0u1ThtiCCygdg7C5vjWYGudBqZbic1MZ5IHPAhG9QtmwO
 W70BxzJQAneJLKElSNCbnJ1ApoFC+dmyBSDf5hKtBs8iDb2woYKVw+GytLslN/eQHG
 IM6iHFI1jth0g==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:35 +0200
Subject: [PATCH v3 30/78] drm/bridge: samsung-dsim: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-30-ff399263111b@kernel.org>
References: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
In-Reply-To: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1554; i=mripard@kernel.org;
 h=from:subject:message-id; bh=T6YpHJwhuEx4nQntGyTzxb1pIDVWPbk7XQR3zIYEFJc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJt+Zdr9x32Qy88znlYzyjzdWnj5wSmKO7p+Zvie+R
 S1USz1U3jGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmYvCQsT52l4oW/8NjC20M
 DPduFNjkfWVVgO797G+P/5r+L248PnnnRrH0I3sKJpTe/mSw9qBxWBljndaVeY3fA6L7tGM6m2v
 MBRiPK0z/bqi8kfmP7JcX3n/94qUqVZ1DppjM7bQ9dGi3I+tnAA==
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

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
To: Inki Dae <inki.dae@samsung.com>
To: Jagan Teki <jagan@amarulasolutions.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 9ee0515074c7..5788066d479e 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1833,11 +1833,11 @@ static int samsung_dsim_attach(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs samsung_dsim_bridge_funcs = {
 	.atomic_duplicate_state		= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state		= drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset			= drm_atomic_helper_bridge_reset,
+	.atomic_create_state			= drm_atomic_helper_bridge_create_state,
 	.atomic_get_input_bus_fmts	= samsung_dsim_atomic_get_input_bus_fmts,
 	.atomic_check			= samsung_dsim_atomic_check,
 	.atomic_pre_enable		= samsung_dsim_atomic_pre_enable,
 	.atomic_enable			= samsung_dsim_atomic_enable,
 	.atomic_disable			= samsung_dsim_atomic_disable,

-- 
2.54.0

