Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1CFCD4F24
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 10:06:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E72C10E5BF;
	Wed, 13 May 2026 10:06:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gNQLUOOi";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7D1E10E5BF
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 10:06:02 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-bd21ffaca79so379740966b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 03:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778666761; x=1779271561; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y8agHE2UtR+0v8hUNRpGN3/NHmgQczj9TZKmKbKc+JU=;
 b=gNQLUOOiLIQwEBxLiDQJLc2/m4OXiQygE2gHYUoCnOiYBWVQqWmTCwLZQB7QK6VyAB
 a7Xy/nqleVqE5SmDOvNiH+2ahb0uskyg6m4Jd3cugiF/l1S0h2ls06sMqTHazmez0hxP
 uZ8eb1s13zO82MUYLi8qvh4D876EmRBwDqgzjkCtcz7pn6hNwfMNzoNTre2InRRxqmOe
 XDmhqE7g95PtnP3xf3z+E8084ki8QHCOThxou2b68uEKXfjR5P1ou0BiMbeeYf2TWjpd
 Xy2bCf6KzH1qauPR64qZfGKzs3rctEsQ0ULsCShOSTPidB25H0zh5LvEpBJuowVbsDGr
 ihTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778666761; x=1779271561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y8agHE2UtR+0v8hUNRpGN3/NHmgQczj9TZKmKbKc+JU=;
 b=H+HuJ+nBDmmLnYu7FY36xMGy+svDlCOsqnv0bJpMdgmlw3TIe1U/1TqSTKuSPeMHvb
 OekqM6Eeti8mZyHW3Keiv7fHtqAsVJtTGHMz1ctNyDyAcIrU/EqCQ2R5ShNA2BVzhfDZ
 SqnpcTkjDfA9hKmgFEvIxfWZ6UCwOXD2r0cHtyLX071WC+2rAk4JaBtozI09OGCnymz8
 nLh7bK6k4F470QLggllXGc1gHMr+dqZKJnCFPeDfhxU9ChjpPvKptu/NoOPjo4L48wNh
 2m9AxEZKBmxh2qEvmPqne/JclEyYsuQ8jkQlCktgmMHBeCSvuxcj85ny850BIb4nXJQO
 3IAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UQboDmTE7jD8yFZ7QGqUVUJ9+djzg0D0vmcSCb8oHTK53megVqTJ1oBJ71OFhgazKG9DqpeJpzpQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxg4efvGQKsnJj3mN7I9n3At6oTlw4MUaKIE8+bvwUaEbJQcrUi
 4wsUH4MJEZKZhGwVyz3MuSfiZt8avwD+wHsJ5C/88PB3KQdm1Nx0HANh
X-Gm-Gg: Acq92OHmB01ZxX9x4seZgRgGoIl6WlHHiLnbsrfJmKJjGqTRd7sOzujmHUJ2BzuIwDa
 9tg6LXA52cyIbH2zL/G4GKhbwl+aikZJ3FojhiRQ9i67iafftYXBJP7jPwxBojVf925XaIUbCMq
 r0Qu2JlxG3kCPKzlBGZHOZD/4oXlq5DZS5VCZf35GvLNNDUojsyA2dk85NrlInM+8GkbPXXpIT/
 SHl2wHJQyazPR4I8O1T+M/eRQ3y0+abxSMq+QSVRHsdb3taoVv3+j5hHs6aizORevrQWq9H0kTc
 naQhF28bFT0HUxlijTyeUAWr0eubxlf7OsUO03LbiCkRNHkghI4iadoJ3SOOZYthMaOVNYcZRlp
 7b9IKWJCdfXhxSGt7hfd6nlFnLsrbxNBl2e5WahjRpQuONiEDqQ4KUFi9pWMkJYYKu6pq9pFr0N
 77R/cfC4Gu4V0JbKFXOTX2VgO+jE5klOcZ5SnZICYZdD90JYXWFZvtO4wisFUu
X-Received: by 2002:a17:907:9493:b0:bc5:2352:555c with SMTP id
 a640c23a62f3a-bd3add39c4bmr174356866b.14.1778666759127; 
 Wed, 13 May 2026 03:05:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bd2dba8fd22sm216615666b.16.2026.05.13.03.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 03:05:58 -0700 (PDT)
Date: Wed, 13 May 2026 11:05:57 +0100
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
Message-ID: <20260513110557.705bdeed@pumpkin>
In-Reply-To: <20a233d2f35274817aa643cc0fe113707eb47e72.1777475843.git.asml.silence@gmail.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <20a233d2f35274817aa643cc0fe113707eb47e72.1777475843.git.asml.silence@gmail.com>
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

On Wed, 29 Apr 2026 16:25:48 +0100
Pavel Begunkov <asml.silence@gmail.com> wrote:

> Introduce a new iterator type for dmabuf maps. The map in an opaque
> object with internals and format specific to the subsystem / driver, and
> only it can use that subsystem / driver for issuing IO. The task of the
> middle layers is to pass the map / iterator further down, maybe doing
> basic splitting and length checking. The iterator can only be used by
> operations of the file the associated map was created for.
> 
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  include/linux/uio.h | 11 +++++++++++
>  lib/iov_iter.c      | 29 +++++++++++++++++++++++------
>  2 files changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index a9bc5b3067e3..75051aed70de 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -12,6 +12,7 @@
>  
>  struct page;
>  struct folio_queue;
> +struct io_dmabuf_map;
>  
>  typedef unsigned int __bitwise iov_iter_extraction_t;
>  
> @@ -29,6 +30,7 @@ enum iter_type {
>  	ITER_FOLIOQ,
>  	ITER_XARRAY,
>  	ITER_DISCARD,
> +	ITER_DMABUF_MAP,
>  };
>  
>  #define ITER_SOURCE	1	// == WRITE
> @@ -71,6 +73,7 @@ struct iov_iter {
>  				const struct folio_queue *folioq;
>  				struct xarray *xarray;
>  				void __user *ubuf;
> +				struct io_dmabuf_map *dmabuf_map;
>  			};
>  			size_t count;
>  		};
> @@ -155,6 +158,11 @@ static inline bool iov_iter_is_xarray(const struct iov_iter *i)
>  	return iov_iter_type(i) == ITER_XARRAY;
>  }
>  
> +static inline bool iov_iter_is_dmabuf_map(const struct iov_iter *i)
> +{
> +	return iov_iter_type(i) == ITER_DMABUF_MAP;
> +}
> +
>  static inline unsigned char iov_iter_rw(const struct iov_iter *i)
>  {
>  	return i->data_source ? WRITE : READ;
> @@ -300,6 +308,9 @@ void iov_iter_folio_queue(struct iov_iter *i, unsigned int direction,
>  			  unsigned int first_slot, unsigned int offset, size_t count);
>  void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
>  		     loff_t start, size_t count);
> +void iov_iter_dmabuf_map(struct iov_iter *i, unsigned int direction,
> +			struct io_dmabuf_map *map,
> +			loff_t off, size_t count);
>  ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
>  			size_t maxsize, unsigned maxpages, size_t *start);
>  ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 243662af1af7..e2253684b991 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -575,7 +575,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
>  {
>  	if (unlikely(i->count < size))
>  		size = i->count;
> -	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i))) {
> +	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i)) ||
> +	    unlikely(iov_iter_is_dmabuf_map(i))) {


Doesn't the extra check add more code to all the non-ubuf cases?
This could be fixed by either making iter_type a bitmask (with one bit set)
or writing an iter_is_one_of(i, ITER_xxx, ITER_yyy) define that uses
'(1 << i->iter_type) & ((1 << ITER_xxx) | ...)'
(look at the the nolibc printf code for an example).

>  		i->iov_offset += size;
>  		i->count -= size;
>  	} else if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i))) {
> @@ -631,7 +632,8 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
>  		return;
>  	}
>  	unroll -= i->iov_offset;
> -	if (iov_iter_is_xarray(i) || iter_is_ubuf(i)) {
> +	if (iov_iter_is_xarray(i) || iter_is_ubuf(i) ||

iter_is_ubuf() should have been first here.

-- David

> +	    iov_iter_is_dmabuf_map(i)) {
>  		BUG(); /* We should never go beyond the start of the specified
>  			* range since we might then be straying into pages that
>  			* aren't pinned.
> @@ -775,6 +777,20 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int direction,
>  }
>  EXPORT_SYMBOL(iov_iter_xarray);
>  
> +void iov_iter_dmabuf_map(struct iov_iter *i, unsigned int direction,
> +			 struct io_dmabuf_map *map,
> +			 loff_t off, size_t count)
> +{
> +	WARN_ON(direction & ~(READ | WRITE));
> +	*i = (struct iov_iter){
> +		.iter_type = ITER_DMABUF_MAP,
> +		.data_source = direction,
> +		.dmabuf_map = map,
> +		.count = count,
> +		.iov_offset = off,
> +	};
> +}
> +
>  /**
>   * iov_iter_discard - Initialise an I/O iterator that discards data
>   * @i: The iterator to initialise.
> @@ -841,7 +857,7 @@ static unsigned long iov_iter_alignment_bvec(const struct iov_iter *i)
>  
>  unsigned long iov_iter_alignment(const struct iov_iter *i)
>  {
> -	if (likely(iter_is_ubuf(i))) {
> +	if (likely(iter_is_ubuf(i)) || iov_iter_is_dmabuf_map(i)) {
>  		size_t size = i->count;
>  		if (size)
>  			return ((unsigned long)i->ubuf + i->iov_offset) | size;
> @@ -872,7 +888,7 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
>  	size_t size = i->count;
>  	unsigned k;
>  
> -	if (iter_is_ubuf(i))
> +	if (iter_is_ubuf(i) || iov_iter_is_dmabuf_map(i))
>  		return 0;
>  
>  	if (WARN_ON(!iter_is_iovec(i)))
> @@ -1469,11 +1485,12 @@ EXPORT_SYMBOL_GPL(import_ubuf);
>  void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
>  {
>  	if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i) &&
> -			 !iter_is_ubuf(i)) && !iov_iter_is_kvec(i))
> +			 !iter_is_ubuf(i) && !iov_iter_is_kvec(i) &&
> +			 !iov_iter_is_dmabuf_map(i)))
>  		return;
>  	i->iov_offset = state->iov_offset;
>  	i->count = state->count;
> -	if (iter_is_ubuf(i))
> +	if (iter_is_ubuf(i) || iov_iter_is_dmabuf_map(i))
>  		return;
>  	/*
>  	 * For the *vec iters, nr_segs + iov is constant - if we increment

