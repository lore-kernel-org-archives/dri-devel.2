Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D755C79FAB
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FC5010EA1A;
	Tue,  8 Sep 2026 04:57:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NP2s0d/i";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E76F10EA16;
 Tue,  8 Sep 2026 04:57:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A944741B24;
 Tue,  8 Sep 2026 04:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562901F00A3A;
 Tue,  8 Sep 2026 04:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788843422;
 bh=TjGQcQ+U//aWuATA9gfkX/7y2TPeBZWnNWjcgEQcAqY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NP2s0d/iR1n+pvIpdCVxsm/dSvt7DXstvdlT8MFaxKCM2WG84EAcliyoHOX8p7JT5
 Tg6zi1c3kiDB7pLDTuWUIXZnjCB3Xr1tzYhyIPljHMYUWck4dR3Ji4IZdIztoVqcMW
 p4DWZnhQfYogPMXwlRRHAfiaRFuHdwwps9wKhZTtaqwR03V4NU9VvABaN4jzsFh5D4
 MtDsTWS1Q4T080y6D5DJwoRPvm3VsJUhPPuGa7k7GvaAijv6ZIMTDBqbJMLi9ahCiB
 61hWdvInDWD6HixbwvXgOAoum2r6ZvM7HqcFLFIgEmM5HAwPf2lrTvmifoUJbPPQYH
 rpu8uCX4UTuLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 12/14] drm/xe: Indicate support for luminance on the
 connector
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260908044035.62093-13-mario.limonciello@amd.com>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-13-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 04:57:01 +0000
Message-Id: <20260908045702.562901F00A3A@smtp.kernel.org>
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
- [Low] The DRIVER_CONNECTOR_LUMINANCE feature flag is placed unconditional=
ly in the general driver features mask instead of inside the display-specif=
ic XE_DISPLAY_DRIVER_FEATURES macro.
--

commit 15b98d1b5f359c6f4e02b8f0bf3cb53a02d509bd
Author: Mario Limonciello <mario.limonciello@amd.com>
Subject: drm/xe: Indicate support for luminance on the connector

This commit enables luminance support on connectors for the xe driver,=20
allowing eDP panels to report luminance information to userspace.

> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_devic=
e.c
> index ee732e5495f7d..b74afe1594842 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -397,6 +397,7 @@ static const struct drm_driver regular_driver =3D {
>  	    XE_DISPLAY_DRIVER_FEATURES |
>  	    DRIVER_GEM |
>  	    DRIVER_RENDER | DRIVER_SYNCOBJ |
> +	    DRIVER_CONNECTOR_LUMINANCE |

[Severity: Low]
Should DRIVER_CONNECTOR_LUMINANCE be included inside the=20
XE_DISPLAY_DRIVER_FEATURES macro rather than added unconditionally here?

When the xe driver is compiled without display support (CONFIG_DRM_XE_DISPL=
AY
is disabled), XE_DISPLAY_DRIVER_FEATURES correctly evaluates to 0, which om=
its
DRIVER_MODESET and DRIVER_ATOMIC.=20

Because DRIVER_CONNECTOR_LUMINANCE is placed outside of that macro, it appe=
ars
the driver will unconditionally advertise this display capability to usersp=
ace=20
via the DRM_IOCTL_SET_CLIENT_CAP mask, even when the display components are=
=20
compiled out.

>  	    DRIVER_SYNCOBJ_TIMELINE,
>  	.open =3D xe_file_open,
>  	.postclose =3D xe_file_close,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908044035.6209=
3-1-mario.limonciello@amd.com?part=3D12
