Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E26CD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 14:04:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 382DA10E391;
	Mon, 25 May 2026 14:04:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q+CqJk5e";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB5B10E136
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 14:04:54 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-36af4b7840aso362338a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 07:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779717894; x=1780322694; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WU7p0G56s5zfUOdQ7oDtFqcXISuvDEUQ45whz+2fmhs=;
 b=q+CqJk5eDZ92LtzXmik5UXS5N4QTC4DYumsUKSBcyODZezqsOY3ErzbeCL8Qepx869
 mPZ5DFojtPzzb27xnGInixZWbtNOFtvXotJVTjVZIVtv9oJ4lTAX/otpXDuqFru2U9zT
 Fuh49KLDaWW/4TEe3BdOZfWV76v5U8+Ck4nRivl7F/xSJqHLFqK0tCzuvjCQVNBMC1Mq
 IwcpCbmOMx1mBVGB8sZGTTTvjDDkHpQCD8ZofWD/Vs+WWTJrtYTEDsAC9mI+7vxl6kdM
 oytM/S8LTYa75C+rgtfecraqcCJt36SnllQCNacldkQ+/+y9cUXbKITNx+LlgEdU3KEJ
 Fk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779717894; x=1780322694;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WU7p0G56s5zfUOdQ7oDtFqcXISuvDEUQ45whz+2fmhs=;
 b=PIl4Aqvj7QhoDqJgEGHP0LNA9WE6DtXew4KKeuAUF2mudwFVrOZQLdTwD61joDodQ9
 8kDCFR+T8+S3OtPCi7A1Iy34o0GDl4e4QCENmTbOCp8ZpYPjzU8IRBt1lKHKGVh7Cq4h
 /kwoWviSgPunPVjoMnL4D/gTDyFgXAPXZjKJuxSSh8J0r/gNQghfu2DdxDGAeGf6TudQ
 TEow4SeFlgVsqWqt7pJ9zBW5QBAap60Kjeur1Xlx1x8X6nSllHDMAOu1p69lNtXAQW5s
 /nyZ7yFgb1T/bJf3MWyZAgT54qLknph9eWYboicwxgk76FA7vsU0tEY13wjujNPZqQw3
 IbRA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8O+EjYpZriYdG+dWPHjStXwY8TxLsK4pVmu+EIO1wg4gQPO0gtOrNue4YV+em1u6gRm0KQrpY1YAg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy/2DL6Ss6wqYy9Z8rkBi1KJZ7Niy/knHMUJYhA8ACOgA0uypul
 gYJbw7LDbI80LLrTx5uq3qbivO6KziKE7QGk1C4ojFqXofIboTGzXZ5Z
X-Gm-Gg: Acq92OFov8922LJwnBFZCkmRmXo16o4YvMlFhfr/TtGjlGcUbblIm3ZLomwJ8axMcOa
 yR02QPJbiG+bD1fXt3+lBOvXuuuh5jNlsz9nSB0PLbDLPqDEBynWpWy6NcZ7Psa6ZiWsPzQaA0G
 1LW8+QY0m2O43ITSNejHI55PnAfcWHtX506DxBgYBd6kuDpqm9SJJCXVZx54LNZPRqwaKhDujAw
 d2yPINMhdckzxS9UoB+FYQ9FiyHqYg6hrVrcV8UvjqJjNVsz09CGDyx3o0VvzVkT8aUFj+S/+AM
 lC8p9OG4UGjJPMuYKw5rdjFJ/RwAiPAqBF5QZDLKB6MypG95NsuM+yGthVblcVQ+xZRUuOaGoIy
 pExDgxdYLCjW7VhXxskCXwB2I5o6xlqyJRYFniWgUHr7MijbEpUSOqe2uBF1hXJ4QDfoY5V49Hr
 K6LefjF5+nBG0ssXC+96oDOfXpwOl5RnnEEToiJzrJuDc=
X-Received: by 2002:a17:90a:c88d:b0:366:10f1:3d86 with SMTP id
 98e67ed59e1d1-36a67616988mr15429149a91.22.1779717893603; 
 Mon, 25 May 2026 07:04:53 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([14.48.8.61])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a726348e2sm9635503a91.2.2026.05.25.07.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 07:04:53 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: Melissa Wen <mwen@igalia.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Iago Toral Quiroga <itoral@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@kernel.org, Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] drm/v3d: fix to avoid cleaning up uninitialized CPU jobs
Date: Mon, 25 May 2026 23:04:22 +0900
Message-Id: <20260525140422.1545327-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The CPU submit ioctl checks cpu_job->job_type before the CPU job has been
initialized with v3d_job_init(). When no CPU job extension is supplied,
the check fails and the ioctl goes to the common error path.

That path calls v3d_job_cleanup(), which expects a fully initialized
v3d_job. However at this point the CPU job has only been allocated,
so the embedded DRM scheduler job state has not been initialized yet.

Initialize the CPU job after parsing extensions, but before validating
the CPU job type and BO count. Keep pre-initialization failures on a
separate path that only deallocates the job and releases multisync
post-dependencies. Also use the CPU-job release callback so initialized
CPU jobs are released through the normal cleanup path.

Cc: stable@kernel.org
Fixes: aafc1a2bea67 ("drm/v3d: Add a CPU job submission")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 3ddd53b6f437..f5a1b388eaa3 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -1300,10 +1300,18 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 		ret = v3d_get_extensions(file_priv, args->extensions, &se, cpu_job);
 		if (ret) {
 			drm_dbg(dev, "Failed to get extensions.\n");
-			goto fail;
+			v3d_job_deallocate((void *)&cpu_job);
+			goto fail_init;
 		}
 	}
 
+	ret = v3d_job_init(v3d, file_priv, &cpu_job->base,
+			   v3d_cpu_job_free, 0, &se, V3D_CPU);
+	if (ret) {
+		v3d_job_deallocate((void *)&cpu_job);
+		goto fail_init;
+	}
+
 	/* Every CPU job must have a CPU job user extension */
 	if (!cpu_job->job_type) {
 		drm_dbg(dev, "CPU job must have a CPU job user extension.\n");
@@ -1319,13 +1327,6 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 
 	trace_v3d_submit_cpu_ioctl(&v3d->drm, cpu_job->job_type);
 
-	ret = v3d_job_init(v3d, file_priv, &cpu_job->base,
-			   v3d_cpu_job_free, 0, &se, V3D_CPU);
-	if (ret) {
-		v3d_job_deallocate((void *)&cpu_job);
-		goto fail;
-	}
-
 	clean_job = cpu_job->indirect_csd.clean_job;
 	csd_job = cpu_job->indirect_csd.job;
 
@@ -1402,6 +1403,8 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 	v3d_job_cleanup((void *)cpu_job);
 	v3d_job_cleanup((void *)csd_job);
 	v3d_job_cleanup(clean_job);
+
+fail_init:
 	v3d_put_multisync_post_deps(&se);
 
 	return ret;
-- 
