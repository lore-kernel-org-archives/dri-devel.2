Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CC9CD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 11:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6439310EFF4;
	Tue,  2 Jun 2026 11:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="HI5eQC8U";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37DCF10EFF3
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 11:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+TdZ6wgntN0ET3unbfiP01cv5Eyt2WdGwjMV+mmhb2I=; b=HI5eQC8UhEvPRlfwGix5bZDZUx
 FrDc/DARZhzX+gWg1ggGPAdpf1LvmI0YJF0yjBiWkFClscHxTL8UGyNCRxhgx84adblnCTfWAxGS7
 hrxJ6UjvYT8xN+vOOmmIDGdOfyEQP7/JCocZkvbzdNm+SzKJEyagR1K4uyPWdjzL7AY2CTWPG2peE
 Jce5lFUMmcK3ROYADDZTsRJJmkiaEsmq78toPPlA6BzyQwTyn8lrcRZOFeqXleRTZtcAtCK6x8EC6
 v2kTvwc9miNL01g4bWDx+UNdu2u2Er/C9XcUprFBBfRKDL43ZYkTq78Tc3lgzIYjFNEcuOemt8aRE
 VMK0sMrA==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wUNkB-00BgWO-TG; Tue, 02 Jun 2026 13:57:16 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Tue, 02 Jun 2026 08:57:06 -0300
Subject: [PATCH v3 1/2] drm/v3d: Fix vaddr leak when indirect CSD has
 zeroed workgroups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260602-v3d-fix-indirect-csd-v3-1-cc79e06e543c@igalia.com>
References: <20260602-v3d-fix-indirect-csd-v3-0-cc79e06e543c@igalia.com>
In-Reply-To: <20260602-v3d-fix-indirect-csd-v3-0-cc79e06e543c@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1568; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=RRma3Zd6UFVlvFhfVDjOAZoDItATMSqZ9aSBrB0Hd+I=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqHsUW8Ntm/Z5+0E90bDqs5eaRckfcVW/38XTSF
 G7xR650tn6JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCah7FFgAKCRA/8w6Kdoj6
 qhLqCADSS0qJ23/bIpEhoZ0IBjmiO9wMlWM+I3jWXu4aWxRpZXkSHQHWDPfxJB2ZlIUtF1L54Af
 zCCCPG+KzvoijVXslnpR71Oc8XmLx1dFW1w5gm2nF6R/sFhbaNMgdi3eOMOY/v2OVtzr53dIZc1
 Gq4Om8F22WKo+8JCjZng5mRNFDHkFrtENz23R7eW7RDvjaqfK7z8T5gF74X/gOs7XLjqoGqWndY
 AGeySfxacrzQIADg5xwK2FxoympsFvkJOJVQrS9J53ovACOuk4V6wJzbX0Con/UMM/TfILx0Ky3
 ghywFj6yWrAw69hR6hcdOGK4R99U8oa9aQiyif7FwaDxg9bs
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

v3d_rewrite_csd_job_wg_counts_from_indirect() maps both the indirect
buffer and the workgroup buffer and is expected to release them before
returning. When any of the workgroup counts read from the buffer is zero,
the function bailed out early and skipped the cleanup, leaking the vaddr
mappings of both BOs.

Jump to the cleanup path instead of returning directly, so the mappings
are always dropped.

Cc: stable@vger.kernel.org
Fixes: 18b8413b25b7 ("drm/v3d: Create a CPU job extension for a indirect CSD job")
Suggested-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 94bf628dc91c..47f83936cd73 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -403,7 +403,7 @@ v3d_rewrite_csd_job_wg_counts_from_indirect(struct v3d_cpu_job *job)
 	wg_counts = (uint32_t *)(bo->vaddr + indirect_csd->offset);
 
 	if (wg_counts[0] == 0 || wg_counts[1] == 0 || wg_counts[2] == 0)
-		return;
+		goto unmap_bo;
 
 	args->cfg[0] = wg_counts[0] << V3D_CSD_CFG012_WG_COUNT_SHIFT;
 	args->cfg[1] = wg_counts[1] << V3D_CSD_CFG012_WG_COUNT_SHIFT;
@@ -428,6 +428,7 @@ v3d_rewrite_csd_job_wg_counts_from_indirect(struct v3d_cpu_job *job)
 		}
 	}
 
+unmap_bo:
 	v3d_put_bo_vaddr(indirect);
 	v3d_put_bo_vaddr(bo);
 }

-- 
2.54.0

