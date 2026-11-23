Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E02606A322
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=QCJB8BAM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C15B10F34A;
	Tue, 24 Nov 2026 08:39:51 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DF4F10E7C0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 14:53:59 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so19055915e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 06:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1795445638; x=1796050438; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e9DOyZqREfCbWSQdjYH3Cx6SxSP6lHmhvZmakX1uIME=;
 b=QCJB8BAMzoCIAvJru6lwMlotnsy1V4EOHCXhd7gPhDUS2inDKxI5Rae5q17sdxEprg
 K/xViWc7Ubx4rn3/Y7eElojre2Z5JD4Oru8nub1wzdD3fpz3//0OdWSJXvsU4XoxLWv/
 S1tl+U30zZ5jEk93AnpiKRi0Xgv9TV0WHKmSFvdEENHoTLLi1qouTHCO4w/LcChWKLf2
 VZLj74ZUYNDMSKo4WtTzRxj5rDr9ITaL+Hm2QUwRjHzUbsyDuQ65pW7s1Yp37zMmaK8u
 WesfFgObvK9yc5h3ulNaJD0kxb+lgmaMomW5CfzX+bMd8qlHBMmmidERZtu98/sEmeIk
 oc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795445638; x=1796050438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e9DOyZqREfCbWSQdjYH3Cx6SxSP6lHmhvZmakX1uIME=;
 b=MNq1PFXvnI5B9qV3m44lT/Ux6gewjLvxD+lHFqL3cENYNgiWqvuMWMYOhfxNjgolQq
 rR+grPgg1zl3PE/1RjajcGccUp+zth79iXKSFRiWPi9Kvzr9oJ++QQPgvDlI7bHM/prO
 j+kPx+FqAy8pKO+noz+mRPFlGYSTEM4/Ic0gic1a2GhWwUl/pPSHdLmpOsWlLg9ybFPt
 FiXlU3SC7uPSvzfOKSCUMa913SO5cWaNeNgViXOJF/kZ4ic+5dmtugz45xmXmoMDquM8
 HfbY6BRijbyakUXRfTf6uMGFpQrcejv7OG8X6944AE3CpdvLHrTRVPPYxpRFuwU1eBb/
 sEgA==
X-Forwarded-Encrypted: i=1;
 AL+hErE7hPXR9nVV/2xOX7M3DEax3TNP8gHMWRgZsP/1IFZtrAmSoQis7GymdcaE2Eb2wEWuOB0V6Szo/Oo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/EJj7MYlcLK/Co5uTc0D+Em4fDbi7lvBrqJzCiifASpnS0hSrF
 oQBySPJeuYvSQJ/JsPISoyPCaj2Da8DZfZ7Uk+lssVbK/pL64dSFvGyzQ1eT6cQKrc0=
X-Gm-Gg: AZFdTZf5pPziEaxtjWV5wmrdIufIgrXj4nZl+3Zq++RDBBgm9U3+Nh+k+CTrl95O7J/
 A1bRiusOoHrVFqpWBoVfnrMubtCitGVrtou+JqxA7TZMPK6ZGB2DKT/nijIXyOGRU5OHfqDfq4+
 GNX92PtGlvbC5mJKZYJ8q+eXi99eVrjErNThSUCa9YkyeS5Zz03FxkPUPvVgOsbFb0/BXmXIH4x
 QxmTSPpj+N34HQLnOVI18pgq8FQwOcFZkBY3ZGfX+gaH3kKA57psr6rqecQkVcD8b/FB8FfVZm/
 0zwBc7hDo5KlW3wgZJVQFwtYg87/zpEMwXxVN2slOBcrZqe/A/W5yjbUrdlxD4EfLMEow2z4f4P
 8vhWiMyS1c5OvTkgcHIZ81xd+r4xwv8c09jbUGc/6oo7XJdmRhPreOJ2vBMf34K0iJyaXfw2KtL
 Q+xL8NKkpKRAfqyOJuaNE4Gie4qUu8iftF8PoNKnF23EVKStMMLZxc1ZtyOkBaHntAIZXSUB3hA
 r4ZtiOnjcOLyM4prIA8oNgvcBRy/LyRQimBh8eFhw1BnfS9kenxC/4TWWAL4lRiuZfFUTpDPugA
 F6FtwLo8U0gLsBP3XY2h3hgoOAE=
X-Received: by 2002:a05:600c:674b:b0:4bb:6947:3e1d with SMTP id
 5b1f17b1804b1-4bb8892c0fcmr226742705e9.20.1795445637861; 
 Mon, 23 Nov 2026 06:53:57 -0800 (PST)
Received: from localhost ([82.192.120.76]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8526cbd0sm469509035e9.0.2026.11.23.06.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 06:53:57 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Saenz Julienne <nsaenz@kernel.org>, Stefan Wahren <wahrenst@gmx.net>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Phil Elwell <phil@raspberrypi.com>, Dom Cobley <popcornmix@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Andrea della Porta <andrea.porta@suse.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 18/28] drm/vc4: hdmi: Pass the CPU physical address of
 MAI_DATA to the DMA engine
Date: Mon, 23 Nov 2026 15:56:56 +0100
Message-ID: <20261123145728.29082-19-andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261123145728.29082-1-andrea.porta@suse.com>
References: <20261123145728.29082-1-andrea.porta@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:39:44 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The address of the DMA slave is handed to the DMA engine through the
dma_slave_config, where it is meant to be a CPU physical address that
the DMA controller driver translates into its own view of the bus. The
driver instead reads the untranslated address out of its reg property,
which only happens to be what the BCM2835 DMA controller expects because
the DMA engine driver used the address verbatim.

Now that the DMA engine driver translates slave addresses itself, use the
CPU physical address of the register resource and drop the comment
describing the old workaround.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 2cc46036f11d..9dc1a67aa7fd 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -47,7 +47,6 @@
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/pm_runtime.h>
 #include <linux/rational.h>
 #include <linux/reset.h>
@@ -2288,7 +2287,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 	struct snd_soc_dai_link *dai_link = &vc4_hdmi->audio.link;
 	struct snd_soc_card *card = &vc4_hdmi->audio.card;
 	struct device *dev = &vc4_hdmi->pdev->dev;
-	const __be32 *addr;
+	struct resource *res;
 	int index, len;
 	int ret;
 
@@ -2324,22 +2323,19 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 	}
 
 	/*
-	 * Get the physical address of VC4_HD_MAI_DATA. We need to retrieve
-	 * the bus address specified in the DT, because the physical address
-	 * (the one returned by platform_get_resource()) is not appropriate
-	 * for DMA transfers.
-	 * This VC/MMU should probably be exposed to avoid this kind of hacks.
+	 * Get the physical address of VC4_HD_MAI_DATA. The DMA engine
+	 * translates it into the address its controller has to use.
 	 */
 	index = of_property_match_string(dev->of_node, "reg-names", "hd");
 	/* Before BCM2711, we don't have a named register range */
 	if (index < 0)
 		index = 1;
 
-	addr = of_get_address(dev->of_node, index, NULL, NULL);
-	if (!addr)
+	res = platform_get_resource(vc4_hdmi->pdev, IORESOURCE_MEM, index);
+	if (!res)
 		return -EINVAL;
 
-	vc4_hdmi->audio.dma_data.addr = be32_to_cpup(addr) + mai_data->offset;
+	vc4_hdmi->audio.dma_data.addr = res->start + mai_data->offset;
 	vc4_hdmi->audio.dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	vc4_hdmi->audio.dma_data.maxburst = 2;
 
-- 
2.51.0

