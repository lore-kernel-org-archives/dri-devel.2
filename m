Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6C2C5DF9C
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 00:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 451A710E315;
	Tue, 25 Aug 2026 00:14:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gqFpJXEM";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CAB110E315
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 00:14:51 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47fd66a094eso1187995f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 17:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787616890; x=1788221690; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x04IiTfhYJXNOaOqTfXwDySQqeqgSixvxmzpY3etBHo=;
 b=gqFpJXEMcOJbLuNRsYHM9ztg2KOdDwiGWlow0FyC9pX78ur8ORfjBgD/A6BJluqK5K
 wzkuUzJ1d/EKBG+oI3p1CrimbCdZmg8fmGktzqIvwB/x8x0BQvHsZiTkQummL2oxnX1l
 wV1PZYA5ltbwksySrepWEOt/YR1yk2yFtn+G6557fQTPjwsml9Shvo8a1+K+GEokn9lB
 dHXtbr+fwKWQGKWJHdk+vZWa4tR389it+SoFdXLqlNZphaCx/FNIKN9U0QMV7sjAmYr3
 Zt5rKlvBb4TOxFJlOaJjkFrECwIat9HXbh2s8vQlg2g4jNdkD3BquZnx7BSbFF5fOBsG
 WyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787616890; x=1788221690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=x04IiTfhYJXNOaOqTfXwDySQqeqgSixvxmzpY3etBHo=;
 b=Hls7VTBSd4uqtDbCCtl393BR7YNraRJrQ7kR7APs1Vw40VCFZB2nT9JIQVTMe60QfB
 0EKoV0zKXisfFRXTVOwT+Hr2Tz5p5fHu2ZavMnatFEjNZfT8+cqjIjqI7QzDKi+nKIMY
 RZqm2XNLHBkMk8WYiaVGHm22gAsmvCjB7HLHlXEEkVgoB+ivlpiLNpmjboaPZcRqavR0
 CX3Xem0yocDzxARwsYdgnWjM9KrDBA28A3vHSHRGdeN5qNqsYJZx0LnvisppOe0kzWzu
 eayQI1kB09gtehd5KPFEOwUpnRpHlkAM0Ix9oNTH3mdxvgw6t5/edw/BWQ65OaYc2Ji3
 MQzw==
X-Gm-Message-State: AFuF++lTSVBdVEUSaA+82LxDr07+L1cKGgkVNfiWJBV+UNv6GDxBGjNb
 eCPGYmE0mpVswGoBw4IZB4vzsVLMwlYH/95Qop/AkkjBO6ht+KpWhAbl
X-Gm-Gg: AR+sD1280QDEL7vOu8X2A/0mq4F+PcByeCuknd0IKq4r4QQhcztJu4xS4QYz/quoWKq
 VPsLqpL5cv3Hry3yPoSKTTnm0G591VR5+YonE6mrfl0Q88ZLfNPFRSAicEw1LCZdfoULyrNKyiv
 N5oTwVYLM43qFnHZzsgnnFbB6ys68DLI9XR39i8sPIj2riIiCJcvVtxqrJUMuaKnhn7lLIUnVgY
 JraBdJHVBJmr9Ybk57kKz5OEgn95C2oMjuecft+kakv9d2JoyhqBM/yNj25l0yoikovr5S6niDW
 a9OL5ZhqM0+Gy+elB3SY6YiCls8/d3PHbOTwBHuRyDNJ8yoL/gyQoIieqq7ZxWrA24u+igaVCpS
 w2JEQcpWly1ppHuYi9iooU+HvpVAoZNaLe/bNvU0v8skEYOECZzAT4uyvuBqKe/eVqa+ezCjSMU
 5H2c6/yOLGtcOMZhaXbzsByje0SqeABKkrIBhhkb2jlWVdRWa8bEJNrIVii1mKoGDF5hSISetKC
 vEUdg==
X-Received: by 2002:a05:6000:2309:b0:47f:9447:62bf with SMTP id
 ffacd0b85a97d-482c0b54855mr37921273f8f.2.1787616889861; 
 Mon, 24 Aug 2026 17:14:49 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b78ebfsm9770676f8f.12.2026.08.24.17.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 17:14:48 -0700 (PDT)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Mary Guillemard <mary@mary.zone>,
 nouveau@lists.freedesktop.org,
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v3 02/10] drm/nouveau/disp: move the GSP HDMI GCP AVMute write
 to engine/disp
Date: Tue, 25 Aug 2026 04:14:00 +0400
Message-ID: <20260825001408.14219-3-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825001408.14219-1-mohamedahmedegypt2001@gmail.com>
References: <20260825001408.14219-1-mohamedahmedegypt2001@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

r535_sor_hdmi_audio() pairs two RM controls (a SET_OD_PACKET carrying
the same General Control Packet, and the audio mute-stream toggle)
with a direct write of the GCP AVMute bit through the SF GCP unit.
The controls are RM and stay, but the direct write is register
programming and moves next to the other per-chip display code as
tu102_sor_hdmi_gcp(). No functional change.

Fixes: 6cc6e08d4542 ("drm/nouveau/kms: add support for GB20x")
Cc: stable@vger.kernel.org
Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h    |  1 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c  | 15 +++++++++++++++
 .../drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c    |  9 +--------
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h b/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h
index 3ba04bead2f9..5d682a774f2d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h
@@ -194,6 +194,7 @@ void gv100_sor_dp_audio_sym(struct nvkm_ior *, int, u16, u32);
 void gv100_sor_dp_watermark(struct nvkm_ior *, int, u8);
 extern const struct nvkm_ior_func_hda gv100_sor_hda;
 
+void tu102_sor_hdmi_gcp(struct nvkm_ior *, int, bool);
 void tu102_sor_dp_vcpi(struct nvkm_ior *, int, u8, u8, u16, u16);
 
 int nv50_pior_cnt(struct nvkm_disp *, unsigned long *);
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
index 7b70b466fa36..6cfd52c9056f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
@@ -30,6 +30,21 @@
 
 #include <nvif/class.h>
 
+/* General Control Packet: bracket an audio enable/disable with AVMute
+ * through the legacy GCP SF unit. Used by the GSP-RM path, which sends the
+ * equivalent packet via RM as well but keeps the direct write in sync.
+ */
+void
+tu102_sor_hdmi_gcp(struct nvkm_ior *sor, int head, bool enable)
+{
+	struct nvkm_device *device = sor->disp->engine.subdev.device;
+	const u32 hdmi = head * 0x400;
+
+	nvkm_mask(device, 0x6f00c0 + hdmi, 0x00000001, 0x00000000);
+	nvkm_wr32(device, 0x6f00cc + hdmi, !enable ? 0x00000001 : 0x00000010);
+	nvkm_mask(device, 0x6f00c0 + hdmi, 0x00000001, 0x00000001);
+}
+
 void
 tu102_sor_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8 slot_nr, u16 pbn, u16 aligned)
 {
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index 8e57bb6519e5..cd4451e62512 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -545,16 +545,9 @@ r535_sor_hdmi_ctrl_audio(struct nvkm_outp *outp, bool enable)
 static void
 r535_sor_hdmi_audio(struct nvkm_ior *sor, int head, bool enable)
 {
-	struct nvkm_device *device = sor->disp->engine.subdev.device;
-	const u32 hdmi = head * 0x400;
-
 	r535_sor_hdmi_ctrl_audio(sor->asy.outp, enable);
 	r535_sor_hdmi_ctrl_audio_mute(sor->asy.outp, !enable);
-
-	/* General Control (GCP). */
-	nvkm_mask(device, 0x6f00c0 + hdmi, 0x00000001, 0x00000000);
-	nvkm_wr32(device, 0x6f00cc + hdmi, !enable ? 0x00000001 : 0x00000010);
-	nvkm_mask(device, 0x6f00c0 + hdmi, 0x00000001, 0x00000001);
+	tu102_sor_hdmi_gcp(sor, head, enable);
 }
 
 static void
-- 
2.55.0

