Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B501C606D812
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iYigDmCc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED36C1127A6;
	Thu,  5 Nov 2026 15:32:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D4F811279B
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:32:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1612B43B41;
 Thu,  5 Nov 2026 15:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7317F1F0093A;
 Thu,  5 Nov 2026 15:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892755;
 bh=YZFeFg+23zqgkVO5qNimKsl9/ZOYHV/wphKXzHJcxlc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=iYigDmCc5aFoQ9qusikWUmCl2WwfvvVgKXz60pLGo1nSqGpT0enkKmM7RfskNHEIV
 4F6zZkNGR0G/wnU17SFbCg6MNdg3BiXdxW6geLngwD//18dN17uOp/hrGvSdBI7MmA
 n7v6UW+7taE9sHcjJQEYmkrPfIJ6PVOyb96KNOpc6+9HbBbMbLq02LRgCaUyy96Ihx
 GPtYCYyRDf43KwZ7QI4P5IQ/gtJZPzvKY14XKKyU7hgnO2kxdXtReO2WXIPaWybcrv
 Z55Dq1BzstE4D/3yqJpz4BnKPBO8wINWTqPhD+nQmVUzmyee38zoqtPWuBrzo0Pco4
 QOCVFGOyDLcZg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:48 +0100
Subject: [PATCH RESEND 39/83] drm/st7571: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-39-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134; i=mripard@kernel.org;
 h=from:subject:message-id; bh=0Bj13gCEoIc9Frkc3EbznZoERZtcGRG5MSAaxfaBOKM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFrzLlPsT2dr9+CC/stn0xW3uHmm6fP1GvMZfzzEeS
 e598yGvYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEykNYix4Z3AyzvPndvvt/zd
 ZXMmfuHepOITgTc4i50jxN+5fFy3JvzpTXb9Wm+/d5f4rq8pW9Rtzljvuc8jW+8ez+XDkz5Ep8h
 uTXptJFJq871sO4vvFibRGK1VnT6cF3zZE2ISNhz2S3770B8A
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
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/gpu/drm/sitronix/st7571.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sitronix/st7571.c b/drivers/gpu/drm/sitronix/st7571.c
index 608d38eab0fc..2d82fb78587d 100644
--- a/drivers/gpu/drm/sitronix/st7571.c
+++ b/drivers/gpu/drm/sitronix/st7571.c
@@ -868,5 +868,7 @@ struct st7571_device *st7571_probe(struct device *dev,
 	}
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ERR_PTR(ret);
 
 	ret = drm_dev_register(drm, 0);

-- 
2.55.0

