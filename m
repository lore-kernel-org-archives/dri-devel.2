Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17C6CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 04:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A80B10E6EC;
	Wed, 10 Jun 2026 04:13:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IEyU/hey";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40C1110E6EC
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 04:13:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6E797602C4;
 Wed, 10 Jun 2026 04:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005891F00893;
 Wed, 10 Jun 2026 04:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781064788;
 bh=JUJJPmVLioN6l8djX/wa4RJs3Cdm7G8B+CJhhhIKuqc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IEyU/heyyUmFx3A2NQ9JkrmJfXeoTQ1l4bMYHlje1K9T7/rQuhObiL5TsHf8xdH24
 ro8ztnwykGYgnbwNkHeRTQVQ6G+c4VA3l1E2IocsMGS6ACIChW+wbctX9dHCiZsP7X
 MzhSDViKmvxl4PcDRleNyD/wCwzwjSRkrHfctCVw1YtnY4zVek0/ViGuYIlAtRRkpS
 GH/WjPAERdJFKiaHfiSYCnJxvK/YYayW9PqOZ0ljd3BCFjIQprNN35YNmG/6EOKLlK
 BAzxOYbqKZdfIOiS43r9dsxuGef919jFsdlWhwLO8rns6DDNGWOIOi0D53NNSqp0ic
 Tvyj1pyzoUwAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/i915: clear CRTC color blob pointers after
 dropping refs
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260610035419.1596963-1-lgs201920130244@gmail.com>
References: <20260610035419.1596963-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 04:13:07 +0000
Message-Id: <20260610041308.005891F00893@smtp.kernel.org>
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
- [High] Missing reference counting for `pre_csc_lut` and `post_csc_lut` wh=
en copying joiner CRTC state leads to refcount underflow and potential Use-=
After-Free.
--

commit 1f085640509d6db9ddf76a018415e1b475be3068
Author: Guangshuo Li <lgs201920130244@gmail.com>

drm/i915: clear CRTC color blob pointers after dropping refs

This commit modifies intel_crtc_free_hw_state() to explicitly clear the
CRTC color blob pointers after dropping their references. This ensures
that repeated cleanups of the same CRTC hw state won't attempt to drop
the same blob references again if an atomic operation fails later.

> diff --git a/drivers/gpu/drm/i915/display/intel_atomic.c b/drivers/gpu/dr=
m/i915/display/intel_atomic.c
> index 0e4f0678c53cd..a80c863952529 100644
> --- a/drivers/gpu/drm/i915/display/intel_atomic.c
> +++ b/drivers/gpu/drm/i915/display/intel_atomic.c
> @@ -293,6 +293,12 @@ static void intel_crtc_put_color_blobs(struct intel_=
crtc_state *crtc_state)
>  void intel_crtc_free_hw_state(struct intel_crtc_state *crtc_state)
>  {
>  	intel_crtc_put_color_blobs(crtc_state);
> +
> +	crtc_state->hw.degamma_lut =3D NULL;
> +	crtc_state->hw.gamma_lut =3D NULL;
> +	crtc_state->hw.ctm =3D NULL;
> +	crtc_state->pre_csc_lut =3D NULL;
> +	crtc_state->post_csc_lut =3D NULL;

[Severity: High]
This is a pre-existing issue, but missing reference counting for pre_csc_lut
and post_csc_lut when copying joiner CRTC state can lead to a refcount
underflow and potential use-after-free.

In drivers/gpu/drm/i915/display/intel_display.c:
copy_joiner_crtc_state_modeset(), the primary state's pre_csc_lut and
post_csc_lut pointers are blindly copied into the secondary state without
acquiring references:

	memcpy(secondary_crtc_state, saved_state, sizeof(*secondary_crtc_state));

After the secondary state's existing blobs are freed, the state is
overwritten by this memcpy, so the secondary state now holds the primary's
blob pointers.

The subsequent memset(&secondary_crtc_state->hw, 0, ...) clears the hw stru=
ct
(including hw.degamma_lut), but pre_csc_lut and post_csc_lut reside outside
the hw struct and remain pointing to the primary's blobs.

Later in the atomic check phase, intel_assign_luts() replaces the
unreferenced pointer:

	drm_property_replace_blob(&crtc_state->pre_csc_lut,
				  crtc_state->hw.degamma_lut);

Because hw.degamma_lut is NULL, it drops the old pointer by calling
drm_property_blob_put() on it. Since the secondary CRTC never actually
acquired a reference, this drops the primary CRTC's reference instead.

Although the newly added NULL assignments here in intel_crtc_free_hw_state()
clear the pointers initially, could they still get overwritten again by the
blind memcpy in copy_joiner_crtc_state_modeset() before intel_assign_luts()
executes?

>  }
> =20
>  /**

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610035419.1596=
963-1-lgs201920130244@gmail.com?part=3D1
