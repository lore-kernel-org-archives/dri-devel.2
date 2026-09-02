Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB1EC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 07:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC61210E550;
	Wed,  2 Sep 2026 07:03:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="I1TmHNhN";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ACA910E463
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 07:03:25 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hZYbZ1JYRzKmyK;
 Wed, 02 Sep 2026 09:03:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1788332602; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7rI/p79b7O2//eMDN0rxElqzgtP2sOjN4H2XmtveNS8=;
 b=I1TmHNhNakR3dC1z1M1I7dbopMKbhpunfqxty3mRWpMhtBlNJTUmbIjynHTe9Kv+OBbaCE
 RdOwrJLJ79LW9W1dd5BZYQ3o4zOvSp6NWGQpjgzH378CaHAqAqjXTC5l6xuK1lOsdaS8wS
 XSP4+ZmtB/gUmgtwhB9lwpJSIO80t2Wm/pvFzlmfCwXvsxFOOsRuK1DzGSKJkhfmvykl2d
 09pXWZDUiVJeRWsI6qPFyK3ZdWaWWB7lhPw8WiBd7zyq108Jc4XC19b4ac3RmwZuOcVTAY
 Q/ZMU+Cy6aMQilYNy8bE+Bd6XJ34LzkmTdq66dok8tRvR4ntLgX9Dg9fuxa5xQ==
Message-ID: <307d764629d7c5d2704b7897c8c0c32c1ef4ce33.camel@mailbox.org>
Subject: Re: [PATCH 1/9] dma-buf: add dma_fence_was_initialized function v2
From: Philipp Stanner <phasta@mailbox.org>
To: Jiri Slaby <jirislaby@kernel.org>, phasta@kernel.org, Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 tursulin@ursulin.net, matthew.brost@intel.com, sumit.semwal@linaro.org
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Date: Wed, 02 Sep 2026 09:03:19 +0200
In-Reply-To: <5be2d5f9-579f-4c5c-8463-a2505a6f0c74@kernel.org>
References: <20260120105655.7134-1-christian.koenig@amd.com>
 <20260120105655.7134-2-christian.koenig@amd.com>
 <0d40243b-0929-46d2-be85-e3248d4bd09c@kernel.org>
 <aee97ce4aad6bcf63ce9e7066e20a4ff6f082669.camel@mailbox.org>
 <9edeaa17aebc284f1f171b1dd4d9ffee4721b750.camel@mailbox.org>
 <4b5b6dda-43a4-4488-9dbd-b0f92fcead61@kernel.org>
 <0b84716fa6bec4e38d811dc76926dd81e31e0c81.camel@mailbox.org>
 <5dd4248bccb446ef390e7149649632657db4aaae.camel@mailbox.org>
 <0df59c80-ae58-47d3-a96b-e878a17766a7@kernel.org>
 <f8b941a8-a468-4243-836e-aa6cebf6f3b3@kernel.org>
 <f923a6f6-8fef-43c8-8ac6-82c070e9b7b8@kernel.org>
 <ddab642c497354d2800e6139f7b0c073fd3981f1.camel@mailbox.org>
 <5be2d5f9-579f-4c5c-8463-a2505a6f0c74@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: wetpf18ibz7gheo8zq3rp8yxtud11hw4
X-MBO-RS-ID: a405899faa8e67a3f2a
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

On Wed, 2026-09-02 at 08:56 +0200, Jiri Slaby wrote:
> On 02. 09. 26, 8:52, Philipp Stanner wrote:
> > On Fri, 2026-08-28 at 10:32 +0200, Jiri Slaby wrote:
> > > On 28. 08. 26, 9:46, Jiri Slaby wrote:
> > > > What helps is indeed the revert back to:
> > > >=20
> > > > --- a/drivers/gpu/drm/qxl/qxl_release.c
> > > > +++ b/drivers/gpu/drm/qxl/qxl_release.c
> > > > @@ -147,7 +147,7 @@ qxl_release_free(struct qxl_device *qdev,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idr_remove(&=
qdev->release_idr, release->id);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(=
&qdev->release_idr_lock);
> > > >=20
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dma_fence_was_initialized=
(&release->base)) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (release->base.ops) {
> > >=20
> > > Crap, the flags simple got garbage from previous freed buffer, so:
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 release =3D kmalloc(size, GFP_K=
ERNEL);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 release =3D kzalloc(size, GFP_K=
ERNEL);
> > >=20
> > > fixes this of course. Patch coming.
> > >=20
> > > Now, the ops and initialized are either both set or unset:
> > > qxl_release_free 1: release->base.ops=3D0x0 initialized=3D0 id=3D6 ty=
pe=3D2
> > > qxl_release_free 1: release->base.ops=3Dqxl_fence_ops initialized=3D1=
 id=3D2
> > > type=3D0
> > >=20
> > > Unlike before.
> > >=20
> > > FTR release->base.ops were NULLed after that kmalloc. Unlike
> > > release->base.flags.
> >=20
> > You're saying that QXL is re-using that fence if it were uninitialized?
>=20
> Sort of. The fence was dropped and freed. Then a new memory was=20
> allocated. And garbage from that allocation was used -- it might be the=
=20
> old (freed) fence. Or anything else freed previously. Simply garbage.


Maybe even dma_fence_init() should zero out the memory for maximum
robustness.

We do that in drm_sched at a few places.

Opinions? @Christian?


P.
