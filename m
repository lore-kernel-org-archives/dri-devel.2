Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F76606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fc4Z772S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 530DD10EF1A;
	Mon, 16 Nov 2026 10:33:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F11D910EE6A
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:33:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 30F54618E0;
 Mon, 16 Nov 2026 10:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F081F000C4;
 Mon, 16 Nov 2026 10:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825195;
 bh=WsbICVKFvsNCgi2O6UHiKIyWvk3rsyoSm5SV1x5toTw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Fc4Z772SiiuMTEYr7quRsgv2HwVROTuKlppBeD7XIwJiqSCXJzi/0FNpkdHXkOQ4Z
 sBO/xNNV2Otbb0ZHhSsreq7IrKmH250bGycQu6G11lYDZR/MEmS9ixMw05RgTLKdqm
 JNEljhWJ3sT3h4p5vb+jEPVFOdCyPdBkYoxSKYB0yX3M6kEq5bKg/CoCHUmkHgv3EU
 F3MTiwhhc2EPkC9kebUMlzU+PPj+YTfcRM2ps+vL/lcY9E2/kKsfjjCHFMwCvgJo8z
 kTVn+piASpTRVJtbxXC7m2RlzFWaWJmEboOpgoYLisVJZrklV2V3bnYOjoHVcAcaT0
 e9fDgPNbZPlPQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:59 +0100
Subject: [PATCH v2 43/64] drm/tilcdc: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-43-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1344; i=mripard@kernel.org;
 h=from:subject:message-id; bh=J3o6ys0Oa/uitqeS5k0hv0iGrNuPEEjZVHHv/YKvhp0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bgexfTGfKi51LmlbovHlBx6XZfhcpNvv+qnMrDbf1
 nQx5HtRx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjIp5eM9WUxl5mKiqb672QS
 dZvz9dqV7dJXViTssFFd5eSzVON1pmavxR2Fre+uHiuyespW/bepkbHh1YVTyhPnz02QOLlVWFh
 YYdpDiRP/V8+o+lXAU+9e+feNxKlH71+7W/tJfV7by11+PSESAA==
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
Cc: Jyri Sarha <jyri.sarha@iki.fi>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 1d6c9a423a41..da718d9cb1d6 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -420,11 +420,13 @@ static int tilcdc_pdev_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		drm_err(ddev, "failed to install IRQ handler\n");
 		goto unregister_cpufreq_notif;
 	}
 
-	drm_mode_config_reset(ddev);
+	ret = drm_mode_config_create_initial_state(ddev);
+	if (ret)
+		goto stop_poll;
 
 	drm_kms_helper_poll_init(ddev);
 
 	ret = drm_dev_register(ddev, 0);
 	if (ret)

-- 
2.56.1

