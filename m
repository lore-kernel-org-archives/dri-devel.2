Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E03C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 17:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2103F10F06F;
	Wed,  1 Jul 2026 17:19:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="MO3Sunbl";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F31F10F06F
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 17:19:51 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id C267E1A0DC1;
 Wed,  1 Jul 2026 17:19:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 95C3B5FD9D;
 Wed,  1 Jul 2026 17:19:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 726A0104C948E; 
 Wed,  1 Jul 2026 19:19:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782926388; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=/VkaAA+a78sL/L5XhJhL2XVfDGKFCrDanUkXyRodub0=;
 b=MO3SunblCQWGlwkKGDGdB3rjKzwq0fdfsBAlq9mrJQbyZ0IUmMNjLiCi37eXRiQovmwvNi
 k8OwkTzM1w5nYqYFtOFxeMKxuKkMAmmT52JuVaQrqIT54Ed7tZUoGwqapi624dYXvrnUJw
 X2jXCHj+/Wco5xuatTbmkuVxL49tApvC27IV0730K7m7FObLTeSUaG4bhjtnRVic+UyCTs
 FzcQ9gXiXTNn9eJmTevqHahNpkV129nw6DmH/MpVpmfRKWW8DnfAXVXTIcHrS1OwsdSLFp
 +wq5MxGqm8L+4KgY/MPX3SqluNVov4NoZI9silD43FmvHg/CQ/9O3zU/rUUkQw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 01 Jul 2026 19:19:38 +0200
Subject: [PATCH 1/3] drm: of: fix wording in comment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-drm-fix-graph-wording-v1-1-295605c5777b@bootlin.com>
References: <20260701-drm-fix-graph-wording-v1-0-295605c5777b@bootlin.com>
In-Reply-To: <20260701-drm-fix-graph-wording-v1-0-295605c5777b@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
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

Fix a comment according to English grammar.

Link: https://lore.kernel.org/all/DI9ZFQUNMSBU.214AU8467OK76@bootlin.com/
Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index d03ada82eac9..4fcdb6944155 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -253,7 +253,7 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 	/*
 	 * of_graph_get_remote_node() produces a noisy error message if port
 	 * node isn't found and the absence of the port is a legit case here,
-	 * so at first we silently check whether graph presents in the
+	 * so at first we silently check whether a graph is present in the
 	 * device-tree node.
 	 */
 	if (!of_graph_is_present(np))

-- 
2.54.0

