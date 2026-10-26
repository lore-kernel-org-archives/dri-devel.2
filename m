Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E0D606A320
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVZlARwq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DE7B10F141;
	Mon, 26 Oct 2026 20:26:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CE5010F132;
 Mon, 26 Oct 2026 20:26:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3D78E601EF;
 Mon, 26 Oct 2026 20:26:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793046365;
 b=LaswMTUwtPHZuz3YAX2905GQ99iuhDIXPyZontZxeN8B3o4rPfqj7jgmbN73mqj6PkYg
 chsH1tzqQ9pHCcRCCUXSMRq70h6iiaKOixFOry3gsyjb6ePJmqLf3Ewsza1u9y4bbtLHH
 RAMY77pPMhXqT7u/eMsxgtRjwcLIJAHdpp+g0cfjVpwJQLWVAsjWdb9kmsSGnmsLv172u
 52vUHRcyna1YM2BHftq+FPHIfYfZy/WpVjaIcsKKu6cPuQh5me+KoglYBo22wxJYsywWj
 A/khg4Wr6mvwXFcCdLD2PgMgz2m4kZyNyiJ4bRGFmNqVLwqkbdlgpAk7MPc7d5HA8vg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793046365;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=9kV3mpo9IDcWJzdmAM3TrfjqAu96cGtkJuIv3p/bUaE=;
 b=wHe0WVf7WbbPI2psYJFE2H+NWKgUlooUg5cPWFMPKefTdzVbVucQIKLfpD8TV+F5iDbH
 1ur/zvErtIQdogxoExuNSSsdNcuuNIt5ghu+UXO3eBLG2BhWBmKnRD2d/7a0fdzMnvsV5
 a21RxM3J3q+yNWe1epRIb7C4TjamOF2OLmgBmaLGyhWKPiuMi43JsmUGfQWtVTVDco/Nh
 0cNtoTWm5z3+ZbX+ReskNxHoRQv3ZmlFJnhIp8AuACl66PQN/2Ww7plChEpYEHtx5y5m6
 t4OfSN8E0OKqLOqA0QKPaCTRCJibthVToJYhwoptwBKe0LZGOYVHGElw7Km6nUhkoCA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 67F6F1F01825;
 Mon, 26 Oct 2026 20:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793046365;
 bh=9kV3mpo9IDcWJzdmAM3TrfjqAu96cGtkJuIv3p/bUaE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=HVZlARwqmxS83q6l7ZbRUfFbZtjYy5PeP39XMVOS4eUF0TB/VQTba+iwiqlMSs5LH
 Q3DLKeYxtD/SZHphJK5mhv+3XPXpy4rGflgAPJY7CqLNwAe8I6dogeweRTCTxg8VDH
 VuW1mdmd5yJYM7tdE9ucemUgrSJbu1M10mmkGH3np4gF4HhJKjkKrfFoVoeGJ/QJT4
 cy0xccoQ9bhiNwzo2K6NpBbwbG6tqKfyw4ZJzv883j2t3sc9TMNthc44iKdQvadFjb
 UPvD1bzd3EqnpxbaOVE4lrcbdgP17zIVLWS1YKAMtou1dHK7fB7gc4aNaaweDqZfMG
 A1kdBrpOUwwWA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id C401A44E8A;
 Mon, 26 Oct 2026 20:26:04 +0000 (UTC)
From: Xi Zhang via B4 Relay <devnull+xz.ca.cn.gmail.com@kernel.org>
Date: Mon, 26 Oct 2026 17:25:42 -0300
Subject: [PATCH v2 1/6] drm/msm/dpu: reset unassigned resource slots to
 NULL on topology update
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261026-msm-dpu-res-clean-v2-1-3d864435186e@gmail.com>
References: <20261026-msm-dpu-res-clean-v2-0-3d864435186e@gmail.com>
In-Reply-To: <20261026-msm-dpu-res-clean-v2-0-3d864435186e@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Xi Zhang <xz.ca.cn@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793046364; l=2413;
 i=xz.ca.cn@gmail.com; s=20261026; h=from:subject:message-id;
 bh=XV5yIGRicisWHnZm/blBrd+eV6OtBhD/12tGnVobzAE=;
 b=PC8rCKcVBdPqI+8YugF/JK3f2ZJoK/+mL56ZMTYea2y7srn3rB74fUnnoW9F8vEyXVAqrCM8q
 VE1DcpN1W9pDxN4Xt9VuTInL1zi5OYgy7EqvaOEC6pTnu6kDrmKZzJQ
X-Developer-Key: i=xz.ca.cn@gmail.com; a=ed25519;
 pk=aRUll5L3eJbwG8Y4BO9uySKGzm+Uy+Ccei9prnRVZRs=
X-Endpoint-Received: by B4 Relay for xz.ca.cn@gmail.com/20261026 with
 auth_id=1328
X-Original-From: Xi Zhang <xz.ca.cn@gmail.com>
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
Reply-To: xz.ca.cn@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Xi Zhang <xz.ca.cn@gmail.com>

While this is not currently the case, it may be possible that topology
for cwb and dsc resource requirements change between mode set in the
future.

e.g. when dsc support is added to DisplayPort, dsc may be optionally
enabled and disabled between different modes due to
bandwidth requirements.

Set unassigned resource slots to NULL on topology update to avoid
issues in the future. It's good practice to do so anyway.

Signed-off-by: Xi Zhang <xz.ca.cn@gmail.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 0a6be69a3e83..8d2b4d2726f2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1205,9 +1205,13 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 						       ARRAY_SIZE(hw_pp));
 	}
 
-	for (i = 0; i < num_cwb; i++) {
-		dpu_enc->hw_cwb[i] = to_dpu_hw_cwb(hw_cwb[i]);
-		cwb_mask |= BIT(dpu_enc->hw_cwb[i]->idx - CWB_0);
+	for (i = 0; i < ARRAY_SIZE(dpu_enc->hw_cwb); i++) {
+		if (i < num_cwb) {
+			dpu_enc->hw_cwb[i] = to_dpu_hw_cwb(hw_cwb[i]);
+			cwb_mask |= BIT(dpu_enc->hw_cwb[i]->idx - CWB_0);
+		} else {
+			dpu_enc->hw_cwb[i] = NULL;
+		}
 	}
 
 	dpu_enc->cwb_mask = cwb_mask;
@@ -1215,16 +1219,20 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 	num_ctl = dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
 		drm_enc->crtc, DPU_HW_BLK_CTL, hw_ctl, ARRAY_SIZE(hw_ctl));
 
-	for (i = 0; i < MAX_CHANNELS_PER_ENC; i++)
+	for (i = 0; i < ARRAY_SIZE(dpu_enc->hw_pp); i++)
 		dpu_enc->hw_pp[i] = i < num_pp ? to_dpu_hw_pingpong(hw_pp[i])
 						: NULL;
 
 	num_dsc = dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
 						drm_enc->crtc, DPU_HW_BLK_DSC,
 						hw_dsc, ARRAY_SIZE(hw_dsc));
-	for (i = 0; i < num_dsc; i++) {
-		dpu_enc->hw_dsc[i] = to_dpu_hw_dsc(hw_dsc[i]);
-		dsc_mask |= BIT(dpu_enc->hw_dsc[i]->idx - DSC_0);
+	for (i = 0; i < ARRAY_SIZE(dpu_enc->hw_dsc); i++) {
+		if (i < num_dsc) {
+			dpu_enc->hw_dsc[i] = to_dpu_hw_dsc(hw_dsc[i]);
+			dsc_mask |= BIT(dpu_enc->hw_dsc[i]->idx - DSC_0);
+		} else {
+			dpu_enc->hw_dsc[i] = NULL;
+		}
 	}
 
 	dpu_enc->dsc_mask = dsc_mask;

-- 
2.55.0


