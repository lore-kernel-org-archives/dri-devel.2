Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DDAC98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87F3610EE71;
	Tue, 22 Sep 2026 20:58:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hL09epyr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DEBD10EE71
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:58:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1789940E52;
 Tue, 22 Sep 2026 20:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C473B1F000FF;
 Tue, 22 Sep 2026 20:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790110693;
 bh=7y4d2/3OijhUSDakg+nsF7FMPUWXEkqXSuYTgoaUKNg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hL09epyrSuXcm3Kqa1x86GkJh4cVVcXDG48ah1wM/ngo+ZSrhwNbDr3Z5mOmQ7f6f
 +XGB2x59V2rECDQIiZFzBxKvD6BfiiJ29BNa5H9FNK60ps6kcAUPJuPtjUwvgF/bEl
 D1WC8pzI5ft3n/kGRYdl4CQDslz+WJHRzQ4GZj/s4jJyHBnRQFbCFviZvcoiv1QG2Z
 Dc2y/JPT+UhfFqpPv4GC0O+meCYfrbCrx9uGo4+Nns1cOj5PvNCjdkiXlaxQ8twtuA
 /Hm7XF77ExnylArl1RV2+dzhLenDZvLLAYQNHOGLhIsH5Lu/3xaloZenKg3xxfCe/F
 Ap2iCq0mF/log==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 08/27] drm/panthor: Add Mali v15 hardware support
To: "Karunika Choo" <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260922204535.2850094-9-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-9-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 20:58:12 +0000
Message-Id: <20260922205812.C473B1F000FF@smtp.kernel.org>
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
- [Medium] gpu: panthor: UB in GENMASK due to unvalidated MMU_FEATURES.AS_C=
OUNT
--

commit f2f7bbf0c9994aff62f62839c8644ec4028839eb
Author: Karunika Choo <karunika.choo@arm.com>
Subject: drm/panthor: Add Mali v15 hardware support

This commit adds hardware support for Mali v15 GPUs in the panthor driver.
It introduces device matching, register definitions, and logic for populati=
ng
GPU information for the v15 architecture.

> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panth=
or/panthor_hw.c
> index 13090ff6db7b5..9d539f5f80158 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
[ ... ]
> @@ -260,12 +304,55 @@ static int panthor_gpu_info_init(struct panthor_dev=
ice *ptdev)
[ ... ]
> +static void panthor_gpu_info_v15_init(struct panthor_device *ptdev)
> +{
[ ... ]
> +	ptdev->gpu_info.core_features =3D gpu_read(ptdev->iomem, DISCOVER_CORE_=
FEATURES);
> +
> +	/* AS_PRESENT register removed on v15+ create virtual mask from MMU_FEA=
TURES.AS_COUNT */
> +	ptdev->gpu_info.as_present =3D GENMASK(
> +		MMU_FEATURES_AS_COUNT(ptdev->gpu_info.mmu_features) - 1, 0);

[Severity: Medium]
Can this result in undefined behavior if the hardware reports an AS_COUNT
of 0?

If the DISCOVER_MMU_FEATURES register returns 0 (e.g., due to a hardware
fault, PCI/bus read failure, or uninitialized clock state),
MMU_FEATURES_AS_COUNT(ptdev->gpu_info.mmu_features) will evaluate to 0.
This would cause the code to evaluate GENMASK(-1, 0).

The GENMASK(h, l) macro invokes undefined behavior when h < l because it
results in a shift out of bounds (shifting ~UL(0) by BITS_PER_LONG). This
could produce an unpredictable value for the as_present bitmask, which may
lead to crashes or out-of-bounds accesses if the driver later attempts to
initialize non-existent address spaces based on a garbage mask.

> +
> +	ptdev->gpu_info.l2_present =3D gpu_read64(pwr_iomem, PWR_L2_PRESENT);
> +	ptdev->gpu_info.tiler_present =3D gpu_read64(pwr_iomem, PWR_TILER_PRESE=
NT);
> +	ptdev->gpu_info.shader_present =3D gpu_read64(pwr_iomem, PWR_SHADER_PRE=
SENT);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204535.2850=
094-1-karunika.choo@arm.com?part=3D8
