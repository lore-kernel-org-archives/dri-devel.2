Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AFEC88E45
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:07:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE75F10F420;
	Thu, 10 Sep 2026 10:06:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Whep0dBd";
	dkim-atps=neutral
Received: from mail-oo2-f3.google.com (mail-oo2-f3.google.com [74.125.231.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2273E10EEE5
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 04:16:18 +0000 (UTC)
Received: by mail-oo2-f3.google.com with SMTP id
 46e09a7af769-7f4e854ef3eso2085531a34.1
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 21:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789013777; x=1789618577; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zYx/Dgo28gO2nNybMfS4z2LQPxEmJb9CFwgBS5VMQSs=;
 b=Whep0dBdylZkO8QxlnOe+NjHq6vExd5T/KYbAj5lpnlnDkm4uPRV0rJyGXPw9xEAb6
 i+OxoCyQIWOmmGP9G5TkYflOkfCxwjZp7BjktmEE3XS1IX43joA7Utw1B8vfOtR1rzZs
 iVvssh7Acq9hNh9PzkwiOVkfEfeIud0vvWbRLGMdI+u+3p7qD9nVOjZXlox48YGrWifL
 cVTA+iMFgXZ5gI6x6mlefggKbi+y1rqw6SLgEn+SaTgB3ee7jYC/9yyaSylsfgjsZCqN
 CoLcqIXJqblAzHW9pzvLi7GFHQNsZfDsSVp94gL/cvso8q5BkBwpXrJqcU3iLwjMaseX
 0zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789013777; x=1789618577;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zYx/Dgo28gO2nNybMfS4z2LQPxEmJb9CFwgBS5VMQSs=;
 b=k4ov0+yd/tLLWWPcXimOUxAfEzj+KeTEZiMTMin+HWhBik2uY8HzTN8hGgcAqGVF36
 iQ0sKomJWJyfj3nm4Eo6SlHS6/OapGOSyrcBoealwqmudbfT1DXnJfTdVEdywNMuVEkM
 5sqKFmtftA1b+yhd+qp9R7/tqGHNIX99S5p6bAWv0qAe9H2YatYhbdnGy5pGYigt1RyA
 7OTOcKPLDoCEy9kkbaCj5L7KVKQwMbP+UxI2fqVpgvedLKTz1FPfcHBYzxxmfwEE/XTL
 qPMKSWsyJz2bfPj7/16pFYR3W9kCnfB51i7hHe+xVxCKheWckydsz9BxOuf2lxtPOd6I
 xwjA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzobQ7Or7iDLpwKVVo+xZfcNzI+gQMPGALx/3/gi8kvkfiq56/Q12duOCbXHHt09EfgRAgqr1aLdc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lni8q6HFGayIE50wTLWGmTQbKY04V2FgHuYtK4ESLBLZaULm5s
 iXtEwMc4Eut34SIzXT7Xy+V+Qk6kkMyiwwKr4BKT72sHyf2rM5dhyDYz
X-Gm-Gg: AYBFou0cdkc8t/ir9BgL1BuIiGzZvIE3yp2rPxbIIWk+jn8JP+Pn0d17CQs6O24w8VN
 NUmS17RsUzLALYOiFC7aQIJJeemCQSL6f7qgNXCYqQzWsuyGRFRYkpisQXRhPHQWwvzZvT2zp6L
 BZBlzxfdHCqvvUf+O1oS9fd1XDZamHUxwvl0V0bjIXZYsn7RUOpOKN/6eApZg1a8Ni0tKsyDzJA
 OOJQ6RiW48Kim+/4sPzBdhKkbUWQ0RqnYrbbc2oQ3fGT7cDirRs4Zd8O0pMLtV90l89Nrcn8IbI
 /i9M4SFEMZqsp2e/cHpz/sLV9QS0ZaHYtC53peCpnbrAsenZ06lzwmi5EiJ2E9yLb5FJum2MLdy
 CcOJf9eTMeSazT7irP5QlPD+/rguE6IBXwpah+sFFCBQ1wqeYBrFUxUHS/WDSxIgu0cz8w3Wl8E
 +Q8ybkKatPuEI+90IXcWepYEe1iJuOhW/M7tgmMMvv2jvJ40V4ycCddc3IOOT99PDR7W47S+Y+Y
 2zhTA==
X-Received: by 2002:a05:6830:43a9:b0:7f4:e4a4:5d9c with SMTP id
 46e09a7af769-8020daab9dcmr3500318a34.6.1789013777034; 
 Wed, 09 Sep 2026 21:16:17 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::b712])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f9f7aef680sm19794372a34.26.2026.09.09.21.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 21:16:15 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Wed, 09 Sep 2026 23:16:06 -0500
Subject: [PATCH v2] drm/imagination: suspend the GPU for system sleep, not
 just runtime PM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v2-1-66a938e92b87@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6WOQQ6CMBREr2K69ptCQMSV9zAsaPmUGlqa/paIh
 Ltb8Agu32Qy81ZG6DUSu59W5nHWpCebID+fmBxaqxB0l5jlPL/ymtfghY8IFPED0VHw2BptFbj
 Zp5Ac2g6Ui0ALBTRAI6ID0Yu667uK80qwtOw89vp9vD6bH1MUL5Rhv9obg6Yw+eXQmrO995/Bn
 EEGfVHeikrIuszEQ5lWjxc5GdZs2/YFcA0LbQgBAAA=
X-Change-ID: 20260909-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-bfb9dfd7007b
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Chen-Yu Tsai <wenst@chromium.org>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, YoungJoon Lee <getfeus@gmail.com>, 
 imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789013774; l=7662;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=6xCUDTIGKPrgFADRT+Qp+uNq6ERnZQBXxN9oMvEXlj4=;
 b=JJuqFueiVdAc31T3lc4BEk+YOegPXwH47zzb8EMcm2e8Ensy8dcuI6X5ZtBIh/8X+gUYmdu17
 ZYmdH0Q1jt9BYpRU6pv57oy3XbQWyJ7QUqbAOOf+C2cx4ufRpx0o6Ja
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=
X-Mailman-Approved-At: Thu, 10 Sep 2026 10:06:32 +0000
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

pvr_pm_ops has only RUNTIME_PM_OPS, so the GPU gets no callback for system
suspend at all. That is fine only while the GPU happens to be
runtime-suspended when the system suspends -- then its own runtime PM has
already disabled the firmware and powered the domain off. If it is
runtime-ACTIVE, genpd powers the domain down during the system suspend
without the driver ever being told, so on resume the driver still believes
its firmware is running. The first firmware operation then never completes:

  pvr_mmu_flush_exec -> timeout -> pvr_power_reset -> drm_dev_unplug

and pvr_power_reset() deadlocks, because drm_dev_unplug() waits in
synchronize_srcu() for every drm_dev_enter() section to exit while being
called from inside a DRM ioctl that holds one. The result is an unkillable
D-state process and a GPU that stays dead until reboot.

On mt8173 (amazon-suez) this is deterministic:

  echo on > /sys/devices/platform/soc/13000000.gpu/power/control
  echo mem > /sys/power/state          # wakes on an RTC alarm
  vulkaninfo --summary                 # hangs in D state, every time

and with an autosuspend delay of 50 ms it is also what makes the failure
look intermittent in normal use -- it depends purely on whether the GPU was
idle at the instant of suspend.

pvr_power_device_suspend() already disables the firmware and calls the
platform power_off, and pvr_power_device_resume() is its exact inverse, so
force them for system sleep.

The force helpers cannot be used directly, though. Once the GPU has been
lost -- pvr_device_lost() sets pvr_dev->lost and calls drm_dev_unplug() --
drm_dev_enter() fails, so pvr_power_device_suspend() returns -EIO, and
pm_runtime_force_suspend() propagates that to the PM core, which aborts the
system suspend. Nothing ever clears the condition: a lost device cannot
runtime-suspend either, for the same reason, so it stays runtime-active and
every later attempt fails the same way. Wiring the force helpers in raw
would therefore trade a GPU that dies on suspend for a machine that cannot
suspend at all. Wrap them instead and skip the transition for a device
that is already gone, which is also the truthful answer: there is nothing
left to power down.

The wrappers test the same condition the -EIO comes from rather than
pvr_dev->lost, so they also cover an unplug from any other path.

The vendor driver arrives at the same rule about system sleep by a
different route: it holds a wakelock while the MFG domain is powered
("prevent suspend when gpu active") so the system can never suspend with
the GPU on.

Two related problems are left alone here. The reset-path deadlock above
(drm_dev_unplug() waiting on an SRCU section held by the ioctl that called
pvr_power_reset()) is a separate bug; this change only stops the
system-sleep path from reaching it. And pvr_power_fw_disable() cancels the
watchdog work before it can fail, and does not restart it on the error
path, so a suspend that fails part-way leaves the watchdog dead until the
next successful resume -- pre-existing, but system sleep is a new way to
reach it.

Fixes: 727538a4bbff ("drm/imagination: Implement power management")
Assisted-by: LLM
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
Changes in v2:
- Don't wire pm_runtime_force_suspend/resume in directly. Once the GPU
  has been lost, drm_dev_enter() fails, pvr_power_device_suspend() returns
  -EIO, and the force helper hands that to the PM core, which aborts the
  system suspend -- permanently, since a lost device never becomes
  suspendable again. v1 would have traded a GPU that dies on suspend for a
  machine that cannot suspend at all. v2 wraps the helpers and skips the
  transition when the device is already unplugged. Caught by the Sashiko
  AI review bot.
- Commit message: say why the wrappers exist, and note that
  pvr_power_fw_disable() leaves the watchdog cancelled on its error path
  -- pre-existing, but system sleep is a new way to reach it.
- Cc'd Chen-Yu Tsai, Icenowy Zheng and YoungJoon Lee, who are testing this
  same GPU in the MT8173 powervr thread [1] and are the people best placed
  to say whether this reproduces on a Chromebook. That thread doesn't
  mention suspend at all.
- Dropped sarah.walker@imgtec.com and donald.robson@imgtec.com, both of
  which bounced on v1. get_maintainer.pl offers them via blamed_fixes on
  the Fixes: commit, but neither has committed since 2025-04 and 2023-12
  respectively and neither has a newer address in kernel mail.
[1] https://lore.kernel.org/all/20260728091804.382753-1-wenst@chromium.org/

- Link to v1: https://patch.msgid.link/20260909-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v1-1-f45847bc951b@gmail.com
---
 drivers/gpu/drm/imagination/pvr_drv.c   |  1 +
 drivers/gpu/drm/imagination/pvr_power.c | 31 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/imagination/pvr_power.h |  3 +++
 3 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index 5c965ef0274f..09eb162353aa 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -1517,6 +1517,7 @@ MODULE_DEVICE_TABLE(of, dt_match);
 
 static const struct dev_pm_ops pvr_pm_ops = {
 	RUNTIME_PM_OPS(pvr_power_device_suspend, pvr_power_device_resume, pvr_power_device_idle)
+	SYSTEM_SLEEP_PM_OPS(pvr_power_system_suspend, pvr_power_system_resume)
 };
 
 static struct platform_driver pvr_driver = {
diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
index eb4b6ecdf4f4..55a47bc4e925 100644
--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -427,6 +427,37 @@ pvr_power_device_resume(struct device *dev)
 	return err;
 }
 
+int
+pvr_power_system_suspend(struct device *dev)
+{
+	struct platform_device *plat_dev = to_platform_device(dev);
+	struct drm_device *drm_dev = platform_get_drvdata(plat_dev);
+
+	/*
+	 * A device that has been lost cannot be talked to, and there is
+	 * nothing left to power down. pvr_power_device_suspend() answers
+	 * -EIO for it, which the PM core turns into a failed system suspend
+	 * for the whole machine -- and because nothing clears the condition,
+	 * it would fail that way on every subsequent attempt.
+	 */
+	if (drm_dev_is_unplugged(drm_dev))
+		return 0;
+
+	return pm_runtime_force_suspend(dev);
+}
+
+int
+pvr_power_system_resume(struct device *dev)
+{
+	struct platform_device *plat_dev = to_platform_device(dev);
+	struct drm_device *drm_dev = platform_get_drvdata(plat_dev);
+
+	if (drm_dev_is_unplugged(drm_dev))
+		return 0;
+
+	return pm_runtime_force_resume(dev);
+}
+
 int
 pvr_power_device_idle(struct device *dev)
 {
diff --git a/drivers/gpu/drm/imagination/pvr_power.h b/drivers/gpu/drm/imagination/pvr_power.h
index c34252bda078..39d18ee9a3bd 100644
--- a/drivers/gpu/drm/imagination/pvr_power.h
+++ b/drivers/gpu/drm/imagination/pvr_power.h
@@ -20,6 +20,9 @@ int pvr_power_device_suspend(struct device *dev);
 int pvr_power_device_resume(struct device *dev);
 int pvr_power_device_idle(struct device *dev);
 
+int pvr_power_system_suspend(struct device *dev);
+int pvr_power_system_resume(struct device *dev);
+
 int pvr_power_reset(struct pvr_device *pvr_dev, bool hard_reset);
 
 static __always_inline int

---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260909-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-bfb9dfd7007b

Best regards,
--  
Ryan Brue <ryanbrue.dev@gmail.com>

