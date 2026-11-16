Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665D6606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bo1xbYmQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD6810EF0C;
	Mon, 16 Nov 2026 10:33:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFE9010EEFB
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:32:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 99A81421FC;
 Mon, 16 Nov 2026 10:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC741F000C5;
 Mon, 16 Nov 2026 10:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825166;
 bh=6eVqaPk+9NKP0SnNEhopV5Eeox0W1MQgwiceH6E1TAY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Bo1xbYmQt9aIwkpCLMIzmOBUEOLdkW/xvLklRLB66J7c+KYi/MBs3oKT1PQVm0nB0
 S7kyd0JA+9IEdKy0MqsfR4PE1CoV7ZIP+eOeTk3zpzIJlAIIBpVbMIrzlVhq1gGjPk
 YycW9bxd+RdmKsLakDIzgleIDeXJO25qaHiuYjdsCVAAdViN0vgjIcI6a/Zfk6KAo6
 ASdAYcHnBn6zSz+GC74sl5QQieGlrfAR9yuzhF5pL2pwMoaV44otB4Irm0i2xbvlxV
 AtehgVCJ7MMolJR+/SDM6/EjCqimNA7VJ7eczOH04y63/KK5lUDRqTHteKMRKYvbV/
 H2BJZLTTpOkGA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:50 +0100
Subject: [PATCH v2 34/64] drm/sti: Move
 drm_mode_config_create_initial_state() before drm_dev_register()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-34-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 sashiko-bot@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1548; i=mripard@kernel.org;
 h=from:subject:message-id; bh=SSRQ+E/oT8yVCpiuHtIMFcw4U0wC2UG4lazDjKmc05Q=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bvu5X1rLsjhlPd/VvWKX3eJZti/f2Bkde+b3rXksH
 M8X31Fc0TGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAm8nYuYzX7yvr0j2ZRu57s
 efK2ueDAhwm7czg+MTn2cPK3hciE313t2xR5b634RM9/7IrvK9bLZTA2rFXZfyPs4SOVY8I3E+2
 86lo0ZLJ1L/vIzPIJnPp7y003yafZai9/983cN/VF7FJff8MIAA==
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

sti_bind() calls drm_dev_register() before
drm_mode_config_create_initial_state(), so the device is exposed to
userspace, through its device node and its connectors sysfs attributes,
while the plane, CRTC and connector states are still NULL. A process
opening the device in that window could then hit a NULL pointer
dereference.

Move drm_mode_config_create_initial_state() before drm_dev_register().

Fixes: 84601dbdea366 ("drm: sti: rework init sequence")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/r/sashiko-outbox-200075@kernel.org
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/sti/sti_drv.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
index 794badf199c9..7db8de8744a4 100644
--- a/drivers/gpu/drm/sti/sti_drv.c
+++ b/drivers/gpu/drm/sti/sti_drv.c
@@ -195,24 +195,22 @@ static int sti_bind(struct device *dev)
 
 	ret = component_bind_all(ddev->dev, ddev);
 	if (ret)
 		goto err_cleanup;
 
-	ret = drm_dev_register(ddev, 0);
+	ret = drm_mode_config_create_initial_state(ddev);
 	if (ret)
 		goto err_cleanup;
 
-	ret = drm_mode_config_create_initial_state(ddev);
+	ret = drm_dev_register(ddev, 0);
 	if (ret)
-		goto err_unregister;
+		goto err_cleanup;
 
 	drm_client_setup(ddev, NULL);
 
 	return 0;
 
-err_unregister:
-	drm_dev_unregister(ddev);
 err_cleanup:
 	sti_cleanup(ddev);
 err_drm_dev_put:
 	drm_dev_put(ddev);
 	return ret;

-- 
2.56.1

