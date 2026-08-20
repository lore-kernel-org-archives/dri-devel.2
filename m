Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF28C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52C9C10F0F5;
	Thu, 20 Aug 2026 16:50:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JU5S7prK";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 488AC10F0F5
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 16:50:27 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-499b2981a7bso304585e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 09:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787244626; x=1787849426; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uA+ttixfTL8eQL/cabSDvzDeSAF53vHarfWSrokRJJI=;
 b=JU5S7prKelmGhhv6sXtKEncmaP9Wn133oHFXt9H1RnuxSiqNZ+J3gPfSPAmpUeaKGS
 HCciOnA+1fs1fqHAiTxBoem9PaCyz+SYfWzX2kY6+UZLlaC3aQbBGggfHzO8ennQDypd
 Yt6EBNn7IO5BQhjPGlOv8WYnFAcQ+YntUWv9i2UXsKGW0/qILtnREf9qrrKXbXshK48j
 nbCcYYQJ0yu8I2pzGDcrgJNAMUEzbqsV4WJgCpOAS9uk5eyZyd10WGEai8lL7OC/tnLv
 5l93nY/V+uXfz0Cj3OZjbYcL4n+0avf2gONcnmASjNHV1Bqnwrf5h3scU7adxvEuqyd3
 zTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244626; x=1787849426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uA+ttixfTL8eQL/cabSDvzDeSAF53vHarfWSrokRJJI=;
 b=X1uUmNKBJtITTfDrxcCwgBT7uihQOP53m5MHclzfhm4+IhD9nNIc4dKonpn0ItVoDY
 nF/19eUCwr5cfcp9GSyThjBQtsrlnpO/uw16FLtMmIWbAkBKfVXTvfhZksbfr48gLa9N
 rzx/CyaZgXW2NWz2ePFjlZzhIFsP2hsQs9ZqEYh8zbqhB99txwLTviEzMUjDR27ONwLo
 7PxAvj1giFgLv3iBrzvEaPxFHBKq6hOhZKWxC2X5WFi0TsHHXwaibLeNyCvPKBXMLOpS
 Vx9lpgnNXa0HnRbAHMWhlN90Je5d0uH+qJF66x9nFBmi7iNkwjtkA8pc4BgNjYHesllK
 37NQ==
X-Gm-Message-State: AOJu0YyUQD4N7uwp5Ol3cnxOEzTrOOvXZpFgSwZto/qiJ9YRcmCP9SOM
 5QvTyfgC2MNwKo4Lyup1D789DJ6ppBzssvmLqd9prw7MdBDUAZV1kGUx
X-Gm-Gg: AR+sD11aX1f1bNRz/iBOL68fuK82If2GqjNPDpBzPb6s4K7t4Co2UfssJtmC1E6lvEH
 OEIWJspignwx86u1DMiV/Y2dNYhgxi0lapX6hoWcpf5ANBmcMpjkv+nYrpBiYGeb+Qaiw8yPLsE
 EQkWasiz3CHQPdZ3DPWMgvjMIu7XAhbdSd7KAJf5dwus0O/j7L4jQEQL92wTZBKEEcDS7moL5pz
 ExmWhcSwlOIVvgonr0xILXLR7z8+BIJtIc+b/9ajr97UwEgqDBc8zrVPDou+vrDO/IEXrksTXjU
 VUIj/CmcPcRSty3FJTIp/f6KPbgUu0jpM4uiGjY0bugDXzFQlHeDfjC/vTzCMARauOiTCPtcrIG
 076IJoOOENh+ef7twKbGR7G2V9dFHl0o9FDdbv28XqwtqW7DjNwSF7oH0gYBrgY4IpDS4zVt5wr
 dsA/+nYH08QqTRviJ2wX07OmF8uyOkvP+8Dy/7pW7av3NAkD0Vi81WxYfscSp/M46ePsA=
X-Received: by 2002:a05:600c:4e91:b0:499:7a15:fcec with SMTP id
 5b1f17b1804b1-499b83547e9mr2734665e9.13.1787244625397; 
 Thu, 20 Aug 2026 09:50:25 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa1111b2sm205307545e9.5.2026.08.20.09.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:23 -0700 (PDT)
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
Subject: [PATCH v2 03/10] drm/nouveau/disp: route GSP-RM display MMIO through
 nvkm_disp_func hooks
Date: Thu, 20 Aug 2026 20:49:22 +0400
Message-ID: <20260820164929.17117-4-mohamedahmedegypt2001@gmail.com>
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

The GSP-RM display code in rm/r535/disp.c borrows a few
register-programming routines from engine/disp (the head-timing
interrupt handler, vblank enables, armed head state and scanout position
readback, the AVI/VSI infoframe writers and the GCP AVMute write) and so
far picked them by name, which means it has to know which chip it runs
on the moment a generation changes any of them.

Give nvkm_disp_func a .gsp table that each chip fills with exactly those
hooks, add tu102_gsp_disp (TU1xx) and ga102_gsp_disp (GA10x onwards)
carrying the current functions, hand them to r535_disp_new() instead of
the full hardware tables, and make rm/r535/disp.c call through the
hooks. r535_head becomes four forwarders, r535_sor_hdmi gets infoframe
forwarders, r535_sor_hdmi_audio() calls the GCP hook, and the interrupt
handler and its vector come from the table (intr_low_latency selects the
second DISP interrupt instance for chips that raise head timing on a
separate vector). The tables are per chip even though the two currently
coincide, so a generation that changes a hook only touches its own file.
rm/r535/disp.c no longer contains chip-specific register code, and a new
display generation only has to provide its own table. No functional
change.

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
---
 .../gpu/drm/nouveau/nvkm/engine/disp/ga102.c  | 16 ++++-
 .../gpu/drm/nouveau/nvkm/engine/disp/priv.h   | 19 ++++++
 .../gpu/drm/nouveau/nvkm/engine/disp/tu102.c  | 16 ++++-
 .../nouveau/nvkm/subdev/gsp/rm/r535/disp.c    | 60 ++++++++++++++++---
 4 files changed, 100 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/ga102.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/ga102.c
index ab0a85c92430..b48ed7146396 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/ga102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/ga102.c
@@ -144,12 +144,26 @@ ga102_disp = {
 	},
 };
 
+static const struct nvkm_disp_func
+ga102_gsp_disp = {
+	.uevent = &gv100_disp_chan_uevent,
+	.ramht_size = 0x2000,
+	.gsp.intr = tu102_disp_intr,
+	.gsp.head_state = gv100_head_state,
+	.gsp.head_rgpos = gv100_head_rgpos,
+	.gsp.vblank_get = tu102_head_vblank_get,
+	.gsp.vblank_put = tu102_head_vblank_put,
+	.gsp.hdmi_gcp = tu102_sor_hdmi_gcp,
+	.gsp.hdmi_infoframe_avi = gv100_sor_hdmi_infoframe_avi,
+	.gsp.hdmi_infoframe_vsi = gv100_sor_hdmi_infoframe_vsi,
+};
+
 int
 ga102_disp_new(struct nvkm_device *device, enum nvkm_subdev_type type, int inst,
 	       struct nvkm_disp **pdisp)
 {
 	if (nvkm_gsp_rm(device->gsp))
-		return r535_disp_new(&ga102_disp, device, type, inst, pdisp);
+		return r535_disp_new(&ga102_gsp_disp, device, type, inst, pdisp);
 
 	return nvkm_disp_new_(&ga102_disp, device, type, inst, pdisp);
 }
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h b/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h
index 722ec340e12a..3cb903741fb8 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h
@@ -5,6 +5,8 @@
 #include <engine/disp.h>
 #include <core/enum.h>
 struct nvkm_head;
+struct nvkm_head_state;
+struct nvkm_ior;
 struct nvkm_outp;
 struct dcb_output;
 
@@ -34,6 +36,23 @@ struct nvkm_disp_func {
 		int (*new)(struct nvkm_disp *, int id);
 	} wndw, head, dac, sor, pior;
 
+	/* Register programming that the GSP-RM display path (rm/r535) needs from
+	 * the chip, everything else on that path goes through RM. Every hook
+	 * is called unconditionally.
+	 */
+	struct {
+		irqreturn_t (*intr)(struct nvkm_inth *);
+		/* Head-timing interrupts arrive on a second DISP vector. */
+		bool intr_low_latency;
+		void (*head_state)(struct nvkm_head *, struct nvkm_head_state *);
+		void (*head_rgpos)(struct nvkm_head *, u16 *hline, u16 *vline);
+		void (*vblank_get)(struct nvkm_head *);
+		void (*vblank_put)(struct nvkm_head *);
+		void (*hdmi_gcp)(struct nvkm_ior *, int head, bool enable);
+		void (*hdmi_infoframe_avi)(struct nvkm_ior *, int head, void *data, u32 size);
+		void (*hdmi_infoframe_vsi)(struct nvkm_ior *, int head, void *data, u32 size);
+	} gsp;
+
 	u16 ramht_size;
 
 	struct nvkm_sclass root;
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
index 6cfd52c9056f..9db3cac487e3 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
@@ -295,12 +295,26 @@ tu102_disp = {
 	},
 };
 
+static const struct nvkm_disp_func
+tu102_gsp_disp = {
+	.uevent = &gv100_disp_chan_uevent,
+	.ramht_size = 0x2000,
+	.gsp.intr = tu102_disp_intr,
+	.gsp.head_state = gv100_head_state,
+	.gsp.head_rgpos = gv100_head_rgpos,
+	.gsp.vblank_get = tu102_head_vblank_get,
+	.gsp.vblank_put = tu102_head_vblank_put,
+	.gsp.hdmi_gcp = tu102_sor_hdmi_gcp,
+	.gsp.hdmi_infoframe_avi = gv100_sor_hdmi_infoframe_avi,
+	.gsp.hdmi_infoframe_vsi = gv100_sor_hdmi_infoframe_vsi,
+};
+
 int
 tu102_disp_new(struct nvkm_device *device, enum nvkm_subdev_type type, int inst,
 	       struct nvkm_disp **pdisp)
 {
 	if (nvkm_gsp_rm(device->gsp))
-		return r535_disp_new(&tu102_disp, device, type, inst, pdisp);
+		return r535_disp_new(&tu102_gsp_disp, device, type, inst, pdisp);
 
 	return nvkm_disp_new_(&tu102_disp, device, type, inst, pdisp);
 }
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index cd4451e62512..f3e55253bcbc 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -547,7 +547,19 @@ r535_sor_hdmi_audio(struct nvkm_ior *sor, int head, bool enable)
 {
 	r535_sor_hdmi_ctrl_audio(sor->asy.outp, enable);
 	r535_sor_hdmi_ctrl_audio_mute(sor->asy.outp, !enable);
-	tu102_sor_hdmi_gcp(sor, head, enable);
+	sor->disp->func->gsp.hdmi_gcp(sor, head, enable);
+}
+
+static void
+r535_sor_hdmi_infoframe_avi(struct nvkm_ior *sor, int head, void *data, u32 size)
+{
+	sor->disp->func->gsp.hdmi_infoframe_avi(sor, head, data, size);
+}
+
+static void
+r535_sor_hdmi_infoframe_vsi(struct nvkm_ior *sor, int head, void *data, u32 size)
+{
+	sor->disp->func->gsp.hdmi_infoframe_vsi(sor, head, data, size);
 }
 
 static void
@@ -575,8 +587,8 @@ r535_sor_hdmi = {
 	.ctrl = r535_sor_hdmi_ctrl,
 	.scdc = r535_sor_hdmi_scdc,
 	/*TODO: SF_USER -> KMS. */
-	.infoframe_avi = gv100_sor_hdmi_infoframe_avi,
-	.infoframe_vsi = gv100_sor_hdmi_infoframe_vsi,
+	.infoframe_avi = r535_sor_hdmi_infoframe_avi,
+	.infoframe_vsi = r535_sor_hdmi_infoframe_vsi,
 	.audio = r535_sor_hdmi_audio,
 };
 
@@ -601,12 +613,36 @@ r535_sor_cnt(struct nvkm_disp *disp, unsigned long *pmask)
 	return 4;
 }
 
+static void
+r535_head_state(struct nvkm_head *head, struct nvkm_head_state *state)
+{
+	head->disp->func->gsp.head_state(head, state);
+}
+
+static void
+r535_head_rgpos(struct nvkm_head *head, u16 *hline, u16 *vline)
+{
+	head->disp->func->gsp.head_rgpos(head, hline, vline);
+}
+
+static void
+r535_head_vblank_get(struct nvkm_head *head)
+{
+	head->disp->func->gsp.vblank_get(head);
+}
+
+static void
+r535_head_vblank_put(struct nvkm_head *head)
+{
+	head->disp->func->gsp.vblank_put(head);
+}
+
 static const struct nvkm_head_func
 r535_head = {
-	.state = gv100_head_state,
-	.rgpos = gv100_head_rgpos,
-	.vblank_get = tu102_head_vblank_get,
-	.vblank_put = tu102_head_vblank_put,
+	.state = r535_head_state,
+	.rgpos = r535_head_rgpos,
+	.vblank_get = r535_head_vblank_get,
+	.vblank_put = r535_head_vblank_put,
 };
 
 static struct nvkm_conn *
@@ -1650,12 +1686,17 @@ r535_disp_oneinit(struct nvkm_disp *disp)
 	if (ret)
 		return ret;
 
-	ret = nvkm_gsp_intr_stall(gsp, disp->engine.subdev.type, disp->engine.subdev.inst);
+	/* Chips that raise head-timing interrupts on a separate low-latency
+	 * vector report it as a second DISP interrupt table entry, exposed
+	 * as instance 1 by the RM engine-index translation.
+	 */
+	ret = nvkm_gsp_intr_stall(gsp, disp->engine.subdev.type,
+				  disp->func->gsp.intr_low_latency ? 1 : disp->engine.subdev.inst);
 	if (ret < 0)
 		return ret;
 
 	ret = nvkm_inth_add(&device->vfn->intr, ret, NVKM_INTR_PRIO_NORMAL, &disp->engine.subdev,
-			    tu102_disp_intr, &disp->engine.subdev.inth);
+			    disp->func->gsp.intr, &disp->engine.subdev.inth);
 	if (ret)
 		return ret;
 
@@ -1688,6 +1729,7 @@ r535_disp_new(const struct nvkm_disp_func *hw, struct nvkm_device *device,
 	rm->uevent = hw->uevent;
 	rm->sor.cnt = r535_sor_cnt;
 	rm->sor.new = r535_sor_new;
+	rm->gsp = hw->gsp;
 	rm->ramht_size = hw->ramht_size;
 
 	rm->root.oclass = gpu->disp.class.root;
-- 
2.55.0

