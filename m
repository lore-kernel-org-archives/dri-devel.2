Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC2ACD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 08:13:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9096710EF5C;
	Wed, 20 May 2026 08:13:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MYEcv73G";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC0E10EF5C
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:13:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D656D43598;
 Wed, 20 May 2026 08:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FD91F00893;
 Wed, 20 May 2026 08:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779264809;
 bh=ofj1QBLosAJ6MjG9bGbKS/xmNiUDX078zVrBGdg2mdY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MYEcv73GahqqzMnESiREFw0ujv+pJ3yLcU6ZX98LRTq7pXGnV+1HkEM3Yhp4JALJo
 AmFuAQgObMR0S/MMrB/pn+/Z9/g9BLBQVmlMuX8f43eo6q4T0gbSHEZQhGN2DRgoPt
 2WnAiDwWQIcb6rMfplggsPhfkgq7DvWl3wSldXHLXFrlhuagLozVRC5JtkFP0ygLDF
 KD0aqPiJRTrQU1tkX9PTNZSz1+TxP6Jhc6rZv58gEDuYfWrTxFE1saga42OFxP7rEH
 UoY5Gq0ILtBrlAJCNVVMGWtanj8pGxNKljRrM8S8LJhQX+hLaV9KEAT9I255u1j7zM
 Ceb5yiLNTGchw==
Date: Wed, 20 May 2026 10:13:26 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org, 
 David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/8] drm/display: hdmi: Add common TMDS character rate
 constants
Message-ID: <20260520-yellow-panther-of-dew-de32eb@penduick>
References: <20260519144712.1418302-1-javierm@redhat.com>
 <20260519144712.1418302-2-javierm@redhat.com>
 <78506dc5f7ff02a2bdd05de1170a1cb3e33e1abe@intel.com>
 <875x4iy1em.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="pqsdc74wx5gmougt"
Content-Disposition: inline
In-Reply-To: <875x4iy1em.fsf@ocarina.mail-host-address-is-not-set>
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


--pqsdc74wx5gmougt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/8] drm/display: hdmi: Add common TMDS character rate
 constants
MIME-Version: 1.0

On Wed, May 20, 2026 at 09:40:17AM +0200, Javier Martinez Canillas wrote:
> Jani Nikula <jani.nikula@intel.com> writes:
>=20
> Hello Jani,
>=20
> > On Tue, 19 May 2026, Javier Martinez Canillas <javierm@redhat.com> wrot=
e:
>=20
> [...]
>=20
> >> =20
> >> +/* HDMI spec TMDS character rate limits (in Hz) */
> >> +#define DRM_HDMI_TMDS_CHAR_RATE_MIN	25000000
> >> +#define DRM_HDMI_TMDS_CHAR_RATE_MAX_1_0	165000000
> >> +#define DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3	340000000
> >> +#define DRM_HDMI_TMDS_CHAR_RATE_MAX_2_0	600000000
> >
> > Usually everything in DRM is in kHz, and Hz is the exception.
> >
>=20
> That is correct but in this case these constants are to be used with the
> HDMI helpers. Both struct drm_connector_hdmi_state.tmds_char_rate and
> the struct drm_bridge_funcs.hdmi_tmds_char_rate_valid() callback expect
> the TMDS char rate to be defined in Hz.
>=20
> If we define these in kHz, it means that drivers will have to * 1000 at
> every call site.

As long as the unit is obvious from the name, I think we'll be fine, and
we can even have both Hz and kHz defines if we want to.

> > I'm also not sure the 1_0, 1_3, and 2_0 really help anyone reading the
> > code. I won't remember what they mean in Hz or kHz, and I'll have to
> > look them up every single time.
> >
>=20
> I discussed this with Maxime before posting the patches since I wondered
> the same. He suggested that the max TMDS character rate was linked to the
> HDMI spec versions and that it would be more readable to name it using
> the spec version rather than the resolution.

As usual, it's both the spec and hardware capabilities. But some like
the HDMI 1.3/1.4 max is used to know where to setup the scrambler for
example, and is used everywhere.

I still think it has value, but we don't have to force anyone to use
them either.

I'd prefer to use the DRM_HDMI_$SPEC_TMDS_CHAR_RATE_MAX_HZ though

> The other naming I suggested was:
>=20
> /* HDMI spec TMDS character rate limits (in Hz) */
> #define DRM_HDMI_TMDS_CHAR_RATE_MIN		 25000000
> #define DRM_HDMI_TMDS_CHAR_RATE_74_25MHZ	 74250000
> #define DRM_HDMI_TMDS_CHAR_RATE_148_5MHZ	148500000
> #define DRM_HDMI_TMDS_CHAR_RATE_297MHZ		297000000
> #define DRM_HDMI_TMDS_CHAR_RATE_MAX_1_4		340000000

Honestly, I'm not sure if it's worth defining if we'll have the
frequency in the define name.

Maxime

--pqsdc74wx5gmougt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCag1tHQAKCRAnX84Zoj2+
dgqzAX45V1iYWii1/7p9SWRWf9JOO0p1K1RfgdEb4sSgVZUQhsxsK/OXiZgqOO2A
rgzcYI8BgMNoa9IpQdq0m01WRFLURicJVBGtAQUxVsg56qKscPzmjnkID61PVqqY
SCUG0N0G2Q==
=+4dU
-----END PGP SIGNATURE-----

--pqsdc74wx5gmougt--
