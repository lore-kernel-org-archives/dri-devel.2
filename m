Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7EA606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0JY1rZ34
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F4EA10EBD0;
	Mon,  2 Nov 2026 08:04:05 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 642A810E3B9
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 18:00:41 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3ab41538192so1908010a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 10:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793556041; x=1794160841; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=90aqdG+SrfJSGek/huInxfvZ4wZJxbtx8iY/wQCJzXI=;
 b=0JY1rZ34441MHD9Za630KuhPJgq0EvWCviIyr0ngrAc0duKzGdn6FfJvWtMesHc6Sd
 SjqJHBAct0UMbHrLr0FxepE3AAaZwJBUs6pgdg7mJOI4oQy5J5xt8ZqthjjiThNJ84xW
 75ncjtQAaTLoeB0Ex9TIEWtBEg4exClrp4jY+ecxea1Vmj52xwGYwWxNWvGNDZvdnEkb
 ir+dOMPZgXoB0JMcDstT414B+A0YODvXivketmsXZPUfH9GPb8Phi0a/dun+5qYB1p3c
 7jD7thoBAqdX9FlV8ruuAJkFzjmCT8I8iAIH7TLxyl+nyDbFALr+HuHlpHYL2daSmjJW
 6TBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793556041; x=1794160841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=90aqdG+SrfJSGek/huInxfvZ4wZJxbtx8iY/wQCJzXI=;
 b=GGHKmCb+07gAnCFa4EBZ9TICjd3gc40EBB59xBEIQDK1iRbG1gM6wGwb4t2qkfxHbJ
 3+Vmn5wbITnVo8d3W7qhqGe+MDAyuaVvGM6NLnWBotTUU7x7j4cD3YEDaLGP4sYU7XTn
 pOYwE65GgTMGz4vi0EXpCDhDcTOT5WX155MhtHVviHbFtlvDkT/SjpbLhF5iZu2LSwT9
 KzMK3bjM+jAKPY6Glpu+LB9Gxl7qKWAWyyVQ7gbEdTxzRmCBBqsPVBrNow7IHUH97ucY
 ejn34joGx+qEzmFjnwg31BvTJ38H6rkUC+0TRE44ZoCJZSD9tYYtOijMnmGMEQ6wf+dK
 mckw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6+APHIZBnZ3jPVCBDnRO4aZGLCXss5kVJ91mZcvN7O3+aIhrPVQe54RA9R4fE8YevtDjpxI+sjzY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+C/djP16ZVkO7SU/fMYq8MoX8N7nASrJqlW4SYjOsE6A24/7Zc
 HxGPRIcRnal6kHPRox3WOFZk2II/GTSUlltW1j+TJA8eAQiNdE7AL9Oz
X-Gm-Gg: AYBFou1qctJCTkd8KOHQurvi4UF+QX94klevg7rKtwxaUOrKSLgdXkyF/UjKQKnBdUX
 w8bB+rQZ2D9mj8rzHo+B4LoYuJBCdNllpJc08c9iqwWv77NJyng9KvOeV5D2w/iFll9bGrcSc5X
 5Rx/2nK+v2bPAGtegDquABSZgtnkU0rIuHx8/9KeiHBki0UAldPfuj1lysKV3JiGEuJkZ4pIazy
 ZdcZL8YURWgIHweRCFRVkxtCiX2m3vRuuk0WMs4JvUSGu2UoCvz9dOwjncJfCfEA08C0i/SQmNe
 o2SVmTtafVVBHLM+WUDwaIxRBMPppdzzaHPt48j/XCezfMqPHdaF3sLMuWL361LbcqCxEk7HEum
 uagp0lh+3t8umRJtKii3AfsyWNntuqOb3Zq56L496qYC6yNuIVBz7E68XTUzKc4QI/75nMRRZ46
 2NH5TYZdGLSQjQmKzJ1NPSDz4W5qtzQnmNMt33+MDIbQxN9do0Z7xJR9b9MsW9lVZ0wEILwEoxU
 EIFpkfqAUVMQ5bA1v+UjpfeVqBDmT3FZrzl408yTqmp5qwG57lAo4/v2ROvpm2hyrPbih6DvnMB
 nZ8CMb6yqfALiDn/qZq7zQ==
X-Received: by 2002:a17:90b:4f87:b0:3ae:5572:c4e2 with SMTP id
 98e67ed59e1d1-3ae897e5685mr6397230a91.57.1793556040776; 
 Sun, 01 Nov 2026 10:00:40 -0800 (PST)
Received: from tabby-boi ([2a09:bac5:4fad:e6::17:370])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e949077sm15194159a91.9.2026.11.01.10.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 10:00:39 -0800 (PST)
From: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH 1/4] drm/msm: don't wait for a fault devcoredump during GPU
 recovery
Date: Mon,  2 Nov 2026 01:55:50 +0800
Message-ID: <20261101175553.53746-2-nicoangelodelacruz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101175553.53746-1-nicoangelodelacruz@gmail.com>
References: <20261101175553.53746-1-nicoangelodelacruz@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:03:58 +0000
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

adreno_fault_handler() calls reinit_completion() on
fault_coredump_done and then blocks in
msm_gpu_fault_crashstate_capture() on mutex_lock(&gpu->lock) to take
the devcoredump.

If recover_worker() is already running, it holds gpu->lock and, from
the runtime suspend in a6xx_recover() or a8xx_recover(), may time out
in a6xx_hfi_wait_for_msg_interrupt() or a6xx_gmu_set_oob(). Both loops
then fall into an unbounded wait_for_completion() on
fault_coredump_done, which has just been reinitialized and which only
the fault handler can complete. The fault handler is waiting for
gpu->lock, which recovery will not release until the wait returns, so
neither side makes progress.

A fault dump that needs gpu->lock can never complete while recovery
holds it, so waiting for it is wrong. Add a recovery_in_progress flag
to struct msm_gpu, set by recover_worker() under gpu->lock, and check
it in two places:

 - the fault handler doesn't start a devcoredump capture while
   recovery is running, so a fault that arrives during recovery no
   longer reinitializes the completion;

 - both GMU wait loops stop waiting for the completion while recovery
   is running and fall through to their normal timeout handling. This
   covers a fault handler that had already reinitialized the
   completion when recovery took gpu->lock.

GMU waiters that don't hold gpu->lock, such as the devfreq frequency
change path, also skip the completion wait while recovery is running
and report their timeout right away; recovery is resetting the GMU
at that point anyway.

On a OnePlus Pad 3 (Adreno 830), recoveries that saw a CP page fault
within 2 s of "hangcheck recover!" were stuck 3 of 3 times, while
12 of 12 recoveries without such a fault completed. With this patch,
three natural recoveries that took a CP page fault during recovery
all completed.

Fixes: 50a0b122cfc8 ("drm/msm: Wait for MMU devcoredump when waiting for GMU")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/CACu1E7EApr6Ne3XxFv4cUa2JuwNW2kfo1c5wSsAUN78iWyQ2sg@mail.gmail.com/
Signed-off-by: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 7 +++++--
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c   | 7 +++++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 3 ++-
 drivers/gpu/drm/msm/msm_gpu.c           | 2 ++
 drivers/gpu/drm/msm/msm_gpu.h           | 9 +++++++++
 5 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 662f09bec..32ed49abe 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -445,12 +445,15 @@ int a6xx_gmu_set_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state)
 		if (!ret)
 			break;
 
-		if (completion_done(&a6xx_gpu->base.fault_coredump_done))
+		if (completion_done(&a6xx_gpu->base.fault_coredump_done) ||
+		    READ_ONCE(a6xx_gpu->base.base.recovery_in_progress))
 			break;
 
 		/* We may timeout because the GMU is temporarily wedged from
 		 * pending faults from the GPU and we are taking a devcoredump.
-		 * Wait until the MMU is resumed and try again.
+		 * Wait until the MMU is resumed and try again. A fault dump
+		 * cannot complete while recovery holds gpu->lock, so don't
+		 * wait for one then.
 		 */
 		wait_for_completion(&a6xx_gpu->base.fault_coredump_done);
 	} while (true);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index 6b34e704a..fe4e35728 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -122,12 +122,15 @@ static int a6xx_hfi_wait_for_msg_interrupt(struct a6xx_gmu *gmu, u32 id, u32 seq
 		if (!ret)
 			break;
 
-		if (completion_done(&a6xx_gpu->base.fault_coredump_done))
+		if (completion_done(&a6xx_gpu->base.fault_coredump_done) ||
+		    READ_ONCE(a6xx_gpu->base.base.recovery_in_progress))
 			break;
 
 		/* We may timeout because the GMU is temporarily wedged from
 		 * pending faults from the GPU and we are taking a devcoredump.
-		 * Wait until the MMU is resumed and try again.
+		 * Wait until the MMU is resumed and try again. A fault dump
+		 * cannot complete while recovery holds gpu->lock, so don't
+		 * wait for one then.
 		 */
 		wait_for_completion(&a6xx_gpu->base.fault_coredump_done);
 	} while (true);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index dadfe4c69..138bebf5e 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -289,7 +289,8 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsigned long iova, int flags,
 	struct msm_mmu *mmu = to_msm_vm(gpu->vm)->mmu;
 	const char *type = "UNKNOWN";
 	bool do_devcoredump = info && (info->fsr & ARM_SMMU_FSR_SS) &&
-		!READ_ONCE(gpu->crashstate);
+		!READ_ONCE(gpu->crashstate) &&
+		!READ_ONCE(gpu->recovery_in_progress);
 	unsigned long irq_flags;
 
 	/*
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 0c2c35636..caa86279f 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -474,6 +474,7 @@ static void recover_worker(struct kthread_work *work)
 	int i;
 
 	mutex_lock(&gpu->lock);
+	WRITE_ONCE(gpu->recovery_in_progress, true);
 
 	DRM_DEV_ERROR(dev->dev, "%s: hangcheck recover!\n", gpu->name);
 
@@ -585,6 +586,7 @@ static void recover_worker(struct kthread_work *work)
 	pm_runtime_put(&gpu->pdev->dev);
 
 out_unlock:
+	WRITE_ONCE(gpu->recovery_in_progress, false);
 	mutex_unlock(&gpu->lock);
 
 	msm_gpu_retire(gpu);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index d27d54bdb..5cf220f75 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -258,6 +258,15 @@ struct msm_gpu {
 
 	struct msm_gpu_state *crashstate;
 
+	/**
+	 * @recovery_in_progress: true while recover_worker() holds @lock, so
+	 * that fault capture and GMU waits don't wait on a fault devcoredump
+	 * that can't complete while recovery holds @lock.  Written with
+	 * WRITE_ONCE() under @lock; readers (the fault handler, GMU wait
+	 * loops) don't hold @lock and use READ_ONCE().
+	 */
+	bool recovery_in_progress;
+
 	/* True if the hardware supports expanded apriv (a650 and newer) */
 	bool hw_apriv;
 
-- 
2.53.0

