Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C246CD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 19:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72A9A112972;
	Thu,  4 Jun 2026 19:29:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kb7uoHLw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14C4E112972
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 19:29:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CB0CF43E04;
 Thu,  4 Jun 2026 19:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915571F00893;
 Thu,  4 Jun 2026 19:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780601388;
 bh=axSVcuilFjvQE40R/sVbNFbup++p863Xuvn6x49nwQM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Kb7uoHLwaIticPZaZduY+UQzZoyy0VBMcGrE8dXGiS9u5O+fEcHdrim5Vq/LiV/j6
 zqdyf+onqi6K7RvzePx6xwFOvdkv8ExekN19qF4EBCdgDNFUvCf2pxKXQjgsBIzBlo
 lsY/p3rXnUEAXY3dHd6FCt0CTaSVjyQT5bRsH9bkDH/ljz5sALDHTdJUZ6M1tQJIH2
 Vqgi6YQeBBCDSw6wdQWeyfIKiTcN9QCTOfK1l4Us6elvF8mqZfgSxTzoVW22vIt6tC
 HrKyFrDjDDyiTGDCovShOHYYi7tSbvobIiH/9fYeuA000pl7nmxM8CHknhZBoPFE0F
 OPN5VJql6VqeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/gem: Try to fix change_handle ioctl, attempt 4
To: "Simona Vetter" <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260604191916.1713387-1-simona.vetter@ffwll.ch>
References: <20260604191916.1713387-1-simona.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 19:29:47 +0000
Message-Id: <20260604192948.915571F00893@smtp.kernel.org>
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
- [High] Missing IS_ERR check on idr_replace() return value causes an inval=
id pointer dereference.
--

commit f7209a31976a5023734386f397179e3835aa2048
Author: Simona Vetter <simona.vetter@ffwll.ch>

drm/gem: Try to fix change_handle ioctl, attempt 4

This commit modifies the change_handle ioctl to resolve a race condition
by merging the GEM object lookup and two-stage idr_replace. It also
temporarily disables the ioctl in drm_ioctls to prevent further abuse until
the implementation is fully verified.

> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index ac751a42db281..66cfd52c7cff9 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
[ ... ]
> @@ -1028,52 +1028,36 @@ int drm_gem_change_handle_ioctl(struct drm_device=
 *dev, void *data,
[ ... ]
> +	obj =3D idr_replace(&file_priv->object_idr, NULL, args->handle);
> +	if (!obj) {

[Severity: High]
Will this result in dereferencing an error pointer if args->handle is inval=
id?

If idr_replace() fails to find the handle, it returns ERR_PTR(-ENOENT) rath=
er
than NULL. The check here only tests for NULL, allowing an error pointer to
fall through.

> +		idr_remove(&file_priv->object_idr, new_handle);
> +		spin_unlock(&file_priv->table_lock);
> +		ret =3D -ENOENT;
> +		goto out_unlock;
> +	}
>  	spin_unlock(&file_priv->table_lock);
> =20
>  	if (obj->dma_buf) {

If an error pointer falls through the check above, wouldn't evaluating
obj->dma_buf here cause an invalid pointer dereference? Should the error
handling for idr_replace() be updated to use IS_ERR(obj)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604191916.1713=
387-1-simona.vetter@ffwll.ch?part=3D1
