Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4522FC98338
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 18:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 952BE10E68A;
	Sun, 27 Sep 2026 18:38:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bOBAEKnC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39BA510E68A
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 18:38:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 74FBB60052;
 Sun, 27 Sep 2026 18:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E8A1F000FF;
 Sun, 27 Sep 2026 18:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790534329;
 bh=WCA4T+kummSJSRk1IidlaIDa4hC2fbK0BftJInoUqSw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bOBAEKnCrNwDjagHCdf4h1Tf9cx2Z+viXH8kYeynPLfGdG3SweDonLV0540YWOpE6
 STlZXZXDbhxgc4kXQyarisUiSQDwzYW2EgHzdp2M+//1lLcygIxZxnjV5fZ3JK4uOC
 bT/jAo8r6+bFiddeb/OKg1h3TA50INijvjpnhNYHTQLN0RC10ytXXrXkOShdVzMSj/
 1eB00xLjOLEinsiA0+Lx2L2To1HQmHxZViQbJ4J4rWPI8dlNvV1h+ziziz7gdkGmyZ
 I0LYW4cy19aORJOQmKm11FefHBbsXTZNP3ob3wDPNe1/G0NQW/MvQ4f8zrIA0Rcb1A
 ucLtay/+qwtCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/14] drm/solomon: ssd16xx: Expose session
 management as plane properties
To: "Devarsh Thakkar" <devarsht@ti.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260927182329.4193961-11-devarsht@ti.com>
References: <20260927182329.4193961-1-devarsht@ti.com>
 <20260927182329.4193961-11-devarsht@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 18:38:48 +0000
Message-Id: <20260927183848.D3E8A1F000FF@smtp.kernel.org>
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
- [Medium] drm/solomon: stale plane properties used in CRTC hooks due to sy=
nc ordering
- [Medium] drm/solomon: unprotected concurrent access to global device prop=
erties
--

commit 16a8f4fa23daecbcef4ac45581fba368964d7807
Author: Devarsh Thakkar <devarsht@ti.com>

drm/solomon: ssd16xx: Expose session management as plane properties

This commit adds DRM plane properties for session management flags,
allowing userspace to control automatic display clear/refresh behavior
at lifecycle transitions.

> diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/=
ssd16xx.c
> index 3815af0cee5c5..6331f367d8649 100644
> --- a/drivers/gpu/drm/solomon/ssd16xx.c
> +++ b/drivers/gpu/drm/solomon/ssd16xx.c
[ ... ]
> @@ -1588,6 +1670,10 @@ static void ssd16xx_plane_atomic_update(struct drm=
_plane *plane,
> =20
>  	device->refresh_mode =3D new_ssd->refresh_mode;
>  	device->color_mode =3D new_ssd->color_mode;
> +	device->clear_on_init =3D new_ssd->clear_on_init;
> +	device->clear_on_close =3D new_ssd->clear_on_close;
> +	device->clear_on_disable =3D new_ssd->clear_on_disable;
> +	device->refresh_mode_init =3D new_ssd->refresh_mode_init;

[Severity: Medium]
Since ssd16xx_plane_atomic_update() returns early if there is no framebuffe=
r:

static void ssd16xx_plane_atomic_update(...)
{
        ...
        if (!fb)
                return;

Will these device property assignments be skipped entirely when the plane
is being disabled?

Additionally, doesn't drm_atomic_helper_commit_tail_rpm() call the CRTC
enable and disable hooks before the plane update? If a user submits an
atomic commit that updates clear_on_disable and disables the CRTC at
the same time, won't ssd16xx_crtc_atomic_disable() read the stale global
device property before this plane update has a chance to synchronize the
new atomic state?

[Severity: Medium]
Is it safe to write to global device properties like device->clear_on_close
here? This code executes under DRM modeset locks, but if another client
closes its DRM file descriptor, wouldn't ssd16xx_drm_master_drop() read
these same properties under drm_device->master_mutex?

Since they don't share locks, could this lead to a data race where the
master drop path reads torn or stale values while an atomic commit is
processing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927182329.4193=
961-1-devarsht@ti.com?part=3D10
