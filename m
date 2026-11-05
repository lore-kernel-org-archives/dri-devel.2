Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63641606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WhnGPkKo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B60A81127C1;
	Thu,  5 Nov 2026 15:34:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF3531127CF
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:34:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A936F403FB;
 Thu,  5 Nov 2026 15:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E601F000C1;
 Thu,  5 Nov 2026 15:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892892;
 bh=e8/ss3FRtAzJGclCGjADo2NbztK/6thbbt0IEd2WxLA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WhnGPkKocavo+8Ud7VIOyFZ5drKhAKV/Yws3ZoSeC14goyoFES3rtRefBnU1ySqxo
 J+nbPqtYFRhDSd6ebWIpcz/XxbRYuNyGKCP21QXeGnw4njM/Zed5e58vcWxUb/9lhG
 1ELbPQLl+Z2dyGjJEemAKkvilgIihocIqo7NzRrgshL4SXHvy0wtVGBCoGlxZoXcyU
 Iq2Mgq1yUpwb1HibZ0f8xTo9qak3JOZKMoqzuG9huLuiQkOYS4h2OvrYPC9GyIz6bJ
 Q/+wqtrQTxM+w5oveaBOJklzfZOQuYNlmdshJ4Yd8F+zestnhJEuaVb2FN/5r48OKb
 l+AZEWstNehKA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:26 +0100
Subject: [PATCH RESEND 77/83] drm/vc4: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261105-drm-no-more-config-reset-v1-77-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213; i=mripard@kernel.org;
 h=from:subject:message-id; bh=NpamOVhuM8V8MaB2NibVE/8ROb80bRpKhlcYCwV1YpU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFvwvPp8WmWF0Rr4t7HScFo9z3pUOdtmpIjenWmX7s
 lz0LxbumMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABOpvM3Y8PZGVuk91sTaCbsU
 0r7ZZIRd05viLCIofeLJSpsVkocsGSepfX3H8fCWxESZ32mcn7zWMzbMimdWLlgq+795p+QK03T
 1Ip7noWl3o7T197Me+fWcVfPrXK3/Sac+5p0q8nvq/djY5z8A
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
Cc: "Maíra Canal" <mcanal@igalia.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_kms.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index 82a7f2ac4c7e..ab551eb2da50 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -1187,5 +1187,7 @@ int vc4_kms_load(struct drm_device *dev)
 		return ret;
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ret;
 
 	drmm_kms_helper_poll_init(dev);

-- 
2.55.0

