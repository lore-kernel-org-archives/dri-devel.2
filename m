Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97ED107760E
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 19:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E246810E7AF;
	Wed, 18 Mar 2026 19:50:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="Q+gK1WmE";
	dkim-atps=neutral
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B426110E7C4
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 10:58:58 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-79a60975dc5so23527357b3.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 03:58:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773831537; cv=none;
 d=google.com; s=arc-20240605;
 b=PsBgqETOIS7tajG0l6DO2rC9kNiutkcMF5paFRHG7F2ifxL623weOmPZ1V5WZa3Kkg
 bdZ4r1jOsNjR0y39vElQ52Fbv4KByeFjOg4toq/s0VhhTf7gdmhCvY+wv47GK+t1jq4e
 7azYpJCbQXjcLwEs7wZQ7rCh6RrMVWwscJzpAvGf6exiWIwhpbxK5K6rxvbYpUtiGbc2
 YkuVYtPHYNhbu/8Of84e8CYpjQNkleEVrukqWTCxGhWRHZ49TsZGuts26Xuow8DYQsHe
 xTWddgky6j4CB15j0bLy0maSbx3FuJJTt2OsxqDtes0pDsa0iKWspiurNWcdZfSnQPR8
 8hoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LVVELEXkmiKTU/p+oy+of4jebFSUmNrxF9w9nex4moo=;
 fh=jUvXxAKfL5rgH30lowKAj/kOJFDgrSPwZxnAqIeHVrw=;
 b=Oy5V3nmhjV0OFFjzWbtv7T5CptQC0hWFE7Syehh/796fY2Mav5n9mFQ62o54yjlnBA
 ymw4LOVQC5q24rN8PPQmQy1MZq0+0WqhaAwn0ud4tJAnoLm/3nZOdehi1eKEQGfu1LNq
 NJ693/W17D6wBzOn+zqetbY9bdT74KFuvrwL03xQrawmaqar8ShUBklSFmetAgMAYZZ/
 b2nF+eKbxUGn/JaVD4vi8uVd6MzunsK6u+VkNzV4jzai2D4dd/2OxwoU9kGTti3LyQWx
 BuYAUBr/YZ9Qw2dI/ir6vt7sAqaEAvKcD21AYfD0e1LU00l9S0wkCfLeU2xnDxG+HuxR
 Qn5A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitbyteword.org; s=google; t=1773831537; x=1774436337;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LVVELEXkmiKTU/p+oy+of4jebFSUmNrxF9w9nex4moo=;
 b=Q+gK1WmEqDF4mF72MTu1sD58qmH2l7gDUyNHroy8YKaXRllnW6ZH/bWrqxiIBMOPPt
 mEZOH0d00AT9gulIa2j/pmFLCExv7q+cILjFyKgRPUkF/5sTxWXZmatpY4DHw5pz0aVh
 t25EbnIGVgVQNOljYhqrDNSf9JhZ1hZZPmhjNSHsk031DQq+p6++On3bwtm/Magsdl4n
 URnoHP85UA7vE0VCqJ/abuqek+rX3nyKC7C9GnP119YYtp0qda7MqOjKWoeDAMpzkZge
 zB77cRnOWGuxlqyDCpRQNQ4f0DpPGglirfTnVJJFGlacQtY0gchElop0p2ai3pg05lBQ
 AGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773831537; x=1774436337;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LVVELEXkmiKTU/p+oy+of4jebFSUmNrxF9w9nex4moo=;
 b=Wpgzh4oIyp4HtEJa6vO0PijrazNmRwdPKo/l6/bkS3VLBrqjWdyQsM6by9WKbnDIL/
 hZEqh6UTr4IHEB1LGXWtLH1b8C7OS7/BLeV16TDF/ryTisPt/vqgum394HbDeBpxZ5wM
 i9J8YlNNWtGUAYy8+5fyWsqYJHD0IMLNTEVFkwgbknBaTKGgZdKjfRjhFhuVTItlyRSz
 uWWLvA+QqzIegXneY8W/014EP5qH4yz0JxkZPbdaolc0ojrx9kwFQc9VqutFHsYcujKR
 LQeVUwrEdK8S+NYqUjheHyoE+ZPOE1lScm6Gw1v3Wjat8UlW/FyA0AHwV7hjysF1lazb
 VnnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4EYYFuPZKmFbC+vaJgozuzIlUElhq3nQCgDCDkQyltzaX6uD8EaNk5Yq9u3mKzvtz9mEha8RoyHc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyogVanUXjOFsc6dytY86qPnqUD67kpBsRKFTFY7aMxeky9o5Sz
 7eAtLK5U36aRWy2ZZbkLqD27/XsnoXsf+5NCM/5gHy/2jBW2l3CXqOFhWRo8UuntnHkyhO9DYT0
 fxGg8NyFoDnTtKsg6t8pvO7cEzjZroEAlv5nz9z1IGg==
X-Gm-Gg: ATEYQzycSd0oFVGhwSMmA3fp3uZN7rdFUz0zUeTnhmbJ/BuMBKpirf+frwSv3Ngel9Z
 M0XZ20KUjIytGh2iTq9bChpV4co1bnmgfJNtXWHtKhe5cED+5VtR1P9jCzmxE0uTF6A71d3zfOS
 J3nfXFI8UxR6dThnDrirk/xw6fwJ0ybZkINphaIKNqLquC7qv0IDqR3lZk6skBYjRqDDWjvraDM
 4gPojfzedVUmcZMTqZi5RbsYbSM15ZqsJrQI7E29/TH9TJrZnZaQ3coUsrCywslLMzImxXNw6i4
 b5Z8LA4=
X-Received: by 2002:a05:690c:c50e:b0:79a:3a33:933 with SMTP id
 00721157ae682-79a71ad413dmr29714557b3.31.1773831537485; Wed, 18 Mar 2026
 03:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <1e3c2830-765e-4271-89f7-0b6784b37597@efficios.com>
 <20260312112354.3dd99e36@gandalf.local.home>
 <219d015d-076b-4c80-8f63-88569115fdad@efficios.com>
 <20260312114041.5193c729@gandalf.local.home>
 <1becdbce-2c01-468a-bbab-42b5dea9fdf8@efficios.com>
 <CAO7JXPjnnruhM5oC6xMgnYaQ9efzYFqMCFiJLNM3HCQ+ZeCiJw@mail.gmail.com>
 <CAEf4BzbnfyhCqp0ne=2gRnVxp-mdGmuZwDeFRyhRYH+eDcz2-w@mail.gmail.com>
 <20260312130255.6476e560@gandalf.local.home>
 <CAO7JXPgHYZ9zF1HFahb2447X85YRZCQQBHB6ihOwKSDtiZi8kQ@mail.gmail.com>
 <20260317120049.6a60fa88@gandalf.local.home>
 <6ca9f884-9566-4a82-9995-4c802a0bf8a0@efficios.com>
In-Reply-To: <6ca9f884-9566-4a82-9995-4c802a0bf8a0@efficios.com>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Wed, 18 Mar 2026 06:58:46 -0400
X-Gm-Features: AaiRm52iP799baA3h48fwfLjW02Pe87nEMlmDoXLIPKYRV2LFYQQkuww_KlSUU0
Message-ID: <CAO7JXPgbERfc_P+aPFB1+nR5ua3mZGbhdkbxCr0TFR4Cr6Khuw@mail.gmail.com>
Subject: Re: [PATCH 00/15] tracepoint: Avoid double static_branch evaluation
 at guarded call sites
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
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
X-Mailman-Approved-At: Wed, 18 Mar 2026 19:50:21 +0000
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

On Tue, Mar 17, 2026 at 12:02=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2026-03-17 12:00, Steven Rostedt wrote:
> > On Fri, 13 Mar 2026 10:02:32 -0400
> > Vineeth Remanan Pillai <vineeth@bitbyteword.org> wrote:
> >
> >>>
> >>> Perhaps: call_trace_foo() ?
> >>>
> >> call_trace_foo has one collision with the tracepoint
> >> sched_update_nr_running and a function
> >> call_trace_sched_update_nr_running. I had considered this and later
> >> moved to trace_invoke_foo() because of the collision. But I can rename
> >> call_trace_sched_update_nr_running to something else if call_trace_foo
> >> is the general consensus.
> >
> > OK, then lets go with: trace_call__foo()
> >
> > The double underscore should prevent any name collisions.
> >
> > Does anyone have an objections?
> I'm OK with it.
>
Great thanks! I shall send a v2 with s/trace_invoke_foo/trace_call__foo/ so=
on.

Thanks,
Vineeth
