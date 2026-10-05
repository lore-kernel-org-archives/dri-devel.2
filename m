Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB140CA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 06:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 287D210E9F8;
	Mon,  5 Oct 2026 06:46:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oUL3C6R2";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BFA410E9F8
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 06:46:53 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a11603310fso12938965e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 23:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791182812; x=1791787612; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=14533aMWhAmVs8SNCRLlWVRuMICBt1zkdaHBPEpaQzs=;
 b=oUL3C6R2WR0TNGV1Ks/PkaycJwZvZCgHX7veGe/E4xdimo7mLYUWvj8g3jvJBeSGRV
 PFuDwgzMwqRXZWzJGcz1zRkuDSQiT+mxiPxisqxmWaqoQPSkFibjgK0KIWCH9X8eamMs
 CZZPWQV/3LdSktc/yzHFEoCMKfQxTZNdT7C6cYqxKXGUPJbDxGum70uPSCTjzxdX0v+z
 kYq0occ8RdIELOjrIkdzTaYKLDZQgsbKTWY2n0UVdTmBiNuMdESrX/Kg35RqcbVlX/FI
 DwWxtPcXXFwb9KpOBtviCANjVvoBViqs4mfmmU2qLFWhatoIOUBEFDrPdc+YiR+/oHlM
 nCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791182812; x=1791787612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=14533aMWhAmVs8SNCRLlWVRuMICBt1zkdaHBPEpaQzs=;
 b=sazX3+q2WxrUp4m8MgEF8HdcXU91bfl5tmnGtHDtROmk6EgBU+6Efz1ov/Gi+8NW5z
 YExo8oKIbiYQDCMFtEdXx389Y+WOIH5CnjK+j3wXCHwwgFNEqdt3yditA6H1m8Beh8Qu
 co+www1xEfrEa7v2UWCldP5e/2Lcmn4P5ebSLvQcgfg6FrPGi05F+GtENIYTpZJCG+f8
 NwoW21ZSaIvWyvsKllC2OMxSwb7nrsf3LWxOVJjbHyebTWaWYUITgoso/o7rZ8Bzy9Li
 N2D0X84xFo3LiSHLWsWYzKO+U2lbg7uhIYcYoYWFBPslDkaZ9qbaCe3ioaLCOZgu2wsd
 SrCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw9IWBqZk1MAFT2IOiI/23a707wT2OaQm3iJR0gXF3KAuk34xHnmWfp2mD9X2xFC4WuGOjyOYuxH/c=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m5LVYdyXF99W1OzSNTHF+irhmMABAXtuqB5CoviAbtmPxr3Cvd
 gDHMvew54Zxsn8ToFMEdp1ppvAtKVqbZGBKHb5kRpmHGEA4KRceeqqUN
X-Gm-Gg: AYBFou3mKVggMlH7WawV0F0zecI+v2DgCog9KShC51YTkzGRO28EGf8H83J2+tyR+rl
 jlR1ShfWbgsE7fHCipHc3KXTzWhwKXQfenjeIpRloEi8n5p3h0lNnpK2/H203vpKdzUZdPMygog
 1kywINT7z0fi0LSayu8lM4aCIzxyVU7s0QLZLWDfhFv3Gy24InqC/9ybVhjPtEoL8RMVj3PCrCe
 wLvW5OjvNjxIzD7jOncCvgMPNRUY6G2u7My8BfXAXLv3mE8qtocqdHFEbn1weDg4lRm43LaIYbe
 mApGI0ZRMEPAMNobYOkommqcpsnUaVdTLtHN6qh2nYN6C+TRWWsXQklBI7AP0+A9Eg09fgshibD
 NXedooinbFdql+gv9RN+Q0aF71BQeKuMCZKf4b32Cz4K9ee0XE0q2+mLWoZseW7Ri0S1k+MPyr+
 jGWoZvNkdzCoduB3WX9RJ2J0xpMvx60NE0dYUj5ZWff062demIi4JLmAnXilDeAT0GG9cPvJrx7
 QZJefOSuCo7Qy2BwDFlKir3wi+KsAtVzUuYE22Dfl/Yc19b0NvZgma/Xi2tYS7jeZABIs8fz0eh
 /7IaaX6RzsBHS/z8Y3CADKZoh/UF7AfJh4McUsC4b8BGwC3zWJC8wfWEsw4i+28Wz5UGVPILaUQ
 gBALJ6aLCYhS8
X-Received: by 2002:a05:600d:82e4:b0:4a1:71af:cbc7 with SMTP id
 5b1f17b1804b1-4a171bc2193mr44005545e9.13.1791182811349; 
 Sun, 04 Oct 2026 23:46:51 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-b305-2001-39fa-3d24-821a-4eae.310.pool.telefonica.de.
 [2a02:3100:b305:2001:39fa:3d24:821a:4eae])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027741586sm315273615e9.14.2026.10.04.23.46.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 04 Oct 2026 23:46:49 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T . J . Mercier" <tjmercier@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Dmitry Osipenko <digetx@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Russell King <linux@armlinux.org.uk>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm/armada: set an unlimited DMA segment size
Date: Mon,  5 Oct 2026 08:46:39 +0200
Message-Id: <20261005064640.7776-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261005064640.7776-1-kmehltretter@gmail.com>
References: <20261005064640.7776-1-kmehltretter@gmail.com>
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

The driver never sets a maximum DMA segment size, so the device claims
the 64 KiB default. With DMA_API_DEBUG, importing a larger contiguous
dma-buf reports:

  DMA-API: armada-drm armada-drm: mapping sg segment longer than
  device claims to support [len=1228800] [max=65536]

armada_gem_map_import() also needs the buffer as one entry. An exporter
that respects the 64 KiB claim has to split a larger buffer, and the
import fails with "dma_buf_map_attachment() returned an (unsupported)
scattered list".

Set the maximum segment size to UINT_MAX.

Verified with a QEMU stub. Not tested on real hardware.

Fixes: 96f60e37dc66 ("DRM: Armada: Add Armada DRM driver")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---

Notes:
    Tested on v7.3-rc4-70-gfe2ec83746e5 with DMA_API_DEBUG on QEMU's
    xilinx-zynq-a9. The LCD controller probed from a stub device tree
    node, so all registers read 0. A test module registered the
    armada-drm platform device, because nothing in mainline registers it.
    
    Creating a framebuffer from an imported 1228800-byte CMA heap buffer
    works before and after this patch, with one segment-length report
    before and none after. With patch 3 alone it fails. With patches 2
    and 3 it works.

 drivers/gpu/drm/armada/armada_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index cae25ad66c74..42498fc77e54 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -6,6 +6,7 @@
 #include <linux/aperture.h>
 #include <linux/clk.h>
 #include <linux/component.h>
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
@@ -101,6 +102,8 @@ static int armada_drm_bind(struct device *dev)
 
 	dev_set_drvdata(dev, &priv->drm);
 
+	dma_set_max_seg_size(dev, UINT_MAX);
+
 	/* Mode setting support */
 	drm_mode_config_init(&priv->drm);
 	priv->drm.mode_config.min_width = 320;
-- 
2.53.0

