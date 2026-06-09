Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FEBCD8CA8
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0008B10E291;
	Tue,  9 Jun 2026 11:39:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tk5HlD4L";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49D5A10E280
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 11:39:16 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gZRl52q1Fz9tr7;
 Tue,  9 Jun 2026 13:39:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1781005153; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eluLLDgP42hnm6jSqwzWJSIrEMLWAxnFr1RN8X6YAUo=;
 b=tk5HlD4L9kqxIDcZlFhew/dR8jEsftGQ+wCMkGLdLOrCCkOVQ7Bho2T2WQIaP67moDgwxv
 9dm3zNzGOrb8PPnNNBIcoad6erBNpY9vEe5TF9JVbYHvkWunfu6DwBOkPjc09Y54oF5BhM
 GazDZiH7A9GLSK1KTnQiUTZWNoDO4aXuVtmpY2We1Vw1U85LkZlA2mhqO8QKEGlzxKq1on
 FuTpHQ1DIwrOiJM7fP58UAcNf/yqXvtGHH94umZXFnxv4YOJ6U7KydRony9llLW6nCKW8j
 xgj8QwnlCU2QOtSVFMqPh7H6h6RpfhRYr90IhSvl7aI0mU57YJlHya6eTc4oOA==
Message-ID: <ced850f9e421d6549c25c27d50a99111bddb2db2.camel@mailbox.org>
Subject: Re: [RFC PATCH] dma-fence: Fix races of fence callbacks versus
 destructors by locking
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 phasta@kernel.org, Danilo Krummrich <dakr@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Boris Brezillon	
 <boris.brezillon@collabora.com>, Alice Ryhl <aliceryhl@google.com>, Daniel
 Almeida <dwlsalmeida@gmail.com>, Gary Guo <gary@garyguo.net>, Tvrtko
 Ursulin	 <tvrtko.ursulin@igalia.com>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 09 Jun 2026 13:39:09 +0200
In-Reply-To: <1bb5efeb-a5d3-4d0b-ae69-8dc8620604d4@amd.com>
References: <20260608142436.265820-2-phasta@kernel.org>
 <95f4ae6b-9dec-4122-84e0-fbb0cdee9cb5@amd.com>
 <fa9a335196525adbc03ec21b2e05bb526e4fc174.camel@mailbox.org>
 <9d49c901-fcdf-487a-a733-0320d0bdf94c@amd.com>
 <DJ3V3OCLIK2K.3CYKWYNHYU6JQ@kernel.org>
 <ea4e0541-3702-4014-b8f6-0746a148df86@amd.com>
 <DJ3VYD71HDQ2.3C8GG983Z2YCM@kernel.org>
 <c8564ea0-8ff4-4049-996d-bd978c478372@amd.com>
 <74bd33a06b75c291c3e2eda19e0250fbd280c49b.camel@mailbox.org>
 <66349a9f-d9dd-498b-b118-1c79d3aa3cca@amd.com>
 <11d7c83185a18d13760b6e77275e97c110dcddcc.camel@mailbox.org>
 <1bb5efeb-a5d3-4d0b-ae69-8dc8620604d4@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: f42b8e1ecef5c7e0890
X-MBO-RS-META: ef3tzkx4ydxh7gmaugqom6nkt6ostb57
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

On Tue, 2026-06-09 at 12:53 +0200, Christian K=C3=B6nig wrote:
> >=20
> > // driver
> > dma_fence_signal(f); // revokes all accesses to our driver through back=
end_ops
> > // synchronize_rcu() now unnecessary \o/
> > cleanup(f); // We know that all accessors are gone
> > dma_fence_put(f);
>=20
> Yeah and exactly that doesn't work.
>=20
> Just think about the Nouveau case when you have your fences on a double l=
inked list.
>=20
> When the fence lock is independent, e.g. have a separate lock for each fe=
nce then this lock can't protect this double linked list.
>=20
> So your cleanup path needs to take a lock which protects the list, but yo=
u then run into lock inversion.


static bool nouveau_fence_is_signaled(struct dma_fence *f)
{
	struct nouveau_fence *fence =3D to_nouveau_fence(f);
	struct nouveau_fence_chan *fctx =3D nouveau_fctx(fence);
	struct nouveau_channel *chan;
	bool ret =3D false;

	rcu_read_lock();
	chan =3D rcu_dereference(fence->channel);
	if (chan)
		ret =3D (int)(fctx->read(chan) - fence->base.seqno) >=3D
0;
	rcu_read_unlock();

	return ret;
}


AFAICT fctx->read() does not take f->lock. So where is the lock
inversion?


Again, ideally we can get to the point where no one except for the
fence subsystem itself has to take the lock manually anymore.

>=20
> > >=20
> > > So you are left with few options: Either the fence lock is external,
> > > which we don't want because that make the fence non-independent, or
> > > cleanup() defers work to irq_work or work_structs, which creates
> > > numerous lifetime issues.
> >=20
> > Yup, this is uncool and we want to avoid that.
> >=20
> > But these seem to be the options
> >=20
> > 1. Ensure proper synchronization
> > 2. Wait for a grace period in a hot path
> > 3. Defer cleanup() with some delay mechanism
> >=20
> > #1 is by far the cleanest approach. I still cannot see any downside,
> > and quite a few upsides.
> >=20
> > https://elixir.bootlin.com/linux/v7.1-rc6/source/drivers/dma-buf/dma-fe=
nce.c#L1025
> >=20
> > ^ is already racing with the signaled check.
>=20
> Yeah so what? That is just an opportunistic check.=20

What happens if someone signals the fence while the set_deadline()
callback is running?



P.
