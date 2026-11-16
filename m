Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F53606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4ybwFFz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DFFA10EF2A;
	Mon, 16 Nov 2026 10:34:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6960B10EE6A
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:33:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E2B0A60DC0;
 Mon, 16 Nov 2026 10:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8921F000C4;
 Mon, 16 Nov 2026 10:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825234;
 bh=oLu3BAILNHfcvltFWGbaIm7YoIMxLrf+262H777JAaA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=D4ybwFFzP8ljAsiOCilQs13Xgc2nkeIwVpIj9B6Sdj0pCeT+KwY7yw5XIoAz4CIMA
 h8MhhmBb47lqdfJTO//LGPluhCBwi2Vg428/9udH2TEQ8ZaWjXSPAFWc2cP4e8CDLr
 cJCoOatqfDy9DyduWdVFoY3Mkxk+FG48DuUBour1FKonFzVIRYAv4xd4/HLzZ7J06E
 xXgF/D/X1vtuLEYxYL4WUmdJKVMFFD5BpxdSC5cJDEwnsaJLDP4rdgrmYydNMFLvDk
 GYC1ICy0u2wVl3BUSyjHjB1VEU1v0t5TSX9gEbPptaUuvCF8ZVttRnlqYqgnm0sOU/
 CUxJke8zpnKyQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:31:11 +0100
Subject: [PATCH v2 55/64] drm/pixpaper: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-55-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 LiangCheng Wang <zaq14760@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=mripard@kernel.org;
 h=from:subject:message-id; bh=GlQA2Bbd+ZMFh0AX38FhVwkFO5rUuFR1XIY0B3i2tv8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bkd8a97D1K88xyX4dPlPJ/403+dqMTP8Q8zeBKT0r
 ixlP2fTMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACbC481YK1MmZRLt+Obikr7T
 D6dq5sc+6469z/7iyqZdW9l/HDmR+ens9n/7g+cLVe1vTmu2eny2ibHhwTbbyW0rHsX7Kr+Z3fT
 9W4Hd+UvJa+Zbuv60frY0M1b4V+Wxq29K/8xLTqgL2vRH12MPAA==
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
Cc: LiangCheng Wang <zaq14760@gmail.com>
---
 drivers/gpu/drm/tiny/pixpaper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/pixpaper.c b/drivers/gpu/drm/tiny/pixpaper.c
index 2a92a28b40f6..f8a633d0fbd8 100644
--- a/drivers/gpu/drm/tiny/pixpaper.c
+++ b/drivers/gpu/drm/tiny/pixpaper.c
@@ -1116,11 +1116,13 @@ static int pixpaper_probe(struct spi_device *spi)
 
 	drm_connector_helper_add(&panel->connector,
 				 &pixpaper_connector_helper_funcs);
 	drm_connector_attach_encoder(&panel->connector, &panel->encoder);
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ret;
 
 	ret = drm_dev_register(drm, 0);
 	if (ret)
 		return ret;
 

-- 
2.56.1

