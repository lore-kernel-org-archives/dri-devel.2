Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3961BC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 23:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85D4A10F4B6;
	Fri, 14 Aug 2026 23:58:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qi4pnGHH";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D380410F6BA
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 23:58:47 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso14544425e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 16:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786751926; x=1787356726; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YPXxPr49E5YFipy1o/O5phwWh+kr0p/UDA08jPQpFV4=;
 b=Qi4pnGHHd54UkrI3wcFtZvFVY5Fe+Xc0fmxBW466+V6Y7+XFjpXxFNz7VaW/PymEy8
 PNcE+YYp4tVyWCLSI+2vlxfGoDMi0Pf9CP98rQGisioU5lKvEViTSsXCXAsR62GMBsdP
 bE9s1dkpcge4iUBaeohx+n09eU1Zc/KFaZASjmLXWsZfTyJo7s4sjhgdC9Cr6EjmyyYY
 YIrNxo8q8uqL5WwJT3EkzlnZzGx61S9ZkBn5WhjDClxF5qkoANXmAZMl+BV3ATxNt4lX
 MA3EJMTMYBuVDAl7osKnrJZX98csv66m2cn2nwBOvsTbluEZsTjtDsORa5Z9rPvra+sG
 JB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786751926; x=1787356726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YPXxPr49E5YFipy1o/O5phwWh+kr0p/UDA08jPQpFV4=;
 b=rs578h8VQJakN9QYZ7kqrqotHwsxOnasE8WiXucED9qgUc3xOFywjPbXPh0Icg1ecs
 Gq1DRp0Hgv3uaHM5I/dJMmOMCAECMMBR1n4yvXPMOJpiFAupr5s2l25zpQwhrvqdovmI
 a7Kd4vS7WZ8PBMA4Mi4N63GoacMZrG6XK4meqigW7bbxxR6acs87U+gpmHynSyLbzEcy
 3L7bdEuVbtijFr8pPbdBev/iP5CvgT7ASMDo8FJ55r1e7prEH3d5Nt0Q49R4d1g+pjS3
 6xy0bWoHYPZbu48fzqEITcgAsXOUPPvRZnZYAReu1Z6SR4gWxEywEW68zWIxTdSY7v6C
 aP0A==
X-Gm-Message-State: AOJu0YzshN56UWjhVYHw8MFaf+/yCzUCzdRdHvccj2nt7umenm/mHtJw
 eR5R+xVw74omuUp+fd/USNHhAgUwniSUBeIT9/19ZpLAmZAZE+PNek/s
X-Gm-Gg: AR+sD12OnMdMHDigRGXHfXHhBjFqON3/7ByNh6buYBr33ubmgy+njxebfsfHxomT8da
 6PUoyauMKLUtnN53DQa4pMJIRyJQyiEvLT+VpBdQOTTn2NJ+4C/hMRvaj5j5v4hPyedlf0yC1u/
 iQ7xQAswNZ1NAMZKAMO15zTDPLHfUD70WfJo+5JcWVoQYdLFvWicChFvIwcY2Gj7WbPMzVQnyFi
 YiUC/+SjOJaNsMZfZScMoOrFBuO9l4+C8ByZ/kOFUNA41tjGoCAlP/ZP+CXLXhp3AUiI4wVbBtr
 9Nyp+/MmJZdhFQOnzBl+A/PaoTXbL9AfTOSHfx1EQzUoys3vp6Ed3jYb7cSdSVUNhFlJPUgfP8C
 w9M2O66K+A54U7paKFln6Z3WCn1FPIPAUSDZe23W4kPeftldiz+2HGQRVE/Gxef5ut99sP+LwtT
 1hI4FCzp5pey1ZAsiTZMo8AmLzJUOkySJ8q/UV9yFrVzm7m//86Z1g6qI0lorsJezI8LA=
X-Received: by 2002:a05:600c:6051:b0:499:737c:8a8b with SMTP id
 5b1f17b1804b1-49987980774mr83702945e9.12.1786751926216; 
 Fri, 14 Aug 2026 16:58:46 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499899753ccsm77751245e9.0.2026.08.14.16.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 16:58:45 -0700 (PDT)
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
Subject: [PATCH 2/7] nouveau/gsp: fix HDMI vendor infoframes on GB20x
Date: Sat, 15 Aug 2026 03:57:00 +0400
Message-ID: <20260814235705.59132-3-mohamedahmedegypt2001@gmail.com>
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

The GSP path reuses the GV100 direct-MMIO infoframe writers on every
chip. On GB20x that is only half right as while the legacy SF AVI unit is
unchanged, the legacy VSI unit at 0x6f0100 was removed, so
gv100_sor_hdmi_infoframe_vsi() writes into a reserved area and no vendor
infoframe ever reaches the wire. This affects HDMI-VIC signalling which
can impact some 4K modes for legacy HDMI 1.4 sinks.

Select the SOR functions per GPU family in r535_sor_new(), keyed on
the display root class from the RM GPU table and use the new
generic-infoframe VSI writer on GB20x. Everything else stays on the
r535 table.

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
---
 .../nouveau/nvkm/subdev/gsp/rm/r535/disp.c    | 29 ++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index 1155f079b0c3..96febd01da78 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -36,6 +36,8 @@
 
 #include <rm/gpu.h>
 
+#include <nvif/class.h>
+
 #include <nvhw/drf.h>
 
 #include "nvrm/disp.h"
@@ -587,6 +589,16 @@ r535_sor_hdmi = {
 	.audio = r535_sor_hdmi_audio,
 };
 
+static const struct nvkm_ior_func_hdmi
+gb202_sor_hdmi = {
+	.ctrl = r535_sor_hdmi_ctrl,
+	/* The legacy AVI unit is unchanged on GB20x. */
+	.infoframe_avi = gv100_sor_hdmi_infoframe_avi,
+	.infoframe_vsi = gb202_sor_hdmi_infoframe_vsi,
+	.audio = r535_sor_hdmi_audio,
+	.frl_train = r535_sor_frl_train,
+};
+
 static const struct nvkm_ior_func
 r535_sor = {
 	.hdmi = &r535_sor_hdmi,
@@ -595,10 +607,25 @@ r535_sor = {
 	.bl = &r535_sor_bl,
 };
 
+static const struct nvkm_ior_func
+gb202_sor = {
+	.hdmi = &gb202_sor_hdmi,
+	.dp = &r535_sor_dp,
+	.hda = &r535_sor_hda,
+	.bl = &r535_sor_bl,
+};
+
 static int
 r535_sor_new(struct nvkm_disp *disp, int id)
 {
-	return nvkm_ior_new_(&r535_sor, disp, SOR, id, true/*XXX: hda cap*/);
+	const struct nvkm_rm_gpu *gpu = disp->engine.subdev.device->gsp->rm->gpu;
+	const struct nvkm_ior_func *func = &r535_sor;
+
+	/* NVD5.0 (GB20x and later) reorganised the SF HDMI packet units. */
+	if (gpu->disp.class.root >= GB202_DISP)
+		func = &gb202_sor;
+
+	return nvkm_ior_new_(func, disp, SOR, id, true/*XXX: hda cap*/);
 }
 
 static int
-- 
2.55.0

