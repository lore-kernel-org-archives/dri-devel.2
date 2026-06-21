Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AD7CD98F0
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 13:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5467E10E3B1;
	Sun, 21 Jun 2026 13:57:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QjVbaaKx";
	dkim-atps=neutral
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6465C10E3B1
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 13:57:07 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-7fdeab38240so30526867b3.2
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 06:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782050226; x=1782655026; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Sv1dki/80aNeWwp+36abGEnVJza7FGEeP7NOY9gPTvc=;
 b=QjVbaaKxuluEWEOkUeik+kajfHUFbS6yZODgMWx4JgvaaJREEpVU54hVJ01K9RIOpt
 35rp9a+O1e6YDu6b/QC8rfkT/y5KN8Hf08911pQ/BNsC1Wv/lu3mhnIPZONpwIVcKU/l
 tIMgcye1y6TM18wSuz9yKil1tQtdv/7/wj3u+FeTbryCZLeaymcV+asXCfZZbvxziImT
 QNv44f6ybj+4vxvZM0p/sXxgBRnvgNudXWGhlMPj3eZYyVDRpZX5h01edHAjgXOg8PrJ
 hxBHBrX0NK1SJRguYV7z+SjVVEz0NmFr4SaIfXWtZoIvzZlJFv/BWL1Qe0kGfbDS+y7g
 Nsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782050226; x=1782655026;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sv1dki/80aNeWwp+36abGEnVJza7FGEeP7NOY9gPTvc=;
 b=Q6nTNeJ9rXN2QKGrRuv8qY3nMMsMKsF3TZ0dWWv5VglwWeSpElwWnPcpf1bdsQkVU+
 Fw4y1oqeh8DGp9LXMJ33tAJa7eC4BuZsl440QZZ169+I3K0+2BIarPlzzPKJ8BSBpYVm
 iJmUWavFdl4DXkVk6/i9kp1Uzk/5/h0iy670Z3zMdhS1P9J/fICWFashtkm2AZIHwzfr
 3ouqvlHKO5pVfJDtwQsJRwFxe70y8bzPawnydx3bHU3Jb2oZeYf5bW75MZl19fK5ogVQ
 R0WK8iYHT+SXAx7XMoE40Nkx+jXgnQlXap1D2Z6iXWxnK6AH59c8l6ZZoWfdmLshY8rT
 3neA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpDokfZbxiGWJC1HWXd+a1eB6J4PUwq2NbKFrtSBKUIaV4hBOKUPasT2TVfII7EFBqY+nXdRH2sADw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyrhll2dxGrdnJInz/fuflWNoMn/F/ZiLbdx2XlnftBz0rmEJtg
 iu8na4rLoS/An7J1JKvl6lbvbTlD1nEzkRg0Lp6f6EaJ4GnU98PRvKDO
X-Gm-Gg: AfdE7cmIRor1UR6oSy91RF+qW6lsjCGZ6Z+xZdTyCjBr/40n8cON7z/1QK0W5RKyN6S
 PzlMfEQEV9wpNz4aBBZixYZw2fOhDawARd0ALN9dXoNII/FFvIoktlBc3SteEYdS2Mx1Taobiow
 TtVPlgGXut8JKwJYJRLOMKqUK8E1yK9Z13DDqVnnpewdlcnoGcX5gGTx1xkN1Vk9QTsmduQPpyr
 bBB+XbN+ibv2Wa57cwOA5pURwlYiN+Go1+V+6mZgh4NpFjOY7Xpv6R5YIyHykxpGfPmsnbBJH/f
 gvKEfz+LkkJzCZN0r8MwtCTJ5rcKa0Zdd7GlXbI6MvUEV4XKsKQizrIWcmbgatL5CyhZfJgkEJL
 //WbIZBNi+1OiqHFpDAI74FITdfF2d9qu4Ez15caFb88Q9IqMzYsAoZzb+D+IS6WXWv6jp2jvjp
 uvbfUl1oRwid7LORGB//l3jkcNYn8Eh+HlBk0=
X-Received: by 2002:a05:690c:4b8b:b0:7c5:f6c:d311 with SMTP id
 00721157ae682-80131d97bdamr100779827b3.13.1782050226417; 
 Sun, 21 Jun 2026 06:57:06 -0700 (PDT)
Received: from localhost (user-24-214-85-55.knology.net. [24.214.85.55])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025c96fdb3sm21073127b3.1.2026.06.21.06.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 06:57:06 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Sun, 21 Jun 2026 09:57:05 -0400
To: Yury Norov <yury.norov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>, Thomas Gleixner <tglx@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Julia Lawall <julia.lawall@inria.fr>, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] tracing: Add CONFIG_TRACE_PRINTK_DEBUGGING to clean
 up kernel.h
Message-ID: <ajftsRwe19fPTP1r@yury>
References: <20260621093430.264983361@kernel.org>
 <20260621093811.168514984@kernel.org>
 <20260621054721.7cde38f0@fedora> <ajfphe4Z8BrfYoUX@yury>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajfphe4Z8BrfYoUX@yury>
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

On Sun, Jun 21, 2026 at 09:39:17AM -0400, Yury Norov wrote:
> On Sun, Jun 21, 2026 at 05:47:21AM -0400, Steven Rostedt wrote:
> > On Sun, 21 Jun 2026 05:34:32 -0400
> > Steven Rostedt <rostedt@kernel.org> wrote:
> > 
> > > Instead of having trace_printk.h included in kernel.h, create a config
> > > TRACE_PRINTK_DEBUGGING that when set will update the CFLAGS in the
> > > Makefile to allow developers to add trace_printk() without the need to add
> > > the include for it. Having it included in the Makefile keeps it from being
> > > in the dependency chain and it will not waste extra CPU cycles for those
> > > building the kernel without using trace_printk.
> > 
> > Bah, I only tested with the config option enabled, and missed some
> > dependencies with it disabled.
> 
> Yes you did.
>  
> > For instance, rcu.h also uses ftrace_dump() so that too needs to go
> > into kernel.h.
> 
> No, it shouldn't.
> 
> > I also need to add a few more includes to trace_printk.h.
> 
> > OK, I need to run this through all my tests to find where else I missed
> > adding the includes. But the idea should hopefully satisfy everyone.
> 
> If you include it under config in kernel.h, to make the kernel buildable,

I mean: in kernel.h or in Makefile.

> you need to include trace_printk.h explicitly where it's actually used.
> IOW, apply my patch v4-7.
> 
> Then, developers who use trace_printk() on their development machine,
> will be really frustrated when their debugging code will break client
> build just because CONFIG_TRACE_PRINTK_DEBUGGING is disabled there.
> They will spend a day, at best, communicating with remote managers,
> and end up with adding #include <linux/trace_printk.h> in the files
> they touch. Is that your plan?
> 
> If I was one of those developers, the solution would be simple for me:
> don't use trace_printk() at all.
> 
> Thanks,
> Yury
