Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA88606A335
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VwB02F8q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 263A91127AC;
	Thu,  5 Nov 2026 15:33:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 735061127AC
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:33:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B1C3E60A68;
 Thu,  5 Nov 2026 15:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB24E1F00919;
 Thu,  5 Nov 2026 15:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892820;
 bh=BKGEMNg9NgkR2mzl09Kznj0mXm8FV4o5Z88xPsxAxVg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=VwB02F8qsp+90jV3+b4yQqJt9yo+PRX07dSNmDhNW3yU0xRYCGw34VaS/SsOw7UbP
 hP8zX6aHhTlvaQPRpiOqumdaWVHeBzQFACHEb0u24C7h8Bub1VNqmwU5FgeIcRJle/
 q4lT2PKDBXbzP1rX6EAQH7yiKTRdFvauodFdgBaAvhEa6PNj8wgNyzZf4GJ1tYdnB5
 As5zvKcVA75t8sjmVohhDHvIPA8ViG8YUz+3VTCq1CQ0NUbo8bbzEcla0ZND585KSX
 Avb+d0IdBO5QK7ij7majhE+THNH+ZqA1ylr8sbp6yH81GawZHbLnmhZbODb5jcYdqk
 gJAfgxxdcA1cQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:06 +0100
Subject: [PATCH RESEND 57/83] drm/tests: drm_hdmi_state_helper_test: Switch
 to drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-57-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1186; i=mripard@kernel.org;
 h=from:subject:message-id; bh=u874M3b/LljNkF5kP0LP3qZmAOpWZmcahfJhGsOKInc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFny7yf/35QWnY0sPfZK8zH7sz6cfvCttii0yo97Ut
 04r2fHvUMdUFgZhTgZZMUWWJzJhp5e3L65ysF/5A2YOKxPIEAYuTgGYiF8vY52+oUnv3BS7JflB
 N/WPvCtsV27YNffR/vqpJ7l6/A9ekOb/vP2q0ekZuXw7ZF9kb/TTE2WsDxIPK78zw32H1zql38s
 SF9b/9Pfu/tvl91QjmHWXBndnTemWbVe6Giev4ai4dOGrXd0DAA==
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
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 336bb644cb7c..99a0fa479704 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -298,5 +298,7 @@ __connector_hdmi_init(struct kunit *test,
 	drm_connector_attach_encoder(conn, enc);
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ERR_PTR(ret);
 
 	if (edid_data && edid_len) {

-- 
2.55.0

