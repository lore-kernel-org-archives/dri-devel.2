Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FF5C982C1
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:49:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30B2B10E376;
	Wed, 16 Sep 2026 07:49:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bdswz4jI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0EDA10E376
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 07:48:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BD8A56020C;
 Wed, 16 Sep 2026 07:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535EE1F000FF;
 Wed, 16 Sep 2026 07:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789544938;
 bh=4ttehqGJyOlgrXzvih58aN2rFoWFDWhoo4R/YVUygUE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bdswz4jI9Yp6eVcwkVC9prLkysRUa1+MvYP2BZREJdsHAD8O0Zo45qu6tz8lzyQ8S
 ZL1f+VBod99eWviyZDiBi94ebNmdzVuKlMXGaSvUdUVuqWl53a3E27nJ49UP//1XMW
 xUtgY0CuTSElBZnhfRYwFPEwJq/MbfTulVWE/EMa1JUjq24EHSCVuGYnUREyJmXSH+
 RAD2PrKeAaWyMC0V0tAqSStTZsD0aKQpVGxZCBOlO06iPJjueW543WqxoxY/xbNzHU
 a9IQzS5tTHo20GPaMknmQurO6VTyWPxxNCw+kHNZ/UprKGs3/a8ZRaZFnoGkSztntk
 ImOdQsVelGEtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] firmware/sysfb: Fix device reference count leak in
 sysfb_disable()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260916073815.1972045-1-vulab@iscas.ac.cn>
References: <20260916073815.1972045-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 07:48:57 +0000
Message-Id: <20260916074858.535EE1F000FF@smtp.kernel.org>
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
- [High] sysfb: kill-switch bypass when parent device query returns an error
--

commit cea5d6870e1a5b4277264d29fe9056b6df3310b7
Author: Wentao Liang <vulab@iscas.ac.cn>

firmware/sysfb: Fix device reference count leak in sysfb_disable()

This commit addresses a device reference count leak in sysfb_disable(). It
adds a check to ensure the parent device is not an error pointer and releas=
es
the reference using put_device() before returning.

> diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
> --- a/drivers/firmware/sysfb.c
> +++ b/drivers/firmware/sysfb.c
> @@ -71,9 +71,12 @@ void sysfb_disable(struct device *dev)
> =20
>  	mutex_lock(&disable_lock);
>  	parent =3D sysfb_parent_dev(si);
> -	if (!dev || !parent || dev =3D=3D parent) {
> -		sysfb_unregister();
> -		disabled =3D true;
> +	if (!IS_ERR(parent)) {

[Severity: High]
Will wrapping the unregistration logic in !IS_ERR(parent) bypass the global
kill-switch when the parent device query returns an error?

Graphics drivers use sysfb_disable(NULL) as a global kill-switch to
unconditionally disable the generic firmware framebuffer before native DRM
drivers take over.

sysfb_parent_dev() can return an ERR_PTR (like -ENODEV) if the PCI device
exists but its memory decoding is not enabled. If this happens during early
boot or driver probe, this new check skips the block entirely, silently
bypassing the kill-switch and leaving the disabled flag as false.

If a built-in native DRM driver disables sysfb and subsequently enables PCI
memory decoding, could a later execution of sysfb_init() see disabled =3D=
=3D false
and incorrectly register the generic framebuffer on top of the already-runn=
ing
native driver? This concurrent access could lead to resource conflicts or k=
ernel
panics.

> +		if (!dev || !parent || dev =3D=3D parent) {
> +			sysfb_unregister();
> +			disabled =3D true;
> +		}
> +		put_device(parent);
>  	}
>  	mutex_unlock(&disable_lock);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916073815.1972=
045-1-vulab@iscas.ac.cn?part=3D1
