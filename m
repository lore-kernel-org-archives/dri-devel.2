Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD5DC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 19:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0D0B10F475;
	Thu,  2 Jul 2026 19:36:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HXGmZ37O";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAE2410F475
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 19:36:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7932F418FE;
 Thu,  2 Jul 2026 19:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF7F1F00A3D;
 Thu,  2 Jul 2026 19:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783021001;
 bh=S5oR3q2BmRyMe3se6lMf7aJAhhF9mM9KTicm2awvQ8k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HXGmZ37OxDFXm2QuLB/tUTd70RIN0xzsHHrawP07D3dokoIivi9e6JdU2rJcFa5mh
 /rdC20nFRkjOSzjzLQOvM7M1gk/RgBQYOz+JCDX2lxaUH/YRXqFAqgJVEe40pB0SHC
 eH+BOqh29AXUplgzj+QUAqKsqY1ozxP34hwtlok5hoR+SqbpzcJxlpbzjYw5TCO+k6
 b/4EjVq6s1K2hbCNThNYUHC3MdIJGaQX7VJI0rjuLJJIBeMaS/0/l+woTRUMhuLDku
 UiI0UfpDPU2/w55d8gZW9JaoTG3qQDcm/IEHsiMRGAssWkxJTaiHgxAWfB6Xn6gAOP
 7devuGw6AEC1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND] drm/connector: check if destroy function exist
To: "Andreas Kemnade" <andreas@kemnade.info>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702191453.611070-1-andreas@kemnade.info>
References: <20260702191453.611070-1-andreas@kemnade.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 19:36:40 +0000
Message-Id: <20260702193641.2FF7F1F00A3D@smtp.kernel.org>
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
- [High] Manual invocation of `funcs->destroy()` causes a NULL pointer dere=
ference on the error path in `msm_hdmi_modeset_init`.
--

commit aa404d4746f85dae926593fae989fac53f064b44
Author: Andreas Kemnade <andreas@kemnade.info>

drm/connector: check if destroy function exist

Connectors might have not resources needed to be manually freed.
E.g. the drm_bridge_connector does not have such a callback.

> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 8b4baed060f3a..288d9d6c75a8d 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -198,7 +198,9 @@ static void drm_connector_free(struct kref *kref)
>  	struct drm_device *dev =3D connector->dev;
> =20
>  	drm_mode_object_unregister(dev, &connector->base);
> -	connector->funcs->destroy(connector);
> +
> +	if (connector->funcs->destroy)
> +		connector->funcs->destroy(connector);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but could the same NULL pointer
dereference happen in the error path of msm_hdmi_modeset_init() when it
manually cleans up the connector?

If devm_request_irq() fails after the drm_bridge_connector is successfully
initialized, it seems the failure path blindly calls the destroy callback:

drivers/gpu/drm/msm/hdmi/hdmi.c:msm_hdmi_modeset_init() {
	...
	hdmi->connector =3D drm_bridge_connector_init(hdmi->dev, encoder);
	if (IS_ERR(hdmi->connector)) {
		...
	}

	ret =3D devm_request_irq(dev->dev, hdmi->irq, ...);
	if (ret < 0) {
		DRM_DEV_ERROR(dev->dev, "failed to request IRQ%u: %d\n",
				hdmi->irq, ret);
		goto fail;
	}

	return 0;

fail:
	if (hdmi->connector) {
		hdmi->connector->funcs->destroy(hdmi->connector);
		hdmi->connector =3D NULL;
	}

	return ret;
}

Should this driver-specific cleanup path also be updated to check if
funcs->destroy is present, similar to the fix applied here in
drm_connector_free?

> =20
>  void drm_connector_free_work_fn(struct work_struct *work)
[ ... ]
> @@ -216,7 +218,9 @@ void drm_connector_free_work_fn(struct work_struct *w=
ork)
> =20
>  	llist_for_each_entry_safe(connector, n, freed, free_node) {
>  		drm_mode_object_unregister(dev, &connector->base);
> -		connector->funcs->destroy(connector);
> +
> +		if (connector->funcs->destroy)
> +			connector->funcs->destroy(connector);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702191453.6110=
70-1-andreas@kemnade.info?part=3D1
