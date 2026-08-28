Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439A3C624C8
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86C0910E6A1;
	Mon, 31 Aug 2026 07:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TgCr94wX";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF71A10E4F6
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:58:10 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2d715f4a587so15569745ad.2
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 07:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787929090; x=1788533890; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UpZ9SLDzN6L/jZYPiTPvyIKpc053VdrqfuuoBmjatWk=;
 b=TgCr94wXQSezgpSewmH07rjdhHXRBO/HaVtkPHLkadJmY9B7ecdALPxFkZM8VtXd1e
 lg21P1Cn4W97uL5PnMsQLCyqxdOok+SD5jvcy8KuOz1XH76kMtBNZtPU+jtLqhhUpODn
 +qDi59p0KS0/I1hsVClwjOl/VqtYwT0lm1BEIEjjHB2VHEtvY4XpFIbsr27kAhmPs1LO
 KrJVtIr20JLwRmc65L1BkFx8Y8NkvCDAAB6J9BnQLMSubL6z3aLa/fcLFI1a7Mil2yEc
 /W9gonvREHCSfVY4szHcFrc5COLFVvyPd/UimJva85pX7COeywsY+b1ZKYAPX1D3kCaW
 fINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787929090; x=1788533890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UpZ9SLDzN6L/jZYPiTPvyIKpc053VdrqfuuoBmjatWk=;
 b=NcHJj0euIO7dDGJgL8rYSyZy/Xp5w3K8HlbOnUcvqjGHGwJxc11zUeEUt88fD8dIIA
 N6OgZUKzMC4YJ5V5jfceuNzM6pJnMsnkJq8CdQU3WgcXTaS4OP1uJY5E9YKMNmkk7XxN
 hXimjItQ5MZXC9Rt6bfkSqpbLw9e8x4Afn5PtNiAydKwTwgQbBv4Pxr+s0IiNlDNzTSD
 NX9bEw63qITzxN1kZ71h0YLq1/CJoAIwaku09akEWH9UrOl+lP0oapx0LT1Io6yC8B/5
 rLhHerClMEi7kxAhIZt3I7EcaoURGKXbpjP1fFxPH7ohwHcOKGVOWJ2NjuEB3M051TBE
 9zxg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro7GcmV6b3tm3M9OmUOdEn2CaUOSICnj1+PoQ3gXO3QyjrG6NpeRoT49UEb0WoBiYU/Nn47USUIk5o=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kySvaAKJT+IHdVoObAiQCqWsB5BGg+3J/K8/BJ5g6PrFye3nt+
 taQLpzARXgCNzSWu31Mush2vooRuj8AWHCaqfCCP4iHVHC8x0VFaC14=
X-Gm-Gg: AR+sD12SrG+7Bq2V2b4P3EENRcd3XutDpCLs257JAMO6vqdL6RnbXfGwR+MHE6uR75e
 uV1/syGAZpWKBo08xGKe2itQnwBnikxonMo1XV7dNrJ6pjisFSY02HQWvraUv5bo2pBy4nWh05k
 tGlt4kIdxd/s9x2HZp2x2+ZdyTUkVlKopa21IIa8kIF+x80Xm3ffuWtY1lpJbYInalb6bmLALOL
 6PuYKJStLs+NgkbYvRtD8FB90CtrZDzpHO4j73cM6GOSGZ/u45uGzXsSn42WAnCM6cqOBQXVCJG
 sLNOMMnfEuBL8BnXwrTixN7JurWWQnoPCdeElkKHDufBqsUPn7bOXc5uUpPHtAnkGuXcwZDGQv2
 jWNtJ18rK/AatMcpQIUO0ZacGhw5T5op2DgA/HgRiTkjlTiatNaea95tZ2sRq+HHgshJ0jwykd4
 8lKwnTR9XrC3bg8g3S4rTCLr/ib87OKybRDzZil74IIVk+wti3yL4FEjNVSZDpS3DNfQ5mx0Zr2
 dgCfVtixi0vFj3vvN/vSWxZbX0=
X-Received: by 2002:a17:903:2342:b0:2d7:414e:f2f with SMTP id
 d9443c01a7336-2d74def676fmr134531005ad.14.1787929090198; 
 Fri, 28 Aug 2026 07:58:10 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d75988b6fcsm6159625ad.56.2026.08.28.07.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:58:09 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
Subject: [PATCH v1 2/2] drm/sched/tests: add a UAF regression test for
 get_timeline_name()
Date: Fri, 28 Aug 2026 23:57:57 +0900
Message-ID: <83d1cde658ad4c34080398ea89fc17dc1e87d5ae.1787928528.git.malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787928528.git.malhyuk97@gmail.com>
References: <cover.1787928528.git.malhyuk97@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:00:03 +0000
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

Add a KUnit test that reproduces the use-after-free fixed by the previous
patch. It holds a reference on a job's finished drm_sched_fence (standing
in for a userspace sync_file), frees the mock scheduler, then calls
get_timeline_name(). Before the fix this triggers a KASAN
slab-use-after-free read of the freed scheduler; after it the test passes.

The test needs no hardware - it exercises the drm_sched core through the
existing mock scheduler under KASAN.

Signed-off-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
---
 drivers/gpu/drm/scheduler/tests/tests_basic.c | 65 ++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/tests/tests_basic.c b/drivers/gpu/drm/scheduler/tests/tests_basic.c
index a5a5a35a87b0..2c6744b58f04 100644
--- a/drivers/gpu/drm/scheduler/tests/tests_basic.c
+++ b/drivers/gpu/drm/scheduler/tests/tests_basic.c
@@ -555,9 +555,72 @@ static struct kunit_suite drm_sched_credits = {
 	.test_cases = drm_sched_credits_tests,
 };
 
+/*
+ * Reproduce the drm_sched_fence get_timeline_name() lifetime bug.
+ *
+ * drm_sched_fence_get_timeline_name() dereferences fence->sched->name, and the
+ * drm_sched_fence ops keep .release set, so the fence is NOT ops-detached on
+ * signal (unlike stub fences). A driver that frees a per-context
+ * drm_gpu_scheduler while userspace still holds the exported ->finished fence
+ * (via sync_file / drm_syncobj) leaves fence->sched dangling; reading the
+ * timeline name then touches freed slab memory (arbitrary-read once the slab is
+ * re-sprayed). Confirmed instances: amdxdna, nouveau, msm. Same class as
+ * CVE-2025-38703 (xe) and CVE-2025-71302 (panthor). KASAN reports a
+ * slab-use-after-free READ in drm_sched_fence_get_timeline_name.
+ */
+static void drm_sched_fence_get_timeline_name_uaf(struct kunit *test)
+{
+	struct drm_mock_sched_entity *entity;
+	struct drm_mock_scheduler *sched;
+	struct drm_mock_sched_job *job;
+	struct dma_fence *finished;
+	const char *name;
+	bool done;
+
+	sched = drm_mock_sched_new(test, MAX_SCHEDULE_TIMEOUT);
+	entity = drm_mock_sched_entity_new(test, DRM_SCHED_PRIORITY_NORMAL,
+					   sched);
+	job = drm_mock_sched_job_new(test, entity);
+
+	/* Arm + submit first; the s_fence is only created by drm_sched_job_arm(). */
+	drm_mock_sched_job_submit(job);
+
+	/* Independent reference on the finished fence == userspace sync_file. */
+	finished = dma_fence_get(&job->base.s_fence->finished);
+
+	/* Let the job get picked up (hw_fence created), then signal + finish. */
+	done = drm_mock_sched_job_wait_scheduled(job, HZ);
+	KUNIT_ASSERT_TRUE(test, done);
+	drm_mock_sched_advance(sched, 1);
+	done = drm_mock_sched_job_wait_finished(job, HZ);
+	KUNIT_ASSERT_TRUE(test, done);
+
+	/* Free the per-context scheduler while the finished fence is held. */
+	drm_mock_sched_entity_free(entity);
+	drm_mock_sched_fini(sched);
+	kunit_kfree(test, sched);
+
+	/* UAF read: fence->sched->name is read from the freed scheduler. */
+	name = finished->ops->get_timeline_name(finished);
+	kunit_info(test, "get_timeline_name() on stale fence returned %p\n", name);
+
+	dma_fence_put(finished);
+}
+
+static struct kunit_case drm_sched_fence_uaf_tests[] = {
+	KUNIT_CASE(drm_sched_fence_get_timeline_name_uaf),
+	{}
+};
+
+static struct kunit_suite drm_sched_fence_uaf = {
+	.name = "drm_sched_fence_uaf_tests",
+	.test_cases = drm_sched_fence_uaf_tests,
+};
+
 kunit_test_suites(&drm_sched_basic,
 		  &drm_sched_timeout,
 		  &drm_sched_cancel,
 		  &drm_sched_priority,
 		  &drm_sched_modify_sched,
-		  &drm_sched_credits);
+		  &drm_sched_credits,
+		  &drm_sched_fence_uaf);
-- 
2.43.0

