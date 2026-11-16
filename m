Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C47E606A32C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e14rC70Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D57010EEEE;
	Mon, 16 Nov 2026 10:31:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 267AF10E0FF
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:31:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 09A7442DEE;
 Mon, 16 Nov 2026 10:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609FC1F000C4;
 Mon, 16 Nov 2026 10:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825082;
 bh=1sm80scMhgRgVSuKEz+dT4uD/UvgQWkPdc7nTKmqvJo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=e14rC70Qsxt47++z1FGXco9H0vXp852Ct2nXN2rvrLhGME4jhOJnz0U/IMqALh0qK
 cYkv5oclvICnR4cSI1DfsCCgHpVRDUurlX0NADoLKKQGlETDzKV0nvtEt2GSqJku+0
 Q1tzmbjnIQE83+039Cw7dY04n2l4b1gXW0MOoz3UWQci7lr4ylx5hDfjD4xQCsVgZK
 OZwxkhOttRRRBUkFWmEpX0OLWbDea0UZV2yZ7vVSqFrEXjspyUt6znmbkM03mDi1yS
 d6NpOGgatTID/VCfDRXyTrpvX4/FfcZaxYyN/R2ommH28ng2f84Pg4UO7yjQLZjYmA
 EbJiCkmxV/yBw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:24 +0100
Subject: [PATCH v2 08/64] drm/fsl-dcu: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-8-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alison Wang <alison.wang@nxp.com>, Stefan Agner <stefan@agner.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312; i=mripard@kernel.org;
 h=from:subject:message-id; bh=+NVxE3LZkL572rmjcX0JFiX8JDoJrsz3eP2PEAbPGas=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bjt/q9P75Z3Ic+R0VKb8dNdFH6xFn255+GVC627uU
 11GqTcvdkxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJWIkyVrPwli6YwhXCbGop
 tWCK6GytjYEL63d93ez3z/3gxdk23j8rr30LLtzCMvXPtgkGK5zMRBgbWgXS1R/8+zPDfJth5fL
 eXTuzJ7h8/Dn18U721xIvdNsU7h29yCIe+tx2wd6lkyPy9l2xAwA=
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
Cc: Alison Wang <alison.wang@nxp.com>
Cc: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
index 5b47000738e4..9c2189661d8a 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
@@ -40,11 +40,13 @@ int fsl_dcu_drm_modeset_init(struct fsl_dcu_drm_device *fsl_dev)
 
 	ret = fsl_dcu_create_outputs(fsl_dev);
 	if (ret)
 		goto err;
 
-	drm_mode_config_reset(fsl_dev->drm);
+	ret = drm_mode_config_create_initial_state(fsl_dev->drm);
+	if (ret)
+		goto err;
 	drm_kms_helper_poll_init(fsl_dev->drm);
 
 	return 0;
 
 err:

-- 
2.56.1

