Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD737CA5FF5
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8578510EAEC;
	Sun,  4 Oct 2026 17:19:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="izZpnLAQ";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 328E210E38E
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 13:07:17 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2dd77300825so40935635ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 06:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790946437; x=1791551237; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UZx5nLRdpWK5z7yKqeHvCYGSh31itlWKNzYPXNN5hIA=;
 b=izZpnLAQgfGikR8VSOZqZGECuta0WoU1EOyGRw6EAWZWqTv9jrxX5lVWDBY4szAvX0
 4Xm3VZ2q8ERDYJde2uHiOwHs0a5RbyrL5D1gA8e1R/mWjsxP1rKhJuXqF2sTluktRh7e
 Y5/uyn0dRnHgJU17hRXRXlE2aoc7WpmGiJSr6voeHKFrJZu5kO7WmVxxLuJFrXuOWqVH
 t7ny+MEq0TaZU1C2S+AFu8Y7mn3ng7I6UHjvA9lBik0zUzMonZpP19Y9Gk5s6056IrV7
 4oVRYzOnqPuK9hhxG8k6GLJ4cj1LSS7tvNtuCbtQv9RrSNrSXRXGerWOVs69t8c0eqTP
 4cGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790946437; x=1791551237;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UZx5nLRdpWK5z7yKqeHvCYGSh31itlWKNzYPXNN5hIA=;
 b=FnY78E5HMRxSOR3uB4z+FN1D4d4jupJ1H0HABvMdmLVi1vzDXLL/bc/uXsVYI7Bzwp
 +QyH/zyLOmxtCli44qOGAf6SAT1DOsZunuG1S0yeCt+FGfOL61/6lncEQ7FjHFZM+wBc
 cZS6M9n1jLjsuAcmDsWAkDFIy84mip4BCKsQEBxRFsEytUUn3SmBwbBwMhipkyNaCjcR
 Ax3gXVaCg38kmbp4AskfNH287RrzGBa9ZpPISH8K3ihtHJKXcRts9UagtLFIsMx5r/hg
 f3NwNLFuJjGp8AxfrZ/9AppZ7cmjldqeDt6CbMyPyDXHRWbdVj3J+J+DAevBgHDVCJpL
 aEFA==
X-Forwarded-Encrypted: i=1;
 AKwUvBylJyryaYKG5AcEBX/J0qgyQQe6a9ODPoZVwyWWpVPDw4yxjg8Tvba8NScZjxs6XQ8R+v5H7NIYnII=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLERgBAs7XN+vhPnsiicoN1k957zHcViVCSWeDOp4gY2S0yeKzy
 UEKz4WfqHUld1WlQjn5XsrQx/vdgsNqWiPGfCjUlnVFVKPdM8KEr/0dt
X-Gm-Gg: AYBFou3IfVoWnaHs4xR/XxfACg45NCmUQwg8suTM8jV9PV1uNz4GsLEYGxywgzGVL/s
 wSCo+TUaE+lUW4kYmQgKc0VZtZL2dq3a4YsOtawTzfNeBP/ndsZ78ffgHG1a5rUmdKkpp/f9uNe
 4lYKH+OAe7H4puR3AoeTr/oi84PFCKtmhmhl9rS3G8guA4QW/gWE70C4oQb2k5+oxBqMzOnFjub
 Bdkih52a3nBlPQjqZ9nIjlOjmNn1F0j72HryVnnWMxOTIRa5D0qsGWiL0PQuM/fXRzPlaE6Tn8X
 kmsYFYSv4axIgzv0yYLFPzx6irPTOTiCiRvqd6mCnNA6Fk84L/mI6j2ovnQ5pShUqfh5fGQUc9P
 3vMVYWJv4yNmD3m3yGA7GXvKi/bHAuAlShLK2GNtaE1nqUPys4ehUtz4bb2cnnIkHLFku39mfDx
 6abadZbLQ1j24tp2uYrQXSPDKDTO7TuZrb3JmZDTwdwT4Xcl9TiKTIwlNcCj7tLM8pyr6YZ3ZDg
 UAMdBuMX1syfw==
X-Received: by 2002:a17:903:230a:b0:2dd:c100:a5d7 with SMTP id
 d9443c01a7336-2e49b655fdemr22787685ad.43.1790946436498; 
 Fri, 02 Oct 2026 06:07:16 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f6f650fsm7481065ad.58.2026.10.02.06.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 06:07:15 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: robin.clark@oss.qualcomm.com,
	lumag@kernel.org
Cc: abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Joonhoe Kim <26rote@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v3] drm/msm/dpu: disable the slave encoder before the master
Date: Fri,  2 Oct 2026 22:07:12 +0900
Message-ID: <20261002130712.50612-1-26rote@gmail.com>
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

dpu_encoder_virt_atomic_disable() disables the physical encoders in
phys_encs[] order, i.e. the master first. With a split display (two
interfaces on one CTL, e.g. bonded DSI) the master's
dpu_encoder_helper_phys_cleanup() then resets the shared CTL while the
slave's timing engine is still running, and the source pipe is left
stalled half-way through the slave's next frame.

A power collapse of the MDSS core GDSC clears the stall, so it normally
goes unnoticed. When MDSS stays powered across the disable (a full
modeset, or an active DP controller), the next enable scans out
nothing: black screen with the backlight on.

Disable the slave before the master, as atomic_enable() enables them in
that order. The slave's cleanup still resets the CTL while the master is
running, but the last reset, from the master's cleanup, now happens with
both timing engines stopped.

Tested on a Lenovo Legion Tab Y700 gen 5 (SM8850, bonded DSI video-mode
panel) with MDSS kept active:

  echo on > /sys/bus/platform/devices/9800000.display-subsystem/power/control

DPMS off/on: black 10/10 before, picture 10/10 after. Full modesets were
not retested with this version. Only tested on this device.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Fixes: 22cb02bc96ff ("drm/msm/disp/dpu: reset the datapath after timing engine disable")
Assisted-by: LLM
Signed-off-by: Joonhoe Kim <26rote@gmail.com>
---
Changes in v3:
- Disable the slave before the master instead of stopping the slave
  timing engines in a helper; drop the comment. Subject updated. [Dmitry]
- Link to v2: https://lore.kernel.org/all/20260929174819.3855-1-26rote@gmail.com/

Changes in v2:
- Stop only the slave interfaces up front. Subject updated. [sashiko-bot]
- Link to v1: https://lore.kernel.org/all/20260929130621.943-1-26rote@gmail.com/

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 1f20695f81e3..0a6be69a3e83 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1386,7 +1386,6 @@ static void dpu_encoder_virt_atomic_disable(struct drm_encoder *drm_enc,
 	struct dpu_encoder_virt *dpu_enc = NULL;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_state = NULL;
-	int i = 0;
 
 	dpu_enc = to_dpu_encoder_virt(drm_enc);
 	DPU_DEBUG_ENC(dpu_enc, "\n");
@@ -1412,12 +1411,11 @@ static void dpu_encoder_virt_atomic_disable(struct drm_encoder *drm_enc,
 
 	dpu_encoder_resource_control(drm_enc, DPU_ENC_RC_EVENT_PRE_STOP);
 
-	for (i = 0; i < dpu_enc->num_phys_encs; i++) {
-		struct dpu_encoder_phys *phys = dpu_enc->phys_encs[i];
+	if (dpu_enc->cur_slave && dpu_enc->cur_slave->ops.disable)
+		dpu_enc->cur_slave->ops.disable(dpu_enc->cur_slave);
 
-		if (phys->ops.disable)
-			phys->ops.disable(phys);
-	}
+	if (dpu_enc->cur_master && dpu_enc->cur_master->ops.disable)
+		dpu_enc->cur_master->ops.disable(dpu_enc->cur_master);
 
 
 	/* after phys waits for frame-done, should be no more frames pending */

base-commit: 6375e61c01e93e35ee7acd336a689ac1fae4b509
-- 
2.43.0

