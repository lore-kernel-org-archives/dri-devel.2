Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7E0C88E5C
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 02:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09D3C10EADF;
	Mon, 14 Sep 2026 02:10:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k7ZR5eww";
	dkim-atps=neutral
Received: from mail-oi2-f4.google.com (mail-oi2-f4.google.com [74.125.231.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 348BE10EADD
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 02:10:10 +0000 (UTC)
Received: by mail-oi2-f4.google.com with SMTP id
 5614622812f47-4b388697b03so377288b6e.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 19:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789351809; x=1789956609; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dXWWEPWR1eTf24c4piCmTsBKFKIOYSQEhaTgS6fa4xg=;
 b=k7ZR5eww1nKIxF3Al1zINVWioCR4VMbxqHDX9xfxFkXLbTdY4CuEZhRiufIb+QWw7x
 gDLBD6IsFbTisKsjZ0qjF/Sg6Fsyu3TTzJbVY1JoeGF65Id2Ae2ypPNoVO3mRj8/KShp
 zrj1iCGc12qHqaAB6hmbbGiS5AD/JhLJilEiOgRQ/wq7A6ilAw1L8R0HlTgitNKO+XQS
 88dEyp93Jkrued8Hq+8UQ1gKZEdQ64GWTZxKofUvu3cyck+c/pxI/zIAOQpXCrSaSdLT
 RZTX1kyg311lHL8CVP9x52D18a0aR7s1JNqoO1jy2Za+bKD4rbW0MBKkL0CiPgtv8Hbq
 ck6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789351809; x=1789956609;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dXWWEPWR1eTf24c4piCmTsBKFKIOYSQEhaTgS6fa4xg=;
 b=fugUr9F+rIOA6L26BvcK3YDJiPEyq81VEm90QZut8TwsbO0Lx3HuuUyLH7lg5uSWum
 3UqfV2gtkfNFyU0tewWvNQzGbEfQnWxh3UarogPgGbMxs3uCrK0izHVRYconnwU94jLB
 Ks/VjbCtd9kxszEsCe8GurEEIhpab2BS5gWrOhmIS+3uShEW8muCp2Iubjgh4pkcCAH1
 vieES77kmZPg/XVb0tyvbuuGZxO1jWFSfZGBgcMOQEhgsBRFXkuQOx+dUi0D5q1hM3L5
 19tH7cEZ5qVDRKq0o0EZ20ZMXstsIkVcuGjdhbghPePsuWPcR25jtqA8VZOGragQG1ZV
 GDoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUyqXRiBtg+32cbMOOyavfacnVZ2ZtnD3uR4F0r92EGMuk+lbo75UNX2TJkOGkZKJaC88Uu/7D1xo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k/+KxmQNM08eksiVoImobvns5Re7A8EPJy8aljdpLTkFdqzngC
 of0LkY7jqJQ0JvuHvlE8ldVtFVX+nDYIvRwsHqvB2AbutYSEpm48kARX
X-Gm-Gg: AYBFou20ckpdwQMLAwZSZrlUUVo3uhkgS/Krm7udKJEcdHPLHWcUQYPwm+bQ8gQKAh0
 r6XRziMc5dtn/VsJRJYnVdlntec5Bj1d01D0rbz/MKkQHNuw4Tzirb4luN7Jc/ZKvs1JQ0zsEs1
 V1Tzed+glEVnjJbSl0X8f1Ii7E2FNJp9EI2QfSh8xSHXs6IzEWVW6zhXqb0eQ6AWwdUMcgwQ56w
 zayCO5ORImgwvpils6OlqmvSN8v6E48fECT0hjTMzx/AmUTbL9E3yOyyfcreP5O+ewb09MIlznu
 FsXab7Yuc9zSJl/zdLxYSWC6ubxNmDL4K3XVnjNHNVBCuenSAULv80hKm3DzF7Adk09qB4vPUEz
 RSOYNmmGrtW2LmqnCo4cRG97QbXMoaI/UVFGXQqpz21ZKiAE4Fq5CfcfwEEniPdNTsZtwRf9vvQ
 gh5UMwquQRJXf0wPFziMORtyC4QiCHbUgKIXggzEqISgOeSnFIQMNnZV3hHhjfKvzkNBY=
X-Received: by 2002:a05:6830:6a95:b0:805:6a93:d9ba with SMTP id
 46e09a7af769-80899266f27mr185481a34.15.1789351809265; 
 Sun, 13 Sep 2026 19:10:09 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::b712])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-803f5ffd82bsm9788713a34.11.2026.09.13.19.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 19:10:07 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Sun, 13 Sep 2026 21:09:52 -0500
Subject: [PATCH v3 1/4] drm/imagination: don't gate the runtime PM
 callbacks on drm_dev_enter()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-1-674b907d0652@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789351801; l=4009;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=B0FAHrSWVXGHaqZILibkK+o++O0wPS8q+cwkcADrHJk=;
 b=m0nuDmmhwVrLfYPrLL6ql7pVKv9N25E76iOoE06iKNPUoksHHY7cDxzgdfxNiEHBncqvkJPZO
 omdWCiOyDUoAX3gisn8eY+hxz2rX+Vqz3A726TzxwQSuwuOn3F1GHuS
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

pvr_power_device_suspend() and pvr_power_device_resume() take
drm_dev_enter() for their whole body and return -EIO once the device is
unplugged. The section protects nothing: the callbacks run on the
platform device, which stays bound until pvr_remove() returns. It is
being used as a "device lost" test, and pvr_dev->lost already is one.

Used that way it causes two problems. The suspend callback waits for
the watchdog worker in pvr_power_fw_disable() while holding the section,
and a worker losing the device calls drm_dev_unplug(), which waits in
synchronize_srcu() for that section: neither finishes. Runtime PM never
lets the two overlap because the worker holds a usage-count reference,
but pm_runtime_force_suspend() ignores the count, so a system-sleep
implementation on top of these callbacks deadlocks. Reproduced on
mt8173 with the worker delayed between taking its reference and losing
the device: system suspend froze until the hardware watchdog fired. And
once the device is lost the callbacks fail forever, which leaves runtime
PM in runtime_error and would abort every system suspend.

Test pvr_dev->lost instead and hold no section; a lost device is a
no-op for both callbacks. Re-test the flag after the cancel in
pvr_power_fw_disable(), since the worker just waited for may be the one
that lost the device.

Fixes: 727538a4bbff ("drm/imagination: Implement power management")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_power.c | 44 +++++++++++++--------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
index eb4b6ecdf4f4..8d82b9a79daf 100644
--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -97,6 +97,10 @@ pvr_power_fw_disable(struct pvr_device *pvr_dev, bool hard_reset, bool rpm_suspe
 	if (!hard_reset) {
 		cancel_delayed_work_sync(&pvr_dev->watchdog.work);
 
+		/* The worker just cancelled may have lost the device. */
+		if (pvr_dev->lost)
+			return -EIO;
+
 		err = pvr_power_request_idle(pvr_dev);
 		if (err)
 			return err;
@@ -372,24 +376,19 @@ pvr_power_device_suspend(struct device *dev)
 	struct platform_device *plat_dev = to_platform_device(dev);
 	struct drm_device *drm_dev = platform_get_drvdata(plat_dev);
 	struct pvr_device *pvr_dev = to_pvr_device(drm_dev);
-	int err = 0;
-	int idx;
+	int err;
 
-	if (!drm_dev_enter(drm_dev, &idx))
-		return -EIO;
+	/* A lost device is left as the failed reset left it. */
+	if (pvr_dev->lost)
+		return 0;
 
 	if (READ_ONCE(pvr_dev->fw_dev.initialised)) {
 		err = pvr_power_fw_disable(pvr_dev, false, true);
 		if (err)
-			goto err_drm_dev_exit;
+			return pvr_dev->lost ? 0 : err;
 	}
 
-	err = pvr_dev->device_data->pwr_ops->power_off(pvr_dev);
-
-err_drm_dev_exit:
-	drm_dev_exit(idx);
-
-	return err;
+	return pvr_dev->device_data->pwr_ops->power_off(pvr_dev);
 }
 
 int
@@ -398,33 +397,24 @@ pvr_power_device_resume(struct device *dev)
 	struct platform_device *plat_dev = to_platform_device(dev);
 	struct drm_device *drm_dev = platform_get_drvdata(plat_dev);
 	struct pvr_device *pvr_dev = to_pvr_device(drm_dev);
-	int idx;
 	int err;
 
-	if (!drm_dev_enter(drm_dev, &idx))
-		return -EIO;
+	if (pvr_dev->lost)
+		return 0;
 
 	err = pvr_dev->device_data->pwr_ops->power_on(pvr_dev);
 	if (err)
-		goto err_drm_dev_exit;
+		return err;
 
 	if (READ_ONCE(pvr_dev->fw_dev.initialised)) {
 		err = pvr_power_fw_enable(pvr_dev, true);
-		if (err)
-			goto err_power_off;
+		if (err) {
+			pvr_dev->device_data->pwr_ops->power_off(pvr_dev);
+			return err;
+		}
 	}
 
-	drm_dev_exit(idx);
-
 	return 0;
-
-err_power_off:
-	pvr_dev->device_data->pwr_ops->power_off(pvr_dev);
-
-err_drm_dev_exit:
-	drm_dev_exit(idx);
-
-	return err;
 }
 
 int

-- 
2.55.0

