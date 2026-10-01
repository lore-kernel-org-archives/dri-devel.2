Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89F9CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:27:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2025E10E142;
	Thu,  1 Oct 2026 13:27:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Pa9BcazJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3335110E142
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 13:27:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 668B96021D;
 Thu,  1 Oct 2026 13:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E711F000FF;
 Thu,  1 Oct 2026 13:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790861251;
 bh=g9il4cbwoU1fhJmz9TvaRAyVPdF5h2lFWl/R+mRFJAw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Pa9BcazJTWJmftG6IFaA7HKuis0U8BnQh5oMqhQuUtWhgbUaYuXoQzjHd8mNWjvQG
 fHPbI75p4FWHavlxJgiX53BxqFMB0AUil5G9JS0jOezhDwOlTnv/7bKBzxj91BQSPW
 PcTM1vqobcDUh4UNdbDMItKpNccquURf5+jZCs6WTK//TgUF+3zviL+CmSsJFNWDrA
 zzBJav3OGO/nXDQjz1UMucN2DfkRUdk9AhHjOOHqg3YM2kner5wrN95W7C0bR5R1HP
 LvpLzO53USxi5TdtUvIShRoIPmGPUphY5+loSEEK1V09DrVEE3iAYWXZmEl6L5SKib
 HiLoW4cF3lqkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 22/24] drm/bridge: samsung-dsim: implement
 .get_next_bridge
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20261001-drm-bridge-hotplug-v2-22-8e34986dcb68@bootlin.com>
References: <20261001-drm-bridge-hotplug-v2-0-8e34986dcb68@bootlin.com>
 <20261001-drm-bridge-hotplug-v2-22-8e34986dcb68@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 13:27:30 +0000
Message-Id: <20261001132730.D9E711F000FF@smtp.kernel.org>
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
- [High] drm/bridge: UAF in samsung_dsim_get_next_bridge() due to missing r=
efcount increment
--

commit ff84bc6df44d9112a31ddd636aeba9815e9fc90e
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/bridge: samsung-dsim: implement .get_next_bridge

This commit adds a get_next_callback function to expose the next bridge in =
the
samsung-dsim driver.

> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index b2de447dc6f43..de64d036b89bf 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1821,6 +1821,13 @@ static void samsung_dsim_mode_set(struct drm_bridg=
e *bridge,
>  	drm_mode_copy(&dsi->mode, adjusted_mode);
>  }
> =20
> +static struct drm_bridge *samsung_dsim_get_next_bridge(struct drm_bridge=
 *bridge)
> +{
> +	struct samsung_dsim *dsi =3D bridge_to_dsi(bridge);
> +
> +	return dsi->bridge.next_bridge ?: ERR_PTR(-ENODEV);

[Severity: High]
Does samsung_dsim_get_next_bridge() in drivers/gpu/drm/bridge/samsung-dsim.c
need to increment the reference count of the returned bridge?

The DRM core API drm_bridge_funcs.get_next_bridge mandates that the returned
bridge pointer must have its reference count incremented (for example via
drm_bridge_get()), as the caller is expected to call drm_bridge_put() when
done.

By returning dsi->bridge.next_bridge directly without taking a new referenc=
e,
when callers (such as drm_hotplug_helper_pipeline_is_complete() introduced
later in this series) use drm_bridge_get_next() and automatically drop the
reference using __free(drm_bridge_put), they will drop the reference
originally owned by the samsung_dsim struct.

Later, when the driver tears down and tries to release its own reference via
drm_bridge_clear_and_put(), could this trigger a double-put or
use-after-free condition?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-drm-bridge=
-hotplug-v2-0-8e34986dcb68@bootlin.com?part=3D22
