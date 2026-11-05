Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D03E606D802
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g4bB+qVT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38DF2112768;
	Thu,  5 Nov 2026 15:30:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41004112761
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:30:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 254ED42213;
 Thu,  5 Nov 2026 15:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE531F00A15;
 Thu,  5 Nov 2026 15:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892625;
 bh=FxQqa3wY9oP6iELl8lfe9kDcoiCZY4gqx8EtaEotyTg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=g4bB+qVT+KiN5ARkO6vA28TFPiIZYRBgPbRUtSOWapO3TYKIw11wGtXlchfaMHTSF
 D45QvQmHRmEV9ChNQy/EoGUDM/a0fK7rHk7Gmr6z/rPI1SEdg9NG6ZvCfVoPvGKXaY
 lNIVlM+CdxnWT+P4sZTP+GTi1qUDPlynsWzV9vYSMjdC5O2GWFmoC6+N899WXiE1xi
 7i9vcp1PPaB98NbS1yTnooBnNFEedtiK7NpWtaUS8k5Ac6grGHrPgY65PR+L4avfkB
 cn7YLZGODjY761+FCC/pwdpnInwU1Chc1GeewJXgh3QdKhm6vSS0DaNjrO9vAARmnQ
 fct2w7HItZIFw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:12 +0100
Subject: [PATCH RESEND 03/83] drm/appletbdrm: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-3-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Aun-Ali Zaidi <admin@kodeit.net>, Aditya Garg <aditya.garg@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129; i=mripard@kernel.org;
 h=from:subject:message-id; bh=M0XvfQbich2kcinuZ0GCbGsfWYAe7SPQzXSKFCh0h2U=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFtxbMVtg71fnJ+FaByZ3vmQLcGJeZn06oqxj2d2Nk
 7+dW3Z5c8dUFgZhTgZZMUWWJzJhp5e3L65ysF/5A2YOKxPIEAYuTgGYyMkwxobtH/Sf5iidlUxe
 tHHSy6ZmjrsOK/oXSXBHKCib/DxW46boGnRc6bz7hNm3VH29I3fv92Os044w71P4tyQwTpIlj6f
 9cNnlJ8brmIuVP+5/EN16OlH+7N15ebks/UsuLzzxZHfR5gYOAA==
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
Cc: Aditya Garg <gargaditya08@proton.me>
Cc: Aun-Ali Zaidi <admin@kodeit.net>
---
 drivers/gpu/drm/tiny/appletbdrm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/appletbdrm.c
index ebfe37557bfe..73315d538fbb 100644
--- a/drivers/gpu/drm/tiny/appletbdrm.c
+++ b/drivers/gpu/drm/tiny/appletbdrm.c
@@ -730,7 +730,5 @@ static int appletbdrm_setup_mode_config(struct appletbdrm_device *adev)
 	}
 
-	drm_mode_config_reset(drm);
-
-	return 0;
+	return drm_mode_config_create_initial_state(drm);
 }
 

-- 
2.55.0

