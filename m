Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E44FCA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 12:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCE3C112100;
	Fri,  9 Oct 2026 12:35:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Y5lwtFhW";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 715BD112100
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 12:35:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791549297; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MapIU5EOwJqSOuTxjJ8jbDf4medCip4QICdqdTbQtT68IwXRZKvD9PKS6OmcGIr4I1ufxqfKhHD/kCpEweqbuSMGCGvoSs+3DvpxjjkDX9UfeOoC9ZmGkaFHEy8gHX6RGn9/5OGa0o+BwlftDU5NaRtHTztd1U/WhD11bMaMTUQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791549297;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Ow8m1p85I2URfn8W7y19YwhJHcOAO4IB4TdoCwyI3XQ=; 
 b=Ax4FFnrANv5vaVnkUAOoB3qFgovN2Tnwf7Z1ozfV3kSL3OmuEoLSq3A5zrhcu+TQFNqMZn9SiSLFGSJtSlMfjWXsVPdsTpRHf2B07D3Qv7jz0i38tR78H/MXpn8uPlFgLsejsXLziDpL3Fx3vZ5TgKYiqgIK4VRp7gII07H16Mo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791549297; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Ow8m1p85I2URfn8W7y19YwhJHcOAO4IB4TdoCwyI3XQ=;
 b=Y5lwtFhWOzAtCitpImZtj6nPWgnNH0Wfhhrd9IPUf7flWomsjQUKAG9TU17LiJlr
 +DxNhTnJoCILK4nVEL/XGt2ndoaPuwkD5Yv1VXwArA4s3O1/SF4PY3mE7DQOgvWObpW
 XIn8iHa+TQR5hzTgbtO+C4+jJgejN/Uly+Dbpd8M=
Received: by smtp.zohomail.com with SMTPS id 1791549296153116.76854193393274; 
 Fri, 9 Oct 2026 05:34:56 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 09 Oct 2026 13:33:57 +0100
Subject: [PATCH v14 10/15] drm/panfrost: Add debugfs knob for manually
 triggering a GPU reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261009-claude-fixes-v14-10-cb743b3b973b@collabora.com>
References: <20261009-claude-fixes-v14-0-cb743b3b973b@collabora.com>
In-Reply-To: <20261009-claude-fixes-v14-0-cb743b3b973b@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3249;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=J9qMQhiTpJOf48Udf2cuPWnHMtP8lHjxgtPC1iHmQ5g=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqyN8vytX7e+sjqktFNc7g/V4fPOzja+Suak0Cv
 pvEerepfoiJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCasjfLwAKCRAOJn5M7lND
 PczkDACk6cPRKDs3HibudDyXXulmeNK80yMfJFqzFr2jDdCXvL7kmNx5PA1h7RoYnd9em7vqNvM
 p2GwEIKi/LLZZV8ZXqGaO/kQVIUHf9SdJOSTAdPPoFyej2aW/NLcY24IM4wYwlB/P95bByJA0ls
 4smdVHHZ23RnWNZjIRIZb85mH3dOU/KyoYCt+zFCjTHBscuagTNehGRfeXz7H6Tav2eO0Vem9Y3
 m7B1Q8InX6MCF7W0HSkjvXZiYVKPWHB8ojKtKZ5wXafpUMpgbNpQWk6sgYPaxPtSgqH2W+43+xE
 TBq/794TJopzDZ8piGd9nCQwU6tNtogVvkf9qqrxsG9SKqa9VznD+c0DzwKpruJGznppQcv7eXC
 LCwi1kgKN+q96o+lxsXhJ+pYxiFRan6xokakj+ynJOa9oCtDNB0V2ZE3NVtkPyK0EC2BxpJ/rv2
 2Nyq6uoCNYn0YOGBX1PB6N0MuntFCU6cvSsIHpNMO2q1/FxscOI5rmA7foVZ4IZpJ8d9g=
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

This will be of great help when testing potential races between the GPU
reset sequence and other parts of the code accessing HW registers.

We must also disable the reset work item rather than simply cancelling
it, to prevent the knob from triggering another reset when the device
is being removed.

At the moment, the only legitimate input value for the knob is '1'. This is
to allow for future inputs that would encode alternative reset scenarios
we'd want to trigger manually.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 46 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_job.c    |  2 +-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 687230225743..b3dae6ce3eb0 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -2,6 +2,7 @@
 /* Copyright 2018 Marty E. Plummer <hanetzer@startmail.com> */
 /* Copyright 2019 Linaro, Ltd, Rob Herring <robh@kernel.org> */
 
+#include <linux/debugfs.h>
 #include <linux/clk.h>
 #include <linux/reset.h>
 #include <linux/platform_device.h>
@@ -623,9 +624,54 @@ EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) = {
 };
 
 #ifdef CONFIG_DEBUG_FS
+static int reset_get(void *data, u64 *val)
+{
+	struct panfrost_device *pfdev =
+		container_of(data, struct panfrost_device, base);
+
+	*val = atomic_read(&pfdev->reset.pending);
+	return 0;
+}
+
+static int reset_set(void *data, u64 val)
+{
+	struct panfrost_device *pfdev =
+		container_of(data, struct panfrost_device, base);
+	int ret;
+
+	if (val != 1)
+		return -EINVAL;
+
+	ret = pm_runtime_get_if_active(pfdev->base.dev);
+	if (!ret)
+		return 0;
+
+	panfrost_device_schedule_reset(pfdev);
+	flush_work(&pfdev->reset.work);
+
+	/* ret < 0 means runtime PM for the device is disabled, so we
+	 * only need to return the PM reference in the opposite case
+	 */
+	if (ret > 0)
+		pm_runtime_put(pfdev->base.dev);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(panfrost_reset_debugfs_fops,
+			 reset_get, reset_set,
+			 "0x%08llx\n");
+
+static void panfrost_reset_debugfs_init(struct drm_minor *minor)
+{
+	debugfs_create_file("reset", 0600, minor->debugfs_root,
+			    minor->dev, &panfrost_reset_debugfs_fops);
+}
+
 void panfrost_device_debugfs_init(struct drm_minor *minor)
 {
 	panfrost_gem_debugfs_init(minor);
 	panfrost_sched_debugfs_init(minor);
+	panfrost_reset_debugfs_init(minor);
 }
 #endif // CONFIG_DEBUG_FS
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 00fb36c577df..ab65786bf63b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -932,7 +932,7 @@ void panfrost_jm_fini(struct panfrost_device *pfdev)
 		drm_sched_fini(&js->queue[j].sched);
 	}
 
-	cancel_work_sync(&pfdev->reset.work);
+	disable_work_sync(&pfdev->reset.work);
 	destroy_workqueue(pfdev->reset.wq);
 }
 

-- 
2.55.0

