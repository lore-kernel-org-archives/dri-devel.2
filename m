Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1463C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A6B10E3A1;
	Fri, 11 Sep 2026 13:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nzqxYvp7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A6E010E3A1;
 Fri, 11 Sep 2026 13:14:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E5AA543ACF;
 Fri, 11 Sep 2026 13:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D7E1F000FF;
 Fri, 11 Sep 2026 13:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789132479;
 bh=UGb3d1QF1KN1V+MPH6MizXgRVdN4vmR+Fh52j8sRt6k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nzqxYvp7pFQLFkb5clbOea+ylh1AZlAidBGWAOM1UQd5m31g5PGLAtheAeOK5nGlv
 GmAwqefgLsk/6i5z8tcdsjlgZlG/kNovJzNm9B01yZpP3Rc35FEGPmc/MDV6mf16/C
 eKSz2RuKm/bJwRgjH6TSR06m4G3D2Pckzj6UFELrsBFZz1v1Nna4vEXgElGc5fey0v
 xLz78CYi5aoesH/B4HUzbg007M3j7KbZ6T3tSi2mdwE2Sw2x3cqquW8KPquJ+kVETO
 Ft3pDbpUrj6EZu0FyCJHK5FWia2FTAppQNmF+lA3I5ZvrgVs7w75bbNsJom5cp+oW7
 P3XWRNPgUE6LA==
Date: Fri, 11 Sep 2026 15:14:36 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 amd-gfx@lists.freedesktop.org, Paul Kocialkowski <paulk@sys-base.io>, 
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>, 
 Mingcong Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Xi Ruoyao <xry111@xry111.site>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Iker Pedrosa <ikerpedrosam@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v3 00/13] drm/crtc: Convert all drivers to
 atomic_create_state and remove reset
Message-ID: <aqP-iPav3cELqcB4@houat>
References: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="6wjfd6ziw2wstkdb"
Content-Disposition: inline
In-Reply-To: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
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


--6wjfd6ziw2wstkdb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 00/13] drm/crtc: Convert all drivers to
 atomic_create_state and remove reset
MIME-Version: 1.0

On Fri, Sep 04, 2026 at 11:07:18AM +0200, Maxime Ripard wrote:
> This is a follow-up to the plane reset removal series, and part of a
> larger effort to remove the reset hook from all KMS objects.
>=20
> The CRTC reset hook is overloaded: it is called both at probe time to
> create the initial software state and during suspend/resume to reset
> hardware and software state. These two roles have different
> requirements, and the reset hook is not fallible, making error
> handling difficult for the initial state allocation path.
>=20
> While reset has the semantics to reset both the software and hardware
> state, the vast majority of implementations and all the helpers only
> reset the software state, making them equivalent to
> atomic_create_state in practice. The atomic_create_state hook makes
> this explicit: it only allocates and initializes a pristine state
> without any side effect, and returns the state pointer or an ERR_PTR
> on failure.
>=20
> This series converts all CRTC drivers tree-wide from the reset hook to
> atomic_create_state, then removes the reset hook from struct
> drm_crtc_funcs entirely. Two drivers (tilcdc and loongson) had actual
> hardware reset logic mixed into their reset hook; those are moved to
> CRTC creation instead. The conversions were done using a combination of
> Coccinelle semantic patches and manual adjustments.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---

Pushed all patches but the ones removing the helpers and hook because
it would break the latest gm12u320 commit.

Maxime

--6wjfd6ziw2wstkdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaqP+uwAKCRAnX84Zoj2+
dpHcAYCQGKLwxrIwsOvoEEjG16dk17m4cLPtWAg9OIAtOKNSnhbz2AH9ShDWdD21
8uiVv/IBgIJcbH09hXRQfgVTQOSSPzgzjW9CCZBk64J8Tg+lvXaDhGANJPsKXTB1
84iDeAc97Q==
=z7L2
-----END PGP SIGNATURE-----

--6wjfd6ziw2wstkdb--
