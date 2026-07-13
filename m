Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB28C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 01:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDF9910E334;
	Mon, 13 Jul 2026 01:54:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="og14ISb+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A84C610E334
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 01:54:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 974E660018;
 Mon, 13 Jul 2026 01:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B24A1F000E9;
 Mon, 13 Jul 2026 01:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783907649;
 bh=nIymli09xdYedva+zS/NvhIWPXz24Cs4u3mhk5Z4Fn0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=og14ISb+H82Cm7sHncVvG7YgJ6C1nPPtD0cONpiwxKOarVU/TtnaAdjMX7rP+m/EW
 Kqk5KAH6JU36+a0RcF6/KUYtuz9ezhYTpQLcdVYjkq0iEjYeKa5oGDnhKYelHzE0qn
 xC8qTR+Fgt+2gkl6s7nifa90kf3S2rphq3fpbEGWknWDP9cQvfeXmsYv8l0G+jNF91
 BOLDRhM6oOyaLW1Ho3WbPCLXzaXbnIGTiqPEIg+Xg+4USQtjvsDqwQ4ydKi6eWf/Bv
 NofDMTvbH30rLbuBgYCBhAQovNXAGGoTV5gdga/9pVDShGLtnLjxuFsJgPxY0HkjKN
 oo6mFQE//oExw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/stm/ltdc: Fix clock cleanup error handling
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713014835.23995-1-zenghongling@kylinos.cn>
References: <20260713014835.23995-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 01:54:08 +0000
Message-Id: <20260713015409.2B24A1F000E9@smtp.kernel.org>
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
- [Medium] Unbalanced clock disable in `ltdc_load()` due to incorrect error=
 path cleanup.
--

--- Patch [1]: [PATCH] drm/stm/ltdc: Fix clock cleanup error handling ---
commit 12fe618c7882264e51fac6ed9a7b1ab9994cdfbe
Author: Hongling Zeng <zenghongling@kylinos.cn>

drm/stm/ltdc: Fix clock cleanup error handling

This commit fixes resource leaks by ensuring clocks are properly disabled a=
nd
unprepared when subsequent clock preparations fail in ltdc_resume() and
ltdc_load().

> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 95fcfa48d8be3..ead9e87bd7192 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
[ ... ]
> @@ -1962,7 +1971,7 @@ int ltdc_load(struct drm_device *ddev)
>  		ret =3D clk_prepare_enable(ldev->bus_clk);
>  		if (ret) {
>  			drm_err(ddev, "Unable to prepare bus clock\n");
> -			return ret;
> +			goto err;
>  		}
>  	}
> =20

[Severity: Medium]
Does this new error path cause an unbalanced clock disable?

If clk_prepare_enable() fails here in ltdc_load(), the pointer ldev->bus_clk
is already set (and non-NULL), but the clock was not successfully enabled.=
=20

By jumping to the 'err' label at the end of ltdc_load():

err:
	clk_disable_unprepare(ldev->pixel_clk);

	if (ldev->bus_clk)
		clk_disable_unprepare(ldev->bus_clk);

Won't this cleanup code unconditionally call clk_disable_unprepare() on a c=
lock
that failed to enable? It seems this would decrement the prepare/enable
counters below their actual values and trigger a WARN in the common clock
framework.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713014835.2399=
5-1-zenghongling@kylinos.cn?part=3D1
