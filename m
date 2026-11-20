Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421B606A32A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W1ffgtcy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 977F4112A4C;
	Fri, 20 Nov 2026 13:18:00 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 739F3112A4B
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:17:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D06243C78
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AFD1F000E0;
 Fri, 20 Nov 2026 13:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795180670;
 bh=TwDuIu6v5GLJkv1sJ0ZQnYpw8OHC/JVUph+1bNjiFhs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W1ffgtcy4Z509LhXiXSA6/R+3e3oRDnLlzd1zeeQV+SctfGSAt5pHGLEGIrhI0oIB
 lq52NUnj9mbDIQjwNlWbKeNtOn81L/U1xkKsf7vn+JQDFhVzjgwn30SEuyAE8iIkSk
 AitZYy5h7Ky8gHdVZYAAUz3KQrfuamPhoUULCyzAdK3hTCen5fyO05ydVU7c+LwtMC
 HY2g5BqeBG8aWTZXJeSWMcdtFnYKJgGqUokg+phW1s8Te/ANRaqHpScp48A1VSpBNy
 xls8j+cn/rtgBWdBslaJzXtlWkjruyJZL6dF0Y3sPbGOFLIXFUoxl6Y2Cacik2MWNs
 4jmRZXDAKtzmw==
Message-ID: <sashiko-outbox-225217@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 36/42] drm/tidss: dispc: Add hardware state readout
 helpers
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261120-drm-state-readout-v9-36-a67c2b45b8ec@kernel.org>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
 <20261120-drm-state-readout-v9-36-a67c2b45b8ec@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:17:47 +0000
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
- [Medium] drm/tidss: dispc readout helpers ordered after callers
  breaking bisect
- [Medium] drm/tidss: bus_flags readout mismatch in
  dispc_vp_get_bus_flags()
--

commit 0fa7c75e1ac8f9d7d7984b674f13c7d7a5955dd7
Author: Maxime Ripard <mripard@kernel.org>

drm/tidss: dispc: Add hardware state readout helpers

This commit adds DISPC register readout helpers for video ports, overlay
managers, and planes, and adjusts video port initialization and plane
setup to handle pipelines left running by firmware.

> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/=
tidss_dispc.c
> index e186c63ba5fb9..8e61216d4532f 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c

[ ... ]

> @@ -1401,6 +1407,228 @@ int dispc_vp_set_clk_rate(struct dispc_device *di=
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
Can dispc_vp_get_bus_flags() cause state comparison mismatches in
tidss_crtc_compare_state() and drm_atomic_helper_bridge_compare_state()
when a downstream bridge or panel leaves any of the three polarity flags
unspecified?

tidss_bridge_atomic_check() copies next_bridge_state->input_bus_cfg.flags
(or connector->display_info.bus_flags) directly into
tcrtc_state->bus_flags and propagates it to the tidss encoder bridge
state without filling in default polarities, while dispc_vp_prepare()
programs default polarities in DISPC_VP_POL_FREQ for any unset flags.
Because dispc_vp_get_bus_flags() unconditionally sets all three polarity
flags, the read-out bus_flags on the CRTC and tidss encoder bridge will
not match the committed state whenever a panel or bridge omits one of
those flags (for example, panels that only specify DRM_BUS_FLAG_DE_HIGH,
or tidss_oldi when DE polarity is left unset).

[ ... ]

> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/=
tidss_dispc.h
> index dcd4d3b18ef48..4abcb9e679acf 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.h
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.h
> @@ -111,10 +111,13 @@ void dispc_ovr_set_plane(struct dispc_device *dispc=
, u32 hw_plane,
>  			 u32 hw_videoport, u32 x, u32 y, u32 layer);
>  void dispc_ovr_enable_layer(struct dispc_device *dispc,
>  			    u32 hw_videoport, u32 layer, bool enable);
> +int dispc_ovr_get_plane(struct dispc_device *dispc, u32 hw_plane,
> +			u32 *hw_videoport, int *x, int *y, u32 *layer);
> =20
>  void dispc_vp_prepare(struct dispc_device *dispc, u32 hw_videoport,
>  		      const struct drm_crtc_state *state);
>  void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport);
> +bool dispc_vp_is_enabled(struct dispc_device *dispc, u32 hw_videoport);
>  void dispc_vp_disable(struct dispc_device *dispc, u32 hw_videoport);
>  void dispc_vp_unprepare(struct dispc_device *dispc, u32 hw_videoport);
>  bool dispc_vp_go_busy(struct dispc_device *dispc, u32 hw_videoport);
> @@ -128,9 +131,17 @@ int dispc_vp_enable_clk(struct dispc_device *dispc, =
u32 hw_videoport);
>  void dispc_vp_disable_clk(struct dispc_device *dispc, u32 hw_videoport);
>  int dispc_vp_set_clk_rate(struct dispc_device *dispc, u32 hw_videoport,
>  			  unsigned long rate);
> +void dispc_vp_set_dpi_output(struct dispc_device *dispc, u32 hw_videopor=
t,
> +			     bool dpi_output);
>  void dispc_vp_setup(struct dispc_device *dispc, u32 hw_videoport,
>  		    const struct drm_crtc_state *state, bool newmodeset,
>  		    bool dpi_output);
> +int dispc_vp_readout_mode(struct dispc_device *dispc,
> +			  u32 hw_videoport,
> +			  struct drm_display_mode *mode);
> +int dispc_vp_get_bus_format(struct dispc_device *dispc, u32 hw_videoport,
> +			    u32 *bus_fmt);
> +u32 dispc_vp_get_bus_flags(struct dispc_device *dispc, u32 hw_videoport);
> =20
>  int dispc_runtime_suspend(struct dispc_device *dispc);
>  int dispc_runtime_resume(struct dispc_device *dispc);
> @@ -141,7 +152,18 @@ int dispc_plane_check(struct dispc_device *dispc, u3=
2 hw_plane,
>  void dispc_plane_setup(struct dispc_device *dispc, u32 hw_plane,
>  		       struct drm_plane_state *state,
>  		       u32 hw_videoport);
> +void dispc_plane_get_picture_size(struct dispc_device *dispc, u32 hw_pla=
ne,
> +				  unsigned int *width, unsigned int *height);
> +void dispc_plane_get_size(struct dispc_device *dispc, u32 hw_plane,
> +			  unsigned int *width, unsigned int *height);
> +const struct drm_format_info *
> +dispc_plane_get_current_format(struct dispc_device *dispc, u32 hw_plane);
> +u8 dispc_plane_get_global_alpha(struct dispc_device *dispc, u32 hw_plane=
);
> +u32 dispc_plane_get_pixel_inc(struct dispc_device *dispc, u32 hw_plane);
> +u32 dispc_plane_get_row_inc(struct dispc_device *dispc, u32 hw_plane);
> +u16 dispc_plane_get_blend_mode(struct dispc_device *dispc, u32 hw_plane);
>  void dispc_plane_enable(struct dispc_device *dispc, u32 hw_plane, bool e=
nable);
> +bool dispc_plane_is_enabled(struct dispc_device *dispc, u32 hw_plane);

[Severity: Medium]
Should this patch be ordered before commit "drm/tidss: crtc: Implement
hardware state readout"?

The earlier commits "drm/tidss: crtc: Implement hardware state readout"
and "drm/tidss: plane: Implement hardware state readout" call these
helpers in tidss_crtc.c and tidss_plane.c before they are declared and
defined here, which breaks the build with CONFIG_DRM_TIDSS enabled at
four intermediate commits in the series during git bisect. (Commit
"drm/tidss: kms: Hook up hardware state readout" also appears to be
ordered before commit "drm/tidss: plane: Implement hardware state
readout".)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-drm-state-=
readout-v9-0-a67c2b45b8ec@kernel.org?part=3D36
