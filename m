Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24350606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RkSBiodO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8949810E2D3;
	Wed, 11 Nov 2026 11:13:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79B8510E2D3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 11:13:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B7B263C86;
 Wed, 11 Nov 2026 11:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965981F00A05;
 Wed, 11 Nov 2026 11:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794395620;
 bh=36EWbltYP1E9t7Yv3ApaDJEPV9SCfDDIWUtGCljX8yg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RkSBiodOgR4Vu3WoOamr63RiGELqBdARbGedG+t/PZFNJ1wURAsulgYkgjo6Hhp7o
 n46m3vAu39vQNRhG/chrRTaHfHnwG2/oEdt6h9z5OUFKABcyAMWHBg3UGEEp9JGMbV
 m4YTC24KWs9dYPwJoaQOkj6jvX/8/n8J6Kre+2HCN0Ln2gKIAXcbV3m6tLyyw54KVB
 151tpV9b+zxFfBCF1fpDGsymzjpD9DHgICSS9xfP+o6pGmt6s3FXxUqLbBXbgMa5d6
 Uz17XUv2nAqGV+8RKeQQ3KgKMzjigERffx3ZJNNVRwaof7iqSbCNhVt26lYw1PMDrV
 /RAeTCzc1TQVg==
Date: Wed, 11 Nov 2026 12:13:37 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Joel Selvaraj <jo@jsfamily.in>, Jagan Teki <jagan@amarulasolutions.com>, 
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michael Tretter <m.tretter@pengutronix.de>, 
 Cristian Cozzolino <cristian_ci@protonmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Ryan Brue <ryanbrue.dev@gmail.com>, Nickolay Goppen <setotau@mainlining.org>, 
 Robert Chiras <robert.chiras@nxp.com>, Alexander Koskovich <akoskovich@pm.me>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
 Barnabas Czeman <barnabas.czeman@mainlining.org>,
 Heiko Stuebner <heiko@sntech.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Arpit Saini <arpit.saini@oss.qualcomm.com>, 
 Michael Walle <mwalle@kernel.org>, Ritesh Kumar <quic_riteshk@quicinc.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Konrad Dybcio <konradybcio@kernel.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Danila Tikhonov <danila@mainlining.org>,
 Jens Reidel <adrian@travitia.xyz>, Michael Srba <Michael.Srba@seznam.cz>, 
 Shawn Guo <shawn.guo@linaro.org>, Alexandre Mergnat <amergnat@baylibre.com>, 
 Alexander Baransky <sanyapilot496@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Romain TISSERAND <romain.tisserand@gmail.com>
Subject: Re: [PATCH] dt-bindings: display: panel: Make DSI panels port optional
Message-ID: <avRM_GhtR8vMdTO4@houat>
References: <20261111110338.81717-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="nbzsbrbfjlpcpmzq"
Content-Disposition: inline
In-Reply-To: <20261111110338.81717-2-krzysztof.kozlowski@oss.qualcomm.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--nbzsbrbfjlpcpmzq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: display: panel: Make DSI panels port
 optional
MIME-Version: 1.0

On Wed, Nov 11, 2026 at 12:03:39PM +0100, Krzysztof Kozlowski wrote:
> DSI panels can be placed under DSI bus directly and many Linux DRM
> drivers will work fine with it: mipi_dsi_host_register() adds device for
> such panel and DRM driver does not use OF graph to configure lanes.

That's not true. We do use the endpoints to configure the lanes through
the data-lanes property. See drm_of_get_data_lanes*

> The affected here Linux panel drivers do not use OF graph, either.
>=20
> Requiring graph port for such panels is tying the binding to one
> specific implementation of Linux DRM drivers, e.g. Qualcomm DRM which
> requires the port.  The port is not needed for the hardware to operate
> and for some of the Linux drivers, so it should be optional.
>=20
> Suggested-by: Romain TISSERAND <romain.tisserand@gmail.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

DSI busses can handle multiple devices, and multiple data types. If we
were to drop the port node, how does the upstream video device know
which device it should send its video output to?

Maxime

--nbzsbrbfjlpcpmzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCavRN4AAKCRAnX84Zoj2+
drBoAYCgtYU8iP34m/O3qAL8jHZ6w3VHZjiW2G37PLPh+1PFoVvjBC5GoEu8ff00
+lWRtM4BgMgudwnDPpuPHEgx+ZAkUZcDuzAaKvmq6V8XHDLf+ZJORjMRqukb+pNm
/OfusQSCIw==
=MTke
-----END PGP SIGNATURE-----

--nbzsbrbfjlpcpmzq--
