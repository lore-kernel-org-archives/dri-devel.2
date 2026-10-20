Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3019606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 23:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRcOeKWx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51C4C10F828;
	Tue, 20 Oct 2026 23:32:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4D2910F828
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 23:32:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F0EAC60098;
 Tue, 20 Oct 2026 23:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9612A1F000C9;
 Tue, 20 Oct 2026 23:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792539165;
 bh=C2dumep2h27WcmVNcIrC4Ex9A/Y7o+jroZHFYn83H1I=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=RRcOeKWxqarRbb2irxaE6PCdp9mn5Vi4XKGnRc88Gl4zECkgQvBV8zO98V2Pz3vnU
 y7+60K3+8dXHzk2XDfPU7jVrX6QXY9kOBenBO40yH90GKh+DWbHUHZr1uZHmLwHqTb
 +Hwj6/oKjaNbyby26A+xG1mVCDz6n0f+mKoZWdYJNpeCjJpYJ1qjnUdbjWQVVztOds
 GUUl6zkWIYuROR1Ch/wfF8O/EUbwPPSwJ4ViMO1VM38jLO32PlnOcrjWVggh2NFZZ1
 3BsVrfmTT/JVnlSAjgUumzyWWVcJGf8ExlDdUVqFWPbWM8UvAomEqkKaUV8hhUOMJA
 P7nqe6/mCcZKA==
Message-ID: <sashiko-outbox-179605@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/12] drm/msm/a8xx: Switch to generated nonctx regs
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261020204728.28844-11-robin.clark@oss.qualcomm.com>
References: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
 <20261020204728.28844-11-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 23:32:45 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/msm/a8xx: a8xx_nonctxt_config() clobbers LLCC SCID in GBIF_S=
CACHE_CNTL0
- [Medium] drm/msm/a8xx: nonctxt_reglist clobbers CX GBIF config in a8xx_no=
nctxt_config()
--

commit 966abf648e13ba76b4165851da9f6e5975e5c769
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/a8xx: Switch to generated nonctx regs

This commit removes the hand-maintained non-context register tables in
drivers/gpu/drm/msm/adreno/a8xx_catalog.c and switches the A8xx GPU catalog
entries to use the generated non-context register lists from the catalog
headers.

> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/=
msm/adreno/a8xx_catalog.c
> index 15fc10d5db688..bc79013165c13 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c

[ ... ]

> @@ -1556,7 +1216,7 @@ static const struct adreno_info a8xx_gpus[] =3D {
>  		.funcs =3D &a8xx_gpu_funcs,
>  		.a6xx =3D &(const struct a6xx_info) {
>  			.protect =3D &a830_protect,
> -			.nonctxt_reglist =3D a830_nonctxt_regs,
> +			.nonctxt_reglist =3D pakala_nonctxt_regs,
>  			.pwrup_reglist =3D &a830_pwrup_reglist,
>  			.dyn_pwrup_reglist =3D &a830_dyn_pwrup_reglist,
>  			.ifpc_reglist =3D &a830_ifpc_reglist,

[Severity: Medium]
Will switching .nonctxt_reglist in a8xx_gpus to pakala_nonctxt_regs (and the
other generated *_nonctxt_regs tables) cause a8xx_nonctxt_config() to clobb=
er
the LLCC slice IDs in REG_A6XX_GBIF_SCACHE_CNTL0?

In drivers/gpu/drm/msm/adreno/catalog/adreno_pakala.h (as well as the
glymur_nonctxt_regs, kaanapali_nonctxt_regs, milos_nonctxt_regs,
maili_nonctxt_regs, and hawi_nonctxt_regs tables), the generated list
includes:

	{ 0x00003c01 /* GBIF_SCACHE_CNTL0                   */, 0x00000100, BIT(PI=
PE_NONE) },

On initial GPU load (adreno_load_gpu()), job submission after runtime suspe=
nd
(msm_gpu_submit()), or recovery (a8xx_recover()), pm_runtime_get_sync() runs
adreno_runtime_resume() -> a6xx_gmu_pm_resume() in
drivers/gpu/drm/msm/adreno/a6xx_gpu.c:

	gpu->needs_hw_init =3D true;
	...
	if (adreno_is_a8xx(adreno_gpu))
		a8xx_llc_activate(a6xx_gpu);

In drivers/gpu/drm/msm/adreno/a8xx_gpu.c, a8xx_llc_activate() programs the
system cache slice ID into REG_A6XX_GBIF_SCACHE_CNTL0 (0x3c01):

	gpu_write(gpu, REG_A6XX_GBIF_SCACHE_CNTL0,
		  FIELD_PREP(GENMASK(27, 22), gpu_scid) |
		  FIELD_PREP(GENMASK(21, 16), gpu_scid) |
		  FIELD_PREP(GENMASK(15, 10), gpu_scid) |
		  BIT(8));

Immediately afterwards, msm_gpu_hw_init() sees gpu->needs_hw_init =3D=3D tr=
ue and
calls a8xx_hw_init() -> hw_init() -> a8xx_nonctxt_config(), which executes:

	gpu_write(gpu, regs[i].offset, regs[i].value);

Because 0x00003c01 is in info->nonctxt_reglist with value 0x00000100,
wouldn't this overwrite REG_A6XX_GBIF_SCACHE_CNTL0 and zero out the gpu_scid
fields in bits [27:10] on every hardware init?

> @@ -1601,7 +1261,7 @@ static const struct adreno_info a8xx_gpus[] =3D {
>  		.funcs =3D &a8xx_gpu_funcs,
>  		.a6xx =3D &(const struct a6xx_info) {
>  			.protect =3D &x285_protect,
> -			.nonctxt_reglist =3D x285_nonctxt_regs,
> +			.nonctxt_reglist =3D glymur_nonctxt_regs,
>  			.pwrup_reglist =3D &a840_pwrup_reglist,
>  			.dyn_pwrup_reglist =3D &x285_dyn_pwrup_reglist,
>  			.ifpc_reglist =3D &a840_ifpc_reglist,
> @@ -1646,7 +1306,7 @@ static const struct adreno_info a8xx_gpus[] =3D {
>  		.funcs =3D &a8xx_gpu_funcs,
>  		.a6xx =3D &(const struct a6xx_info) {
>  			.protect =3D &a840_protect,
> -			.nonctxt_reglist =3D a840_nonctxt_regs,
> +			.nonctxt_reglist =3D kaanapali_nonctxt_regs,
>  			.pwrup_reglist =3D &a840_pwrup_reglist,
>  			.dyn_pwrup_reglist =3D &a840_dyn_pwrup_reglist,
>  			.ifpc_reglist =3D &a840_ifpc_reglist,
> @@ -1692,7 +1352,7 @@ static const struct adreno_info a8xx_gpus[] =3D {
>  		.zapfw =3D "gen80300_zap.mbn",
>  		.a6xx =3D &(const struct a6xx_info) {
>  			.protect =3D &a810_protect,
> -			.nonctxt_reglist =3D a810_nonctxt_regs,
> +			.nonctxt_reglist =3D milos_nonctxt_regs,
>  			.pwrup_reglist =3D &a810_pwrup_reglist,
>  			.dyn_pwrup_reglist =3D &a810_dyn_pwrup_reglist,
>  			.ifpc_reglist =3D &a810_ifpc_reglist,
> @@ -1735,7 +1395,7 @@ static const struct adreno_info a8xx_gpus[] =3D {
>  		.funcs =3D &a8xx_gpu_funcs,
>  		.a6xx =3D &(const struct a6xx_info) {
>  			.protect =3D &x285_protect,
> -			.nonctxt_reglist =3D x285_nonctxt_regs,
> +			.nonctxt_reglist =3D glymur_nonctxt_regs,
>  			.pwrup_reglist =3D &a840_pwrup_reglist,
>  			.dyn_pwrup_reglist =3D &x285_dyn_pwrup_reglist,
>  			.ifpc_reglist =3D &a840_ifpc_reglist,
> @@ -1778,7 +1438,7 @@ static const struct adreno_info a8xx_gpus[] =3D {
>  		.funcs =3D &a8xx_gpu_funcs,
>  		.a6xx =3D &(const struct a6xx_info) {
>  			.protect =3D &a850_protect,
> -			.nonctxt_reglist =3D a845_nonctxt_regs,
> +			.nonctxt_reglist =3D maili_nonctxt_regs,
>  			.pwrup_reglist =3D &a850_pwrup_reglist,
>  			.dyn_pwrup_reglist =3D &a850_dyn_pwrup_reglist,
>  			.ifpc_reglist =3D &a850_ifpc_reglist,
> @@ -1822,7 +1482,7 @@ static const struct adreno_info a8xx_gpus[] =3D {
>  		.funcs =3D &a8xx_gpu_funcs,
>  		.a6xx =3D &(const struct a6xx_info) {
>  			.protect =3D &a850_protect,
> -			.nonctxt_reglist =3D a850_nonctxt_regs,
> +			.nonctxt_reglist =3D hawi_nonctxt_regs,
>  			.pwrup_reglist =3D &a850_pwrup_reglist,
>  			.dyn_pwrup_reglist =3D &a850_dyn_pwrup_reglist,
>  			.ifpc_reglist =3D &a850_ifpc_reglist,

[Severity: Medium]
Should the CX GBIF registers (0x3c00..0x3c45) in the generated *_nonctxt_re=
gs
tables also be excluded or handled separately in a8xx_nonctxt_config()?

Unlike the previous hand-maintained nonctxt_regs arrays in
drivers/gpu/drm/msm/adreno/a8xx_catalog.c, all six generated *_nonctxt_regs
tables include CX GBIF entries:

	{ 0x00003c00 /* GBIF_CX_CONFIG                      */, 0x20023020, BIT(PI=
PE_NONE) },
	{ 0x00003c01 /* GBIF_SCACHE_CNTL0                   */, 0x00000100, BIT(PI=
PE_NONE) },
	{ 0x00003c03 /* GBIF_QSB_SIDE0                      */, 0x00071e20, BIT(PI=
PE_NONE) },
	{ 0x00003c04 /* GBIF_QSB_SIDE1                      */, 0x00071e20, BIT(PI=
PE_NONE) },
	{ 0x00003c05 /* GBIF_QSB_SIDE2                      */, 0x00071e20, BIT(PI=
PE_NONE) },
	{ 0x00003c06 /* GBIF_QSB_SIDE3                      */, 0x00071e20, BIT(PI=
PE_NONE) },
	{ 0x00003c45 /* GBIF_HALT                           */, 0x00000008, BIT(PI=
PE_NONE) },

During resume, a6xx_gmu_pm_resume() -> a6xx_gmu_resume() ->
a6xx_gmu_fw_start() configures gbif_cx and boots the GMU (which enables clo=
ck
gating in REG_A6XX_GBIF_CX_CONFIG BIT(0), as noted in a8xx_set_hwcg() in
drivers/gpu/drm/msm/adreno/a8xx_gpu.c):

	/*
	 * GMU enables clk gating in GBIF during boot up. So,
	 * override that here when hwcg feature is disabled
	 */
	gpu_rmw(gpu, REG_A6XX_GBIF_CX_CONFIG, BIT(0), 0);

Then in drivers/gpu/drm/msm/adreno/a8xx_gpu.c, hw_init() explicitly clears
REG_A6XX_GBIF_HALT before calling a8xx_nonctxt_config():

	/* Clear GBIF halt in case GX domain was not collapsed */
	gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
	gpu_read(gpu, REG_A6XX_GBIF_HALT);
	...
	a8xx_nonctxt_config(gpu);

When a8xx_nonctxt_config() subsequently writes the generated nonctxt_reglis=
t,
could writing 0x20023020 to REG_A6XX_GBIF_CX_CONFIG (0x3c00) clear BIT(0)
that the GMU enabled on boot, and could writing 0x00000008 to
REG_A6XX_GBIF_HALT (0x3c45) undo the earlier clear in hw_init() in addition
to overwriting REG_A6XX_GBIF_SCACHE_CNTL0 (0x3c01)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020204728.2884=
4-1-robin.clark@oss.qualcomm.com?part=3D10
