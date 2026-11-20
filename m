Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C1F606A32C
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lKgjl5yA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F8271128D3;
	Fri, 20 Nov 2026 10:40:47 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADB5E1128A2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 10:40:37 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4a7b8abe209so498607f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 02:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795171236; x=1795776036; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wWjEO3N90Ag9CCKCLSbaqSxSbDsFMtzLcLHXCqLa5hY=;
 b=lKgjl5yATIztk2Q/om7FRPFksg+yknEw/i1L4fPy6c1qDJyxrtqEUZpD1lOwsa+cJ+
 6PAOxSXitjw/SF6MYvBHfeOOmGVH7WG17n8VI4d643el716dRrDrpookP/E7wBrqpck4
 zheWdVkkc5S57SFOEiBYVyExvv5QLY2UBlPO6OZVbCwnKVqD9B78Lz8+gY/g1aspPwxS
 rf4yHa+d5YLZRSnD5bzozDYH8fR11WPqgYPO0lXYmoq+jCFNBF9m4YS2CqTsCffO1xHa
 ADCoUp89abGUBfByeZrcJOsngcMKrjD1IqMQpaErOr8bVW/pMsITAGe/EjRrDjG9lp+/
 mWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795171236; x=1795776036;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wWjEO3N90Ag9CCKCLSbaqSxSbDsFMtzLcLHXCqLa5hY=;
 b=NNkwUYBj5I0N+8B6Ea8hX0jXFcR06b8dCYhbpEgtHsmXihiEEIz5+EXyJbtGAlGSiw
 Jy3TQL/zx1pwG1RSb5gdOACmBbxSohgZQ+I3DhLXgVrFvimX8p2tQAUvnouMDZBqdS+Z
 gr8ggxcAXOLLBNCDSKDcSC4S3Rz03gG/Ey5I09v5T64z2GzY3BxT7/bcqTFzdMnX+zHS
 tCEoueDxf/twEFGsju+ZRgFBg0luzttNGAOFJBeT5Ew9ybGuW++MUuKc47/OkmvK+LzU
 BWQU2vAiLotT4q9oxNrG5F6hnnNhjybgFTa10/A9P6cUh1jZTxPTldq5+C+SwtOdK2x/
 RVXA==
X-Forwarded-Encrypted: i=1;
 AL+hErEQlsj7/MPJuw3WYxOyRPS5dtCgHBmdktNxM/ZRDsiobgveXKQ5bN54MERkY01/uICjuhWc5hDpCuI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+ondfi+8zZf0FiE0PugGEeIIP4SZR22f9OSAgWZkR1r1ncD7fs
 8bL87KI3dw1DPpHOlPF5vvhUSI6mCvWBj1RIbkmaym1ciP0cNmm5fmfT
X-Gm-Gg: AYBFou1GAfyVgyaWkdbrZnPdgCGd9ES3CgJDAhmFZsARlt8CPcnXtoVK66cloj4Yyk8
 Co5thi7JeGJVJ06wZD/KyqXJIdFoYa/PpKv89f6HtPi+qOrgUpirZ5xhvdkTEW2jkkb9BGWXeaJ
 jNoxLtNCg1HmhA+iQiY1EOfsd3ZqoQRrHIh1TB9v4cHLlpd+6o7b96Z/cH6avDLc9HpKf9J+1Mr
 QfuuJ6eOZpp6L4xX5drRUzaGz/C1GYmcg+BXOsaCzfezZFhXOL+ltBaTVoMrnSWYCbiojN2z1LX
 wkvWc7SP9uR0+O4Slm4AQhHQOW1hjHQLlXeadQQNwB5FwibtcK4/GS/9vwkQfKB+uzBUYdTTk+t
 Uz1DdpjNyBBaIksL6QK3WcYUf7mw4qQpJJTLDaB/EQ0po5V3iW3wYLcr2pWu0tziDgHCFaR+Cu1
 6ZNIf9n3AVQalMRjjsg9Od077mYVx2/6d+1fzmQ/foB4IBRWWxHqmZEvzhQT2YP9Ui8fJ9I8DyP
 YcZLVDdWVrDayOrnH+1ck2PIFzbA94zzfiDeokz1G4/72r4wOLCJRHyrRZJTE/j3UW6pw+eWsh7
 FhU+Xyq58rfBDuXoWRzvMdA6l/lqcYk3df/L4Wlg+tsZKdVBMVEpFsxnlJw7WUP3/Elxz+CnW+2
 flRRYFpC8p+0HYGwVDlU2cyFG7mCbP3b2soJT63FHQpLBQSEy2tY=
X-Received: by 2002:a05:600c:8b11:b0:4a1:dda8:eb73 with SMTP id
 5b1f17b1804b1-4bb8881c630mr62257765e9.27.1795171235703; 
 Fri, 20 Nov 2026 02:40:35 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at.
 [80.108.121.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb895eec06sm22297535e9.2.2026.11.20.02.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:40:35 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Fri, 20 Nov 2026 11:40:27 +0100
Subject: [PATCH 1/7] drm/etnaviv: Don't set up a GPU on resume that is not
 initialized
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-etnaviv-gpu-freq-trace-v1-1-445fc6eacddf@igalia.com>
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

etnaviv_gpu_init(..) can fail, for example for a VG core with FE2.0,
which is ignored on purpose. The device stays bound and is runtime
suspended and resumed later.

etnaviv_gpu_rpm_suspend(..) sets the state to identified without
looking at the old state. So the next resume programs the clock and
runs etnaviv_gpu_hw_init(..) on a GPU that is not initialized. An
unbound GPU keeps the identified state as well, so the next bind sets
it up before it is reset.

Go back to the unknown state when etnaviv_gpu_init(..) fails and in
etnaviv_gpu_unbind(..), and keep it in etnaviv_gpu_rpm_suspend(..).

Seen on an i.MX6Q with its ignored GC355, and with its GC320 on every
bind after the first.

Fixes: 647d817d8071 ("drm/etnaviv: better track GPU state")
Cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 6a4aab75ebba..2a15ae6135f5 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -951,6 +951,8 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 	return 0;
 
 fail:
+	/* the GPU is not used, a resume must not set it up */
+	gpu->state = ETNA_GPU_STATE_UNKNOWN;
 	pm_runtime_mark_last_busy(gpu->dev);
 pm_put:
 	pm_runtime_put_autosuspend(gpu->dev);
@@ -1874,6 +1876,9 @@ static void etnaviv_gpu_unbind(struct device *dev, struct device *master,
 		etnaviv_gpu_clk_disable(gpu);
 	}
 
+	/* the GPU is not initialized any more, a resume must not set it up */
+	gpu->state = ETNA_GPU_STATE_UNKNOWN;
+
 	if (gpu->mmu_context)
 		etnaviv_iommu_context_put(gpu->mmu_context);
 
@@ -2019,7 +2024,8 @@ static int etnaviv_gpu_rpm_suspend(struct device *dev)
 
 	etnaviv_gpu_hw_suspend(gpu);
 
-	gpu->state = ETNA_GPU_STATE_IDENTIFIED;
+	if (gpu->state != ETNA_GPU_STATE_UNKNOWN)
+		gpu->state = ETNA_GPU_STATE_IDENTIFIED;
 
 	return etnaviv_gpu_clk_disable(gpu);
 }

-- 
2.56.0

