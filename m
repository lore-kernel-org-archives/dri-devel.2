Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE52CDB46F
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:26:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAB7010F593;
	Fri, 19 Jun 2026 12:26:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="edkLBDsg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B782210F58D
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:26:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A0E45444A0;
 Fri, 19 Jun 2026 12:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384A61F000E9;
 Fri, 19 Jun 2026 12:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871986;
 bh=ETI+9Ht1vTDYzRbXTxW6OapvfZxGPJ/Cyodyi5/7fV0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=edkLBDsgIsAKZ3DIF84eT/B9mm/v2bQwXeRe6W/H8p4jw2/oZQ+NGvPQ+fBeKAGw+
 QZrfT3714BmlhEh9MGvjv4OuDWUTTdC0M98ltfE4I+VwQiqDgOSgCKI1ZWF94yL7Tv
 csbp+/FgHtXM8Jl1HGEcbdow1XxmkZZxmO4BfDRx5TDz73yPfrwCFKz8ZDfE5uEumx
 kXW2pATvCsO9Pmu7CJMIPoN+ycG7MumAozVSsdCf8smOVEfFLB0YbiiKplqdxNj0TT
 N1qiTdBZ2YXCzfQ0SaXcM4isdoPqc2nutj9srWC7el8/0lqiz4hAPpT5kCbx1d5QYx
 l4zFjVSK9BV9A==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:42 +0200
Subject: [PATCH v3 37/78] drm/bridge: dw-mipi-dsi2: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-37-ff399263111b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1537; i=mripard@kernel.org;
 h=from:subject:message-id; bh=9e3aMiNkanAizeMOrKJnqJpLyIoV8nKUKfmkylP7Igs=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJr/mXHbem3uZed/U+KCLyyWcdY/tb/OMutjfdKBmU
 v6OrkTOjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCR8LmM9a5ClVm/Y3inFft4
 dnun1vp/9fE60bGnfcdy49MzGJ1WTuRgME5O+P65ctvxB03//60yZGz4L9pXvOiPk7pq6hfP5yw
 1qv7zbmcaBQesP7FSZtPkvYJPGISzD8uo5nmK8J0/c2GKpSkA
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
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
index b2a022d266d9..5f06cb03b4c0 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
@@ -891,11 +891,11 @@ static int dw_mipi_dsi2_bridge_attach(struct drm_bridge *bridge,
 static const struct drm_bridge_funcs dw_mipi_dsi2_bridge_funcs = {
 	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
 	.atomic_get_input_bus_fmts = dw_mipi_dsi2_bridge_atomic_get_input_bus_fmts,
 	.atomic_check		= dw_mipi_dsi2_bridge_atomic_check,
-	.atomic_reset		= drm_atomic_helper_bridge_reset,
+	.atomic_create_state		= drm_atomic_helper_bridge_create_state,
 	.atomic_pre_enable	= dw_mipi_dsi2_bridge_atomic_pre_enable,
 	.atomic_enable		= dw_mipi_dsi2_bridge_atomic_enable,
 	.atomic_post_disable	= dw_mipi_dsi2_bridge_post_atomic_disable,
 	.mode_set		= dw_mipi_dsi2_bridge_mode_set,
 	.mode_valid		= dw_mipi_dsi2_bridge_mode_valid,

-- 
2.54.0

