Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0662F606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NbSi2N4c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D10AB10EF17;
	Mon, 16 Nov 2026 10:33:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31B5B10EE6A
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:32:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1B5584057A;
 Mon, 16 Nov 2026 10:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730361F000C6;
 Mon, 16 Nov 2026 10:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825157;
 bh=cOhwyaBbnJzmiQU9Xwmdc5ahIxUXVWSuGkjc8QFdAjM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=NbSi2N4cMQFaIXPvHgarRniumy6ILzCmsVHHoX/QOoqD07xHxWkqh7fdcdDkqOIya
 l8zsPL6P4coa5NP45r7r6p0xr4BhOFDRegZJ4l0i/+8MCTt17GA+CnvgDTmUil0b6G
 Y5vo64BWgdNyGeBeAzO1VRm3dY9m5HdsCSEk6TJpfbvn5WA9OIrQ0HZqzztMdYT6Bx
 Z6OBQM77E77xZfSZnPGmoiFb7RDwyil+DM8krrC8NNAs71KxUPjiqYsNYck1poj+eG
 Z/9jhYrxNni5hd/5voNEK865sNaK4VAvcxP7vXCPk5ec/Ot+eE0BEJiS1ZYFPSuCgH
 tUVVjfi9ZYuAQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:47 +0100
Subject: [PATCH v2 31/64] drm/st7920: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-31-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1271; i=mripard@kernel.org;
 h=from:subject:message-id; bh=SXxJCTyYv2KmPM9Y7plXRPwMNyzCiW68837YPOkCWz8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bvsWP+Dfp7bozOtmvfw06ZdXV6YFy55yc1myTHXXr
 TuHGZuZO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBE1p5irBX9uE/4lfKPVcfb
 txfkv5vZ+W+R4ju2qf80NBc4TtuSleNiOu3W/ayD9RZXOI88fq9u9YCxvmp7Z+mWrOLlm4+7uoX
 805EzFZjsfY2lYGGwRVX9sYs7tbTXivxy3fbrw491nlxfN+m6AQA=
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
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/gpu/drm/sitronix/st7920.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7920.c b/drivers/gpu/drm/sitronix/st7920.c
index 2f2c808e783b..616d83387d31 100644
--- a/drivers/gpu/drm/sitronix/st7920.c
+++ b/drivers/gpu/drm/sitronix/st7920.c
@@ -782,13 +782,11 @@ static int st7920_init_modeset(struct st7920_device *st7920)
 	if (ret) {
 		drm_err(drm, "DRM attach connector to encoder failed: %d\n", ret);
 		return ret;
 	}
 
-	drm_mode_config_reset(drm);
-
-	return 0;
+	return drm_mode_config_create_initial_state(drm);
 }
 
 static int st7920_probe(struct spi_device *spi)
 {
 	struct st7920_device *st7920;

-- 
2.56.1

