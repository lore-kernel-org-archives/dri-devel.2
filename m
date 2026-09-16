Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9653CC88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAFFC10E569;
	Wed, 16 Sep 2026 10:25:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WiW+gDWh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDDA110E588
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 10:25:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B085C602D0;
 Wed, 16 Sep 2026 10:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D06A1F000FF;
 Wed, 16 Sep 2026 10:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789554338;
 bh=oLTaSqa80LVjpFRwxUGstzlzN2qZpD85RVboO/wV3is=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WiW+gDWhhoDHxQR7zjNSzcxXn03ay7edL4sICzFWOCbFyIapaW5ILJAqBWg9pHSv+
 y35Smg2TrV7M+pjEvbW4jeBxrtLx8T5wlYHDB2ROClRrMJt/L6r6HnkH/z46NtjQZG
 Q30RFrSf3oiCT2e6QV/wcfXnLj9xGz9WqH4ZiEaounFbMtHJCgIGLMgQD/V21bkLk/
 PD8Hi0/ovC5kXZ0lZA07+KSvvcByKbOqSdaDVVfwVctw+G3plw3DdS4UDxk2/nYSzk
 GUEsMgUEDoonPGkhoF2PExwxGw8tADuUXMHbMtyZllchIoNNHAsx66Lr6kL5OupFTf
 hIQkuw28b2+tQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: dw-hdmi: Fix next_bridge reference leak in
 dw_hdmi_parse_dt()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260916100912.2014953-1-vulab@iscas.ac.cn>
References: <20260916100912.2014953-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 10:25:37 +0000
Message-Id: <20260916102538.3D06A1F000FF@smtp.kernel.org>
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
- [Low] drm/bridge: dw-hdmi: bogus fix introduces dead code and double-put =
risk
--

commit a2a89ee3551f54a10aa7baa4ebb98caa3f85eb6f
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/bridge: dw-hdmi: Fix next_bridge reference leak in dw_hdmi_parse_dt()

This commit attempts to fix a claimed reference leak of the next bridge in=
=20
the pipeline by manually dropping the reference in the probe error path=20
and the remove function.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/=
bridge/synopsys/dw-hdmi.c
> index 937d61c42b58d..a1434beef92ff 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
[ ... ]
> @@ -3588,6 +3588,7 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_devic=
e *pdev,
>  	return hdmi;
> =20
>  err_res:
> +	drm_bridge_put(hdmi->bridge.next_bridge);

[Severity: Low]
Is this fix addressing a phantom issue? The commit message mentions fixing
a leak in dw_hdmi_parse_dt(), but that function appears to have been
removed in an earlier refactoring. The bridge lookup now happens dynamically
in dw_hdmi_bridge_attach() using a local variable that manages refcounting.

Also, since hdmi->bridge.next_bridge is never actually populated anywhere
in dw-hdmi.c (and is initialized to NULL by devm_drm_bridge_alloc), does
this simply introduce dead code by calling drm_bridge_put(NULL)?

Furthermore, if the bridge were populated, wouldn't this manual put cause
a double-put risk? According to the DRM bridge core lifecycle, next_bridge
is automatically put when the bridge's refcount reaches zero and
__drm_bridge_free() is invoked during probe failure cleanup.

>  	i2c_put_adapter(hdmi->ddc);
> =20
>  	return ERR_PTR(ret);
> @@ -3597,6 +3598,7 @@ EXPORT_SYMBOL_GPL(dw_hdmi_probe);
>  void dw_hdmi_remove(struct dw_hdmi *hdmi)
>  {
>  	drm_bridge_remove(&hdmi->bridge);
> +	drm_bridge_put(hdmi->bridge.next_bridge);

[Severity: Low]
Similar to the err_res path in dw_hdmi_probe(), isn't this manual put both
dead code (acting on a NULL pointer) and a violation of the DRM bridge API?

If next_bridge were actually populated, the DRM core would intrinsically
execute drm_bridge_put(bridge->next_bridge) during standard teardown when
the refcount drops to zero. Calling it manually here risks a double-put
during teardown.

> =20
>  	if (hdmi->audio && !IS_ERR(hdmi->audio))
>  		platform_device_unregister(hdmi->audio);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916100912.2014=
953-1-vulab@iscas.ac.cn?part=3D1
