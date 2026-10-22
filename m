Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D499606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNK22IVD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C24B1125B5;
	Thu, 22 Oct 2026 12:35:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A8D51125AF
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:35:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8EDC160204;
 Thu, 22 Oct 2026 12:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F0E1F000C1;
 Thu, 22 Oct 2026 12:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672506;
 bh=JM54MVEpSOgCtXgEB9/g+Mg39tgnc/q00e1y68pdmu4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=QNK22IVDRugWRISGIcMEmXyULa4mZCdpIirzfgMdLyL3qEvhHkrZVILX6XnXvr9pZ
 XHrn3ClgAjYZ7gJdg3cthFqLSKlql1WfHbSf3a8Wyo4B21FFoYYPE9nYykF6+T72mu
 uFQL5Vp66eH/Byc35FZFLZZTDHnYxUA6ad7t0+R6dMPiYzPfdNJkJxGignQFo+Sape
 aWwKGOEyliyv0frWDxFoBAve/z+wiAWExitCHMtVwHPSG72SbZXOvUcmaHFzAiLj9F
 Uq1bE0jYqPmJrlJ4LjJrs/1xI+gG0itWnNlgFab9IF7xYjInCfYI88EpHFCw9otlVs
 qZTZ1Eksphopw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:21 +0200
Subject: [PATCH v2 22/59] drm/mgag200: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-22-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2163; i=mripard@kernel.org;
 h=from:subject:message-id; bh=PoZKSrFUIbE6pSIJMSOYI6Hby/74zi5m7ZgK69Mg2Yk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mKZ372vOiZgrtCys4mNOW7yTcnDxgh5V7w/GX+4wL
 TdkZFXrmMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABO5Y8FYK+xvreCd4BHM8f+D
 6mQj1/lmRtkFMrsyCud3VoW8450mlXrQu7e62bPn/5HMr/3Vt+oYa2XzQxlOPJvK2LcyauqnE5G
 afT5XK8SeOx01efPujNKXWsW7Rxerzzyd/bVNgSNppa9jFgA=
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

The mgag200 connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dave Airlie <airlied@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/mgag200/mgag200_vga.c     | 2 +-
 drivers/gpu/drm/mgag200/mgag200_vga_bmc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_vga.c b/drivers/gpu/drm/mgag200/mgag200_vga.c
index b07c1362ddd4..864cf01b93bf 100644
--- a/drivers/gpu/drm/mgag200/mgag200_vga.c
+++ b/drivers/gpu/drm/mgag200/mgag200_vga.c
@@ -19,7 +19,7 @@ static const struct drm_connector_helper_funcs mgag200_vga_connector_helper_func
 
 static const struct drm_connector_funcs mgag200_vga_connector_funcs = {
-	.reset                  = drm_atomic_helper_connector_reset,
 	.fill_modes             = drm_helper_probe_single_connector_modes,
 	.destroy                = drm_connector_cleanup,
+	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state   = drm_atomic_helper_connector_destroy_state
diff --git a/drivers/gpu/drm/mgag200/mgag200_vga_bmc.c b/drivers/gpu/drm/mgag200/mgag200_vga_bmc.c
index 805636990b55..aa9cedd0fd33 100644
--- a/drivers/gpu/drm/mgag200/mgag200_vga_bmc.c
+++ b/drivers/gpu/drm/mgag200/mgag200_vga_bmc.c
@@ -101,7 +101,7 @@ static const struct drm_connector_helper_funcs mgag200_vga_connector_helper_func
 
 static const struct drm_connector_funcs mgag200_vga_connector_funcs = {
-	.reset                  = drm_atomic_helper_connector_reset,
 	.fill_modes             = drm_helper_probe_single_connector_modes,
 	.destroy                = drm_connector_cleanup,
+	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state   = drm_atomic_helper_connector_destroy_state

-- 
2.55.0

