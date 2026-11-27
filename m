Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBFF60A263B
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUCfIr7H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FCE510E47D;
	Fri, 27 Nov 2026 10:13:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0167D10E47D
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:13:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1684461267
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541E31F00925;
 Fri, 27 Nov 2026 10:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795774408;
 bh=gJZfc+BhTmfMGhKcQmEe3AaO+IVYmGcsv/mohd4flZM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dUCfIr7HBFnkz8awF0OOxs+MDD0GAK7OgP8+W6YML5qZtCy/BRHq5e1utw4o5XGoE
 dcrJUn/yWpEChrIchI9ZrEf1rC5U1qxnYvql7cN98BQBT4R4ZMvph9Y7awocufESfL
 laYqkf8wY3HgMSq6KH/VSZN33DSo/gsteGJPT3O2NhB/YysQ2yWyjYgYtGaW7FHnTe
 hOQ/hxCy2mpEJP0utr6QrKjh8FgYfecrnaY/FqccljCzE6gGumtBUc1+SbYgGuOcxA
 tdnIoVeHhojvdY+uEpDG6kBtsalGS4USRa1G2rXQgx96hdha3R2ZMAaVChUk/xDMvw
 SPHr5xbmQULJg==
Message-ID: <sashiko-outbox-237067@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 26/36] drm/tidss: dispc: Add hardware state readout
 helpers
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261127-drm-state-readout-v10-26-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
 <20261127-drm-state-readout-v10-26-0259582d45a8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 10:13:27 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/tidss: bus_flags readout mismatch in
  dispc_vp_get_bus_flags()
--

commit 975b444202a6ec88f77002c0d3c2a5c2918b276b
Author: Maxime Ripard <mripard@kernel.org>

drm/tidss: dispc: Add hardware state readout helpers

This commit adds DISPC register readout helpers for video ports, overlay
routing, and planes so the driver can reconstruct KMS state from hardware.

> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/=
tidss_dispc.c
> index e186c63ba5fb9..15395e06f3f83 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
[ ... ]
> @@ -1401,6 +1408,151 @@ int dispc_vp_set_clk_rate(struct dispc_device *di=
spc, u32 hw_videoport,
[ ... ]
> +u32 dispc_vp_get_bus_flags(struct dispc_device *dispc, u32 hw_videoport)
> +{
> +	u32 flags =3D 0;
> +	u32 val;
> +
> +	val =3D dispc_vp_read(dispc, hw_videoport, DISPC_VP_POL_FREQ);
> +	if (FIELD_GET(DISPC_VP_POL_FREQ_IPC_MASK, val))
> +		flags |=3D DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE;
> +	else
> +		flags |=3D DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE;
> +
> +	if (FIELD_GET(DISPC_VP_POL_FREQ_IEO_MASK, val))
> +		flags |=3D DRM_BUS_FLAG_DE_LOW;
> +	else
> +		flags |=3D DRM_BUS_FLAG_DE_HIGH;
> +
> +	if (FIELD_GET(DISPC_VP_POL_FREQ_RF_MASK, val))
> +		flags |=3D DRM_BUS_FLAG_SYNC_DRIVE_POSEDGE;
> +	else
> +		flags |=3D DRM_BUS_FLAG_SYNC_DRIVE_NEGEDGE;
> +
> +	return flags;
> +}

[Severity: Medium]
Can dispc_vp_get_bus_flags() return bus_flags that mismatch the committed
CRTC and encoder bridge states?

tidss_bridge_atomic_check() stores next_bridge_state->input_bus_cfg.flags
(or connector->display_info.bus_flags) directly into
tcrtc_state->bus_flags without normalizing unset polarity flags or
stripping non-polarity flags, while dispc_vp_prepare() programs
DISPC_VP_POL_FREQ by defaulting unset polarity bits to 0:

drivers/gpu/drm/tidss/tidss_dispc.c:dispc_vp_prepare() {
    ...
	ieo =3D !!(tstate->bus_flags & DRM_BUS_FLAG_DE_LOW);

	ipc =3D !!(tstate->bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE);

	/* always use the 'rf' setting */
	onoff =3D true;

	rf =3D !!(tstate->bus_flags & DRM_BUS_FLAG_SYNC_DRIVE_POSEDGE);
    ...
}

Because dispc_vp_get_bus_flags() unconditionally sets all three polarity
flags and cannot recover non-polarity flags (such as
DRM_BUS_FLAG_DATA_MSB_TO_LSB from panel-lvds, or an omitted polarity flag
on panels like rocktech,rk101ii01d-ct), post-commit state readout
verification in tidss_crtc_compare_state() and
drm_atomic_helper_bridge_compare_state() will report a bus_flags mismatch
on every commit for those pipelines.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-drm-state-=
readout-v10-0-0259582d45a8@kernel.org?part=3D26
