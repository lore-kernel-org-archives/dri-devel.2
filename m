Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8428C79FAA
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 05:03:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE50610E9DA;
	Tue,  8 Sep 2026 05:03:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eRwaf3BE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0386110E9B4;
 Tue,  8 Sep 2026 05:03:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AB57641354;
 Tue,  8 Sep 2026 05:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED111F00A3A;
 Tue,  8 Sep 2026 05:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788843818;
 bh=134Fk8vVoZZY4+YfwBpdo/O3D5RbQhXw6PMdiUszjIY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eRwaf3BEc3uT+WHbmM1SFLPSrfzQ1lsQlJ7grs3qHlXufNRNtQIYJEOjLlI/uBnEM
 nxn6IBtqxfFqhOePnPmQ7TjD3hpbRbypQr20rVVdAAcYHJYdZ1+7jSFJT7U7Gg6rRC
 ZFk7JNjixVXZ26+zhajVMF16c7HVcGM3/zdC6xePRy79JCPGCjQGKOUM9GAcTRTexr
 mU3nFzQeUe74mmc0uevkZTP/Iuc9KS70nsbfvI+cCQEdPKVJb2B5cSEmW8A7wBrPU2
 K9b80J+zOWzJ4znNnqGOpARd6wIQqK0+Q2IPr6DLGvzZMQ4hkJwVjkYg0J+IB+i4aU
 4cJyXh3ilPZdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 14/14] drm/i915/display: use drm backlight
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20260908044035.62093-15-mario.limonciello@amd.com>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-15-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 05:03:37 +0000
Message-Id: <20260908050338.4ED111F00A3A@smtp.kernel.org>
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
- [High] Unprotected access to `crtc->state` in `drm_atomic_helper_connecto=
r_apply_luminance` leading to Use-After-Free.
--

commit 4d692fcf914aa54e6baac83f8855bd80382896c8
Author: Mario Limonciello <mario.limonciello@amd.com>
Subject: drm/i915/display: use drm backlight

Convert the Intel display drivers to the DRM backlight infrastructure so
brightness can be controlled through the connector LUMINANCE property. The
DRM core owns the embedded backlight state and its property.

> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/d=
rm/i915/display/intel_display.c
> index 9dfd095f325f7..d53e5f4bdf57d 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
[ ... ]
> @@ -7608,6 +7610,9 @@ static void intel_atomic_commit_tail(struct intel_a=
tomic_state *state)
>  	/* Now enable the clocks, plane, pipe, and connectors that we set up. */
>  	display->modeset.funcs->commit_modeset_enables(state);
> =20
> +	for_each_new_connector_in_state(&state->base, connector, new_conn_state=
, i)
> +		drm_atomic_helper_connector_apply_luminance(new_conn_state);
> +

[Severity: High]
Could this lead to a Use-After-Free of the CRTC state?

When userspace updates only the LUMINANCE property, the CRTC is not pulled
into the atomic state, meaning crtc->mutex is never locked and no
serialization dependencies are established.

In intel_atomic_commit_tail(), we call
drm_atomic_helper_connector_apply_luminance() which dereferences the
global CRTC state:

drivers/gpu/drm/drm_atomic_helper.c:drm_atomic_helper_connector_apply_lumin=
ance() {
	struct drm_connector *connector =3D conn_state->connector;

	if (conn_state->crtc && conn_state->crtc->state &&
	    conn_state->crtc->state->active)
		drm_backlight_set_luminance(connector, conn_state->luminance);
}

Since the LUMINANCE commit executes concurrently with no CRTC
synchronization, another thread performing a modeset or DPMS update could
simultaneously acquire crtc->mutex, call drm_atomic_helper_swap_state(),
and free the old CRTC state while this code evaluates ->active.

Is this safe without acquiring the CRTC lock or pulling the CRTC into the
atomic transaction?

>  	intel_display_power_dc3co_compute(state);
> =20
>  	/* FIXME probably need to sequence this properly */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908044035.6209=
3-1-mario.limonciello@amd.com?part=3D14
