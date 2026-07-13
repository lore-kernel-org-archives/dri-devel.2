Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA17C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:59:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55B7C10E77B;
	Mon, 13 Jul 2026 05:59:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hNXdAJd2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8309B10E758
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:59:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DCFCD600AA;
 Mon, 13 Jul 2026 05:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690291F000E9;
 Mon, 13 Jul 2026 05:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783922384;
 bh=8hlh/bU8UAVYabDhmP7TwgiwtUzqBLKlyOXfXrGs6ys=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hNXdAJd2zcDQMEFjmgpULToI8lpMiAsy/Vgy6aFh5X0QN9oAsesGjoIyNNBzQwdBm
 ELyrSMFHINVcqsWYc4+ilg+aizVB0FldXWFfFt7zy8SSoLVAEIHcpzwG97a88O/f/z
 T8dfFbLSpARXNGqhaUXJoL/5H1aScwzXmjNynHgkoiy9pXL+a8rA9np1e8tSFZgXH2
 5x7WmHMbwmxnTzcyUwv8UPIWNOWmcn3F92GHWysBJqW9rYf12ijVDNPDnDWPbglaoB
 AwzvX3+XRPm/mMW113lHVYUQaVdS/9Xn/LqQU30FoiSD3yGRFer0YWxJk91csyeekd
 8mPgoVMzhQmsQ==
From: sashiko-bot@kernel.org
Subject: Re: [CI v4 05/14] drm/i915/display: Track CSC mode in intel plane
 state
To: "Chaitanya Kumar Borah" <chaitanya.kumar.borah@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713051516.4087420-6-chaitanya.kumar.borah@intel.com>
References: <20260713051516.4087420-1-chaitanya.kumar.borah@intel.com>
 <20260713051516.4087420-6-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 05:59:43 +0000
Message-Id: <20260713055944.690291F000E9@smtp.kernel.org>
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
- [High] The fixed-function CSC configuration (csc_ff_enable and csc_ff_typ=
e) and other color pipeline states (LUTs, CTMs) are lost on atomic commits =
that do not explicitly modify the colorop (e.g., page flips).
--

--- Patch [5]: [CI v4 05/14] drm/i915/display: Track CSC mode in intel plan=
e state ---
commit d2e5633249bd5c0c74c6412da61ad42bd832980e
Author: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

drm/i915/display: Track CSC mode in intel plane state

This commit adds CSC mode to hw plane state to enable programming the
fixed-function CSC block for SDR planes. It also tracks the bypass state
explicitly as a boolean since it is managed separately from the FIXED_MATRIX
enum value.

> diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm=
/i915/display/intel_plane.c
> index a440f92ff00cd..217c7a84bbfa5 100644
> --- a/drivers/gpu/drm/i915/display/intel_plane.c
> +++ b/drivers/gpu/drm/i915/display/intel_plane.c
> @@ -430,11 +430,19 @@ intel_plane_color_copy_uapi_to_hw_state(struct inte=
l_atomic_state *state,
>  	while (iter_colorop) {
>  		for_each_new_colorop_in_state(&state->base, colorop, new_colorop_state=
, i) {
>  			if (new_colorop_state->colorop =3D=3D iter_colorop) {
>  				intel_colorop =3D to_intel_colorop(colorop);
> +				if (intel_colorop->id =3D=3D INTEL_PLANE_CB_CSC_FF) {
> +					plane_state->hw.csc_ff_enable =3D
> +						!new_colorop_state->bypass;

[Severity: High]
This is a pre-existing issue, but does this loop fail to restore the hardwa=
re
state of colorops that are active but not modified in the current atomic
commit?

Since intel_plane_clear_hw_state() zeroes plane_state->hw before
intel_plane_color_copy_uapi_to_hw_state() is called, what happens on a simp=
le
page flip that doesn't modify the color pipeline?

It looks like for_each_new_colorop_in_state() will only yield colorops that
were explicitly added to the atomic commit. Since a simple page flip does n=
ot
modify the color pipeline, the colorops wouldn't be in the atomic state and
the inner loop body wouldn't execute.

Could this cause the hardware state for unmodified colorops (including the =
newly
added csc_ff_enable and csc_ff_type) to remain zeroed out, resulting in the
loss of color correction or incorrect gamma during video playback or normal
desktop use?

> +					plane_state->hw.csc_ff_type =3D
> +						new_colorop_state->fixed_matrix_type;
> +				} else {
> +					blob =3D new_colorop_state->bypass ?
> +						NULL : new_colorop_state->data;
> +					changed |=3D intel_plane_colorop_replace_blob(plane_state,
>  									    intel_colorop,
>  									    blob);
> +				}
>  			}
>  		}
>  		iter_colorop =3D iter_colorop->next;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713051516.4087=
420-1-chaitanya.kumar.borah@intel.com?part=3D5
