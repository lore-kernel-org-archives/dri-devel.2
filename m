Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DFDC5DF97
	for <dri-devel@archiver.kernel.org>; Sat, 22 Aug 2026 14:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02D9510E0D0;
	Sat, 22 Aug 2026 14:44:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YnKmAZvy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50EC010E0D0
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 14:44:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 082A5405E3;
 Sat, 22 Aug 2026 14:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09171F000E9;
 Sat, 22 Aug 2026 14:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787409844;
 bh=6ktBv4adFKM4OpFlyFStkyjyEaLb/0YcLTRSPS7aXwo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YnKmAZvybZS5Un3sI3Nr2Vy0JH8OvO7qWhIbdvvue1VHz9kavYn9TCWN0DwAVRx83
 RqU/xsnsfm9kd4xMZiFg8nsbYFnbZlVcsd9lmBYmGyeGYBC1CV2QlFlhTDFYzpFRzp
 62cuZA/163xa+o4VO8Vh0CwZmUVpxOmjLxr5YUeiMJOMnTqmKddw/7FK3Gz7lEXu4w
 WwFspEHl0ZObLfpDjHUbCUVo/eXF1IwU5TWiENgjMcRjjBUm8b0VdMg8gU56tLxZ16
 eOpQpjN69H5Q3wf0O8FScU+XAK7UZd3U3pIAsEFf5fiRDKPGUPB/p9DQ3m8fpJyDkZ
 gEpQaagQXpkoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vc4: hdmi: Unregister the ASoC card on unbind
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260822143218.68764-1-kmehltretter@gmail.com>
References: <20260822143218.68764-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 14:44:04 +0000
Message-Id: <20260822144404.C09171F000E9@smtp.kernel.org>
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
- [High] Incomplete Fix / Use-After-Free / Resource Leak: The patch fixes a=
 Use-After-Free for the ASoC card by replacing `devm_snd_soc_register_card`=
 with a non-devres registration managed in `.unbind`. However, it leaves nu=
merous other `devm_` allocations in `vc4_hdmi_bind()`, `vc4_hdmi_audio_init=
()`, `vc4_hdmi_hotplug_init()`, and `vc4_hdmi_cec_register()` tied to the c=
omponent's platform device (`dev`) while passing pointers to the `drmm_kzal=
loc`-allocated `vc4_hdmi` structure. When the DRM aggregate device is unbou=
nd (e.g., via `rmmod vc4`), the master device's release runs and frees `vc4=
_hdmi`. The platform device, whose lifecycle is separate, retains the `devm=
_` actions (like `vc4_hdmi_put_ddc` and IRQ handlers) in its devres queue. =
When the platform device is eventually removed, or if an active interrupt f=
ires after the DRM device unbinds, these actions access the freed `vc4_hdmi=
` pointer, causing a Use-After-Free. Additionally, unbinding and rebinding =
the component will stack duplicate devres actions on the platform device, c=
ausing memory leaks.
--

--- Patch [1]: [PATCH] drm/vc4: hdmi: Unregister the ASoC card on unbind ---
commit 197ce798da149a07ddab65100d64653586ed2892
Author: Karl Mehltretter <kmehltretter@gmail.com>

drm/vc4: hdmi: Unregister the ASoC card on unbind

The patch fixes a use-after-free issue by switching the ASoC card
registration from devm to manual registration and unregistering it during
the component unbind callback.

> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdm=
i.c
> index 17c8635c5afae..ce28075f77b68 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -2349,28 +2349,11 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *v=
c4_hdmi)

[ ... ]

> +	 * The card is unregistered from the component unbind callback:
> +	 * a DRM-managed action can run after the device-managed ASoC
> +	 * resources are gone, and the device-managed release runs after
> +	 * the DRM-managed vc4_hdmi structure holding the card has been
> +	 * freed. Only at unbind time are both still alive.
>  	 */
>  	ret =3D devm_snd_dmaengine_pcm_register(dev, &pcm_conf, 0);

[Severity: High]
This isn't a bug introduced by this patch, but while this commit fixes the =
UAF
for the ASoC card, does leaving devm_snd_dmaengine_pcm_register() and
devm_snd_soc_register_component() tied to the platform device (dev) leave
them vulnerable to a similar issue?

When the DRM master device is unbound, the drmm-managed vc4_hdmi structure
is freed. However, the HDMI platform device has a separate lifecycle, so th=
ese
devm_ resources won't be released until the platform device is removed.=20

If the component is unbound and rebound, wouldn't these devm_ registrations
stack and leak memory?

[ ... ]

> @@ -3345,8 +3329,20 @@ static int vc4_hdmi_bind(struct device *dev, struc=
t device *master, void *data)
>  	return ret;
>  }
> =20
> +static void vc4_hdmi_unbind(struct device *dev, struct device *master,
> +			    void *data)
> +{
> +	struct vc4_hdmi *vc4_hdmi =3D dev_get_drvdata(dev);
> +
> +	if (vc4_hdmi->audio.card_registered) {
> +		snd_soc_unregister_card(&vc4_hdmi->audio.card);
> +		vc4_hdmi->audio.card_registered =3D false;
> +	}
> +}

[Severity: High]
This is a pre-existing issue, but since the vc4_hdmi structure is passed
to several devm_ actions in the bind path (such as vc4_hdmi_put_ddc, and
IRQ handlers for HPD and CEC), wouldn't those callbacks dereference the
freed vc4_hdmi pointer if the platform device is removed after the DRM
master device has already been torn down?

For example, vc4_hdmi_hotplug_init() registers the HPD irq handler using
devm_request_threaded_irq() against the platform device. If an interrupt
fires after the DRM device is unbound, won't it try to access the freed
vc4_hdmi pointer?

Should these other resources also be manually cleaned up in the .unbind
callback, or transitioned to drmm_ management?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822143218.6876=
4-1-kmehltretter@gmail.com?part=3D1
