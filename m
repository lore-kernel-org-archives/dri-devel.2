Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878C2606A33B
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NmmuCwlZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E07DE10EEEF;
	Mon, 16 Nov 2026 10:31:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98F4C10E0FF
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:31:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9298D461E4;
 Mon, 16 Nov 2026 10:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD781F000C4;
 Mon, 16 Nov 2026 10:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825095;
 bh=ILfrq1LDk2fzz0e/u0mrwfqzMdZDeM6EdfD54PJHsB4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=NmmuCwlZx9np5KSGhVe6aetYseQkRk2UNZv50NiIhcrmnV3ukP+oYz3zTGb/XTUzL
 5yn8+Ic98TFtLxP38wPVupxJKmHMZUO6gm/eD+Num8QT607JlMY44c7p9WnuychGk+
 wvVNyqqvKmYctUfrmVax4Cn54r3Oeic83zdMPJiLh2nkNoaYfU1mUkAZ44UDhsxk6l
 sUdfFeTkRTU97f4yAzJHBMygQ2ntsafOmf1xUnORERT/m529vSOym1tFwFL0yZ60VO
 Fw1kPljiruuZnsEKvx/pmxWgs4N0mjn1k4DHM1lMs5vaykfh21IGEpP41rxZ7kIgM4
 3/uB+zQIxSF5g==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:28 +0100
Subject: [PATCH v2 12/64] drm/imx/ipuv3: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-12-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1631; i=mripard@kernel.org;
 h=from:subject:message-id; bh=mIjkOaPh9MqU2vMA6VEeSiaggDiEEKD/wPxqjrn980U=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/brvyu+XMPP5wx7/jN8yuuqztFNhqteRZ8Ol4IQbP8
 t3+oi+udExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJ6Mow1mkUr5wllPQ2y5GZ
 Sf3d6v8VlX5b57dOmnNln0KpQHjZIY2TRxb6+itw8C4sPcJtqOhrytjw482RSsmGeK+NhpuaQ3T
 kFq+ZXXPgVK/cPeVFp7+un/yt1bfCKCPSmUPB1jBaKmqexHwA
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
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: imx@lists.linux.dev
---
 drivers/gpu/drm/imx/ipuv3/imx-drm-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c b/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
index 51a0ec043248..b7b6ae8f9578 100644
--- a/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
+++ b/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
@@ -242,11 +242,13 @@ static int imx_drm_bind(struct device *dev)
 	/* Now try and bind all our sub-components */
 	ret = component_bind_all(dev, drm);
 	if (ret)
 		goto err_kms;
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		goto err_poll_fini;
 
 	/*
 	 * All components are now initialised, so setup the fb helper.
 	 * The fb helper takes copies of key hardware information, so the
 	 * crtcs/connectors/encoders must not change after this point.

-- 
2.56.1

