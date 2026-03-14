Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB15107BCEA
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 00:24:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2820E10E06E;
	Sat, 14 Mar 2026 00:24:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i0nggihj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12283891B8;
 Sat, 14 Mar 2026 00:24:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1B71A408E8;
 Sat, 14 Mar 2026 00:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088E7C19421;
 Sat, 14 Mar 2026 00:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773447856;
 bh=WQRXpjIwf6KYkSpJNf4xnZTekqBOFUxWV+yK0mOoxb8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i0nggihjXmXTKML8sut6lB5srcFWHmMKN3tSb0vnbiKDcMNVltZU2CmPxcxFrG3o3
 nQrXA1wQ5YuTbmhgcTPNORS+379TzqDGm/7lSrQ1+WOrB6YJhRCIjKA7zUUcBgPch0
 EYChM4p2xmMbNvogwcdaYFHJ9nHAZ56sOZLrj4G67jwJtQWWuJzeM6LK+rXxZtPvPL
 7hsCy1/fez24lkAmdr6y8xZG7yqBOpidyJ0h37yL3W7fcEPRQk675mEsDmHjbA8Xn+
 hN93oY8bX37rGdXAEkgAe3QI7f5zrI2DHLm42gIk1V7HmETARtzUHgwH52MHcPBfBz
 VF6ZMYEbGWSgg==
Date: Fri, 13 Mar 2026 18:24:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>, Dmitry Ilvokhin <d@ilvokhin.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 io-uring@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-sctp@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, dev@openvswitch.org,
 Oded Gabbay <ogabbay@kernel.org>, Koby Elbaz <koby.elbaz@intel.com>,
 dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Huang Rui <ray.huang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Len Brown <lenb@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 linaro-mm-sig@lists.linaro.org, Eddie James <eajames@linux.ibm.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, linux-fsi@lists.ozlabs.org,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-i2c@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] tracepoint: Add trace_invoke_##name() API
Message-ID: <abSqrJ1J59RQC47U@kbusch-mbp>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-2-vineeth@bitbyteword.org>
 <20260312111255.7925b4e2@gandalf.local.home>
 <CAO7JXPhg-Etspj9YahZrq8cmZ2K6AGWDrMnHO+oD96P_SmOLBw@mail.gmail.com>
 <20260312155326.GB1282955@noisy.programming.kicks-ass.net>
 <CAO7JXPiu8-LE_gG001_GQLoGVYakPdzmH2SXLqfzJjEUxbn1Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO7JXPiu8-LE_gG001_GQLoGVYakPdzmH2SXLqfzJjEUxbn1Rw@mail.gmail.com>
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

On Thu, Mar 12, 2026 at 12:05:37PM -0400, Vineeth Remanan Pillai wrote:
> On Thu, Mar 12, 2026 at 11:53 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > That seems like an unreasonable waste of energy. You could've had claude
> > write a Coccinelle script for you and saved a ton of tokens.
> 
> Yeah true, Steve also mentioned this to me offline. Haven't used
> Coccinelle before, but now I know :-)

[+ Chris Mason]

At the risk of creating a distraction...

This discussion got me thinking the right skill loaded should have the
AI implicitly use coccinelle to generate the patchset rather than do it
by hand. You could prompt with simple language for a pattern
substitution rather than explicitly request coccinelle, and it should
generate a patch set using a script rather than spending tokens on doing
it "by hand".

I sent such a "skill" to Chris' kernel "review-prompts":

  https://github.com/masoncl/review-prompts/pull/35

I used patch one from this series as the starting point and let the AI
figure the rest out. The result actually found additional patterns that
could take advantage of the optimisation that this series did not
include. The resulting kernel tree that the above github pull request
references cost 2.8k tokens to create with the skill.
