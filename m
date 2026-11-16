Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B082606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oj9BFeeI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4BC610EF12;
	Mon, 16 Nov 2026 10:33:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 450B410EE6A
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:33:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1584E41994;
 Mon, 16 Nov 2026 10:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A5D1F000C4;
 Mon, 16 Nov 2026 10:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825189;
 bh=zWa9w/f7h3yiuaIhXi8xdt4xKikG5+dBKpBO3xvU6jo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Oj9BFeeIJpoX10a4QdSTm5hXAYAWjOI3O8C46UNLmbFTdLnN7nymMp7YuRuB9QAvm
 yk383f+zY46NW+4ub42l5LCHfyXCaRYKdK3KqrzafWl+1GLLnFy6g9wEXjJyP8+5cW
 zm4gz8+5zrzhV1AD7MwrEOfBHk2tHFttvPFa+8SXMo6hy27a/vgcAkxnUx1cWfqvso
 iOeht6hGdPGztZVBuGfqR5Nlfntm07kPCvMNeKaawng0LFDWVQn0NrB8cZb8KLdONH
 CsamHBrjmWB03CcQVBFpwH166vQ9wcGg1XKOC7qE45DBj5BIVUpMc4cWQ2ZvC9zB7D
 LWokjg4zizG+A==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:57 +0100
Subject: [PATCH v2 41/64] drm/tests: drm_hdmi_state_helper_test: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-41-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1402; i=mripard@kernel.org;
 h=from:subject:message-id; bh=vmMkmC7iIJ2rp9oHBzo0Qfl6vTQMSfWsbf1byDoIjfI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bge6L4x54pT8W/PT3y72fxVGK67dYD4ca1zFf5htd
 RLvwX8MHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAi/9cx1gc5SlTNPRp9eT7/
 G2bBmcwH21orry5/XsPPvvfVlJ3XV87yVly8juOjnGLkLFEXqyObnjHW2Uy+MN/BV/CBNcuht85
 HLxzO/zFlrlFx9dbgW0tKRQ8ey29ZeSI6uilfnPUJc4x0xV53AA==
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
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 336bb644cb7c..35c551b4a35d 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -295,11 +295,12 @@ __connector_hdmi_init(struct kunit *test,
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	drm_connector_helper_add(conn, &dummy_connector_helper_funcs);
 	drm_connector_attach_encoder(conn, enc);
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	if (edid_data && edid_len) {
 		ret = set_connector_edid(test, &priv->connector, edid_data, edid_len);
 		KUNIT_ASSERT_GT(test, ret, 0);
 	}

-- 
2.56.1

