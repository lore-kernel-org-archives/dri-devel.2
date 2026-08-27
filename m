Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56B4C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 16:12:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB84010E108;
	Thu, 27 Aug 2026 16:12:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TJQkeRLu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E64DF10E108
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 16:12:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A5C684145D;
 Thu, 27 Aug 2026 16:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F47C1F000E9;
 Thu, 27 Aug 2026 16:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787847154;
 bh=pSDJBoj6fK0QzS/Fm9gZOJQuMZVBwC1TMI4vHve1c5E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TJQkeRLuJnB6ptZN9w4LDDMKtg343al6nOIR5XNqwC9RJVGSQotGyd3bbuTbEwVmw
 SZRubexcyoTnj+PmCNXzzRyqyrFRMW9/1FOSQkzNg7UR2YU+q+1ths8e+3hRo6WNFO
 KvtBUHnYvKzMaRDX0UvIFkFM+6g2Fq/Z3r+5aVrLl4xDsS6qd2aAHofOqH2rD9q7Tg
 Ae+I9zzQysP/kylzRuIrZw2baWnIwM1HInq581i7qrl6r3AGQ2B9FTh0ls8K4oTtv0
 adlRplCxAGXvA14v1hHtiqW76Sv6O60xrMP8GBaR7c0VtpTVw2ungvpN7EBfrtKyry
 US2i6G/D1gn1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/radeon: check radeon_ttm_tt_pin_userptr() return
 value in bind
To: "Seongjun Hong" <hsj0512@snu.ac.kr>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260827160124.679309-2-hsj0512@snu.ac.kr>
References: <20260827091532.340141F000E9@smtp.kernel.org>
 <20260827160124.679309-1-hsj0512@snu.ac.kr>
 <20260827160124.679309-2-hsj0512@snu.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 16:12:34 +0000
Message-Id: <20260827161234.5F47C1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] The error path in `radeon_ttm_tt_pin_userptr()` incorrectly fr=
ees `ttm->sg` using `kfree()` without setting the pointer to NULL and witho=
ut properly freeing the inner scatterlist array if it was allocated. This l=
eads to a memory leak, dangling pointer, use-after-free, double-put of page=
s, and double-free during the object teardown sequence.
--

commit 4389e2026f1a66251ba9951cbc3ed34d9181fa4f
Author: Seongjun Hong <hsj0512@snu.ac.kr>

drm/radeon: check radeon_ttm_tt_pin_userptr() return value in bind

This commit propagates the error from radeon_ttm_tt_pin_userptr() in
radeon_ttm_backend_bind() to avoid writing stale or uninitialized DMA
addresses to the GPU's GART page table.

> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon=
/radeon_ttm.c
> index e7ab8162ac694..1b72cac9ed6b6 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -431,7 +431,9 @@ static int radeon_ttm_backend_bind(struct ttm_device =
*bdev,
>  		return 0;
> =20
>  	if (gtt->userptr) {
> -		radeon_ttm_tt_pin_userptr(bdev, ttm);
> +		r =3D radeon_ttm_tt_pin_userptr(bdev, ttm);
> +		if (r)
> +			return r;

[Severity: Critical]
This is a pre-existing issue, but by returning the error here, we trigger
the TTM object teardown sequence which exposes memory management bugs in
the existing error handling paths.

If radeon_ttm_tt_pin_userptr() fails at dma_map_sgtable() (for instance),
it does this:

drivers/gpu/drm/radeon/radeon_ttm.c:radeon_ttm_tt_pin_userptr() {
    ...
	r =3D dma_map_sgtable(rdev->dev, ttm->sg, direction, 0);
	if (r)
		goto release_sg;
    ...
release_sg:
	kfree(ttm->sg);
release_pages:
	release_pages(ttm->pages, pinned);
	return r;
}

This frees ttm->sg without setting it to NULL, leaving a dangling pointer.
It also leaks the internal scatterlist nodes instead of using sg_free_table=
().

Because we now return the error from radeon_ttm_backend_bind(), TTM initiat=
es
teardown via ttm_tt_unpopulate() -> radeon_ttm_tt_unpopulate() ->
radeon_ttm_tt_unbind() -> radeon_ttm_tt_unpin_userptr().

In radeon_ttm_tt_unpin_userptr(), we have a use-after-free read:

drivers/gpu/drm/radeon/radeon_ttm.c:radeon_ttm_tt_unpin_userptr() {
    ...
	/* double check that we don't free the table twice */
	if (!ttm->sg || !ttm->sg->sgl)
		return;
    ...
}

It also does a double-put on the pages, as they were already released in the
initial error path:

drivers/gpu/drm/radeon/radeon_ttm.c:radeon_ttm_tt_unpin_userptr() {
    ...
		put_page(page);
    ...
}

Finally, radeon_ttm_tt_unpopulate() causes a double-free of ttm->sg:

drivers/gpu/drm/radeon/radeon_ttm.c:radeon_ttm_tt_unpopulate() {
    ...
	if (gtt && gtt->userptr) {
		kfree(ttm->sg);
    ...
}

Can we update the error paths in radeon_ttm_tt_pin_userptr() and related
teardown functions to safely handle these failure cases before propagating
the error here?

>  		flags &=3D ~RADEON_GART_PAGE_WRITE;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827160124.6793=
09-2-hsj0512@snu.ac.kr?part=3D1
