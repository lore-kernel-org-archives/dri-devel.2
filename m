Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C06C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 468BB10F106;
	Thu, 20 Aug 2026 16:50:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M7zfuCNx";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEBB510F107
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 16:50:20 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-499acf0fb55so177575e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787244619; x=1787849419; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rT8aU54Ao2Sd1OnFQ2SWEU+B+UCoOzmBSCO9Ey1DwWE=;
 b=M7zfuCNxEXNeHc6+5iLr6b1GxrdsGAogTspr7PcrckvwhrkQXTaqIPlM34EP6U7AzF
 SMb3V97KRFGJ0Qi4vf4dSCgDWNj3fFCsNue5++bILV7yuDNxEzKUQ+AEHjPXvVAjjMmU
 cN/bYmN3zfWeDvVVlXvxsSgCmTQQ9fpwK/e2+jAhShThwd4G88W4NpMjHUlcF8I6uwEQ
 iETreohz3B4oxqoJB4eKeIcbj6n1MyekoNa0yZdltQlHTKrOrHtPhPjQS7PpVv85isYl
 2n2xs1YxCW3nMyHraHQQaAZreX1VE5uMQulfANAn8OBAXxiEb3lLgJd+s/6BeXqokYEl
 aF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244619; x=1787849419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rT8aU54Ao2Sd1OnFQ2SWEU+B+UCoOzmBSCO9Ey1DwWE=;
 b=JEup+vM5t9rKKMYmcscCRjKQfRUdQA+flluh7dZvjKl5xKoEfjYd8wI3HOGlQJuyS7
 RcfoVI/kYAESJ6CBdrhGHbMe1Hv4gJZkpMbFf/vmqQlp3/EB/jaU0h3ZhWgD0ffhkOSt
 kGzkTo/BJJ1fqdbYnNchMlsj8VgHc5C+anIxibej/ENtdLBSYNxNib8fVwQDoIKyh8Jn
 TIUPDxIvzugHa4P4gCtYJKZ0gC9844p7YGVpZeeSsn4LRLRueSIfeiqSRQGmFn6nFWie
 LLQRlD5veerHwRZaS1ZzhFzAOiem4LCfedINV7pp1J+9C2bpQuAcgn2xwpn6t+kCvYSk
 7fDg==
X-Gm-Message-State: AOJu0Yw3+LnLUkVbRMko/wYTcnEv2YWZmaRLV8zQiYNdT5vHE0CrCjR2
 UfvEir9jAIIpud3Tr5sAIo0wCGaLzs6n2NFR4ATbu1yQLdZrwfvhmKIP
X-Gm-Gg: AR+sD10dGkGhonMPLDZ4WNGQSqTcQPb7Py7AKLAy2smHJOy2k0zD2jie2OgxpdYB6tY
 qUYpibTJOXb0/rt0qYgeukpX8j6SCrzXfCWchfekidb+cK9qcbm528YPuxIQwa2jF4QC5g/+44l
 0wSGOKILurO7Of0+aZeRGpfduVGCotEylBWAW5njhGba7Bp6fmX/sT6i3xTiEbmc0J9mp8Y++HN
 WLSjIOZnKav15QHneJvGAwxJzBdAhQXrM8oR7h7kXI0UeRv4O/ruJUGp+RgfhHNlIgEC6oWt7pt
 Ax5FtlQgg9YDKB475+rvJ9NYK/frxALwZFVbat1AO6FnND/aVQ5PrSd/gV5WLd5aOyoyKPEGsLe
 uCiRWw38jcOlqp3gRf4T93IWt+5pzsvL3Emn+H2rBAPQHSw5jMMLXufh/8nC9QUzTWjvhV/3Ux7
 a3uzdq8VbxxlMhpr5Yh3Sb/ikmzzvnY9jjGqkBy2HTtsiIbPC9eM1nT/V4ZcTWdVnhKc8=
X-Received: by 2002:a05:600c:a087:b0:499:a760:722f with SMTP id
 5b1f17b1804b1-499b8461acfmr3397515e9.13.1787244619109; 
 Thu, 20 Aug 2026 09:50:19 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa1111b2sm205307545e9.5.2026.08.20.09.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:17 -0700 (PDT)
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
Subject: [PATCH v2 02/10] drm/nouveau/disp: move the GSP HDMI GCP AVMute write
 to engine/disp
Date: Thu, 20 Aug 2026 20:49:21 +0400
Message-ID: <20260820164929.17117-3-mohamedahmedegypt2001@gmail.com>
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

r535_sor_hdmi_audio() pairs two RM controls (a SET_OD_PACKET carrying
the same General Control Packet, and the audio mute-stream toggle)
with a direct write of the GCP AVMute bit through the SF GCP unit.
The controls are RM and stay, but the direct write is register
programming and moves next to the other per-chip display code as
tu102_sor_hdmi_gcp(). No functional change.

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
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

