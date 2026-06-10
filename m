Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF2DCD98C7
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 22:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 503B110EC02;
	Wed, 10 Jun 2026 22:51:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="O+jpXZim";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF77010EC0B
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 22:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EISVHFFgIuccdZ28R3wrcitK3cG5RBhXVy2buxZsbLU=; b=O+jpXZim7L1hxIBSoSTKaH/zya
 RAWe1i9FaQc8gyuDg9y8XYEL380blLNpcqgRS3nvDYdEFF8nvxZKV1oEdb+Kx4nd5AEsufR502Mcq
 bXR8T+r4ymeOllgNS6B2RYu1ewmXMI5gNgXL/RUD+oKREdlYy5TLEhSaB5kPZvA/En1kPp6u3xt1N
 4tMEus3MOpatNgnkHyeAffJrM4f3FSzEKdN5LyHkXMUXHvURaeqUBMhBKAW+YZX6GwLdu7Jh+kcEd
 OR+bPrSjFj3wz628T/b3gxFWA0D6Td4RmwaVsg3QQ0SMnud2ufOCYiAB81ja22e0DEmgfCdr0Lus4
 kUGoZd2g==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wXRlV-00FrrZ-Uy; Thu, 11 Jun 2026 00:51:18 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Wed, 10 Jun 2026 19:51:01 -0300
Subject: [PATCH 3/3] drm/v3d: Use write_to_buffer() helper in performance
 query copy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-v3d-cpu-job-fixes-v1-3-0d9c88989edc@igalia.com>
References: <20260610-v3d-cpu-job-fixes-v1-0-0d9c88989edc@igalia.com>
In-Reply-To: <20260610-v3d-cpu-job-fixes-v1-0-0d9c88989edc@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=JIHYJ0yn03HbkLTTTVaDypE7s6zhM2tBXSmlHRyj+DA=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqKepaIpJRknds64JteWyyrpJFp2exE5oXj+6LM
 6OSeybASCiJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCainqWgAKCRA/8w6Kdoj6
 qonrCAC+D6VzXP/0L3CS2ospkh/00ki+SkkTyqSKlU7oAV9QyOZnaz6vLOWXLLWjxo+i/lqcnHd
 lLjSFd2HQvThOXkVw5k8aHZpQtW6zS4OWc7e2b86GvdltYUUsLBmag5t4T2Nl29Lom8O5m0ny3g
 H+y6uKZ5SRi0qtZvqNwRDsmLrddDFne6mIDMJ3WZyqyyoSluqhYpOUy+k4rxrnyL5b27oZppc3X
 BkPeJOtxvcEdJ1P6h2KuYR0+SEch5xnZiKSj6XjcuBjBy4fpKiJ79wiuju7JDoG23QQvKN8LpUV
 ihqxr0owEk9s4MVZlePFX6HpMPXYWkIFuoaOFyzED6ZXqRH/
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

