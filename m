Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C26CCD98F2
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 18:50:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ED3310E26A;
	Sat, 20 Jun 2026 18:50:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kYHQSfVl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AC3710E26A
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 18:50:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8063643EA4;
 Sat, 20 Jun 2026 18:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF421F00A3A;
 Sat, 20 Jun 2026 18:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781981448;
 bh=CvX68E3/Wcm5+aQlQQVtZ0iFBzIQa26BVF579CEFtTY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kYHQSfVlatYOJYyllXVLnsxFHZe4iLvdrSz9Z7uD8qyCe+UfUOLJKtUQxe7lIp8K3
 nRsmXI03ThSS9XycmNBB60GAcnyf6KJoI2ZqaYgy0GmznKm+Ne+OlOvbbB61asxzFO
 jKupyA8JF33K06Vn+aVyYyBqZOaqple7WeoK/Q8xfm98SJl0liu0bUX4ABF4AlN4yn
 8rwhduaB/+SOk8Pm+H1hoqoY5wylwjW5ZkTYE1GdI21iKiKGjtj9B+c6OqJqCEFjVC
 kN/TWz6nN12CcVLqJgJdFIhwvDM/sFurCyLU/8xbs54EgAekU17yeDI2ztDpUzymxw
 llrm3BKIWgxfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/radeon: Add NULL pointer check for enc_priv in
 atombios_set_encoder_crtc_source()
To: "Alexey Velichayshiy" <a.velichayshiy@ispras.ru>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260620183150.1248791-1-a.velichayshiy@ispras.ru>
References: <20260620183150.1248791-1-a.velichayshiy@ispras.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 18:50:47 +0000
Message-Id: <20260620185048.4EF421F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] Incomplete fix for NULL pointer dereference. The patch adds a loca=
l check for `enc_priv` (`dig`) in `atombios_set_encoder_crtc_source()`, but=
 leaves the root cause unaddressed. In `radeon_add_atom_encoder()`, if the =
memory allocation for `enc_priv` fails (e.g., via `radeon_atombios_get_lvds=
_info()`, `radeon_atombios_set_dig_info()`, or `radeon_atombios_set_dac_inf=
o()`), the error is ignored and the encoder is registered with a NULL `enc_=
priv`. This broken encoder is then passed to numerous other functions (like=
 `atombios_dig_encoder_setup2`, `atombios_dig_transmitter_setup2`, and `ato=
mbios_dac_setup`) which unconditionally dereference `enc_priv` (via `dig` o=
r `dac_info`), leading to guaranteed kernel panics. The proper fix is to ha=
ndle the allocation failure at the source and abort encoder registration.
- [High] The driver automatically defaults the display scaling mode to RMX_=
FULL for LCD devices, which violates the DRM subsystem guideline on scaling=
 modes. This stretches the image and distorts its aspect ratio (e.g., circl=
es become ovals) instead of preserving it.
--

commit 21561a0f42099aab9f6cd586dc86a1e791580aef
Author: Alexey Velichayshiy <a.velichayshiy@ispras.ru>

drm/radeon: Add NULL pointer check for enc_priv in atombios_set_encoder_crt=
c_source()

This commit adds a NULL pointer check for enc_priv in
atombios_set_encoder_crtc_source() to prevent a NULL pointer dereference.
The issue was reported to be found with SVACE.

> diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm=
/radeon/atombios_encoders.c
> index 3d9f47bc807af..6efb6bd2d344c 100644
> --- a/drivers/gpu/drm/radeon/atombios_encoders.c
> +++ b/drivers/gpu/drm/radeon/atombios_encoders.c

[ ... ]

> @@ -1931,6 +1931,8 @@ atombios_set_encoder_crtc_source(struct drm_encoder=
 *encoder)
>  			case ENCODER_OBJECT_ID_INTERNAL_UNIPHY3:
>  			case ENCODER_OBJECT_ID_INTERNAL_KLDSCP_LVTMA:
>  				dig =3D radeon_encoder->enc_priv;
> +				if (!dig)
> +					return;

[Severity: High]
This isn't a bug introduced by this patch, but does this local check leave
the root cause unaddressed?

In drivers/gpu/drm/radeon/atombios_encoders.c:radeon_add_atom_encoder(), if
the memory allocation for enc_priv fails (e.g. via
radeon_atombios_set_dig_info()), the error is ignored and the encoder is
registered with a NULL enc_priv:

radeon_add_atom_encoder() {
    ...
    radeon_encoder->enc_priv =3D radeon_atombios_set_dig_info(radeon_encode=
r);
    ...
}

This broken encoder is then passed to numerous other functions which
unconditionally dereference enc_priv, such as:

atombios_dig_encoder_setup2() {
    ...
    if (dig->dig_encoder =3D=3D -1)
    ...
}

atombios_dig_transmitter_setup2() {
    ...
    int dig_encoder =3D dig->dig_encoder;
    ...
}

atombios_dac_setup() {
    ...
    switch (dac_info->tv_std) {
    ...
}

Since other DRM callbacks will unconditionally dereference it, could we han=
dle
the allocation failure at the source and abort encoder registration instead?

[Severity: High]
This is a pre-existing issue, but does this driver incorrectly default to
distorting the aspect ratio for LCD devices?

Also in drivers/gpu/drm/radeon/atombios_encoders.c:radeon_add_atom_encoder(=
):

radeon_add_atom_encoder() {
    ...
    radeon_encoder->rmx_type =3D RMX_FULL;
    ...
}

Setting the default scaling mode to RMX_FULL stretches the image and
distorts its aspect ratio (e.g., circles become ovals). Should this
default to RMX_ASPECT instead to preserve the aspect ratio?

>  				switch (dig->dig_encoder) {
>  				case 0:
>  					args.v2.ucEncoderID =3D ASIC_INT_DIG1_ENCODER_ID;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620183150.1248=
791-1-a.velichayshiy@ispras.ru?part=3D1
