Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE40C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4269810F430;
	Thu,  2 Jul 2026 15:08:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LX90oG5C";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E45D310F430
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:08:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B1E644069B;
 Thu,  2 Jul 2026 15:08:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B011F000E9;
 Thu,  2 Jul 2026 15:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783004916;
 bh=MiuUa6JM8fuxIVZ3rhqwzV4NR3iIMau+hnL6NzfYthk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LX90oG5C1MDBXUTl63XagWfsITlBw/p99JKYMSey6/karmBsokNlJh63UtDY36t3L
 TIfI93dwiykZuG2hd1yHoYUy+wy4ow1QCrRYPQ9Z67FU7zfLEAhs+NXkOu+uFdhz3+
 IrD9tJ1HajWN3PVBb9ZwH5Qik6tHL2eJ7WixgvcV6oq4C25ltcmmRJJAh4+gKGBtfI
 qtlAlRJ1AzkBJ2tmof9VfaQsJP6v9atl4VIfgRLaI76WFJpN5QynSBWNOcIJmiaglY
 T1hyQXfu7OYyA/50ME5rzXwjzPgoGPNReCfZ7SWUBv7zkIz5/0mfHjRBwj6NMudG7n
 1YqrFsm5O2iGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 19/39] drm/bridge: dw-hdmi-qp: Add HDMI 2.0 SCDC
 scrambling support
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-19-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-19-d79890d00b6a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:08:36 +0000
Message-Id: <20260702150836.74B011F000E9@smtp.kernel.org>
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
- [Medium] State tracking bug in atomic disable skips PHY shutdown on initi=
al modesets.
--

commit 572f752e8a57b7a37e457765a056b711271ae975
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: drm/bridge: dw-hdmi-qp: Add HDMI 2.0 SCDC scrambling support

Enable HDMI 2.0 display modes (e.g. 4K@60Hz) by implementing SCDC
scrambling and high TMDS clock ratio management for TMDS character
rates exceeding the 340 MHz HDMI 1.4b limit. Reject modes requiring
TMDS rates above 600 MHz since those require HDMI 2.1 FRL.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/d=
rm/bridge/synopsys/dw-hdmi-qp.c
> index a0613f0d2ebcf..07b274f76e53e 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c

[ ... ]

> @@ -752,26 +751,33 @@ static void dw_hdmi_qp_bridge_atomic_enable(struct =
drm_bridge *bridge,
>  {
>  	struct dw_hdmi_qp *hdmi =3D bridge->driver_private;
>  	struct drm_connector_state *conn_state;
> -	struct drm_connector *connector;
>  	unsigned int op_mode;
> +	int ret;
> =20
> -	connector =3D drm_atomic_get_new_connector_for_encoder(state, bridge->e=
ncoder);
> -	if (WARN_ON(!connector))
> +	hdmi->curr_conn =3D drm_atomic_get_new_connector_for_encoder(state,
> +								   bridge->encoder);

[ ... ]

> @@ -787,8 +793,14 @@ static void dw_hdmi_qp_bridge_atomic_disable(struct =
drm_bridge *bridge,
>  {
>  	struct dw_hdmi_qp *hdmi =3D bridge->driver_private;
> =20
> +	if (!hdmi->curr_conn)
> +		return;
> +

[Severity: Medium]
Will this early return skip the PHY disable sequence during initial modeset=
s?

If the DRM core determines the encoder is active on boot and needs to be
disabled for a new modeset, it calls dw_hdmi_qp_bridge_atomic_disable().
Because dw_hdmi_qp_bridge_atomic_enable() hasn't run yet in this boot cycle,
hdmi->curr_conn will be NULL.

This causes the early return to trigger, skipping the hdmi->phy.ops->disabl=
e()
call below. Could this leave the hardware in an inconsistent state, causing=
 PLL
lock failures or display glitches when atomic_enable() tries to re-initiali=
ze
an already running PHY with new parameters?

To avoid caching unreferenced pointers like curr_conn across state changes,
should the old connector be extracted directly from the atomic state using
drm_atomic_get_old_connector_for_encoder() instead?

>  	hdmi->tmds_char_rate =3D 0;
> =20
> +	drm_connector_hdmi_disable_scrambling(hdmi->curr_conn);
> +
> +	hdmi->curr_conn =3D NULL;
>  	hdmi->phy.ops->disable(hdmi, hdmi->phy.data);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-dw-hdmi-qp=
-scramb-v8-0-d79890d00b6a@collabora.com?part=3D19
