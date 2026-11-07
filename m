Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F0A606A32F
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lTxdkSCc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E48710E6D0;
	Sat,  7 Nov 2026 20:26:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97EE910E0CB;
 Sat,  7 Nov 2026 20:26:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 451AB42449;
 Sat,  7 Nov 2026 20:26:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794083172;
 b=SCYof7XAEhPfAb87lKhzk00t+XlWt8GUqLRuCDiKSOl4IMMqHSCMUN9MYVGu2ulLSXB1
 dgFSwdy3IXgjDtsQbX3gyfc0O6YHwlMsuWqRL+KIftKXI9fWutlBdHShDlEOdHWHVJGjB
 w126YTvO17FyEeaa6DXmCVe7bOo7v71/c/THwgrige9BlPgjdzlOXMX7LtaOtxfFs/r6V
 +wdEERg//+cpr9Ys4BwodC3PytVBQv2Zcur0z1yksPc5CYR0byv583KB7YuBZRAZ4sO5r
 qO1mmxil9q3FzqpFM6lTDpfC+xsiKWWGZak8d89Ny/o8buldLW3ihBiNBc16Df0+yyQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794083172;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=e3d75uKi/3kvcv2MEIqtUxR6V1ebLArnKx3P4aRw3vU=;
 b=dDzZFRU+sQIFtfTBLBYbXILAmuh1FV7zzSr/uJqggmbhtSy8Mol4E8OiAU1Q0dLxwqdt
 rrkmo+ou9Y4D8JuHZn2/SRfnZODlFMcyn95QyvZJwgHIHTzGapHarWLTzEo/Qp+XIZ3pA
 q0rzVYHPr15sxOjI4foft2UlQhA1d8B0foAdRoBkGFqJlppjTYSBMeCmVvO3i2A6uT2aG
 LcHCV9X0P9vntA6VSauEiS67eBbzC4yTBXdSIiw3HT7Z8Amjbgsc8t1fsgWsQkfqalBjw
 wZwR+YKvRmePueO+f86fqKDFOB17VtgVbYPrfGLwtiPXbCMD50qqIlhCKptjojdXLOQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 0D4E41F0089F;
 Sat,  7 Nov 2026 20:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794083172;
 bh=e3d75uKi/3kvcv2MEIqtUxR6V1ebLArnKx3P4aRw3vU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=lTxdkSCcmIdCVgFbXnGSbkOjddF/gUv0SFmJ2KMiesh6iFssOn0gcox9wRNtIjLt1
 /mUlAiG3GAXHGLouh3I1HI7zUAOErM/XGA0G8RHIKPPYHmBo2Y6axnKT5q097nLR6P
 VcYhiUDHY90/wt+FdgwvPF2iZ7wOFHiOfnthRAqedPmyWqjv4k1Ph5s9kQFjVpiShJ
 +zWN3pbAGJM/7rJLl676n6UKGsrYhqpB/Twuiymh/KcF6SE6tQaVmqXH5rnhNi5b8H
 aaPU7OYoucrCw1eHdqlXWQOX5gHYSC0EhsdI4zzZF4NVRtlxcOXgJquhxHmAoLyfAI
 K6s9jYgx33jjw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 8567447CFB;
 Sat,  7 Nov 2026 20:26:10 +0000 (UTC)
From: Fabricio Akio via B4 Relay <devnull+fabricioakio.gmail.com@kernel.org>
Date: Sat, 07 Nov 2026 17:26:08 -0300
Subject: [PATCH v3 2/4] drm/msm/a5xx: Reset the GPU when resuming it
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261107-a5xx-gpu-pm-v3-2-e2480408abea@gmail.com>
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
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Fabricio Akio <fabricioakio@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794083169; l=3443;
 i=fabricioakio@gmail.com; s=20260928; h=from:subject:message-id;
 bh=swuB5qHfUrNVomwySv4f22B0nyHsJGRFcNLJX68gYv0=;
 b=XX5HFn28yfKDmvaz2ANFIekhZVEN3ZUH3GamTeBzF5FnVQiNCJq+DoxFv54PGVP/GwWgjFZCB
 u2ceCRfNmvhAk3uYL0E6m5kfPeHlk3+1dQHiGSg0bGnNC0jbkiJvD6a
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Fabricio Akio <fabricioakio@gmail.com>

On SDM630, SDM660 and MSM8998 the device tree attaches the GPU's GX
power domain to its SMMU, whose own domain is CX, so GX switches off
only once the SMMU suspends as well. A GPU resumed with GX still on
keeps its state, and the CP keeps its ringbuffer read pointer.
a5xx_hw_init() then rewinds the ringbuffer and writes CP_ME_INIT at its
start, while the CP goes on from its old position, executes stale
ringbuffer contents and hangs:

  timeout waiting to drain ringbuffer 0 rptr/wptr = 23/C

Soft reset the GPU in a5xx_pm_resume() once it is powered, so that
every resume starts from the reset state. The downstream driver resets
only when it finds the GPU's power left on; resetting a GPU that was
powered off changes nothing, and on A508 the reset takes about 2 us of
a resume of about 1.5 ms, so do it every time.

The reset also clears the busy counter devfreq samples as the baseline
of its next poll, so resume devfreq after it.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
---
Changes in v3:
- Say that the device tree attaches GX to the SMMU, whose own domain
  is CX (Konrad, Akhil)
- Resume devfreq after the reset instead of taking its baseline again,
  on the previous patch (Akhil)
- Dropped Dmitry's Tested-by: devfreq now resumes after the reset
  instead of resampling the busy counter

Changes in v2:
- Take devfreq's busy-cycle baseline again after the reset, which
  clears the busy counter (Sashiko)

Downstream resets when it finds a GPU regulator left on, and resumes
its frequency scaling only after that:
https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/drivers/gpu/msm/adreno.c#L1336-L1351
https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/drivers/gpu/msm/kgsl_pwrctrl.c#L2596-L2606

A stall with the same signature, the CP's read pointer past the write
pointer just after CP_ME_INIT, was reported on an A509:
https://lore.kernel.org/linux-arm-msm/20260308-adreno-ringbuffer-drain-timeout-recovery-v1-1-985a33faf108@postmarketos.org/

Tested on A508 only; the reset runs on every A5xx.
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index c81f67c639c8..5b5429033986 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1367,6 +1367,19 @@ static int a5xx_pm_resume(struct msm_gpu *gpu)
 	if (ret)
 		return ret;
 
+	/*
+	 * The GX power domain is not necessarily switched off while we are
+	 * suspended: on SDM630, SDM660 and MSM8998 the device tree attaches it
+	 * to the GPU's SMMU rather than the GPU. If it stayed on, the CP still
+	 * holds its old ringbuffer read pointer and would execute stale
+	 * ringbuffer contents once hw_init restarts it. Soft reset the GPU so
+	 * that it always resumes from its reset state.
+	 */
+	gpu_write(gpu, REG_A5XX_RBBM_SW_RESET_CMD, 1);
+	gpu_read(gpu, REG_A5XX_RBBM_SW_RESET_CMD);
+	gpu_write(gpu, REG_A5XX_RBBM_SW_RESET_CMD, 0);
+
+	/* devfreq samples the busy counter, which the reset clears */
 	msm_devfreq_resume(gpu);
 
 	/* Adreno 505, 506, 508, 509, 510, 512 needs manual RBBM sus/res control */

-- 
2.56.0


