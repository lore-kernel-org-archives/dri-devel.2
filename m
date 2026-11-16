Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35D7606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eGpzJaaR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D679810EE8F;
	Mon, 16 Nov 2026 10:32:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C60C10EDC0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:32:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F2E6B628D3;
 Mon, 16 Nov 2026 10:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061651F000C4;
 Mon, 16 Nov 2026 10:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825128;
 bh=ndSL2pNTFv6FMlmqgHebpgrWQnY5J2O9h6r+jy0GRds=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=eGpzJaaRZDGzXnQHRdKURUEj1rS+HxZIwAG6WhBK78TSI5s6N8COLzDDAewc1DlDw
 R8Do5HbBO3fp+6rqcRpq9Wy3atynRZJh4C79Tnf+WR22NcxZedwC5oXk13opSRgnA2
 hWCGRKeA5zyEgwvQqmBadCmjolXRN6kmXlp73jsZFOrpuCIgpHFcdKceLa36UtEOnS
 oVUHXNsnnftLkb+nCmXmelpZ5p3etz82bJxMObSLrB9oTkKva1Xf6+ndQET0bwUxFg
 Mx1NJvhtHIsf3vENxXybUS5M0cO8vb62rH2UdiEmICF7LRC/mYzFQlyBNA2wUFAV7d
 Tx2m17z8o5JPg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:38 +0100
Subject: [PATCH v2 22/64] drm/omap: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-22-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311; i=mripard@kernel.org;
 h=from:subject:message-id; bh=kAk1XpcKRoDRjz8FkFWqJUChaxJNsDSAyEKojbWuos0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bnvm6HxIjV2gLM/Ufth48TZTG/45zck1uxIvyCpec
 lAxW+rQMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACZSyc1Y77pq36WAi3e7DNT4
 O+rkdC98fnByI8e2deJedYmPrm2QDz1pannWo/F82VNpd1lD18PSjA0nTdftZ97yppkpelrSxZl
 Je0P3tjWfmlc441CjfWfPa3uGg5a/HAM7dCQSpNp2qH1w+wsA
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
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/omapdrm/omap_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 89a6d3b4aa6f..db216c888a8f 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -533,11 +533,13 @@ static int omap_modeset_init(struct drm_device *dev)
 	dev->mode_config.normalize_zpos = true;
 
 	dev->mode_config.funcs = &omap_mode_config_funcs;
 	dev->mode_config.helper_private = &omap_mode_config_helper_funcs;
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ret;
 
 	omap_drm_irq_install(dev);
 
 	return 0;
 }

-- 
2.56.1

