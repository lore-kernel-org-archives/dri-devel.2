Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234A2CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D16610E45E;
	Wed, 10 Jun 2026 07:49:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sFXCTkQF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B42C10E45E;
 Wed, 10 Jun 2026 07:49:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D049560172;
 Wed, 10 Jun 2026 07:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79F6FC2BCB9;
 Wed, 10 Jun 2026 07:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781077759;
 bh=lD1HUnZXDh8evB2ZyROS/+Exc/gYge+hONvXJRsg0UY=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=sFXCTkQFUj30kP12tXU3X+Elc6KPQMgHJy/S4wyg4uB3hHXD9VW+Sg5A1Y6rofwOD
 PnBCCKSzLiLXGFa4/aNO8EPUNEtNNmtF8W8Is7GfsagbFj5hy2jLZgUIVS868osOQn
 ItTmk51/M1OynqNhKQomyWevpLNHfI6ZwVuQoKnqZkjKdOaT+nzhe3OlCrSCOwKXU0
 yLBg4h0mt22I3qfXyWEDVOEs8VaNC9xtdSKxciRZByL2VFWKWmjShGJvmXGs5QO7DX
 HdOkNTFJjVldKzRyYL2UCrhHOeSUy8slR1e+LR5Tl6nxEBRUoWgXDLZuViDnBi5WEh
 Pv+lx9/cFpuzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 53B98CD98C7;
 Wed, 10 Jun 2026 07:49:19 +0000 (UTC)
From: Alexandre MINETTE via B4 Relay <devnull+contact.alex-min.fr@kernel.org>
Date: Wed, 10 Jun 2026 09:49:17 +0200
Subject: [PATCH] drm/msm/a3xx: Drain VBIF before GPU suspend
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-mainline-fix-a3xx-gpu-hang-sending-v1-1-9282182840b5@alex-min.fr>
X-B4-Tracking: v=1; b=H4sIAPwWKWoC/yWNywrCQAxFf6VkbWAetYK/Ii6mnVgjGsuklYHSf
 zfV1eXA4dwVlAqTwrlZodCHld9i4A8NDPckIyFnYwgudK7zDl+J5clCeOOKKdaK47TgrqKSZLY
 NR9f2Mcfc+hNYaCpk8u/kcv2zLv2Dhnkvw7Z9AYguHeSGAAAA
X-Change-ID: 20260610-mainline-fix-a3xx-gpu-hang-sending-2504b3d3d417
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
 phone-devel@vger.kernel.org, Alexandre MINETTE <contact@alex-min.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781077758; l=4188;
 i=contact@alex-min.fr; s=20260421; h=from:subject:message-id;
 bh=U1m7+SxBVxKaqhEGJu1GKuE9XFcw724ySAWY6Dm6jt4=;
 b=nrWv/4C4ROSaessiJUfrFyLGL8vxGp7iEbTcPpIDVjzhm5GMPY2gubhvQdtpsE1HDsq0fRHUJ
 N8MMsl3qktVBuMTFr00w7oJnk+2lIfD+kdrBvz16faVmf2QzhyMn59s
X-Developer-Key: i=contact@alex-min.fr; a=ed25519;
 pk=KOCaxY4v16ptaT0uk1FRkuaDF2n1JhmnYwLiqWD76M4=
X-Endpoint-Received: by B4 Relay for contact@alex-min.fr/20260421 with
 auth_id=743
X-Original-From: Alexandre MINETTE <contact@alex-min.fr>
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
Reply-To: contact@alex-min.fr
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Alexandre MINETTE <contact@alex-min.fr>

A3xx hangs after every runtime suspend on the Samsung Galaxy S4
GT-I9505. Even simple GPU workloads, such as drawing a single triangle,
hang reliably once the GPU has been suspended by runtime PM.

The generic MSM GPU suspend path disables clocks/power, but A3xx also
needs to ensure that pending VBIF transactions are drained before that
happens.

Add an A3xx-specific pm_suspend callback. Wait for the GPU to become
idle, halt all VBIF XIN clients, wait for the corresponding
acknowledgment, and only then enter the generic MSM GPU suspend path.

This fixes reliable A3xx GPU hangs observed after runtime PM on the
Samsung Galaxy S4 GT-I9505, codename jflte. The failure is reported as:

  mdp4 5100000.display-controller: [drm:hangcheck_handler] *ERROR* 3.2.0.2: hangcheck detected gpu lockup rb 0!
  mdp4 5100000.display-controller: [drm:hangcheck_handler] *ERROR* 3.2.0.2:     completed fence: 4294967041
  mdp4 5100000.display-controller: [drm:hangcheck_handler] *ERROR* 3.2.0.2:     submitted fence: 4294967049
  mdp4 5100000.display-controller: [drm:recover_worker] *ERROR* 3.2.0.2: hangcheck recover!

Link: https://github.com/freedreno-zz/freedreno/issues/12
Signed-off-by: Alexandre MINETTE <contact@alex-min.fr>
---
Fix A3xx GPU hangs after runtime PM by draining pending VBIF
transactions before entering the generic MSM GPU suspend path.
---
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c         | 36 ++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/registers/adreno/a3xx.xml |  2 ++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
index 018183e0ac3f..a37be1241271 100644
--- a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
@@ -25,6 +25,8 @@
 
 extern bool hang_debug;
 
+#define A3XX_VBIF_XIN_HALT_CTRL0_MASK	GENMASK(5, 0)
+
 static void a3xx_dump(struct msm_gpu *gpu);
 static bool a3xx_idle(struct msm_gpu *gpu);
 
@@ -502,6 +504,38 @@ static u64 a3xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
 	return busy_cycles;
 }
 
+static int a3xx_vbif_halt(struct msm_gpu *gpu)
+{
+	u32 ack;
+	int ret;
+
+	gpu_write(gpu, REG_A3XX_VBIF_XIN_HALT_CTRL0,
+		  A3XX_VBIF_XIN_HALT_CTRL0_MASK);
+	ret = spin_until(((ack = gpu_read(gpu, REG_A3XX_VBIF_XIN_HALT_CTRL1)) &
+			  A3XX_VBIF_XIN_HALT_CTRL0_MASK) ==
+			 A3XX_VBIF_XIN_HALT_CTRL0_MASK);
+	gpu_write(gpu, REG_A3XX_VBIF_XIN_HALT_CTRL0, 0);
+
+	if (ret)
+		return -EBUSY;
+
+	return 0;
+}
+
+static int a3xx_pm_suspend(struct msm_gpu *gpu)
+{
+	int ret;
+
+	if (!a3xx_idle(gpu))
+		return -EBUSY;
+
+	ret = a3xx_vbif_halt(gpu);
+	if (ret)
+		return ret;
+
+	return msm_gpu_pm_suspend(gpu);
+}
+
 static u32 a3xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 {
 	ring->memptrs->rptr = gpu_read(gpu, REG_AXXX_CP_RB_RPTR);
@@ -597,7 +631,7 @@ const struct adreno_gpu_funcs a3xx_gpu_funcs = {
 		.get_param = adreno_get_param,
 		.set_param = adreno_set_param,
 		.hw_init = a3xx_hw_init,
-		.pm_suspend = msm_gpu_pm_suspend,
+		.pm_suspend = a3xx_pm_suspend,
 		.pm_resume = msm_gpu_pm_resume,
 		.recover = a3xx_recover,
 		.submit = a3xx_submit,
diff --git a/drivers/gpu/drm/msm/registers/adreno/a3xx.xml b/drivers/gpu/drm/msm/registers/adreno/a3xx.xml
index 6717abc0a897..096de72b0b6c 100644
--- a/drivers/gpu/drm/msm/registers/adreno/a3xx.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/a3xx.xml
@@ -1499,6 +1499,8 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	<reg32 offset="0x3058" name="VBIF_OUT_AXI_AMEMTYPE_CONF0"/>
 	<reg32 offset="0x305e" name="VBIF_OUT_AXI_AOOO_EN"/>
 	<reg32 offset="0x305f" name="VBIF_OUT_AXI_AOOO"/>
+	<reg32 offset="0x3080" name="VBIF_XIN_HALT_CTRL0"/>
+	<reg32 offset="0x3081" name="VBIF_XIN_HALT_CTRL1"/>
 
 	<bitset name="a3xx_vbif_perf_cnt" inline="yes">
 		<bitfield name="CNT0" pos="0" type="boolean"/>

---
base-commit: 2d3090a8aeb596a26935db0955d46c9a5db5c6ce
change-id: 20260610-mainline-fix-a3xx-gpu-hang-sending-2504b3d3d417

Best regards,
--  
Alexandre MINETTE <contact@alex-min.fr>


