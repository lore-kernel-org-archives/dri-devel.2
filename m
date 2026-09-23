Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B67DC98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E59910E85A;
	Wed, 23 Sep 2026 15:27:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="eoqXCRsb";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7863D10E85A
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:27:12 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hqgn84GcfzKnDg;
 Wed, 23 Sep 2026 17:27:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1790177228; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tyKF4/6NTMMn3I867npjUmJjWdb1bsW7lxCFL1zlTZQ=;
 b=eoqXCRsbGPuSwKbg1nn6FsdVWY2BADm4ICEKPIwfNJ98Uxxe+rbPI1HKOdPx3HhuZbGUgN
 Kt8FEmpjaN+HlrfHq7BrJf9fnvW46pJliV5Hgxb0bQPYLUlI2WHmi1jm+Da8jk6/d/Fb/D
 wucOisDRVaiH85yRzzlObjP4MHfRq31II46j549XD5yop9NtK0ai15t1ay/ERczNE/1kz4
 2e1LYBldjKC9eE3TblwREY/IM/Nbv6PQd/1an0VhoFk0M1wPrxefeidEruO8f92vpMK69w
 KCDPFVh07QoQ9oXQVN1vEfjOUS4vvS6JsWmfm5JX2BnUxowUgRwn9cXX/iMQZg==
Message-ID: <469d5deb2ef644b5d77d21bc2d700443f00c0b4d.camel@mailbox.org>
Subject: Re: [PATCH] dma-buf/dma-fence: Mark two callbacks as deprecated
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Philipp
 Stanner <phasta@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 17:27:06 +0200
In-Reply-To: <3983b2de-b6ee-4674-be22-9ecb2525a055@amd.com>
References: <20260923150308.1294592-2-phasta@kernel.org>
 <3983b2de-b6ee-4674-be22-9ecb2525a055@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 1f309f0964af6ffe465
X-MBO-RS-META: rchzwudec8q3dxj84cuk1no43fcd1hxp
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

On Wed, 2026-09-23 at 17:13 +0200, Christian K=C3=B6nig wrote:
> On 9/23/26 17:03, Philipp Stanner wrote:
> >=20

[=E2=80=A6]

>=20
> > 	Consumers of a fence can instead notify themselves by
> > +	 * registering a callback on the fence.
>=20
> Mhm, the wait callback is transparent to consumers it's just that impleme=
ntations used it for quite a number of different hacks.

Right=E2=80=A6

but doesn't the question then become why dma_fence_wait_timeout() even
exists? IOW, shall we deprecate it, too?

It seems to be a reimplementation of waitqueues. The driver could get
this functionality by using a waitqueue whose event gets triggered by a
fence callback.

dma_fence_default_wait() interacts directly with the task state with
__XX_task() functions which looks very.. deep to me :)

>=20
> I would just drop that sentence.
>=20
> > =C2=A0	 */
> > =C2=A0	signed long (*wait)(struct dma_fence *fence,
> > =C2=A0			=C2=A0=C2=A0=C2=A0 bool intr, signed long timeout);
> > @@ -243,6 +249,8 @@ struct dma_fence_ops {
> > =C2=A0	/**
> > =C2=A0	 * @release:
> > =C2=A0	 *
> > +	 * DEPRECATED!
> > +	 *
> > =C2=A0	 * Called on destruction of fence to release additional resource=
s.
> > =C2=A0	 * Can be called from irq context.=C2=A0 This callback is option=
al. If it is
> > =C2=A0	 * NULL, then dma_fence_free() is instead called as the default
> > @@ -254,6 +262,12 @@ struct dma_fence_ops {
> > =C2=A0	 *
> > =C2=A0	 * If the callback is implemented the memory backing the dma_fen=
ce
> > =C2=A0	 * object must be freed RCU safe.
> > +	 *
> > +	 * Deprecated because it prevents the producer of a fence from
> > +	 * unloading. No new users must be implemented. Parties with a
> > +	 * hypothetical need for this callback can instead simply and directl=
y
> > +	 * perform their custom release operations one RCU grace period after
> > +	 * they have signaled the fence.
>=20
> Yeah that is a bit problematic.
>=20
> We need my patch set to explicit signal fences instead of returning true/=
false from callback for that so that a backend can properly implement this.

Well, what I'm trying to say in this docu is that the driver can kick
off custom operations that shall be performed once everyone is "done"
with the fence after signaling it. Any driver data that might still be
around cannot be accessed by fence consumers after signaling anymore.
So the driver could trigger cleanup work after a graceperiod, as long
as it does not involve kfree()-ing the fence itself.


P.
