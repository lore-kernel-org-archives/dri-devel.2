Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA62606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lQbFT3HF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE6AC10EF26;
	Mon, 16 Nov 2026 10:34:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E6B10EF21
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:33:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3426162894;
 Mon, 16 Nov 2026 10:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576471F000C4;
 Mon, 16 Nov 2026 10:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825237;
 bh=+/CzcX1gx9u7nXfBwqPaMmzHhBxfj3F8nQ7cXa6bGzE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lQbFT3HFZqhM1BSXC7kS+pnR+hWMs12YeXewRuCTsJ/LPSYwctZTAeOaMJ8ZRCAsu
 fkkbhisD5Iki3p27qfjXx0VKR6sAoWds/d0L8YFTArlbe8fIOca3i4c3OYwYzYphRD
 W1viQpKi6I1ECJRG7v9PjKekvm664dSiSgYVThGA9zF8E4jBjV0rS9RBwDF62IWAsw
 jUReSVzbuXwTFo3wRBA8f/Nx270kEBp161hkEAIuTospwtgFTuQcDZtybwKN9I9w+2
 w7rtU/hri1C4yYqMD/e9j8/HKI4ZKer33oPZfM8zaNc5lVc0DRSDTm8eBoQjAOeVia
 702wRE2QUn/Cw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:31:12 +0100
Subject: [PATCH v2 56/64] drm/repaper: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-56-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alex Lanzano <lanzano.alex@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228; i=mripard@kernel.org;
 h=from:subject:message-id; bh=4MjBMTPcTlAMRlMF01flJXvQCEdtmmSL0cKuN9YcIlE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bkesLProt+NWhOkTO/M34e99xXYfZ/j+bbHC7N493
 ql20sasHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiLOaMtaLrFf/16i9vD3n4
 5maUkn6UU+WTVbPv3unU/HtMMLQq47Nt2oLVk1b/LX6QeMihRN3yCWPDnTWfNI7UTO6Wfl4RcYR
 9+tu8b3/qVzAWiYjmSpeU3vw10dB/f8Pkpnm8zKcOn7g0J7cYAA==
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
 drivers/gpu/drm/tiny/repaper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index 25e6a7a4affc..4a0f55e3a9ee 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -1188,11 +1188,13 @@ static int repaper_probe(struct spi_device *spi)
 
 	ret = drm_connector_attach_encoder(&epd->connector, &epd->encoder);
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

