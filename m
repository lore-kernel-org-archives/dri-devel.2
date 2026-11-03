Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB48E606A337
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o23K+Bmx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3380B10E736;
	Tue,  3 Nov 2026 01:24:36 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 229B610E736
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 01:24:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D259041500;
 Tue,  3 Nov 2026 01:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAC11F000C1;
 Tue,  3 Nov 2026 01:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793669069;
 bh=I0SMTgf3HweeHjOubXE2vGq4MWKhjTw3uqQaNr4Hfh8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=o23K+BmxJOq4tc0Uvkwg7Bst2xO/Mz7GF0MRK3ij5XlqCI1I/ykiN3t7hZU6N3vHi
 cXAJvuzNPU8+moK2i7HYjbU7DCTnX9HaIO5kmtPY/NnNMxl7zM/jCtebuSWuuCvumu
 3Lf/5ccvmJe0fYF+KPhqB6SBf3Ykt3BEjrmck2LsthA9kqmLbovW6gwi7m6fq1PY1P
 4E2koUnsJHM5HlR/RFbBZhzG8fN57mSVQZlLw445+yx0zIhIVptPBsjR3rWtMvOnNJ
 78v3l1vLCVxOYtM734WFjYd5q6+sv8UKJB45PLVm0JkDg0TRPHrn+l8+5e+MBWg3AF
 OSDBszmCGRUgQ==
Message-ID: <sashiko-outbox-194429@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] drm/msm/a6xx: Import a680 hwcg sequence from kgsl
To: "Val Packett" <val@packett.cool>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261103011358.65398-5-val@packett.cool>
References: <20261103011358.65398-1-val@packett.cool>
 <20261103011358.65398-5-val@packett.cool>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 01:24:29 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/msm/a6xx: out-of-bounds gpu_write() on GMU registers in a680_h=
wcg
--

commit f29e5fbd58a4870ae3b815aaaebc1ea0d6ff115a
Author: Val Packett <val@packett.cool>

drm/msm/a6xx: Import a680 hwcg sequence from kgsl

This commit adds an a680_hwcg register table imported from downstream kgsl
and wires it up to the Adreno 680 GPU catalog entry in place of a640_hwcg.

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/=
msm/adreno/a6xx_catalog.c
> index 6c154792cb077..48197a54984cf 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -9,6 +9,7 @@
>  #include "adreno_gpu.h"
>  #include "a6xx_gpu.h"
>  #include "a6xx.xml.h"
> +#include "a6xx_gmu.xml.h"
> =20
>  static const struct adreno_reglist a612_hwcg[] =3D {
>  	{REG_A6XX_RBBM_CLOCK_CNTL_SP0, 0x22222222},
> @@ -449,6 +450,59 @@ static const struct adreno_reglist a660_hwcg[] =3D {
>  	{},
>  };
> =20
> +static const struct adreno_reglist a680_hwcg[] =3D {

[ ... ]

> +	{REG_A6XX_RBBM_CLOCK_CNTL_GMU_GX, 0x00000222},
> +	{REG_A6XX_RBBM_CLOCK_DELAY_GMU_GX, 0x00000111},
> +	{REG_A6XX_RBBM_CLOCK_HYST_GMU_GX, 0x00000555},
> +	{REG_A6XX_GMU_GX_GMU_SP_RF_CONTROL_0, 0x00000001},
> +	{REG_A6XX_GMU_GX_GMU_SP_RF_CONTROL_1, 0x00000001},

[Severity: High]
Does placing REG_A6XX_GMU_GX_GMU_SP_RF_CONTROL_0 and
REG_A6XX_GMU_GX_GMU_SP_RF_CONTROL_1 into a680_hwcg cause an out-of-bounds
MMIO write past the end of gpu->mmio?

During GPU initialization and suspend (via hw_init() -> a6xx_set_hwcg() and
a6xx_pm_suspend() -> a6xx_set_hwcg()), every entry in the hwcg table is
programmed using gpu_write():

drivers/gpu/drm/msm/adreno/a6xx_gpu.c:a6xx_set_hwcg() {
	...
	for (i =3D 0; (reg =3D &adreno_gpu->info->a6xx->hwcg[i], reg->offset); i++)
		gpu_write(gpu, reg->offset, state ? reg->value : 0);
	...
}

In drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml, these two registers a=
re
GMU registers at dword offsets 0x1a883 and 0x1a884 (byte offsets 0x6a20c and
0x6a210 from the GPU base address).

Unlike downstream kgsl, upstream maps the GPU and GMU register spaces
separately. In arch/arm64/boot/dts/qcom/sc8180x.dtsi, the gpu@2c00000 node's
kgsl_3d0_reg_memory region mapped into gpu->mmio is only 0x40000 bytes:

	gpu@2c00000 {
		...
		reg =3D <0 0x02c00000 0 0x40000>;
		reg-names =3D "kgsl_3d0_reg_memory";

while the GMU registers at 0x02c6a000 are mapped separately into gmu->mmio =
by
gmu@2c6a000 and accessed via gmu_write(), which subtracts gmu->mmio_offset
(0x6a000):

drivers/gpu/drm/msm/adreno/a6xx_gmu.h:
#define GMU_BYTE_OFFSET(gmu, offset) (((offset) << 2) - (gmu)->mmio_offset)
...
static inline void gmu_write(struct a6xx_gmu *gmu, u32 offset, u32 value)
{
	writel(value, gmu->mmio + GMU_BYTE_OFFSET(gmu, offset));
}

When a6xx_set_hwcg() calls gpu_write() with offsets 0x1a883 and 0x1a884, it
writes to gpu->mmio + 0x6a20c and gpu->mmio + 0x6a210, which is 0x2a20c byt=
es
past the end of the 0x40000-byte gpu->mmio mapping. Should these GMU regist=
er
writes be routed through gmu_write() instead of gpu_write()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103011358.6539=
8-1-val@packett.cool?part=3D4
