Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9F6606A32C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GoX8hjST
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF5841128AB;
	Fri, 30 Oct 2026 15:15:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C531A1128A7
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:15:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AD284434F5;
 Fri, 30 Oct 2026 15:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107C31F000C1;
 Fri, 30 Oct 2026 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373342;
 bh=Vtr7CCZY9gMYHFcV5A2zkbb7Vy7y3t4AdShMheoRkiE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=GoX8hjSTEo0yPgoZOpuJCQiQe80In8uz4MkvqvLl86I7sMnbxGH1bWe42zDsY0j1O
 d+ofvzlA6DN3Dd8PPnYHdaobloDzQnU000wHjSnWndwCcbMUE0yE3/ru5Gwduj2YPs
 wX3i66WsnqjSyZ6ffl3dBcXiInc1bhP/nR3O01VmZ2fm3B208dcLb/s2W5yf+uk8AF
 13ueW+fkx5AjkSMGz4Z5KsrZksgX+P/qHccwtFumQL7BDkJxQH+9w0Vzf+M815AMMl
 YY7KWHrLlfGGlujLskG8SHboVUub1qh4iAghGmc3X15iaXchA2GfkAZkqBKwYFWUGg
 1Nuc+ECjYm6QQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:14:00 +0100
Subject: [PATCH v3 30/37] drm/tests: hdmi: Convert to atomic_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-30-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1893; i=mripard@kernel.org;
 h=from:subject:message-id; bh=yF3+E/K+zhyYaQcOQ4Aaoiwdwq+LlM/3c0QBb/i8U5w=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtmgtKVnfIJ8i9+DR5XXXdLX4bvKZTLfifnD6ay9/0
 sH/LZLpHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiHxkZG3a/qd/4oD1m6wfd
 4iK7j2JSWfbtCSv/2gSHbxffae7bJHs6uoKzsv+efZPf49K15wr7GRsaT7Pfn/xZr9Mqt7U1qHX
 xvbulSp/mu07axti3Kr9DcWMYh8IRCcWqbSUHjh2pOVPOFwoA
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

The test HDMI connector reset implementation creates a pristine
state and initializes the HDMI state. It does not perform any
hardware reset.

Since this is equivalent to what atomic_create_state expects, convert
the reset function to an atomic_create_state hook that returns the
initialized state.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 9953f5e661ce..336bb644cb7c 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -200,16 +200,24 @@ static const struct drm_connector_helper_funcs dummy_connector_helper_funcs = {
 };
 
-static void dummy_hdmi_connector_reset(struct drm_connector *connector)
+static struct drm_connector_state *
+dummy_hdmi_connector_create_state(struct drm_connector *connector)
 {
-	drm_atomic_helper_connector_reset(connector);
-	__drm_atomic_helper_connector_hdmi_state_init(connector->state,
+	struct drm_connector_state *connector_state;
+
+	connector_state = drm_atomic_helper_connector_create_state(connector);
+	if (IS_ERR(connector_state))
+		return connector_state;
+
+	__drm_atomic_helper_connector_hdmi_state_init(connector_state,
 						      connector);
+
+	return connector_state;
 }
 
 static const struct drm_connector_funcs dummy_connector_funcs = {
+	.atomic_create_state	= dummy_hdmi_connector_create_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
 	.fill_modes		= drm_helper_probe_single_connector_modes,
-	.reset			= dummy_hdmi_connector_reset,
 };
 

-- 
2.55.0

