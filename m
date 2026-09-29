Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7AFCA5FC7
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B10CA10F364;
	Wed, 30 Sep 2026 12:13:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kHoRkT4m";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD2C310EEA4
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 13:06:25 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccda24afso2144867a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 06:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790687185; x=1791291985; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8jE/aJ2E98iI2S/CWQodcOrB8SsgSTcF+14ugT3aOH8=;
 b=kHoRkT4mMRV6wB2BnqCYxh/ZZJLKv0zCUrIkbc7F2DkRIBkn+cOIxXBrmMyqzvp+VM
 B+NTtLoUaPFLf3Aonpu/wzE98c+8SOf6gdXfcYMX17K3YIZL5MqwfGadUJuceg8PBU9Z
 A02vDToXD+CWl/aZhcJd0R0kSvvNVzoeqOt4Ok+79cAVGN1QJNPRAkdUD+swfa5UeLHD
 4n6/yF27/jnFaxOLKSivFsULmdBWNLgrsgEs7NRBI6PY0FQlnwSdXhg17ZB+jte6LXMG
 Ep4AMncPG18dI9OB8fDI8BIYiFZSaJvCQCqVeX1pj+5mau1M6rk/VO4DkScLr/CDr4/w
 P37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790687185; x=1791291985;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8jE/aJ2E98iI2S/CWQodcOrB8SsgSTcF+14ugT3aOH8=;
 b=nP/n1aChtp3TlTbWEzCxa/EMDf0FAwxLMuDupAUTQnyEpSMOAevOhsEbWGk23RE60z
 JVRD1gtsvhLrvGSgOxS0E6tip60EBSk6j3P825FSApy8k/X3jQpXCuDhOchs6kNpuSPC
 SYM8rsSEW0nA2oMc8yFOvzKIhnm57mRcNEsU4kCi62PDsEE4VI3gNBireaQBQK4XHDbA
 igIeWHuMWuhXR5MJJM6+qm+CCuwmuy7WQ2HqgGfIFyEfkYRc561GV/tvqYS8CGGWGQoZ
 WICrLvaxPiVjQqaqKh2hKgh91B9ZUKScTgQ8fOa5GXYoWtMLnQHLNSRozhO3SWQ35vw/
 7qng==
X-Forwarded-Encrypted: i=1;
 AKwUvByahKc5WD3SfbBIHauFRcDBbcleCHY/9yJSf8bOUdkoG168GvS++dFgMvRTYAZYcM/4k/jZw5OnFvE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ11dfnJYnH1tVB+Ys8Wuj3IW06DxivBY+bprC2fXLQwVXlRSE0
 Qa01roakU3zCfolOV2Vv3jWBJAeVm9j5fZpuT5+fa1x1Vye2SfNJNeYF
X-Gm-Gg: AYBFou3QXzIKl8CcQlssTYdf0ePj72LA/a/QIArTOe5YrYDIJlkfoouS3JYRP2hFf2u
 BKU6ZUeu2VNXHTfaN1W1oks8pfOTQ4QwVOkKqyDZnS7m0B6rAZUdRzcVnS/GUN3zXcTSCFHuQYX
 wpWCRxqvy6CpPpar0ruTNsdMpCxTASejEIJ1eL4S8w1J1rcbqhL95c/rUT2QO+m2dpDVS0QtawS
 g+quqkUwJhNP30oCnKO7c6cUmBLSM4LUexUf9fq3wp9EhSysW/s0HpDneU6IwGClC54SzDO1htD
 co847ck98wxHmi3aVLVOY7M7Kti4291t+/0iMWdpTxbue2XKSzMu9h7qy0/DmJJSNNHjAPxMMAR
 JLN5UUVsp/wk7bauACvJLe58FqYHBwifth5VT8CZwmJxU4hXIqVTkzhNlC9eCTTo+0STGaSOlEh
 endU2iiNV1FLyHwYn3gD/EZfAnejcTaO65mOWIDImOyRCyvZ4Cn/sNkLMMKyMn2IWY2VRlzrNjl
 psrCpoLXXgRugQ=
X-Received: by 2002:a17:90a:d883:b0:3a0:4146:295b with SMTP id
 98e67ed59e1d1-3a0987255a0mr10559170a91.17.1790687185233; 
 Tue, 29 Sep 2026 06:06:25 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a49858555csm6107928a91.5.2026.09.29.06.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:06:24 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: robin.clark@oss.qualcomm.com,
	lumag@kernel.org
Cc: abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Joonhoe Kim <26rote@gmail.com>
Subject: [PATCH] drm/msm/dpu: stop all video interfaces before cleaning up a
 split encoder
Date: Tue, 29 Sep 2026 22:06:21 +0900
Message-ID: <20260929130621.943-1-26rote@gmail.com>
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

dpu_encoder_virt_atomic_disable() disables the physical encoders one by
one. For a video-mode master, dpu_encoder_phys_vid_disable() stops its
timing engine, waits for the frame to finish and then runs
dpu_encoder_helper_phys_cleanup(), which resets the CTL. With a split
display (two interfaces driven from one CTL, e.g. bonded DSI) that CTL
is shared with the slave, whose timing engine is still running at that
point: the source pipe starts fetching the slave's next frame and is
left stalled half-way through it (on SM8850, SSPP_CMN_STATUS 0x10030
with the fetch and unpack counters frozen, where an idle pipe shows
0x10003).

The stall is cleared by a power collapse of the MDSS core GDSC, which
normally happens between a disable and the next enable, so it goes
unnoticed. When MDSS stays powered across the disable -- a full modeset
within one commit, or another runtime-active user of MDSS such as the
DP controller -- the next enable of the bonded DSI panel scans out
nothing: the DPU keeps committing frames, the layer mixers produce no
output (CRC 0), and the panel shows black with the backlight on. A CTL
reset at enable does not clear it.

Stop the timing engine of every video interface of the encoder before
any of them is cleaned up. The master's existing wait for the frame to
complete then covers both halves.

Seen on a Lenovo Legion Tab Y700 gen 5 (TB323FU, SM8850) with a bonded
DSI video-mode panel (CSOT PP8807HB1-1). It reproduces without any
external display by keeping MDSS runtime-active:

  echo on > /sys/bus/platform/devices/9800000.display-subsystem/power/control

then DPMS off and on from the compositor: black 3/3 before this change.
Every full modeset (e.g. a refresh rate change) went black the same way.
With this change: DPMS off/on 13/13 and full modesets 4/4 show the
picture, and an attached DP display is unaffected. Only tested on this
device.

Fixes: 22cb02bc96ff ("drm/msm/disp/dpu: reset the datapath after timing engine disable")
Assisted-by: LLM
Signed-off-by: Joonhoe Kim <26rote@gmail.com>
---
Saim Shujah's "drm/msm/dpu: clear pending flush state before physical cleanup"
(https://lore.kernel.org/all/20260826182459.1506522-1-saimzst@gmail.com/)
alone does not help here: still black 3/3 with only that change.

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 32 +++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 1f20695f81e3..a14156408126 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1380,6 +1380,35 @@ static void dpu_encoder_virt_atomic_enable(struct drm_encoder *drm_enc,
 	mutex_unlock(&dpu_enc->enc_lock);
 }
 
+/*
+ * Stop the timing engine of every video-mode interface of the encoder before
+ * any of them is cleaned up. With a split display (two interfaces on one CTL,
+ * e.g. bonded DSI) the master's cleanup resets the shared CTL while the
+ * slave's timing engine would still be running; the source pipes then start
+ * fetching the slave's next frame and stall half-way through it. The stall
+ * survives until the MDSS core GDSC is power-collapsed, so when something else
+ * keeps MDSS powered (an active DP controller) the next enable scans out
+ * nothing.
+ */
+static void dpu_encoder_stop_video_timing(struct dpu_encoder_virt *dpu_enc)
+{
+	unsigned long lock_flags;
+	int i;
+
+	for (i = 0; i < dpu_enc->num_phys_encs; i++) {
+		struct dpu_encoder_phys *phys = dpu_enc->phys_encs[i];
+
+		if (phys->intf_mode != INTF_MODE_VIDEO || !phys->hw_intf ||
+		    !phys->hw_intf->ops.enable_timing ||
+		    phys->enable_state == DPU_ENC_DISABLED)
+			continue;
+
+		spin_lock_irqsave(phys->enc_spinlock, lock_flags);
+		phys->hw_intf->ops.enable_timing(phys->hw_intf, 0);
+		spin_unlock_irqrestore(phys->enc_spinlock, lock_flags);
+	}
+}
+
 static void dpu_encoder_virt_atomic_disable(struct drm_encoder *drm_enc,
 					struct drm_atomic_commit *state)
 {
@@ -1412,6 +1441,9 @@ static void dpu_encoder_virt_atomic_disable(struct drm_encoder *drm_enc,
 
 	dpu_encoder_resource_control(drm_enc, DPU_ENC_RC_EVENT_PRE_STOP);
 
+	if (dpu_enc->num_phys_encs > 1)
+		dpu_encoder_stop_video_timing(dpu_enc);
+
 	for (i = 0; i < dpu_enc->num_phys_encs; i++) {
 		struct dpu_encoder_phys *phys = dpu_enc->phys_encs[i];
 

base-commit: 6375e61c01e93e35ee7acd336a689ac1fae4b509
-- 
2.43.0

