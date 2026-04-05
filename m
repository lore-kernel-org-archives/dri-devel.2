Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CBCE9D800
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 19:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E984A10E14D;
	Sun,  5 Apr 2026 19:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qZxFYhYm";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5447410E14D
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 19:23:16 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso29822085e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 12:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775416995; x=1776021795; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hlQ/HWcle4nBzK0uGVXKI4hIW3LC+uT3zoLi9QT2VZQ=;
 b=qZxFYhYmHt/e9U/R67ZTnUxUQFF0Kx+aiqQwm25qNuBEl4p+G5hYMopRS8EOrZBIHD
 n7rsPUgipJUefkz/ooIHDNsMf6TOtwnQHMnstY+gqMFuNI+lxeAoDoojBCz3/8G1p8/W
 lhbw/i4d6IJ+t6SgzY4R9aqYQT+R2hzVVjdSmIGkPflIzovCekwUjlrC1EAR9KKzLEdK
 ZJtTKYcY5ViVESfJ+Zba2N5n9wX9KFPoAtv+M3rObR5freBG6B7Qp/9vUQb5VEK8m5VW
 DboVafCkkDzKOlEkcv0bddYRt5vaTBr16JypOI6XbMCIEu38VLUCFNIf0/HcGdGVFFS9
 iMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775416995; x=1776021795;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlQ/HWcle4nBzK0uGVXKI4hIW3LC+uT3zoLi9QT2VZQ=;
 b=BhxkfGYwcbpVL3yJjwcL2FwzkhtDXEyCZg4Mf3ti0gOS8TED6j8PAZvnwKmtwyvqjt
 5zsyVK+hN2WV0wY8V1MrquK9U26AcRFovMDelECkvXhvqwA5BlmzCxHsRPUO6bPFYbBt
 gPhQ1p8Ny5IraJarBMCJELaSIIK/Crv/rCleRrNspXJsXOUA+guNQLjp4ELQTv4EoRth
 0P0/mqbF5IGXzBcj2G7HI2DJ7nvrnLwDDnUSDlqCZi6g+qxwxFIQZhYMNKL4S3N34CyS
 X05AN2Hm7AufNM9APIfhm15utOwyaN3I77GMLwJnjfIiRKcwbgqBPHAj0TlkSSSzSlLo
 axcg==
X-Gm-Message-State: AOJu0YzwfyA4dsNjz48YZ/CHA4G/Eb7MpQRR9DzNE7/orPTDXhWnx/Dq
 JlAELK+i634PaPq48GIEEuqDDXH0/Lhv/Z5tp+Or01mkyXFey1EeVYwA
X-Gm-Gg: AeBDietQpHTlvzbKtoVBormVBkRl+kSDFg8A4sKT2psif+8TUPmBH/2IJqJOMog0BVs
 O8g0232YUTTRwp14xc9qLiJF9uC6VOBnUIljnZzHzdC3bBbRxKl0svfilNtjtthdxvUZXZ/TMBP
 CMaRZ52m9JeNmUPQt3kYHnZb2b3rpTsWcE5qxGWquGdj1Vt1Wj0hUFsm0qKWiDqWMjvDqeYENLk
 9pwsVQskG4XcEIKDCckNI2zR+UJLjep0yUvS8ZTqU9gdwINW3Yw8sMGxbhj54bgMysdsXmWbf9m
 TWIXRZaQyQZelBIw232CDX1o6rg4+kxYt/Da4FZv8zT+sCQp0bH+tJpt+oKRMJq/zMOpoQ3m04/
 Yskhq/R2+v1CY1k/maRor8uE6NDBgbt5hUExuyjGFpsL8LiIsGj5QiLZGXBeETRkbHrI1y/bhAh
 aTpO62TjrtUDau4zVZSrB9KevuuKIx3+lR9oFb59An8PWp0MJ4wcBEGXLPJWQbPMw97AuSGLCSx
 wIG1Bni5zXQ511eT4k=
X-Received: by 2002:a05:600c:3b99:b0:485:4453:401d with SMTP id
 5b1f17b1804b1-488996b0125mr164821245e9.2.1775416994576; 
 Sun, 05 Apr 2026 12:23:14 -0700 (PDT)
Received: from Arch-Spectre.home (host-2-101-228-96.as13285.net.
 [2.101.228.96]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2a6f1esm34375347f8f.2.2026.04.05.12.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 12:23:14 -0700 (PDT)
From: Yicong Hui <yiconghui@gmail.com>
To: boris.brezillon@collabora.com,
	steven.price@arm.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, me@brighamcampbell.com,
 Yicong Hui <yiconghui@gmail.com>
Subject: [PATCH] drm/panthor: Fix kernel-doc warning in panthor_sched.c
Date: Sun,  5 Apr 2026 20:23:09 +0100
Message-ID: <20260405192309.389039-1-yiconghui@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Fix the following W=1 kerneldoc warnings by adding the missing parameter
descriptions for @ptdev and @events in panthor_sched_report_fw_events()
and @ptdev in panthor_sched_report_mmu_fault()

Warning: drivers/gpu/drm/panthor/panthor_sched.c:1898 function parameter 'ptdev' not described in 'panthor_sched_report_fw_events'
Warning: drivers/gpu/drm/panthor/panthor_sched.c:1898 function parameter 'events' not described in 'panthor_sched_report_fw_events'
Warning: drivers/gpu/drm/panthor/panthor_sched.c:2783 function parameter 'ptdev' not described in 'panthor_sched_report_mmu_fault'

Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
Signed-off-by: Yicong Hui <yiconghui@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index a70f1db0764e..2d6dc5db4148 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -1894,6 +1894,8 @@ static void process_fw_events_work(struct work_struct *work)
 
 /**
  * panthor_sched_report_fw_events() - Report FW events to the scheduler.
+ * @ptdev: Device.
+ * @events: Bitmask of pending FW events to report.
  */
 void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events)
 {
@@ -2779,6 +2781,7 @@ static void panthor_group_start(struct panthor_group *group)
 
 /**
  * panthor_sched_report_mmu_fault() - Report MMU faults to the scheduler.
+ * @ptdev: Device.
  */
 void panthor_sched_report_mmu_fault(struct panthor_device *ptdev)
 {
-- 
2.53.0

