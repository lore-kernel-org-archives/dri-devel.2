Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3FFC44532
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:53:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B60F610EF57;
	Thu, 23 Jul 2026 01:53:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZNMht7Td";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65F3A10EF57
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 01:53:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 487A1600AB;
 Thu, 23 Jul 2026 01:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94241F000E9;
 Thu, 23 Jul 2026 01:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784771587;
 bh=pWTU5JdzSAUfPmcHwN5so1hBshLSEp8c9dgMtokF0vE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZNMht7Td/4i8LxD4rD+2w02O1VvIafMlahRXLLC2ofZykGRguYWvC/Mj7C8H1f6y1
 F7skjGEDeiRFOg7N2AzVbt5GKB6zBgX/UVL805MvuwWiOHDNabW2JbyDUjr4CML9Vd
 N3RqWT+sox5WQH8bYxj55baswJJ0gON/9VtfP77jlwN4oeVTGwxfQ6eudzqDz6FCm2
 R33xYu+MRAvjB88OpJnucISMkFIcMIB9fdIDxILpqFL52CfOh0B+WowjEH/0GFf0Xy
 kyHHDz3Zw9B/YooiZKHPRJ4OBpDxeBxAEEJA6WyrXV9wA1CmTA6QmU4Mg4iXwmA1vV
 xMhDHtFyMn+lQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 03/61] drm/connector: Add drmm_connector_hdmi_init()
 with new signature
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-3-4fb12ea22ac9@collabora.com>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
 <20260723-dw-hdmi-qp-scramb-v9-3-4fb12ea22ac9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 01:53:06 +0000
Message-Id: <20260723015306.C94241F000E9@smtp.kernel.org>
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
- [High] Missing validation for `hdmi_funcs->supported_hdmi_ver` leading to=
 a 0 Hz TMDS rate limit or spurious -EINVAL on initialization.

Pre-existing issues:
- [High] Missing NULL check on `connector->state` before calling `drm_conne=
ctor_attach_max_bpc_property()`, leading to a potential NULL pointer derefe=
rence.
--

--- Patch [3]: [PATCH v9 03/61] drm/connector: Add drmm_connector_hdmi_init=
() with new signature ---
commit 68ee3a0c1e1945b6e973060559a1cafa855a35d7
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: drm/connector: Add drmm_connector_hdmi_init() with new signature

This patch introduces a new function drmm_connector_hdmi_init() with a
reduced signature by moving HDMI-specific parameters into struct
drm_connector_hdmi_funcs. It also infers the maximum TMDS character rate
from the supported HDMI version or allows an override if specified.

> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c

[ ... ]

> +	/*
> +	 * The supported HDMI version can be used to determinate the maximum
> +	 * TMDS character rate allowed by the specification. Some controllers,
> +	 * however, may support a lower rate than that version would imply.
> +	 *
> +	 * A non-zero caps->max_tmds_char_rate lets drivers override this
> +	 * default with the actual controller capability. A value of zero keeps
> +	 * the limit inferred from supported_hdmi_ver.
> +	 */
> +	if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_2_0)
> +		connector->hdmi.max_tmds_char_rate =3D HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ;
> +	else if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_1_3)
> +		connector->hdmi.max_tmds_char_rate =3D HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
> +	else if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_1_0)
> +		connector->hdmi.max_tmds_char_rate =3D HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;

[Severity: High]
What happens if hdmi_funcs->supported_hdmi_ver is 0 (HDMI_VERSION_UNKNOWN) =
in
drmm_connector_hdmi_init()?

If a driver developer forgets to initialize hdmi_funcs->supported_hdmi_ver,
it defaults to 0. This if/else block falls through without setting
max_tmds_char_rate, leaving it at 0.

If a driver provides a custom supported_tmds_char_rate, initialization will
then fail with -EINVAL. Otherwise, the connector initializes with a 0 Hz
TMDS limit, which could break display mode validation by rejecting all
display modes.

> +
> +	if (hdmi_funcs->supported_tmds_char_rate) {
> +		if (hdmi_funcs->supported_tmds_char_rate > connector->hdmi.max_tmds_ch=
ar_rate) {
> +			drm_err(dev, "Enforced max_tmds_char_rate exceeds %llu spec limit\n",
> +				connector->hdmi.max_tmds_char_rate);
> +			return -EINVAL;
> +		}
> +		connector->hdmi.max_tmds_char_rate =3D hdmi_funcs->supported_tmds_char=
_rate;
> +	}

[ ... ]

> +	if (connector->funcs->atomic_create_state) {
> +		struct drm_connector_state *state;
> +
> +		state =3D connector->funcs->atomic_create_state(connector);
> +		if (IS_ERR(state))
> +			return PTR_ERR(state);
> +
> +		connector->state =3D state;
> +	} else if (connector->funcs->reset) {
> +		connector->funcs->reset(connector);
> +	}
> +
> +	drm_connector_attach_max_bpc_property(connector, 8, hdmi_funcs->max_bpc=
);

[Severity: High]
This isn't a bug introduced by this patch, but could this lead to a NULL
pointer dereference in drm_connector_attach_max_bpc_property() if the reset
callback fails?

In drmm_connector_hdmi_init(), if the reset callback fails to allocate memo=
ry
(e.g., inside drm_atomic_helper_connector_reset()), connector->state will
remain NULL.

When this is unconditionally passed to
drm_connector_attach_max_bpc_property(), would it dereference the NULL stat=
e:

drivers/gpu/drm/drm_connector.c:drm_connector_attach_max_bpc_property() {
	...
	connector->state->max_requested_bpc =3D max;
	...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-dw-hdmi-qp=
-scramb-v9-0-4fb12ea22ac9@collabora.com?part=3D3
