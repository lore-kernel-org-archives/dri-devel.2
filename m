Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E71C606EE85
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YXdrGja2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB5E211275E;
	Thu,  5 Nov 2026 15:32:49 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 784EE11278D
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:32:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8E34660A5A;
 Thu,  5 Nov 2026 15:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02161F00A15;
 Thu,  5 Nov 2026 15:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892762;
 bh=f9kYW841BDJl6R9wx20cr+/bJ+qfHvkR+5GLFyEPxlM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=YXdrGja2nEg8j5/RuMsmBxbYfGjs5HRTNgc2J919l5pr1dfZDI8yfDAGKhGkIk3a1
 /brbuacCe1gcrlp9UId/cz7TdFWmJK+Q4PqmwZXg0ofpl2MdgJEcNOLsMPJQtXKi8/
 q89azkaZguX1qI+VZ76tHpP8hPJEMti/mCg4kW+9vSh1aW2A74fL8nG+uE9na+naRP
 /L5l965VRdpfVSkKLq+A5FpqpZH8twD0L+ITOVzhv89SolwKf8YHoxDv1SsZ8DC9TB
 9MM4v9/4qqrb1Me1y6VZdomZU/hv8fZZg8BGOqQKqaX0wPeob2CJbQpgsEv+nD+mUj
 LeFoKqLrgiM9w==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:50 +0100
Subject: [PATCH RESEND 41/83] drm/st7735r: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-41-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 David Lechner <david@lechnology.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126; i=mripard@kernel.org;
 h=from:subject:message-id; bh=1bxma7FSgGt9MzvK7ujkxixXtHmZeae4mmBZdFPBtvQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFrx/Vqu1vjbOK0v91svQB0ymGl4J/zzZvsvVGk5+l
 OVjF3GxYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzEcwljfc7n3UbTorekCtQb
 Lkux/5ejF6KyW3janrD/bFP52lJ0naz8/zR1ZdnJR1sw+LSUmvxibJgYLCGXYeZmrHBku+Yt4Yv
 fI0S+CXuwMVjOK9OyNygxTv7/wDpq3qmvRw4m3z9+vdiJFwA=
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
Cc: David Lechner <david@lechnology.com>
---
 drivers/gpu/drm/sitronix/st7735r.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sitronix/st7735r.c b/drivers/gpu/drm/sitronix/st7735r.c
index bd763871dca0..e6c77b01dd38 100644
--- a/drivers/gpu/drm/sitronix/st7735r.c
+++ b/drivers/gpu/drm/sitronix/st7735r.c
@@ -336,5 +336,7 @@ static int st7735r_probe(struct spi_device *spi)
 		return ret;
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ret;
 
 	ret = drm_dev_register(drm, 0);

-- 
2.55.0

