Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027C3C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 07:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4656310F2DF;
	Fri, 24 Jul 2026 07:04:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f0+ib+mJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B807510F2DF
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 07:04:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A0E8242BA0;
 Fri, 24 Jul 2026 07:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC3E1F000E9;
 Fri, 24 Jul 2026 07:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784876685;
 bh=VMs/xq3GJDqlh81Aq/zinQPzA/3OsaqqHluc+UJDxks=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=f0+ib+mJWB5Gkvbe21bWbGydXeZAbIj1APMQnTSKtNs5W+i3dYO4kJ/+xrycMtpZR
 IBpCkfw7i4J/9r3O1GQ9hfXAzeBxkEyOefYzRU54Pvui9ZWvgeItd7wT3X2t9gsYPq
 hM31LqgHPi5P7MwheUkqQ5K+sRxyS3XRN2Dy9hzAaMor9XGOBrR76DaMVBmRUugQbM
 ilE6W0CCo357cJdA2D6Rgub6+52h125mjTW9vVA5LPOa0SE1qxVNJuvJ6OFmmPnba7
 +7eB3RHBlCWjOT0sxeKslaAuoOmtRt0O+l6wi405vspd10tgSIa6fJ2YEh19JU65CJ
 WHUNb9FjBcbYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] gpu: nova-core: return non-WPR heap size as u64
 from HALs
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260724-blackwell-fixes-v3-3-01aa6a54e3fd@nvidia.com>
References: <20260724-blackwell-fixes-v3-0-01aa6a54e3fd@nvidia.com>
 <20260724-blackwell-fixes-v3-3-01aa6a54e3fd@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 07:04:44 +0000
Message-Id: <20260724070445.2AC3E1F000E9@smtp.kernel.org>
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
- [High] The driver lacks bounds checking for framebuffer size and VGA work=
space addresses read from untrusted device MMIO, leading to integer underfl=
ows and kernel panics.
--

--- Patch [3]: [PATCH v3 3/5] gpu: nova-core: return non-WPR heap size as u=
64 from HALs ---
commit 607f14f3038014abfcbe45e7fcb56d2a70d0bac2
Author: Eliot Courtney <ecourtney@nvidia.com>

gpu: nova-core: return non-WPR heap size as u64 from HALs

This commit changes the non_wpr_heap_size() HAL function to return a u64
directly, avoiding the need for a conversion when calculating the heap size.
It updates the HAL implementations for various chipsets accordingly.

> diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
> index 1f7b6a69e4db8..f5832e59de599 100644
> --- a/drivers/gpu/nova-core/fb.rs
> +++ b/drivers/gpu/nova-core/fb.rs
> @@ -252,7 +252,7 @@ pub(crate) fn new(chipset: Chipset, bar: Bar0<'_>, gs=
p_fw: &GspFirmware) -> Resu
>          };
> =20
>          let non_wpr_heap =3D {
> -            let non_wpr_heap_size =3D u64::from(hal.non_wpr_heap_size());
> +            let non_wpr_heap_size =3D hal.non_wpr_heap_size();
>              FbRange(wpr2.start - non_wpr_heap_size..wpr2.start)

[Severity: High]
This is a pre-existing issue, but since we are modifying size calculations
here in FbLayout::new(), could a malicious device cause an integer underflow
earlier in this function?

If a device returns a framebuffer size smaller than NV_PRAMIN_SIZE (1MB) fr=
om
MMIO, the subtraction fb.end - NV_PRAMIN_SIZE will underflow and panic.

Additionally, the untrusted VGA workspace address read from MMIO isn't boun=
ded
against fb.end. If the VGA workspace address is larger than the framebuffer
size, it can result in a range where start > end. When FbRange::len() is
called on this range, it will unconditionally subtract start from end, caus=
ing
another underflow panic.

Could we add upper bounds checking for the framebuffer size and VGA workspa=
ce
address against MMIO registers to prevent these crashes?

>          };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-blackwell-=
fixes-v3-0-01aa6a54e3fd@nvidia.com?part=3D3
