Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3929C43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D807910EBA6;
	Tue,  7 Jul 2026 07:34:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OHyYsmkI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CC5310EB9A
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:33:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 37B19437D9;
 Tue,  7 Jul 2026 07:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7392B1F000E9;
 Tue,  7 Jul 2026 07:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783409625;
 bh=2BFynzDzCliPcjcFgwiOh4hD0fCZGiv9eLbuu/gfUXo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OHyYsmkI7NYbdwoQrNWbSbms/DzBipykfBZ7lAnRkMunfbXBmHFP0gNXZ7xTS9wH/
 De4imz4DvADDrhXdUwJFux5F6CxCRd8BiQ5Uzz7ojI/f+cGb56YfgFmPwsIQo+aW2U
 C+bi+beXehGZw+osAjtTvzMwLaS2Aj1ndFOHQ3Mj4orGW9VXQ9ZXRkux2fvA4++aOf
 VezXaJdK+0bzu45bxCugFycIVyuzxCnA1DAliLQx5s1FUyrfHPDkjpPfkDJLeNT29i
 JmAPn0F2otsNkkViuxxpJmQarkcURiRon4j+eo8awH4RtbNCRY6D/ghE8EPerwHplf
 ZdML0TtfGXGiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 28/40] dept: assign unique dept_key to each distinct
 dma fence caller
To: "Byungchul Park" <byungchul@sk.com>
Cc: "Chuck Lever" <cel@kernel.org>, dlemoal@kernel.org,
 "Jeff Layton" <jlayton@kernel.org>, linux-rt-devel@lists.linux.dev,
 linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-ide@vger.kernel.org, tytso@mit.edu, cassel@kernel.org, ojeda@kernel.org,
 "Anna Schumaker" <anna@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20260706061928.66713-29-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-29-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:44 +0000
Message-Id: <20260707073344.7392B1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The newly introduced statement expression macros for DMA fence w=
aiting evaluate their timeout argument (`t`) multiple times.
- [Medium] Local variable shadowing in the statement expression macros due =
to the unhygienic `__ret` variable declaration.
--

commit 4d4caad8d173eededcba1493c060f5ddecbd6b70
Author: Byungchul Park <byungchul@sk.com>

dept: assign unique dept_key to each distinct dma fence caller

dma fence can be used at various points in the code and it's very hard
to distinguish dma fences between different usages.  Using a single
dept_key for all the dma fences could trigger false positive reports.

> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index d4c92fd350924..3732849a30b7e 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h

[ ... ]

> @@ -370,8 +370,22 @@ bool dma_fence_check_and_signal_locked(struct dma_fe=
nce *fence);
>  void dma_fence_signal_locked(struct dma_fence *fence);
>  void dma_fence_signal_timestamp(struct dma_fence *fence, ktime_t timesta=
mp);
>  void dma_fence_signal_timestamp_locked(struct dma_fence *fence, ktime_t =
timestamp);
> -signed long dma_fence_default_wait(struct dma_fence *fence,
> +signed long __dma_fence_default_wait(struct dma_fence *fence,
>  				   bool intr, signed long timeout);
> +
> +/*
> + * Associate every caller with its own dept map.
> + */
> +#define dma_fence_default_wait(f, intr, t)				\
> +({									\
> +	signed long __ret;						\

[Severity: Medium]
Could this local variable declaration lead to shadowing issues? If a caller
passes arguments that reference a variable named __ret in their own scope,
this uninitialized local variable will shadow the caller's variable, causing
undefined behavior.

> +									\
> +	sdt_might_sleep_start_timeout(NULL, t);				\
> +	__ret =3D __dma_fence_default_wait(f, intr, t);			\

[Severity: Medium]
Is it safe to evaluate the timeout argument t multiple times here?

If a caller passes an expression with side effects, such as timeout--, it
would be evaluated twice, which could lead to incorrect timeout logic.

> +	sdt_might_sleep_end();						\
> +	__ret;								\
> +})
> +

[ ... ]

> @@ -628,12 +642,37 @@ static inline ktime_t dma_fence_timestamp(struct dm=
a_fence *fence)
>  	return fence->timestamp;
>  }
> =20
> -signed long dma_fence_wait_timeout(struct dma_fence *,
> +signed long __dma_fence_wait_timeout(struct dma_fence *,
>  				   bool intr, signed long timeout);
> -signed long dma_fence_wait_any_timeout(struct dma_fence **fences,
> +signed long __dma_fence_wait_any_timeout(struct dma_fence **fences,
>  				       uint32_t count,
>  				       bool intr, signed long timeout,
>  				       uint32_t *idx);
> +/*
> + * Associate every caller with its own dept map.
> + */
> +#define dma_fence_wait_timeout(f, intr, t)				\
> +({									\
> +	signed long __ret;						\
> +									\
> +	sdt_might_sleep_start_timeout(NULL, t);				\
> +	__ret =3D __dma_fence_wait_timeout(f, intr, t);			\

[Severity: Medium]
Does this code also suffer from the same macro hygiene issues with shadowing
__ret and evaluating the t argument twice?

> +	sdt_might_sleep_end();						\
> +	__ret;								\
> +})
> +
> +/*
> + * Associate every caller with its own dept map.
> + */
> +#define dma_fence_wait_any_timeout(fpp, count, intr, t, idx)		\
> +({									\
> +	signed long __ret;						\
> +									\
> +	sdt_might_sleep_start_timeout(NULL, t);				\
> +	__ret =3D __dma_fence_wait_any_timeout(fpp, count, intr, t, idx);	\

[Severity: Medium]
Would it be safer to use a more unique variable name instead of __ret, and
evaluate t only once before passing it to sdt_might_sleep_start_timeout()
and __dma_fence_wait_any_timeout(), similar to the other macros?

> +	sdt_might_sleep_end();						\
> +	__ret;								\
> +})

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D28
