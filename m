Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C98CD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 13:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2E5A10E43A;
	Mon, 18 May 2026 13:00:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yS6J3KR6";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8662B10E43A
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 13:00:36 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gJyb54CT5z9vWk;
 Mon, 18 May 2026 15:00:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1779109233; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=42UjWw8qdkmaeRynzwAOvzZibvc3MMo7iwMmUNfLtAs=;
 b=yS6J3KR6RuMyJdK3Mc1TqUwbuIR2xoaAKONvBNyG4S1+pIXHzY3CD5lQia44N1gzfZQuyy
 OL/KOsmiOnb3iXtCuRd985WSmaY6YseIomOWESsWRwjnp8J/MGH6jzTYA4yVsm1Lc5egEc
 7nkU7g2kpKPWkkSwpv0NyemZHWWJDGgkv2w2yztKkL1tBTWsx9DNs2BqSyERmvAW0o5jAc
 EmobO6DhgzD9KQjapN8PW1Xsx2o5OkWeEVDrb1FYc4YHpmSw77ZMrUHvwXhq9m4SJ3kLRF
 hPTy01WcpJXz76CCeac4gOe2PVAGvT1U1R9qNrzy25Fb3x6PP/Kz/Y7bph3Ycw==
Message-ID: <64a784311f048a0fe4bbf8a89839522cd1e6144e.camel@mailbox.org>
Subject: Re: [PATCH v2] dma-fence: Clarify external lock use case in
 dma_fence_init() docs
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, Boris Brezillon <boris.brezillon@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,  Philipp Stanner
 <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 kernel-dev@igalia.com
Date: Mon, 18 May 2026 15:00:24 +0200
In-Reply-To: <b202b9f4-9ef6-422a-be39-8050217590ad@amd.com>
References: <20260419134943.54833-2-mcanal@igalia.com>
 <b202b9f4-9ef6-422a-be39-8050217590ad@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 5edb5a488875ca8cd85
X-MBO-RS-META: b9yb8x5mrbg9iepo8jkqeqntbemb3mko
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

On Mon, 2026-05-18 at 13:30 +0200, Christian K=C3=B6nig wrote:
> On 4/19/26 15:48, Ma=C3=ADra Canal wrote:
> > The kerneldoc comment on dma_fence_init() and dma_fence_init64() descri=
be
> > the legacy reason to pass an external lock as a need to prevent multipl=
e
> > fences "from signaling out of order". However, this wording is a bit
> > misleading: a shared spinlock does not (and cannot) prevent the signale=
r
> > from signaling out of order. Signaling order is the driver's responsibi=
lity
> > regardless of whether the lock is shared or per-fence.
> >=20
> > What a shared lock actually provides is serialization of signaling and
> > observation across fences in a given context, so that observers never
> > see a later fence signaled while an earlier one is not.
> >=20
> > Reword both comments to describe this more accurately.
> >=20
> > Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> >=20
> > ---
> >=20
> > v1 -> v2: https://lore.kernel.org/dri-devel/20260411185756.1887119-4-mc=
anal@igalia.com/
> >=20
> > - Be more explicit about not allowing new users to use an external lock=
.
> > - De-duplicate the explanation in dma_fence_init64() by pointing to the
> > =C2=A0 dma_fence_init() documentation.
> > ---
> > =C2=A0drivers/dma-buf/dma-fence.c | 13 +++++++------
> > =C2=A01 file changed, 7 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> > index 1c1eaecaf1b0..63b349ba9a34 100644
> > --- a/drivers/dma-buf/dma-fence.c
> > +++ b/drivers/dma-buf/dma-fence.c
> > @@ -1102,9 +1102,11 @@ __dma_fence_init(struct dma_fence *fence, const =
struct dma_fence_ops *ops,
> > =C2=A0 * context and seqno are used for easy comparison between fences,=
 allowing
> > =C2=A0 * to check which fence is later by simply using dma_fence_later(=
).
> > =C2=A0 *
> > - * It is strongly discouraged to provide an external lock because this=
 couples
> > - * lock and fence life time. This is only allowed for legacy use cases=
 when
> > - * multiple fences need to be prevented from signaling out of order.
> > + * External locks are a relic from legacy use cases that needed a shar=
ed lock
> > + * to serialize signaling and observation of fences within a context, =
so that
> > + * observers never see a later fence signaled while an earlier one isn=
't. New
> > + * users MUST NOT use external locks, as they force the issuer to outl=
ive all
> > + * fences that reference the lock.
>=20
> No that's not correct. The use of the external lock was indeed to prevent=
 signaling out of order.
>=20
> It is perfectly possible to observe the fence as signaled even without ta=
king the lock because of the unlocked test_bit() operation we use, so the n=
ew wording is clearly misleading and not explaining properly what is going =
on here.
>=20

I think the point Ma=C3=ADra / we tried to make with that statement is that
an external lock is effectively useless for ensuring correct signaling
order. Afair you agree with that in general.

Do you have a suggestion for a better formulation?

Regards
P.

> Regards,
> Christian.
>=20
>=20
> > =C2=A0 */
> > =C2=A0void
> > =C2=A0dma_fence_init(struct dma_fence *fence, const struct dma_fence_op=
s *ops,
> > @@ -1129,9 +1131,8 @@ EXPORT_SYMBOL(dma_fence_init);
> > =C2=A0 * Context and seqno are used for easy comparison between fences,=
 allowing
> > =C2=A0 * to check which fence is later by simply using dma_fence_later(=
).
> > =C2=A0 *
> > - * It is strongly discouraged to provide an external lock because this=
 couples
> > - * lock and fence life time. This is only allowed for legacy use cases=
 when
> > - * multiple fences need to be prevented from signaling out of order.
> > + * New users MUST NOT use external locks. Check the documentation in
> > + * dma_fence_init() to understand the motives behind the legacy use ca=
ses.
> > =C2=A0 */
> > =C2=A0void
> > =C2=A0dma_fence_init64(struct dma_fence *fence, const struct dma_fence_=
ops *ops,
>=20

