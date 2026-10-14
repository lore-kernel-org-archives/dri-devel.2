Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3326CC6B2D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4915210EA7F;
	Wed, 14 Oct 2026 17:27:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A699A10EA7F
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:27:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2939560238;
 Wed, 14 Oct 2026 17:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558981F000C4;
 Wed, 14 Oct 2026 17:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998835;
 bh=Ub17MxPeuOhhuYb0h6M4u6ObO4tiNsyBBWpcjIz5tBw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=dnQdMwXr93gdl9s0d2z8A6WYUgfhqpUHV5QSMGxwI3TIoi1Yt/9ye9vD5/S5CiFUt
 6nhQz+o4lJ9Hy/l0x8kkfUqgv1n6crjYnITX/t1ZaMYMshdoLT/xu1cVgtlpONHf7Y
 40BkYUn5L05C3xoNHyvtdSALvw+DUh/whAwuR4R27OYOIuNYr8hQgC3Mj4NDQR90NN
 7eMYegsr2XYDq1zOmsOLHxXjBz8cqHyttnXTuNPrhhsJHNmYqGIQY82winPFnzld7y
 frCauAGBwPvpzRgfrjOJenSf0Bb4DnfE+cN7ylckcoRM9MDVBPGWtfyWyI8cJRnzFe
 hvtFPZiwrqKOw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:24 +0200
Subject: [PATCH 01/75] drm/panel: Add atomic_create_state support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-1-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1367; i=mripard@kernel.org;
 h=from:subject:message-id; bh=HyjhWIkFwqiNHlLC7J5TLnPD0Fuef8zDB9uhvwPfle8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd3u/n/v8IoOhx9z2qx43z+9vdXPLfnz13Y6+yf4sq
 +zuZ13j6JjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQAT+baRseFKUPd24RN1yx5E
 r7zKpbpslkeUCst2p7Z5Wa0HbHWqw264m+Tyxmmeav/u3bQu0intC2N9cXd0SgBXkGn8zpzHE+L
 WNWZWTU0LfX9Ld9+M7+3Ms79oXHGT/dt6/FFNipnu6uw5vzQB
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

The panel bridge attach hook calls the connector's reset function to
initialize the connector state when the device is already registered.

Now that connectors are being migrated from the reset hook to
atomic_create_state, prefer it over reset and fall back to the reset
hook if atomic_create_state is not implemented.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_panel.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index c00529bfb706..c9f49e18890a 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -102,12 +102,22 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
 	drm_panel_bridge_set_orientation(connector, bridge);
 
 	drm_connector_attach_encoder(connector, encoder);
 
 	if (bridge->dev->registered) {
-		if (connector->funcs->reset)
+		if (connector->funcs->atomic_create_state) {
+			struct drm_connector_state *conn_state;
+
+			conn_state = connector->funcs->atomic_create_state(connector);
+			if (IS_ERR(conn_state))
+				return PTR_ERR(conn_state);
+
+			connector->state = conn_state;
+		} else if (connector->funcs->reset) {
 			connector->funcs->reset(connector);
+		}
+
 		drm_connector_register(connector);
 	}
 
 	return 0;
 }

-- 
2.55.0

