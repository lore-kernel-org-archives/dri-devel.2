Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67A9C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E77110E4F5;
	Mon,  7 Sep 2026 13:11:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jCadTu4e";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DCF210E407
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:11:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CD03260A9C;
 Mon,  7 Sep 2026 13:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AD21F00A3A;
 Mon,  7 Sep 2026 13:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788786713;
 bh=sOUEM8R63wJvnIvFrvAyTl2doOcjJ9JD/iyOu6HDJU0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jCadTu4e6EhjcXW93RyoRJO22K/Ssa03RyhqRtGg1K6AjrlKTN2ontvMealDpkd+f
 F+DzMg1I8JjeUMdK9IBf+crfHCZncs9xPLxDRejn1ePWnGMC5yXt5eJAdN0Vxo731h
 S7WpWHFPqjpE1RIbVsn6vpVpRG0QDJ1CM+EmgjD669oWIwlYl3n6tO5TsOBMmdWgDt
 tfvEkA45+lXBKJQEPKhNJvR+kc/uiQpxrLM68ll6hvqFqUzaVzo7i+pSZAe/6tQYNy
 B/NsMD9PuvWwOhsCnIY+WyWyiZhgrySE9u6JPicT2dhjXXWyFiU8TfHuw3auwMVGyd
 0jEgg1BlN5BIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/7] drm/msm/hdmi_bridge: Correct poweroff/audio
 cleanup order in post_disable
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-3-b097cf1eac77@oss.qualcomm.com>
References: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
 <20260907-drm-msm-hdmi-fixes-before-eliza-v2-3-b097cf1eac77@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 13:11:52 +0000
Message-Id: <20260907131153.34AD21F00A3A@smtp.kernel.org>
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
- [Medium] Moving `hdmi->power_on =3D false` to after `msm_hdmi_audio_updat=
e()` breaks the audio hardware disablement logic, leaving the audio engine =
active before its power is cut.

Pre-existing issues:
- [High] Unclocked MMIO accesses in ALSA audio callbacks can cause a kernel=
 panic if the DRM bridge is powered off.
--

commit b86cb24a12ce06704d3597339883527b57932c00
Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

drm/msm/hdmi_bridge: Correct poweroff/audio cleanup order in post_disable

Turning off the power in msm_hdmi_bridge_atomic_post_disable() should
follow reverse order of powering up, not only because it is logical, but
also because msm_hdmi_audio_update() accesses registers thus block
should still be powered on.

Depending on specific timing, existing code could have accesses to MMIO
of powered off block.

Cc: <stable@vger.kernel.org>

> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm=
/hdmi/hdmi_bridge.c
> index db85400e574e4..04c893062dbd4 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> @@ -339,10 +339,10 @@ static void msm_hdmi_bridge_atomic_post_disable(str=
uct drm_bridge *bridge,
>  	msm_hdmi_phy_powerdown(phy);
> =20
>  	if (hdmi->power_on) {
> -		power_off(bridge);
> -		hdmi->power_on =3D false;
>  		if (hdmi->connector->display_info.is_hdmi)
>  			msm_hdmi_audio_update(hdmi);

[Severity: High]
This isn't a bug introduced by this patch, but can unclocked MMIO accesses =
in
ALSA audio callbacks cause a kernel panic if the DRM bridge is powered off?

If a user-space ALSA application starts or stops audio playback while the
display is powered off (e.g., via DPMS blanking), the ALSA callbacks
msm_hdmi_bridge_audio_prepare() and msm_hdmi_bridge_audio_shutdown() in
drivers/gpu/drm/msm/hdmi/hdmi_audio.c call msm_hdmi_audio_update().

This function reads from MMIO registers unconditionally, without verifying =
if
the HDMI block is powered on or holding a PM runtime reference. Could this =
lead
to a synchronous external abort (kernel panic) due to unclocked MMIO access?

> +		power_off(bridge);
> +		hdmi->power_on =3D false;

[Severity: Medium]
Does moving hdmi->power_on =3D false to after msm_hdmi_audio_update() break=
 the
audio hardware disablement logic?

The audio shutdown logic in msm_hdmi_audio_update() relies on hdmi->power_on
being false during teardown to correctly disable audio:

drivers/gpu/drm/msm/hdmi/hdmi_audio.c:msm_hdmi_audio_update() {
	...
	if (enabled && !(hdmi->power_on && hdmi->pixclock)) {
		DBG("disabling audio: no video");
		enabled =3D false;
	}
	...
}

By setting hdmi->power_on =3D false after the call, msm_hdmi_audio_update()=
 still
evaluates hdmi->power_on as true. Will this leave the audio engine active a=
nd
programmed to remain enabled right before its power and clocks are cut,
potentially leading to transient audio glitches or incomplete hardware state
reset?

>  		msm_hdmi_phy_resource_disable(phy);
>  	}
>  	mutex_unlock(&hdmi->state_mutex);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-drm-msm-hd=
mi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com?part=3D3
