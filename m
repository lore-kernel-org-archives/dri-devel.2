Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D5A606A33D
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RC1dOEFw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 701B3112798;
	Thu,  5 Nov 2026 15:32:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E17112795
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:32:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A6E4C40174;
 Thu,  5 Nov 2026 15:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1151F1F000C1;
 Thu,  5 Nov 2026 15:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892740;
 bh=h7kXjIvaD9I4Ytlo9V6WrbW5s+lf9mwR20Esdy6Qa9c=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=RC1dOEFwPSrVrMHwQzh6gsFEOepNrbeQSmyAIV7q+YwvzYXH3e05slNif55FNpSrL
 Imc4EVFWHElYIGlnggB3OX4JVFjSx4NndbofqJ6vxmIfViY01KM56g8eDYWKw5cNQd
 5VY+NIeJ/McY4/2SmSVJks8Cr/Q+WmHYhD/Nb3sVWfBiECmk/FS3F+irdRoQ0xwufK
 xre0l9GqM9gfpaOxew4e22gxHAC9zgty6Ef3Wlj3JVZM9HhTfYc3/0XOZtB8qTLjK/
 Xwzu8BGDiPBpgYlRxn0F38gjl9VTf1ORwAw5zBjeW7+1bA1wN5K+ytAKbxb65stjVz
 wJoDzzrGQ3CjQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:44 +0100
Subject: [PATCH RESEND 35/83] drm/rcar-du: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-35-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497; i=mripard@kernel.org;
 h=from:subject:message-id; bh=hPGIK5YZmvGETlt8Fu9SkSwdVK9ySZ5w82wooG5le/g=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFrxp+/Su6B3f31v6jz8xqWTop70+80b09iHnrY1+c
 z9PsKvX75jKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATWZfO2NAVmyBsPSGw/Ibm
 /w0hXV9EIxPXHpBiYlzDu/i6NvOdvTn/1sQ2RPck2IidKueaseGhOWPD6mKtjEkl3IetY6+n7V1
 t2PzrqHlNwLJpi4qXX57ec4Rvz/59qf3Xikr46hPqqxXvHvQAAA==
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
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
@@ -1003,5 +1003,7 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 	rcdu->dpad0_source = ffs(dpad0_sources) - 1;
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ret;
 
 	drm_kms_helper_poll_init(dev);

-- 
2.55.0

