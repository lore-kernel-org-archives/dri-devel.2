Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A58606A321
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPV+mRBe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68EBB10F0B6;
	Mon, 19 Oct 2026 22:58:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0539E10EB60;
 Mon, 19 Oct 2026 22:58:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D1114447CA;
 Mon, 19 Oct 2026 22:58:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792450716;
 b=UFsiUA6bU/lKDWPBTKuVDOre3akdejlxm7gWYFgnOsEqiw8CIQZC2oz2X6iqWsiCeD3V
 NNpFtFhnjIRK+mRRBPvMFqqw6Cs8Vd+wqz3LrBI8+hKrv7q3qTvKrp0NtVrGtVLc4GRJY
 AhEsnns7a9f5iMcZoiOa+7unhO+fwH5CzUShzuslwDQtptnAhZ2THAw3lGgAzZXNfhaKX
 qyyR9ngCI2PeRxZzlyoJAKvwoCrMXiHMaXfdcOJe1etx9cepdsLn8aoAsX0O2bkOsz2Om
 NzwBuG/jBPKs+2arYLxlA4Skt05wBsIPB2gyoXS8AeGFKoi0hecfhUTebWmWFG7UvUA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792450716;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=56TFoPsC+vIT97tVs05l7Gvn4lxIguQ6q9+6FgEk53M=;
 b=YbABa7GB02RQFHGcEJt/2B/KO/vA9vhThlovBQhq+3jBXHGujNHlwgaB5TwAAfATIcCY
 8KS76Her+BD/l/8JnT9nWMZTonzmu54fZIBvWvMoWszm11R+w7Pl5lZEKwFvHP/uvQJSc
 j0263NcijvT0wUOzhaij/3zvK2bGXXqV6bhplZToYI85wIeOm3looxv1r7ezka/PRS88C
 9AjJTDHf/JE6XNFhta11YFnHMvbX2+Mixmb5NiJDYUrZzKF1ALm7cWy02VC5zQ3jmbMSb
 YmJTjtwHxhSOG4i5zIIzS1Lhs/DJXXSHvqHPwc9fHNgy2wRuSeEQa87xgtkvl1n8OVw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id AD48B1F000C6;
 Mon, 19 Oct 2026 22:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792450716;
 bh=56TFoPsC+vIT97tVs05l7Gvn4lxIguQ6q9+6FgEk53M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=iPV+mRBeTgQgItDDwnex0ixy/NSgNriAirk71Bw56ScN6rktwNRKdAP+GpdfKrO2B
 jo1l6kRgHcGOUwIiuscvsbDFmuNzObNehh8BI9ONDhjdqCnHLuKj7K3TM9toUV29C+
 UtVfzgXyIYkEYLN47ze8krAaFOchHsdWZXhDVuSva+d9lfz34vLHafgngYUncK4cPN
 7jro8yc7ixWW451DPXM8WzUEPfuqj6hrHo/GfUlNcwos4bxOeA8YkQgKH0DlmBjhEB
 cGHPYAOyK6mHxpS/8cYUw8wdVAiXlgeUGbNyHm+nx79evPz4nGzcpx+1ZCne7FObuA
 fRutYeZKjyWnQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 268324069F;
 Mon, 19 Oct 2026 22:58:35 +0000 (UTC)
From: Fabricio Akio via B4 Relay <devnull+fabricioakio.gmail.com@kernel.org>
Date: Mon, 19 Oct 2026 19:58:32 -0300
Subject: [PATCH 3/3] drm/msm/a5xx: Use the downstream GPU idle timeout on
 A508, A509 and A512
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261019-a5xx-gpu-pm-v1-3-1d0c313a1412@gmail.com>
References: <20261019-a5xx-gpu-pm-v1-0-1d0c313a1412@gmail.com>
In-Reply-To: <20261019-a5xx-gpu-pm-v1-0-1d0c313a1412@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792450714; l=3585;
 i=fabricioakio@gmail.com; s=20260928; h=from:subject:message-id;
 bh=cXuE1dXmmOJbBZYxHq4v0R2d0f35xmFnvdicm6SOghk=;
 b=LzlQnGXBmj93JNo9quUesds4Cs0o5QRubK1pirscMXLh/RYexwsTwDfRCI5zxR4HVfRu9jfdC
 OgzQtwmDNnBCvaPUGPF9nG4UFQs60zmDMZxzzGZeF2cwCWMDt7o4uho
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
X-Spam-Status: No, score=-24.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Fabricio Akio <fabricioakio@gmail.com>

The A508, A509 and A512 took the 250 ms runtime-PM autosuspend delay
of the A530, raised there because quickly cycling that GPU's power
hung the system. Qualcomm's downstream driver powers these GPUs down
after 80 ms idle, qcom,idle-timeout, on SDM630, SDM636 and SDM660
alike.

Use 80 ms for these three, so the GPU powers down, and releases its
CPU latency request, sooner after its last work.

Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
---
The value is downstream's idle timeout for these SoCs:
https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/arch/arm/boot/dts/qcom/sdm630-gpu.dtsi#L71
https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/arch/arm/boot/dts/qcom/sdm660-gpu.dtsi#L73
SDM636 includes sdm660.dtsi:
https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/arch/arm/boot/dts/qcom/sdm636.dtsi#L13
Downstream reads it at probe, restarts the idle timer when the last
work completes, and slumbers the GPU when it fires, dropping its CPU
latency request:
https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/drivers/gpu/msm/adreno.c#L901
https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/drivers/gpu/msm/kgsl_pwrctrl.c#L2981
https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/drivers/gpu/msm/kgsl_pwrctrl.c#L2467
https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/drivers/gpu/msm/kgsl_pwrctrl.c#L2753

Tested on an A508 with the previous patch: 1381 GPU power cycles at
gaps from 50 ms to 3 s without a fault. The A509 and A512 values are
downstream's for SDM636 and SDM660; tested on an A508 only.
---
 drivers/gpu/drm/msm/adreno/a5xx_catalog.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_catalog.c b/drivers/gpu/drm/msm/adreno/a5xx_catalog.c
index 7b261f045eae..254bae06af39 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_catalog.c
@@ -50,11 +50,7 @@ static const struct adreno_info a5xx_gpus[] = {
 			[ADRENO_FW_PFP] = "a530_pfp.fw",
 		},
 		.gmem = (SZ_128K + SZ_8K),
-		/*
-		 * Increase inactive period to 250 to avoid bouncing
-		 * the GDSC which appears to make it grumpy
-		 */
-		.inactive_period = 250,
+		.inactive_period = 80,
 		.cpu_latency_us = 424,
 		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
 		.funcs = &a5xx_gpu_funcs,
@@ -68,11 +64,7 @@ static const struct adreno_info a5xx_gpus[] = {
 			[ADRENO_FW_PFP] = "a530_pfp.fw",
 		},
 		.gmem = (SZ_256K + SZ_16K),
-		/*
-		 * Increase inactive period to 250 to avoid bouncing
-		 * the GDSC which appears to make it grumpy
-		 */
-		.inactive_period = 250,
+		.inactive_period = 80,
 		.cpu_latency_us = 518,
 		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
 		.funcs = &a5xx_gpu_funcs,
@@ -102,11 +94,7 @@ static const struct adreno_info a5xx_gpus[] = {
 			[ADRENO_FW_PFP] = "a530_pfp.fw",
 		},
 		.gmem = (SZ_256K + SZ_16K),
-		/*
-		 * Increase inactive period to 250 to avoid bouncing
-		 * the GDSC which appears to make it grumpy
-		 */
-		.inactive_period = 250,
+		.inactive_period = 80,
 		.cpu_latency_us = 518,
 		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
 		.funcs = &a5xx_gpu_funcs,

-- 
2.56.0


