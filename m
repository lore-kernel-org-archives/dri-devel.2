Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4B7C624D3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E10D810EE07;
	Tue,  1 Sep 2026 17:39:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O/YhovGz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 943CA10EE06
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 17:39:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E7F4F6022D;
 Tue,  1 Sep 2026 17:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAA61F000E9;
 Tue,  1 Sep 2026 17:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788284365;
 bh=GPhFKuVKYW7vQ3dbmhT6M0BhOrgHEC8+ClR5l6bsZ98=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O/YhovGz4eaMPYV1rh1KSWuvPZvB4g+Mw2zYH2giB/50WyMwEPblQRzzGe6TIfgvE
 XZMTjbZwKVQsKEWqclWEks/tS8uVQR9JpPzN033plDDNa23RECUUNGSAObdReUx1aa
 JtQKmjuBDDFbYKvbgm/scLxpJxBydsdtz3b9SJi6Eluy3XeSdEomQKKCJrl8EQpg0I
 J2maqbcw+ll0WSOlFT8c8klwznpt2u/rB+zX2AMyDd/OKm60XHtXYIFu4p/wUN2bp1
 i+E1Zx1nSwXiGWor1gFGRQyd1sVAW9cSLHGDr0xXgfUm2ZD6SH3zOG4ZzBNuDofKP5
 I2NSssbm2pV3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/verisilicon: set blend mode for the cursor plane
To: "Icenowy Zheng" <zhengxingda@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260901171703.1161592-2-zhengxingda@iscas.ac.cn>
References: <20260901171703.1161592-1-zhengxingda@iscas.ac.cn>
 <20260901171703.1161592-2-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:39:25 +0000
Message-Id: <20260901173925.7CAA61F000E9@smtp.kernel.org>
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
- [High] The cursor plane's blend mode property is created supporting only =
COVERAGE, but the default atomic state initialization sets it to PREMULTI, =
causing atomic commits to fail.
--

commit 8e0ec23e99807ff97fec9437ae15ac650e658045
Author: Icenowy Zheng <zhengxingda@iscas.ac.cn>

drm/verisilicon: set blend mode for the cursor plane

This commit adds a fixed COVERAGE blend mode property for the cursor plane,
as blend mode properties are now required to expose pixel formats with alph=
a.

> diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c b/drivers/gpu/=
drm/verisilicon/vs_cursor_plane.c
> index fa4f601dd0c87..36e3664373fa1 100644
> --- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
[ ... ]
> @@ -268,5 +269,7 @@ struct drm_plane *vs_cursor_plane_init(struct drm_dev=
ice *drm_dev,
> =20
>  	drm_plane_helper_add(plane, &vs_cursor_plane_helper_funcs);
> =20
> +	drm_plane_create_blend_mode_property(plane,
> +					     BIT(DRM_MODE_BLEND_COVERAGE));

[Severity: High]
Will this cause atomic commits to fail during state restoration?

Looking at the plane setup, vs_cursor_plane_funcs uses the default
drm_atomic_helper_plane_reset() hook, which unconditionally initializes the
plane state's pixel_blend_mode to DRM_MODE_BLEND_PREMULTI.

Because this property is created supporting only DRM_MODE_BLEND_COVERAGE,
there is a mismatch with the initial state. When userspace queries the
initial state, it reads PREMULTI. If it attempts to write this state back
during an atomic commit (for instance, during a VT switch in a compositor),
the commit will fail with -EINVAL since PREMULTI is not in the supported
blend mode enum list.

>  	return plane;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901171703.1161=
592-1-zhengxingda@iscas.ac.cn?part=3D2
