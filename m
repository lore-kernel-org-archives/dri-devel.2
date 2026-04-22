Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE541F9B601
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 09:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24F0610EE0E;
	Wed, 22 Apr 2026 09:48:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mnePCkJj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CED6010EE02
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 09:48:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CCA876011F;
 Wed, 22 Apr 2026 09:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DE18C2BCB3;
 Wed, 22 Apr 2026 09:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776851322;
 bh=08E5ptp45hu+A0H4XUoisT3SzTcHnJ4oRsrCTwjFrdk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=mnePCkJj43XLBTwzn0Ju+e7ncNLlF9wb69NzZYQxnDdxlGcTCR1FYUJKNqF4++vuq
 nygD/ckGbIUCf/cEF18E1TUL4K0idYQFIz7AWjY/dqLgYGO/wVrR9ccJ8fWTP6Uoxm
 kx5lR+j42Z2aTvEKdux0QUvPTmcA3gXNXLaMY94s7fPYJMpBKNThLHh46LZvFogTuF
 bfTIm243jGH81c+Y20L9Ag4CbEDnM/gFsXqBJWLzGMzfTV6k5fQ286GA72LfZ2oKTD
 u67bN3FZ2Feh2e0HfwZ7V5K96syQ8sWGtuOnw7OkceYN5CU0B/1ZBQWKGe6Lx5vxSg
 S3nqr/Lgnu7dg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 70B3FF9B604;
 Wed, 22 Apr 2026 09:48:42 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 22 Apr 2026 11:48:36 +0200
Subject: [PATCH RESEND 2/4] drm/panel: Clean up S6E3FC2X01 config dependencies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-panel-clean-up-kconfig-dep-v1-2-d825e9ffe911@ixit.cz>
References: <20260422-panel-clean-up-kconfig-dep-v1-0-d825e9ffe911@ixit.cz>
In-Reply-To: <20260422-panel-clean-up-kconfig-dep-v1-0-d825e9ffe911@ixit.cz>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 marijn.suijten@somainline.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1478; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=QCqlyKwxaTuh0MEQOecgcLXACzmZnqmhpNcpsr+X/mk=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBp6Jl4VvzN9Tmhv0fiX0jap40QPW/cGjhZ9zewV
 O9tyI+pLeCJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaeiZeAAKCRBgAj/E00kg
 ckS4EACuyuy0CX7BUwMsewxbajohgYJsNQytKfCFdtWG17RdIDwzDK/nIKAYIa7wm+upxG19qfP
 izncmG6VvlHD3a5vIWybDj2FfR0KATxxA21Yb9t8a+r17jgogH2kIT49p3oVxQEKMPvLag9X+MU
 fBc683jLs95octNXJdZesv4QQBJd7o97lIBam3IvnhndM+eATYHJYDD8MKt5jkzh3EQ2FnnpuhF
 sxqheIs35Gpl3MMqy7FYM+7GBpSB6+ggf5zLjEWs8LGIjPgkEfhetTiSjsvukN8gy+rMVYR55zy
 /pOrKZtaYvr3MEKkbTIGSaqDbi9YjuWBzCt+PsWyXUp3IF9gBAj/QT/ce/C/9bHPASaehZSAF0Y
 6XlonVRXcQF7Esj9s/a9jUfwEPcBwupOCN6vL1hhAek7L3jRH2JyNLEw7Tfn0dK66RRXr+//tTe
 pnbj0+3bYpx5yCBpWkjORfmgZocxVfaAUzgUq4p7XWjgMvmezCgaDU4DTL3nPraBIQwJORwryzj
 AoDQ/VEVEHmjhrS5wxsk+fR8WigRGyQf33B6pARi/JvkFs5rSRuUyCaEKTX6M3djf2zIBOxuDvU
 rWWK6qtHDY4PVz3ASfCL1DaNhRIzfGL8v8WmoFsSZJWkJKE4oP2sxIO1q4w9NVjhbZUVkoGVVis
 YJD3NlTzb0ZPSNg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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
Reply-To: david@ixit.cz
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: David Heidelberg <david@ixit.cz>

As per the config name this Display IC features a DSI command-mode
interface (or the command to switch to video mode is not
known/documented) and does not use any of the video-mode helper
utilities, hence should not select VIDEOMODE_HELPERS.  In addition it
uses devm_gpiod_get() and related functions from GPIOLIB.

Fixes: 88148c30ef26 ("drm/panel: Add Samsung S6E3FC2X01 DDIC with AMS641RW panel")
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/gpu/drm/panel/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 2fd3222ba2e3b..a81ea7755c03f 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -825,20 +825,19 @@ config DRM_PANEL_SAMSUNG_S6D7AA0
 	tristate "Samsung S6D7AA0 MIPI-DSI video mode panel controller"
 	depends on OF
 	depends on BACKLIGHT_CLASS_DEVICE
 	select DRM_MIPI_DSI
 	select VIDEOMODE_HELPERS
 
 config DRM_PANEL_SAMSUNG_S6E3FC2X01
 	tristate "Samsung S6E3FC2X01 DSI panel controller"
-	depends on OF
+	depends on OF && GPIOLIB
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
-	select VIDEOMODE_HELPERS
 	help
 	  Say Y or M here if you want to enable support for the
 	  Samsung S6E3FC2 DDIC and connected MIPI DSI panel.
 	  Currently supported panels:
 
 	    Samsung AMS641RW (found in the OnePlus 6T smartphone)
 
 config DRM_PANEL_SAMSUNG_S6E3HA2

-- 
2.53.0


