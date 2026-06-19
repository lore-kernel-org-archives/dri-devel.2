Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB48BCD98F6
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D09B010F570;
	Fri, 19 Jun 2026 12:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iybP91wY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39D5710F577
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:25:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2091E40287;
 Fri, 19 Jun 2026 12:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831301F00A3A;
 Fri, 19 Jun 2026 12:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871917;
 bh=VQKymBOZpsnbHmFX8MYgIe20POG7J33RFGorY/FIZv0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=iybP91wYGOQXkF5eu1+/n4wgUN0ZPJexYKypH3Lp4AogiZdhkN6o878zfdbvayNzs
 TZCpuB4oqWaMtiUrh7lycy1GRebf2eQJMpcjQbE/ayghWiUeUD1QB1Bm9Ti2cI23FP
 cUW6Fqf6H+/3TFYBwhr6OCgNJ72WHPm0r4jYERWFYj7FlXlFIokt9nBFAkNsi8Nyzf
 n0xV9SiJBzGxomcyptHs8+CHcmLioVQeh65IfgdsniX7WHWK2+XeuTcl9C9mLuaN9p
 tGP7YpaicNbaciy+jwCU9HRQBcH6WwXweick/Nbewrn41H46Z60e5vXQnzVGsGK709
 Nd8ZherKkMK5Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:16 +0200
Subject: [PATCH v3 11/78] drm/bridge: chipone-icn6211: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-11-ff399263111b@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Jagan Teki <jagan@amarulasolutions.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1355; i=mripard@kernel.org;
 h=from:subject:message-id; bh=pXwvSJQolCmhqu+d/AspDqHRt0jTXTtfMl7BZ3+008Q=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJu+6eXb6rWEybLl14OaPX5dj2FqyKrJY0hzWft1jk
 NX4NMG9YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzE5DljfZzLDocGx63ax7U2
 3DrS/tCwfaX9/4+CsTzHlc34ZFawBPZdnFBRsHk2Q4ti3twfG16EMdZXuH5ILRNrfJPjofH18El
 f+5aqSS89j/MkvTKLjsq0fSfFcufAV9lFNxKFpP9eDSho2A0A
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

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
To: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/bridge/chipone-icn6211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
index d8344e011818..eb628a0ce6ec 100644
--- a/drivers/gpu/drm/bridge/chipone-icn6211.c
+++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
@@ -616,11 +616,11 @@ chipone_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs chipone_bridge_funcs = {
 	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset		= drm_atomic_helper_bridge_reset,
+	.atomic_create_state		= drm_atomic_helper_bridge_create_state,
 	.atomic_pre_enable	= chipone_atomic_pre_enable,
 	.atomic_enable		= chipone_atomic_enable,
 	.atomic_post_disable	= chipone_atomic_post_disable,
 	.mode_set		= chipone_mode_set,
 	.attach			= chipone_attach,

-- 
2.54.0

