Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F91B606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gL4J0tt0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A8711125CC;
	Thu, 22 Oct 2026 12:37:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF4421125C5
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:36:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D93D741E5B;
 Thu, 22 Oct 2026 12:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404001F000C1;
 Thu, 22 Oct 2026 12:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672602;
 bh=Vtr7CCZY9gMYHFcV5A2zkbb7Vy7y3t4AdShMheoRkiE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=gL4J0tt0OoUCU/30WmsiCn34wFQXCC3KBIS73m8/NkP7tJgIQWal7Twv+oaSDuqDZ
 WkOnGI230CGqE0NtRBa9wqwNgQ8foPjfyDLvrQhayO3UnmrBP+FFZX6ExF9WbyeFUw
 3Pw2gIXBaeYRxkY9Z/Rkl8AXP05+s1FpSEvq6b7ISQIDtJRgq4JdbhlT7v1NgQ1gii
 Bc4peSMDwh2/ql0bKwVDhDgBLDLRFe6dfWbQ9T3Wobd2k+xycMOpKLwa/lbTLS0THa
 9Qm7KA4VQ459PMDm73fnqgIyQjHAgJk7KPSIqHkU6QkXmycY+tKXiexGx8epnhI6ZH
 9lFhFOUdgMAKA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:48 +0200
Subject: [PATCH v2 49/59] drm/tests: hdmi: Convert to atomic_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-49-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1893; i=mripard@kernel.org;
 h=from:subject:message-id; bh=yF3+E/K+zhyYaQcOQ4Aaoiwdwq+LlM/3c0QBb/i8U5w=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mBbvWakitnbz4iuTo3gmSU46+uPHF76H8/yXMp3vZ
 flfvuvIvI6pLAzCnAyyYoosT2TCTi9vX1zlYL/yB8wcViaQIQxcnAIwER5NxobmgLcnte5kfp60
 bNlc/SptjfXH7J/vMpbieRSxwOzn89+2fzYxNHe++/an/pdAeW1T+DLGOm2XH+zt2UHvl+dd+tv
 zY200lyOD4pPi9AumUaWHF8TZbV/VwGj11EXlupdqw56cWWEOAA==
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

