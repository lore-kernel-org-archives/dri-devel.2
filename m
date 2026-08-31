Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D19C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 20:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC33F10EAF3;
	Mon, 31 Aug 2026 20:40:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CJCBbgpZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B47310EAF3
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 20:40:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 89C99601DE
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 20:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A121F000E9;
 Mon, 31 Aug 2026 20:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788208810;
 bh=eCSJG5NgyymC6l42q+f4JXi1BKWyAeJucuhP1ZlztJU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CJCBbgpZommw68q8NOu/bpc53YsHpcuO3Z/yG9bLOi4zu22FHczo3fFeYAkm62aYH
 MJgHBgtqMJJRoUNJK7Dk+N1NvGh9lRzNkMVOMOcOfaSA9FPjh3C7ZweQ573hLF0yc4
 3iGgW6ECYAu4IA5EBIYqvh/prqsVEIsQhsMRAo7Dwj4bCRbSIL1wZSNuh0fn2MJQ3D
 DMsuyhaJOzC74N/lWhUwmH9czJAN1Ha1VoY48QKZSuDqjlvB4Xpk3BwMRmeJJoT5yC
 HLLrC7yocaKZ97AloKxLc7tOYbDl8RPJhBbPP3A6mT9/t4FXcoj6xdL/y+5N2NYaLu
 r/PV5lh6fHOXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/13] drm/sitronix: st7920: Convert to
 atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-drm-no-more-crtc-reset-v2-11-4500d49a337f@kernel.org>
References: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
 <20260831-drm-no-more-crtc-reset-v2-11-4500d49a337f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 20:40:09 +0000
Message-Id: <20260831204010.14A121F000E9@smtp.kernel.org>
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
- [High] The driver calls sleeping functions (usleep_range, msleep, spi_wri=
te) from CRTC atomic_enable/atomic_disable and Plane atomic_update callback=
s, which are designated as atomic context paths by the DRM subsystem guidel=
ines where sleeping is strictly forbidden.
--

commit a9d5c4bd0a5df0b653500203f8b4425d59185b78
Author: Maxime Ripard <mripard@kernel.org>

drm/sitronix: st7920: Convert to atomic_create_state

The st7920 crtc implementation provides a custom reset hook. However,
this hook only allocates the state, initializes it with
__drm_atomic_helper_crtc_reset(), and warns if there's a previous state.
It does not perform any hardware reset.

Since this is exactly what the atomic_create_state hook is meant to
do, minus the old state cleanup which the caller handles, convert the
implementation to use atomic_create_state with
__drm_atomic_helper_crtc_state_init() instead.

> diff --git a/drivers/gpu/drm/sitronix/st7920.c b/drivers/gpu/drm/sitronix=
/st7920.c
> index 0a75e9319080f..9887ed746cebd 100644
> --- a/drivers/gpu/drm/sitronix/st7920.c
> +++ b/drivers/gpu/drm/sitronix/st7920.c
> @@ -575,17 +575,17 @@ static void st7920_crtc_atomic_disable(struct drm_c=
rtc *crtc,
>  }

[Severity: High]
This is a pre-existing issue, but does this driver incorrectly call sleeping
functions from atomic context paths?

A display modeset or screen update triggers DRM callbacks like
st7920_crtc_atomic_enable(), st7920_crtc_atomic_disable(), and
st7920_primary_plane_atomic_update() in drivers/gpu/drm/sitronix/st7920.c,
which are designated as atomic contexts where sleeping is strictly forbidde=
n.

However, they internally call functions that can sleep:

st7920_crtc_atomic_enable() (at line 553):
  st7920_hw_reset()
    usleep_range(15, 20);
    msleep(40);

st7920_crtc_atomic_disable():
  st7920_power_off()
    spi_write()

st7920_primary_plane_atomic_update():
  st7920_fb_blit_rect()
    spi_write()

Could this lead to "scheduling while atomic" kernel warnings or deadlocks
when userspace triggers screen updates?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-drm-no-mor=
e-crtc-reset-v2-0-4500d49a337f@kernel.org?part=3D11
