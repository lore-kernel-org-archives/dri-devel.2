Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1FB606A339
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mcengLX6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4332112773;
	Thu,  5 Nov 2026 15:30:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D87112772
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:30:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DB9C841878;
 Thu,  5 Nov 2026 15:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5841F000C1;
 Thu,  5 Nov 2026 15:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892635;
 bh=1T23L3ipuQSn2BUrf55OVYXWwx/x0lGgBPdbpbwrVxs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=mcengLX6hSC9MoInKeUsM2WpZBUx2vyFrTk4aAI7HgoUbxxBkOsqmqHDuwXCFrblT
 iYwrhP6KDQECkhN5JNEgCOa1/Db9eQKJyHUPl/fuQGNPhlmvHnsG9yS0m1rNP9FV0S
 04D2fReJnf/IDz9XAuxjcE42aPRLguz9JNLUS2ccbMaAwlSb7UgJnOlunoaq9atyfm
 9V5COowwO/1Z4IttvZzuyqTgbyfreDtx+pqdUDehGKk2DZOQMwuKHyNU9eUPCWwwHU
 FvE1gWrrrb9pCcjdL+rICeFWrKd1lhxxbmxaVIXEstBqRFxnvuYbAxwlqMj61OYdyd
 GceRnQl1WwXMw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:15 +0100
Subject: [PATCH RESEND 06/83] drm/malidp: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-6-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Liviu Dudau <liviu.dudau@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=mripard@kernel.org;
 h=from:subject:message-id; bh=TRBPGH+TkGNuMyf7I3oFxuIsPrtN2tq28vA5vgM32x8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFjzYcnL1P4dtZ7MmTudd/tG0bXet+7X44/vYs1r3l
 0U9q6hL6pjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATEUhkbPgioSwktEYsTEu0
 4V/d69dWlhdEp53z1p+tkpjwdNquvNm+s9ftcTupnrJBbo/gsRmPKxgbJrKb/YgSX6a146y2UGu
 J4NwAn1e3+59XGcT/YJ+877OZaOFyz5159lt27MpqPv7g3nJXAA==
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
Cc: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/malidp_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 23fa942ae4bb..b4e38eba5957 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -857,5 +857,7 @@ static int malidp_bind(struct device *dev)
 	pm_runtime_put(dev);
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		goto register_fail;
 
 	drm_kms_helper_poll_init(drm);

-- 
2.55.0

