Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7968CDB46B
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 13:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D21F910E3A4;
	Sun, 21 Jun 2026 13:39:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i0v6P9Jg";
	dkim-atps=neutral
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1969010E3A1
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 13:39:19 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-7ff05e5d009so33580407b3.1
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 06:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782049158; x=1782653958; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YUsaj7vv5ecLJDUQ0RmLhOH3YlF5lnncSJLJl2FpGbU=;
 b=i0v6P9Jgjd5hcKWmMDxYoISQb2TzRKzvipFQtMJv1dtjyzMwLSEH1cnIJ9kkMZH+GO
 JS9w2P4+qKPb8xjs8FtBA1rKjRiwA6Tk92kZrklMQjEiw952HcB9+58NwLEt9AIqMPVD
 coy6Y+MgRx6WnAk3E4laba8fZIKYBC+Yx4lBYu31JU3kA51UEr+WPg5MpiHWhDUIzDqw
 mHYrk37ZjUhfPT75JMVSZBBN6vWd7keYPaNxMT/I0WJIvA4Q49pCBAg0nQ5KWHXVInll
 PwGzWODCu57gVayXRsCIorf9ITKsye3lb6ZUScInsohNN8/wbZcAK/3kG+RTW4PWmJd2
 ufFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782049158; x=1782653958;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YUsaj7vv5ecLJDUQ0RmLhOH3YlF5lnncSJLJl2FpGbU=;
 b=N224pgzd1IhTDEWAmHCF4VY8JmdY7Ko+lA2YYV0jE7j62uKez0b8Ui7zgCvnZvX6XK
 BF2O8ZKqzKSeU7c5VGHBurtZ/vy9bPyfOMWcW1eSmyYE3FfsCLdGCmLfiw/id3uKgvGh
 /4RA6OF7Fw14UHgAtvwW4oy69OQSuEejCn8v2CZ0OshWqimrHTgvEO/UzvPft0dfO9JV
 Kx/WNYzwEMX+55pFV/I66UOade/Dkc4Ici+il9hP2BE0ue7DJrssgmuzudAIiFp2OJLL
 Y1REmPZ3sAc8oGUIykNSNa2rNh7jK3Q61BIvIdss6SiAcFFEw0l7qTdxYOYk+6Rr+hE8
 SUxg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXq1CtlgOkPIjKQXdX8uEE3NHPGZGeQ3RX2DaSKHiZAFnfuh4llhbAP6F7ytSvhTWh8rXyNd9PRIs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyW6fxUwFBR9EXZVJlVPSZEDcRS7KVISHbhcjwlow0m6TSKDj2+
 EU5xIoAtwhpbY3qWVPZ+Wh51pSmj5/Ya3bbjTpKq6kDvZUSprdiX+DcR
X-Gm-Gg: AfdE7ckYSpt4XYugFakeq08b4Vne3zATIpCvCszADJiOYuFh+2bq97q/sPa8SOPPGbd
 ptk2CmsTlvQfr9/AyRl3DRNaEorELnGl/8pwDe9OZMLnlYAfmu9aYivAZVDc2J0xV1tN8Vs7ZsG
 Ja0Eqd0RLHlVYHopYVwvsJahKnHffWKN9ZUqJXAL5RKZhoxZY9wq/xFkIlWazJA2I+Rxj9HfKvR
 HY0uo52sIhq/zxdBQtg+Dbj+s2qDRR+kRLGvI7limA1m/75g1ZyBG0M1Ype36Mwnx2pTnmfWPDs
 QSASeOYgAC5rMsqBUwKMq2vJG/mLMN0V75uJnl5socO5kfN5QZ8C5dLuYQan15V17of+13MYC+H
 6jbyA1Z+pbbNogQZer7m+hWw/nf513qmx8/1OZsofnMgEcYmlFq93mk1n+2qJx2Necn2E8bUOYw
 wZwBOoCJoT8dNXFXOiF0LFGoZgLleC8ix0O4c=
X-Received: by 2002:a05:690c:e347:b0:7db:ccda:a409 with SMTP id
 00721157ae682-801759e5070mr88778787b3.9.1782049157948; 
 Sun, 21 Jun 2026 06:39:17 -0700 (PDT)
Received: from localhost (user-24-214-85-55.knology.net. [24.214.85.55])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025f8dde30sm20893067b3.27.2026.06.21.06.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 06:39:17 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Sun, 21 Jun 2026 09:39:17 -0400
To: Steven Rostedt <rostedt@goodmis.org>
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
Subject: Re: [PATCH 2/2] tracing: Add CONFIG_TRACE_PRINTK_DEBUGGING to clean
 up kernel.h
Message-ID: <ajfphe4Z8BrfYoUX@yury>
References: <20260621093430.264983361@kernel.org>
 <20260621093811.168514984@kernel.org>
 <20260621054721.7cde38f0@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621054721.7cde38f0@fedora>
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

On Sun, Jun 21, 2026 at 05:47:21AM -0400, Steven Rostedt wrote:
> On Sun, 21 Jun 2026 05:34:32 -0400
> Steven Rostedt <rostedt@kernel.org> wrote:
> 
> > Instead of having trace_printk.h included in kernel.h, create a config
> > TRACE_PRINTK_DEBUGGING that when set will update the CFLAGS in the
> > Makefile to allow developers to add trace_printk() without the need to add
> > the include for it. Having it included in the Makefile keeps it from being
> > in the dependency chain and it will not waste extra CPU cycles for those
> > building the kernel without using trace_printk.
> 
> Bah, I only tested with the config option enabled, and missed some
> dependencies with it disabled.

Yes you did.
 
> For instance, rcu.h also uses ftrace_dump() so that too needs to go
> into kernel.h.

No, it shouldn't.

> I also need to add a few more includes to trace_printk.h.

> OK, I need to run this through all my tests to find where else I missed
> adding the includes. But the idea should hopefully satisfy everyone.

If you include it under config in kernel.h, to make the kernel buildable,
you need to include trace_printk.h explicitly where it's actually used.
IOW, apply my patch v4-7.

Then, developers who use trace_printk() on their development machine,
will be really frustrated when their debugging code will break client
build just because CONFIG_TRACE_PRINTK_DEBUGGING is disabled there.
They will spend a day, at best, communicating with remote managers,
and end up with adding #include <linux/trace_printk.h> in the files
they touch. Is that your plan?

If I was one of those developers, the solution would be simple for me:
don't use trace_printk() at all.

Thanks,
Yury
