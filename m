Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578CCC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:39:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B95FD10EA73;
	Wed, 19 Aug 2026 15:39:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gYIidkpS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8239310EA73
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 15:39:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8E7B060A92;
 Wed, 19 Aug 2026 15:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316DA1F000E9;
 Wed, 19 Aug 2026 15:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787153966;
 bh=ZU3odl9gaxDErqTpWiHEBmlWHYt6xnD51qjKKmaFF68=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gYIidkpSKLtIdW2BzZzgbemft8pYCnlH90Cx2qMwm6bEIApQEFfztzzo/cH5u9ZGy
 luqr/DDvZAYNFuUTmoNcf45RDs8SIELMBZmraAHw2xLJhx3zBlzqUMLD57Rkmc+rB0
 C44fGBtQpOCHe/ALuOyPsQWc1MzP+DHVOCfeyDyU5Y8a9Ab0KyN2ajp1jNuIGr3JhN
 LiUbyYDNgob39BmR/nbgDYAWR4pWeJPalXib95oaiyNlmBrZtyvkflTTgSWSByBfMG
 DebXV8CRpNiAPEzquz1GUyjUqueNTzqSi9tcNnwNXVhRZ6v7tdDi69NTiExs3Jf98r
 QFmletiqsCUsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/omap: Report HDMI hotplug events to the ASoC
 HDMI codec
To: "Ivaylo Dimitrov" <ivo.g.dimitrov.75@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260819152755.231754-1-ivo.g.dimitrov.75@gmail.com>
References: <20260819152755.231754-1-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 15:39:25 +0000
Message-Id: <20260819153926.316DA1F000E9@smtp.kernel.org>
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
- [High] Use-After-Free during HDMI hotplug events due to vulnerable sysfs =
unbind path.
- [High] Function signature mismatch in `hdmi5_bridge_hpd_notify` causes a =
CFI kernel panic and breaks state reporting.
- [Medium] Missing initial jack state synchronization causes HDMI audio to =
remain disconnected at boot.
--

--- Patch [1]: [PATCH v2] drm/omap: Report HDMI hotplug events to the ASoC =
HDMI codec ---
commit 79155722ff98d49bdbf6c4e880ed9ec3b85d6fd0
Author: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

drm/omap: Report HDMI hotplug events to the ASoC HDMI codec

The OMAP HDMI audio driver currently has no way of reporting HDMI cable
hotplug events to ASoC. As a result, user space cannot detect HDMI audio
availability through the standard jack mechanism and audio policy managers
cannot automatically route audio to or from the HDMI output.

> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5.c b/drivers/gpu/drm/omapdr=
m/dss/hdmi5.c
> index ab2d4eb6787f2..76aedc1c9ba1f 100644
> --- a/drivers/gpu/drm/omapdrm/dss/hdmi5.c
> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
> @@ -425,6 +425,14 @@ static void hdmi5_bridge_disable(struct drm_bridge *=
bridge,
>  	mutex_unlock(&hdmi->lock);
>  }
> =20
> +static void hdmi5_bridge_hpd_notify(struct drm_bridge *bridge,
> +				    enum drm_connector_status status)
> +{

[Severity: High]
Will this cause a Control-Flow Integrity (CFI) kernel panic?

The DRM core expects the hpd_notify callback to have three arguments:
void (*hpd_notify)(struct drm_bridge *bridge, struct drm_connector *connect=
or,
                   enum drm_connector_status status)

hdmi5_bridge_hpd_notify() is defined with only two arguments. With CFI
enabled, calling this with a mismatched signature triggers a panic. Even
without CFI, the calling convention causes the callee to read the
connector pointer as the status enum.

> +	struct omap_hdmi *hdmi =3D drm_bridge_to_hdmi(bridge);
> +
> +	hdmi_audio_hpd_notify(hdmi, status);
> +}
> +

[ ... ]

> diff --git a/sound/soc/ti/omap-hdmi.c b/sound/soc/ti/omap-hdmi.c
> index e60f5b483fc57..90ce12a812468 100644
> --- a/sound/soc/ti/omap-hdmi.c
> +++ b/sound/soc/ti/omap-hdmi.c
> @@ -262,6 +265,34 @@ static void hdmi_dai_shutdown(struct snd_pcm_substre=
am *substream,

[ ... ]

> +static int hdmi_audio_dai_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_card *card =3D rtd->card;
> +	struct hdmi_audio_data *ad =3D snd_soc_card_get_drvdata(rtd->card);
> +	int ret;
> +
> +	ret =3D snd_soc_card_jack_new(
> +		      card, "HDMI", SND_JACK_AVOUT, &ad->jack);

[Severity: Medium]
Is there a way to query the initial connection state of the jack here?

If the system boots with the HDMI cable already connected, the ASoC jack
is initialized to a disconnected state (0) here. Because the DRM hardware
interrupt only fires on state edges, hdmi_audio_hpd_notify() is never
called at boot, leaving the jack reporting as disconnected until the user
unplugs and replugs the cable.

> +	if (ret < 0) {
> +		dev_err(card->dev, "Cannot create HDMI jack: %i\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}

[ ... ]

> @@ -371,28 +402,44 @@ static int omap_hdmi_audio_probe(struct platform_de=
vice *pdev)

[ ... ]

> +static void omap_hdmi_audio_remove(struct platform_device *pdev)
> +{
> +	struct omap_hdmi_audio_pdata *ha =3D pdev->dev.platform_data;
> +
> +	/*
> +	 * hdmi4_unbind() holds audio lock across platform_device_unregister(),
> +	 * so audio_hpd() cannot run concurrently with this callback.
> +	 */
> +	ha->audio_hpd =3D NULL;
> +}
> +
>  static struct platform_driver hdmi_audio_driver =3D {
>  	.driver =3D {
>  		.name =3D DRV_NAME,
>  	},
>  	.probe =3D omap_hdmi_audio_probe,
> +	.remove =3D omap_hdmi_audio_remove,

[Severity: High]
Could a user space sysfs unbind trigger a use-after-free here?

If a user unbinds the omap-hdmi-audio driver via sysfs,
omap_hdmi_audio_remove() locklessly clears ha->audio_hpd.

Concurrently, if a physical hotplug event occurs:

CPU1
hdmi_audio_hpd_notify()
    if (ha->audio_hpd)
        ...gets preempted here...

CPU2
omap_hdmi_audio_remove()
    ha->audio_hpd =3D NULL;
    ...driver unbinds and frees 'ad' via devres...

CPU1
    ...resumes...
    ha->audio_hpd(dev, ...) -> calls hdmi_audio_hpd()
    dereferences freed 'ad'.

Should this driver struct set .suppress_bind_attrs =3D true to prevent
uncoordinated sysfs lifecycle events?

>  };
> =20
>  module_platform_driver(hdmi_audio_driver);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819152755.2317=
54-1-ivo.g.dimitrov.75@gmail.com?part=3D1
