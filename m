Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E08CD6E57
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45D9A112827;
	Sat, 30 May 2026 14:01:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UmGqClhZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFD9411281E
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:01:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 32639600BB;
 Sat, 30 May 2026 14:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F53F1F00893;
 Sat, 30 May 2026 14:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149699;
 bh=3LTBhVzd6X776JFhRymvRfwivQZ5zNINv+y5WYbkkF4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=UmGqClhZbOqIx+ePbt0ZtGuSjveXX/7To+eAFTsrBNdVM5SAwGNI2pg/vtDP0X2PN
 RfzXt4clY8PZFCL4SHmKYueCYbe8D9mxATxn7m05GhtEl0aoJsasIpRIcO2EsI87D/
 iPtk6EhIoTNG0NTnK9FydfIltFPlx2ri5BxzaQVed163/sqZ7CKtoZajfkUAWrHGgg
 XD5D0pcHz7ym5Xnefd2vGSciJ8Byfhr3BUDnlScHUrXk45WJPQuTSMimnKNMXBTZvC
 nz/Ve/5Q/xZ3GvjIANjxsjrcQbPs//5oh86tDc39pBV8DqESs0Ottx5AZPrU2RC55Z
 D91v3F56hM65A==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:44 +0200
Subject: [PATCH 39/76] drm/bridge: tc358775: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-39-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1198; i=mripard@kernel.org;
 h=from:subject:message-id; bh=mUENLqNl9cLFSuHMV7zAiRp+uTTmexf4lRBCbyrOIhk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb90OvKsKb1U54femLO1sz/GiPcankjwV7h/zu/LkY
 HdOyvR3HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAinh2MddbrJh/XWs3P1py2
 hl8w+O3FlOfXGvvPxOiXLlz3+GOyV+8qydgDWSZG+7q37BSwbGe6zlin/+iCnZ0um3bjpgL3Pd/
 Wvv7yafqmeRLxixYVB1ZFWv0+VMwjOPdE+v75iw9Hf//DWLUTAA==
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

