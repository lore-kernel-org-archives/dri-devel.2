Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7E6606A33C
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWMoVAwa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2043288A3E;
	Mon, 23 Nov 2026 15:52:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86D9188A3E
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:52:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 576EB40E51;
 Mon, 23 Nov 2026 15:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8981F000CA;
 Mon, 23 Nov 2026 15:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795449141;
 bh=Pl0MmwLaYcXNuQgS+eqZhBDyPWDIJ4EPbUXDkKt6W0M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jWMoVAwat5TIKqc/PAdc9nhK8BLDCuz/FBYrkiMEZ1UXRhL4u7vzhiKmhxvzOI6IK
 BPX3C8mds5zlv/m6YzZDYusrpVdNwR6OXUurfrJuo9oukLOVWbR64lka1fudrjNJpU
 bi7Mr9tx0Mt9uXit9qcn+BgZ86J/NdAhUDrF4HX2iBT5i7VDP0xf3gmcKWkhc0KPCP
 QwwDgd9sFfkGPEujVNvZhmSvIWjWxlkbLYygFR8LMG+uer7vqYDNPG+TutOcdGwbP0
 ZFzN+RIVhvUsGnsV/iN6VQzu8S8rf8eJsVeXodhq1sNqinmWaBVxqMlKZDOkWSYcfu
 GhfF09IQN25nw==
Date: Mon, 23 Nov 2026 16:52:18 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>, 
 Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, kernel@collabora.com,
 linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/25] drm/tests: edid: Add 4K@60Hz EDID with 600MHz TMDS
Message-ID: <awRhHORNYR8MYT1R@houat>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
 <20261114-drm-conn-hdmi-cleanup-v1-15-20e8a33a2286@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="mfmvcyhwaviogczo"
Content-Disposition: inline
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-15-20e8a33a2286@collabora.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--mfmvcyhwaviogczo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 15/25] drm/tests: edid: Add 4K@60Hz EDID with 600MHz TMDS
MIME-Version: 1.0

On Sat, Nov 14, 2026 at 08:03:39PM +0200, Cristian Ciocaltea wrote:
> Add a new test EDID advertising the following capabilities:
>=20
> Max resolution: 3840x2160@60Hz with RGB, YUV444, YUV422, YUV420
> Max BPC:        16
> Max TMDS clock: 600 MHz
>=20
> This is needed to exercise the new HDMI infrastructure that decides
> whether scrambling needs to be enabled for a given display mode and
> to validate that high-rate modes are properly rejected/accepted
> depending on the source/sink scrambling capability.
>=20
> The EDID is derived from test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz
> with the following changes:
>=20
> - Upgraded the first DTD from 3840x2160@30 (297 MHz) to 3840x2160@60
>   (594 MHz).  The H/V totals (4400x2250) and porches already match the
>   HDMI 2.0 4K@60Hz standard timing, so only the pixel clock had to be
>   bumped.
> - Widened Display Range Limits descriptor to cover the new timing, i.e.
>   24-140 kHz H, max dotclock 600 MHz.
> - Updated CTA-861 Video Data Block to advertise VIC 97 (4K@60Hz) instead
>   of VIC 95 (4k30).
> - Bumped HF-VSDB Max TMDS Character Rate to 600 MHz, keeping
>   SCDC_Present set so that the sink advertises scrambling support.
> - Cleared HDMI VSDB Max TMDS clock byte, as required by HDMI 2.0 when
>   the HF-VSDB declares a Max TMDS Character Rate above 340 MHz.
> - Provided a Video Capability Data Block advertising selectable RGB and
>   YCC quantization range plus underscan for IT/CE formats; also set the
>   'IT Video Formats Underscanned' bit in the CTA-861 extension header to
>   match.
> - Aligned base block image size with the DTD (160x90 cm) and set the
>   Week of Manufacture to 0x00 instead of 0xff, since the Model Year
>   flag is not supported by EDID 1.3, so that the Model year field
>   becomes a regular Year of Manufacture.  Both fix inherited EDID
>   conformity failures.
> - Dropped the empty YCbCr 4:2:0 Video Data Block inherited from the
>   parent EDID, which is flagged as a failure by edid-decode v1.33.0
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/tests/drm_kunit_edid.c | 129 +++++++++++++++++++++++++++=
++++++
>  drivers/gpu/drm/tests/drm_kunit_edid.h |   1 +
>  2 files changed, 130 insertions(+)

Acked-by: Maxime Ripard <mripard@kernel.org>

Having a sample for that one would be nice too
Maxime

--mfmvcyhwaviogczo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCawRhMgAKCRAnX84Zoj2+
dsuzAX9eUHuod9rRrA9UBv1u0FRc0LXEgRaO1s73XLXMueRU0/hxIonKd82PEUwG
pYJHerUBfRMG4wrWnQ14mxmOD4sR1RLymRxwUxN1pHlEPSQ2RpEwL2SJ4TEm1ZTz
bVwXPmekKw==
=qCsv
-----END PGP SIGNATURE-----

--mfmvcyhwaviogczo--
