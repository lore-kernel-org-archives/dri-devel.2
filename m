Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D15606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RaIXbvmu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31C841127C0;
	Thu,  5 Nov 2026 15:34:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF1221127C1
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:34:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D5B6E40AD4;
 Thu,  5 Nov 2026 15:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DB21F000C1;
 Thu,  5 Nov 2026 15:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892881;
 bh=dLPXgUX6gtrXo7fP4TxpM+LltPpUCdB038l68DbV5Ho=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=RaIXbvmuGhe4S9O+3gr+JB5cpY09hXnsdgmCn9myIUdLvA+yZ3K6CbD3bVSPA8xe/
 emileOLZiyDCxvs84BZQ1rYw7wl3xoQLD4ecCUywRO2AFNpUQQnWkCu7mQ2I1sPLEX
 NtN2uNytf6hkhNH//Rj0ce6Dk36xSrlgElCIwbqaLjTkfTXkQiBXN72YLiXPVTVGnn
 KS5w3xI0+SbncH4oVGFS/mpjhtTF4kC6Isx0+Y5cajn7EFaMVOg06N4qY49I/p+YlV
 fdTtlZFYsdrATgYAZLXpJrYu0NfxXKAPLpS7CB7n34FV5rJp5poRSRgTpjvtt6XBIC
 dlItZ1iKlBxxA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:23 +0100
Subject: [PATCH RESEND 74/83] drm/tve200: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-74-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127; i=mripard@kernel.org;
 h=from:subject:message-id; bh=TmCu4JWuZu25CJK3tObO1ap8LrTYFGkPvQew20Jy+w8=;
 b=kA0DAAkTJ1/OGaI9vnYByyZiAGrsoP2gEX88MTFArvIY2d5ypwtEehhnonpyyIIssDu2xvYFr
 oiVBAATCQAdFiEE5BxWy6eHo3pAP6n4J1/OGaI9vnYFAmrsoP0ACgkQJ1/OGaI9vnY/EQF+NQYz
 U+ymUbW0Vklrvi/ccpUXrvqY3OHA9XbNO5d/9hm/J+4jLB0DiB4PV3tJ4ZNPAX9/nuyHib08aDC
 Q0gs6lZ1xsiqN7XRsI6ZCwsAVSdgNK+FRgwZ3wmleMhLaUd2n4/I=
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
Cc: Linus Walleij <linusw@kernel.org>
---
 drivers/gpu/drm/tve200/tve200_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
index 2bcb9dc86ffd..fe94b34d5b41 100644
--- a/drivers/gpu/drm/tve200/tve200_drv.c
+++ b/drivers/gpu/drm/tve200/tve200_drv.c
@@ -119,5 +119,7 @@ static int tve200_modeset_init(struct drm_device *dev)
 	}
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		goto out_bridge;
 	drm_kms_helper_poll_init(dev);
 

-- 
2.55.0

