Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B32CD98F2
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 13:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E85510E312;
	Sun, 21 Jun 2026 13:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qrjqWZ3v";
	dkim-atps=neutral
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15D7410E312
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 13:08:39 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-7fdbd0960b9so28914487b3.3
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 06:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782047318; x=1782652118; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JelQF+PgdiILboeOL52+qm2l/XNW/EjjD3ktKV3cKe4=;
 b=qrjqWZ3vz+hY3C3NDdZ95QX+TwF+5h4R68ylMOJE1B0xjQhudBCXjnNlv87+WNBY5f
 oLFBK5f0+WQGgl8joKA2v1tuZThAuQlfMmC2Wselh8AI+XRzfssDSqh62BEOkIa6e4bV
 OuyuIkYV/vyE0QL1NAJ0Kz6zvuNf4xvAff3rER4RFS0d7e6pN5zb4W7igZB3YRg4h4x3
 tfrPD7L1oV7B5QeXxPi+8MMFQO8/31fvmHVEkxMiKpQFNEp9VAm+LFKOH7Tff7yrjCnA
 b3M+wnhNEX/3EI08Sk6Ly5AgAJTfqrnOWQM8QAMryx46JpzhcWjKXFYsYHHeoocao4xi
 mNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782047318; x=1782652118;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JelQF+PgdiILboeOL52+qm2l/XNW/EjjD3ktKV3cKe4=;
 b=koM20eNZ4oYyJ9manG1SQs1c1TyuRE6JbQ4rWRKQbID+VhUHjxxxFBQ/lylcGix9rb
 N3PhDtWFwMSEfYK2heX0Uwg56WRt8bUXZEKJS+kEwTvCwjpUyilQnH5EUyzBe1xrT4n1
 4tQ5XoKY88pLRoJE2Q5SaYPnBUkHCm8uXH8Ew4MhqxemWhuTMKL/0X4kE6sxbkRLLMRt
 btWlJXLvhCRNgjV7CSxnyk26TzrSZSvloypiEW00VbNWVn0BYexwN5r8Mi2YmPU6q3zR
 ht04rWAfQuKulSOA+gyJ/YQrF9Jrp1CrZf6AbUkx54njmxcVCforid/OYhCSb8UBdBnj
 oNww==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMUiNL4RdagWcB6jhw3W6Fats6d6GJstAANs8TmmUUgwKMnRsf5RkC3Op//nB8JRq/e4yFSPr4sFg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRBvvVy2FSvlrlDmFSo+1gA/7qtdj2POur2avbDKmOMeiNWWBE
 J723eLnrEKLolLOtAXn2Rx/Y4U6tD88SLlGBeGKZiqkt3OF4a4ZRXcgV
X-Gm-Gg: AfdE7cntjQjDpZyUglCtn60iAju6fsLlkcQdWyhFK2BVPJh7e/erNwVK75TEe72Mria
 JH4UggwVuhDybcw37O2Vvp7OVKTxIyncoP8FG3CnMvAKnHar56aNx6t63q17iEchYecOt3Kuntf
 /6qnUhYAni+2pddMfgLLTyIJrzYRCCmBTPq7uTCgfKzpUiBhWMcEGWNf2PX+fvwsAvdUip6buB/
 ARfblsl38NLXnRXDoDKUvinem0l4jHpMcW7/b1C7id2fu9mMBZNm6QrNEOaPwwmxTDfW0V4G6dp
 W+nblp8jfd1i3sFofjDRylE4tc8NR3/myOWSPhYwkukOfEjYlKfp46ARurVjA3LtUfJseHZM+tC
 eproq4HkkBjlOYUlXElLrHQciw1+wZbP4hERMGskQSztdouRWtBm8vuEGqpfxZ/ViCbz0fVbV4A
 uz9l8k7oJKkwpEdHCF9Ry+EOs7R+43/KtaQiU=
X-Received: by 2002:a05:690c:6881:b0:7fd:5297:28da with SMTP id
 00721157ae682-80139103c73mr119142517b3.49.1782047317965; 
 Sun, 21 Jun 2026 06:08:37 -0700 (PDT)
Received: from localhost (user-24-214-85-55.knology.net. [24.214.85.55])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025cf693f8sm20544597b3.15.2026.06.21.06.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 06:08:37 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Sun, 21 Jun 2026 09:08:37 -0400
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>, Thomas Gleixner <tglx@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Julia Lawall <julia.lawall@inria.fr>,
 Yury Norov <yury.norov@gmail.com>, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/2] tracing: Move non-trace_printk prototypes back to
 kernel.h
Message-ID: <ajfiVTlCIVlqW3sh@yury>
References: <20260621093430.264983361@kernel.org>
 <20260621093811.007634476@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621093811.007634476@kernel.org>
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

On Sun, Jun 21, 2026 at 05:34:31AM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> In order to remove the include to trace_printk.h from kernel.h the tracing
> control prototypes need to be moved back into kernel.h. That's because

Please don't. Instead, you can split them out to trace_control.h, and
include where needed. I actually have a prototype for it, FYI:

https://github.com/norov/linux/tree/trace_pritk3

> they are used in other common header files like rcu.h. There's no point in
> removing trace_printk.h from kernel.h if it just gets added back to other
> common headers.
> 
> Prototypes are very cheap for the compiler and should not be an issue.

It's not about cost, it's about mess. kernel.h is included everywhere.
Is that API needed everywhere? No, it's needed in literally 10 files.
So, no place in kernel.h.
 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  include/linux/kernel.h       | 18 ++++++++++++++++++
>  include/linux/trace_printk.h | 17 -----------------
>  2 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index e5570a16cbb1..c3c68128827c 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -194,4 +194,22 @@ extern enum system_states system_state;
>  # define REBUILD_DUE_TO_DYNAMIC_FTRACE
>  #endif
>  
> +#ifdef CONFIG_TRACING
> +void tracing_on(void);
> +void tracing_off(void);
> +int tracing_is_on(void);
> +void tracing_snapshot(void);
> +void tracing_snapshot_alloc(void);
> +void tracing_start(void);
> +void tracing_stop(void);
> +#else
> +static inline void tracing_start(void) { }
> +static inline void tracing_stop(void) { }
> +static inline void tracing_on(void) { }
> +static inline void tracing_off(void) { }
> +static inline int tracing_is_on(void) { return 0; }
> +static inline void tracing_snapshot(void) { }
> +static inline void tracing_snapshot_alloc(void) { }
> +#endif
> +
>  #endif
> diff --git a/include/linux/trace_printk.h b/include/linux/trace_printk.h
> index 3d54f440dccf..879fed0805fd 100644
> --- a/include/linux/trace_printk.h
> +++ b/include/linux/trace_printk.h
> @@ -35,15 +35,6 @@ enum ftrace_dump_mode {
>  };
>  
>  #ifdef CONFIG_TRACING
> -void tracing_on(void);
> -void tracing_off(void);
> -int tracing_is_on(void);
> -void tracing_snapshot(void);
> -void tracing_snapshot_alloc(void);
> -
> -extern void tracing_start(void);
> -extern void tracing_stop(void);
> -
>  static inline __printf(1, 2)
>  void ____trace_printk_check_format(const char *fmt, ...)
>  {
> @@ -176,16 +167,8 @@ __ftrace_vprintk(unsigned long ip, const char *fmt, va_list ap);
>  
>  extern void ftrace_dump(enum ftrace_dump_mode oops_dump_mode);
>  #else
> -static inline void tracing_start(void) { }
> -static inline void tracing_stop(void) { }
>  static inline void trace_dump_stack(int skip) { }
>  
> -static inline void tracing_on(void) { }
> -static inline void tracing_off(void) { }
> -static inline int tracing_is_on(void) { return 0; }
> -static inline void tracing_snapshot(void) { }
> -static inline void tracing_snapshot_alloc(void) { }
> -
>  static inline __printf(1, 2)
>  int trace_printk(const char *fmt, ...)
>  {
> -- 
> 2.53.0
> 
