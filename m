Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EB0CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D909C10E12C;
	Wed, 14 Oct 2026 01:19:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAD3010E12C
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 01:19:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8D901600CB;
 Wed, 14 Oct 2026 01:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285D61F000FF;
 Wed, 14 Oct 2026 01:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791940759;
 bh=xM1RkneBYmio/YJXAdDphgKKOYyxu1UpTMwTY8MhG88=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=m8AD+oOJ+h8NUaB8QULazYW/JqVc3skeb255G8AhGSar8y7c0nesL9sVLXXf+B1vq
 Jdg/QD1ca8E1AOdO/FV9zX63FEdV30W0yfnSRgngymtDkCVd9LCyO+Y85U1x/P9igL
 cnNHcOFU8GqXX9USSxmTjutUcGmJeugV+JlaZqA9NB33rQcTcZ5IyaVtMi9/g1ep2g
 2qj+l8lfJ7Vnyf4cXQVwSgPNHMGoAlelInw1vT1HL0ulyviUeK5tf0Vg5iicfMpUKv
 qeS6zlfmJD4I4DRNV9AxEX2z9ABzvKi1aRP5OnW/QPTAEwaAoWQdWrkyQByL7w5G9s
 yzoJKPHD4aU6w==
Message-ID: <sashiko-outbox-170670@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/9] drm/vc4: hdmi: Convert to common HDMI 2.0
 scrambling infrastructure
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261014-vc4-common-scramb-v3-6-c68d58d959a2@collabora.com>
References: <20261014-vc4-common-scramb-v3-0-c68d58d959a2@collabora.com>
 <20261014-vc4-common-scramb-v3-6-c68d58d959a2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 01:19:18 +0000
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
- [Medium] drm/vc4: spurious CRTC reset on hotplug due to stale scrambler_e=
nabled flag
--

commit b54514a951277541ceb5327bc2186f46057b3bd2
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/vc4: hdmi: Convert to common HDMI 2.0 scrambling infrastructure

This commit replaces the local VC4 scrambling logic with the common HDMI 2.0
scrambling support in the DRM core. It delegates sink-side SCDC programming
and monitoring to the core, drops local state tracking for scrambling, and
switches to the core hotplug helpers.

> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdm=
i.c
> index a03e50e8afcb3..2451ff85e7597 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
[ ... ]
> @@ -535,6 +410,14 @@ static int vc4_hdmi_connector_init(struct drm_device=
 *dev,
> =20
>  	drm_connector_helper_add(connector, &vc4_hdmi_connector_helper_funcs);
> =20
> +	/*
> +	 * Since we don't know the state of the controller and its
> +	 * display (if any), let's assume it's always enabled.
> +	 * drm_connector_hdmi_disable_scrambling() will thus run at boot,
> +	 * make sure it's disabled, and avoid any inconsistency.
> +	 */
> +	connector->hdmi.scrambler_enabled =3D drm_connector_hdmi_scrambler_supp=
orted(connector);
> +

[Severity: Medium]
Will this lead to spurious CRTC resets on hotplug events or EDID polls?

If the display starts disconnected, its initial atomic state has crtc set to
NULL. When a display is plugged in and a mode not requiring scrambling is s=
et
(e.g. 1080p), the encoder disable hook is skipped by=20
drm_atomic_helper_commit_modeset_disables() because old_conn_state->crtc is
NULL.=20

Then drm_connector_hdmi_enable_scrambling() in the core returns early witho=
ut
clearing the scrambler_enabled flag:

drivers/gpu/drm/display/drm_hdmi_helper.c:drm_connector_hdmi_enable_scrambl=
ing() {
	...
	if (!conn_state->hdmi.scrambler_needed)
		return 0;
	...
}

The flag remains true.

Subsequently, when drm_kms_helper_poll_worker() runs or an HPD event occurs,
drm_connector_hdmi_sync_scdc() sees the stale true flag:

drivers/gpu/drm/display/drm_hdmi_helper.c:drm_connector_hdmi_sync_scdc() {
	...
	if (!drm_connector_hdmi_scrambler_supported(connector) ||
	    !READ_ONCE(hdmi->scrambler_enabled))
		return 0;
	...
}

This reads the SCDC register (where scrambling is actually disabled) and
triggers a spurious drm_atomic_helper_reset_crtc(), causing the display to
flicker.

The previous local logic checked if scrambling was needed before reading SC=
DC,
but the new framework relies on this flag. How can we ensure the flag is
cleared when scrambling isn't needed on the first modeset?

>  	/*
>  	 * Some of the properties below require access to state, like bpc.
>  	 * Allocate some default initial connector state with our reset helper.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-vc4-common=
-scramb-v3-0-c68d58d959a2@collabora.com?part=3D6
