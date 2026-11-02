Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1F3606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q5bQCVn5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 756FB10ED23;
	Mon,  2 Nov 2026 11:41:49 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92F9B10E03D
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 11:41:42 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so23787735e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 03:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793619701; x=1794224501; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5rqHvwjECQWToFtKKOyTtpPoZY/7s6Eyj9/c7r3hJ48=;
 b=q5bQCVn5Z83tz7u33pUc8dAoueIoVXCk4NCjPi1ZeiGR/abKQryo4DdBlRi8iZmQXd
 PL4gR8FkeYM7MaE7FszuxIkqbbRiDdSfiHOcA2SWYO79MB/zY5Q4Lm7x8L6W0wgQqRJS
 /JunGYNU7aZzBYLbjCqzAGocS15Rhe6riMa7QZfqE+p5vDOwqOaR/CtBDKDKjkcjY2ks
 3wj/gACvKSnbJ3PA6QLYYMwsG3DqAOWzpXPfqpIho6VkseKVaZ4DXIgIsWN6GwHgyB13
 ahW/8n3W/76s3HH0GPU8+iqDiae/EH39m0t+sqE8U0FL+W8yxfkIaKyNlOvFstXL4FY6
 fZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793619701; x=1794224501;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5rqHvwjECQWToFtKKOyTtpPoZY/7s6Eyj9/c7r3hJ48=;
 b=Ez90MllDRNStOfpofZ0/2qO7aYnFAlj+NkmggAo+nRA7J6Ueh9btYPwILea+CQS0UK
 gm4up64v7RXQiGzPeHfOxOBbqwpLEEJ0ZPJBlMYkGSwKOxBcvTDxYpTYEcVMXnRCDA8c
 J3zj6VBofU/PfV/58MtPvvEITrWWMbN8FP+ICwdRDK/BbAKnDEnTqrtsn5TKrgPtFOeX
 0Bj5gWlCFqa5mrganS/ufGduYy0udIjg5t157zWcjzij2/xilhhv7EjB2tEBkUCDCXST
 KphXeFOKUAtbmKPg90dsWpvsd1n2JlmicrymY26SB6E/7mwgVLyIa65vQPMV5xVgv/0T
 Vhng==
X-Forwarded-Encrypted: i=1;
 AKwUvBwpyTu+Ym33Yq3EGYitINOL8Zq+Wd8iahOb9+qzlSenSPZENdmG1kgvuGfh5yMC92sVfNAOwd3Xh2I=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK8lLBkdBHhXG4by40grNrRRlCL7063/UKHco4AUAz+V+Q00o59
 b7xKDQCdvxDJcL9O0ySjpmmelvwitCOGaLKMFAB3l71/YoAwRp1DJd28
X-Gm-Gg: AYBFou0ZDLFse3gzGPoqowLJjUjZ/+EqiiBelBnw1ti8gLb6qaV/s81xPiqTKJBCT67
 QT50RWvul6A1+NIMcxS7qCzrBGamPd8VEjIAGH9SKd1mSTdl7xi9I5XL29MKHzeYdjCsSaT8lRR
 MEZQbLjMhsl/5sxh7tZMi9qdyBPP755iHIUnwjpyVEfTnYgNkjmMbRpg7GEmRoJ7IH51xeUqh/l
 RiCLFyhk2wMcT/dbI8zIbQ5u8hAVqerSwOKruvw8N4rInSPVGSFdjuQrYMpJZmHYgDTRUlSHyd8
 kGob16pUuuWVESH9GyHovmbTRakwzicbl+zikwxGzeCZ/EYdB2WlwJypX8Y0Og5G9jHhcFWiUYE
 jnPVOAydiumj42seB/rn6a44403IrODm0UwZ2a+c8tEpih+tOpHnyS7f0f54AagBUwMnwE8pBhR
 gm5J3AY2hM4TU7/0hqvW1H3FBJ/uUt9Whs3XBA3KdlmmHcfcrsEl0QR69SJX7rRzHSuzSvr/m0n
 iVNKEcAQD6jzuM0yE9qIxxyHicfpcS+lzp8CeizfoNwEy6XpflFDNn52LJIFgw5YsYZ0M+NWY6+
 7I8sVAKOomWXh9J4iZ9bNqahE8VXKR2cZn+a/4qkzJ9WHiMaSjGb7PCycnmUUIgKG9pokiIo3D0
 eHP8GHsKWuhWzH7/4LPVFH5Ty0j7ohfbvMAv9NgiY8ea4H6Y9Wpc=
X-Received: by 2002:a05:600c:6215:b0:4aa:1527:659 with SMTP id
 5b1f17b1804b1-4ac17a366c0mr231375965e9.17.1793619700722; 
 Mon, 02 Nov 2026 03:41:40 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at.
 [80.108.121.211]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3f9sm21715781f8f.4.2026.11.02.03.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 03:41:40 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 02 Nov 2026 12:41:33 +0100
Subject: [PATCH] drm/etnaviv: Keep busy jobs alive in the hangcheck
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-etnaviv-compute-hangcheck-v1-1-1f81dd1806a2@igalia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MwQqDMBAFf0X23AWTQxR/pfSQri+6SKMkNgjiv
 5v2ODAzJ2UkRaahOSmhaNY1VjCPhmT2cQLrWJlsa50xrWXs0RctLOtn++7gnyQzZGF596NB54P
 rA9V+Swh6/N/P13Xd8WktyGsAAAA=
X-Change-ID: 20261102-etnaviv-compute-hangcheck-cb8d1e7af68f
To: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Christian Gmeiner <cgmeiner@igalia.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Gmeiner <cgmeiner@igalia.com>

A compute dispatch consists of a single FE command. The FE DMA address
does not change while the kernel is running, so the hangcheck kills any
dispatch that takes longer than about one second. Long-running OpenCL
kernels never finish.

Read VIVS_HI_IDLE_STATE at each timeout tick. If any unit other than FE
and MC is busy, the job is still executing, so give it more time.
If all units are idle for two consecutive ticks, the FE is waiting for
something that will never come, and the job is killed as before.

A job that stays busy without FE progress for longer than the new
hang_max_ms module parameter (default 30 seconds) is killed anyway.
This also catches kernels that loop forever. Setting it to 0 restores
the old behaviour.

Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h   |  3 +++
 drivers/gpu/drm/etnaviv/etnaviv_sched.c | 39 ++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
index e89d591d7404..f871ab7899fd 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
@@ -147,6 +147,9 @@ struct etnaviv_gpu {
 	u32 hangcheck_dma_addr;
 	u32 hangcheck_primid;
 	u32 hangcheck_fence;
+	bool hangcheck_idle;
+	bool hangcheck_busy;
+	unsigned long hangcheck_busy_since;
 
 	void __iomem *mmio;
 	int irq;
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_sched.c b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
index 3cc50d697c89..cef1ed33ff91 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_sched.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
@@ -17,6 +17,9 @@ static int etnaviv_job_hang_limit = 0;
 module_param_named(job_hang_limit, etnaviv_job_hang_limit, int , 0444);
 static int etnaviv_hw_jobs_limit = 4;
 module_param_named(hw_job_limit, etnaviv_hw_jobs_limit, int , 0444);
+static unsigned int etnaviv_hang_max_ms = 30000;
+module_param_named(hang_max_ms, etnaviv_hang_max_ms, uint, 0644);
+MODULE_PARM_DESC(hang_max_ms, "Time a busy job may run without front-end progress (ms, 0 = no extension)");
 
 static struct dma_fence *etnaviv_sched_run_job(struct drm_sched_job *sched_job)
 {
@@ -36,7 +39,8 @@ static enum drm_gpu_sched_stat etnaviv_sched_timedout_job(struct drm_sched_job
 {
 	struct etnaviv_gem_submit *submit = to_etnaviv_submit(sched_job);
 	struct etnaviv_gpu *gpu = submit->gpu;
-	u32 dma_addr, primid = 0;
+	u32 dma_addr, primid = 0, mask;
+	bool idle, was_idle;
 	int change;
 
 	/*
@@ -62,6 +66,12 @@ static enum drm_gpu_sched_stat etnaviv_sched_timedout_job(struct drm_sched_job
 		primid = gpu_read(gpu, VIVS_MC_PROFILE_FE_READ);
 		mutex_unlock(&gpu->lock);
 	}
+
+	mask = gpu->idle_mask & ~(VIVS_HI_IDLE_STATE_FE | VIVS_HI_IDLE_STATE_MC);
+	idle = (gpu_read(gpu, VIVS_HI_IDLE_STATE) & mask) == mask;
+	was_idle = gpu->hangcheck_idle;
+	gpu->hangcheck_idle = idle;
+
 	if (gpu->state == ETNA_GPU_STATE_RUNNING &&
 	    (gpu->completed_fence != gpu->hangcheck_fence ||
 	     change < 0 || change > 16 ||
@@ -70,9 +80,36 @@ static enum drm_gpu_sched_stat etnaviv_sched_timedout_job(struct drm_sched_job
 		gpu->hangcheck_dma_addr = dma_addr;
 		gpu->hangcheck_primid = primid;
 		gpu->hangcheck_fence = gpu->completed_fence;
+		gpu->hangcheck_busy = false;
 		return DRM_GPU_SCHED_STAT_NO_HANG;
 	}
 
+	/*
+	 * A compute dispatch is a single FE command, so the FE does not move
+	 * while a long kernel runs. Keep the job alive as long as some unit
+	 * other than FE and MC is busy, up to hang_max_ms. All of them idle at
+	 * two ticks in a row means the FE waits for something that never
+	 * comes.
+	 */
+	if (gpu->state == ETNA_GPU_STATE_RUNNING && !(idle && was_idle)) {
+		unsigned long max = msecs_to_jiffies(READ_ONCE(etnaviv_hang_max_ms));
+
+		if (!gpu->hangcheck_busy) {
+			gpu->hangcheck_busy = true;
+			gpu->hangcheck_busy_since = jiffies;
+		}
+
+		if (time_before(jiffies, gpu->hangcheck_busy_since + max))
+			return DRM_GPU_SCHED_STAT_NO_HANG;
+
+		if (max)
+			dev_err(gpu->dev, "job busy for more than %u ms without FE progress\n",
+				jiffies_to_msecs(max));
+	}
+
+	gpu->hangcheck_idle = false;
+	gpu->hangcheck_busy = false;
+
 	/* block scheduler */
 	drm_sched_stop(&gpu->sched, sched_job);
 

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-etnaviv-compute-hangcheck-cb8d1e7af68f

Best regards,
-- 
Christian Gmeiner <cgmeiner@igalia.com>

