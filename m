Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545E3606A329
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSjJhQBo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B78D01127C8;
	Thu,  5 Nov 2026 15:34:44 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB63D1127C0
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:34:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 50876600AA;
 Thu,  5 Nov 2026 15:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796581F000C1;
 Thu,  5 Nov 2026 15:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892878;
 bh=NuZpbtZlwzp0aGDM+7DSz589NnLvC3hXbFOJ3+MElI4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=BSjJhQBoGDM6twYi4IBL9QWJbUuWPS4ZyossMjJLR70efevEiBZkTkxzDYAxyySJ0
 udnAWqMubO2PzH6LHlxpNel3aDn7e6iSU4tyHjhMXx+lE/2Xw0fnc5zK4Qlbzgpork
 fAGaxDVSaK58mwzOqDczF9/HAHEa9VZTSE/tjcMZjw2Pbz7wp9MX4OskK3FxrcWPfV
 tjUhr3AwP2HsKlJM/3K2aDiUVrfqsEM5Y8wSH9TjxRxh0tGBtRKhUcS7KVm8T6PQCR
 Iv5+tQvy6D8Zn5O09unKk0S2Pf3qf12KGtokGM1J9AUgqi30jXecbDEU8UlEu1kKLr
 3yNsvBRJYodEA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:22 +0100
Subject: [PATCH RESEND 73/83] drm/sharp-memory: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-73-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Alex Lanzano <lanzano.alex@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ASSWVuGR3ja8uza5LqWo9tSvoN2APEXdCH1PzRR0sR4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFvxVkDRbtckpX6DMPPjZPaX0tOrK8zYG/+N07PVyJ
 q9fFxnVMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACayiZOxYdn3mg9uzl+CnxtN
 Tcufdkxl1VUv7+8+kha8XMJH7I8qft9q/SerxXye1oz84F3SdXFnGOvUvKc2Ms9Xzgp8qfeZy2e
 dzrN+Z3tm+YaZfPaX169futmT8XTmZcXJJh90u08aVhYzRAEA
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
 drivers/gpu/drm/tiny/sharp-memory.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
index b948e44544d6..579782940cf4 100644
--- a/drivers/gpu/drm/tiny/sharp-memory.c
+++ b/drivers/gpu/drm/tiny/sharp-memory.c
@@ -621,5 +621,7 @@ static int sharp_memory_probe(struct spi_device *spi)
 
 	drm_plane_enable_fb_damage_clips(&smd->plane);
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ret;
 
 	ret = drm_dev_register(drm, 0);

-- 
2.55.0

