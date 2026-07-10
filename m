Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3EFC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:24:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E080810F77A;
	Fri, 10 Jul 2026 06:24:56 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
 by gabe.freedesktop.org (Postfix) with ESMTP id 39DC310F77A
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 06:24:55 +0000 (UTC)
X-AuditID: a67dfc5b-c45ff70000001609-7b-6a509036d40b
Date: Fri, 10 Jul 2026 15:24:49 +0900
From: Byungchul Park <byungchul@sk.com>
To: sashiko-reviews@lists.linux.dev
Cc: Chuck Lever <cel@kernel.org>, dlemoal@kernel.org,
 Jeff Layton <jlayton@kernel.org>, linux-rt-devel@lists.linux.dev,
 linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-ide@vger.kernel.org, tytso@mit.edu, cassel@kernel.org,
 ojeda@kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-kernel@vger.kernel.org, kernel_team@skhynix.com
Subject: Re: [PATCH v19 28/40] dept: assign unique dept_key to each distinct
 dma fence caller
Message-ID: <20260710062449.GF37630@system.software.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-29-byungchul@sk.com>
 <20260707073344.7392B1F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707073344.7392B1F000E9@smtp.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LhesuzUNdsQkCWQeNxKYvWnf9ZLI5NWMFs
 se7FETaLB/vtLa58fc9m8XPZKnaLYzseMVlc3jWHzaJh9ndWi0urL7BYrJy/nNGiYeltVovW
 np/sDrwem1Z1snnc7z7O5PFi80xGj6YzR5k9Pm+SC2CN4rJJSc3JLEst0rdL4MqY1r6BrWC9
 dsXuTwtYGxgnSXcxcnJICJhIvJ84jRnG3rdqLiOIzSKgKrG0eS8riM0moC5x48ZPsBoRAWWJ
 2TvOMnUxcnEwC7xgktg/8zkbSEJYIF5iWtcvFhCbV8BCouHiCjaQIiGBSYwShy7NYIVICEqc
 nPkErIhZQEdi59Y7QEUcQLa0xPJ/HBBheYnmrbPBlnEKWEkc3z+DCcQWBVp8YNtxsMUSAq/Z
 JJ593MkGcbWkxMEVN1gmMArOQrJiFpIVsxBWzEKyYgEjyypGocy8stzEzBwTvYzKvMwKveT8
 3E2MwEhaVvsnegfjpwvBhxgFOBiVeHgN6v2zhFgTy4orcw8xSnAwK4nwPpABCvGmJFZWpRbl
 xxeV5qQWH2KU5mBREuc1+laeIiSQnliSmp2aWpBaBJNl4uCUamCU2qo+SerDhqlm6ufXyyQ/
 ymVnEj137MP+pouuOavtU8Kn5U+cuYLVQH2XovbDsp4qhYxZ9XEhDC5KfpquLIeZ1Vg1Tuv/
 bKl9rNm2Ri5M8eLtptUTVJ5UnD9l35fPqBzLK7t+v+y0Yy+mGhR3zHngd2jNXJXO+yZGDmd3
 qXK+ZtLl+xYaG67EUpyRaKjFXFScCAABKLs6oAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsXC5WfdrGs2ISDLoPkOj0Xrzv8sFscmrGC2
 WPfiCJvFg/32Fle+vmez+LlsFbvF4bknWS2O7XjEZHF51xw2i4bZ31ktLq2+wGKxcv5yRouG
 pbdZLVp7frI78HlsWtXJ5nG/+ziTx4vNMxk9ms4cZfZY/OIDk8fnTXIBbFFcNimpOZllqUX6
 dglcGdPaN7AVrNeu2P1pAWsD4yTpLkZODgkBE4l9q+YygtgsAqoSS5v3soLYbALqEjdu/GQG
 sUUElCVm7zjL1MXIxcEs8IJJYv/M52wgCWGBeIlpXb9YQGxeAQuJhosr2ECKhAQmMUocujSD
 FSIhKHFy5hOwImYBHYmdW+8AFXEA2dISy/9xQITlJZq3zgZbxilgJXF8/wwmEFsUaPGBbceZ
 JjDyzUIyaRaSSbMQJs1CMmkBI8sqRpHMvLLcxMwcU73i7IzKvMwKveT83E2MwLhYVvtn4g7G
 L5fdDzEKcDAq8fAa1PtnCbEmlhVX5h5ilOBgVhLhfSADFOJNSaysSi3Kjy8qzUktPsQozcGi
 JM7rFZ6aICSQnliSmp2aWpBaBJNl4uCUamAsOH6qRirh/dYD5/nDddmu25QJv3UJFbB4Jhp2
 I/Gsbm/n66c6IdNT3FT2Xd1gIdPxXn0q045JTYFHpV6dnSgU1hkScTbhbMSyEyLWcxN29FXP
 vNjds8a41tAoqPi5QZs284kyIa1NqqEarYqp9Tkn/I4K5O68ozfRkIfZ6anaBz6FVRKn1yux
 FGckGmoxFxUnAgAQyQruhwIAAA==
X-CFilter-Loop: Reflected
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

On Tue, Jul 07, 2026 at 07:33:44AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The newly introduced statement expression macros for DMA fence waiting evaluate their timeout argument (`t`) multiple times.
> - [Medium] Local variable shadowing in the statement expression macros due to the unhygienic `__ret` variable declaration.
> --
> 
> commit 4d4caad8d173eededcba1493c060f5ddecbd6b70
> Author: Byungchul Park <byungchul@sk.com>
> 
> dept: assign unique dept_key to each distinct dma fence caller
> 
> dma fence can be used at various points in the code and it's very hard
> to distinguish dma fences between different usages.  Using a single
> dept_key for all the dma fences could trigger false positive reports.
> 
> > diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> > index d4c92fd350924..3732849a30b7e 100644
> > --- a/include/linux/dma-fence.h
> > +++ b/include/linux/dma-fence.h
> 
> [ ... ]
> 
> > @@ -370,8 +370,22 @@ bool dma_fence_check_and_signal_locked(struct dma_fence *fence);
> >  void dma_fence_signal_locked(struct dma_fence *fence);
> >  void dma_fence_signal_timestamp(struct dma_fence *fence, ktime_t timestamp);
> >  void dma_fence_signal_timestamp_locked(struct dma_fence *fence, ktime_t timestamp);
> > -signed long dma_fence_default_wait(struct dma_fence *fence,
> > +signed long __dma_fence_default_wait(struct dma_fence *fence,
> >                                  bool intr, signed long timeout);
> > +
> > +/*
> > + * Associate every caller with its own dept map.
> > + */
> > +#define dma_fence_default_wait(f, intr, t)                           \
> > +({                                                                   \
> > +     signed long __ret;                                              \
> 
> [Severity: Medium]
> Could this local variable declaration lead to shadowing issues? If a caller
> passes arguments that reference a variable named __ret in their own scope,
> this uninitialized local variable will shadow the caller's variable, causing
> undefined behavior.

I will fix it.

> > +                                                                     \
> > +     sdt_might_sleep_start_timeout(NULL, t);                         \
> > +     __ret = __dma_fence_default_wait(f, intr, t);                   \
> 
> [Severity: Medium]
> Is it safe to evaluate the timeout argument t multiple times here?
> 
> If a caller passes an expression with side effects, such as timeout--, it
> would be evaluated twice, which could lead to incorrect timeout logic.

Sure, I will fix it.

> > +     sdt_might_sleep_end();                                          \
> > +     __ret;                                                          \
> > +})
> > +
> 
> [ ... ]
> 
> > @@ -628,12 +642,37 @@ static inline ktime_t dma_fence_timestamp(struct dma_fence *fence)
> >       return fence->timestamp;
> >  }
> >
> > -signed long dma_fence_wait_timeout(struct dma_fence *,
> > +signed long __dma_fence_wait_timeout(struct dma_fence *,
> >                                  bool intr, signed long timeout);
> > -signed long dma_fence_wait_any_timeout(struct dma_fence **fences,
> > +signed long __dma_fence_wait_any_timeout(struct dma_fence **fences,
> >                                      uint32_t count,
> >                                      bool intr, signed long timeout,
> >                                      uint32_t *idx);
> > +/*
> > + * Associate every caller with its own dept map.
> > + */
> > +#define dma_fence_wait_timeout(f, intr, t)                           \
> > +({                                                                   \
> > +     signed long __ret;                                              \
> > +                                                                     \
> > +     sdt_might_sleep_start_timeout(NULL, t);                         \
> > +     __ret = __dma_fence_wait_timeout(f, intr, t);                   \
> 
> [Severity: Medium]
> Does this code also suffer from the same macro hygiene issues with shadowing
> __ret and evaluating the t argument twice?

Okay, I will fix it.

> > +     sdt_might_sleep_end();                                          \
> > +     __ret;                                                          \
> > +})
> > +
> > +/*
> > + * Associate every caller with its own dept map.
> > + */
> > +#define dma_fence_wait_any_timeout(fpp, count, intr, t, idx)         \
> > +({                                                                   \
> > +     signed long __ret;                                              \
> > +                                                                     \
> > +     sdt_might_sleep_start_timeout(NULL, t);                         \
> > +     __ret = __dma_fence_wait_any_timeout(fpp, count, intr, t, idx); \
> 
> [Severity: Medium]
> Would it be safer to use a more unique variable name instead of __ret, and

Suggestion?

> evaluate t only once before passing it to sdt_might_sleep_start_timeout()
> and __dma_fence_wait_any_timeout(), similar to the other macros?

Sure.

	Byungchul

> > +     sdt_might_sleep_end();                                          \
> > +     __ret;                                                          \
> > +})
> 
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706061928.66713-1-byungchul@sk.com?part=28
