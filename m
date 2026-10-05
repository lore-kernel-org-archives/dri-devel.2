Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B762CA5FE2
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 06:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 972E210E9F7;
	Mon,  5 Oct 2026 06:46:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OVSVISyU";
	dkim-atps=neutral
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com
 [74.125.225.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D059610E9F7
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 06:46:50 +0000 (UTC)
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-48b05fdb2f9so1104558f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 23:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791182809; x=1791787609; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C8mhPQJ3zOva6jYeHlXj3lH5xzHiYvRbnIJdnEytZoE=;
 b=OVSVISyUOmLRKi9fP5an+mElvF1P9QrBKpkjElClxZc5XbVMo5zgRDeiy+cVtROfOE
 KTEDXKwffvZeAHzv7a0yd4vzzsH2aFgHU9eAwLg2lcwJDU/IqVXTHxu5/kfK1qCjWdCO
 whNLrCy7ofr3CsTiqPXUhE4Lt2mdhXcktVaR1rNPhv8qvq7zK/3d7anYPIk8CCBTF/ii
 Tl1rHcai3m7yqsEwkgQrDVQXFmjhbKMuwGlJ1XSCpMBw9OqEsOcXWkLdMO9PSNPUNYAQ
 o9GNlC1p2QEmlnv/wKHrWiy3bYeB4wUbq/yQGup4Trfks/xf7hri8aSDEx1CJ0wJTuCa
 psMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791182809; x=1791787609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C8mhPQJ3zOva6jYeHlXj3lH5xzHiYvRbnIJdnEytZoE=;
 b=Su6xVuac6Nb4Ry/B5acW6hGnOoKuLeRaJFjX1Xcoz1+oI7CeDDQZVHHgjKF22NO5bl
 cyZV4Lqy5bWbGFsbm0Bs8Q0Cmdc3XgJ9IHi4KwrdDsF0javX4TNHzOIXUVMwft/wAvmN
 fv4RhkqWvQpSSSLciSZwoKzkNNKSWfD9Ow6Hg9R9fFqTmZnxp8ZyfjOAdLQKWpmbyNNo
 4tbvFWuZR7WjPdsNn81dMZl2PxNGX7syq3jGEgXrhxkkNRPuODrDluZPA48WYDGePOdt
 krBxHNL9mgONWaHsF9SJmOsSNH0e9ta7Q4t4lRPZcztK8m4NGKSOMqmYk8QKZUZoOm9j
 65jA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7AIGc51PZmY2qqklVjhfcwzRbn0YQ5JRjh3XAYVneW/jTWflvVaxGdIYVgnXwMzBCe9Z2kwwRHbw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nmPvNhzDbW439vf4yjnOy/Ayw4fOvvOECVDxi4yAQn8+JqostL
 OS6ddrtn/l3bV9pI+Jj0s7M/giO9VSKgrS5hoOIBNyLMbBBFPtUhkSPh
X-Gm-Gg: AYBFou3KOAXfSW2DdFfUZ96/XRTKI7nwWd4fFDH7QjVhLESuh6rjLiRo+FUM04XLG5e
 15V5U9+Vxbt2Fo11T0b1cNillphtfiCA/Vai8bLWtFGG7jYGGf6HlXPJhv9s0p5uYiof+oLF/gR
 8DBMRCQgONxtduw1O+l1zHXKd19VQCLXIeBrMUPryHil0U1hTV2Sk2IFTpWMsfMYxLAUnnhVmOq
 p7op4rW1CjZTdURmN3KJ4DyJ4eHZlgpjDEqlmVBYpAi64uGirjAAphk/LxU3KpCSF5wjjQfAE2g
 KG1xS+shCGwXmF90UDNZZvcPzvbLL9TJaoej3WcigxBtb/pDbkcnKyZdpstgPvKRBwX98shGwIq
 Zf4SJ1lz/penezwoyl4T3ZIQHuUaC3PAeLAT5UMdHjbZ/0yEHIrTW0E/Bj+u2OqZLRL/q7CaEpQ
 g8dpL6hcn1oAzSPhiioODLZ+IC9dVJJo9YO/mgTNdMBninuQx7rJ9FcpvUZF8AtbnBPVkB+lmee
 22J71KQlmEvFDAnK49dNUr6kSC4Gh1CsNGmJkohdai/CTFL/2nOmQwDSHw+sbBvCRPnEq5ygldj
 d3JqmGGqd2+/45Y/rtxeb8lDfGe1nRND6XkalmPieKiEYsikjw1tzVUzoGvnJ7YtK1Z8e3OBm1a
 bnQ==
X-Received: by 2002:a05:600c:2187:b0:4a0:1c10:1372 with SMTP id
 5b1f17b1804b1-4a02769a83amr118812745e9.27.1791182808952; 
 Sun, 04 Oct 2026 23:46:48 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-b305-2001-39fa-3d24-821a-4eae.310.pool.telefonica.de.
 [2a02:3100:b305:2001:39fa:3d24:821a:4eae])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027741586sm315273615e9.14.2026.10.04.23.46.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 04 Oct 2026 23:46:47 -0700 (PDT)
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
Subject: [PATCH 1/3] media: tegra-vde: set an unlimited DMA segment size
Date: Mon,  5 Oct 2026 08:46:38 +0200
Message-Id: <20261005064640.7776-2-kmehltretter@gmail.com>
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
the 64 KiB default. With DMA_API_DEBUG, mapping a larger buffer
reports:

  DMA-API: tegra-vde 6001a000.vde: mapping sg segment longer than
  device claims to support [len=1228800] [max=65536]

Without an IOMMU domain the driver also needs each imported buffer as
one entry. An exporter that respects the 64 KiB claim has to split a
larger buffer, and queueing it fails with "Sparse DMA region is
unsupported, please enable IOMMU".

Set the maximum segment size to UINT_MAX.

Verified with a QEMU stub. Not tested on real hardware.

Fixes: cd6c56feb591 ("media: staging: media: Introduce NVIDIA Tegra video decoder driver")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---

Notes:
    Tested on v7.3-rc4-70-gfe2ec83746e5 with DMA_API_DEBUG on QEMU's
    xilinx-zynq-a9. The driver probed from a stub device tree node, so all
    registers read 0, and needed a test-only change to probe without a
    Tegra PMC.
    
    Queueing a capture buffer of 1228800-byte CMA heap buffers works
    before and after this patch, with 7 segment-length reports before and
    none after. With patch 3 alone it fails. With patches 1 and 3 it
    works.

 drivers/media/platform/nvidia/tegra-vde/vde.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/nvidia/tegra-vde/vde.c b/drivers/media/platform/nvidia/tegra-vde/vde.c
index c3097085ad9d..6a47e8ba083c 100644
--- a/drivers/media/platform/nvidia/tegra-vde/vde.c
+++ b/drivers/media/platform/nvidia/tegra-vde/vde.c
@@ -238,6 +238,8 @@ static int tegra_vde_probe(struct platform_device *pdev)
 	vde->soc = of_device_get_match_data(&pdev->dev);
 	vde->dev = dev;
 
+	dma_set_max_seg_size(dev, UINT_MAX);
+
 	vde->sxe = devm_platform_ioremap_resource_byname(pdev, "sxe");
 	if (IS_ERR(vde->sxe))
 		return PTR_ERR(vde->sxe);
-- 
2.53.0

