Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFE7C98310
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 08:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB18910F344;
	Thu, 24 Sep 2026 08:14:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PcSLgM2q";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0C0510F344
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 08:14:15 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hr6785yczzKn70;
 Thu, 24 Sep 2026 10:14:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1790237652; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nLIdHlINPPTk97LeeSu2Ngy2+Bo9bivsTeUqxRvwGyQ=;
 b=PcSLgM2qOACk8/OzB7Ptmfse/AyrMzxlp+/2PAjEifdb4t/9K7gYorqcdevMw23M13D+we
 sqGyt2l3ml5DEHuVrm/i4PxA/C5ffHl2q5xDJsMGo8UvbG3pv2Ai6dlp84XL2Qq098Brmq
 2llMQ1UAskR7Xga6rdK+es6VaMfP0pb0IRtiSookkt7nf81957CzI25rH/moH8mAmjKD25
 QwMZUXwCSA7egdPsBjmAN0Kl8UHk9QlktgnKr/BqYWbzQJbpK3C1Ctd7+ZgWHgbGYupN6S
 qGxL6YPzc1SILBJhrQPkNNv967l4YRabS/lnFl3ohnfJYTLb/bC1oVOjuNV1Lg==
Message-ID: <a4655e4ab7a2477b75351a0e83b98e0cb0396fdb.camel@mailbox.org>
Subject: Re: [PATCH] dma-buf/dma-fence: Mark two callbacks as deprecated
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 phasta@kernel.org, Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 10:14:10 +0200
In-Reply-To: <c400f12a-04db-45eb-853b-629f19e3060e@amd.com>
References: <20260923150308.1294592-2-phasta@kernel.org>
 <3983b2de-b6ee-4674-be22-9ecb2525a055@amd.com>
 <469d5deb2ef644b5d77d21bc2d700443f00c0b4d.camel@mailbox.org>
 <c400f12a-04db-45eb-853b-629f19e3060e@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: 14u3rqh58rttqsbg5a1nqgx9nck8zahs
X-MBO-RS-ID: 89c24c99eb9869622cf
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

On Wed, 2026-09-23 at 17:35 +0200, Christian K=C3=B6nig wrote:
> On 9/23/26 17:27, Philipp Stanner wrote:
> > On Wed, 2026-09-23 at 17:13 +0200, Christian K=C3=B6nig wrote:
> > > On 9/23/26 17:03, Philipp Stanner wrote:
> > > >=20
> >=20
> > [=E2=80=A6]
> >=20
> > >=20
> > > > 	Consumers of a fence can instead notify themselves by
> > > > +	 * registering a callback on the fence.
> > >=20
> > > Mhm, the wait callback is transparent to consumers it's just that
> > > implementations used it for quite a number of different hacks.
> >=20
> > Right=E2=80=A6
> >=20
> > but doesn't the question then become why dma_fence_wait_timeout() even
> > exists? IOW, shall we deprecate it, too?
>=20
> Yes, without the wait callback it is only a wrapper to block the
> current thread for a dma_fence to signal using a callback.

I agree that it's probably quite a common use-case. I'm not sure
whether it's possible to write a convenient wrapper, though, since you
need to carry a waitqueue around.

Maybe we can put a task for it onto the DRM TODO list?

>=20
> It's still quite useful to have a common function for that I think.
>=20
> > It seems to be a reimplementation of waitqueues. The driver could get
> > this functionality by using a waitqueue whose event gets triggered by a
> > fence callback.
> >=20
> > dma_fence_default_wait() interacts directly with the task state with
> > __XX_task() functions which looks very.. deep to me :)
>=20
> That is *exactly* what I pointed out as well >10 years ago before that st=
uff was merged upstream :)
>=20
> A wait_event based implementation would be tons of cleaner if you ask me.

So you objected and it was merged anyways? With any rationale?

I think I understand now why sometimes people apply a Nacked-by, so
that it's documented that people objected against merging.

[=E2=80=A6]

> >=20
> >=20
> > Well, what I'm trying to say in this docu is that the driver can kick
> > off custom operations that shall be performed once everyone is "done"
> > with the fence after signaling it. Any driver data that might still be
> > around cannot be accessed by fence consumers after signaling anymore.
> > So the driver could trigger cleanup work after a graceperiod, as long
> > as it does not involve kfree()-ing the fence itself.
>=20
> That sounds sane to me, but I'm not sure how to phrase it cleaner either.
>=20
> For now I'm ok with it, maybe somebody else has a better idea to how writ=
e this.

I try to come up with something slightly better.


P.
