Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D977060A261A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KWKvxb0P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B39B710F6A6;
	Tue, 27 Oct 2026 15:44:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A13A10F68F;
 Tue, 27 Oct 2026 15:44:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D82FF405B1;
 Tue, 27 Oct 2026 15:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80BC1F031E5;
 Tue, 27 Oct 2026 15:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793115854;
 bh=Sqrwxska1pJf5RJ9nDvLNAM3+XgodcmyKlBOM1kgm4U=;
 h=Date:From:To:Cc:Subject:References;
 b=KWKvxb0PF0Z8atNP5cI08N1vgaMfCtAZoVHzzExHoVgxLqp3sCUeJyEK1yt8D9p+v
 KViwbqpylH005cALulkKaMqye2teyyYZGweVKwHQK4lpE6zhd+8lL+Vre1f8+X9Xgt
 qKK6Ljk5w/dsLOgX0/FMmT/p7Q+ydvCAg4ZLZFx7zQEsoY0gBrjXxe+FakaLVzKjzm
 9Pprzoj7rddGZJcE7wY90qnWpW2tUGlTyC7Z/XVKPlwNwtZjpT51UboUvNttoBM1Nn
 ORqxmABvPO7RZuImlBqZYzeFDHvGRT7pGtW7ER57ZGEUAioylY4BbkZXkWAXalxCaY
 186al6GQ5BwKw==
Received: from rostedt by gandalf with local (Exim 4.100.1)
 (envelope-from <rostedt@kernel.org>) id 1xLjLR-000000078j5-47DU;
 Tue, 27 Oct 2026 11:44:13 -0400
Message-ID: <20261027154413.807515174@kernel.org>
User-Agent: quilt/0.69
Date: Tue, 27 Oct 2026 11:37:05 -0400
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
Subject: [PATCH 7/9] net: devlink: Use trace_call__##name() at guarded
 tracepoint call sites
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

Link: https://patch.msgid.link/20260515135953.2238907-1-vineeth@bitbyteword.org
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 net/devlink/trap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/trap.c b/net/devlink/trap.c
index 793ffc66dc11..d99427f3b953 100644
--- a/net/devlink/trap.c
+++ b/net/devlink/trap.c
@@ -1497,7 +1497,7 @@ void devlink_trap_report(struct devlink *devlink, struct sk_buff *skb,
 
 		devlink_trap_report_metadata_set(&metadata, trap_item,
 						 in_devlink_port, fa_cookie);
-		trace_devlink_trap_report(devlink, skb, &metadata);
+		trace_call__devlink_trap_report(devlink, skb, &metadata);
 	}
 }
 EXPORT_SYMBOL_GPL(devlink_trap_report);
-- 
2.53.0
