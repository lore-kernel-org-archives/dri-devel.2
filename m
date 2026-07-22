Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CBBC44512
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67D4D10EC84;
	Wed, 22 Jul 2026 07:03:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FOlm7AVm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E46010EC84
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:03:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 86A7160A64;
 Wed, 22 Jul 2026 07:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C84D1F000E9;
 Wed, 22 Jul 2026 07:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784703829;
 bh=+043Re44fITy2mxq2BjAV27pYbUgXMNvZxrSPt/lWLU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FOlm7AVmvzUrytlr09Lsoxqvey0bZofpqY+8AqeO/4hAENs1SauC85R7SlWovFC0B
 Cbo6iQnL4gFufeZOHCYeMOIgtfiBOU681DDXk6guLmX493FJjwTLrhmzEGuiP9M8ZI
 8i2xcp5aB16PlgZ4Je7KYG6Q6Zff7EC2Sf9XpuTO39EU+NFP431ChfUsC92pM9FQvn
 7vUIRFZY3lb0s9cgV6yJkVMygtT3Ox6gZfKNbzxA9q6D1UyaHoN12dPWSKpILf9M3k
 1fDkz+hNOwXomCtobZgGet4cZmRiLGfnTZuAKtXsODZx+THG8ehpM1d0Y4hAfYRPqX
 dGlx0BTBfFfTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/24] drm/msm/hdmi: use dev_get_drvdata() in
 msm_hdmi_unbind()
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722-drm-msm-display-interface-v1-13-368c10fe62fd@oss.qualcomm.com>
References: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
 <20260722-drm-msm-display-interface-v1-13-368c10fe62fd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 07:03:48 +0000
Message-Id: <20260722070349.1C84D1F000E9@smtp.kernel.org>
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
- [High] Use-After-Free of `hdmi` and `hdmi->i2c` due to missing IRQ teardo=
wn in `msm_hdmi_unbind`.
--

--- Patch [13]: [PATCH 13/24] drm/msm/hdmi: use dev_get_drvdata() in msm_hd=
mi_unbind() ---
commit fd38b018e0f710b01405e26519af9581c27b6208
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm/hdmi: use dev_get_drvdata() in msm_hdmi_unbind()

This commit updates msm_hdmi_unbind() to fetch the hdmi structure directly
using dev_get_drvdata(dev) rather than indirectly through the private kms
pointer. It also removes a NULL check, as the hdmi pointer is guaranteed to
be valid at unbind time.

> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/h=
dmi.c
> index 506a9856459e1..0327098287d14 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
> @@ -324,11 +324,10 @@ static void msm_hdmi_unbind(struct device *dev, str=
uct device *master,
>  		void *data)
>  {
>  	struct msm_drm_private *priv =3D dev_get_drvdata(master);
> +	struct hdmi *hdmi =3D dev_get_drvdata(dev);
> =20
> -	if (priv->kms->hdmi) {
> -		msm_hdmi_destroy(priv->kms->hdmi);

[Severity: High]
This is a pre-existing issue, but does this unbind sequence leave an active
IRQ handler that can cause a use-after-free?

In msm_hdmi_modeset_init(), the IRQ is requested using devm_request_irq()
tied to the DRM master device (dev->dev), not the HDMI component device:

msm_hdmi_modeset_init() {
    ...
    ret =3D devm_request_irq(dev->dev, hdmi->irq,
                msm_hdmi_irq, IRQF_TRIGGER_HIGH,
                "hdmi_isr", hdmi);
    ...
}

When the HDMI platform device is unbound, msm_hdmi_unbind() is called, which
in turn calls msm_hdmi_destroy(hdmi) here and frees hdmi->i2c. Later, the
HDMI device's devres runs and frees the hdmi structure itself.=20

Because the DRM master device is not removed during component unbind, its
devres cleanup does not run, and the IRQ remains registered and active.

If a pending or spurious interrupt triggers msm_hdmi_irq() after this point,
will it dereference the freed hdmi structure and call msm_hdmi_i2c_irq()
with the freed hdmi->i2c pointer?

> -		priv->kms->hdmi =3D NULL;
> -	}
> +	msm_hdmi_destroy(hdmi);
> +	priv->kms->hdmi =3D NULL;
>  }
> =20
>  static const struct component_ops msm_hdmi_ops =3D {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-drm-msm-di=
splay-interface-v1-0-368c10fe62fd@oss.qualcomm.com?part=3D13
