Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D346C606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvzOJ7sD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D400C1128B0;
	Fri, 30 Oct 2026 15:15:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 786601128A4
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:15:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E28C42E10;
 Fri, 30 Oct 2026 15:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9131F000C1;
 Fri, 30 Oct 2026 15:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373313;
 bh=dbaIHLcuRbf1r7XswiUJ2Hr/t7xo3JLQ7W99G9BTu7o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WvzOJ7sD//fGiLJ/RUIfLiqhKkBTIN4OWG90A7bJw6Dog5eWUc6RpsyPp/m+6IOwI
 tE6CMwQaOYRXEN7HYwyfiBYgja9c1kXG6pYu641l8+LeXSF36ost5bpfqnLHiuRDb7
 9FAlCHNawFj45qqEzs/YPpoGRP7y0jdfns9c7ieIUAphpwcrKAimqkbQ+CRaQXn1W6
 qC9xdi/4qne+FMNv/HKQdTO0hEbvR10c2Xx5yOwyNT08DtlZ6KJPKVEv1+TCE1pdD2
 SOB8GmXviKh7IiQz7FpcGy24iJsnhhcd0ZPZP4oAn31aJpEkh9z35ijsjX70s/dF6e
 QiTzOp4DzVpdA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:13:52 +0100
Subject: [PATCH v3 22/37] drm/tiny: sharp: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-22-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alex Lanzano <lanzano.alex@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=mripard@kernel.org;
 h=from:subject:message-id; bh=aa6IrZpHRTuvFTS2chWcIBQW1uO7UQc6yLUVp5CXv2E=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtqgfviw1SWDvl6oeLePnPKUtZU2s99zt/00Oi/L93
 +TqdjyzYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEykuYWx4eSerHYJv2dS0vte
 1l5nS/rJc6tOnj/9xKfNmjNsih4HbVIvnnbxQrz99VXpUkr+W71fMDZcya/9O/mxpfrmdQ2PCqf
 5RV+yd3ovrt2ip769dFpBTP/LV3Kz5XoaM/2deIPOp0xPXgEA
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

The tiny: sharp connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Alex Lanzano <lanzano.alex@gmail.com>
---
 drivers/gpu/drm/tiny/sharp-memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
index 434e73bd25a5..b948e44544d6 100644
--- a/drivers/gpu/drm/tiny/sharp-memory.c
+++ b/drivers/gpu/drm/tiny/sharp-memory.c
@@ -370,7 +370,7 @@ static const struct drm_connector_helper_funcs sharp_memory_connector_hfuncs = {
 
 static const struct drm_connector_funcs sharp_memory_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

