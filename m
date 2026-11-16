Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE89606A332
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lbhcYG6T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64BB610ED7C;
	Mon, 16 Nov 2026 10:32:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 225A810EDC0;
 Mon, 16 Nov 2026 10:32:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0794C46209;
 Mon, 16 Nov 2026 10:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B12B1F000C5;
 Mon, 16 Nov 2026 10:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825121;
 bh=knOyFaUO3FKrhtRHRqH99Z/CNRw2SZfnLMjOYRBuGnU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lbhcYG6ThTQrKKTCgi81ikBzpWvTujiLVp5oJZNIx1XVg5yVFqFpW5+S5WE1EudfM
 pISg+uRhbaTNF7MhwvhzJW2LBhZhiyOOfO9umtczIqM/Qog0cSM9gYdkRUj0olRm2w
 +chNF3+rwDavZIZXr6OddKX3UGZIPqxiWavvZvDivFV+4CsLlNlFGs9zhNbX45rjqw
 atIUXl8yt29H+gTFghkUYRpLCG9dVcL3tmYZV8lcoZvZCl+PtraQkdyv//VwuFZS6t
 ep/wlk7WQrm6FfvY8NWn/eSdVw1rI0uc5Se+QJTMblnCDW0Zg0qsTdfR4xNYBNYqvs
 yDbtAAZE13XmA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:36 +0100
Subject: [PATCH v2 20/64] drm/msm: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-20-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Dmitry Baryshkov <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532; i=mripard@kernel.org;
 h=from:subject:message-id; bh=PcY4ZpeNGzN471kZUkkkcGkDS5JzxgkVz0ugy/XkvFY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bnscL0iQqL8xmTf74Zn7wb4rn+1b8fgHz6HjTtoyr
 ke2Zp+Z3DGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAm8lidseFbAbdcyWcR3Wm1
 +fyBq5banFp9lu/H+ySBCcyO55d3Xt6/7baaONsS7+n7WDKeS6y628RYH9GTv13fL+hMxZr2/U8
 KLrcfXr/N+33JbidBtX2rVXIibaxWb1tVL5q/UIDX/RjLL75lAA==
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
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
Cc: Dmitry Baryshkov <lumag@kernel.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>
Cc: freedreno@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org
---
 drivers/gpu/drm/msm/msm_kms.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index e5d0ea629448..9592fa28c85b 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -329,11 +329,13 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 	if (ret < 0) {
 		DRM_DEV_ERROR(dev, "failed to install IRQ handler\n");
 		goto err_msm_uninit;
 	}
 
-	drm_mode_config_reset(ddev);
+	ret = drm_mode_config_create_initial_state(ddev);
+	if (ret)
+		goto err_msm_uninit;
 
 	return 0;
 
 err_msm_uninit:
 	return ret;

-- 
2.56.1

