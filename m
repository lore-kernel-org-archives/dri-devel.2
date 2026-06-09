Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBA9CD8C92
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 13:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87F9B10E40D;
	Tue,  9 Jun 2026 13:19:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nvLL6Ubj";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5338F10E40D
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 13:19:18 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gZTyW2glfz9tnw;
 Tue,  9 Jun 2026 15:19:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1781011155; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mPZl402TTzFkEbpsWPx3x9qh63uQoHgvkfTnX6weyHw=;
 b=nvLL6Ubjv+0bH+rIPtjZU8EmZQHHyj2A6D3QdOBuIaXO7Kxs7kjGpEp5ZFuNm/+Lhl/Q9I
 rEKqDsVvwfxsqw7qoqbSfKHjyBaMEfhrPT1N4Xo1yQIGJ71+ahNIexZcy8gl2EVXzOMQYf
 qfVNjQ8jiQs3C7T8d/qXml0ks8sq3NlUWs8V3DbyK8rvYujOieaNHCENP4YG3UIynSduzI
 Ll93dtBD2UVh23Ke3ySj3WLB56fcXxoK69Y7LMQMxpQXXzGNqRhqgEJ15cKY3Tcf8YTtJD
 4KQa8JDlNV9vzFaQVyGhTf7E5DL1bBZDN0dDev5Efyemwp+Q4sbnEluzo4iUQQ==
Message-ID: <aebe759117cd65004510946e39bd02e4c903e1e3.camel@mailbox.org>
Subject: Re: [RFC PATCH] dma-fence: Fix races of fence callbacks versus
 destructors by locking
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Danilo
 Krummrich <dakr@kernel.org>, airlied@gmail.com
Cc: phasta@kernel.org, Sumit Semwal <sumit.semwal@linaro.org>, Boris
 Brezillon	 <boris.brezillon@collabora.com>, Alice Ryhl
 <aliceryhl@google.com>, Daniel Almeida <dwlsalmeida@gmail.com>, Gary Guo
 <gary@garyguo.net>, Tvrtko Ursulin	 <tvrtko.ursulin@igalia.com>,
 linux-media@vger.kernel.org, 	dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Date: Tue, 09 Jun 2026 15:19:10 +0200
In-Reply-To: <c8564ea0-8ff4-4049-996d-bd978c478372@amd.com>
References: <20260608142436.265820-2-phasta@kernel.org>
 <95f4ae6b-9dec-4122-84e0-fbb0cdee9cb5@amd.com>
 <fa9a335196525adbc03ec21b2e05bb526e4fc174.camel@mailbox.org>
 <9d49c901-fcdf-487a-a733-0320d0bdf94c@amd.com>
 <DJ3V3OCLIK2K.3CYKWYNHYU6JQ@kernel.org>
 <ea4e0541-3702-4014-b8f6-0746a148df86@amd.com>
 <DJ3VYD71HDQ2.3C8GG983Z2YCM@kernel.org>
 <c8564ea0-8ff4-4049-996d-bd978c478372@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: jzpunfkr5bfxqpmxapy8ykety9n455dw
X-MBO-RS-ID: 048a86ff4514b3ea937
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

+Cc Dave

On Mon, 2026-06-08 at 20:47 +0200, Christian K=C3=B6nig wrote:
> On 6/8/26 20:39, Danilo Krummrich wrote:
> > How did you get to this conclusion considering that you run into what I
> > mentioned above as well and the fact that we seem to agree that the per=
formance
> > concern is rather questionable?
>=20
> Quite simple, it's the cleaner approach.
>=20
> Calling callbacks with locks held is rather questionable even putting the=
 performance issue aside.


I'm right now going through all fence users to see whether we can
implement my solution.

And look what I found:

static inline bool
nouveau_cli_work_ready(struct dma_fence *fence)
{
	unsigned long flags;
	bool ret =3D true;

	dma_fence_lock_irqsave(fence, flags);
	if (!dma_fence_is_signaled_locked(fence))
		ret =3D false;
	dma_fence_unlock_irqrestore(fence, flags);

	if (ret =3D=3D true)
		dma_fence_put(fence);
	return ret;
}


That looks weird, doesn't it?


We do some git-blame:

c8a5d5ea3ba6a18958f8d76430e4cd68eea33943

and we find that it's Dave who wrote that code, because

"
    My analysis: two threads are running, one in the irq signalling the
    fence, in dma_fence_signal_timestamp_locked, it has done the
    DMA_FENCE_FLAG_SIGNALLED_BIT setting, but hasn't yet reached the
    callbacks.
   =20
    The second thread in nouveau_cli_work_ready, where it sees the fence is
    signalled, so then puts the fence, cleanups the object and frees the
    work item, which contains the callback.
   =20
    Thread one goes again and tries to call the callback and causes the
    use-after-free.
"


So this is a race, caused by lockless speed optimization.

And it would further seem that there is one invention in computer
science that can prevent such races:

Locks.

There is no cleaner, safer synchronization strategy in computer science
than locking.

This race became possible because the lock does not guard the entirety
of dma_fence_is_signaled().

Wouldn't you agree that this is a strong indicator for the great
advantages that consequent and consistent lock-protection grants? IOW,
by using locks more strictly in dma_fence, we can increase its
robustness and reliability.


P.
