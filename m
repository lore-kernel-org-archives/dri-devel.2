Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8B2606A328
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ty9bBqZX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 936591127B0;
	Thu,  5 Nov 2026 15:33:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E666611279F
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:33:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CCCF2423BE;
 Thu,  5 Nov 2026 15:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354B21F00A15;
 Thu,  5 Nov 2026 15:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892816;
 bh=zchK6PCRUk4qYRPsZ95gICVMD9kvyh5YxB2lgeIeAi0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Ty9bBqZXbAXFg1x/nr2ye5Hkokw2Cy6NJrJmN5TeokPynwjCIn9487EQ4PgyYIXrU
 adS9zF8O4DvDu82T3VHRa2TEBZlJbjbXd1PNKbyc02FmKyAhQa59OIeOYWcnWcPUMo
 OPjXCruf4dzRIZvNzsZX/15F+qj4SeKm465EXp6KoqJcuy/8jByNblGYxoOc+p0mdt
 n07ByY2UFeXaGnevlud2tTmogwe9mnEp8+CWKioDYFIEGl33tCV9YajEnXcpKfbK2d
 eN0EUiWCoCxN/pkexJZry55ALf1PJdAyw9RAkBe3zt7q6x8z5FXPyZzQwdCi1YRWVf
 GxsOm+tndhXeQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:05 +0100
Subject: [PATCH RESEND 56/83] drm/tests: drm_bridge_test: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-56-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748; i=mripard@kernel.org;
 h=from:subject:message-id; bh=4GVAPocOygdqJVIEbxkhb7P8sZVMF6bzeOTxNOiFpfU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFnz1Y7fRPH2i6Vdy7suCfRGH7/nfdM3Y3GYl97Y2j
 7tl0y2tjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRx5yMdTr7js/POyLcmVNf
 rPAreJUU394z92YGi4qXv70a/FftcOnph9mOx5UsJJYELH5cICW1jrHh/fGnNbMSuu7fYr4yQ84
 xytX3bsk5j2P/tyW6790vLVqfnHeNr/NhdY5Y1aybzTw96V0A
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
 drivers/gpu/drm/tests/drm_bridge_test.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_bridge_test.c b/drivers/gpu/drm/tests/drm_bridge_test.c
index 15583ade8494..f56209c0ab1c 100644
--- a/drivers/gpu/drm/tests/drm_bridge_test.c
+++ b/drivers/gpu/drm/tests/drm_bridge_test.c
@@ -423,5 +423,7 @@ drm_test_bridge_init(struct kunit *test, const struct drm_bridge_funcs *funcs)
 		return ERR_CAST(priv->connector);
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return priv;
@@ -521,5 +523,7 @@ drm_test_bridge_chain_init(struct kunit *test, unsigned int num_bridges,
 	drm_connector_attach_encoder(priv->connector, enc);
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ERR_PTR(ret);
 
 	if (!has_hdmi)
@@ -613,5 +617,7 @@ drm_test_bridge_hdmi_init(struct kunit *test, const struct drm_bridge_funcs *fun
 	drm_connector_attach_encoder(priv->connector, enc);
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return priv;

-- 
2.55.0

