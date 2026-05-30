Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EAFCD6E5E
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 13:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0EC5112B5D;
	Sun, 31 May 2026 13:58:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BsnZfCNm";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FA2C112750
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 09:45:27 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2c0a5354da1so2156485ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 02:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780134326; x=1780739126; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aVc/26APRiTPbdxNs/jo+GGLcrXaHHIyPQYjeJMMqc0=;
 b=BsnZfCNmRLIgJLKV8SEjvG4o54ZjGfqg3R7/yww1ZzMj2VcMknB5kL0zU7pob2pMt0
 NJy63cfN5ik8ktxalV1pikkp7AjQxaNkTkkP7oaHNOSeqCOhTIHqdq4UKx/YW7wZf7sC
 NC+GH5xNZwVwaYcN9bwyhqOfBGfEORD5Mk3fb0d4zZOWxIZGee6C5tDJ2XkcZjcjrYv8
 nxq+Anc8eOf66KXspPc3YGp2uZSedNkLGFI0O74RumSsHTditcAc5Dz6ABBMGH4mDiRA
 DuTVbtB4oUciClCcmL+gLInfof2i/1VmGDAusMkOzEDd5Iev+iOB346ATmQZSWepmML5
 ZAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780134326; x=1780739126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aVc/26APRiTPbdxNs/jo+GGLcrXaHHIyPQYjeJMMqc0=;
 b=lgxUAPk/I+JWJis5wAmfT2Nj0NBnEyqvvV8URy6iFozFqWN8vrEt3g4RUXRK5ff/nY
 NkeVLNlxUXugDnC9gRbdJyXsojVcQ3v6zwCKCnV5wcDA5feRyVBvQ+eKQyCuDpP70nrQ
 ac7NYcrLuuaBeSE4k8X00PBzZBo0i0aHQO5xRaopf6xdNn9dfl7sB6Htclj2FuyZW6Gx
 PRcZr0nSAC2smLgqsrYSGzfAAweW3ebHo4TTyzXJBX50V+RwcZLxSMS0r2rT7LwWlXy6
 G8k1QzGJI6taBHzzNhQ7kxHozutihX76PXyi7f/2iglyIdGp7AMhnNHMS98w8dRg7JU3
 CbSA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wQ3LqMVOZFRr7Kwe7QbSs9gsj+emPHqmA3HcmitXEMjPejPzfRBiGhQttSeLE0heJMI40lcPiDwM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSAJ/2LjKG1VuzcGA7hmBc2SRTTXea6BtNdljYY5AQ3hbruEbH
 /ZXRr747wBqw87l5DjdQxOCSkvIq9hO/HQx7KSHfcXJ7bxvIyc1xt9Cx
X-Gm-Gg: Acq92OGBInxmwfJXQmtXohH1ylTHFEj2+xt8XfkwBO8KcJk6lGvMFKZJJEHjPzs85H6
 09IKIuor8js0Rkktrc9Ch4wDCbDFNaobKbNyzxjDJkdJKLpavfMMC78qoOnb1N2iO2qp/3qUENP
 /5/9OMfCPvuy8uvosA3Jp46NzoSg4mTk/5eOGeRX2XavjIvQX9DvpGw55+bGeNnti0Vr3SMJPc8
 raa1eFUqvG8PtwCmh7LJkt7d0xnbd9SSvY2ptQTWtv/aRApzp6QISHOHzqu6WkBFQ+K6BYbv+uK
 BpsNNNzKi3u+K1XY28/CCxq759S/zkOoZEDj93CyAGoIOXntuVmG3i+AF7oKeuMSyGaoDY2zm+Y
 JsIjgnAaLap3oZQRC6VSahJnp1x3AVUTOrgc+aOkP77ovC9r2LKGsrJiXKN78yc2+qAd7brQtkt
 77wuB1uTMWpCjWY2eKYGRo8tPZIupe4r0=
X-Received: by 2002:a17:902:c402:b0:2b0:6068:4c5f with SMTP id
 d9443c01a7336-2bf2048b983mr72327425ad.8.1780134326539; 
 Sat, 30 May 2026 02:45:26 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.191]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf239e700csm61529945ad.10.2026.05.30.02.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 02:45:25 -0700 (PDT)
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
Cc: Anand Moon <linux.amoon@gmail.com>, Nicolas Dufresne <nicolas@ndufresne.ca>
Subject: [PATCH v6 8/8] gpu: drm: meson: Fix DMA max segment size for DMABUF
 imports
Date: Sat, 30 May 2026 15:12:54 +0530
Message-ID: <20260530094326.11892-9-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260530094326.11892-1-linux.amoon@gmail.com>
References: <20260530094326.11892-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When using hardware-accelerated video decoding via v4l2m2m-copy with mpv or
similar players, the video decoder driver (`meson_vdec`) exports contiguous
memory allocations as DMABUFs. When these buffers are subsequently imported
by the display controller driver (`meson-drm`) for rendering via the GPU or
compositor, the DMA API throws constraint validation warnings.

- Call dma_set_max_seg_size(dev, UINT_MAX) to allow large
  scatter‑gather segments.
- Ensures the DRM core and canvas allocations can handle
  full sized buffers without hitting DMA‑API warnings.

This aligns the driver with common DMA setup practices and
avoids failures on platforms with strict segment limits.

Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 49ff9f1f16d3..8570add8b831 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -247,6 +247,8 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 		goto free_drm;
 	}
 
+	dma_set_max_seg_size(dev, UINT_MAX);
+
 	ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_osd1);
 	if (ret)
 		goto free_drm;
-- 
2.50.1

