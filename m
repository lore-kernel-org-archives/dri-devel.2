Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D4BC4453E
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1972110EFA3;
	Thu, 23 Jul 2026 06:41:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UDKJBAm7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D41110EFA3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 06:41:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 95C99431F6;
 Thu, 23 Jul 2026 06:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241E01F000E9;
 Thu, 23 Jul 2026 06:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784788884;
 bh=2mQiS4p6dyH3yVHqa9KsxAIcjrva99u6hYhFIaT3/OU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UDKJBAm7aadl2wRGRNQlQ8KmsW6P/S9eztESuFc2VMM+p9SxW81ywCEygHdJkVKHH
 /l9x0JQMgYogLrVivHWvaAXbnpA7ZNQ6kaZ8garH8OqDFje37jD7vIZZkAQ0Egawp3
 BoKzVIFGxpFAaWavUTAJ4PrmZxYrjieYeg/DnDaTBIHezS3Khv1unlk9ek2wz+IDGu
 g2PglKkGoXDxGaslw5kl4GJf+E1GPkM3zTQXYvySdDixKJWdxGqIL5rvxwGy4/A3zS
 pjXnkblydKVo0k6QkvvAQ2eHeR3i0ts2fITTj45wxQS3/JclhKNAbIszJ4Uh6ZNLuc
 0xNHLVQcj5Z8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/7] drm: nova: Add GETPARAM parameter to read the
 GPU chipid
To: "Alistair Popple" <apopple@nvidia.com>
Cc: ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260723063046.1265791-5-apopple@nvidia.com>
References: <20260723063046.1265791-1-apopple@nvidia.com>
 <20260723063046.1265791-5-apopple@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 06:41:23 +0000
Message-Id: <20260723064124.241E01F000E9@smtp.kernel.org>
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
- [Low] Conditional compilation error on 32-bit architectures due to mismat=
ched match arm types.
--

--- Patch [4]: [PATCH v3 4/7] drm: nova: Add GETPARAM parameter to read the=
 GPU chipid ---
commit c560fdc21fe8a1d71109ee27e0b91d35e7283f2a
Author: Alistair Popple <apopple@nvidia.com>

drm: nova: Add GETPARAM parameter to read the GPU chipid

One of the first things a user needs to know about a GPU is its chipid,
so add a GETPARAM parameter to return that.

> diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
> index 1156df51c533a..855f238777349 100644
> --- a/drivers/gpu/drm/nova/file.rs
> +++ b/drivers/gpu/drm/nova/file.rs
[ ... ]
> @@ -43,6 +43,7 @@ pub(crate) fn get_param(
> =20
>          let value =3D match getparam.param as u32 {
>              uapi::NOVA_GETPARAM_VRAM_BAR_SIZE =3D> pdev.resource_len(1)?,
> +            uapi::NOVA_GETPARAM_GPU_CHIPID =3D> reg_data.api.chipset() a=
s u64,

[Severity: Low]
Does this cause a conditional compilation error on 32-bit architectures?

In File::get_param(), all match arms must evaluate to exactly the same
type. The first arm evaluates to pdev.resource_len(1)? which returns a
bindings::resource_size_t. The newly added second arm evaluates to u64
via the explicit cast.

On 32-bit kernel configurations without CONFIG_PHYS_ADDR_T_64BIT enabled,
resource_size_t resolves to u32. This mismatch between u32 and u64 across
the match arms will result in a hard build error.

>              _ =3D> return Err(EINVAL),
>          };
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723063046.1265=
791-1-apopple@nvidia.com?part=3D4
