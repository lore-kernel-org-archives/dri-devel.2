Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C08EC55179
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ABBB10E6DF;
	Mon,  3 Aug 2026 14:57:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="CioNybO9";
	dkim-atps=neutral
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch
 [79.135.106.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22AB810E6EA
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 14:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1785769035; x=1786028235;
 bh=G3qiWzBEND8YgpNWecgDdwzMBBEEvdJc+STZBSOtEJE=;
 h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=CioNybO9VCnr9CruU4lvqeWs3ix6wMQpfQamwjFJ8nNZvgeNHGDM7YnguZb3Gmha3
 b5L67nnd31yeowDQ2o2x8wX9wC7LhKWQ+f9XMZ3Ch6W3GJQezAn+mFtgIk2rJetOEs
 6OxGyGiv6pqC+hfeAP/YfS0OgoGz7MsS8qGSoQzl5k4Kf0GMRJtvIpPSCBiwQYmzlA
 cgb970SaE8AkdxY1JnJS35f/NiHV7SNGGxLW5aU9I6cP6lwU9xq/vuQiqq6FJywCLV
 pu8QtUGlK3GeVLB5C/WNs6nXi2mhCeGnyUl4M5JcgM8pWXh/ASlm6MahItw140ZiaN
 tfZUlb+P+KZYA==
X-Pm-Submission-Id: 4hDKX85XNYz2Sd49
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 03 Aug 2026 16:57:04 +0200
Subject: [PATCH v3 2/3] drm/bridge: ti-sn65dsi83: Fix error handling in
 sn65dsi83_reset_work()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-ti-sn65dsi83-fixes-v3-2-9b403a405ccd@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785769029; l=812;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=JjiHpZszbJpucQsbmOMl8d52BhhvfvUVXtcScjW0e9c=;
 b=xHK6bAA+3PEjRSHluSTwuxnNOSWPCYfSWEuEaYm+hQ5ccZirOB0t/VPTJrHZzaLgeHpXf6+a+
 duJNFYqqtMiD/wAPgWwlhmnFlxxyGaPyKSbpFTNOVOS2KXVu5VXheHh
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

We obviously should not leave the DRM bridge critical section activated
when exiting on error.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 476f255bd34d..5551845ea0dd 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -419,11 +419,12 @@ static void sn65dsi83_reset_work(struct work_struct *ws)
 	ret = sn65dsi83_reset_pipe(ctx);
 	if (ret) {
 		dev_err(ctx->dev, "reset pipe failed %pe\n", ERR_PTR(ret));
-		return;
+		goto err_exit;
 	}
 	if (ctx->irq)
 		enable_irq(ctx->irq);
 
+err_exit:
 	drm_bridge_exit(idx);
 }
 

-- 
2.55.0

