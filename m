Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F92606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EZjLTyQW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E419310EEE0;
	Mon, 16 Nov 2026 10:34:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9859B10EF23
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:34:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 74BD0628A8;
 Mon, 16 Nov 2026 10:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20B41F000C6;
 Mon, 16 Nov 2026 10:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825241;
 bh=YCZdpEmszwcZYnhmHUsrbmVTleQTVCyJOkiKF1AWntk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=EZjLTyQW8NbhuJ/D4J9towLgOPKtmb10PsFP3tVNU0d9MgdB7tMuwfaSJXCFbf9jA
 EWYNqkqwKUY4eD6wL5NqGRTxZ6kNjpvI4I1uNJGFBKh0P5FgxaK4EBgtALcdcKngxi
 1Blnz3nSw3LZNaty5HNQBCo6HtrTYB3t3PfWquuD74ZoRGyJkdUFLLkBn4H7UrbY4G
 vZhYj0pNtBZjV0Ph575i4XTUeoKZ1NbVx3GNk4Q6P5Wp9QS1PZt5OtT8s7LKzgfFBI
 txM9Gtqx1pBhs8b5VFdUX9OBp6PUUJoNeatexMQrD/x/H0Xy1gyHw5okI7cPVuvmSX
 6f7VBK3E6qIrQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:31:13 +0100
Subject: [PATCH v2 57/64] drm/sharp-memory: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-57-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alex Lanzano <lanzano.alex@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1370; i=mripard@kernel.org;
 h=from:subject:message-id; bh=twB5upAdpW3CZK+rv0/7GVFKLc3JD9cBNd6nSj+N8T4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bkfE6RkHJud3F5XNYUgPEeyVuKAb6Pb0o1TB4XthU
 rcKpzh2TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgIm85mFs6Gu96X7Q5Oamu918
 91n4+6SNl+1JvGrmxyz0Y8PaJ9nfREW8Tr6RedsvtHOT4boZm2UrGGu4TnMasNX08PQe2t9U4W7
 hV3qYIYRR++/v0+EZKR53/2mrGa4WuLaj/3DHw28v+y7stwUA
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
Cc: Alex Lanzano <lanzano.alex@gmail.com>
---
 drivers/gpu/drm/tiny/sharp-memory.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
index b948e44544d6..579782940cf4 100644
--- a/drivers/gpu/drm/tiny/sharp-memory.c
+++ b/drivers/gpu/drm/tiny/sharp-memory.c
@@ -618,11 +618,13 @@ static int sharp_memory_probe(struct spi_device *spi)
 				     NULL);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to initialize display pipeline.\n");
 
 	drm_plane_enable_fb_damage_clips(&smd->plane);
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ret;
 
 	ret = drm_dev_register(drm, 0);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to register drm device.\n");
 

-- 
2.56.1

