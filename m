Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D2B103E302
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8712110EB18;
	Fri, 13 Mar 2026 08:25:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OpqdOLUy";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DCE610EA84
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 16:54:44 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-358ed696623so569890a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 09:54:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773334483; cv=none;
 d=google.com; s=arc-20240605;
 b=E6cuXJpQ9nNXML4p0SInkvt4zhUxSSUQNBWvjFsWTOqwjcfeZntjwzFz2u3QJu29+K
 0TKIg/E2twNBHwxnzWWSOw3zWeTUkMvrH5QO45fqE8A5GhUoIEI4edb2RBJVmMSUTP3p
 AETG8BCABD60gpePcxIf8DYKDUCZJmfQqWgTTXtd2EUZ0gNmWU+HNuMqSJhuVHgdtc+Y
 1qxHWh5qTHTW+t2dpUXXgY87ao/9zpsm0Q33QlAADFdJl5mPWce61c31odEDTv7tMGM9
 1+ZaqQkeM77ZRmBf/6sRe/IZwVcMQwgGkeDTZG9w7dTvQtXop7ZXPSrP7GnFrndqowlA
 +q1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+kWy5KRAZzJ0k+gfnUe4+KiD3cukw8nZMNARL7dWDnQ=;
 fh=NmMar6WAM3ICnv9cGYtOrgWJujITKhYtDR5b6K6L07U=;
 b=O7i4GvOe2dUjOBvxPAZ8hmMKm6soj1+gVyH1oDCC7My2QGU3T1bGyV5jSecB6AflKY
 M10Jchjupnx/UHpa00kZQJ7dP/ecQduF33hmgDjfaa3vgutG08zc22PxVkhLrVV4tsf/
 pwXixnop0tmKVEhoGB+IJUxqLg0oUB3opECtSwtPQ4L8U2UhU5lfyx9qCF2h3i5QVVOi
 emo3c2AVZyHnM/R5RFiZK9beQB+HtjPtAF315M2f21exTcuIYZNudEuH1FasaH1PEzEK
 P2Ztf9JlAD40V2ItMRqfZUJBHm/c/cJSFCKY53OCHI3GIjzs8bthvjgktQGpfoiB/GvN
 X7nw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773334483; x=1773939283; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kWy5KRAZzJ0k+gfnUe4+KiD3cukw8nZMNARL7dWDnQ=;
 b=OpqdOLUy9qMvN5bHwEES8gq6ubqcg1HzHYMh97JRbsERufjCnMka6xTkoRLtUW4OIf
 4blHMlI3X6mlEomz9NrRqXEZ3Fgx8XY4lvoM8siCsLdIn6xwIk5FYU4fucKHg9ugQZzR
 Q7lzLSCYU/VBm+DF/KHu9lv74Q368pV9IOAyT75e6ZrLU8/XQKxWE8fo+PIxxh4dWOsq
 AQrgyb8zyZVV2kl5A4PFHaJ0iTDc/7OMgzzdyhCAlHSy7ai486k/RRDPWuIYcq9qthqP
 kWikP33wDWj3G0dbmUNZKGCvfNES438IolqjSNNBx+YPNAIQc+dZB93vd8tNjnv6dxak
 IjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773334483; x=1773939283;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+kWy5KRAZzJ0k+gfnUe4+KiD3cukw8nZMNARL7dWDnQ=;
 b=gxlCFG+F8C9nV5N2/+HlaEwBxhtCIJ9NgMwGf6CRK1dHP1jLPPd0RUfNvXpxgbUxD7
 ELwhpaxnNWRX4Ld6pi42M4928zsFp11bo7mpwfj7cv8qgXOndUqwsNDkdZhxvG50enxq
 9OWHLYunWnYTQYECHxdi0b+WToHAajgM9s06lgoY5MOOlNGQxOhuJHNQlTtCQzjE8m6m
 ijcJepeWtYIS1uhV+AbAWYcvuo4bPfDRkqkCItO9E+N9LcnUPfhGg8Y5+/isR5bFF9LV
 A2ooeaJydIVVDgwpRY9H6JpbKjqxwNlkQXuitegvPql8HVsm739mRbq7zkrUXXRwqIa4
 Smeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiBmnfFNpFBHCeveqLALd06ek6K2WVncdn5QSkL3FQtCxeNVx6Kt3Wv5IRQ4qh4H00B7dV2brT9K8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDlwGXgdbEhVa7dL28MgtRwjlj7GYm1wMA4fxvK5dvu5T5JTEh
 lW1RtRkzmy1QHUsZ1W12V3vfSI3FrJcR4yKCBp1ntrfgnmu0lhK2cRdnFcqmN5CRwUEdHShGc72
 ZNOXIW3G76VB+PE61Va5kygK/WNxHuxI=
X-Gm-Gg: ATEYQzx1tFnvDuPiWFQRCLMdaa8UWbN7jfpu4tAeGxR2BeESGPbCXGlPvOXxvrstSxm
 w8km06O44uV2+EAM5tn//kEfTQIDRaEPTZolBRioWembkLumfGkN5thAs82Vlth79nQFpsCnaSc
 S+cEu5wneUrlYUY+SkeRNNJiDl8FPe2tFZKWt/E8ev0utNh5qq+NFP1W4UxXCEeP28G5yPiSYuu
 vezWvRlCWEQQzvx44u9HBoZSWahOegXBZ0YPM423qQ7bqeme1jF9ULNvsnj5dOFgOH9tqTJ/mxO
 8dMOYe4ByqtXhAFQ5lH/kao=
X-Received: by 2002:a17:90b:288e:b0:359:8d0d:5905 with SMTP id
 98e67ed59e1d1-35a21eba194mr250522a91.9.1773334483388; Thu, 12 Mar 2026
 09:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <1e3c2830-765e-4271-89f7-0b6784b37597@efficios.com>
 <20260312112354.3dd99e36@gandalf.local.home>
 <219d015d-076b-4c80-8f63-88569115fdad@efficios.com>
 <20260312114041.5193c729@gandalf.local.home>
 <1becdbce-2c01-468a-bbab-42b5dea9fdf8@efficios.com>
 <CAO7JXPjnnruhM5oC6xMgnYaQ9efzYFqMCFiJLNM3HCQ+ZeCiJw@mail.gmail.com>
In-Reply-To: <CAO7JXPjnnruhM5oC6xMgnYaQ9efzYFqMCFiJLNM3HCQ+ZeCiJw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Mar 2026 09:54:29 -0700
X-Gm-Features: AaiRm51tg7oVvkVGab0X55k0oYxIuUltKNvtNsrbO-Cw57of2y67mwv1ziUvJS0
Message-ID: <CAEf4BzbnfyhCqp0ne=2gRnVxp-mdGmuZwDeFRyhRYH+eDcz2-w@mail.gmail.com>
Subject: Re: [PATCH 00/15] tracepoint: Avoid double static_branch evaluation
 at guarded call sites
To: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>, 
 Peter Zijlstra <peterz@infradead.org>, Dmitry Ilvokhin <d@ilvokhin.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, 
 io-uring@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Xin Long <lucien.xin@gmail.com>, 
 Jon Maloy <jmaloy@redhat.com>, Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-sctp@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, dev@openvswitch.org, 
 Oded Gabbay <ogabbay@kernel.org>, Koby Elbaz <koby.elbaz@intel.com>, 
 dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
 Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
 Len Brown <lenb@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, linaro-mm-sig@lists.linaro.org, 
 Eddie James <eajames@linux.ibm.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, linux-fsi@lists.ozlabs.org, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alex Deucher <alexander.deucher@amd.com>, Danilo Krummrich <dakr@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 amd-gfx@lists.freedesktop.org, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 13 Mar 2026 08:25:02 +0000
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

On Thu, Mar 12, 2026 at 9:15=E2=80=AFAM Vineeth Remanan Pillai
<vineeth@bitbyteword.org> wrote:
>
> On Thu, Mar 12, 2026 at 11:49=E2=80=AFAM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> >
> > On 2026-03-12 11:40, Steven Rostedt wrote:
> > > On Thu, 12 Mar 2026 11:28:07 -0400
> > > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > >
> > >>> Note, Vineeth came up with the naming. I would have done "do" but w=
hen I
> > >>> saw "invoke" I thought it sounded better.
> > >>
> > >> It works as long as you don't have a tracing subsystem called
> > >> "invoke", then you get into identifier clash territory.
> > >
> > > True. Perhaps we should do the double underscore trick.
> > >
> > > Instead of:  trace_invoke_foo()
> > >
> > > use:  trace_invoke__foo()
> > >
> > >
> > > Which will make it more visible to what the trace event is.
> > >
> > > Hmm, we probably should have used: trace__foo() for all tracepoints, =
as
> > > there's still functions that are called trace_foo() that are not
> > > tracepoints :-p
> >
> > One certain way to eliminate identifier clash would be to go for a
> > prefix to "trace_", e.g.
> >
> > do_trace_foo()
> > call_trace_foo()
>
> This was the initial idea, but it had conflict in the existing source:
> call_trace_sched_update_nr_running. do_trace_##name also had
> collisions when I checked. So, went with trace_invoke_##name. Did not
> check rest of the suggestions here though.
>
> Thanks,
> Vineeth
>
> > emit_trace_foo()
> > __trace_foo()

this seems like the best approach, IMO. double-underscored variants
are usually used for some specialized/internal version of a function
when we know that some conditions are correct (e.g., lock is already
taken, or something like that). Which fits here: trace_xxx() will
check if tracepoint is enabled, while __trace_xxx() will not check and
just invoke the tracepoint? It's short, it's distinct, and it says "I
know what I am doing".

> > invoke_trace_foo()
> > dispatch_trace_foo()
> >
> > Thanks,
> >
> > Mathieu
> >
> >
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > https://www.efficios.com
>
