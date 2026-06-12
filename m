Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383F0CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 04:09:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C83710E925;
	Fri, 12 Jun 2026 04:09:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AlQ65+fT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAD0110E925
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 04:09:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E23EC600AF;
 Fri, 12 Jun 2026 04:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BE31F000E9;
 Fri, 12 Jun 2026 04:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781237367;
 bh=PlBrPTcTpjxitHOGggBdDMD8fH+YHlnzLgB7/gk5gGs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AlQ65+fTEkBgzDslZpBVAFwHfUBw6h+tqKhmEimxKpKbuTF/c+xynrE3083OkjXpt
 Ac0tJRPBQSOc6kkHeEx9G+KZrea0gd5U2DZvCNk5u83ExdFY8Em3ELna8HCajzKc+E
 Ukmk0PgLSE+7iEALfkKAtJrAxRPnCVa681JPmuDnp8vdYlsjz5hPQYF5sgWBMPEH0r
 WHeS+ZzVonv3qhzj6GFqwAR1jKjlzCVH/w2+QgKGVJ0nfy6yBGL4hS16NsxQAqpGkM
 wj8js0+ZiHB7WlyP2ecPHdP5Q7j6AWrGlkivPehdbSMk1jZSRxomplPcZGjxb+PE/G
 0C7lIhcPLP4oA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/i915: clear CRTC color blob pointers after
 dropping refs
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612035310.3013066-1-lgs201920130244@gmail.com>
References: <20260612035310.3013066-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 04:09:27 +0000
Message-Id: <20260612040927.75BE31F000E9@smtp.kernel.org>
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
- [High] Shallow copy of `pre_csc_lut` and `post_csc_lut` in `copy_joiner_c=
rtc_state_modeset` causes reference count underflow.
--

commit d8903c83c49bdd10049bb0f1ca2cc52040717077
Author: Guangshuo Li <lgs201920130244@gmail.com>

drm/i915: clear CRTC color blob pointers after dropping refs

intel_crtc_put_color_blobs() drops the CRTC color blob references, but leav=
es
the corresponding pointers unchanged. Clear the blob pointers after dropping
the references so repeated cleanup of the same CRTC hw state is safe.

> diff --git a/drivers/gpu/drm/i915/display/intel_atomic.c b/drivers/gpu/dr=
m/i915/display/intel_atomic.c
> index 0e4f0678c53cd..9d0d47c79dd12 100644
> --- a/drivers/gpu/drm/i915/display/intel_atomic.c
> +++ b/drivers/gpu/drm/i915/display/intel_atomic.c
> @@ -288,6 +288,12 @@ static void intel_crtc_put_color_blobs(struct intel_=
crtc_state *crtc_state)
> =20
>  	drm_property_blob_put(crtc_state->pre_csc_lut);
>  	drm_property_blob_put(crtc_state->post_csc_lut);
> +
> +	crtc_state->hw.degamma_lut =3D NULL;
> +	crtc_state->hw.gamma_lut =3D NULL;
> +	crtc_state->hw.ctm =3D NULL;
> +	crtc_state->pre_csc_lut =3D NULL;
> +	crtc_state->post_csc_lut =3D NULL;

[Severity: High]
This isn't a bug introduced by this patch, but does the current state
duplication logic cause a refcount underflow for pre_csc_lut and
post_csc_lut?

In copy_joiner_crtc_state_modeset(), the primary CRTC state is duplicated
and shallow-copied to the secondary CRTC state using memcpy():

drivers/gpu/drm/i915/display/intel_display.c:copy_joiner_crtc_state_modeset=
() {
    ...
    memcpy(secondary_crtc_state, saved_state, sizeof(*secondary_crtc_state)=
);
    ...
}

This transfers the pre_csc_lut and post_csc_lut pointers to the secondary
state without acquiring a reference.=20

While copy_joiner_crtc_state_nomodeset() is subsequently called and correct=
ly
acquires references for the hw color blobs (degamma_lut, gamma_lut, ctm) via
drm_property_replace_blob(), it completely omits pre_csc_lut and post_csc_l=
ut:

drivers/gpu/drm/i915/display/intel_display.c:copy_joiner_crtc_state_nomodes=
et() {
    ...
    drm_property_replace_blob(&secondary_crtc_state->hw.degamma_lut,
                              primary_crtc_state->hw.degamma_lut);
    drm_property_replace_blob(&secondary_crtc_state->hw.gamma_lut,
                              primary_crtc_state->hw.gamma_lut);
    drm_property_replace_blob(&secondary_crtc_state->hw.ctm,
                              primary_crtc_state->hw.ctm);
    ...
}

As a result, the secondary CRTC state holds these pointers without holding a
corresponding reference.=20

When intel_crtc_free_hw_state() eventually destroys both states, it calls
drm_property_blob_put() on the same pre_csc_lut and post_csc_lut pointers f=
or
both the primary and secondary states.

While this patch successfully prevents a double-free when a single state
fails and is retried, will it still result in a use-after-free and refcount
underflow across the two different CRTC states?

>  }
> =20
>  void intel_crtc_free_hw_state(struct intel_crtc_state *crtc_state)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612035310.3013=
066-1-lgs201920130244@gmail.com?part=3D1
