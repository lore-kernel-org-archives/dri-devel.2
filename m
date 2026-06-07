Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9834CD8C88
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 03:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BF1010E597;
	Sun,  7 Jun 2026 03:17:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fsHwgoPE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA5A310E597
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 03:17:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 03BFF600AE;
 Sun,  7 Jun 2026 03:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AE41F00893;
 Sun,  7 Jun 2026 03:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780802219;
 bh=bY6vDxvG10977YRhrAOWRrWZUvwPRWsvPxykiEaDYDs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fsHwgoPEeT7OVIoehvRjt7c1XeGoWH8AUVGVAMsFnfgntsiYvdErj0QRdDHOk2bMN
 XHzaO2EioE5tNEJdmIkXnvnkAmc6zBEpS9hvjTlECtxkCnxRzUROWWKL4Iva8K+NUm
 FWj4UjEy2lX5x/T4t3lMshM/Dh39fw+nCpy3inlI31WC02slZeUoKhkVbwkDcCuCmE
 n1rVnN/EdyVMnXNsBgha+fWPBv+xKrthvaGnfP4tBQMmzRCDqzIkJnBZOGUSl0c5RH
 cir89rODDOH0+Y6kmYC43UyGSIl+BHu2LM75xXODD3DYWiWK31cj4F4+c++ir+KoqR
 BWatIfV62zDVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/sun4i: fix refcount leak in sun4i_backend_init_sat()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260607030950.83636-1-vulab@iscas.ac.cn>
References: <20260607030950.83636-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 03:16:58 +0000
Message-Id: <20260607031659.75AE41F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup for SAT resources in sun4i_backend_bind() if devm_=
regmap_init_mmio() fails, leaking SAT clock and reset state.
- [High] Return values of clk_prepare_enable() are completely ignored, pote=
ntially causing imprecise external aborts on clock enablement failure.
- [High] Use of devm_ managed allocations inside the component bind() callb=
ack causes resource leaks on every rebind.
--

commit bc39d4e776a1c47107cfd91202ce280e5f321f36
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/sun4i: fix refcount leak in sun4i_backend_init_sat()

When sun4i_backend_init_sat() calls reset_control_deassert() it
increments the deassert_count of the reset controller, and must
pair that with a reset_control_assert() call to decrement it.
In the error path where clk_prepare_enable() fails, the function
returns immediately without calling reset_control_assert(), leaking
the reference count.  Other error paths, like the devm_clk_get()
failure, correctly jump to the err_assert_reset label which performs
the missing assert.

Fix the leak by using the existing err_assert_reset label in the
clk_prepare_enable error path instead of returning directly.

> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4=
i/sun4i_backend.c
> index 03e46a2af6463..adf5b6e09ca64 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -686,7 +686,7 @@ static int sun4i_backend_init_sat(struct device *dev)=
 {
>  	ret =3D clk_prepare_enable(backend->sat_clk);
>  	if (ret) {
>  		dev_err(dev, "Couldn't enable the SAT clock\n");
> -		return ret;
> +		goto err_assert_reset;
>  	}
> =20
>  	return 0;

[Severity: High]
This isn't a bug introduced by this patch, but there is a pre-existing issue
where SAT resources are not cleaned up in sun4i_backend_bind() if
devm_regmap_init_mmio() fails.

If the device is compatible with sun8i-a33-display-backend,
sun4i_backend_init_sat() successfully enables sat_clk and deasserts sat_res=
et.

If the subsequent call to devm_regmap_init_mmio() fails:

drivers/gpu/drm/sun4i/sun4i_backend.c:sun4i_backend_bind() {
    ...
    backend->engine.regs =3D devm_regmap_init_mmio(dev, regs,
                             &sun4i_backend_regmap_config);
    if (IS_ERR(backend->engine.regs)) {
        dev_err(dev, "Couldn't create the backend regmap\n");
        ret =3D PTR_ERR(backend->engine.regs);
        goto err_disable_ram_clk;
    }
    ...
}

Will jumping to err_disable_ram_clk skip calling sun4i_backend_free_sat() or
otherwise clean up the SAT resources, permanently leaving the SAT clock ena=
bled
and the reset deasserted?

[Severity: High]
This is another pre-existing issue not introduced by this patch, but the
return values of clk_prepare_enable() are ignored in sun4i_backend_bind(),
which might cause imprecise external aborts.

drivers/gpu/drm/sun4i/sun4i_backend.c:sun4i_backend_bind() {
    ...
    clk_prepare_enable(backend->bus_clk);
    ...
    clk_prepare_enable(backend->mod_clk);
    ...
    clk_prepare_enable(backend->ram_clk);
    ...
}

If one of these clocks fails to enable, could the driver proceed to access
hardware registers via regmap on an unclocked hardware block, leading to
system hangs or crashes?

[Severity: High]
This is also a pre-existing issue not introduced by this patch, but using d=
evm_
managed allocations inside the component bind() callback can cause resource
leaks on every rebind.

drivers/gpu/drm/sun4i/sun4i_backend.c:sun4i_backend_bind() {
    ...
    backend =3D devm_kzalloc(dev, sizeof(*backend), GFP_KERNEL);
    ...
}

Since a component's bind/unbind lifecycle can occur multiple times without =
the
underlying platform device being removed (for instance, when the master DRM
device is manually unbound via sysfs), are these managed resources prevented
from being freed upon unbind()?

Can this cause a persistent memory and resource leak (including clocks,
regmaps, and reset controls) on every unbind/rebind cycle?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607030950.8363=
6-1-vulab@iscas.ac.cn?part=3D1
