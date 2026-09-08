Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2986C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E6C510EBF4;
	Tue,  8 Sep 2026 13:38:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UI2Z+D2u";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88D8610EBED
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 13:38:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4398843928;
 Tue,  8 Sep 2026 13:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13291F00ACA;
 Tue,  8 Sep 2026 13:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788874681;
 bh=cQAoha+EUysAxuCKTR/LsmYwQGUI8Rbcih+rWQYoX0A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UI2Z+D2uCBVDJW53yI3xI6lYli4U13JtwlaCuY3ZLd25U7HHeg/22wI1L7j81cYBQ
 hn3dUA3DP/INA+46eHNtOQlc3dpiG0GiGey5RU5WVP6lcInCv/f3/7I9OaGCxn6g8H
 5/zNQE3/NX7bizwjYdFO9sHz/TdBZMncY983AsqwwNe5+4kL8+bCgjZ+zckrUa5z4v
 YAIIdo+yKdNLNII8tlGmMCh4AJbt3U2PhnCVCXKc/IE04WARilNx45g+JV4L/oVsR0
 1Jk1Q12Px4deUdW1vcg/8fxnM30bIXqLx7R2TeNXCZ/B8EfTK0qNTVoGQtuytclX3b
 wy6fObUKpsb5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/msm/a6xx: Add CX AO Counter registers used for
 a750 GPUs
To: "Neil Armstrong" <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-1-284880d6e68b@linaro.org>
References: <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-0-284880d6e68b@linaro.org>
 <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-1-284880d6e68b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:38:00 +0000
Message-Id: <20260908133800.F13291F00ACA@smtp.kernel.org>
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
- [High] Swapped _H and _L register offsets for GMU_CX_AO_COUNTER cause inc=
orrect timestamp calculation and potential infinite loop.
--

commit 6a7904eb81671357880e41c095c0516fdc10e669
Author: Neil Armstrong <neil.armstrong@linaro.org>

drm/msm/a6xx: Add CX AO Counter registers used for a750 GPUs

This commit adds the CX AO Counters to the a6xx GMU XML definitions for
use on a750 GPUs. These replace the GMU_ALWAYS_ON_COUNTER register used
on other A6xx and A7xx variants.

> diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml b/drivers/=
gpu/drm/msm/registers/adreno/a6xx_gmu.xml
> index 33404eb18fd02..3fe7bc3ea93d1 100644
> --- a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
> +++ b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
> @@ -141,6 +141,8 @@ xsi:schemaLocation=3D"https://gitlab.freedesktop.org/=
freedreno/ rules-fd.xsd">
>  	<reg32 offset=3D"0x1f9f0" name=3D"GMU_BOOT_KMD_LM_HANDSHAKE"/>
>  	<reg32 offset=3D"0x1f957" name=3D"GMU_LLM_GLM_SLEEP_CTRL"/>
>  	<reg32 offset=3D"0x1f958" name=3D"GMU_LLM_GLM_SLEEP_STATUS"/>
> +	<reg32 offset=3D"0x1f880" name=3D"GMU_CX_AO_COUNTER_H" variants=3D"A7XX=
"/>
> +	<reg32 offset=3D"0x1f881" name=3D"GMU_CX_AO_COUNTER_L" variants=3D"A7XX=
"/>

[Severity: High]
Are the offsets for GMU_CX_AO_COUNTER_H and GMU_CX_AO_COUNTER_L swapped
here?=20

Usually, standard little-endian hardware counters place the lower 32 bits
(_L) at the lower offset (0x1f880) and the upper 32 bits (_H) at the higher
offset (0x1f881).

If GMU_CX_AO_COUNTER_H points to the fast-changing lower 32 bits of the
counter, it could cause an infinite loop in a6xx_gmu_get_timestamp(). That
function relies on a read-retry loop to ensure the high bits haven't rolled
over:

    do {
        count_hi =3D read(_H);
        count_lo =3D read(_L);
        temp =3D read(_H);
    } while (unlikely(count_hi !=3D temp));

If _H is mapped to the lower bits, which increment rapidly at 19.2 MHz, the
two reads of _H will almost always yield different values due to MMIO
latency. This would cause the loop to spin indefinitely and potentially lock
up the CPU, returning corrupted timestamps if it ever manages to exit.

>  	<reg32 offset=3D"0x1f888" name=3D"GMU_ALWAYS_ON_COUNTER_L" variants=3D"=
A6XX-A7XX"/>
>  	<reg32 offset=3D"0x1f840" name=3D"GMU_ALWAYS_ON_COUNTER_L" variants=3D"=
A8XX-"/>
>  	<reg32 offset=3D"0x1f889" name=3D"GMU_ALWAYS_ON_COUNTER_H" variants=3D"=
A6XX-A7XX"/>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-topic-sm86=
50-gmu-a750-timestamp-reg-v1-0-284880d6e68b@linaro.org?part=3D1
