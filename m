Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798CDC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 13:18:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D769D10E15E;
	Tue,  4 Aug 2026 13:18:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XtTHDJY9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6143C10E15E
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 13:18:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0218640727;
 Tue,  4 Aug 2026 13:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A921F000E9;
 Tue,  4 Aug 2026 13:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785849534;
 bh=RTHV5v9tQNOB180OttEs0wmT8xa5rG3vlpFXX7jZKD8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XtTHDJY9/S7JIhwl7aw020fmmXyI6RBIpFPR5G9NdBj2W1WdIJY7cA43p3HPvyHBS
 dGsUIUwEebYZn+hTA8lNAblxIuLLlpCq0odQCbpj+0fkuzl4PWmGLpnb6urdy8vesn
 SUYhlaz1PnrqHehafvhDG6BGIfK73NXZ0HWjWWdlOuB5QNO9/P/Rq6mulFmHxBrgl6
 fz2lOxuxECUK9yhuMJCJh3R8Bz8s+IOn8uPdAgDTLhWjqtsXDSbqbgz6lcyttU4Oju
 xVkaIh7u3n0swSlLygZ+CJtnsZwFm2khG/hOaxgPCWutT35aZUYSzZRS2HwUXrOChV
 lGQayIgEJktaw==
From: sashiko-bot@kernel.org
Subject: Re: [v6 5/9] drm/i915/display: Program CSC on SDR planes based on
 Fixed Matrix Colorop
To: "Chaitanya Kumar Borah" <chaitanya.kumar.borah@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260804123107.2256124-6-chaitanya.kumar.borah@intel.com>
References: <20260804123107.2256124-1-chaitanya.kumar.borah@intel.com>
 <20260804123107.2256124-6-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 13:18:53 +0000
Message-Id: <20260804131854.B9A921F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Plane color pipeline configuration (including `csc_ff_enable` and =
LUT blobs) is silently discarded if an atomic commit updates the plane but =
omits the color pipeline objects.
--

--- Patch [5]: [v6 5/9] drm/i915/display: Program CSC on SDR planes based o=
n Fixed Matrix Colorop ---
commit 17128052d77ad1b002034d74a8e48d89696c0df8
Author: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

drm/i915/display: Program CSC on SDR planes based on Fixed Matrix Colorop

When a color pipeline is active, program the SDR plane fixed-function
CSC based on the Fixed Matrix Colorop's state. Re-use the existing plane
state variables for color_range and color_encoding.

> diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm=
/i915/display/intel_plane.c
> index d0f99a87c42e8..25ca049009efb 100644
> --- a/drivers/gpu/drm/i915/display/intel_plane.c
> +++ b/drivers/gpu/drm/i915/display/intel_plane.c

[ ... ]

> @@ -485,11 +522,23 @@ intel_plane_color_copy_uapi_to_hw_state(struct inte=
l_atomic_state *state,
>  	while (iter_colorop) {
>  		for_each_new_colorop_in_state(&state->base, colorop, new_colorop_state=
, i) {
>  			if (new_colorop_state->colorop =3D=3D iter_colorop) {
> -				blob =3D new_colorop_state->bypass ? NULL : new_colorop_state->data;
>  				intel_colorop =3D to_intel_colorop(colorop);
> -				changed |=3D intel_plane_colorop_replace_blob(plane_state,
> +				if (intel_colorop->id =3D=3D INTEL_PLANE_CB_CSC_FF) {
> +					fm_type =3D new_colorop_state->fixed_matrix_type;
> +
> +					plane_state->hw.csc_ff_enable =3D
> +						!new_colorop_state->bypass;

[Severity: High]
This isn't a bug introduced by this patch, but does this iteration macro fa=
il
to preserve the hardware state during page flips?

If userspace performs a simple plane update, such as a page flip to update =
the
FB, without explicitly including the color pipeline objects in the atomic
commit, for_each_new_colorop_in_state() in
intel_plane_color_copy_uapi_to_hw_state() will skip the unmodified colorops.

Since intel_plane_copy_uapi_to_hw_state() calls intel_plane_clear_hw_state()
prior to this step, the entire hardware state is cleared. As a result, the
new csc_ff_enable flag and other LUT pointers will not be restored,
permanently losing the hardware configuration.

[ ... ]

> diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers=
/gpu/drm/i915/display/skl_universal_plane.c
> index 73be4c6ff1d3b..222c3b6bbe467 100644
> --- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
> +++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c

[ ... ]

> @@ -1245,9 +1245,11 @@ static u32 glk_plane_color_ctl_input_csc(const str=
uct intel_plane_state *plane_s
>  	struct intel_display *display =3D to_intel_display(plane_state);
>  	const struct drm_framebuffer *fb =3D plane_state->hw.fb;
>  	struct intel_plane *plane =3D to_intel_plane(plane_state->uapi.plane);
> +	bool color_pipeline =3D !!plane_state->uapi.color_pipeline;
> +	bool needs_csc =3D color_pipeline ? plane_state->hw.csc_ff_enable : fb-=
>format->is_yuv;
>  	u32 ctl =3D 0;
> =20
> -	if (!fb->format->is_yuv)
> +	if (!needs_csc)
>  		return 0;

[Severity: High]
Because of the issue mentioned above, could needs_csc evaluate to false
incorrectly?

When the csc_ff_enable flag is silently dropped during an atomic commit that
does not modify colorops, glk_plane_color_ctl_input_csc() will evaluate
needs_csc to false. This disables the hardware CSC, which can lead to
incorrect colors or visual artifacts on the display.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804123107.2256=
124-1-chaitanya.kumar.borah@intel.com?part=3D5
