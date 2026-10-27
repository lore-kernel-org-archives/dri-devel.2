Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3759E606D946
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fgHnkTyo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96CE910E430;
	Tue, 27 Oct 2026 15:44:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D88410E420;
 Tue, 27 Oct 2026 15:44:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A0A42419EA;
 Tue, 27 Oct 2026 15:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7463C1F01825;
 Tue, 27 Oct 2026 15:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793115853;
 bh=Gkqrjit9+J4CJctXBbr9aEQ6wG9MjsFcQbJJ6qRHxxM=;
 h=Date:From:To:Cc:Subject;
 b=fgHnkTyo/8WH2NlGS3UEDZvLhFLuCcOEbT+Biv5UEH1BUma4S/V5vvpgD1O/LP0/b
 xbLkNjjzP/s+eC/0hWq+4g4uhHGrZB2n8vgSCfwSdJNG8i3IjVSFjTQaMtsjzxB7LC
 7gAy3GMidabLmrmgTj1mKC894dAMw43YvNchPD+EPbVs93iIEhrZy8UsU8qzMU2jgO
 9mneIY8c2mg6ULvLXhbXV4IcAib11uQClk0ZzkWc3/Oz3pCpMTcAg9kifHr9cIxLDP
 JQGfmBoAH8jakGVW3hwWb3nzcqjyfnPtGjxKzmddkD6u3roLx2eKrjl/efNEP+G2Gm
 DDCt6HBJe0EiQ==
Received: from rostedt by gandalf with local (Exim 4.100.1)
 (envelope-from <rostedt@kernel.org>) id 1xLjLQ-000000078eo-2Z1f;
 Tue, 27 Oct 2026 11:44:12 -0400
Message-ID: <20261027153658.703730257@kernel.org>
User-Agent: quilt/0.69
Date: Tue, 27 Oct 2026 11:36:58 -0400
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
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 0/9] tracing: Use trace_call__FOO() for tracepoints behind
 trace_FOO_enabled()
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

This is a rebase of patches Vineeth Pillai created back in May[1].
This series fixes the "double static_branch" that Peter Zijlstra complained
about. When there's some extra work that needs to be done specifically
for a tracepoint, that work should be behind a trace_FOO_enabled() "if"
statement so that the work is only done when the tracepoint FOO is enabled.
The issue that Peter complained about is that both the trace_FOO_enabled()
and the trace_FOO() use a static branch which has the nop/jmp switch.
There's no reason to have the trace_FOO() use that if it is behind a
trace_FOO_enabled() as that test has already been checked.

Vineeth created a trace_call__FOO() which calls the tracepoint logic
directly without doing the static_branch. This is to only be used when
the tracepoint is called behind a trace_FOO_enabled() check. That code[2]
has been upstream since 7.1. Vineeth also sent out changes to update
all trace_FOO() callers behind a trace_FOO_enabled() to use the new
API. But not all maintainers took it nor gave an ack.

This is a rebase of that work for the maintainers that did not ack nor
take the patches. This is to give those maintainers another chance to do so.
Maintainers may either take the patches or ACK them and I'll take it.

[1] https://lore.kernel.org/linux-trace-kernel/20260515135903.2238731-1-vineeth@bitbyteword.org/
[2] 677a3d82b6407 ("tracepoint: Add trace_call__##name() API")


Vineeth Pillai (9):
      net: Use trace_call__##name() at guarded tracepoint call sites
      accel/habanalabs: Use trace_call__##name() at guarded tracepoint call sites
      devfreq: Use trace_call__##name() at guarded tracepoint call sites
      dma-buf: Use trace_call__##name() at guarded tracepoint call sites
      drm: Use trace_call__##name() at guarded tracepoint call sites
      scsi: ufs: Use trace_call__##name() at guarded tracepoint call sites
      net: devlink: Use trace_call__##name() at guarded tracepoint call sites
      kernel: time, trace: Use trace_call__##name() at guarded tracepoint call sites
      x86: msr: Use trace_call__##name() at guarded tracepoint call sites

----
 arch/x86/lib/msr.c                        |  6 +++---
 drivers/accel/habanalabs/common/device.c  |  9 +++++----
 drivers/accel/habanalabs/common/mmu/mmu.c |  3 ++-
 drivers/accel/habanalabs/common/pci/pci.c |  6 ++++--
 drivers/devfreq/devfreq.c                 |  2 +-
 drivers/dma-buf/dma-fence.c               |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 ++--
 drivers/gpu/drm/scheduler/sched_entity.c  |  5 +++--
 drivers/ufs/core/ufshcd.c                 | 31 ++++++++++++++++---------------
 kernel/time/tick-sched.c                  | 12 ++++++------
 kernel/trace/trace_benchmark.c            |  2 +-
 net/core/dev.c                            |  2 +-
 net/core/xdp.c                            |  2 +-
 net/devlink/trap.c                        |  2 +-
 net/openvswitch/actions.c                 |  2 +-
 net/openvswitch/datapath.c                |  2 +-
 net/sctp/outqueue.c                       |  2 +-
 net/tipc/node.c                           |  2 +-
 19 files changed, 52 insertions(+), 46 deletions(-)
