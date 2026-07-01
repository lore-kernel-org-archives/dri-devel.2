Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1ECC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B93B710EDD7;
	Wed,  1 Jul 2026 06:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZU/PqjLY";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F0B810EDD8
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 06:52:21 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gqrKt35VBz9vGl;
 Wed,  1 Jul 2026 08:52:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1782888738; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h0T0Aq4D0iiGnKHiN1eZ2zLsHAfporMJTH+keDJMVT0=;
 b=ZU/PqjLYdUiPOLC1o1CHkNqnRWsWfDKu4PG7OskLcj4psHOOoQ0zBRYGw6Gze2a14/sl2U
 wHMDkln3I3IaRs48Ku4lCmfKS8/KJPIFxPKn/HpIRkzVVyYNWShBhB6ZCw36RxQJhmNEgr
 T4C1QUc50rAHX5pr+aLHYYkI6E8q7ca3/5ba7n1XnpCzewzYb1wnHTXXP230V9lIVXQxgn
 gLiBHCdH5bg1fdWbhQz5JPG06JLtuI6ZEXiQskFJS26aHDHA1SgATq9yELWzTCub2AEcC6
 pOPxortvAhMhqLo2gl1lKSfxpuxgW0ta4z/zQFopBf2arSLnrfQDl6xWUyG+vA==
Message-ID: <9650c30654db85e393217fde419a966d312e4a43.camel@mailbox.org>
Subject: Re: [PATCH] dma_buf: change unsigned int and int types into size_t
From: Philipp Stanner <phasta@mailbox.org>
To: Shahyan Soltani <shahyan.soltani@amd.com>, christian.koenig@amd.com, 
 sumit.semwal@linaro.org
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org
Date: Wed, 01 Jul 2026 08:52:15 +0200
In-Reply-To: <20260630160401.67544-1-shahyan.soltani@amd.com>
References: <20260630160401.67544-1-shahyan.soltani@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: ybe5otnm1fhe4joh9rh1ax17bud13fw4
X-MBO-RS-ID: e2417a6c4c1abfbbfb5
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

On Tue, 2026-06-30 at 12:04 -0400, Shahyan Soltani wrote:
> The num_fences, count, i, and j variables in dma_fence_dedup_array() and
> __dma_fence_unwrap_merge() have inconsistent integer types, mixing both
> unsigned int and int.
>=20
> Use type size_t consistently for these instead, and update the return
> type of dma_fence_dedup_array() accordingly.
>=20
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> Suggested-by: Philipp Stanner <phasta@mailbox.org>

Thx for fixing this, cool work

Reviewed-by: Philipp Stanner <phasta@kernel.org>

> ---
> The rest of the subsystems (dma_resv_reserve_fences, drm_exec, drm_gpuvm,
> xe, nouveau, etc) uses "unsigned int" for num_fences, for example the
> amdgpu caller in amdgpu_userq_fence.c.

You mention that because you can't / won't change them?

My suggestion actually has been to go for `unsigned int`. Christian
opinioned that it should be size_t. Shouldn't be a big deal, though, my
issue was just the possibility for negative numbers.

Christian, would it be a bit better to be consistent with the parties
Shayan mentions?


P.

>=20
> =C2=A0drivers/dma-buf/dma-fence-unwrap.c | 8 ++++----
> =C2=A0include/linux/dma-fence-unwrap.h=C2=A0=C2=A0 | 6 ++++--
> =C2=A02 files changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fen=
ce-unwrap.c
> index 53bb40e70b27..65e87d263c3a 100644
> --- a/drivers/dma-buf/dma-fence-unwrap.c
> +++ b/drivers/dma-buf/dma-fence-unwrap.c
> @@ -93,9 +93,9 @@ static int fence_cmp(const void *_a, const void *_b)
> =C2=A0 *
> =C2=A0 * Return: Number of unique fences remaining in the array.
> =C2=A0 */
> -int dma_fence_dedup_array(struct dma_fence **fences, int num_fences)
> +size_t dma_fence_dedup_array(struct dma_fence **fences, size_t num_fence=
s)
> =C2=A0{
> -	int i, j;
> +	size_t i, j;
> =C2=A0
> =C2=A0	sort(fences, num_fences, sizeof(*fences), fence_cmp, NULL);
> =C2=A0
> @@ -115,14 +115,14 @@ int dma_fence_dedup_array(struct dma_fence **fences=
, int num_fences)
> =C2=A0EXPORT_SYMBOL_GPL(dma_fence_dedup_array);
> =C2=A0
> =C2=A0/* Implementation for the dma_fence_merge() marco, don't use direct=
ly */
> -struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
> +struct dma_fence *__dma_fence_unwrap_merge(size_t num_fences,
> =C2=A0					=C2=A0=C2=A0 struct dma_fence **fences,
> =C2=A0					=C2=A0=C2=A0 struct dma_fence_unwrap *iter)
> =C2=A0{
> =C2=A0	struct dma_fence *tmp, *unsignaled =3D NULL, **array;
> =C2=A0	struct dma_fence_array *result;
> =C2=A0	ktime_t timestamp;
> -	int i, count;
> +	size_t i, count;
> =C2=A0
> =C2=A0	count =3D 0;
> =C2=A0	timestamp =3D ns_to_ktime(0);
> diff --git a/include/linux/dma-fence-unwrap.h b/include/linux/dma-fence-u=
nwrap.h
> index 62df222fe0f1..7bfacdf79de2 100644
> --- a/include/linux/dma-fence-unwrap.h
> +++ b/include/linux/dma-fence-unwrap.h
> @@ -8,6 +8,8 @@
> =C2=A0#ifndef __LINUX_DMA_FENCE_UNWRAP_H
> =C2=A0#define __LINUX_DMA_FENCE_UNWRAP_H
> =C2=A0
> +#include <linux/types.h>
> +
> =C2=A0struct dma_fence;
> =C2=A0
> =C2=A0/**
> @@ -48,11 +50,11 @@ struct dma_fence *dma_fence_unwrap_next(struct dma_fe=
nce_unwrap *cursor);
> =C2=A0	for (fence =3D dma_fence_unwrap_first(head, cursor); fence;	\
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0 fence =3D dma_fence_unwrap_next(cursor))
> =C2=A0
> -struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
> +struct dma_fence *__dma_fence_unwrap_merge(size_t num_fences,
> =C2=A0					=C2=A0=C2=A0 struct dma_fence **fences,
> =C2=A0					=C2=A0=C2=A0 struct dma_fence_unwrap *cursors);
> =C2=A0
> -int dma_fence_dedup_array(struct dma_fence **array, int num_fences);
> +size_t dma_fence_dedup_array(struct dma_fence **array, size_t num_fences=
);
> =C2=A0
> =C2=A0/**
> =C2=A0 * dma_fence_unwrap_merge - unwrap and merge fences
