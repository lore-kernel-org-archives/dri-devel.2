Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA159C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 07:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1371B10E6F3;
	Mon, 10 Aug 2026 07:19:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="U3N7n9l5";
	dkim-atps=neutral
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch
 [109.224.244.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CA2B10E6F3
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 07:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail; t=1786346389; x=1786605589;
 bh=ZJSCfXp3hcwIl+jbWgDlNmbsCfx+Kvs7P3NKbUEI0gg=;
 h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=U3N7n9l591S9trMRfqQ8/wyBQ+NDJpCKZFLrUn/+dBiRFlhpia5LeC3YhlE6N7skq
 A1zyhG+GnxLFTaZBpdtAftAblnLFEwQY8RzcN6RiNVsh11HOlqkywj47e+MPqZt3Ck
 HyhAmN+iTOQREYdQ1sKAcqnCOQVQM5fIG1zvL+RRsXRV3bxXLhOhwjAgsWZ4o05apk
 TDwFAvLD9K4S3QRiyp0dBkVw9LgOqwVyQdLTotjcCkMfU+MD2sjdAbxD8YyVOsxgGA
 iaiDETAvAuO7jgFRWYCHi5141zEXmCp2z8vLGazoYWSK1DUP5U+dPIjaoL+WvDIAje
 7ZBC9na40S54Q==
X-Pm-Submission-Id: 4hJR365Wxrz2ScNb
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 10 Aug 2026 09:19:41 +0200
Subject: [PATCH v4 2/3] drm/bridge: ti-sn65dsi83: Propagate error in
 sn65dsi83_reset_pipe()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-ti-sn65dsi83-fixes-v4-2-ae9c95c8d162@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786346382; l=975;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=ADbcip/7+ws/P910Sgn2HvCEM8tB4gXcTCDY2lBAYnQ=;
 b=t9VdwYSBeo0Zyjs1jvJ28ES768Rf5d4vyTyfpV1720IcKxNymqvXUUNzCBBTCwPVDaufHUtUI
 dIR1PsMOxDHDmeZAWkjlb7wmhPhD/jDb+UQVWN8PPiol0CBaryS//AX
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

Fixes: ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error recovery mechanism")
Cc: stable@vger.kernel.org
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 0ccfff401b2a..475224c5a5d8 100644
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

