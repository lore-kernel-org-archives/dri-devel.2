Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA20606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NfNp/6hp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F373A10F09F;
	Tue, 24 Nov 2026 18:42:35 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E67310F08C;
 Tue, 24 Nov 2026 18:42:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E4ACF60A60;
 Tue, 24 Nov 2026 18:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FE01F000C4;
 Tue, 24 Nov 2026 18:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795545743;
 bh=52SRQ61rfZVPRDCOUAglscJGlDss/3UZ9vyPXcWxejQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NfNp/6hpcc0iZbhBl6JFJWOG82LqBS/gUdJrYnlT+g4wy/Z5GEXqzJ83SK9D8xoSm
 GCq20NeF8wdGM5hGl0KEqkw6+xzDYChsvgjtLlMbY4Abk0mczyLoWzJUYO1srtD18z
 nwrGKtjDX6M8nA00vA8/JRUqJa9t1rsn5UL8IIPvOb5vc2dHCK4N/gmzKNQrh5sejg
 pRWWVtzKlSPQfzGpQYK/zxWisFwYdHQqIz8h3/m4VJgN1JaJx10FtwLJ/2RlTtOicG
 PoN76pA3W2f+MJXD9J4tMezSDfH2X5nwUcEkOvX3o0Q64AXo26Uepxae5ITJ6LgN1q
 TGHb5kS7DxsCQ==
Message-ID: <sashiko-outbox-231844@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/19] drm/atomic: set hidden CRTC color mgmt model
 to default values
To: "Melissa Wen" <mwen@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261124181652.1333986-15-mwen@igalia.com>
References: <20261124181652.1333986-1-mwen@igalia.com>
 <20261124181652.1333986-15-mwen@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 18:42:22 +0000
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
- [Medium] drm/atomic: hidden CRTC color model not reset outside
  drm_mode_atomic_ioctl()
--

commit 988786e967d206ee7e346b8385770656e4c8ad9e
Author: Melissa Wen <mwen@igalia.com>

drm/atomic: set hidden CRTC color mgmt model to default values

This commit resets the hidden CRTC color management properties (either the
legacy LUT/CTM blobs or the colorop pipeline) to default values on each
CRTC included in an atomic ioctl commit.

> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index afac90d5d7e0a..fe676e612d414 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -1687,6 +1687,32 @@ static void complete_signaling(struct drm_device *=
dev,
>  	kfree(fence_state);
>  }
> =20
> +static void
> +reset_crtc_color_mgmt_props(struct drm_atomic_commit *state,
> +			    struct drm_file *file_priv,
> +			    bool async_flip)
> +{
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_crtc *crtc;
> +	bool changed;
> +	int i;
> +
> +	/* Async page flip doesn't change properties */
> +	if (async_flip)
> +		return;
> +
> +	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
> +		if (file_priv->crtc_color_pipeline) {
> +			changed =3D drm_property_replace_blob(&crtc_state->degamma_lut, NULL);
> +			changed |=3D drm_property_replace_blob(&crtc_state->ctm, NULL);
> +			changed |=3D drm_property_replace_blob(&crtc_state->gamma_lut, NULL);
> +		} else {
> +			changed =3D drm_atomic_set_colorop_for_crtc(crtc_state, NULL);
> +		}
> +		crtc_state->color_mgmt_changed |=3D changed;
> +	}
> +}
> +
>  static void
>  set_async_flip(struct drm_atomic_commit *state)
>  {
> @@ -1845,6 +1871,8 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>  		drm_mode_object_put(obj);
>  	}
> =20
> +	reset_crtc_color_mgmt_props(state, file_priv, async_flip);

[Severity: Medium]
Does calling reset_crtc_color_mgmt_props() only in drm_mode_atomic_ioctl()
leave crtc_state->color_pipeline active when a later client updates CRTC
color properties through other atomic commit paths?

For example, after a client with DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE sets a
CRTC color pipeline, switching to a client or helper that updates gamma or
CTM via drm_crtc_legacy_gamma_set() (DRM_IOCTL_MODE_SETGAMMA),
set_property_atomic() (DRM_IOCTL_MODE_OBJ_SETPROPERTY), or fbdev's
setcmap_atomic() commits the new LUT/CTM blobs without clearing
crtc_state->color_pipeline.  Because drivers program CRTC color management
from color_pipeline whenever it is non-NULL and only fall back to
degamma_lut, ctm, and gamma_lut otherwise, those updates are silently
ignored while the previous client's color pipeline remains active.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124181652.1333=
986-1-mwen@igalia.com?part=3D14
