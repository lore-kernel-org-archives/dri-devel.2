Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBF4CD6E55
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92D3F112849;
	Sat, 30 May 2026 14:03:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eR82DJ/H";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E65D11283B
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:03:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 22334600BB;
 Sat, 30 May 2026 14:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545291F00893;
 Sat, 30 May 2026 14:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149793;
 bh=9oFladQl8JqFJbRLE34adxgv9WHeEknwJD46EB8Pe7k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=eR82DJ/HSQmXGNZvHi9WbIM+2zFr9o5Fvq/jDxDtWDbHyNQCzJBtLVI1idtNtb2OL
 USu7qF2FewGNDQUMPc3WvVJOjOkWgBCD9LPJDCwp1Yp/s/tBaUtEORw0jcSUevJ7oQ
 T5t84cDMvuabmz1zDkSWnp1+qYTBozp9rVcLGsaQGXWoT24F+VOSqipZo/m98qJca/
 GDhJakn3eC0fXYMttw97+6+iwKyAQCYGb9Y3JOVQUxWQWxEE5QBwbLCj6RJSPh9qZ0
 nrjyGuo4Hmljj6mRza5SvIuqaR52FaTOFCbVnkTkK8ObGKhEcPdsPp1nzf+a3f8xKk
 Ps1mkI0SpLMXw==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 16:00:19 +0200
Subject: [PATCH 74/76] drm/bridge: cdns-dsi: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-74-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2007; i=mripard@kernel.org;
 h=from:subject:message-id; bh=S8ZW2DRczaJ3/vV8p5pIac0PF5rI4rUzK0oh/V+qRSQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb8OOHpns+FJKlXnC0zs5S+JUr7OdF06OlGGd3h8i/
 jmSx+5Rx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjIveuMDQ9rGA/6sD1r8W0q
 yzcrWeTBHPGrWeFOL5dfnNLylIrfJk9u3o5TCv3NfG/GrWjTB5c4GOu0fZO//lyhePLt8pfTJvD
 8kJkzZ2fJObmj/399Ufs+8fzEM5tOvK5jX6NptPsk1/SmtMfuAA==
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

The cdns-dsi bridge atomic_reset implementation is semantically an
atomic_create_state: it allocates and initializes a pristine state
without side effects.

However, it returns NULL on allocation failure instead of an error
pointer.

Switch to the atomic_create_state callback, rename the function
accordingly, and return ERR_PTR(-ENOMEM) on failure.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index f4cf765f0be8..c3e466ded84a 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -1007,17 +1007,17 @@ cdns_dsi_bridge_atomic_destroy_state(struct drm_bridge *bridge,
 
 	kfree(dsi_state);
 }
 
 static struct drm_bridge_state *
-cdns_dsi_bridge_atomic_reset(struct drm_bridge *bridge)
+cdns_dsi_bridge_atomic_create_state(struct drm_bridge *bridge)
 {
 	struct cdns_dsi_bridge_state *dsi_state;
 
 	dsi_state = kzalloc_obj(*dsi_state);
 	if (!dsi_state)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	__drm_atomic_helper_bridge_state_init(&dsi_state->base, bridge);
 
 	return &dsi_state->base;
 }
@@ -1026,11 +1026,11 @@ static const struct drm_bridge_funcs cdns_dsi_bridge_funcs = {
 	.attach = cdns_dsi_bridge_attach,
 	.mode_valid = cdns_dsi_bridge_mode_valid,
 	.atomic_pre_enable = cdns_dsi_bridge_atomic_pre_enable,
 	.atomic_post_disable = cdns_dsi_bridge_atomic_post_disable,
 	.atomic_check = cdns_dsi_bridge_atomic_check,
-	.atomic_reset = cdns_dsi_bridge_atomic_reset,
+	.atomic_create_state = cdns_dsi_bridge_atomic_create_state,
 	.atomic_duplicate_state = cdns_dsi_bridge_atomic_duplicate_state,
 	.atomic_destroy_state = cdns_dsi_bridge_atomic_destroy_state,
 	.atomic_get_input_bus_fmts = cdns_dsi_bridge_get_input_bus_fmts,
 };
 

-- 
2.54.0

