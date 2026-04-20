Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338C1F557EB
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 09:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9298110E47C;
	Mon, 20 Apr 2026 09:18:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cB90nWFp";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A7A010E47C
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 09:18:55 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fzg05575rz9tR9;
 Mon, 20 Apr 2026 11:18:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1776676725; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H52iZf47nyQwwRpseIanj6FLrUv+KwPcCKT1CAjDrAg=;
 b=cB90nWFp3jlKw5PuENi9paPeOvYUuP3SbfRNJVBKJl5AaEtNm20KgqH3NeGpNQav6zlRCW
 yiF2WReABU7bNov5V24qy2HcUxOBsdv/0a949udS+L+R73Gtv1qlpNFe1hfyV1i9Bx9r5v
 VGhDvAdlcXJL5cJdysKl5m4MsbChPAFurUBzPPHRNTvQm4Hx3aqYCrTnK1bKZbETzzGDku
 CDVWjv6dOIZdq6gIhSRmtxbSElW9nk5dtDJ/QiK9iY3N2KWpK8SN7EzeQTMO7IUayXPAqX
 g7MPytBFwquP0eMyjQKlO1El/rIodE7Ez74KctIt/TYBFUIcGylXWdIstt4Y9g==
Message-ID: <6389c57fd1453b545709c15c5fa74aa76a3d9afa.camel@mailbox.org>
Subject: Re: [PATCH v2] dma-fence: Clarify external lock use case in
 dma_fence_init() docs
From: Philipp Stanner <phasta@mailbox.org>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, Boris Brezillon <boris.brezillon@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,  Philipp Stanner
 <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 kernel-dev@igalia.com
Date: Mon, 20 Apr 2026 11:18:40 +0200
In-Reply-To: <20260419134943.54833-2-mcanal@igalia.com>
References: <20260419134943.54833-2-mcanal@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: kwjkcgbza3jqjwbqyuokp8iq1c9thwkr
X-MBO-RS-ID: dd32fd36144395c208b
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

On Sun, 2026-04-19 at 10:48 -0300, Ma=C3=ADra Canal wrote:
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

Reviewed-by: Philipp Stanner <phasta@kernel.org>

>=20
> ---
>=20
> v1 -> v2: https://lore.kernel.org/dri-devel/20260411185756.1887119-4-mcan=
al@igalia.com/
>=20
> - Be more explicit about not allowing new users to use an external lock.
> - De-duplicate the explanation in dma_fence_init64() by pointing to the
> =C2=A0 dma_fence_init() documentation.
> ---
> =C2=A0drivers/dma-buf/dma-fence.c | 13 +++++++------
> =C2=A01 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index 1c1eaecaf1b0..63b349ba9a34 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -1102,9 +1102,11 @@ __dma_fence_init(struct dma_fence *fence, const st=
ruct dma_fence_ops *ops,
> =C2=A0 * context and seqno are used for easy comparison between fences, a=
llowing
> =C2=A0 * to check which fence is later by simply using dma_fence_later().
> =C2=A0 *
> - * It is strongly discouraged to provide an external lock because this c=
ouples
> - * lock and fence life time. This is only allowed for legacy use cases w=
hen
> - * multiple fences need to be prevented from signaling out of order.
> + * External locks are a relic from legacy use cases that needed a shared=
 lock
> + * to serialize signaling and observation of fences within a context, so=
 that
> + * observers never see a later fence signaled while an earlier one isn't=
. New
> + * users MUST NOT use external locks, as they force the issuer to outliv=
e all
> + * fences that reference the lock.
> =C2=A0 */
> =C2=A0void
> =C2=A0dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops =
*ops,
> @@ -1129,9 +1131,8 @@ EXPORT_SYMBOL(dma_fence_init);
> =C2=A0 * Context and seqno are used for easy comparison between fences, a=
llowing
> =C2=A0 * to check which fence is later by simply using dma_fence_later().
> =C2=A0 *
> - * It is strongly discouraged to provide an external lock because this c=
ouples
> - * lock and fence life time. This is only allowed for legacy use cases w=
hen
> - * multiple fences need to be prevented from signaling out of order.
> + * New users MUST NOT use external locks. Check the documentation in
> + * dma_fence_init() to understand the motives behind the legacy use case=
s.
> =C2=A0 */
> =C2=A0void
> =C2=A0dma_fence_init64(struct dma_fence *fence, const struct dma_fence_op=
s *ops,

