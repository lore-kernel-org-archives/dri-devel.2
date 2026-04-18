Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF85FF99C98
	for <dri-devel@archiver.kernel.org>; Sat, 18 Apr 2026 23:05:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C985510E260;
	Sat, 18 Apr 2026 23:05:38 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com
 [216.40.44.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A465810E260
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 23:05:37 +0000 (UTC)
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
 by unirelay01.hostedemail.com (Postfix) with ESMTP id 3A610E4C26;
 Sat, 18 Apr 2026 23:05:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by
 omf17.hostedemail.com (Postfix) with ESMTPA id D63C017; 
 Sat, 18 Apr 2026 23:05:02 +0000 (UTC)
Date: Sat, 18 Apr 2026 19:04:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Dmitry Ilvokhin <d@ilvokhin.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, Jens
 Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Marcelo Ricardo
 Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, Jon
 Maloy <jmaloy@redhat.com>, Aaron Conole <aconole@redhat.com>, Eelco
 Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-sctp@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, dev@openvswitch.org, Jiri Pirko
 <jiri@resnulli.us>, Oded Gabbay <ogabbay@kernel.org>, Koby Elbaz
 <koby.elbaz@intel.com>, dri-devel@lists.freedesktop.org, "Rafael J.
 Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Huang Rui
 <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, Len
 Brown <lenb@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, linux-pm@vger.kernel.org, MyungJoo
 Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 linaro-mm-sig@lists.linaro.org, Eddie James <eajames@linux.ibm.com>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 linux-fsi@lists.ozlabs.org, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Danilo
 Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 amd-gfx@lists.freedesktop.org, Jiri Kosina <jikos@kernel.org>, Benjamin
 Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, Mark Brown
 <broonie@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, "Martin K.
 Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, Chris
 Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Andrew
 Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>,
 linux-mm@kvack.org, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/19] tracepoint: Avoid double static_branch
 evaluation at guarded call sites
Message-ID: <20260418190456.631df6f3@fedora>
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 14j39sducs3tg3aey13ys76m4wq4pf1a
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: D63C017
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18uI1/Yo7/rI1+CwnTJAuzOiDhDTcHCmFM=
X-HE-Tag: 1776553502-227936
X-HE-Meta: U2FsdGVkX19V5aRBuQVgNrwFYqJny3DiV29cPCLORtmFjnJgNsHv2iodpq+DK7eFwvzFvhgzZ+I=
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

On Mon, 23 Mar 2026 12:00:19 -0400
"Vineeth Pillai (Google)" <vineeth@bitbyteword.org> wrote:

>   if (trace_foo_enabled() && cond)
>       trace_call__foo(args);   /* calls __do_trace_foo() directly */

Hi Vineeth,

Could you rebase this series on top of 7.1-rc1 when it comes out?
Several of these patches were accepted already. Obviously drop those.
They were the patches that added the feature, and any where the
maintainer acked the patch.

Now that the feature has been accepted, if you post the patch series
again after 7.1-rc1 with all the patches that haven't been accepted
yet, then the maintainers can simply take them directly. As the feature
is now accepted, there's no dependency on it, and they don't need to go
through the tracing tree.

Thanks,

-- Steve
