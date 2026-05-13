Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F87CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 13:29:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E33B510EE72;
	Wed, 13 May 2026 13:29:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B5nAHTde";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACAB510EE72
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:29:13 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso73856875e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 06:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778678952; x=1779283752; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+cq+23+E96HQoAhwgeeSJr3+OJ8IJX5BGImZhad/wV8=;
 b=B5nAHTdeUAbI8ogLmrOIavJLwK7cjxOsLJ3tNQcqsmHZUWat5T19BdnpJc4jW2P/8G
 l9pNQNXkkRaYNP2YtWVnpfxEhh3p1g5/9PUqfWe/XQqoSuluJYTrQIbfEvmsQDByxVzX
 3y49gzOslmzX5i8+O7JFyLY8glKviDvKc+FI1xK2uzYdR+r8Ihrq2lfmQy3ltJM6RNti
 9w/Zqcw7VXrjHA4iUxDtPWaqdWSjicE04HIUeO7cTS9fZvVoDfn6NGYXGmHSTDTXRoAI
 ABV7QNeNzXv5JlCwgAqLaXCIOAaIjtt0f+4IY7ibGsuLlL2p7Fl2ZG6fGejfMUd3TX9D
 wfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778678952; x=1779283752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+cq+23+E96HQoAhwgeeSJr3+OJ8IJX5BGImZhad/wV8=;
 b=JYg96CPzbyfTGDoWRxsZ1J7LH56jeTwO1Oe3yGORiwDrXmhJK/uiMS35VOF2sOypNl
 eWCzkbL+65nLDhb8gSnjjDb4E0wRUSX2uyEDJdn7tXYStxUFzxpDp10NA0YbOJlNUtUZ
 kEkmRhjXSA805WPn9le+eDyKIyiNiflm9sBcGx28vWqkp6kO1Xxh+BVRXqhcFWJYxbnH
 v6fiZMhutt4eeqXrvOP1iDtDl3Zhgs8ikW+CMTCY286RJ6zl1hut3PLjBEX6+8e4Hopq
 LyUGQaxkUyorjTeUl4W276N7ZC9bDNzYK83+pU70nZdQTksXm/o2aaaT1ZjjuGCnGeVF
 RP1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+lF7ljBY4xL/Q0wCbDPPWIJkxHxPljeVcjovEfOj8nSaecEyxEDNlvLaWkSifI8IXc7HdzqwFCO5g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcMr8uXokHor/xYsN3u2/rlIRJpcDfxHEYUFjvRFz0v2+8aHiq
 AandWDLQfDP29zPMmPtdfxwNkVVtI+6MCpb6oqNPGoF1BGDNWTY4K67J
X-Gm-Gg: Acq92OFipXkrJIkCZ8zqibSdFlFsr0ijFnlXzhbngXx79eUWYihbIMPFakb+06oRnlp
 dANdJpuStXwN4X6gTs9BMtwdWjADnMSAyua3OzqIOyJsmJSLmFUrgTs9Erw6GNh1EMGNq/PcUCM
 QvvGS+jY2nHsfd6gpAfWAMcyZvszMy2FWmVgdZdF2LjXRD10PosnxLF2WDUw69PuuZsdKOG+YEe
 HpO1QlyHd3H8hNQ+kWe/s9+cVy8rx6iyvF3Glf63vuzx99RVxuqfvLfH/pBSpPXGTBAUHYpYYZN
 siWlRFOiduM5ALWciQB0qgywCrnk9ig8auu84kelBC9lhjwwg1aOjapovXNCBnr9KY+LtHmo/lM
 lIWzbZlK8l40oL36dDhtKVmRRI+xVHnZkdqDQ968Aaxy0I+0Md2gQCL+s5Pn3QIaKN6Mm4ch2QZ
 a562i0jjuq4CRbKhTaywpjcPLf1SeW+roL2UupHmL7GXT34WX/8vIzMnSaaOX1
X-Received: by 2002:a5d:591c:0:b0:446:708e:1e8d with SMTP id
 ffacd0b85a97d-45ac4504a13mr9930360f8f.30.1778678951817; 
 Wed, 13 May 2026 06:29:11 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549120ec0asm40068578f8f.17.2026.05.13.06.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 06:29:11 -0700 (PDT)
Date: Wed, 13 May 2026 14:29:09 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, Nitesh
 Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, Anuj
 Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 02/10] iov_iter: add iterator type for dmabuf maps
Message-ID: <20260513142909.03ae6c2b@pumpkin>
In-Reply-To: <20260513110557.705bdeed@pumpkin>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <20a233d2f35274817aa643cc0fe113707eb47e72.1777475843.git.asml.silence@gmail.com>
 <20260513110557.705bdeed@pumpkin>
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

On Wed, 13 May 2026 11:05:57 +0100
David Laight <david.laight.linux@gmail.com> wrote:

...
> > @@ -575,7 +575,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
> >  {
> >  	if (unlikely(i->count < size))
> >  		size = i->count;
> > -	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i))) {
> > +	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i)) ||
> > +	    unlikely(iov_iter_is_dmabuf_map(i))) {  
> 
> 
> Doesn't the extra check add more code to all the non-ubuf cases?
> This could be fixed by either making iter_type a bitmask (with one bit set)
> or writing an iter_is_one_of(i, ITER_xxx, ITER_yyy) define that uses
> '(1 << i->iter_type) & ((1 << ITER_xxx) | ...)'

This seems to DTRT:

#define _ITER_IS_ONE_OF(iter, t1, t2, t3, t4, t5, t6, t7, t8, ...) \
    ((1u << (iter)->iter_type) & ((1u << ITER_##t1) | (1u << ITER_##t2) | \
        (1u << ITER_##t3) | (1u << ITER_##t4) | (1u << ITER_##t5) | \
        (1u << ITER_##t6) | (1u << ITER_##t7) | (1u << ITER_##t8)))
#define ITER_IS_ONE_OF(iter, t, ...) \
    _ITER_IS_ONE_OF(iter, t, ## __VA_ARGS__, t, t, t, t, t, t, t)

int foo(void *);
int f(struct iov_iter *i)
{
    return ITER_IS_ONE_OF(i, UBUF, KVEC) ? foo(i) : 0;
}

See https://godbolt.org/z/sMz93zah1

Pasting ITER_ on the front ensures the values are constants of the right type.
OTOH it makes it harder to search for uses of each type.
You could paste _ITER_ on the front, elsewhere define _ITER_ITER_UVEC
to be ITER_UVEC (etc), and require the caller use the full name.

-- David
