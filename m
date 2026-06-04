Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2213CCD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:33:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D1DD10F67C;
	Thu,  4 Jun 2026 20:33:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="XdOMRo5j";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6001710F5F1
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h1fXp1epbOk6/tSSAqjEDQtGXAHevzL8TN5DHenggx4=; b=XdOMRo5jB1nxzXA0AU9uJsAmCb
 3QgrX5XtMfD1ZpGXqXuCo8L7E55A+g9k/Z2o8DKUp5kfk6s+6y7K/JBiqn0o8BRUZvk0nWDMrgO/h
 sXCaplCjN38jGqOgDGU4P0GY4hjAuGUGR90X0LLkDHUAyBnkCE5UTHpng70/b2BBOie0PY9nxiTqh
 +WysRQkc9ifQQBRR7RskaFN1POWHZxSBfn9JEOZ9+6EUB7TuLY02QCLH7uDUOvrBLFU05r/vkvVWm
 V/Cqmmexacsyj5cyDVn+npeMoBkwN1IWp0b9KUU8mqC2qZOlijwgz7maoMDShCgkcsYlIfhaDbAcc
 C9S4d3LA==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wVEkJ-00CoGD-7t; Thu, 04 Jun 2026 22:32:55 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Thu, 04 Jun 2026 17:32:20 -0300
Subject: [PATCH v4 07/12] drm/v3d: Make v3d_get_cpu_indirect_csd_params() a
 pure parser
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-v3d-sched-misc-fixes-v4-7-c068f5bf5ccf@igalia.com>
References: <20260604-v3d-sched-misc-fixes-v4-0-c068f5bf5ccf@igalia.com>
In-Reply-To: <20260604-v3d-sched-misc-fixes-v4-0-c068f5bf5ccf@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3020; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=HtWiyKmsFk3zNCmmrCa/QDwGv/Epc37uIbJLd00LIlI=;
 b=owGbwMvMwMVo/5mvq6zj1yrG02pJDFmKD67EiW9salO+8sPalantB3fjJAm9S6f2nA11u6vA4
 972l/ViJ6MxCwMjF4OsmCLLjyextYxi5eyay8ovwgxiZQKZwsDFKQATuV7A/j/jy6+yifuL0iZn
 CwhuY4+tUslrMdzf/mub/s1DpwKXfPq+dSvbisplc4NDdcs0ONmWlnP+XssQLNivMG1em+WH+Hc
 T29flMXvXTNBR62nWc2vl0bi4YbeAGE9UtV7BftZgbWkuydx311gZ2+bnHSt/o9LZm1A1PdD5Of
 PpYs3TyxRzP151C/B4k+USmpWme/LA2fQyebUF/oG3nYw7m0JqZir5r1Fcf/3JAqY4ycB9RpMSN
 iwUzsvfkL7w2rwZWcXLvxzoF+JuN5v4Vf3uOjaxWSufrZTV4AzYxvcvMST0H6uaOo9I4Ly7fa9l
 Z/6RDZqi6ZCne6ZoLm+10ePVl+JtVV6fPnTqwK3G3CXbAQ==
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

v3d_get_cpu_indirect_csd_params() currently does double duty: it parses
the indirect CSD extension and, while still inside the extension parser,
also creates the CSD/clean jobs and locks their BOs through a separate
DRM exec context. This nested submission deviates from the standard flow
and makes it hard to fold the indirect CSD path into the unified submit
chain.

Stash the parsed drm_v3d_submit_csd args in struct v3d_indirect_csd_info
and have the parser only fill in the parameters. Then, move job creation
(v3d_setup_csd_jobs_and_bos()) into v3d_submit_cpu_ioctl(), where is the
proper place to create jobs.

No functional change, but prepares to move the CPU ioctl into the
unified submission chain.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h    |  5 +++++
 drivers/gpu/drm/v3d/v3d_submit.c | 16 +++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index fae0c53e7aa3..52ed0af67f5e 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -428,6 +428,11 @@ struct v3d_indirect_csd_info {
 	/* Clean cache job associated to the Indirect CSD job */
 	struct v3d_job *clean_job;
 
+	/* Indirect CSD args, stashed by the extension parser and later used
+	 * to create the CSD job from them.
+	 */
+	struct drm_v3d_submit_csd args;
+
 	/* Offset within the BO where the workgroup counts are stored */
 	u32 offset;
 
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index ded7963370a2..40a45e04f81d 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -632,6 +632,7 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
 	}
 
 	job->job_type = V3D_CPU_JOB_TYPE_INDIRECT_CSD;
+	info->args = indirect_csd.submit;
 	info->offset = indirect_csd.offset;
 	info->wg_size = indirect_csd.wg_size;
 	memcpy(&info->wg_uniform_offsets, &indirect_csd.wg_uniform_offsets,
@@ -639,9 +640,7 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
 
 	info->indirect = drm_gem_object_lookup(file_priv, indirect_csd.indirect);
 
-	return v3d_setup_csd_jobs_and_bos(file_priv, v3d, &indirect_csd.submit,
-					  &info->job, &info->clean_job,
-					  NULL, &info->exec);
+	return 0;
 }
 
 /* Get data for the query timestamp job submission. */
@@ -1404,6 +1403,17 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 		goto fail;
 	}
 
+	if (cpu_job->job_type == V3D_CPU_JOB_TYPE_INDIRECT_CSD) {
+		ret = v3d_setup_csd_jobs_and_bos(file_priv, v3d,
+						 &cpu_job->indirect_csd.args,
+						 &cpu_job->indirect_csd.job,
+						 &cpu_job->indirect_csd.clean_job,
+						 NULL,
+						 &cpu_job->indirect_csd.exec);
+		if (ret)
+			goto fail;
+	}
+
 	clean_job = cpu_job->indirect_csd.clean_job;
 	csd_job = cpu_job->indirect_csd.job;
 

-- 
2.54.0

