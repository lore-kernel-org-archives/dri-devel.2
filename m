Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC1C606A331
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XPvPuU8M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB2A10E6B1;
	Sat,  7 Nov 2026 20:26:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 268F410E5EB;
 Sat,  7 Nov 2026 20:26:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EE791611B9;
 Sat,  7 Nov 2026 20:26:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794083171;
 b=UkB72y68VR1hApCx+DhsuPmokH4c8DUWmqG0N//E016QZVnPbv3OR5F/RFDf38IQgWbr
 5ZDR9oJRbdkddBQRBREjrOxEhp6VGo/tu0dTL3GFpsB1fUCjvHgBQ8E6g/6PEuH4QLSIw
 reb72HSYaYUF+0ffF/UlQIrefm5Jh2eKoUtupIuk6JgyL6nh3nt4r6eFCv8zp7kd2qLxJ
 o8T0o4dh6Qd/9Rg9lYkmntinSoQKlEgO/NWtHFsELdWyxtFyj/jdiixc8mKUs5yZUybGH
 pfBaMnPyJKy8aetIYcxdoRRCwSo1MRwMB1vuYeGfExYAgCnzzi+pqlIoABtoR5KW72A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794083171;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=mDePkqFwOIRt6vrMmH95TRvT3OacLhO08wSp0V/X8Gc=;
 b=Svc5Gi0KFExtoW9KFPU35hSNZukj4ZmB4ryjDeHs5YWUT5gwZas+Eqw+jsoeyGlHnMf4
 xHnkwAXKSMUNmo0q/yLecCWhviusJxg3hLhLOWZWofl/7hyrKBl8hkRUfUKUjdZiW1kau
 2JUNuxs0BbY/ztn4BzabroGkg35RKzHK59GNfVkMEMWLuBtY79MXvyfqxQ+kG6/cGrSs+
 BpKHPkDu8bGyCorA7XVNXIFO31O7VlyZna16U/EHL7HR2nFF4wtmWIWSlaN9vWRsLc7e2
 p3Ru73EHGiUSAwkY8m1XlDtPagENWG0eSQr2mECoEIOA0cws0RvhmIvlfVyFXm5MLkA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 0D5A91F008A2;
 Sat,  7 Nov 2026 20:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794083171;
 bh=mDePkqFwOIRt6vrMmH95TRvT3OacLhO08wSp0V/X8Gc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=XPvPuU8MRuBsZ7ZHo1UUNc1Joz1jCv6dFi4Ri5AaPYzxFkyGEabOIbhnl3GIkpAtF
 pm6OiPy5bWM/YYIVZOUowNnYYh2oiFAiHDSjeVSQ3CU1By23wq7bxClMMQ9zA+Twx0
 UG4WFdby5PzTfy/LBEAngfd56Z71/FO2EIy/Cff8+08GXjXNQl3dj6HmjTo3AYpP0v
 D+h2XQsCcpXNijw6p4EhTfk5I4+5c09TkbXIUJtR23mSGJGvBqUpPzFnMZNTTZ6reL
 81ndas4O2SyuNxIVsBFnXYUM3wBKdC7sjg0V+JJNaI+3UnfIk62m+EYVB/qSLqgnlr
 gCGNe2lPZZ7jg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 7574347CF3;
 Sat,  7 Nov 2026 20:26:10 +0000 (UTC)
From: Fabricio Akio via B4 Relay <devnull+fabricioakio.gmail.com@kernel.org>
Date: Sat, 07 Nov 2026 17:26:07 -0300
Subject: [PATCH v3 1/4] drm/msm: Resume devfreq from each GPU's resume callback
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261107-a5xx-gpu-pm-v3-1-e2480408abea@gmail.com>
References: <20261107-a5xx-gpu-pm-v3-0-e2480408abea@gmail.com>
In-Reply-To: <20261107-a5xx-gpu-pm-v3-0-e2480408abea@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794083169; l=3502;
 i=fabricioakio@gmail.com; s=20260928; h=from:subject:message-id;
 bh=WKx98tYEeskV/kIUiXfz3iSMFdKKmrq0cO+ilFuFsnE=;
 b=UD+hnPGkt24XPuPzx9SUtXtuTqDNI0/yrMudI7K1Cx/+2gSDCNxoj9bXknwMRUheOSU5sQnnE
 TTigYJlo942BNKsjkIX36R1eZABb808jP7i0jzUYtR8PcqNGzp/Oze1
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Fabricio Akio <fabricioakio@gmail.com>

msm_gpu_pm_resume() resumes devfreq, which samples the GPU's busy
counter as the baseline of its next poll. A resume callback that resets
the GPU after msm_gpu_pm_resume() clears that counter, and the next
poll then subtracts the old count from the new one and wraps.

Move the call out of msm_gpu_pm_resume() into the resume callbacks that
use it, as A6xx already does, so that each GPU can resume devfreq once
its hardware is ready. The A3xx, A4xx and A5xx callbacks call it right
after msm_gpu_pm_resume(), where it ran before, so nothing changes yet.
A2xx has no gpu_busy callback, so it has no devfreq.

Suggested-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
---
New in v3.

Tested on A508 only; the A3xx and A4xx callbacks call it where
msm_gpu_pm_resume() did.
---
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c | 15 ++++++++++++++-
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c |  2 ++
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c |  2 ++
 drivers/gpu/drm/msm/msm_gpu.c         |  2 --
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
index 160d302e16a3..a3aa4ae1fdb0 100644
--- a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
@@ -534,6 +534,19 @@ static int a3xx_pm_suspend(struct msm_gpu *gpu)
 	return msm_gpu_pm_suspend(gpu);
 }
 
+static int a3xx_pm_resume(struct msm_gpu *gpu)
+{
+	int ret;
+
+	ret = msm_gpu_pm_resume(gpu);
+	if (ret)
+		return ret;
+
+	msm_devfreq_resume(gpu);
+
+	return 0;
+}
+
 static u32 a3xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 {
 	ring->memptrs->rptr = gpu_read(gpu, REG_AXXX_CP_RB_RPTR);
@@ -637,7 +650,7 @@ const struct adreno_gpu_funcs a3xx_gpu_funcs = {
 		.set_param = adreno_set_param,
 		.hw_init = a3xx_hw_init,
 		.pm_suspend = a3xx_pm_suspend,
-		.pm_resume = msm_gpu_pm_resume,
+		.pm_resume = a3xx_pm_resume,
 		.recover = a3xx_recover,
 		.submit = a3xx_submit,
 		.active_ring = adreno_active_ring,
diff --git a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
index 6392126f48f2..289204d53311 100644
--- a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
@@ -577,6 +577,8 @@ static int a4xx_pm_resume(struct msm_gpu *gpu) {
 	if (ret)
 		return ret;
 
+	msm_devfreq_resume(gpu);
+
 	if (adreno_is_a430(adreno_gpu)) {
 		unsigned int reg;
 		/* Set the default register values; set SW_COLLAPSE to 0 */
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 16c7335c4b1f..c81f67c639c8 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1367,6 +1367,8 @@ static int a5xx_pm_resume(struct msm_gpu *gpu)
 	if (ret)
 		return ret;
 
+	msm_devfreq_resume(gpu);
+
 	/* Adreno 505, 506, 508, 509, 510, 512 needs manual RBBM sus/res control */
 	if (!(adreno_is_a530(adreno_gpu) || adreno_is_a540(adreno_gpu))) {
 		/* Halt the sp_input_clk at HM level */
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 0c2c35636251..d33612fb3e53 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -116,8 +116,6 @@ int msm_gpu_pm_resume(struct msm_gpu *gpu)
 	if (ret)
 		return ret;
 
-	msm_devfreq_resume(gpu);
-
 	gpu->needs_hw_init = true;
 
 	return 0;

-- 
2.56.0


