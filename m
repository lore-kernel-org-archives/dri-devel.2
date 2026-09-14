Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07689C88E5C
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 02:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FB1610EAE5;
	Mon, 14 Sep 2026 02:10:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="onXTHaz+";
	dkim-atps=neutral
Received: from mail-oa2-f1.google.com (mail-oa2-f1.google.com [74.125.231.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F9BA10EADD
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 02:10:13 +0000 (UTC)
Received: by mail-oa2-f1.google.com with SMTP id
 586e51a60fabf-448a12ddfb4so1329900fac.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 19:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789351812; x=1789956612; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2bdJBddmQdN/xHd2xrtzk7IHIBI7EewXCRJ+IEzWoR4=;
 b=onXTHaz+Fw4Jgr5zju8A4H4g1E09fHeGi6Cq15XkkQsJAB0IZMkBC50p97u7N14vSb
 iByrK4qGsjCQ0E1JjVZDgIiQW0qWnTE14Jlnxynf2MwTQwhSuHobIB20RdJKlDLB3qVl
 Ur6vCuK723Z9VosnDvzPbU8j8/ifw0d1O0yVn0Dl8vEBZDcxwvfSnTlVHxy+T0jrUKQZ
 NH9zBDG8zoQNlV/CoeLuQKMvW8kRul+Tueo3QliEFqjMHt93lXJC7tAjdoYH0gVplZRh
 3J9yXWxFHWmma/Wu93GdG8AjglJNdLpLmmg+xJeIrptVqgD285f+ENY4HwQrVPpWeGNi
 n7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789351812; x=1789956612;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2bdJBddmQdN/xHd2xrtzk7IHIBI7EewXCRJ+IEzWoR4=;
 b=FMXeknJQtZPvhFeWsl7VV32iLK/a7FoPveEGUCuDx0UxzCcKarc6WhaV9jh6UHxRj0
 Nwx3Uv44eCZkv+rkyDarBqz5MPojCXaf9fjo1xc1CTf4tRl9HjeGPkcZi7b70BrXaHP+
 Wn99xyFxMVqqbeUlcUTT/bC7Vbqaaz1efIwsnKWs6NoFHHyQx6Yyy0Q1mttwdhRf1UYY
 ldkcb+JI1yJeDCHKjexHdYqy+zNyzPsJiKpmo+dHsXHBRAc7CT2B/gl23PykcRQBHtes
 cxDaMZ8e8lhESErhLyJRJBPB+S8HHzNV5edxCvPlgsYY0jQzjT8bYIXYdGhsk4oC1LZB
 UwVg==
X-Forwarded-Encrypted: i=1;
 AKwUvByzHjENn8k813UBaWFmv8FkK67+Zru1m/eICMI4R0tp61wUILGqDiiFY/82Dki0HKXiEYG5Li79q84=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lF8sgKyj0BaJ/ynf/UX4KPUdPJAfsm5WmN4FUY1ZX/1mB6m9z3
 Dwy5nbY/8U5MBC6QmsvsZL0iN5ZjjgHHEHZRKyUovlEub7PtauiQvVFI
X-Gm-Gg: AYBFou2FYai0RW0GuF8r+2bdyjGTlH3GNtKeT1fi4Y5pGbH/nv1xes0WuBxO8nJ+Qq2
 DqumqSA9K7GCE2EWu+Rxvb7E9SgxO1EYmvxFnvRF/GLVcwqyEsoKbSNA8YkgxQ7criIT52H8uv4
 TSaLQNNJZQqGxWiC3SbuAyO0PWCl5JQR4gPlJK01UC8fv1cQT8DWjmJl0XJ8Rg03REgGCMrogA8
 KWSrOLVPDk+Pwt+76nPRfmsv8vlnYTTgBL3MjUFoK0zqzrqW1//JBzChTlG8CEC+EtuzKbDCq7D
 T176Oieo7IAhWCuJ1OQF7Ha14cKxHV+kLqOKw02s9pv1tiEeOoHvRqMAaxAZkxlBmHVM3gQuyS5
 FkiBa+TuBD2spJIpQqopTtamyVh8bplyFDsMrKg5i4EISsY5bLDzmGvzv0Bz9wXUzUzVAI+sHBi
 Irc9utY/c1tIyRdOHKnDIW4kxNa9uXmclU+4ikFLkN2I8btmIV1TUfCVCvp1c4zPx/XW8=
X-Received: by 2002:a05:6830:82d2:b0:806:fca6:f3d with SMTP id
 46e09a7af769-80899c5ce25mr398715a34.15.1789351812288; 
 Sun, 13 Sep 2026 19:10:12 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::b712])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-803f5ffd82bsm9788713a34.11.2026.09.13.19.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 19:10:10 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Sun, 13 Sep 2026 21:09:53 -0500
Subject: [PATCH v3 2/4] drm/imagination: unplug the device before tearing
 it down in pvr_remove()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-2-674b907d0652@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789351801; l=2461;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=ZZoHyJJSUtcmG47bFptDvaygfZrn5NqsAxuHZkhft04=;
 b=ZTV8BCDF9afG8SPH8QIz/AAfq1jv9qP3OiHDYb8FI//s7x0Reg8Ej14pcfX2MNfYVOuUMH8ic
 KIpi1YWdHnOCoempRnPbcHdJciKlLmnJraoXqE3+v/SfuEL6GuFVBgB
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

pvr_remove() destroys the job and free list xarrays, powers the GPU
down and runs pvr_device_fini() before calling drm_dev_unplug(), so an
ioctl that entered its drm_dev_enter() section before the unbind can
still be walking structures that have already been freed.

Call drm_dev_unplug() first. It makes every later drm_dev_enter() fail
and waits for the sections already in flight. The runtime suspend that
follows works on an unplugged device now that the callbacks no longer
gate on drm_dev_enter().

Skip the unplug if pvr_device_lost() has already done it: drm_dev_unplug()
is not idempotent, and the second call oopses in
drm_client_sysrq_unregister() on a node the first one removed. Unbinding
a GPU that a failed reset marked lost hits that deterministically.

Holding an ioctl in its section for 4s on mt8173 while unbinding shows
the change: before, pvr_device_fini() completed 3.1s before the ioctl
left its section; after, drm_dev_unplug() blocks for those 3.1s and the
teardown follows.

Fixes: 1f88f017e649 ("drm/imagination: Get GPU resources")
Fixes: 727538a4bbff ("drm/imagination: Implement power management")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_drv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index 5c965ef0274f..fc92a82a7208 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -1469,15 +1469,23 @@ static void pvr_remove(struct platform_device *plat_dev)
 	struct drm_device *drm_dev = platform_get_drvdata(plat_dev);
 	struct pvr_device *pvr_dev = to_pvr_device(drm_dev);
 
+	/*
+	 * Unplug before freeing anything, so no ioctl is still inside
+	 * drm_dev_enter(). pvr_device_lost() may already have done it, and
+	 * drm_dev_unplug() is not idempotent.
+	 */
+	if (!pvr_dev->lost)
+		drm_dev_unplug(drm_dev);
+
 	WARN_ON(!xa_empty(&pvr_dev->job_ids));
 	WARN_ON(!xa_empty(&pvr_dev->free_list_ids));
 
+	pm_runtime_suspend(drm_dev->dev);
+
 	xa_destroy(&pvr_dev->job_ids);
 	xa_destroy(&pvr_dev->free_list_ids);
 
-	pm_runtime_suspend(drm_dev->dev);
 	pvr_device_fini(pvr_dev);
-	drm_dev_unplug(drm_dev);
 	pvr_watchdog_fini(pvr_dev);
 	pvr_queue_device_fini(pvr_dev);
 	pvr_context_device_fini(pvr_dev);

-- 
2.55.0

