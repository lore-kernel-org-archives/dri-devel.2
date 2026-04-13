Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1034F34C5C
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:18:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B627892A6;
	Mon, 13 Apr 2026 15:18:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ET1cPrgC";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2E4C892A6
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 15:18:57 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fvWJt612kz9sFB;
 Mon, 13 Apr 2026 17:18:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1776093534; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3PxxStrZgBn5ynxD2Aasdb66LvhdbOOKogmOPA4Swtw=;
 b=ET1cPrgCejm8kbB9JjLUf4F9lEGrmlZ7Ki73VXw1EReWS0xZjxIaH6Pl2kKxh/k0Ff/irt
 HSgbg5CRPqfS24CzscNiGJm3Lgq6LNpjImiGKouGO84sDtXpw4ciUo4fJIRnTYE4c092bX
 ahkKsR4vEcq5gQ0dKpwFJHYn6taeG/WjQ9ANCagtPYyhNC8AENyPvlbpn0D2Kwpsh6e6Ts
 NeClMJEKcaF68zWIP+MxBdgDxqiD3K2UkvMCeRkQfnLtK/BuvNLFBZYKcwClLtClps8GM9
 TbParxnU8btGaK2qnjLGbmnAXL4XoXjtFQ32EmJVo147psPj2VnZxvI19qa00g==
Message-ID: <e0d1ac4e4fc69696e42f00dad4a2bbf8a4076c7b.camel@mailbox.org>
Subject: Re: [PATCH] dma-fence: Clarify external lock use case in
 dma_fence_init() docs
From: Philipp Stanner <phasta@mailbox.org>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, phasta@kernel.org, 
 Christian =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,  Boris Brezillon
 <boris.brezillon@collabora.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 kernel-dev@igalia.com
Date: Mon, 13 Apr 2026 17:18:51 +0200
In-Reply-To: <a873a7ba-7309-4c80-86c1-2f009365266b@igalia.com>
References: <20260411185756.1887119-4-mcanal@igalia.com>
 <59759507d4fb89d3726092268f17680998d1b4cf.camel@mailbox.org>
 <a873a7ba-7309-4c80-86c1-2f009365266b@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 99ea47477b8a6797b98
X-MBO-RS-META: cem96uj5pydkontd8qjn5c1tfzmwqf6q
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

On Mon, 2026-04-13 at 09:00 -0300, Ma=C3=ADra Canal wrote:
> Hi Philipp,
>=20
> On 4/13/26 03:47, Philipp Stanner wrote:
> > On Sat, 2026-04-11 at 15:47 -0300, Ma=C3=ADra Canal wrote:
> > > The kerneldoc comment on dma_fence_init() and dma_fence_init64() desc=
ribe
> > > the legacy reason to pass an external lock as a need to prevent multi=
ple
> > > fences "from signaling out of order". However, this wording is a bit
> > > misleading: a shared spinlock does not (and cannot) prevent the signa=
ler
> > > from signaling out of order. Signaling order is the driver's responsi=
bility
> > > regardless of whether the lock is shared or per-fence.
> > >=20
> > > What a shared lock actually provides is serialization of signaling an=
d
> > > observation across fences in a given context, so that observers never
> > > see a later fence signaled while an earlier one is not.
> > >=20
> > > Reword both comments to describe this more accurately.
> > >=20
> > > Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> > > ---
> > >=20
> > > Hi,
> > >=20
> > > While reading the documentation, I found this particular paragraph qu=
ite
> > > hard to understand. As I understand it, locks don't enforce order, on=
ly
> > > serialization, but the paragraph seems to communicate the other way a=
round.
> >=20
> > Yes, 100%.
> > That's one of the reasons why Christian recently moved to using inline-
> > locks.
> >=20
> >=20
> >=20
> > > Due to that, I had the impression that the current wording can be
> > > misleading for driver developers.
> > >=20
> > > I'm proposing a new wording to better describe the use case of the
> > > external lock based on my understanding, but it would be great to hea=
r
> > > the feedback and suggestions from more experienced developers who mig=
ht
> > > have more insight about these legacy use cases.
> > >=20
> > > Best regards,
> > > - Ma=C3=ADra
> > >=20
> > > =C2=A0=C2=A0drivers/dma-buf/dma-fence.c | 12 ++++++++----
> > > =C2=A0=C2=A01 file changed, 8 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.=
c
> > > index 1826ba73094c..bdc29d1c1b5c 100644
> > > --- a/drivers/dma-buf/dma-fence.c
> > > +++ b/drivers/dma-buf/dma-fence.c
> > > @@ -1102,8 +1102,10 @@ __dma_fence_init(struct dma_fence *fence, cons=
t struct dma_fence_ops *ops,
> > > =C2=A0=C2=A0 * to check which fence is later by simply using dma_fenc=
e_later().
> > > =C2=A0=C2=A0 *
> > > =C2=A0=C2=A0 * It is strongly discouraged to provide an external lock=
 because this couples
> > > - * lock and fence life time. This is only allowed for legacy use cas=
es when
> > > - * multiple fences need to be prevented from signaling out of order.
> > > + * lock and fence lifetime. This is only allowed for legacy use case=
s that need
> > > + * a shared lock to serialize signaling and observation of fences wi=
thin a
> > > + * context, so that observers never see a later fence signaled while=
 an earlier
> > > + * one isn't.
> >=20
> > I would probably delete the explanation altogether and just state
> > "allowed for legacy reasons". The legacy people know why it's allowed,
> > and new users don't need to care. Same below of course.
>=20
> Actually, I ended up in this part of the documentation as I'm thinking
> about dropping the external lock in v3d driver. I was reading the docs
> exactly to know if v3d is a legacy use case (spoiler: it isn't) and I
> got confused by the current wording. So, I think there is value in
> documenting the legacy use cases for the external lock.
>=20
> Maybe, instead of "strongly discouraged", we could add a disclaimer
> like: "New drivers MUST NOT use an external lock because...". What do
> you think?

Hmm. Yeah, I mean you are right that what the lock was supposed to be
good for was never really applicable anyways.

Thinking about it, I would probably state:

"External locks are a relic from a past design mistake. New users must
not use external locks since they do not provide value and prevent
fences' life time to be completely decoupled from their issuer's."

Sth like that sounds to the point to me.


P.


>=20
> Best regards,
> - Ma=C3=ADra
>=20
> >=20
> >=20
> > Thx
> > P.
> >=20
> > > =C2=A0=C2=A0 */
> > > =C2=A0=C2=A0void
> > > =C2=A0=C2=A0dma_fence_init(struct dma_fence *fence, const struct dma_=
fence_ops *ops,
> > > @@ -1129,8 +1131,10 @@ EXPORT_SYMBOL(dma_fence_init);
> > > =C2=A0=C2=A0 * to check which fence is later by simply using dma_fenc=
e_later().
> > > =C2=A0=C2=A0 *
> > > =C2=A0=C2=A0 * It is strongly discouraged to provide an external lock=
 because this couples
> > > - * lock and fence life time. This is only allowed for legacy use cas=
es when
> > > - * multiple fences need to be prevented from signaling out of order.
> > > + * lock and fence lifetime. This is only allowed for legacy use case=
s that need
> > > + * a shared lock to serialize signaling and observation of fences wi=
thin a
> > > + * context, so that observers never see a later fence signaled while=
 an earlier
> > > + * one isn't.
> > > =C2=A0=C2=A0 */
> > > =C2=A0=C2=A0void
> > > =C2=A0=C2=A0dma_fence_init64(struct dma_fence *fence, const struct dm=
a_fence_ops *ops,
> >=20
>=20

