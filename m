Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A127CC55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 10:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2CEF10E9A0;
	Tue,  4 Aug 2026 10:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="QGwJxOlw";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5891410E9A6
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 10:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=rY
 z9U+QDAo8fQj74xxPZ1HBSKLHkAU/kgF6k/ZYBlSs=; b=QGwJxOlw9Gwz6mHx2O
 xdAO7YaY8s4Wd/LkHv+4VEXeHDF3R4Cexc2NYpvpCIEtmlVbxS8kozPZBlh31dO5
 3KQobTIoTDgovGzfkjErulxHNes/b9hLn/hTFXgEBC3OHJU8MJP8nppqWr4UgD9P
 AO8+Bkni7T7/IgATuN/xcBbqQ=
Received: from localhost.localdomain (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PygvCgDn4hh5unFqgXCiKg--.51693S2;
 Tue, 04 Aug 2026 18:10:03 +0800 (CST)
From: oushixiong1025@163.com
To: Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH 1/2] drm/sched: Guard against NULL dev in drm_sched_job trace
 event
Date: Tue,  4 Aug 2026 18:09:55 +0800
Message-Id: <20260804100956.780316-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgDn4hh5unFqgXCiKg--.51693S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFy8ZrWfJw17Jw18Wr4rXwb_yoW8ArW3pr
 Zrua9xKry8tr47t3yUZ3WrWr98GayavayxGr1DX3sxZrn0qF15GrW3Kw4ftrW7Ar4xAryI
 gFnF9ay2q3Wj9w7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uv4EiUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC-hvD0mpxuntMjAAA3u
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

From: Shixiong Ou <oushixiong@kylinos.cn>

The drm_sched_job trace event class calls dev_name() on
sched_job->sched->dev without checking for NULL. Since the
dev field in drm_sched_init_args is optional (used for
debugging), a NULL dev causes a kernel oops when the trace
event fires.

Add a NULL check following the same pattern used by the CXL
subsystem (drivers/cxl/core/trace.h). When dev is NULL, the
trace output will show "none" instead of crashing.

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000050
  Call trace:
   trace_event_raw_event_drm_sched_job+0x90/0x258
   __traceiter_drm_sched_job_queue+0x4c/0x78
   drm_sched_entity_push_job+0x188/0x380
   drm_sched_basic_entity_cleanup+0xfc/0x240
   kunit_try_run_case+0x74/0x170

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/scheduler/gpu_scheduler_trace.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
index 261713dd7d5a..319a3ec54bec 100644
--- a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
+++ b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
@@ -61,7 +61,8 @@ DECLARE_EVENT_CLASS(drm_sched_job,
 			     __string(name, sched_job->sched->name)
 			     __field(u32, job_count)
 			     __field(int, hw_job_count)
-			     __string(dev, dev_name(sched_job->sched->dev))
+			     __string(dev, sched_job->sched->dev ?
+				      dev_name(sched_job->sched->dev) : "none")
 			     __field(u64, fence_context)
 			     __field(u64, fence_seqno)
 			     __field(u64, client_id)
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

