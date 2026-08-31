Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3409C624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 23:55:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 432B510E383;
	Mon, 31 Aug 2026 23:55:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jw5zq+mT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F80510E285;
 Mon, 31 Aug 2026 23:55:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 73E24601DE;
 Mon, 31 Aug 2026 23:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F641F000E9;
 Mon, 31 Aug 2026 23:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788220539;
 bh=NEQIaboQMPbpmXNkbp/hqCXRStAUMmc/5DpYJeoJy8E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Jw5zq+mTcSVhrFCpLZSuqVw5QJjnSyIlsVoh1nRDR9jo6Auxtj3bjuO0Cl2p8SEJY
 cdLj+3XWClAfLrnDolU9VHKE3Gh4WnW0YCF799+Nn9EE7E2T4Ct0ULmxcc0kiARXx2
 OmJtOdPfLJJ6gjkmMX//7kLKmVYWdgfTzbzkNhseERhMmoBK0QSK5/Bf/UbTOwoutM
 dvrsGFSnkmMRwjKh6hiVT2buA1NbCZIIGWmqf2JMI8OLj7lti7QOIh2V0YoDMaloNa
 ThNe7zBe/LFHL3FtTjmeFQE6Ymo0WRh1TI2qALJqo7BTEMlvokXPkmVN1wJoekAMh6
 ONLZecnhbXr3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/12] drm/i915/display: use drm backlight
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260831210531.2334221-13-mario.limonciello@amd.com>
References: <20260831210531.2334221-1-mario.limonciello@amd.com>
 <20260831210531.2334221-13-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 23:55:38 +0000
Message-Id: <20260831235538.E3F641F000E9@smtp.kernel.org>
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

New issues:
- [Low] Unused include `<drm/drm_backlight.h>` in `intel_dp.c`

Pre-existing issues:
- [High] TOCTOU race in sysfs backlight update leading to NULL pointer dere=
ference during non-blocking display disable
--

commit 6982034de97212a1664f3db93710a699b08ecdab
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/i915/display: use drm backlight

This commit converts the Intel display drivers (i915 and xe) to use the DRM
backlight infrastructure, allowing brightness control via the connector
LUMINANCE property. It links the backlight device to the eDP connector on
registration and unlinks it on unregistration.

> diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu=
/drm/i915/display/intel_backlight.c
> index b128896cb1c2d..b0cd4dc3adc00 100644
> --- a/drivers/gpu/drm/i915/display/intel_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_backlight.c

[ ... ]

> @@ -1015,6 +1018,7 @@ void intel_backlight_device_unregister(struct intel=
_connector *connector)
>  	struct intel_panel *panel =3D &connector->panel;
> =20
>  	if (panel->backlight.device) {
> +		drm_backlight_link(&connector->base, NULL);
>  		backlight_device_unregister(panel->backlight.device);
>  		panel->backlight.device =3D NULL;
>  	}

[Severity: High]
This is a pre-existing issue, but could this cause a NULL pointer dereferen=
ce
during a non-blocking display disable?

If there is a concurrent userspace write to the legacy sysfs brightness file
during a non-blocking display disable on VLV/CHV hardware, we might hit a r=
ace.
During the non-blocking commit, connection_mutex is dropped before the hard=
ware
is disabled, allowing intel_backlight_device_update_status() to execute.

It uses the newly swapped connector->base.state (where crtc =3D NULL), but
panel->backlight.enabled remains true until the asynchronous commit tail
disables it.

This seems to lead to intel_panel_set_backlight() passing the state directly
to the backend without checking if conn_state->crtc is NULL:

drivers/gpu/drm/i915/display/intel_backlight.c:intel_panel_set_backlight() {
    ...
    if (panel->backlight.enabled)
        intel_panel_actually_set_backlight(conn_state, hw_level);
    ...
}

Which then calls into vlv_set_backlight() where the NULL crtc is dereferenc=
ed:

drivers/gpu/drm/i915/display/intel_backlight.c:vlv_set_backlight() {
    ...
    enum pipe pipe =3D to_intel_crtc(conn_state->crtc)->pipe;
    u32 tmp;

    tmp =3D intel_de_read(display, VLV_BLC_PWM_CTL(pipe)) & ~BACKLIGHT_DUTY=
_CYCLE_MASK;
    intel_de_write(display, VLV_BLC_PWM_CTL(pipe), tmp | level);
    ...
}

Does this require a check for conn_state->crtc being NULL before passing the
state, similar to how other backlight functions handle it?

[ ... ]

> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
> index 113d767e62e9c..2381a80a4e671 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -43,6 +43,7 @@
>  #include <drm/display/drm_dsc_helper.h>
>  #include <drm/display/drm_hdmi_helper.h>
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_backlight.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_fixed.h>

[Severity: Low]
Is this include used anywhere in this file?

It looks like <drm/drm_backlight.h> is added to intel_dp.c but no symbols f=
rom
it are utilized in this file, resulting in a dead include.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831210531.2334=
221-1-mario.limonciello@amd.com?part=3D12
