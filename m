Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C03606A32E
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnmfNiPP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB5C211278D;
	Thu,  5 Nov 2026 15:33:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C483D11279E
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:33:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AB84A411A8;
 Thu,  5 Nov 2026 15:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F191F00A1C;
 Thu,  5 Nov 2026 15:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892780;
 bh=hGbAy1C0aUmhdcqzSGHC+7/3PmaFWfvAkLL+/GhSdlE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=fnmfNiPPOoMI1AosE7Td/wxsduvCrFNjh1Q0Beel4e/eZmXZD2YwQOkx5jfYPclxi
 hmWP/Gidd61+mBFe114H0LYM+M/BOVEpYq7h0xpamJEv26DMJmrln8qaUXpmtDSRH5
 /oaSBDpk7CHta8nECDBtwBVK1gKKUEqBfZMQ7HT8wI2pyuCQ548XudFwazlRTjkB2l
 6RpDErU4WzPHnxu2r8C5VAiP+enjfWf4vHgXnfwLrh2166BHZqCZsDUN8XXt1TPQh2
 tcwbm/2r8jfdgMG3KMwgXkbcjV9wbl7SZHSVd47KaKJTRppUhnlXQTcA2rzSNUNVkb
 fQQZ8UxZ/W83Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:55 +0100
Subject: [PATCH RESEND 46/83] drm/stm: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-46-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296; i=mripard@kernel.org;
 h=from:subject:message-id; bh=m+IeKbw6XLsYfGVum2nmmyA+iqtvPVFkbqzIC8mp/1o=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFnz847xY/N2DCYvPiN7/v1b4UcWstsl7bMub2rtLH
 pQqexww6ZjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATUW1jrOGzLPpvcs5/2bZF
 j+Zp7Y/ha5EPfFr8yf3g/0Udn6NZjT3v3Z5x7dtyoTNGk/dXl3dM0mds2MO41HzR9f/yNadXz7X
 RSQ8UzJdK1JqtHznxV+lk5uT4kyV9r6Y8/bt/x/9P4ZvXf+mwAwA=
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
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Philippe Cornu <philippe.cornu@foss.st.com>
Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>
---
 drivers/gpu/drm/stm/drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 0967b9b3451d..60343ffe02f7 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -105,5 +105,7 @@ static int drv_load(struct drm_device *ddev)
 		return ret;
 
-	drm_mode_config_reset(ddev);
+	ret = drm_mode_config_create_initial_state(ddev);
+	if (ret)
+		return ret;
 	drm_kms_helper_poll_init(ddev);
 

-- 
2.55.0

