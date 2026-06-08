Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E47ECD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82BB410F5EE;
	Mon,  8 Jun 2026 15:31:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="eOqVfl0Y";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 204E610F5EE
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 15:31:06 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gYwx151nsz9tSP;
 Mon,  8 Jun 2026 17:31:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1780932661; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wn7yLxLm8kmCdN7adnHk3oLnLkZt7t/zPoim3PIkgr0=;
 b=eOqVfl0YD2dNt7u6nIK03/7OdlTIHMnSU1dWs33nGjnD/qHnPtne5qwyK4k0w4v4fs6Uhp
 pjoP1fyR3l6yMmI70LyoZkRMjFn4hiW1tkknL0QicSvCKcGsQYZr7YRYW4Lm/dasu/jJTI
 42L58/aGXdROgytemZAS3jt7YS3PcmW0ClR3l6tYTU1dtrUm6rXPbCO1EUqNGVoasFqZ6w
 4ZFqlyiXqvwGMutSAgl7iB/Kxwhl1mDWG49zVAxoAdOkEQNdG7rIwvvXYGqhm+7lixkFH6
 MeUe8Y4khaNJzVrQ9Bg2d2nGtPM3G3gzHrNJGNaCBjCdnt8DgWA9tPBCx6xKFA==
Message-ID: <256dc5ae3529e2548c4151af34a540476ac928c1.camel@mailbox.org>
Subject: Re: [RFC PATCH] dma-fence: Fix races of fence callbacks versus
 destructors by locking
From: Philipp Stanner <phasta@mailbox.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: phasta@kernel.org, Boris Brezillon <boris.brezillon@collabora.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>,  Alice Ryhl <aliceryhl@google.com>, Daniel
 Almeida <dwlsalmeida@gmail.com>, Gary Guo <gary@garyguo.net>,  Tvrtko
 Ursulin <tvrtko.ursulin@igalia.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 	linux-kernel@vger.kernel.org
Date: Mon, 08 Jun 2026 17:30:58 +0200
In-Reply-To: <DJ3RRRX6JY4M.LCRKJ074W9DQ@kernel.org>
References: <20260608142436.265820-2-phasta@kernel.org>
 <20260608170112.24fd92df@fedora-2.home>
 <6bdbdb6541392c6ea58e0035f0b20ac3c8f3e54e.camel@mailbox.org>
 <DJ3RRRX6JY4M.LCRKJ074W9DQ@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 728debd615e70e6d046
X-MBO-RS-META: q9xpqdt4tjm3ihj87tj9qjpfrc5uhntn
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

On Mon, 2026-06-08 at 17:23 +0200, Danilo Krummrich wrote:
> On Mon Jun 8, 2026 at 5:17 PM CEST, Philipp Stanner wrote:
> > On Mon, 2026-06-08 at 17:01 +0200, Boris Brezillon wrote:
> > > On Mon,=C2=A0 8 Jun 2026 16:24:37 +0200
> > > Philipp Stanner <phasta@kernel.org> wrote:
> > >=20
> > > > @@ -1020,11 +1024,20 @@ EXPORT_SYMBOL(dma_fence_wait_any_timeout);
> > > > =C2=A0void dma_fence_set_deadline(struct dma_fence *fence, ktime_t =
deadline)
> > > > =C2=A0{
> > > > =C2=A0	const struct dma_fence_ops *ops;
> > > > +	unsigned long flags;
> > > > =C2=A0
> > > > =C2=A0	rcu_read_lock();
> > > > =C2=A0	ops =3D rcu_dereference(fence->ops);
> > > > -	if (ops && ops->set_deadline && !dma_fence_is_signaled(fence))
> > > > +	if (!ops || !ops->set_deadline) {
> > > > +		rcu_read_unlock();
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	dma_fence_lock_irqsave(fence, flags);
> > > > +	if (!dma_fence_is_signaled_locked(fence))
> > > > =C2=A0		ops->set_deadline(fence, deadline);
> > >=20
> > > You can't take the fence lock around ->set_deadline(), otherwise you'=
ll
> > > deadlock here [1] or here [2].
> > >=20
> > > > +
> > > > +	dma_fence_unlock_irqrestore(fence, flags);
> > > > =C2=A0	rcu_read_unlock();
> > > > =C2=A0}
> > >=20
> > >=20
> > > [1]https://elixir.bootlin.com/linux/v7.0.11/source/drivers/dma-buf/sw=
_sync.c#L182
> > > [2]https://elixir.bootlin.com/linux/v7.0.11/source/drivers/gpu/drm/ms=
m/msm_fence.c#L139

Oh, MSM actually doesn't btw, that's a false positive. That's a
distinct spinlock on their fence context object.


But yes, before we could upstream this, we would go through all the
implementors like Danilo did, to find all the others.

P.

> >=20
> >=20
> > If we'd port these (and maybe some we have overlooked) simultaneously,
> > they could completely drop their separate locking.
> >=20
> > The fact that other parties were forced to take the fence lock in their
> > callbacks (and even 100% of the functions' code) actually proves that
> > this RFC is probably a good idea and callback-calls should be guarded
> > by the fence lock :]
>=20
> I think I looked into this recently and IIRC it indeed seems like all
> implementors of set_deadline() take the lock within their callback.
