Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F37606D804
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYBQHh/W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3987810E6BF;
	Sat,  7 Nov 2026 20:26:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05B1D10E21B;
 Sat,  7 Nov 2026 20:26:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D7E0143BDE;
 Sat,  7 Nov 2026 20:26:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794083172;
 b=0En8ZXymQ7bZO0FAuTXvigCfjcyj12sQUfV+mTNmD6r2FZBHj/63Jo7WD/Y/l+GsffGt
 CZKVNe2BKldy8qNW1cCD0BSTHuVrZkofp0Wa9lh6f+4ZwPGrrMrA7khlhHcqGu79GkfD/
 dLw7B2Sun6XUi1rxyCeyMrf38f/rUXmgGM0OhNnyZ1hIWwsVVH/te1ZX+ZnlKJwWLau5F
 7ok142DFPXDyJ2MYQABPZwIrXZwRsnLn5UNgebLXWlWWDiTkRCX4wflReHKsYM4csvupW
 CuZF8fsF0R5KOCnVhxyGkXlPSUAzPJGA2hyaMDqnW06tf03fBlWRsSv36/5sllAugYw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794083172;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=599oIHXagTXVq55rO1Coxpv0tx3hk0b60kUtSVJ1qMg=;
 b=uvHG2ZPQrhpDUVnL1VqY5/7AkbHLyzWuj6ZHs3pH3ngNKELKcMa6ncIN+HXe9x0GNMoE
 JaIxJwA10STwNTSMcMZX7o5YyjvmWO+naqf+JxhOs8XcpoVfyzKy+VKtBS6RKk38XJIrm
 376f/WWumWpXUAzIxmEGYcrDr6ZoasZWPmVN4RbNgQwQXnXoI4MuJhoSWgjBBqK1548fJ
 Sgi6ed6dVt9U/rMHjKwv84rpbEGi2zUnyI94h1KZai+6wnZfKXK16QwDkVz3xFHXj1/lY
 PlV/UYXzGTUWjhrdSXkdwS30epkUgGQum+4LncT03jna+y1UfKkU13S1rQcaDJN8g1A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 23D451F008A4;
 Sat,  7 Nov 2026 20:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794083172;
 bh=599oIHXagTXVq55rO1Coxpv0tx3hk0b60kUtSVJ1qMg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=RYBQHh/WFFzNT+mldoS2eJyt+JLcJIVnYjvX1DYkGMYs6VCPoDlVczMN/rxC51Jv6
 +GSoTK6NiBxdxInBlzmyNh9RC4/DhB/dIlKbPwTRPw+l+iGJGbA+dZEUOAL91bdWa4
 druC6REY8iH6g3pJc94exXJBJt5lsH6RfLkB21AOSWHbW02Y8s32c7QlM7vk62i4PT
 oJPTcIolvxGnKKvyKBznRXzRgMz3zQTPb1XJP/18DpIdCYkajuASZSRJN0ZqQE7FLN
 BAq9e5nDFeNFvZSpKUVVpGDqnUjMz3cVe2kdN2qR+ZGHCk+f/cH693n01tvV7ztRui
 P5iPdIg1bwuKQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id A4A8C47D03;
 Sat,  7 Nov 2026 20:26:10 +0000 (UTC)
From: Fabricio Akio via B4 Relay <devnull+fabricioakio.gmail.com@kernel.org>
Date: Sat, 07 Nov 2026 17:26:10 -0300
Subject: [PATCH v3 4/4] drm/msm/a5xx: Use the downstream GPU idle timeout
 on A508, A509 and A512
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261107-a5xx-gpu-pm-v3-4-e2480408abea@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794083169; l=3716;
 i=fabricioakio@gmail.com; s=20260928; h=from:subject:message-id;
 bh=Bk05C/pJ2lbdNVztIffGRS6PegYHz16EtmFFGVfj7C4=;
 b=fHPXFDymTmQPdnvsK3U7IkDzt3xmli55zYnXCNO+0niQHZZAExMFzQNN7Kmm6CO9ZDKSy7+3q
 9WVn5M3++IKAAljjrOjSXttjfM1YdUVNY7gSHYMUwLSW6PI6/vrn6tb
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

The A508, A509 and A512 took the 250 ms runtime-PM autosuspend delay
of the A530, raised there because quickly cycling that GPU's power
hung the system. Qualcomm's downstream driver powers these GPUs down
after 80 ms idle, qcom,idle-timeout, on SDM630, SDM636 and SDM660
alike.

Use 80 ms for these three, so the GPU powers down, and releases its
CPU latency request, sooner after its last work.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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

Tested on an A508 with the previous patch: 784 GPU power-ups at gaps
from 90 ms to 2 s without a fault. The A509 and A512 values are
downstream's for SDM636 and SDM660; tested on an A508 only.
---
 drivers/gpu/drm/msm/adreno/a5xx_catalog.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_catalog.c b/drivers/gpu/drm/msm/adreno/a5xx_catalog.c
index ae9127940a22..285502356823 100644
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
 		.cpu_latency_us = 2336,
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
 		.cpu_latency_us = 2336,
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
 		.cpu_latency_us = 2336,
 		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
 		.funcs = &a5xx_gpu_funcs,

-- 
2.56.0


