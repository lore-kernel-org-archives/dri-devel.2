Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA18FD5F92
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 720A310E566;
	Wed,  8 Apr 2026 08:14:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XW2ncqGL";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71A6B10E566
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:14:39 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c74f0c3fc16so2019815a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 01:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775636079; x=1776240879;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dSjdMh+XaFUbzimxpCfQ0e3RkMLJvEC/5j84Dsq46Cg=;
 b=XW2ncqGLJeiST6zlZX5ocVnCuURoVSKlNYOSjirYN3Ao9Elcg5gYhZ02lx+Q0GbUqO
 JubtmFoPdKXKDVNi1kg/+3Wh4V3ejJX5tbSmRj15lLz0Tsdf2jD0UzYe6kz8UZMp9ldW
 G6Ye+DFuELyDJkZNYt0CIHOIoxxcTClYH2dUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775636079; x=1776240879;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dSjdMh+XaFUbzimxpCfQ0e3RkMLJvEC/5j84Dsq46Cg=;
 b=HWRaf50dasGAi9xZCMR/B0maKup9FDLu5wk3C+xdxO570skNw884CYOqOWZhWWvhit
 QbyClZmLwcf/w1BxaV36zGmG49f3++3EKrwwcd5uY42LlXPqc8P8SpfaJ/jAxSux3aAg
 1x0pp0i7p3YX/OkLuHNWQu70nyeIrPIVxhnHeUAkCcSbaY9EoL0ffdHwXtgyue2ju2eT
 gH1Kog/VE/Hi16Va1mpZ3AYSjOxeHHqfkghStvC8rDFwtmSMr+w5s8pinwacxnO3CIzK
 v+RKDW1v3Yg+1m7mFkdtfzQqGPlmlCjRp9yZTwFtPpAOAW1gQCWqOnjcmyl9MzfxdfJA
 nF8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmZiqJrDAVgfpCMjO5rcghwU1ye1cinOuujLiMWBqRT/QWk3PXZPxR7V7dvt29zJWAxMgv21N5zQI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGmhJ3dVQwDb0ENv5EWZsJ6JVt5V/Ajo5Uet0p5uSdFkljN5St
 dGRu2wnurC1HZxCthrmG8VNURLqR+YQLGgA77qIaXm5m1XRWM+tyPhlNm+xjDqF3vA==
X-Gm-Gg: AeBDiesZV17/6cuBPkAMjGC5b/IqV1xsgehzHKnKuoPtcRevSKpfrpkN5IVoe1Hcqew
 PeFFZ1omgqm9MmRaG+Z4hyW9EwHim8nYxeHZxhgFytTDNe6gkkEivgcy3AY+KT4tqcJ33qzbKyC
 KSZfBXWg/AYS2JQSBzrJcsdlFUtix+1iqnGwEHOL/H0mTX/x4pfM/mwZlMV+KPBmtqgZcTwSJoI
 FxoVFOuQJz0M1E7EFT3xaF9YK/r4EAw8K2h06MzEK1yTrJFVVJLTUuDT4qh9LWv2/G3h7d2Hi4A
 SnbSI7KCoNmI+dF14CYSGVq0k5o61Bj2X/unlwcjJRyWZbav7olOw9iNqEEPGlliShhqYpKh2tN
 WG3Mm0JRIfJQjL1VgVDaIghycWIT5v/pakGwkHmsrfeDM313aL6h62Ta6P5JLQxp8diFGkX/UkB
 B17cEcdh9iCgwNOQxYKvMulg4AcJM14Ewqr698v/xQ5jZCDk+V3KYzXW+iJQA1I1XJn/w274bn/
 pfbltxz
X-Received: by 2002:a05:6a20:258b:b0:39e:f994:f681 with SMTP id
 adf61e73a8af0-39f2e9f5f3amr20959994637.0.1775636079009; 
 Wed, 08 Apr 2026 01:14:39 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:f0e3:c8b2:74ff:70d1])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6563ce5sm18131207a12.21.2026.04.08.01.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 01:14:38 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/xlnx/zynqmp-dpsub: Fix dependencies for COMPILE_TEST
Date: Wed,  8 Apr 2026 16:14:28 +0800
Message-ID: <20260408081430.1712335-1-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
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

Group the two dependencies with ARCH_ZYNQMP so that the driver can be
compile tested without them.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
IMO the two driver dependencies could be removed altogether, but that
would be up to the driver and platform maintainers.
---
 drivers/gpu/drm/xlnx/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/Kconfig b/drivers/gpu/drm/xlnx/Kconfig
index cfabf5e2a0bb..4c6729459f40 100644
--- a/drivers/gpu/drm/xlnx/Kconfig
+++ b/drivers/gpu/drm/xlnx/Kconfig
@@ -1,10 +1,8 @@
 config DRM_ZYNQMP_DPSUB
 	tristate "ZynqMP DisplayPort Controller Driver"
-	depends on ARCH_ZYNQMP || COMPILE_TEST
+	depends on (ARCH_ZYNQMP && PHY_XILINX_ZYNQMP && XILINX_ZYNQMP_DPDMA) || COMPILE_TEST
 	depends on COMMON_CLK && DRM && OF
 	depends on DMADEVICES
-	depends on PHY_XILINX_ZYNQMP
-	depends on XILINX_ZYNQMP_DPDMA
 	select DMA_ENGINE
 	select DRM_CLIENT_SELECTION
 	select DRM_DISPLAY_DP_HELPER
-- 
2.53.0.1213.gd9a14994de-goog

