Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04087C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:49:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F1C610E368;
	Thu, 16 Jul 2026 13:49:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c/YvJoXK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8728210E368
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:49:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CE24413EA
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E221F00A3E;
 Thu, 16 Jul 2026 13:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784209741;
 bh=DTHFOnJGztrCeqEZ/uWgzJyLw7x9GUGANZa4hLOcjx8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c/YvJoXK0Mdg7FsoZcg+ftxpllFUqQgq98IcnxXLaaKeYOz7EWvytxviCoKMtWKu/
 E/8oD7CkNarESSJaRd2DvjUPW6UgkUTyPsUH9JgOLzhBzj8Qz2dnKmvi6J82urchRf
 A3WR972oGNfbJde7vxJsbfa0fyOLPlqeFWgBrSlHOk2x5OxhOL3QMZPVcRHb+ImKHb
 pmSoW4W/dKFO+ktUaQ1sjVGpfvUBIg9PFXK9W1KYd2O0PuK504WEodZ5Rc1WXt/bjT
 CWNueL8D97gzvix0sb+JL5+9Uf3zZuD3DW61VHB73FdudFArNEHGNa5GUF4bwCuDwL
 2cijx6kh/np5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panel-simple: take i2c adapter module reference
To: "Johan Hovold" <johan@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716132334.1565183-1-johan@kernel.org>
References: <20260716132334.1565183-1-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 13:49:00 +0000
Message-Id: <20260716134901.05E221F00A3E@smtp.kernel.org>
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
- [Low] Calling `i2c_put_adapter()` breaks the build when `CONFIG_I2C` is n=
ot enabled.
--

--- Patch [1]: [PATCH] drm/panel-simple: take i2c adapter module reference =
---
commit 78f8d3d7539288c8e1940d04e2aff6503a3592b4
Author: Johan Hovold <johan@kernel.org>

drm/panel-simple: take i2c adapter module reference

This patch changes the panel-simple driver to use of_get_i2c_adapter_by_nod=
e()
instead of of_find_i2c_adapter_by_node(). This ensures the i2c adapter modu=
le
reference is taken, preventing uninterruptible blocking during deregistrati=
on.
The teardown paths are updated to use i2c_put_adapter() instead of put_devi=
ce().

> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel=
/panel-simple.c
> index 5c169fdf265c1..79bd6bbec7bde 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c

[ ... ]

> @@ -746,7 +746,7 @@ static struct panel_simple *panel_simple_probe(struct=
 device *dev)
>  	pm_runtime_disable(dev);
>  free_ddc:
>  	if (panel->ddc)
> -		put_device(&panel->ddc->dev);
> +		i2c_put_adapter(panel->ddc);

[Severity: Low]
Does this cause a build failure when CONFIG_I2C is disabled?

Looking at include/linux/i2c.h, it appears the declaration for i2c_put_adap=
ter()
is guarded by IS_ENABLED(CONFIG_I2C), but there is no corresponding empty s=
tub
provided in the fallback block for when I2C is disabled.

Since this driver can be built without CONFIG_I2C, calling i2c_put_adapter()
unconditionally here in panel_simple_probe() might result in an undefined
reference during linking or an implicit declaration error.

> =20
>  	return ERR_PTR(err);
>  }

[ ... ]

> @@ -791,7 +791,7 @@ static void panel_simple_remove(struct device *dev)
>  	pm_runtime_dont_use_autosuspend(dev);
>  	pm_runtime_disable(dev);
>  	if (panel->ddc)
> -		put_device(&panel->ddc->dev);
> +		i2c_put_adapter(panel->ddc);

[Severity: Low]
The same potential build issue with CONFIG_I2C=3Dn applies here in
panel_simple_remove().

>  }
> =20
>  static const struct drm_display_mode ampire_am_1280800n3tzqw_t00h_mode =
=3D {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716132334.1565=
183-1-johan@kernel.org?part=3D1
