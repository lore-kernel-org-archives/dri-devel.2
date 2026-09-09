Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB839C88E40
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:50:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE5CD10F226;
	Wed,  9 Sep 2026 17:50:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aKmNcGny";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D28B810E583;
 Wed,  9 Sep 2026 17:50:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DC5DC601F0;
 Wed,  9 Sep 2026 17:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519561F000FF;
 Wed,  9 Sep 2026 17:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788976220;
 bh=dwpneMCvnbYYVq8+VTo22jfsNgLSMdIBEqaCLsqpXhM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aKmNcGnyn+jPzb7x9poBEGhncOVXVQQC4UhYSrPHD46XQD/n9jmgC4X8R7Q70c5qe
 8XHEYOBu83BTixO6LyTHua5hZoK3fVNWzPxjKzcNTPV3OHa67sClz30ZFYiS2zkRoT
 ubZTCRtIy0U0LAvL10mGiH6lepwoPtFHXM7uVUvJgZfJkSxqgDsoZuUr2fisW5vTcA
 uw+vpSJjuynf5F6aryGpb9bnEBkicxJvkSTh1RjH1Fh3ZSfdhVdq10XWGYCaqeY/Ld
 sosfPe+fCxpUS1IAgPeaF+pt3YufDX3874OgMI9u/jGxzENMQne+956PdqheGAsubY
 Me8XA0m+VpRYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] drm/rockchip: dw_dp: Attach "max bpc" connector
 property
To: "Igor Paunovic" <royalnet026@gmail.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260909173542.14030-4-royalnet026@gmail.com>
References: <20260909163206.36409-1-royalnet026@gmail.com>
 <20260909173542.14030-4-royalnet026@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 17:50:19 +0000
Message-Id: <20260909175020.519561F000FF@smtp.kernel.org>
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
- [Medium] Unconditional connector state allocation causes a memory leak if=
 an HDMI bridge is present in the chain.

Pre-existing issues:
- [High] `devm_` allocations tied to the component device in `dw_dp_bind` c=
ause resource leaks and permanent driver failure if `bind` fails.
--

commit 47f0f730df97f46871d26a1858e6f2594ea7c383
Author: Igor Paunovic <royalnet026@gmail.com>

drm/rockchip: dw_dp: Attach "max bpc" connector property

This commit attaches the "max bpc" property to the dw-dp bridge connector
with a range of 6 to 10. It also explicitly creates the connector state
before drm_mode_config_reset() runs, allowing the property to be attached
successfully during driver initialization.

> diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/=
rockchip/dw_dp-rockchip.c
> index b23efb153c9e6..8ff27353b1417 100644
> --- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
[ ... ]
> @@ -112,6 +112,32 @@ static int dw_dp_rockchip_bind(struct device *dev, s=
truct device *master, void *
>  				     "Failed to init bridge connector\n");
>  	}
> =20
> +	/*
> +	 * The components are bound before drm_mode_config_reset() runs, so
> +	 * the connector has no state yet, but
> +	 * drm_connector_attach_max_bpc_property() requires one. Create the
> +	 * connector state first, like drmm_connector_hdmi_init() does.
> +	 */
> +	if (connector->funcs->atomic_create_state) {
> +		struct drm_connector_state *state;
> +
> +		state =3D connector->funcs->atomic_create_state(connector);
> +		if (IS_ERR(state)) {
> +			dw_dp_unbind(dp->base);
> +			return PTR_ERR(state);
> +		}
> +
> +		connector->state =3D state;

[Severity: Medium]
Does this unconditionally overwrite connector->state?

If the display pipeline contains an HDMI bridge (e.g., a DP-to-HDMI chip),
drm_bridge_connector_init() internally calls drmm_connector_hdmi_init(),
which allocates and assigns connector->state. Overwriting it here seems to
leak the previously allocated drm_connector_state.

> +	} else if (connector->funcs->reset) {
> +		connector->funcs->reset(connector);
> +	}
> +
> +	ret =3D drm_connector_attach_max_bpc_property(connector, 6, 10);
> +	if (ret) {
> +		dw_dp_unbind(dp->base);
> +		return ret;

[Severity: High]
This isn't a regression introduced by this patch, but if this newly added
error path is taken, does it permanently break the driver on deferred probe?

The component bind callback invokes dw_dp_bind() earlier in this function,
which performs devm_ allocations tied to the component device (dev) rather
than the master device. For example:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_bind() {
    ...
    ret =3D devm_request_threaded_irq(dev, dp->irq, NULL, dw_dp_irq,
                                    IRQF_ONESHOT, dev_name(dev), dp);
    ...
}

Because the component device remains probed even if the bind callback fails,
these devm_ resources are not freed when this error path returns. On a
subsequent bind retry, dw_dp_bind() executes again. Since
devm_request_threaded_irq() does not use IRQF_SHARED, it will return
-EBUSY, permanently failing.

> +	}
> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909163206.3640=
9-1-royalnet026@gmail.com?part=3D3
