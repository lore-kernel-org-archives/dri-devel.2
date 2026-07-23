Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659BDC4453D
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC5A110EF65;
	Thu, 23 Jul 2026 01:59:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WEs5LycH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3552E10EF68
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 01:59:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AE163600AB;
 Thu, 23 Jul 2026 01:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E221F000E9;
 Thu, 23 Jul 2026 01:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784771970;
 bh=g5JQWaiDZWU+J5zCFmQcTN/S2bBTnOtmhlYsfeNUZ0I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WEs5LycHwUGwy2m2g3x5TtfjBVN/7xNjiMIMEgrvRU6+SHTwiPJzkQz5HQ7aGljWf
 z+lB6HP4lOMpIFeKkXMml7bNZYKlQJzWyWu236dL5o+HjsroIItgJqOWDzXDTIP/2m
 qJ1DkBAQhAdodKQZJ8Iw8Lcl3npX6Gfg9CjRrwMQY3sBtEVGusbDMdaTrc/I+JfZ1b
 YUqG2/JQprp+go0fVYemLnjoIfz6kJZifppeV0EPI1JcvZmBwtF8gruAr3aA9phb5G
 8770ikOM1T/0EFwO2MK64wKIlSrpEM8+W1AMBZA6Q67w0m04G0IASmVJqSfh1oYO92
 jf5dhbnWEZRsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 36/61] drm/vc4: hdmi: Propagate -EDEADLK to the top
 level
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-36-4fb12ea22ac9@collabora.com>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
 <20260723-dw-hdmi-qp-scramb-v9-36-4fb12ea22ac9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 01:59:29 +0000
Message-Id: <20260723015930.31E221F000E9@smtp.kernel.org>
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
- [High] The return value of `drm_atomic_helper_connector_hdmi_hotplug()` i=
s ignored, swallowing `-EDEADLK` errors and causing lock API violations.
--

--- Patch [36]: [PATCH v9 36/61] drm/vc4: hdmi: Propagate -EDEADLK to the t=
op level ---
commit 386da5b87a0ad478948abb5cc75141b0bedce489
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: drm/vc4: hdmi: Propagate -EDEADLK to the top level

drm_connector_helper_funcs.detect_ctx() is expected to propagate
-EDEADLK so that context owners, e.g. drm_helper_probe_detect_ctx(), can
perform the required backoff and retry.

> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdm=
i.c
> index 4f7fc6689869e..75a251530970e 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -344,12 +344,11 @@ static int vc4_hdmi_reset_link(struct drm_connector=
 *connector,
>  	return drm_atomic_helper_reset_crtc(crtc, ctx);
>  }
> =20
> -static void vc4_hdmi_handle_hotplug(struct vc4_hdmi *vc4_hdmi,
> -				    struct drm_modeset_acquire_ctx *ctx,
> -				    enum drm_connector_status status)
> +static int vc4_hdmi_handle_hotplug(struct vc4_hdmi *vc4_hdmi,
> +				   struct drm_modeset_acquire_ctx *ctx,
> +				   enum drm_connector_status status)
>  {
>  	struct drm_connector *connector =3D &vc4_hdmi->connector;
> -	int ret;
> =20
>  	/*
>  	 * NOTE: This function should really be called with vc4_hdmi->mutex
> @@ -368,17 +367,9 @@ static void vc4_hdmi_handle_hotplug(struct vc4_hdmi =
*vc4_hdmi,
>  	drm_atomic_helper_connector_hdmi_hotplug(connector, ctx, status);
> =20
>  	if (status !=3D connector_status_connected)
> -		return;
> -
> -	for (;;) {
> -		ret =3D vc4_hdmi_reset_link(connector, ctx);
> -		if (ret =3D=3D -EDEADLK) {
> -			drm_modeset_backoff(ctx);
> -			continue;
> -		}
> +		return 0;

[Severity: High]
Should the return value of drm_atomic_helper_connector_hdmi_hotplug() be
captured and propagated to the caller?

If drm_atomic_helper_connector_hdmi_hotplug() fails to acquire locks, for
example inside drm_connector_hdmi_sync_scdc(), it can return -EDEADLK. By
ignoring this return value, the standard DRM locking retry semantics are
bypassed.

When a deadlock occurs, ctx->contended is set. If we proceed to use this
context in vc4_hdmi_reset_link(), or eventually drop the locks via
drm_modeset_drop_locks(), it triggers a WARN_ON(ctx->contended) stack
trace in drm_modeset_lock.c.

Additionally, if the connector was disconnected, returning 0 tricks the
caller into believing the operation succeeded. This skips essential
teardown steps like CEC physical address invalidation, Audio InfoFrame
clearing, and SCDC sync retry.

> =20
> -		break;
> -	}
> +	return vc4_hdmi_reset_link(connector, ctx);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-dw-hdmi-qp=
-scramb-v9-0-4fb12ea22ac9@collabora.com?part=3D36
