Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72861C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9D0810E3C9;
	Fri, 26 Jun 2026 15:11:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DL8TEnUi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CEAF10E3C9
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 15:11:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 84AB842E58;
 Fri, 26 Jun 2026 15:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D661F000E9;
 Fri, 26 Jun 2026 15:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782486695;
 bh=GeEQzOxYYOVWRBg7LNltCqytEaDsrpAoKZdlfcv1x7U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DL8TEnUizlB/kIqppKzUh/9WEv5PFTQRoDoK8Bg7uyhDhz5fh8a0k8Luo53FjLzxZ
 rCQNn77ypBDbrjsWzZ5znjZsiRjPeNnyZicKcAWNdiZUKYI8lqbNw4Ip5oH7afEKJM
 0QDHhuMKa239BEsZT7HwgpqyfQWUy7+kV3ZGgbVVJqkOuAo7w56713+/U4qokZlm2X
 wgLrdxToIW4QFopLbvlHj72CgMsTUpM9z3SCt3MlYJi+f7AC3P/Bxc795rdwkxXolY
 wxUPruFRA2B9po3KKKx45C3ZX3cjcdUgb9RioCt14hWeH3ruMIBz8RfNIzN0sjhn6l
 1ZC46+oaOe81w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fix: drm/vc4: vc4_cl_lookup_bos: fix NULL pointer
 dereference on   drm_gem_objects_lookup failure
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626145655.49508-1-vulab@iscas.ac.cn>
References: <20260626145655.49508-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 15:11:34 +0000
Message-Id: <20260626151135.37D661F000E9@smtp.kernel.org>
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
- [High] An off-by-one bounds check in `vc4_validate_shader_recs` allows an=
 out-of-bounds read past the end of the `exec->bo` array, leading to a pote=
ntial arbitrary pointer dereference.
--

commit ded73237e9f7dd1d57c4b86e834979a9f46dac6e
Author: WenTao Liang <vulab@iscas.ac.cn>

fix: drm/vc4: vc4_cl_lookup_bos: fix NULL pointer dereference on drm_gem_ob=
jects_lookup failure

When drm_gem_objects_lookup fails, it sets *objs_out to NULL, leaving
  exec->bo as NULL. The fail_put_bo error handler unconditionally iterates
  over exec->bo[i] without checking for NULL, causing a NULL pointer
  dereference.

Add a NULL check for exec->bo before accessing its entries in the
  fail_put_bo error path.

Cc: stable@vger.kernel.org
Fixes: ba3f6db4afee ("drm/vc4: replace obj lookup steps with drm_gem_object=
s_lookup")

> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
> index e231c906709c1..b6cf24ca176cd 100644
> --- a/drivers/gpu/drm/vc4/vc4_gem.c
> +++ b/drivers/gpu/drm/vc4/vc4_gem.c
> @@ -723,10 +723,12 @@ vc4_cl_lookup_bos(struct drm_device *dev,
> =20
>  fail_put_bo:
>  	/* Release any reference to acquired objects. */
> -	for (i =3D 0; i < exec->bo_count && exec->bo[i]; i++)
> -		drm_gem_object_put(exec->bo[i]);
> +	if (exec->bo) {
> +		for (i =3D 0; i < exec->bo_count && exec->bo[i]; i++)
> +			drm_gem_object_put(exec->bo[i]);
> =20
> -	kvfree(exec->bo);
> +		kvfree(exec->bo);
> +	}
>  	exec->bo =3D NULL;
>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but there appears to be an off-by-one bounds
check when validating shader records that could allow an out-of-bounds read
past the end of the exec->bo array.

In drivers/gpu/drm/vc4/vc4_validate.c:validate_gl_shader_rec():

    for (i =3D 0; i < shader_reloc_count; i++) {
        if (src_handles[i] > exec->bo_count) {
            DRM_DEBUG("Shader handle %d too big\n", src_handles[i]);
            return -EINVAL;
        }

        bo[i] =3D to_drm_gem_dma_obj(exec->bo[src_handles[i]]);
        if (!bo[i])
            return -EINVAL;
    }

If the handle index provided in src_handles[i] is exactly equal to
exec->bo_count, the check passes, and exec->bo[exec->bo_count] is accessed.

Could this result in an out-of-bounds read and a pointer dereference when
this out-of-bounds value is cast to a drm_gem_dma_object?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626145655.4950=
8-1-vulab@iscas.ac.cn?part=3D1
