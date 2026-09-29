Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD96CA5FC6
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BA9110F36F;
	Wed, 30 Sep 2026 12:13:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JBirK6Ni";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1047F10EFD9
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 17:48:29 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc4bdf8abaaso2717449a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 10:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790704108; x=1791308908; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8nvWs5p8QQYBvyiXC8JLMISKpo/nNaLJDjqczyA+R4E=;
 b=JBirK6NimjPloLNZqvtIMZ4tlnz668eg26uLl7B/YTzrewDbEr7PwaMKHE0ZW4zZmL
 oaaQBk6XjVo7uYpnpdivAb6irf8tV1G9EsVhEQ/p1G9fAbNgpoV2rWeGq03Ro4WCrwcL
 oE7R+8z11o0VgrXwUpSC6xcXSGbw+y+LuLAxwhFphaxyfRAWGi9rrTXOQ/np+vSyPxwi
 ZJYzjSyy3ngDeZaCKhFcnQytQPLIAFifXO+pFcoShhS7+AVujvgVyPDKAFTvhmQiJ6u/
 nwQ8BWZlpp6IuKasaOq2IEBKawMBAAmaY+ZGABnowVTM346m94PJ41w/LRpG5gimZCzd
 KDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790704108; x=1791308908;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8nvWs5p8QQYBvyiXC8JLMISKpo/nNaLJDjqczyA+R4E=;
 b=wFyOb3xXkFSggawU54IP0e8HxVj89Q0RkVav7S40mfXrzqLLVcHhIyYRSVVx2UNL6X
 XsD6iQ1CGSNTavg8N8YOeKgarFAFhCzI1vcWRso1ASlvvIc5h2VhT62Lya5xTfMLOPm/
 UwqYqMEurdyMkvELsZF/6nhUtAYX2iJpCLEZ0dAo2ivL9IwZN/wQATWpPgC6D8OYqvFR
 etFOEUOfZeGAlUF1rFVQKJBkbf/g3iIZRwMgOp8Owjpu7VF2xSJTiQIJB3SWxzbNRDTZ
 amdYLWyC1t1nNqt4PE14XYarIpVsmg0TdB+gXUzzPYleSRF9hQKYAkRcuax79a4jU/Z8
 eeWg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjdLKL1kXBKjHz4fEIgJc2dFSO/ZjYTt37F+NXki2oKC+dVdi9c9kvTR332irmgYNlTwnrPvd/aXA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLeA3uQatg2EXxRr5X6YQZHWpMffPR33BOmCfNZ9+JcUu2IVGFu
 XYr4a+NgLqIlBOUCLTqsxDoYim5eJyjXAEvn/BymTLA5iMPzGyy8wAWi
X-Gm-Gg: AYBFou3qJBy2WCEG3/MyxdFCBDDaCafQiLfreu3wQGER1Sk0tNZSXFiTvM/FDa0YrXg
 KAQjVMA9R+87V8cCuAmv1K9ARkA/aP/60poNGKm3x8SY5zw2dgGoKV54rbypOf71U1hb+zvh9TY
 K2VXv+T27uHVxsjkil4oZuuXWY26IRAaPjcvgYigmaCC3qCQJx4MlkSmK8fgEWNv9/CuQJO/Tc2
 Zy7mo3Brb1YKhCQjI3goQLC0LKcoBRaByDZjBYdkvWsq+K6fC5XHOybIwQA8EGPWrhVGBpaeH0P
 d/Yjg4PuuNvdcMQcPcc+PEs4LxFxEMLNq0UmyGbdGMumWIIfci2/LcKF2UXozHjmuKDNDBB5aH2
 o9JPJoRO9wvRu2YgtNL7wTAJX6+pWnWbgUC0eBF/SMkKycuww1aRYizBhkIWVVJUqGU+KCXpAeO
 eDa5q5eg84u4EZK9KKn73Y4Mx1gsp5g1cRCgn37vr4DYNKYVS0Cjl/wi+unohyGUC91zT8t/Yj5
 chyP+y+VAoHbg==
X-Received: by 2002:a17:90b:568b:b0:3a4:ad5c:d48a with SMTP id
 98e67ed59e1d1-3a4c001cfd1mr86892a91.67.1790704108417; 
 Tue, 29 Sep 2026 10:48:28 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4bf9e3b8asm230794a91.7.2026.09.29.10.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 10:48:27 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: robin.clark@oss.qualcomm.com,
	lumag@kernel.org
Cc: abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Joonhoe Kim <26rote@gmail.com>
Subject: [PATCH v2] drm/msm/dpu: stop the slave video interfaces before
 disabling a split encoder
Date: Wed, 30 Sep 2026 02:48:19 +0900
Message-ID: <20260929174819.3855-1-26rote@gmail.com>
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

Stop the timing engines of the slave interfaces before the master is
disabled. The master keeps stopping its own timing engine in
dpu_encoder_phys_vid_disable(), which counts the final vsync before it
waits for it, and its cleanup then finds the slaves idle.

Seen on a Lenovo Legion Tab Y700 gen 5 (TB323FU, SM8850) with a bonded
DSI video-mode panel (CSOT PP8807HB1-1). It reproduces without any
external display by keeping MDSS runtime-active:

  echo on > /sys/bus/platform/devices/9800000.display-subsystem/power/control

then DPMS off and on from the compositor: black 3/3 before this change.
Every full modeset (e.g. a refresh rate change) went black the same way.
With this change: DPMS off/on 15/15 show the picture, with no "wait
disable failed" timeouts. Only tested on this device.

Fixes: 22cb02bc96ff ("drm/msm/disp/dpu: reset the datapath after timing engine disable")
Assisted-by: LLM
Signed-off-by: Joonhoe Kim <26rote@gmail.com>
---
Changes in v2:
- Stop only the slave interfaces up front and leave the master to
  dpu_encoder_phys_vid_disable(), which counts the final vsync before it
  stops the timing engine and waits for it; v1 stopped the master too,
  so that vsync could arrive before it was counted and the wait could
  time out (Sashiko review). Subject updated to match.
- Link to v1: https://lore.kernel.org/all/20260929130621.943-1-26rote@gmail.com/

Saim Shujah's "drm/msm/dpu: clear pending flush state before physical cleanup"
(https://lore.kernel.org/all/20260826182459.1506522-1-saimzst@gmail.com/)
alone does not help here: still black 3/3 with only that change.

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 33 +++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 1f20695f81e3..2f8b6204c93e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1380,6 +1380,36 @@ static void dpu_encoder_virt_atomic_enable(struct drm_encoder *drm_enc,
 	mutex_unlock(&dpu_enc->enc_lock);
 }
 
+/*
+ * Stop the timing engines of the slave video interfaces of a split display
+ * (two interfaces on one CTL, e.g. bonded DSI) before the master is disabled.
+ * The master's cleanup resets the shared CTL; with a slave timing engine still
+ * running, the source pipes start fetching the slave's next frame and stall
+ * half-way through it. The stall survives until the MDSS core GDSC is
+ * power-collapsed, so when MDSS stays powered the next enable scans out
+ * nothing. The master itself is stopped by its own disable path, which counts
+ * the final vsync it waits for.
+ */
+static void dpu_encoder_stop_slave_timing(struct dpu_encoder_virt *dpu_enc)
+{
+	unsigned long lock_flags;
+	int i;
+
+	for (i = 0; i < dpu_enc->num_phys_encs; i++) {
+		struct dpu_encoder_phys *phys = dpu_enc->phys_encs[i];
+
+		if (phys->split_role != ENC_ROLE_SLAVE ||
+		    phys->intf_mode != INTF_MODE_VIDEO || !phys->hw_intf ||
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
@@ -1412,6 +1442,9 @@ static void dpu_encoder_virt_atomic_disable(struct drm_encoder *drm_enc,
 
 	dpu_encoder_resource_control(drm_enc, DPU_ENC_RC_EVENT_PRE_STOP);
 
+	if (dpu_enc->num_phys_encs > 1)
+		dpu_encoder_stop_slave_timing(dpu_enc);
+
 	for (i = 0; i < dpu_enc->num_phys_encs; i++) {
 		struct dpu_encoder_phys *phys = dpu_enc->phys_encs[i];
 

base-commit: 6375e61c01e93e35ee7acd336a689ac1fae4b509
-- 
2.43.0

