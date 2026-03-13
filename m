Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2780D58B1C
	for <dri-devel@archiver.kernel.org>; Sun, 15 Mar 2026 11:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD57310E551;
	Sun, 15 Mar 2026 11:21:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="OUXLcKf+";
	dkim-atps=neutral
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67E8B10E153
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 14:02:46 +0000 (UTC)
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-64c9ebd1369so2225771d50.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 07:02:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773410565; cv=none;
 d=google.com; s=arc-20240605;
 b=RCUaGS7sVcmj8Gv0zkE+cDyMmC0S8mzs37hptOg5u78kNh66FwKQXMykPUyKefUc9B
 +gz8rX/OAXJIfXoD0evgREJhKFHg0oB1oA46oqSAiaW3b+CVtYu+WWjMJYwPENMZxan/
 rN0nuFjNHURnvgCYYtb1HtyFmNzivNdV1XDSwNKQW2ydkRbU2NNTXASE8jNjNOiKP6Iu
 5rsyvehTNwTo63dbzmFFxLdty/1H7g+YDZpPKfeZmAnWW8zuKyXJB2479iCpivttWWyE
 wV+gmK4UWerUwom2i8ucmwQW+83Ngryj6l1FQ0i3wv6taX0EitaEr9qj1lnoyXkM3/UE
 vYZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=a7/dI9iHAkAoxpT/Y/jlrZ1Uk/u+tnKK+1+hPiLUJTk=;
 fh=mcuvUrVN6QdI1/1lXJRIor9RUov6r2x4z0bcwezhcTM=;
 b=JL5i3QEFpBpUDOO/eMFy6UBEcec82i8Pgo4cOlNHOMQiRuvkivLmZ9uivP6OPzCkO6
 c0h9qpjlLzYqsEYcMPPz7v9zkK+DRbMU1J6GYBd7rT4A2I4vQpiLj/BGOKhrLpvioGDQ
 sfkh/6zjeluZ84gI+wqvA26ctA01NQQkUjNSx0mf9gtv2MiBRD6Z2sWoO4e+DsELzHw0
 CiXNTKF5KmU+B4U4EwTjmwCCvIo1K0HK2jhAAqbDlWRpslHldkW6+2mxLDWPim55eVjA
 zY2+t23pXfH125bmdUoQaY/HPbseahB3xSVtTdWk+ROh+lemCIBG888Js1VxFQnto6I5
 omzw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitbyteword.org; s=google; t=1773410565; x=1774015365;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a7/dI9iHAkAoxpT/Y/jlrZ1Uk/u+tnKK+1+hPiLUJTk=;
 b=OUXLcKf+YxtlG+gu5P6spfXm+Rd+FyDQSobBvy5ObOZv+K9msK0AizkIFBfwpuwV2j
 8goaxk6Mw3Oiel/n5AP3Wir5nu9vY/VtM490IwubJOw8z3sgBkJIJsWCBQ7tGPgVH4bD
 1KOT35FXflCnoNJF8Hf9EXNbZY7+8guN6yziCmIWgaZqYQZ2OJ5VlxBCh263gWfCo6Uf
 e6Yqwmy0LKc8sgcNl+UJzhCKgZooSyyrdUPZgs2CBZ7btBZWXflBmGCLLDQ+Nzjctmux
 Rpfb6Ms30RtQjdcIbR8ZZmOuxYtdVTHLm8a0QcLvJwWwNBL8GqQaUEbTH2a+j23vq5BU
 D2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773410565; x=1774015365;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a7/dI9iHAkAoxpT/Y/jlrZ1Uk/u+tnKK+1+hPiLUJTk=;
 b=AARR0nMT15iX+2kpqBNBg6tfdBb6NPLtAoSu67j4FQBOV+l14e/Sm9KzcQaBHriMOe
 OCR9yfwbpNDzDev0Gi6MVpooBLS0FiIta+LLrFFK/brMNYfMNxCwRot8mmqtwa4Hjt8H
 41w4lBzFFt3BvZvQAFWmfESojrUBkHiipR7vVF2V5+oaaxWRb583+yfRWXyIMcx8U08d
 4s2JzR3t5z8NyrDrNdJLFqF+zrKdJGSJ61wM2hg0FlzpQebKgb87oiipj6UKJeoTl/lq
 YjpGAhpl75yLVouzic2xeu4wgNR6IPlovlL6vQkcKQKGqba7dRNtlX44YRMulljE72jm
 O+Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJaOhiDZ8/CXNpTOMfLN69nQ2GXEsCD1sxEhBdjtN2RrI90FMCHkV8gfU40vwq4UuqvySZ+d149+8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxW8Lwk2k4tCl/CDCteBAhK0liQpryg7r+DQ2zEpEL8GNZFU+sz
 SYmuYOpOdclxUU3yct/Ec1nEYM2wWxkuWt6fwG0vnSQsfV0j6v2Y921kHIrJ33s5UcZl1tkDi2v
 7D5WCoT8h7K/ltsJqUj82rsdoHugPAtQa3zdGS5evRg==
X-Gm-Gg: ATEYQzxxipeU8BZZSkYXEkWZnYmLi2GDdVw8J7VdWVAU7SZDKqtrW/ku38AOC1o3+G5
 YvK06w9H2/VSv+NV5ghH76wwGx8Owym8bNwDgzp+XpW+ISzK4glY9D3ILMjAKavWJZVvvfLWq1X
 Ibf+ikKxx1xdJQp/XMFcndFneFFqN6/NT+0ebFJ044zSfspofcsZwvNZFaTLJ0b/n43D0Xqi89T
 fgK1hUACmSVnRnoAuTILkhN8K+RbunxLbjo+7VwZ9W2HwJPcwwm9WP056OB+eueV0voWN+85G1q
 5OGhomg=
X-Received: by 2002:a53:eccf:0:b0:64d:568b:bcb3 with SMTP id
 956f58d0204a3-64e62eeb40fmr2691449d50.9.1773410564388; Fri, 13 Mar 2026
 07:02:44 -0700 (PDT)
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
In-Reply-To: <20260312130255.6476e560@gandalf.local.home>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Fri, 13 Mar 2026 10:02:32 -0400
X-Gm-Features: AaiRm51K5Hc3O7_rOVK2jMiMzft9bvuP5pyZ-VF_j7db91GKvyylhuGDp34sRoA
Message-ID: <CAO7JXPgHYZ9zF1HFahb2447X85YRZCQQBHB6ihOwKSDtiZi8kQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] tracepoint: Avoid double static_branch evaluation
 at guarded call sites
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, 
 Dmitry Ilvokhin <d@ilvokhin.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, 
 Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
 dev@openvswitch.org, Oded Gabbay <ogabbay@kernel.org>,
 Koby Elbaz <koby.elbaz@intel.com>, 
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
X-Mailman-Approved-At: Sun, 15 Mar 2026 11:20:58 +0000
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

On Thu, Mar 12, 2026 at 1:03=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 12 Mar 2026 09:54:29 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > > > emit_trace_foo()
> > > > __trace_foo()
> >
> > this seems like the best approach, IMO. double-underscored variants
> > are usually used for some specialized/internal version of a function
> > when we know that some conditions are correct (e.g., lock is already
> > taken, or something like that). Which fits here: trace_xxx() will
> > check if tracepoint is enabled, while __trace_xxx() will not check and
> > just invoke the tracepoint? It's short, it's distinct, and it says "I
> > know what I am doing".
>
> Honestly, I consider double underscore as internal only and not something
> anyone but the subsystem maintainers use.
>
> This, is a normal function where it's just saying: If you have it already
> enabled, then you can use this. Thus, I don't think it qualifies as a "yo=
u
> know what you are doing".
>
> Perhaps: call_trace_foo() ?
>
call_trace_foo has one collision with the tracepoint
sched_update_nr_running and a function
call_trace_sched_update_nr_running. I had considered this and later
moved to trace_invoke_foo() because of the collision. But I can rename
call_trace_sched_update_nr_running to something else if call_trace_foo
is the general consensus.

Thanks,
Vineeth
