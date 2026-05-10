Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FE9CD3427
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 22:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FF2910E445;
	Sun, 10 May 2026 22:12:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="o3Un+D41";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B31A910E445
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 22:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T7qeVcFayb6rYo13PNNQpSmFf8uOunOZravPjY/BU+U=; b=o3Un+D41XFNRuzescfG/ZzQ1Vx
 eJpHpljUInLosPmpfiROBFmcXxT4uiBlelXwIAZbELSvsok0EmcoaJLFJmCqKhmRWg6+d3zGnEKcD
 6go7HOcaDuSbG6VKqipUFvbMTG90fSPTHu7gjPzRtHHTI6rfN6LGlMCOTKlwGoT+CMRfc+tDthpxN
 a3KeKXGgdv7UIB97EQ6ZUdI3HjRKKKzLRBR/36QM/WlBWxIBLQmXuZ7MAxJ8y3VNrdzhm1wAeQrss
 WtISb45nDVrFdIJR1810ou6HH1MBzTzOldox/I4y2knSW44TeOXKkLrfu6jb25lkaFH7IS8iyA2Vx
 +NQAsurw==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wMCOJ-008k1J-2W; Mon, 11 May 2026 00:12:50 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 10 May 2026 19:12:06 -0300
Subject: [PATCH v2 09/14] drm/v3d: Make v3d_get_cpu_indirect_csd_params() a
 pure parser
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-v3d-sched-misc-fixes-v2-9-ca4aba343ef6@igalia.com>
References: <20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com>
In-Reply-To: <20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2963; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=mp10yDEMxSPRPAMfVa2I7xJ3EJXWbmQnkE9lE/O/TVc=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqAQK072W7jSoAVtTS3nbM062j8MYfSxiKSLFEV
 n/bBmZ1C5WJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCagECtAAKCRA/8w6Kdoj6
 quDlCAC2whPOaKh9AZXFSPyyt/CUtVYHekW0n0RRLLkBR5JSGnYZca2i4MnAIgiVkQyAyTgTKJm
 xWRECm9zEtA21oNaAWqkZHOZNYIGBNkWORwPO5xfDJt2l3GKO6roJsQ4C3ltgrHG6lgsdZTqRmR
 pjD6qMErCRmC9uOgvQlr54Vyp25cVQqrgjL3HFyFv+N0QS0RLGXg4VpoOPl+bMIO93M1EPAtaAG
 c2XVuFBhs/MkoIaat6cXMD7UweUdram7oTPgNhDm4pBGZZv9pSK8YDyLsXyONO+X5jdQ2vHpU+F
 X64JQWPormYgQxdOWekJmv16LXDCfCFWWiFeIP9OiycVkVff
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

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h    |  5 +++++
 drivers/gpu/drm/v3d/v3d_submit.c | 16 +++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index fc12e5215fb0..ec01668bacb6 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -425,6 +425,11 @@ struct v3d_indirect_csd_info {
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
index c51474403d2d..ef003ca6b42a 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -600,6 +600,7 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
 	}
 
 	job->job_type = V3D_CPU_JOB_TYPE_INDIRECT_CSD;
+	info->args = indirect_csd.submit;
 	info->offset = indirect_csd.offset;
 	info->wg_size = indirect_csd.wg_size;
 	memcpy(&info->wg_uniform_offsets, &indirect_csd.wg_uniform_offsets,
@@ -607,9 +608,7 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
 
 	info->indirect = drm_gem_object_lookup(file_priv, indirect_csd.indirect);
 
-	return v3d_setup_csd_jobs_and_bos(file_priv, v3d, &indirect_csd.submit,
-					  &info->job, &info->clean_job,
-					  NULL, &info->exec);
+	return 0;
 }
 
 /* Get data for the query timestamp job submission. */
@@ -1370,6 +1369,17 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
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

