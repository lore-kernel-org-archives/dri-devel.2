Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B534606A33A
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UFX3vnZk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1F811127A3;
	Thu,  5 Nov 2026 15:33:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BCC911279F
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:33:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5F2A0421F2;
 Thu,  5 Nov 2026 15:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D031F000C1;
 Thu,  5 Nov 2026 15:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892802;
 bh=CSy84AcvIkslDK90qpHg+5sPusx0mmovKHyoizOZf/w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=UFX3vnZkRJd3hVNkP93x0VaZzz5y6gA2kEZadAAicqfSOuNirhQO6gHqjJdV7quuh
 42OLnWk6mbmb7JDgDxFcGaPmE83UYpXgj0A/pDu3A7uy1dWH+6VB/bJQDuszTRPzXA
 cm5ktaa2cRcUSLcvW6p4T/fx4vBZ2oM1g/K3nMWZuyhidy6ZLt5C8FpWbRDm7g4pOH
 9jOKlY2qQDVf9L4O/1Llz09QGvS0qdqL/OR2KiuF4gbvYQjCKw+XcMquXZJwYRvlFI
 9+61CMpuPInp8UjUPYyADSv0wDMFjCjACbKLPWYQxePqg6ofcovtMvS+d0dQMG9mFP
 5kC2OM+TVEkbA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:01 +0100
Subject: [PATCH RESEND 52/83] drm/vesadrm: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-52-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Javier Martinez Canillas <javierm@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Y14Flu3vJyPOLlK0N4qKkug5fZe+l+MhZNs5F/krPaM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFnx592Pnr0Pn583p5fpTc2Xu2XnHlvLJNiyucXt/X
 ql7Q4np5o6pLAzCnAyyYoosT2TCTi9vX1zlYL/yB8wcViaQIQxcnAIwkb0HGRsuHU6f/95gZ8G8
 hT0O5UemFQX8vZCtf0Rsse755teOES7zuzazN2ucz+3xnbJxpr3Ps7+M9TXlTF90FMxiqnLeHUp
 qtbvCendb8Znc8GfvqpTrGd8u231x+7OPK1geNTEyu6wNqJurDQA=
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
Cc: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/sysfb/vesadrm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sysfb/vesadrm.c b/drivers/gpu/drm/sysfb/vesadrm.c
index 1668aabf8687..474fc2db0ee1 100644
--- a/drivers/gpu/drm/sysfb/vesadrm.c
+++ b/drivers/gpu/drm/sysfb/vesadrm.c
@@ -610,5 +610,7 @@ static struct vesadrm_device *vesadrm_device_create(struct drm_driver *drv,
 		return ERR_PTR(ret);
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return vesa;

-- 
2.55.0

