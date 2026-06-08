Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B290CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A379910F5BE;
	Mon,  8 Jun 2026 15:23:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZN3TL//e";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB76E10F5BE
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 15:23:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 87B834407C;
 Mon,  8 Jun 2026 15:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291301F00893;
 Mon,  8 Jun 2026 15:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780932190;
 bh=ncrCACTkUNfpMUjm6+cmxSyvVwJrnjrLOEWj6i6HgS0=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=ZN3TL//euvdAQwQDgxiVPv21Aw4q89ZhitkD/YVtPRSaYl0lSBgj49DySlUYKfJ+n
 Oqe1OVsOF2J63uXbWvS6giHwvAp86wM9KkINGd4GgzC+Fh8DzTU+dYj6pGqmmEm0Pl
 ekRS94DBLtMaFVbcTLXkIFIJAjzx0glePdVQgBDPMh7qpTsn92ncyb4FslfbVKNd2z
 hCq+09a4u9mGttY8IhVw70vZxvJ4ThN9gHiSLfmnvwpOpAMnIqL2iXfS+Ybpr4SvKn
 q10xOpKfiPbQu5muBc7tSUrAfkMT5en8N6DO2I1F8bui1exLPuTGT4qGy1gCacN6Ej
 y3V3NCPaQUX7g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 17:23:06 +0200
Message-Id: <DJ3RRRX6JY4M.LCRKJ074W9DQ@kernel.org>
Subject: Re: [RFC PATCH] dma-fence: Fix races of fence callbacks versus
 destructors by locking
Cc: <phasta@kernel.org>, "Boris Brezillon" <boris.brezillon@collabora.com>,
 "Sumit Semwal" <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel
 Almeida" <dwlsalmeida@gmail.com>, "Gary Guo" <gary@garyguo.net>, "Tvrtko
 Ursulin" <tvrtko.ursulin@igalia.com>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Philipp Stanner" <phasta@mailbox.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260608142436.265820-2-phasta@kernel.org>
 <20260608170112.24fd92df@fedora-2.home>
 <6bdbdb6541392c6ea58e0035f0b20ac3c8f3e54e.camel@mailbox.org>
In-Reply-To: <6bdbdb6541392c6ea58e0035f0b20ac3c8f3e54e.camel@mailbox.org>
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

On Mon Jun 8, 2026 at 5:17 PM CEST, Philipp Stanner wrote:
> On Mon, 2026-06-08 at 17:01 +0200, Boris Brezillon wrote:
>> On Mon,=C2=A0 8 Jun 2026 16:24:37 +0200
>> Philipp Stanner <phasta@kernel.org> wrote:
>>=20
>> > @@ -1020,11 +1024,20 @@ EXPORT_SYMBOL(dma_fence_wait_any_timeout);
>> > =C2=A0void dma_fence_set_deadline(struct dma_fence *fence, ktime_t dea=
dline)
>> > =C2=A0{
>> > =C2=A0	const struct dma_fence_ops *ops;
>> > +	unsigned long flags;
>> > =C2=A0
>> > =C2=A0	rcu_read_lock();
>> > =C2=A0	ops =3D rcu_dereference(fence->ops);
>> > -	if (ops && ops->set_deadline && !dma_fence_is_signaled(fence))
>> > +	if (!ops || !ops->set_deadline) {
>> > +		rcu_read_unlock();
>> > +		return;
>> > +	}
>> > +
>> > +	dma_fence_lock_irqsave(fence, flags);
>> > +	if (!dma_fence_is_signaled_locked(fence))
>> > =C2=A0		ops->set_deadline(fence, deadline);
>>=20
>> You can't take the fence lock around ->set_deadline(), otherwise you'll
>> deadlock here [1] or here [2].
>>=20
>> > +
>> > +	dma_fence_unlock_irqrestore(fence, flags);
>> > =C2=A0	rcu_read_unlock();
>> > =C2=A0}
>>=20
>>=20
>> [1]https://elixir.bootlin.com/linux/v7.0.11/source/drivers/dma-buf/sw_sy=
nc.c#L182
>> [2]https://elixir.bootlin.com/linux/v7.0.11/source/drivers/gpu/drm/msm/m=
sm_fence.c#L139
>
>
> If we'd port these (and maybe some we have overlooked) simultaneously,
> they could completely drop their separate locking.
>
> The fact that other parties were forced to take the fence lock in their
> callbacks (and even 100% of the functions' code) actually proves that
> this RFC is probably a good idea and callback-calls should be guarded
> by the fence lock :]

I think I looked into this recently and IIRC it indeed seems like all
implementors of set_deadline() take the lock within their callback.
