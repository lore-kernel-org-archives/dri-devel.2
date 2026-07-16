Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09892C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7828110F311;
	Thu, 16 Jul 2026 13:34:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h2NKIvKq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31B4710F311
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:34:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8CFC4600B0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187131F000E9;
 Thu, 16 Jul 2026 13:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784208860;
 bh=bfg9mxN+i5HBxRcEDCi9iX+bJ7ixadfalHcSQ39oLgA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h2NKIvKq9UDJ47G3WcK8EjimpOyqS/IyMRnVXiP6fzZzGozthiMGws+6K0er0SsPQ
 +lblAq7Op6qONKr+Y17eenSLwe7+GsvNn17zYi7U1RBY9ioKdCHEqJ4BvVFowRApsN
 UsD8oQolnZhzINMyBzpQ65fEYtA/GuD/KWMcRMRre4CiHrx6esO26VaomMrphoo1Ua
 WH/xLpTsgWcEvj8w7zbxbPfp54RoSbpNSO+UGj8DSIHND3P8QQ0JhKD8r1M7YSS1k3
 a1eQwEA8G9+/S00rpUZgp5XUvyA6feqa3TzKr0+L0K0DTfof1gOnn+KqcSynPO06Tr
 PW/6brDQRJ9rA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panel-edp: take i2c adapter module reference
To: "Johan Hovold" <johan@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716132245.1565121-1-johan@kernel.org>
References: <20260716132245.1565121-1-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 13:34:19 +0000
Message-Id: <20260716133420.187131F000E9@smtp.kernel.org>
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
- [Medium] When the devicetree's `ddc-i2c-bus` property explicitly points t=
o the DP AUX I2C adapter, the module and device references acquired by `of_=
get_i2c_adapter_by_node()` are leaked during error cleanup and driver remov=
al.
--

--- Patch [1]: [PATCH] drm/panel-edp: take i2c adapter module reference ---
commit 2c5917c76c861a6fb28736134884b2a3575fb31a
Author: Johan Hovold <johan@kernel.org>

drm/panel-edp: take i2c adapter module reference

The i2c subsystem currently blocks during adapter deregistration
whenever there are consumers holding a reference.

Switch to using of_get_i2c_adapter_by_node() which also takes a
reference to the adapter module so that an attempt to unload the module
while in use fails gracefully instead of blocking uninterruptibly.

> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index f66474d3ef65e..a65bfe50be817 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -874,7 +874,7 @@ static int panel_edp_probe(struct device *dev, const =
struct panel_desc *desc,
> =20
>  	ddc =3D of_parse_phandle(dev->of_node, "ddc-i2c-bus", 0);
>  	if (ddc) {
> -		panel->ddc =3D of_find_i2c_adapter_by_node(ddc);
> +		panel->ddc =3D of_get_i2c_adapter_by_node(ddc);
>  		of_node_put(ddc);

[ ... ]

> @@ -939,7 +939,7 @@ static int panel_edp_probe(struct device *dev, const =
struct panel_desc *desc,
>  	pm_runtime_disable(dev);
>  err_finished_ddc_init:
>  	if (panel->ddc && (!panel->aux || panel->ddc !=3D &panel->aux->ddc))
> -		put_device(&panel->ddc->dev);
> +		i2c_put_adapter(panel->ddc);

[Severity: Medium]
If the devicetree's "ddc-i2c-bus" property explicitly points to the DP AUX =
I2C
adapter node, panel->ddc will equal &panel->aux->ddc.

While the check panel->ddc !=3D &panel->aux->ddc was already present, switc=
hing
to of_get_i2c_adapter_by_node() means a module reference is now acquired he=
re
if the node is parsed from the devicetree.

Does skipping i2c_put_adapter() in this case cause a module reference leak =
when
an error occurs during probe?

> =20
>  	return err;
>  }
> @@ -984,7 +984,7 @@ static void panel_edp_remove(struct device *dev)
>  	pm_runtime_dont_use_autosuspend(dev);
>  	pm_runtime_disable(dev);
>  	if (panel->ddc && (!panel->aux || panel->ddc !=3D &panel->aux->ddc))
> -		put_device(&panel->ddc->dev);
> +		i2c_put_adapter(panel->ddc);

[Severity: Medium]
Similarly, does this skip i2c_put_adapter() and leak the module reference
during driver removal if the devicetree explicitly pointed to the AUX DDC
adapter?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716132245.1565=
121-1-johan@kernel.org?part=3D1
