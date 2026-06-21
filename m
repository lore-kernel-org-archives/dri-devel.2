Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D88CD98F2
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 12:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB93A10E277;
	Sun, 21 Jun 2026 12:55:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kZQO3pZj";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF0A510E1A7
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 12:55:35 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49241a577d8so14568265e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 05:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782046534; x=1782651334; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WU+6TPSMrQeQnOmPDKoUDmLIYSzXbxEWNqGQFFhaaZU=;
 b=kZQO3pZjHUp8spcWhDbCJ9BYpSWKqCUnfD1rIV9tOWhua6yUXEhEkr0ndtKu6hOkap
 LVSTj1o3FTeKg3x47rzcjekqXu0FEhWs0BSNPMrSqQMTk3C4xnFytgQvoKDMmlMmco+U
 W/QqKSiaNkNz2TJr5/+NHbJHeZXwNxbGvS1zs1DVZE07tMlOHE5b/VyoJwTjKRveVfwC
 3OwrZUnJe1Bw3ocdyz9Euhw5l+yP09uC+2ZYpna7ZeWq1W1d8mocVUhBpkKRrJyCXuQ2
 JnU7VXMIRTr66fmIDiUj1ksVCHDwwRxbv61/FYshpd6tfAB+w8kjEG92vM3A5uYdeoKo
 RShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782046534; x=1782651334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WU+6TPSMrQeQnOmPDKoUDmLIYSzXbxEWNqGQFFhaaZU=;
 b=B8lXGFYpOrrqX+EYxMDN1nEAUaFhvpymOQNXFUCrkLxcFT7fIVInlF0TJ0NJiA6p0v
 Uu1uoARU4c8ABUny2yDn4gebZAxALIdUXed2xkKB5vUGhOP5rrRbwwFcFYJ+2MQs/f0s
 ihZlxqrE5BJZlxaQlD/3Ma/V+f3SVtnbvfpbbae9MiKHFolEik4uP5b3XkSMHFe6cqVG
 +3oy9abPTdWuzd7zCSWLXKHIodRyLCkayIOR/FsCclwE2jhRRmf+EtvvP5ht5P5w71nI
 b+BEyNz7nfjZ2eaUcM75cGGOQ8/AxZQxZdbFDuIGQsUJclDC4FQjqhNvKTqtSVzp7vuc
 k8jQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Quhbd8fv9QObeVa6U3y62yUCBM5qVNdQgwWaYlxIg/PnEWMDMh2e5gnl2b4Eg86Ylq45zKnwNgl4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxk5ZPaq/RBe/r/QmBJ3uZK9frquOGyHvegxEYfx84sEesn8bwt
 1PedFR7vgRwvoxAnXA5rqZ1eB6J1kltIFMCzGEnTTaaSh+CwfrU+Pbbm
X-Gm-Gg: AfdE7clP2WCwIPZRuOUfPjhGcHrVSbbdmlzgMqzLgBxI6LsnvOOFv/2Z4NRH4iW6o1n
 J+3EF9HItO0UcoFYQxLr4eM41aYiZDws1x+rXYiIniRADtVcXXj/yn/ZK30avgQeZJnTBdFPXsJ
 KHHXMkSYhv9qhdvpHloa+tKBO7OeJ4fPAXmH0XmtPZ1DVUszeg3da6L6svhhZ0goR1kV7EageNc
 RGiZfU+RlvdMYF82Hq4E6/le/O1YyXX6tsxwSWXAwOYw0YoMd9QgRxx7IicMCrzMpEE3b8KIIsg
 EJEjH+vhWSEh713BO/++B0po/alwDIaKd6C0v0LNQv7nAaP3GR+ZglTlf3N5rRixotkJIcBGuv0
 kRF7Y2ntCu5J72d/YOWgyOxY1Cg4Y4KZM/d6r/rRbIuYh9Z24h982EQkCxJRQx9v1AqjnPq30GC
 QlbIECY2y5y+rUmFoiOEMHvpgM7R/4KltFi79oZuFPxTrvixtu9g==
X-Received: by 2002:a05:600c:e547:20b0:48f:d5b8:5b07 with SMTP id
 5b1f17b1804b1-49240e81b22mr113459545e9.20.1782046534244; 
 Sun, 21 Jun 2026 05:55:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49249238900sm129230375e9.4.2026.06.21.05.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 05:55:33 -0700 (PDT)
Date: Sun, 21 Jun 2026 13:55:31 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Julia Lawall <julia.lawall@inria.fr>, Yury
 Norov <yury.norov@gmail.com>, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] tracing: Add CONFIG_TRACE_PRINTK_DEBUGGING to clean
 up kernel.h
Message-ID: <20260621135531.243375d9@pumpkin>
In-Reply-To: <87ik7cmcb7.ffs@fw13>
References: <20260621093430.264983361@kernel.org>
 <20260621093811.168514984@kernel.org> <87ik7cmcb7.ffs@fw13>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sun, 21 Jun 2026 12:13:00 +0200
Thomas Gleixner <tglx@kernel.org> wrote:

> On Sun, Jun 21 2026 at 05:34, Steven Rostedt wrote:
> > Instead of having trace_printk.h included in kernel.h, create a config
> > TRACE_PRINTK_DEBUGGING that when set will update the CFLAGS in the
> > Makefile to allow developers to add trace_printk() without the need to add
> > the include for it. Having it included in the Makefile keeps it from being
> > in the dependency chain and it will not waste extra CPU cycles for those
> > building the kernel without using trace_printk.  
> 
> IOW, you make it worse just because.
> 
> With the header being separate I add the three trace_printk()s and the
> include to the source file I'm investigating. The recompile will build
> exactly this source file.
> 
> Having to enable the config knob will result in a full kernel rebuild
> for no value.

Indeed...
Isn't trace_printk() just an extern?
Having it defined somewhere isn't going to make any difference to build times.

	David
 

> 
> Seriously?
> 
> Thanks,
> 
>         tglx
> 
> 
> 

