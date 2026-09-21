Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AD7C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C6E010E470;
	Mon, 21 Sep 2026 16:26:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gKHonzv4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2639510E3C8
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 16:26:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CE87843923;
 Mon, 21 Sep 2026 16:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915961F000FF;
 Mon, 21 Sep 2026 16:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790007966;
 bh=aIyQRJgcWIOxWvax7BQksU0xH/L42+Xf2UYTC/cGxn4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gKHonzv4i9Z6/Bk9OAkoyrJSetOMkkbcV6yc+FVkjBXTMFYf4Tz2BOMk9URAvVPdS
 w0BS6oCPZqbnKv9NNLa8b09yH4+SKc223K79uEWHmg7v4esSy1vxBir0Wf9XRS0vXq
 ef2HJYiWuXcvmEqwCBpVsgD9p5TZmiqcMXtIx6EFAKD9EXHPnjdjPpMefDGaK93vvX
 3RbSUp3gZcTV3H9zpzoUsnsU3dVXNOodC0H4T83k5VWh29sXKmem+knGSmFNTjekXJ
 Co7Og/wpchP8PYe44+XYQ4757IsIFyWjsYrFKaBlpIaJ8x44yTOt3YcgG8iT1gtdy5
 SBkwLOKsbUItQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 25/25] drm/atomic: Disable VRR in helper_set_config
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921-vrr-limiter-uapi-v1-25-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-25-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:26:06 +0000
Message-Id: <20260921162606.915961F000FF@smtp.kernel.org>
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
- [High] drm: __drm_atomic_helper_set_config unconditionally disables VRR f=
or legacy clients
--

commit 353fccdd37726114a8ead2ac16a0d6cf9e239631
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/atomic: Disable VRR in helper_set_config

This commit explicitly sets crtc_state->vrr_enabled to false in
__drm_atomic_helper_set_config. The goal is to prevent a non-functional KMS
fbdev console if a DRM client exits without properly cleaning up its VRR
state.

> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 9bb761eda59f4..1d3c35f7788eb 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -2051,6 +2051,8 @@ int __drm_atomic_helper_set_config(struct drm_mode_=
set *set,
> =20
>  	crtc_state->active =3D true;
> =20
> +	crtc_state->vrr_enabled =3D false;
> +

[Severity: High]
Does this unconditionally disable VRR for legacy clients that use
DRM_IOCTL_MODE_SETCRTC?

If a legacy KMS client (like X.org) enables VRR via
DRM_IOCTL_MODE_OBJ_SETPROPERTY and later calls DRM_IOCTL_MODE_SETCRTC (for
DPMS, panning, or resolution changes), won't this unconditionally clear the=
ir
persistent state by setting crtc_state->vrr_enabled to false?

Additionally, can this cause unnecessary full hardware modesets?

If drm_atomic_helper_check_modeset() sees vrr_enabled transition from true =
to
false, it sets mode_changed =3D true. This could force a slow, full modeset
(with screen blanking/flicker) during what would normally be a fast, seamle=
ss
display update.

>  	ret =3D drm_atomic_set_crtc_for_plane(primary_state, crtc);
>  	if (ret !=3D 0)
>  		return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vrr-limite=
r-uapi-v1-0-2fcd7d011646@collabora.com?part=3D25
