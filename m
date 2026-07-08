Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBA5C44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 08:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAD0610F052;
	Wed,  8 Jul 2026 08:37:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QfA4m8cT";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1C2510F052
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 08:37:46 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-845b6d9bf39so382216b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 01:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783499866; x=1784104666; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rkFHFrpdMX2lTPQZppYAFTvSiQ8aiF+y8Org7/neXaw=;
 b=QfA4m8cTeWc3u7IsqgrSreuf71YFUB34xKN7HQcm6w4G8hATTBGVv8JY2bkW5ZSvW+
 fR9G4zGPbmZuggBvBTaHondGsBtuCpiHL9UjsEmVMv4jkVlcaUaB4XEG+hJqC/DQMkT9
 syREZKhDyWXHsjYrWfbzSyJ2qfwa7C5x5Nm1sp2g+YHdVE7ApyecLodJk3lLPrtx8NFl
 1zNmL9dtgqgqiagfqEK4XWGwX6Q3zkxj38pcIfoge+fM5HHqPeRRpqwZI0nQ593etp1c
 yPjpa/3mYTQL9/md4Z5KmdqhyJgNYZEIJIyoxL7MqQs5FRUmrbaJoxAMy60p3Ai4e01N
 SFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783499866; x=1784104666;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rkFHFrpdMX2lTPQZppYAFTvSiQ8aiF+y8Org7/neXaw=;
 b=q8Nf7ZzcjY5mCd3qKHHrepzp76xibI6DClgDqKhmiYOTManndEbz6HshG6MFHQU517
 S/3qi7d39YOfudsElxxPTBvs6ctIG3mtRXCOp6cRyjjLv7BsZGeysG0ne8cRQNcty6+w
 PsQoGxUrjSZUn+1LTwBV1FQylWBQpptQ2cdFA/tceMgBADoU+fUhgZ87kbjcu058AONw
 ydIYrHsC55ASs5Bn5/JiT1i7TjhFpQJI1dKnpTEecnIeYh3qf/IRxaWgcHFKXKmelCpw
 Ph8NaQ9BEgBNgjbGhQvbMJYaB5X3KuhWLD3L3nqQ5+FhaWQ/P7510336W/MBxLQ54WRH
 kcoA==
X-Forwarded-Encrypted: i=1;
 AHgh+RruHurXPW7jJa7uLR++mXnxXpezFhiNjqWYbltMbwi9R0TaRfrqZW5dGhcIKRtx7RZ/prwK0FOg4So=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywe5KelphLSvMdF8qmVC9idAGjoNhDuLDaWehTSnnsPUK11JoST
 /VcWJDDesN2oMRktdJzTuaCV30FJAPPcH+iosRgIgYUbBBw62fSD/YWce/k0gtmvmdQ=
X-Gm-Gg: AfdE7cmm7RBsDo7wl70YNgU9S7pCL3M0FL5hLOhsIMX/Revk3PUgqtSNR+jCXZVaOvM
 8GodozAgNy3SHaagnitlek3B+49slP0JowpTj2HKaBvXGMM4aCAYG5w6Oc0IgNv9iE1hZMNJQIg
 nIGnJ3ORqpquG1/LSIQ1XElodtl2wUTK0AT0OYZMCelnUu6QxsV4lZ1G557hEofH2NgV0chwges
 oG9NrbRz4nABobF+GA0eRVhxKtuvTPxCylgq1St4jVUxqoNQOxXTgjg1COcbQHnuaPI1N8WI+zJ
 QsiLykSmIx63ZqEuIxOdX/5Djz5VUYwQ17fHz42/+/0I87WKLOF/WiPq9JFOW41zMSi3sT1Rgjx
 2m+JPlPDeVCCvBDeBUu1+WsNP14vr7VnV4tDCgeZ7vZIJCbY3POvI7o36EAc0MxLTyfTdTn3+lf
 e2tA==
X-Received: by 2002:a05:6a00:4292:b0:842:3838:cb03 with SMTP id
 d2e1a72fcca58-84842ef74f3mr1635653b3a.11.1783499866370; 
 Wed, 08 Jul 2026 01:37:46 -0700 (PDT)
Received: from lgs.. ([152.32.251.59]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm6713214b3a.40.2026.07.08.01.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 01:37:45 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Melissa Wen <mwen@igalia.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Iago Toral Quiroga <itoral@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] drm/v3d: release indirect CSD GEM on pre-init failures
Date: Wed,  8 Jul 2026 16:37:28 +0800
Message-ID: <20260708083728.737168-1-lgs201920130244@gmail.com>
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

The change referenced by the Fixes tag releases the indirect CSD GEM
reference from v3d_cpu_job_free(), the CPU job kref destructor.

However, the indirect CSD GEM object is looked up while parsing CPU job
extensions, before v3d_job_init() has successfully installed that
destructor. If v3d_setup_csd_jobs_and_bos() fails, if a later extension
fails, or if v3d_job_init() itself fails, the CPU job can be cleaned up
or deallocated without running v3d_cpu_job_free().

Drop the indirect CSD GEM reference on those pre-init error paths and
clear the pointer after doing so.

Fixes: 6eb6e5acafa4 ("drm/v3d: Release indirect CSD GEM reference on CPU job free")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 1db43c6a078d..8ed95a203810 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -476,6 +476,7 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
 	struct v3d_dev *v3d = v3d_priv->v3d;
 	struct drm_v3d_indirect_csd indirect_csd;
 	struct v3d_indirect_csd_info *info = &job->indirect_csd;
+	int ret;
 
 	if (!v3d_validate_cpu_job(file_priv, job))
 		return -EINVAL;
@@ -496,9 +497,15 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
 
 	info->indirect = drm_gem_object_lookup(file_priv, indirect_csd.indirect);
 
-	return v3d_setup_csd_jobs_and_bos(file_priv, v3d, &indirect_csd.submit,
-					  &info->job, &info->clean_job,
-					  NULL, &info->acquire_ctx);
+	ret = v3d_setup_csd_jobs_and_bos(file_priv, v3d, &indirect_csd.submit,
+					 &info->job, &info->clean_job,
+					 NULL, &info->acquire_ctx);
+	if (ret && info->indirect) {
+		drm_gem_object_put(info->indirect);
+		info->indirect = NULL;
+	}
+
+	return ret;
 }
 
 /* Get data for the query timestamp job submission. */
@@ -1311,6 +1318,10 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 		ret = v3d_get_extensions(file_priv, args->extensions, &se, cpu_job);
 		if (ret) {
 			drm_dbg(dev, "Failed to get extensions.\n");
+			if (cpu_job->indirect_csd.indirect) {
+				drm_gem_object_put(cpu_job->indirect_csd.indirect);
+				cpu_job->indirect_csd.indirect = NULL;
+			}
 			goto fail;
 		}
 	}
@@ -1333,6 +1344,10 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 	ret = v3d_job_init(v3d, file_priv, &cpu_job->base,
 			   v3d_cpu_job_free, 0, &se, V3D_CPU);
 	if (ret) {
+		if (cpu_job->indirect_csd.indirect) {
+			drm_gem_object_put(cpu_job->indirect_csd.indirect);
+			cpu_job->indirect_csd.indirect = NULL;
+		}
 		v3d_job_deallocate((void *)&cpu_job);
 		goto fail;
 	}
-- 
2.43.0

