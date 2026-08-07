Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B10C5ACAB
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 14:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB4F210E41D;
	Fri,  7 Aug 2026 14:56:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m9+tIsNd";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A0DD10E36A
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 14:56:39 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2d02b4c3601so38651445ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 07:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786114599; x=1786719399; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=G/8xx2t4WO7QVCjZ7uGwrmqxOJTEUaxIvRYS3m/7Bno=;
 b=m9+tIsNdZ4U6leCYnziJeqmxy+iHFrR5r4z24BfnEXnR12GxezoB6k9MFwsXpKzIjD
 GHFXpYpAsHQw5qsyWojA422hbdC70O3ITlhNW3NUmzEa/v98+5HZcUeBR/mhQISh2kOx
 pgi/7GFWqDnxCFH1ZW3K23dfIooQhWmrA7EUXna+Jb6b8bmqRG+qRxOocgtHBYc4gITP
 6V7dNSJooQz6mT0EkJ9eAFTZJZ7sj7ftzlfNrCYhBYUPmIvEFrm4e3l7Ra8JDPFUy09v
 BEoNVr7wVzBo08fpZACm3Eb/nYruZkdE2WQWp/a1knx11gp0/tz3INQnQ5abXuR9EU51
 2r4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786114599; x=1786719399;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G/8xx2t4WO7QVCjZ7uGwrmqxOJTEUaxIvRYS3m/7Bno=;
 b=ZnReXSXN8PonKcgRFuCCS3rsWofm08JSGshpWX1BhpoVzaOGjCy02c2HuN2Tif/R8S
 v7sA8o48Hrzw5U3haRuSpiGr89hJB0NxR0aaQAMpupJGfrKyp9a1zY5H8pCKnnDhEu+3
 VwWi5lW5c6kZJIi4HsTNuEu2qjLnY8RGlQWVj/k8d3KIU+OLBPdcYyvgN1SMLbbGWkzT
 Y6nayrjkJG9BGBQlQVwBJoQe1HbJELczn4ffh1ScAJhYFTHjmeo0ZwCLFo+22sRYmlm+
 +/L+EkaG8XRuYA5/15ZeiGzS5t/tmBPNoY0/oPdUzAxTxNBLFPWaVKWR/sz86z1GQn6q
 D1fw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2V2Hl1c8YojaWKh8PR6hgcCiol181TWfZ3RocmzukNDRkFTGfb18KsfXk1rHJaLXSd0VNm7QNacE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLhND6Ymsi5wsVzd/MIRmeCENddz3vjwERVNHBJ1irwOF6ZHIQ
 qNSxFQ4NgxRHWHHcYRWndIjeWCz8PH3/bpkFb+ypSmWWE9sr8o7G+PFG
X-Gm-Gg: AR+sD11hhfXEt4Hug9v57Zqv5PVNMmbhMjl9Vz8zwMx6YiVddNtztlTI+4Deg6DCGHj
 yGdyUTCsVgLTnV0Ryw5IARG2J8fs5nC4bo+xa9Mt4L2jQYZUdMYJ/NL8oyQBT5TJJpZI7yfRsKR
 2gmFml8qqCXG/0srX4j23mV1sJ3giuNSLEvtxOOfO2vKBrAAg76zx3pFiHehSFuiHrpno+VIZDR
 XZRYKu12YOJ4RnvTrSn0ZJ18ZSt9q35JN2w8wLOtlMSEDUN3Y6LfEo71P56Jp7SFMGj6iQXEs8n
 e7bjMbA2qfmO6geEhhedvP+IZOiFrBNIQPfdDpbvCmVRfhHluUk5kuS+Ps5hm8J0mFS1bUiRIuQ
 0GCunz56M1NNaoMjWaGQbhVDYfQ1Av6M42eHXxTHHJLy5yQW3mdhUK8Y1qgh8BsOdEaQbV79ONc
 /UlAJql2bwkQj/bTRiRsUwXx4ucOUrSoMMl63wge+nSmw=
X-Received: by 2002:a17:902:d485:b0:2c9:d55d:2d3 with SMTP id
 d9443c01a7336-2d2a20b6c2cmr23611005ad.15.1786114598695; 
 Fri, 07 Aug 2026 07:56:38 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d14dbeaa95sm10653235ad.38.2026.08.07.07.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 07:56:38 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Krystian Pradzynski <krystian.pradzynski@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] accel/ivpu: fix usage_count leak when autosuspend_delay is
 negative
Date: Fri,  7 Aug 2026 22:54:16 +0800
Message-ID: <20260807145416.2518999-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

ivpu_pm_init() calls pm_runtime_use_autosuspend(), but the autosuspend
setting is not disabled when the device is removed or when
initialization fails after runtime PM setup.

When the autosuspend delay is negative, the runtime PM core increments
usage_count to prevent runtime suspend. Without a matching
pm_runtime_dont_use_autosuspend(), this reference is not dropped and
usage_count remains unbalanced.

Call pm_runtime_dont_use_autosuspend() from ivpu_pm_disable() to clean
up the autosuspend state during normal device teardown. Also undo the
autosuspend setting when ivpu_boot() fails after ivpu_pm_init().

This issue was found by manual code inspection.

Fixes: 852be13f3bd3 ("accel/ivpu: Add PM support")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/accel/ivpu/ivpu_drv.c | 4 +++-
 drivers/accel/ivpu/ivpu_pm.c  | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 35e506074d5f..633c90e73f2c 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -756,13 +756,15 @@ static int ivpu_dev_init(struct ivpu_device *vdev)
 
 	ret = ivpu_boot(vdev);
 	if (ret)
-		goto err_ipc_fini;
+		goto err_pm_fini;
 
 	ivpu_job_done_consumer_init(vdev);
 	ivpu_pm_enable(vdev);
 
 	return 0;
 
+err_pm_fini:
+	pm_runtime_dont_use_autosuspend(vdev->drm.dev);
 err_ipc_fini:
 	ivpu_ipc_fini(vdev);
 err_fw_fini:
diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index c1ce8329790e..20dc8ec7d70a 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -445,6 +445,7 @@ void ivpu_pm_enable(struct ivpu_device *vdev)
 
 void ivpu_pm_disable(struct ivpu_device *vdev)
 {
+	pm_runtime_dont_use_autosuspend(vdev->drm.dev);
 	pm_runtime_get_noresume(vdev->drm.dev);
 	pm_runtime_forbid(vdev->drm.dev);
 }
-- 
2.43.0

