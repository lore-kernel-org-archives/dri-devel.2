Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C706606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CgnNfElp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C65FA1125C7;
	Thu, 22 Oct 2026 12:36:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F261125C2
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:36:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1736860204;
 Thu, 22 Oct 2026 12:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C53E1F000C2;
 Thu, 22 Oct 2026 12:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672577;
 bh=++GHg3Ey+M2qQoh/CfMwDgt5WdSfsnKEhV0rtbkHTmw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=CgnNfElpTMQJwKv08f+/nr5FUVBt8yc2JhLRthby11mbDrTP+MOAfZ+Aco6HZoGjT
 wZK/EBjyIMIGamE9eZOU2rZcoTWwo6DSJsHYx/i+I61zaVYcvHj+fhEnWJCntvXEUT
 fpKt/8oTDFcqNF4LyfeFOwzS0/6vAhnJKfThxxARe6BNpCCYNbNy7VGIMTDFPSstcm
 jrmTn7kJb+6LaLJwTlHReKdOptGIwlSD7MXohh4V3kcbQitEBjGXLUfYwGLXesznBt
 zdNtzN+H3WvK7OU5rZPQ24DZsM7ge49hGN9SWeZqzSV9cVGmkf2F3QaVQRqx4wsAza
 bOH/oDBmB+qBA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:41 +0200
Subject: [PATCH v2 42/59] drm/vkms: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-42-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Melissa Wen <melissa.srw@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1864; i=mripard@kernel.org;
 h=from:subject:message-id; bh=rn5bRJ9bh+nY8mhfj6LcjouIo4gf2+iZ7kX6VPKLL18=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mOYHybFYmtx32MY4oaL8qpDAp80Chmeay/jL14bsT
 cs+/6K4YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEyEYTljnb3wnM0V1/zzLpm9
 Dly2jndKQOmhjAMcZ085p7LNuqY0U7VK79Oq3SeFHurz6X95xrbzPmPDlGNVlycsOPtswdoPjB2
 OXVM0M6xnLWVu5HjG0nW2oG/eCq0pLnUaG5n+P9f4f/HjtqvBAA==
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

The vkms connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Melissa Wen <melissa.srw@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_connector.c | 2 +-
 drivers/gpu/drm/vkms/vkms_writeback.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index b0a6b212d3f4..57138027966f 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -38,5 +38,5 @@ static const struct drm_connector_funcs vkms_connector_funcs = {
 	.detect = vkms_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index ecf29a2c0c8e..858df1f89f66 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -27,5 +27,5 @@ static const u32 vkms_wb_formats[] = {
 static const struct drm_connector_funcs vkms_wb_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

