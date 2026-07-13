Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EB4C44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BE4A10E95C;
	Mon, 13 Jul 2026 12:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZPIvVtex";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0BD110E95C
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:11:32 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so1786722a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783944692; x=1784549492; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PKJfzcOO3DPVFtYYdFmzNXMgq4lw0a0uxvJDNfRGA24=;
 b=ZPIvVtex1TBaiYxYZyqM5eONWd/heOrS+k8mGPWvLZNjKjLWrCMKP61JzQrG3VS1Of
 qypP8oXYF3nSECQZjpsg3Qgsa6nl/s0oT2EjPOQ05P9TjO4r8oYv00uO4qXzRBE6nVNI
 sc7DWNXXPdFyQoLJc2VcMBXoI6Pwk6f9ceCp7kgjOJUEUuGA/dCODixMujgPxsyVc72x
 wDeuducfl0F5Yr0VsPR/+XNDFQsknC7dkSMb/uGTHEP+7QyiRMpVoihdoff4Uta/AkBF
 nC1ABWRA7bkfsKe1KTKm2EVy8zES56mL6cVv0PZhGOa7cU/twysIeNPYF8ho2BZs6mrL
 Tcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783944692; x=1784549492;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PKJfzcOO3DPVFtYYdFmzNXMgq4lw0a0uxvJDNfRGA24=;
 b=Qi4wNCM/5nnSj/mJ5ndCUk4hu8X93ClpBsJM3LVd3lkMFcxLHjQRiJeRAeRr337Z5r
 AfykinqLVujbe5sTcT1ksJZEk1CcSJrrsmvDplJPw2MTC336DTWVIF1mFLMjvKSsfvsG
 /dqKn0jb238sYlpVQtp4HG2RS41JbiPEybLGuiSzJj52bI5Oni10fSDxYjzLv47i2LFH
 vIbF1ywCNFs7f3aGf1JZmrcYAHCYYfoKpIGRlTKwZ+z/3begOCprYu2eqcpc2N9zvkKq
 2Q7X/nVF7Z6sWjtygRlPhXLgXbu763iEcO7XxKCSH2ifU9v6mRwnaojl2R/Z/C2pXrVf
 nVrw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2QdKzibclrKY13Gj4oKH278tDRvqKJoj8RlyYek0DntzfhzLYQJlXpzgceUQmRwnkWKkhMILmkbk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNEsBcvbknmBN6xp06YJMfYF3vhSQEvI95ykchKuHFPIFzQErc
 nFG7cUeGWwXwu+YoVrkpK1VweY/VSDEGgprOWzxV5ekzhCzCRnkSY3vC
X-Gm-Gg: AfdE7cn7x1+JzP52g2LpmWCK4MDAU5ChmpkHTI3aq9iHuW9L9C90fCDtFlKI97+hdeg
 O9LvMsxV+D0LAl+AX58JukQPdykO/6o1x9ziqnGrmlD1dT8lyoeh7Z3CAcQybKCz+DAR2CqS50i
 Tdcgc0PCRcH8u9NDxXbCWPKtuEmPJcFXHEY7HtsF50Li3mGGrKVRIxoDJtTRXizJMg6thPy/JTt
 yLhvkRh31YIjfD5OdyuY+tUsNSue7v8F5yjhZ5KwkwnAr+3B3gqNUr15WeCWSfsIykL+1ulYmsT
 cZM3ctu1YKG8pExxD5Tf1SU8DM9cY5lUdrnf6hIklV3Gu9blE+AdPiethm9ubWs90+LA75tSVKR
 pooa8dd/LvIC2IIhYQEGAOjEUtwuEhSdYuxFSxGVTjopyslcaVjUwhePlOmVbASnnjEywna5+JI
 Pgo3LXdfoufQ==
X-Received: by 2002:a17:90b:180c:b0:38e:fbe:b67b with SMTP id
 98e67ed59e1d1-38e0fbeb818mr766655a91.0.1783944692422; 
 Mon, 13 Jul 2026 05:11:32 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.180]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f7293sm67756935eec.3.2026.07.13.05.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:11:31 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR AMLOGIC SOCS),
 linux-amlogic@lists.infradead.org (open list:DRM DRIVERS FOR AMLOGIC SOCS),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson SoC
 support), linux-kernel@vger.kernel.org (open list),
 linux-media@vger.kernel.org (open list:MESON VIDEO DECODER DRIVER FOR AMLOGIC
 SOCS), linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM)
Cc: Anand Moon <linux.amoon@gmail.com>, Doruk Tan Ozturk <doruk@0sec.ai>,
 Nicolas Dufresne <nicolas@ndufresne.ca>
Subject: [PATCH v7 15/19] media: meson: vdec: Fix concurrent firmware loading
 race and hardware timeout
Date: Mon, 13 Jul 2026 17:37:10 +0530
Message-ID: <20260713120840.17427-16-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260713120840.17427-1-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The vdec_1 firmware loader used static variables for DMA buffer
addresses (`mc_addr`, `mc_addr_map`). This made allocations global
across sessions, corrupting state when multiple decoders loaded
firmware concurrently. Under stress this triggered KASAN reports,
lost references, and memory leaks. Making mc_addr and mc_addr_map
local to each load call, eliminating cross‑session races.

The firmware DMA completion check also relied on a raw decrement
loop of 1000 iterations. On modern CPUs this loop completed far
too quickly, often before hardware signaled ready, producing
false "DMA hang" errors. Replacing the busy‑wait loop with
readl_poll_timeout_atomic(),  providing a bounded, microsecond
scale poll with proper timeout semantics.

Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/staging/media/meson/vdec/vdec_1.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/vdec_1.c b/drivers/staging/media/meson/vdec/vdec_1.c
index a65cb49594465..27363c9a5af3c 100644
--- a/drivers/staging/media/meson/vdec/vdec_1.c
+++ b/drivers/staging/media/meson/vdec/vdec_1.c
@@ -29,14 +29,14 @@ vdec_1_load_firmware(struct amvdec_session *sess, const char *fwname)
 	struct amvdec_core *core = sess->core;
 	struct device *dev = core->dev_dec;
 	struct amvdec_codec_ops *codec_ops = sess->fmt_out->codec_ops;
-	static void *mc_addr;
-	static dma_addr_t mc_addr_map;
+	void *mc_addr;
+	dma_addr_t mc_addr_map;
 	int ret;
-	u32 i = 1000;
+	u32 val;
 
 	ret = request_firmware(&fw, fwname, dev);
 	if (ret < 0)
-		return -EINVAL;
+		return ret;
 
 	if (fw->size < MC_SIZE) {
 		dev_err(dev, "Firmware size %zu is too small. Expected %u.\n",
@@ -63,11 +63,11 @@ vdec_1_load_firmware(struct amvdec_session *sess, const char *fwname)
 	amvdec_write_dos(core, IMEM_DMA_COUNT, MC_SIZE / 4);
 	amvdec_write_dos(core, IMEM_DMA_CTRL, (0x8000 | (7 << 16)));
 
-	while (--i && amvdec_read_dos(core, IMEM_DMA_CTRL) & 0x8000);
-
-	if (i == 0) {
+	ret = readl_poll_timeout_atomic(core->dos_base + IMEM_DMA_CTRL, val,
+					!(val & 0x8000), 10, 10000);
+	if (ret) {
 		dev_err(dev, "Firmware load fail (DMA hang?)\n");
-		ret = -EINVAL;
+		ret = -ETIMEDOUT;
 		goto free_mc;
 	}
 
-- 
2.50.1

