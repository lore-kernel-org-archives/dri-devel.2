Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E12C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:30:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3298D10F346;
	Fri, 31 Jul 2026 16:30:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TeFkwCrK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C821B10F346
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:30:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 621D043A0E;
 Fri, 31 Jul 2026 16:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FA81F00ACA;
 Fri, 31 Jul 2026 16:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785515408;
 bh=wc3Lv+IkzPJ5w9srUtZfHSRdaMtbBfmRfgTfV0kDU6k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TeFkwCrKcZk31zFULrqjUQ4hAURsxzrmqpeIRo6e7Oo5VSrEi7jFGS+na7TAzTD/u
 0I/toMyvlJhcjWYQIrUr9E0Mn2bh9xS5moGDEAE5qY81suzlfdkshkhZfBOAEw/Fdz
 oimdaWYoOzlFyguSmJGabLEGogYC7jLHRgP7D4fsJhx9AC3CtoZJyrldoGi9JuR/tB
 cmNt5Vo+seSA4g5/l5Ga+bm6f/lAKA9Uw3LaVGmdYSHjToRABKFbq9OmCA6pm66BVb
 aG5V/zRvY9UZrzVzUun4PFIH3Fsxyu8XoNk5wseBGpNGlJcTW6weFY5iTTA2WmGbJk
 2+IEUt1P4TlhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/21] drm/bridge: synopsys: dw-dp: Free output_fmts
 when none are valid
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260731-synopsys-dw-dp-improvements-v8-8-ac1e6a75782f@collabora.com>
References: <20260731-synopsys-dw-dp-improvements-v8-0-ac1e6a75782f@collabora.com>
 <20260731-synopsys-dw-dp-improvements-v8-8-ac1e6a75782f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 16:30:07 +0000
Message-Id: <20260731163007.E9FA81F00ACA@smtp.kernel.org>
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

Pre-existing issues:
- [High] Unbalanced phy_power_off() and regulator_disable() if phy_power_on=
() fails in dw_dp_link_enable().
- [High] NULL pointer dereference in dw_dp_hpd_work() and dw_dp_link_retrai=
n() due to missing bridge.dev check.
--

--- Patch [8]: [PATCH v8 08/21] drm/bridge: synopsys: dw-dp: Free output_fm=
ts when none are valid ---
commit 749c8cb81f0227b8f3795cdf2bcba3b9e0038179
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Free output_fmts when none are valid

If dw_dp_bandwidth_ok() returns false for all formats, *num_output_fmts
might end up becoming 0. This commit frees output_fmts within the function
in that case to avoid leaking memory.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 760e1e0f8234b..7127928c26506 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1804,6 +1804,11 @@ static u32 *dw_dp_bridge_atomic_get_output_bus_fmt=
s(struct drm_bridge *bridge,
>  		output_fmts[j++] =3D fmt->bus_format;
>  	}
> =20
> +	if (j =3D=3D 0) {
> +		kfree(output_fmts);
> +		output_fmts =3D NULL;
> +	}
> +
>  	*num_output_fmts =3D j;
> =20
>  	return output_fmts;

[Severity: High]
This isn't a bug introduced by this patch, but could there be an unbalanced
phy_power_off() if phy_power_on() fails during dw_dp_link_enable()?

In dw_dp_link_enable(), if phy_power_on() fails:

    ret =3D phy_power_on(dp->phy);
    if (ret)
        return ret;

It returns without incrementing the PHY's power_count. However, if the DRM
core continues tracking the bridge as enabled, it will eventually call
dw_dp_link_disable() when the bridge is disabled.

dw_dp_link_disable() does:

    phy_power_off(dp->phy);

Because the power_count was not incremented earlier, does this cause
phy_power_off() to decrement it to -1 and unconditionally call
regulator_disable(), potentially dropping power for other shared devices?

[Severity: High]
This is also a pre-existing issue, but can dw_dp_hpd_work() or
dw_dp_link_retrain() trigger a NULL pointer dereference if the bridge is
detached?

If the DRM encoder is unbound, drm_bridge_detach() explicitly sets
bridge->dev =3D NULL. If a physical hotplug event occurs before the bridge
device itself is unbound, the IRQ can fire and schedule dw_dp_hpd_work().

In dw_dp_hpd_work():

    drm_helper_hpd_irq_event(dp->bridge.dev);

And in dw_dp_link_retrain():

    struct drm_device *dev =3D dp->bridge.dev;
    ...
    ret =3D drm_modeset_lock(&dev->mode_config.connection_mutex, &ctx);

Since neither function checks if dp->bridge.dev is NULL, could a hotplug
event after encoder unbind cause a kernel panic here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-synopsys-d=
w-dp-improvements-v8-0-ac1e6a75782f@collabora.com?part=3D8
