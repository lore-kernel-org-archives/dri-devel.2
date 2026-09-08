Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41B7C79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 06:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3652110EA0B;
	Tue,  8 Sep 2026 06:41:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N4nDdphA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E24CA10EA0B
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 06:41:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0593B6022B;
 Tue,  8 Sep 2026 06:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FC61F00A3A;
 Tue,  8 Sep 2026 06:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788849661;
 bh=VzgSxDt3W40ywf6DuzqN2jSyauvottaXg/7z8/fZ8hw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=N4nDdphAll54UKpRUBhhZ+aKq6O7Vmpn1ya/r+Wu0Q2vFMB9st1qQrp5E8qEWzsNe
 76VQhj1DSQmXCTweu36ON6pPEL37bg3+LCJiWLP2u8C2AROmpt/B4lckQU9kvWccz1
 W0SjFPE8N/AEyHHF6qy3cTpZFzqZWWRz78AMet6apNF4mqQzCCVLuAlAxjjcPRRBpm
 wNXbdWrllxL9C4NMLAQl42ME4/+WwdRIwJAB4x7IkRn3c2n+82tIgGN9rej54DSC3r
 erTXU6oI6uWIz2yUw+/VF+JiHGsQvyOjCw/q48T3/PslpuaUn/41BQAV2em9aZzLTI
 qCBw1FM6EO2Xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe
 when PHY is down
To: "Frank Zhang" <rmxpzlb@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908062708.39437-1-rmxpzlb@gmail.com>
References: <20260908062708.39437-1-rmxpzlb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 06:41:01 +0000
Message-Id: <20260908064101.87FC61F00A3A@smtp.kernel.org>
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
- [High] Missing synchronization lock between DRM atomic disable and ALSA c=
allbacks leaves a Time-Of-Check to Time-Of-Use (TOCTOU) race condition, fai=
ling to fix the kernel panic.
--

commit 41e47d6bcdba49646deba6ac74845c934529f2f4
Author: Frank Zhang <rmxpzlb@gmail.com>

drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe when PHY is down

This commit attempts to fix a kernel panic caused when an audio server
closes the HDMI audio device concurrently with an atomic_disable. It tries
to guard register accesses in the audio teardown path by checking the
tmds_char_rate state variable.

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
This isn't a bug introduced by this patch, but does this lockless check
leave an open Time-Of-Check to Time-Of-Use (TOCTOU) race condition?

If a userspace audio server (like pipewire) closes the HDMI audio device at
the same time as a DRM modeset disables the display, the ALSA teardown path
can execute dw_hdmi_qp_bridge_clear_audio_infoframe() and successfully
evaluate this unguarded check.

Concurrently, dw_hdmi_qp_bridge_atomic_disable() can execute:

    hdmi->tmds_char_rate =3D 0;
    hdmi->phy.ops->disable(hdmi, hdmi->phy.data);

This zeroes the state variable and powers off the PHY without
synchronization. The ALSA thread can then resume and invoke
__dw_hdmi_qp_bridge_clear_audio_infoframe(), writing to the now-disabled
PHY registers and triggering the Asynchronous SError Interrupt panic this
patch is trying to fix.

Additionally, could the same race exist in dw_hdmi_qp_audio_prepare()?

    if (!hdmi->tmds_char_rate)
        return -ENODEV;
   =20
    // ... further down ...
    dw_hdmi_qp_set_audio_interface(hdmi, fmt, hparms);

This path configures multiple registers after a lockless check, making the
entire preparation sequence vulnerable to the same race condition.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908062708.3943=
7-1-rmxpzlb@gmail.com?part=3D1
