Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B69C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 23:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 854B610F6BA;
	Fri, 14 Aug 2026 23:58:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V7X5mDzC";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E194710F782
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 23:58:52 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-495757ccbc1so13957505e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 16:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786751931; x=1787356731; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R6DVPxscTkaYxlbTz2TUJ+2+zTnJDWDA7fd5WXD5WOU=;
 b=V7X5mDzCFJhxqnW3HOb8nYQvY/ka5zfN7DV6/dsbRZiPFb5uww52bsvC4wjHpFB9hm
 BAscpsDHMzhLWHyVRslwRYB647wEW/WrLVb8yJUs6rYO7QVca65XTX0j5x4I+GvhzmVo
 I6Qw5O8+7pbsQwuns100y5Z77fufsWQMCLcwEADO5qt3kj+kjLdZY2eZmStRn4OrR2eZ
 DcvQaJNWghZ/hLJEi49aF8UxNJ0I11DJx0tt3XfKKsKmZl+3xD3tNzq+Djtx57WIzyha
 7xDHV4ickCm1xSju4tLCrahpKdBBx8is7OF4Vn0JhyUQJba4kjx7mR6R65GH/s9eTOox
 EkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786751931; x=1787356731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R6DVPxscTkaYxlbTz2TUJ+2+zTnJDWDA7fd5WXD5WOU=;
 b=qKnCLuZNA3yzZESSNecSoAkle69CtMEEt82XmVmX7+QKsXlsgGBDbD4plTKH8fEEOc
 DS+UaGARTkCvcsZ7HgSGzi01+rU7m6J9i2u33pXr3sLNlOO8PshuXLy5Rh6HgqAW2exR
 XLt6ot8LjikaGEekO5tbG1c+qb77/b4vGP8+R4JQhr5Uiz3W6nJjpaqz9SdNuuSDvTYV
 pe78XK/NuT6ztsHt/30fZL+VtZYPqEx2j5s7sm2dSPV9C2LcZwrVT0aDhnKqzvojo7ZB
 UHXcuobEY9gsTTrjcP/tLEwYrkq+cW6J8YswjLnm7NllqSkYHm/hqwARBxRBa2Kgyo/t
 cM5Q==
X-Gm-Message-State: AOJu0YzEEUIQFRy8ufjCZE2T2AlCekndHpnigECRRJXZ0wvwpvs0i/9N
 Ik99fW3SXtQbAF28vJYOixhoYsHLfrXigphvZyzRFkw4++ySpthIJRAo
X-Gm-Gg: AR+sD13M3FZL1fsxDxTf5/9/QLgpOuEO/OlZpXdqfDipvV0SXKVSzCPyi6FXi3aI3/p
 75Je7oV/k8vimltByXJgoMHsZvmjUVjzYV2NAsks6k7hYR4BWcgG3gKCcBTW9bqPUG5Ra+mw1Ns
 T7U+HmqQUTzMJOTM/zviNzl/pFHKTr9+XKZS8BDyRdBXwNIbjX5KtKESye58+bid9iTVxUz/tYH
 9D5whfUsslPuKegH+3yyqa96FxPjFi9XG3fLs2AL36jFxeky0VOguxjxlE9aCUClvJikoBCS5b9
 29gu9diJk7eHqIN51Vg/APCgv/OECa7g/nB/eC1NkG94bvieSm7WLPKwKL+ABJ/TBClZb/3xgdf
 aSYLMOVvV7OtRqTdq5dOftM4ex2aILN7+vxXk1Nm+HnHH98irIuWcj4UzOpdN+hrfHn9HWvpX6h
 p3kkIq5b1vLd0Juj91VU+Hjzla1yOpo3bTlfdAN5xjRf4MT5QEXqmIpq+fN5vemSIfB7E=
X-Received: by 2002:a05:600c:b99:b0:496:c379:b2a1 with SMTP id
 5b1f17b1804b1-49987929903mr128849405e9.2.1786751931136; 
 Fri, 14 Aug 2026 16:58:51 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499899753ccsm77751245e9.0.2026.08.14.16.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 16:58:50 -0700 (PDT)
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
Subject: [PATCH 3/7] nouveau/gsp: fix HDMI GCP AVMute register offsets on GB20x
Date: Sat, 15 Aug 2026 03:57:01 +0400
Message-ID: <20260814235705.59132-4-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814235705.59132-1-mohamedahmedegypt2001@gmail.com>
References: <20260814235705.59132-1-mohamedahmedegypt2001@gmail.com>
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

r535_sor_hdmi_audio() brackets audio enablement with a General
Control Packet AVMute toggle written through the legacy GCP unit at
0x6f00c0/0x6f00cc. On GB20x the SF packet units were compacted and the
old generic and audio-infoframe units are gone and the GCP unit moved
from slot 3 to slot 1 (control 0x6f0040 and subpack 0x6f004c from
NVIDIA's published clc971.h. The same offsets are also used by OpenRM's
hdmiWriteGeneralCtrlPacketC871() on these chips). The old addresses are
reserved on GB20x, so the AVMute writes were silent no-ops and mitigated
only by the equivalent GCP this function already sends through the
SET_OD_PACKET RM control.

Add a GB20x variant of the audio function using the new offsets,
keeping the direct MMIO path in sync with the hardware as on
earlier chips.

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
---
 .../drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c  | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index 96febd01da78..f51ad7c754d8 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -559,6 +559,21 @@ r535_sor_hdmi_audio(struct nvkm_ior *sor, int head, bool enable)
 	nvkm_mask(device, 0x6f00c0 + hdmi, 0x00000001, 0x00000001);
 }
 
+static void
+gb202_sor_hdmi_audio(struct nvkm_ior *sor, int head, bool enable)
+{
+	struct nvkm_device *device = sor->disp->engine.subdev.device;
+	const u32 hdmi = head * 0x400;
+
+	r535_sor_hdmi_ctrl_audio(sor->asy.outp, enable);
+	r535_sor_hdmi_ctrl_audio_mute(sor->asy.outp, !enable);
+
+	/* General Control (GCP): the unit moved to slot 1 on NVD5.0. */
+	nvkm_mask(device, 0x6f0040 + hdmi, 0x00000001, 0x00000000);
+	nvkm_wr32(device, 0x6f004c + hdmi, !enable ? 0x00000001 : 0x00000010);
+	nvkm_mask(device, 0x6f0040 + hdmi, 0x00000001, 0x00000001);
+}
+
 static void
 r535_sor_hdmi_ctrl(struct nvkm_ior *sor, int head, bool enable, u8 max_ac_packet, u8 rekey)
 {
@@ -595,7 +610,7 @@ gb202_sor_hdmi = {
 	/* The legacy AVI unit is unchanged on GB20x. */
 	.infoframe_avi = gv100_sor_hdmi_infoframe_avi,
 	.infoframe_vsi = gb202_sor_hdmi_infoframe_vsi,
-	.audio = r535_sor_hdmi_audio,
+	.audio = gb202_sor_hdmi_audio,
 	.frl_train = r535_sor_frl_train,
 };
 
-- 
2.55.0

