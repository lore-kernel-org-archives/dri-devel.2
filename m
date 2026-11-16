Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DF7606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cOJYpv1i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEA7010EF2B;
	Mon, 16 Nov 2026 10:34:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 704AA10EF21
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:34:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 594E1434F8;
 Mon, 16 Nov 2026 10:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16781F000C5;
 Mon, 16 Nov 2026 10:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825245;
 bh=4kTwAWXb2fWyNK1QLT4lc891ow5rzqar8ZHYSq9im2I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=cOJYpv1igPD/BBsqq2mZ9ZDu9rBwXmtATtRNPXN7nd5LbBPPPM2VA6z9ptGBR+Vgz
 HIgfITW6a5mjg//B+38J1cIOxBXXJRKoXkpecr/xzxThzAU85+hhFZuErRpMasl5v3
 7UgJQ4zeCVG5wMqhDHMKK9ImOyQuxzT7xBesvn4OG8lWU8GYB8mnDK/FKgmYGQWHbm
 QUBlQOgxe+kglAP3C3GpgetUNcneYXE+awdVoKT56gvlSVo53X6Xe8Fy4FsJWS1mBb
 8BawiILu+7a0obYK8cR+rDjHyQtdvCNaoR0lQ/2kbjbBajBSdWRWRXwHGyDgksRnEh
 FN9pdmIkdTFIA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:31:14 +0100
Subject: [PATCH v2 58/64] drm/udl: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-58-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1239; i=mripard@kernel.org;
 h=from:subject:message-id; bh=hQj/+9EcYWLaCWd8D0NpwSfwZD+oBv59tNCi2js147g=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bke6XrraqRGd3/j66bqudpGK0vYPXAuyvJzeTPu0Y
 E65waENHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiojsY6zN+nSufZR7Vuy+b
 3aJRVLs/r+i/4pVNnp6bD/aLJ2xuM5O0MhXIVKzXk/sS0/V/hlc8Y63IFuNDG80DmC8ETjPOu/n
 z0c55171nHDym7JMSM0nc8p7Nu+V/F07c/2HnSytvX6sF9qsB
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
Cc: Dave Airlie <airlied@redhat.com>
Cc: Sean Paul <sean@poorly.run>
---
 drivers/gpu/drm/udl/udl_modeset.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index d8a617e2d2ea..02138457a97b 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -538,10 +538,12 @@ int udl_modeset_init(struct udl_device *udl)
 
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret)
 		return ret;
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ret;
 	drmm_kms_helper_poll_init(dev);
 
 	return 0;
 }

-- 
2.56.1

