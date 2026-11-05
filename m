Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19176606EE99
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kt0t/0GZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7806E112799;
	Thu,  5 Nov 2026 15:32:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26DE9112794
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:32:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1060043B53;
 Thu,  5 Nov 2026 15:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DFB1F000C1;
 Thu,  5 Nov 2026 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892765;
 bh=TYbT2Msy9GgV7RZsT3pganqws0GmyEO6NTzPXCCOaTA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Kt0t/0GZ6jOdy+AkNI2dBl/3J+DzKdB3BW7x20Kl6FNJ3NQbyhZjaFI5QCQo0Dgm0
 fgFoo5SHw8Kx0IUfAAdkKtWhPJs6UqvFUy1i40eFuf+TkR9Lhf1moeNf+FZpvOsFAw
 fJyJIT0naM6cUN40v3RrX83zGFO7wYOZG0UeV+Wwqo8ffdzbJ6Gil6waJ1SeuXxUPi
 JqLA8055GxtzPSlr/5fNoBV+CS1Za1Eloy6z+ENGZ/4zB8+YSDoWAphso2bfLJAVHd
 alPKJPKN6gMghx3eJgeMiepyF9Z3y/NhC+SWGMjDVeu+hQPOgX4SOdfv16aHNrhbid
 IRFiY+rDymfgg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:51 +0100
Subject: [PATCH RESEND 42/83] drm/st7920: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-42-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081; i=mripard@kernel.org;
 h=from:subject:message-id; bh=uBFWAnlFCyWSJn/6lGeoChUfbO6LSStEFHuklx0uVwU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFrx3D704WXe5YDnjTduyKNeeE6t8HdL3T5jztUbhu
 ZCru65jx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjIRBvGeoe/j/f9zL8x5fni
 Q3uC2v/NO7CgKj0i8ulBZ+WJ08NYTvsaHn+gXxQd/theqnkf+/KWMMaGvwejfhwr8Tl/kcnSkVH
 hXcKsVvv6KKMlpYGfzrY9Dpp/QZr59elj0RktAUsSlnwLKeEBAA==
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
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/gpu/drm/sitronix/st7920.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7920.c b/drivers/gpu/drm/sitronix/st7920.c
index 2f2c808e783b..616d83387d31 100644
--- a/drivers/gpu/drm/sitronix/st7920.c
+++ b/drivers/gpu/drm/sitronix/st7920.c
@@ -785,7 +785,5 @@ static int st7920_init_modeset(struct st7920_device *st7920)
 	}
 
-	drm_mode_config_reset(drm);
-
-	return 0;
+	return drm_mode_config_create_initial_state(drm);
 }
 

-- 
2.55.0

