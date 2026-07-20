Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE554C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 05:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2749210E66B;
	Mon, 20 Jul 2026 05:28:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oJLtfEq0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A0AA10E66B
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 05:28:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B121960103;
 Mon, 20 Jul 2026 05:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4996C1F000E9;
 Mon, 20 Jul 2026 05:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784525330;
 bh=cJ/AFfRHYDfEAF9VPMRJmPiCR99EABBGmGsQJpN3Yf4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oJLtfEq0YwqQLvj8CmKb8jSyQcbCuiGZLHGB+5abdxzQGo4ypO/y56yZb25dqZww6
 7KQrA4Hg5nCYflfmYNAQDX20WNSTKNBoiVyTCun1/7hMJVwl3rMh1HMCbe1sug9XUe
 zGOp4+cvLvwcQSnWHQD6M4MEgEir9muBqa5CVZAAp/YmInZEgfBt7g/dqpjoU5c4nG
 PDb08vAt++AaAYlXL/pWfsruJw1HbVJMhSX1ejs4LnjRl1Z/yNnQhlXbop+X5aBXSB
 qyzp3nb36VZQlfi4igQa6x7oc4kqFjb9xrlubypjJtj4AN+9HBOiNutewPfdqxSYQw
 AxBlW7p6U1NzA==
From: sashiko-bot@kernel.org
Subject: Re: [v5 05/14] drm/i915/display: Track CSC mode in intel plane state
To: "Chaitanya Kumar Borah" <chaitanya.kumar.borah@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720045131.971650-6-chaitanya.kumar.borah@intel.com>
References: <20260720045131.971650-1-chaitanya.kumar.borah@intel.com>
 <20260720045131.971650-6-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 05:28:49 +0000
Message-Id: <20260720052850.4996C1F000E9@smtp.kernel.org>
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
- [High] Unmodified plane color pipeline state (including the newly added C=
SC_FF configuration) is inadvertently wiped and silently disabled when an a=
tomic commit modifies unrelated plane properties.
--

--- Patch [5]: [v5 05/14] drm/i915/display: Track CSC mode in intel plane s=
tate ---
commit ff45547703318a58efbb8be7b806421f22234b15
Author: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

drm/i915/display: Track CSC mode in intel plane state

This commit adds CSC mode to the hardware plane state to enable programming=
=20
the fixed-function CSC block for SDR planes based on the=20
DRM_COLOROP_FIXED_MATRIX state. It also explicitly tracks the bypass state=
=20
as a boolean.

> diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm=
/i915/display/intel_plane.c
> --- a/drivers/gpu/drm/i915/display/intel_plane.c
> +++ b/drivers/gpu/drm/i915/display/intel_plane.c
[ ... ]
> @@ -430,11 +430,19 @@ intel_plane_color_copy_uapi_to_hw_state(struct inte=
l_atomic_state *state,
>  	while (iter_colorop) {
>  		for_each_new_colorop_in_state(&state->base, colorop, new_colorop_state=
, i) {

[Severity: High]
This is a pre-existing issue, but I have a question about how unmodified=20
colorops are handled here.

Does this cause the hardware colorop configuration to be lost when unrelated
plane properties are updated?

Since for_each_new_colorop_in_state() only iterates over colorops actively
included in the current atomic commit, unmodified colorops won't be in the
state during a simple plane update like a page flip.=20

Because the hardware state is wiped earlier by intel_plane_clear_hw_state(),
unmodified plane color pipeline state (including the newly added CSC_FF
configuration) appears to be left zeroed and silently disabled.

Can this lead to incorrect display output, and should this path handle
copying state from unmodified colorops?

>  			if (new_colorop_state->colorop =3D=3D iter_colorop) {
> -				blob =3D new_colorop_state->bypass ? NULL : new_colorop_state->data;
>  				intel_colorop =3D to_intel_colorop(colorop);
> -				changed |=3D intel_plane_colorop_replace_blob(plane_state,
> +				if (intel_colorop->id =3D=3D INTEL_PLANE_CB_CSC_FF) {
> +					plane_state->hw.csc_ff_enable =3D
> +						!new_colorop_state->bypass;
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720045131.9716=
50-1-chaitanya.kumar.borah@intel.com?part=3D5
