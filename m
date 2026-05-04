Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBBBFF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 07:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B886010E0DD;
	Mon,  4 May 2026 07:34:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="XtF6QeA6";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ED7710E0DD
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 07:34:36 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so29368795e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 00:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777880075; x=1778484875;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ikXVRoL7UxdcoQ7zQVqAT6TJS61guAaeU9Wz822bWgs=;
 b=XtF6QeA6AMswlABbHjr/VS1r9jHAvAXfA2j8bCKRP2pL2vnym63xW0UtmSDv3mXRTL
 kfgzJ6mlTQR+gOqeR/GXUwu5rWH3GFz8FE79j2k+qq3Upby7yLQU2ncUhiV7HpYUljmT
 JxTPElfKjTVI01jvr/Drnblwk6ZwhY6+8fpAXr/lnKG7Jh0rUnD5QzG73R+m8rumStRr
 UhB1QCDCtZ9BsrFev9zhu0bxTyNXU0/ur2iPvDyFakgtr3fLMuCfup8RGmeVljBzF7hr
 bZ3y3BS9GtNvfHqL/a+r8iYMW1V+KWRYJ2/OnR/sofcfIA60Tffe9HIlNjo752SQRrdK
 aCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777880075; x=1778484875;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ikXVRoL7UxdcoQ7zQVqAT6TJS61guAaeU9Wz822bWgs=;
 b=PEaUK5NpVOLys8AvJU/SYTeu+IlAr2OBErskYTsF1bSedIK/eQJGHQQ7m3BFJZBW+1
 uDdE4h7P0MPN2Te7AatkYrP1HOSIOLnxLUch210YvHdCpCLs+wtkukuNaj6XZ58uizLS
 5E3Cih5i5Pu5sBqrfIrN0tCBbnW20gl7tJPs1AaeP8yqMfA4M9MjSPD7IcYTzmoPkRUM
 XAFnnckG4aBc2hLno2YJVnbDLIOqbfq0uInkvCCkhTQ5ECLUacZBwwiVY1FzDEXqVDHN
 b/jKMoexC49Qed1MZr0SyFG1gnQsPovALeNEK1CCB0F6gJUqClyNAcHhnwg7ag59U/d6
 XpFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ93DotFObWTjby/+BXrTZezcPfSLL/CfuedAmsDlNpdtH3UHbz4/RqYbU8ute//P7fMkMoWT/GD0Uc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyi0RntbBYlFXV0FMbEkzabJERWmvptE1rn+7/UPn7IjsRH8UyA
 uTVDx3YR4HEYyevOzKM8sT5E/YMsnIO5ttsxFA5nc0Txu/iwhUu/89F+pZ2nWyqmPA0=
X-Gm-Gg: AeBDieuQdxWIFfzqhukpUSoGbqYIChVJWq2gvV9bwV8zghU3LK4WfKoT6zb9aEG/9hL
 5Ne69YqYgxETUtzTl+ISTWPI9Z4bbMUknHC2ZNCXX4UqZ8fCzPIYAqeJxHrhho3I0dqdTlyUiog
 EphVP/3r79NJbZ69X9vch6xJZdgOFn3edT67os1DB3KaqNDxl0U5rX69ZsU8dzbYyu6xDUU2P2K
 MPQsAxLgkt3Ot6eJBoT67DLXbvwx/XBrTmFQX+hrY7gFYniel9/liQXkumpzJ9fj/MHjeqgU2Nw
 VZuq/8eDWaSFinCwkTda6/PZgCoNplLz73NQfUMbfSv/KaAy5Gw/jVawCJrWjU0Gbxdi/StcHCA
 9VCYpglwQu+x7/ijJbWwMW61l7JFBU+4ApLoaR90V9S9/McG/A+Y1PrfZr+f4jinfksd5mdx6Z0
 MkW9LLLtIkOipp5ZuJVKkpmgxIHy+eocmuKT9MrjwVZeV6giiQIkm1qEz2iGSJCbcPYPNHbzbTU
 oJy4yrjO//N7GTQS40B5RYASg==
X-Received: by 2002:a05:600c:4e4d:b0:488:af7f:7707 with SMTP id
 5b1f17b1804b1-48a98663189mr156282625e9.18.1777880074832; 
 Mon, 04 May 2026 00:34:34 -0700 (PDT)
Received: from localhost
 (p200300f65f114e08f5a4175dadf07882.dip0.t-ipconnect.de.
 [2003:f6:5f11:4e08:f5a4:175d:adf0:7882])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48a8feb0cbfsm105853715e9.2.2026.05.04.00.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 00:34:34 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Zack Rusin <zack.rusin@broadcom.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: Don't use UTS_RELEASE directly
Date: Mon,  4 May 2026 09:34:20 +0200
Message-ID: <20260504073422.1130008-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1949;
 i=u.kleine-koenig@baylibre.com; h=from:subject;
 bh=IvpBzrTG8NsRbACgF6uIDFqr/tHY09F62gKICIeQhBU=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp+Ev+gQ84ZfIwKeIdxO14OnTXaeamQgdaf6msa
 8VNof+RPyKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafhL/gAKCRCPgPtYfRL+
 TvCVB/998JTZnFpdrEZrgFbZyiGMA5KaFJ4x7pDaHhSV5hYwZqfLmZGJkr9gJb7tzJ+F89hDdpH
 A+4/AtT6bEFMt4kWcV/6bdh5nAr6KeQLK9bi7hGWle5m22LjHzhESHkhZOvSaMeZkvX6ZkbafY+
 EyrgEeY38IGZkrSgrdJp4HUdPeh46fXDp7FqCZok1gRo7S1Bn3Lec/a2uGibMquhWow+60+8g0g
 7zx2k3SeBKnG/VJ2jvX1jEDuKdnsjOBtim31NAUNr0oLrzLhjPrjkOFCoFCdmDMiVHaGKhZdTnW
 idn/k5dfMc6CMfMKxGOaO7qbfLNGDSpKvs8tcGDC9Xo/9VYi
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

UTS_RELEASE evaluates to a static string and changes quite easily (e.g.
uncommitted changes in the source tree or new commits). So when checking
if a patch introduces changes to the resulting binary each usage of
UTS_RELEASE is source of annoyance.

Instead of using UTS_RELEASE directly use init_utsname()->release which
evaluates to the same string but with that a change of UTS_RELEASE
doesn't affect vmwgfx_drv.o.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

an alternative way to address this is to drop the kernel version string
completely. But I'm not sure how redundant this really is so I chose the
init_utsname() approach.

Best regards
Uwe

 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 0f101aedb49a..12f5f288ae15 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -24,7 +24,6 @@
 #include <drm/drm_sysfs.h>
 #include <drm/ttm/ttm_range_manager.h>
 #include <drm/ttm/ttm_placement.h>
-#include <generated/utsrelease.h>
 
 #ifdef CONFIG_X86
 #include <asm/hypervisor.h>
@@ -35,6 +34,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/utsname.h>
 #include <linux/version.h>
 #include <linux/vmalloc.h>
 
@@ -1115,7 +1115,7 @@ static int vmw_driver_load(struct vmw_private *dev_priv, u32 pci_id)
 	vmw_print_sm_type(dev_priv);
 	vmw_host_printf("vmwgfx: Module Version: %d.%d.%d (kernel: %s)",
 			VMWGFX_DRIVER_MAJOR, VMWGFX_DRIVER_MINOR,
-			VMWGFX_DRIVER_PATCHLEVEL, UTS_RELEASE);
+			VMWGFX_DRIVER_PATCHLEVEL, init_utsname()->release);
 	vmw_write_driver_id(dev_priv);
 
 	dev_priv->pm_nb.notifier_call = vmwgfx_pm_notifier;

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

