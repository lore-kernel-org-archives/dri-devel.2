Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61002F53D76
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 17:16:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA11810E3FE;
	Mon, 16 Mar 2026 17:16:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lV3o+FQK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5621810E3ED
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 17:16:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C9D9960097;
 Mon, 16 Mar 2026 17:16:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C87C19421;
 Mon, 16 Mar 2026 17:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773681370;
 bh=6LmWPTZ/Wg2pBGtohG0Ur/9CqBjO5FCLHf+6zdpUR6I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lV3o+FQKmNNn7HspUM9dsacv+6GjqRIAdGFLZM6/mwsB1VNXctFqXUJSk04vZLgly
 E9FXbaW1d24eD+MJeX+CR2lGzj4/iNFw6bCt+VoPV3AsWCzGTz3RUH8RQJdpwFiaH4
 L9eMi/E5vBHU7BqItJA7zmT3v8h/nHIbhF5YUA3ueh02HCSxOdtnsGIGA/h6P+N/Zj
 QWlpmBNxDUoFd9gcBUsSs/He+4VH8Xei98P/uCpeIQq5OnN+aEAJZHixJTnyL9MZSY
 3GvgA2sgf496joKi/RTQ1wrMW9lWkYvFnMtF/dw/dxqGnyNxiBlfr4xSKaV7u7YNuH
 ynUwHLz7cqq9w==
Date: Mon, 16 Mar 2026 18:16:07 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/14] drm/atomic: Drop drm_private_state.obj assignment
 from create_state
Message-ID: <20260316-lumpy-jackdaw-of-downpour-10a890@houat>
References: <20260310-drm-mode-config-init-v1-0-de7397c8e1cf@kernel.org>
 <20260310-drm-mode-config-init-v1-2-de7397c8e1cf@kernel.org>
 <20260316154913.GE31616@killaraus.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="oun657mnxvl2buei"
Content-Disposition: inline
In-Reply-To: <20260316154913.GE31616@killaraus.ideasonboard.com>
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


--oun657mnxvl2buei
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 02/14] drm/atomic: Drop drm_private_state.obj assignment
 from create_state
MIME-Version: 1.0

Hi Laurent,

Thanks for your review

On Mon, Mar 16, 2026 at 05:49:13PM +0200, Laurent Pinchart wrote:
> On Tue, Mar 10, 2026 at 05:06:54PM +0100, Maxime Ripard wrote:
> > The initial intent of the atomic_create_state helper was to simply
> > allocate a proper drm_private_state and returning it, without any side
> > effect.
> >=20
> > However, the __drm_atomic_helper_private_obj_create_state() introduces a
> > side effect by setting the drm_private_obj.state to the newly allocated
> > state.
> >=20
> > This assignment defeats the purpose, but is also redundant since
> > the only caller, drm_atomic_private_obj_init(), will also set this
> > pointer to the newly allocated state.
>=20
> __drm_atomic_helper_bridge_reset() is called in many places. Most of
> them are .atomic_create_state() handlers, called from
> drm_atomic_private_obj_init() only. The only exception is
> __drm_atomic_helper_bridge_reset().

__drm_atomic_helper_bridge_reset (and any bridge reset implementation)
is also called through atomic_create_state and
drm_atomic_private_obj_init(), so there's nothing special about it.

Maxime

--oun657mnxvl2buei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCabg60wAKCRAnX84Zoj2+
dnU4AYCuEyiXgv3cybTH7SWACE5/V+hfw6e2wgFRaG9UpIXSl7/mSglBbkRVOA/v
kT/T7x0Bf3bTigOLUzyCx6DbYn3+Xek8KAsMkBq0mNX5eoDVDR8cPjnVVqphtvff
kp9Uhw3c1Q==
=8w94
-----END PGP SIGNATURE-----

--oun657mnxvl2buei--
