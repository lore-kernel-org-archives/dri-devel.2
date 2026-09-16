Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBC3C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:15:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FFC610E389;
	Wed, 16 Sep 2026 10:15:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SJ2mLvKV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D1F710E389
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 10:15:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C4681602CC;
 Wed, 16 Sep 2026 10:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEE61F000FF;
 Wed, 16 Sep 2026 10:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789553731;
 bh=a3DgXHpbddr3DHrf8xtm22XiLsjyPgyxkQsuGOgAu1o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SJ2mLvKVf5cfOBY75XgVMTfl0X42H8YAzOJGuUuPpmB30JUgx6Fj+vDBhtxdsJmFD
 NGZNQSAK4pETcEyE192ypsu28AFZWrDWzeksQCggIc6Q7ufZ4uoG22Hz1zj/OPU2DH
 dLVDP29ixsZcZfmURvwjMXDFGt2i3DwhMQt1Fv/PdAsDvs4Ptc8SpBhdxZBDtPuJVf
 tHr1CraM/c0vOnDyxIExrllO9Gj2MidRFTBDVfASkl3MBSlU6eUtX158bHFkw7aH+e
 XX1Osq/RuVV0/oCFqUSrS21J7Q5rnhdzbmHMCY4sYFkarRyISpiFkIvbrFUuLgG7qK
 DRaZBIQPQzAfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: display-connector: Fix DDC adapter leak in
 display_connector_probe()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260916100547.2012828-1-vulab@iscas.ac.cn>
References: <20260916100547.2012828-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 10:15:30 +0000
Message-Id: <20260916101531.5CEE61F000FF@smtp.kernel.org>
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
- [High] drm/bridge: display-connector: double-put of I2C adapter on probe =
failure
--

commit 6664228340b6b3ba7c429f5b94a033d13e1f4e21
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/bridge: display-connector: Fix DDC adapter leak in display_connector_pr=
obe()

This commit explicitly drops the DDC adapter reference on error paths in
display_connector_probe() to prevent a resource leak when probe fails after
obtaining the adapter.

> diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm=
/bridge/display-connector.c
> index eb3412ec30a07..e7e9c40dbdd97 100644
> --- a/drivers/gpu/drm/bridge/display-connector.c
> +++ b/drivers/gpu/drm/bridge/display-connector.c
> @@ -394,18 +394,22 @@ static int display_connector_probe(struct platform_=
device *pdev)
> =20
>  		if (IS_ERR(conn->ddc_en)) {
>  			dev_err(&pdev->dev, "Couldn't get ddc-en gpio\n");
> +			i2c_put_adapter(conn->bridge.ddc);

[Severity: High]
Could this result in a double-put of the I2C adapter when returning an erro=
r?

Since the display_connector structure is allocated earlier using
devm_drm_bridge_alloc(), returning an error will trigger the devres cleanup
action. This cleanup calls drm_bridge_put(), which invokes the bridge's
destroy callback, display_connector_destroy().

Looking at display_connector_destroy(), it already releases the adapter:

static void display_connector_destroy(struct drm_bridge *bridge)
{
        struct display_connector *conn =3D bridge_to_display_connector(brid=
ge);
        ...
        i2c_put_adapter(conn->bridge.ddc);
        ...
}

If we explicitly call i2c_put_adapter() here without also setting
conn->bridge.ddc to NULL, will the devres cleanup path put the adapter a
second time and cause a refcount underflow?

>  			return PTR_ERR(conn->ddc_en);
>  		}
> =20
>  		ret =3D display_connector_get_supply(pdev, conn, "hdmi-pwr");
> -		if (ret < 0)
> +		if (ret < 0) {
> +			i2c_put_adapter(conn->bridge.ddc);

[Severity: High]
Does this also suffer from the same devres double-put regression during
cleanup?

>  			return dev_err_probe(&pdev->dev, ret, "failed to get HDMI +5V Power r=
egulator\n");
> +		}
>  	}
> =20
>  	if (conn->supply) {
>  		ret =3D regulator_enable(conn->supply);
>  		if (ret) {
>  			dev_err(&pdev->dev, "failed to enable PWR regulator: %d\n", ret);
> +			i2c_put_adapter(conn->bridge.ddc);

[Severity: High]
Does this path similarly trigger a double-put via
display_connector_destroy() when returning the error?

>  			return ret;
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916100547.2012=
828-1-vulab@iscas.ac.cn?part=3D1
