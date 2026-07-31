Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98019C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2952D10F16A;
	Fri, 31 Jul 2026 06:50:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bJJFPiz4";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74B7B10F16A
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:49:59 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47f502ff678so73527f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 23:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785480598; x=1786085398; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kXo8J24KrU8Vbaf2n2kgu1xGVPuRWaU3gl3iPntegac=;
 b=bJJFPiz4vbUoYhoOlhIs3YHb2iemAJAyVxZxBw5eqpEQOTmdi/OsBx4VdPKU4apOe6
 JV/fIMv/H2i6tJyjqAemop+qEyFjUMmeq6nGNxWLCo5eoA8Zq6RLKB2+BcGxSDd5ij8/
 PYWJln4qPA2XSWCeI4ZIZ6maz6l1XOK3cEED1BR3VIZjukGHbw4DSQThEslSExjQrxIH
 ImfRCfiuCzbpptJT7YIRRyQMHjBu/TeOZcpKYahB183x0w2SiRuG8HtTGdZuYW1KY+yj
 77Oibf1oYdUT5B6BymzaAKQ0yB5URJ2Ph5Vs7NiOzwc28oEAHdSlCy6YIIgvkEA45ciO
 bZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785480598; x=1786085398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kXo8J24KrU8Vbaf2n2kgu1xGVPuRWaU3gl3iPntegac=;
 b=A9PVEKGu0CuZuNbVV1jPgtKxauZ85NLdf7khrzAsmIq2h4Evp4RJ04Z+6bx0nQ7Vvw
 HLbjW+haYrb8Cwfot7hFBWzEnHNi0Q7wWWr6N0rSOAa5i9R45jUs4oWysu89YgYhbVTu
 bYNdbD7xqwXa0gCseJ6WhI+fiSP9a/CLSnbBLyKXtSRvTTK7gY9b2VkDd5oXSx+URswK
 u19pUPHhX8mTlpoGQss50mMeZ02vUr3/zoO1mopLW9DS8NmyEINOLzTgSZrItlsqadKw
 YjlarnxWp31RaTVXOJNldUFtB4GRJtZTB+SNewPdHu362ky+cfOBAxXPRfIgp1tbbJYA
 xYig==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0YqaIkIcDdySb185BjvkDa33WYe6TZlucZTBFi8gMkAISgYogKGuT8BhICccNuYAW5W4LNvc0l5I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YygEGTY+b+CnBl1TWK/5JmjyosL7Gpkhu+AOnAJs5F52D6T+A2t
 Yl1IOYK9prWKczC+Cxwb2m9HbZITMVK9xR+72jtPDSuiXP5xTdg/aVc+
X-Gm-Gg: AR+sD12EDyF4CWyzJRHP9dG5V7E5cKKlW1hOFEMRc97ZD9BErLn0CSfi6tcviK8WzDw
 KALrOa3xWrs81cm+8B2Nnz5LM68xVx711LTtCL9M1wSZlYWyF2MfDcKvSlfuY1G4WiPyTb/70ei
 lBhnEWC0kqHW/JDnWDtrA9fy4au1qGWh0rFOphqPJpHPx9/0Rb35WZ4CEW7YadxrbHCvlAvitM6
 CzjTjS+VlO7FFa0CF0ujaWMIcQr2Jk+LlXOcM6ivylgpY9/g0C4O4M+5TRImi7n/+IK60rzdmoN
 HeQ/oBMO7Tpb2rz6oEiop4RvWJOIorsYt6atfmftUj8HfipJHTvbL0m3/430KkOJLqhomf1DMYB
 JnD1l0PsqiNEIDR58sKzOcBWkXnAHvvUo3P9WJL97VvoP5OAU1OVubgK/IxbK7r1OFudivvivqM
 D6Ll4/qixS76XYgWe5lfZgDUZEC+HS968xlLIPqBvqW4NJdJn8TKu72ZGsXuIG9Y45IFTVzNZEL
 1Zah4kIzmxJ8R6bed0VB3VMkNl9c5LklhEYRp58KLpCWBy/aOfRVGcQnHfV+yUp2krE5A==
X-Received: by 2002:a05:6000:2401:b0:47f:96bc:e370 with SMTP id
 ffacd0b85a97d-47fd2b653fcmr2421972f8f.4.1785480597528; 
 Thu, 30 Jul 2026 23:49:57 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8B8B0053881A2C61CA978D.dsl.pool.telekom.hu.
 [2001:4c4e:1b8b:8b00:5388:1a2c:61ca:978d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e2abbsm1212753f8f.9.2026.07.30.23.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 23:49:57 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 Guangshuo Li <lgs201920130244@gmail.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH v2 1/2] accel/rocket: release the shared device's devres on
 teardown
Date: Fri, 31 Jul 2026 08:49:32 +0200
Message-ID: <20260731064933.12548-2-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731064933.12548-1-royalnet026@gmail.com>
References: <20260731064933.12548-1-royalnet026@gmail.com>
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
v2: unchanged.
v1: https://lore.kernel.org/dri-devel/20260730080355.177422-2-royalnet026@gmail.com/

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
 
