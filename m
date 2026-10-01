Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54600CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B484810F687;
	Thu,  1 Oct 2026 13:31:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j0UiUcbT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A64310F687
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 13:31:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D2AC260A58;
 Thu,  1 Oct 2026 13:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCEE1F00899;
 Thu,  1 Oct 2026 13:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790861473;
 bh=z3OdInNosQ7hsQOPxWm1oKSIPhIbfXm9IyLmnIYFbqk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=j0UiUcbTQzdt//kGHyIaCpky7DEQjOe8xvjoni8iJMwBBxOn4efE6iEl78LhY6jqe
 Hz6h0gg4Camyt7+bQVzb2eYN401w0GX/b8ruYUeacHr7UNPUhPGAkDiVn4nW/BuLDx
 B/TlrCbEFYDWwc9hD7G/5t8zfif98h3JtCvIyG2iEU+3a9Oo3zy0cz9QeYmN/6Iaja
 1Qz/FEL+EDEP77cuZoo17Bb48X0mDKgC/Dnq+BdsMo3r7qkvAp1Rc+PLil48epOOVL
 QtbCIiBmwA1hzwQ5jKbExwRaqEWDlgsKLrUSLFc3Gd26iWbkWg+rYm8scnUYhmiBZI
 7hcGlI3L+RKMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 24/24] drm/mxsfb/lcdif: enable bridge hotplug
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: imx@lists.linux.dev, dri-devel@lists.freedesktop.org, Frank.Li@kernel.org
In-Reply-To: <20261001-drm-bridge-hotplug-v2-24-8e34986dcb68@bootlin.com>
References: <20261001-drm-bridge-hotplug-v2-0-8e34986dcb68@bootlin.com>
 <20261001-drm-bridge-hotplug-v2-24-8e34986dcb68@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 13:31:12 +0000
Message-Id: <20261001133113.4FCEE1F00899@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm: API violation via double execution of bridge .attach()
- [High] drm: race condition allows concurrent bridge attach execution
- [Medium] drm: spurious warning on teardown of incomplete pipeline
--

commit 58600c33214c844d55e169ec965ac93160d06726
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/mxsfb/lcdif: enable bridge hotplug
   =20
Switch to the new drm_hotplug_helper() to handle bridge hotplugging.

> diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lc=
dif_drv.c
> index e2173c4d6fc28..3d8904a48d9a9 100644
> --- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
[ ... ]
> @@ -94,10 +94,10 @@ static int lcdif_attach_bridge(struct lcdif_drm_priva=
te *lcdif)
>  					     "Failed to attach bridge for endpoint%u\n",
>  					     of_ep.id);
> =20
> -		connector =3D drm_bridge_connector_init(lcdif->drm, encoder);
> -		if (IS_ERR(connector))
> -			return dev_err_probe(dev, PTR_ERR(connector),
> -					     "Failed to init bridge_connector for endpoint%u\n",
> +		hotplug_helper =3D drmm_hotplug_helper_init(lcdif->drm, encoder);

[Severity: Medium]
Will this cause a spurious warning during standard module unload or unbind =
if
the bridge pipeline is incomplete?

When the device is torn down, the drmm cleanup action
drm_hotplug_helper_fini() unconditionally calls
drm_hotplug_helper_connector_remove(). If the bridge pipeline never complet=
ed
(e.g., a downstream bridge was never plugged or probed),
hotplug_helper->connector remains NULL.

In drivers/gpu/drm/display/drm_hotplug_helper.c:
drm_hotplug_helper_connector_remove(), this evaluates to true and triggers a
warning:

	if (drm_WARN_ON(hotplug_helper->drm, !hotplug_helper->connector))
		return;

[Severity: High]
Does using this helper violate the DRM API contract by executing the bridge=
's
.attach() callback twice?

When a hotplug event occurs, the helper retrieves the last bridge currently=
 in
the chain. Since this bridge is already in the chain, its .attach() callback
was already executed by the drm_bridge_attach() call made earlier in
lcdif_attach_bridge().

However, in drivers/gpu/drm/display/drm_hotplug_helper.c:
drm_hotplug_helper_try_complete(), the helper directly invokes attach again:

	err =3D last_bridge->funcs->attach(last_bridge, hotplug_helper->encoder,
					 DRM_BRIDGE_ATTACH_NO_CONNECTOR);

Can this lead to memory leaks, double list additions, or crashes in bridge
drivers that do not expect .attach() to be called multiple times?

[Severity: High]
Is there a race condition when processing concurrent hotplug events in the
helper?

In drivers/gpu/drm/display/drm_hotplug_helper.c:
drm_hotplug_helper_try_complete(), there is a state check without holding t=
he
connector_mutex:

	if (hotplug_helper->connector)
		return;

Since hotplug notifier events can be dispatched concurrently via the blocki=
ng
notifier chain (which uses a read-write semaphore), two simultaneous events
can both see connector =3D=3D NULL.

Both threads will then proceed to concurrently execute
last_bridge->funcs->attach(), causing data races. Furthermore, both threads
may proceed to drm_hotplug_helper_connector_add(), where one will hit the
drm_WARN_ON after acquiring the mutex.

> +		if (IS_ERR(hotplug_helper))
> +			return dev_err_probe(dev, PTR_ERR(hotplug_helper),
> +					     "Failed to init hotplug_helper for endpoint%u\n",
>  					     of_ep.id);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-drm-bridge=
-hotplug-v2-0-8e34986dcb68@bootlin.com?part=3D24
