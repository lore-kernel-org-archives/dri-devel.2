Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C048C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC03310EAA7;
	Wed, 14 Oct 2026 17:28:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 803C410FEA9
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:28:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6912B42AE6;
 Wed, 14 Oct 2026 17:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD24D1F000C4;
 Wed, 14 Oct 2026 17:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998883;
 bh=H1Vi26Eu7Od0Oyo0+HBNBYtDA+UHhBn50lAdotPfjuY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TvodVboRL421FY3xMvBio8AVquFoS8lrvYTQ1VdFxc8ECZCKGMohzBzFc4UAH4mH4
 qfnkMJMVW5dM9kq5Vf41u7na2PcXo8Vus6BVfAyINNeWlVEiYaXxKkbLNF+sRNrWmz
 5VdpRc4I+/wWIdpkdevbfD9dPaHNFRoKTbEssrzHO0P4mwRULDMMUsS0ZyFB1TJh5s
 HC4TxZvIGqQon1DryLpMvJJ7urELDrgvOk1DwC3Fd3AjU/rw+MuUIEpwBuEkMVPvu8
 VmVV4QDEH+jDq2BLH23toUKMXQIXlz8O7W9pDliOh3AtDWKOBKzP3gNWfgHvAWCN48
 SDFpbwS2H3wqw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:37 +0200
Subject: [PATCH 14/75] drm/panel: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-14-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1193; i=mripard@kernel.org;
 h=from:subject:message-id; bh=+c/PnBe+nb3ILOL7V0tQIfzxgHXcw44dBxrJbQaTIJk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnndwecPLbk0bXAI9FX/ueFTTI88YD715ZpYfPfcYQz2
 XWu3aLU0DGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmEqbKWJ9Zu/Dt3buCE712
 FHtP+mT39dYH40LGyiOcx5sdrrPMr5/B/l35pJhPwJ7uq6snFZRseMVYn3qLg+VuUP+VxrUKWbP
 +iDt8Py28sMD++nyjBbcWs5ytPTQp+ukZuZCLIh9KOy/Py323CwA=
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

The bridge: panel connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_panel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index c9f49e18890a..55a1427c7a10 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -68,13 +68,13 @@ static const struct drm_connector_helper_funcs
 panel_bridge_connector_helper_funcs = {
 	.get_modes = panel_bridge_connector_get_modes,
 };
 
 static const struct drm_connector_funcs panel_bridge_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static int panel_bridge_attach(struct drm_bridge *bridge,

-- 
2.55.0

