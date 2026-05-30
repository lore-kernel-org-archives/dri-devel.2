Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873C0CD5BD0
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:02:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D39B911283A;
	Sat, 30 May 2026 14:02:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CHzlEjS/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2E1A11281E
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:01:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DAFD240AD1;
 Sat, 30 May 2026 14:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444331F00893;
 Sat, 30 May 2026 14:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149683;
 bh=p0ZUTmXx+KoqKuqqBwnq6A2/x0KuICIDG9Oq4B+B9f0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=CHzlEjS/VnQl2rDdu5LaV/IJz6pHc1FkjGlTfZ5p6Xp64kLl8tHLYJjeWIhfh0fAa
 DN5vePcq0UUXwsR0rXJ/A21NdaCnNkwAraXNv4PcwYXoqhCTrhdOcC8K2R6P1sru6s
 Kyf8DujvA8m4M4Kkb5JTSBl6OggUhVmG0wLDLmXhIzFTwvLhtOayVDyIubC9o4SF24
 kF8+LI821vyPa1szZUUuRARPqSosnPJpBlC3bawS23wfGFCUsMYS1RURq08fHMiFJH
 BubDayu5klHgXO6JLYTbTufgkdnl0x0qF99HcxBGdUdvmDxFeGhdihunkWIcllZfPt
 vZSkesWYziYtg==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:38 +0200
Subject: [PATCH 33/76] drm/bridge: dw-hdmi: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-33-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1331; i=mripard@kernel.org;
 h=from:subject:message-id; bh=vHObffEkaooHea/y0EzF3kyV8jT9m2MR+X1Aecjamrs=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb10S9yyRUVV48sxTW/+k2uNf5jsZSpvljbt26274+
 nUZ++mbHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAitzsZ66ufOR39Pueq+ieN
 T0cUrvBxcK2TjC+Jzs9feiXZaXG9SoDmw/qtx6ycL16PFhf2OrxRmLHhhsTT+vPTj1qb+aQe2X2
 o9oTxGXaG0BKLfzP2+PFHnJE+safYPeSt4rScxYaPNdj2BQQDAA==
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
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 17d5caedb32e..a408dbd414bf 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -3025,11 +3025,11 @@ static const struct drm_edid *dw_hdmi_bridge_edid_read(struct drm_bridge *bridge
 }
 
 static const struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.attach = dw_hdmi_bridge_attach,
 	.detach = dw_hdmi_bridge_detach,
 	.atomic_check = dw_hdmi_bridge_atomic_check,
 	.atomic_get_output_bus_fmts = dw_hdmi_bridge_atomic_get_output_bus_fmts,
 	.atomic_get_input_bus_fmts = dw_hdmi_bridge_atomic_get_input_bus_fmts,

-- 
2.54.0

