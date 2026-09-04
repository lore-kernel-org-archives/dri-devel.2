Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB33C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A26610F910;
	Fri,  4 Sep 2026 08:03:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JX1onWhG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55C2910E547
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 08:03:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 768F060211;
 Fri,  4 Sep 2026 08:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1651F00A3D;
 Fri,  4 Sep 2026 08:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788509002;
 bh=s/zSK9glIZgaFavTSPNYXa7U6OoG5C31lrRAZTpFKNM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JX1onWhGrn8yxZQlI4CcfGk1Co/Ts8c37PwXDDg2T+jC54nLUaTpp090KAzSaKW3J
 tmo/kKR5GYiNERbc5KkAkg9Y95BFv92UmfQjFAmEEEeiopDVd9EPzxw4I1IZmBLShg
 unCF4IrawZqXg7CgeorqOZO4K9lg18yIVi5GYwDkaKPe6lJFy3yQjD5vyysnkqYfJ2
 4cqJYB0IpWU02C21TF2jttWzRfX8SHt8fZyr3TTB7JbxHOd/xSOCdFSCeRdMDbUDn0
 JOnih7BeB3GqnM+WTdXZE1REQgm1058SV44yVg+nnGeqndHduL7M5zQM9e9spAJfp8
 4EL54/ab+gkBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/13] drm/imx: dc-ed: Drop initial source selection
To: "Liu Ying" <victor.liu@nxp.com>
Cc: robh@kernel.org, imx@lists.linux.dev, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Frank.Li@kernel.org
In-Reply-To: <20260904-imx8-dc-prefetch-v6-10-26643e3f6cb7@nxp.com>
References: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
 <20260904-imx8-dc-prefetch-v6-10-26643e3f6cb7@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 08:03:21 +0000
Message-Id: <20260904080321.BD1651F00A3D@smtp.kernel.org>
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
- [High] Unconditional dereference of potentially NULL component pointers d=
uring pixel engine runtime resume.
--

commit 0e56cfa8da82fa905cb37a791e64c203dd9bf7e5
Author: Liu Ying <victor.liu@nxp.com>

drm/imx: dc-ed: Drop initial source selection

It's unnecessary to set initial ExtDst source selection because KMS
driver would do that when doing atomic commits.

> diff --git a/drivers/gpu/drm/imx/dc/dc-ed.c b/drivers/gpu/drm/imx/dc/dc-e=
d.c
> index b8ab41271bb40..803b3e891a1e6 100644
> --- a/drivers/gpu/drm/imx/dc/dc-ed.c
> +++ b/drivers/gpu/drm/imx/dc/dc-ed.c
> @@ -202,7 +202,6 @@ static inline void dc_ed_disable_gamma_apply(struct d=
c_ed *ed)
> =20
>  void dc_ed_init(struct dc_ed *ed)
>  {
> -	dc_ed_pec_src_sel(ed, LINK_ID_NONE);
>  	dc_ed_pec_enable_shden(ed);

[Severity: High]
This is a pre-existing issue, but does this function dereference the ed poi=
nter
without checking if it's NULL?

Looking at dc_pe_runtime_resume() in drivers/gpu/drm/imx/dc/dc-pe.c, it
unconditionally loops over fixed-size arrays:

    for (i =3D 0; i < ARRAY_SIZE(pe->ed_safe); i++)
        dc_ed_init(pe->ed_safe[i]);

    for (i =3D 0; i < ARRAY_SIZE(pe->ed_cont); i++)
        dc_ed_init(pe->ed_cont[i]);

    for (i =3D 0; i < ARRAY_SIZE(pe->fu_disp); i++)
        pe->fu_disp[i]->ops.init(pe->fu_disp[i]);

If any sub-component of the display pipeline (such as extdst, constframe, o=
r fu)
is marked as status =3D "disabled" in the device tree, the component master=
 in
dc-drv.c uses for_each_available_child_of_node() and only binds the availab=
le
components.

The pointers corresponding to disabled components remain NULL. When
dc_pe_runtime_resume() executes, it passes these NULL pointers to initializ=
ation
functions like dc_ed_init(), which immediately dereferences them when calli=
ng
dc_ed_pec_enable_shden(). It also directly dereferences them when calling
pe->fu_disp[i]->ops.init().

Disabling unused display pipes in the device tree is a standard configurati=
on
practice for generic SoCs, but doing so appears to cause a kernel panic here
during device runtime resume.

>  	dc_ed_pec_poweron(ed);
>  	dc_ed_pec_sync_mode_single(ed);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-imx8-dc-pr=
efetch-v6-0-26643e3f6cb7@nxp.com?part=3D10
