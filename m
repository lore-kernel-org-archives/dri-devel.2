Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084E7606A321
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7yvG2V6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E4DA1126F4;
	Fri, 30 Oct 2026 10:04:49 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15B4C1126F0;
 Fri, 30 Oct 2026 10:04:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D21A743A4F;
 Fri, 30 Oct 2026 10:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC181F00A15;
 Fri, 30 Oct 2026 10:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793354680;
 bh=fO0AO1ezML1ZvparvLGZsxHnWBCOQ1gQ8CStf/I59JA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=m7yvG2V6a9LDM3vmUc2xqLggBPZCYSe5YZ9Sf6vOqZT4FnUEHaH/rT2r6FGVw1YS1
 RDlNZtbaTAX8z8/DP9XcMZd85nMS9pkqEi8KuOGKUV8jCx5gqV4fI29N7gRTkVAf6a
 Sw0xBjhFB8lRq8RRNA0U/H/X62nvWN+sI+WGQN7mhYm/WPoKVJzTYlR351Lfo+uptg
 g+NQT9Ov/X1cRINLZEKybBo/Lo7BLHK003VktMyRm0+DQKEO3bM13qPyIOM4Bev/ph
 FOoBQtmRiKOAuQDt/Zy80TUv8lPcwcf+U9AbwMvSulqMfk+5aolZ7k+VgRPVghyeDb
 xCSQVJIfB8yTw==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 30 Oct 2026 11:03:58 +0100
Subject: [PATCH 2/8] drm/msm/adreno: Register GPU debugfs only on the
 primary minor
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-topic-a6xx_ifpc-v1-2-6992841a9a32@oss.qualcomm.com>
References: <20261030-topic-a6xx_ifpc-v1-0-6992841a9a32@oss.qualcomm.com>
In-Reply-To: <20261030-topic-a6xx_ifpc-v1-0-6992841a9a32@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793354666; l=1617;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=f0rysbieKC2sAalawNQh6GSoQOPxzKQ6TMGwbEHZnbM=;
 b=rfHuaJLwKeVD9NfY3XbZbksMHnwfylga4ZO9Gim/sq9YaPlay8NioaPSXpd8xWM5ZSBvN5BlI
 i7UxuBG2ayRBz3sWtmoNy1Jx+fqf7DTBwkn5WScAigZiN2AsH93gSpG
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

adreno_load_gpu() calls the GPU's debugfs_init hook for both the
primary and the render minor. Since the DRM debugfs rework both minors
share one debugfs root, so every file the hook creates is created
twice, and the second attempt fails with "already exists".

Since the DRM debugfs rework:(commit 0b30d57acafc ("drm/debugfs: rework
debugfs directory creation v5")) both minors share one root, and
commit e76e7ec8f162 ("drm/debugfs: drop debugfs_init() for the render
and accel node v2") made the core call a driver's debugfs_init only for
the primary minor. Adreno's second call predates that: commit
331dc0bc195b ("drm/msm: add a5xx specific debugfs") added it in 2017,
when each minor had its own debugfs root and the render node needed its
own copy of the files.

Remove the odd call to fix 'already exists' warnings.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 7108d4aa59b5..8154371e04eb 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -123,10 +123,8 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 #ifdef CONFIG_DEBUG_FS
-	if (gpu->funcs->debugfs_init) {
+	if (gpu->funcs->debugfs_init)
 		gpu->funcs->debugfs_init(gpu, dev->primary);
-		gpu->funcs->debugfs_init(gpu, dev->render);
-	}
 #endif
 
 	return gpu;

-- 
2.56.0

