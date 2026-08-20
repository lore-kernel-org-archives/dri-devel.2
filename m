Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B24C5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77F6510F10A;
	Thu, 20 Aug 2026 16:50:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JrSn0lXp";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE72810F10A
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 16:50:40 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-480033bdcf4so78601f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787244639; x=1787849439; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y+Y9y81hA9Cad/KoflpAlEdybDJIGHGo0qSz9MnRnh8=;
 b=JrSn0lXpN1kgEvx9VvzPpkQceZWdz5GogdmA10gAQJNKj9tPksmXzcQ6+jWl8EOWCA
 VK9OBB28VVSYygZAA3k6MAWW0HuYF+bqXEiI9R6JqFx4NvWgY/czKsXqnHHXm9afXwCo
 ct/lIj0ASuvxj7OVuIhZs/9B3jbfC0HgkXRbJoP7DDTp+n6kpgQMPx+4pzJzQL7b+a7m
 JlNcf9GcJR82WR63i5y2ZKSkGnnwM+gOXRh4SIgg7TjrOrQBf9ss+nUsODRy1wQf+xnV
 X9J20fmIKTlqQ7zM0ZC+ddBeO9Jmi0MnItJ8sxTQVV1dKNE/eWgw9r+aoMrXn1MlYoGr
 y97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244639; x=1787849439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y+Y9y81hA9Cad/KoflpAlEdybDJIGHGo0qSz9MnRnh8=;
 b=EF2cdsnpAVL3ZN3KvYA6iGuilTjSI//MGrEcU2OgE0gmaqMro9oDZGnMSw61vfwBrh
 JRa4EwxeyibXNUTdzH0MoXa/O1+HxlCMERVuadZCu07H2SeJj7CJ6AT9CY/8StwjIA5z
 VzVnTchnch7BxrfKsOsCRcdmXPisMc5a+JXL+vQe2itM3YvK92HtNXPWFIJJaZkEBcV1
 qs5YDQU8Va52lfftiKxpA3xMoG/RQATaMixc359nczajqjFr8c9IPCm6qszHQsH96RNm
 tFLJhPSAfv9mpDx4ogNjV9vBpf8nuImS+uxDQlqKU72ym0ar6RPdF7FIt8x23afkW5u9
 X/Qw==
X-Gm-Message-State: AOJu0YwPPLIonkuMZFI/hx+DWY3UCzr2a8MTFhqp79/LoeajtcAUSmY3
 EhL5TV/MVuyDdwGcsOIvqT4GoSUIEiGE5UcfdcDhDVSYvO0eECGvEAJz
X-Gm-Gg: AR+sD13jllLqKL2CENOOuXd0XM5wMBcibANfiMTKGT/5AiDR6Jagar50zFqi+GXw1r9
 Oe+rApyKpGDpfMCtuaBPnuqa3n+5/jyTUwzcuI+tIvwn7HV9XBDNIGcjFVHjOhptv0KUXR7gPBx
 ILWl1u0I1fGEeENGvXBIbi066XDOHtg6goRdWmxWG/zKRxFfyJSc2AfMjyL24U/DQ+Zcq9BjTh8
 Fl+VlZfxV3Ey+Rsgh84iq2u0NzKPDTonqC0yEV4k5WkqlkSK7DsRGK0rjSfuKXmh5jFmgHn+fr2
 eEmHC3wWcSOpN+ZEHM5+fdyCTqQeebfyiVNnfmDnTjysTMKZNfeR59JVx6kqNq7Yt248Zq6cZpb
 hEVTCr5fMA2d4q+UuSRAYU9znE5YWZ4+Q6tJjSgMBZLOsOzLeezYgDOrYYDi0GTsb9Y1AaUxDac
 DyuJy/mv0YEhe7y24GVMDt9UwDZHAilZXdHiBkVMlAxTH3RtVvIUxo7uh4Juw1MmsUuqE=
X-Received: by 2002:a05:600c:19c7:b0:499:484a:81d0 with SMTP id
 5b1f17b1804b1-499b82e84aemr4300455e9.9.1787244639062; 
 Thu, 20 Aug 2026 09:50:39 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa1111b2sm205307545e9.5.2026.08.20.09.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:36 -0700 (PDT)
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
Subject: [PATCH v2 05/10] drm/nouveau/disp: fix HDMI GCP AVMute register
 offsets on GB20x
Date: Thu, 20 Aug 2026 20:49:24 +0400
Message-ID: <20260820164929.17117-6-mohamedahmedegypt2001@gmail.com>
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

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
---
 .../gpu/drm/nouveau/nvkm/engine/disp/gb202.c  | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
index fa83aee35ae7..4863b2b36db0 100644
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
@@ -77,7 +95,7 @@ gb202_gsp_disp = {
 	.gsp.head_rgpos = gv100_head_rgpos,
 	.gsp.vblank_get = tu102_head_vblank_get,
 	.gsp.vblank_put = tu102_head_vblank_put,
-	.gsp.hdmi_gcp = tu102_sor_hdmi_gcp,
+	.gsp.hdmi_gcp = gb202_sor_hdmi_gcp,
 	/* The legacy AVI unit is unchanged on GB20x. */
 	.gsp.hdmi_infoframe_avi = gv100_sor_hdmi_infoframe_avi,
 	.gsp.hdmi_infoframe_vsi = gb202_sor_hdmi_infoframe_vsi,
-- 
2.55.0

