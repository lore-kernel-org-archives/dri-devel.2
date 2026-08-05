Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD6BC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5069A10EEE3;
	Wed,  5 Aug 2026 15:42:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XrHdS0iG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA8F610EEE3
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 15:42:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C1FA0600AE;
 Wed,  5 Aug 2026 15:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED161F000E9;
 Wed,  5 Aug 2026 15:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785944551;
 bh=3Y3CidiSbVUDVx7qpPrrdCLbI9YipBxRHM8J88Md87M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XrHdS0iGhh9OGmHgIzmtRlqcPP9e/o/hxQX6RxNXWAQMiuqYK9hkOqzQQqoCSWBoM
 t6L9v13oi0n9dxdR7E8DufjdtqJKZNpU6jkjhrlUxGAKFst0mkBwF1kVRsKsh8j4wa
 EiAFzhwDg/AYwPE0RAnftE4/cR6o894bRGVj2lsG5ydcGRt1zA1rZvWlz56KCL2B1A
 5Z+FaqgCw/7hcgc7mT6IzGyxgBFDtPfpnv7ZDIJdqFv4hB0f4ZndfgWx0k2SH4mGIZ
 gU+1Ne5KIXflZ4MNzShWjwRuTj62xokUWxtvasHxDHZcAtzJrhIlcEC3bHMSXdLPOv
 VnBCJ1OdXEYGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/omap: Report HDMI hotplug events to the ASoC HDMI
 codec
To: "Ivaylo Dimitrov" <ivo.g.dimitrov.75@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805152057.1291659-1-ivo.g.dimitrov.75@gmail.com>
References: <20260805152057.1291659-1-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 15:42:30 +0000
Message-Id: <20260805154231.4ED161F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The HPD notification path lacks lifecycle synchronization with the=
 audio driver, resulting in Use-After-Free vulnerabilities during driver un=
bind. During removal, `hdmi4_unbind()` unregisters and frees `hdmi->audio_p=
dev`, but the DRM bridge remains registered until `hdmi4_uninit_output()` i=
s called later in `hdmi4_remove()`. An HPD event firing in this window will=
 unconditionally dereference the freed `audio_pdev` in `hdmi4_bridge_hpd_no=
tify()`. Additionally, while `omap_hdmi_audio_remove()` clears `ha->audio_h=
pd`, it does not synchronize with ongoing executions of `hdmi_audio_hpd()`.=
 Consequently, a concurrent HPD event that passes the NULL check can derefe=
rence `struct hdmi_audio_data *ad` after it has been freed by `devres`, lea=
ding to a kernel crash.
- [High] The newly added ALSA jack and its kcontrols are never exposed to u=
serspace because the jack is created after the sound card has been register=
ed. In `omap_hdmi_audio_probe()`, `snd_soc_card_jack_new()` is incorrectly =
called after `devm_snd_soc_register_card()`. `devm_snd_soc_register_card()`=
 internally calls ALSA's `snd_card_register()`, which iterates and register=
s all attached devices to userspace. ALSA devices created after `snd_card_r=
egister()` require an explicit call to `snd_device_register()` to become vi=
sible. Because ASoC does not do this for late-added jacks, the jack's input=
 device and kcontrols are never created, completely breaking the intended f=
unctionality.
- [Medium] The patch intends to report HDMI hotplug events to the `omap-hdm=
i-audio` ASoC codec, which is shared by both OMAP4 and OMAP5/DRA7 platforms=
. However, the HPD notification callback (`.hpd_notify`) was only implement=
ed for the HDMI4 bridge in `hdmi4.c`. The `hdmi5_bridge_funcs` structure in=
 `hdmi5.c` was completely omitted. Consequently, the hotplug detection feat=
ure will remain entirely non-functional on all OMAP5 and DRA7 hardware.
--

--- Patch [1]: [PATCH] drm/omap: Report HDMI hotplug events to the ASoC HDM=
I codec ---
commit afacde67dc4a81e706a39b2252a2c9a3309fb284
Author: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

drm/omap: Report HDMI hotplug events to the ASoC HDMI codec

This patch adds an optional HPD callback to omap_hdmi_audio_pdata and
invokes it from the DRM HDMI bridge whenever the connector status changes.
The HDMI audio driver registers an ASoC jack to report these state changes,
and the disconnect path is fixed to take a runtime PM reference.

> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdr=
m/dss/hdmi4.c
> index e306247ed8a05..b466bbdae5ccc 100644
> --- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
> @@ -432,9 +432,19 @@ static void hdmi4_bridge_hpd_notify(struct drm_bridg=
e *bridge,
>  				    enum drm_connector_status status)
>  {
>  	struct omap_hdmi *hdmi =3D drm_bridge_to_hdmi(bridge);
> +	struct device *dev =3D &hdmi->audio_pdev->dev;
> +	struct omap_hdmi_audio_pdata *ha =3D dev_get_platdata(dev);

[Severity: High]
Does this introduce a use-after-free risk during driver unbind?

Since hdmi4_unbind() unregisters and frees hdmi->audio_pdev, but the DRM
bridge remains registered until hdmi4_remove() is called later, could an
HPD event firing in this window unconditionally dereference the freed
audio_pdev?

[Severity: Medium]
Since this adds the HPD notification callback for the HDMI4 bridge, should
the hdmi5_bridge_funcs in hdmi5.c also implement the .hpd_notify callback so
that the hotplug detection feature functions on OMAP5 and DRA7 hardware?

> +
> +	if (ha->audio_hpd)
> +		ha->audio_hpd(dev, status =3D=3D connector_status_connected);
> +
> +	if (status =3D=3D connector_status_disconnected) {
> +		if (hdmi_runtime_get(hdmi))
> +			return;
> =20
> -	if (status =3D=3D connector_status_disconnected)
>  		hdmi4_cec_set_phys_addr(&hdmi->core, CEC_PHYS_ADDR_INVALID);
> +		hdmi_runtime_put(hdmi);
> +	}
>  }

[ ... ]

> diff --git a/sound/soc/ti/omap-hdmi.c b/sound/soc/ti/omap-hdmi.c
> index e60f5b483fc57..333aa308979e5 100644
> --- a/sound/soc/ti/omap-hdmi.c
> +++ b/sound/soc/ti/omap-hdmi.c

[ ... ]

> @@ -380,19 +395,37 @@ static int omap_hdmi_audio_probe(struct platform_de=
vice *pdev)
>  		return ret;
>  	}
> =20
> +	atomic_set(&ad->jack_state, -1);
>  	ad->card =3D card;
>  	snd_soc_card_set_drvdata(card, ad);
> =20
>  	dev_set_drvdata(dev, ad);
> =20
> +	ret =3D snd_soc_card_jack_new(
> +		      card, "HDMI", SND_JACK_AVOUT, &ad->jack);
> +	if (ret < 0) {

[Severity: High]
Is the jack actually exposed to userspace when created here?

In omap_hdmi_audio_probe(), devm_snd_soc_register_card() has already been
called earlier in the function. Since the card is already registered,
wouldn't calling snd_soc_card_jack_new() after registration cause the jack
to be excluded from the device registration process, meaning the input
device and kcontrols are never created?

> +		dev_err(dev, "Cannot create HDMI jack: %i\n", ret);
> +		return ret;
> +	}
> +
> +	ha->audio_hpd =3D hdmi_audio_hpd;
> +
>  	return 0;
>  }
> =20
> +static void omap_hdmi_audio_remove(struct platform_device *pdev)
> +{
> +	struct omap_hdmi_audio_pdata *ha =3D pdev->dev.platform_data;
> +
> +	ha->audio_hpd =3D NULL;
> +}

[Severity: High]
Could this lead to a use-after-free if a concurrent HPD event is executing?

While this clears ha->audio_hpd, it doesn't appear to synchronize with
ongoing executions of hdmi_audio_hpd(). Could a concurrent HPD event pass
the NULL check and dereference the ad struct after devres has freed it?

> +
>  static struct platform_driver hdmi_audio_driver =3D {
>  	.driver =3D {
>  		.name =3D DRV_NAME,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805152057.1291=
659-1-ivo.g.dimitrov.75@gmail.com?part=3D1
