Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EEDC982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 17:51:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A58EC10E060;
	Wed, 16 Sep 2026 17:51:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OESgr3Q9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3EEA10E060
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 17:51:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 680A2601FD;
 Wed, 16 Sep 2026 17:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06751F00893;
 Wed, 16 Sep 2026 17:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789581106;
 bh=HZZXcJyoB6Dqh1esbi2gV3sA0PyaYzHOHQn5pjY/Uq0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OESgr3Q9QL7jZCis5tkRxCv/Mu1IzbOC3Y62Ki7Ux6fx1BbcvfCVtzmTjqeJefo7u
 +kwXR3UkrQcKVV76K0ZcuzitxzVJ1VCty3PzRRkn+OWqutns8wdkGhEkDsOGg6Dy7z
 T0u3PDiTUd+SRXy1fznthuaIqXRmoFrV5Kevlbe9aQvgaLvjZF++ar64RXSoUQ7UkB
 JyU/G3bvaJctN/l0+LrWgw/JHG+pByfe63aK4QU7un2kj/oHuTsVBoiJLXPTM3s8I+
 imr+bGIsBCYa2Gjx1Un5o+yQYKYIFl9RRE/ZNpwajZDEOhgS/vMsYwWjQgAq9BzToM
 txMUHFwa6CJww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/mediatek: Fix pdev reference leak in mtk_drm_bind()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260916174058.2088709-1-vulab@iscas.ac.cn>
References: <20260916174058.2088709-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 17:51:45 +0000
Message-Id: <20260916175145.F06751F00893@smtp.kernel.org>
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
- [High] drm/mediatek: UAF in mtk_crtc_create() due to dangling mutex_dev
--

commit 8e4c071af71a8f36ce4623ffd3129ead77322d8b
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/mediatek: Fix pdev reference leak in mtk_drm_bind()

This commit addresses a device reference leak in mtk_drm_bind() by dropping
the reference to the disp-mutex device via put_device() when returning early
for non-master components.

> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -638,8 +638,10 @@ static int mtk_drm_bind(struct device *dev)
>  	private->mtk_drm_bound =3D true;
>  	private->dev =3D dev;
> =20
> -	if (!mtk_drm_get_all_drm_priv(dev))
> +	if (!mtk_drm_get_all_drm_priv(dev)) {
> +		put_device(private->mutex_dev);
>  		return 0;
> +	}

[Severity: High]
Does this introduce a dangling pointer that could lead to a Use-After-Free?

When put_device(private->mutex_dev) is called, the reference is dropped, but
the pointer private->mutex_dev is left intact while returning success.

Later, when the master component binds, it initializes the CRTCs for all
components. In mtk_crtc_create(), it retrieves the non-master's private
structure and uses this pointer:

drivers/gpu/drm/mediatek/mtk_crtc.c:mtk_crtc_create() {
    ...
    mtk_crtc->mutex =3D mtk_mutex_get(priv->mutex_dev);
    ...
}

This accesses the potentially freed device memory in mtk_mutex_get():

drivers/soc/mediatek/mtk-mutex.c:mtk_mutex_get() {
    struct mtk_mutex_ctx *mtx =3D dev_get_drvdata(dev);
    ...
}

If the disp-mutex device is unregistered between the non-master and master
binds, could this lead to a memory corruption or panic? Should
private->mutex_dev be set to NULL after the put_device() call?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916174058.2088=
709-1-vulab@iscas.ac.cn?part=3D1
