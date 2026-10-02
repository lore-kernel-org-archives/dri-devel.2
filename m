Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12239CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 12:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72B1210EB26;
	Fri,  2 Oct 2026 12:56:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cPlH3RTO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F4D610F837
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 12:55:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 49F1360A70;
 Fri,  2 Oct 2026 12:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45D71F000FF;
 Fri,  2 Oct 2026 12:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790945758;
 bh=CoGkT0pveH7DUi32Ot274gzIlTfWTVcz5bAcSwDWtSY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cPlH3RTOOrmx3tOpea3bFSXCGBwLf8uP7SXamMaGEny9gkd+7TuHiT0SHy0UoT5nE
 /tMtTxYA1cYjN0GfEto02NQrx6bDOblaoUP07oWxOhKUnBwZoOW1q+DYCp/WIyhK29
 SZvK9AzA9p/Se4LiShrqN1JapreofP7ytfpxMTGbo/DA+JL5K3phf8HvQEdxyySega
 oBNMO4H23sxYT+vYXK7gfJJCe9oTNTVUDreEww4upsYuTsvtRHAP8mh7YqN1z6gwUv
 2ZWKijcznVJrfUJy++6bH00PI5zxfgp0QT4/tCUJWQR8PYz9Ib62eTr8wPJBBs0art
 GeICU1GZZPdog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/7] drm/kms-helper: Remove struct
 drm_simple_display_pipe and helpers
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261002124456.741011-3-tzimmermann@suse.de>
References: <20261002124456.741011-1-tzimmermann@suse.de>
 <20261002124456.741011-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 12:55:57 +0000
Message-Id: <20261002125557.D45D71F000FF@smtp.kernel.org>
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
- [Low] build: imx-lcdc broken due to removed drm_simple_display_pipe
--

commit 34fb6e586b77e29b94177632c0a641cf060ef4ce
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/kms-helper: Remove struct drm_simple_display_pipe and helpers

This commit removes struct drm_simple_display_pipe and its related helpers,
stating that they are no longer used by any drivers. It also updates the
TODO list to reflect this cleanup.

> There are no drivers using struct drm_simple_display_pipe. Remove
> the data type and all related helpers.

[Severity: Low]
Is this statement fully accurate? It appears the imx-lcdc driver still
relies on these structs and functions. Building with CONFIG_DRM_IMX_LCDC=3Dy
currently fails due to incomplete types and implicit function declarations
caused by this removal.

For example, in drivers/gpu/drm/imx/lcdc/imx-lcdc.c, the struct is still
embedded:

	struct imx_lcdc {
		...
		struct drm_device *drm;
		struct drm_simple_display_pipe pipe;
		...

And initialized in imx_lcdc_probe():

	ret =3D drm_simple_display_pipe_init(drm, &lcdc->pipe,
					   &imx_lcdc_pipe_funcs,
					   imx_lcdc_formats,
					   ARRAY_SIZE(imx_lcdc_formats), NULL, NULL);

Does this driver need to be converted to regular atomic helpers before
removing the simple-pipe infrastructure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002124456.7410=
11-1-tzimmermann@suse.de?part=3D2
