Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC79606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l6f7f9In
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE9F210EF15;
	Mon, 16 Nov 2026 10:33:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49C2A10EF04
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:33:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BDD1B6276B;
 Mon, 16 Nov 2026 10:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978D91F000C4;
 Mon, 16 Nov 2026 10:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825192;
 bh=9HRTEvheEXiGTpNLkyTi/YIrjZGWMgoAOdoNQudNlEk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=l6f7f9InODqoWI6oFseDT0AfBIrhs2SMFYmYCqyMqrUWWZup3y913qAbnCSf2lWTt
 580izODPP+LvIP9gb9/k7BgFeXyd/h1TyzgQellD1YHp8w0O2n8K2KXl5Ab9MYJdP/
 BsDrZlseF0/7+hrAKVVQuHGVW476itEme35Jp/TcuW3rJIUOT7pguzIfRHYUGa3VAI
 zM2U0Taqfdguw3j8pQGXD9CgSix9TVIVpqOyPrFo6GIINVUDN20fuqs/r1etJGm6ud
 QUxe3rdWKo1bsRVCgZTnhGRqM0xK1ylFia6UGWO8bMMcsglhvTuiedFBUYt3UW6FDb
 URkbHrz8dYP0g==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:58 +0100
Subject: [PATCH v2 42/64] drm/tidss: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-42-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1414; i=mripard@kernel.org;
 h=from:subject:message-id; bh=cdwrx4bcUsOm+m29L44Am4KCphsooZjnagz89gfbkps=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bgfp6lsJOF5QUshUj5fes1+k5OGfzMSlzX8zdDVXT
 HaeKsnWMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACYS6MZYX7pJX7Ck1OCHt4WG
 cOqvL0w39s1KqdDeonp9h8jDxG3h87SPpHrIa7P+4L9R2eq475gmYxXTtP/LUs5IXp7vlqbzK6F
 p4oY9Lf84PNOa7a9vm9UZ5P3KqvbFt2Upd5Iv1k58KvxsjysA
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
Cc: Jyri Sarha <jyri.sarha@iki.fi>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
index 44b0b009c29a..e258f656cf03 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.c
+++ b/drivers/gpu/drm/tidss/tidss_drv.c
@@ -164,11 +164,15 @@ static int tidss_probe(struct platform_device *pdev)
 		goto err_runtime_suspend;
 	}
 
 	drm_kms_helper_poll_init(ddev);
 
-	drm_mode_config_reset(ddev);
+	ret = drm_mode_config_create_initial_state(ddev);
+	if (ret) {
+		dev_err(dev, "failed to create initial state: %d\n", ret);
+		goto err_irq_uninstall;
+	}
 
 	ret = drm_dev_register(ddev, 0);
 	if (ret) {
 		dev_err(dev, "failed to register DRM device\n");
 		goto err_irq_uninstall;

-- 
2.56.1

