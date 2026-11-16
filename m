Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A9A606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYLC4HlM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28AEA10EF09;
	Mon, 16 Nov 2026 10:32:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C020B10EE6A
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:32:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A70A04029F;
 Mon, 16 Nov 2026 10:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0514C1F000C4;
 Mon, 16 Nov 2026 10:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825150;
 bh=dtsHlXTIQUib095GcM2lq0+a5o4qlzxIvogBTbZJ9bA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=BYLC4HlMP4y5dUPw8j2yBuRXQw/UDgl57NjCgicgx3E1YxH7FWKjb//Ip4dQYEKzk
 0+5xlObA0Fjmjf2436wUmsJTY0I63kIqxpZCz/5gRxl1YpXt4KgLKe4DhYY4frNwaX
 Gm58mkZls/6iOJYietMZ7qvOYGAoU8zIOQw5HZ8/JAoVQJJguA6tsFkqBOrorTe6Gw
 0ey7YC2qB4UYP8lyeRdD9rbjubHCsWUc4is0Dr0t7FaJ8ig/yHhs3fIKFusoDJ8RNg
 PPmzHB5XpyWH3J0m+PVSRTIWwOotIyU8n0iR3njhJsUEeCxCdSg40qGvLRUYOtF4tA
 PysPIcL3IyP5g==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:45 +0100
Subject: [PATCH v2 29/64] drm/st7586: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-29-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 David Lechner <david@lechnology.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1227; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ZT+GKEar/RUU6xvhvcjNEECjPH0297iFyOqM/4B/S0s=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bvv8lPy9y+GzqeDyraVpa8p1S3Nq9M0qH2zXqLlzu
 1J6vpZzx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhIgwxjDX/WofcKgbPUtdY9
 6Jq6IvHh0ZUmO8Vft9+ZIXOiStUqS+tczB0B9oL55T+Xi2f92xF4i7HhfdL5SXOOLkve/lt5Vp+
 JIJ+KRSlL/SrFm09b35S9/R6abuy7UPmW7lneVZIp8Q+/assCAA==
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
 drivers/gpu/drm/sitronix/st7586.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sitronix/st7586.c b/drivers/gpu/drm/sitronix/st7586.c
index 28b2245f6b79..50b2e4c901ce 100644
--- a/drivers/gpu/drm/sitronix/st7586.c
+++ b/drivers/gpu/drm/sitronix/st7586.c
@@ -453,11 +453,13 @@ static int st7586_probe(struct spi_device *spi)
 
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret)
 		return ret;
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ret;
 
 	ret = drm_dev_register(drm, 0);
 	if (ret)
 		return ret;
 

-- 
2.56.1

