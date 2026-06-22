Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F95CDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1772810E547;
	Mon, 22 Jun 2026 08:42:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZJjQ5sM5";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFE7410E547
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 08:42:46 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-46255b269c2so3112293f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 01:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782117765; x=1782722565; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bFnA4MB3rhX4hW9kwKpEDdWQh6n3FEg0cpZAkJWsmhQ=;
 b=ZJjQ5sM5/USsYm9FqwCU8JnjmaHZ/PilGRe5EhcGiEi+js4MytmqTrJGEelJtWWYif
 5fEI9Px4Tk//S5njEkp3JDY/zHDDLjz0HuSdyoYwJ0rWJAsE0/9/Jrx+3KhG2sYkukIW
 5xc955Rp6HKFlQ8Wn0z8PIaEL8AEY0QYBbGAeTVSwFatSQqQr1cDr38zXQyAYA27g7ei
 hHrvuQhvKU+RSol85ZZU1kfMQhdQlWUf6zsr6wG8vj47Sm388i7VfSzalXBhO051DzSZ
 aysx+q9y38Tabo9vUpCOudCMbrO04e9efHqr+ev9p5eqA0rqata7uw9aSlgnjGwS2w0w
 elOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782117765; x=1782722565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bFnA4MB3rhX4hW9kwKpEDdWQh6n3FEg0cpZAkJWsmhQ=;
 b=LZiFiBF/+LRNzIYQi39X4KQq9Yhk24ZZrASMv2ZckZy2/LPengxgtfg6teHMW4rzIU
 w6uy8AWYK0m6f2z2RIEnzgh/Ke51h3CTRZCkUR4+ZDDISiqJZlBSwraVhP5ds4iOo8iF
 J2jrIKMDPsoe65yL2Bg0T0F1dhBgZYQ9lK06MxF2vWmkmMCqB8gPmYvP0hLaigJfcQOi
 +7ofrQy9z+hmAjBYhLVRV+PNRrs9as/tBiJCQL7TjNGPVb5TEn2BsW0MxULV/y4ElFVB
 8fL79x/o62v+gcL+Fk43ra1FvqiS8lnpoFpNrg+BkMqZEXcWi5oOeH6UIBqlUsbbpMnQ
 7EUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9mFgVc0IlzF+OktctJKcR1KIenpGuiUZj7bndTi58IXzO3R5wJV+7+0zG0EDvhf1wmAzt3ATvS08=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywqbyn7B1f4u43qHaHMbKWAA4Mm/YSqjXa4sF1fWAwkxxBkQfhg
 F39bZAp8ET3hP8w2Jx4IfZUBaiXZIiGQROQOI8wmypLnrpZWrzEblfsg
X-Gm-Gg: AfdE7cm/mt8MLvNOY+DkuMXNUMHXbH+ZNg7WeWyxn8XVogUDYBhygLMjyV9UqBrHRtX
 bdhnK0w0PzEVVGdLtHfmr16hp2T6bDQt1k9SfvelRVz5VeB9LdEQQtX38NhHnrvCqwBbmN7HA/m
 FpBXbvd4RvcNAR82ZRhtH+ZtVTmQLekJdF72GDME0xzVaF87C3eoY5L+RzIiiUu9Q2Nad+2l0fq
 sQxQihnfCxEDbliUwi8+8JpY8qt5Kiofhafiodm9SFH5r8O7GbNAoP5LJMZWxmJmdp96c/i93Qy
 HV359kobjBhhN+oAN5cRyBlKKz/7PgRYHmAvdlXKtORoI3ItsTSmYGTNA5JKRUsxFsMqxGu8Rec
 cF5OobK+KmBjNIqa2E6on5Ca+xUSCanXtEWKgwXFNraLn11Kb4XkhQGuA+CF8qgqNJkdoZId4NW
 F+PxBfFNCbrRh+IfBYLjCC/x/FHastFd8jypBCXUTfTfLKHiM9qAxr9vOeXSVu
X-Received: by 2002:a05:6000:2006:b0:460:1e5a:2267 with SMTP id
 ffacd0b85a97d-4650090b736mr21019711f8f.17.1782117764761; 
 Mon, 22 Jun 2026 01:42:44 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666c57afasm24839972f8f.29.2026.06.22.01.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 01:42:44 -0700 (PDT)
Date: Mon, 22 Jun 2026 09:42:42 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kaitao Cheng <kaitao.cheng@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
 <david@kernel.org>, Jens Axboe <axboe@kernel.dk>, Tejun Heo
 <tj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Paul Moore <paul@paul-moore.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, David Howells
 <dhowells@redhat.com>, Simona Vetter <simona.vetter@ffwll.ch>, Randy Dunlap
 <rdunlap@infradead.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Philipp
 Stanner <phasta@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-ntfs-dev@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, audit@vger.kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kexec@lists.infradead.org, live-patching@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-pm@vger.kernel.org, rcu@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-mm@kvack.org, virtualization@lists.linux.dev, damon@lists.linux.dev,
 llvm@lists.linux.dev, Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: Re: [PATCH v3 1/7] list: Add mutable iterator variants
Message-ID: <20260622094242.64531b9a@pumpkin>
In-Reply-To: <20260622040533.29824-2-kaitao.cheng@linux.dev>
References: <20260622040533.29824-1-kaitao.cheng@linux.dev>
 <20260622040533.29824-2-kaitao.cheng@linux.dev>
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

On Mon, 22 Jun 2026 12:05:31 +0800
Kaitao Cheng <kaitao.cheng@linux.dev> wrote:

> From: Kaitao Cheng <chengkaitao@kylinos.cn>
> 
> The list_for_each*_safe() helpers are used when the loop body may
> remove the current entry.  Their API exposes the temporary cursor at
> every call site, even though most users only need it for the iterator
> implementation and never reference it in the loop body.
> 
> Add *_mutable() variants for list and hlist iteration.  The new helpers
> support both forms: callers may keep passing an explicit temporary cursor
> when they need to inspect or reset it, or omit it and let the helper use
> a unique internal cursor.

I'm not really sure 'mutable' means anything either.
It is possible to make it valid for the loop body (or even other threads)
to delete arbitrary list items - but that needs significant extra overheads.

It might be worth doing something that doesn't need the extra variable,
but there is little point doing all the churn just to rename things.

> 
> This makes call sites that only mutate the list through the current entry
> less noisy, while keeping the existing *_safe() helpers available for
> compatibility.
> 
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>  include/linux/list.h | 269 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 231 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/list.h b/include/linux/list.h
> index 09d979976b3b..1081def7cea9 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -7,6 +7,7 @@
>  #include <linux/stddef.h>
>  #include <linux/poison.h>
>  #include <linux/const.h>
> +#include <linux/args.h>
>  
>  #include <asm/barrier.h>
>  
> @@ -763,28 +764,72 @@ static inline void list_splice_tail_init(struct list_head *list,
>  #define list_for_each_prev(pos, head) \
>  	for (pos = (head)->prev; !list_is_head(pos, (head)); pos = pos->prev)
>  
> -/**
> - * list_for_each_safe - iterate over a list safe against removal of list entry
> - * @pos:	the &struct list_head to use as a loop cursor.
> - * @n:		another &struct list_head to use as temporary storage
> - * @head:	the head for your list.
> +/*
> + * list_for_each_safe is an old interface, use list_for_each_mutable instead.
>   */
>  #define list_for_each_safe(pos, n, head) \
>  	for (pos = (head)->next, n = pos->next; \
>  	     !list_is_head(pos, (head)); \
>  	     pos = n, n = pos->next)
>  
> +#define __list_for_each_mutable_internal(pos, tmp, head)		\
> +	for (typeof(pos) tmp = (pos = (head)->next)->next;		\

Use auto

> +	     !list_is_head(pos, (head));				\
> +	     pos = tmp, tmp = pos->next)
> +
> +#define __list_for_each_mutable1(pos, head)				\
> +	__list_for_each_mutable_internal(pos, __UNIQUE_ID(next), head)
> +
> +#define __list_for_each_mutable2(pos, next, head)			\
> +	list_for_each_safe(pos, next, head)
> +
>  /**
> - * list_for_each_prev_safe - iterate over a list backwards safe against removal of list entry
> + * list_for_each_mutable - iterate over a list safe against entry removal
>   * @pos:	the &struct list_head to use as a loop cursor.
> - * @n:		another &struct list_head to use as temporary storage
> - * @head:	the head for your list.
> + * @...:	either (head) or (next, head)
> + *
> + * next:	another &struct list_head to use as optional temporary storage.
> + *		The temporary cursor is internal unless explicitly supplied by
> + *		the caller.
> + * head:	the head for your list.
> + */
> +#define list_for_each_mutable(pos, ...)					\
> +	CONCATENATE(__list_for_each_mutable, COUNT_ARGS(__VA_ARGS__))	\
> +		(pos, __VA_ARGS__)

The variable argument count logic really just slows down compilation.
Maybe there aren't enough copies of this code to make that significant.
But just because you can do it doesn't mean it is a gooD idea.
I'm also not sure it really adds anything to the readability.

And, it you are going to make the middle argument optional there is
no need to change the macro name.

	David


