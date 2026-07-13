Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5508CC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD55010E95E;
	Mon, 13 Jul 2026 12:11:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BNOXlS3U";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D8FB10E95E
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:11:43 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-caf45fc5202so769910a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783944703; x=1784549503; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xrLz/BgMOWZJw3Q53MMnd8sHfRljAQMBGTN2LAcpT4M=;
 b=BNOXlS3U4u47OGEFtPsclA9QZnusXkALSNlqq+pj1PKghWAeyAhqYhK/8OEJ6lB7Zu
 d8qpebOoRAlwqzSuQB/vFeK4VV7SQ1n6d14r9A8XobXqffGniod/19+gFrMUlE1WX6Mg
 Qdc5rI3Vgaj4gX1G2iePgp8FwGS10++PK5dRLPPGfGKlXc6/G3PKhDIeyvH5y4kr+izx
 7aquiNePoI2pm5miW7SUGSdTTSez5u0JALJL2PjLkAmkLUHi6SlbYKcdekbn9oJWjJ2m
 X9iQuI/ZEOp60JGqI6gI5XqFqM8R3aN85SD4VRojFmxOl5qeitviJkJ10O4r20MPOGpH
 0knQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783944703; x=1784549503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xrLz/BgMOWZJw3Q53MMnd8sHfRljAQMBGTN2LAcpT4M=;
 b=p67jvD44htAE7X0qEYwv0Hl00t67372BLtzg1SrdxioAPP22V2+4vVE3TNqbbNdWZO
 j2EPJFUDjrwVdkGJyGxgh2ia9wfMn07Lf1gXbX7+sAVp5Iq0+qtuVIk/UnihnoydupbC
 6Xmsu1rLLVGtKAZVjTSYOh7M2vnn8LtV00GJcYl4/zycuV6q8Wrsi0cupJZHIBb/dsMO
 CjM8LryB0zTKgAsHTYs+1NwASjOmL0u7IP754cwSPcHPxgyia53XpHa1DyZRq7Y0HpSe
 2gDhZigoLFaz+ORG6GzyGS0sKAff2VwBhWbdKXjZ+QdXPaLUgq+ah/n14sTY/986Kkf+
 0mLw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpnnwNfQqPvbYH+nywhe2KGAlJ8cbfli+ULhn/+I2A4++QTMZYRHjqKBcC145gW79MLld8BflOn5no=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8gbbG7Iz1LCQ1wQdkKUX53fsbGXpjeeps7TH3Gqh2SOVbsPWA
 qjWU3hskiDGnefqki+60OxtCDbR1DMe8qgMlLIbIqHd5NegodxJO/fio
X-Gm-Gg: AfdE7clgjRY5DmWqxo1xnhlSbNUgk3GiJ/3EtS58KEAf+IB44p55B4J2xOlnI0OnhmO
 QyDs/5n0PEzz0WwwkufO1toVp2KBCJ3TDYbgKBQAyK1CoQx7+ubssyz2EJ/wEyUqbHrAoPN7S3+
 WhMvXCJjA4mIdI85z3rXK1pILDsG3GmEl5jClCusoVWGsqsIKev/OgRyOl6XPW4Vji9QiYYQVA0
 XWZcHNkJJ4Ur3+BahbDCeD1OJM8hT4Oy/6aQErb5DcecgDYM5xDJAr3WPNsOLS+joGqFINSXEYm
 bZwfW9FGahQjppc7pHpVyJigOyS0ftImCdZbq8bXY60y0YNGSPJWIku7PmGEddkG/IgRG9Wf0zZ
 sVYaw26bQRV0Ts01ifj9Io0nI25kqMOIzOHroYge1/SSWJXQ6ndWhWX3bfPQsmSWr457YPcNgZ6
 x89E/a9ZFpZw==
X-Received: by 2002:a05:6a20:da1a:b0:3c0:9c18:d5a5 with SMTP id
 adf61e73a8af0-3c111073a84mr9971121637.66.1783944702870; 
 Mon, 13 Jul 2026 05:11:42 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.180]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f7293sm67756935eec.3.2026.07.13.05.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:11:42 -0700 (PDT)
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
Subject: [PATCH v7 16/19] media: meson: vdec: Configure DMA mask and segment
 size in probe
Date: Mon, 13 Jul 2026 17:37:11 +0530
Message-ID: <20260713120840.17427-17-linux.amoon@gmail.com>
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

The vdec probe routine does not set explicit DMA constraints, leaving the
driver completely dependent on platform bus default values. This lack of
explicit layout initialization can lead to allocation failures, restricted
address space mappings, or broken contiguous buffer handling on
architectures with restrictive DMA layers.

Address these platform constraints with the following changes during driver
initialization:
1. Enforce a 32-bit coherent DMA allocation window by invoking
   dma_set_mask_and_coherent() with a DMA_BIT_MASK(32) argument.
2. Maximize the contiguous allocation segment boundary constraint to
   UINT_MAX using the vb2_dma_contig_set_max_seg_size() configuration
   helper.

This guarantees that large, contiguous video frame allocation requests
work reliably and explicitly aligns the memory management paths with
standard Linux kernel DMA management paradigms.

Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/staging/media/meson/vdec/vdec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index ac86a9c4febff..d33cbebc4453b 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -1186,6 +1186,16 @@ static int vdec_probe(struct platform_device *pdev)
 	if (IS_ERR(core->canvas))
 		return PTR_ERR(core->canvas);
 
+	/* Enforce strict 32-bit DMA limit to match hardware capabilities */
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set 32-bit DMA mask\n");
+
+	ret = vb2_dma_contig_set_max_seg_size(dev, UINT_MAX);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to set DMA max segment size\n");
+
 	of_id = of_match_node(vdec_dt_match, dev->of_node);
 	core->platform = of_id->data;
 
-- 
2.50.1

