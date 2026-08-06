Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D1EC55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 01:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5555B10F072;
	Thu,  6 Aug 2026 01:02:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OefSaa/B";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE84E10F072
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 01:02:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D829B43A80;
 Thu,  6 Aug 2026 01:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26351F000E9;
 Thu,  6 Aug 2026 01:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785978129;
 bh=O8PmrIki4SPKUbkpv9PJpkxzFVQBYiV2UpNtJ9djzTs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OefSaa/BgPto1y0JbdxCe/3KbB6yR3ibN8sjipd44GGAVCvU8t91lCJPvukKoC7ul
 ZAGwaQ82BmYDN1Cm2lxFQGYlAWbha95W9dF7OKh/DNjYghsCJd4PS+TbvoLLR8EKhV
 r5hQ+XitPBHTOlZ+wOUASwo/YlJYj2aylD3bU6svXhe45PJuPi49ZJP4ehci8HKyjX
 JvgMlvnByiGrDudhoCXee2X1Pk7gF+vejcLgCqNyqshJ6w065pMCdU1M4ZDKQGslY0
 /yZaih3m2d76TT7zdGKVHV1sBRVMPL/m5p9AaodKzoaye5Y30BNv9BVZG7vNkPlDJ8
 4Vqtml56/k2dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 01/21] drm/bridge: synopsys: dw-dp: Register DP AUX
 on bridge attach
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v10-1-d84a26c303d6@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v10-0-d84a26c303d6@collabora.com>
 <20260806-synopsys-dw-dp-improvements-v10-1-d84a26c303d6@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 01:02:07 +0000
Message-Id: <20260806010208.A26351F000E9@smtp.kernel.org>
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
- [High] Moving `drm_dp_aux_unregister()` to the bridge `detach` callback l=
eaves the AUX character device exposed to userspace after the component is =
unbound, leading to a Use-After-Free and hardware fault.

Pre-existing issues:
- [High] Incorrect use of `devm_` APIs on the component device in `dw_dp_bi=
nd` causes permanent resource leaks and a fatal NULL pointer dereference on=
 unbind.
--

--- Patch [1]: [PATCH v10 01/21] drm/bridge: synopsys: dw-dp: Register DP A=
UX on bridge attach ---
commit 1118ca21508c977536ef793f4a69acdf62b0bbbb
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Register DP AUX on bridge attach

This commit delays the DP AUX device registration until the bridge attach
callback, ensuring the DRM device is ready and the bridge is initialized.
It also moves the unregistration from the component unbind callback to the
bridge detach callback.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 3445c82e6f50e..112a499113095 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
[ ... ]
> @@ -1813,7 +1813,36 @@ static struct drm_bridge_state *dw_dp_bridge_atomi=
c_duplicate_state(struct drm_b
[ ... ]
> +static void dw_dp_bridge_detach(struct drm_bridge *bridge)
> +{
> +	struct dw_dp *dp =3D bridge_to_dp(bridge);
> +
> +	drm_dp_aux_unregister(&dp->aux);
> +}

[Severity: High]
Does moving drm_dp_aux_unregister() to the bridge detach callback leave the=
 AUX
character device exposed to userspace after the component is unbound?

If a userspace process opens the DRM device, holding a reference, and the
dw_dp driver is unbound (e.g., via sysfs), the component unbind callback wi=
ll
now do nothing, leaving the AUX device registered.

The component devres handlers will then execute, freeing dp->regmap and
dp->phy, and releasing the MMIO mappings.

Since dw_dp_bridge_detach() relies on drmm cleanup, its execution is delayed
until the userspace process closes the DRM file descriptor.

If userspace initiates a read or write on the still-registered
/dev/drm_dp_auxN character device during this time, dw_dp_aux_transfer()
could attempt to write to the unmapped and freed dp->regmap, resulting in a
hardware fault or kernel panic.

[ ... ]
> @@ -2065,37 +2084,33 @@ struct dw_dp *dw_dp_bind(struct device *dev, stru=
ct drm_encoder *encoder,
[ ... ]
>  	ret =3D devm_request_threaded_irq(dev, dp->irq, NULL, dw_dp_irq,
>  					IRQF_ONESHOT, dev_name(dev), dp);

[Severity: High]
This is a pre-existing issue, but does using devm_ APIs like
devm_request_threaded_irq() inside dw_dp_bind() tie the resource to the
component device's probe/remove lifecycle rather than the bind/unbind
lifecycle?

When the master DRM driver unbinds, the component .unbind hook is called, b=
ut
devres on the component device does not run because the component driver
itself was not removed.

This leaves the IRQ handler active. When the master DRM device's drmm clean=
up
runs, it triggers drm_bridge_detach(), which explicitly sets dp->bridge.dev
to NULL.

If a hotplug event then triggers the active IRQ, it schedules dw_dp_hpd_wor=
k():

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_hpd_work() {
    ...
    drm_helper_hpd_irq_event(dp->bridge.dev);
    ...
}

Will this dereference the NULL dp->bridge.dev pointer and crash the kernel?

Additionally, if the master DRM driver attempts to rebind, will dw_dp_bind()
fail with -EBUSY when calling devm_request_threaded_irq() because the previ=
ous
allocation leaked?

>  	if (ret) {
>  		dev_err_probe(dev, ret, "failed to request irq\n");
> -		goto unregister_aux;
> +		return ERR_PTR(ret);
>  	}
> =20
>  	return dp;
> -
> -unregister_aux:
> -	drm_dp_aux_unregister(&dp->aux);
> -	return ERR_PTR(ret);
>  }
>  EXPORT_SYMBOL_GPL(dw_dp_bind);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-synopsys-d=
w-dp-improvements-v10-0-d84a26c303d6@collabora.com?part=3D1
