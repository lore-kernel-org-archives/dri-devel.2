Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCB5C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 07:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04AC510E53D;
	Sat, 18 Jul 2026 07:13:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rM2c25HA";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5374210E53D
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 07:13:02 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2ced3386430so50166105ad.1
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 00:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784358782; x=1784963582; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LCvurZDj8ZNBgdcw/TmEFw/CVg2NYzhOj6T2ENk19L4=;
 b=rM2c25HAJHLbeCYa1/IEOgCgkFWNURpTMGpHH2hp2YMWg2WLMBBQ4nXpqjB9ryUKb1
 SwH+iiDwGaRu2L7Q63YpjSURymKGIjU3wiNfiE9P/oiL6CPjaf7YZ9iQawCVD5+JKEfv
 UUb40+fioSl5AX2S29o4KUB06OBiCg5XzSuBgaRebVOpyIeED08UlI/WUANkR1stK3Sb
 dLseCY7FVNC7OhkdeCh16Mqde/stFm8kC2su8BFkOat8dFpqdRhaIWsdIrYtBNCj0tLb
 cT1Y8UL5PYIqe88FpDQ/N6sFCnPtd3T/J5Yf/v/gD15kvlyC7SMrfoAM4mzqeQXnw+O1
 ab7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784358782; x=1784963582;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LCvurZDj8ZNBgdcw/TmEFw/CVg2NYzhOj6T2ENk19L4=;
 b=QyCqzQAlfpKey5SekhE9tDZ6BO5HlRueu6639QW6MHv+JBTE6L3mIDQppn47jAeooW
 UDMiZXN4eO62yYUPIF1senj9JrFxqtyRmm2KmXTzx1Zh9F+WwCrV8ve4bGMBSdx40bB8
 TmD8PdbeqvX/DH/jzFpb9imHBM5Q4rI1kHvmdsVycLbULYSJNxnCOeoAYdrYrRqauIlW
 /SUE0+hbxa+FaB1FqhX05hPpwi+W457SPC9LBbVIMNZ5IorixHTS27wapQcg5o82DsuL
 vfLSaJ70s5DtWPlpEpK/1LOcU6Sd28wf65MeXN5B5tARY1q+bGznaWMw1cs13nhIBElw
 QD7g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpDiFO/FUINM618xXmlhwvOr6L0YImITMnUYSrWqo4hrnltgEea8nfSCXuOP4331C9xn6SNz7v9ZYU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwXcSFDnxbU6Vg6IphLNR1Js+rfXwwSsl6WvZ9DJp24gRj2Eggh
 v9WaOqNkYVCfsD+INWJC263o6XvevyWpVP12uETRqTSp5yUMF9Wn9QgI
X-Gm-Gg: AfdE7ck3EtpxlcOUiU8xbFJthG9xPHfPzuv9iE5OQNHwtQFjp9jRk/C0NGG57JkO9W5
 zpv+F5HZpEvr6lXlcFvopnpW2p8FtBQfWtyBcRCyT1OZcDan0tOekB6WfFClZFLCNoAVFr1dIHQ
 DygHbTTh7Fz3k+3So9UohnKl4IYkv76+QrFC/Gf3FAAInr69ZTczzVyYvXwzIBPEwstpptEtZVO
 je9G62Dkv+oSC+lkhl9wN/y6VygqWe4dk6vHe7zmZe8LwfH8HHmpgJucWhSzjXpesjWC49mu4PV
 jA53w3HJ3FvOkFHbiRp9oukpjnBPRsKAx55h/jmANpXjM0P8SKe6y6/4w8xeZuSQBE7Gwa+Ho5/
 1xXv0oM+k/GBABTA+dZKkYwvIrWY61zf8Dro/8kXnGtb77QbLzdbHfADRW7oE
X-Received: by 2002:a17:902:dcd5:b0:2ca:6d87:cda0 with SMTP id
 d9443c01a7336-2cf34804834mr41476345ad.6.1784358781780; 
 Sat, 18 Jul 2026 00:13:01 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf344be458sm23372375ad.25.2026.07.18.00.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 00:13:00 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Melissa Wen <mwen@igalia.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Iago Toral Quiroga <itoral@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH v3] drm/v3d: release CPU job resources on pre-init failures
Date: Sat, 18 Jul 2026 15:10:45 +0800
Message-ID: <20260718071047.3037514-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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
v3:
  - Do not call v3d_cpu_job_free_resources() after v3d_get_extensions()
    fails, since v3d_get_extensions() already handles the cleanup
    internally, as pointed out by Maíra Canal.

v2:
  - Rebase onto drm-misc-fixes.
  - Fold the indirect CSD GEM pre-init failure fix into this patch.
  - Drop unnecessary pointer and count resets after releasing resources,
    as suggested by Maíra Canal.

 drivers/gpu/drm/v3d/v3d_submit.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 7682b24f13ec..77e94c25b2af 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -127,10 +127,8 @@ v3d_render_job_free(struct kref *ref)
 }
 
 static void
-v3d_cpu_job_free(struct kref *ref)
+v3d_cpu_job_free_resources(struct v3d_cpu_job *job)
 {
-	struct v3d_cpu_job *job = container_of(ref, struct v3d_cpu_job,
-					       base.refcount);
 
 	v3d_timestamp_query_info_free(&job->timestamp_query,
 				      job->timestamp_query.count);
@@ -140,7 +138,15 @@ v3d_cpu_job_free(struct kref *ref)
 
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

