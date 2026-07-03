Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02ECC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 15:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0884310E623;
	Fri,  3 Jul 2026 15:33:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="jdaKnI5U";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6178B10E623
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 15:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ztJhDjITkKjKRoG+pub4QojdvAJhF5FGmqd5ZxEIFuA=; b=jdaKnI5UctxePv/RWdONLkp7OQ
 6ZDn23yMJL/PnKFLFlH2ADMSabw6S7Uq1TWsuFi6oky7LlNfLsYwpNJJa+L08tHn0XkKnZP8WR/y1
 ahDYIMvwdx9JvPGtnL8Bnc9cTvRjUB78ZP0I32ZIgAKQRd5GDlVSLL14ttYZXyaI89BEmy4dvjaDP
 Kr9GWL1ycDCOeA9L5lHKuBV51pPFqV/09MUT5aWb95dLGNAs5E7LtoYcuOR9VW+HNen+oRtl2T8zT
 AG+0IA0cfuRG664nGwAfr1FXznS9UD61H0BxomzMuF6qgmPIV5Bv8jrYSxyVgCjG3y0z0xSKpVk+u
 y6vJngvA==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wfftn-008Xuq-II; Fri, 03 Jul 2026 17:33:51 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Fri, 03 Jul 2026 12:33:36 -0300
Subject: [PATCH v3 3/3] drm/v3d: Use write_to_buffer() helper in
 performance query copy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260703-v3d-cpu-job-fixes-v3-3-bc51b1f3eeb5@igalia.com>
References: <20260703-v3d-cpu-job-fixes-v3-0-bc51b1f3eeb5@igalia.com>
In-Reply-To: <20260703-v3d-cpu-job-fixes-v3-0-bc51b1f3eeb5@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=dX6Ptub7yr8/1qk4TXUlLWhUWo2WIEO8wCkzsF0lCiM=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqR9ZUUkwx07GPWxKQ3q92CfVWiamoDazCYVk2L
 fimEe03yTSJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCakfWVAAKCRA/8w6Kdoj6
 qrUwCAC4NCi56xuqwoDDEiyGCKFxh0gKmg6KcZreLaSeh5t2467E44OydhFfzswsgeKsfBhAl2x
 7wnW0cU1UjG09bOXc/zAFgSq3xy022Ct1aVit8zpYCdHtcvIHFRmm57i3wwE1kcsU4kbFsYlSvT
 H+OpRoiHHoNWyUyGNH/0L4euktl1ghL6kCcyVQL4n7iWSFElZ835IwSApvtLB6SxTrAz/vVB5Hx
 2IzscUtWtunCU0PFl307fayDNOw1wCULn2WWizAsTGIp5G22LzoZPZAImUUoImjMcKwcE2ioKOZ
 JM2y3e0a519Ph9jqqop/1AhEFDdJyNyujKHbcuOsEtaJmIL3
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

The copy of performance query results to the output buffer open-codes
the 32-bit/64-bit selection with two nearly identical loops. As the
write_to_buffer() helper already encapsulates the do_64bit decision,
use it instead of open-coding it.

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index e950cee31bcb..21ab9cd83685 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -605,15 +605,8 @@ v3d_write_performance_query_result(struct v3d_cpu_job *job, void *data,
 
 		v3d_perfmon_stop(v3d, perfmon, true);
 
-		if (job->copy.do_64bit) {
-			for (j = 0; j < perfmon->ncounters; j++)
-				write_to_buffer_64(data, offset + j,
-						   perfmon->values[j]);
-		} else {
-			for (j = 0; j < perfmon->ncounters; j++)
-				write_to_buffer_32(data, offset + j,
-						   perfmon->values[j]);
-		}
+		for (j = 0; j < perfmon->ncounters; j++)
+			write_to_buffer(data, offset + j, job->copy.do_64bit, perfmon->values[j]);
 
 		v3d_perfmon_put(perfmon);
 	}

-- 
2.54.0

