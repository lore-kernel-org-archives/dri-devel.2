Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D71C55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 08:09:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADD9210E2BC;
	Thu,  6 Aug 2026 08:09:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fEBDnDml";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0853610E2BC
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 08:09:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9B80341476;
 Thu,  6 Aug 2026 08:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546A11F00A3A;
 Thu,  6 Aug 2026 08:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786003786;
 bh=bd97DkkuyIsq/jw6SgOO/VjBvTL3PPZniDUb1+De0R0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fEBDnDml3xvC9H2j5vVm3kBU9EzmcB7exq+UNu5a8mWhwq01uMY/7VRtqv9mTpd0o
 ZTXohMansp9dryebtEgVmXjnyfOYoZ77fOQso+mGTHWO/RGRZTHvQ6sAaEouQV/0HZ
 RCCaofUrVs1eAq6vHl5en974zsUUrp/RkLHI57rJ08dJGnkrzeO9P02BVX5fIiEy4T
 cukOHmnZ0BgZUu70EirxjxAaKyr+mm0/XbpsIxtsq6MB7BPbtsj1t7acOOikrYJMUi
 FW4RH9bZbbobIerwEsT0d4wglRtyKq8u/L5kXu6H+bpg2v/9vkUdDrEdbdxObtvqqB
 ldBcb8tMNam0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/mipi-dsi: fix UAF on device_add() failure
To: "Linkai Gong" <gonglinkai@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260806075452.2361689-1-gonglinkai@kylinos.cn>
References: <20260806075452.2361689-1-gonglinkai@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 08:09:45 +0000
Message-Id: <20260806080946.546A11F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces inconsistent ownership semantics for the `inf=
o->node` reference on error paths, creating an unresolvable reference count=
ing ambiguity for callers.

Pre-existing issues:
- [High] Double-put of `device_node` references in DSI device callers leadi=
ng to Use-After-Free.
--

--- Patch [1]: [PATCH] drm/mipi-dsi: fix UAF on device_add() failure ---
commit a9cfa4f20408a5cdd4a82d99b49a2b8290aff096
Author: Linkai Gong <gonglinkai@kylinos.cn>

drm/mipi-dsi: fix UAF on device_add() failure

This commit modifies the error handling in mipi_dsi_device_register_full()
when mipi_dsi_device_add() fails. It replaces kfree() with put_device()
to ensure mipi_dsi_dev_release() is called to clean up the device resources.

> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_ds=
i.c
> index 3ac1dd5ad640a..1b4c0acbd30d2 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -233,7 +233,7 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *h=
ost,
>  	ret =3D mipi_dsi_device_add(dsi);
>  	if (ret) {
>  		dev_err(host->dev, "failed to add DSI device %d\n", ret);
> -		kfree(dsi);
> +		put_device(&dsi->dev);

[Severity: High]
Does this create an inconsistent ownership contract for the caller?

If mipi_dsi_device_register_full() fails early (e.g., info->channel > 3, or
mipi_dsi_device_alloc() fails), it returns ERR_PTR() without putting
the info->node reference.

If it fails late at mipi_dsi_device_add(), the new put_device() call trigge=
rs
mipi_dsi_dev_release() which consumes the info->node reference via
of_node_put().

Since both cases return an opaque error pointer, the caller has no way to
know whether the node reference was consumed or not. If the caller drops the
reference on error, it causes a double-put on late failures. If the caller
retains it, it leaks on early failures.

[Severity: High]
This is a pre-existing issue, but this patch makes it manifest on the error
path. Are callers actually holding an extra reference to info->node when
calling mipi_dsi_device_register_full()?

Looking at existing drivers, many pass an unowned reference. For example,
in drivers/gpu/drm/panel/panel-raydium-rm69380.c:rm69380_probe():

	dsi_sec_host =3D of_find_mipi_dsi_host_by_node(dsi_sec);
	of_node_put(dsi_sec);
	...
	ctx->dsi[1] =3D devm_mipi_dsi_device_register_full(dev, dsi_sec_host, &inf=
o);

The driver explicitly drops the reference before registration. When
mipi_dsi_dev_release() calls of_node_put(dev->of_node) unconditionally,
this causes a use-after-free.

Similarly, in drivers/gpu/drm/bridge/lontium-lt9611.c:lt9611_attach_dsi():

	const struct mipi_dsi_device_info info =3D { "lt9611", 0, lt9611->dev->of_=
node};
	...
	dsi =3D devm_mipi_dsi_device_register_full(dev, host, &info);

The node is passed without acquiring an extra reference, which will also
result in a double-put when the device is released.

>  		return ERR_PTR(ret);
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806075452.2361=
689-1-gonglinkai@kylinos.cn?part=3D1
