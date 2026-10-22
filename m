Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BE4606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SDBKcFvH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EA0F112598;
	Thu, 22 Oct 2026 12:34:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10E261125A4
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:34:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 79CEE60200;
 Thu, 22 Oct 2026 12:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75F11F000C3;
 Thu, 22 Oct 2026 12:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672456;
 bh=i35Qm+qMMyurhBoKLlGURfbkNeXYO7YQcls/ZdewMAA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SDBKcFvHrkO7MkRXGz669eaxnyVwUUKZyss6fUExk7R5fCDWmb+qqmchy/6JqygMS
 2uKaUmdS1M77MQ/3gtZrcW/rFYFmA2x6okuUvx4q21BfzuJpn45YWYpmLAQJDG/ai4
 f51tZbWuv+LrSWPAeRI48ktgyBxVEgeMg/PD0y2Ju2z3t5TwoyfRjELbQh2Ba7ABBR
 8oav/bgyo0W2O6qxne86j6PPmyLadyKP8u0lJv/5Qx1de/5vN0t3fs9gyadoeNut6q
 5cBkNfMDQV3nTAFruGJWoEM9pNlPcpKQzd05AJ9ogiBIV3sOIemZvHC+GY4vW6BDKu
 apGzxfqwA1FaQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:07 +0200
Subject: [PATCH v2 08/59] drm/bridge: analogix-anx6345: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-8-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1101; i=mripard@kernel.org;
 h=from:subject:message-id; bh=iUJnLivR/qesp1K52yMGXmVxSDwm0/09r/ESAXOB1GU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mCZe71GdcWZ1S1ZUhpy40/8fm29/11x4/8q9rAcHJ
 81hYvC+2jGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmsjCYseEhy7o9657e1lvf
 Fxm6fOaS29s+LVQOeXPy8e6E9soJPauWGcSImZe4fzx2/LbfnNkn5f0Z63PNt+7ZInm2fdp2/tt
 y3/L2TDfZ2JGv2GYadfiQ/aTXCSEbym8n+b/csVZvwdz1t7wV8wE=
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

The bridge: analogix-anx6345 connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
index 407834a03b63..0cff9ff0265a 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
@@ -484,5 +484,5 @@ static const struct drm_connector_funcs anx6345_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = anx6345_connector_destroy,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

