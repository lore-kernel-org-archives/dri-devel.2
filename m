Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2F4C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:29:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48A4C10E00F;
	Wed, 16 Sep 2026 10:29:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AdnAkBgw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F0CE10E00F
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 10:29:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 524DB42B38;
 Wed, 16 Sep 2026 10:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151761F000FF;
 Wed, 16 Sep 2026 10:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789554542;
 bh=NRmX5LwGXE/WOkvNLcK6K7ifhQeO+g/3S3/FQP7Fgzg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AdnAkBgwAJaO//Wnnwd5aD21n2yhYAb5KsOCbBtHxwnohajo1DJtjfEkVujeJOztE
 AG8qhoNtdanprFnp42FTdsCRdQHtpU9ilIH9M5ZmVrVaF3FKKlHT8VI/WoW3WpWXUY
 tQnDKaXUfZI5fzfzwg0pl5eYHwu0ETFeACNWE4K5S8JmhX+QXsfxia3olgsG+yuOVm
 Cj3ntfW6VHbmhSxVgavp/ECsRjZz5LiHov+M3ms5rwQuSAAFnjkBQKpAmEjUrm1CZT
 qlBVKa43MMykyDTPPlYzem/GOr4m5ucY1HhT3U1I6PnB/a8jzIcs12Rsvkeo8KFyPP
 hJ438Ymei2Wgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: microchip-lvds: Fix runtime PM leak in
 mchp_lvds_enable()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260916101922.2018259-1-vulab@iscas.ac.cn>
References: <20260916101922.2018259-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 10:29:01 +0000
Message-Id: <20260916102902.151761F000FF@smtp.kernel.org>
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
- [Medium] drm/bridge: runtime PM usage counter underflow on atomic_enable =
error
--

commit f6da183dff281321349d56635d572cdbbecf6393
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/bridge: microchip-lvds: Fix runtime PM leak in mchp_lvds_enable()

This patch attempts to fix a runtime PM usage counter leak in
mchp_lvds_atomic_enable() by dropping the reference when
pm_runtime_get_sync() fails.

> diff --git a/drivers/gpu/drm/bridge/microchip-lvds.c b/drivers/gpu/drm/br=
idge/microchip-lvds.c
> index dd4ffc9f4df3f..f30ebeea4a4da 100644
> --- a/drivers/gpu/drm/bridge/microchip-lvds.c
> +++ b/drivers/gpu/drm/bridge/microchip-lvds.c
> @@ -144,6 +144,7 @@ static void mchp_lvds_atomic_enable(struct drm_bridge=
 *bridge,
>  	ret =3D pm_runtime_get_sync(lvds->dev);
>  	if (ret < 0) {
>  		dev_err(lvds->dev, "failed to get pm runtime: %d\n", ret);
> +		pm_runtime_put_noidle(lvds->dev);

[Severity: Medium]
Will this lead to a runtime PM usage counter underflow when the bridge is
disabled?

The DRM bridge API's atomic_enable callback returns void, so the DRM core
cannot be notified of a failure. If pm_runtime_get_sync() fails, the DRM co=
re
still considers the bridge enabled and will unconditionally call
mchp_lvds_atomic_disable() during the next modeset or pipeline teardown.

Since this patch locally drops the PM reference here on the error path, the
unconditional pm_runtime_put() in mchp_lvds_atomic_disable() will decrement
the usage count a second time, causing an underflow. Before this patch, the
reference left by the failing get_sync() balanced the unconditional put in
the disable path.

>  		return;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916101922.2018=
259-1-vulab@iscas.ac.cn?part=3D1
