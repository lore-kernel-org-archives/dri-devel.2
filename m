Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23D3C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87B7410F045;
	Wed, 15 Jul 2026 13:11:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="k87kdcNQ";
	dkim-atps=neutral
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch
 [185.70.43.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8610910F03F
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 13:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1784121051; x=1784380251;
 bh=bvnCK9zE294VXKOxxjcJyhzGq6cZwjwnuShfZcjBV+A=;
 h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=k87kdcNQbHAnPU+n8Wb2MzBmWnVPNPR0jWhBBXusjUIUZ6qFOX/AM2Fp3kLP47N0s
 1U6SRgRbdA93gKWnCZtMWdsyprhVuGAHF+n9RKLrjVR3AmGFhj6ATHGoiw99XIPvbY
 LCFA+1KPfhsY1qV8B0qW9aBMc3rkWO/UvxtSKUSGPmbYjSuHnEiYIafZXJWdjaKzpp
 QAJnMIKCzCodsd2CU699sWU+tPJReD+7Epeji7Ox2J9IotYFRHudFlSMKk9Um4swxB
 9SNWBtc1c4s5pqZOO/7J8iRX7+3n5j2hL8WVn/MoJG2LhaCzHCm+lxAmYIBRezuY9L
 O/Pva8BrzE3iw==
X-Pm-Submission-Id: 4h0c4B3dP4z1DFT1
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 15 Jul 2026 15:10:32 +0200
Subject: [PATCH v2 2/3] drm/bridge: ti-sn65dsi83: Fix error handling in
 sn65dsi83_reset_work()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-ti-sn65dsi83-fixes-v2-2-ebc4c3fe29b6@geanix.com>
References: <20260715-ti-sn65dsi83-fixes-v2-0-ebc4c3fe29b6@geanix.com>
In-Reply-To: <20260715-ti-sn65dsi83-fixes-v2-0-ebc4c3fe29b6@geanix.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Linus Walleij <linusw@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>
Cc: Esben Haabendal <esben@geanix.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784121041; l=812;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=ITOwL8ADYC6nHslPXggZi9M5w3jOfE4CtNZcTfv7AG4=;
 b=c4ISSN2oJdlT1eMaUtqLk/lirNij8z40jLNaPlgQKNmm60kTmGQnoZArtWcOZ8w/g80m7Rpuo
 e1frjxgvukEDAB1HWxQJj1hk9voO2qesA6MgvKHoXSzbwEEhTU5GFzZ
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
index b4b220eee790..7e73035d7798 100644
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

