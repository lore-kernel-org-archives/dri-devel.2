Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9497B606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eEoJaKOF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B8110F836;
	Tue, 20 Oct 2026 23:41:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA7A810F836
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 23:41:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EA22F60142;
 Tue, 20 Oct 2026 23:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBDD1F000CB;
 Tue, 20 Oct 2026 23:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792539702;
 bh=pik+2O93N/KOKNEP3aRbIOyg23tkfUZjQkDx7wBWA0o=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=eEoJaKOFB94x/uQI2NUNMB6omFdFZKEa8aEdzpK/h5zmJR1J6Id9HJfV77DidrxNT
 AdivcgHP1Ypa4qeaLmBBIl6C79B82bWojZlIZdNe7aTuByAl7R7aROHqc7uQjlvkbv
 WU0o9MweeA0/zk7SmKKF7Q3Yucgt5U6xI7bVjr+QWWavDNWANfb18FBR4uIplpyMvC
 8tS7IxKe5GdfG/AvLo2MKG5qT1ZV2RkV/8quQ4iGeHC/LJNNkFHr/IR1aDXemxz4rj
 TKPvSoJ0gkQp+PdskS53o3BGSbc7dz5OaSxyJ7twmluY4WNlFS9nO+h88jkmygrKEv
 Z/6H9ZwPX8Q0Q==
Message-ID: <sashiko-outbox-179609@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/12] drm/msm/a8xx: Switch to generated protect regs
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261020204728.28844-12-robin.clark@oss.qualcomm.com>
References: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
 <20261020204728.28844-12-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 23:41:42 +0000
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
- [High] drm/msm/a8xx: wrong protect table pakala_protect used for Kaanapali
- [High] drm/msm/a8xx: missing CP_PROTECT_GLOBAL(56..62) in a850_ifpc_regli=
st_regs
--

commit 552d3a60893e50e06127da749c3d585e911f2b2e
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/a8xx: Switch to generated protect regs

This commit replaces the hardcoded protect register tables in
a8xx_catalog.c with the generated protect tables from the per-target
catalog headers.

> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/=
msm/adreno/a8xx_catalog.c
> index bc79013165c13..5f5f71d86df93 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c

[ ... ]

> @@ -1305,7 +1026,7 @@ static const struct adreno_info a8xx_gpus[] =3D {
>  			  ADRENO_QUIRK_IFPC,
>  		.funcs =3D &a8xx_gpu_funcs,
>  		.a6xx =3D &(const struct a6xx_info) {
> -			.protect =3D &a840_protect,
> +			.protect =3D &pakala_protect,
>  			.nonctxt_reglist =3D kaanapali_nonctxt_regs,
>  			.pwrup_reglist =3D &a840_pwrup_reglist,
>  			.dyn_pwrup_reglist =3D &a840_dyn_pwrup_reglist,

[Severity: High]
Should the Kaanapali (Adreno 840, 0x44050a01) entry in a8xx_gpus[] use
&kaanapali_protect instead of &pakala_protect?

__build_asserts() checks kaanapali_protect, which is defined in
drivers/gpu/drm/msm/adreno/catalog/adreno_kaanapali.h, but kaanapali_protect
is left unused in a8xx_gpus[].

When hw_init() -> a8xx_set_cp_protect() programs the protection registers
from pakala_protect_regs on Kaanapali, several Kaanapali-specific spans from
kaanapali_protect_regs (including 0x00775..0x0077f, 0x00c07..0x00c0f,
0x03d00..0x05cff, 0x0a82e, 0x0aed0..0x0b17f, and 0x1fd80..0x1ffff) are left
unprotected against unprivileged userspace command streams, while
0x00000..0x00007 and 0x27c02..0x27c05 are protected instead.

[ ... ]

> @@ -1481,7 +1202,7 @@ static const struct adreno_info a8xx_gpus[] =3D {
>  			  ADRENO_QUIRK_IFPC,
>  		.funcs =3D &a8xx_gpu_funcs,
>  		.a6xx =3D &(const struct a6xx_info) {
> -			.protect =3D &a850_protect,
> +			.protect =3D &hawi_protect,
>  			.nonctxt_reglist =3D hawi_nonctxt_regs,
>  			.pwrup_reglist =3D &a850_pwrup_reglist,
>  			.dyn_pwrup_reglist =3D &a850_dyn_pwrup_reglist,

[Severity: High]
Does switching Hawi (Adreno 850, 0x44051401) to hawi_protect without
updating a850_ifpc_reglist_regs cause REG_A8XX_CP_PROTECT_GLOBAL(56) through
REG_A8XX_CP_PROTECT_GLOBAL(62) to be lost across inter-frame power collapse?

Previously, a850_protect_regs had 57 entries, and a850_ifpc_reglist_regs
omitted REG_A8XX_CP_PROTECT_GLOBAL(56) through
REG_A8XX_CP_PROTECT_GLOBAL(62):

drivers/gpu/drm/msm/adreno/a8xx_catalog.c:
static const u32 a850_ifpc_reglist_regs[] =3D {
	...
	REG_A8XX_CP_PROTECT_GLOBAL(54),
	REG_A8XX_CP_PROTECT_GLOBAL(55),
	REG_A8XX_CP_PROTECT_GLOBAL(63),
};

In drivers/gpu/drm/msm/adreno/catalog/adreno_hawi.h, hawi_protect_regs has
64 entries, so hw_init() -> a8xx_set_cp_protect() populates all 64
REG_A8XX_CP_PROTECT_GLOBAL(0..63) registers:

drivers/gpu/drm/msm/adreno/catalog/adreno_hawi.h:
static const u32 hawi_protect_regs[] __maybe_unused =3D {
	...
	A6XX_PROTECT_NORDWR(0x1ac00, 0x1fff),
	A6XX_PROTECT_NORDWR(0x1f400, 0x0477),
	A6XX_PROTECT_NORDWR(0x1f930, 0x032f),
	A6XX_PROTECT_NORDWR(0x1fd80, 0x1fff),
	A6XX_PROTECT_NORDWR(0x27800, 0x007f),
	A6XX_PROTECT_RDONLY(0x27880, 0x0001),
	A6XX_PROTECT_NORDWR(0x27882, 0x037d),
	A6XX_PROTECT_NORDWR(0x27c06, 0x0000),
};
DECLARE_ADRENO_PROTECT(hawi_protect, 64);

Because Hawi sets ADRENO_QUIRK_IFPC and uses a850_ifpc_reglist in
a8xx_patch_pwrup_reglist(), those 7 protection registers (covering ranges in
0x1ac00..0x27bff) will not be restored after inter-frame power collapse.

> @@ -1516,6 +1237,10 @@ DECLARE_ADRENO_GPULIST(a8xx);
> =20
>  static inline __always_unused void __build_asserts(void)
>  {
> -	BUILD_BUG_ON(a810_protect.count > a810_protect.count_max);
> -	BUILD_BUG_ON(a830_protect.count > a830_protect.count_max);
> +	BUILD_BUG_ON(glymur_protect.count > glymur_protect.count_max);
> +	BUILD_BUG_ON(hawi_protect.count > hawi_protect.count_max);
> +	BUILD_BUG_ON(kaanapali_protect.count > kaanapali_protect.count_max);
> +	BUILD_BUG_ON(maili_protect.count > maili_protect.count_max);
> +	BUILD_BUG_ON(milos_protect.count > milos_protect.count_max);
> +	BUILD_BUG_ON(pakala_protect.count > pakala_protect.count_max);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020204728.2884=
4-1-robin.clark@oss.qualcomm.com?part=3D11
