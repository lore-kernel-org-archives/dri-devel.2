Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE39CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:36:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20CB310F844;
	Fri,  2 Oct 2026 13:36:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="h/XwX597";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ED9810F844
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 13:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=1HFtPF2q1qHR7zaF3kxQ3S1rKjfrnBUjUtR/8zoN0js=; b=h/XwX597+GkhJaqDyr3Co9lmfF
 qnRwoey0Quxphrbq63M8UVUZ8PPcGZaX+GLw0HAePY2sjYZ9ArACUD4AcwEjtgqZwTTcnV10GTaQl
 /5JB150N6wKrZX9/YKfLfFX1V5wRGJzwKUTe5MFJgxnW2eBU2cPm8k2prhE/NDMlIrn3wPbytddH7
 sYUFD8cZ96Bva5ce7szjayTIAJIcx28ipxp7Lnlz0q1/ZGkjYqt1Kjs4TS9vwkLVrp0PSu7e+hQT2
 GchBEVHItvcrjFEycy32CLHkD0+H6vZKzZphA9lwqdyUwoWBTiADdva9FxEymNLUi6dzNikqz921h
 enau3hpw==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xCdRW-00AceG-Hz; Fri, 02 Oct 2026 15:36:54 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Fri, 02 Oct 2026 10:36:43 -0300
Subject: [PATCH 1/2] drm/vc4: hdmi: Move packet RAM enable to PM runtime
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-vc4-hdmi-packet-ram-fix-v1-1-3d73148096c9@igalia.com>
References: <20261002-vc4-hdmi-packet-ram-fix-v1-0-3d73148096c9@igalia.com>
In-Reply-To: <20261002-vc4-hdmi-packet-ram-fix-v1-0-3d73148096c9@igalia.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5303; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=heiRyucwL45bWdXLrcVrTjVota0LvqwOSaFeryPrgbE=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqv7Nw1/nZP/CmPKAvE92J5rhsNHLgRY8HESMyA
 qN4yTa667KJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCar+zcAAKCRA/8w6Kdoj6
 quJsB/9s4W7v6mU1SQyIDp2ibcOul5DDs7FGWYH7x1nBtm8r3+69LKs5VOvIIhPGtG49caBEAsp
 Uo6BxNmBmjNoYm3kj9mEXIT2Z9Ln+tBZAmzOoI6IHgbMgwyrady3Johwn2fbwV9aSueBLWwlwFF
 YybYxqNVUa2MbFj+cCHRBNkN8ZwDKAxe0eB+fSp1cGqjPL1Iafqb9JXnu0hjZ0MrrrtFLjnWwZi
 WgySnTe1Pm+VM6KsWOUKbtLCm42sHJTY4vlw2UvLAuCvpkOj1dOBfSdh7tHeocKNYHk179DR/5u
 nm2eM59/xCCf57mrpPph1hghVMtmyHGvXp+JAiqXW6q0+2MY
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

Audio can be triggered by the HPD handler and start up before video has
been restored, calling vc4_hdmi_write_infoframe() for the audio infoframe.
vc4_hdmi_write_infoframe() needs Packet RAM to be on to store the
infoframe, however, if the video hasn't been enabled,
vc4_hdmi_encoder_post_crtc_enable() hasn't been called and therefore, the
Packet RAM can be disabled by the time vc4_hdmi_write_infoframe() executes,
causing the following splat:

[  201.570266] ------------[ cut here ]------------
[  201.570293] Packet RAM has to be on to store the packet.
[  201.570367] WARNING: drivers/gpu/drm/vc4/vc4_hdmi.c:683 at vc4_hdmi_write_infoframe+0x404/0x494 [vc4], CPU#0: wireplumber/1606
[...]
[  201.658650] Hardware name: Raspberry Pi 4 Model B Rev 1.5 (DT)
[...]
[  201.758499] Call trace:
[  201.760967]  vc4_hdmi_write_infoframe+0x404/0x494 [vc4] (P)
[  201.766607]  vc4_hdmi_write_audio_infoframe+0x1c/0x28 [vc4]
[  201.772247]  write_infoframe+0xbc/0x140 [drm_display_helper]
[  201.777975]  drm_atomic_helper_connector_hdmi_update_audio_infoframe+0x80/0xdc [drm_display_helper]
[  201.787140]  vc4_hdmi_audio_prepare+0x4ac/0x570 [vc4]
[  201.792252]  drm_connector_hdmi_audio_prepare+0x24/0x30 [drm_display_helper]
[  201.799390]  hdmi_codec_prepare+0x100/0x160 [snd_soc_hdmi_codec]
[  201.805471]  snd_soc_pcm_dai_prepare+0xd4/0x100 [snd_soc_core]
[  201.811375]  __soc_pcm_prepare+0x60/0x12c [snd_soc_core]
[  201.816752]  soc_pcm_prepare+0x34/0x58 [snd_soc_core]
[  201.821863]  snd_pcm_do_prepare+0x70/0x8c [snd_pcm]
[  201.826798]  snd_pcm_action_nonatomic+0xe4/0x174 [snd_pcm]
[  201.832350]  snd_pcm_prepare+0xc8/0xd8 [snd_pcm]
[  201.837021]  snd_pcm_common_ioctl+0x458/0x614 [snd_pcm]
[  201.842308]  snd_pcm_ioctl+0x30/0x48 [snd_pcm]
[  201.846802]  __arm64_sys_ioctl+0x88/0xd8
[  201.850769]  invoke_syscall+0x48/0xf4
[  201.854470]  el0_svc_common+0x80/0xd8
[  201.858171]  do_el0_svc+0x1c/0x28
[  201.861520]  el0_svc+0x3c/0xb0
[  201.864605]  el0t_64_sync_handler+0x68/0xdc
[  201.868834]  el0t_64_sync+0x198/0x19c
[  201.872536] ---[ end trace 0000000000000000 ]---

Considering that Packet RAM enable is essentially a power management
configuration, move its enabling/disabling to the Runtime PM hooks.

Note that post_crtc_disable() still stops all infoframes, but keeps Packet
RAM enabled, leaving it to be disabled by runtime suspend.

Link: https://github.com/raspberrypi/linux/issues/7069
Fixes: b47a72f30768 ("drm/vc4: hdmi: Switch to HDMI connector")
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 17c8635c5afa..d4672aa81d85 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -894,7 +894,7 @@ static void vc4_hdmi_encoder_post_crtc_disable(struct drm_encoder *encoder,
 
 	spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
 
-	HDMI_WRITE(HDMI_RAM_PACKET_CONFIG, 0);
+	HDMI_WRITE(HDMI_RAM_PACKET_CONFIG, VC4_HDMI_RAM_PACKET_ENABLE);
 
 	HDMI_WRITE(HDMI_VID_CTL, HDMI_READ(HDMI_VID_CTL) | VC4_HD_VID_CTL_CLRRGB);
 
@@ -1663,9 +1663,6 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder,
 		WARN_ONCE(ret, "Timeout waiting for "
 			  "VC4_HDMI_SCHEDULER_CONTROL_HDMI_ACTIVE\n");
 	} else {
-		HDMI_WRITE(HDMI_RAM_PACKET_CONFIG,
-			   HDMI_READ(HDMI_RAM_PACKET_CONFIG) &
-			   ~(VC4_HDMI_RAM_PACKET_ENABLE));
 		HDMI_WRITE(HDMI_SCHEDULER_CONTROL,
 			   HDMI_READ(HDMI_SCHEDULER_CONTROL) &
 			   ~VC4_HDMI_SCHEDULER_CONTROL_MODE_HDMI);
@@ -1684,9 +1681,6 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder,
 		WARN_ON(!(HDMI_READ(HDMI_SCHEDULER_CONTROL) &
 			  VC4_HDMI_SCHEDULER_CONTROL_HDMI_ACTIVE));
 
-		HDMI_WRITE(HDMI_RAM_PACKET_CONFIG,
-			   VC4_HDMI_RAM_PACKET_ENABLE);
-
 		spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
 		vc4_hdmi->packet_ram_enabled = true;
 
@@ -3143,6 +3137,11 @@ static int vc5_hdmi_init_resources(struct drm_device *drm,
 static int vc4_hdmi_runtime_suspend(struct device *dev)
 {
 	struct vc4_hdmi *vc4_hdmi = dev_get_drvdata(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
+	HDMI_WRITE(HDMI_RAM_PACKET_CONFIG, 0);
+	spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
 
 	clk_disable_unprepare(vc4_hdmi->audio_clock);
 	clk_disable_unprepare(vc4_hdmi->hsm_clock);
@@ -3153,9 +3152,8 @@ static int vc4_hdmi_runtime_suspend(struct device *dev)
 static int vc4_hdmi_runtime_resume(struct device *dev)
 {
 	struct vc4_hdmi *vc4_hdmi = dev_get_drvdata(dev);
-	unsigned long __maybe_unused flags;
+	unsigned long rate, flags;
 	u32 __maybe_unused value;
-	unsigned long rate;
 	int ret;
 
 	ret = clk_prepare_enable(vc4_hdmi->hsm_clock);
@@ -3201,6 +3199,10 @@ static int vc4_hdmi_runtime_resume(struct device *dev)
 	}
 #endif
 
+	spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
+	HDMI_WRITE(HDMI_RAM_PACKET_CONFIG, VC4_HDMI_RAM_PACKET_ENABLE);
+	spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
+
 	return 0;
 
 err_disable_clk:

-- 
2.55.0

