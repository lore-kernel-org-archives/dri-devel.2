Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AB8C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:13:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 003C510E531;
	Mon, 21 Sep 2026 16:13:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lRilrCSh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6598E10E531
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 16:13:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DF8BD60142;
 Mon, 21 Sep 2026 16:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772241F000FF;
 Mon, 21 Sep 2026 16:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790007218;
 bh=qJrUa/A+0Y5md39kSeS6a+dtSRWTqL61d0dgm8q/nHQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lRilrCSh807iMqzzmaFBiqp9RRXZkSm+KFoD4dTm/I9WXXiE77MbSdHC9kdbewGmG
 eR57OxIAKzIeU8r8oeJ94ykA3uIBZ2RFgDV1oB42E2Vj/QJoSfQMn+4McvKnLEjQb9
 RsUTE+Awz9rIdFk/qxlIdw9fozPk0j8Q+xLqrEx7Q0e8whXukkYZB16OCL0GqyDHQC
 p5um4LJdg+XUdGNqNCeu+ndReihqUMh37Rxx6Z6x1lG7ue+nMNGWKfLVXfmu5biieb
 KHVgDcilR48+2OOL6joyw+yOW8JSM/Niuvsx0+dXqZozhykPYdmCI7UGUG31vrRhhz
 Eu8xDZDlulyfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 03/25] drm/atomic-helper: Set mode_changed on
 vrr_enabled change
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921-vrr-limiter-uapi-v1-3-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-3-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:13:38 +0000
Message-Id: <20260921161338.772241F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/atomic: mode_changed forced on VRR toggle adds all planes brea=
king fastsets
- [High] drm/amd/display: multi-display VRR toggle causes unintended modese=
ts via DSC check
--

commit e5fcd3be2834f5245a6d72ea14c2fd1ffcde525f
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/atomic-helper: Set mode_changed on vrr_enabled change

This commit modifies the DRM atomic core to set the mode_changed flag when
the vrr_enabled property changes on a CRTC. This approach intertwines VRR
toggles with mode changes to replace ad-hoc driver implementations.

> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_at=
omic_helper.c
> index 9d006f98413a5..0664d57792826 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -694,6 +694,12 @@ drm_atomic_helper_check_modeset(struct drm_device *d=
ev,
>  			new_crtc_state->active_changed =3D true;
>  		}
> =20
> +		if (old_crtc_state->vrr_enabled !=3D new_crtc_state->vrr_enabled) {
> +			drm_dbg_atomic(dev, "[CRTC:%d:%s] VRR changed\n",
> +				       crtc->base.id, crtc->name);
> +			new_crtc_state->mode_changed =3D true;
                        ^^^^

[Severity: High]
Does setting mode_changed to true here destroy fast-path performance by
adding all planes to the atomic state?

Because new_crtc_state->mode_changed is true, drm_atomic_crtc_needs_modeset=
()
evaluates to true. Later in drm_atomic_helper_check_modeset(), this trigger=
s:

    ret =3D drm_atomic_add_affected_planes(state, crtc);

This unconditionally adds all planes attached to the CRTC to the atomic sta=
te
and acquires their locks. Toggling VRR now forces the driver's commit tail
to process all planes, which significantly increases overhead and causes
unnecessary lock contention across all drivers using this helper.

[Severity: High]
Can this also cause unintended modesets in the AMD display driver when
multiple displays are connected and a DSC check occurs?

During amdgpu_dm_atomic_check(), the forced mode_changed value is cached:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:amdgpu_dm_atomic_check() {
    ...
    dm_new_crtc_state->mode_changed_independent_from_dsc =3D new_crtc_state=
->mode_changed;
    ...
}

The AMD driver correctly identifies the VRR toggle as a fastset and clears
new_crtc_state->mode_changed to false. However, if another CRTC triggers a
modeset, lock_and_validation_needed becomes true, invoking
compute_mst_dsc_configs_for_state().

For the VRR CRTC, pre_compute_mst_dsc_configs_for_state() observes no timing
changes and erroneously restores the cached true value:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c:pre_compute_mst=
_dsc_configs_for_state() {
    ...
    dm_new_crtc_state->base.mode_changed =3D dm_new_crtc_state->mode_change=
d_independent_from_dsc;
    ...
}

This incorrectly flags the VRR CRTC for a full modeset. This causes unexpec=
ted
screen blanking on the VRR display, and if userspace did not provide the
DRM_MODE_ATOMIC_ALLOW_MODESET flag (expecting a fastset), the atomic commit
will be rejected with -EINVAL.

> +		}
> +
>  		if (new_crtc_state->enable !=3D has_connectors) {
>  			drm_dbg_atomic(dev, "[CRTC:%d:%s] enabled/connectors mismatch (%d/%d)=
\n",
>  				       crtc->base.id, crtc->name,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vrr-limite=
r-uapi-v1-0-2fcd7d011646@collabora.com?part=3D3
