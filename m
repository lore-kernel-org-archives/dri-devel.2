Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F30606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RLq86mP7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A581D1125B7;
	Thu, 22 Oct 2026 12:35:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4797D1125B4
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:35:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BECF260A6F;
 Thu, 22 Oct 2026 12:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F406E1F000C2;
 Thu, 22 Oct 2026 12:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672527;
 bh=vghrKHlQFbAAOAUv1DMHtTAn3Nmha2HRQ2ORF69ARvc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=RLq86mP7U+EIyr36ojM9BH/kx0i0+hkHt5NguPy9SbmtAI40pXw1MeKgsBa7bpKRG
 8JzDNtCAUflQUIqhUZUZitgduPRCmPmvGN/SmdvSnPW2AueLdye49HVl4gKWKmg1Do
 OQuQ/TJeG83+BVHaDyYbYKFpLYDG6V8i4tgPf6zRcJG1tqzaXV20DIf5fiqDqM+uad
 kUqyTfpEHwcp4YnAZbu43QXb5xb3ZbZ3ytuurC7heTRyV+/cBWxyxzHAtIEFbTaa/n
 olmtRyBma7YeNaURr6kNm19rUxL6UPUb2gWGRNXQ/+k8M4u0SZJVUb7PrKzGgYDm21
 77yyjPchMEuQg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:27 +0200
Subject: [PATCH v2 28/59] drm/sti: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-28-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2366; i=mripard@kernel.org;
 h=from:subject:message-id; bh=18xz9q2NfLDnv8i+NkgGxtusLNL4nVJqF63xDtJac/o=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mGYe7n4o7GK/9PPqy20buuWMiwQZplpklXXN7Oc8k
 ugXoJbZMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACZyTYixYd1Htw3tfjPPCed2
 VgdlNy9/saBJStYyoLnpvMLXV8ZhwjcnnZry7NTlJZ4JK7vWvDGfz9hw7/t+PgGFzTfO3L1jFnT
 T5fLqAr6iRY43pFIneW0RVkl0UPkhe+3ltLLFav+kNlz6NfkMAA==
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

The sti connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Alain Volmat <alain.volmat@foss.st.com>
Cc: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 drivers/gpu/drm/sti/sti_dvo.c  | 2 +-
 drivers/gpu/drm/sti/sti_hda.c  | 2 +-
 drivers/gpu/drm/sti/sti_hdmi.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
index cdb19b75f5e1..18c337ffa161 100644
--- a/drivers/gpu/drm/sti/sti_dvo.c
+++ b/drivers/gpu/drm/sti/sti_dvo.c
@@ -421,5 +421,5 @@ static const struct drm_connector_funcs sti_dvo_connector_funcs = {
 	.detect = sti_dvo_connector_detect,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index b4def2b25cec..204738807c86 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -664,5 +664,5 @@ static const struct drm_connector_funcs sti_hda_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 7ba9e0b7ba6c..9a810a89e6c0 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1147,5 +1147,5 @@ static const struct drm_connector_funcs sti_hdmi_connector_funcs = {
 	.detect = sti_hdmi_connector_detect,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_set_property = sti_hdmi_connector_set_property,
 	.atomic_get_property = sti_hdmi_connector_get_property,

-- 
2.55.0

