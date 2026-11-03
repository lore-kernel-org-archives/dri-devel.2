Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2618606D804
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SrYk7Riw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2645410F69A;
	Tue,  3 Nov 2026 15:33:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D8B310F69A
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 15:33:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B546C609EC;
 Tue,  3 Nov 2026 15:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCC61F00A02;
 Tue,  3 Nov 2026 15:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793719995;
 bh=wdz+UoLmdeuO/9e+1/ijBJsXh3Mk16TKUgOURfVhGuo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SrYk7Riw66F3Sk4QneGV7ZpKJcGR6IqkeVr6i9KlEI8QRnIns0UQZQkSsm+hYhiZi
 2O2JZ+fskwU7ybwEXwL/Gq4ZUnRph3P2Q47UxDVds0d1KnnzcESIDyuZgdWgNhYImF
 jEzn60nj3S2FxWGLcx69ZjMchRX69RvTet85tZwyHiEq0AxD0uKlkZhLAvoxcUQ/lw
 FZGylD5m3W0dMJzZgzi6QZd+VVgHwYGl2Xm9qsShHf4W/k02pbmgT7nxtLpRZ61F7b
 hxTX13gYJAu8zsh1+ylez2l6cBGIyt2fke1gDTd2BJBZdlhR6Pc6m0Hkhb4oNRQQCP
 lXCrVXqoC6Kqg==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [RFC PATCH v7 8/8] samples: rust: Add JobQueue Tester
Date: Tue,  3 Nov 2026 16:31:38 +0100
Message-ID: <20261103153138.1087330-10-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103153138.1087330-2-phasta@kernel.org>
References: <20261103153138.1087330-2-phasta@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Gary Guo <gary@garyguo.net>

Some test code for the JobQueue
---
 samples/rust/Kconfig                 |  11 ++
 samples/rust/Makefile                |   1 +
 samples/rust/rust_jobqueue_tester.rs | 242 +++++++++++++++++++++++++++
 3 files changed, 254 insertions(+)
 create mode 100644 samples/rust/rust_jobqueue_tester.rs

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 31d62533ef25..a5754fe03fd5 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -190,4 +190,15 @@ config SAMPLE_RUST_HOSTPROGS
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_JOBQUEUE_TESTER
+	tristate "Jobqueue Tester"
+	select JOBQUEUE_TESTER
+	help
+	  This option builds the Rust Jobqueue Tester.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_jobqueue_tester.
+
+	  If unsure, say N.
+
 endif # SAMPLES_RUST
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index b986b681cde5..69dd0b8d2597 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_SAMPLE_RUST_DRIVER_AUXILIARY)	+= rust_driver_auxiliary.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_SERDEV)		+= rust_driver_serdev.o
 obj-$(CONFIG_SAMPLE_RUST_CONFIGFS)		+= rust_configfs.o
 obj-$(CONFIG_SAMPLE_RUST_SOC)			+= rust_soc.o
+obj-$(CONFIG_SAMPLE_RUST_JOBQUEUE_TESTER)	+= rust_jobqueue_tester.o
 
 rust_print-y := rust_print_main.o rust_print_events.o
 
diff --git a/samples/rust/rust_jobqueue_tester.rs b/samples/rust/rust_jobqueue_tester.rs
new file mode 100644
index 000000000000..48dd1188f7db
--- /dev/null
+++ b/samples/rust/rust_jobqueue_tester.rs
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Small example demonstrating how to use [`drm::JobQueue`].
+
+use kernel::dma_buf::{FenceContext, FenceContextOps, Fence, FenceStatus};
+use kernel::drm::{JobQueue, JobQueueOps, JobRunnable};
+use kernel::prelude::*;
+use kernel::str::CString;
+use kernel::task::might_sleep;
+use kernel::time::{delay::fsleep, Delta};
+
+module! {
+    type: RustJobqueueTester,
+    name: "rust_jobqueue_tester",
+    authors: ["Philipp Stanner"],
+    description: "Rust minimal sample",
+    license: "GPL",
+}
+
+// -- FenceContext data for external dependency fences -------------------------
+
+#[pin_data]
+struct DepFenceCtxData {}
+
+impl DepFenceCtxData {
+    fn new() -> impl PinInit<Self> {
+        pin_init!(Self {})
+    }
+}
+
+impl FenceContextOps for DepFenceCtxData {
+    type FenceDataType = ();
+}
+
+// -- JobQueue data and ops ----------------------------------------------------
+
+#[pin_data]
+struct JqData {}
+
+impl JqData {
+    fn new() -> impl PinInit<Self> {
+        pin_init!(Self {})
+    }
+}
+
+struct JobPayload {}
+
+impl Drop for JobPayload {
+    fn drop(&mut self) {
+        might_sleep();
+    }
+}
+
+impl JobQueueOps for JqData {
+    type JobDataType = JobPayload;
+
+    fn run_job<'a>(&self, job: JobRunnable<'a, JobPayload>) {
+        // Simulate GPU work completing after a short delay. In a real driver
+        // this would submit work to the hardware ring.
+        pr_info!("run_job: seqno {}\n", job.seqno);
+    }
+
+    fn kill(&self, _jq_nr: u64, _err: Error) {
+
+    }
+}
+
+fn is_signaled(fence: &Fence) -> bool {
+    match fence.status() {
+        FenceStatus::Unsignaled => false,
+        FenceStatus::Signaled(_) => true,
+    }
+}
+
+struct RustJobqueueTester {}
+
+impl kernel::Module for RustJobqueueTester {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust Jobqueue Tester (init)\n");
+        pr_info!("Am I built-in? {}\n", !cfg!(MODULE));
+
+        // A standalone FenceContext for creating external dependency fences.
+        let dep_fctx = KBox::pin_init(
+            FenceContext::new(
+                0,
+                c"rust-jq-tester",
+                c"dep-timeline",
+                DepFenceCtxData::new(),
+            ),
+            GFP_KERNEL,
+        )?;
+
+        let driver_name = CString::try_from_fmt(fmt!("rust-jobqueue-tester"))?;
+        let timeline_name = CString::try_from_fmt(fmt!("rust-jq-tester-hw-timeline"))?;
+        let jq = KBox::pin_init(
+            JobQueue::new(0, driver_name, timeline_name, 1_000_000, JqData::new()),
+            GFP_KERNEL,
+        )?;
+
+        pr_info!("Test 1: Test submitting two jobs without dependencies.\n");
+        let job1 = jq.new_job(1, JobPayload {})?;
+        let job2 = jq.new_job(1, JobPayload {})?;
+
+        let fence1 = job1.submit();
+        let fence2 = job2.submit();
+
+        // Complete both jobs by seqno so their fences get signaled.
+        jq.complete_jobs_up_to_seqno(fence2.seqno());
+
+        // Give the submit worker a chance to run.
+        fsleep(Delta::from_millis(100));
+
+        if !is_signaled(&fence1) || !is_signaled(&fence2) {
+            pr_info!("Test 1 failed.\n");
+            return Err(EAGAIN);
+        }
+        pr_info!("Test 1 succeeded.\n");
+
+        pr_info!("Test 2: Test submitting a job with already-fulfilled dependency.\n");
+        let mut job3 = jq.new_job(1, JobPayload {})?;
+        job3.add_dependency(&fence1)?;
+
+        let fence3 = job3.submit();
+        jq.complete_jobs_up_to_seqno(fence3.seqno());
+
+        // Give the submit worker a chance to run.
+        fsleep(Delta::from_millis(100));
+
+        if !is_signaled(&fence3) {
+            pr_info!("Test 2 failed.\n");
+            return Err(EAGAIN);
+        }
+        pr_info!("Test 2 succeeded.\n");
+
+        pr_info!("Test 3: Test that a job with unfulfilled dependency does not get run.\n");
+        let unsignaled_alloc = dep_fctx.new_fence_allocation(())?;
+        let unsignaled_fence = unsignaled_alloc.new_fence();
+
+        let mut job4 = jq.new_job(1, JobPayload {})?;
+        job4.add_dependency(unsignaled_fence.as_fence())?;
+
+        let blocked_job_fence = job4.submit();
+
+        // Give the submit worker a chance to run (it should NOT run job4).
+        fsleep(Delta::from_millis(100));
+
+        if is_signaled(&blocked_job_fence) {
+            pr_info!("Test 3 failed.\n");
+            return Err(EAGAIN);
+        }
+        pr_info!("Test 3 succeeded.\n");
+
+        pr_info!("Test 4: Test whether Test 3's blocked job can be unblocked.\n");
+        unsignaled_fence.signal(Ok(()));
+
+        // Give the submit worker a chance to run the now-unblocked job.
+        fsleep(Delta::from_millis(500));
+
+        // Complete it.
+        jq.complete_jobs_up_to_seqno(blocked_job_fence.seqno());
+        fsleep(Delta::from_millis(100));
+
+        if !is_signaled(&blocked_job_fence) {
+            pr_info!("Test 4 failed.\n");
+            return Err(EAGAIN);
+        }
+        pr_info!("Test 4 succeeded.\n");
+
+        pr_info!("Test 5: Submit unblocked jobs, then a blocked one, then unblocked ones.\n");
+        let job1 = jq.new_job(1, JobPayload {})?;
+        let job2 = jq.new_job(1, JobPayload {})?;
+        let mut job3 = jq.new_job(1, JobPayload {})?;
+        let job4 = jq.new_job(1, JobPayload {})?;
+        let job5 = jq.new_job(1, JobPayload {})?;
+
+        let unsignaled_alloc1 = dep_fctx.new_fence_allocation(())?;
+        let unsignaled_fence1 = unsignaled_alloc1.new_fence();
+        let unsignaled_alloc2 = dep_fctx.new_fence_allocation(())?;
+        let unsignaled_fence2 = unsignaled_alloc2.new_fence();
+        let unsignaled_alloc3 = dep_fctx.new_fence_allocation(())?;
+        let unsignaled_fence3 = unsignaled_alloc3.new_fence();
+
+        job3.add_dependency(unsignaled_fence1.as_fence())?;
+        job3.add_dependency(unsignaled_fence2.as_fence())?;
+        job3.add_dependency(unsignaled_fence3.as_fence())?;
+
+        let fence1 = job1.submit();
+        let fence2 = job2.submit();
+        let fence3 = job3.submit();
+
+        // Complete unblocked jobs 1 and 2.
+        jq.complete_jobs_up_to_seqno(fence2.seqno());
+        fsleep(Delta::from_millis(100));
+
+        if is_signaled(&fence3) || !is_signaled(&fence1) || !is_signaled(&fence2) {
+            pr_info!("Test 5 failed (phase 1).\n");
+            return Err(EAGAIN);
+        }
+
+        // Signal two of three dependencies — job3 should still be blocked.
+        unsignaled_fence1.signal(Ok(()));
+        unsignaled_fence3.signal(Ok(()));
+        fsleep(Delta::from_millis(200));
+
+        if is_signaled(&fence3) {
+            pr_info!("Test 5 failed (phase 2).\n");
+            return Err(EAGAIN);
+        }
+
+        // Signal the last dependency — job3 should now be runnable.
+        unsignaled_fence2.signal(Ok(()));
+        fsleep(Delta::from_millis(500));
+
+        // Complete job3 and the remaining jobs.
+        jq.complete_jobs_up_to_seqno(fence3.seqno());
+        fsleep(Delta::from_millis(100));
+
+        if !is_signaled(&fence3) {
+            pr_info!("Test 5 failed (phase 3).\n");
+            return Err(EAGAIN);
+        }
+
+        let fence4 = job4.submit();
+        let fence5 = job5.submit();
+        jq.complete_jobs_up_to_seqno(fence5.seqno());
+        fsleep(Delta::from_millis(100));
+
+        if !is_signaled(&fence4) || !is_signaled(&fence5) {
+            pr_info!("Test 5 failed (phase 4).\n");
+            return Err(EAGAIN);
+        }
+        pr_info!("Test 5 succeeded.\n");
+
+        Ok(RustJobqueueTester {})
+    }
+}
+
+impl Drop for RustJobqueueTester {
+    fn drop(&mut self) {
+        pr_info!("Rust Jobqueue Tester (exit)\n");
+    }
+}
-- 
2.56.0

