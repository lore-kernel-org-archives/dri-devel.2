Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6674CA5FF5
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10F3B10EAD8;
	Sun,  4 Oct 2026 17:18:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rwjgPJor";
	dkim-atps=neutral
Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com
 [74.125.227.166])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B74A10E5B3
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 13:07:02 +0000 (UTC)
Received: by mail-pj2-f38.google.com with SMTP id
 98e67ed59e1d1-3a4c0da0145so1691181a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 06:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790946422; x=1791551222; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DY2cwQpDJccuyfdSvxswtfH2eyWbZEDW7sPjJNa4T3k=;
 b=rwjgPJorkhrLjp5FaOcO6FbSS0TiFDvVxt0vWsqAaDraJEPLZFnah+LSVFhTxswODI
 iHKCOIKvRVMnBeAOY/BwhCIK6T2Yx/wvl0JieP4n24fY1JgxXguAdNA51g+mxxsXlZaZ
 nkt7PewqyU1CCbZkibL51qgqxv351gGfZtap00L2lYSsqusN1sbyRDz2ASmaC0ot1Mry
 rvLx48ZT/L83K+Fdl9z7z/l0uiPbcxggJaDgp+q3UVaiRoGsxTpunGElYB4TJ4fxmGhe
 86ZqP+s35WQeZdTR8rwqHrUsLLRxKugGezKFfcYkdTHugEzps23/wSr/i00YMMt3UEut
 UUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790946422; x=1791551222;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DY2cwQpDJccuyfdSvxswtfH2eyWbZEDW7sPjJNa4T3k=;
 b=rcV9acTMdTNss0As4apDLcxC/t7Q/7BDbG2B+YJk7FfmaAuoxR9g+nyCGPjdfuOyuL
 TTnSMVMif5BLjeC9wgQP0i8AlQ5/sH7JrpkYw++Foidybp7XYMTwjYN8ToN2XU/nlmI/
 g3Os/uoHYIDH5BlzstEh6MnBZR2TmsqRdDvpfTj9nmDt2uRGbOIDdSVfGNapEozwWyHC
 LG6B6usvFmtH2DfsGKgAQEq4XbdCq+7oY4+tEv2OUuZVh4ZJJK5xG2wo2+GKAXsTS/4S
 l4kr7AYLxJNxL8dvWT4HOeOO6AAnJD4mTbnEfuFCPjjqbl9Aq/Rihj0G61I9FVUkf7Cx
 fKnA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+74lYiAcAELRXfHJwhhQilGcXlhrgtTY8Wq13jzhq5KgAQIDwDVXXFIkkaoHncdZlwoYEXJpxRqU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKiqNkeNBOisRtpq/7k3gGbeQ3jymE9PaUWyRXC9zUNHJRbRDBx
 cHl34fXuejPNGgkT4PFM5mOs7g5yRzBB4rcRaK3u8aO3ROGO6Q+go/1F
X-Gm-Gg: AYBFou3UfQQbMqfSbpL27tyNk3ltfOkTWyZIRtIX2MZhEeBfFnT5mOYDA5Nod1lKz66
 WAoyqaSjKxF6gdrQC7LBIwo1zzrrvAGtC7HI97gTNEACL27Xk7NDuK6ZOxBPS5w/E9705i5UpPZ
 c+N3uG0wmbYhxl2rGSNVwvqJh+m4mtTcLrOWifchT5/uW1T6/BkNMBqx2CEpat+K8GR5zQdnDUe
 Zk/aqjcFrvOjcuCtUCcPjGCBFIPYibSoy4loys//LS6XUZDfVnmXaXhQG8MRd8owfCQaOa1mbvr
 3jXrplJQAdJ+s+7+DrwB9Aj6TdEBbYghdqA+w8rHqlczn1J52W9EJP50uLyT7uvolJfpiCAYWix
 gQNVnI5iPWuTrysvpge1K0V4dyXCX3BYi6p8Vjn3Q8iimC2JGdyyNjpJZeP4dPO/Jdh+kHBuPOP
 SqbLyMRIjPKBcaTbBgLIvdgH1GcX9K+lHhRTQE2sBS4LjaG+okUa3GnFCZQwUrpYngzff5agsIm
 5W0Vgts+jQmPA==
X-Received: by 2002:a17:90b:4acb:b0:39e:4c81:6c5f with SMTP id
 98e67ed59e1d1-3a6ce95932bmr2677617a91.26.1790946421716; 
 Fri, 02 Oct 2026 06:07:01 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6cd5d88e4sm4474906a91.13.2026.10.02.06.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 06:07:00 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: robin.clark@oss.qualcomm.com,
	lumag@kernel.org
Cc: abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Joonhoe Kim <26rote@gmail.com>
Subject: [PATCH v2] drm/msm/dpu: compute the CRTC bandwidth from the state
 being checked
Date: Fri,  2 Oct 2026 22:06:56 +0900
Message-ID: <20261002130656.50577-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

_dpu_core_perf_calc_bw() is called with the new CRTC state but sums
plane_fetch_bw over drm_atomic_crtc_for_each_plane(), i.e. the planes
of the committed state. When the CRTC is re-enabled (DPMS on, system
resume) the committed state has no planes attached, so the check
computes bw_ctl = 0 and the display runs without an average bandwidth
vote on the MDP path until some later commit changes a plane -- which
may not happen for a long time on a static screen such as a lock
screen.

Seen on a Lenovo TB323FU (SM8850) through the interconnect and DPU
tracepoints: after DPMS off/on or s2idle, dpu_perf_crtc_update reported
bw_ctl=0 and qnm_mdp was left at avg_bw=0 (peak 800000) instead of the
3728793 kBps voted before, until the next mode change.

Iterate the plane states of the CRTC state being checked instead.
drm_atomic_crtc_state_for_each_plane_state() falls back to the current
plane state for planes that are not part of the commit, so the result
is unchanged for commits that do touch the planes.

With this, bw_ctl is 3728793600 right after DPMS on and after resume.
Only tested on this device.

Fixes: c33b7c0389e1 ("drm/msm/dpu: add support for clk and bw scaling for display")
Assisted-by: LLM
Signed-off-by: Joonhoe Kim <26rote@gmail.com>
---
Changes in v2:
- Drop the code comment that repeated the commit message. [Dmitry]
- Link to v1: https://lore.kernel.org/all/20260929130633.977-1-26rote@gmail.com/

_dpu_core_perf_calc_clk() walks the planes the same way; it is not
touched here since I have not seen a wrong clock vote from it.

 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
index fea173e37464..9fa55904dba1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
@@ -54,24 +54,19 @@ u64 dpu_core_perf_adjusted_mode_clk(u64 mode_clk_rate,
 /**
  * _dpu_core_perf_calc_bw() - to calculate BW per crtc
  * @perf_cfg: performance configuration
- * @crtc: pointer to a crtc
+ * @state: the CRTC state
  * Return: returns aggregated BW for all planes in crtc.
  */
 static u64 _dpu_core_perf_calc_bw(const struct dpu_perf_cfg *perf_cfg,
-		struct drm_crtc *crtc)
+		struct drm_crtc_state *state)
 {
 	struct drm_plane *plane;
-	struct dpu_plane_state *pstate;
+	const struct drm_plane_state *plane_state;
 	u64 crtc_plane_bw = 0;
 	u32 bw_factor;
 
-	drm_atomic_crtc_for_each_plane(plane, crtc) {
-		pstate = to_dpu_plane_state(plane->state);
-		if (!pstate)
-			continue;
-
-		crtc_plane_bw += pstate->plane_fetch_bw;
-	}
+	drm_atomic_crtc_state_for_each_plane_state(plane, plane_state, state)
+		crtc_plane_bw += to_dpu_plane_state(plane_state)->plane_fetch_bw;
 
 	bw_factor = perf_cfg->bw_inefficiency_factor;
 	if (bw_factor) {
@@ -131,7 +126,7 @@ static void _dpu_core_perf_calc_crtc(const struct dpu_core_perf *core_perf,
 		return;
 	}
 
-	perf->bw_ctl = _dpu_core_perf_calc_bw(perf_cfg, crtc);
+	perf->bw_ctl = _dpu_core_perf_calc_bw(perf_cfg, state);
 	perf->max_per_pipe_ib = perf_cfg->min_dram_ib;
 	perf->core_clk_rate = _dpu_core_perf_calc_clk(perf_cfg, crtc, state);
 	DRM_DEBUG_ATOMIC(

base-commit: 6375e61c01e93e35ee7acd336a689ac1fae4b509
-- 
2.43.0

