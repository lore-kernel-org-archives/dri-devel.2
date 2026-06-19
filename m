Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8030BCD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D239810F58F;
	Fri, 19 Jun 2026 12:26:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FSJvg+9b";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19EFF10F594
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:26:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8F865601E4;
 Fri, 19 Jun 2026 12:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C008B1F00A3A;
 Fri, 19 Jun 2026 12:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871997;
 bh=z8QiHS5Lsn7ae6/J8bTUUkRHsxmax8ePz5cfoaB2YGY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=FSJvg+9br+gifvs4aLh90ophnqJTolVD3Fg8A7MUAz8+GqKY1cCZYHccw0gh849wi
 WVTVWKG9zUFqcZv8vu3lJ0okzhl5WfyX4/G++V/JBcqhl+fsRE1Nynh2O9ZLIQRNGd
 1GaQrQzm4T3ensh2uGwFGhx4Ujk2Eq7KUHfsPHnyNcn3P7kDbwPaeP09CUEu2nxOzZ
 OPLCLtjISGCoOr3Z/3V9sJmPYrFclvOMTkdecf1Aa0cuw0mwWZHmYwhK6EvTbRpWRz
 i9jEilIVWi3xowRwQbyFGuhwNBQ0VhP4c6d+jAYkQwYEE52AdSpcPs7tAERKtQoWCw
 CZVN4LBBW9A9w==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:46 +0200
Subject: [PATCH v3 41/78] drm/bridge: tc358775: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-41-ff399263111b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1252; i=mripard@kernel.org;
 h=from:subject:message-id; bh=rO1U+MmE09J/X15mzpcpLhKjMr0AXoLQrhutwn3eWzc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJn/2p75Ql855ki51fif/jSuX4p6WL+NSXTjh8cTK2
 +f6bvVJd0xlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJPMlmbPgw67q10dpZOwR/
 L13Rfu1rt+2y2pUSwgb7GrXCBTmuLT85xXlqydd/Px3MYnsz3q27fJaxPmpWYrR/y8rrOW8tfTd
 KnuxbIrzO8vYvx8/1IWH612ZYpas/qJ19grXhdUzIda71jT0SAA==
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
 drivers/gpu/drm/bridge/tc358775.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index e067b671cece..728938f9dcb4 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -596,11 +596,11 @@ static const struct drm_bridge_funcs tc_bridge_funcs = {
 	.attach = tc_bridge_attach,
 	.atomic_pre_enable = tc_bridge_atomic_pre_enable,
 	.atomic_enable = tc_bridge_atomic_enable,
 	.mode_valid = tc_mode_valid,
 	.atomic_post_disable = tc_bridge_atomic_post_disable,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 };
 
 static int tc_attach_host(struct tc_data *tc)

-- 
2.54.0

