Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2793CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3515010F353;
	Wed, 30 Sep 2026 12:12:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MOOHA+WN";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 018E710EEA3
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 13:06:39 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2dd4b43b20bso17689285ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790687198; x=1791291998; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rGEWCLC1FPZDP0SnOnB5resnwfxQezT/YHoUyZYHjyE=;
 b=MOOHA+WNwq22J5WIIaMf79scJ+QVvnzyFBXMmldy4MjZ98dZaxYrtMYh82jPHGm3DH
 /pc+h+xBtjyTYtUSG0f1P2DT6jxzlB3jiH+bbBJ+4c43f/KfxTnQNaBGHYup2ngFOlIW
 wtOQZIoQWA52GVYRXm2wY7SFRDpsEoz4q3T0UZ29O/yopprCWLMte1eXm2vfmrKPKh9f
 +y7EEMJ89RMYpDsqzCUlPuZB59pXDvEMIgmHSufA4c5ACfDWaHHy3HiZ1Hhjikt2reua
 vcBS7op1VCnKmcY5o1Lm9IOdmrk+6QNH+8PbRbUupyafjfobwKH9d86qg1VZBFhVTDGc
 dadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790687198; x=1791291998;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rGEWCLC1FPZDP0SnOnB5resnwfxQezT/YHoUyZYHjyE=;
 b=EiJ8Ovp7lpXN9y3hlsEBGGAuS7RILOL9oplUJkzBrqGP0vfjpGgc2zHqxmhtb46Jb3
 yR3h7EUERcVbxumIIXa3MVgz/tLw5dK1FXrVIPThXcTioebFf1F2SdymFn4fnzuptn+2
 xYVn3LgbW7KAT6E8wVhYP3fqPZwFEntPMsaupmQAhGC5AEYRQsQGCLfZJWKPa3QU2WU8
 KbBkFkKAqZ7PKDzEn4D2FTBHsO/qB0HFE4olnMfGZKtxAQNsxKu0p/X2f73ghUSx6rx4
 K6JRpF51CxstoouJQUXRUsz3wkNyePtO5Z9hqpqYsE+Cl2xVwmgMZA5cxNv7BEYXINVn
 sRlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxT5BHd0Hj2gR8KsAn6PDhET2unl2Zb6XbhMLvIpX9Vz5jY/6smMC/1zeJk5p/REBl3MEBLguu8MXA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKrT8z1XchIl6pdaATokf9CsuiOLGX1A2Fl71zZumVE9GlaGPmE
 J7nU2XESvETk9WA62UNDPeEWXqm0T8Ez6EhkMPh7BInDtxqni6uxoU3A
X-Gm-Gg: AYBFou173VlOOO8V4cWhp7Fnd97cEOA06U/qFwGyWDZi9BZ6fJnQZOK8vGGIN24lTIP
 Uudk43SoysaYfhB2ja+GolnrduA6D7GddL6sgZj1lwbjGD92eM4YE6CAOGzZqKdVMBLx/tYvPJa
 g6JOLMacRcUc6Mket0UpvLXXY/TpFWjMR+jGotgfdC+udiHqezZ0bNnV3S0gxbUthxGDsxeRLRW
 IkUbn9NK+Np/jDq25VTXixWi/r/vZOKAwkOsFUwpZLZ0LCjhNWvowMrDllepFd7RfYJ7Avkct6p
 PMZMYNA2kKrooy10dCQGYq+Av5X1G1Uqmu4wXHRf1/lHoKmnz9qtksJAsf+2vb5uH5djgePKzSL
 HmTjlp++Y/DLFaf33IPHdlpojGhXJAzhdfLlv2etEbzQ+bdQSU4EsZlvVYkTnIOTQt/R/KtpNXy
 ZPP3fKN2GSSYzFxYZitV95v8RW0WtEHWetA8TUFhDEIcFMnUkZUfznFhZuD+TjsHxpzcrXIcz6n
 9fTYrWiuWev/LNLgOIaRp9T
X-Received: by 2002:a17:902:cec9:b0:2dd:ad74:ac2f with SMTP id
 d9443c01a7336-2df7dea09b6mr135005155ad.24.1790687197690; 
 Tue, 29 Sep 2026 06:06:37 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df914024c4sm55838485ad.31.2026.09.29.06.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:06:37 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: robin.clark@oss.qualcomm.com,
	lumag@kernel.org
Cc: abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Joonhoe Kim <26rote@gmail.com>
Subject: [PATCH] drm/msm/dpu: compute the CRTC bandwidth from the state being
 checked
Date: Tue, 29 Sep 2026 22:06:33 +0900
Message-ID: <20260929130633.977-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Sep 2026 12:12:40 +0000
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
_dpu_core_perf_calc_clk() walks the planes the same way; it is not
touched here since I have not seen a wrong clock vote from it.

 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 24 ++++++++++---------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
index fea173e37464..343c41550637 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
@@ -54,24 +54,26 @@ u64 dpu_core_perf_adjusted_mode_clk(u64 mode_clk_rate,
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
+	/*
+	 * The planes of the CRTC state being checked: iterating the committed
+	 * state (drm_atomic_crtc_for_each_plane()) summed nothing when the CRTC
+	 * was being re-enabled (DPMS on, resume), whose old state has no
+	 * planes, and the display ran without a bandwidth vote until the next
+	 * plane update.
+	 */
+	drm_atomic_crtc_state_for_each_plane_state(plane, plane_state, state)
+		crtc_plane_bw += to_dpu_plane_state(plane_state)->plane_fetch_bw;
 
 	bw_factor = perf_cfg->bw_inefficiency_factor;
 	if (bw_factor) {
@@ -131,7 +133,7 @@ static void _dpu_core_perf_calc_crtc(const struct dpu_core_perf *core_perf,
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

