Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA908CD98D6
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 07:58:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9B1910E24C;
	Mon, 15 Jun 2026 07:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kccd/fxo";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD2810E208
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 06:50:33 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-304d7f31215so2728357eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 23:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781506233; x=1782111033; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IHx1+R/J17dYEVk2E+ls+XsmeltEygUylDakA0bf7co=;
 b=kccd/fxoNwurNZpFGXKi1/mf+Zg5k3p/DpTKKAYAaJGupMCXVbf6o38TCU7QFhXWs+
 vhFZL9etDaIjGjvjzZ3j5Zauw18blJQzxh9ldu52//+rqt+ZEe+gW9vJOjxeEIsqoVSf
 uerCGeLonRFbPhLO6YvFqYmlkJd4F4HguWEVZsX4hWg3UJPkY2Wz1VHqVjM7M7CeBbju
 xjL4v5veLTAcVAsYzmdpsUzQlvmzEDx2QBuI8Pi9ATbmcvYOk7an3/WlbfDPRWqzyBET
 Q8/giVpE7G3gliQE5jGm/VCfSlWKrlCBM9XHzH0rAbs1rO+5LLOEoqXhc0YshFfFb8YG
 ZrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781506233; x=1782111033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IHx1+R/J17dYEVk2E+ls+XsmeltEygUylDakA0bf7co=;
 b=E0t+qQFq/8iBJRHuvAYk8ywo9Kja6hvK7hb5xwbw9tBLMCSvRltefUTLT0yI7n6BmB
 jO4VsS8wLQZfUvcxIeaY9TM6AovZs20gw+rwGfPVP+hWCn4NGCZssWKeC71CUQOfk0ML
 XdCJEpeI4CF1SRHzpnN5RqIckifFOsYCsE/hmQV0gzwpeNMhwzatc741kFN+W8XCe6TX
 cN6ExqySEQPODCEKg4RIxmbAzhqQ0pqT/yZ77M2eNK6aIDoYyJIzQcPQ46pI8cCW+/uj
 v6o+mXYTiN2QwpkfTe4Hl6/TvoeDpDbzdjO9TdbNH1Bea4e/g49lPQx+1kFwnC8NKwHY
 3Z2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8OTZ10OthCG98gH4rW1CLxD5sW9I0vZU8myqQRVzfVsenWccXcnLhdGw6PUY4aYkEAiBZ5KBtSB6Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFc3vpiwJDkOY1Q/2QDJihcXDr8WyjVWKR/zzD87kazyKv2iVi
 9dQFLyUP5HDrbQDVFlHOlQXxxHXganaPgUjocUThH82EMJpH4qx/psQt
X-Gm-Gg: Acq92OH4IeFW8QfvACfz0N26uXLSGU8+HTGzPDbG1bpxVg7qTEZj/sj7M9hUNK+xegs
 aGHs9+hfV78Prgb/MOQvLwW/2vvDqq+3HfIMfc0hOYVmNf511BwUo3i3WiO407uXti5j8+mJg1G
 oPaPqZBXPcmmRFlkU7O6d/nnGU0aJ7cGnifQmHiIzAPuEpGpKqIQEfydreoUirVOzFLJaFxRiBL
 lvS9D69058cPRK+fledFmu0mqD++7X8H8xWEF50Ndo5sgA4MAqzLY8BVi+GNnhwHwmTtHWJdu/f
 0o/TwEy3jBCBilDjnPJRv6gy4mRAYfj9cLiTYSaxWUi9AkpQGpnuWcypTb07G1f9igKkE2BXpB3
 qY64fA0JGfgASeMKDNGQ+PmrAlmUGQEr/qRUPorVjiNefovka7Ma4mKp80Z9W4ic8kxTUH7tavc
 UdNCCKhjVxKt3LV4klEAph4qCnIKLT1ju4QGmbtMWUFKI60sYs53vJ4cwLzhUen3fq1NWpB+1wm
 wty2qdDew3r
X-Received: by 2002:a05:693c:3b09:b0:304:819f:5029 with SMTP id
 5a478bee46e88-3081ff3dc01mr6294428eec.2.1781506232688; 
 Sun, 14 Jun 2026 23:50:32 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb9a2e7sm13516812eec.30.2026.06.14.23.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 23:50:32 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v4 6/6] drm/verisilicon: extend Kconfig to support ARCH_MA35
 platforms
Date: Mon, 15 Jun 2026 14:50:03 +0800
Message-ID: <20260615065003.76661-7-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615065003.76661-1-a0987203069@gmail.com>
References: <20260615065003.76661-1-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 15 Jun 2026 07:58:00 +0000
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

The DCUltraLite hardware ops and HWDB entry added in the preceding commits
enable the driver to work on Nuvoton MA35D1 hardware.  Allow the driver
to be built when ARCH_MA35 is selected; this dependency is meaningful only
now that all supporting code is in place.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 drivers/gpu/drm/verisilicon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/verisilicon/Kconfig b/drivers/gpu/drm/verisilicon/Kconfig
index 7cce86ec8603..295d246eb4b4 100644
--- a/drivers/gpu/drm/verisilicon/Kconfig
+++ b/drivers/gpu/drm/verisilicon/Kconfig
@@ -2,7 +2,7 @@
 config DRM_VERISILICON_DC
 	tristate "DRM Support for Verisilicon DC-series display controllers"
 	depends on DRM && COMMON_CLK
-	depends on RISCV || COMPILE_TEST
+	depends on RISCV || ARCH_MA35 || COMPILE_TEST
 	select DRM_BRIDGE_CONNECTOR
 	select DRM_CLIENT_SELECTION
 	select DRM_DISPLAY_HELPER
-- 
2.43.0

