Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C050CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:18:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB71710F5A0;
	Mon,  8 Jun 2026 15:18:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="t6p5kcq4";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A39B10F5A0
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 15:18:04 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gYwf06RW0z9t2V;
 Mon,  8 Jun 2026 17:18:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1780931880; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MvgHNmO3IxC6FXq47XwMRXs/rO7p6vxeZKZs8DURXVw=;
 b=t6p5kcq4GEPZGEBmrYJd5WjDVKQDmd/x+E1K3DdHytPDxNbcqknDyjyuhQHcAfV2NSrBhe
 nSvqr5gFQvWu749rsfgAqGdcLMPphK4gfu3xsTVIQnzP2cOQXcdjvNYUeL6EMyGDx+6I3f
 iEpo/nkHHG70UXXBwkp/YXHUaftkIv3Uqr6iuOIX+D8/CITL5vbIWtLjfjpeON6EORLB2w
 op5eLLM8rRo7vU0aiUn0cSHZPVqTH/V5B8C3VNtmrN8pyFDfmtPSURZmaLDXOaaEvP2lQM
 8hHgZhkSra8TL+1ZswdsGbvGROxZ19ItM4ndpTxwuo/uocUU0gcxWAh2aN018w==
Message-ID: <6bdbdb6541392c6ea58e0035f0b20ac3c8f3e54e.camel@mailbox.org>
Subject: Re: [RFC PATCH] dma-fence: Fix races of fence callbacks versus
 destructors by locking
From: Philipp Stanner <phasta@mailbox.org>
To: Boris Brezillon <boris.brezillon@collabora.com>, Philipp Stanner
 <phasta@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Alice Ryhl
 <aliceryhl@google.com>, Daniel Almeida	 <dwlsalmeida@gmail.com>, Gary Guo
 <gary@garyguo.net>, Tvrtko Ursulin	 <tvrtko.ursulin@igalia.com>,
 linux-media@vger.kernel.org, 	dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Danilo Krummrich	 <dakr@kernel.org>
Date: Mon, 08 Jun 2026 17:17:57 +0200
In-Reply-To: <20260608170112.24fd92df@fedora-2.home>
References: <20260608142436.265820-2-phasta@kernel.org>
 <20260608170112.24fd92df@fedora-2.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 59bc9e339d8aa4148f6
X-MBO-RS-META: 87wtwfwi7qid9a3otercu8yt7yiyc6zx
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

On Mon, 2026-06-08 at 17:01 +0200, Boris Brezillon wrote:
> On Mon,=C2=A0 8 Jun 2026 16:24:37 +0200
> Philipp Stanner <phasta@kernel.org> wrote:
>=20
> > @@ -1020,11 +1024,20 @@ EXPORT_SYMBOL(dma_fence_wait_any_timeout);
> > =C2=A0void dma_fence_set_deadline(struct dma_fence *fence, ktime_t dead=
line)
> > =C2=A0{
> > =C2=A0	const struct dma_fence_ops *ops;
> > +	unsigned long flags;
> > =C2=A0
> > =C2=A0	rcu_read_lock();
> > =C2=A0	ops =3D rcu_dereference(fence->ops);
> > -	if (ops && ops->set_deadline && !dma_fence_is_signaled(fence))
> > +	if (!ops || !ops->set_deadline) {
> > +		rcu_read_unlock();
> > +		return;
> > +	}
> > +
> > +	dma_fence_lock_irqsave(fence, flags);
> > +	if (!dma_fence_is_signaled_locked(fence))
> > =C2=A0		ops->set_deadline(fence, deadline);
>=20
> You can't take the fence lock around ->set_deadline(), otherwise you'll
> deadlock here [1] or here [2].
>=20
> > +
> > +	dma_fence_unlock_irqrestore(fence, flags);
> > =C2=A0	rcu_read_unlock();
> > =C2=A0}
>=20
>=20
> [1]https://elixir.bootlin.com/linux/v7.0.11/source/drivers/dma-buf/sw_syn=
c.c#L182
> [2]https://elixir.bootlin.com/linux/v7.0.11/source/drivers/gpu/drm/msm/ms=
m_fence.c#L139


If we'd port these (and maybe some we have overlooked) simultaneously,
they could completely drop their separate locking.

The fact that other parties were forced to take the fence lock in their
callbacks (and even 100% of the functions' code) actually proves that
this RFC is probably a good idea and callback-calls should be guarded
by the fence lock :]


P.
