Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD61C9831E
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 06:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2485F10E160;
	Sat, 26 Sep 2026 06:17:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qaPAMcfX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D40910E01F;
 Sat, 26 Sep 2026 06:17:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 22D666022B;
 Sat, 26 Sep 2026 06:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C662BC2BCF5;
 Sat, 26 Sep 2026 06:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790403441;
 bh=uz1qQsWM9XDZpqqxN47iDPynlINrnQvOxEdKWbh4xDw=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=qaPAMcfXhtV7myD0LxuyGneAY0yyupIi4MNgM3XYCrvlsI14EPGQcxDKpshHNeq9u
 XBS1FIt/FEgAsM43hYv2YAuy4bdroblfd9t95W4C9Fp90Dwb/BlYmI/pZtW7fma0VZ
 CeD6KF4Mk0y+lIsGjM+nd0MdPCFGfQTevTCX54aRdIUCAf275sgFUC+CP6Vkz1a05B
 ORITNV3lQtnNbChJXA/Rud91e94Y7r392H/EwGvGfx1/nJeEhPY5lTfcMZ3szszf5I
 yRiqtNeiLG4139qYOObI2nz/m88lm7h7svfCZ/7dnyVkJGXW8ngjUfPPPf/lwnFuxe
 SC23l/ARwA5Pg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC15C98328;
 Sat, 26 Sep 2026 06:17:21 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Sat, 26 Sep 2026 16:17:13 +1000
Subject: [PATCH] drm/msm/a3xx: fix VBIF halt mask for A306/A306A
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-a306-vbif-mask-v1-1-2bae5e81c05a@samcday.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MWwqDMBAF0K0M99uBmNpUs5XSj9hM7CA+SECE4
 N4LngWciiJZpcBTRZZDi24rPLUN4fsL6ySsEZ5gjXVmsB2Hh3F8jJp4CWXmZ59eg3HJdi6iIex
 Zkp53+P5c1x90ppU2YAAAAA==
X-Change-ID: 20260924-a306-vbif-mask-58f7906f246d
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexandre MINETTE <contact@alex-min.fr>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790403440; l=2199;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=oDYwGKGyfEkOHM+q+3q3tiYEXIpdYfuD7sbODF+IpJk=;
 b=P7wMnjbjN9vUTSd526bE/GsU+zAk9jbwq6ub1Lx30B47NQO4CXDtBYqViJyRqDCt3l1wtulhK
 NoKQEdFjxt6BW1Ct6DdfRTqUY5I3gYpcBggYA1+RfxzrqcGYXPri2C+
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: me@samcday.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Sam Day <me@samcday.com>

A306 and A306A implement only three VBIF XIN halt request bits.
Consequently, waiting for the full 6-bit A3xx mask times out and
prevents runtime suspend.

This issue was reproduced on a DragonBoard 410c: the request reads back
as 0x7 and the acknowledgment as 0x00070007 - the poll eventually
returns -ETIMEDOUT, and a3xx_pm_suspend fails with -EBUSY.

The downstream kgsl driver corroborates this (see link). Since the
single-character difference between A3XX_VBIF_XIN_HALT_CTRL0_MASK and
A30X_VBIF_XIN_HALT_CTRL0_MASK could be confusing to read, the narrowed
GENMASK is instead defined inline in a3xx_vbif_halt().

Fixes: be0e82b8e0c9 ("drm/msm/a3xx: Drain VBIF before GPU suspend")
Link: https://android.googlesource.com/kernel/msm/+/c90c7feeca2f5839ad6824f816c0bd207602a2f4/drivers/gpu/msm/adreno_a3xx.c#637
Assisted-by: LLM
Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
index 0259e60b80115..f672abd5e15e4 100644
--- a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
@@ -500,14 +500,18 @@ static u64 a3xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
 
 static int a3xx_vbif_halt(struct msm_gpu *gpu)
 {
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	u32 mask = A3XX_VBIF_XIN_HALT_CTRL0_MASK;
 	u32 ack;
 	int ret;
 
-	gpu_write(gpu, REG_A3XX_VBIF_XIN_HALT_CTRL0,
-		  A3XX_VBIF_XIN_HALT_CTRL0_MASK);
+	/* A306(A) only have three VBIF XIN ports. */
+	if (adreno_is_a306(adreno_gpu) || adreno_is_a306a(adreno_gpu))
+		mask = GENMASK(2, 0);
+
+	gpu_write(gpu, REG_A3XX_VBIF_XIN_HALT_CTRL0, mask);
 	ret = spin_until(((ack = gpu_read(gpu, REG_A3XX_VBIF_XIN_HALT_CTRL1)) &
-			  A3XX_VBIF_XIN_HALT_CTRL0_MASK) ==
-			 A3XX_VBIF_XIN_HALT_CTRL0_MASK);
+			  mask) == mask);
 	gpu_write(gpu, REG_A3XX_VBIF_XIN_HALT_CTRL0, 0);
 
 	if (ret)

---
base-commit: a15fac810c76397ec9f62a6fc26c4d7ab6e238a7
change-id: 20260924-a306-vbif-mask-58f7906f246d

Best regards,
-- 
Sam Day <me@samcday.com>


