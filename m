Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AED6F99C7C
	for <dri-devel@archiver.kernel.org>; Sat, 18 Apr 2026 12:12:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B385410E0B9;
	Sat, 18 Apr 2026 12:12:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m1yjrDgC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4160C10E0B9;
 Sat, 18 Apr 2026 12:12:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D1C3A43832;
 Sat, 18 Apr 2026 12:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DDCC19424;
 Sat, 18 Apr 2026 12:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776514349;
 bh=b9PenJjHaSudWajbzycGmt+Iph3cnRU02bJt70Fh7Eg=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=m1yjrDgC2Vp3S9i2v6ibSL2JFghRG5C7W0hZT+LalgTRV1d7OnryWOSB6nnndhnYp
 dCbOL2num5eSmqu1bDi587r/2SOMZZa1nqWxhLf7M7JjN94lkCjoVu93rtzCfiuyzO
 NrF+DTMCzFGk+MYZGmNkqPxPJR+4SfVS4d7MdRsFaZuPBJoj53dseGveTtyZHtHA5e
 NKuYe8ftmP7kAh+2zEn9XPYZOL/ffb/0+53Ko/kcS2f4XDAplXWcFI2Ca0k5t57/xE
 CckFwhX1B9mrP2MOo7YpWRCfuj+3OuukgNtaYIFU785F7YAIjUnmC3XCOP4qKcb0pF
 Xg5ix46JWpC5A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Apr 2026 14:12:25 +0200
Message-Id: <DHW9RZVWDN6Y.2G2RKSJMF5ESB@kernel.org>
Subject: Re: [PATCH] drm/nouveau/gsp:  Fix possible NULL pointer dereference
 warning in r535_dmac_alloc
Cc: <lyude@redhat.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "sunliming" <sunliming@kylinos.cn>
To: <sunliming@linux.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260418071412.86022-1-sunliming@linux.dev>
In-Reply-To: <20260418071412.86022-1-sunliming@linux.dev>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Sat Apr 18, 2026 at 9:14 AM CEST, sunliming wrote:
> From: sunliming <sunliming@kylinos.cn>
>
> Fix below smatch warnings:
> drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c:178 r535_dmac_allo=
c()
> warn: 'args' can also be NULL

Please write a commit description that explains also the underlying problem=
; see
more below.

> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/dri=
vers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> index 6e63df816d85..6dec2623d0be 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> @@ -172,6 +172,8 @@ r535_dmac_alloc(struct nvkm_disp *disp, u32 oclass, i=
nt inst, u32 put_offset,
> =20
>  	args =3D nvkm_gsp_rm_alloc_get(&disp->rm.object, (oclass << 16) | inst,=
 oclass,
>  				     sizeof(*args), dmac);
> +	if (!args)
> +		return -ENOMEM;

Are we sure that this can ever return NULL in the first place? I know that
nvkm_gsp_rm_alloc_get() internally checks for IS_ERR_OR_NULL(), but I could=
n't
find anything within the callchain that would actually return NULL.

That said, I think IS_ERR_OR_NULL() checks are misleading.

>  	if (IS_ERR(args))
>  		return PTR_ERR(args);
> =20
> --=20
> 2.25.1

