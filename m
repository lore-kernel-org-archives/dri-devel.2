Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EF3606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V5qpUFHP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9395F10EBC6;
	Mon,  2 Nov 2026 08:04:03 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95C8F10E3B9
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 18:00:53 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-3ae691283ecso1058515a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 10:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793556053; x=1794160853; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I/g7B1/2uK+SOUUXwB/iWNiLNLGu8eYWyxjyco9QARM=;
 b=V5qpUFHPNlJEIRuY8Vm1fN+RmhPwEy7CpbTXGNZhwMoaycE1cITAF1iG5gpe57CItS
 k/pvwSvxJHNfH8xD1ekKthXw2rcBG8Kt4XJrqs9aCcvY9vumugvLmY+UIIoYapOJdWYI
 kR0oXMJ1gslecuf6TL8CGsyrlqcs3O/ZWgqGve0x8xkOz8t+vrX1frpBNYQGHao/LlII
 n9dlmeh4eYdrzIHmdxrQhtdA/bteTLYyBXTBW5Zxt3DekYA8shMCWFBzKi9UWtE1yfxC
 0MwZTg7/ItFUseGak74LcsXa+yMYCqfquJsCdczQsylVAPxWCvAsZJO9Q1BOCVjWW5/1
 x1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793556053; x=1794160853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I/g7B1/2uK+SOUUXwB/iWNiLNLGu8eYWyxjyco9QARM=;
 b=UmNZyo/JdBZpmVVu46XsRBGkvOYwf5/yfTyIoc9elVpbpRdJvD/kGbKCTqIQ/Kq1Ju
 kIYUFKxSdbLnxd6qehrkOMKSQsXJcG1qRmBmdGH8goJEDm9qOdP9Kq0naa/lHNcOgiVj
 Q9Z2WcUnzZGdIvquqqfQ/luGm3ucmBHGB7OSHGZ/PBDeFmsDoLhZiEX/XHlzwE+HDyA4
 TyX3r1586sSn0wrjUy54CcNKV1zPhZgDpzx8z9QKgm1oKIeCw3ODLST1JwVRFi/Sy7Xs
 w7B4HlAOzIdJZG8wU1LyEwAuTsbfTzwQG8X+WcWF0rHwPvv2P+JYY2bYI1YncvrXUCDl
 gfYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxuJipOhxRDT/WZ5dYhRjkTGoZNVv14N06Llg2XqTFaGFFMll68yDtT6oqy/wJ45/TCpiFB/zg/vdE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+PvXeNZrGoY1RynW/8t5yOjt2gsZGLSXq6YtO/D8J7k4GQM1Bq
 18Kioka+IX7k3KyZfKl4KJOSMTkoQo1lTaoGIBBrTdIqAf/78XRkz3Xq
X-Gm-Gg: AYBFou2GtAI+Ehd/KvFkfQ3CFCqJVVBePN69uSB/OcX785b6+fA4zQhBP8KHg6L5eCt
 xHXPzNxNr18JLj7PAj4XH+yRhoP4rqs/WNPA3LM6TC1lkS+rpooY9cku4ertRKGPAnsVw4TFM3A
 UQaxPdGy6lbj78uI7nZ+xpo9TI1ImVAaUIpCbFLRMNCXJa7gOPbsvttVODN8d8zYhNRAVIDrG45
 Q2+A/tZZdnRgOJ7xKkYtNprSbfbzKFq2xM9I1JQ6wRbaf6ckb76a5kaxtyp+hmVKhaBbdEXOxMl
 oqs5iX6JI1B/B30lIucllp4Ynrd2l/STWp1v4eiUGn9/DPG+UBowK8ehShY3uLqtSAXX1EdqIr+
 OC4Wvx+qIi9jPMgZOKWCDzdtxTJZjJZ7/NZ/piQ8IEYa/REmAwVk7y3hfRbPPzasXG1JXb12sJu
 qvRs3Oj0lMVF/6edteAg63NzrMM0wCu06QkQk/QqY5y4ZvRhSEmbRjrxWNrWZt/i+d0Zc7f/u/d
 PkUgTQ2Xuf2hZ0Pr2qeQ4l24MfpUzXxtoxhBbl7vmoEqXPCpgKo3PgPF7nxfZnX5E6VUethkU4a
 k8uQJv0dP8RHVO82ADip1Q==
X-Received: by 2002:a17:90b:1b0d:b0:3ac:36c7:c144 with SMTP id
 98e67ed59e1d1-3ae89776936mr4446077a91.28.1793556052975; 
 Sun, 01 Nov 2026 10:00:52 -0800 (PST)
Received: from tabby-boi ([2a09:bac5:4fad:e6::17:370])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e949077sm15194159a91.9.2026.11.01.10.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 10:00:52 -0800 (PST)
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
Subject: [PATCH 2/4] drm/msm: free the crash state asynchronously
Date: Mon,  2 Nov 2026 01:55:51 +0800
Message-ID: <20261101175553.53746-3-nicoangelodelacruz@gmail.com>
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

msm_gpu_crashstate_capture() sets gpu->crashstate and calls
dev_coredumpm() while the caller (recover_worker() or
msm_gpu_fault_crashstate_capture()) holds gpu->lock. When devcoredump
is disabled (/sys/class/devcoredump/disabled, a write-once knob) or
its allocation fails, dev_coredumpm_timeout() calls the free callback
synchronously.

msm_gpu_devcoredump_free() then calls msm_gpu_crashstate_put(), which
does mutex_lock(&gpu->lock) and so recursively takes a mutex the
caller already holds. On systems with devcoredump disabled, every GPU
recovery that captures a crash state deadlocks.

Defer the put to a work item on system_dfl_wq instead. This is safe
because msm_gpu_devcoredump_read() takes and drops its own crash
state reference, and the work takes gpu->lock normally once the
holder has released it. gpu->crashstate stays set until the work
runs, which only means a capture in that window is skipped.
msm_gpu_cleanup() flushes an already queued free before teardown.

Tested on an Adreno 830 with /sys/class/devcoredump/disabled set to 1:
IGT msm_recovery gpu-fault recovers and the GPU resumes.

Fixes: c0fec7f562ec ("drm/msm/gpu: Capture the GPU state on a GPU hang")
Cc: stable@vger.kernel.org
Signed-off-by: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
---
 drivers/gpu/drm/msm/msm_gpu.c | 21 ++++++++++++++++++++-
 drivers/gpu/drm/msm/msm_gpu.h |  6 ++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index caa86279f..fded78fdb 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -175,6 +175,14 @@ int msm_gpu_hw_init(struct msm_gpu *gpu)
 	return ret;
 }
 
+static void msm_gpu_crashstate_free_worker(struct work_struct *work)
+{
+	struct msm_gpu *gpu = container_of(work, struct msm_gpu,
+					   crashstate_free_work);
+
+	msm_gpu_crashstate_put(gpu);
+}
+
 #ifdef CONFIG_DEV_COREDUMP
 static ssize_t msm_gpu_devcoredump_read(char *buffer, loff_t offset,
 		size_t count, void *data, size_t datalen)
@@ -215,7 +223,13 @@ static void msm_gpu_devcoredump_free(void *data)
 {
 	struct msm_gpu *gpu = data;
 
-	msm_gpu_crashstate_put(gpu);
+	/*
+	 * dev_coredumpm() calls this synchronously when it can't keep the
+	 * dump (devcoredump disabled, or out of memory), while
+	 * msm_gpu_crashstate_capture() holds gpu->lock, which
+	 * msm_gpu_crashstate_put() also takes.  Defer the put to a worker.
+	 */
+	queue_work(system_dfl_wq, &gpu->crashstate_free_work);
 }
 
 static void msm_gpu_crashstate_get_bo(struct msm_gpu_state *state,
@@ -899,6 +913,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	gpu->dev = drm;
 	gpu->funcs = funcs;
 	gpu->name = name;
+	INIT_WORK(&gpu->crashstate_free_work, msm_gpu_crashstate_free_worker);
 
 	gpu->worker = kthread_run_worker(0, "gpu-worker");
 	if (IS_ERR(gpu->worker)) {
@@ -1047,6 +1062,10 @@ void msm_gpu_cleanup(struct msm_gpu *gpu)
 
 	DBG("%s", gpu->name);
 
+	/* May be unset if probe failed before msm_gpu_init() */
+	if (gpu->crashstate_free_work.func)
+		flush_work(&gpu->crashstate_free_work);
+
 	for (i = 0; i < ARRAY_SIZE(gpu->rb); i++) {
 		msm_ringbuffer_destroy(gpu->rb[i]);
 		gpu->rb[i] = NULL;
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 5cf220f75..db9e11e7f 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -258,6 +258,12 @@ struct msm_gpu {
 
 	struct msm_gpu_state *crashstate;
 
+	/**
+	 * @crashstate_free_work: drops the devcoredump's crashstate reference
+	 * outside of @lock, see msm_gpu_devcoredump_free().
+	 */
+	struct work_struct crashstate_free_work;
+
 	/**
 	 * @recovery_in_progress: true while recover_worker() holds @lock, so
 	 * that fault capture and GMU waits don't wait on a fault devcoredump
-- 
2.53.0

