Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D43FCDB47F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6F2910E9E4;
	Tue, 23 Jun 2026 08:07:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kknM7Rpq";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2586E10E82B
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 19:03:54 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-3042a388168so186243eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 12:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782155033; x=1782759833; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=uM6rjwv+rWrcNEl8KjTKnVcDSG3oUNpsPUMqnFOcLeE=;
 b=kknM7RpqLwfmysPItufd73g5bZ4WkYMpdqhyfA6hFXmJpkAemh665JQ5Zju7A1SxtG
 lkW2Dh2guhJ2Oams7nSNUZIY20ROwu0iCwr3qmjTODQRJbBjhrtCwM9hsz6z8QmoXo0y
 U1NS38ZBloFdwIpG/yEiLMXsVzQQpL62gXMOB/IHHYSogTTEgHwuf8j/32vJ4PVvpqaC
 1cOLJepIm/u2h3TSoxilzosjOmi7aFWISYmQ2oK1yR8Op6uwDJG7U7LQJTRnpNQFP/V3
 BsoCBw+fbVz+X8kqQRp6A85RIs8d5m5BGdXvpZUAseJ7Dd9vgmVz3EGlej5eHwlnV7XH
 7Sjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782155033; x=1782759833;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uM6rjwv+rWrcNEl8KjTKnVcDSG3oUNpsPUMqnFOcLeE=;
 b=ELB7zj2RBs/QmA9YXCicaBrYXUllpdjlSonw4qj6N6XPGgFe06+hc4MuGjathuExTN
 lQ0WqF+KBkNxf+Vth0XkQ8d7iGoyLghSF3QSf4HjOIti8S1KHlRnm5qO4SmLNRowXWav
 KnVroHvnqWJaU1MU9HR98M/ZESXqzCjlIxexkoV+z6AEjwbiYz0whK5HzuiMbwrfmRIx
 yH8mnToNEhGcWIhVfKi/wNle+GH3grDRZtLrn5bEC1U/qx3A0K7tunOChDSN5zNKFgBl
 oIGlEqBhFjTDb8HIBcUIJW838PKl0e2sZl8C+WL4/61wFaptAVBtsOsYKWmT/pDDvAgs
 EPEQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpxdUDd3vt0wVSR8C7uUn05VGJjkz3yl5G0OWuBp+hDwW3xrULeHQ4LYKn/+ITzNsawniit4IFaOQ0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1oJMlpbhFnUqMkUUJhCU/SDA5+0e3+eHFi7hMMJDpEElZAv7t
 taFoAUUz2s7qmgMEvSqzuanx+t5YdqfenmfeLbu4n9YbhbzSFjQLOX4g
X-Gm-Gg: AfdE7clFKB9NrMg8gjnfYGWG2/6j7lBxJYYycOiVR0tyefzIJulOPGkTwHi0UBTR2G/
 +EEioyHojNWXYnnCB9G8mjopCAfTYY1YBfc5+dHTA0abCdveYW7XaV2S9gJ5v83nUPcqD2961hV
 0yv+ED1usRI4msC5A+VEczzZex3C5SQvKLcCTVJ/blSZMzaGaN9aDTGia1KXU3tBNmFpxe5qKRK
 AO40G5h10ewDo0R5gnEGkUYg7UNHMeYJYY6uaMLxDMFvKb67j3SC6qhhWlIB/cn7+OLZQteYG95
 IehYFsAkXj5l4XwKFxYLRccgZYGy43XbNquMjiuHNQJkJ5Tu1JNztn/7vtEw6rFPAKebzELUuhV
 QobOJOfRWFt/GiCtZXryXo6ufELb/uSQkp2wdGO+YhKoN/rg/pIiwf7hhSNf2PLROFyAY4h4a1+
 0uhICZ9AiqnHOuCQ6favRwNOKbLYGUBXwFXaZBud8BwUnuCYZLLG914Gaub5Ib09ufxcI=
X-Received: by 2002:a05:693c:2887:b0:30b:cc4e:6396 with SMTP id
 5a478bee46e88-30c5553b105mr382073eec.7.1782155033135; 
 Mon, 22 Jun 2026 12:03:53 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:6e2:c699:67c:63fe?
 ([2620:10d:c090:500::1:5387]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1be4967fsm10549199eec.26.2026.06.22.12.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:03:52 -0700 (PDT)
Message-ID: <1979fc81ae7bdaabda8616cd9698a40ef8bbfaee.camel@gmail.com>
Subject: Re: [PATCH v3 5/7] kernel: Use mutable list iterators
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kaitao Cheng <kaitao.cheng@linux.dev>, Paul Moore <paul@paul-moore.com>,
 Eric Paris <eparis@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski	 <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend	
 <john.fastabend@gmail.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner	
 <hannes@cmpxchg.org>, Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, 
 Maarten Lankhorst	 <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock	 <natalie.vock@gmx.de>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar	 <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim	 <namhyung@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Oleg Nesterov	 <oleg@redhat.com>, Peter
 Oberparleiter <oberpar@linux.ibm.com>, Andrew Morton	
 <akpm@linux-foundation.org>, Baoquan He <baoquan.he@linux.dev>, Mike
 Rapoport	 <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav	 <pratyush@kernel.org>, Naveen N Rao <naveen@kernel.org>,
 Josh Poimboeuf	 <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Miroslav Benes	 <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Will
 Deacon <will@kernel.org>,  Boqun Feng <boqun@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,  Daniel Gomez
 <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Steffen
 Klassert	 <steffen.klassert@secunet.com>, Daniel Jordan
 <daniel.m.jordan@oracle.com>,  "Rafael J. Wysocki"	 <rafael@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>, "Paul E. McKenney"	
 <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes	 <joelagnelf@nvidia.com>,
 Uladzislau Rezki <urezki@gmail.com>, Juri Lelli	 <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Kees Cook <kees@kernel.org>,
 Balbir Singh <bsingharora@gmail.com>, Anna-Maria Behnsen	
 <anna-maria@linutronix.de>, Thomas Gleixner <tglx@kernel.org>, John Stultz	
 <jstultz@google.com>, KP Singh <kpsingh@kernel.org>, Matt Bobrowski	
 <mattbobrowski@google.com>, Nathan Chancellor <nathan@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, David Vernet	 <void@manifault.com>, Steven
 Rostedt <rostedt@goodmis.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, 	netdev@vger.kernel.org, cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 	linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, 	kexec@lists.infradead.org,
 live-patching@vger.kernel.org, 	linux-modules@vger.kernel.org,
 linux-crypto@vger.kernel.org, 	linux-pm@vger.kernel.org,
 rcu@vger.kernel.org, sched-ext@lists.linux.dev, 	llvm@lists.linux.dev,
 Kaitao Cheng <chengkaitao@kylinos.cn>
Date: Mon, 22 Jun 2026 12:03:46 -0700
In-Reply-To: <20260622042811.31684-1-kaitao.cheng@linux.dev>
References: <20260622040533.29824-1-kaitao.cheng@linux.dev>
 <20260622042811.31684-1-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:06:53 +0000
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

On Mon, 2026-06-22 at 12:28 +0800, Kaitao Cheng wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>=20
> The safe list iteration helpers require callers to provide a temporary
> cursor even when the cursor is only used internally by the loop. This
> leaves many functions with otherwise unused variables whose only purpose
> is to satisfy the old iterator interface.
>=20
> Use the mutable list iteration helpers for those cases. The mutable
> helpers keep the same removal-safe traversal semantics, while allowing
> the temporary cursor to be internal to the macro when the caller does
> not need to observe it.
>=20
> Convert list, hlist and llist users under kernel/ where the temporary
> cursor is not used outside the iteration. Keep the explicit cursor form
> where the next entry is still needed by the surrounding code.
>=20
> No functional change intended.
>=20
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---

Beside the fact that this does not apply,
I don't see a reason why is this needed for BPF sub-tree.

[...]
