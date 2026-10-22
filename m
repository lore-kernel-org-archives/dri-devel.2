Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26356606A31B
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=giDs46M3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73F1B1125C6;
	Thu, 22 Oct 2026 12:37:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4450E1125C8
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:36:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2D71B44079;
 Thu, 22 Oct 2026 12:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800901F000C1;
 Thu, 22 Oct 2026 12:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672610;
 bh=t8xyRmFr1Lg0eu2vbZiZf2aGscL1B6jZzlbmeKOZqQE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=giDs46M3EL4YEWHKUGBjwvP1RDlc0rGJHJMq9/t8ijBFMIiO/K2ZtWsH5yJZXC/49
 uon8fDjBHMztuETgG4DJy0+Yg/xXkftfpz86YSGrls7DZ4lCczxaa1TeOHwO/IsCvf
 j3KJnCCS7U5V+LiZgnwtDX+hwVQjlJySonvyCdkpvDew6cGUKcbObhgIi8MWrde6rI
 BjzR2Jk9RCb6a47o+MDnTU48bvJ1knOV7RmDSUQE5/ZfiqFmYf9P94w1C6MqOKOhrT
 X573kBzpmwb1JEPjqdtNj3ikXCZVlxEMdlwgRp2R1gLRzRvOpNvNQIfGsn8I4DxRJn
 ZnFaAardnoZJQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:50 +0200
Subject: [PATCH v2 51/59] drm/vc4: vec: Convert to atomic_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-51-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2023; i=mripard@kernel.org;
 h=from:subject:message-id; bh=wkLPLYoWMZVrHgugLAQCB4izJ5pX8eSHG+SSAt0DXFo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mBaH6PxgZS258/zFW5kkRZk0neMzfuyMjl16Zse/X
 St+W2vrdUxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJ7C9nrK9SerP91xQN3eKI
 VOvcadmt26asNtldXfUv8J3jFv5D6dx3pp6pyruSaenRdMd1YvcWBsb6GI7rkU1m7YGaOQ45PeH
 vEirKa8trmJnY+g5c+b72o92anT4nn5sw7z6z1LpJRnVtAT8A
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

The vc4 VEC connector reset implementation creates a pristine state
and initializes the analog TV properties. It does not perform any
hardware reset.

Since this is equivalent to what atomic_create_state expects, convert
the reset function to an atomic_create_state hook that returns the
initialized state.

Reviewed-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: "Maíra Canal" <mcanal@igalia.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_vec.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c
index 7ab77f97df31..d46c164c4393 100644
--- a/drivers/gpu/drm/vc4/vc4_vec.c
+++ b/drivers/gpu/drm/vc4/vc4_vec.c
@@ -378,8 +378,16 @@ vc4_vec_connector_detect(struct drm_connector *connector, bool force)
 }
 
-static void vc4_vec_connector_reset(struct drm_connector *connector)
+static struct drm_connector_state *
+vc4_vec_connector_create_state(struct drm_connector *connector)
 {
-	drm_atomic_helper_connector_reset(connector);
-	drm_atomic_helper_connector_tv_state_init(connector->state, connector);
+	struct drm_connector_state *connector_state;
+
+	connector_state = drm_atomic_helper_connector_create_state(connector);
+	if (IS_ERR(connector_state))
+		return connector_state;
+
+	drm_atomic_helper_connector_tv_state_init(connector_state, connector);
+
+	return connector_state;
 }
 
@@ -490,5 +498,5 @@ static const struct drm_connector_funcs vc4_vec_connector_funcs = {
 	.detect = vc4_vec_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.reset = vc4_vec_connector_reset,
+	.atomic_create_state = vc4_vec_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

