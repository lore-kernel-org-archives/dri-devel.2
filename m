Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA4DC55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:54:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A69D10E4A4;
	Mon,  3 Aug 2026 08:54:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OuXBgtYV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42D3510E4A4
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 08:54:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EE2E2413B1;
 Mon,  3 Aug 2026 08:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14601F000E9;
 Mon,  3 Aug 2026 08:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785747255;
 bh=E2Yzyg71a3kbLpSCSBNFDwznmsleX59CeYDXF7RJ1gQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OuXBgtYV58Va9dN/s7LUMWs4g4jY18uLMIR1fER5ksN5ufol/CXzhHEdaI5szTZyc
 kYvQg7gxqxXCdnvK1VqFNYP82nkGdONlUJ1Y8zvanXZmy7REyoxur0kfrq9U/cvaFx
 UMU+LDIzSdDMEoVUVownGEb/C0G/bUdAv6JxB2UL6FhgHiRyw0Zill8nJu+EmRv8gd
 lcA2PQDcM8qsoYKB1GYbnIUTHoxO+dTs9W7gERrhN5+kM1IEoud4wKDexPsZyedNWK
 JZJYOfCyzIRVZ4kATyDwiGLrIYg7PejLxTNoCxmKmRET7C8S7YM9XINkNZfqw6Lq33
 uLVapAOz1bNIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: aux-hpd-bridge: replay last HPD status on
 hpd_enable
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260803-drm-usbdp-preboot-v1-1-2539b362be00@oss.qualcomm.com>
References: <20260803-drm-usbdp-preboot-v1-1-2539b362be00@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 08:54:15 +0000
Message-Id: <20260803085415.B14601F000E9@smtp.kernel.org>
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
- [High] Missing cancellation of `hpd_work` on device unbind leads to acces=
s of a destroyed mutex and use-after-free.
- [High] Lockless read of `last_status` in `hpd_work` creates a TOCTOU race=
 condition that can deliver stale HPD events out of order.
--

--- Patch [1]: [PATCH] drm/bridge: aux-hpd-bridge: replay last HPD status o=
n hpd_enable ---
commit ac67055ec791a818497d8d0b82453f5ad00a28d3
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/bridge: aux-hpd-bridge: replay last HPD status on hpd_enable

This commit caches the last HPD status reported by an upstream driver
and replays it when a downstream consumer enables HPD handling on the
bridge. The replay is deferred to a work item to run outside the
.hpd_enable() call context.

> diff --git a/drivers/gpu/drm/bridge/aux-hpd-bridge.c b/drivers/gpu/drm/br=
idge/aux-hpd-bridge.c
> index a2e525aa57887..bb81aabf58d49 100644
> --- a/drivers/gpu/drm/bridge/aux-hpd-bridge.c
> +++ b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
[ ... ]
> @@ -154,6 +166,8 @@ void drm_aux_hpd_bridge_notify(struct device *dev, en=
um drm_connector_status sta
>  	if (!data)
>  		return;
> =20
> +	WRITE_ONCE(data->last_status, status);
> +
>  	drm_bridge_hpd_notify(&data->bridge, status);

[Severity: High]
Could this create a race condition with drm_aux_hpd_bridge_hpd_work() where
stale HPD events are delivered out of order?

If drm_aux_hpd_bridge_hpd_work() reads the status locklessly but gets
preempted before calling drm_bridge_hpd_notify(), a concurrent hardware
event here could update the status and dispatch it synchronously.=20

When drm_aux_hpd_bridge_hpd_work() resumes, it might then dispatch the olde=
r,=20
stale status it cached earlier, leaving the consumer with an outdated=20
connection state.

>  }
>  EXPORT_SYMBOL_GPL(drm_aux_hpd_bridge_notify);
> @@ -165,11 +179,45 @@ static int drm_aux_hpd_bridge_attach(struct drm_bri=
dge *bridge,
>  	return flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR ? 0 : -EINVAL;
>  }
> =20
> +static void drm_aux_hpd_bridge_hpd_work(struct work_struct *work)
> +{
> +	struct drm_aux_hpd_bridge_data *data =3D
> +		container_of(work, struct drm_aux_hpd_bridge_data, hpd_work);
> +	enum drm_connector_status status =3D READ_ONCE(data->last_status);
> +
> +	if (status =3D=3D connector_status_unknown)
> +		return;
> +
> +	drm_bridge_hpd_notify(&data->bridge, status);

[Severity: High]
Can this work item execute after the device is unbound?

If the auxiliary device unbinds while this work item is pending, devres
teardown will call drm_bridge_remove_void(), which in turn destroys
bridge->hpd_mutex and can free the data structure.=20

If this work item executes after that teardown, wouldn't it result in a=20
use-after-free on data and an attempt to lock a destroyed mutex inside
drm_bridge_hpd_notify()?

[ ... ]
> @@ -192,6 +240,9 @@ static int drm_aux_hpd_bridge_probe(struct auxiliary_=
device *auxdev,
>  	data->bridge.interlace_allowed =3D true;
>  	data->bridge.ycbcr_420_allowed =3D true;
> =20
> +	data->last_status =3D connector_status_unknown;
> +	INIT_WORK(&data->hpd_work, drm_aux_hpd_bridge_hpd_work);
> +

[Severity: High]
Since INIT_WORK() is used here, should there be a corresponding devm cleanup
action to ensure the work is cancelled on unbind?

Adding something like devm_add_action_or_reset() to call cancel_work_sync()=
=20
would ensure the work item doesn't outlive the data structure it operates o=
n.

>  	auxiliary_set_drvdata(auxdev, data);
> =20
>  	return devm_drm_bridge_add(data->dev, &data->bridge);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-drm-usbdp-=
preboot-v1-1-2539b362be00@oss.qualcomm.com?part=3D1
