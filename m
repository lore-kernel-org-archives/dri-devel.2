Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A292A606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jIQzohmQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E38311127DB;
	Thu,  5 Nov 2026 15:35:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D577B1127CF
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:35:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B729140D6D;
 Thu,  5 Nov 2026 15:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169C31F000C1;
 Thu,  5 Nov 2026 15:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892903;
 bh=UQEs02W7+OTl5YUy4B9ZbN0RuwZjMptonvyIGpg6hHo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jIQzohmQVlLRNhJcB3qWmDjf7GSOk/tYAp/DO/sg/zLdMpre9EDyOTiNLfz1nZctb
 yO/2JItrwQd15P/6hZ0Gw0HJUGbYZdYHgMGEM6oxKgQKz8iYqFwBFbBNDubrXC4S07
 9a9wvXN/yCmeUQYAMkbfLS+77pWC2bdqvvqep0dn5QtxGJ5mVJA/PcxlDWSGmHGXjD
 aKXc6QvDdoW/nXjrpxmv5dNxx3YK9SfU59nmaQ2Igm68bKE8EvxXd2aonXy+aJj7b1
 NzolZ+x0T/SAxy8JCcLSUcBJLKr6GtZc6izAwM93X+aYUAqT2DwJC/GSaGdClOqmlz
 vNhco2kUHbqig==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:29 +0100
Subject: [PATCH RESEND 80/83] drm/vkms: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-80-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Melissa Wen <melissa.srw@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1164; i=mripard@kernel.org;
 h=from:subject:message-id; bh=UysxI80bLU0YwSm9IRB4Mu2pOePve0PFbO+3zV5IQQY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFjLsM9ZbY3HwhfJN2YJlPrGcMkHhgUenxaVXnI27L
 7+IvzO5YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzk2grGhtNnbBh37v2xfpbl
 3fBzD+p16oOfXzpjHuT5X4PnwdEO86t1i1dJan6/ui9FecfJeVpNGxnrwz+e32R30fPXCV6u4mP
 nrorpCswV+z5B8stcz0ciE/lZWaYZaLBsPKJ9sXqOTVTMLFtDAA==
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
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Melissa Wen <melissa.srw@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_output.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 86ce07a617f5..982c6cd5fcc7 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -116,6 +116,4 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 	}
 
-	drm_mode_config_reset(dev);
-
-	return 0;
+	return drm_mode_config_create_initial_state(dev);
 }

-- 
2.55.0

