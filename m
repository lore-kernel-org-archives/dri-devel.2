Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83627C55174
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 01:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B944110E251;
	Thu,  6 Aug 2026 01:05:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iRSaEoMj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D92D10E251
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 01:05:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3638E60A80;
 Thu,  6 Aug 2026 01:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4A31F00A3A;
 Thu,  6 Aug 2026 01:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785978317;
 bh=pkLPM2z9lKUFGlaabAZhXerDaNQMmNmY1+CNdN9IBiQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iRSaEoMjXV647rw9j7CvJaDDnvtrNTJvlLiToYDjSzmCT+NVk30dwHY9SlCjsn4aE
 v8iM+uluRkJ0BWoIy8DKCCJ7YVSpH2i6Av4zn60FxRDtXhsbIPfuxNxJoxh6FQL+Q1
 t5K9sjrjmfC0qLEFBRxyGOT1MvoBB3jVDJTmFvztwOq4Yc8I2zMMWM6RjgN+tVuK4w
 GcENgB72XJMNWa2GbvPi8CcKjRyx8x94LikMoEH3sTdwKjnvoEJADAxT3PlOHvza9p
 RUoif5Bz4J93jnpFI9oWTJqevufSVWicO+hpjjZ2UcBWxfV/J9HConCp1z4NM1yCtC
 5huR2N8uAoKMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 02/21] drm/bridge: synopsys: dw-dp: Fix incorrect
 resource lifetimes in bind callback
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v10-2-d84a26c303d6@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v10-0-d84a26c303d6@collabora.com>
 <20260806-synopsys-dw-dp-improvements-v10-2-d84a26c303d6@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 01:05:17 +0000
Message-Id: <20260806010517.9D4A31F00A3A@smtp.kernel.org>
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
- [High] Race condition leading to uninitialized mutex usage in bridge atta=
ch path.

Pre-existing issues:
- [High] Use-After-Free of bridge resources on component removal while DRM =
device is open.
--

--- Patch [2]: [PATCH v10 02/21] drm/bridge: synopsys: dw-dp: Fix incorrect=
 resource lifetimes in bind callback ---
commit add1fb610af93986b5b39118795cddc285343d20
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Fix incorrect resource lifetimes in bind callb=
ack

Currently the driver requests resources in the bind function which are
freed on driver removal instead of unbind. This introduces a probe helper
to fix the discrepancy and keeps interrupts disabled while detached to
prevent spurious worker wakeups.

Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support =
library")
Reported-by: Sashiko <sashiko-bot@kernel.org>

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 112a499113095..f8ca464d43717 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1826,10 +1826,19 @@ static int dw_dp_bridge_attach(struct drm_bridge =
*bridge,
>  	dp->aux.name =3D dev_name(dev);
>  	dp->aux.transfer =3D dw_dp_aux_transfer;
> =20
> +	enable_irq(dp->irq);
> +
>  	ret =3D drm_dp_aux_register(&dp->aux);

[Severity: High]
Can this race with the interrupt handler?

If the display is already plugged in and the interrupt line is asserted,
dw_dp_irq() might fire immediately after enable_irq() is called. This
schedules the dp->hpd_work worker.

The worker function dw_dp_hpd_work() can then execute before
drm_dp_aux_register() completes. It calls dw_dp_link_retrain(), which in
turn calls drm_dp_dpcd_read_link_status(). That function acquires the
aux->hw_mutex lock.

Since hw_mutex is exclusively initialized inside drm_dp_aux_init(), which
is called by drm_dp_aux_register(), could the worker attempt to lock an
uninitialized mutex here?

> -	if (ret)
> +	if (ret) {
>  		dev_err(dev, "Aux register failed: %d\n", ret);
> +		goto err_disable_irq;
> +	}
> +
> +	return 0;
> =20
> +err_disable_irq:
> +	disable_irq(dp->irq);
> +	cancel_work_sync(&dp->hpd_work);
>  	return ret;
>  }
> =20
> @@ -1838,6 +1847,8 @@ static void dw_dp_bridge_detach(struct drm_bridge *=
bridge)
>  	struct dw_dp *dp =3D bridge_to_dp(bridge);
> =20
>  	drm_dp_aux_unregister(&dp->aux);
> +	disable_irq(dp->irq);
> +	cancel_work_sync(&dp->hpd_work);
>  }

[Severity: High]
This is a pre-existing issue, but does this lead to a use-after-free
on component removal?

The dw_dp structure is allocated using devm_drm_bridge_alloc in
dw_dp_probe(), tying its lifetime to the component platform device.
If the component is unbound, its devm resources are immediately freed
when the remove function finishes.

However, if a userspace application holds the DRM device file
descriptor open, the overarching DRM device is not torn down
immediately. When userspace eventually closes the file descriptor,
drm_encoder_cleanup() traverses the bridge chain and calls
dw_dp_bridge_detach().

Does this cause dw_dp_bridge_detach() to access the already freed dp
pointer when it tries to unregister the aux channel, disable the irq,
and cancel the work?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-synopsys-d=
w-dp-improvements-v10-0-d84a26c303d6@collabora.com?part=3D2
