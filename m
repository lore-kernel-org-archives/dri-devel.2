Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C70C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:24:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3912C10F99A;
	Fri, 10 Jul 2026 22:24:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cf5PEtro";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1B1210F998
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 22:24:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7573E60051;
 Fri, 10 Jul 2026 22:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020901F000E9;
 Fri, 10 Jul 2026 22:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783722244;
 bh=orEa6Pnvm+ymnS14O0bV67BUNTq1ehtE5FXCQpJYpcQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Cf5PEtroLmiik02MQpDeYva4715Urcqo9A++XD4pHK4fcKrcz0m/LrD/YHuIU67q3
 ItnXwEdWr4L3lYmxQls0+s5Q+pXeev12CZU58BKZW4hXAlAc8YGDyfJYSingbwaBoB
 UAFS5+eYUDOGmJYv5AzDOb89wTsYqrIcYNMdXnmUCSZIZPyko38Q/ZTfAXbMLedYof
 wvwXK1cgh5PnlJHlForx50d9qwxlxLeuELwUOA/ZxTIJl9lTFiDLWezeb+4kBSnWKF
 jpLz0HPVpVBeWhQLk55+sSXvEuK1uml3VKTZulEm9dyisOJ7Q2UrXh3JxNILlT3+PA
 pQCrk5YymlfjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 27/33] drm/xe: Add IOVA-based xe_res_cursor variant
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710215442.2444235-28-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-28-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:24:03 +0000
Message-Id: <20260710222404.020901F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unreachable dead code block added for IOVA cursor segment advanceme=
nt in xe_res_next().
--

--- Patch [27]: [PATCH v2 27/33] drm/xe: Add IOVA-based xe_res_cursor varia=
nt ---
commit 8700355546957aacaa7e49fc841d6e860b3ed9e7
Author: Matthew Brost <matthew.brost@intel.com>

drm/xe: Add IOVA-based xe_res_cursor variant

Introduce xe_res_first_iova() to walk a buffer that was DMA mapped using
the IOVA-based DMA API. Such a mapping is described by a struct
dma_iova_state and is a single contiguous IOVA range, so the cursor walks
it as one segment.

> diff --git a/drivers/gpu/drm/xe/xe_res_cursor.h b/drivers/gpu/drm/xe/xe_r=
es_cursor.h
> index 0522caafd89d7..f0f1d699e16e5 100644
> --- a/drivers/gpu/drm/xe/xe_res_cursor.h
> +++ b/drivers/gpu/drm/xe/xe_res_cursor.h

[ ... ]

> @@ -255,6 +264,41 @@ static inline void xe_res_first_dma(const struct drm=
_pagemap_addr *dma_addr,
> +static inline void xe_res_first_iova(struct dma_iova_state *state,
> +				     u64 start, u64 size,
> +				     struct xe_res_cursor *cur)
> +{
> +	XE_WARN_ON(!state);
> +	XE_WARN_ON(start + size > dma_iova_size(state));
> +
> +	cur->node =3D NULL;
> +	cur->start =3D start;
> +	cur->remaining =3D size;
> +	cur->size =3D size;
> +	cur->dma_addr =3D NULL;
> +	cur->sgl =3D NULL;
> +	cur->dma_start =3D state->addr;
> +	cur->dma_seg_size =3D dma_iova_size(state);
> +	cur->mem_type =3D XE_PL_TT;
> +	cur->is_iova =3D true;
>  }

[ ... ]

> @@ -283,6 +327,13 @@ static inline void xe_res_next(struct xe_res_cursor =
*cur, u64 size)
>  	if (cur->size > size) {
>  		cur->size -=3D size;
>  		cur->start +=3D size;
>  		return;
>  	}
> =20
> +	if (cur->is_iova) {
> +		/* Single contiguous IOVA segment. */
> +		cur->start +=3D size;
> +		cur->size =3D cur->remaining;
> +		return;
> +	}
> +

[Severity: Low]
Is this block unreachable dead code?

In xe_res_first_iova(), the cursor is initialized as a single segment where
cur->size is equal to cur->remaining:

    cur->remaining =3D size;
    cur->size =3D size;

When xe_res_next(cur, size) is called, it first subtracts size from
cur->remaining. If the entire remaining segment is consumed, it returns
early via if (!cur->remaining).

If only a portion of the segment is consumed, size is strictly less than
cur->size. This causes the function to always take the early return path
immediately above this newly added block:

    if (cur->size > size) {
        cur->size -=3D size;
        cur->start +=3D size;
        return;
    }

Because an IOVA cursor is a single contiguous segment where cur->size and
cur->remaining start perfectly synchronized, does it ever need to bypass
these early returns and evaluate the if (cur->is_iova) block?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710215442.2444=
235-1-matthew.brost@intel.com?part=3D27
