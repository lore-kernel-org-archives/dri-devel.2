Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A9F606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 02:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OksRBn9D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0218A10E55F;
	Tue, 20 Oct 2026 02:05:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC43310E55F;
 Tue, 20 Oct 2026 02:05:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7CFA34022E;
 Tue, 20 Oct 2026 02:05:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792461911;
 b=qkdvq6YpjtiofSLYkYxUG21vjIwQmjIVId8rbfdBCJjE6tGfK7e6/CoI+o5cnyQ0Vg9H
 ireuQa6eQAt9JhMtQK0RpQArSSBG6o4347BQwrlKB019gX/vdIEQxIk04zhIUvUW3YRY/
 Xr6NmBwLM+nElWEzqZ0vnfGz2m0a3Zk5iP6r0f9+JWuiu2Bp4IROm6bwN7bh/xJ1A5JNU
 hol8FUIpiidOKmSNCo/j+4Zc8caQK1+5Yo49U03vjE8uMrxjJqWhRhlTPuLRE3NdmK5Hy
 AWVmGeT2i2T2TxPKIwL7M+Kata0bN0y3H55MPxl9Qag1QDMEs3OL1j2HvPGE92dRr+Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792461911;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=GRS5pgCL5y7zW5bY4sxN+JZSN1eN1o0+kQBbkgTn6Rk=;
 b=deFUpoJsMXcmlT0fDpn6Sz452NblcPRjIQlW3+CuhXXnsk+LIt0HjcU7btYVyuL5rvNW
 TIploQ06n5/UYOVNI3uY3s9wqbsPnx9aTMGyCVDvT06FMm5QeYnkmXBvIfYm9HWIy/pKD
 99pojUjU3omtRwfpyjk3ctatEWftXcR0En5Z23jkVfEok6nfkx2a5FytrUXwpzcodozwo
 iw7wcbombWGFg/PX7LgbuHx3xnOTOLcXVqzf6qPZwBhzsDXqBNoHMBEw6lWwDmeEYHktz
 2UJPXOaAFJSXiynFFNetGDB8PdU7ymkcqBWK92In32LBt4JoRY49wbpJA+/OAHupdoA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id B28AA1F000C5;
 Tue, 20 Oct 2026 02:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792461911;
 bh=GRS5pgCL5y7zW5bY4sxN+JZSN1eN1o0+kQBbkgTn6Rk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=OksRBn9DgYRHHqPodu0KVftQXOpssOz/VYKy26j61ttn+NraA4ZP7h5KGETfcL2Pa
 xBDR0hdobKGZXr9npqKOQpMAfrzWtqLTbWlAVQSuuP1VVMJfpXk1sY/A6LxxChUb1Y
 MbkWmGG+jJk+WsNiggVt6994zcWD6/SP7ZT9fypFWO06bHyS7k9IXwW5mB0uZmCujz
 y9BLPBV7TbFO+W1nwanqGARyBmGHkPbFs8bC3U71la67Cii0OlPq75rRxWVbF3PA5/
 CGe/cP9Y2MgyGLSRPxnXNzNVaCuGAQw3fcIs/sZT8bxBTYd8Pl6MYtVl6kvQhouTrT
 hEBJs96IuWtAg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 29A82406E1;
 Tue, 20 Oct 2026 02:05:10 +0000 (UTC)
From: Fabricio Akio via B4 Relay <devnull+fabricioakio.gmail.com@kernel.org>
Date: Mon, 19 Oct 2026 23:05:08 -0300
Subject: [PATCH v2 1/3] drm/msm/a5xx: Reset the GPU when resuming it
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261019-a5xx-gpu-pm-v2-1-457aafbb28da@gmail.com>
References: <20261019-a5xx-gpu-pm-v2-0-457aafbb28da@gmail.com>
In-Reply-To: <20261019-a5xx-gpu-pm-v2-0-457aafbb28da@gmail.com>
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
 Paul Sajna <sajattack@postmarketos.org>, 
 Fabricio Akio <fabricioakio@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792461909; l=4545;
 i=fabricioakio@gmail.com; s=20260928; h=from:subject:message-id;
 bh=idG9UEOCHDY9HHinuKj/MRVsQ1JSiZd+zxX4FQSwrt4=;
 b=lMwkiCpQtm+UPs3qByl0tnTg6eemFpXL8Tgk6y4MrPXyboTSxaIBWoZP+tRdRvKGE9m5B2yX/
 1c+k49zDDlJDBYhwJqT/3FuuJ5M+zRAsXxXABNMey7eLvYih9CwsFkZ
X-Developer-Key: i=fabricioakio@gmail.com; a=ed25519;
 pk=TlMUT8bPI/ZQzp2q24BIQTb2qSx/jdUTBlGEXIRCm54=
X-Endpoint-Received: by B4 Relay for fabricioakio@gmail.com/20260928 with
 auth_id=1076
X-Original-From: Fabricio Akio <fabricioakio@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: fabricioakio@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Fabricio Akio <fabricioakio@gmail.com>

On SDM630, SDM660 and MSM8998 the GPU's GX power domain belongs to its
SMMU, not to the GPU, so GX switches off only once the SMMU suspends as
well. A GPU resumed with GX still on keeps its state, and the CP keeps
its ringbuffer read pointer. a5xx_hw_init() then rewinds the ringbuffer
and writes CP_ME_INIT at its start, while the CP goes on from its old
position, executes stale ringbuffer contents and hangs:

  timeout waiting to drain ringbuffer 0 rptr/wptr = 23/C

Soft reset the GPU in a5xx_pm_resume() once it is powered, so that
every resume starts from the reset state. The downstream driver resets
only when it finds the GPU's power left on; resetting a GPU that was
powered off changes nothing, and on A508 the reset takes about 2 us of
a resume of about 1.5 ms, so do it every time.

The reset also clears the busy counter, which msm_gpu_pm_resume() has
just sampled as devfreq's baseline. Take the baseline again after the
reset, or the next devfreq poll subtracts the old count from the new
one, wraps, and sets the GPU to its top frequency.

Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
---
Changes in v2:
- Take devfreq's busy-cycle baseline again after the reset, which
  clears the busy counter (Sashiko)

Tested on A508 only; the reset runs on every A5xx.

A stall with the same signature, the CP's read pointer past the write
pointer just after CP_ME_INIT, was reported on an A509:
https://lore.kernel.org/linux-arm-msm/20260308-adreno-ringbuffer-drain-timeout-recovery-v1-1-985a33faf108@postmarketos.org/
This may be the root cause of the A509 stall Paul Sajna reported there.
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 15 +++++++++++++++
 drivers/gpu/drm/msm/msm_gpu.h         |  1 +
 drivers/gpu/drm/msm/msm_gpu_devfreq.c | 17 +++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 16c7335c4b1f..0aff8252a00f 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1367,6 +1367,21 @@ static int a5xx_pm_resume(struct msm_gpu *gpu)
 	if (ret)
 		return ret;
 
+	/*
+	 * The GX power domain is not necessarily switched off while we are
+	 * suspended: on SDM630, SDM660 and MSM8998 it follows the GPU's SMMU
+	 * rather than the GPU. If it stayed on, the CP still holds its old
+	 * ringbuffer read pointer and would execute stale ringbuffer contents
+	 * once hw_init restarts it. Soft reset the GPU so that it always
+	 * resumes from its reset state.
+	 */
+	gpu_write(gpu, REG_A5XX_RBBM_SW_RESET_CMD, 1);
+	gpu_read(gpu, REG_A5XX_RBBM_SW_RESET_CMD);
+	gpu_write(gpu, REG_A5XX_RBBM_SW_RESET_CMD, 0);
+
+	/* The reset cleared the busy counter devfreq has just sampled */
+	msm_devfreq_resample_busy(gpu);
+
 	/* Adreno 505, 506, 508, 509, 510, 512 needs manual RBBM sus/res control */
 	if (!(adreno_is_a530(adreno_gpu) || adreno_is_a540(adreno_gpu))) {
 		/* Halt the sp_input_clk at HM level */
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index d27d54bdb7a7..0e0768c15bcc 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -735,6 +735,7 @@ static inline struct msm_context *msm_context_get(
 void msm_devfreq_init(struct msm_gpu *gpu);
 void msm_devfreq_cleanup(struct msm_gpu *gpu);
 void msm_devfreq_resume(struct msm_gpu *gpu);
+void msm_devfreq_resample_busy(struct msm_gpu *gpu);
 void msm_devfreq_suspend(struct msm_gpu *gpu);
 void msm_devfreq_boost(struct msm_gpu *gpu, unsigned factor);
 void msm_devfreq_active(struct msm_gpu *gpu);
diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
index 2e1d5c343272..2e963bff3f61 100644
--- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
+++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
@@ -242,6 +242,23 @@ void msm_devfreq_resume(struct msm_gpu *gpu)
 	devfreq_resume_device(df->devfreq);
 }
 
+/*
+ * Take a new busy cycles baseline, for a GPU that resets its busy counter
+ * after msm_devfreq_resume() has sampled it.
+ */
+void msm_devfreq_resample_busy(struct msm_gpu *gpu)
+{
+	struct msm_gpu_devfreq *df = &gpu->devfreq;
+	unsigned long sample_rate;
+
+	if (!has_devfreq(gpu))
+		return;
+
+	mutex_lock(&df->lock);
+	df->busy_cycles = gpu->funcs->gpu_busy(gpu, &sample_rate);
+	mutex_unlock(&df->lock);
+}
+
 void msm_devfreq_suspend(struct msm_gpu *gpu)
 {
 	struct msm_gpu_devfreq *df = &gpu->devfreq;

-- 
2.56.0


