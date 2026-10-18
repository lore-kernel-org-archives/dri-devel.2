Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48740CCF2C9
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 18:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A878E10E21B;
	Sun, 18 Oct 2026 18:55:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9609910E21B
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 18:55:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D4D7C60D9D;
 Sun, 18 Oct 2026 18:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162311F000C4;
 Sun, 18 Oct 2026 18:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792349711;
 bh=2gSnxxp9+S2bdq0tAaJzYOQ5H57L6cyfrw3t5aQGaVE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GSMybtu33ErxpZVaCYMWIKIo2Pp8/KxyU8ZDNckbK07yOM+sPMCfV06OMW9wAdvTE
 qYNrCIAwJZGLZ1qebY6o3CEp5nxNXXH4MZugSgUrmiNVJrqGxNyYKwOHj2FNF+06wu
 cPaavWZTie+iw/kG5JVBnUzCj4ZFSHtmRJLO4sqaqssasE95rJalIxB3L0Q6wdcw4b
 1895Op1z2adzlmhVpDyJQNyR436XN+onmfTUwI7Yds0JsDg+kSZAuv1x78oIi4M8k4
 WMZQMPEy2olwIoEbtKREzh0e1a4pCjr6N/959raE5O05DlHnEvDbLEbFTCT35HHZeX
 rqD5Ez48Jtesg==
Date: Sun, 18 Oct 2026 19:55:07 +0100
From: Conor Dooley <conor@kernel.org>
To: tianshi12127 <tianshi12127@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: display: panel: add Smartisan TD4362
Message-ID: <20261018-directive-monopoly-4f8578c9a888@spud>
References: <20261017083531.766557-1-tianshi12127@gmail.com>
 <20261017103250.800109-1-tianshi12127@gmail.com>
 <20261017103250.800109-3-tianshi12127@gmail.com>
 <20261018-snorkel-mollusk-0bfba29ae1f8@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wXstIsICGwWqppAd"
Content-Disposition: inline
In-Reply-To: <20261018-snorkel-mollusk-0bfba29ae1f8@spud>
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

--wXstIsICGwWqppAd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 07:53:35PM +0100, Conor Dooley wrote:
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable


Hmm, my review shouldn't have been required.. You forgot to pick up tags
=66rom Krzysztof.

--wXstIsICGwWqppAd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCatUWCgAKCRB4tDGHoIJi
0gTsAP9VCGm12+AMkObL7EHRRfHpGWLXc8gfx6dt3Hwj8xb79gEAysfqkG8s7vYO
HZThuz48tY2zLwxH7QI4wg2OeRWrugU=
=PjOH
-----END PGP SIGNATURE-----

--wXstIsICGwWqppAd--
