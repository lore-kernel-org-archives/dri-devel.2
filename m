Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E0DC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52AE210E33F;
	Tue, 15 Sep 2026 21:17:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="No2xhNuf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA37310E33F
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 21:17:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 935EA4140B;
 Tue, 15 Sep 2026 21:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8211F000FF;
 Tue, 15 Sep 2026 21:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789507068;
 bh=BgIH+Cayi0pU4sF0OX9E7Saist6XGoo0PHsJ77Kx+II=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=No2xhNuf4+oTJHRZ2SZNsO2Z2rJhFOEYIOAxTOD2JTBsLGxsWrTlQ8b6yUnr6hnsa
 jXayZS7eVqLFGFKhwOMOyqldLq4wVUZuVjJjXBbwts1r3p+dkiWu/kqqGlWEpmI5Qk
 4B/BIPS4XcgMq5GWh/AG4O967ZX9fcFC4DTQ7AgzOEEBeEw1ALn6Vy41BKT6LVD83W
 5enSow7scFqRssvetTWZUdqCYPBW0t0bcBsO5vKfTLnZiTDM3wdI770kbvFC3gr5X5
 TDAQoZzdRSP5lD/3z4gkG2mPTn228tj2HqWdEp1/jpCZSIMr5R9FO3HxRT6okziHie
 1dNtKhfTG27aQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] drm/nouveau/gsp/r535: Add support for
 MEMSYS_GET_STATIC_CONFIG
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260915210647.695187-3-lyude@redhat.com>
References: <20260915210647.695187-1-lyude@redhat.com>
 <20260915210647.695187-3-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 21:17:47 +0000
Message-Id: <20260915211748.4C8211F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/nouveau/gsp: read of uninitialized memory in r535_gsp_get_stat=
ic_memsys_info
- [Medium] drm/nouveau/gsp: r535_gsp_get_static_memsys_info is never called=
 for R535 initialization
--

commit 2fa837b461b49fefa7883b5628782713aaf7bd67
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/gsp/r535: Add support for MEMSYS_GET_STATIC_CONFIG
   =20
This is a GSP structure describing various characteristics of the memory
management system that GSP provides. Start by fetching it during driver
load, but don't do anything with the information we get from it just yet.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
> index 09b17b85dc1ac..c57a3250d6b96 100644
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
> +	ctrl =3D nvkm_gsp_rm_ctrl_get(&gsp->internal.device.subdevice,
> +				    NV2080_CTRL_CMD_INTERNAL_MEMSYS_GET_STATIC_CONFIG,
> +				    sizeof(*ctrl));
> +	if (IS_ERR(ctrl))
> +		return PTR_ERR(ctrl);
> +
> +	gsp->memsys.use_raw_mode_comptagline_alloc =3D ctrl->bUseRawModeComptag=
lineAllocation;

[Severity: High]
Does this read from uninitialized memory?

The nvkm_gsp_rm_ctrl_get() function only allocates the RPC payload buffer,
but it doesn't execute the command. This reads from the buffer without push=
ing
it to the firmware (e.g. using nvkm_gsp_rm_ctrl_push() or nvkm_gsp_rm_ctrl_=
rd()).

Without executing the command, does it just read the uninitialized or zeroed
buffer memory?

> +
> +	nvkm_gsp_rm_ctrl_done(&gsp->internal.device.subdevice, ctrl);
> +	return 0;
> +}
> +
[ ... ]
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> index b45781cd0dfdc..5a51fe7e5ab98 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> @@ -137,6 +137,14 @@ r570_gsp_get_static_info(struct nvkm_gsp *gsp)
>  		}
>  	}
> =20
> +	ret =3D r535_gsp_get_static_memsys_info(gsp);
> +	if (ret) {
> +		nvkm_error(&gsp->subdev, "Retrieving static memsys info failed\n");
> +		return ret;
> +	}
> +	nvkm_debug(&gsp->subdev, "memsys: Use raw mode for comptag allocations?=
 %s\n",
> +		   str_yes_no(gsp->memsys.use_raw_mode_comptagline_alloc));
> +

[Severity: Medium]
Is r535_gsp_get_static_memsys_info() missing a call in the r535 initializat=
ion?

This adds the call to r570_gsp_get_static_info() here, but I don't see a
similar call added to r535_gsp_get_static_info() in r535/gsp.c, even though
the commit message mentions adding support for r535.

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915210647.6951=
87-1-lyude@redhat.com?part=3D2
