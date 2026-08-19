Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C95C5DF88
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23E9F10E154;
	Wed, 19 Aug 2026 12:34:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qm1MkqPI";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD13510E154
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 12:34:00 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hQ5bV0wfyzMlGw;
 Wed, 19 Aug 2026 14:33:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1787142838; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M17Dqvfqmh/nogr2qpwaZJICEioI5Qe0e56cjpQY++Y=;
 b=qm1MkqPIhrTll8WwuGOyl6+D6UiiA1zI9HXoJ7KLsg3M9Zfq+eMyT9LGK+uW6XiOczDekZ
 BFvR1TbxerVC7HCKPMo7CsaSCP8QwvhDgeSYJgkEQowPw50oJNgsnpfb+tloRpBuCboLyo
 E/2joY9PKQwDQN5zTQNs4ee3hgKbtpgN6ZawbFKnIN4F4mMF8Q4KcSlS0G9PAnwjJ7u0pY
 XjowgDdYDEewMF2CdvY4LRJ+1scIZmMabj2s0MGsICvNaAhrpqLCRbG5viPz6KZa9Et3on
 74dILgKaHEJK0uVpqT1ITlX+BftzJWaHNtpHNMj699AuvB1KAmoF9/xaQF3flw==
Message-ID: <0b84716fa6bec4e38d811dc76926dd81e31e0c81.camel@mailbox.org>
Subject: Re: [PATCH 1/9] dma-buf: add dma_fence_was_initialized function v2
From: Philipp Stanner <phasta@mailbox.org>
To: Jiri Slaby <jirislaby@kernel.org>, phasta@kernel.org, Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 tursulin@ursulin.net, matthew.brost@intel.com, sumit.semwal@linaro.org
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Date: Wed, 19 Aug 2026 14:33:54 +0200
In-Reply-To: <4b5b6dda-43a4-4488-9dbd-b0f92fcead61@kernel.org>
References: <20260120105655.7134-1-christian.koenig@amd.com>
 <20260120105655.7134-2-christian.koenig@amd.com>
 <0d40243b-0929-46d2-be85-e3248d4bd09c@kernel.org>
 <aee97ce4aad6bcf63ce9e7066e20a4ff6f082669.camel@mailbox.org>
 <9edeaa17aebc284f1f171b1dd4d9ffee4721b750.camel@mailbox.org>
 <4b5b6dda-43a4-4488-9dbd-b0f92fcead61@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: d7628e671ec36426afb
X-MBO-RS-META: re5f35bh5uubqi13qbhhhr3gm3u9brxa
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

On Wed, 2026-08-19 at 10:59 +0200, Jiri Slaby wrote:
> On 14. 07. 26, 10:43, Philipp Stanner wrote:
> > On Tue, 2026-07-14 at 09:53 +0200, Philipp Stanner wrote:
> > > On Mon, 2026-07-13 at 10:58 +0200, Jiri Slaby wrote:
> > > > Hi,
> > > >=20
> > > > On 20. 01. 26, 11:54, Christian K=C3=B6nig wrote:
> > > > > Some driver use fence->ops to test if a fence was initialized or =
not.
> > > > > The problem is that this utilizes internal behavior of the dma_fe=
nce
> > > > > implementation.
> > > > >=20
> > > > > So better abstract that into a function.
> > > > >=20
> > > > > v2: use a flag instead of testing fence->ops, rename the function=
, move
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to the beginning of the patch set.
> > > > ...
> > > > > --- a/drivers/gpu/drm/qxl/qxl_release.c
> > > > > +++ b/drivers/gpu/drm/qxl/qxl_release.c
> > > > > @@ -146,7 +146,7 @@ qxl_release_free(struct qxl_device *qdev,
> > > > > =C2=A0=C2=A0=C2=A0	idr_remove(&qdev->release_idr, release->id);
> > > > > =C2=A0=C2=A0=C2=A0	spin_unlock(&qdev->release_idr_lock);
> > > > > =C2=A0=C2=A0=20
> > > > > -	if (release->base.ops) {
> > > > > +	if (dma_fence_was_initialized(&release->base)) {
> > >=20
> > > Could you verify the cause with sth like
> > >=20
> > > if (release->base.ops && dma_fence_was_initialized(=E2=80=A6)) {
> >=20
> > Forget about that, probably would not work or cause other issues
> > because the NULL-setting on signal().
> >=20
> > I'd then probably try to verify it with a separate boolean in struct
> > release. Though I also don't get why the fence-initialized check does
> > not do the trick.
>=20
> Hi, have you come up with something yet?

Well, I was more like suggesting this as a debug option [to you] :D


Regardless, looking at the code again, I would say that this might be a
race, but I don't know enough about QXL to say for sure.

dma_fence_init() is (of course) not ordered:


static void
__dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
	         spinlock_t *lock, u64 context, u64 seqno, unsigned long flags)
{
	BUG_ON(!ops || !ops->get_driver_name || !ops->get_timeline_name);

	kref_init(&fence->refcount);
	/*
	 * While it is counter intuitive to protect a constant function pointer
	 * table by RCU it allows modules to wait for an RCU grace period
	 * before they unload, to make sure that nobody is executing their
	 * functions any more.
	 */
	RCU_INIT_POINTER(fence->ops, ops);
	INIT_LIST_HEAD(&fence->cb_list);
	fence->context =3D context;
	fence->seqno =3D seqno;
	fence->flags =3D flags | BIT(DMA_FENCE_FLAG_INITIALIZED_BIT);

(Should this maybe be set_bit() btw?)


The fact that QXL could run into qxl_release_free() with an
uninitialized fence hints at the fact that this might race, so
DMA_FENCE_FLAG_INITIALIZED_BIT could be set / read before kref_init()
ran.


Maybe one way to verify / debug that would be to move
spin_unlock(&qdev->release_idr_lock) downwards so it also guards
dma_fence_was_initialized(), and also lock the initialization of the
fence (in qxl_release_fence_buffer_objects() ?) with said lock.

If that's possible. Just brainstorming a bit for ways how to debug.

QXL does a few tricky things with the release->base.ops pointer.
qxl_release_alloc() sets it to NULL, and only
qxl_release_fence_buffer_objects() then actually sets it. So this could
be the race? Setting of the ops pointer got replaced by setting of the
fence-flag.


P.
