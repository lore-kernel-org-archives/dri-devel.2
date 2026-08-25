Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01C3C5DF9C
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 00:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0546C10E59F;
	Tue, 25 Aug 2026 00:15:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oPNGkoju";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A63B010E59F
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 00:15:12 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-480001972b8so1019010f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 17:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787616911; x=1788221711; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mdmMJSJ8rbCJNULoO8M4OEKgVBhOfOqt451kTS7kBCU=;
 b=oPNGkojuBFjkZnaKfHKK03K9oiW0AE0OxJBrmqHI10PHbxwWXns6OKKffNI3IqsJ9p
 6F+Ma5lwuhq9cdRJpGJetDwV4cDqAndgOZ8nvMsMHcmMIKfmExUxUcHTIYLJtKkJLHi2
 wHIVZguykSgG142HeoQssakyNswwps0gwQmi537lW2fHyqFi9OQavNTAu5ygXhWWv6fU
 rUDA68SUxhTnKsXLKcWA+G06z61kTsn5tiXiYXQciydnFfPQ1zONuQC94in46r0NsPBg
 OAPVb+0WZilZQr1WOJZR5UmCRXvgDg6Y7O9tMPQ/9FRJEPczVs1jjH5U908Fdz3/ayIH
 woGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787616911; x=1788221711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mdmMJSJ8rbCJNULoO8M4OEKgVBhOfOqt451kTS7kBCU=;
 b=XH5a643rWNQDdGa2Ztz8AyTf2MlQ352h8tB8Ymx7FRWDkXePqyKVCIoac74Utlj0UM
 Mh3G2SqRGn6lvVIXrWU0Igy7ldp3iLb2eMjnxmOgPD358Trb1dTFV8iZHtpwbvmM8wtQ
 ArsuvWX5j5trNFRrXV5+uhKmHy5A8Ilrxee7/HB/lBNGsRZXpwdapSlPY8cSiW6LUELq
 /E5iGZ9hXIwRXVpaf4jv7AD6dsf52UHWg9+ySLdfJ8kE2cCGDjEImMILR6w+RUvNQSxA
 k2+yvHOy6IZ8xCAGWkxeVa8t0vABnK/0HGY22nbf0suV4qZj2Jcj6s9f+iQD5cW1YmYs
 bfcQ==
X-Gm-Message-State: AFuF++mVwCvQIzK7RuEQGyV63uNVyIYQS5xjgbw3pIbwdr0/aCAByXp9
 s1M0I/MgRrxexF4hVGQ9SGIXydtn/BZXeIlgOIZ7jMwyS0nUNsj3junv
X-Gm-Gg: AR+sD11hdQTAPmiJZCJxvGVjo9crKVTwdVx5eeiaIDve1JcLxNDMRnFKcWwf/Ty53OP
 iU51JNkYSDDKSA3ipHB9vdmnHrbdjWRS6gT6b+EmdojuAk+Hxae4nHNEaRVllbr9Jb1ixHFJh6T
 71Qyqbk7IZ1Z3Z2yxWelQ9fE+92OmQaIdkLYaakqp4/BM8nKaraAqnf3DsPBS2ioS5CskE4+tKM
 L/ZAPERaXiUa59I2uaMeBqoYZQMTTcWzhr/lLETUYnRRTWcDd5oIO0Lw8uFm8Pu7m4NPmL3lee8
 yyQMNzNk5QiPdHhLs3kSuSIXg9CzhT9N1c1DwmmllSuTGMozkZ4V7VLo2WdRP5D9FizWLno35hz
 CLMoxeyV+5OpC1RBv/qZ/J/jxOL52qp7vflUc742caujQs++xeXOENi+Y1Gz4rt3X9mMDbgmw7o
 Fnb9gG7xBewICpD0F+hOiaJIhmeuzmer2oik3ozRbPi0NZj7M9LlMy2mjWnta44XiIVQw=
X-Received: by 2002:a05:6000:2582:b0:47f:80ee:744f with SMTP id
 ffacd0b85a97d-482c0b99a89mr36897656f8f.16.1787616911031; 
 Mon, 24 Aug 2026 17:15:11 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b78ebfsm9770676f8f.12.2026.08.24.17.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 17:15:09 -0700 (PDT)
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
Subject: [PATCH v3 05/10] drm/nouveau/disp: fix HDMI GCP AVMute register
 offsets on GB20x
Date: Tue, 25 Aug 2026 04:14:03 +0400
Message-ID: <20260825001408.14219-6-mohamedahmedegypt2001@gmail.com>
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

The GSP path brackets audio enablement with a General Control Packet
AVMute toggle. r535_sor_hdmi_audio() calls the gsp.hdmi_gcp hook, which
every chip so far serves with tu102_sor_hdmi_gcp() and the legacy GCP
unit at 0x6f00c0/0x6f00cc. On GB20x the SF packet units were compacted
and the old generic and VSI units are gone (ACR keeps slot 2) and the
GCP unit moved from slot 3 to slot 1 (control 0x6f0040 and subpack
0x6f004c from NVIDIA's published clc971.h. The same offsets are also
used by OpenRM's hdmiWriteGeneralCtrlPacketC871() on these chips). The
old addresses are reserved on GB20x, so the AVMute writes were silent
no-ops and mitigated only by the equivalent GCP r535_sor_hdmi_audio()
already sends through the SET_OD_PACKET RM control.

Add a GB20x GCP writer using the new offsets and hook it into
gb202_gsp_disp, keeping the direct MMIO path in sync with the hardware
as on earlier chips.

Only SB0 (the AVMute bit) is written. On NVD5.0 the subpack register also
carries SB1_CTRL (bit 24), which selects where the deep-color CD/PP
fields are generated (hardware or from the driver, with the default being
HW). hdmiWriteGeneralCtrlPacketC871() likewise writes only SB0-SB2.

Fixes: 6cc6e08d4542 ("drm/nouveau/kms: add support for GB20x")
Cc: stable@vger.kernel.org
Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
 .../gpu/drm/nouveau/nvkm/engine/disp/gb202.c  | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
index 1e40de83e2bb..face801af080 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
@@ -65,6 +65,24 @@ gb202_sor_hdmi_infoframe_vsi(struct nvkm_ior *ior, int head, void *data, u32 siz
 	nvkm_wr32(device, 0x6f03f8 + hoff, 0x00000002);
 }
 
+/* General Control Packet AVMute bracket. The GCP unit moved to slot 1 on
+ * NVD5.0. Only SB0 (the AVMute bit) is ours to write so we must not do a
+ * full write here: SB1 carries the deep-color CD/PP fields, and SB1_CTRL
+ * (bit 24, new with clc871.h) controls where their generation happens (HW
+ * or driver) on these chips, with the default being HW.
+ */
+static void
+gb202_sor_hdmi_gcp(struct nvkm_ior *sor, int head, bool enable)
+{
+	struct nvkm_device *device = sor->disp->engine.subdev.device;
+	const u32 hdmi = head * 0x400;
+
+	nvkm_mask(device, 0x6f0040 + hdmi, 0x00000001, 0x00000000);
+	nvkm_mask(device, 0x6f004c + hdmi, 0x000000ff, !enable ? 0x00000001 :
+								 0x00000010);
+	nvkm_mask(device, 0x6f0040 + hdmi, 0x00000001, 0x00000001);
+}
+
 /* GB20x is GSP-only. This table supplies the register programming the
  * GSP-RM display path needs from the chip.
  */
@@ -74,7 +92,7 @@ gb202_gsp_disp = {
 	.ramht_size = 0x2000,
 	.gsp.intr = tu102_disp_intr,
 	.gsp.head = &tu102_gsp_head,
-	.gsp.hdmi_gcp = tu102_sor_hdmi_gcp,
+	.gsp.hdmi_gcp = gb202_sor_hdmi_gcp,
 	/* The legacy AVI unit is unchanged on GB20x. */
 	.gsp.hdmi_infoframe_avi = gv100_sor_hdmi_infoframe_avi,
 	.gsp.hdmi_infoframe_vsi = gb202_sor_hdmi_infoframe_vsi,
-- 
2.55.0

