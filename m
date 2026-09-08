Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73C9C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E1F10EA73;
	Tue,  8 Sep 2026 07:15:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CKYlVcjc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8274510EA73
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 07:15:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B86A960A97;
 Tue,  8 Sep 2026 07:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C861F00A3A;
 Tue,  8 Sep 2026 07:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788851706;
 bh=dQ8ucXPRZZZnWVxQ1yZR3qNTrcYDHU9KSOiJmdkkHJY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CKYlVcjc+bOOeVTSa8v2xnIeURwamL1I8Iy7zxp1t+0b0cIGB0DPzCp3rxS0G6pXh
 VrQ9MCVSeNk7CsgO9OZYdIeRYsH8Hk/WO43/nb1LPQsvtyR5CoFylKvCjtuzY9kJZg
 CnKPI0xs/Fm3sR7zdWqj+ePbZxjnJ+b218v/WKze6RsYzWzbSigwIWCszqQiYpHYLk
 FbbZYTbazFDn4aEb6Rj1b/c+Mpo59sxQgI8H4yAj5X3E9QSVA/lTnA6d3vMW35gjnh
 jJaQlfqXaT2kOJW/KMtfnPxhGvxt1NsYJIremLI9Z6nJbRyVikM5L37YHsLS99rTxZ
 h/7sLYahwpxNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe
 when PHY is down
To: "Frank Zhang" <rmxpzlb@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908070220.41574-1-rmxpzlb@gmail.com>
References: <20260908070220.41574-1-rmxpzlb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 07:15:05 +0000
Message-Id: <20260908071506.45C861F00A3A@smtp.kernel.org>
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
- [High] The lockless `if (hdmi->tmds_char_rate > 0)` check introduces a Ti=
me-Of-Check to Time-Of-Use (TOCTOU) data race with the DRM atomic commit th=
read, failing to fully prevent the SError panic.

Pre-existing issues:
- [High] `tmds_char_rate` is assigned before the PHY is actually initialize=
d in `dw_hdmi_qp_bridge_atomic_enable`, allowing concurrent audio operation=
s to crash the kernel by accessing unpowered hardware.
--

commit 9d8465ca2470e46cc48135ada91995d64bb0dec1
Author: Frank Zhang <rmxpzlb@gmail.com>

drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe when PHY is down

This patch attempts to prevent an Asynchronous SError Interrupt kernel panic
by checking hdmi->tmds_char_rate before accessing PHY registers during ALSA
audio shutdown. It introduces a lockless check to decouple the audio
infoframe operations from powered-down hardware states.

Link: https://lore.kernel.org/all/20260416093150.13853-1-rmxpzlb@gmail.com/
Link: https://lore.kernel.org/all/20260418101936.7731-1-rmxpzlb@gmail.com/
Link: https://lore.kernel.org/all/20260423081514.15444-1-rmxpzlb@gmail.com/
Link: https://lore.kernel.org/all/20260512103153.8861-1-rmxpzlb@gmail.com/

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/d=
rm/bridge/synopsys/dw-hdmi-qp.c
> index cfd1b18c06e62..f0e9324249d66 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
[ ... ]
> @@ -893,6 +893,16 @@ static int dw_hdmi_qp_bridge_clear_audio_infoframe(s=
truct drm_bridge *bridge)
>  	return 0;
>  }
> =20
> +static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *br=
idge)
> +{
> +	struct dw_hdmi_qp *hdmi =3D bridge->driver_private;
> +
> +	if (hdmi->tmds_char_rate > 0)
> +		return __dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);
> +
> +	return 0;
> +}
> +

[Severity: High]
Does this lockless check introduce a Time-Of-Check to Time-Of-Use race?

If a userspace process closes the ALSA audio stream concurrently with a DRM
atomic disable, could the DRM commit thread clear the tmds_char_rate state
variable and disable the PHY hardware right after this check passes, but
before __dw_hdmi_qp_bridge_clear_audio_infoframe() executes?

For example:

ALSA thread in dw_hdmi_qp_bridge_clear_audio_infoframe():
    if (hdmi->tmds_char_rate > 0) // passes

DRM thread in dw_hdmi_qp_bridge_atomic_disable():
    hdmi->tmds_char_rate =3D 0;
    hdmi->phy.ops->disable(hdmi, hdmi->phy.data);

ALSA thread continues:
    return __dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);

This would result in writing to the disabled PHY and causing the same SError
panic this patch intends to fix. Would it be safer to use a mutex to
serialize audio operations with PHY state changes?

[Severity: High]
This is a pre-existing issue, but looking at how tmds_char_rate is used as a
proxy for hardware readiness, could concurrent audio operations crash the
kernel during a DRM atomic enable?

In dw_hdmi_qp_bridge_atomic_enable(), tmds_char_rate is assigned a non-zero
value before the hardware is actually powered on:

dw_hdmi_qp_bridge_atomic_enable():
    ...
    hdmi->tmds_char_rate =3D conn_state->hdmi.tmds_char_rate;
    hdmi->phy.ops->init(hdmi, hdmi->phy.data);

If an ALSA thread concurrently executes dw_hdmi_qp_audio_prepare() or
dw_hdmi_qp_bridge_write_audio_infoframe(), couldn't it observe
tmds_char_rate > 0 and proceed to access PHY registers before they are
powered on?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908070220.4157=
4-1-rmxpzlb@gmail.com?part=3D1
