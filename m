Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B81C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:45:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29C2410EA15;
	Tue, 30 Jun 2026 13:45:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jt2Ja/qD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9CDB10EA15
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 13:45:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5A45740100;
 Tue, 30 Jun 2026 13:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140721F000E9;
 Tue, 30 Jun 2026 13:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782827154;
 bh=jLGVe1tT+1Ii95ToR3br/YDPL8BQF6jZu7Qv+ibrAY0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Jt2Ja/qDZh+Fy/Qp8A8UEnPiaqXDVvjYOprX7d/C5iOIrIzlW7GS4XRseTG8lt/VY
 o4OZU1ASnn5SnyVU8hF6F2DoR05AZlUv6p3IBAedn7DBj0v1T+F5wMQ7KY5sKTUvrK
 gwSfBPceGd4yC6+eY/e6UokOtk1WOhAahbqLBTJbSPZjRiQ0OCY1+wXrNE9W0RLX/b
 j+p1JSXo0NHAhnVIwfcwy0MMbiMAzqssKO40+UO0m7YDgHLnwF2aBpUAwavYR4nR1h
 1fdmbr4dZCu8kC8+rrfmYq/m9ar1/p6FMSXpZgESovXUpSGyWyHktqIvU38G9J7woZ
 WSAX5sLjfza7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/vmwgfx: Fix NULL vs error pointer bug in
 vmw_prime_import_sg_table()
To: "Dan Carpenter" <error27@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <akPFZ-e9usvsYgf_@stanley.mountain>
References: <akPFZ-e9usvsYgf_@stanley.mountain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 13:45:53 +0000
Message-Id: <20260630134554.140721F000E9@smtp.kernel.org>
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
- [High] Imported DMA buffers and their scatterlist mappings are leaked bec=
ause vmw_gem_object_free() does not call drm_prime_gem_destroy().
--

commit 122b763cb3d6da8120f8ce7568a560873e4c1325
Author: Dan Carpenter <error27@gmail.com>

drm/vmwgfx: Fix NULL vs error pointer bug in vmw_prime_import_sg_table()

The vmw_prime_import_sg_table() function is expected to return error
pointers on error and not NULL.  Otherwise it leads to a NULL dereference
in the caller drm_gem_prime_import_dev().

Propagate the error code from vmw_bo_create().

Fixes: b32233acceff ("drm/vmwgfx: Fix prime import/export")
Signed-off-by: Dan Carpenter <error27@gmail.com>

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_gem.c
> index 39f8c46550c27..93a92ae625f8e 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c

[ ... ]

> @@ -201,8 +201,10 @@ struct drm_gem_object *vmw_prime_import_sg_table(str=
uct drm_device *dev,
>  	dma_resv_lock(params.resv, NULL);
> =20
>  	ret =3D vmw_bo_create(dev_priv, &params, &vbo);
> -	if (ret !=3D 0)
> +	if (ret !=3D 0) {
> +		gem =3D ERR_PTR(ret);
>  		goto out_no_bo;
> +	}
> =20
>  	vbo->tbo.base.funcs =3D &vmw_gem_object_funcs;

[Severity: High]
This is a pre-existing issue, but while reviewing the dmabuf import lifecyc=
le,
I noticed a potential memory leak in the GEM object free hook.

The DRM core contract requires drivers using the generic dmabuf import help=
er
to call drm_prime_gem_destroy() to unmap and free the dmabuf attachment when
the object is freed.

Looking at vmw_gem_object_free() in the same file:

static void vmw_gem_object_free(struct drm_gem_object *gobj)
{
	struct ttm_buffer_object *bo =3D drm_gem_ttm_of_gem(gobj);
	if (bo)
		ttm_bo_fini(bo);
}

Because this completely omits the drm_prime_gem_destroy() call, does this l=
eak
the dma_buf_attachment and sg_table?

Could an untrusted userspace application trigger a denial-of-service by
repeatedly importing and closing dmabufs, permanently pinning the exported
buffers in memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/akPFZ-e9usvsYgf_@st=
anley.mountain?part=3D1
