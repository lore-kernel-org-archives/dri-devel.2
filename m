Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7363C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F44810E8A6;
	Mon,  6 Jul 2026 10:32:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="naoURcfD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2064110E8AF
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 10:32:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5474C61389;
 Mon,  6 Jul 2026 10:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3301F000E9;
 Mon,  6 Jul 2026 10:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783333941;
 bh=x8sID526/ok6f9vPwF0PLCRZmDinfJ2L1xHv3GyRbKA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=naoURcfDqcS8jcaDAckWzvnVg988fPzOMhPuAJkjPJ8GbBdY9ulRgF9787NtYWwVi
 46EV1ot/k7vwvLqXzRthu50yPcy3K+asJo0j2uLJPmlfNeq9e5IOiq8UJBZQXtMP38
 p3C3wobR/QAwPcpwIzQY5SXAiv7VpyUc9Wwb/zyJ+PK2ThQOtkCz1YaJcXIdqgT0P8
 e+zg2ta/JDIeDXqGUGHFOii9s6NORZFMCp9Krvi6fUf+YRGRtPiR6zgNKhoGmHCDn3
 75KhrlOzAI4A4pYKQSJ2tQYDU9FsCPD/GNPVSxJdQkR4F1Quo0fVAJ9zrsxUNqZ9NK
 9mzet7KIunLtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/10] drm/xe: remove workaround for TTM internals
To: "Natalie Vock" <nat@pixelcluster.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706-ttm_2_drm_exec-v2-8-4bf6bfc0d320@pixelcluster.dev>
References: <20260706-ttm_2_drm_exec-v2-0-4bf6bfc0d320@pixelcluster.dev>
 <20260706-ttm_2_drm_exec-v2-8-4bf6bfc0d320@pixelcluster.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:32:20 +0000
Message-Id: <20260706103220.DE3301F000E9@smtp.kernel.org>
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
- [Critical] Locking mismatch and missing error handling in `xe_ttm_bo_rele=
ase_notify` lead to deadlocks, state corruption, and kernel panics for impo=
rted dma-buf objects.
--

commit 654aea229ee4882cf8f04774d507ece22e8921fd
Author: Natalie Vock <nat@pixelcluster.dev>

drm/xe: remove workaround for TTM internals

This commit removes the xe_ttm_bo_lock_in_destructor() workaround and repla=
ces
it with a WARN_ON() check in xe_ttm_bo_release_notify().

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 5843f850339c7..34eae56716076 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
[ ... ]
> @@ -1680,8 +1655,11 @@ static void xe_ttm_bo_release_notify(struct ttm_bu=
ffer_object *ttm_bo)
>  	bo =3D ttm_to_xe_bo(ttm_bo);
>  	xe_assert(xe_bo_device(bo), !(bo->created && kref_read(&ttm_bo->base.re=
fcount)));
> =20
> -	if (!xe_ttm_bo_lock_in_destructor(ttm_bo))
> -		return;
> +	/*
> +	 * This should never fail since there are no other references to the BO
> +	 * any more.
> +	 */
> +	WARN_ON(!dma_resv_trylock(ttm_bo->base.resv));

[Severity: Critical]
Since WARN_ON() does not return on failure, if the trylock fails, won't
execution fall through and modify fences without holding the lock?

Also, there appears to be a mismatch in the resv pointer being locked and
unlocked. We are locking ttm_bo->base.resv here, but later in this same
function it acts on ttm_bo->base._resv:

	dma_resv_for_each_fence(&cursor, &ttm_bo->base._resv,
				DMA_RESV_USAGE_BOOKKEEP, fence) {
		...
	}
	dma_resv_unlock(&ttm_bo->base._resv);

For imported dma-buf objects, base.resv might not equal &base._resv. Could
this lock the exporter's shared resv but attempt to unlock the local embedd=
ed
_resv? This might cause a deadlock on the shared resv and an attempt to
unlock an unheld mutex.

> =20
>  	/*
>  	 * Scrub the preempt fences if any. The unbind fence is already

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-ttm_2_drm_=
exec-v2-0-4bf6bfc0d320@pixelcluster.dev?part=3D8
