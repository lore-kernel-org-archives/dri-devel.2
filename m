Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA626C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 09:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E9AA10F077;
	Wed,  8 Jul 2026 09:03:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="smiijCzU";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1960710F062
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 09:03:46 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-847a69ba83dso367633b3a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 02:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783501425; x=1784106225; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OrLAGUFeKbr7ox+LI/0Wbz5q2HAYtvEZJ0vD+5N29cs=;
 b=smiijCzU15zaAYAdg7nCSwhXSl1IgMwVcuSkBq0J0XiE22IBZ4c22r1IRHatdkQSPH
 KohM2zPKohd+PxntyGKQSDroTOPWs51lr2sGNl1mtGyJlMCgX7G+CDaiMpt9qZVp1srh
 xyZ7nSrvnK34IsPjoVe0qkV24L9R0IS4IdEkpeismZ7vWNZ1ZN3XuyLBIXGyvAq1VipJ
 U5d6eepedADJ9Vfjto3Xhvl/Bxavhsp3UWFp5pjr/iDFYNYH7mlzkIlLjHYGXgtIoWT1
 YpzYn6X9yDiAGQJ9m3+VHfVpn3ULlwAJd5+p8oakDIEBiESyWNkyc4DMwkmnPNSh/BGy
 Cfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783501425; x=1784106225;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OrLAGUFeKbr7ox+LI/0Wbz5q2HAYtvEZJ0vD+5N29cs=;
 b=F5PFmi0em1kZWhXutCVB0sqVcQcRqR/4stfnNZytZa4u5d0sydVAJKTan4HOSp+w86
 XaaJvK7NjoLwrU+HTgf/QvQb0F2Sd+dycvonlEGcgFGe6ugVNog51InmlJkZJUbRwpi+
 m+0MTharyutZlpF/I4BSYCX8ptGfe9bIo3h2FFxlzbUFptg/dXF/dwm3MfsX75EI6bzG
 D2ZpqGcCUlTrQe4RBCkfp7yq5TZwaSYQbLIEMDiljObbyzqQiCQAzj2TFXo1bsAihoiE
 FcLkcTQJ4AK7GhswlIK8FcIpjoJ7T/FjMRVMVfQ947YxZQPP/STQ9YRmXsmFq1yaJCMe
 MrRw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoSdrbgxUEu3TOSicxWJBwC26Wn+nxnejyA3UaKLXIxLaAzBMbIVEWQwauMkOR+zWSuh1NyDWUcytA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzlYKWT46XTBsXMnzDUuxBtybh0lOfsIxdFeeX8jzZsKhO3awVZ
 byxSx4YAQKjWe2+HEeFgVYgClhCazUMUEnZatCjloxN914Bh9onAp0AP
X-Gm-Gg: AfdE7cnKqffdQX74LfN5BEXxCMyPmLUGZ36tCgls9lbVLYVT+/r+ncOeVkV7TKpWLF0
 S33hZwMEACA+DkYE2AZES9Q1VW2r4CyLMo5MMXqe9pUQnm2gbBiglpGSmBPe7Vdrt4fLrJGGjTy
 G4WSgDgHxrE21rJnpLUMSL1dBZtyTOoYhs+GcBWWf6p0XgyW0xQSIupWlheUXUYTmtqcQIuXM+G
 z2C4X1HU/Js4VL8c9rst8AJAjtHAFXr3ijCZWGy+ugTSYsjrXKcDP9VdQ08m+srP8Zo2m2+m/S9
 bhF9wOXVsf9OarIbkmE3nQFjF6t4w3TyFwNKR1iOLC7eJY6rfQxJ0FUNR8QIpnpRnqo4g5n/tov
 d7pmbjHLT3d7aeTpgmOd1WbGGiq9vZUNan3Pz1ppOdSoUIXthskNtcqY6xCocJ5N0/8qAQcQq8R
 w2KCY/Ag==
X-Received: by 2002:a05:6a21:4591:b0:3bf:b931:b3ec with SMTP id
 adf61e73a8af0-3c0bd16cd2cmr1851514637.57.1783501425589; 
 Wed, 08 Jul 2026 02:03:45 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5b3643beesm2029602a12.25.2026.07.08.02.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 02:03:45 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Melissa Wen <mwen@igalia.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Iago Toral Quiroga <itoral@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] drm/v3d: release CPU job resources on pre-init failures
Date: Wed,  8 Jul 2026 17:01:32 +0800
Message-ID: <20260708090132.738819-1-lgs201920130244@gmail.com>
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

Move the CPU-job owned resource release into a helper and call it both
from the normal CPU job destructor and from the pre-init error paths.

Fixes: b0fe80c0b925 ("drm/v3d: Fix use-after-free of CPU job query arrays on error path")
Fixes: 6eb6e5acafa4 ("drm/v3d: Release indirect CSD GEM reference on CPU job free")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 8ed95a203810..2cca9c49f30c 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -127,20 +127,28 @@ v3d_render_job_free(struct kref *ref)
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
+	job->timestamp_query.queries = NULL;
+	job->timestamp_query.count = 0;
 
 	v3d_performance_query_info_free(&job->performance_query,
 					job->performance_query.count);
+	job->performance_query.queries = NULL;
+	job->performance_query.count = 0;
 
-	if (job->indirect_csd.indirect)
+	if (job->indirect_csd.indirect) {
 		drm_gem_object_put(job->indirect_csd.indirect);
+		job->indirect_csd.indirect = NULL;
+	}
+}
 
+static void
+v3d_cpu_job_free(struct kref *ref)
+{
+	v3d_cpu_job_free_resources(job);
 	v3d_job_free(ref);
 }
 
@@ -1318,10 +1326,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 		ret = v3d_get_extensions(file_priv, args->extensions, &se, cpu_job);
 		if (ret) {
 			drm_dbg(dev, "Failed to get extensions.\n");
-			if (cpu_job->indirect_csd.indirect) {
-				drm_gem_object_put(cpu_job->indirect_csd.indirect);
-				cpu_job->indirect_csd.indirect = NULL;
-			}
+			v3d_cpu_job_free_resources(cpu_job);
 			goto fail;
 		}
 	}
@@ -1329,12 +1334,14 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
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
@@ -1344,10 +1351,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 	ret = v3d_job_init(v3d, file_priv, &cpu_job->base,
 			   v3d_cpu_job_free, 0, &se, V3D_CPU);
 	if (ret) {
-		if (cpu_job->indirect_csd.indirect) {
-			drm_gem_object_put(cpu_job->indirect_csd.indirect);
-			cpu_job->indirect_csd.indirect = NULL;
-		}
+		v3d_cpu_job_free_resources(cpu_job);
 		v3d_job_deallocate((void *)&cpu_job);
 		goto fail;
 	}
-- 
2.43.0

