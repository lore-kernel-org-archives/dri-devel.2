Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3881C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F6CA10E0F1;
	Tue,  8 Sep 2026 13:37:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Dotc9vbu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EDE510E0F1
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 13:37:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 72F2B601DB;
 Tue,  8 Sep 2026 13:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018851F00ACF;
 Tue,  8 Sep 2026 13:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788874650;
 bh=DEudI5QJBz4swIevmG+FMF7o/96k+Fr5gw2H3onFgzI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Dotc9vbuX/u3VTboP2z9MQ6maamqGSInVQa/lNrzcagIDBrNM4TY/VVTD0/cz4i19
 eTZDylK+c/lsuz66/rVzDB+3XegEz9bTbDzXAaQIuaCSuTcB68nlZvil1YiIj/pV4x
 X9C5HogUqFxg16iGCqkUwB7XXKuNtvybd256+P13/CGYLb7qRqXICTvxTEr+2Eircc
 Q7wHnieOYtA8RskMR0FhoQCFAOr1LQ2mwYsSFUij/uemR7ciBcb9ybzBy+tzMDtIk3
 KYoD4rUrJDiatPmYJP3UJiJdcq61Zqo0GkUMmy4EtsE6a1HcolyuxkoTKV5WbtuMgs
 UvUVXtU52puqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/msm/a6xx: Use CX AO Counter register for
 timestamp on a750 GPUs
To: "Neil Armstrong" <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-2-284880d6e68b@linaro.org>
References: <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-0-284880d6e68b@linaro.org>
 <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-2-284880d6e68b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:37:29 +0000
Message-Id: <20260908133730.018851F00ACF@smtp.kernel.org>
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
- [Critical] The lockless 64-bit counter read loop will spin indefinitely o=
n A750 GPUs, causing a hard CPU hang, because the high and low register off=
sets for the CX AO counter are swapped in their XML definitions.
--

commit cf31c6e4a536e6c06c20aa83c73f0af1762a7d51
Author: Neil Armstrong <neil.armstrong@linaro.org>

drm/msm/a6xx: Use CX AO Counter register for timestamp on a750 GPUs

The a750 uses the CX AO Counters instead of the GMU_ALWAYS_ON_COUNTER
register on A6xx and other A7xx GPUs, use it when running a A750 GPU.

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index f9de9329dee39..081e79ea46528 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -23,9 +23,15 @@ static u64 a6xx_gmu_get_timestamp(struct msm_gpu *gpu)
>  	u64 count_hi, count_lo, temp;
> =20
>  	do {
> -		count_hi =3D gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_H=
);
> -		count_lo =3D gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_L=
);
> -		temp =3D gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_H);
> +		if (adreno_is_a750_family(adreno_gpu)) {
> +			count_hi =3D gmu_read(&a6xx_gpu->gmu, REG_A7XX_GMU_CX_AO_COUNTER_H);
> +			count_lo =3D gmu_read(&a6xx_gpu->gmu, REG_A7XX_GMU_CX_AO_COUNTER_L);
> +			temp =3D gmu_read(&a6xx_gpu->gmu, REG_A7XX_GMU_CX_AO_COUNTER_H);
> +		} else {
> +			count_hi =3D gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_=
H);
> +			count_lo =3D gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_=
L);
> +			temp =3D gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_H);
> +		}
>  	} while (unlikely(count_hi !=3D temp));
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Critical]
Could this cause an infinite loop on A750 GPUs?

In drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml, the register offsets
for the A750 CX AO counter appear to be swapped:

	<reg32 offset=3D"0x1f880" name=3D"GMU_CX_AO_COUNTER_H" variants=3D"A7XX"/>
	<reg32 offset=3D"0x1f881" name=3D"GMU_CX_AO_COUNTER_L" variants=3D"A7XX"/>

Since the H offset points to the lower 32 bits (0x1f880), this loop will
read the fast-changing lower 32 bits into count_hi and temp. Because these
bits change rapidly, won't the comparison (count_hi !=3D temp) almost always
evaluate to true, causing a hard CPU hang in a6xx_gmu_get_timestamp()?

> =20
>  	return (count_hi << 32) | count_lo;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-topic-sm86=
50-gmu-a750-timestamp-reg-v1-0-284880d6e68b@linaro.org?part=3D2
