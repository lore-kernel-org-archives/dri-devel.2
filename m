Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1230FCD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 12:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 668A210E7A0;
	Wed, 27 May 2026 12:04:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jD9183lA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DCD810E7A0
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 12:04:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E0F46600BB;
 Wed, 27 May 2026 12:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A351F000E9;
 Wed, 27 May 2026 12:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779883470;
 bh=XMfF5DnL7dDcq9KjDboiINYmJ7YqWFYoHGh7UlSTB7g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jD9183lArneaw8BloQcTcrcKlkT4/u0tTmoiY4xz7P3Gxdeesy1iRrg4d7fsjNqwQ
 bMYM8xcWGEqxnXknJPhzB7VmpL/fSj2b11cdxGJOb+BtdkuZzjaNR1bq8z1dBvjGiy
 7Vwd/zzd7YIA2muFHD+vFtg/P9nJcM9bO4kWCHQiMRb4bwtoBA1aehg9uQleq4mkpr
 sHll4qpCvCOXIhZ5ryPt+uYc013SnhCFsuaRhkuppGXBCXsvIka5FDWT5YpdlZuNAc
 VixYHMHuhwZSekWwwptRzzJbyaxP3b7HzNS/5VYCOyHmS4iCjhzC7C2jnTE0gCKCGG
 9ej5NtT+FR7sA==
Date: Wed, 27 May 2026 14:04:27 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Helge Deller <deller@gmx.de>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 0/3] clk: Add __clk_disable_unprepare_counts_only() and
 use this in simple[fb|drm]
Message-ID: <20260527-flawless-chowchow-of-fruition-edbe8a@houat>
References: <20260527094811.116977-1-johannes.goede@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="poecqeshwt7yxrvn"
Content-Disposition: inline
In-Reply-To: <20260527094811.116977-1-johannes.goede@oss.qualcomm.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


--poecqeshwt7yxrvn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/3] clk: Add __clk_disable_unprepare_counts_only() and
 use this in simple[fb|drm]
MIME-Version: 1.0

Hi Hans,

On Wed, May 27, 2026 at 11:48:08AM +0200, Hans de Goede wrote:
> Hi Michael, Stephen, et al.,
>=20
> The device-tree simple-framebuffer device is special in that it does not
> describe actual hardware, but it allows firmware (e.g. u-boot) to pass a
> firmware initialized framebuffer to the OS to use as display during boot.
>=20
> To avoid clocks used by the firmware framebuffer getting touched while in
> use, the DT node contains a list of clocks which should not be touched
> while the simple-framebuffer is in use.
>=20
> Conceptually this is fine, in practice the *do not touch* is implemented =
as
> a clk_prepare_enable() + clk_disable_unprepare() pair, with the disabling
> happening when the simple-framebuffer driver gets replaced by the real
> display-engine driver.

Which is also pretty fragile because it doesn't lock the rate either.

> The simple-framebuffer concept assumes that the order in which resources
> are acquired does not matter since they are already on, so power-sequenci=
ng
> is not an issue. But clk_disable_unprepare() actually turns the clock off,
> messing with the hardware state before the real display driver loads,
> without any knowledge of the proper power-off sequence for the display.
>=20
> The turning off of the clocks outside of a proper power-off sequence caus=
es
> the following error when the msm display driver tries to re-enable them:
>=20
> [    2.980181] disp_cc_mdss_dptx3_pixel0_clk_src: rcg didn't update its c=
onfiguration.
> [    2.980272] WARNING: drivers/clk/qcom/clk-rcg2.c:136 at update_config+=
0xdc/0x100
>=20
> Resulting in a non working display.
>=20
> To fix this, we need a way to properly implement the "do not touch" conce=
pt
> for clocks.

I'm not sure it's something we can enforce, really. The firmware can
modify clocks behind our back. Other clocks might change this one as a
side-effect of a rate change or reparenting, etc. It's just not
something we can commit to.

> clk_prepare_enable() is fine, the clocks are already on so no
> ordering worries and it ensures that the clocks and their parents cannot
> get turned off by incrementing their enable, prepare and protect counts.
>=20
> clk_disable_unprepare() is a problem though since it actually turns the
> clocks off. Instead something is needed which only decrements those count=
s.
>=20
> This series introduces a new clk-core function called
> __clk_disable_unprepare_counts_only() (1) which does just that. Prefixed
> with '__' to indicate that normally drivers should not use this.
>=20
> Michael, Stephen sorry for needing to add a new clk-core function for thi=
s,
> but I see no other way of solving this (2)(3). The changes are not that
> big / not too bad.
>=20
> I've also considered making __clk_disable_unprepare_counts_only() impleme=
nt
> all the logic itself instead of adding the extra parameter to
> clk_core_unprepare() and clk_core_disable() but that leads in duplicating
> quite a bit of logic (4) so this seems better.
>=20
> The other 2 patches just replace the clk_disable_unprepare() calls in
> the simple[fb|drm] driver with the new helper.
>=20
> This series fixes the display not coming up after switching to the msm
> driver when a simple-framebuffer node with clocks listed is used.
>
> 1) I'm open to changing the name, this is the best I could come up with.
>=20
> 2) One option considered was detaching the simple-framebuffer driver late=
r,
>    after the real display driver has had a chance to claim the clocks. But
>    this won't work in cases where the real display driver picks different
>    parent clocks then the boot firmware did and needs to reparent clocks.
>=20
>    Basically the goal is for things to behave as if the simple-framebuffer
>    driver was not there at all, because that leaves the hw in the state
>    the real display driver expects.

So I know it's not really what you had in mind, but if you are only
concerned about the transition from the bootloader to the DRM driver,
then I think supporting the following work would help:

https://lore.kernel.org/r/20260423-drm-state-readout-v2-0-8549f87cb978@kern=
el.org

With that series, we can build the initial KMS state from the hardware
state, which means that if you were to change the resolution at boot, it
would be executed just like any mode change in KMS.

The initial state allocation is now fallible as well, so if you remove
simple-framebuffer after drm_mode_config_create_initial_state has been
called and has succeeded, then you know that the driver is now in
charge, picked up the configuration, and has taken all the resources
needed to continue running. And if it fails for any reason,
simple-framebuffer is still functional.

This should help mitigate your initial problem, even though it's a
widely different solution.

Maxime

--poecqeshwt7yxrvn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCahbdywAKCRAnX84Zoj2+
doYEAYCJSKbYb5ovBP1Tk4I/neeBWAd0rAXIxQ4ItF/x8n1yMsBNqaD+sYb0l5ej
8yKxe1EBgJXJaa1J/HCXRaAWJqpc4/P8PV6oMIF9/Ph5dplnMb+5cOU5Iul4Hq3C
fXaTVRpKyQ==
=zoaU
-----END PGP SIGNATURE-----

--poecqeshwt7yxrvn--
