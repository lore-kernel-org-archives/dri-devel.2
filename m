Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4049C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 07:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D5ED10E6E9;
	Mon, 10 Aug 2026 07:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="3FhkKFNY";
	dkim-atps=neutral
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch
 [79.135.106.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E71D610E6E9
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 07:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail; t=1786346387; x=1786605587;
 bh=CVuR4JN4qvYTWrwAiybLluZngZdrcxB+j6GjB1GhM18=;
 h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=3FhkKFNY66b3AD3bEaQ6EOUmy2RE9gEoaRKPWg64k20azjbf3Os/7+/47Bvx5pzUI
 O4FHJppaXwY+1UVQDl6/868TLIVDHef7ibClKzbnqNhkSYU77fVKCoiz+3WdtrVzhf
 UIPQZFjzFc3qwQMdipvAZz83LpbxSI0uB9mUdwyhXXMrEGdP24fR06Y8tIgOLgaNGy
 PaCw+clFj8wtR2wD99n447u77mGd+CUCsbyzkOb3Wrfm7U11jIbJf1qTeglTRSM2GJ
 uIQ437w9TaVZJ+FKaNFNjJ2czAbFUuLbDapCqrjQqDe5E52KZFNuCzSI5+f00rnvEL
 4YS5Qs1HY2/sQ==
X-Pm-Submission-Id: 4hJR351Qdbz1DFFF
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 10 Aug 2026 09:19:40 +0200
Subject: [PATCH v4 1/3] drm/bridge: ti-sn65dsi83: Fix error handling in
 sn65dsi83_reset_work()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-ti-sn65dsi83-fixes-v4-1-ae9c95c8d162@geanix.com>
References: <20260810-ti-sn65dsi83-fixes-v4-0-ae9c95c8d162@geanix.com>
In-Reply-To: <20260810-ti-sn65dsi83-fixes-v4-0-ae9c95c8d162@geanix.com>
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
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786346382; l=1222;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=fMP2hOoQfOnTvMLbjGHxqKSru2U0lvUotPn+hSMBBk0=;
 b=nRoQC5DfBHj6lQFvnFD8ahuFzZnMz9W1pXbjcH9tHHqDRG+fTyAPB0ogNE6BdYUuXeRzf7VUj
 QPuWtldw21WCDPyYD5c753AWuE7YM9luxoiyBuPcR9fOAR1ZWoOao/1
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

The error handling of sn65dsi83_reset_pipe() failure in
sn65dsi83_reset_work() has been a bit strange all the time, missing both
enable_irq() and drm_bridge_exit() in case of failure. But since
sn65dsi83_reset_pipe() have never been failing (always returning 0), it has
not caused any problems.

As we are going to change sn65dsi83_reset_pipe() to return error values in
case of failure, we need to fix this.

Fixes: ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error recovery mechanism")
Cc: stable@vger.kernel.org
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 42b451432bbb..0ccfff401b2a 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -417,10 +417,9 @@ static void sn65dsi83_reset_work(struct work_struct *ws)
 
 	/* Reset the pipe */
 	ret = sn65dsi83_reset_pipe(ctx);
-	if (ret) {
+	if (ret)
 		dev_err(ctx->dev, "reset pipe failed %pe\n", ERR_PTR(ret));
-		return;
-	}
+
 	if (ctx->irq)
 		enable_irq(ctx->irq);
 

-- 
2.55.0

