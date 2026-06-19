Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850F2CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E328B10F5AC;
	Fri, 19 Jun 2026 12:28:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tf0lNJMC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7448010F5AA
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:27:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EB3DC601E4;
 Fri, 19 Jun 2026 12:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B601F00A3A;
 Fri, 19 Jun 2026 12:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781872072;
 bh=qUKuQpyPZ4ST8XOV+KuHwmIwPfKJzDy2s3CJQxVgs2c=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Tf0lNJMC95k/JVdmq++DpEGf/7k25A0p59/xMW2vwXRXODVVHjHr/UPkIyZ+qDhGo
 ZoTufzRryzo9/4BzInDYhbnykNbW+oRmx6EyYT3hp2u5RY89QoDCkQovLzuyPyl0Ba
 hSynGb5nrES9/c8hhOjIgTDwyOxPxNJNyjZgidlSfaI3hXOm3NEHvSCUzO3wj/S5o5
 lfmA6nJshnqyUMZ7eHiyxnnBT3b2aDP3/1RWnGhvL4Xvs2sR9kksVxlexDEjMjiYs8
 enwp2zI875McdvRJjvX2tkBzzqkrob2sk+8IFArpCxHjNGwNv4+/3sB4QKZOuVVFZs
 anNjimuJGFXGg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:25:14 +0200
Subject: [PATCH v3 69/78] drm/tidss: encoder: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-69-ff399263111b@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358; i=mripard@kernel.org;
 h=from:subject:message-id; bh=52peTVli6CkKvN/4sHfH9Bbr4G6oD2a73XB5g3t2hSE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmphxXJ2wIZFw3RbsiY4lBgtHx4y0TI1J1T876zi90L
 tvAKkuhYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzEmI2xVlSyIC/+cP5ur9eh
 MR8zo75OcG8NaX6r9mGhfHqUgaXa1fxLUd3iDesU+VLjWopnx1sxNlxxnuQZklzvZ8Rk+vmmbqy
 jQyxr9fI/ef913XQjdtwSWLdC32jdRS/VV6/Ud981WbV9CgA=
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
To: Jyri Sarha <jyri.sarha@iki.fi>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/tidss/tidss_encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/tidss/tidss_encoder.c
index 34db8d2a3792..698f8d964ca0 100644
--- a/drivers/gpu/drm/tidss/tidss_encoder.c
+++ b/drivers/gpu/drm/tidss/tidss_encoder.c
@@ -74,11 +74,11 @@ static int tidss_bridge_atomic_check(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs tidss_bridge_funcs = {
 	.attach				= tidss_bridge_attach,
 	.atomic_check			= tidss_bridge_atomic_check,
-	.atomic_reset			= drm_atomic_helper_bridge_reset,
+	.atomic_create_state			= drm_atomic_helper_bridge_create_state,
 	.atomic_duplicate_state		= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state		= drm_atomic_helper_bridge_destroy_state,
 };
 
 int tidss_encoder_create(struct tidss_device *tidss,

-- 
2.54.0

