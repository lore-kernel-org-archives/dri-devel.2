Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946AB606A339
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQLTMg4c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1A7210EE50;
	Mon, 16 Nov 2026 10:32:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE4C610EEFF
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:32:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4DBB1628E0;
 Mon, 16 Nov 2026 10:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75ED41F000C5;
 Mon, 16 Nov 2026 10:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825138;
 bh=rG/bU2F6Yzq9+IoZRAWFbP971HL865rSzgbZYJPcgBU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=eQLTMg4cLPxpXnQot+3Td6dMysmF+dpC9moH6yefAJTNrpscBZvrg18rdx0gZazgY
 hidtoMfYKrV7Isj5iiHe18kj9wQH8Hd7yHbfhNXIBvqWjqErDY3885mwX2y1G75Q7k
 1ByhvYmTxyqCNE6dtdqWzmVEbhQjpE96bz9dznhB9gp+zAKBcAEVNcVmGoPEJCwg6M
 2imYIy2tQe0kFO8hLad6cTle/Nvk6l/k6C5IDBF+vCDQU67xhF/TODfF7+1CiBYVug
 +p/STxvPYEFtXumAfP1Xm+oS9CiWoBqSp+YyVl6Ui8wk4N5jW/OyjZ0C6nXWRCOa0S
 3mk1s/4E2H2XA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:41 +0100
Subject: [PATCH v2 25/64] drm/rcar-du: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-25-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1615; i=mripard@kernel.org;
 h=from:subject:message-id; bh=z8r/ote5eF8WbVQfXs68uTr6BhTZMLrQPmV8XM/1I08=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bnsfvmt1KDjCfXLj3x2X9i6u/6S2fdN+R7tH0zTX/
 NjxzPv17Y6pLAzCnAyyYoosT2TCTi9vX1zlYL/yB8wcViaQIQxcnAIwEY9fjPXOV/cez3arLFYO
 9drz81bawQs3+hckTvv61PbQ9FmrUv4L9vzQN4lUCzy2Zh2/26S7vh8Z6/RvLAuKW7FJqklbIoz
 3/4WEnYuflP167cGVdc6rPYVjxSpO1oYivqOaq268TXZqdnt+FwA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_mode_config_reset() has a dual role: it creates the initial KMS
state at probe time, and resets hardware and software state during
suspend/resume cycles.

Since the two roles need different behaviors (notably for objects like
drm_private_obj that must persist across suspend/resume),
drm_mode_config_create_initial_state() was introduced to handle only
the initial state creation at probe time.

Switch to drm_mode_config_create_initial_state().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
index 9228a7ad0dfa..7fddde804dc6 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
@@ -1000,11 +1000,13 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 	 * DPAD0.
 	 */
 	dpad0_sources = rcdu->info->routes[RCAR_DU_OUTPUT_DPAD0].possible_crtcs;
 	rcdu->dpad0_source = ffs(dpad0_sources) - 1;
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ret;
 
 	drm_kms_helper_poll_init(dev);
 
 	return 0;
 }

-- 
2.56.1

