Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EE6606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hSPdICTS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5BAB10E11D;
	Mon, 26 Oct 2026 16:05:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA3C110E11D
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 16:05:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7ECBC4140A;
 Mon, 26 Oct 2026 16:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AD51F01828;
 Mon, 26 Oct 2026 16:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793030719;
 bh=X4P9doNSSZHi7xDs27qdq6a7tMm8EvHZftTfeAFfVDA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hSPdICTSQHVA6woacBjH3rS9q9RZFs3lEswVKkoXLSu8osSW/FrZaiEZuJeyqxyqk
 CsEw0JhKSqar7mioxkx77h9BJE7hubn+kBt0MD8Y1FGSpVFdu/S3S/n9EdNCrmU90+
 j49j+UJkMwwEJgWejpndXqVSdemwjEGNEj3apbyHKrb/2dVUHpXFlq3F8q+QzyKt35
 GVylu4ErOYjaz6dEo+UqLxi1Umt/LPre+gvAh7L0yn7ZhCLckloIN5t0+vzvGHfQBu
 RDhjZv/aKo3dpZUzrMKivWUrZAgDSi7jy8tyNI+aotuu9omuPrfQk190KW4RwXGWxE
 1fiENVWLVHqUQ==
Date: Mon, 26 Oct 2026 17:05:15 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/bridge: sii902x: Read "sil,i2s-data-lanes" as u32
Message-ID: <at96EnXnYQrZmsA7@houat>
References: <20260831203137.1331960-1-robh@kernel.org>
 <CAL_Jsq+FErjac-iqe+okjjqw9ZwR57w2zrVSt--8aTuegdsstQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="p3z64vdjulzwtl2r"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+FErjac-iqe+okjjqw9ZwR57w2zrVSt--8aTuegdsstQ@mail.gmail.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--p3z64vdjulzwtl2r
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] drm/bridge: sii902x: Read "sil,i2s-data-lanes" as u32
MIME-Version: 1.0

On Mon, Oct 26, 2026 at 10:25:13AM -0500, Rob Herring wrote:
> On Mon, Aug 31, 2026 at 3:32=E2=80=AFPM Rob Herring (Arm) <robh@kernel.or=
g> wrote:
> >
> > The "sil,i2s-data-lanes" binding and in-tree DTS files use normal
> > uint32 cells. Reading the array as u8 only works because the values are
> > small, but it does not match the documented DT element size.
> >
> > Use the u32 array helper so the driver follows the binding. Changing to
> > u32 increases a potential OOB access range due to using unchecked
> > values, so add a check on the read values.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> > v3:
> >  - Drop the WARN_ON.
> >  - Combine checking the values with any other error parsing the DT
> >    property. The exact DT error isn't important.
> >
> > v2:
> >  - Add bounds check for property values as reported by sashiko
> > ---
> >  drivers/gpu/drm/bridge/sii902x.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
>=20
> Ping. Can I get an ack on this to apply it.

Acked-by: Maxime Ripard <mripard@kernel.org>

Alternatively, I can apply it to the drm-misc tree

Maxime

--p3z64vdjulzwtl2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCat96MgAKCRAnX84Zoj2+
dqYwAYDXonET/fuL7fXP2GUp8qHQ+utLWPUgECflw8z149gOxBaYH7tmxn2GeSSW
e6WxSTQBf0vEZS51BMvfLNUgIMgkB8Ll6XHv9aRrH8wZDzkoPa15+2abYm3X01UU
CFjgMezpEQ==
=BTnA
-----END PGP SIGNATURE-----

--p3z64vdjulzwtl2r--
