Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF980CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 16:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDEDC10E794;
	Mon, 22 Jun 2026 16:40:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="wSEig2tX";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D2FD10E558;
 Mon, 22 Jun 2026 16:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=c5UMhYqzW3FXITWipN5SHhAQOB1P9YUKBIDy0r3xPQw=; b=wSEig2tXNqqYlMi+DO0fVntY5n
 xOHolZZKA+fIDoV0P9vbcZYk+nTw3ZO3neQaPzi4xv2gcxwSzlDonXdcprWpDH2QVuSHb1XstdPJW
 SDJunku4cTdk3jGABXOOirk4qvdvStLyf+TSspP6lyyvSkgzI8foJ7iUHjAWC1KMbyOnlr8Bk2/AC
 kSmplFs4mh7vU8qt6mUcBWozaXfZYbjxcaOPfxhFG3Z95uao/bptRNf0v9TlnvAPmJRfMGZZ11YUj
 Kd2cOw4Cnm3blaF1fkpC/rbtuwYhawbpOJtgBO9UdgKUgdoYUd8ev6TfDb5XWKvISvKwTYP33Ug+E
 awdU0f0A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wbhhW-00000005CFj-0vuV; Mon, 22 Jun 2026 16:40:46 +0000
Message-ID: <08b3c961-18bb-43d9-8d7f-8a87bcad0afa@infradead.org>
Date: Mon, 22 Jun 2026 09:40:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tracing: Move trace_printk.h out of kernel.h
To: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>, Thomas Gleixner <tglx@kernel.org>,
 Julia Lawall <julia.lawall@inria.fr>, Yury Norov <yury.norov@gmail.com>,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
References: <20260621093430.264983361@kernel.org>
 <20260622083440.GX49951@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260622083440.GX49951@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
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



On 6/22/26 1:34 AM, Peter Zijlstra wrote:
> On Sun, Jun 21, 2026 at 05:34:30AM -0400, Steven Rostedt wrote:
>> There's been complaints about trace_printk() being defined in kernel.h as it
>> can increase the compilation time. As it is only used by some developers for
>> debugging purposes, it should not be in kernel.h causing lots of wasted CPU
>> cycles for those that do not ever care about it.
>>
>> Instead, add a CONFIG_TRACE_PRINTK_DEBUGGING option that developers that do
>> use it can set and not have to always remember to add #include <linux/trace_printk.h>
>> to the files they add trace_printk() while debugging. It also means that
>> those that do not have that config set will not have to worry about wasted
>> CPU cycles as it is only include in the CFLAGS when the option is set, and
>> its completely ignored otherwise.
> 
> Did you forget your C 101 class? If you use a function, you gotta
> include the relevant header.

Also item #1 in Documentation/process/submit-checklist.rst.

> You don't see userspace saying: 'Hey, you know what, perhaps we should
> add stdio.h to every other header, just in case someone wants to
> printf()' either.
> 
> I really don't understand your argument. Yes, maybe someone will forget
> and then either their editor (if they have a halfway modern setup with
> LSP enabled) or their build will complain, but so what? This is all
> trivial stuff, surely we have more pressing matters to concern outselves
> with?



-- 
~Randy

