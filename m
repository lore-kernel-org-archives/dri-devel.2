Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0BEC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B628A10E969;
	Tue, 28 Jul 2026 17:07:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FXnhSd4v";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A250710E969
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 17:07:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AB1B960A86;
 Tue, 28 Jul 2026 17:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403A71F000E9;
 Tue, 28 Jul 2026 17:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785258472;
 bh=7xJ3HIDmX8n9xwkRMrUWPJH2BFf0u+LpylU91pz5jq8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FXnhSd4vVLeVr09PLJUrA8KYMinKoQSPylTJl28Q/qt+lVucJfpLTccdcMBeRUPIH
 X/1ZV4BMt9KqanCndxmpv6aurNLCVhEBYGfu2KS+q5fce9MioOZAPg7xOUtKunLKdJ
 7bVEH6Lztwowowev8RGWSudMmkaUvHCuUJDRl1FLWqBa25Z/CZq83KoNKWcO8Wj7Ah
 xzpXvqMuuiTyEbVlY5qprhNeGBgOoAWIpX2iIkEft7zXmLcpc0L7aTlK+iHUuPnSrr
 0H/5+oLFef7fy0Vy9bKZKmfDMVC9j6AFmMfyOOrM3SFkyVUWZreOc9T1qEAmz4pr/4
 WhKwE5rV1CLTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/sti: dvo: Remove bridge on attach failure
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260728165614.25847-1-mhun512@gmail.com>
References: <20260728165614.25847-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:07:51 +0000
Message-Id: <20260728170752.403A71F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `connector` structure is allocated using `devm_kzalloc` in the=
 component `bind` callback (`sti_dvo_bind`), leading to memory leaks on bin=
d deferrals and potential use-after-free.
- [High] The return value of `drm_connector_init()` is ignored, leading to =
potential use of a partially initialized connector.
- [High] Invalid bitwise copy of a `struct device`.
- [High] Lockless list manipulation in `drm_bridge_add()` causes a data rac=
e and list corruption when a bridge is re-added.
--

--- Patch [1]: [PATCH] drm/sti: dvo: Remove bridge on attach failure ---
commit 1cb37c38eb373898a3e03a40bbc7b0f30ebe733d
Author: Myeonghun Pak <mhun512@gmail.com>

drm/sti: dvo: Remove bridge on attach failure

This patch removes the bridge before returning the attach error to ensure=20
the globally registered bridge does not leak or remain held when component=
=20
binding fails.

> diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
> --- a/drivers/gpu/drm/sti/sti_dvo.c
> +++ b/drivers/gpu/drm/sti/sti_dvo.c

[Severity: High]
This is a pre-existing issue, but looking earlier in sti_dvo_bind():

	connector =3D devm_kzalloc(dev, sizeof(*connector), GFP_KERNEL);

Does using devm_kzalloc() here lead to a memory leak on bind deferrals?

Because devm allocations are tied to the device probe lifecycle rather=20
than the component bind/unbind lifecycle, each bind retry might leak=20
this connector allocation.

Additionally, since DRM reference-counts connectors, freeing this memory=20
automatically upon device unbind rather than during the DRM connector's=20
destruction could lead to a use-after-free if userspace still holds a=20
reference.

> @@ -465,8 +465,10 @@ static int sti_dvo_bind(struct device *dev, struct d=
evice *master, void *data)
>  	drm_bridge_add(&dvo->bridge);

[Severity: High]
This is a pre-existing issue, but could this call to drm_bridge_add()=20
trigger a data race when a bridge is re-added?

Looking at drm_bridge_add() in drivers/gpu/drm/drm_bridge.c:

	if (!list_empty(&bridge->list))
		list_del_init(&bridge->list);

This list_del_init() is called locklessly. If the bridge is currently on=20
the bridge_lingering_list, concurrent calls to drm_bridge_remove() might=20
be manipulating that list while holding bridge_lock.

Could this lockless deletion corrupt the list pointers of adjacent entries=
=20
in the global lingering list?

> =20
>  	err =3D drm_bridge_attach(encoder, &dvo->bridge, NULL, 0);
> -	if (err)
> +	if (err) {
> +		drm_bridge_remove(&dvo->bridge);
>  		return err;
> +	}
> =20
>  	connector->encoder =3D encoder;
>  	dvo->encoder =3D encoder;

[Severity: High]
This is a pre-existing issue, but looking just below this hunk in=20
sti_dvo_bind():

	drm_connector_init(drm_dev, drm_connector,
			   &sti_dvo_connector_funcs, DRM_MODE_CONNECTOR_LVDS);
	drm_connector_helper_add(drm_connector,
				 &sti_dvo_connector_helper_funcs);

Is it safe to ignore the return value of drm_connector_init() here?

If drm_connector_init() fails due to a memory allocation failure or mode=20
object ID registration failure, it returns a negative error code.

By ignoring it, we pass a partially initialized connector to=20
drm_connector_helper_add() and drm_connector_attach_encoder(), which=20
expect initialized internal lists and object IDs.

[Severity: High]
This is also a pre-existing issue, but looking at sti_dvo_probe() in the=20
same file:

	dvo->dev =3D pdev->dev;

Does this perform an invalid bitwise copy of a struct device?

A struct device contains internal state elements such as kobject reference=
=20
counts, mutexes, and list heads.

Copying these by value can lead to corruption if any subsystem attempts to=
=20
lock the copied mutexes or traverse the copied list heads.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728165614.2584=
7-1-mhun512@gmail.com?part=3D1
