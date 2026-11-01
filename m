Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53916606A325
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 02:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mfKBJ6I1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10D1810E12F;
	Sun,  1 Nov 2026 02:33:00 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FF0110E0FC;
 Sun,  1 Nov 2026 02:32:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3327760234;
 Sun,  1 Nov 2026 02:32:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793500371;
 b=QtXT1zE5+3DDdh4Zn2Ma4SJYYZpC7ZZiduS+6VLTXvyf9Sig8Z8T/L2JHPIf3aS5rJP+
 0KezN3M6YGDMBlRaE2NuoJEleDO6xew38xJTlUCMkA9FWiU+ruqAbt23CLoyMoZjb/n1O
 Xxqx1SInTIouhzR4L5wO78CaZYbTxkkWaRm5HVC7cMwseGDflJcXWVRG9jwxDfgRLacoE
 b/MAL0n62mWEJGeqPZiPfXbOGQkk3lH7DmpZWchu5inBXhCLgk/TK9uBIVnhGBL9SDHhn
 0KIWIElUBV9tr62vKUOQVqR0Gb/Fupr+pDJU+3Oy0ISFeyEut87l2ISFUYNxSHH5s1Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793500371;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=io1h8wzcadpTDuoB7GZuwOI3LJnSvjgks0Q8JaPUBzs=;
 b=CVSNWgsl6G1Ma40U3jqrwDTDKhW8Z/tCNLNVFa+Ol0wIieqHx/B/0nCPfKzeaudXySbB
 WFzLUWFGTS1XOYjgTid3Ixtqk43wTmE6FackoTmDojb8/Vs3+PCDjuKDXTX7BbRx2RVEr
 9A83EAFmJBcitsN2zE9BshScd+BdavUIQ+T38qNliE1v8JAkTLPVG6QPjujr5hVUmlY/m
 GgyFP+2iLzDUmQVMMhnMo50rWV6fzPpAQAaH7AG+LRNbGPa0A5r5EiktkrcSXGqQzLZMS
 PFY5BumuLPXMizzr2gug9Cc/zgqd8AbeWc3bUvbxc2A8m/HY3X0WwXE0oFe0JAUSQMw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 58B371F00919;
 Sun,  1 Nov 2026 02:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793500371;
 bh=io1h8wzcadpTDuoB7GZuwOI3LJnSvjgks0Q8JaPUBzs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=mfKBJ6I1FAU8XZeMwh5G2zP7Qjs2zfCNFfEOoEZyGNxXYCk2P4dECTjVbtbeHEsdz
 HGmKWRveiDgdaAf2yX+eVo0PcLnZn4sviJIEaSR7OINeJqu5lBFW9ixmQP1CMkcFRj
 4BBEUe2JVNTK2g+GtrshxMW58xu3GqK2b8W14TieON6hepGVRaxEZwCvIJKskPMSXt
 nnLJnxjIcr/ctiQiCJ2U8769o+qwobYVRBv4k3Ijeq0h0QKjNz+DTIpBKh0UXt19Yo
 t65bYxo+pAQnRtuiHPBDjA2V8Pazyq3NEtBYh/T+tgPgn/LuBf8RIBjX3XQKtpu5Rx
 T2iCDeJVf8zGA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id DA0834605B;
 Sun,  1 Nov 2026 02:32:50 +0000 (UTC)
From: Fabricio Akio via B4 Relay <devnull+fabricioakio.gmail.com@kernel.org>
Date: Sat, 31 Oct 2026 23:32:50 -0300
Subject: [PATCH 1/2] drm/msm: Report no GPU time for a submit killed by
 hangcheck
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261031-a5xx-submit-stats-v1-1-16a67ac96edd@gmail.com>
References: <20261031-a5xx-submit-stats-v1-0-16a67ac96edd@gmail.com>
In-Reply-To: <20261031-a5xx-submit-stats-v1-0-16a67ac96edd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793500370; l=2799;
 i=fabricioakio@gmail.com; s=20260928; h=from:subject:message-id;
 bh=XiTCuVQ2SVXzVV9gUfwhSNVnytDNQZiKRQ8ZI2IW92k=;
 b=cPMkjXaKMy9W6RniiDq9tmz9FCrvwjT09MF7QD6Laqc6C/gY1veoNzfm5kP0HChlmkatlVxxw
 mlVCjpZb7uJBCmzscdggw8yOnjQVgLHgnJRdWjr2I8EP6hUtTw367QO
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

recover_worker() advances the fence over the submit it treats as hung
and retires it through retire_submit(), which computes its elapsed time
and cycles from the stats slot the CP writes after the submit's IBs.
That submit may not have written its end stamps, leaving an older
submit's or zero; the subtraction then wraps, and about 3 years of GPU
time is added to the context's fdinfo drm-engine-gpu and reported in
msm_gpu_submit_retired.

Set the end stamps of the submit the fence is advanced over to its
start stamps, so that it reports no time. Do it after the GPU is reset,
when the CP can no longer write the slot.

Fixes: 4241db42e474 ("drm/msm/gpu: Add trace events for tracking GPU submissions")
Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
---
Charging the time until the failed submit was retired, as panfrost
does, would need the stamps' counter read at recovery, and that
differs by generation: a6xx stamps CP_ALWAYS_ON_CONTEXT while its
get_timestamp() reads another counter, and a2xx/a3xx have none. So
this reports zero.
---
 drivers/gpu/drm/msm/msm_gpu.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 0c2c35636251..40d658a63540 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -468,9 +468,11 @@ static void recover_worker(struct kthread_work *work)
 	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_gem_submit *submit;
 	struct msm_ringbuffer *cur_ring = gpu->funcs->active_ring(gpu);
+	volatile struct msm_gpu_submit_stats *stats;
 	char *comm = NULL, *cmd = NULL;
 	unsigned int noreclaim_flag;
 	struct task_struct *task;
+	uint32_t hung_fence = 0;
 	int i;
 
 	mutex_lock(&gpu->lock);
@@ -548,8 +550,10 @@ static void recover_worker(struct kthread_work *work)
 		 * For the current (faulting?) ring/submit advance the fence by
 		 * one more to clear the faulting submit
 		 */
-		if (ring == cur_ring)
+		if (ring == cur_ring) {
 			ring->memptrs->fence = ++fence;
+			hung_fence = fence;
+		}
 
 		msm_update_fence(ring->fctx, fence);
 	}
@@ -558,6 +562,15 @@ static void recover_worker(struct kthread_work *work)
 
 	gpu->funcs->recover(gpu);
 
+	/*
+	 * The submit retired in place of completing may not have written its
+	 * end stamps, leaving an older submit's or zero.  Now that the GPU is
+	 * reset, set them to its start stamps, so that it reports no time.
+	 */
+	stats = &cur_ring->memptrs->stats[hung_fence % MSM_GPU_SUBMIT_STATS_COUNT];
+	stats->alwayson_end = stats->alwayson_start;
+	stats->cpcycles_end = stats->cpcycles_start;
+
 	/* retire completed submits, plus the one that hung: */
 	retire_submits(gpu);
 

-- 
2.56.0


