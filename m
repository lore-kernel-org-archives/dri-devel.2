Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F7B606A320
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVTqtAHs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1EDA1128AD;
	Fri, 30 Oct 2026 15:15:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04FCE1128A3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:14:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7CD2B60252;
 Fri, 30 Oct 2026 15:14:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8B81F000C1;
 Fri, 30 Oct 2026 15:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373295;
 bh=vghrKHlQFbAAOAUv1DMHtTAn3Nmha2HRQ2ORF69ARvc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lVTqtAHsTHZtg0BQ0ZByVNKQn7K7U+ptYy29Oi90kQtdM5j57huOSIL1+IMjf7HIT
 C+2zblC1yLfzvDieu1/HIJOsu9CrR3ZSyrnmssHWXwAUrGdDn4R6RxrD/0Pwh7BnD2
 8Ww1UDLuYzBc6ThV9Ekzilztj+NHu35csNwMxMXM6OkhvDvdefDkmFLvkBV531Bxq5
 82XbDocxNior4VMRDNh6orerWZXYpP/CZQryXitoIML832OPJ4YzhS504uBNd/de+q
 GEsALvmr7xld9rLBiCp5D+87/ZiCJST1YDz5bDaB3QGXiMDFyK9SxKETRK7is1h74F
 4+KClfsZinCPw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:13:47 +0100
Subject: [PATCH v3 17/37] drm/sti: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-17-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2366; i=mripard@kernel.org;
 h=from:subject:message-id; bh=18xz9q2NfLDnv8i+NkgGxtusLNL4nVJqF63xDtJac/o=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtqjc2HZ6gf/xi5WfVVuWvJr9/6y4qUlG4IO8fuEdG
 6d/t3zG1zGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmYnyVsU5xigyjx8yVV90s
 JJ843pj9+uO+1P9SSzu7Xn04n/FXeovTwi/LPm3tOqE3ObZ0UeSik3yM9a6RupOXS29f/aM4wuB
 VgunGvB1OF9aGaebeWmnbVbez4NuzniStri26cow8e50sczq2AwA=
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

