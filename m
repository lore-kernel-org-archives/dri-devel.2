Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90288606A333
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ALPPIaO5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7DD110E5C9;
	Sat, 28 Nov 2026 09:41:23 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9107E10E3C0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:19:08 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so65191785e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 04:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1795781947; x=1796386747; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e9DOyZqREfCbWSQdjYH3Cx6SxSP6lHmhvZmakX1uIME=;
 b=ALPPIaO5ce3qUrGE9FSrBetEaco2EZntAZqz4bzrAWolfuo1dCdf5k/3HlXw67lgXT
 ZODLAiCeyfTk2XOUScVvrwXEBUCbvHBBxZsqLEYw8Qp8zOK3eiPvg3Jpro9PJYP6+26i
 A0qHcrY9XoFHaibDcx11tfXCFboY9OhDRMBvkJoIZ+AWAjlMkrQElzf65epI2hmHW2mP
 E73uYFkxqA5iFBKNsJpnwisGoQxQKjMr9nrrEBsnKIOcs2dbszFZ44v09O5IyPiTTU6r
 SM46MFouelSRydEnTFPOetx9FHR76WtG7T4Dz4lkzZJEW02POiALpyXzhNKNRXygOw9c
 hDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795781947; x=1796386747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e9DOyZqREfCbWSQdjYH3Cx6SxSP6lHmhvZmakX1uIME=;
 b=bvLd+ePL4ulnm2pDMpN+HjFk/7olWnEIdIc0yG3E2DLLSCbVDktoAjN1LwdnG43IYx
 YbBw3kOJhAHRUIaRXIBQ0INXSRqvW0mU5jV5rpa/JZFnDzZxn0G51OYjXjLU7zexVZd4
 IPp8AVHZRqjD/B8GE9OYmMcgNjrtgpgwKn226A1cAV+jnSHrJcRWGqZ0Sgnj5YecrRWI
 YUaZdJDPFlAzXVHVCrdCsXd2R4DJ/svldz3+Y7ez3ff9Lz4DFgTCG5sBtckDZKI7ns5N
 25CzN5YAOz5pWJtiAQQyhHu0/SGNb6sM5tDDyV3AfDgkMP8z4lPtLF8lAPNZ0UaWq8QX
 lLOA==
X-Forwarded-Encrypted: i=1;
 AL+hErGdT3lUp23O7KX546Ein7YtroS1G3C8e+gulXr7A3lpZmpR2maoy9i4r5OhHw6FE5EZ4ZYlhHjAFPM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8nJmGpposq2Xfihw+c7fhfdNLfKyggiBEvBCIFcLw4+Rix6Fcc
 Qzy0xCWvfUMGpxiYBqQ3Xvirda5lrTlMvJ9cBEY7iUwmFpECzS9xi82kc79sgRHh9v8=
X-Gm-Gg: AZFdTZdPBlIpFH4/Fsdgi8//uYNVPaFUELrHzOAlUGtWcIOVtqWZCO2/Ag+BXNcdzOT
 68u7fECuPvJVqKxbNCVjRx0WqPD1Q+qfcX3JKVuDXKJxAyClKXGpx09ANNIZpStHjodYv/yE39y
 c4WKywYoSI87V9hLcOjuTbakWpggQ83iPaYt2oChuTeeZrH25AhGI/P0zkzpIBRvvux1wLVWhqb
 YVR+D2uYgcsniMogZyOgL65yQs33p9u/0087xd/jNTUiLzIFRK2VNOH9oCnVfKA283g3IHtljyH
 9NHn9j2VjLRNmA/NMA12HppM4/SD+eTr/xwgyqLW/nXWxobksxcRBZ/urXE3ISwRAYogApQv9Zu
 IOkcojzNWDe9HBlQVV5fMgrcrpZUYo1keD7CaSOVmrIeOxuoOfSJwky+oVxjPIamwhnl92vdOpj
 6qdONeHsaavqQxffkeTKrGbC3Hm44gk5SnfXUPLiJhGo9cxl/gFPrsUJ3B2Z5HQqtWwp8lzOecT
 hTSnSbjC/StG0rxyxNU7kJr3Rh8zSbYGcOBkF6JpexuZCy6l7Ag3TDCU4dr4sC/k5uwsPry859n
 LyczETB6qD+dqoU7gL+cFZud0Z7vBXfIc6AgSSqaMHFOTjJN7g==
X-Received: by 2002:a05:600c:1389:b0:4af:83ad:8f70 with SMTP id
 5b1f17b1804b1-4bb88924f66mr488154985e9.35.1795781946969; 
 Fri, 27 Nov 2026 04:19:06 -0800 (PST)
Received: from localhost ([195.94.148.180]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb9065744esm373251435e9.1.2026.11.27.04.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 04:19:06 -0800 (PST)
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
Subject: [PATCH v4 18/28] drm/vc4: hdmi: Pass the CPU physical address of
 MAI_DATA to the DMA engine
Date: Fri, 27 Nov 2026 13:22:08 +0100
Message-ID: <20261127122236.4976-19-andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261127122236.4976-1-andrea.porta@suse.com>
References: <20261127122236.4976-1-andrea.porta@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 28 Nov 2026 09:41:00 +0000
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

