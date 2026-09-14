Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF0FC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 02:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 077BA10EAE3;
	Mon, 14 Sep 2026 02:10:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d4PySIiR";
	dkim-atps=neutral
Received: from mail-oa2-f1.google.com (mail-oa2-f1.google.com [74.125.231.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16DC210EAE3
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 02:10:20 +0000 (UTC)
Received: by mail-oa2-f1.google.com with SMTP id
 586e51a60fabf-456b57c99e2so458472fac.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 19:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789351819; x=1789956619; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LwLjeaGopLfJY+d0f6yY+haKMKBWMqU5CkDwCqQQGFw=;
 b=d4PySIiRswKSMfXvrWP/Ae0orwFw03qkWPGbWPDlgnfK0BTZl7XIh+3K96MY4WjQcG
 oC1rQ1WxkaBSWPpfiK2c0rDaxDEsrT2As4D2Q6+Ya0jv8FknJFTudOcmrDS7tX21+SGP
 VcKxUtNLnqVZDONrHMQHCEmDdkSDqtPNeXOe6iYl3/n+Tu5IMLEadQN+LpJ8ag7VCP1V
 iPK+llaAcGg9ZS97da8oGHJCSO+d7iPrw0dQreNqNkDNzJ4wcQZm1sy44qcg40x/VAmy
 s3soQ6mdjAZZmRT8eYCwbzxCtXt6tzyDtFtoQ5KjLGhQfYuHRaMx+SyJGR0tBdGrrxDO
 hBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789351819; x=1789956619;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LwLjeaGopLfJY+d0f6yY+haKMKBWMqU5CkDwCqQQGFw=;
 b=DYGkSmKQyJ5xxFL80R/MUROXc6iXxkx89YBOAJQThEwG7vZCR2Prq38nonHVjTrr6Y
 Xjs6aFi+Jo9sBSHO41E4qVjVnGb3wIbXpsxyUwD0njfCx2ISGZIsGYSZgtXYxMV5Hz+N
 Vt5eMyfcIhla0ABbnxdEbRszTc9F/LDZ7zI/T+zJn0T5egGc9MxF2PpkZvt0pupym6VU
 8O0DeM0XNqyktrgGrbIvZDhR77PGQQkJ67FM5p/TyIz/vC4C3OQwKQR7h2j5StdJI0s8
 ndhHOJcmQkfYEXrPMx0VaXn1nV4+E79yLDZTVKyTAC1bN1Q00X1eahlRhffgy0g0NVVY
 Jm8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByME3B/9jUqR0/XfFFJvW2b31UwiETmYsMbKzTDz5mdysozYG+n65JlBcCIs3Az04Dyy1R41pRsTSE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lKOwG+WM87zlAxRnrr2bK/8dVi17n8c3lVb4v8wmY1H04H1afs
 PgU2dX5bFCQ4pYgR+BoQH91X2mZftmxBpy7heGimteBTYzg1Ir/dQEP2
X-Gm-Gg: AYBFou3ej/pzn9pyz1wFy0k68nOmptAwR/l5c2Wgbam+wb/GLRibfQBDWEmFkBKniiu
 ZBdThL/e4W8J3oXIunww7NB2dEX0B2/jkYLd6tAAvlE99KwHnvV/OdC96JVC70VCl7SXzroP+J8
 FdvRPhy/MTONeFc+QOG0CUFdwgiyeFM0xwN6oQoxTewiFo+HLGasI6h+rV/moDmwYmKpTxC0sN3
 lwwYoa37MkP2fVZkRgHqPGVYnUPjaRk5JrFYQaGihJjkjWfdX8kA+II1vpMO2SgV4Gspaxxm2Sc
 YCKXzN2T3j5e9akYwaEFxa4FSZiJBw5KU5CGr963EAJikQMBX4S5HrpfxxIi/tAhgiWqInXwwE/
 HfbviQL83LQIKXF3IPuaW8W1R4Z6lYTKARLLx32UsNXkNAf1a5+SBOiJ4QjA0EdhPEJdtZ0UjhS
 G9SOAwZ+fVZl0sdIdPD657vCCzWfxisOT9XAWlO6Xtlv9Y47CITL3GuHPaVQfYUbH1v8k=
X-Received: by 2002:a05:6830:6f81:b0:7dc:e78b:158 with SMTP id
 46e09a7af769-808846c49d6mr223406a34.4.1789351819296; 
 Sun, 13 Sep 2026 19:10:19 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::b712])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-803f5ffd82bsm9788713a34.11.2026.09.13.19.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 19:10:18 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Sun, 13 Sep 2026 21:09:55 -0500
Subject: [PATCH v3 4/4] drm/imagination: suspend the GPU for system sleep,
 not just runtime PM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-4-674b907d0652@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789351801; l=2092;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=bPg7ibmMjA3YZEMkxh8P9EgsDt2Ehcjuozj55lALu8k=;
 b=sogxAc49G5Crj4suR69BUpnafPaK3iEZJ21gP+/t5/X1rHiNPL/wGtJylh4kP0QilF0ofUwbs
 zFmkUpjGYCjBpyiOvH7tdGZx1THU442gXZOr+oZFMppu9B+n33ZMqen
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

pvr_pm_ops has only RUNTIME_PM_OPS, so the GPU gets no callback for
system suspend. That works only while it happens to be runtime-suspended
when the system goes down. If it is runtime-active, genpd counts it as
suspended anyway and turns the power domain off. After resume the driver
still believes its firmware is running, the first firmware operation
times out, and pvr_power_reset() is entered from inside an ioctl's
drm_dev_enter() section, where its drm_dev_unplug() waits for that very
section: the caller is left in an unkillable D state and the GPU is dead
until reboot. On mt8173 it is deterministic:

  echo on > /sys/devices/platform/soc/13000000.gpu/power/control
  echo mem > /sys/power/state          # wakes on an RTC alarm
  vulkaninfo --summary                 # hangs in D state, every time

With the default 50ms autosuspend delay the same bug is intermittent in
ordinary use, depending only on whether the GPU was idle at the instant
of suspend.

pvr_power_device_suspend() already disables the firmware and powers the
GPU off and pvr_power_device_resume() is its inverse, so drive both for
system sleep with the force helpers. The reset-path deadlock is a
separate bug; this only stops the system-sleep path from reaching it.

Fixes: 727538a4bbff ("drm/imagination: Implement power management")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index 20b27a468327..b7931f75832f 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -1527,6 +1527,7 @@ MODULE_DEVICE_TABLE(of, dt_match);
 
 static const struct dev_pm_ops pvr_pm_ops = {
 	RUNTIME_PM_OPS(pvr_power_device_suspend, pvr_power_device_resume, pvr_power_device_idle)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 static struct platform_driver pvr_driver = {

-- 
2.55.0

