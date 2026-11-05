Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCC0606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bFAS48f0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C62AC112288;
	Thu,  5 Nov 2026 09:15:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3212411225E;
 Thu,  5 Nov 2026 09:15:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 30E8860F3E;
 Thu,  5 Nov 2026 09:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B561F000C1;
 Thu,  5 Nov 2026 09:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793870111;
 bh=yuu8MRbvZ8Q99gVGDEWGPtvGQgcdEiYL3ohtAsA9Mfg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bFAS48f0dLcspAEXkjkArw9f5g1sLZat7q01f+HKggEbmSs8nuly01Er89M9cFC+E
 aJelUDSseJymE+2CsLiDv70w3W0f6o/p8FxgDHcsOPwgv1/JMp5POhaS6WYnvYb7K8
 zUzkNI/hkDRyloSNnZbNr8XotLbG+h1F+jOL0Hkb0Avr9U7fYBRpfR9C0mcxiQBR3s
 vMTD9J5x5SQw0X/qL4Os/hOqj2LHOa1MTSUUKJIb4NDus9wXA/2kpJ9BHnn9SLC4gw
 1auncQlq+pWnfmu6Sf7Gd8Hf0QutCtTy+KqQdynzeHMD3cDRsYlcu6hbTs5fM0MRzR
 2QGNBnbRrZdUQ==
Date: Thu, 5 Nov 2026 10:15:08 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 amd-gfx@lists.freedesktop.org, Russell King <linux@armlinux.org.uk>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Inki Dae <inki.dae@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 linux-samsung-soc@vger.kernel.org, Alison Wang <alison.wang@nxp.com>, 
 Stefan Agner <stefan@agner.ch>, Huacai Chen <chenhuacai@kernel.org>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>, 
 Mingcong Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Xi Ruoyao <xry111@xry111.site>, Geert Uytterhoeven <geert+renesas@glider.be>, 
 linux-renesas-soc@vger.kernel.org,
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Alain Volmat <alain.volmat@foss.st.com>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 linux-sunxi@lists.linux.dev, Jonathan Hunter <jonathanh@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>,
 Thierry Reding <thierry.reding@kernel.org>, 
 linux-tegra@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>, 
 Alex Lanzano <lanzano.alex@gmail.com>, Chia-I Wu <olvaffe@gmail.com>,
 David Airlie <airlied@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, virtualization@lists.linux.dev, 
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Melissa Wen <melissa.srw@gmail.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, 
 Danilo Krummrich <dakr@kernel.org>, Lyude Paul <lyude@redhat.com>,
 nouveau@lists.freedesktop.org
Subject: Re: [PATCH v3 00/37] drm/connector: Convert all drivers to
 atomic_create_state and remove reset
Message-ID: <auxJBtexUg6oHcs9@houat>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="2zvnwa2sqytkzb4j"
Content-Disposition: inline
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--2zvnwa2sqytkzb4j
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 00/37] drm/connector: Convert all drivers to
 atomic_create_state and remove reset
MIME-Version: 1.0

On Fri, Oct 30, 2026 at 04:13:30PM +0100, Maxime Ripard wrote:
> This is a follow-up to the plane and CRTC reset removal series, and
> part of a larger effort to remove the reset hook from all KMS objects.
>=20
> The connector reset hook is overloaded: it is called both at probe
> time to create the initial software state and during suspend/resume to
> reset hardware and software state. These two roles have different
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
> This series converts all connector drivers tree-wide from the reset hook
> to atomic_create_state, then removes the reset hook from struct
> drm_connector_funcs entirely. The conversions were done using a
> combination of Coccinelle semantic patches, mechanical one-line
> replacements and manual adjustments.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Applied to drm-misc-next

Maxime

--2zvnwa2sqytkzb4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCauxJHAAKCRAnX84Zoj2+
dpi6AYDFcyxVth1IfzYJl7Mk/wdU/UrwZChOoRG3vJ2c4jm3YXPwmaZCDBG4hPm/
E3dp1WQBf2Htv+GDvQkXS9avpT+uRjkpFRqowDqfaE0gXWHKwBFuo13bOFi12DLC
XPBNQCk6+w==
=O+mF
-----END PGP SIGNATURE-----

--2zvnwa2sqytkzb4j--
