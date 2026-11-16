Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6CF606A336
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ODUBMTjs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 473B010EEE5;
	Mon, 16 Nov 2026 10:31:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41DC310E843
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:31:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1DF7662887;
 Mon, 16 Nov 2026 10:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484521F000C4;
 Mon, 16 Nov 2026 10:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825079;
 bh=HR1RnG73PrXXW9f/KrS7v/UuHKcFn403pSvB3v4W9gU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ODUBMTjsyBR50n0RnnIkFijnpZFYJkbqs4kXGVGODhDtXc1bivzW/taUGsgyr023a
 GseO1tuD2m68NZQ0d3luzZQF1sqsUNjS4OWFm2oKz9ulLYY98RC8zvz57xujS00tL3
 tNacntiKXcS3HOixihTOQDsgV/GLtv4ReXogxPjqO7d9a6VZ04PAYAmyx5imcYn+/L
 /cnEz37OAs9G1aBo9csI8hWzCJ2YFuFPA/Gc5nbAriJxk5hZFjz+0nWWNaX9PYmzMB
 FHe2x1hgxnRzepKPRHj7oG3ZtK6EEdho2cOZYofXJa8xrTWu8AtC5D6oq/jV4VwKFf
 h8xGAhW+Kj0Zg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:23 +0100
Subject: [PATCH v2 07/64] drm/exynos: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-7-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Inki Dae <inki.dae@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, linux-samsung-soc@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574; i=mripard@kernel.org;
 h=from:subject:message-id; bh=jqgMByXeT6UiGU7jKa8TjYMskSzMribJdbP82Ad+0/Y=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bjuLXtjyvqFKhG9fcV7AyXaRnq7217FdLTnpz+q/G
 jOrHdzRMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACZyxYSxYX3eJoZoRzYmUzH1
 WQLVfaXq7dsUWbocXj/hM6x5VX1c0ezJnAXXLXi3v1q6IzwmI3wvY63Yq4UGRzbv/DQnboWG23O
 pyIeCy0/W951rPDTr96IfmWwd7Ova5j14t2P2BHmT2ANrBV0A
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
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org
---
 drivers/gpu/drm/exynos/exynos_drm_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
index 9ee30086879f..712e5ac86f50 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
@@ -275,11 +275,13 @@ static int exynos_drm_bind(struct device *dev)
 
 	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
 	if (ret)
 		goto err_unbind_all;
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		goto err_unbind_all;
 
 	/* init kms poll for handling hpd */
 	drm_kms_helper_poll_init(drm);
 
 	/* register the DRM device */

-- 
2.56.1

