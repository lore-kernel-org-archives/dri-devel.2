Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB309EA71B3
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 01:09:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08F6110E08D;
	Mon, 20 Apr 2026 01:09:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="Osnvv86a";
	dkim-atps=neutral
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com
 [95.215.58.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0D0610E08D
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 01:09:49 +0000 (UTC)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1776647386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2YIChuj/xzLlQ/FzRUUTT1CABmjJDTZrcYGppYIN00M=;
 b=Osnvv86aI+Uh5BzJC5hmnoa8du5qawpLCVeUsnt1WOt4bC/rdDmh/iwaqs/Jh9o7d7Z/un
 AdlWG14Z8dClDR22HHqXniw02WVikVTXKlGRUH3G0mW9gePH+U/j8GK8QA3unPUAVeEnWq
 BjtktXDH5d1lxOMdDHQAZdzz9WfOzAA=
Date: Mon, 20 Apr 2026 01:09:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: sunliming@linux.dev
Message-ID: <ea7bdf986e2c50c52d63de1d76eba3ca8c65ae17@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] drm/nouveau/gsp: Fix possible NULL pointer dereference
 warning in r535_dmac_alloc
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: lyude@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, "sunliming" <sunliming@kylinos.cn>
In-Reply-To: <DHW9RZVWDN6Y.2G2RKSJMF5ESB@kernel.org>
References: <20260418071412.86022-1-sunliming@linux.dev>
 <DHW9RZVWDN6Y.2G2RKSJMF5ESB@kernel.org>
X-Migadu-Flow: FLOW_OUT
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

2026=E5=B9=B44=E6=9C=8818=E6=97=A5 20:12, "Danilo Krummrich" <dakr@kernel=
.org mailto:dakr@kernel.org?to=3D%22Danilo%20Krummrich%22%20%3Cdakr%40ker=
nel.org%3E > =E5=86=99=E5=88=B0:


>=20
>=20On Sat Apr 18, 2026 at 9:14 AM CEST, sunliming wrote:
>=20
>=20>=20
>=20> From: sunliming <sunliming@kylinos.cn>
> >=20
>=20>  Fix below smatch warnings:
> >  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c:178 r535_dmac=
_alloc()
> >  warn: 'args' can also be NULL
> >=20
>=20Please write a commit description that explains also the underlying p=
roblem; see
> more below.
>=20
>=20>=20
>=20> Signed-off-by: sunliming <sunliming@kylinos.cn>
> >  ---
> >  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
>=20>  diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.=
c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> >  index 6e63df816d85..6dec2623d0be 100644
> >  --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> >  +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> >  @@ -172,6 +172,8 @@ r535_dmac_alloc(struct nvkm_disp *disp, u32 ocla=
ss, int inst, u32 put_offset,
> >=20=20
>=20>  args =3D nvkm_gsp_rm_alloc_get(&disp->rm.object, (oclass << 16) | =
inst, oclass,
> >  sizeof(*args), dmac);
> >  + if (!args)
> >  + return -ENOMEM;
> >=20
>=20Are we sure that this can ever return NULL in the first place? I know=
 that
> nvkm_gsp_rm_alloc_get() internally checks for IS_ERR_OR_NULL(), but I c=
ouldn't
> find anything within the callchain that would actually return NULL.
>=20
>=20That said, I think IS_ERR_OR_NULL() checks are misleading.
>=20
I=20also believe that the nvkm_gsp_rm_alloc_get function will not return =
NULL. My patch=20
was=20merely intended to suppress a compiler warning and to guard against=
 possible future=20
changes=20in the implementation of nvkm_gsp_rm_alloc_get. Of course, the =
patch may be=20
unnecessary,=20and I will defer to the maintainers' review conclusion.

Thanks.
> >=20
>=20> if (IS_ERR(args))
> >  return PTR_ERR(args);
> >=20=20
>=20>  --=20
>=20>  2.25.1
> >
>
