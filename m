Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD3FCA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 11:21:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5BBE10EE4A;
	Tue, 29 Sep 2026 11:21:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Filmn7Gu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6F8D10EE4A
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 11:21:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4C7844322D;
 Tue, 29 Sep 2026 11:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAA51F000FF;
 Tue, 29 Sep 2026 11:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790680871;
 bh=GA38cMiGogZVDgMjBn996Oc6nmpWsGsKPZoPwJ2yu78=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Filmn7GufNPUoWEs25MRRYybA6DbhQ0EBHuvWXpMGi8ZxB7cKimp7zqlzHxnM4t8S
 8fcJlErSV4pAJZR+McC2Pd4d8ZyHl5VhfSTZDxuSzYP4vAgXNHWe7/02WhFQ45tdD8
 GU9ev/qpcFpi7jLTh1Nd2Zp6x+M3bjrTAK2g7lsv3x7DyHIgNJmA/qxgxeHDm72ZO1
 G8tgIE4mcmvZibmoMobQGI05CQRKV+0PJOMMHq6uXWxtJa5l4kF/ZjtMJxgBT9Bw0C
 j5PGBD+wzLhgjgXuJ0p1kcu/Fugqu8aqAqdWwha0HN1vh1uTmMzV15oQP3648q3xqD
 l28F7AYAfazGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] drm/vc4: dsi: stop using deprecated
 drmm_of_get_bridge()
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, Frank.Li@kernel.org,
 wsa+renesas@sang-engineering.com, imx@lists.linux.dev
In-Reply-To: <20260929-drm-fix-of_get_bridge-build-regression-v1-6-ccb7e602daad@bootlin.com>
References: <20260929-drm-fix-of_get_bridge-build-regression-v1-0-ccb7e602daad@bootlin.com>
 <20260929-drm-fix-of_get_bridge-build-regression-v1-6-ccb7e602daad@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 11:21:09 +0000
Message-Id: <20260929112109.BAAA51F000FF@smtp.kernel.org>
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
- [High] drm/vc4: dsi: bridge reference leak on bind failure/retry
--

commit d1b5b987d3dbb5f94782b8b596d7895539b38c8d
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/vc4: dsi: stop using deprecated drmm_of_get_bridge()

This commit replaces the deprecated devm_drm_of_get_bridge() with
of_drm_get_bridge_by_endpoint(), storing the refcounted bridge in
dsi->bridge.next_bridge. It also removes an unused include.

> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
> index 0148f2befed14..30598738cfcf3 100644
> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c
[ ... ]
> @@ -1749,9 +1747,9 @@ static int vc4_dsi_bind(struct device *dev, struct =
device *master, void *data)
>  		return ret;
>  	}
> =20
> -	dsi->out_bridge =3D drmm_of_get_bridge(drm, dev->of_node, 0, 0);
> -	if (IS_ERR(dsi->out_bridge))
> -		return PTR_ERR(dsi->out_bridge);
> +	dsi->bridge.next_bridge =3D of_drm_get_bridge_by_endpoint(dev->of_node,=
 0, 0);
> +	if (IS_ERR(dsi->bridge.next_bridge))
> +		return PTR_ERR(dsi->bridge.next_bridge);

[Severity: High]
Does this leak the bridge reference if a subsequent initialization step fai=
ls?

If a later call in vc4_dsi_bind() fails or returns -EPROBE_DEFER, the funct=
ion
exits without putting the newly acquired bridge reference. For example, fur=
ther
down in vc4_dsi_bind():

	ret =3D drm_bridge_attach(encoder, &dsi->bridge, NULL, 0);
	if (ret)
		return ret;

Because the component framework tears down the drm_device and its actions
on failure, the drmm cleanup runs vc4_dsi_release_action() which drops the
dsi->bridge refcount. However, because the refcount does not reach 0,
__drm_bridge_free() is not called and the next_bridge pointer is never put
or cleared.

When the bind is retried, of_drm_get_bridge_by_endpoint() is called again,
overwriting dsi->bridge.next_bridge and permanently leaking the previous
reference.

Is there a missing drm_bridge_put() or cleanup path to ensure the reference
is dropped when vc4_dsi_bind() fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-drm-fix-of=
_get_bridge-build-regression-v1-0-ccb7e602daad@bootlin.com?part=3D6
