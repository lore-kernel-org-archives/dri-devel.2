Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D99FC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2732B10F475;
	Fri, 28 Aug 2026 20:58:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Eb/SWB4g";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7B2D10F473
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 20:58:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787950694; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eF0Me/nRVkS8ZC5JmfSGZeJw41uOC3RsFKeY7Bmj8L+L90mads01wBFLyKtr6P21AT7C5PnyNE216LyHh3kr2emhQGAwdTqEPYPzedZEy4Sk/Vu2zHhhVT52ML2VJF1XiLpEPtNbVhTogu6x1T1+8tt+/LKcW1ywy7P4En30jXE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787950694;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=zb2+6a9Sn7z271oIKdJKzTUdqNTgeCI/6gpd+hpR7xU=; 
 b=OOk5nFIzu/1aCrkxndoIju5Vjqqsfk62HSUH49dkUDrIZJlc8K7scJUgfCwX+zDW4lpChky5aN+OYfSt6/AlKAY6eT1ObLwksZHe2fFfJE+t9utOoylgHaHotyJClFCHlBRzmvAo4SCTNkUyM642qyKiGjYhCPbSgDEnUBW5z0k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787950694; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=zb2+6a9Sn7z271oIKdJKzTUdqNTgeCI/6gpd+hpR7xU=;
 b=Eb/SWB4gmqiUHJs7m/rE5pdx1SjkF/4cReXbK9/ISNdp+20Rj6KsScANDYdfYZdZ
 ImPToXWJBY/MOIm07eA45nEFUQyHEEvshGEAEjMuc97SdYfLfgYIVEkyXhQx+3wXlHB
 LTKTJfPwyoRcWOFr7aU1KMVxuqABo50HIAdqQP6M=
Received: by mx.zohomail.com with SMTPS id 1787950693495776.7987431600491;
 Fri, 28 Aug 2026 13:58:13 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 28 Aug 2026 21:56:49 +0100
Subject: [PATCH v7 09/17] drm/panfrost: Fix PM refcnt and autosuspend
 issues at device probe/remove
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-claude-fixes-v7-9-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
In-Reply-To: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2614;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=qAGMipCyNf/cHapTcJ0arjRPOZaFd8pguKbd0yyzcgs=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqkfYtjYWFN7TAchDQfrBmIEiOGoYB0T/TwSt1P
 6JxjE9uPIeJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCapH2LQAKCRAOJn5M7lND
 PYvoC/0a+npClx19/LVzdodPuqQ4Ju8uzEbIoJ1b2MGSl+9NvPU73V4MerJObaRTSjLz0BIEbHu
 DQRldAhT5tKpuquPXRYYYSW38KgPs/vxJ7sWiZokQnqMfV5dMFLCwxcMO9Oyg8kBxHGrttIvoGe
 ninQLlk/HZNLrTvaVr1tu2DAl9bBo8wr8ZiUYMwYe4hGmcyxUVpK8faV55arClpwvRpDV1HlLI6
 +bj5AkjY+pdukrA9NU5cc/WGUCiIM0m1OzvIs+szPNcYbYXnrvaJFGqNiYeiXZd1qM1QOQqt9XX
 AOeEKfqvQXvJpNgCcv+3iIWf88uVC321FUgeqwGMNsbOQ4ssAXwX3POvU8YkKgew8ecSQ2unuKd
 R0dpOKKCkNOyqsg4PK6ah0yMf6HA/Niu8xkakh0G8+iuwHA7WoM1SPhrQSADkJR2djXjCL27Mp4
 1c/hOaaC5I8BXGdhz0iEIgXamQUDclVSEsB+CUtXbSSlfwZCZ+NBYVQzNN4A5x+8XdGGM=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

During device probe(), failure to do a PM get() will leave the usage_count
set to 0, which is the value assigned at device creation time. That means
when the autosuspend delay expires, runtime suspend callback won't be
invoked, so the device will remain powered on forever.

On top of that, failure to call PM put() during device unplug means
Panfrost device's PM usage_count increases monotonically for every new
module reload.

The combined outcome of both of the above was that devfreq OPP transition
notifications would be printed all the time, even when no jobs are being
submitted. This quickly fills the kernel ring buffer with junk.

To fix the above:
- Manually adjust the PM refcnt at device probe and removal time.
- Ensure pm_runtime_dont_use_autosuspend is called in the wind-down path.
- Call pm_runtime_put_autosuspend() when device is ready to accept jobs

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Fixes: 635430797d3f ("drm/panfrost: Rework runtime PM initialization")
Fixes: 876b15d2c88d ("drm/panfrost: Fix module unload")
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 99f7da2180f9..70c8109ea698 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -322,6 +322,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 
 	pm_runtime_set_active(pfdev->base.dev);
 	pm_runtime_mark_last_busy(pfdev->base.dev);
+	pm_runtime_get_noresume(pfdev->base.dev);
 	pm_runtime_enable(pfdev->base.dev);
 	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames */
 	pm_runtime_use_autosuspend(pfdev->base.dev);
@@ -334,9 +335,13 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 	if (err < 0)
 		goto out_devreg;
 
+	pm_runtime_put_autosuspend(pfdev->base.dev);
+
 	return 0;
 
 out_devreg:
+	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
+	pm_runtime_put_noidle(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
 	panfrost_device_disable_hw(pfdev);
 	panfrost_gem_fini(pfdev);
@@ -363,7 +368,9 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 void panfrost_device_fini(struct panfrost_device *pfdev)
 {
 	pm_runtime_get_sync(pfdev->base.dev);
+	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
+	pm_runtime_put_noidle(pfdev->base.dev);
 
 	panfrost_jm_stop_sched_jobs(pfdev);
 	panfrost_device_disable_hw(pfdev);

-- 
2.55.0

