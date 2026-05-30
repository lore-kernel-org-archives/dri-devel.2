Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41943CD6E49
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 19:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A599111299A;
	Sat, 30 May 2026 19:51:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="TvYThmxg";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6A3D11299A
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 19:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=drIE03WxnvuBWwmjQgqCTITEr7QPi+8WtF/vwrBmG7Y=; b=TvYThmxgAhKr2ZtnmPr439YGYc
 2XP3tbqJmX86L6QcVBMVL8n6iT274b2WXxOOMeflJmtLoAvRlEiIhl35s2aKkSrViFic4nnUreCEc
 q9bg8HHqJWPI1RjR0Z6IBKycF2oclNABeGjLPrYR6dszlQYvsHwStGgBJ8UIgZyAcqaKjLfMKWEcs
 jd+WcmOb4newmRfdnHO2a1TniQmszKFpq1EWpAif/SGJbjLyXUxeDZuoAzbkfNqrDD68e+bLsjg9J
 bBvE+0Sy3UTY5znoCO24UvLp+z/IpII7hIJNNoFeHj4n9Zy42dc5UhBKjC0/gRnKq2+nZBeQ9WOuh
 8SOc0mBA==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wTPiV-00AMOG-TD; Sat, 30 May 2026 21:51:32 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sat, 30 May 2026 16:51:19 -0300
Subject: [PATCH 2/2] drm/v3d: Skip CSD when it has zeroed workgroups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260530-v3d-fix-indirect-csd-v1-2-15533948663f@igalia.com>
References: <20260530-v3d-fix-indirect-csd-v1-0-15533948663f@igalia.com>
In-Reply-To: <20260530-v3d-fix-indirect-csd-v1-0-15533948663f@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=zz4yKtIHiFbQtzHhRtVH3Ox6Ch3mFjD9O51wlHTO2EQ=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqGz+7kNkIbRto43ZxsAC7n/lHZOKriy0HSvcnJ
 J7Unqk3sHuJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCahs/uwAKCRA/8w6Kdoj6
 qghvB/wMYOL7CyUR7chDG2i3hBym3o8mfhSRKmtdVnc6D/Nje9nViuBvWJK+t7zhl2MJ/CLbSwM
 cS/YnzAk0pK80G1qL4KhcknDc3+4HCPxBTSXdmepaS8En5QgllmAgOEbkgsNASMC0wS2vrXBHej
 PoTStJq7/Nb+Tlo9sVDrLDGV+pBpE4q05uHMV47/1nmcqRemVxpIcGy+gyScgXcgD+xmZRjeo0D
 KDVKLTJuV+ICMdOdnC5+3ZvNX3AFs8H1Uikw/KhfqkNc0bCIlOZI+Z3eKRSLzkKpwwkUzRuca+h
 FpzEFY0rHTWIB7uLtXe3zivKsIXxbV4SHqP642WEHS2Xb4ae
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

A compute shader dispatch encodes its workgroup counts in the CFG0..CFG2
registers. Kicking off a dispatch with a zero count in any of the three
dimensions is invalid. First, the hardware will process 0 as 65536,
causing an illegitimate submission. But over that, a submission with a
zeroed workgroup dimension should be a no-op.

These zeroed counts can reach the dispatch path through an indirect CSD
job, whose workgroup counts are only known once the indirect buffer is
read and may legitimately be zero, but such scenario should only result in
a no-op.

Don't submit the job to the hardware when any of the workgroup counts is
zero, so the job completes immediately instead of running the shader.

Cc: stable@vger.kernel.org
Fixes: d223f98f0209 ("drm/v3d: Add support for compute shader dispatch.")
Suggested-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 47f83936cd73..5476fcf43793 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -352,6 +352,9 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
 		return NULL;
 	}
 
+	if (!job->args.cfg[0] || !job->args.cfg[1] || !job->args.cfg[2])
+		return NULL;
+
 	v3d->queue[V3D_CSD].active_job = &job->base;
 
 	v3d_invalidate_caches(v3d);

-- 
2.54.0

