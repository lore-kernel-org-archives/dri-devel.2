Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DE1CA5FFC
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 16:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 239F910E071;
	Mon,  5 Oct 2026 16:31:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XGezUrAV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29FCE10E071
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 16:31:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BA36F40F43;
 Mon,  5 Oct 2026 16:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D37F1F00893;
 Mon,  5 Oct 2026 16:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791217881;
 bh=I5endn9+GcWhf7MO81n4aViG+PNUapDlOy79Z9E6Puo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XGezUrAVm+lM/K1my1eGg278kC1SyoLw5vgbya/IphJAv81pxkoiCQW1I5uOvXgTM
 wKzrZQlR1dDqMgjOrI6z05rQhcc91lVuhM9q4tvcsZqKk2KYb3Y+AEnBc44S4MAArv
 duOnD3dHg8PJcpWd3tVNUVKyl5ZTG7K5IpWol0Wcv/4Tg2b6J2NEzgEwUcM01eB3Wz
 Nqf3plsNjO64a4OqheQOGUAC1AMctPCHvDG0M63E4NKokZzy3TXNqu2+B3WlBJ9PpY
 WGbKfi6OrueAvOCpXX999srJMcwjFbyTXgePBHXZU+xyLOrlQYxWcmq6s25niljPmP
 5HJM6FSqZQENQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/display: let a bridge configure sink audio from
 hw_params
To: "Jean-Francois Bobier" <jean-francois.bobier@laposte.net>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261005161824.36445-1-jean-francois.bobier@laposte.net>
References: <20261005131545.23219-1-jean-francois.bobier@laposte.net>
 <20261005161824.36445-1-jean-francois.bobier@laposte.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 16:31:21 +0000
Message-Id: <20261005163121.7D37F1F00893@smtp.kernel.org>
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
- [High] audio: CPU DAI timeout during resume due to ASoC prepare order
- [Medium] audio: sink unconfigured if suspended in SETUP state
--

commit d257aa80aa39633c1d1299041c31c3df56ca93d7
Author: Jean-Francois Bobier <jean-francois.bobier@laposte.net>

drm/display: let a bridge configure sink audio from hw_params

This commit allows HDMI audio bridges to configure the sink audio path from
the ASoC hw_params callback instead of prepare. It adds tracking flags to
ensure the configuration isn't run twice when not needed, specifically to
address bridges that require sink clocks running before the CPU DAI starts.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_audio_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_audio_helper.c
> index 7d78b02c14462..d4281cee7c65e 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
> @@ -34,9 +34,47 @@ static int drm_connector_hdmi_audio_prepare(struct dev=
ice *dev, void *data,
>  	const struct drm_connector_hdmi_audio_funcs *funcs =3D
>  		connector->hdmi_audio.funcs;
> =20
> +	/*
> +	 * Only skip the specific prepare that hw_params already did the work
> +	 * for. ASoC also reaches .prepare with no .hw_params call ahead of it
> +	 * on XRUN recovery and on resume from suspend; prepare_done_in_hw_para=
ms
> +	 * is clear in both cases, so the call below still runs and configures
> +	 * the sink here instead of leaving it unconfigured.
> +	 */
> +	if (connector->hdmi_audio.prepare_early &&
> +	    connector->hdmi_audio.prepare_done_in_hw_params) {
> +		connector->hdmi_audio.prepare_done_in_hw_params =3D false;
> +		return 0;
> +	}

[Severity: High]
Does this state tracking properly account for the CPU DAI being prepared fi=
rst
and timing out before this code is reached?

When the system suspends during active playback, on resume ALSA calls
snd_soc_pcm_dai_prepare() without a preceding .hw_params call. Since ASoC
iterates CPU DAIs before Codec DAIs, the CPU DAI's .prepare executes first
and waits for the sink's audio clock.

However, the clock is not yet running because this codec DAI .prepare has
not been reached. Consequently, the CPU DAI times out and aborts the loop,
leaving audio broken on resume.

[Severity: Medium]
Additionally, does this logic correctly handle a system suspend that occurs
while in the SETUP state?

If the system suspends between the ALSA .hw_params and .prepare ioctls,
hardware power and configuration are lost. On resume, ALSA calls .prepare to
recover.

Because prepare_done_in_hw_params is still true from the previous SETUP pha=
se,
this function clears the flag and returns immediately. This leaves the HDMI
audio sink unconfigured and causes a silent audio failure.

[ ... ]

> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 2ee7c59329aae..749eab1f96303 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -2184,6 +2184,26 @@ struct drm_connector_hdmi_audio {
>  	 * The port in DT that is used for the Codec DAI.
>  	 */
>  	int dai_port;
> +
> +	/**
> +	 * @prepare_early:
> +	 *
> +	 * Call @funcs->prepare from the ASoC hw_params callback instead of
> +	 * from prepare. See &drm_bridge.hdmi_audio_prepare_early.
> +	 */
> +	bool prepare_early;
> +
> +	/**
> +	 * @prepare_done_in_hw_params:
> +	 *
> +	 * Private state for the @prepare_early helper implementation. Not to
> +	 * be set by drivers. Tracks whether hw_params already ran
> +	 * @funcs->prepare for the prepare call immediately ahead, so that
> +	 * call can be skipped without skipping any other prepare -- ASoC
> +	 * calls .prepare without a preceding .hw_params on XRUN recovery and
> +	 * on resume from suspend, and @funcs->prepare must still run then.
> +	 */
> +	bool prepare_done_in_hw_params;
>  };

[Severity: High]
This documentation notes that ASoC calls .prepare without .hw_params on
resume from suspend. Given that ASoC walks CPU DAIs before codec DAIs, will
the CPU DAI's .prepare time out waiting for a clock that this codec DAI has
not yet enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005161824.3644=
5-1-jean-francois.bobier@laposte.net?part=3D1
