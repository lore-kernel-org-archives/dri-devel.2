Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA37CD6E5D
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 13:59:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55EB0112B5F;
	Sun, 31 May 2026 13:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B2Ot2brz";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 689C811274C
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 09:45:06 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2bd9c3b550aso100550165ad.2
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 02:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780134306; x=1780739106; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UsfY8GRrXZdSk9lyMdgzW2ibIF3DXFt06J5TGlB1HVc=;
 b=B2Ot2brzsauA/Ylm94bSI7hI12CkXlsFdjHpFCz2erj8KQ2a1KWJ4tpk2wQGprOsLs
 UFUM0X2yawBqQR8xiTBDlwxIzkCSP7btCgMkhpGwfgNnst4Oa8W1GliargXZIHS0OENx
 gpvQ82qisZd2Rv+Hoh4Ly061HyG3l8KbiqoN2CAK1jPl0mqERWMrHKlJkN44bpeEB2GN
 owCR7T3mqTIwqUXMkv0GOxvq0ZT2nJjnbpAFCRGxAYihBY7AFhk1vJPyOIyXF+fT3auH
 3Ib7BeLXnzBlqYQ3LMtfnrvntIGnMrnnAqLbG8VC0fnnSsyrDwHCNvjS+DHsZFjZp/iq
 QgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780134306; x=1780739106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UsfY8GRrXZdSk9lyMdgzW2ibIF3DXFt06J5TGlB1HVc=;
 b=Mj+L9kKHRAxWNomfgLwBds7AO6cstNDxFbVBOvuzGQj0587RC8ZKUmjayeE5+QjOtq
 wFqb38pUlWbiPkZGrObKsIX4wL+tRhv4kPsrKK07xi/xZCBQf8j2g4L7MpmUD8H7yhM9
 2/epoglb1XuF+Ux/bgjbCFufiiq1mBJha01wzXysKtnDOg5ZYaqy6ij0puxP/uL/ZIUE
 3t1u/SVGfV/Tc6DDmwsRtwQGJktgGOUz9M3bV/z2Uhh6sK1k3MkcYsppqBKWW3qdQ2R6
 OM676gq+0BfauaxLmFQeFiYMuEJXVf0oqawSxLCs5MksLlDoMEXs6yg9ma401gOzoyI9
 wKRQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9vY5d8nuUYWcHXhu0jyvLd9HwarF7FAMY9lwyW3jJcWxJK+xF5sxrxTasrRVeWSKHoniB5IgsHZ34=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzaURZTTKaLvLGijlXI6vou8JneZa6Ju7mTkcX9xG7N0nXpElLU
 H23qTBi0DM35HgnkGclFRsMExk0CP4b/GvIr/g7apZOXVvd+PzRY9QgO
X-Gm-Gg: Acq92OFfcvgByYvEOK/RDsFL3jPO6O0PVYGsTG/RsyFyLXOqGryRfQ96DfPm9ev2JN3
 ra9xsGKxbkb3nHWzem6ZmPmGSV7PWgUc9hv0cEOEgQkWwyLiuZ9Mu3KlqBJQzjj5qDEwVnlpax1
 1JAIqiUrb3Poc05ZWsr/5+2foi1Ba1JBHsozufFR21+ZEFHe4Urr/xs4sC4vxhC+AmSQLGq129W
 pekttt88fKYZLX5OkDtD1BQYiSTQjlB+PETRF20Dr4a3o4NpnGX1v9rg5w39FIvoDE4Is2kpF/K
 V3hLnkmcbMzlFw3MlINKDItx48wLnC+zRUnvWqSowcmlafeTFheESnQWu8tVMkMWMrkC2qa18eK
 UQ36VYqZIuMWhpCL36+3UljSqdPlJpg2OEYNIVOVWVnwnPgfNHmFrZcemoj4x4amh0OhgK0ZcfA
 P6pwlCPW1OFLeOT+gUfqnTELiXwBuawjdO8w1yi7tezw==
X-Received: by 2002:a17:903:32cc:b0:2bf:23ad:8598 with SMTP id
 d9443c01a7336-2bf3679336dmr37430715ad.5.1780134306001; 
 Sat, 30 May 2026 02:45:06 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.191]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf239e700csm61529945ad.10.2026.05.30.02.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 02:45:05 -0700 (PDT)
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
 Hans Verkuil <hverkuil@kernel.org>, Maxime Jourdan <mjourdan@baylibre.com>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR AMLOGIC SOCS),
 linux-amlogic@lists.infradead.org (open list:DRM DRIVERS FOR AMLOGIC SOCS),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson SoC
 support), linux-kernel@vger.kernel.org (open list),
 linux-media@vger.kernel.org (open list:MESON VIDEO DECODER DRIVER FOR AMLOGIC
 SOCS), linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM)
Cc: Anand Moon <linux.amoon@gmail.com>,
 Nicolas Dufresne <nicolas@ndufresne.ca>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v6 6/8] media: meson: vdec: Configure DMA mask and segment
 size in probe
Date: Sat, 30 May 2026 15:12:52 +0530
Message-ID: <20260530094326.11892-7-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260530094326.11892-1-linux.amoon@gmail.com>
References: <20260530094326.11892-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 May 2026 13:58:31 +0000
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

The vdec probe routine did not set explicit DMA constraints,
leaving the driver dependent on platform defaults. This could
cause allocation failures or fragmented buffer handling on
systems with stricter DMA limits.

Fix this by:
- Setting a 64 bit coherent DMA mask with
  dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)).
- Configuring the maximum contiguous segment size to UINT_MAX
  via vb2_dma_contig_set_max_seg_size().

This aligns the driver with common DMA setup practices and guarantees
large buffer allocations work reliably across platforms.

Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260521090944.F35401F00A3D@smtp.kernel.org/
Fixes: 3e7f51bd9607 ("media: meson: add v4l2 m2m video decoder driver")
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/staging/media/meson/vdec/vdec.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index 4884ee04b352..f99335effe17 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -1064,6 +1064,15 @@ static int vdec_probe(struct platform_device *pdev)
 	if (IS_ERR(core->canvas))
 		return PTR_ERR(core->canvas);
 
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set DMA mask\n");
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

