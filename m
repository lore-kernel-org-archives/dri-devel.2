Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2112606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lr2ugz3u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC58110EF1C;
	Mon, 16 Nov 2026 10:33:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7B4C10EF1D
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:33:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D0355421FC;
 Mon, 16 Nov 2026 10:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBAB1F000C5;
 Mon, 16 Nov 2026 10:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825218;
 bh=OWwJtdR9I8/zcRAOcSzC2NNXxN3UWKsRgB7qZE+WkkU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lr2ugz3uJnJaSxqY3ysVuh2+c2/EaHaVS8bvyl2BhiH9N8D1qeyNUFD0FcJ8Z0nNM
 CTM4vIzVMfbYdB4L90RL1C3B7vJeKdJTPpe9qWHM21yq0F7c2A9QELUP+jiQOcmJe4
 566N6xGOg+m0oQUIrlfRzkSgdNzxDchJan7iNA0yq/+N34/pR1CKXNKdQ8PQnKNz4I
 aOhqLSirR3PzO6CXCyC2sWVxNbat1Fg7aYqnT+g2y7txlEAM/hvhpBavyjCEt4jAD/
 KWtRUtht/RgNv8LA2bhFQDHOF+xvgcYepj0K77SVDyKfC7OyOH4Lh6zpIYaAHOjsEX
 1LoaV3RPyfBWA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:31:06 +0100
Subject: [PATCH v2 50/64] drm/ili9225: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-50-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 David Lechner <david@lechnology.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213; i=mripard@kernel.org;
 h=from:subject:message-id; bh=XhphqJVbwLBpXA3ntytP9Wa8OTZNgnACHz6uYinaWwo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bocqZt7uEQqoChE/I2U/VfPklT/dKhHb/6Z39f/5q
 LzMhMWtYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEykyZ+x4TSDlMatxL8iNt8m
 Pzq9Jrd9q96enZbV8zlLzOZZGLLtaFsUMNfv1KWEunWn6w4c7FKJYqxTenzxPjOXuNaBV1Pvl/7
 /WN83N1Vus+wqk+ha1xvVsXfM/36XEs3ff2N64pEQhob/Z5YCAA==
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
 drivers/gpu/drm/tiny/ili9225.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/ili9225.c b/drivers/gpu/drm/tiny/ili9225.c
index 5bf52a8fd75b..3b1f3b9a0abe 100644
--- a/drivers/gpu/drm/tiny/ili9225.c
+++ b/drivers/gpu/drm/tiny/ili9225.c
@@ -516,11 +516,13 @@ static int ili9225_probe(struct spi_device *spi)
 
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

