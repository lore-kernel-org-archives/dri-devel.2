Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C67606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DquInywc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EB1810E667;
	Fri,  6 Nov 2026 13:57:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDDB5112DBD
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:57:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D0D1E605EB
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA211F0089F;
 Fri,  6 Nov 2026 13:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793973453;
 bh=1kQxbp2OCusxFyNc/kVBro7U8NHmWMvoOddm8d7GYII=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DquInywcr83pOLMFJpNZ5GuVxbHacK5pxT1CcjD7bSYM86O6kQdLw+Qrgp08Kblg8
 cVW7IxqDHmxrgWk6UbvqCMGdp9ze5smGwSaevhcn3/hA3v8TNHmEslfENfa5I//CNg
 Ao5AkkViFJ3p3wRud2WN+6tTgd/TRtVII+plfauOr66lQgAdFl9W8dRGypQNBxL9bl
 fFmnvBGxu62ndOKaZJtl/CHI87pWHlJxqgHEeRPpg1MJknYu8GdNPhpFlHRkjK7CWR
 RItXrd1+xvO95lN/RK4MWcUsMTrOUP6OWHOOQ/L+OSNjqeCn5KTxeVY3+xH/HO8ku4
 GzUh/+xTbyaIA==
Message-ID: <sashiko-outbox-201513@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 39/39] fixup! drm/tidss: Implement readout support
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106-drm-state-readout-v8-39-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
 <20261106-drm-state-readout-v8-39-cbe78624e1bc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 13:57:32 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/tidss: oldi: bus flags mismatch in
  tidss_oldi_bridge_readout_state()
- [Low] drm/tidss: oldi: unsquashed fixup commit and unused header
  includes
--

commit cca2438eb6832da31ab86d7cdd455e9f4115f969
Author: Maxime Ripard <mripard@kernel.org>

fixup! drm/tidss: Implement readout support

This commit adds atomic state and connector hardware readout callbacks for
the TI DSS OLDI bridge.

> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/t=
idss_oldi.c
> index 82b059f852449..7dbfbb380205e 100644
> --- a/drivers/gpu/drm/tidss/tidss_oldi.c
> +++ b/drivers/gpu/drm/tidss/tidss_oldi.c
> @@ -5,6 +5,7 @@
>   * Aradhya Bhatia <a-bhatia1@ti.com>
>   */
> =20
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/of.h>
>  #include <linux/of_graph.h>
> @@ -13,8 +14,12 @@
>  #include <linux/regmap.h>
> =20
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_atomic_state_readout.h>
> +#include <drm/drm_atomic_state_readout_helper.h>
>  #include <drm/drm_bridge.h>
> +#include <drm/drm_connector.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>

[Severity: Low]
This isn't a bug, but <linux/bitfield.h> and <drm/drm_panel.h> are not used
in tidss_oldi.c.  Also, this commit is still formatted as an unsquashed
"fixup!" patch with a placeholder commit message instead of being squashed
into commit "drm/tidss: Implement readout support" or given a full
changelog.

[ ... ]

> @@ -351,6 +356,135 @@ tidss_oldi_mode_valid(struct drm_bridge *bridge,
>  	return 0;
>  }

[ ... ]

> +static int
> +tidss_oldi_bridge_readout_state(struct drm_bridge *bridge,
> +				struct drm_atomic_sro_state *state,
> +				struct drm_bridge_state *bridge_state,
> +				struct drm_crtc_state *crtc_state,
> +				struct drm_connector_state *conn_state)
> +{

[ ... ]

> +	/*
> +	 * tidss_oldi_atomic_check() forces positive edge sampling on
> +	 * the input side, and the DE polarity is programmed from the
> +	 * negotiated flags: OLDI_DEPOL is set when the DE is active
> +	 * low.
> +	 */
> +	bridge_state->input_bus_cfg.flags =3D
> +		DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
> +		DRM_BUS_FLAG_SYNC_SAMPLE_POSEDGE |
> +		((cfg & OLDI_DEPOL) ? DRM_BUS_FLAG_DE_LOW :
> +				      DRM_BUS_FLAG_DE_HIGH);
> +
> +	bridge_state->output_bus_cfg.flags =3D
> +		(cfg & OLDI_DEPOL) ? DRM_BUS_FLAG_DE_LOW :
> +				     DRM_BUS_FLAG_DE_HIGH;
> +
> +	return 0;
> +}

[Severity: Medium]
Will input_bus_cfg.flags and output_bus_cfg.flags mismatch the committed
state during drm_atomic_helper_bridge_compare_state() when the downstream
panel or bridge sets other bus flags or omits DE polarity?

During atomic check, drm_atomic_bridge_propagate_bus_flags() copies the
downstream bridge's input_bus_cfg.flags (populated by panel_bridge from
connector->display_info.bus_flags) into both output_bus_cfg.flags and
input_bus_cfg.flags, and tidss_oldi_atomic_check() only adjusts the sampling
edge flags on input_bus_cfg.flags:

drivers/gpu/drm/tidss/tidss_oldi.c:tidss_oldi_atomic_check() {
	bridge_state->input_bus_cfg.flags &=3D
		~(DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
		  DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE);

	bridge_state->input_bus_cfg.flags |=3D
		DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
		DRM_BUS_FLAG_SYNC_SAMPLE_POSEDGE;
}

For LVDS panels driven by panel-lvds (which sets
DRM_BUS_FLAG_DATA_MSB_TO_LSB or DRM_BUS_FLAG_DATA_LSB_TO_MSB in
display_info.bus_flags) or panels that leave both DE polarity flags unset,
the committed bridge state retains those flags in input_bus_cfg.flags and
output_bus_cfg.flags, whereas tidss_oldi_bridge_readout_state() reconstructs
only DRM_BUS_FLAG_DE_LOW or DRM_BUS_FLAG_DE_HIGH from OLDI_DEPOL.  Every
blocking atomic modeset on those panels will therefore report a bridge state
readout mismatch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-drm-state-=
readout-v8-0-cbe78624e1bc@kernel.org?part=3D39
