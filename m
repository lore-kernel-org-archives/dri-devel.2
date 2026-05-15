Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D60CCD4F25
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 15:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5530010F568;
	Fri, 15 May 2026 15:08:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="lv2M0HpO";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1A4810F562
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 15:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4eRQiSsQaSARhQ/wnfMR14emqxN9Al6eke5GtJ2wtu0=; b=lv2M0HpODTcals3NtvBBlhUoQO
 P+I99DNTUCANkIDRndGgr4vnyzkjePeGnkPywRaN+8r3xkIDZGepP0x1p/vdmwZ0MgUNBxRQu5QB7
 P3vAKU4djehLE73DSWLlrBhhUlMe6ri4VPVFZjtBnnfDKi8TjQlY23U4jD3CMZ7hvRlOJCdBDA/DU
 UF9aRUouvtT2tOgFjUZrro67rpWua2XOeo/pjSaQp2m9C0/JRonYw9SccUIEH1OFKR6h65ON2ygLR
 vY80Zsps40oExmzyGQn/39Cvu1yO1L7ZjpChuY5K5vVfJ7IKNiPExQWEXetNGbLayVveyhsHdsORG
 BuyCou/w==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wNu9L-000ZQ7-44; Fri, 15 May 2026 17:08:27 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Fri, 15 May 2026 12:07:15 -0300
Subject: [PATCH 2/2] drm/v3d: Release indirect CSD GEM reference on CPU job
 free
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260515-v3d-cpu-job-leaks-v1-2-7f147cbbf935@igalia.com>
References: <20260515-v3d-cpu-job-leaks-v1-0-7f147cbbf935@igalia.com>
In-Reply-To: <20260515-v3d-cpu-job-leaks-v1-0-7f147cbbf935@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=2nO2YodR8WFCiuS9cWUEeS13jCHAkn4DqVBFWcxsq2U=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqBzbiT/MWSCnZSUBnl6TsEdm3jgNYRU8WeJkUs
 qo0Ubij1qSJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCagc24gAKCRA/8w6Kdoj6
 qm7PCAC5o7E+mTzVGLqGst+3kQ0w4jFVLghg3rxRCgEz260pvmJJ5fbRW50v/UFhulgPmGo6vNz
 z5I+gtDIjcd2FhrBHhx2B6qExcU/f61gqAiH/hd/EvVyvf/r5dDQh5cmPZt/1F4vEFcSRQYHpS2
 k75BIxo4JyavDBvzJD4BZSL7S+8qyQVOvCxbLWClhp2FxsuG2EFThLqCQ6RGeG8GFnQtHxlrsCH
 CD40A2AUApFk7fRuviOVqUVvri9CO5H9+6HpfZqqn6fgIQjXsUZ/738gJEiiNBefHJJXcFRRYxG
 Cav8xCl1tl+ww44JzZ4NPOlrgPM06Odf0PXV6WQwHnS3tPzy
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

v3d_get_cpu_indirect_csd_params() takes a reference to the indirect BO via
drm_gem_object_lookup() and stashes it in cpu_job->indirect_csd.indirect,
but nothing on the CPU job teardown path ever drops that reference.

Drop the extra reference in v3d_cpu_job_free(). The NULL check covers ioctl
errors before the lookup ran and CPU job types other than
V3D_CPU_JOB_TYPE_INDIRECT_CSD, which leave the field zero-initialised.

Fixes: 18b8413b25b7 ("drm/v3d: Create a CPU job extension for a indirect CSD job")
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index e3a6e7cc7bd5..3ddd53b6f437 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -135,6 +135,9 @@ v3d_cpu_job_free(struct kref *ref)
 	v3d_performance_query_info_free(&job->performance_query,
 					job->performance_query.count);
 
+	if (job->indirect_csd.indirect)
+		drm_gem_object_put(job->indirect_csd.indirect);
+
 	v3d_job_free(ref);
 }
 

-- 
2.54.0

