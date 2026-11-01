Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85D9606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 02:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ok2oMrG6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0ED410E0BC;
	Sun,  1 Nov 2026 02:31:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 021B310E033;
 Sun,  1 Nov 2026 02:30:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BF0F0405EE;
 Sun,  1 Nov 2026 02:30:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793500257;
 b=zA4N53CkZlEYr1KvM2suW5fUtKpyPuN0JX/N/Zbu7sQyw1EOrSTBU9c/OcRDpH8OFIGF
 Oey3JFNA2ip6HhqIA/0JO1LqhmfkXfYb/8RP7nG7jQA4XnR/J8wZYzDhmKO0JRk2m4Umg
 y3iycGEqezip5TqoZDE2haxMnZ5Bt8yi8tVstZyczX5LrK3vQFQKjHkkTY5tzO93ZYfpi
 Tw3rPcLpScXGCsad/1xdaqugFRObcWvoBfhvxOCrR5zscP2SKSZT8X+jOfHUGZyGQ3meo
 +ppDyLR8CGaW1aJq8U1Jht+YgVuB83UtszxGht5SHL3QZzVb1XjVJZXLkq3zTBSkJzA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793500257;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=Av/AZx/+hbd/epNN4JJOs8spD71iHEi1GvauWh/m9P8=;
 b=XFnv6AS+WPCEBZd57mLd1GLj9qcEdd7wxD/FrrfEZLSSexEFkkCGfvP39ifCvFTBa4o3
 WoWEc7nLNM3cdW4idJ2DtVK7i3FVLArGABHwwF9iDl2UM7HomrDkVCgTFiHGL0Ewr4vOe
 lY4vYdW04JPNkSH2efbLMbPVpbwFiH9GjG4Wmaq0mIk8CAju+vu8uKetH/guJYYibe9dd
 4ElETqvcMM3J8WOEhVUyarTpvUZte2lhOAQyrRcXzppNSDuWFrlGCiEZ9EmaQla4K+Kan
 1969f1gyc6EA0prWXm+AGEK1/kvDOYE7fKBJyWeYpMl/M4kmpA2M/tP6Cnrxvl5EXyQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 0B7EB1F00919;
 Sun,  1 Nov 2026 02:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793500257;
 bh=Av/AZx/+hbd/epNN4JJOs8spD71iHEi1GvauWh/m9P8=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=ok2oMrG6eftGOhRimh3x6jwoxHdFt4h78EoK2X4i5hI1+7R83grX9e7LR6VwOQyzN
 /YgJO8ccurJebZzh0DS0SwYDvUlv6rJnOmmGZvNfs8HjRb10/CtRO/PMI3uxLDFJ+/
 PJ5I7W3KcQVMx74r8dhJRy3GgdcCxzkxYXN4Dh30rNzRy5/8chS7sscbvW3FFHDRYT
 CUq0GQaCmK7gRDeWVUz5brC6tBV3FgihmP/e/2VB3G2c3f74aAO7qZmu6NCk8OP+Nc
 GvokKoaD31rDMySVtIk6vFCIgox8132oPraBRijt159EESJaBrYlLSC58/IOKFxuwx
 584gT3ffeRodw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 8BEDD46037;
 Sun,  1 Nov 2026 02:30:56 +0000 (UTC)
From: Fabricio Akio via B4 Relay <devnull+fabricioakio.gmail.com@kernel.org>
Date: Sat, 31 Oct 2026 23:30:55 -0300
Subject: [PATCH] drm/msm/a5xx: Write CP_RB_WPTR under the ring's preempt_lock
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261031-a5xx-wptr-lock-v1-1-fa7d7b9a7fbe@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ5EMBCA4VeROZvEtKmDV9k4UFMGQVq7moh31
 +X4Hf7/hMBeOECVneD5J0HWJYHyDOzQLD2jdMmgClVSoQkbEyMe2+5xXu2ExrRkSGvlrIMUbZ6
 dxGf4qV+Hbzuy3f8XuK4bHMQP9nIAAAA=
X-Change-ID: 20261031-a5xx-wptr-lock-55b151332fcf
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jordan Crouse <jordan@cosmicpenguin.net>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Fabricio Akio <fabricioakio@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793500256; l=3913;
 i=fabricioakio@gmail.com; s=20260928; h=from:subject:message-id;
 bh=SUNATcfAyOfKteGeuYntWXBBaaQFnfxYwXjBjp6a+vU=;
 b=ZMKnqzhG6IvyxdK/sCwhtNHfQiyo+Tuzwg7/AsYhB8BROSd9CZjCN4WCviZhiZo7TMnoFkvci
 T5kHFg5BUdxDhvD0Tc0/R4AjvSBNoSiRgbkW89xgsE+Now3SbyqgGRt
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

CP_RB_WPTR tells the CP how far the ring has been filled. Two functions
write it: a5xx_flush(), after a submit is added to the ring, and
update_wptr(), which a5xx_preempt_trigger() calls from the IRQ handler
each time a submit completes, whenever there is more than one ring,
even when no ring switch follows. Both read the ring's wptr holding
ring->preempt_lock, but write the register after releasing it, so the
two writes can land in the wrong order:

  CPU A, IRQ:   update_wptr() reads wptr N
  CPU B, flush: a5xx_flush() reads wptr N+1, writes N+1
  CPU A, IRQ:   update_wptr() writes N

CP_RB_WPTR then points behind the last submit. If the CP has already
read past N, it treats the ring as nearly full and executes the
commands left over from its previous pass through the ring. This shows
up as CP opcode errors, and the old submits write old fences, so the
fence in memptrs goes backwards. Recovery then finds no submit to
blame and does not reset the GPU, which stays hung until reboot.

Write the register before releasing the lock in both places, so the
last value written is always the newest, as a6xx_flush() does.

Fixes: b1fc2839d2f9 ("drm/msm: Implement preemption for A5XX targets")
Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
---
Tested on A508 (SDM630), with piglit's texelfetch tests run in
parallel: CP opcode errors in each of seven one-minute runs, the
seventh ending in a hang that never recovers; with this, none in 25.

The downstream driver writes the register holding the ring's
preempt_lock in both of its places:
https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/drivers/gpu/msm/adreno_ringbuffer.c#L104
https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/drivers/gpu/msm/adreno_a5xx_preempt.c#L25
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c     | 10 +++++++---
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c |  3 +--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 16c7335c4b1f..63b313328979 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -53,14 +53,18 @@ void a5xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
 	/* Make sure to wrap wptr if we need to */
 	wptr = get_wptr(ring);
 
-	spin_unlock_irqrestore(&ring->preempt_lock, flags);
-
 	/* Make sure everything is posted before making a decision */
 	mb();
 
-	/* Update HW if this is the current ring and we are not in preempt */
+	/*
+	 * Update HW if this is the current ring and we are not in preempt.
+	 * Under the lock, so that update_wptr() cannot write an older wptr
+	 * after this one.
+	 */
 	if (a5xx_gpu->cur_ring == ring && !a5xx_in_preempt(a5xx_gpu))
 		gpu_write(gpu, REG_A5XX_CP_RB_WPTR, wptr);
+
+	spin_unlock_irqrestore(&ring->preempt_lock, flags);
 }
 
 static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit)
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
index e4924b5e1c48..0deac58bc22e 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
@@ -47,9 +47,8 @@ static inline void update_wptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 
 	spin_lock_irqsave(&ring->preempt_lock, flags);
 	wptr = get_wptr(ring);
-	spin_unlock_irqrestore(&ring->preempt_lock, flags);
-
 	gpu_write(gpu, REG_A5XX_CP_RB_WPTR, wptr);
+	spin_unlock_irqrestore(&ring->preempt_lock, flags);
 }
 
 /* Return the highest priority ringbuffer with something in it */

---
base-commit: a39c950806213f6861d00f90729acaaa21f2d95a
change-id: 20261031-a5xx-wptr-lock-55b151332fcf

Best regards,
--  
Fabricio Akio <fabricioakio@gmail.com>


