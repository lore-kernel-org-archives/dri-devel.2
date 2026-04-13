Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CACAEBFD03
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 06:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DDEB10E322;
	Mon, 13 Apr 2026 06:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZaJyTE89";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D0E10E322
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 06:47:28 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fvHyk06vQz9vBF;
 Mon, 13 Apr 2026 08:47:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1776062846; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNqg4//AHBbNZ3RoiPIAfyIUx1byLwQcXw94D/twNTo=;
 b=ZaJyTE89qf1juduquhuXt8/2tzZl7dQFn955XFVGTmoWi7PO7hgkBFKpCqVFDja6D8wnPC
 gc40dRFBbXcUHlfkHTf6HWA32/ZnN8BP5i5mEFp8NQUXHUuzrTr6JTxf2NwXj9bPiHRinm
 504FlZytfIvlkkVnoQnhws9TmRuG2l1uNlDX2ILNcvuRVb16/M/t6VLJmlIPIOOilmxFgj
 W6KQgn4bGFjCrEavWXmbV510WhuuaViIZTQoKFStWuxP/0uaPGUGIXbXik0ltMAvp2S7HK
 E8V+6gQJYHsDIbLlgDYBYHOUjAzeQcHRNdW4gZ+tzqvdx6VeCJjeElMcEfnfqw==
Message-ID: <59759507d4fb89d3726092268f17680998d1b4cf.camel@mailbox.org>
Subject: Re: [PATCH] dma-fence: Clarify external lock use case in
 dma_fence_init() docs
From: Philipp Stanner <phasta@mailbox.org>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, Boris Brezillon <boris.brezillon@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,  Philipp Stanner
 <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 kernel-dev@igalia.com
Date: Mon, 13 Apr 2026 08:47:21 +0200
In-Reply-To: <20260411185756.1887119-4-mcanal@igalia.com>
References: <20260411185756.1887119-4-mcanal@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: f9275734e115b506393
X-MBO-RS-META: t9zjn3p3af6q66cu93yoz5wctseyf7ch
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

On Sat, 2026-04-11 at 15:47 -0300, Ma=C3=ADra Canal wrote:
> The kerneldoc comment on dma_fence_init() and dma_fence_init64() describe
> the legacy reason to pass an external lock as a need to prevent multiple
> fences "from signaling out of order". However, this wording is a bit
> misleading: a shared spinlock does not (and cannot) prevent the signaler
> from signaling out of order. Signaling order is the driver's responsibili=
ty
> regardless of whether the lock is shared or per-fence.
>=20
> What a shared lock actually provides is serialization of signaling and
> observation across fences in a given context, so that observers never
> see a later fence signaled while an earlier one is not.
>=20
> Reword both comments to describe this more accurately.
>=20
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
>=20
> Hi,
>=20
> While reading the documentation, I found this particular paragraph quite
> hard to understand. As I understand it, locks don't enforce order, only
> serialization, but the paragraph seems to communicate the other way aroun=
d.

Yes, 100%.
That's one of the reasons why Christian recently moved to using inline-
locks.



> Due to that, I had the impression that the current wording can be
> misleading for driver developers.
>=20
> I'm proposing a new wording to better describe the use case of the
> external lock based on my understanding, but it would be great to hear
> the feedback and suggestions from more experienced developers who might
> have more insight about these legacy use cases.
>=20
> Best regards,
> - Ma=C3=ADra
>=20
> =C2=A0drivers/dma-buf/dma-fence.c | 12 ++++++++----
> =C2=A01 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index 1826ba73094c..bdc29d1c1b5c 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -1102,8 +1102,10 @@ __dma_fence_init(struct dma_fence *fence, const st=
ruct dma_fence_ops *ops,
> =C2=A0 * to check which fence is later by simply using dma_fence_later().
> =C2=A0 *
> =C2=A0 * It is strongly discouraged to provide an external lock because t=
his couples
> - * lock and fence life time. This is only allowed for legacy use cases w=
hen
> - * multiple fences need to be prevented from signaling out of order.
> + * lock and fence lifetime. This is only allowed for legacy use cases th=
at need
> + * a shared lock to serialize signaling and observation of fences within=
 a
> + * context, so that observers never see a later fence signaled while an =
earlier
> + * one isn't.

I would probably delete the explanation altogether and just state
"allowed for legacy reasons". The legacy people know why it's allowed,
and new users don't need to care. Same below of course.


Thx
P.

> =C2=A0 */
> =C2=A0void
> =C2=A0dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops =
*ops,
> @@ -1129,8 +1131,10 @@ EXPORT_SYMBOL(dma_fence_init);
> =C2=A0 * to check which fence is later by simply using dma_fence_later().
> =C2=A0 *
> =C2=A0 * It is strongly discouraged to provide an external lock because t=
his couples
> - * lock and fence life time. This is only allowed for legacy use cases w=
hen
> - * multiple fences need to be prevented from signaling out of order.
> + * lock and fence lifetime. This is only allowed for legacy use cases th=
at need
> + * a shared lock to serialize signaling and observation of fences within=
 a
> + * context, so that observers never see a later fence signaled while an =
earlier
> + * one isn't.
> =C2=A0 */
> =C2=A0void
> =C2=A0dma_fence_init64(struct dma_fence *fence, const struct dma_fence_op=
s *ops,

