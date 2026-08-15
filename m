Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF5EC5DF70
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6406A10E1BC;
	Sun, 16 Aug 2026 14:05:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A/wfYo8p";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1A3E10E0EB
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 14:59:19 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso22934185e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 07:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786805958; x=1787410758; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wx5BkprMSKmCIjYgcc1kdDlxBMJZQro9c/22It8R+Vk=;
 b=A/wfYo8p8oJ2VuKLcH+2mZpWc2G5ZKFP33Nj/pJmLJxOIt5YHa0csU4ztF8R4k1phr
 BkTwMH/3vDGBw2TglCW5fSzRnkeLa4M4yKxTz8FNX6SPHv0LFZzE8LVpuFPhx69auDO7
 a/2fPLwpxtZHNgqBNhi9NxYO3oIpW39fwdwU+HpQKgt2udkRmx3gsq29a3FgiT9ytg3E
 6DeVVLPQd/AMOoOBqs7sWl1B+rcWkRbDf+kn9tVjBbreU/lecgDPB2fD7/PiNkMR9tlb
 Fi+3+OzF2RD2uFJLYYEa/BGGsRa2n4G7qg1v9DcligixgFiMGfzUqQXVD+cngZfIY5zC
 QLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786805958; x=1787410758;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wx5BkprMSKmCIjYgcc1kdDlxBMJZQro9c/22It8R+Vk=;
 b=HVM0/C/1j6tTpCtk0/z8+r0ZiN5BJSblqcyTzsyMxqD3WEI3Zs0Pme5C8mVZrh92zs
 rN0wAWrTX1wHRJo82353mAPcV99zI1MX5DmTjYM/0IC3Wdos9OTU71LXWTn2ICG9Vcdb
 k7xE1J2ZlRbqWHHiCty5LtTjo72lCArBJLe8GvgOzaJbMoJ0NJcGQ+aTCvGphlZQ78Rv
 vtV6vgVd4nERYGl7jUNMgpdtOmo0iCQgjNOGjBx0CfrxhjGe7vACnUxrvAbKBP3xaW+F
 7b73r7Uktu4VSeN2lacdQrpsWfhI01aTFNI+n22BTc66Vgqx5I+XNez++6tlH9Fi25yI
 iuSA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpumWge69GWFtXg75UVaQyYxaVmmCgcN2lqpqaPTqTjUQkLPOfmJQWgIztdQnvUAnBGaGOHHXxt07A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzP+10lpQXa3yX5leup10TzBMfnsAtRzenJw4oBvM9uq935gjqf
 An45jLOOGH4NoG6AqtEKqRy5sarKZEOlOg/Wv2/PSVDEcxRgI31BoC05
X-Gm-Gg: AR+sD13sFvt16CI1rtMnc3CCSM0N4kdr1Rutj/tQ2lH40sMvpRa0Mvf/+DvR8GaRr/r
 5nvBU/11hrxEugOUUZ2sUiV8bW8aqu9Wnl7mWxl6dIxpZW9QZ0n86Xk1gapswGa9pYnFKHw7tk/
 /a79/2R9oyBM++XsSjwDaYenl9hYWny9rlvKSgLi5YrHz4bb1pFeBgJm5KY92uimOFRNOeCiYqU
 k1peN2WtL8umSDnLpSM8kL5xHMpWmIwlOVGJq9dHd4N35NrhGky1Bgrfh2+Sp8Kt8bMtwuDliGk
 sjSuqpMwdiIjb2Hb5V6CNTpdqpZoWs9wVbzrWf4NrJEDKppHY3mZvQvcPfHEM1gSRJvhqWwwR6Q
 af+UoPAbY5CjK7+sYuvziAi6A/juyH4fKfgLWeykFQjEUu1wiNFPhfxnXBtZxhi1hyYn9QMtGqH
 RoXfGiet8zNHk93c2IgEyRBuAB6ZYvberlQAfj9ykLZxrkqSWRyvBSByS/myfi0ysBpYWRMmcxK
 wGQpgGUb0WUzRmXAjIseLbjHKE1yDia8QsIISkc4o9lWVH6hzsJuPuHc7brDDuJT9DImUaSdq7P
 OTCP5kjzoxuy4imE4UcTH8+GN3kByO0zABHfHSVFms2bxeVLM2gia1gTLeKOIBnxazC2
X-Received: by 2002:a05:600c:3485:b0:499:726a:a017 with SMTP id
 5b1f17b1804b1-49987938e19mr207043855e9.1.1786805957923; 
 Sat, 15 Aug 2026 07:59:17 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-aecb-d601-fc34-eb31-14a1-3704.310.pool.telefonica.de.
 [2a02:3100:aecb:d601:fc34:eb31:14a1:3704])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499899b5f86sm119605645e9.5.2026.08.15.07.59.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 15 Aug 2026 07:59:17 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Melissa Wen <mwen@igalia.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Iago Toral Quiroga <itoral@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] drm/v3d: Fix NULL pointer dereference in CPU job cleanup
Date: Sat, 15 Aug 2026 16:59:14 +0200
Message-Id: <20260815145914.84154-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

v3d_submit_cpu_ioctl() allocates cpu_job before initializing its embedded
drm_sched_job. If extension parsing fails, no CPU job extension is
supplied, or the BO count is invalid, it jumps to fail before
v3d_job_init().
v3d_job_cleanup() then calls drm_sched_job_cleanup() with a NULL s_fence,
causing a NULL pointer dereference.

An empty DRM_IOCTL_V3D_SUBMIT_CPU (flags == 0) is sufficient to trigger it.

Deallocate the job and clear the pointer on these paths, matching the
existing handling when v3d_job_init() fails.

v3d_job_deallocate() frees only the top-level job. If extension parsing
already allocated query or indirect-CSD state, that state still leaks on
these error paths, turning the former oops into a repeatable leak.
Fixing this safely is more involved and beyond the scope of this fix. This
patch therefore addresses only the crash.

Fixes: aafc1a2bea674 ("drm/v3d: Add a CPU job submission")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Tested on a Raspberry Pi 400: the unpatched kernel oopses on flags=0; with
this patch the ioctl returns -EINVAL without an oops.

 drivers/gpu/drm/v3d/v3d_submit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 7682b24f13ec5..304950ba42a38 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -1313,6 +1313,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 		ret = v3d_get_extensions(file_priv, args->extensions, &se, cpu_job);
 		if (ret) {
 			drm_dbg(dev, "Failed to get extensions.\n");
+			v3d_job_deallocate((void *)&cpu_job);
 			goto fail;
 		}
 	}
@@ -1321,12 +1322,14 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 	if (!cpu_job->job_type) {
 		drm_dbg(dev, "CPU job must have a CPU job user extension.\n");
 		ret = -EINVAL;
+		v3d_job_deallocate((void *)&cpu_job);
 		goto fail;
 	}
 
 	if (args->bo_handle_count != cpu_job_bo_handle_count[cpu_job->job_type]) {
 		drm_dbg(dev, "This CPU job was not submitted with the proper number of BOs.\n");
 		ret = -EINVAL;
+		v3d_job_deallocate((void *)&cpu_job);
 		goto fail;
 	}
 
-- 
2.53.0
