Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0B8CA5FFC
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2949B10EDBB;
	Mon,  5 Oct 2026 15:28:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ccCjwBHY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39E1010EDBB
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 15:28:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E13760514;
 Mon,  5 Oct 2026 15:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1971F000FF;
 Mon,  5 Oct 2026 15:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791214097;
 bh=WgUZKeQa9qI699t/ZskfufC9ZWDZZVTyVgX4jJ7R1HE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ccCjwBHYaol8/ddpDNbuRjiW7WMTfDvdbIdsFWoBGARkyfNTYr5SkpyAEJL3PlwVc
 eL8OTdT45SSB2W2tI9U2l2DFpTbdr20UoBIhV1elnytmYVNnOaSFl8nRkwo4sIe8GY
 7ltzEAZmralsAZUlmReF3rV20lzuLk4mlc+UuxLgJIhPaTNZudyvPfLbw7h7Drxn5n
 uTOkEuMb4CfG0CAtpVaKN4efuQwxoeNaA+WZbNXowKyNpvAUO6ykFsAb/byKVmXMmO
 5lBo9KrHhwUlymLeJcqhcUujQSbax8ojB1Ea8tqrOErp03MjCcjY4r0dgIcfrsHKQX
 1EmVQEJDfT+og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/display: let a bridge configure sink audio from
 hw_params
To: "Jean-Francois Bobier" <jean-francois.bobier@laposte.net>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261005131545.23219-1-jean-francois.bobier@laposte.net>
References: <20261005131545.23219-1-jean-francois.bobier@laposte.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 15:28:16 +0000
Message-Id: <20261005152816.CF1971F000FF@smtp.kernel.org>
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
- [High] drm/display: skipping bridge prepare() breaks ALSA resume and XRUN=
 recovery
--

commit 9242b33c411ab2327a1ed1ae0af3ab2560e75b3a
Author: Jean-Francois Bobier <jean-francois.bobier@laposte.net>

drm/display: let a bridge configure sink audio from hw_params

This commit introduces a prepare_early flag to configure a sink's audio
path from the ASoC hw_params callback rather than from prepare. This is
done to support configurations where the CPU side of the DAI link cannot
start until the sink's audio clock is already running.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_audio_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_audio_helper.c
> index 7d78b02c14462..3ed5d73f17eb0 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
> @@ -34,6 +34,28 @@ static int drm_connector_hdmi_audio_prepare(struct dev=
ice *dev, void *data,
>  	const struct drm_connector_hdmi_audio_funcs *funcs =3D
>  		connector->hdmi_audio.funcs;
> =20
> +	if (connector->hdmi_audio.prepare_early)
> +		return 0;

[Severity: High]
Can skipping hardware initialization here break recovery from XRUNs or syst=
em
resume?

When ALSA resumes from system suspend or recovers from an XRUN, the core (or
userspace) calls snd_pcm_prepare() without calling .hw_params. Because
prepare_early is set, drm_connector_hdmi_audio_prepare() returns early and
skips funcs->prepare().

This means the hardware audio clocks and infoframe configurations are never
restored, and the subsequent CPU DAI .prepare can time out waiting for the
missing audio clock.

> +
> +	return funcs->prepare(connector, fmt, hparms);
> +}
> +
> +/*
> + * Only used by connectors that asked for it; everyone else keeps being
> + * configured from prepare() and this returns without doing anything. See
> + * &drm_bridge.hdmi_audio_prepare_early for why a connector would want i=
t.
> + */
> +static int drm_connector_hdmi_audio_hw_params(struct device *dev, void *=
data,
> +					      struct hdmi_codec_daifmt *fmt,
> +					      struct hdmi_codec_params *hparms)
> +{
> +	struct drm_connector *connector =3D data;
> +	const struct drm_connector_hdmi_audio_funcs *funcs =3D
> +		connector->hdmi_audio.funcs;
> +
> +	if (!connector->hdmi_audio.prepare_early)
> +		return 0;
> +
> +	return funcs->prepare(connector, fmt, hparms);

[Severity: High]
Will shifting the hardware setup exclusively to .hw_params leave the hardwa=
re
disabled during recovery?

Because ALSA does not invoke .hw_params during XRUN or resume recovery,
shifting the configuration entirely here means the stream may become comple=
tely
unusable after an XRUN or system resume. This would require the stream to be
fully closed and reopened to recover.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005131545.2321=
9-1-jean-francois.bobier@laposte.net?part=3D1
