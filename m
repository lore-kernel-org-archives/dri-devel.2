Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AA2CCA464
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 12:48:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E0F810E2E8;
	Fri, 16 Oct 2026 12:48:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85E4410E2E8
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 12:48:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6F7DE60008;
 Fri, 16 Oct 2026 12:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10D61F000C4;
 Fri, 16 Oct 2026 12:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792154926;
 bh=8X4urbvO2xZpXPVoCNUzNjOls4tZXK2yo09pYBPipng=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=eOslO6PSywvkvwQQZ8u+97bxGOkt/RuHsS+RlgbdtiWTuey/+hqjEDWm3VScn/Xoz
 j7zFejJEHY9g2SO8VOAo7xjXCfMjrLr4QTw1pfwPrOeEle2Dgxq2e+3rVSaMAzQBG9
 jV0SuAMydmdTYJT7p7wg2JG2CBhpRztIkqqlZ580oCZVR318+d33WP55jrCX+tMRoD
 MpR9VQNWtH0xQuHwX/kPHAwWu3ObTse9TGYXh8NAhP895B84kfERlRVpdWVDcPeUJn
 G6IQcL8rrcLv9vJBP1okTTwpOOZZ8qvMRp+RVK9B2Xb/LnCk6N+te6iid3TKnZbrrg
 +is7xQ2As46Xg==
Date: Fri, 16 Oct 2026 14:48:42 +0200
From: Maxime Ripard <mripard@kernel.org>
To: =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Subject: Re: [PATCH 63/75] drm/vc4: hdmi: Convert to atomic_create_state
Message-ID: <atIc_4PHIFheqbft@houat>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-63-586c9c026823@kernel.org>
 <c0f448b2-128e-47ae-b63e-168948673b89@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="3dlknviedupngxol"
Content-Disposition: inline
In-Reply-To: <c0f448b2-128e-47ae-b63e-168948673b89@igalia.com>
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


--3dlknviedupngxol
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 63/75] drm/vc4: hdmi: Convert to atomic_create_state
MIME-Version: 1.0

On Thu, Oct 15, 2026 at 08:07:45AM -0300, Ma=EDra Canal wrote:
> Hi Maxime,
>=20
> On 14/10/26 14:27, Maxime Ripard wrote:
> > The vc4 HDMI connector reset implementation creates a pristine state,
> > initializes the HDMI state, and sets the TV margins. It does not
> > perform any hardware reset.
> >=20
> > Since this is equivalent to what atomic_create_state expects, convert
> > the reset function to an atomic_create_state hook that returns the
> > initialized state.
> >=20
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
>=20
> The order of the parameters in
> __drm_atomic_helper_connector_hdmi_state_init() bothers me a bit, as
> it's the reverse of drm_atomic_helper_connector_tv_margins_state_init(),

You're right, I'll send a patch to align
__drm_atomic_helper_connector_hdmi_state_init() with the same convention
we have for all other _state_init helpers

Thanks!
Maxime

--3dlknviedupngxol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCatIdKgAKCRAnX84Zoj2+
doudAX9ZOIJ9ii7grzmwEBlIbxcHIBLrCwCHqqH+UNG1Ipuc2ZKysko7X6emV7xd
Li72/wgBgMbhkCoz+WFHBri43xj3JjtXclkJTb/CElWnoXIThy3p47d5Rc0rMlBC
IhGI2hPOww==
=RG6m
-----END PGP SIGNATURE-----

--3dlknviedupngxol--
