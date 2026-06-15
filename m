Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD2ECD98CF
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95EE510E46E;
	Mon, 15 Jun 2026 14:17:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Qeivuea1";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D65FC10E46E
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 14:17:03 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gfByN6D5Gz9tqP;
 Mon, 15 Jun 2026 16:17:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1781533020; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TuZ3x3JTN/9yH9PEoZ3f5MyKUlmqnsPISl7oI8ILi2g=;
 b=Qeivuea1s4p88OtgKz6JPZQHhxKqaZk17DV/XYyBWtbfX8GpRrlceG+WlX52Si3a7Jfqa9
 cioUmsT+L1/s/qfcVnvtREmNAxxpHfnDPmb2Ms1lVbmwMHdt7X31nKqkAO5UBkTkkvYs2F
 mIvVsPAFVEWCJ9FbdH04rgae19CsFb8K1CujJLS+z2AZOi6SQ5aji5G0JHXDRp4ihDclPL
 NHCii66GnkH2VKiDYYyVJtZvppS0J+w8m4Jy7NYeJ5qmLeVIzYP74Mhqnik9hnB8yjJgoG
 1zpNZMo5tTiracVbHXw7BSrzoqzU4cK4Wi/YE9I5CBn1Bd9dgt+46YAOnnhIeg==
Message-ID: <c67c57b05f4ecae75439be6ba613e8c92f13952b.camel@mailbox.org>
Subject: Re: [RFC PATCH] dma-buf/dma_fence: Make races for
 dma_fence_is_signaled() less likely
From: Philipp Stanner <phasta@mailbox.org>
To: Gary Guo <gary@garyguo.net>, Philipp Stanner <phasta@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, David Airlie	 <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal	 <sumit.semwal@linaro.org>,
 Christian =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Tvrtko
 Ursulin <tvrtko.ursulin@igalia.com>,  Boris Brezillon
 <boris.brezillon@collabora.com>, "Paul E . McKenney" <paulmck@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, dri-devel
 <dri-devel-bounces@lists.freedesktop.org>
Date: Mon, 15 Jun 2026 16:16:53 +0200
In-Reply-To: <DJ9J7LOD4NKC.LUC2DF5MC5ZQ@garyguo.net>
References: <20260612104251.2264707-2-phasta@kernel.org>
 <DJ9J7LOD4NKC.LUC2DF5MC5ZQ@garyguo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: 71x74475hxah1syx86exmmww6q7ucrc3
X-MBO-RS-ID: 22942d2814785c88b74
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

On Mon, 2026-06-15 at 10:56 +0100, Gary Guo wrote:
> On Fri Jun 12, 2026 at 11:42 AM BST, Philipp Stanner wrote:
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
>=20
> You want a release barrier here, which we don't have currently, but you c=
an use
> `smp_mb__before_atomic`.
>=20
> However note that barriers must be paired, so in order for the added barr=
ier to
> do anything, dma_fence_is_signaled lockless fast path would need to have =
an
> acquire barrier, which we also don't have, so you need a `smp_mb()` there=
 after
> the flag test.

Thx for the explanations.

I tend to conclude that this solution is far too fragile and without
even further synchronization we couldn't solve that, because the fence-
>signaled is at other places evaluated locklessly

const char __rcu *dma_fence_timeline_name(struct dma_fence *fence)
{
	const struct dma_fence_ops *ops;

	/* RCU protection is required for safe access to returned string */
	ops =3D rcu_dereference(fence->ops);
	if (!dma_fence_test_signaled_flag(fence))
		return (const char __rcu *)ops->get_driver_name(fence);
	else
		return (const char __rcu *)"signaled-timeline";
}
EXPORT_SYMBOL(dma_fence_timeline_name);

The signaled flag here is ordered in the reverse order.
dma_fence_signal_timestamp_locked() sets the ops pointer to NULL, so
you might dereference a NULL pointer there.


P.

>=20
> Best,
> Gary
>=20
> > +	set_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(dma_fence_signal_timestamp_locked);
> > =C2=A0
>=20
