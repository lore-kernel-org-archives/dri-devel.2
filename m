Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4931AC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 20:41:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A494610EBC7;
	Tue,  4 Aug 2026 20:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M4MknuQc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C35410EBC7
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 20:41:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 41F5F600AA;
 Tue,  4 Aug 2026 20:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7C91F000E9;
 Tue,  4 Aug 2026 20:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785876095;
 bh=WyN0H9baGhjSYcGNbI3CVnsgZN44/AG4UccnZm/GrdM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M4MknuQc7DggpuI/2u5Pvi8g3OeUcSmeDriGXbwrr89RMUzMREP2EB3QgRLatRUVa
 XCrRlVeO+DvPCWclU/dJxZIunbzYWnF0Ep3GvUovH7MOIWTVYlLMZ6Vzpn0wDb9N6e
 aUzhe9TRPgt7FpPWl3hxCgBJgKonOL2GkK64eERnqcHN/eH/oYJRjiOVstHigg5BiW
 OlTUKBwL1yI7m47imsy42EhssiNtRfvPKLQ4f715GpSy2grm9FvBhqJnviNfLjOaX4
 Y+3bA0oJ0k/IVkjdKVxqoGa2BMqV9gKArzksRzkWDc1zbCABuuDz/ZmYIWcSh3942V
 zQJ37UGkqt9fQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/11] drm/vkms: rename VKMS_LUT_SIZE to
 VKMS_GAMMA_LUT_SIZE
To: "Leandro Ribeiro" <leandro.ribeiro@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260804203351.148521-2-leandro.ribeiro@collabora.com>
References: <20260804203351.148521-1-leandro.ribeiro@collabora.com>
 <20260804203351.148521-2-leandro.ribeiro@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 20:41:33 +0000
Message-Id: <20260804204134.CE7C91F000E9@smtp.kernel.org>
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
- [High] Incorrect size calculation for gamma_lut validation causes atomic =
commits to be rejected on 32-bit systems.
--

--- Patch [1]: [PATCH 01/11] drm/vkms: rename VKMS_LUT_SIZE to VKMS_GAMMA_L=
UT_SIZE ---
commit 2362b93c64416bccb5039e7ee169799f46cd254c
Author: Leandro Ribeiro <leandro.ribeiro@collabora.com>

drm/vkms: rename VKMS_LUT_SIZE to VKMS_GAMMA_LUT_SIZE

This commit renames VKMS_LUT_SIZE to VKMS_GAMMA_LUT_SIZE to clarify that it
represents the size of the CRTC gamma LUT.

> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_=
drv.c
> index 5a640b531d88f..86a8a95694fd7 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -113,7 +113,7 @@ static int vkms_atomic_check(struct drm_device *dev, =
struct drm_atomic_commit *s
>  			continue;
> =20
>  		if (new_crtc_state->gamma_lut->length / sizeof(struct drm_color_lut *)
> -		    > VKMS_LUT_SIZE)
> +		    > VKMS_GAMMA_LUT_SIZE)

[Severity: High]
This is a pre-existing issue, but does this calculation incorrectly reject
atomic commits with valid gamma LUTs on 32-bit systems?

Looking at vkms_atomic_check() in drivers/gpu/drm/vkms/vkms_drv.c, it
divides the length by the size of a pointer (sizeof(struct drm_color_lut *))
rather than the actual struct size (sizeof(struct drm_color_lut)).

On 32-bit architectures, the pointer size is 4 bytes, while the struct itse=
lf
is 8 bytes. When userspace provides a valid 256-element LUT (2048 bytes), t=
his
division calculates the length as 512 elements. This would exceed the=20
VKMS_GAMMA_LUT_SIZE of 256, causing the atomic check to incorrectly fail=20
with -EINVAL.

>  			return -EINVAL;
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804203351.1485=
21-1-leandro.ribeiro@collabora.com?part=3D1
