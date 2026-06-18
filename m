Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92113CD98F6
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D843410EBEC;
	Thu, 18 Jun 2026 15:03:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ET4GoHmU";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8389B10EBEC
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 15:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+h6pmhsWEGu+q6s7t6G1H4y0bLKWyjDDr3vj6XsdbFs=; b=ET4GoHmUYEjy/CPy3em4rGCb0l
 mliiDWSAS/jUBYtwXtaBG/yEQOqhbTtI4jPK0NGEhc9/Lz5t0+xwVaCjkMu8z2I29Ts/VMvPyONsb
 UiNt5EI3qfq2mW2o2fgzkOCb0gc83ietEY0+Q2sctxY3y9w9huDzO12qRQC3MZxfXdwVUDd+lqS0V
 +bwtF5Fctasb1FxnVX3lUCpO0ZVd2KqzSnd/uvc4jUblHi1ojsQTB3m5w3ZvgIGU0dbbdNzqQMKmG
 TUha8xBNldC+7gEDyfGfFc9K9YdDXXok23Gd2XWPzATAKD5EijhDrOpOKom4h/qy8N16HPzGOEn2F
 y2sgHvOQ==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1waEHB-001vhd-I7; Thu, 18 Jun 2026 17:03:29 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Thu, 18 Jun 2026 12:03:15 -0300
Subject: [PATCH v2 3/3] drm/v3d: Use write_to_buffer() helper in
 performance query copy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260618-v3d-cpu-job-fixes-v2-3-fec132484fc4@igalia.com>
References: <20260618-v3d-cpu-job-fixes-v2-0-fec132484fc4@igalia.com>
In-Reply-To: <20260618-v3d-cpu-job-fixes-v2-0-fec132484fc4@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=3LwmLLnQGOzCY5kbwVnNGhP9bH3SBonITtSLA+zMINA=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqNAi2OSUIPCAcpnk2PE3iLmBxTCDuA5F/yJn3n
 xpuG9No2AeJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCajQItgAKCRA/8w6Kdoj6
 qvXPB/oCa1aXPuHtJWBC08M5M5RGAu6V2fPbIBLY+xtDh8PQSwdQ2hfs4epF6LR5zvj7UsgIUwP
 rrhJ0xVfvDbcguMOufdSDKa5YzpG3tpGcMu6o9X8le4lQ2HUJl1yeE1Fe8X7OSgrCvjMXFW3TZx
 4xgWXwN53/UdyDG6JX1PJfOuU8+Shsvif9JgmDrFBfipNAqxFxeUBliCYPDaXG7SQ9UgBUMTTNC
 3MydVUUbss8itiV26NUMmNXcHWaj/XlYp6AFYRO8Z3HV5/695al93uUBYMlyO3ksXgICx00tbRk
 H0EoYQl11cYMi11bacVrPd0Ki8GwN1QKP4zYjG/3CTVCbH7v
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
index 53deae1a2eda..17751c8d7f16 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -594,15 +594,8 @@ v3d_write_performance_query_result(struct v3d_cpu_job *job, void *data,
 
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

