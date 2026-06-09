Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E52CD8CA7
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE7110E1C6;
	Tue,  9 Jun 2026 09:00:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mbKBAflS";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C3E110E1BB
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 09:00:52 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gZNDJ4jM9z9v6H;
 Tue,  9 Jun 2026 11:00:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1780995648; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2XewDnzdhkSGP7z6mkVUkCPOhELJsvC+ONlq1zZ3ECY=;
 b=mbKBAflSUZtPuK/nXwLbpCorxo++jFSHfc1tVKsE1FSvSH3CDangFWORTdz4h/9h1Konzc
 lNcns2124vJhTNJWqs03j3QwW4e5MCrLktPa6Ycqs2lxls2qPt2L7ze6ODB4ijdujPnyro
 E+I3ZJnywOg+KE0hVub8gvgKySdidZaBWRR8gQHrV1VrO9EVeKhDNlOIAUoVD7K5Rl9l2a
 5QDlxcUr5F76D54yUw7Nxcc3xyQPKCKmTbhyccBeFNZb9bap9UIdC7SN/JpCiZ2HVj9iSY
 oY3DVCzd6rQp8Wepvq5S29WJyOLjW/ra0K39r4Kmp2Z+nRl4yKfRK6eiFOltmA==
Message-ID: <f28f1ec7fe3961aa4e616688ac46056421292564.camel@mailbox.org>
Subject: Re: [RFC PATCH] dma-fence: Fix races of fence callbacks versus
 destructors by locking
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 phasta@kernel.org, Boris Brezillon <boris.brezillon@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>,  Alice Ryhl <aliceryhl@google.com>, Daniel
 Almeida <dwlsalmeida@gmail.com>, Gary Guo <gary@garyguo.net>,  Tvrtko
 Ursulin <tvrtko.ursulin@igalia.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 	linux-kernel@vger.kernel.org
Date: Tue, 09 Jun 2026 11:00:43 +0200
In-Reply-To: <8c155cd9-3f79-4e0b-ba3e-1c7e8dad1fa0@amd.com>
References: <20260608142436.265820-2-phasta@kernel.org>
 <20260608170112.24fd92df@fedora-2.home>
 <6bdbdb6541392c6ea58e0035f0b20ac3c8f3e54e.camel@mailbox.org>
 <DJ3RRRX6JY4M.LCRKJ074W9DQ@kernel.org>
 <256dc5ae3529e2548c4151af34a540476ac928c1.camel@mailbox.org>
 <20260608181630.20145d1c@fedora-2.home>
 <739df49a9c0fc54e3d096f95f7d738081f6fcfc2.camel@mailbox.org>
 <8c155cd9-3f79-4e0b-ba3e-1c7e8dad1fa0@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: agbh83dfcab4z3ghtieii8tkw53cd466
X-MBO-RS-ID: 366f5c3a3072fff08a9
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

On Tue, 2026-06-09 at 10:47 +0200, Christian K=C3=B6nig wrote:
> On 6/9/26 10:43, Philipp Stanner wrote:
> > On Mon, 2026-06-08 at 18:16 +0200, Boris Brezillon wrote:
> > > If I were to choose, I'd probably go for a dedicated rwlock_t to
> >=20
> > side note:
> > rw_locks are officially discouraged AFAIK. They utilize more of the
> > expensive instructions than a spinlock and are only worth it if the
> > read section is really long compared to the write section.
> >=20
> > > protect dma_fence_ops, so we can:
> > >=20
> > > - protect all dma_buf_ops::xx() consistently no matter the kind
> > > of op
> > > - protect returned data (get_xxx_name()) with this lock instead
> > > of the
> > > =C2=A0 RCU read lock
> >=20
> > That doesn't solve our Rust destructor problem though, does it?
> >=20
> > What we want to do is:
> >=20
> > =C2=A0=C2=A0 1. Signal the fence before it drops
> > =C2=A0=C2=A0 2. Wait for all accessors to be gone
> > =C2=A0=C2=A0 3. Run the destructor
> >=20
> > Step #2 by definition demands the signaled-state lock.
>=20
> If I'm not completely mistaken that approach won't work.
>=20
> See you can't have a destructor if the dma_fence is independent of
> the module it issued.
>=20
> That's why we have all the handling for inline lock and fence
> independents.

It does work if you have two fence types, one for the producer and one
for the consumers.

The producer type has a destructor, and with Rust you can ensure that
all producer-fences get signaled and deconstructed before module
unload.

That relies on the work done by you and Tvrtko in C, where the
signaled-state is the point of decoupling.

The only additional thing I'd need now would be to make this a hard
synchronization point that cannot race / does not need an RCU delay :)


P.
