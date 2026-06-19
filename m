Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC8DCDB471
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:27:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB96410F59B;
	Fri, 19 Jun 2026 12:27:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bEmEIARJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70FA910F595
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:26:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D9DF8601E4;
 Fri, 19 Jun 2026 12:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C5B1F000E9;
 Fri, 19 Jun 2026 12:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871994;
 bh=JtsiMf4SkgfqSRTGoDKVZKPwAQcTe3YfnMc53n3KLPo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=bEmEIARJGgdC74LCizbvu60z8CfidbQFQwFkdpNcJAkXPYhGhFBjue2c4uWt5etai
 aNS+jUn2Vz7Gqz2U+FvA+lAYQnFNJu2hSpV8a841WT/kH44l2X2EDT4/Ki7WYG2rCY
 9HS70cb0n4g7A5F7u4n9hufvKD1Tn7mMwfbd8tOJmAdxDbzIHc7wpnZwgLktg1Ynqu
 ZQCNcY8SBXP26oxThmw9HT3mN5JRLVhTRt1EJR5avbLOL7sqSGBkrRD/FplEIgNK9s
 zoyq7jb7K4ZfPFYXM+7lwTGGzKicVjQbRQPxfBL6jZorU2veFoVRcSwx1NP8Q59kML
 pN9YZbbDPpfSg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:45 +0200
Subject: [PATCH v3 40/78] drm/bridge: tc358768: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-40-ff399263111b@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1309; i=mripard@kernel.org;
 h=from:subject:message-id; bh=QuHfpnJFbcUAcshH9ifg/tTRWGGDkNscE5tiSpCh3T4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJr+3/Pjz2Mvh23meHVpJEociOG5tX8DAdH03n2/ej
 FLuxoWcHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAit58yNiw4kyP160dR9ayX
 SU6ZWukbWoTuMGr6VfeceX5ot5LZhq+a4mz3Lzy53m6/wiRI5+5rO8b66D0mxYb5G9+e+dCS77t
 Ob83SyInLzJd+38C6zbqDzVqzVna63rklD47fci2LFP3IHPQeAA==
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

