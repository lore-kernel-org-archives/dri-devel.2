Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E6EC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6738710F3E9;
	Thu, 10 Sep 2026 10:06:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ThkArMC7";
	dkim-atps=neutral
Received: from mail-yx2-f1.google.com (mail-yx2-f1.google.com [74.125.224.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D88810E1F0
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 19:14:21 +0000 (UTC)
Received: by mail-yx2-f1.google.com with SMTP id
 00721157ae682-857cb570f53so24797487b3.1
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 12:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788981260; x=1789586060; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Yzknjs/dgM6cXy8bMP6XtAn4j86y5MQftpHsbTjU4JM=;
 b=ThkArMC7xLyQ5qMrgaG61hn7pkne8O+U6JSN2c4GOUcPhDjKBcVf40umc86s1xcDz/
 FQD1Vb5tHBvGF9gcf4MI+Bg2zicwMGbWHEz+GC+zDuACm/SK+UMRboSSHY7pTdnOIH15
 rrp8RpgXW+IutJ9gwcvFUIbFPP9Q3+tsQczSU27BKmT3nBLtp3pkY9wc57tzW5JxgjAM
 wRj78PnVCMZSSG8YuQ1WFLKd+BNZwzI7f+mGg1J+tXMpNkVDMdz14bTefxqoTClePVmm
 UjJ8ZE3EpPjzQbOcDkDIx7RGhh8WljvV/BSw7EGNreumUxMowT3GmxQPnCP80z9dwUKa
 k0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788981260; x=1789586060;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Yzknjs/dgM6cXy8bMP6XtAn4j86y5MQftpHsbTjU4JM=;
 b=DDqDeUBVCyUjW9C1Mkh4m1JCTUnmU/kML+oirL3L2xMObJ5RePAgYeNGodrxwF8hVD
 Wc773YiORLOs/8/9Z+UkYFAQN9dlClWPPnvepOXqcZ7Dkr1J8j9MDyhoIc3q/uj5CtH2
 teqFcYPdEFV1Hs1RZ1HIy2gjfe3aHeyVnzTkHBQ2itQ5sMYULqy/khUQKr+SutBNTKh2
 dpYBgPzDKNDUsyVYAyZ1F+bEjJPL+3Yg2uJp0Q1pLAOw5l+mRJ9FwcJfeY+beiau0rPv
 xWBQLum6MvJ2hd36EGxEnoEVo8Po3Rn2zkgAUwaq3Siw7cj+jG/Lr5q4Vujnix9ttn3z
 B/wA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz82XmZx1bgWPejcJyFpoWp9YmhrXxS8AsBQ8tpwY4Vee0renAXNz0IVxcbUW9xPnKJOTWRmXTicyc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kiZB84lJuAOUs8AeRhI6eNOXMr8SRZsqrTk2vT8rEqpqKCzc91
 GfnuHPL6MxwGzp8bBhOQ8st/jf7umhLTWx/WjTZDapkJvKALKGpQKNXv
X-Gm-Gg: AYBFou2MXRoG38m6s7MZV0qCjQK7PKlKTXBLAcMzlnJiI2zV29oLIK8tpQWYNdf0OR3
 xTfLrL6MNuvULUzG+ojdLGK0JIqiamU7zPul5AvKGWj1Nn6KwzD7g0mpLHJUHVvrxzUX8O3E6A1
 pwUakPnjSF7MInDX6/PnDT8aULxuLU//nNTX7iHRb7/qv0ernpXB13Mr291JqEPSyE4vWdjO3J7
 OeD9Qi0YQvWLDV5TLaAnNO1vB9NkfGxEiUtiZ7ld9TXRA4bBTBovuhiquOgCH6R0XjMm/P6u+fM
 lWiiYNCmTkoruvBS4iCDjYnw92VS+HC8SxwsISanNy5bw9quog7ZsVehcNXDv56HQ3/VqOj4SXC
 yu5ufk9MJSThDENiXr3t0hE6zoYrWEDIH9WSK2aXDfZkskSED3K49EsH64qGqQU0QuLXMXzfFC5
 5rtsX7LhMHLgH+aocEi7TcSN1tVmCypmStkY/kq7DkhZB8VVuibOmdNuKqnLO7lIYQ+OreSsVSM
 K18wJajvoNeIkt+8gVVKojR05eCmjlejuI0XlPC4ydQdZnvFtbTEfWuhjGJaoR48GdI9RIgHB0k
X-Received: by 2002:a05:690c:e0d5:10b0:857:f33:6f1d with SMTP id
 00721157ae682-87122396144mr109553227b3.6.1788981259894; 
 Wed, 09 Sep 2026 12:14:19 -0700 (PDT)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net.
 [64.207.253.118]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91040664be1sm150361316d6.18.2026.09.09.12.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 12:14:19 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Wed, 09 Sep 2026 14:14:16 -0500
Subject: [PATCH] drm/imagination: suspend the GPU for system sleep, not
 just runtime PM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v1-1-f45847bc951b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNwQ6CMBCE4Vche3aTykGCr2I8UDrUGqnNbktQw
 rtb9fjNYf6NFBKgdG42EixBwzNWHA8NjbchenBw1dSa9mR607NYKWAteHNJmgXDHKLntEgdNSE
 69qmwvjRjZn0Aie1keze5zpjOUn1Ogimsv+rl+rcWe8eYvyna9w8NeRyNlwAAAA==
X-Change-ID: 20260909-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-bfb9dfd7007b
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sarah Walker <sarah.walker@imgtec.com>, 
 Donald Robson <donald.robson@imgtec.com>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788981258; l=2911;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=EDwUvwYj52uRaI2dCh0tF4qDlZkgWRI/RU1+vIfQfts=;
 b=e3Tfw3yuJqdLfhsvfVAyjk7rHzRK6ioMgcmTgeGmoRNT6onFbW6CVKFXi6ZGv4BUSX/EeoMII
 yVSbVc+K6VSA70/wRm0GEMx1VTHB/o73vstNk/nEBUf+3usP2Lttss8
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
force them for system sleep. The vendor driver arrives at the same rule by
a different route: it holds a wakelock while the MFG domain is powered
("prevent suspend when gpu active") so the system can never suspend with
the GPU on.

The reset-path deadlock itself (drm_dev_unplug() waiting on an SRCU section
held by the ioctl that called pvr_power_reset()) is a separate problem and
is not addressed here; this change only stops the system-sleep path from
triggering it.

Fixes: 727538a4bbff ("drm/imagination: Implement power management")
Assisted-by: LLM
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index 5c965ef0274f..23d353141589 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -1517,6 +1517,7 @@ MODULE_DEVICE_TABLE(of, dt_match);
 
 static const struct dev_pm_ops pvr_pm_ops = {
 	RUNTIME_PM_OPS(pvr_power_device_suspend, pvr_power_device_resume, pvr_power_device_idle)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 static struct platform_driver pvr_driver = {

---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260909-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-bfb9dfd7007b

Best regards,
--  
Ryan Brue <ryanbrue.dev@gmail.com>

