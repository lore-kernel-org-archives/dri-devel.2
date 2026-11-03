Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2F4606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhnoMRig
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C97FF10F8D8;
	Tue,  3 Nov 2026 22:59:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C20F910F8C9;
 Tue,  3 Nov 2026 22:59:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A6DE60AB0;
 Tue,  3 Nov 2026 22:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2151F000C1;
 Tue,  3 Nov 2026 22:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793746761;
 bh=W4TleEYDDiKIphcGn6vgwMRIJGKRuYmsVo8RTX/3EgA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HhnoMRigZTSSqoy++oeCntLL6knELqqDYTf+zsBzlwsKBDMlvBoSdELxm3xE1E16a
 q9B3LyH90Ku/FN66ctfwIYCVtBaK0njxIRBSx/jnDvgcA+p0MCQ25IUh0pU8JwRZyT
 EkW3sN+ftXwPUF+FsONxNiFF7NYXnbzrPXHXmvrw4iy7R96mj+tdQ4h75qiPyykz8a
 IY8uTG/lrJGc8+tW6Uo6Xp6TnRw6IORox56wwRdT+ZyLCs2kf2SpyJKNTq4woXRS1y
 s6evzvnTDl2E8J0mubdT5uugF5r/PaDdND3+bJ8YdNqYulzxFmSj6a4yBG7CXEQkT8
 L9N1dzFm6zJTg==
Message-ID: <sashiko-outbox-196165@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 10/12] drm/gud: add connector luminance support
To: =?utf-8?b?TWFyaW8gTGltb25jaWVsbG8gKEFNRCk=?= <superm1@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261103-superm1-backlight-property-v11-10-00cce7b2ba22@kernel.org>
References: <20261103-superm1-backlight-property-v11-0-00cce7b2ba22@kernel.org>
 <20261103-superm1-backlight-property-v11-10-00cce7b2ba22@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 22:59:21 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/gud: LUMINANCE updates in gud_connector_atomic_check() require=
 modeset
--

commit 8034990b85e36e57451a40c677e5ac4037438eda
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/gud: add connector luminance support

This commit exposes GUD display brightness through the connector LUMINANCE
property when CONFIG_DRM_LUMINANCE is enabled, mirroring luminance changes
into tv.brightness during atomic check.

> diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gu=
d_connector.c
> index ddbf3b3ebbca8..bfb298bbc9b51 100644
> --- a/drivers/gpu/drm/gud/gud_connector.c
> +++ b/drivers/gpu/drm/gud/gud_connector.c
> @@ -292,10 +292,19 @@ static int gud_connector_atomic_check(struct drm_co=
nnector *connector,
>  	struct drm_connector_state *old_state;
> =20
>  	new_state =3D drm_atomic_get_new_connector_state(state, connector);
> +	old_state =3D drm_atomic_get_old_connector_state(state, connector);
> +
> +	/*
> +	 * LUMINANCE is sent to the device as tv.brightness in the same commit,
> +	 * the brightness change below then triggers GUD_REQ_SET_STATE_CHECK.
> +	 */
> +	if (connector->luminance_property &&
> +	    old_state->luminance !=3D new_state->luminance)
> +		new_state->tv.brightness =3D new_state->luminance;

[Severity: High]
Will mirroring new_state->luminance into new_state->tv.brightness here cause
non-modeset atomic commits that update LUMINANCE to fail with -EINVAL?

In gud_connector_atomic_check(), changing new_state->tv.brightness sets
new_crtc_state->connectors_changed:

	if (old_state->tv.margins.left !=3D new_state->tv.margins.left ||
	    ...
	    old_state->tv.brightness !=3D new_state->tv.brightness ||
	    ...)
		new_crtc_state->connectors_changed =3D true;

When a userspace compositor updates LUMINANCE in a normal atomic commit
without DRM_MODE_ATOMIC_ALLOW_MODESET:

drm_mode_atomic_ioctl()
  -> drm_atomic_check_only()
    -> drm_atomic_helper_check()
      -> drm_atomic_helper_check_modeset()
        -> gud_connector_atomic_check()
      -> drm_atomic_helper_check_planes()
        -> gud_plane_atomic_check()

gud_plane_atomic_check() sees crtc_state->connectors_changed and sends
GUD_REQ_SET_STATE_CHECK to the USB device, but drm_atomic_check_only() then
rejects the commit because drm_atomic_crtc_needs_modeset(new_crtc_state) is
true when connectors_changed is set:

	if (!state->allow_modeset) {
		for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
			if (drm_atomic_crtc_needs_modeset(new_crtc_state)) {
				drm_dbg_atomic(dev, "[CRTC:%d:%s] requires full modeset\n",
					       crtc->base.id, crtc->name);
				return -EINVAL;
			}
		}
	}

Even if DRM_MODE_ATOMIC_ALLOW_MODESET is passed, wouldn't setting
connectors_changed force a full CRTC modeset on every brightness adjustment?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-superm1-ba=
cklight-property-v11-0-00cce7b2ba22@kernel.org?part=3D10
