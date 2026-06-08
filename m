Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D054CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6BE110F7C4;
	Mon,  8 Jun 2026 17:24:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RoFfcp9T";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BC0710F7C4
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 17:24:47 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-490c1915793so29352355e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 10:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780939486; x=1781544286; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W67x2+0CmcWfiVmczD4VTNNBq42SHz8YTBavihCtORQ=;
 b=RoFfcp9TIFRAbWOw/mkMuyRk4B3SatNcLZiBW5X21+yYxsmTnh/YylI1sRhXOFZ9XD
 8GSizuUFP6qxvzXqCj+VAzPhri+4WP0C9i7LvhmUEcZk913TgP490uzpy4tpYOYR6ZYk
 aUwSSsgyxHM2TgCoLcNFXYLyQlxcnRo55oO20RQqksVzaEJTiorXPYW5RGneVwr8hQtp
 bjTw8PUWbcRoq9Lvmwuty3BMYk1L257OEGKa5otsXi5+aTupb/sFyTDXGxz49mG7ZzPk
 +pgylgLc+9ZCo3XvJcCxnl/UTb0Jm6GjgHmhdreeDELkofV4dkY5Oh8S/slslNScGicV
 Td0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780939486; x=1781544286;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W67x2+0CmcWfiVmczD4VTNNBq42SHz8YTBavihCtORQ=;
 b=qwFHo/BZeNhDOfOMxEooLMlP0StqTIIiU628PKAHSc+GoJsGdsJIv9iRDaNH2dDW4g
 jUquMGAKbwyDtjRaXZ75fDvv80vSKKp3dkInJWsiYRoucb9MHBpwlHsYv6wFjt5m5Dgl
 OVqzklGAMADMHIfKekwM6GIDVJE5jEVH60E3hs9EqrIjyxhkfRtUWEzrBE1CYoPE/Lup
 KRm6x0Yi0Jhvwimtx1NbZlloujp2kp630YyzTBfVeetKdTyZWnbkP5uEyW7ys1XV9qrt
 tIgzoGFvbUrhwwRD4KUh3OsODFysN326Sq7QLfL2OB6x/sqDz15skW3r3mHJEXjnXT+Q
 Zvrg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9PTaaS8f6+94IBRxWZGiO9nGBVztTDpqWRG/8Ocrsjpklx/6or/o9S0RT3KJXxJFaM/WvD2A8gygY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwnVARmW3/3wfNm1OQtjtLNHVSJ6bu/w1ipCLTTxA5INEp4rP51
 rMBGmqMi3xe0dn1WwpVur76zd+lvZKualGZ3mg7l87a8WpseAW7fuzmq
X-Gm-Gg: Acq92OHQKPjRdcHvo8r41OvDqLq2zQl/5P8PUZeiFdx/AZqRlONYm/00Mjf5YsCegKF
 gIJnEag7l2mnNCn65FPKMs+04wVgzxBjD3J3wclwVj2ay7qc495z38g8yxGfN+S0um6ee5ZBlf7
 8zLFH5g0iCZKoBrXI4+II2oPjti3RD4YPX8+L3HurRWl9p/r6LSpdvF2LPjvy3bn5QZlifQfKOm
 Nv1fLO/qPtJa+w8IzaKnzZVoAv2qa1RUM306yZnZWwN7o2nzMSh2VOeX1Tmc5/2Vdjvfp58jFjT
 Fdz8sL+g1u7ZEWCngISFEo+qlNCV/Iq0rTP93H8SnRw4mX1H8UBspMuiKLC+cTKw66sYKdvAMCF
 Ox21MMEjvk3ekjdP/bysqfIDsKv+Sl3NSQ2OOpqDE6AMpMqAwwQCF59VhHGR/WoQWYF1OB7QF3n
 qE7dhJEdtKBbTc5cNOHNLNj7chNqTOLqGZLNlPWJUW36I=
X-Received: by 2002:a05:600c:c4a7:b0:490:b58a:dcc1 with SMTP id
 5b1f17b1804b1-490c262183cmr263479625e9.29.1780939485695; 
 Mon, 08 Jun 2026 10:24:45 -0700 (PDT)
Received: from localhost ([87.254.0.141]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4602cda363bsm41890020f8f.31.2026.06.08.10.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 10:24:45 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/sched: Fix spelling mistake "sumission" ->
 "submission"
Date: Mon,  8 Jun 2026 18:23:15 +0100
Message-ID: <20260608172315.34626-1-colin.i.king@gmail.com>
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
index 90d31888cf92..285546a2218f 100644
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

