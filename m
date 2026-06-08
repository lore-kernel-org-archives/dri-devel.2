Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A27ACD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87B6C10F4D9;
	Mon,  8 Jun 2026 14:37:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iwS1hOtR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99F8210F4D9
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:37:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8250543C81;
 Mon,  8 Jun 2026 14:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E608A1F00898;
 Mon,  8 Jun 2026 14:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929467;
 bh=Lp21qpWXh1ZOuPmiZAgwNbziAL0lC7UyW+zBO2hxiAs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=iwS1hOtRo/Ac7YW2WZeYWILpe00/heftJrMjfqjRnRjDSR22iJ9KPQfrOOA/7MQkG
 ZYts1Rl+9tfFRjeEmVuwI34BgH9n/LfBJkTGFd4sGhDmA4Ovuswd05dGsvlddxKxlh
 xIZFd3/CYg9QWHC4rpOmYv9xP4S7PWNBJfbyot3PwPMiQ566Y2aUqcA+ie9W4a9EKZ
 tTGMrXZrEn1HDxAZQ6qdRTiFjDO/kndaddqJkbzjhm6Bp1CYVNrqVFTFgDYrGqDE4m
 Wm1rjrX+XSWxqn3hnV5KtbjUNpDcRrVSOEo9BqXxKwuJO4/kdJklNy8DMtCu0K3JIA
 aPVPb69Tg/PeA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:12 +0200
Subject: [PATCH v2 30/78] drm/bridge: samsung-dsim: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-30-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1554; i=mripard@kernel.org;
 h=from:subject:message-id; bh=T6YpHJwhuEx4nQntGyTzxb1pIDVWPbk7XQR3zIYEFJc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql4M0HjcWpO3Xn6Gzapnr5E0OPCqTtyctU3z8VmRro
 01MxIWsjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRVgfGWsm9665p793gaGtb
 ZLt3o/mVdS0vJDa2fPDy/SDS8n/P5X/z18/8GNj4LnmGcMAW910tFoy1si837mkoNcrYXOyvXHv
 r/s/kuMj3b9llf36b3qLz4qlpya/rV3JN/se/ZCgoczFbPHMVAA==
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

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
To: Inki Dae <inki.dae@samsung.com>
To: Jagan Teki <jagan@amarulasolutions.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 9ee0515074c7..5788066d479e 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1833,11 +1833,11 @@ static int samsung_dsim_attach(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs samsung_dsim_bridge_funcs = {
 	.atomic_duplicate_state		= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state		= drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset			= drm_atomic_helper_bridge_reset,
+	.atomic_create_state			= drm_atomic_helper_bridge_create_state,
 	.atomic_get_input_bus_fmts	= samsung_dsim_atomic_get_input_bus_fmts,
 	.atomic_check			= samsung_dsim_atomic_check,
 	.atomic_pre_enable		= samsung_dsim_atomic_pre_enable,
 	.atomic_enable			= samsung_dsim_atomic_enable,
 	.atomic_disable			= samsung_dsim_atomic_disable,

-- 
2.54.0

