Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFE7C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:50:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A64610F119;
	Thu, 20 Aug 2026 16:50:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="loIKSPy4";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C85310F117
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 16:50:53 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so394725e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787244652; x=1787849452; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YE7qcApQ+Obk30eKV1C+kC93MwiUbUNOYm/DV2i4pE0=;
 b=loIKSPy40dyLkiqjl9+er/uz+O55y0n429vwjCdHEMVh6cU0IxVMK4AYcp/K8AIo9Z
 n0mXk5kGesUdBwSffYKYDQ6g2ME1J3/irPbMqKVKhtDhAqDsY3q5PwfSLvB+udntXffl
 uXIXeIQ0NYodh+SjNFZDYbXFRILL9eYc0Wfev6Ed5eCClkb6tZYqK7RDCAHWuBlPM1eE
 296CBnNeN25pe9BeaBR3UuTiMfYHPrWYqgbewk8EHNGF1Urdp0fIgDcA2sr+hnOVMvfY
 iZNe43YOAtRtuXMyaqOqjM+HMGGcPvXeKWpv76m+ePHQP7BfIb2gIGyLCd+VGRbmoz8c
 2IFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244652; x=1787849452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YE7qcApQ+Obk30eKV1C+kC93MwiUbUNOYm/DV2i4pE0=;
 b=XZCz8SwWWXGwcxSbpb2OpUz3gYt+rI08iacP52ApeHrlplFhCMPCBscEW1OMtBlhP9
 1ZeAQNEW3gI7Fk4mXgd8mF1Rls+w8RwA5hGlqg/pbsHTzjy8y/CxfPGPZflkb5Ynj0zT
 Ft9RFHApRievEP9Ecy95quJCMBP6jIkqGxmvJEKF2Z/p2dohx3Oj4gwmmAR1AGMDAFKh
 C1tdbz8rvmzTks6xOIGzBBSg99QP1fzsQz1r+yeyBEPaWbGUywGeN8JAcVMek73coykI
 5bAIoemEKkR7v3l3qUsVv9aNlg18U8g7AbCAW/uQO2BSiBA9ihJY4fWCPBQx6dxBFXVQ
 CqTg==
X-Gm-Message-State: AOJu0YwievUIWFon2vOzSJCJImH4R74x7twP5sh5pTnFVPsQulOf2uO5
 ynftVGixROclzhWCH8MTOzVJ9rwiKVIrV/XiJgsZfmOoqvxgvcoTpEdd
X-Gm-Gg: AR+sD13Qm51rhQLOWsSk5WTgeb5F8SZ0oxCrrO7ZxD+NG6gqVNsRN9KirHovYhnCIFD
 XTJKmtFrHwhg7n+xpRZRieMLxWAccaTgOsDyApWv3oH3nzWUIGJnTDzIl+HW9j9a64x4V5uZRSW
 aNnwFGqc8D0gSLizyfH+5F+ZUICy73or0TxA9TeH2gKIR+5cOGFXgH93cRW8mDBMwhJEDwllGMX
 w05JObsrfy/QslvyLUu6DZSELEghbvEvlcOkl/UWdOrXtvu29nINkfF6VF7ezmiYP6Vz2X94tIT
 iZlseuKGcFsJEXEonVskdefbkSnKM4a5qpiDLdMftKZuny/WQHHvlZSqCGnNUJGX1Y6p/GNJNY5
 dgmEIMy9m85cB1uJgeVzO5lGDv4B7wn2LTOwT2PeR/zcrlpLNFE73/Q/Hh13UiRaag6hKW1hUpK
 quh7NzIfIs9+FyQSk1jaXe5R6JxV3B4zaEmmXLEA6DKphRhcNls/cyuJQK0SNdcVCZWPw=
X-Received: by 2002:a05:600c:4e8b:b0:499:872b:abd4 with SMTP id
 5b1f17b1804b1-499b829ef81mr4294175e9.6.1787244651755; 
 Thu, 20 Aug 2026 09:50:51 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa1111b2sm205307545e9.5.2026.08.20.09.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:49 -0700 (PDT)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Mary Guillemard <mary@mary.zone>,
 nouveau@lists.freedesktop.org,
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Subject: [PATCH v2 07/10] drm/nouveau/disp: fix head state readback on GB20x
Date: Thu, 20 Aug 2026 20:49:26 +0400
Message-ID: <20260820164929.17117-8-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164929.17117-1-mohamedahmedegypt2001@gmail.com>
References: <20260820164929.17117-1-mohamedahmedegypt2001@gmail.com>
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

Add gb202_head_state(), the same readback at the 0x800 stride, and
supply it through gb202_gsp_disp.
gv100_head_rgpos() is kept. The RG registers keep their per-head 0x800
stride on NVD5.0, and OpenRM's kdispReadRgLineCountAndFrameCount_v03_00
still reads NV_PDISP_RG_DPCA on DISPv0502.

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
---
 .../gpu/drm/nouveau/nvkm/engine/disp/gb202.c  | 49 ++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
index 4863b2b36db0..a66c820be9fe 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
@@ -83,6 +83,53 @@ gb202_sor_hdmi_gcp(struct nvkm_ior *sor, int head, bool enable)
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
+	case 5:
+		state->or.depth = 30;
+		break;
+	case 4:
+		state->or.depth = 24;
+		break;
+	case 1:
+		state->or.depth = 18;
+		break;
+	default:
+		state->or.depth = 18;
+		WARN_ON(1);
+		break;
+	}
+}
+
 /* GB20x is GSP-only. This table supplies the register programming the
  * GSP-RM display path needs from the chip.
  */
@@ -91,7 +138,7 @@ gb202_gsp_disp = {
 	.uevent = &gv100_disp_chan_uevent,
 	.ramht_size = 0x2000,
 	.gsp.intr = tu102_disp_intr,
-	.gsp.head_state = gv100_head_state,
+	.gsp.head_state = gb202_head_state,
 	.gsp.head_rgpos = gv100_head_rgpos,
 	.gsp.vblank_get = tu102_head_vblank_get,
 	.gsp.vblank_put = tu102_head_vblank_put,
-- 
2.55.0

