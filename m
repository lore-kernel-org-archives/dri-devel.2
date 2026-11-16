Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA8F606A32F
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cS6IUWLJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8529410F304;
	Mon, 16 Nov 2026 16:58:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECB9D10F31C;
 Mon, 16 Nov 2026 16:58:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D282D463EC;
 Mon, 16 Nov 2026 16:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169491F000C4;
 Mon, 16 Nov 2026 16:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794848301;
 bh=v1ZC4177952dmHFY2wm5BMhliYJM81FgXxiUJDLBSTU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=cS6IUWLJGJW9ttvChNIu/I+/2Zy7qvZLcXWboveVYFVr2BTg+4jiDDlCpMPhtybac
 sowK9bL39zN/6D8Yd4UhOFznlYfpMKMbWfFEKyu7dHTQi3IEzELWbHbR7ApLdv/W4j
 sNDUJwiH8qp4QRWHlGfKJlvZDvzVMIowKYd3BLdVZfe6U2eYYlZtrNxd1FlcBNSjGq
 mki+zJipKsI31SuAjy8bISj92bqM3cI6PcaVGrh3lHkofvtfgdAm1ll2spRz6/r6RK
 VCk+mXFZvS3pGcZmN5DWBhMqfjQSaxuULPlV0w4WjivZN0lnuiHIq+nCwMRKSPGE3f
 AXrv52JcVylVQ==
Date: Mon, 16 Nov 2026 11:58:10 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: Choi Chanwoo <cwchoi00@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vineeth Pillai <vineeth@bitbyteword.org>,
 Peter Zijlstra <peterz@infradead.org>, Aaron Conole <aconole@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>, Alexei Starovoitov
 <ast@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Borislav
 Petkov <bp@alien8.de>, Chanwoo Choi <cw00.choi@samsung.com>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Danilo Krummrich <dakr@kernel.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, David Airlie <airlied@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eelco Chaudron <echaudro@redhat.com>, Eric
 Dumazet <edumazet@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
 Ilya Maximets <i.maximets@ovn.org>, Ingo Molnar <mingo@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Jiri Pirko <jiri@resnulli.us>, John Fastabend
 <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>, Koby Elbaz
 <koby.elbaz@intel.com>, Konstantin Sinyuk <konstantin.sinyuk@intel.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, "Martin K. Petersen" <mkp@kernel.org>, Matthew
 Brost <matthew.brost@intel.com>, Maxime Ripard <mripard@kernel.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Oded Gabbay <ogabbay@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Philipp Stanner <phasta@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Gleixner <tglx@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 tipc-discussion@lists.sourceforge.net, Tung Quang Nguyen
 <tung.quang.nguyen@est.tech>, Xin Long <lucien.xin@gmail.com>,
 x86@kernel.org, amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org,
 dev@openvswitch.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH 3/9] devfreq: Use trace_call__##name() at guarded
 tracepoint call sites
Message-ID: <20261116115810.719f4e18@gandalf.local.home>
In-Reply-To: <2d8dbfaf-46d3-4d05-b052-5e8a8670931e@gmail.com>
References: <20261027153658.703730257@kernel.org>
 <20261027154413.039021489@kernel.org>
 <2d8dbfaf-46d3-4d05-b052-5e8a8670931e@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 14 Nov 2026 23:11:05 +0900
Choi Chanwoo <cwchoi00@gmail.com> wrote:

> Applied it.

Thanks a lot!

-- Steve
