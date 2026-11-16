Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A99606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ryo9Oa7R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE5110EF29;
	Mon, 16 Nov 2026 10:34:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A60BB10EF26
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:34:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 88A5A44DE3;
 Mon, 16 Nov 2026 10:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B6F1F000C5;
 Mon, 16 Nov 2026 10:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825248;
 bh=x0kvkC5KTq+t2bbglYSDQFpj2ygtQpXAOfztNhVSF0g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Ryo9Oa7R64j3Kw47+ztQwOCaTYK76t56nrt3EU15JDnHtaM3LEitT4Guh6k3qS/01
 IPsDWXjcjKK/At8WMsYV2cMjiOQ5Ly8RNITNwGhq0fbY0Gez5rRpSOFOdSmIsCiZYy
 8zxWYlFkpwzh348EBGw9aQhZ5UIahldoHRX3UmTz+ET7xbXHCKwqBxsF2wc2+0Tixc
 UzFV/yxid+wNxrg6tUNUfhNryBJthFrgk5EBFohME/E2aPw6qDOoVSiKaO5glWaiUn
 6/Jbf9Ajaz7rNtYrkV2uaTpVjXpJn8/RKrHuW9Cpy8zKWj1OshA0biTeDvWzFrV9zd
 9b5TzS8rBhWUg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:31:15 +0100
Subject: [PATCH v2 59/64] drm/vboxvideo: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-59-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Hans de Goede <hansg@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1295; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Jfy90Wf9whnMpEDYxwY8nd43MfyMcYH74+kIa1aCxGE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bkdVM+1a6SW67fSJjatWqT6YKPt1xY21dtXvRa/M8
 pGZfnLt7Y6pLAzCnAyyYoosT2TCTi9vX1zlYL/yB8wcViaQIQxcnAIwkYCLjNXse1/dtmpco+Z1
 rlbTLeCK74/6c0t23//brj4zo/bKY6ayK8KMTV62YfL/IprK+L8LvWesUwp7z6K8bWmB0qr61kz
 mdQoq6fc6TVWUdnN18KW8eWPykm1H/a3YmemTdx7o+3Lj54F7AA==
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
Cc: Hans de Goede <hansg@kernel.org>
---
 drivers/gpu/drm/vboxvideo/vbox_mode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vboxvideo/vbox_mode.c b/drivers/gpu/drm/vboxvideo/vbox_mode.c
index d66dc1cbbd82..414f2af1e821 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_mode.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_mode.c
@@ -875,11 +875,14 @@ int vbox_mode_init(struct vbox_private *vbox)
 		ret = vbox_connector_init(dev, vbox_crtc, encoder);
 		if (ret)
 			goto err_drm_mode_cleanup;
 	}
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		goto err_drm_mode_cleanup;
+
 	return 0;
 
 err_drm_mode_cleanup:
 	drm_mode_config_cleanup(dev);
 	return ret;

-- 
2.56.1

