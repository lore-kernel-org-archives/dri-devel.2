Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CDC606A335
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jdXfyJo0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDAC510F6A3;
	Tue, 27 Oct 2026 15:45:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A914E10E426;
 Tue, 27 Oct 2026 15:44:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 14CD443C9C;
 Tue, 27 Oct 2026 15:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEA01F031E1;
 Tue, 27 Oct 2026 15:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793115855;
 bh=/z7vULV9ET96OVawlpuKhOOFOEzaoRsKx7ENimt5WTY=;
 h=Date:From:To:Cc:Subject:References;
 b=jdXfyJo0CGxQAq6lrM+rdnAC5kkyIyDGCyaXy8RY12C/xhAmDv3kBWgF640VC9QLr
 5ShJWb1/tqFMTWp3gx+4Bu638fVHYryIf65TpGBn9iErS6v5zw4chc+UIqthKMFSol
 m7QJgZDgqjgnpl6sFCER7TZcLp5ZqjJm9yTM5hebyb6YNCzPAgGsdwC0gbxsalLn38
 6BtLExOerDeAlk2bQKM+UiC1Lxrm5PIavqM9G8sYWMn19MLQ3I2DWjlYV/2TCRcwCQ
 2IqeWVq3OUlxSdmQQEVXdpj261/935ndAUdylVs9l3k+qqwUfbv56vUmNl7D9zeeR4
 0hWk1S9PZO1eQ==
Received: from rostedt by gandalf with local (Exim 4.100.1)
 (envelope-from <rostedt@kernel.org>) id 1xLjLS-000000078je-0hhf;
 Tue, 27 Oct 2026 11:44:14 -0400
Message-ID: <20261027154413.997660461@kernel.org>
User-Agent: quilt/0.69
Date: Tue, 27 Oct 2026 11:37:06 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Peter Zijlstra <peterz@infradead.org>, Aaron Conole <aconole@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Chanwoo Choi <cw00.choi@samsung.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Danilo Krummrich <dakr@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Airlie <airlied@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eelco Chaudron <echaudro@redhat.com>, Eric Dumazet <edumazet@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Ilya Maximets <i.maximets@ovn.org>, Ingo Molnar <mingo@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
 Koby Elbaz <koby.elbaz@intel.com>,
 Konstantin Sinyuk <konstantin.sinyuk@intel.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 "Martin K. Petersen" <mkp@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Oded Gabbay <ogabbay@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Philipp Stanner <phasta@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Gleixner <tglx@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 tipc-discussion@lists.sourceforge.net,
 Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
 Xin Long <lucien.xin@gmail.com>, x86@kernel.org,
 amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org, dev@openvswitch.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 8/9] kernel: time,
 trace: Use trace_call__##name() at guarded tracepoint call sites
References: <20261027153658.703730257@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Vineeth Pillai <vineeth@bitbyteword.org>

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Original v2 series:
https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/

Parts of the original v2 series have already been merged in mainline.
This patch is being reposted as a follow-up cleanup for the remaining
unmerged pieces.

Link: https://patch.msgid.link/20260515135959.2238922-1-vineeth@bitbyteword.org
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/time/tick-sched.c       | 12 ++++++------
 kernel/trace/trace_benchmark.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 5d53ab18b31a..9bdd49e66acf 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -346,32 +346,32 @@ static bool check_tick_dependency(atomic_t *dep)
 		return !!val;
 
 	if (val & TICK_DEP_MASK_POSIX_TIMER) {
-		trace_tick_stop(0, TICK_DEP_MASK_POSIX_TIMER);
+		trace_call__tick_stop(0, TICK_DEP_MASK_POSIX_TIMER);
 		return true;
 	}
 
 	if (val & TICK_DEP_MASK_PERF_EVENTS) {
-		trace_tick_stop(0, TICK_DEP_MASK_PERF_EVENTS);
+		trace_call__tick_stop(0, TICK_DEP_MASK_PERF_EVENTS);
 		return true;
 	}
 
 	if (val & TICK_DEP_MASK_SCHED) {
-		trace_tick_stop(0, TICK_DEP_MASK_SCHED);
+		trace_call__tick_stop(0, TICK_DEP_MASK_SCHED);
 		return true;
 	}
 
 	if (val & TICK_DEP_MASK_CLOCK_UNSTABLE) {
-		trace_tick_stop(0, TICK_DEP_MASK_CLOCK_UNSTABLE);
+		trace_call__tick_stop(0, TICK_DEP_MASK_CLOCK_UNSTABLE);
 		return true;
 	}
 
 	if (val & TICK_DEP_MASK_RCU) {
-		trace_tick_stop(0, TICK_DEP_MASK_RCU);
+		trace_call__tick_stop(0, TICK_DEP_MASK_RCU);
 		return true;
 	}
 
 	if (val & TICK_DEP_MASK_RCU_EXP) {
-		trace_tick_stop(0, TICK_DEP_MASK_RCU_EXP);
+		trace_call__tick_stop(0, TICK_DEP_MASK_RCU_EXP);
 		return true;
 	}
 
diff --git a/kernel/trace/trace_benchmark.c b/kernel/trace/trace_benchmark.c
index e19c32f2a938..189d383934fd 100644
--- a/kernel/trace/trace_benchmark.c
+++ b/kernel/trace/trace_benchmark.c
@@ -51,7 +51,7 @@ static void trace_do_benchmark(void)
 
 	local_irq_disable();
 	start = trace_clock_local();
-	trace_benchmark_event(bm_str, bm_last);
+	trace_call__benchmark_event(bm_str, bm_last);
 	stop = trace_clock_local();
 	local_irq_enable();
 
-- 
2.53.0
