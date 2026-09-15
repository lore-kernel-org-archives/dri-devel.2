Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFCFC88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17D4810FC1A;
	Tue, 15 Sep 2026 11:50:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FZyLQujg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01FA310FC16
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:50:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D088C414F1;
 Tue, 15 Sep 2026 11:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA52D1F00898;
 Tue, 15 Sep 2026 11:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789473007;
 bh=Wvy04NbJid/rHT9Oo2y6und5H0C/2sS7C4rNvZsUJ+M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FZyLQujgrSLTLItt0atdLygYtPLJy07BtTpqJEj8tK4rCFepTR6WTdgjVU1CUaviY
 /2kxpiaHyjwEq8od5PpCP63amvdhTsJyZVoAXJVFzklNTY1gegcdWYDDoR+/XePScz
 MHrJT4NoUt8HIfXHRaVC5PMjCIQJVPlEkfbh8gaQY1dgXLLaPf3I5PVcxiOdPbdNhp
 egKHXLxlo+8hU8IJMPwEDm1igMoQNQ50LWjgaSmTwzy6Kkr1xxWZeZvflO3a23mVwB
 kOkyNkCaEN1wr6HpAzVJp/5fzNLTwrIjdFvuyd/aBdf6hTcIxBdJ3Y3aTJX6C30ppL
 nzwCXruPvLzow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 09/50] m68k: commit fds on syscall exit
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>
Cc: kexec@lists.infradead.org, linux-openrisc@vger.kernel.org,
 io-uring@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-mips@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-mm@kvack.org, linux-sh@vger.kernel.org,
 "Jann Horn" <jannh@google.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, bpf@vger.kernel.org, linux-hyperv@vger.kernel.org,
 kvm@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-hexagon@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-um@lists.infradead.org, "Michael S.
 Tsirkin" <mst@redhat.com>, linux-parisc@vger.kernel.org,
 "Peter Zijlstra" <peterz@infradead.org>, "Jan
 Kara" <jack@suse.cz>, dri-devel@lists.freedesktop.org, =?utf-8?b?Q2hy?=
 =?utf-8?b?aXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>,
 linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, "Oleg Nesterov" <oleg@redhat.com>,
 linux-fsdevel@vger.kernel.org, "Alexander Viro" <viro@zeniv.linux.org.uk>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-9-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-9-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:50:04 +0000
Message-Id: <20260915115004.CA52D1F00898@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] m68k: single-step SIGTRAP lost on fd-allocating syscalls
--

commit 731b1387fc76d92d165ee1f28de694e3d228627b
Author: Christian Brauner <brauner@kernel.org>

m68k: commit fds on syscall exit

Add TIF_FD_SLOTS and test it on the untraced return from a system
call in all three entry paths. A task that reserved descriptors calls
syscall_trace_leave(), which commits them before the ptrace exit stop.

[ ... ]

> diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
> index 338b474910f74..9e4471f681652 100644
> --- a/arch/m68k/kernel/entry.S
> +++ b/arch/m68k/kernel/entry.S
> @@ -229,6 +229,8 @@ ret_from_syscall:
>  syscall_exit_work:
>  	btst	#5,%sp@(PT_OFF_SR)	| check if returning to kernel
>  	bnes	1b			| if so, skip resched, signals
> +	btst	#4,%a1@(TINFO_FLAGS+2)	| TIF_FD_SLOTS: commit descriptors
> +	jne	do_trace_exit

[Severity: High]
Does this new branch cause delayed trace (single-step) SIGTRAPs to be lost?=
=20

If a process is being single-stepped (TIF_DELAYED_TRACE is set) and execute=
s a=20
syscall that allocates file descriptors (TIF_FD_SLOTS is set), this=20
unconditionally branches to do_trace_exit.=20

Looking at do_trace_exit, it executes syscall_trace_leave() and then direct=
ly
jumps to the exception return path, bypassing the jmi do_delayed_trace logi=
c=20
completely.=20

This means single-stepping over a system call like open() could fail to=20
deliver the expected SIGTRAP, which might break debugger functionality.

>  	lslw	#1,%d0
>  	jcs	do_trace_exit
>  	jmi	do_delayed_trace

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D9
