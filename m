Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7461D606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LfxudG9D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B0B61128D6;
	Fri, 20 Nov 2026 10:40:48 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A432E1128CD
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 10:40:42 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so6742235e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 02:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795171241; x=1795776041; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b/qJoLFhb7whNR1fmKsxBm/CKb6ds1LT3YrumeDpyEA=;
 b=LfxudG9DRj0QVT3birXXpfAf45zLctc0uP2TP7IKxq5AtripdaX7CmDyGuADeLnrNb
 IZ75rLmcyDGwhvhKrcWhVf4S9LBYQwPdXeGWANfxNL5DYJ3tWMgwXfNnPB+w5vb3vJ4M
 tM8ixTdLaW65liTA8VCRCu7KSp6ldnPAvBxPtbE6IAxJN7gonsOC4m9FMJZ2Rid18BLx
 YhG34DgFNCwzhfeFbg0uuv/AYe2tppdGp48llJ5YtNhmWRG1JXZbfqz7j5MzmZUcQWH0
 v6ZQjqMy6qxkJ8pw94HUJCHbh/nnx3ELWMty2PpGpNWU5H1QdVKKOb1KaBNmhBpAI2z/
 C2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795171241; x=1795776041;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b/qJoLFhb7whNR1fmKsxBm/CKb6ds1LT3YrumeDpyEA=;
 b=ArGITxZsqAnMIEFmfWmE3uPa7xjqpF+zKVQvyCshgqnQNE+boBsGx4Lrl4khDboTdU
 nz3autTekIQsH/FLdFVzde3rxqAzHod0AxFhfeWTaUwQPenxEnAob7B08gqHcAfd9S0e
 2GU8bK0hgNljaRDko60M8fodn5XXhqniuEktQOrykk8aWlDl+K0PG1UWuirjGfRV3QmU
 +3p2lz06xHWIxOP4OBUfoXPV4w1U+P2mAFDQLxvmoITo0XLn5SiydB3zPnqc/T2TN147
 x+0oPhtCqsruOYXdBynwGYrANvq0GjuWs5/JQ3K8rxdCwf5KYT2WgBlBjx9DDSR5Yea/
 b10w==
X-Forwarded-Encrypted: i=1;
 AL+hErFcGVuIauFku9BmFsxeH/pDAs3gVJqrmXGa1j4YbcQJaJBbK1zsvtGnFNMierI1T353X4TgqFuCUHU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8VptLIINNooxNPNLyHTh18EWYouxznJ4J99zHDF2kA3Tz7EJLL
 esykTNK06pLrE3kH6jNo5uVaOOlFNMZqhtzJiCDD/Ib+i+sgiGL29WaS
X-Gm-Gg: AYBFou22XDMFGtGiVqcpH5beNyEsJ2ZBfIaREG62/6E2xXn4nRsjVbhNEkGta9YhhP+
 SpD0Bift6hS0QmCQ/SEA3cWkLcup0Y1/himVhuh4hnzhnoPQ4zFzRQwEp0kGLWsyVPVtrIfkRuO
 osMhSea5WzNXWb2bl51HQ3pNbRWSG39+PBiO4glKSXufgFs0JNNtJ4bAiTZ81CPxJDnEtKoPGPM
 +g8f0VRK/qOCcr1Ks+XUFvMz+ggRXuEqJkqzdPQ93i5ZF7DcVLNKIfqmWV2oK5CFP+ihC89rFLS
 unrp9CaMeXwGqedQsST3qVoJxVJaR3EHbWKQOgqhHTHQFJKKaHv9bnyWVG2/3asedTTQje2bILf
 xI6CjdeB23Ah/rbAJddEDJEPrxwPrbY3jvMVx8ImDJFeG+G5hIoGR4Fmy+6V5v/zzHuhRbhf/aL
 DI6IwtL8zVdMJLtlADJmK0IMtjRYdKogKXnnxAOOb1IZ3xQoI7mdhpvXlKtUfzgYlOCl1UGGNWN
 wQVTbPdtewyvBk8Z9d6cVd95HtLx5NUurF0y/emX/fLeAGI3sEm4R+06dfbCaeWcCYzHTyj2q6o
 gSilFpvMnRB7yzQKJEF+uSxN8P59tnyTfVzm5k7/WkG4t40e+f6W5AmtSM43YRVF0wZXkj8SK3Y
 hPUmPbRZQPXFerye0iXOG2KKLpxp5MrhVh56zoKWwKDCpESb2Q54=
X-Received: by 2002:a05:600c:5303:b0:4a2:1655:87db with SMTP id
 5b1f17b1804b1-4bb88785d2fmr58497555e9.0.1795171240966; 
 Fri, 20 Nov 2026 02:40:40 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at.
 [80.108.121.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb895eec06sm22297535e9.2.2026.11.20.02.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:40:40 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Fri, 20 Nov 2026 11:40:30 +0100
Subject: [PATCH 4/7] drm/etnaviv: Don't change the clock of a suspended GPU
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-etnaviv-gpu-freq-trace-v1-4-445fc6eacddf@igalia.com>
References: <20261120-etnaviv-gpu-freq-trace-v1-0-445fc6eacddf@igalia.com>
In-Reply-To: <20261120-etnaviv-gpu-freq-trace-v1-0-445fc6eacddf@igalia.com>
To: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: kernel-dev@igalia.com, etnaviv@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Christian Gmeiner <cgmeiner@igalia.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Gmeiner <cgmeiner@igalia.com>

pm_runtime_suspended(..) only looks at the runtime PM status and takes
no reference. It returns false while a suspend or resume is in flight,
and nothing stops a suspend from starting right after the check. So the
cooling device can write the clock while the GPU turns its clocks off.

Check gpu->state under gpu->lock instead. The state is RESET or higher
only after the runtime resume or the init reset has programmed the
clock. A GPU that is suspended or not reset yet only stores the new
scale, and the next resume or the init reset applies it.

Take gpu->lock in every place that sets the state below RESET:
etnaviv_gpu_rpm_suspend(..), etnaviv_gpu_unbind(..) and the failure
path of etnaviv_gpu_init(..). etnaviv_gpu_init(..) also keeps
the lock from its state change until the init reset is done. Otherwise
a cooling request during the reset is not applied until the next
resume.

Fixes: bcdfb5e56dc5 ("drm/etnaviv: add etnaviv cooling device")
Cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 0a28e21feb8b..c819f5fc4418 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -886,9 +886,12 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 	    (gpu->identity.minor_features10 & chipMinorFeatures10_SECURITY_AHB))
 		gpu->sec_mode = ETNA_SEC_KERNEL;
 
+	/* the cooling device may change the clock from here on */
+	mutex_lock(&gpu->lock);
 	gpu->state = ETNA_GPU_STATE_IDENTIFIED;
-
 	ret = etnaviv_hw_reset(gpu);
+	mutex_unlock(&gpu->lock);
+
 	if (ret) {
 		dev_err(gpu->dev, "GPU reset failed\n");
 		goto fail;
@@ -952,7 +955,9 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 
 fail:
 	/* the GPU is not used, a resume must not set it up */
+	mutex_lock(&gpu->lock);
 	gpu->state = ETNA_GPU_STATE_UNKNOWN;
+	mutex_unlock(&gpu->lock);
 	pm_runtime_mark_last_busy(gpu->dev);
 pm_put:
 	pm_runtime_put_autosuspend(gpu->dev);
@@ -1792,7 +1797,8 @@ etnaviv_gpu_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 	}
 
 	gpu->freq_scale = state;
-	if (!pm_runtime_suspended(gpu->dev))
+	/* a suspended or not yet reset GPU picks up freq_scale later */
+	if (gpu->state >= ETNA_GPU_STATE_RESET)
 		etnaviv_gpu_update_clock(gpu);
 	mutex_unlock(&gpu->lock);
 
@@ -1888,7 +1894,9 @@ static void etnaviv_gpu_unbind(struct device *dev, struct device *master,
 	}
 
 	/* the GPU is not initialized any more, a resume must not set it up */
+	mutex_lock(&gpu->lock);
 	gpu->state = ETNA_GPU_STATE_UNKNOWN;
+	mutex_unlock(&gpu->lock);
 
 	if (gpu->mmu_context)
 		etnaviv_iommu_context_put(gpu->mmu_context);
@@ -2031,8 +2039,10 @@ static int etnaviv_gpu_rpm_suspend(struct device *dev)
 
 	etnaviv_gpu_hw_suspend(gpu);
 
+	mutex_lock(&gpu->lock);
 	if (gpu->state != ETNA_GPU_STATE_UNKNOWN)
 		gpu->state = ETNA_GPU_STATE_IDENTIFIED;
+	mutex_unlock(&gpu->lock);
 
 	return etnaviv_gpu_clk_disable(gpu);
 }

-- 
2.56.0

