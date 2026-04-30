Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C30CD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 19:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05A8710F425;
	Thu, 30 Apr 2026 19:36:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZcJD5BPM";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF27E10F425
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 19:36:14 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso13091275e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 12:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777577773; x=1778182573; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1+76ABm/WaUtbne2+7yg99KNFhUHJhiFPf1yo1/iOYY=;
 b=ZcJD5BPM56Vc4aSPaQtb5/KYchIOLFZCQCEmLb7ozbfem8dc+Pb0g12Qs6/VyYBKRR
 kzpX3R9MDuL16k56uAl6gLT6Fa6/ZPuXixKPyXx1GVZdUimAZCLyGPXrBF5nksLlTK/l
 Ftuw17Z+799+Hcq7eV4MjDDx53nep+vrwT9DQnUyhwT/acVHQtkOpHNEaIGGVk0R0z+k
 GqNtFzww/aXgEL2/n/AYH/1dBtkXAs4KR6gjgGSyWjlB2DUb4741Gi2SDB/wHJ4FbCxO
 XQ7+L3RXCItGWG8nDWHDq7e5e9JMaQjQo7lWO8Uv5hSz73fQF810mupPVEGxvnkFsvN7
 DQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777577773; x=1778182573;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1+76ABm/WaUtbne2+7yg99KNFhUHJhiFPf1yo1/iOYY=;
 b=C3LYmrjcjLeRG4lre6EoVuZ9BJkoDuStgiL4znmqE3IyQjtNmUkbsAD3B2BFQmytON
 SE4lMt3lfsCzu4dcx7pqfaVQkBtS+0FrY2VkfjKE1Z6XGvm9rX8vpajhuorA8jn8IRrO
 7pPioyfSWwF9YXIYBevJkPqbBbjsFjHpJ5gIHFXneXRtsZbIrPGWmVzOcg4uRzXycZEE
 7vtW+4bMyJIi4+hutAreHJm9GrHi5JyGux+3Zcmle4mLutj2Gjm/kHqxjG/iZyIKFBaZ
 +BuV8JFhRHN1HbZv/Pbntx8ovvGucIqc45hivBDTLOLmODSgZj+Xhm3k4S8c+kjtqq2W
 JrhQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Q3T7sjDbF6/XVyeGHrKFWY3R+aVY+bjQ5jOZeJt6RwSpiJYSq7us4V/wL21ylpZSobmO/frmCRe4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzun4tbGdTKLJxz8+4MepGJ+RpgVbzPFqqjlyT+CKi0V1Wdq3oK
 ekftwBbmWdJQIzddChCydlggdUVQZIiBvryoTiZKlzyxauTCpkXseWDv
X-Gm-Gg: AeBDieubh5cx5wHpHS4QRifvzsMb+KWLBGJ7t9ZyBFUXCZzbvuseK1/5Qeg/dzZa8Mg
 KQNAWJzUGgJ3pdJXn0uo0u28ar5GIr6zXyJf+z3ncmhvUgs+xxOsUzjx3oegamHGbCuckBL2Wqa
 BtAsCzisDWBM8nFcqSWLQ/Rt61u8WNAQiS5yJ7iWt0uLVvbKDmzsQMmIWX/H7aQnpZpOAfmedUX
 XDDP9ueii2UzNPh3myyjTAqI/cq7W3Q4iGHxaFMQpoHFYAmi0IwjQoqKNOmAZGGIky17IkMzTzq
 L4cwFvvR6UyK6UVQ00mNOncwC8gEttWaUOJro23j3fpViEtyEuhKRv8ISdm3QWCuhWuwPKg4UJV
 xN97Pcj/DsIgM7n8L0GrSWh6VEvZIwe/6GLzHpuTiQY0kagVZ+FZcMJT+rbji9RBgZ/E470SkWw
 PA98m5h2GJqzJSKLkGknemZKTykrvTW42P
X-Received: by 2002:a05:600c:354d:b0:488:8b99:54a1 with SMTP id
 5b1f17b1804b1-48a8445e8bcmr71043215e9.28.1777577772997; 
 Thu, 30 Apr 2026 12:36:12 -0700 (PDT)
Received: from localhost ([87.254.0.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb75fe8sm2264485e9.8.2026.04.30.12.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 12:36:12 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nige?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/sched: Fix spelling mistake "sumission" ->
 "submission"
Date: Thu, 30 Apr 2026 20:34:46 +0100
Message-ID: <20260430193446.1062933-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a pr_info message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/scheduler/tests/tests_scheduler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/tests/tests_scheduler.c b/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
index 8b2e4ef9915f..4728e4605818 100644
--- a/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
+++ b/drivers/gpu/drm/scheduler/tests/tests_scheduler.c
@@ -599,7 +599,7 @@ static void drm_sched_scheduler_two_clients_test(struct kunit *test)
 	 *  -  qd: Number of outstanding jobs in the client/entity
 	 */
 
-	pr_info(" [pct] - Job sumission progress\n"
+	pr_info(" [pct] - Job submission progress\n"
 " [cps] - Cycles per second\n"
 "  [qd] - Number of outstanding jobs in the client/entity\n");
 	pr_info("%s:\n\t            pct1 cps1 qd1;  pct2 cps2 qd2\n",
-- 
2.53.0

