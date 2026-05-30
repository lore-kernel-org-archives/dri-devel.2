Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCA0CD6E52
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3092112822;
	Sat, 30 May 2026 14:01:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I/ftIpyG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6467D11281A
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:01:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4BB4B40616;
 Sat, 30 May 2026 14:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8F01F00893;
 Sat, 30 May 2026 14:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149697;
 bh=3W4dFEF23VtkPSr8te0EecDVHJICoU1i8NUROzvPPGk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=I/ftIpyG/UXBEPx0birBu3hnl1Ex/g2Ej7tG3XTVawuS1UQe5EIdUn6Dc1hDkFL1U
 brTPLFkvjvYSIO/J8XyxW2NUDcG2pLp7F/0UjbMn12TcaFpOyUqUekDi0tL5ob/W5u
 L1xN30nU4rI170a8mnmGpjfPj+WB640hPbLZF9wKDlGMIeMGYAaNy/T8moko0jD8G0
 Wpr4M0NMNcfhWmm+GpYG9PzHFIyvCpfb6wYK3HX4J/3Ai1fnMxX1HtWeRV6C5Epu1+
 laSpm7g/VorgTAT5dT94RnNm8vL65UOL7UFPcjw7XPk0tLOF79VEZA8jFHH1oPDwqr
 V9LDAXCl2onjg==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:43 +0200
Subject: [PATCH 38/76] drm/bridge: tc358768: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-38-875d828d31bc@kernel.org>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255; i=mripard@kernel.org;
 h=from:subject:message-id; bh=1t8IfM73z5+neACa40f2LkR0dYnP/aQ+EptAqk6U/Y4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb91uOOjw5fHGCgsfff8gxHN61b+C5IKkm3PYfaPZ7
 7ulOpR0TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgIm8rWJs+BJ5fe3NKJOMdiU7
 1s9yu4R6M4Q+OtisnLyqdPNjiaqt7Eopmo/lRHm8HGcwr9thtvkyY33uXvMGM92f4SLWF+Xsv89
 l+LfKaPOdHZxdUb6ZJ7svT9bmct9Qz5oW+Jk7VLD2Jo9wIgA=
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

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/tc358768.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 0f2820b37302..0d85120fcc7a 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -1288,11 +1288,11 @@ static const struct drm_bridge_funcs tc358768_bridge_funcs = {
 	.atomic_disable = tc358768_bridge_atomic_disable,
 	.atomic_post_disable = tc358768_bridge_atomic_post_disable,
 
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_get_input_bus_fmts = tc358768_atomic_get_input_bus_fmts,
 };
 
 static const struct drm_bridge_timings default_tc358768_timings = {
 	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE

-- 
2.54.0

