Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BBBCC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76D9610FEB1;
	Wed, 14 Oct 2026 17:28:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47B4F10EAB1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:28:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BFBE56022E;
 Wed, 14 Oct 2026 17:28:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08DF1F000C4;
 Wed, 14 Oct 2026 17:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998890;
 bh=TtORA57OmQPelD4AI4ftrV3Rc8wZfpHNSjVn1zRbkP0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=h7jXwGLrGzRHPZdV+lb854V3TzDO+dc+NgOlcrXBc3bF++/wAyFWJOLCadc0VpYMN
 JYhGlkQv4Ex+lCvuUIaKbZd1N8KW/iDJjpfm6NaTDEFUqik0848X+TYnHJpCXvou08
 NcTzV8sIpVrP1vWSJgeSekXZji8D2ZsrH0jeucKXz4nxiod3mEb0W2hpOsVieFdSC0
 hnQq5rdCJsdMCKxkGuRkUCKKE729AfQuJxuCkqZjHONDwk5ACps5h8e7rk804OlO6w
 CckNhkiAuCCeRwr4A7PeentAaih9wpfTJtqd1HI6HALFLEg/Cc3Tsu8M7oLkzzZkRb
 h+m5Q6dd0ZIhg==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:39 +0200
Subject: [PATCH 16/75] drm/bridge: simple-bridge: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-16-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1235; i=mripard@kernel.org;
 h=from:subject:message-id; bh=g6WKF5R+AJoWQ732yJgTYELqBRHSz7Gd9E42kL2d8ro=;
 b=kA0DAAkTJ1/OGaI9vnYByyZiAGrPu1GjAlBBe09Syacm9706N+WHQd7Ges4spH2aUpXHONpMu
 YiVBAATCQAdFiEE5BxWy6eHo3pAP6n4J1/OGaI9vnYFAmrPu1EACgkQJ1/OGaI9vnZM3AF/WzKC
 WNCx4Wkw2wUq38SavsQO8MXVe1YEqWbbjbciaos88SkRXL/NeSesKFam7mixAYDDTgcQArVzXKy
 KLYafXOGbVZSgdGqCQT/Zmk50pjKoR/QiLr2XGE1UTM+FBKtdePQ=
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

The bridge: simple-bridge connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/simple-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index fab793fb12b5..a1a1d8c4c035 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -94,11 +94,11 @@ simple_bridge_connector_detect(struct drm_connector *connector, bool force)
 
 static const struct drm_connector_funcs simple_bridge_con_funcs = {
 	.detect			= simple_bridge_connector_detect,
 	.fill_modes		= drm_helper_probe_single_connector_modes,
 	.destroy		= drm_connector_cleanup,
-	.reset			= drm_atomic_helper_connector_reset,
+	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 };
 
 static int simple_bridge_attach(struct drm_bridge *bridge,

-- 
2.55.0

