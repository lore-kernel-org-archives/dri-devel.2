Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECF2606EE82
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ahbqePA4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 134E511278E;
	Thu,  5 Nov 2026 15:32:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79F0111278E
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:32:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6365541FE8;
 Thu,  5 Nov 2026 15:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C050F1F000C1;
 Thu,  5 Nov 2026 15:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892733;
 bh=k/97alcCOK4DVxBFltuxJ1VVMwRvHtEP9C2pbfwoGxc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ahbqePA4p3jSk20uYNHeGgDze0HF4HgHKnO22NHajWl0/DOsuuUieKUzsgWZLkKif
 P8IAajoyRPz5SwKBGUPyOb83qgzpSe2Vv9z1rZwQuFpNc7S/2YqCnFU6MR1BNcj2Qt
 wkvDZwwUqKjw/CPTaLqHaKmN1suGIwnqsDlyOGZ/ccUJwj5hOueysruN1LP/cqt8qA
 FDEOavfQUZtp11xwRwLXbzGQIxGvsUU8DigTGbEZhw8SopZD3Py81hNCgmgN+vw+Hy
 gkK7GMmI+w4cgnpqtnT3+XeI1cwB2oTyjA/A/mY00zOZp6PnOuQkYrvVV74dva1OYw
 0B4GPvpZuoekQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:42 +0100
Subject: [PATCH RESEND 33/83] drm/pl111: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-33-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=mripard@kernel.org;
 h=from:subject:message-id; bh=yTR0/rW1SmlAy8RrrokK0ISXH4L4DpcLWKiKUe4dKHI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFrzu0XPuLxL6eNjZ5qbyztvWV48tdTpTsn32ndyK7
 +6Bh95ydkxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJbNrL2NDxVdVF3KMmh/m0
 pHNN07wtC71StHJd+l9yWr2uczYwNVjQ+zEqONLaVXjBrEDvPM6FjA2n56+e8iLFoqbYoH2qxdr
 EnOD2M1sWrEqq3bFfbkL5ZN9okc4flfz9qVmG/as+17lOXgMA
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
 drivers/gpu/drm/pl111/pl111_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index 89d44e970510..fbfbb8efd2e9 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -182,5 +182,7 @@ static int pl111_modeset_init(struct drm_device *dev)
 	}
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		goto out_bridge;
 
 	drm_kms_helper_poll_init(dev);

-- 
2.55.0

