Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F81AC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B774E10E962;
	Mon, 13 Jul 2026 12:12:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lRCQb18t";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 144A610E96B
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:12:15 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-c9aea40d799so1328531a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783944734; x=1784549534; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bCvZS+UotNJvFZgti0pR+2qbKuDNmgfw3z2iv69lpMk=;
 b=lRCQb18t/Tui4PAE85gQEP8qwTDsrYMcuUcsBpgmaNdSzFfMk5f4mPb3PCrVhA3jBm
 dyDx6ghz/VShuSOk6XUoRpLzthpdDMEpNmR9t9MmTgq1kdyJIHGTV7q9MJf5cfsms9QZ
 4fXfSLEnSZAwlhAu6KeplK/R2zZfgOkEw9395n3nFZ2qgGuZyQPZZUBowukR56XHA6e3
 waFVeFnjWnpjyXufpj9pB25F5JcGdK1i+bG6qA15P4MQYh49U3cVgm4CTEV0FR7v33cF
 KdsmB9beyaRdQ2Mhfk/47Eb4r20P2pNl28BOo2s+FsFToQc3goRHFYAGUHDYC8wGlsSR
 picg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783944734; x=1784549534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bCvZS+UotNJvFZgti0pR+2qbKuDNmgfw3z2iv69lpMk=;
 b=SvMytjXUPS5fk/Tk65Vp3Itq+RvsZn2RUKO7TBF0nKBeJmngZxNf31CV/EnWB62J+3
 ghCDEnTdzPWZyEyAKKpP561yO4JkWaEU7zw4SBcZnPaknHXgOA5rEn9562UDTBCbR1Xe
 inLsztrQEdriQ9EeYMjXIKBLOR0gOUjh7ByZCNb/D4zQP92ULsBLGYHES/TKd3OaY6p6
 XN8NZlTJbe4phaKn0eV9q1fU0v/unWyODUOuWsSNmuEY/rtKEYkcGpSCtSUiSVud8GxC
 IY0CDwA0Oik+Vsqb+2JR4TyuKsPNvDJ3fdjwR6nMmiQPtPvcS/6iHDxPeHAci1GCV+Wj
 nzzA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/KcFUOAW7+4n5Cr98HG9a0b34B3nZlzTz18M9NHI0IhMkou7a+rgwqKW1lxupV8ok9LcG2rlAfqE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRX5B2edUwJprNyHw57HQPspsUgAzrL1lzcV4SC91oeVEywgnj
 d6lQRYGBth8uD+d27WzPqWkmck30KesznW4YlqkAHpMquMe8KEqsU3od
X-Gm-Gg: AfdE7clPzP8bUJMex4/V3itXGDckgAH+JLo3QFbu/5d/Dp+ISXOfoXiASqWvB+7I0kr
 5SfKQ2fj13pG6V5CyyZyuC0ufOYrnf9b2fA7xS8JqNQ000nbkiM1abnJb9KKFedJ0mBp2tWM0KP
 OU9irl5w2aB+XwaxJnFrT/mO+YLoQcpU0mx3VqKlkhty1LJbAsdf7zZHiVva97hzNhGxoQCDmgM
 7gCxqo7cbWGFXqoobihQELmjRh2A99QUngk5ETlXBX/AIECIz+pW3lyaO5L9ba85UBvTE1c5aIJ
 9BDXWSU3Avp7hAgIFXh9Zemv9OGgcl+yEo3iulW1a8/n0/VjuYhzvql1IcexhJxDk/fEvHX5Qhn
 wRZoGLAzIN7tHwhSLS4EQDIiSOdUAytvdY1YudTVs0SDnMnnDLMjj7XhHlZUcUw/ku3yotrOs4y
 JdbhvIiw1I5A==
X-Received: by 2002:a05:6a21:6817:b0:3bf:80b8:9c8a with SMTP id
 adf61e73a8af0-3c1102d7cf9mr9542534637.6.1783944734620; 
 Mon, 13 Jul 2026 05:12:14 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.180]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f7293sm67756935eec.3.2026.07.13.05.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:12:13 -0700 (PDT)
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
Subject: [PATCH v7 19/19] gpu: drm: meson: Fix DMA segment size limits and
 maximize allocation boundaries
Date: Mon, 13 Jul 2026 17:37:14 +0530
Message-ID: <20260713120840.17427-20-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260713120840.17427-1-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
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

When importing DMABUFs exported by the Amlogic video decoder driver
(meson_vdec) for hardware-accelerated rendering paths, the DMA core
subsystem throws constraint validation warnings. This occurs because the
display controller master device lacks explicit DMA layout configuration,
causing it to fall back to a default 64KB maximum segment size limit.

Address these architectural constraints during the master bind sequence:

1. Initialize and validate a 32-bit coherent DMA allocation window by
   invoking dma_set_mask_and_coherent() with a DMA_BIT_MASK(32) argument.
2. Maximize the contiguous scatter-gather allocation segment boundary
   check constraint to UINT_MAX using the dma_set_max_seg_size() helper.

This guarantees that large video bitstream frame buffers can be imported
and scanned out across sub-driver domains without triggering allocation
warnings or page boundary splits.

Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 49ff9f1f16d32..899e70bca4ce2 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -202,6 +202,12 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	if (IS_ERR(drm))
 		return PTR_ERR(drm);
 
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (ret)
+		goto free_drm;
+
+	dma_set_max_seg_size(dev, UINT_MAX);
+
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
 		ret = -ENOMEM;
-- 
2.50.1

