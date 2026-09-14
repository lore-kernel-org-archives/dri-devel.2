Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5CEC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 02:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 753EF10EAE2;
	Mon, 14 Sep 2026 02:10:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oVk50KMZ";
	dkim-atps=neutral
Received: from mail-oa2-f1.google.com (mail-oa2-f1.google.com [74.125.231.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DDEB10EA71
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 02:10:17 +0000 (UTC)
Received: by mail-oa2-f1.google.com with SMTP id
 586e51a60fabf-448a12ddfb4so1329943fac.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 19:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789351816; x=1789956616; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5ens4tvOvZUZ2shdZ+y3dfNiHm8kjjJbg0o+rL2d/6o=;
 b=oVk50KMZgrOHdJb1mndYW55b8DTGdFoRJIOfKQHtya9bg2mogPFpY9E0FSHyXv9PbW
 GgquruHxeMU7BlvZMOi4VjwtV3tkeJrbc8hZDJVVk7uS5o7NEuXFn1dKDNcLc456w9fE
 /RlTg4q6z2thY+9EAQlYveO32K/dSBAssD+VJ/Vhzhq4iVq1s1Ox2jWN9yUmEsS54Cze
 ywzX4qrKTRrN2I8jyoEZzGRTjMTwKdlP1HF07g5BrsZV0wc91c10oyqo3U8qgBV0e3ut
 b3abJM+tSJciqrVOc0W5yVDtckv4zEjf3VurHonXTal/u4yaHWtHD9bG+WeZ8FxeKVgL
 by6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789351816; x=1789956616;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5ens4tvOvZUZ2shdZ+y3dfNiHm8kjjJbg0o+rL2d/6o=;
 b=M0NsoiAWHDcLYBTqB/LaZI9SniiKSypvnMIGYUJyJPbNTJNyomW/Bxfz+YvCVl/Zi5
 PBqxGTd59quJCUx8boyoTa+SEKIC0ikuT3EKT8O2Aovpeqzjol+hSvjnz4vRT0YD/29F
 24Iy88uexSxRA5xsi8reBdhV9K5FDPiNkH9jsL9XevxqeKevNfDLSXUJF4S1o/xtMtl+
 sSy//+ZDsAnuChtfspoTWJAY+BnY5jwMcOl71S/lKtTe0W9+48UJE/oGYkz5a2bK5Q1z
 yavaVpjFeQ+3AJtKPYEOxGsapTneXYmE0DAxVRjSsfoDZSiIDmIJUNjcrGlCK8QBhada
 nQOw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwi6pVqH/dw2ojDfchR54OLJ5vgVvWU3Oxr711rrp5eZlfcXBIUWHWsZeHdpyya2zR8KdwuK7On9bY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nX1hu2PgSWmtsaYzWODrSITamkdnFdpet6dbvU0syaEzat4GG2
 AfhBWJZ2gBRdXuAxzOU9zyzD0L+Cm6rkVh5raL/qiE2cirz4WOW+UGwj
X-Gm-Gg: AYBFou0txq5/3uM6qywsHO6h60aSGSkkQdyWllbzOzv+d+Mv2I7d9FMgtPqMAvZ3i6B
 gH2sYYxQaF3tH4eFjchnj7doO8qROh5JhGYEpXSf/NRetBLmHDRjMya9RfozQhR70dkgXcq1ADD
 ZOI5uq5PkWLqXgcl7KNjyROt0EOCVK3ZUOQ1KiMJUAVP2CfhLanNrZdpvXuzyLxco42ZuLBxgVh
 9OhUlXSHytUs4ZQlQ76303iEkdx8BVPWEPJRgRhF61gqCY53/7OIWqzj/w7CL2s7DczDfFmSaoo
 QFSiWVqgB9/eYu1Cl4mwkd2yRqNmCxd4Z4OrZxeuJBPxNEmPQaZoE29Z7APfyfA9f2c5Udyq4f3
 nPXvmkf3JOG/OhWzRa5UveWovTfrAYiHC7lgUnsCGUMMJPIMWiLp6C/Z+ilgm77edGd+Py2nZci
 K89hvHOcuJCmIwYeVqctQbIDk+usdM8ePc1Jdun37UTJWXnKCvqxlVm4HVicBkLbKCxrI=
X-Received: by 2002:a05:6830:2a86:b0:7f8:4ebe:2854 with SMTP id
 46e09a7af769-8089759c582mr369256a34.4.1789351816652; 
 Sun, 13 Sep 2026 19:10:16 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::b712])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-803f5ffd82bsm9788713a34.11.2026.09.13.19.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 19:10:14 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Sun, 13 Sep 2026 21:09:54 -0500
Subject: [PATCH v3 3/4] drm/imagination: stop the watchdog before tearing
 the device down
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-3-674b907d0652@gmail.com>
References: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-0-674b907d0652@gmail.com>
In-Reply-To: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-0-674b907d0652@gmail.com>
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789351801; l=2128;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=9Yo6q3xRbzehVoYANIYWHpMZD6dLjaFxkE9BuO/bq+o=;
 b=rNNUnHpmGFQsgkJLLWq00R5uggWAjk/JjRny6l6FmNcxSrvItWpKCt0tt45OW+Nttk7zpXs9V
 CL+mYayaXpQCG8DD49sK5/ANbS97EdXH8RzYP1gZE0ybzlmJMLQpnO0
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=
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

pvr_remove() runs pvr_watchdog_fini() after pvr_device_fini(), so the
watchdog work can still be queued while pvr_fw_fini() unmaps the
fwif_osdata it reads. The pm_runtime_suspend() earlier in remove
normally cancels the work on its way through pvr_power_fw_disable(), but
it returns -EAGAIN without calling the callback when the usage count is
raised, and -EINVAL when the device is in runtime_error, and then
nothing has cancelled the watchdog since the last pvr_power_fw_enable():

  echo on > /sys/devices/platform/soc/13000000.gpu/power/control
  echo 13000000.gpu > /sys/bus/platform/drivers/powervr/unbind

The worker fires within 500ms of the free and reads freed memory.

Cancel it first, before the unplug: the worker is one of the callers of
pvr_device_lost(), so waiting for it here also means the pvr_dev->lost
test that guards the unplug cannot race it.

Fixes: 727538a4bbff ("drm/imagination: Implement power management")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index fc92a82a7208..20b27a468327 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -1469,6 +1469,9 @@ static void pvr_remove(struct platform_device *plat_dev)
 	struct drm_device *drm_dev = platform_get_drvdata(plat_dev);
 	struct pvr_device *pvr_dev = to_pvr_device(drm_dev);
 
+	/* Stop the watchdog before anything it reads is freed. */
+	pvr_watchdog_fini(pvr_dev);
+
 	/*
 	 * Unplug before freeing anything, so no ioctl is still inside
 	 * drm_dev_enter(). pvr_device_lost() may already have done it, and
@@ -1486,7 +1489,6 @@ static void pvr_remove(struct platform_device *plat_dev)
 	xa_destroy(&pvr_dev->free_list_ids);
 
 	pvr_device_fini(pvr_dev);
-	pvr_watchdog_fini(pvr_dev);
 	pvr_queue_device_fini(pvr_dev);
 	pvr_context_device_fini(pvr_dev);
 	pvr_power_domains_fini(pvr_dev);

-- 
2.55.0

