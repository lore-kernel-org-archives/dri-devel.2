Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7628CC5AC7C
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9812410F277;
	Thu,  6 Aug 2026 17:36:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TJjJTpuY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B67AB10F277
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:36:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 73C71415AB;
 Thu,  6 Aug 2026 17:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0807C1F000E9;
 Thu,  6 Aug 2026 17:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786037772;
 bh=0RKZVfuZa99jY3AirSYoCBLlGcBW84Q07fUWGbKux70=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TJjJTpuY8vKMUL1H/kQ+/L/EBslis/rE/4fU7PfoE+6wb1dvMWAKm+6c9ouIyMJn0
 01WayQBYC08rq9uyGrslJhkMl30a9xgd38o2bVX/Njn3wIwIPfbYCDvsLERZi3Pvh+
 X7+mzQuF+aBqnyOgc+myw7b/B8uort5negzzyvv5dkst9eApYmnMXm2BjLGdVa4SHk
 +fE1Leu1und623TDdeqk3xNLtxgq6BqSwMdeaxc8t51U3CZHdqLiUKlZHtutfnn/kv
 H/PAer/cmFWmLfsUSDH7MK4N3pFyVHNjHfGWEt1gnW3OYFc9Ou+ELVjdNPZIoQO2JI
 FAJYETd49199g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 02/21] drm/bridge: synopsys: dw-dp: Fix incorrect
 resource lifetimes in bind callback
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v11-2-0d508505f383@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
 <20260806-synopsys-dw-dp-improvements-v11-2-0d508505f383@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 17:36:11 +0000
Message-Id: <20260806173612.0807C1F000E9@smtp.kernel.org>
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
- [High] Use-After-Free and -EBUSY on re-bind due to missing drm_bridge_det=
ach in component unbind.
--

--- Patch [2]: [PATCH v11 02/21] drm/bridge: synopsys: dw-dp: Fix incorrect=
 resource lifetimes in bind callback ---
commit 8317a23524c759645b1aec330e9a401578a81a81
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Fix incorrect resource lifetimes in bind callb=
ack

This commit moves the bridge allocation and resource requests from the bind
callback to the probe callback using a new dw_dp_probe() helper. It also
disables the IRQ in the detach callback to prevent spurious interrupts.

Reported-by: Sashiko <sashiko-bot@kernel.org>

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 60feb3d1e14bb..d7945f7fe9f05 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c

[ ... ]

> @@ -1982,6 +1988,18 @@ static const struct regmap_config dw_dp_regmap_con=
fig =3D {
>  	.rd_table =3D &dw_dp_readable_table,
>  };
> =20
> +int dw_dp_bind(struct dw_dp *dp, struct drm_encoder *encoder)
> +{
> +	return drm_bridge_attach(encoder, &dp->bridge, NULL, DRM_BRIDGE_ATTACH_=
NO_CONNECTOR);
> +}
> +EXPORT_SYMBOL_GPL(dw_dp_bind);
> +
> +void dw_dp_unbind(struct dw_dp *dp)
> +{
> +	/* nothing to do as bridge is detached automatically */
> +}
> +EXPORT_SYMBOL_GPL(dw_dp_unbind);

[Severity: High]
Since the bridge allocation was moved to probe using devm, the bridge
structure now outlives the component bind/unbind cycle. If the bridge is
not explicitly detached here, does this cause issues during re-bind?

Specifically, if we unbind and re-bind the component, won't
drm_bridge_attach() in dw_dp_bind() return -EBUSY because the bridge is
still attached to the old encoder?

Additionally, can this cause a use-after-free on driver removal? If the
platform driver is removed while a DRM file descriptor is kept open, devm
will free the dp structure. When the file descriptor is eventually closed,
DRM core will call dw_dp_bridge_detach():

static void dw_dp_bridge_detach(struct drm_bridge *bridge)
{
	struct dw_dp *dp =3D bridge_to_dp(bridge);

	disable_irq(dp->irq);
	cancel_work_sync(&dp->hpd_work);
	...
}

Since dp was already freed by devm, will accessing dp->irq and dp->hpd_work
here crash? Should this unbind function explicitly call drm_bridge_detach()
to prevent both the re-bind failure and the use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-synopsys-d=
w-dp-improvements-v11-0-0d508505f383@collabora.com?part=3D2
