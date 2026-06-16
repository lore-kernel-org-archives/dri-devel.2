Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721D3CD98DE
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 00:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A232F10E1DE;
	Tue, 16 Jun 2026 00:17:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q0z/dTyk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEADE10E1DE
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 00:17:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1B78B60137;
 Tue, 16 Jun 2026 00:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4081F00A3A;
 Tue, 16 Jun 2026 00:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781569056;
 bh=4vFXpYDJwq4iT9avbdQphWe+5QQpviDiTMBGKfUV4F8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q0z/dTykffIR841OxtZavhNib+Pfpd7e1nMLUzQT2rtYqVj8SVN1oHHqpDN7tJBj0
 ZuN5rhamAqZumcLpO4iGeB2+LqO7+a0sPjbQKdwr4RyemCcLQUlFmlRvj4QldLbTmf
 g2TrHrZ7LuauPDPWFN2DGSq4Maa/bsTgDp+1o4cuR17CMe4586pBgkYMbFg6uBDiVa
 8OnLtppS7hfvd1Lw0R2C8i5c32CyBD4Er36tG13PsfaCOOFVjGmB5ffncYPcPE05XN
 UxzwRVt7l5+gtLeeYwUpfK4jt9nJYQgyu38LZ8vLh4hzd+3I0BLDVzoXXgarzQ5vCI
 saL12KAvMqCdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] drm/ttm: don't leave bulk_move cursor dangling
 for unevictable resources
To: "Samuel Ainsworth" <skainsworth@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260615234922.151263-2-skainsworth@gmail.com>
References: <20260615234922.151263-2-skainsworth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 00:17:36 +0000
Message-Id: <20260616001736.9E4081F00A3A@smtp.kernel.org>
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
- [Critical] ttm_resource_del_bulk_move() forces ttm_lru_bulk_move_del() on=
 unevictable resources, causing out-of-bounds reads and severe list splicin=
g.
--

commit 899a72ab04ff8d47f3d8f9603f7989eb258c9b3e
Author: Samuel Ainsworth <skainsworth@gmail.com>

drm/ttm: don't leave bulk_move cursor dangling for unevictable resources

ttm_resource_add_bulk_move() and ttm_resource_del_bulk_move() both act
only when the resource is evictable. A resource is added to its bo's
bulk_move cursor while evictable, but it can become unevictable -- pinned
or swapped -- after it has been added. Track whether a resource is actually
on the bulk_move cursor with a new flag.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/5387

> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm=
_resource.c
> index 192fca24f37e4..1a031ef151a71 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
[ ... ]
> @@ -280,16 +280,27 @@ static bool ttm_resource_unevictable(struct ttm_res=
ource *res, struct ttm_buffer
[ ... ]
>  /* Remove the resource from a bulk move if the BO is configured for it */
>  void ttm_resource_del_bulk_move(struct ttm_resource *res,
>  				struct ttm_buffer_object *bo)
>  {
> -	if (bo->bulk_move && !ttm_resource_unevictable(res, bo))
> +	/*
> +	 * Remove based on whether the resource was actually added, not on its
> +	 * current evictability: a resource can become unevictable (pinned or
> +	 * swapped) after being added, and must still be taken off the bulk_move
> +	 * cursor before it is freed -- otherwise pos->first/last are left
> +	 * dangling at freed memory.
> +	 */
> +	if (res->bulk_move) {
>  		ttm_lru_bulk_move_del(bo->bulk_move, res);

[Severity: Critical]
Since the !ttm_resource_unevictable check is removed, can ttm_lru_bulk_move=
_del()
now process unevictable resources?

When a resource becomes unevictable, its lru.link is moved to bdev->unevict=
able
via ttm_resource_move_to_lru_tail().

If ttm_lru_bulk_move_del() is called on this resource, and it is pos->first=
 (but
not pos->last), it finds the next resource to update the cursor:

drivers/gpu/drm/ttm/ttm_resource.c:ttm_lru_bulk_move_del() {
    ...
	} else if (pos->first =3D=3D res) {
		pos->first =3D ttm_lru_next_res(res);
    ...
}

Since res is on the bdev->unevictable list, ttm_lru_next_res() will traverse
bdev->unevictable rather than man->lru. When it reaches the list head:

drivers/gpu/drm/ttm/ttm_resource.c:ttm_lru_next_res() {
    ...
	do {
		lru =3D list_next_entry(lru, link);
	} while (!ttm_lru_item_is_res(lru));
    ...
}

Could casting the list head to struct ttm_lru_item and reading the type fie=
ld
cause an out-of-bounds read of adjacent struct fields?

Additionally, pos->first would now point to an element on the bdev->unevict=
able
list. If a subsequent ttm_lru_bulk_move_tail() is called, wouldn't it attem=
pt a
list splice with endpoints spanning two completely different lists, permane=
ntly
corrupting kernel list structures?

> +		res->bulk_move =3D false;
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615234922.1512=
63-1-skainsworth@gmail.com?part=3D1
