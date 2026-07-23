Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAF7C44536
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C50510EF60;
	Thu, 23 Jul 2026 01:58:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gUIkzgYE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B061210EF60
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 01:58:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 630B543B2C;
 Thu, 23 Jul 2026 01:58:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D541F000E9;
 Thu, 23 Jul 2026 01:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784771918;
 bh=b4hPwrEfdjqt33NhvscHAHEAiVY4Da4Ocanupu0jb50=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gUIkzgYE8sxugAfSnpafARNTyQMYtL95LY4zAURSbxkN5pMi/F9uax2o1Q1rjFdh9
 EZKxysdJC4cH1jFdyJvGpaLEAKPfEfzjZSWJQtSqhUFoM9nKqX8N4SgWH4n6RnoqPW
 gG7mNy82n1Ra9gCFPoY8C/vniA1S+OLlcf7/g1Xnt9rGPj0bnGrHib1DOEJKV/VMsx
 XqXyfGaJI372j/4ule9p2rO2dsrlX1NjzH6Lr0eWvfMMvn7VY+v7yg7h/dyZbD9GAO
 749YCtd4GzXflQInqLSN0kfMIsNnR4B02Al4dDefaDspFNZu/r4gi3ocAjkB4sErbc
 9TG62CQJeeunQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 32/61] drm/rockchip: dw_hdmi_qp: Use
 dw_hdmi_qp_hpd_notify() for HPD reports
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-32-4fb12ea22ac9@collabora.com>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
 <20260723-dw-hdmi-qp-scramb-v9-32-4fb12ea22ac9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 01:58:37 +0000
Message-Id: <20260723015838.10D541F000E9@smtp.kernel.org>
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
- [High] The `hdmi` and `hdmi->hdmi` pointers become dangling after a faile=
d `component_bind` or a `component_unbind`, leading to a Use-After-Free in =
the platform suspend/resume callbacks.
--

--- Patch [32]: [PATCH v9 32/61] drm/rockchip: dw_hdmi_qp: Use dw_hdmi_qp_h=
pd_notify() for HPD reports ---
commit 47b04090e96cbf8915a6ccec52dc144345e77f41
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: dw_hdmi_qp: Use dw_hdmi_qp_hpd_notify() for HPD reports

This commit notifies only the affected connector instead of polling all
of them. It also ensures .detect_ctx() runs on reconnect to recover SCDC
state.

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index 534a2c8da2a0a..1311eb1cb4aa5 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
[ ... ]
> @@ -768,11 +761,10 @@ static int __maybe_unused dw_hdmi_qp_rockchip_resum=
e(struct device *dev)
>  	if (hdmi) {
>  		hdmi->ctrl_ops->io_init(hdmi);
> =20
> -		if (hdmi->hdmi)
> +		if (hdmi->hdmi) {
>  			dw_hdmi_qp_resume(dev, hdmi->hdmi);
> -
> -		if (hdmi->encoder.encoder.dev)
> -			drm_helper_hpd_irq_event(hdmi->encoder.encoder.dev);
> +			dw_hdmi_qp_hpd_notify(hdmi->hdmi);
> +		}

[Severity: High]
This is a pre-existing issue, but does this addition expose us to a=20
use-after-free during system resume if the driver is unbound?

If dw_hdmi_qp_rockchip_bind() fails late, such as at=20
drm_bridge_connector_init(), or if dw_hdmi_qp_rockchip_unbind() is called,=
=20
devres and drmm cleanups will free hdmi->hdmi and the hdmi struct itself.

However, platform_set_drvdata() is never cleared, leaving a dangling pointer
that dev_get_drvdata(dev) will retrieve in dw_hdmi_qp_rockchip_resume().=20

Since the patch adds a call to dw_hdmi_qp_hpd_notify(hdmi->hdmi) here,
could a system resume following an unbind (or a failed bind) dereference=20
these freed pointers?

>  	}
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-dw-hdmi-qp=
-scramb-v9-0-4fb12ea22ac9@collabora.com?part=3D32
