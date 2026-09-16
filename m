Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF08EC88E7F
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2908510E479;
	Wed, 16 Sep 2026 10:19:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NCVYrh7Z";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72A6610E479
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 10:19:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AE21E6053B;
 Wed, 16 Sep 2026 10:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCF21F000FF;
 Wed, 16 Sep 2026 10:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789553994;
 bh=0ZaLR97ItQk+FoOeS3PQzjLKD4ONTA6/Cea3gYUypHA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NCVYrh7Zj5l3Uepcsm0IRpgJdR+Fwl3xNneDlxqqY8YZOb5fxcXl+kffYZ0zS9F1P
 jz0pE5tCf3QHZlm6knYXtXerSC/ub3UaFmgBrzSPjmHy/zi6oV1UgrwrqvR6KlIElT
 cjmQZWPJInOgiP/CNRR9kv3riHcA8zMBlu3UnBW3QPCDqJcqFnWS/647ZtQ6doIvOj
 LHz+gJB4rR9yw0z3zMQkZhe7gj/sGFgNrYoQvGEUbBaceqKV07paZwfhtW6ghV0/eu
 CBdRIe0aU0fkDu3a1iA+pyPJvR2bVLepiaZ/G25fcyYLRPFQEUbemK0YkzacLPW4Fu
 WVJp0qXAQXdhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: imx8mp-hdmi-pvi: Fix next_bridge reference
 leak
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260916101146.2015255-1-vulab@iscas.ac.cn>
References: <20260916101146.2015255-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 10:19:53 +0000
Message-Id: <20260916101954.3FCF21F000FF@smtp.kernel.org>
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
- [High] drm/bridge: imx8mp-hdmi-pvi: double-put of next_bridge on unbind
--

commit 86a7e8c2747f218e207c0b6519ab1f7729f32712
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/bridge: imx8mp-hdmi-pvi: Fix next_bridge reference leak

This commit adds a call to drm_bridge_put() in the driver unbind path to
release the reference to the next bridge in the pipeline.

> diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c b/drivers/gpu/d=
rm/bridge/imx/imx8mp-hdmi-pvi.c
> index a31d4fc76f35b..c71319bb68f4b 100644
> --- a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
> @@ -179,6 +179,7 @@ static void imx8mp_hdmi_pvi_remove(struct platform_de=
vice *pdev)
>  	struct imx8mp_hdmi_pvi *pvi =3D platform_get_drvdata(pdev);
> =20
>  	drm_bridge_remove(&pvi->bridge);
> +	drm_bridge_put(pvi->bridge.next_bridge);

[Severity: High]
Does this introduce a double-put of the next_bridge object?

When the device is unbound, devres triggers the cleanup for pvi->bridge
which was allocated with devm_drm_bridge_alloc(). When its refcount drops
to zero, the DRM core calls __drm_bridge_free(), which automatically
releases next_bridge:

drivers/gpu/drm/drm_bridge.c:__drm_bridge_free() {
    ...
    drm_bridge_put(bridge->next_bridge);
    ...
}

By adding a manual drm_bridge_put() here without clearing the pointer,
won't __drm_bridge_free() drop the reference a second time and potentially
cause a use-after-free?

> =20
>  	pm_runtime_disable(&pdev->dev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916101146.2015=
255-1-vulab@iscas.ac.cn?part=3D1
