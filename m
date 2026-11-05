Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E080E606A331
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nwg1JxTw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45AB7112797;
	Thu,  5 Nov 2026 15:33:00 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E5B9112794
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:32:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A642560254;
 Thu,  5 Nov 2026 15:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BD01F000C1;
 Thu,  5 Nov 2026 15:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892773;
 bh=Mpo27nnkExZe773eEjkLP9GoG76cKwy/MndOTDtsBnQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Nwg1JxTw8p5wSqYGDxT1dKMkTjJjdrZuAroxolHyRASUZLckGjvGp3La65Lmt7fX6
 WDsZ6IMYmMadkj03JJhfZQfKkCxaNTp4CfqY80Dq/nCDVkFhBzov2DTMcl6BNuoROb
 OkN88QyUSIfphAkAuxl+nBke3HQpCNKuRgTNj+7qc6QgMSc00wU2PddeXEg+YpOm2v
 n3huOkSpwOEO3W/nYCxfEFBuwS0+NSp6E8tagHBXo3p17AsNpApr0/GzNgpnEH7cI/
 x+jr1x6HkA7N6ZpOaTCglvlaLsQ3zVjAH40BOTy0YiZFmNa5An1xYDkN12Vi5sWqQK
 TOBA7nALGGhHg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:53 +0100
Subject: [PATCH RESEND 44/83] drm/sprd: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-44-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Orson Zhai <orsonzhai@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319; i=mripard@kernel.org;
 h=from:subject:message-id; bh=rD4hxdJpHq/9C00HkYLwldzKzozIykfCt/4Tcz1SpHM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFnw4ZmEUX3n5zYHoDEWzIxVbrzBMlSp+IlTYZXfKh
 4fF6o59x1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhI5jXGhnd2k9O/ix04FPvy
 bUxTTtPyW1kLDL//3rvxydlZf5gtnryyvnExbU/ksb+39tUf9J5Xxc3Y8MmELY3RK1Tn7ekjv0v
 KOwR4p8yOkeX1cD5p42fzTiPgrHTNsz42pcQll1YLC29WOr8FAA==
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
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Orson Zhai <orsonzhai@gmail.com>
---
 drivers/gpu/drm/sprd/sprd_drm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sprd/sprd_drm.c b/drivers/gpu/drm/sprd/sprd_drm.c
index c2fd5380a834..cef022f54912 100644
--- a/drivers/gpu/drm/sprd/sprd_drm.c
+++ b/drivers/gpu/drm/sprd/sprd_drm.c
@@ -96,6 +96,8 @@ static int sprd_drm_bind(struct device *dev)
 	}
 
-	/* reset all the states of crtc/plane/encoder/connector */
-	drm_mode_config_reset(drm);
+	/* Create the states of crtc/plane/encoder/connector */
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		goto err_unbind_all;
 
 	/* init kms poll for handling hpd */

-- 
2.55.0

