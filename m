Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E95606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 22:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i3sl42zw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8831810F8B1;
	Tue, 24 Nov 2026 22:57:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6775F10ED03;
 Tue, 24 Nov 2026 22:56:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3FC316126F;
 Tue, 24 Nov 2026 22:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527211F000CF;
 Tue, 24 Nov 2026 22:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795561009;
 bh=KQ2hSFjiGvivYXcIljlLRnSq85SW+19ujwKjv1vdt9s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=i3sl42zwh9fQTPPvkc12yB12JPeo4CpOEvf9P7NUy7TslArE3Oz0nPHSebOfB81Ap
 g8DeFkEPN9tfDezUtmWCDZ2gFjGq74cIKQErQEZkBHA3PyBvWaHeE406djz0Gs7G0V
 rMkdJ2l4nX8h4I70RJgISxprWoAHD6xBkm7ylVx08opnrM2fUr58B1Qa1MdixovLdn
 LIM5QzEOuOLvyIgT48yHtadGjb4Hydi5zJiJJQ6oEhGn9fhatHSg5r9wQWvIMTKiwI
 xoZTfqY2fz9YB2DGOjCxfpkiHNq9qzwpnpZI9A1A8huDk0moVp/MP4WE8E8KflWohS
 QaTbqg/9OGhkA==
Message-ID: <sashiko-outbox-232179@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/i915/bios: Attempt to match the VBT PnP ID
 against DisplayID first
To: "Ville Syrjala" <ville.syrjala@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20261124224621.6506-3-ville.syrjala@linux.intel.com>
References: <20261124224621.6506-1-ville.syrjala@linux.intel.com>
 <20261124224621.6506-3-ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 22:56:48 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/i915/bios: false VBT match in
  pnpid_displayid_get_panel_type()
--

commit b621730b3ac12390341a723bfb91f30971b56f98
Author: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

drm/i915/bios: Attempt to match the VBT PnP ID against DisplayID first

This commit attempts to match the VBT PnP ID against the DisplayID product =
ID
block before falling back to the base EDID vendor/product ID.

> diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/=
i915/display/intel_bios.c
> index 7b6a6f8c3cf19..8fbabf2e8b6f8 100644
> --- a/drivers/gpu/drm/i915/display/intel_bios.c
> +++ b/drivers/gpu/drm/i915/display/intel_bios.c
[ ... ]
> @@ -732,6 +727,48 @@ static int pnpid_get_panel_type(struct intel_display=
 *display,
>  	return best;
>  }
> =20
> +static int pnpid_edid_get_panel_type(struct intel_display *display,
> +				     const struct intel_bios_encoder_data *devdata,
> +				     const struct drm_edid *drm_edid, bool use_fallback)
> +{
> +	struct drm_edid_product_id product_id;
> +
> +	if (!drm_edid)
> +		return -1;
> +
> +	drm_edid_get_product_id(drm_edid, &product_id);
> +
> +	return pnpid_get_panel_type(display, &product_id, "EDID");
> +}
> +
> +static int pnpid_displayid_get_panel_type(struct intel_display *display,
> +					  const struct intel_bios_encoder_data *devdata,
> +					  const struct drm_edid *drm_edid, bool use_fallback)
> +{
> +	struct drm_displayid_product_id displayid_id;
> +	struct drm_edid_product_id product_id;
> +
> +	if (!drm_edid)
> +		return -1;
> +
> +	drm_displayid_get_product_id(drm_edid, &displayid_id);
> +
> +	/*
> +	 * Only the first two bytes of the OUI get
> +	 * smashed into the old EISA/PNPID field, and
> +	 * that gets matched against what's in the VBT.
> +	 */
> +	product_id.manufacturer_name =3D
> +		cpu_to_be16((displayid_id.vendor_id[0] << 8) |
> +			    displayid_id.vendor_id[1]);
> +	product_id.product_code =3D displayid_id.product_code;
> +	product_id.serial_number =3D displayid_id.serial_number;
> +	product_id.week_of_manufacture =3D displayid_id.week_of_manufacture;
> +	product_id.year_of_manufacture =3D displayid_id.year_of_manufacture;
> +
> +	return pnpid_get_panel_type(display, &product_id, "DisplayID");
> +}

[Severity: High]
Can pnpid_displayid_get_panel_type() falsely match an unpopulated VBT PnP ID
entry when the EDID has no DisplayID Product ID block?

drm_displayid_get_product_id() zeroes displayid_id up front and leaves it
zero-filled if no DisplayID Product ID block is present. Passing the result=
ing
all-zero product_id into pnpid_get_panel_type() will match the first unused
(all-zero) slot among the 16 entries in BDB_LFP_DATA, causing get_panel_typ=
e()
to select that unpopulated VBT panel index via PANEL_TYPE_PNPID_DISPLAYID
instead of falling back to PANEL_TYPE_PNPID_EDID.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124224621.6506=
-2-ville.syrjala@linux.intel.com?part=3D2
