Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD80C5DF9C
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 00:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F03210E5CB;
	Tue, 25 Aug 2026 00:15:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rwr4s+Xu";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C962810E5CB
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 00:15:28 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47f7872abb6so2225096f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 17:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787616927; x=1788221727; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2+P/vDouc9UoeUwar0MlBIfz+YKIXPqdUfu9owZSH9I=;
 b=Rwr4s+Xu57QXnMZH3wRVJypO8DQ3/HPyCSMZMFqDQpB0P91iBszlFSAfbKQaZQWpqB
 89n/8NOg/X6aYHjrDg4OnkDi+OgO1OYom1Do27D1DaPUtQnpfcxVFgI0eGH052aeNQLE
 Ks0FOsoxlAuMYNWRABKUJKBMXRsfg+SaK+Q85vUIEiheZJOaOK0gMQSnaHNbZ76KV0jM
 Rq214pbJQor5xyb1WW139ZQqWqGlHXvurmbEJvsExZ/Jk5nA9IqqSl5CDj+oF54ieJR3
 r/wErcx9VnNXk2jb8b0JfsrvAxiiWgsMoJqQw0rztcb+DgZBUf6aGRJFtCdm8rCgP2Ra
 HpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787616927; x=1788221727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2+P/vDouc9UoeUwar0MlBIfz+YKIXPqdUfu9owZSH9I=;
 b=XRAXgYAK85iD1OnvFdLFrs4L075bM5+A6S22GFQdrTdKfRXv3Dw6cpbuwnHw0yglwp
 kd3jAwVR2ZDTSZ6h6EKb0mn2L6CSoRJ0Bobu0gHRW6ziDjqM/2zhsuM+a69L38LAU2yC
 mhh8bivIlScd7dQjXD+Nce2aspgJzMKH3gHQb6UiGtZut/8gHD6gNnO+4SsWjm6dgAaI
 p8teDov4hCNgP6ZpA7xb9kgtBP550gVK/Z82DZDpJuWFCZpRu9U22z9DesBGLeT6JCV3
 Ij54n868xKn2mimejlr7g0tG1U8kpuOB7TfTOeZGeXaMWF3uAsw2pMuH2nQkzUFOuoAJ
 lUFA==
X-Gm-Message-State: AFuF++mb6ehg/vjSnhvpcJFb8K5R+ezVJ2k0r1q75SOdS3YztMHeKQ+0
 7cHD9USllbT4DygPjah9euKq3ZFOUuRffMX2w3DMCq2hvby61uEc935P
X-Gm-Gg: AR+sD11AcjFo7dODabg9phvKjG+PZYMDRctVQuPSXDHJ3+AFWihTRsn7bcF5K3LNgZF
 v4ENgf9g4qEpf9LTk6P5pDr1amcCz3EsE6Gckbwsj3IhWUs9/mlp+MF6wf8LUTK3A28qmRn7qfR
 pJApH3PA4kSgA7AMTIY0ZTPW/HXHrJQF3ZqVlOfmbdRH4HFZszHmDnn5vMLaNo4+ba+2aCNzbEv
 ZwH36cQIyRjMaj8X1DUdz6Sy/yTQYicqi6ju+9IuymEgKoiTp+5ViW63x9xW3R88eEhCAvF7f+Y
 lfGInTg82gUoqzYPsT8vjdPXFeowtEEUs5raZDcKeunoDWmEN0idqJCpZZMNiMGZwFxrNtdINxB
 X2rU3LFFZJ/JL8/iv3/YASic6DDf29GzF0kccSzxxUdnhjpN3t0z7yhJe1BLaGvusTrpZhP9szw
 n2NvoYc38vZu6zPqiYxtdmoo4WhYIf6mQwGwNsF5JZGI3kQ2jgo/cm5MWHbCTxCwtrMaE=
X-Received: by 2002:a05:6000:2204:b0:481:5167:d526 with SMTP id
 ffacd0b85a97d-482d9ee1e7cmr2945347f8f.6.1787616927138; 
 Mon, 24 Aug 2026 17:15:27 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b78ebfsm9770676f8f.12.2026.08.24.17.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 17:15:25 -0700 (PDT)
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
Subject: [PATCH v3 07/10] drm/nouveau/disp: fix head state readback on GB20x
Date: Tue, 25 Aug 2026 04:14:05 +0400
Message-ID: <20260825001408.14219-8-mohamedahmedegypt2001@gmail.com>
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

The GSP path reads armed head state and the RG scanout position through
gv100_head_state() and gv100_head_rgpos() on every generation.
gv100_head_state() reads the core channel's state mirror at a 0x400
per-head stride, which NVD5.0 (GB20x) doubled. Per NVIDIA's published
CA7D class header every HEAD_SET method sits at 0x2000 + head * 0x800,
while the mirror bases are unchanged (assembly at 0x680000, armed at
+0x8000, per OpenRM's v03_00 channel-user-base HAL which is still used on
DISPv0502).

Add gb202_head_state(), the same readback at the 0x800 stride, and a
gb202_gsp_head table to supply it.
gv100_head_rgpos() is kept. The RG registers keep their per-head 0x800
stride on NVD5.0, and OpenRM's kdispReadRgLineCountAndFrameCount_v03_00
still reads NV_PDISP_RG_DPCA on DISPv0502.

Fixes: 6cc6e08d4542 ("drm/nouveau/kms: add support for GB20x")
Cc: stable@vger.kernel.org
Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
 .../gpu/drm/nouveau/nvkm/engine/disp/gb202.c  | 51 ++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
index face801af080..765c42039a47 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
@@ -83,6 +83,55 @@ gb202_sor_hdmi_gcp(struct nvkm_ior *sor, int head, bool enable)
 	nvkm_mask(device, 0x6f0040 + hdmi, 0x00000001, 0x00000001);
 }
 
+/* Same core-channel state mirror as gv100_head_state() (assembly at 0x680000,
+ * armed at +0x8000, per-head method offsets unchanged), but NVD5.0 spaces
+ * heads 0x800 apart (see NVCA7D_HEAD_SET_*(a) in clca7d.h).
+ */
+static void
+gb202_head_state(struct nvkm_head *head, struct nvkm_head_state *state)
+{
+	struct nvkm_device *device = head->disp->engine.subdev.device;
+	const u32 hoff = (state == &head->arm) * 0x8000 + head->id * 0x800;
+	u32 data;
+
+	data = nvkm_rd32(device, 0x682064 + hoff);
+	state->vtotal = (data & 0xffff0000) >> 16;
+	state->htotal = (data & 0x0000ffff);
+	data = nvkm_rd32(device, 0x682068 + hoff);
+	state->vsynce = (data & 0xffff0000) >> 16;
+	state->hsynce = (data & 0x0000ffff);
+	data = nvkm_rd32(device, 0x68206c + hoff);
+	state->vblanke = (data & 0xffff0000) >> 16;
+	state->hblanke = (data & 0x0000ffff);
+	data = nvkm_rd32(device, 0x682070 + hoff);
+	state->vblanks = (data & 0xffff0000) >> 16;
+	state->hblanks = (data & 0x0000ffff);
+	/* Bit 31 is ADJ1000DIV1001, not a HERTZ bit. We don't have enough bits
+	 * to add the full clock in hz on Blackwell (35 bits), but state->hz
+	 * is unused and obsolete under GSP so this is fine.
+	 */
+	state->hz = nvkm_rd32(device, 0x68200c + hoff) & 0x7fffffff;
+
+	data = nvkm_rd32(device, 0x682004 + hoff);
+	switch ((data & 0x000000f0) >> 4) {
+	case 5: state->or.depth = 30; break;
+	case 4: state->or.depth = 24; break;
+	case 1: state->or.depth = 18; break;
+	default:
+		state->or.depth = 18;
+		WARN_ON(1);
+		break;
+	}
+}
+
+static const struct nvkm_head_func
+gb202_gsp_head = {
+	.state = gb202_head_state,
+	.rgpos = gv100_head_rgpos,
+	.vblank_get = tu102_head_vblank_get,
+	.vblank_put = tu102_head_vblank_put,
+};
+
 /* GB20x is GSP-only. This table supplies the register programming the
  * GSP-RM display path needs from the chip.
  */
@@ -91,7 +140,7 @@ gb202_gsp_disp = {
 	.uevent = &gv100_disp_chan_uevent,
 	.ramht_size = 0x2000,
 	.gsp.intr = tu102_disp_intr,
-	.gsp.head = &tu102_gsp_head,
+	.gsp.head = &gb202_gsp_head,
 	.gsp.hdmi_gcp = gb202_sor_hdmi_gcp,
 	/* The legacy AVI unit is unchanged on GB20x. */
 	.gsp.hdmi_infoframe_avi = gv100_sor_hdmi_infoframe_avi,
-- 
2.55.0

