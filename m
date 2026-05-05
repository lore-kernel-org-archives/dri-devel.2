Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8609FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 09:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1A5210EA24;
	Tue,  5 May 2026 09:47:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XaJ1L4Sw";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1611310EA1B
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 09:47:24 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-c8028fa6039so1333821a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 02:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777974443; x=1778579243;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H47du07QN++q3kF8wD+XRMzmoj4qTLPzJmnZJfh1GKo=;
 b=XaJ1L4SwDqjtV3lWWMj0TIkAvr4ADhsMkod/JtrkpHcbzsIe2/drhkPzaynBXuXHiF
 BEDA0k5TLJOctORAMQ0awmUKU9oiGNsselUemxHPqRzzmWXkwZtFMYL/XZZ6McK6gFrs
 wgfhPOYAqbVu3/q6rzkVpjh1ai+7ZgSjCcX7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777974443; x=1778579243;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H47du07QN++q3kF8wD+XRMzmoj4qTLPzJmnZJfh1GKo=;
 b=kGeasJL/AFyBQKuBBllo7sRkS5+NF/jNsptng3pRKwtF+hxR7LdSkzrn/lX+VVg14w
 MMud4PRKAqFYXq7+yqze+dZE8+lmecMu19h8cHK1nygZchid4eKPeWyD02rH/1UDqXGO
 lRcIOV+kgpY8cg1JiUJzC6DG93dTabEo4oEc010Ep51Sl8F5VY2zWriYXhqWNpif6IC9
 IBnybulm08dgrVKbot1jE1uWTRYa0WxsG74A0WkF1sRxsQyEMwKBPt0Nnu5JMW2lU13d
 6lqJgRgWgtIcpDJxDXTZyoTuextkOCNqnCIdgKg7StSnsscyATahkklgVrhYXpAciT13
 XIsA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/iGCifzn+xEY11aPohfVyI6efrdEfyxmHYjQ1KrUixojj6zYg5JjPf+3RHtLxJ7EJGEG7MrCuH6E0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzo2fb6w8i9WalAF7eVHAA6UArvmJ+BqJVQA/KgFQK0tgJPIjDM
 oYNia+u7DZ+7mXX9WLjZ8qnFvH/tb5iA0u2S8d93nCxzqRbr6tm1MFUfbm1y5lK3AA==
X-Gm-Gg: AeBDieu8OPlOvKnL2rXRI3pTH7cCRl0/RT+wSxnEvbyGJKzoIW+ozPu5XDoDs2fs2ce
 fDAogK40tOJcgdPekra6nnU5Pdtdt2h553JIEtKjuRDR5QmqoKR1t/XQpk3FD9rygNR75NarS8Q
 Pbm4BIQP4SgX2Yx3/TJtrZHOpWxYOqL6NuVxLmDLMo1wF+Vp0RXtnhY0gQYG3oz57sxqb13qgP3
 SX2WflPfEg5L60pBi1UYQwrLZr7osNtIKG0diEvKqSPz0NvuTqB596AGVKy2pBWGilvjFlvw7BZ
 cU81Mpm99QBusdcDMr3OdkQhGoqpHdennGrCx06Nwps1U4ugSqjbBzgE2Tx+5WLJJFGpaId+jwl
 WBJuYlyDbkMY//qh7IEah7nQSOr2Zp4h6EiHyBH3Mcjhc26Ox/Q5NbK+JEOI9+11p1QNvEkIV52
 QMPJoGZmxwE0vu0hL0fjNc2slA/lo/6w14yHdAP4krgV+bPO9onJxb5coP6EBeFKpX2pS82dnlm
 n8djhJ/rBk7st4tESo=
X-Received: by 2002:a05:6a21:3296:b0:39f:3559:7501 with SMTP id
 adf61e73a8af0-3aa3b710f2cmr2574979637.41.1777974443578; 
 Tue, 05 May 2026 02:47:23 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:f1d4:2ef0:7d08:9dd8])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965d314f7sm1774100b3a.23.2026.05.05.02.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 02:47:23 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Subject: [PATCH v2] drm/xlnx/zynqmp-dpsub: Fix dependencies for COMPILE_TEST
Date: Tue,  5 May 2026 17:47:15 +0800
Message-ID: <20260505094716.1784225-1-wenst@chromium.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
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

The zynqmp-dpsub driver does not have build time dependencies on the PHY
or DMA drivers. These are runtime hardware restrictions.

Make the two dependencies optional if COMPILE_TEST.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Keep each dependency on a separate line

IMO the two driver dependencies could be removed altogether, but that
would be up to the driver and platform maintainers.
---
 drivers/gpu/drm/xlnx/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/Kconfig b/drivers/gpu/drm/xlnx/Kconfig
index cfabf5e2a0bb..58c19e5a7e8f 100644
--- a/drivers/gpu/drm/xlnx/Kconfig
+++ b/drivers/gpu/drm/xlnx/Kconfig
@@ -3,8 +3,8 @@ config DRM_ZYNQMP_DPSUB
 	depends on ARCH_ZYNQMP || COMPILE_TEST
 	depends on COMMON_CLK && DRM && OF
 	depends on DMADEVICES
-	depends on PHY_XILINX_ZYNQMP
-	depends on XILINX_ZYNQMP_DPDMA
+	depends on PHY_XILINX_ZYNQMP || COMPILE_TEST
+	depends on XILINX_ZYNQMP_DPDMA || COMPILE_TEST
 	select DMA_ENGINE
 	select DRM_CLIENT_SELECTION
 	select DRM_DISPLAY_DP_HELPER
-- 
2.54.0.545.g6539524ca2-goog

