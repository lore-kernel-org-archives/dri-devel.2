Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3DFC79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B2D210EA7F;
	Tue,  8 Sep 2026 07:23:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d+SF7vq7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 902EE10EA7F
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 07:23:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 14332601DB;
 Tue,  8 Sep 2026 07:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611331F00A3A;
 Tue,  8 Sep 2026 07:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788852215;
 bh=zFWKbkGkVlUJAyCJleWaxyRTqtFqm+b5gMjdrVXIdxc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=d+SF7vq7iFfEe/hHydLdQQvbsrokArxgk2tFFiz1DZPMhDIrg3gnHRBTXYLxrQpbk
 qtwHI8OzcMXTFRlEWjt+r2unnP4ZyamtqXvUq8b+5D7XhPeUgQOHOnNSwJMlX1fIAX
 PqYrYe9Q5Oe92yl75G9ZhRz4ohtSvLYSt7uMehdXW773/VLn4Hwrfb9Qa4i1tYwkFV
 tN0ejOSk4jILAvk3IZhPN6AaAPHL3zaB3Bh3QF0ojCaDXWAIIR4mcc7hp9pmslQi8t
 SloLhERvySjyecjHVZ6LobcRzRcFDA+taScw0sgryDn3orAw1hXKus5anEz3ntUx1z
 QNreTnvyWqwow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/7] drm/msm/hdmi_bridge: Correct poweroff/audio
 cleanup order in post_disable
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-3-dcf8956878ca@oss.qualcomm.com>
References: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
 <20260908-drm-msm-hdmi-fixes-before-eliza-v3-3-dcf8956878ca@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 07:23:34 +0000
Message-Id: <20260908072335.611331F00A3A@smtp.kernel.org>
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
- [High] ALSA audio callbacks execute locklessly and can run concurrently w=
ith the DRM modeset disable sequence or when the display is fully powered o=
ff, leading to unclocked MMIO access exceptions (kernel panics) and registe=
r corruption.
--

commit 7fe5c8b01a7d1a03dc085316a4205c3b77f6e3a8
Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

drm/msm/hdmi_bridge: Correct poweroff/audio cleanup order in post_disable

This commit corrects the poweroff and audio cleanup order in
msm_hdmi_bridge_atomic_post_disable() to ensure the block remains powered on
when msm_hdmi_audio_update() accesses registers.

> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm=
/hdmi/hdmi_bridge.c
> index db85400e574e4..1860605850c9b 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> @@ -339,10 +339,10 @@ static void msm_hdmi_bridge_atomic_post_disable(str=
uct drm_bridge *bridge,
>  	msm_hdmi_phy_powerdown(phy);
> =20
>  	if (hdmi->power_on) {
> -		power_off(bridge);
>  		hdmi->power_on =3D false;
>  		if (hdmi->connector->display_info.is_hdmi)
>  			msm_hdmi_audio_update(hdmi);
> +		power_off(bridge);

[Severity: High]
This isn't a bug introduced by this patch, but does this still leave a race
window with concurrent lockless ALSA callbacks?

When userspace starts an audio stream on the HDMI audio PCM device, the ALSA
framework invokes msm_hdmi_bridge_audio_prepare() without acquiring
hdmi->state_mutex. This in turn calls msm_hdmi_audio_update(), which reads
hdmi->power_on locklessly:

drivers/gpu/drm/msm/hdmi/hdmi_audio.c:msm_hdmi_audio_update() {
    ...
    if (enabled && !(hdmi->power_on && hdmi->pixclock)) {
        DBG("disabling audio: no video");
        enabled =3D false;
    }

    /* Read first before writing */
    acr_pkt_ctrl =3D hdmi_read(hdmi, REG_HDMI_ACR_PKT_CTRL);
    ...
}

Even if msm_hdmi_audio_update() observes hdmi->power_on as false and sets
enabled =3D false, it proceeds unconditionally to execute the hdmi_read().

If msm_hdmi_bridge_atomic_post_disable() runs concurrently and calls
power_off(bridge) exactly between msm_hdmi_audio_update() checking
hdmi->power_on and attempting the MMIO read, can this result in an unclocked
MMIO access exception that crashes the system?

>  		msm_hdmi_phy_resource_disable(phy);
>  	}
>  	mutex_unlock(&hdmi->state_mutex);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-drm-msm-hd=
mi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com?part=3D3
