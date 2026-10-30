Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693A3606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akcVjEyq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 164931128AC;
	Fri, 30 Oct 2026 15:15:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 801D811288C
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:15:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 025E4601EE;
 Fri, 30 Oct 2026 15:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFFC1F000C1;
 Fri, 30 Oct 2026 15:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373309;
 bh=fP5ZzG5BYOMroj/BMRw+mELsCATZtgVgFGFS4DYQl5A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=akcVjEyqRYmYJWvpX15ynBXRVBj7i/4Jdkd+5JsF0J/x//6lS2QuENNjheQPqNDQd
 36h7/JqoHDMdg3F7ELsb6BkfzcqaRvcSDmrLUgpasWBmngkuzwG/xT8J6/gofjSdqR
 L/oPfoztTH0/rVQWwVeUl3RH5UVa2e+lcJdZAkrFrRJ4eU17O4H95yoS1rEJXlEg75
 hnIlS7Im832UcCIlFJj53V8yAMcy5ewKt0Kpsi5mZ1ShD3pEnpHC7HDZqWkLjrmy6f
 Y7ZOY7kf6y0QWi7jh1CFk0ZXtYIl2gM3/3S2bdNO3TPGZH1l9WPtgzbm4GJzConmx2
 9uzMiv6eUN0gw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:13:51 +0100
Subject: [PATCH v3 21/37] drm/tiny: arcpgu: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-21-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alexey Brodkin <abrodkin@synopsys.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073; i=mripard@kernel.org;
 h=from:subject:message-id; bh=lRmM4tqeA3Vt8gf7dUtrCiy7xIkgvbo20a7VjxyAHLo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtqjdqOz6ac0gwrmgfJrttJn3Zybsq7wQbbrc9obv+
 iy+VwdrOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBETs9hbHjLUWK/SIVxS/NU
 /6zkmFOOG+4ps07fsMjYOiTTkm25d7HlyrrM6NdNjwRVObgC2SfeYmxocH2cENnAcLD30zODMMH
 nLofLpkxUOtfp9uXM+ijxM3dl78/me71izm+HPkdv3qfP4ycDAA==
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

The tiny: arcpgu connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Alexey Brodkin <abrodkin@synopsys.com>
---
 drivers/gpu/drm/tiny/arcpgu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index cdbf28db8fa1..32f6e98ba9c5 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -99,7 +99,7 @@ arcpgu_drm_connector_helper_funcs = {
 
 static const struct drm_connector_funcs arcpgu_drm_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

