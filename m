Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3256FC531D0
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8632510EE15;
	Thu, 30 Jul 2026 08:04:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LkjkogxL";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D00B410EE0E
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 08:04:13 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47f706438c3so129596f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785398652; x=1786003452; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VrwtyRX2qDPBxX3r7OeFon4kOmzwfovTWycGAbMSmog=;
 b=LkjkogxL4XPxeURW7vIH017U8tFR/udPm7Vy5mLtZaEkU51gyrezH9+cttad9zP76j
 Ld76TYUlb8zTuNtvZFBeGlECiI3fZUaWrbSRXFxLtwi14SoNXgLD5f32bMQqOkM7srMm
 8kQUZ0Tn/+Dpbr0AgNDivF1RUrvvQMKKTgKQ37aozbT0wVEY6668Is3rssmE6rNnVSEF
 d4evmImlspbby+GSlvD6oJ3rGW1qOPqFhKCJEr/5mNeTLlT/Uv0hh8+JvKPgCgc6Dvet
 hYr0V76H2yMiCCU5yR7LDJEV9aXtVnTNxq6PRNH2rmPihs8DE2n0eF8SXxCbunsA0cmp
 8L6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785398652; x=1786003452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VrwtyRX2qDPBxX3r7OeFon4kOmzwfovTWycGAbMSmog=;
 b=JxZlX/QjS/R8tc9e9UlYOKmzTFbVuC7AbHI0N3i24MEyeIgFZGxvfs8+bicGmtcQ2s
 e5K9qVg8dpLVAwtHikdtsRsYAcfXe7K2tC8jXLIejKXeBX1W51jES10sp+m0xQKLdCq3
 tZJwZcaOr6RTGrBbY993soh2B4AJ/khWW1phsQwXTKzCLEIOymqhtRUVAYVwz3BRSuZx
 iey3Ee6YU//1DDqc5/VZZlKPM2Oa9R0T84zeceDncn0BAlR9pHXyb/EalEnK+liiZu+E
 VnCJyx9doBeUg5hD16ZeJYfAf49awIzK6Y2b/N2Zm888BX/GD2uuLuAz3+bdl0EUlrI/
 zaUA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqfXL1cf6SPt1mVnblZlL2z1Co6o1fcDJvX0/wtsieNwo7hxtJjaPrrd22IpsHUaipbdzXo9eJZN+M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz0jN3SVQjgk5dSnw6KcvjupL3nEusn0yIeN2N+4UpeAysraWh1
 Gp8A4vMRewp9U90k28pTPQ318HbMUXOiBg3GYVjtHzNgGXUX/g1dfeyS
X-Gm-Gg: AR+sD11AVF73Lq+rS9m49hw4uwqedytsRTVINHpeBE3cOYVZIzc8nGhaqYURzjGwR0K
 MJLnWQjOL/TeEC3dUOx1PmbDLh8ydl4OkK7XAyWvsJnnyjv7T9QJejBL3dkk/0G75bJOW93CQVw
 NoZ21ch3MLv2FRSWeS53JEG/IxQ1+FUk04AZKobpgEJwS0Q+x7/FNPa3d3ZEqfrenLX/CubgUu6
 TjBPG+p7hzEEjM8A2SdhetZN9Nzcmcf7ldyVAW9H2S5D4Hu4xli8bbhcAlY9YC7/XwT5dmMR5Xv
 yYi5ST12avHDWY6nKOndy+ZZFMilcdyTUwREAIC5psxlhynbH9lBaZi25a/YZ4UC4afIYhROW6o
 Lxq0abxiWOolg6ptM2rPjsuKYMhrlfQTgHbGC8wLEE9jnWKKfhXsQajm+l9XQVwJfQGfUL7aa7N
 032aoenL3OQ/J24sUP7m0IoxSODCEzwY1XXVPK22GNUn6YnygpJY14yDHi12v4qcvaG4TygtLLW
 xcDN2zFjSSKCDiwp+yDMvP/OdwibjmhBpIbbe1qyoXxpY8pu05ePrirQy1ynP4a/JyJ2hQGduAI
 c+4O
X-Received: by 2002:a5d:5e82:0:b0:47f:6fbd:f23e with SMTP id
 ffacd0b85a97d-47fc8329a61mr1706891f8f.4.1785398651803; 
 Thu, 30 Jul 2026 01:04:11 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8A5A00BF2D55A7591B4173.dsl.pool.telekom.hu.
 [2001:4c4e:1b8a:5a00:bf2d:55a7:591b:4173])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc88e4055sm3347685f8f.13.2026.07.30.01.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 01:04:10 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Guangshuo Li <lgs201920130244@gmail.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH 1/2] accel/rocket: release the shared device's devres on
 teardown
Date: Thu, 30 Jul 2026 10:03:53 +0200
Message-ID: <20260730080355.177422-2-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730080355.177422-1-royalnet026@gmail.com>
References: <20260730080355.177422-1-royalnet026@gmail.com>
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

rocket_device_init() attaches its allocations to the shared "rknn"
platform device via devres: devm_drm_dev_alloc(), devm_kcalloc() for
the cores array and devm_mutex_init(). That device is registered at
module init, never binds to a driver, and is only unregistered at
module exit - so its devres list is not released for as long as the
module is loaded.

rocket_device_fini() only calls drm_dev_unregister(): it does not run
the drm_dev_put() devres action or free any of the other entries.
Every fini/re-init cycle therefore leaks the previous rocket_device
(with its embedded drm_device and all drmm state, including the accel
minor number), the cores array and the mutex devres node. The cycle is
easy to trigger: unbind the last bound core and bind one again, or
fail the first core's probe (-EPROBE_DEFER retries included).

Observable symptom, RK3588 (Orange Pi 5 Plus): each unbind/rebind
cycle of all three cores moves the accel node forward -
/dev/accel/accel0 comes back as accel1, then accel2 - because every
leaked drm_device keeps its minor pinned.

Wrap the initialization in a devres group and release exactly that
group wherever the device is torn down: on the rocket_device_init()
error path, when the first core's rocket_core_init() fails, and when
the last core is removed. Each fini now frees what the matching init
allocated, and the accel minor is reusable again.

Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
This applies on top of Guangshuo Li's pending fix, which it depends on:
"accel/rocket: clear rdev on device init failure"
https://lore.kernel.org/dri-devel/20260708062845.716487-1-lgs201920130244@gmail.com/

Verified on RK3588 (Orange Pi 5 Plus): with the patch, repeated
unbind/rebind cycles keep /dev/accel/accel0 stable (previously the
minor incremented on every cycle); normal three-core probe, runtime PM
and a MobileNetV1 inference run via the Teflon TFLite delegate are
unaffected.

 drivers/accel/rocket/rocket_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 67e7f54..d29c5ee 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -24,6 +24,7 @@
  */
 static struct platform_device *drm_dev;
 static struct rocket_device *rdev;
+static void *rdev_group;
 
 static void
 rocket_iommu_domain_destroy(struct kref *kref)
@@ -163,14 +164,19 @@ static int rocket_probe(struct platform_device *pdev)
 
 	if (rdev == NULL) {
 		/* First core probing, initialize DRM device. */
+		rdev_group = devres_open_group(&drm_dev->dev, NULL, GFP_KERNEL);
+		if (!rdev_group)
+			return -ENOMEM;
 		rdev = rocket_device_init(drm_dev, &rocket_drm_driver);
 		if (IS_ERR(rdev)) {
 			int err = PTR_ERR(rdev);
 
 			dev_err(&pdev->dev, "failed to initialize rocket device\n");
 			rdev = NULL;
+			devres_release_group(&drm_dev->dev, rdev_group);
 			return err;
 		}
+		devres_close_group(&drm_dev->dev, rdev_group);
 	}
 
 	unsigned int core = rdev->num_cores;
@@ -190,6 +196,7 @@ static int rocket_probe(struct platform_device *pdev)
 		if (rdev->num_cores == 0) {
 			rocket_device_fini(rdev);
 			rdev = NULL;
+			devres_release_group(&drm_dev->dev, rdev_group);
 		}
 	}
 
@@ -213,6 +220,7 @@ static void rocket_remove(struct platform_device *pdev)
 		/* Last core removed, deinitialize DRM device. */
 		rocket_device_fini(rdev);
 		rdev = NULL;
+		devres_release_group(&drm_dev->dev, rdev_group);
 	}
 }
 
