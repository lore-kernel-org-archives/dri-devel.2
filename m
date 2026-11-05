Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3801606A32E
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gOUjQXS9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53A951127A4;
	Thu,  5 Nov 2026 15:33:11 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E70211279A
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:33:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6543160A68;
 Thu,  5 Nov 2026 15:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987C01F00A02;
 Thu,  5 Nov 2026 15:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892784;
 bh=VYcSzDYe2cCmMS9VwuuEsQBYsAyzZgoeL8e35MmNwKw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=gOUjQXS9KJDLxlgEOrKHWcqdUTsEUC2QAcNp4sEJwNnf97Ce8rMkhoUj/aj9d7R36
 WZgXRY8odHnwQvzVqQeevnxWbhbnw8zJotxbFq77VtR/UMxbymA9gKLvSdF5ATWnsZ
 Rh3TEwO/JHgyRNSO3prT/6oP7/vstHM3Ghek886lxnIquuuLWxZkgUbMB6BNxJENGc
 KDU91gW40DVDnKzfAOGzfxWARgz/7ps0Z9YIGcTdqiJ3ChvGLqd7YpKi8Ph/mNXG6s
 5Ug5D3J7w6mgaSNXMAAf6LmeTcz+nTgxK5WcHVLs64uCPmfg+6wIhlih0nxsKHEeXN
 nJtZQ4blQeDiQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:56 +0100
Subject: [PATCH RESEND 47/83] drm/sun4i: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-47-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 linux-sunxi@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1466; i=mripard@kernel.org;
 h=from:subject:message-id; bh=JVsRSfyjg+pxKH6555O56doMPhroT6uX2Lmd+IGrVQU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFnziNjsXOUVFyUcsVje3VdLbxEGGNVrotgzn3XPZi
 TvmtRR2TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgInE5DDWex/J598sNbdmtcbF
 iR/1jm4xMgroPHvhdtHDB1dL5VZ9k7m/pOfLlqTz9tt3Fb6crMb/l7Gh/Rin2M2GD/OetO7o0Ht
 6NODUg6euHnuqHXeuuv/Vibe5KNg4yFSYb1oD4+KprYvnqu0CAA==
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
Cc: Chen-Yu Tsai <wens@kernel.org>
Cc: Samuel Holland <samuel@sholland.org>
Cc: linux-sunxi@lists.linux.dev
---
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
index fc822bc2c62b..0ce3691dedad 100644
--- a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
@@ -11,4 +11,5 @@
 #include <drm/drm_blend.h>
 #include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_print.h>
 
 #include "sun4i_drv.h"
@@ -27,5 +28,6 @@ static const struct drm_mode_config_helper_funcs sun4i_de_mode_config_helpers =
 void sun4i_framebuffer_init(struct drm_device *drm)
 {
-	drm_mode_config_reset(drm);
+	drm_WARN(drm, drm_mode_config_create_initial_state(drm),
+		 "Failed to create state\n");
 
 	drm->mode_config.max_width = 8192;

-- 
2.55.0

