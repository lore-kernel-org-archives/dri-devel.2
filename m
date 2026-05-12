Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E794CD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 17:05:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8178310E296;
	Tue, 12 May 2026 17:05:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cq+cGsMb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE83810E296
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 17:05:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5C82D4181F;
 Tue, 12 May 2026 17:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2984C2BCB0;
 Tue, 12 May 2026 17:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778605535;
 bh=diGQRJnzbKWWmx30Bj9r7KM1Fe9Mi03kTXpmxciu5pU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Cq+cGsMbH1q5GgvCqapj/d+kxHrNG1+8ZRNC9sKo2v0L96xCtRCa24TgW/19XdRB+
 u2XVHsvtvcVev3CSWlHduLHsrx/O1EJwNTnjZgEj3c+sBFhzXdyLNPyJs34TU7xgOW
 T5Lh/4nvl9IwkkYeoX+Bgn0jEivmkg9B2obQpc4GpZ2S3acX0EfDUEtoFMqGq1LLGI
 BXlwpBfW/6ZmjKkFszvQSIywHrmE2Ht704CPt/NuXUXcwLJ/U7OBFFsX5jfLekRRak
 suvlfZgGlXXglpAEURz/eK/2jH+IjtF3EroHUGGRZipFNu0ZrgXsjt0fOfG23gA8ZG
 ++SJW0XvAnMgA==
Date: Tue, 12 May 2026 18:05:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Boerge Struempfel <bstruempfel@data-modul.com>
Cc: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display/bridge: lt9211: Add
 drive-strength-microamp property
Message-ID: <20260512-void-gravitate-68ebce8e76da@spud>
References: <20260512164609.3390700-1-bstruempfel@data-modul.com>
 <20260512164609.3390700-2-bstruempfel@data-modul.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Bu2OKcobMenC00G9"
Content-Disposition: inline
In-Reply-To: <20260512164609.3390700-2-bstruempfel@data-modul.com>
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


--Bu2OKcobMenC00G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 06:46:08PM +0200, Boerge Struempfel wrote:
> Add the 'drive-strength-microamp' property to allow board DTs to
> configure the LT9211 LVDS TX output driver current. Sixteen discrete
> levels are supported, ranging from 12 uA to 36 uA. Defaults to 25 uA.
>=20
> Signed-off-by: Boerge Struempfel <bstruempfel@data-modul.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--Bu2OKcobMenC00G9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagNd2QAKCRB4tDGHoIJi
0quOAP0YtSiGVK0u6HlMaNoQSRfH6N+7MdZh3gClUB6c82x3jQD/cQvWO7p1zPgd
2RRVYhUc+CRUP8hUaPj8tfiauR3hbw4=
=Q0y0
-----END PGP SIGNATURE-----

--Bu2OKcobMenC00G9--
