Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEC1CD6E54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 21:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A81C11255C;
	Fri, 29 May 2026 21:53:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ktSjYOzl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40B7C11255C
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 21:53:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B57D943D2D;
 Fri, 29 May 2026 21:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619531F00893;
 Fri, 29 May 2026 21:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780091593;
 bh=M8sP0nKdhFiScfx1hIMkuFsQE9ZhPuCAyZmUu8LHU+E=;
 h=From:To:Cc:Subject:Date;
 b=ktSjYOzl4qU08K2om7yNm+VDaUE7m37+T7Mxz9ynh3Wha4Uk/uLPpWr8ORUxWS1BU
 RfJ2nzrE6no2JuN5j6TbCkWYVtLNgO9RDZ7HSKdhaqtc1JnCprwdwb7O4A2eraNgNr
 fSITmfSIr2rFHQzzL1udEk2zvH5HIZkrqB6nx+wVz8ZTeOp1YfLXb5wjFQKfQAGDCx
 HntVZKc+q1Key6D5escXQ6DRUa6FvEvTx4eT3XTROUqBZ/VqCvvU7ucENSzy2ThuR1
 fNcB2od22EiN5PDRgtuVK+c/zi0BL5wXlgwECo0XLQN8GonRVqdw7Gj9Yxsen51f9b
 9Y2W9iZXBRKsg==
From: Philipp Stanner <phasta@kernel.org>
To: avid Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, dakr@kernel.org,
 christian.koenig@amd.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Philipp Stanner <phasta@kernel.org>
Subject: [PATCH] Documentation: drm: Add entry for removing spsc_queue to TODO
 list
Date: Fri, 29 May 2026 23:52:07 +0200
Message-ID: <20260529215207.115513-2-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

drm_sched contains a lockless queue (spsc_queue) that seems to be
useless and potentially unsound.

Add a TODO list entry for replacing spsc_queue with a locked list.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 Documentation/gpu/todo.rst | 41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index cdddf8db35f5..87e082b0eb48 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -948,6 +948,47 @@ Contact: Philipp Stanner <phasta@kernel.org>
 
 Level: Intermediate
 
+Replace the lockless queue with a locked list
+---------------------------------------------
+
+drm_sched is the only user in the entire kernel of a special lockless queue, the
+spsc_queue. This queue utilizes:
+
+- preempt_disable()
+- atomic instructions
+- memory barriers
+- ACCESS_ONCE()
+
+whereas a conventional spinlock utilizes:
+
+- preempt_disable()
+- 1 atomic instruction for taking / releasing the lock
+- memory barriers
+
+Moreover, drm_sched_entity_push_job(), the only user of spsc_queue_push(), has
+to take a lock in some situations anyways and calls to it are often serialized
+with a driver lock.
+
+It is, thus, highly questionable whether the lockless queue grants any advantage
+at all. Considering that its internals are not well documented and its correctness
+is not formally proven, it seems desirable to replace the queue with a mere list
+or hlist that is protected by a spinlock.
+
+Tasks:
+
+- Replace the spsc_queue in drm/sched (and those who might access the scheduler's
+  internal queue) with a spinlock + (h)list.
+- Ideally, check with some micro benchmarks and real world tests (preferably
+  with amdgpu) for relevant performance regressions.
+- Remove the spsc_queue from the kernel altogether.
+
+Contact:
+
+- Philipp Stanner <phasta@kernel.org>
+- Christian König <christian.koenig@amd.com>
+
+Level: Beginner
+
 Outside DRM
 ===========
 
-- 
2.54.0

