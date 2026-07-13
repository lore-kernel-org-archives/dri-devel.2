Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC98C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B8CA10E35D;
	Mon, 13 Jul 2026 16:06:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nQVypAld";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A1DE10E35D
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 16:06:49 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-381018b9375so3798661a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783958809; x=1784563609; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ryGtyXUkJGyx4y6Y9GxT62jrJOuVmMDJpP45K17ylC4=;
 b=nQVypAldcBSisjIyN8vKnvQCWZ22nCwfdCZUpiUrLluwSiLbDkM6WecPACxTW1D8kY
 yMemaRuydSLc2oj0f1TJeMbxA8cC43NBO+WpRYAcajVexd0E8gGbeYByDcyN7sdkRCdG
 8WVqC/wA1FnfL8mPxY967g/Sskr2gJ+5Ai2yCSmHK4rV+MBNOZt3s67zHvrl3M1yKw/O
 Yam1JOTU41taGEO0HPLIvs8vHOi9g3VH0O95e0NGWCF4tDQoh84x4kFd+7rNJu8waA15
 6i3Ll7ms1zJYLiZdl9kghf6DCbSg9d/XbSyyjh5UojkqXg6qJNmfMEHyRTPXwUmxG0WL
 hI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783958809; x=1784563609;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ryGtyXUkJGyx4y6Y9GxT62jrJOuVmMDJpP45K17ylC4=;
 b=lJAGgIfUgtubWKQpsSYbx/6cK1w249K3jQi9fwAiPQ9ltTHDDAfcia33ipOgDsZtQH
 MnAFNcTxVunesg8h+yZ1PEK2f02QuMNPQtBoceQ/8OY2LaRTr8RvUj+XTT06WDE+ZKSG
 /S8cWqjAOqQS1oNvcyXzpL9c1ImjjbtAAeuvO/C7hn7NndBnSoLImb+lljd2Vnk0CpK4
 53IXj0DdDzH1KsUPFQD3yN6O9BlBB5KMRBNSlSU+NlyfHdH0WWpm7C1Ng/dT2Kv5Yb3w
 ezNizS96d7KLdvD4ZEYyAG602caXqV9+ZNqtaQLL+rymG8fxXr4BCerDxWm0gQnKIJ0C
 wP0g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJABkPaixjMMaCaHVxMFL2znH6h1Rc/qINgsDwEf+AgGXSQV9Yo3jMB35CMsuuc2ZuugbDybpYu3Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJqxnd7J0Jk/dR37diIuvRg6E5u2BycE+U/ZgEhe34QteKqSxm
 zxsULVier/rDWoXKKLOjPxnniGou75Jvg+RWaR82xcrJEViKmL2DGxq/
X-Gm-Gg: AfdE7ckwXshhP3UbfiCzfiFTtMqlSffBoh0LpZfGFFKvHMwxr9jcX44boA91LgDo8RB
 /2IaR7V6go8LwfpOxCfZrOLDFga4joA13fwaqf3qRycXzI0GkMbUUb4f4fTXalA8XUyEqa9bGb/
 iBd4AsZyfCSJU5/x+harETvzGgt4FbFdGwYi7PMnHYPDdPUuVrPgTGkPhjYx8MwcbBivkKmKKlm
 b2gjS3hyh7bvcU3nURQ2mQLuMUw78f6t3o9/dCex6uHCCLlJwWJQV3AVImGgHQRJJOT7Ggyt744
 50R10siK/w/HtEP74FLWKos+l4f3/8LWZZo6UMMhbfAMgKJMSZ1R6NpMAXcSuqv4STZY/Zj3mrO
 Hj1S+drbwhME9BFhZ+HU49ws5b8MYbxk80f5G9hbjVswyYfLfQKnPIrBEr+6E2KyBnrI6g1Zbuv
 tIXkg=
X-Received: by 2002:a17:90b:2781:b0:387:df8f:1401 with SMTP id
 98e67ed59e1d1-38dc77a7b96mr9946987a91.34.1783958808546; 
 Mon, 13 Jul 2026 09:06:48 -0700 (PDT)
Received: from lgs.. ([101.36.109.157]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e172b6d08sm140025a91.2.2026.07.13.09.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 09:06:48 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Melissa Wen <mwen@igalia.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Iago Toral Quiroga <itoral@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH v2] drm/v3d: release CPU job resources on pre-init failures
Date: Tue, 14 Jul 2026 00:05:31 +0800
Message-ID: <20260713160630.1362131-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The changes referenced by the Fixes tags moved CPU job resource cleanup
to v3d_cpu_job_free(), the CPU job kref destructor.

However, CPU job extensions are parsed before v3d_job_init() has
successfully installed that destructor. Timestamp and performance query
arrays, their syncobj references, and the indirect CSD GEM reference can
therefore be acquired before the CPU job is managed by the kref cleanup
path.

If a later pre-init validation fails, or if v3d_job_init() itself fails,
the CPU job can be cleaned up or deallocated without running
v3d_cpu_job_free(). Those extension resources are then leaked.

Move the CPU-job-owned resource release into a helper and call it both
from the normal CPU job destructor and from the pre-init error paths.

Fixes: b0fe80c0b925 ("drm/v3d: Fix use-after-free of CPU job query arrays on error path")
Fixes: 6eb6e5acafa4 ("drm/v3d: Release indirect CSD GEM reference on CPU job free")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Rebase onto drm-misc-fixes.
  - Fold the indirect CSD GEM pre-init failure fix into this patch.
  - Drop unnecessary pointer and count resets after releasing resources,
    as suggested by Maíra Canal.

 drivers/gpu/drm/v3d/v3d_submit.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 7682b24f13ec..2b1dc92d4709 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -127,11 +127,8 @@ v3d_render_job_free(struct kref *ref)
 }
 
 static void
-v3d_cpu_job_free(struct kref *ref)
+v3d_cpu_job_free_resources(struct v3d_cpu_job *job)
 {
-	struct v3d_cpu_job *job = container_of(ref, struct v3d_cpu_job,
-					       base.refcount);
-
 	v3d_timestamp_query_info_free(&job->timestamp_query,
 				      job->timestamp_query.count);
 
@@ -140,7 +137,15 @@ v3d_cpu_job_free(struct kref *ref)
 
 	if (job->indirect_csd.indirect)
 		drm_gem_object_put(job->indirect_csd.indirect);
+}
+
+static void
+v3d_cpu_job_free(struct kref *ref)
+{
+	struct v3d_cpu_job *job = container_of(ref, struct v3d_cpu_job,
+					       base.refcount);
 
+	v3d_cpu_job_free_resources(job);
 	v3d_job_free(ref);
 }
 
@@ -1313,6 +1318,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 		ret = v3d_get_extensions(file_priv, args->extensions, &se, cpu_job);
 		if (ret) {
 			drm_dbg(dev, "Failed to get extensions.\n");
+			v3d_cpu_job_free_resources(cpu_job);
 			goto fail;
 		}
 	}
@@ -1320,12 +1326,14 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 	/* Every CPU job must have a CPU job user extension */
 	if (!cpu_job->job_type) {
 		drm_dbg(dev, "CPU job must have a CPU job user extension.\n");
+		v3d_cpu_job_free_resources(cpu_job);
 		ret = -EINVAL;
 		goto fail;
 	}
 
 	if (args->bo_handle_count != cpu_job_bo_handle_count[cpu_job->job_type]) {
 		drm_dbg(dev, "This CPU job was not submitted with the proper number of BOs.\n");
+		v3d_cpu_job_free_resources(cpu_job);
 		ret = -EINVAL;
 		goto fail;
 	}
@@ -1335,6 +1343,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 	ret = v3d_job_init(v3d, file_priv, &cpu_job->base,
 			   v3d_cpu_job_free, 0, &se, V3D_CPU);
 	if (ret) {
+		v3d_cpu_job_free_resources(cpu_job);
 		v3d_job_deallocate((void *)&cpu_job);
 		goto fail;
 	}
-- 
2.43.0

