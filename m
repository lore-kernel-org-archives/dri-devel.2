Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A87BCD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 10:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD23C10E79B;
	Mon, 18 May 2026 10:40:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YPDtsDgz";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45A3710E5C3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 10:40:14 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so31544685e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 03:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779100813; x=1779705613; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KBUJm1g4jrVLHLARnQ410xCyIfZ2+knqUA7xvFczZVo=;
 b=YPDtsDgz/cggN6fZZylkytDY84Pbx0HNPgPe3uiF/MPZnlgjQ89l+wodhzZYyM0Ink
 68vaJKSqWbMTE1WCFZElWrTl5+rm8ZrQ2Kx2FZOaUY5Wvo6lQAwGRoYptEHw9+Zv/qSz
 MkBk1nbi4HXVJZ2qQPNkqoiw0VqU5NwsUT9qinQIXd5xbGUkfKbu47dFQY5VjsYP8+2R
 UoxXUbmxw+o27xDH9XO1vlrwcS/s4tFNLe3MYuaHH5TImkXbhPCIOdf5M41lC0MVr3qc
 DHCdvTyEGL7Fpf9XyCNJAHV0e7mG++cM9ZyLNEaXEOIba8T6LX54cRrjJ47QsatzZsVJ
 7JRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779100813; x=1779705613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KBUJm1g4jrVLHLARnQ410xCyIfZ2+knqUA7xvFczZVo=;
 b=FciUvitELzxQ6Cr8cR7V3HPX/Gh38kpnMCldd4Rr+lxJhoX3dEDFxocziOgWJXJAXT
 jDVdKFO80rghysIdEH0KoPQb3uVWpIVUwQV5vqfz8evX6R3RXkTPyaKdYN5sPl2UL0Fm
 XEKHaotmNvpwx44c1oNchyz6WCgvnGff7tlh7AFvqXLLkfI5ei1bTJc1o/g7+yajCHyw
 AMV4tB5ZGTzgEh9ApiycFuO6YRQGDiXXeFWNs5RIrXUHb+BzBfCQzxMgV2qRW/O+2oKO
 U+FtgUf3+x/OMIqz6glBy0SFcVtGp7FO04GORTGzLC17gSqkACHd27jEbrQm2NmYbuTY
 36BA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+piFTBVBjp51Swtko9ZKW1wvJhDGA2i2VpR1G/GWAgpOze4bFAWGeAyBA0NPSIZGbvFJRwhZh0z64=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzosGULywnq2ZEHOPeX8NcGYd0zt/CfB/Wr8HeOFtOs/SatOkND
 mVzgYqitg4YI2vqtTwKkjKwPFtDdY4B5G2rK4VjeqPjiUiiw9SVtWMIh
X-Gm-Gg: Acq92OFPsvnu2kVWfbUSMfUDBwzpviXr6LzlOgRscXOk+Qe+JZBgoHomucocGX54URq
 LmWonmL7Qv8gjvUKm8fFZECZrE0UFUvaXzWGFmGyQuz+givsDiSUbiRlE036Wg7puthfkIyJeBZ
 5Ikum4+YBvtQjKJpJSalMNrgWX/xIIaPZvqcBDJ5V5to3sj8TW5bui6OvJRhZpj0p04VNQo8mva
 8s6hYkBt+CKu4yAJU5OMK40a6wef1f3t8NjVsEXd8eMecVZmyBWCa574/80CWmlYiw3KqgH+qOJ
 99BrBVg4CS2NSUQ8xyUD0i8p+K/c6J8Iv74Z5fmV51O8/7xiAwp8Gxj3Yv8lu8MvOyVOnAEGSwg
 7sdrCmfEOGyZqAFhrs2YU8Zv+CGh0DHx2HWGHbJO7xF7AuyaBarqaKLONJi632C4zmRHr29Fka6
 GLLhp6/HGfNWR6k1dYuXYCwF7wFhu4G1PHzPaGiDN7N6hnOAeLtFmoYP+v8IskhfuT7XbWuf5Bj
 NyYbmPpPYP2ZQ==
X-Received: by 2002:a05:600c:4fc9:b0:489:1c1f:35df with SMTP id
 5b1f17b1804b1-48fe60e58ecmr202920365e9.10.1779100812550; 
 Mon, 18 May 2026 03:40:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c90b27sm255713955e9.8.2026.05.18.03.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 03:40:12 -0700 (PDT)
Date: Mon, 18 May 2026 11:40:10 +0100
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
Message-ID: <20260518114010.6e1f7391@pumpkin>
In-Reply-To: <4b2f74e9-3225-47f6-85fe-911720030e35@gmail.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <20a233d2f35274817aa643cc0fe113707eb47e72.1777475843.git.asml.silence@gmail.com>
 <20260513110557.705bdeed@pumpkin> <20260513142909.03ae6c2b@pumpkin>
 <4b2f74e9-3225-47f6-85fe-911720030e35@gmail.com>
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

On Mon, 18 May 2026 10:24:35 +0100
Pavel Begunkov <asml.silence@gmail.com> wrote:

> On 5/13/26 14:29, David Laight wrote:
> > On Wed, 13 May 2026 11:05:57 +0100
> > David Laight <david.laight.linux@gmail.com> wrote:
> > 
> > ...  
> >>> @@ -575,7 +575,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
> >>>   {
> >>>   	if (unlikely(i->count < size))
> >>>   		size = i->count;
> >>> -	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i))) {
> >>> +	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i)) ||
> >>> +	    unlikely(iov_iter_is_dmabuf_map(i))) {  
> >>
> >>
> >> Doesn't the extra check add more code to all the non-ubuf cases?
...
> >> or writing an iter_is_one_of(i, ITER_xxx, ITER_yyy) define that uses
> >> '(1 << i->iter_type) & ((1 << ITER_xxx) | ...)'  
> > 
> > This seems to DTRT:
> > 
> > #define _ITER_IS_ONE_OF(iter, t1, t2, t3, t4, t5, t6, t7, t8, ...) \
> >      ((1u << (iter)->iter_type) & ((1u << ITER_##t1) | (1u << ITER_##t2) | \
> >          (1u << ITER_##t3) | (1u << ITER_##t4) | (1u << ITER_##t5) | \
> >          (1u << ITER_##t6) | (1u << ITER_##t7) | (1u << ITER_##t8)))
> > #define ITER_IS_ONE_OF(iter, t, ...) \
> >      _ITER_IS_ONE_OF(iter, t, ## __VA_ARGS__, t, t, t, t, t, t, t)  
> 
> We definitely don't want that, using them directly would've been
> much cleaner.
> 
> if (get_type_mask(i) & (TYPE1 | TYPE2)) ...

You need to shift all the TYPEn as well.
The above condition would become:
	if (likely(ITER_IS_ONE_OF(i, UBUF, XARRAY, DMABUF_MAP))) {
which reads reasonable well.
Without the token pasting it becomes:
	if (likely(ITER_IS_ONE_OF(i, ITER_UBUF, ITER_XARRAY, ITER_DMABUF_MAP))) {
and the line starts getting long.
Although that version probably needs a check that the mask is constant.

-- David


> 

