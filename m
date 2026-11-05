Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF57606A331
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqiPpiJB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94D4111277A;
	Thu,  5 Nov 2026 15:31:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66BA411277A
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:31:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4FD8140E39;
 Thu,  5 Nov 2026 15:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F681F000C1;
 Thu,  5 Nov 2026 15:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892686;
 bh=/RuyPDJSOQkSvtGZQ699xnBIKRw+fZZ9SK+IyRUFhM0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=UqiPpiJB3QyYkOa5ZFfohwKdWzS/k7C93mYTOj0zbyJVpSFD+tlIn//xp1wdr+u/7
 z8Eu3e5SfgOBOjL61Nr5bg0L1kw6QWB6FxqNidtwvLmsCmmIF+5cHo3XhECWzleY4y
 qttntWxU7+RQbQRSFcmikIEnQji1VePvwt/Qrlyblx9EPVkeetYTztv6flLJYy8LDy
 OMYnFRKlmiNkR11xTUmOmkK3e0dMTvAJKseTvbRsYH/ZgXOEZ4D8QztfIDR4cd0Iu3
 FyJHb+liJzRxF/mCQJ97bSFyDXqeDYKkQofoI81GWSpXcPIUIDlK6l3RjEAF2H+Tee
 JG1Asownbpeaw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:29 +0100
Subject: [PATCH RESEND 20/83] drm/ingenic: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-20-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219; i=mripard@kernel.org;
 h=from:subject:message-id; bh=9SWtkslaqOuBdZr7dXYA3MFs+LezwP69O0+5JcuvqD4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFjyzkFFfw58s4LswKMQkfAmXoa6JSt0m0bObr06Y6
 TvfVci0YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzkbytjrRD7vG1T4lgWlp71
 myvY6LZu5nQPRuPABVUKYtvdOdUjsqUVz9Q7vF2avGSN21WhgKp2xvqotLUHjnpITlF/dXPjtK1
 hi48oVfIL5AkqCH/r0XoZGLXcYhPLi2nOkbtOpCmxvP/L3QsA
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
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: linux-mips@vger.kernel.org
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 625ec76cf04d..63198fd59498 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -1355,5 +1355,7 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 	}
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		goto err_drvdata;
 
 	ret = clk_prepare_enable(priv->pix_clk);

-- 
2.55.0

