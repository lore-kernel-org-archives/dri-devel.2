Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618EAC88E56
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 12:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5900D10E0C3;
	Sun, 13 Sep 2026 12:02:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="azogx67p";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CFF610E0C3
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 12:02:39 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2db18fe459dso4345545ad.3
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 05:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789300959; x=1789905759; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dZ5JOsCZ04J11iAGe8msFZoGQpgRKm5XQ0vjKi0ufM8=;
 b=azogx67ps9fM4Po1Du5rqdv0nmF/5CeEpsbak1QLhFQKqfimWDt+S0UJgSEIYWvp3z
 UWwmG6L9Jr5+nOEjkqNWc+jLVvi2VSvgtBRnR9fY+yh8XBxEGOnhqZJNodkPP9l4w+oU
 QY96iDBRRZqw/53PgE/DyDk82j53uMY1xNE2jjcjFMOUtKRTGFq0m9s2mCM57rBHkeRk
 9wdeBdMGMXr1jLTCGhlzQoKheCE4oNTNKoWW+4GsPKodXGoz6ikd8gpZ0HmPzQKueTYT
 dNTD4mQpXq4CiiBr+qqWIMaEiDenvc01HhdP0JdCsukSzX30BLGrcXzU20E8zLfonuWf
 GR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789300959; x=1789905759;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dZ5JOsCZ04J11iAGe8msFZoGQpgRKm5XQ0vjKi0ufM8=;
 b=lvupgta+2z8g7T7tSm7dqJ3z1YzJy4NmDIoBn44qf7wSopczZxZg7YK+b3dBsdR5Gq
 Q+SMB2Euqz8FviFmPWrwITKTeMCpTwbBLqP/8+MEIjjrqRqDbP9Iy+S+Z2sh6cZaIA2c
 jCz7mHihSvdHHdAtaNNQ37Kx+1Hxd8Ip6AzzAih0BOiif9W5tNGwNBYcSESTYWptrSQp
 ZA4R7EaEuGoLJ2ymY+tYA0IwDmulip+WhRR9DoHKGtHy4mEWZHopzZaD0d5KK7WhR2oE
 Qy+VXOpGGo2ikyUNBQIQbCrzfnXOLR4qpF1HysCaP90yAB+2FumLfFr3Cpcm+h637/4y
 XgPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwctJEdYAZ4eJwZNp+3bi8nNKHe167jAjfdtOCZYpqA/TKD8IyA45sRKC2+sO//NQjhw14cJKkkMls=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ljJhFKbAnzxsDHz3V/bsDw4phmqEwHF3wEqLR2x54HboEYG4Xq
 aKi1zUc8nCxhGpLXI2Rg2MFVMQHGhb0BMPlDpBkAttflp2z2JPbu6gaW
X-Gm-Gg: AYBFou1ekPxMp5/pysIPq833qaMaxuhz5FQZoW8Fy4RwVGTw8ZZrUOVmZWxrTx9AJiv
 Z+41sWw88zPRNLLfEv0mGBLF9cAl8u7zDMttpYJIWzmuSEOm3JLhyqdwauoEJn4rd/v2ZF38Brn
 A5UMDhxGdojLvpGPoelec/dWyLVu4aRXiH+6HR5MVHii/b7cHBk3B0F1MzKO+MgF5Ryavtd2DZs
 Xz9xabtaDb4XVuJs0+tv1z6bk65u1tKuk19Is6CwSqYIUQsroWGVA4f9kPTBxisxdAXwSdHGal5
 ZOH4sM9jXF/gKSTzZM/N5l2EDkEUxdNfY+6mbCcb02n/lRuWR+NtAfxkcj0y7qymL/FUX5EPt5Y
 HNSjKIUpIhFJh5Cnev/GXpBlIoKzLNPvZIgNzOnll78c436D7+Fu3BpBamGimIjkkrXDtuPeYqX
 pzqv5kcSC+y2YaFShy+cFpk0lkdt74gdl0yftX3bBIAqcyx7YqDKeYydk=
X-Received: by 2002:a17:90b:52cd:b0:398:b426:ca4b with SMTP id
 98e67ed59e1d1-39dbc6ef551mr12049002a91.22.1789300959024; 
 Sun, 13 Sep 2026 05:02:39 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd3e2dabc4sm27365725ad.19.2026.09.13.05.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 05:02:37 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Osipenko <digetx@gmail.com>,
 Ulf Hansson <ulfh@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] gpu: host1x: fix runtime PM reference leak on remove
Date: Sun, 13 Sep 2026 20:02:27 +0800
Message-ID: <20260913120227.1559129-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

host1x_probe() calls pm_runtime_resume_and_get() and intentionally keeps
the runtime PM usage reference for the lifetime of the driver because
host1x is not yet ready for dynamic runtime PM.

The probe error path drops this reference with
pm_runtime_put_sync_suspend(), but the remove path only calls
pm_runtime_force_suspend().

pm_runtime_force_suspend() disables runtime PM and invokes the runtime
suspend callback when necessary, but it does not decrement the runtime
PM usage counter. As a result, the reference acquired by
pm_runtime_resume_and_get() remains held after the driver is unbound.
Repeated bind and unbind cycles can therefore leave the runtime PM
usage counter increasingly unbalanced.

Drop the usage reference with pm_runtime_put_sync_suspend() before
forcing the device into suspend during removal.

This issue was found by manual code inspection.

Fixes: 6b6776e2ab8a ("gpu: host1x: Add initial runtime PM and OPP support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/host1x/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index d2c64728f804..bb6a1647e4db 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -729,6 +729,7 @@ static void host1x_remove(struct platform_device *pdev)
 	host1x_unregister(host);
 	host1x_debug_deinit(host);
 
+	pm_runtime_put_sync_suspend(&pdev->dev);
 	pm_runtime_force_suspend(&pdev->dev);
 
 	host1x_intr_deinit(host);
-- 
2.43.0

