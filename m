Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F783606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YPWKBRRl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B10F81128A3;
	Fri, 30 Oct 2026 15:15:25 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A8D110E58D
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:14:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E375601EE;
 Fri, 30 Oct 2026 15:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6E71F000C1;
 Fri, 30 Oct 2026 15:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373298;
 bh=oc0PrDV8DEK9WJ2O0W/WsptT1VrI37wtjGjJETAFueg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=YPWKBRRl3rK3doVyFHGwFZHMKD5xsnUKCdOvaVpZdnMkF6mKVa4qyur7YHJYpNYsV
 ggBviu2ne8azuiPU61/ff6oBZ2zDjhxlJwTID09T4GRi+A+WCXO0BbKaZ9IW/mPtIg
 M92lL2qQOToYM6DE7jc8aMBH1tqOesYnmtlxIjlCpwRnMq+B99/5H7xRT+Z5FAG2mV
 AxHHQ7v6/PsBPGNlhs9QwIGl/iiA1wJgujVs85I14V9gD9OnrwzzI5HIww6PtwNTFP
 rfb/bO9OLybYfEM/YpxQSOjBoCj9A9dCieo8l5zZml2vCLLgFX6OhlCHfsZanqzgPR
 KvDirvec5fodA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:13:48 +0100
Subject: [PATCH v3 18/37] drm/sun4i: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-18-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 linux-sunxi@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2555; i=mripard@kernel.org;
 h=from:subject:message-id; bh=WhXdr0caQxsD2xQ8xxnX9ce6ERhKkrPc/zQA/D7z/Z0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtqhuCQ1cc6az8UmtWKg6/yZ1tXJpadvIbcuPNcpx5
 U6W8nzaMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACZi/YexoamfayZT2ua6GdXP
 r3x9OnPT95sBt3YyrXrUbdUx9yTn5KQ9uU/uODj65gqHnlnhP2XLfMaGRudpd3wPpt32u/LKp8j
 Mk1k35SzTvIq1L379f7mhcdJs7xPqYZpSxh/6ZCYa3570OWEHAA==
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

The sun4i connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Chen-Yu Tsai <wens@kernel.org>
Cc: Samuel Holland <samuel@sholland.org>
Cc: linux-sunxi@lists.linux.dev
---
 drivers/gpu/drm/sun4i/sun4i_lvds.c     | 2 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c      | 2 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.c b/drivers/gpu/drm/sun4i/sun4i_lvds.c
index 6b98d20a8890..f3f035c9260f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_lvds.c
+++ b/drivers/gpu/drm/sun4i/sun4i_lvds.c
@@ -66,5 +66,5 @@ static const struct drm_connector_funcs sun4i_lvds_con_funcs = {
 	.fill_modes		= drm_helper_probe_single_connector_modes,
 	.destroy		= sun4i_lvds_connector_destroy,
-	.reset			= drm_atomic_helper_connector_reset,
+	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index 3da9a9283c6e..c930dd899875 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -157,5 +157,5 @@ static const struct drm_connector_funcs sun4i_rgb_con_funcs = {
 	.fill_modes		= drm_helper_probe_single_connector_modes,
 	.destroy		= sun4i_rgb_connector_destroy,
-	.reset			= drm_atomic_helper_connector_reset,
+	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index d504ae583294..1b7ae9b327c1 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -838,5 +838,5 @@ static const struct drm_connector_funcs sun6i_dsi_connector_funcs = {
 	.fill_modes		= drm_helper_probe_single_connector_modes,
 	.destroy		= drm_connector_cleanup,
-	.reset			= drm_atomic_helper_connector_reset,
+	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

