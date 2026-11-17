Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7475F606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 01:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgtWfJwG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FE9110E3A0;
	Tue, 17 Nov 2026 01:31:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D16DE10F58B
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 01:31:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 16B0061B38;
 Tue, 17 Nov 2026 01:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A272A1F000C4;
 Tue, 17 Nov 2026 01:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794879096;
 bh=x44Fvm/3s6gQYV/+T6aDIBzbJ+hT9n1136z38bZ8YlU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dgtWfJwG7jcAYiAXY0p0d35KRl8T9lWYOD4XYMjR0IMbZi3gChgv10CKsbbzHRfMC
 QHPKA3sHQXO7Ffbk6zkbPS/3NvOLwHc/Pb+1+vnFhPgOT0bov3/rhF1UfG0rgIeDGZ
 +lQFF3p8HttaM1dG6UTOoArabJo1giuJXtDBzaEPJz5w1xBDtyMNhFt6Dq0tqYjY4m
 xEUNZmVFZu9pqkp8EFLXdVN4VEqM/fYsG8BXVinbBLIv5mZiF5XduZpH7cn9eADX+W
 Z0hrS+/TQ4eULKtrqRjGyyRMZnUD0qtHQVR8wl16hMbFiME6JPIJIw8PKlSaXeIjCc
 QLeWqWUXf89Gw==
Message-ID: <sashiko-outbox-218044@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] drm/vkms: Add KUnit tests for RGB332 and BGR233
 read conversion
To: "Sidharth Saha" <ssaha2000@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261116-rgb565-test-v1-3-27f49c1aa694@gmail.com>
References: <20261116-rgb565-test-v1-0-27f49c1aa694@gmail.com>
 <20261116-rgb565-test-v1-3-27f49c1aa694@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 01:31:36 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/vkms: duplicate RGB565/BGR565 declarations in vkms_formats.h
--

commit 9f63eb8da7a8714b37e3f9813c3cd23126f306f7
Author: Sidharth Saha <ssaha2000@gmail.com>

drm/vkms: Add KUnit tests for RGB332 and BGR233 read conversion

This commit exports argb_u16_from_RGB332() and argb_u16_from_BGR233() for
KUnit builds and adds parameterized KUnit tests covering RGB332 and BGR233
to 16-bit ARGB conversion.

[ ... ]

> diff --git a/drivers/gpu/drm/vkms/vkms_formats.h b/drivers/gpu/drm/vkms/v=
kms_formats.h
> index 135bb60a554b4..90006325a87ea 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.h
> +++ b/drivers/gpu/drm/vkms/vkms_formats.h
> @@ -18,6 +18,10 @@ struct pixel_argb_u16 argb_u16_from_yuv161616(const st=
ruct conversion_matrix *ma
>  					      u16 y, u16 channel_1, u16 channel_2);
>  void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_p=
ixel);
>  void argb_u16_to_BGR565(u8 *out_pixel, const struct pixel_argb_u16 *in_p=
ixel);
> +void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u16 *in_p=
ixel);
> +void argb_u16_to_BGR565(u8 *out_pixel, const struct pixel_argb_u16 *in_p=
ixel);

[Severity: Low]
Were the second declarations of argb_u16_to_RGB565() and
argb_u16_to_BGR565() added by mistake?  They duplicate the prototypes
directly above and trigger -Wredundant-decls warnings under W=3D2 builds wi=
th
CONFIG_KUNIT enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-rgb565-tes=
t-v1-0-27f49c1aa694@gmail.com?part=3D3
