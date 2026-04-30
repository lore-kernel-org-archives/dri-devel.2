Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83C5CCFA13
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 11:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01D1010E136;
	Thu, 30 Apr 2026 11:16:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="DUKJ+/O0";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9325910E136
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 11:16:54 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso5612495e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 04:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777547813; x=1778152613;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YFpDe3yLsIQBoj9o9DIep0n+3MllwodoaC7QJ4zZl2w=;
 b=DUKJ+/O0MpKOfTCuAeZXcI2wjTR1fZOW0ICo168cTmNedmrLn1LJwq/U2w6TjjBsIi
 IQmZ6I4io+5xasM9fxuMvRFSxcOmogPDTgXAXYODZzG5tQkpxb1HJ4xrqJl4yikekE9d
 LTzpIAz1JUshXaXE9lnIBXMx5dU2sxMr44vD5Kc/L4jo/Nu5iVZRQ+S4eMjHDP9WcW87
 TCWGkCZY544ERcXHnILTslI2lH9PXuv2hTWg6+OgalceyuxsAtVFMGQsz+Gw9pTRzCiL
 T0FdxtAHJWdKJNtzz4wgolFyl7AAaqlbePA9M/Suss9rnfBIN3SZ+QJ6JkmDOQMGZuAe
 0GVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777547813; x=1778152613;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YFpDe3yLsIQBoj9o9DIep0n+3MllwodoaC7QJ4zZl2w=;
 b=VkxXZ1lNI3Vy/mzSY55Tp7skCkS/nVu5T1SjWxLpY4+GgZCMVlgwlqw5YTlbfeXTdf
 l74sF77uhjoL4bjiCuSNfhzLstZkww6ygbCACqsZ+9Nlj5hfFYyRSJ/ULi8wpe8FAV0H
 iFs9t+Al6Jq7zzMZfY8QVOhSeMaxbOJMsep7WgxSlnVr4V3ztBCBcE/16GZMXmNeiHoL
 N8egH5ek9D51w/wZQwFcazh3OWtrjLfzTRXRr6QGAR+IVXbg6onMYY9bSKxv/Z3m6cXq
 fCxfY63yCu9+bmXG7K5nxM7WnNwbCps9xgTsqT3O7VnyxreV4RzO+bCJm9jjBeRGyfgV
 nUhw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8eBT08dxElFVMxVcZVf6p5wCdgInaf8jgF2TLCJ9rY4pxewlC0yKdmUvNNP0SPpjy+lUJvYksgtEE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwL2nEWAi6hzCj5wE1yAVzGIx3wZetpk3PxsXHJsZlNcJ6pEXR/
 Day2ibPLN5Ab9+al0hHO9V/2sDcBT2qSOeYD5UlsoQuFvGKB2RTSgZk1ad7EzUIuuNo=
X-Gm-Gg: AeBDieuqyMYlYi8d/d8xcwS4CrhtcNXqvQdoVC9O+g0OU1wVy+gCbnP/8vwb6cyF2Qd
 vh88P+Y+Op90F+z9PAd6x9DlTcZcwSJPqiWp9cyPAsLlr+MERbY4DJ9rS05/RqXKTwRhEoUrGUC
 P5H0Z2GyY4Uf7V3o0nlgBJbLBO6TbQWwWiTmTijXD76GbEwCyaF4yQVavExgtwNIfq3gio1d0mT
 otCej2/9dOIZrn4bGbAR4PKXB0LJiDq+XYCbgASexmqRvlg5zH6dieUcGlFWYPUyh4oQWHemZdf
 Jft/BpQ7GMQOXyJuE1QrO21iwOhHeNbJuCOXlSKruaVbsULgv6YP3PQkwZGGGm0TJnsW7Hk2hyd
 fdXHA3aZjQrFx/TUP+zkfsdmNxU5E5tdEQn2HCKSGwveQxVP2Mc5mmIRCO60ljUKCJi6XlW7EZU
 X+WBKeaNQfzhtSHLLaC3/LCkLeASu4oN4Rd0LOVVEjlEzja4saoWjdrN3u5LoXOT4WslvcXL/iJ
 eQ4E0t2quiUEcP4DeugJaK8qQ==
X-Received: by 2002:a05:600c:6088:b0:489:1cd2:610a with SMTP id
 5b1f17b1804b1-48a844ec847mr40902955e9.9.1777547812685; 
 Thu, 30 Apr 2026 04:16:52 -0700 (PDT)
Received: from localhost
 (p200300f65f114e08c77bcc4a3b99186a.dip0.t-ipconnect.de.
 [2003:f6:5f11:4e08:c77b:cc4a:3b99:186a])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48a822c82f2sm58792695e9.11.2026.04.30.04.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 04:16:52 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell King <linux@armlinux.org.uk>, Andres Salomon <dilinger@queued.net>,
 Antonino Daplas <adaplas@gmail.com>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-geode@lists.infradead.org,
 Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH] fbdev: Consistently define pci_device_ids using named
 initializers
Date: Thu, 30 Apr 2026 13:16:36 +0200
Message-ID: <20260430111637.211336-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=46533;
 i=u.kleine-koenig@baylibre.com; h=from:subject;
 bh=kfgVszV2/VOdETl3YqTPRaaIHR4ZV+GOcPVLtdHBm+4=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp8zoVa50c4TDozs24luqT21afUuCwhkS7gye86
 eTlSIqC8FSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafM6FQAKCRCPgPtYfRL+
 ThAYB/9wPCLjuiLMIyeJ4l9POUKi8F+AeJgN9+SADYOw1jUrZ26PvHG1jDFhMvgCNX1pk6u/VGj
 /rkjscjuciufWNIC+yL9zUDE/3hHO7IDTcNFBHBTcaGiyIKcA8on+HaTznWVV1pr/J1Wu00X2Pu
 NP1MEYOS5SOQttVG6cs5z8n/DOvQS9nPveEvIJqBYQxzkXXoY+mRsrWgdua6aqFLUztJQN5eY8M
 uuPeVfe+S5AZxQgcc/93tDES+4wPnhPs5b2WiFoIIKWBz+pVkzGRG8d492+yUPdGL8ptq1Xvl5F
 8+FptosLeEmaXUdNRtvUrkHt/6wTSeLHgaIAAh8idAlJDqkE
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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

... and PCI device helpers.

The various struct pci_device_id arrays were initialized mostly by list
expressions. This isn't easily readable if you're not into PCI. Using
named initializers is more explicit and thus easier to parse. Also use
PCI_DEVICE* helper macros to assign .vendor, .device, .subvendor and
.subdevice where appropriate and skip explicit assignments of 0 (which
the compiler takes care of).

The secret plan is to make struct pci_device_id::driver_data an
anonymous union (similar to
https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/)
and that requires named initializers. But it's also a nice cleanup on
its own.

This change doesn't introduce changes to the compiled pci_device_id
array. Tested on x86 and arm64.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

There is no benefit for radeon of the mentioned follow up quest as it
doesn't use pointers in .driver_data. Other drivers benefit from

	-	{ PCI_VDEVICE(TTI, 0x3220), .driver_data = (kernel_ulong_t)&hptiop_itl_ops },
	+	{ PCI_VDEVICE(TTI, 0x3220), .driver_data_ptr = &hptiop_itl_ops },

which gets rid of a bunch of casts and so brings a little bit more type
safety. This patch is a preparation for that.

I assume a single patch for all of drivers/video/fbdev is fine. If not I
can split per driver.

 drivers/video/fbdev/arkfb.c                  |   4 +-
 drivers/video/fbdev/aty/aty128fb.c           | 143 +++++++------------
 drivers/video/fbdev/aty/radeon_base.c        |   2 +-
 drivers/video/fbdev/carminefb.c              |   5 +-
 drivers/video/fbdev/cirrusfb.c               |   2 +-
 drivers/video/fbdev/cyber2000fb.c            |  24 ++--
 drivers/video/fbdev/geode/gx1fb_core.c       |  10 +-
 drivers/video/fbdev/kyro/fbdev.c             |   5 +-
 drivers/video/fbdev/matrox/matroxfb_base.c   |  38 ++---
 drivers/video/fbdev/neofb.c                  |  29 ++--
 drivers/video/fbdev/nvidia/nvidia.c          |   9 +-
 drivers/video/fbdev/pm2fb.c                  |  11 +-
 drivers/video/fbdev/pm3fb.c                  |   5 +-
 drivers/video/fbdev/pvr2fb.c                 |   5 +-
 drivers/video/fbdev/riva/fbdev.c             | 128 ++++++-----------
 drivers/video/fbdev/s3fb.c                   |  32 ++---
 drivers/video/fbdev/savage/savagefb_driver.c | 140 +++++++++---------
 drivers/video/fbdev/sis/sis_main.h           |  26 ++--
 drivers/video/fbdev/tdfxfb.c                 |  21 +--
 drivers/video/fbdev/tridentfb.c              |  44 +++---
 drivers/video/fbdev/vt8623fb.c               |   4 +-
 21 files changed, 292 insertions(+), 395 deletions(-)

diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
index 866c1165704e..195dbf4a5142 100644
--- a/drivers/video/fbdev/arkfb.c
+++ b/drivers/video/fbdev/arkfb.c
@@ -1167,8 +1167,8 @@ static const struct dev_pm_ops ark_pci_pm_ops = {
 /* List of boards that we are trying to support */
 
 static const struct pci_device_id ark_devices[] = {
-	{PCI_DEVICE(0xEDD8, 0xA099)},
-	{0, 0, 0, 0, 0, 0, 0}
+	{ PCI_DEVICE(0xEDD8, 0xA099) },
+	{ }
 };
 
 
diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index f55b4c7609a8..bcb10e66221c 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -180,101 +180,54 @@ static const struct dev_pm_ops aty128_pci_pm_ops = {
 
 /* supported Rage128 chipsets */
 static const struct pci_device_id aty128_pci_tbl[] = {
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_LE,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_M3_pci },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_LF,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_M3 },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_MF,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_M4 },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_ML,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_M4 },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PA,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PB,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PC,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PD,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro_pci },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PE,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PF,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PG,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PH,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PI,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PJ,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PK,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PL,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PM,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PN,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PO,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PP,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro_pci },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PQ,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PR,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro_pci },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PS,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PT,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PU,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PV,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PW,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PX,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_RE,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pci },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_RF,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_RG,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_RK,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pci },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_RL,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_SE,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_SF,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pci },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_SG,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_SH,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_SK,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_SL,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_SM,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_SN,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_TF,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_ultra },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_TL,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_ultra },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_TR,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_ultra },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_TS,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_ultra },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_TT,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_ultra },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_TU,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_ultra },
-	{ 0, }
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_LE), .driver_data = rage_M3_pci },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_LF), .driver_data = rage_M3 },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_MF), .driver_data = rage_M4 },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_ML), .driver_data = rage_M4 },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_PA), .driver_data = rage_128_pro },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_PB), .driver_data = rage_128_pro },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_PC), .driver_data = rage_128_pro },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_PD), .driver_data = rage_128_pro_pci },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_PE), .driver_data = rage_128_pro },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_PF), .driver_data = rage_128_pro },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_PG), .driver_data = rage_128_pro },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_PH), .driver_data = rage_128_pro },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_PI), .driver_data = rage_128_pro },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_PJ), .driver_data = rage_128_pro },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_PK), .driver_data = rage_128_pro },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_PL), .driver_data = rage_128_pro },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_PM), .driver_data = rage_128_pro },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_PN), .driver_data = rage_128_pro },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_PO), .driver_data = rage_128_pro },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_PP), .driver_data = rage_128_pro_pci },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_PQ), .driver_data = rage_128_pro },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_PR), .driver_data = rage_128_pro_pci },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_PS), .driver_data = rage_128_pro },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_PT), .driver_data = rage_128_pro },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_PU), .driver_data = rage_128_pro },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_PV), .driver_data = rage_128_pro },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_PW), .driver_data = rage_128_pro },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_PX), .driver_data = rage_128_pro },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_RE), .driver_data = rage_128_pci },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_RF), .driver_data = rage_128 },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_RG), .driver_data = rage_128 },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_RK), .driver_data = rage_128_pci },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_RL), .driver_data = rage_128 },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_SE), .driver_data = rage_128 },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_SF), .driver_data = rage_128_pci },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_SG), .driver_data = rage_128 },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_SH), .driver_data = rage_128 },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_SK), .driver_data = rage_128 },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_SL), .driver_data = rage_128 },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_SM), .driver_data = rage_128 },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_SN), .driver_data = rage_128 },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_TF), .driver_data = rage_128_ultra },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_TL), .driver_data = rage_128_ultra },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_TR), .driver_data = rage_128_ultra },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_TS), .driver_data = rage_128_ultra },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_TT), .driver_data = rage_128_ultra },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_RAGE128_TU), .driver_data = rage_128_ultra },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, aty128_pci_tbl);
diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index cb006484831b..adb03489bedf 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -95,7 +95,7 @@
 #define MIN_MAPPED_VRAM	(1024*768*1)
 
 #define CHIP_DEF(id, family, flags)					\
-	{ PCI_VENDOR_ID_ATI, id, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (flags) | (CHIP_FAMILY_##family) }
+	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, id), .driver_data = (flags) | (CHIP_FAMILY_##family) }
 
 static const struct pci_device_id radeonfb_pci_table[] = {
         /* Radeon Xpress 200m */
diff --git a/drivers/video/fbdev/carminefb.c b/drivers/video/fbdev/carminefb.c
index bd4bff6a2484..5f13f1cc79d3 100644
--- a/drivers/video/fbdev/carminefb.c
+++ b/drivers/video/fbdev/carminefb.c
@@ -753,9 +753,8 @@ static void carminefb_remove(struct pci_dev *dev)
 
 #define PCI_VENDOR_ID_FUJITU_LIMITED 0x10cf
 static struct pci_device_id carmine_devices[] = {
-{
-	PCI_DEVICE(PCI_VENDOR_ID_FUJITU_LIMITED, 0x202b)},
-	{0, 0, 0, 0, 0, 0, 0}
+	{ PCI_DEVICE(PCI_VENDOR_ID_FUJITU_LIMITED, 0x202b) },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, carmine_devices);
diff --git a/drivers/video/fbdev/cirrusfb.c b/drivers/video/fbdev/cirrusfb.c
index e29217e476ea..2693b5cc053f 100644
--- a/drivers/video/fbdev/cirrusfb.c
+++ b/drivers/video/fbdev/cirrusfb.c
@@ -253,7 +253,7 @@ static const struct cirrusfb_board_info_rec {
 
 #ifdef CONFIG_PCI
 #define CHIP(id, btype) \
-	{ PCI_VENDOR_ID_CIRRUS, id, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (btype) }
+	{ PCI_VDEVICE(CIRRUS, id), .driver_data = (btype) }
 
 static struct pci_device_id cirrusfb_pci_table[] = {
 	CHIP(PCI_DEVICE_ID_CIRRUS_5436, BT_ALPINE),
diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyber2000fb.c
index 2d12f8e96c7e..3daba94c6c13 100644
--- a/drivers/video/fbdev/cyber2000fb.c
+++ b/drivers/video/fbdev/cyber2000fb.c
@@ -1796,16 +1796,22 @@ static int __maybe_unused cyberpro_pci_resume(struct device *dev)
 
 static struct pci_device_id cyberpro_pci_table[] = {
 /*	Not yet
- *	{ PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_1682,
- *		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_IGA_1682 },
+ *	{
+ *		PCI_VDEVICE(INTERG, PCI_DEVICE_ID_INTERG_1682),
+ *		.driver_data = ID_IGA_1682,
+ *	},
  */
-	{ PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_2000,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_CYBERPRO_2000 },
-	{ PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_2010,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_CYBERPRO_2010 },
-	{ PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_5000,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_CYBERPRO_5000 },
-	{ 0, }
+	{
+		PCI_VDEVICE(INTERG, PCI_DEVICE_ID_INTERG_2000),
+		.driver_data = ID_CYBERPRO_2000,
+	}, {
+		PCI_VDEVICE(INTERG, PCI_DEVICE_ID_INTERG_2010),
+		.driver_data = ID_CYBERPRO_2010,
+	}, {
+		PCI_VDEVICE(INTERG, PCI_DEVICE_ID_INTERG_5000),
+		.driver_data = ID_CYBERPRO_5000,
+	},
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, cyberpro_pci_table);
diff --git a/drivers/video/fbdev/geode/gx1fb_core.c b/drivers/video/fbdev/geode/gx1fb_core.c
index a1919c1934ac..7cca46891aef 100644
--- a/drivers/video/fbdev/geode/gx1fb_core.c
+++ b/drivers/video/fbdev/geode/gx1fb_core.c
@@ -423,10 +423,12 @@ static void __init gx1fb_setup(char *options)
 #endif
 
 static struct pci_device_id gx1fb_id_table[] = {
-	{ PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5530_VIDEO,
-	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
-	  0xff0000, 0 },
-	{ 0, }
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5530_VIDEO),
+		.class = PCI_BASE_CLASS_DISPLAY << 16,
+		.class_mask = 0xff0000,
+	},
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, gx1fb_id_table);
diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
index c8b1dfa456a3..d756b3603fa6 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -645,9 +645,8 @@ static int kyrofb_ioctl(struct fb_info *info,
 }
 
 static const struct pci_device_id kyrofb_pci_tbl[] = {
-	{ PCI_VENDOR_ID_ST, PCI_DEVICE_ID_STG4000,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ 0, }
+	{ PCI_DEVICE(PCI_VENDOR_ID_ST, PCI_DEVICE_ID_STG4000) },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, kyrofb_pci_tbl);
diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbdev/matrox/matroxfb_base.c
index e1a4bc7c2318..22774eb1b14c 100644
--- a/drivers/video/fbdev/matrox/matroxfb_base.c
+++ b/drivers/video/fbdev/matrox/matroxfb_base.c
@@ -1642,7 +1642,7 @@ static int initMatrox2(struct matrox_fb_info *minfo, struct board *b)
 	int err;
 
 	static const struct pci_device_id intel_82437[] = {
-		{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82437) },
+		{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82437) },
 		{ },
 	};
 
@@ -2135,35 +2135,23 @@ static void pci_remove_matrox(struct pci_dev* pdev) {
 
 static const struct pci_device_id matroxfb_devices[] = {
 #ifdef CONFIG_FB_MATROX_MILLENIUM
-	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_MIL,
-		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
-	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_MIL_2,
-		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
-	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_MIL_2_AGP,
-		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
+	{ PCI_VDEVICE(MATROX, PCI_DEVICE_ID_MATROX_MIL) },
+	{ PCI_VDEVICE(MATROX, PCI_DEVICE_ID_MATROX_MIL_2) },
+	{ PCI_VDEVICE(MATROX, PCI_DEVICE_ID_MATROX_MIL_2_AGP) },
 #endif
 #ifdef CONFIG_FB_MATROX_MYSTIQUE
-	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_MYS,
-		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
+	{ PCI_VDEVICE(MATROX, PCI_DEVICE_ID_MATROX_MYS) },
 #endif
 #ifdef CONFIG_FB_MATROX_G
-	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G100_MM,
-		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
-	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G100_AGP,
-		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
-	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G200_PCI,
-		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
-	{PCI_VENDOR_ID_MATROX,	0x0532,
-		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
-	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G200_AGP,
-		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
-	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G400,
-		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
-	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G550,
-		PCI_ANY_ID,	PCI_ANY_ID,	0, 0, 0},
+	{ PCI_VDEVICE(MATROX, PCI_DEVICE_ID_MATROX_G100_MM) },
+	{ PCI_VDEVICE(MATROX, PCI_DEVICE_ID_MATROX_G100_AGP) },
+	{ PCI_VDEVICE(MATROX, PCI_DEVICE_ID_MATROX_G200_PCI) },
+	{ PCI_VDEVICE(MATROX, 0x0532) },
+	{ PCI_VDEVICE(MATROX, PCI_DEVICE_ID_MATROX_G200_AGP) },
+	{ PCI_VDEVICE(MATROX, PCI_DEVICE_ID_MATROX_G400) },
+	{ PCI_VDEVICE(MATROX, PCI_DEVICE_ID_MATROX_G550) },
 #endif
-	{0,			0,
-		0,		0,		0, 0, 0}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, matroxfb_devices);
diff --git a/drivers/video/fbdev/neofb.c b/drivers/video/fbdev/neofb.c
index c1cd028b8991..e0b8d4d6ce79 100644
--- a/drivers/video/fbdev/neofb.c
+++ b/drivers/video/fbdev/neofb.c
@@ -2126,34 +2126,25 @@ static void neofb_remove(struct pci_dev *dev)
 }
 
 static const struct pci_device_id neofb_devices[] = {
-	{PCI_VENDOR_ID_NEOMAGIC, PCI_CHIP_NM2070,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_NEOMAGIC_NM2070},
+	{ PCI_VDEVICE(NEOMAGIC, PCI_CHIP_NM2070), .driver_data = FB_ACCEL_NEOMAGIC_NM2070 },
 
-	{PCI_VENDOR_ID_NEOMAGIC, PCI_CHIP_NM2090,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_NEOMAGIC_NM2090},
+	{ PCI_VDEVICE(NEOMAGIC, PCI_CHIP_NM2090), .driver_data = FB_ACCEL_NEOMAGIC_NM2090 },
 
-	{PCI_VENDOR_ID_NEOMAGIC, PCI_CHIP_NM2093,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_NEOMAGIC_NM2093},
+	{ PCI_VDEVICE(NEOMAGIC, PCI_CHIP_NM2093), .driver_data = FB_ACCEL_NEOMAGIC_NM2093 },
 
-	{PCI_VENDOR_ID_NEOMAGIC, PCI_CHIP_NM2097,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_NEOMAGIC_NM2097},
+	{ PCI_VDEVICE(NEOMAGIC, PCI_CHIP_NM2097), .driver_data = FB_ACCEL_NEOMAGIC_NM2097 },
 
-	{PCI_VENDOR_ID_NEOMAGIC, PCI_CHIP_NM2160,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_NEOMAGIC_NM2160},
+	{ PCI_VDEVICE(NEOMAGIC, PCI_CHIP_NM2160), .driver_data = FB_ACCEL_NEOMAGIC_NM2160 },
 
-	{PCI_VENDOR_ID_NEOMAGIC, PCI_CHIP_NM2200,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_NEOMAGIC_NM2200},
+	{ PCI_VDEVICE(NEOMAGIC, PCI_CHIP_NM2200), .driver_data = FB_ACCEL_NEOMAGIC_NM2200 },
 
-	{PCI_VENDOR_ID_NEOMAGIC, PCI_CHIP_NM2230,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_NEOMAGIC_NM2230},
+	{ PCI_VDEVICE(NEOMAGIC, PCI_CHIP_NM2230), .driver_data = FB_ACCEL_NEOMAGIC_NM2230 },
 
-	{PCI_VENDOR_ID_NEOMAGIC, PCI_CHIP_NM2360,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_NEOMAGIC_NM2360},
+	{ PCI_VDEVICE(NEOMAGIC, PCI_CHIP_NM2360), .driver_data = FB_ACCEL_NEOMAGIC_NM2360 },
 
-	{PCI_VENDOR_ID_NEOMAGIC, PCI_CHIP_NM2380,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_NEOMAGIC_NM2380},
+	{ PCI_VDEVICE(NEOMAGIC, PCI_CHIP_NM2380), .driver_data = FB_ACCEL_NEOMAGIC_NM2380 },
 
-	{0, 0, 0, 0, 0, 0, 0}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, neofb_devices);
diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index 72b85f475605..da2d486022e8 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -58,9 +58,12 @@
 #define MAX_CURS		32
 
 static const struct pci_device_id nvidiafb_pci_tbl[] = {
-	{PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-	 PCI_BASE_CLASS_DISPLAY << 16, 0xff0000, 0},
-	{ 0, }
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID),
+		.class = PCI_BASE_CLASS_DISPLAY << 16,
+		.class_mask = 0xff0000
+	},
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, nvidiafb_pci_tbl);
 
diff --git a/drivers/video/fbdev/pm2fb.c b/drivers/video/fbdev/pm2fb.c
index f34429829b7d..412ff249b5c7 100644
--- a/drivers/video/fbdev/pm2fb.c
+++ b/drivers/video/fbdev/pm2fb.c
@@ -1748,13 +1748,10 @@ static void pm2fb_remove(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id pm2fb_id_table[] = {
-	{ PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_TVP4020,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_3DLABS, PCI_DEVICE_ID_3DLABS_PERMEDIA2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_3DLABS, PCI_DEVICE_ID_3DLABS_PERMEDIA2V,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ 0, }
+	{ PCI_VDEVICE(TI, PCI_DEVICE_ID_TI_TVP4020) },
+	{ PCI_VDEVICE(3DLABS, PCI_DEVICE_ID_3DLABS_PERMEDIA2) },
+	{ PCI_VDEVICE(3DLABS, PCI_DEVICE_ID_3DLABS_PERMEDIA2V) },
+	{ }
 };
 
 static struct pci_driver pm2fb_driver = {
diff --git a/drivers/video/fbdev/pm3fb.c b/drivers/video/fbdev/pm3fb.c
index 6e55e42514d6..6f552ae36219 100644
--- a/drivers/video/fbdev/pm3fb.c
+++ b/drivers/video/fbdev/pm3fb.c
@@ -1486,9 +1486,8 @@ static void pm3fb_remove(struct pci_dev *dev)
 }
 
 static const struct pci_device_id pm3fb_id_table[] = {
-	{ PCI_VENDOR_ID_3DLABS, 0x0a,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ 0, }
+	{ PCI_VDEVICE(3DLABS, 0x000a) },
+	{ }
 };
 
 /* For PCI drivers */
diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index 3f6384e631b1..06aefad75f46 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -993,9 +993,8 @@ static void pvr2fb_pci_remove(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id pvr2fb_pci_tbl[] = {
-	{ PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_NEON250,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ 0, },
+	{ PCI_VDEVICE(NEC, PCI_DEVICE_ID_NEC_NEON250), },
+	{ },
 };
 
 MODULE_DEVICE_TABLE(pci, pvr2fb_pci_tbl);
diff --git a/drivers/video/fbdev/riva/fbdev.c b/drivers/video/fbdev/riva/fbdev.c
index 1e377b2ec089..2268fea4d807 100644
--- a/drivers/video/fbdev/riva/fbdev.c
+++ b/drivers/video/fbdev/riva/fbdev.c
@@ -103,92 +103,50 @@ static int rivafb_blank(int blank, struct fb_info *info);
  * ------------------------------------------------------------------------- */
 
 static const struct pci_device_id rivafb_pci_tbl[] = {
-	{ PCI_VENDOR_ID_NVIDIA_SGS, PCI_DEVICE_ID_NVIDIA_SGS_RIVA128,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TNT,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TNT2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_UTNT2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_VTNT2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_UVTNT2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_ITNT2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_SDR,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_DDR,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_MX,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_MX2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_GO,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO2_MXR,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_GTS,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_GTS2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_ULTRA,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO2_PRO,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_460,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_440,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA_SGS, PCI_DEVICE_ID_NVIDIA_SGS_RIVA128) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TNT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_TNT2) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_UTNT2) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_VTNT2) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_UVTNT2) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_ITNT2) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_SDR) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_DDR) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_MX) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_MX2) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_GO) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO2_MXR) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_GTS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_GTS2) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_ULTRA) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO2_PRO) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_460) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_440) },
 	// NF2/IGP version, GeForce 4 MX, NV18
-	{ PCI_VENDOR_ID_NVIDIA, 0x01f0,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_420,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_440_GO,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_420_GO,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_420_GO_M32,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_500XGL,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_440_GO_M64,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_200,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_550XGL,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_500_GOGL,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_IGEFORCE2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE3,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE3_1,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE3_2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO_DDC,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4600,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4400,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4200,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
- 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_900XGL,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_750XGL,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5200,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ 0, } /* terminate list */
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, 0x01f0) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_420) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_440_GO) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_420_GO) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_420_GO_M32) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_500XGL) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_440_GO_M64) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_200) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_550XGL) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_500_GOGL) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_IGEFORCE2) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE3_1) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE3_2) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO_DDC) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4600) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4400) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4200) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_900XGL) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_750XGL) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5200) },
+	{ } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, rivafb_pci_tbl);
 
diff --git a/drivers/video/fbdev/s3fb.c b/drivers/video/fbdev/s3fb.c
index ba30e5568cab..831e9e6861b1 100644
--- a/drivers/video/fbdev/s3fb.c
+++ b/drivers/video/fbdev/s3fb.c
@@ -1563,24 +1563,24 @@ static const struct dev_pm_ops s3_pci_pm_ops = {
 /* List of boards that we are trying to support */
 
 static const struct pci_device_id s3_devices[] = {
-	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8810), .driver_data = CHIP_XXX_TRIO},
-	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8811), .driver_data = CHIP_XXX_TRIO},
-	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8812), .driver_data = CHIP_M65_AURORA64VP},
-	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8814), .driver_data = CHIP_767_TRIO64UVP},
-	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8901), .driver_data = CHIP_XXX_TRIO64V2_DXGX},
-	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8902), .driver_data = CHIP_551_PLATO_PX},
+	{ PCI_VDEVICE(S3, 0x8810), .driver_data = CHIP_XXX_TRIO },
+	{ PCI_VDEVICE(S3, 0x8811), .driver_data = CHIP_XXX_TRIO },
+	{ PCI_VDEVICE(S3, 0x8812), .driver_data = CHIP_M65_AURORA64VP },
+	{ PCI_VDEVICE(S3, 0x8814), .driver_data = CHIP_767_TRIO64UVP },
+	{ PCI_VDEVICE(S3, 0x8901), .driver_data = CHIP_XXX_TRIO64V2_DXGX },
+	{ PCI_VDEVICE(S3, 0x8902), .driver_data = CHIP_551_PLATO_PX },
 
-	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x5631), .driver_data = CHIP_325_VIRGE},
-	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x883D), .driver_data = CHIP_988_VIRGE_VX},
-	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8A01), .driver_data = CHIP_XXX_VIRGE_DXGX},
-	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8A10), .driver_data = CHIP_357_VIRGE_GX2},
-	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8A11), .driver_data = CHIP_359_VIRGE_GX2P},
-	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8A12), .driver_data = CHIP_359_VIRGE_GX2P},
-	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8A13), .driver_data = CHIP_36X_TRIO3D_1X_2X},
-	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8904), .driver_data = CHIP_365_TRIO3D},
-	{PCI_DEVICE(PCI_VENDOR_ID_S3, 0x8C01), .driver_data = CHIP_260_VIRGE_MX},
+	{ PCI_VDEVICE(S3, 0x5631), .driver_data = CHIP_325_VIRGE },
+	{ PCI_VDEVICE(S3, 0x883D), .driver_data = CHIP_988_VIRGE_VX },
+	{ PCI_VDEVICE(S3, 0x8A01), .driver_data = CHIP_XXX_VIRGE_DXGX },
+	{ PCI_VDEVICE(S3, 0x8A10), .driver_data = CHIP_357_VIRGE_GX2 },
+	{ PCI_VDEVICE(S3, 0x8A11), .driver_data = CHIP_359_VIRGE_GX2P },
+	{ PCI_VDEVICE(S3, 0x8A12), .driver_data = CHIP_359_VIRGE_GX2P },
+	{ PCI_VDEVICE(S3, 0x8A13), .driver_data = CHIP_36X_TRIO3D_1X_2X },
+	{ PCI_VDEVICE(S3, 0x8904), .driver_data = CHIP_365_TRIO3D },
+	{ PCI_VDEVICE(S3, 0x8C01), .driver_data = CHIP_260_VIRGE_MX },
 
-	{0, 0, 0, 0, 0, 0, 0}
+	{ }
 };
 
 
diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index c2f79357c8da..7789196d2eb5 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -2449,76 +2449,78 @@ static const struct dev_pm_ops savagefb_pm_ops = {
 };
 
 static const struct pci_device_id savagefb_devices[] = {
-	{PCI_VENDOR_ID_S3, PCI_CHIP_SUPSAV_MX128,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_SUPERSAVAGE},
+	{
+		PCI_VDEVICE(S3, PCI_CHIP_SUPSAV_MX128),
+		.driver_data = FB_ACCEL_SUPERSAVAGE,
+	}, {
+		PCI_VDEVICE(S3, PCI_CHIP_SUPSAV_MX64),
+		.driver_data = FB_ACCEL_SUPERSAVAGE,
+	}, {
+		PCI_VDEVICE(S3, PCI_CHIP_SUPSAV_MX64C),
+		.driver_data = FB_ACCEL_SUPERSAVAGE,
+	}, {
+		PCI_VDEVICE(S3, PCI_CHIP_SUPSAV_IX128SDR),
+		.driver_data = FB_ACCEL_SUPERSAVAGE,
+	}, {
+		PCI_VDEVICE(S3, PCI_CHIP_SUPSAV_IX128DDR),
+		.driver_data = FB_ACCEL_SUPERSAVAGE,
+	}, {
+		PCI_VDEVICE(S3, PCI_CHIP_SUPSAV_IX64SDR),
+		.driver_data = FB_ACCEL_SUPERSAVAGE,
+	}, {
+		PCI_VDEVICE(S3, PCI_CHIP_SUPSAV_IX64DDR),
+		.driver_data = FB_ACCEL_SUPERSAVAGE,
+	}, {
+		PCI_VDEVICE(S3, PCI_CHIP_SUPSAV_IXCSDR),
+		.driver_data = FB_ACCEL_SUPERSAVAGE,
+	}, {
+		PCI_VDEVICE(S3, PCI_CHIP_SUPSAV_IXCDDR),
+		.driver_data = FB_ACCEL_SUPERSAVAGE,
+	}, {
+		PCI_VDEVICE(S3, PCI_CHIP_SAVAGE4),
+		.driver_data = FB_ACCEL_SAVAGE4,
+	}, {
+		PCI_VDEVICE(S3, PCI_CHIP_SAVAGE3D),
+		.driver_data = FB_ACCEL_SAVAGE3D,
+	}, {
+		PCI_VDEVICE(S3, PCI_CHIP_SAVAGE3D_MV),
+		.driver_data = FB_ACCEL_SAVAGE3D_MV,
+	}, {
+		PCI_VDEVICE(S3, PCI_CHIP_SAVAGE2000),
+		.driver_data = FB_ACCEL_SAVAGE2000,
+	}, {
+		PCI_VDEVICE(S3, PCI_CHIP_SAVAGE_MX_MV),
+		.driver_data = FB_ACCEL_SAVAGE_MX_MV,
+	}, {
+		PCI_VDEVICE(S3, PCI_CHIP_SAVAGE_MX),
+		.driver_data = FB_ACCEL_SAVAGE_MX,
+	}, {
+		PCI_VDEVICE(S3, PCI_CHIP_SAVAGE_IX_MV),
+		.driver_data = FB_ACCEL_SAVAGE_IX_MV,
+	}, {
+		PCI_VDEVICE(S3, PCI_CHIP_SAVAGE_IX),
+		.driver_data = FB_ACCEL_SAVAGE_IX,
+	}, {
+		PCI_VDEVICE(S3, PCI_CHIP_PROSAVAGE_PM),
+		.driver_data = FB_ACCEL_PROSAVAGE_PM,
+	}, {
+		PCI_VDEVICE(S3, PCI_CHIP_PROSAVAGE_KM),
+		.driver_data = FB_ACCEL_PROSAVAGE_KM,
+	}, {
+		PCI_VDEVICE(S3, PCI_CHIP_S3TWISTER_P),
+		.driver_data = FB_ACCEL_S3TWISTER_P,
+	}, {
+		PCI_VDEVICE(S3, PCI_CHIP_S3TWISTER_K),
+		.driver_data = FB_ACCEL_S3TWISTER_K,
+	}, {
+		PCI_VDEVICE(S3, PCI_CHIP_PROSAVAGE_DDR),
+		.driver_data = FB_ACCEL_PROSAVAGE_DDR,
+	}, {
+		PCI_VDEVICE(S3, PCI_CHIP_PROSAVAGE_DDRK),
+		.driver_data = FB_ACCEL_PROSAVAGE_DDRK,
+	},
 
-	{PCI_VENDOR_ID_S3, PCI_CHIP_SUPSAV_MX64,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_SUPERSAVAGE},
-
-	{PCI_VENDOR_ID_S3, PCI_CHIP_SUPSAV_MX64C,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_SUPERSAVAGE},
-
-	{PCI_VENDOR_ID_S3, PCI_CHIP_SUPSAV_IX128SDR,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_SUPERSAVAGE},
-
-	{PCI_VENDOR_ID_S3, PCI_CHIP_SUPSAV_IX128DDR,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_SUPERSAVAGE},
-
-	{PCI_VENDOR_ID_S3, PCI_CHIP_SUPSAV_IX64SDR,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_SUPERSAVAGE},
-
-	{PCI_VENDOR_ID_S3, PCI_CHIP_SUPSAV_IX64DDR,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_SUPERSAVAGE},
-
-	{PCI_VENDOR_ID_S3, PCI_CHIP_SUPSAV_IXCSDR,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_SUPERSAVAGE},
-
-	{PCI_VENDOR_ID_S3, PCI_CHIP_SUPSAV_IXCDDR,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_SUPERSAVAGE},
-
-	{PCI_VENDOR_ID_S3, PCI_CHIP_SAVAGE4,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_SAVAGE4},
-
-	{PCI_VENDOR_ID_S3, PCI_CHIP_SAVAGE3D,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_SAVAGE3D},
-
-	{PCI_VENDOR_ID_S3, PCI_CHIP_SAVAGE3D_MV,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_SAVAGE3D_MV},
-
-	{PCI_VENDOR_ID_S3, PCI_CHIP_SAVAGE2000,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_SAVAGE2000},
-
-	{PCI_VENDOR_ID_S3, PCI_CHIP_SAVAGE_MX_MV,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_SAVAGE_MX_MV},
-
-	{PCI_VENDOR_ID_S3, PCI_CHIP_SAVAGE_MX,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_SAVAGE_MX},
-
-	{PCI_VENDOR_ID_S3, PCI_CHIP_SAVAGE_IX_MV,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_SAVAGE_IX_MV},
-
-	{PCI_VENDOR_ID_S3, PCI_CHIP_SAVAGE_IX,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_SAVAGE_IX},
-
-	{PCI_VENDOR_ID_S3, PCI_CHIP_PROSAVAGE_PM,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_PROSAVAGE_PM},
-
-	{PCI_VENDOR_ID_S3, PCI_CHIP_PROSAVAGE_KM,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_PROSAVAGE_KM},
-
-	{PCI_VENDOR_ID_S3, PCI_CHIP_S3TWISTER_P,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_S3TWISTER_P},
-
-	{PCI_VENDOR_ID_S3, PCI_CHIP_S3TWISTER_K,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_S3TWISTER_K},
-
-	{PCI_VENDOR_ID_S3, PCI_CHIP_PROSAVAGE_DDR,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_PROSAVAGE_DDR},
-
-	{PCI_VENDOR_ID_S3, PCI_CHIP_PROSAVAGE_DDRK,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_PROSAVAGE_DDRK},
-
-	{0, 0, 0, 0, 0, 0, 0}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, savagefb_devices);
diff --git a/drivers/video/fbdev/sis/sis_main.h b/drivers/video/fbdev/sis/sis_main.h
index 0965db9fad6a..4ca487f48205 100644
--- a/drivers/video/fbdev/sis/sis_main.h
+++ b/drivers/video/fbdev/sis/sis_main.h
@@ -102,22 +102,22 @@ static struct sisfb_chip_info {
 
 static struct pci_device_id sisfb_pci_table[] = {
 #ifdef CONFIG_FB_SIS_300
-	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_300,     PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_540_VGA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
-	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_630_VGA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
+	{ PCI_VDEVICE(SI, PCI_DEVICE_ID_SI_300), .driver_data = 0 },
+	{ PCI_VDEVICE(SI, PCI_DEVICE_ID_SI_540_VGA), .driver_data = 1 },
+	{ PCI_VDEVICE(SI, PCI_DEVICE_ID_SI_630_VGA), .driver_data = 2 },
 #endif
 #ifdef CONFIG_FB_SIS_315
-	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_315H,    PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
-	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_315,     PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
-	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_315PRO,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5},
-	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_550_VGA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6},
-	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_650_VGA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 7},
-	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_330,     PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8},
-	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_660_VGA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 9},
-	{ PCI_VENDOR_ID_XGI,PCI_DEVICE_ID_XGI_20,     PCI_ANY_ID, PCI_ANY_ID, 0, 0,10},
-	{ PCI_VENDOR_ID_XGI,PCI_DEVICE_ID_XGI_40,     PCI_ANY_ID, PCI_ANY_ID, 0, 0,11},
+	{ PCI_VDEVICE(SI, PCI_DEVICE_ID_SI_315H), .driver_data = 3 },
+	{ PCI_VDEVICE(SI, PCI_DEVICE_ID_SI_315), .driver_data = 4 },
+	{ PCI_VDEVICE(SI, PCI_DEVICE_ID_SI_315PRO), .driver_data = 5 },
+	{ PCI_VDEVICE(SI, PCI_DEVICE_ID_SI_550_VGA), .driver_data = 6 },
+	{ PCI_VDEVICE(SI, PCI_DEVICE_ID_SI_650_VGA), .driver_data = 7 },
+	{ PCI_VDEVICE(SI, PCI_DEVICE_ID_SI_330), .driver_data = 8 },
+	{ PCI_VDEVICE(SI, PCI_DEVICE_ID_SI_660_VGA), .driver_data = 9 },
+	{ PCI_VDEVICE(XGI, PCI_DEVICE_ID_XGI_20), .driver_data = 10 },
+	{ PCI_VDEVICE(XGI, PCI_DEVICE_ID_XGI_40), .driver_data = 11 },
 #endif
-	{ 0 }
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, sisfb_pci_table);
diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index 4c4e53aaea3a..a6b63c09b48f 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -124,16 +124,17 @@ static int tdfxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id);
 static void tdfxfb_remove(struct pci_dev *pdev);
 
 static const struct pci_device_id tdfxfb_id_table[] = {
-	{ PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_BANSHEE,
-	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
-	  0xff0000, 0 },
-	{ PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_VOODOO3,
-	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
-	  0xff0000, 0 },
-	{ PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_VOODOO5,
-	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
-	  0xff0000, 0 },
-	{ 0, }
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_BANSHEE),
+		.class = PCI_BASE_CLASS_DISPLAY << 16, .class_mask = 0xff0000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_VOODOO3),
+		.class = PCI_BASE_CLASS_DISPLAY << 16, .class_mask = 0xff0000,
+	}, {
+		PCI_DEVICE(PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_VOODOO5),
+		.class = PCI_BASE_CLASS_DISPLAY << 16, .class_mask = 0xff0000,
+	},
+	{ }
 };
 
 static struct pci_driver tdfxfb_driver = {
diff --git a/drivers/video/fbdev/tridentfb.c b/drivers/video/fbdev/tridentfb.c
index 17b7253b8fbe..a8fdbae83a80 100644
--- a/drivers/video/fbdev/tridentfb.c
+++ b/drivers/video/fbdev/tridentfb.c
@@ -1736,28 +1736,28 @@ static void trident_pci_remove(struct pci_dev *dev)
 
 /* List of boards that we are trying to support */
 static const struct pci_device_id trident_devices[] = {
-	{PCI_VENDOR_ID_TRIDENT,	BLADE3D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEi7, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEi7D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEi1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEi1D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEAi1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEAi1D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEE4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{PCI_VENDOR_ID_TRIDENT,	TGUI9440, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{PCI_VENDOR_ID_TRIDENT,	TGUI9660, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{PCI_VENDOR_ID_TRIDENT,	IMAGE975, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{PCI_VENDOR_ID_TRIDENT,	IMAGE985, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{PCI_VENDOR_ID_TRIDENT,	CYBER9320, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{PCI_VENDOR_ID_TRIDENT,	CYBER9388, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{PCI_VENDOR_ID_TRIDENT,	CYBER9520, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{PCI_VENDOR_ID_TRIDENT,	CYBER9525DVD, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{PCI_VENDOR_ID_TRIDENT,	CYBER9397, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{PCI_VENDOR_ID_TRIDENT,	CYBER9397DVD, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEXPAi1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEXPm8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEXPm16, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{0,}
+	{ PCI_VDEVICE(TRIDENT, BLADE3D) },
+	{ PCI_VDEVICE(TRIDENT, CYBERBLADEi7) },
+	{ PCI_VDEVICE(TRIDENT, CYBERBLADEi7D) },
+	{ PCI_VDEVICE(TRIDENT, CYBERBLADEi1) },
+	{ PCI_VDEVICE(TRIDENT, CYBERBLADEi1D) },
+	{ PCI_VDEVICE(TRIDENT, CYBERBLADEAi1) },
+	{ PCI_VDEVICE(TRIDENT, CYBERBLADEAi1D) },
+	{ PCI_VDEVICE(TRIDENT, CYBERBLADEE4) },
+	{ PCI_VDEVICE(TRIDENT, TGUI9440) },
+	{ PCI_VDEVICE(TRIDENT, TGUI9660) },
+	{ PCI_VDEVICE(TRIDENT, IMAGE975) },
+	{ PCI_VDEVICE(TRIDENT, IMAGE985) },
+	{ PCI_VDEVICE(TRIDENT, CYBER9320) },
+	{ PCI_VDEVICE(TRIDENT, CYBER9388) },
+	{ PCI_VDEVICE(TRIDENT, CYBER9520) },
+	{ PCI_VDEVICE(TRIDENT, CYBER9525DVD) },
+	{ PCI_VDEVICE(TRIDENT, CYBER9397) },
+	{ PCI_VDEVICE(TRIDENT, CYBER9397DVD) },
+	{ PCI_VDEVICE(TRIDENT, CYBERBLADEXPAi1) },
+	{ PCI_VDEVICE(TRIDENT, CYBERBLADEXPm8) },
+	{ PCI_VDEVICE(TRIDENT, CYBERBLADEXPm16) },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, trident_devices);
diff --git a/drivers/video/fbdev/vt8623fb.c b/drivers/video/fbdev/vt8623fb.c
index df984f3a7ff6..9708d968970a 100644
--- a/drivers/video/fbdev/vt8623fb.c
+++ b/drivers/video/fbdev/vt8623fb.c
@@ -900,8 +900,8 @@ static const struct dev_pm_ops vt8623_pci_pm_ops = {
 /* List of boards that we are trying to support */
 
 static const struct pci_device_id vt8623_devices[] = {
-	{PCI_DEVICE(PCI_VENDOR_ID_VIA, 0x3122)},
-	{0, 0, 0, 0, 0, 0, 0}
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, 0x3122) },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, vt8623_devices);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

