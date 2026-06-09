Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8CCCD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFBCA10E1AE;
	Tue,  9 Jun 2026 08:54:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="c8vAWrP5";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E120C10E1AE
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:54:12 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gZN4f0Fx7z9tQk;
 Tue,  9 Jun 2026 10:54:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1780995250; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gnzyn1FtEPpW02KE6pMOpwrpdyoImhLB9p+D4NNEkXI=;
 b=c8vAWrP5sn+etNsyihfOpmaxCiaSeqoK9GKXLKFKEq89C9fuFdxku7NXMP7/lwCbBMXHab
 a6IwF72CtYuidcytHCssAjxTZIf6MBW9n6W1nhBSQi4G7ZN/ilMzp3oEVoulQJwhJb+IzM
 S4gjODUMHW+ECFLPQJhJYtGyYONNuvfDuPd1h3jcCJFKVZ95FdJBxGiQ816zyPwd2dnK/K
 oYa8drj3HxBdL5RGHcS1MF0g1VJo+nccumjWVDwVGMR+rQac2w50CJ8CEZwDVtJbel+0XM
 2an34AFwa+1gDLXJ8lI9GfBL4Bgr4T8bX6e7OLqmN1IgygCE8eE21Op4GlNojg==
Message-ID: <fa2e15f41ef361dd25170ab89509952d3ec8bce5.camel@mailbox.org>
Subject: Re: [RFC PATCH] dma-fence: Fix races of fence callbacks versus
 destructors by locking
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Boris
 Brezillon <boris.brezillon@collabora.com>
Cc: phasta@kernel.org, Danilo Krummrich <dakr@kernel.org>, Sumit Semwal	
 <sumit.semwal@linaro.org>, Alice Ryhl <aliceryhl@google.com>, Daniel
 Almeida	 <dwlsalmeida@gmail.com>, Gary Guo <gary@garyguo.net>, Tvrtko
 Ursulin	 <tvrtko.ursulin@igalia.com>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 09 Jun 2026 10:54:05 +0200
In-Reply-To: <850fd675-714e-4e3c-895a-d1dafaeb8219@amd.com>
References: <20260608142436.265820-2-phasta@kernel.org>
 <20260608170112.24fd92df@fedora-2.home>
 <6bdbdb6541392c6ea58e0035f0b20ac3c8f3e54e.camel@mailbox.org>
 <DJ3RRRX6JY4M.LCRKJ074W9DQ@kernel.org>
 <256dc5ae3529e2548c4151af34a540476ac928c1.camel@mailbox.org>
 <20260608181630.20145d1c@fedora-2.home>
 <850fd675-714e-4e3c-895a-d1dafaeb8219@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: uw5m3caeppkq64k5ydrhg1ao9dhasi9g
X-MBO-RS-ID: 4b965308c8edfb90f2a
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

On Tue, 2026-06-09 at 10:02 +0200, Christian K=C3=B6nig wrote:
> On 6/8/26 18:16, Boris Brezillon wrote:
> > - calling with the lock held in the new places is not causing a
> > =C2=A0 deadlock
>=20
> Yeah, exactly that.
>=20
> For example the set_deadline() is intentionally not called with the
> fence lock held because that won't work for some use cases.
>=20
> The problem when you call ops with a lock held is always that this
> lock then becomes the outermost look held. In other words when you
> for example want to grab a power management lock to implement the
> deadline feature the framework enforces an order between the two
> locks which isn't desired.

A deadlock can only happen if that power management routine also
attempts to take the fence lock. Or maybe the fence ctx lock.

Why would it want to do that? What does it want to signal? I suppose in
case of a close enough deadline you will do a firmware call to shovel
some more coals into the kettle.

The only GPU driver implementing it seems MSM anyways?


P.
