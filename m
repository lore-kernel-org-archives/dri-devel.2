Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FED606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XzPKXaAt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 017C410E5D7;
	Tue, 24 Nov 2026 18:42:15 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E85010E5D7;
 Tue, 24 Nov 2026 18:42:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 25A0F61D9C;
 Tue, 24 Nov 2026 18:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D731F000C4;
 Tue, 24 Nov 2026 18:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795545727;
 bh=hv3cwKxXwwkcdpRlt2/tq0MwTe66mCZ19HuiWJzIrec=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XzPKXaAtg0ZrVxKeyu3qj62xkp+mCySS4rOy2hF/jrT72R1cYNdVOpYnEH/Z33ZQK
 fTo3xXkn9FXVunz4cL18hgCFbdmbZpCvbVBv769Ks0AscinZnDWjglsOD12puNrw/w
 6/eWsFLLIw3OUYB9JXlj23XgwV0Y98DISxJkrFhlOh7Wv9xVgsr/B2zk/XQj+n/iVW
 0AS10+R2fHcCggzAWZI4ddCbKPAzEUSBYQ30edx6lSyR5h9h/hA2eOwozffxkB+TcV
 ET8d/hDG668i4Z86iu/EhYtW+E3pyopF5g+rFPG30raI3D1/Lq8PO4Bj2jAe3sALtg
 2lkzJOQhWXP/w==
Message-ID: <sashiko-outbox-231843@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 18/19] drm/amd/display: add support to post-blend
 1D-Curve colorop
To: "Melissa Wen" <mwen@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261124181652.1333986-19-mwen@igalia.com>
References: <20261124181652.1333986-1-mwen@igalia.com>
 <20261124181652.1333986-19-mwen@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 18:42:06 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [Medium] drm/amd/display: missing ogam_ram check when applying CRTC
  regamma colorop
- [Medium] drm/amd/display: stale out_transfer_func.tf in
  __set_dm_crtc_colorop_regamma()
- [Medium] drm/amd/display: colorop leak in
  amdgpu_dm_initialize_crtc_default_pipeline()
- [Medium] drm/amd/display: unchecked kasprintf() in CRTC default
  pipeline init
- [Low] drm/amd/display: unused param and variable in
  __set_dm_crtc_colorop_regamma()
--

commit a10135e3487a34c61aa5df0ce12f0d6b9ae37b7c
Author: Melissa Wen <mwen@igalia.com>

drm/amd/display: add support to post-blend 1D-Curve colorop

This commit adds a 1D curve regamma transfer function colorop to the AMD
CRTC post-blend color pipeline and applies its state during atomic check
and commit.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index 12665810708e2..f807a2e8c0f71 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -1287,6 +1287,41 @@ __set_dm_crtc_colorop_3x4_matrix(struct drm_crtc_s=
tate *crtc_state,
>  	return 0;
>  }
> =20
> +static int
> +__set_dm_crtc_colorop_regamma(struct drm_crtc_state *crtc_state,
> +			      struct dc_stream_state *dc_stream_state,
> +			      struct drm_colorop *colorop,
> +			      struct dc_transfer_func *tf)
> +{
> +	struct drm_colorop_state *colorop_state =3D NULL;
> +	struct drm_atomic_commit *state =3D crtc_state->state;
> +	enum dc_transfer_func_predefined default_tf =3D TRANSFER_FUNCTION_LINEA=
R;
> +	struct drm_device *dev =3D crtc_state->state->dev;
> +	int ret =3D 0;
> +
> +	tf->type =3D TF_TYPE_BYPASS;
> +
> +	/* 1D Curve - Regamma TF */
> +	if (colorop->type !=3D DRM_COLOROP_1D_CURVE)
> +		return -EINVAL;

[Severity: Medium]
Does setting only tf->type =3D TF_TYPE_BYPASS leave a stale transfer
function in dc_stream_state->out_transfer_func.tf when this colorop is
bypassed?  Other transfer function helpers use __set_tf_bypass(), which
also resets tf->tf to TRANSFER_FUNCTION_LINEAR.  Downstream DC paths such
as set_avi_info_frame() and get_hdr_visual_confirm_color() check
stream->out_transfer_func.tf without checking whether out_transfer_func.type
is TF_TYPE_BYPASS, so a prior TRANSFER_FUNCTION_GAMMA22 or
TRANSFER_FUNCTION_PQ value stays active for AVI InfoFrame colorimetry and
HDR visual confirm even after regamma is bypassed.

> +
> +	colorop_state =3D drm_atomic_get_new_colorop_state(state, colorop);
> +	if (!colorop_state)
> +		colorop_state =3D colorop->state;
> +
> +	if (!colorop_state->bypass) {
> +		drm_dbg(dev, "Regamma TF colorop with ID: %d\n", colorop->base.id);
> +		tf->type =3D TF_TYPE_DISTRIBUTED_POINTS;
> +		tf->tf =3D default_tf =3D amdgpu_colorop_tf_to_dc_tf(colorop_state->cu=
rve_1d_type);

[Severity: Low]
dc_stream_state is unused in __set_dm_crtc_colorop_regamma(), and
default_tf is assigned here without being read in this patch, which
triggers -Wunused-but-set-variable under W=3D1 builds until commit
"drm/amd/display: add support to post-blend 1D-LUT colorop" uses it.

> +		tf->sdr_ref_white_level =3D SDR_WHITE_LEVEL_INIT_VALUE;
> +		ret =3D __set_output_tf(tf, 0, 0, false);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * amdgpu_dm_crtc_set_colorop_properties: Set colorop props if programma=
ble by DC.
>   * @crtc_state: DRM crtc state
> @@ -1312,6 +1347,7 @@ amdgpu_dm_crtc_set_colorop_properties(struct drm_cr=
tc_state *crtc_state,
>  {
>  	struct drm_colorop *colorop =3D crtc_state->color_pipeline;
>  	struct drm_device *dev =3D crtc_state->crtc->dev;
> +	struct dc_transfer_func *out_tf;
>  	int ret;
> =20
>  	if (drm_WARN_ON(dev, !colorop))
> @@ -1319,6 +1355,28 @@ amdgpu_dm_crtc_set_colorop_properties(struct drm_c=
rtc_state *crtc_state,
> =20
>  	/* 3x4 matrix */
>  	ret =3D __set_dm_crtc_colorop_3x4_matrix(crtc_state, dc_stream_state, c=
olorop, check_only);
> +	if (ret)
> +		return ret;
> +
> +	/* 1D Curve - REGAMMA TF */
> +	colorop =3D colorop->next;
> +	if (!colorop) {
> +		drm_dbg(dev, "no regamma TF colorop found\n");
> +		return -EINVAL;
> +	}

[Severity: Medium]
Should this check adev->dm.dc->caps.color.mpc.ogam_ram before requiring
the regamma colorop?  amdgpu_dm_initialize_crtc_default_pipeline() only
appends the 1D curve colorop when mpc.ogam_ram is set, so when it is false
the pipeline still registers with just the 3x4 CTM (ops[0]->next =3D=3D NUL=
L)
and every atomic check or commit using that pipeline will fail here with
-EINVAL.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> index dcd497b644c11..f5991f29973d5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> @@ -311,6 +311,7 @@ int amdgpu_dm_initialize_crtc_default_pipeline(struct=
 drm_crtc *crtc,
>  {
>  	struct drm_colorop *ops[MAX_COLOR_PIPELINE_OPS];
>  	struct drm_device *dev =3D crtc->dev;
> +	struct amdgpu_device *adev =3D drm_to_adev(dev);
>  	int ret;
>  	int i =3D 0;
> =20
> @@ -332,6 +333,25 @@ int amdgpu_dm_initialize_crtc_default_pipeline(struc=
t drm_crtc *crtc,
> =20
>  	i++;
> =20
> +	if (adev->dm.dc->caps.color.mpc.ogam_ram) {
> +		/* 1D Curve - REGAMMA TF */
> +		ops[i] =3D kzalloc_obj(*ops[0]);
> +		if (!ops[i]) {
> +			ret =3D -ENOMEM;
> +			goto cleanup;
> +		}
> +
> +		ret =3D drm_crtc_colorop_curve_1d_init(dev, ops[i], crtc, &dm_colorop_=
funcs,
> +						     amdgpu_dm_supported_shaper_tfs,
> +						     DRM_COLOROP_FLAG_ALLOW_BYPASS);
> +		if (ret)
> +			goto cleanup;

[Severity: Medium]
Does jumping to cleanup leak ops[i] if drm_crtc_colorop_curve_1d_init()
fails before linking it into dev->mode_config.colorop_list?
drm_common_colorop_init() returns early if drm_mode_object_add() fails
before list_add_tail(&colorop->head, &config->colorop_list), and
drm_colorop_pipeline_destroy() only frees colorops already on
colorop_list.

> +
> +		drm_colorop_set_next_property(ops[i-1], ops[i]);
> +
> +		i++;
> +	}
> +
>  	list->name =3D kasprintf(GFP_KERNEL, "Color Pipeline %d", ops[0]->base.=
id);
> =20
>  	return 0;

[Severity: Medium]
This problem wasn't introduced by this patch (it comes from commit
"drm/amd/display: enable post-blend CTM colorop" earlier in the series),
but what happens if kasprintf() returns NULL for list->name?  Returning 0
skips drm_colorop_pipeline_destroy() and leaves a NULL name in pipelines[]
when dm_crtc_init_colorops() calls drm_crtc_create_color_pipeline_property(=
),
leading to a NULL pointer dereference in strlen(name) inside
drm_property_add_enum().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124181652.1333=
986-1-mwen@igalia.com?part=3D18
