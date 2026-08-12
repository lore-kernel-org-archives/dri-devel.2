Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E362DC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5047910E40F;
	Wed, 12 Aug 2026 13:13:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CJ7M1LK7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6BC010E40F
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:13:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5C8A660A85;
 Wed, 12 Aug 2026 13:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A531F000E9;
 Wed, 12 Aug 2026 13:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786540404;
 bh=Bo9AaDw7FhRj4R8d9Rc1K18va82DS9cXmVReak2JbNs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CJ7M1LK79KTR1aAgQyenreQtPtOyjJyWLJHYclKZ3WNrjYNP/ylvXMkps9tHVJHht
 E7dzz8sFtYi/lgKwBM7jGvDleZP8quPA74ZXwj5riu9LSeOC0dWPjHaIIbgWuHnNfA
 jPO9RABMW1LV7vdeSLetaCgWDyIaZdoR8SSJ3QuBd0M2X27pQKlXDHGc8YCDQhWHLN
 Grc4nRLnKJevPXE37NKS9XIjHOg9dnOleJmrJ5lpxiOZajBELE+WzAtrpdXrRjJJjn
 OL/DVuZDS7q+lYHMBOmtFKonR0Ai50wOdnVgXo/k6nyIjRW3gBvrRk/5VUJaqJNTD5
 KNjPvuu/+LEAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] drm/panel: Use devm_mipi_dsi_attach in BOE panels
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812130429.16850-1-osama.abdelkader@gmail.com>
References: <20260812130429.16850-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 13:13:23 +0000
Message-Id: <20260812131323.E7A531F000E9@smtp.kernel.org>
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
- [High] Missing drm_panel_remove() on devm_mipi_dsi_attach() error path in=
 boe_bf060y8m_aj0_probe() causes a dangling pointer and use-after-free.
--

--- Patch [1]: [PATCH v3 1/6] drm/panel: Use devm_mipi_dsi_attach in BOE pa=
nels ---
commit 1f4d2947471e6cb49ce506f1077843c672e21899
Author: Osama Abdelkader <osama.abdelkader@gmail.com>

drm/panel: Use devm_mipi_dsi_attach in BOE panels

Use the managed MIPI DSI attach helper in BOE panel drivers and drop the
corresponding manual detach calls from remove paths.

> diff --git a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c b/drivers/gpu=
/drm/panel/panel-boe-bf060y8m-aj0.c
> index 84c21c62a43e4..6a74523a66141 100644
> --- a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
> +++ b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
> @@ -359,7 +359,7 @@ static int boe_bf060y8m_aj0_probe(struct mipi_dsi_dev=
ice *dsi)
> =20
>  	drm_panel_add(&boe->panel);
> =20
> -	ret =3D mipi_dsi_attach(dsi);
> +	ret =3D devm_mipi_dsi_attach(&dsi->dev, dsi);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
>  		return ret;

[Severity: High]
This is a pre-existing issue, but should drm_panel_remove(&boe->panel) be
called on this error path?

In boe_bf060y8m_aj0_probe(), drm_panel_add() inserts the panel into the
global panel_list. If devm_mipi_dsi_attach() fails, the function returns an
error without calling drm_panel_remove().

During probe failure, the devres cleanup drops the panel's refcount but it
remains in the global panel_list since the refcount doesn't reach zero. If
another driver later looks up this panel (e.g., via of_drm_find_panel())
and invokes its operations, it will dereference freed devres-managed resour=
ces
like boe->reset_gpio, causing a use-after-free.

Other BOE panel drivers updated in this patch seem to correctly handle this
cleanup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812130429.1685=
0-1-osama.abdelkader@gmail.com?part=3D1
