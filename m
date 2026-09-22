Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70756C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAFEE10EE78;
	Tue, 22 Sep 2026 21:01:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jy/8igRH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03C4A10EE78
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:01:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 41BEC60142;
 Tue, 22 Sep 2026 21:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC081F000FF;
 Tue, 22 Sep 2026 21:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790110878;
 bh=dms361c+ODW88NWE2m3sR1VVcB24LNnjJRPT21hQGSI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jy/8igRHVMurtPV6AEtbawL7Lu35FY5gkrLUTWbOJSJ/JIdVi6FWPs38Zbt920LgX
 DTb/x0l3bsvTOGAyzEjH2Ja/2n22WmXHuW2IayiUcFqHtWM1DHdQ8n8dzJe3c6J+Ze
 lR02SYA365SVMD7UCXSAxSZwaTEKaJM4WFOxYdExzpBUPpUj1IcW67Qp3M236gKCyw
 LfnDxKxN42tN/2/73olSsDh7RbLH47sVkBq5W+/05JEq8YYnpASf/Keua3zXxJ6uwq
 HtZX+4t5F5zIO6tjntxI/W8xK/Mv13mMZvlodHa8jltdrk1B6+wZO6PyFVmnvQmn/B
 cVUe2u10wpM8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 04/27] drm/panthor: Add 64-bit GPU_ID decoding for
 v15 GPUs
To: "Karunika Choo" <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260922204535.2850094-5-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-5-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 21:01:17 +0000
Message-Id: <20260922210117.CEC081F000FF@smtp.kernel.org>
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
- [Medium] drm/panthor: missing driver version bump for UAPI addition
- [Low] drm/tyr: build failure due to exhaustive struct initialization
--

commit 543a83f06edb5e6a777b3ef1eefcac27b352d2c8
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Add 64-bit GPU_ID decoding for v15 GPUs

Mali v15 exposes a 64-bit GPU_ID register with a different field layout
from earlier GPUs. This patch adds the register definitions, decoding helpe=
rs,
and populates the new uAPI gpu_wide_id field.

> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_dr=
m.h
> index a2ff0f4ec6915..843a0b40e1d36 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
[ ... ]
> @@ -376,6 +376,19 @@ struct drm_panthor_gpu_info {
> =20
>  	/** @gpu_features: Bitmask describing supported GPU-wide features */
>  	__u64 gpu_features;
> +
> +	/**
> +	 * @gpu_wide_id: 64-bit GPU ID for v15 and later GPUs. @gpu_id is 0 when
> +	 * this is populated.
> +	 */
> +	__u64 gpu_wide_id;

[Severity: Medium]
Does the addition of this new UAPI field require a driver version bump?

The UAPI documentation for Panthor mandates that each new flag or field
addition must come with a driver version update, so the userspace driver
doesn't have to rely on trial and error to know which flags are supported.

However, the driver minor version in panthor_drm_driver within
drivers/gpu/drm/panthor/panthor_drv.c remains at 9:

	.major =3D 1,
	.minor =3D 9,

Will userspace be forced to use trial and error to determine support for
this field without an incremented minor version?

[Severity: Low]
Will this UAPI structure modification cause a build failure in the Rust tyr
driver?

The Rust driver utilizes this structure via bindgen and initializes it
exhaustively in GpuInfo::new() within drivers/gpu/drm/tyr/gpu.rs:

        Self(uapi::drm_panthor_gpu_info {
            gpu_id: io.read(GPU_ID).into_raw(),
            gpu_rev: io.read(REVIDR).into_raw(),

Because the exhaustive initializer lacks the new gpu_wide_id field, the
Rust compiler will fail with a missing field error. Has this compile-time
regression been addressed?

> +#define DRM_PANTHOR_WIDE_ARCH_MAJOR(x)		(((x) >> 56) & 0xff)
> +#define DRM_PANTHOR_WIDE_ARCH_MINOR(x)		(((x) >> 48) & 0xff)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204535.2850=
094-1-karunika.choo@arm.com?part=3D4
