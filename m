Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1FDC88E69
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 04:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7D4F10E10F;
	Mon, 14 Sep 2026 04:57:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LlJqaczd";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA7510E10F
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 04:57:09 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d747ed1368so14286565ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789361829; x=1789966629; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VTOIvrzOT5wsDFmFOxury6RlxqMzV8uVFfNJe4lJIAA=;
 b=LlJqaczdQjyMTus2vXEycd2xGXi2EBSha8GkbYdo7OlEfwQPxQo0dpI4m/5lHIkGUC
 FE+oSoduQX9o5oTKJx2m38OR5swHAA6Hz83+d/4pQYrfZxK4sqe5N18VeYVYV0rC0ANB
 i309RRPcPtr645ZCq/bmT05XDdq/t7CV4GdO2jIazLz93R/QS3PisP/yUaJtAX5/vGIt
 Ckw71+7IaHPfmCEYkLCgg1IqPnXhJ8Pgm3H8tkxtOM3QkPRNMca5aVJ7g6a7d6SR5BPm
 KS07sUbVkN5IXzGF44Ps5DpNm3xvc3PCIQ1hjeYUHnb8s+BDDWBYG7f0ViT2ZSMk4JEW
 dsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789361829; x=1789966629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VTOIvrzOT5wsDFmFOxury6RlxqMzV8uVFfNJe4lJIAA=;
 b=KVPsz5k+iobBTqfQEhYW2Wex6lohRkavR+5onDaXwki/Kr06Y1//S1UI20iD5dxzkM
 XFHBXhi9KeP0M4fOhO5QmWmDvbNU6zHfJbqUNsZHmMiL/GwJMQqZEuoo3xjvmqJSIfbd
 ZbAkeIFhebtCvUEouGpveuVEfeMFFI8kCr0iqVpti0aJ9O71PDxEIeWNG0zrt9VYABvW
 Oc4fCoWMSQtLpMYvK/1iQYsX0SJ4UFypjjbdzQF2t8NP9dl2obpUHPDfIFRflOulMqd2
 U/pnxF8fU2XttFe8aZsvob3BqUWotFAWcGfJ2NMxD52zJBaiLbw9mk7r9603GhQMXoHU
 L12A==
X-Gm-Message-State: AFuF++kJPfUKscLbUqHFr0a4dqGKULdCCTHUPBzRGnNYd2lL63gVks6T
 t4NmbAsVeSM2oRwDGILU/4rLbDMXC9/r6aTrEzivIY46yLrovTbYPjo=
X-Gm-Gg: AYBFou0F04o82+42PAkDXW9bAJmibFF5XFx7sam847s+AD7Hw78AHHbWAqtQlGstu8n
 nArgasTNoWDVssfKdoXQZokBBclPBnyyk9ihS+kSaK7le7vksRocqS6angL5ldkvH8lkq/m9qZT
 5kiI+tb0NxhtjMB5iZKzclpdDIv/ARJbejbIPMcevMAkBwp9bM5XDLDx69vkYyuj4lngkW2q1dM
 Mq1+6AfGjktUdB8nAYXvYqpPTZEpkve4/RlaQ1jop4KWnAWimz765lkM8WDINeOEv+Kmweaq7l9
 C6+RA4R/VV43+RsPph+FanFH1W+ujLmA5IyB7EHPKvxFAiVmj/RVZLiy45qxLs01sRkt3ojp6uL
 xXbcMy1H8M9pmuqEVPeQ+LvHzqAH4EtwJwTzb3llAO1Z5dMQGQxtMGHjcYSkuaqkosmdOrGbBnL
 0BEybl5hFG7SYdkc//nrKlsASwMyD+XmdbAAZ1BMNWYRp1Uc6QCJ/Ns3w7ucAwkS2VjCZx9szDj
 tA5P4KADcrm
X-Received: by 2002:a17:90b:1f86:b0:398:bee5:61d6 with SMTP id
 98e67ed59e1d1-39dec0f9ff3mr2422921a91.24.1789361828915; 
 Sun, 13 Sep 2026 21:57:08 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d994872e0sm18824792a91.8.2026.09.13.21.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 21:57:08 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: sidong.yang@furiosa.ai,
	royalnet026@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ogabbay@kernel.org, tomeu@tomeuvizoso.net, triet.hoang.dev@gmail.com
Subject: [PATCH v6 1/2] accel/rocket: Check allocations before use
Date: Mon, 14 Sep 2026 11:56:04 +0700
Message-ID: <20260914045605.381933-2-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914045605.381933-1-triet.hoang.dev@gmail.com>
References: <20260914045605.381933-1-triet.hoang.dev@gmail.com>
MIME-Version: 1.0
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

Check the result of kmalloc_objs() in rocket_job_open() 
before using the allocated buffers.

Also replace the WARN_ON(ret) check in rocket_job_open() with a plain if
since ret can be -ENOMEM from drm_sched_entity_stats_new(). 
That is an allocation failure, not a driver bug, so a plain if 
seems better than a stack trace.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com>
Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
---
Changes in v2:
- Free scheds when drm_sched_entity_init() fails.
- Initialize ret to 0.

Changes in v3:
- Move patch version descriptions below the '---' marker.

Changes in v4:
- Remove unnecessary initialization of ret to 0.
- Adjust commit message word wrapping.
- Add Fixes tag.

Changes in v5:
- Add check overflow before kvmalloc_array() in rocket_job_push().

Changes in v6:
- Rebase on top of drm-misc-next, remove the rocket_job_push() hunk.
- Change WARN_ON(ret) to plain if check in rocket_job_open().
- Add Tested-by tags.
---
 drivers/accel/rocket/rocket_job.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index f40435505818..704a15513179 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -516,6 +516,9 @@ int rocket_job_open(struct rocket_file_priv *rocket_priv)
 	unsigned int core;
 	int ret;
 
+	if (!scheds)
+		return -ENOMEM;
+
 	for (core = 0; core < rdev->num_cores; core++)
 		scheds[core] = &rdev->cores[core].sched;
 
@@ -523,10 +526,10 @@ int rocket_job_open(struct rocket_file_priv *rocket_priv)
 				    DRM_SCHED_PRIORITY_NORMAL,
 				    scheds,
 				    rdev->num_cores, NULL);
-	if (WARN_ON(ret))
-		return ret;
+	if (ret)
+		kfree(scheds);
 
-	return 0;
+	return ret;
 }
 
 void rocket_job_close(struct rocket_file_priv *rocket_priv)
-- 
2.53.0

