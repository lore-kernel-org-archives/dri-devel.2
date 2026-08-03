Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36199C5518F
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EF6B10E6F2;
	Mon,  3 Aug 2026 14:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="p/fVK14s";
	dkim-atps=neutral
Received: from mail-244102.protonmail.ch (mail-244102.protonmail.ch
 [109.224.244.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BC2E10E6EB
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 14:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1785769032; x=1786028232;
 bh=lWFNcg3Z0aeqqXp77FdcarolwwC73/Be0zDs18Ibqlk=;
 h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=p/fVK14sXxOEJ8mWVYa/gC3/sLDs4ARqlfhksFd97oPEmULMm78mrYLy34U9RC/Fm
 h6LwBDyrFtE01vu6pggUeCu/DxGpkFuWLBv6iK29CzwCdZppjsR4tO2drVokVza2nX
 xUAKDy71NwvJ0xwldCTm73mQv1aRIsti5Wls9HBybJy6PSDOYvnNutXUBO0Csopmg5
 /ZhvEWoYZg829w7zQbtX1P6wZwS0D4Fz4BMSRkNzLfXVPJI0PobsiMYql662DxcVM/
 T+CP9qc212XfyaUtDcom9rkz9jnW9WQeFyDELTqVYH4GjrF8XjWrgdCDT7nQllhcWw
 8puVtB00Ve4DQ==
X-Pm-Submission-Id: 4hDKX71qhHz2ScQ9
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 03 Aug 2026 16:57:03 +0200
Subject: [PATCH v3 1/3] drm/bridge: ti-sn65dsi83: Propagate error in
 sn65dsi83_reset_pipe()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-ti-sn65dsi83-fixes-v3-1-9b403a405ccd@geanix.com>
References: <20260803-ti-sn65dsi83-fixes-v3-0-9b403a405ccd@geanix.com>
In-Reply-To: <20260803-ti-sn65dsi83-fixes-v3-0-9b403a405ccd@geanix.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Linus Walleij <linusw@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>
Cc: Esben Haabendal <esben@geanix.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785769029; l=756;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=bLWFQzGGZZzZ81AoA17VFOtTn8HPelQlz4iKIBMhusI=;
 b=PJodPx3YdSEoMORx54kk+TPVbypksNqcUrYpNWh8UdalKP1+ZLSat/t78wRT3Vb7foTSdbuOp
 RHJrz+urxDqCV9/Yu9XL1KvOeG6TWZ2gyrAjxWA2RS9L5fYh02t4Icq
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
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

Propagate the error code from drm_bridge_helper_reset_crtc(), so that
callers has a chance to handle the failure.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 42b451432bbb..476f255bd34d 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -403,7 +403,7 @@ static int sn65dsi83_reset_pipe(struct sn65dsi83 *sn65dsi83)
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 
-	return 0;
+	return err;
 }
 
 static void sn65dsi83_reset_work(struct work_struct *ws)

-- 
2.55.0

