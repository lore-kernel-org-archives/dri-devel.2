Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60505C43211
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 19:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F55F10F709;
	Fri, 26 Jun 2026 19:03:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tw9iWJ3A";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 890F710F706;
 Fri, 26 Jun 2026 19:03:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E1BDB600AA;
 Fri, 26 Jun 2026 19:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10911F000E9;
 Fri, 26 Jun 2026 19:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782500612;
 bh=TyFl9GWmXNLl+QLk0gYGvkiIPobdLVhGYz9j6ia1saU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Tw9iWJ3AW/qVhYN7KGc/ZTiaZzg/3oECz+DiP4VJfyn3QB4fPWwrgNuAJIGNxs+V2
 gQMOySYXH+qHCB0JOy7ShmXUDJ864WlfuAmNSW4eC0jw1v5I1DDn/MBUmLRwI+Zmn+
 Tvx68PQugVu+ljQ23TFRCcjPeBFQjWYKgQD+yv+Dj0NPAyY7KU1ce1064Yq2UJQHNh
 7PCVds29NYJupkBRTBhXtnaGXQquqVp6AN7Xp9L5f6IxL0XEVKpAcZfxaTF8hC29A2
 GZgsbwtmAy/ydDOu69TLhC+XE3g2v+Sxjbre9Fp/7W+UikRELgut2FYBWl4v+dv3IH
 ZX2QubJjR77jQ==
Date: Fri, 26 Jun 2026 12:03:25 -0700
From: Nathan Chancellor <nathan@kernel.org>
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
Subject: Re: [PATCH v4 2/2] tracing: Remove trace_printk.h from kernel.h
Message-ID: <20260626190325.GA3913132@ax162>
References: <20260625104007.041432666@kernel.org>
 <20260625104402.210473477@kernel.org>
 <20260625234158.GA261868@ax162> <20260626045119.659d1e6b@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626045119.659d1e6b@fedora>
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

On Fri, Jun 26, 2026 at 04:51:19AM -0400, Steven Rostedt wrote:
> On Thu, 25 Jun 2026 16:41:58 -0700
> Nathan Chancellor <nathan@kernel.org> wrote:
> 
> 
> > The following diff resolves it for me, should I send it as a separate
> > patch or do you want to just fold it in with a note?
> > 
> > diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> > index 621566345406..2301a701ffbb 100644
> > --- a/include/linux/lockdep.h
> > +++ b/include/linux/lockdep.h
> > @@ -10,6 +10,7 @@
> >  #ifndef __LINUX_LOCKDEP_H
> >  #define __LINUX_LOCKDEP_H
> >  
> > +#include <linux/instruction_pointer.h>
> 
> Ah, so the reason for this breakage is because lockdep was relying on
> instruction_pointer.h, that just happened to be included in kernel.h
> via trace_printk.h.

Correct.

> This is a separate issue, so it should be a separate patch. I'll add it
> as patch 1 of this series.

Sounds good, thanks!

> Can you send me the config you used. This didn't trigger in my tests.

It is a plain allmodconfig, for example on arm:

  $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- allmodconfig lib/test_context-analysis.o
  In file included from include/linux/local_lock_internal.h:8,
                   from include/linux/local_lock.h:5,
                   from lib/test_context-analysis.c:9:
  include/linux/local_lock_internal.h: In function 'local_lock_acquire':
  include/linux/lockdep.h:541:87: error: '_THIS_IP_' undeclared (first use in this function)
    541 | #define lock_map_acquire(l)                     lock_acquire_exclusive(l, 0, 0, NULL, _THIS_IP_)
        |                                                                                       ^~~~~~~~~
  include/linux/lockdep.h:509:88: note: in definition of macro 'lock_acquire_exclusive'
    509 | #define lock_acquire_exclusive(l, s, t, n, i)           lock_acquire(l, s, t, 0, 1, n, i)
        |                                                                                        ^
  include/linux/local_lock_internal.h:46:9: note: in expansion of macro 'lock_map_acquire'
     46 |         lock_map_acquire(&l->dep_map);
        |         ^~~~~~~~~~~~~~~~
  include/linux/lockdep.h:541:87: note: each undeclared identifier is reported only once for each function it appears in
  ...

I also reproduced it on top of allnoconfig:

  $ cat allno.config
  CONFIG_CONTEXT_ANALYSIS_TEST=y
  CONFIG_DEBUG_KERNEL=y
  CONFIG_DEBUG_LOCK_ALLOC=y
  CONFIG_EXPERT=y
  CONFIG_MMU=y
  CONFIG_RUNTIME_TESTING_MENU=y

  $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- KCONFIG_ALLCONFIG=1 clean allnoconfig lib/test_context-analysis.o
  <same error as above>

-- 
Cheers,
Nathan
