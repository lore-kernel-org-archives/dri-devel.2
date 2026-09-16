Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097F5C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 00:35:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DED610E08B;
	Wed, 16 Sep 2026 00:35:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FTwhqBjB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0E1310E08B
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 00:35:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D4D1D40A6D;
 Wed, 16 Sep 2026 00:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E5F1F000FF;
 Wed, 16 Sep 2026 00:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789518955;
 bh=qc58WhPumtPlpuEzzwgDcEAKs5EbWbvUnz+WEbrqmNY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FTwhqBjBlaz0d3r8eWP08amy8v5BkCClo721NujHH9qomguKeSjdK0ygJAwwO038D
 Sr0PyyOPbtpwKaCzeX+ORzchPHN+KogrjAGXiIeOJXyDqNnPix986bxjW9C205XE8t
 IRWw2H0Dw87vZ/g4yiF+ruP4Zy1ACniSK/SqkmUmr/aFNhtoi62x5R5+SA5flYFZ0k
 dh/FqkJ+/AKhugo+ouCwuwEWXiuMUfjhiaLiPR9T24cEZbJi8gK/Eb1g5g9Mgf6FTA
 GuSZjwNlxRZixyOl2wRklXZGEex96IijxtayEejQmSftX+pvU5oUhhtzqsfYhDbUG1
 O6SMQlSFPqQdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] drm/nouveau/gsp/r535: Add support for
 MEMSYS_GET_STATIC_CONFIG
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260916001603.22394-3-lyude@redhat.com>
References: <20260916001603.22394-1-lyude@redhat.com>
 <20260916001603.22394-3-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 00:35:55 +0000
Message-Id: <20260916003555.96E5F1F000FF@smtp.kernel.org>
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
- [Medium] nouveau/gsp: r535_gsp_get_static_memsys_info omitted from R535 i=
nit path
--

commit 66ae2756f54f0408a696a11be12bc7b083f1942f
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/gsp/r535: Add support for MEMSYS_GET_STATIC_CONFIG
   =20
This patch introduces a GSP structure describing memory management system
characteristics. It adds code to fetch this structure during driver load
and saves the use_raw_mode_comptagline_alloc flag for later use.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
> index 09b17b85dc1ac..5df5365e744f5 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
[ ... ]
> @@ -1808,6 +1808,23 @@ r535_gsp_fini(struct nvkm_gsp *gsp, enum nvkm_susp=
end_state suspend)
>  	return 0;
>  }
> =20
> +int
> +r535_gsp_get_static_memsys_info(struct nvkm_gsp *gsp)
> +{
> +	NV2080_CTRL_INTERNAL_MEMSYS_GET_STATIC_CONFIG_PARAMS *ctrl;
> +
> +	ctrl =3D nvkm_gsp_rm_ctrl_rd(&gsp->internal.device.subdevice,
> +				    NV2080_CTRL_CMD_INTERNAL_MEMSYS_GET_STATIC_CONFIG,
> +				    sizeof(*ctrl));
> +	if (IS_ERR(ctrl))
> +		return PTR_ERR(ctrl);
> +
> +	gsp->memsys.use_raw_mode_comptagline_alloc =3D ctrl->bUseRawModeComptag=
lineAllocation;
> +
> +	nvkm_gsp_rm_ctrl_done(&gsp->internal.device.subdevice, ctrl);
> +	return 0;
> +}
> +

[Severity: Medium]
Should r535_gsp_get_static_info() in this file also call this function?

The commit message indicates this adds support for R535, but it looks like
this function is only called from r570_gsp_get_static_info() in r570/gsp.c.
Because it is omitted from r535_gsp_get_static_info(), gsp->memsys remains
uninitialized on R535 hardware.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916001603.2239=
4-1-lyude@redhat.com?part=3D2
