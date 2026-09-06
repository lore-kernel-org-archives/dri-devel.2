Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B21CC79F9F
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 15:38:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A89B10E3E8;
	Sun,  6 Sep 2026 15:38:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FxqNkMKf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 377F310E3E8
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 15:38:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 35E1B601DB;
 Sun,  6 Sep 2026 15:38:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69F81F00A3D;
 Sun,  6 Sep 2026 15:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788709079;
 bh=YeVQD5JH8J2wJHwg5dOd+tAM2BzI5Rsh+nms3GBGgy4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FxqNkMKfgDfUO7AQB3TG9zdBTQJJZvFwesggg52/mPgvFUCnrGvz58SYSx1Tcvuv7
 DqpxIzVQMOrmaiScAoh5zNy05xyBoJ0TPS0C6L/HfrK7LoHRJpALymVvCPZ8UaXEmi
 R5zT6WA99mz1KqztbtZ+bALRl0kGxZWXImh68haL9xGxv8S90dvTvQcvFVSKhTx9s8
 A1UC5UbuTaDU4F3lykv6p2q0gbVA2t9h26Szn85oBSZ+Wud8rBE6qO1JIKukC67LBp
 dref2S4Y7aX7B148QIBzQtAmP5Voh9YA/SJIOjWrDoouLhIKGs4KzZfxK7tjCJC/cA
 q2V5gaif4ZTjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/radeon: switch from get_user_pages to
 pin_user_pages
To: "Seongjun Hong" <hsj0512@snu.ac.kr>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260906152726.1685848-1-hsj0512@snu.ac.kr>
References: <20260827090100.428302-1-hsj0512@snu.ac.kr>
 <20260906152726.1685848-1-hsj0512@snu.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 15:37:59 +0000
Message-Id: <20260906153759.B69F81F00A3D@smtp.kernel.org>
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
- [Critical] The return value of `radeon_ttm_tt_pin_userptr()` is completel=
y ignored in `radeon_ttm_backend_bind()`, leading to arbitrary DMA mapping,=
 Use-After-Free, and Double Free vulnerabilities.
--

commit 4531c5ac337e9cc383254beba3b239a8be2b493c
Author: Seongjun Hong <hsj0512@snu.ac.kr>
drm/radeon: switch from get_user_pages to pin_user_pages

This commit replaces the deprecated get_user_pages() API with
pin_user_pages() to ensure DMA pages are properly pinned. It also adds the
FOLL_LONGTERM flag to reflect that these userptr pages remain pinned for
the lifetime of the GEM userptr BO's GART binding.

> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon=
/radeon_ttm.c
> index e7ab8162ac694..c14b215c7e3e1 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c

[ ... ]

> @@ -377,7 +378,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_devic=
e *bdev, struct ttm_tt *ttm
>  	kfree(ttm->sg);
> =20
>  release_pages:
> -	release_pages(ttm->pages, pinned);
> +	unpin_user_pages(ttm->pages, pinned);

[Severity: Critical]
This is a pre-existing issue, but does this error path leave ttm->sg as a
dangling pointer?

When pin_user_pages() fails (which could happen more easily now if userspace
provides File System DAX mappings that are cleanly rejected due to the newly
added FOLL_LONGTERM flag), the failure is handled here and ttm->sg is freed
without being set to NULL.

Because radeon_ttm_backend_bind() completely ignores the return value of
radeon_ttm_tt_pin_userptr():

drivers/gpu/drm/radeon/radeon_ttm.c:radeon_ttm_backend_bind() {
    ...
	if (gtt->userptr) {
		radeon_ttm_tt_pin_userptr(bdev, ttm);
		flags &=3D ~RADEON_GART_PAGE_WRITE;
	}
    ...
}

Execution proceeds with an invalid state, leading to arbitrary GPU DMA acce=
ss
to physical memory or address 0.

Furthermore, this dangling pointer will be accessed later in
radeon_ttm_tt_unpin_userptr():

drivers/gpu/drm/radeon/radeon_ttm.c:radeon_ttm_tt_unpin_userptr() {
    ...
	/* double check that we don't free the table twice */
	if (!ttm->sg || !ttm->sg->sgl)
		return;
    ...
}

This causes a Use-After-Free read, and subsequently a Double Free when the
BO is destroyed and radeon_ttm_tt_unpopulate() calls kfree(ttm->sg).

Could we set ttm->sg =3D NULL after freeing it and check the return value of
radeon_ttm_tt_pin_userptr() in radeon_ttm_backend_bind() to prevent this?

>  	return r;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906152726.1685=
848-1-hsj0512@snu.ac.kr?part=3D1
