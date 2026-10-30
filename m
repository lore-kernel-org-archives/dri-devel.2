Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2172C606A320
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMzZyBmM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DCB51128BB;
	Fri, 30 Oct 2026 15:14:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7525E10E2B8
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:14:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5F24140394;
 Fri, 30 Oct 2026 15:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2B91F00A18;
 Fri, 30 Oct 2026 15:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373277;
 bh=ORkRJATMd0p9kraX8wdTcl7KMy5E5R01t/sVOb9WDIc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=MMzZyBmM40ChYiYBkzVpwzXMqCsGuNnNQIh8Ejh37+gAiFp9fQF3bi29AxQ4m2t3I
 4nQ71PgUSFvRCXm/keOH2GQ85Euwr79+/YyfJW1lBadrPnVpO3s73EDuszaU2ekqQH
 AQgEul5LrWifcUfdeYqZbzcKRfffmTLlvRwBh82ZANrhzOZSGiUfO6M2Sb4r8QoLXv
 WTgm8GDPQCqnfZgQzb9jwMeBUWK14JPQXjSocVzRNo+YnDFr+FANnC9y2vZYspcA9C
 BuW2QJke5H95fOyF65nC3MYRl7RunqhrJwufZQGIqA/hgC2dLCVY+1jL87HsxSAvHM
 kOsomVBFun6/w==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:13:42 +0100
Subject: [PATCH v3 12/37] drm/fsl-dcu: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-12-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alison Wang <alison.wang@nxp.com>, Stefan Agner <stefan@agner.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213; i=mripard@kernel.org;
 h=from:subject:message-id; bh=vYO5EbWNjX3Rjt+ko7F2f/zMi/7Pa17ARYvAJ9LBf7A=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtihFnbLU8rpjtPvhshkeq6KmlWUdd2vvvNjt+lb7z
 PyyiwoPO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEFAwY69Q/B2kIduip9sSt
 yA3X0qtZ/Fm07OhO+4qzX459jZt/1+rXg7kSz2+wNAvmx+jevtPwhrFhc3PjhhuvRPzXe0x2uXw
 4i3n+MdkHa4uMqrmfaXN/uif4Y/bxLyyXzpu5eyoGMnC8YF0HAA==
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

The fsl-dcu connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Alison Wang <alison.wang@nxp.com>
Cc: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
index c64264541fe2..9b5ca262d619 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
@@ -51,9 +51,9 @@ static void fsl_dcu_drm_connector_destroy(struct drm_connector *connector)
 
 static const struct drm_connector_funcs fsl_dcu_drm_connector_funcs = {
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.destroy = fsl_dcu_drm_connector_destroy,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.reset = drm_atomic_helper_connector_reset,
 };
 

-- 
2.55.0

