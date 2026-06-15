Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8882CD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 10:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 356F510E323;
	Mon, 15 Jun 2026 10:04:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lYXH3qjU";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C33A10E323
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 10:04:41 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gf5M94sSVz9vD9;
 Mon, 15 Jun 2026 12:04:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1781517877; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vcMfyWCmScqAXuIuZfOPShBN7wAdoe95v7+nL69H0sE=;
 b=lYXH3qjUvqrL/6mAF0LaPbLonPIQO3HtOnWoUVS4q0V4iT4LF7naeR9xtXNWv34jMPNRrS
 GflRTrWTsxB4rbS1HNfy7a4n2H4A7a1y7kW/hLEyTIwUUlH1kbKDTVeAkgRJn+EMXY7vwO
 374k4z/edg1ACd4rI12mxcmuYlDd37FX/zs6NIxSHP96tK/FOBcQj212PNwv+19OZ4nEap
 nkLsMijRxqWTdQu+p9r+7VZYjAXwQaZbYPdaczNWMY2QkKQHbRFsoRq2cqlGQ62YjA9dvq
 E0XS9dSQ71rhGchKPZA2TsEV0x+GY7I11ZHA9S8BVyFOPuS1Vq6Fklk2yeipqQ==
Message-ID: <bf3917fb3ba6bd34611f5aff63178d80c13ebc4d.camel@mailbox.org>
Subject: Re: [RFC PATCH] dma-buf/dma_fence: Make races for
 dma_fence_is_signaled() less likely
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Philipp
 Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Maarten
 Lankhorst	 <maarten.lankhorst@linux.intel.com>, David Airlie
 <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>, Sumit Semwal
 <sumit.semwal@linaro.org>, Tvrtko Ursulin	 <tvrtko.ursulin@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,  "Paul E . McKenney"	
 <paulmck@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Mon, 15 Jun 2026 12:04:32 +0200
In-Reply-To: <600885fc-7e07-4713-b5c2-a470637040c8@amd.com>
References: <20260612104251.2264707-2-phasta@kernel.org>
 <600885fc-7e07-4713-b5c2-a470637040c8@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 5882d3cc14375d1b852
X-MBO-RS-META: 94478hzu1jzm6hdcatri5kbhpubb7dfn
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, 2026-06-15 at 11:53 +0200, Christian K=C3=B6nig wrote:
> On 6/12/26 12:42, Philipp Stanner wrote:
> > dma_fence_is_signaled() returns whether a fence has been signaled
> > already. That function contains a fast path opportunistic check which i=
s
> > not guarded by the lock and, according to Christian, cannot be guarded
> > by the lock without causing a massive performance regression.
> >=20
> > This now means that dma_fence_is_signaled() can return true WHILE the
> > fence callbacks are still being executed. This is razy and has lead to
> > at least one bug solved in:
> >=20
> > commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race")
> >=20
> > Make this race impossible, by simply setting the bit only once the
> > callbacks are actually completed.
>=20
> Groundhog day, that has been suggested before and it simply doesn't work.
>=20
> The flag is intentional set before calling the callbacks because the stat=
e needs to be visible.

It will be visible. Just later.

>=20
> Just see dma_fence_default_wait() for an example why that approach doesn'=
t work.

What's the issue? It will be set. Just later. Who is ordering with
whom?


I BTW suggest to write more code comments in the future to document all
these supposed pitfalls for those who will hack on that code base once
we have left.


P.

>=20
> Regards,
> Christian.
>=20
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> > =C2=A0drivers/dma-buf/dma-fence.c | 18 ++++++++++++++++--
> > =C2=A01 file changed, 16 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> > index c7ea1e75d38a..2416cc86ce93 100644
> > --- a/drivers/dma-buf/dma-fence.c
> > +++ b/drivers/dma-buf/dma-fence.c
> > @@ -359,8 +359,19 @@ void dma_fence_signal_timestamp_locked(struct dma_=
fence *fence,
> > =C2=A0
> > =C2=A0	dma_fence_assert_held(fence);
> > =C2=A0
> > -	if (unlikely(test_and_set_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
> > -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &fence->flags)))
> > +	/*
> > +	 * First test the bit, so we don't signal an already signaled fence a=
gain.
> > +	 * The lock protects against multiple parties setting the bit. The bi=
t
> > +	 * is then set at the end of the function.
> > +	 *
> > +	 * The background is that there is a fast path check in
> > +	 * dma_fence_is_signaled() which does not use lock protection and can
> > +	 * return true *while* the fence callbacks are still executing.
> > +	 *
> > +	 * This fast path check supposedly cannot be guarded by the lock beca=
use
> > +	 * of significant performance regressions.
> > +	 */
> > +	if (unlikely(test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
> > =C2=A0		return;
> > =C2=A0
> > =C2=A0	trace_dma_fence_signaled(fence);
> > @@ -384,6 +395,9 @@ void dma_fence_signal_timestamp_locked(struct dma_f=
ence *fence,
> > =C2=A0		INIT_LIST_HEAD(&cur->node);
> > =C2=A0		cur->func(fence, cur);
> > =C2=A0	}
> > +
> > +	// TODO: we need some barrier here, don't we?
> > +	set_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(dma_fence_signal_timestamp_locked);
> > =C2=A0
