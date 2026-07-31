Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA913C5516F
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1794210F380;
	Fri, 31 Jul 2026 18:09:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T1KeE601";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7C9710F380
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 18:09:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CFD5943900;
 Fri, 31 Jul 2026 18:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD9C1F00AC4;
 Fri, 31 Jul 2026 18:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785521385;
 bh=eIKarEuyOY8dzXdFlVkd6J592fiC7ID6E9bBmVQlRPQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T1KeE601riSC5Vy+e5KwEeig8YokWTmJGIWPMzw6FC4VCp4Pud89a3Xn4bLYyndFy
 xi6VYgSQtzybGaI2QF+0QjwHwQ+x1fK/EXZe9Nuut1o+yvQKGjkA8w9jGJf880BLPT
 2bwJhownVm/SDPj4wwK+xsFoZY6KtT72aZX0XJHPIuY8BGmSH0ps7lo/caubGw3QHj
 OFlgBVS6aXHad918Xk2L8YjKdFjXA+EXFV7jhVOAnL2VJJonwEQdYWBPabbifG3LHc
 wsOWpn9qP2HHv7o/2ziWR0g9FkyAFtmVnxXFU50EAa97RPmNCHISmmF9afoC90bwiU
 04bUNnsx4f38w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 15/69] drm/bridge: Add bridge ops for source-side
 HDMI 2.0 scrambling
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-15-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-15-294364b2cf15@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 18:09:45 +0000
Message-Id: <20260731180945.8DD9C1F00AC4@smtp.kernel.org>
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
- [Medium] Missing API implementation for bridge HDMI 2.0 scrambler callbac=
ks causes unconditional probe failure.
--

--- Patch [15]: [PATCH v10 15/69] drm/bridge: Add bridge ops for source-sid=
e HDMI 2.0 scrambling ---
commit 5577332c0f45e627e54f1e2997be97e38fdecf40
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/bridge: Add bridge ops for source-side HDMI 2.0 scrambling

This commit adds hdmi_scrambler_enable() and hdmi_scrambler_disable()
callbacks to struct drm_bridge_funcs. These allow bridges to enable or
disable source-side scrambling and high TMDS clock ratios for modes
exceeding 340 MHz.

> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 5a5a25995471c..77b3ffe692304 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
[ ... ]
> +	/**
> +	 * @hdmi_scrambler_enable:
> +	 *
> +	 * Enable source-side scrambling and the high TMDS clock ratio for the
> +	 * mode currently being applied.
[ ... ]
> +	 * Returns:
> +	 * 0 on success, a negative error code otherwise.
> +	 */
> +	int (*hdmi_scrambler_enable)(struct drm_bridge *bridge);
> +
> +	/**
> +	 * @hdmi_scrambler_disable:
> +	 *
> +	 * Disable source-side scrambling and the high TMDS clock ratio.
[ ... ]
> +	 * Returns:
> +	 * 0 on success, a negative error code otherwise.
> +	 */
> +	int (*hdmi_scrambler_disable)(struct drm_bridge *bridge);

[Severity: Medium]
Are these newly added callbacks being hooked up to the DRM connector
infrastructure?

Looking at drm_bridge_connector_init() in drm_bridge_connector.c, it
initializes hdmi_funcs but doesn't seem to map these new bridge callbacks:

		bridge_connector->hdmi_funcs =3D drm_bridge_connector_hdmi_funcs;

		bridge_connector->hdmi_funcs.vendor =3D bridge_connector->bridge_hdmi->ve=
ndor;
		bridge_connector->hdmi_funcs.product =3D bridge_connector->bridge_hdmi->p=
roduct;

If a bridge advertises HDMI_VERSION_2_0, will drmm_connector_hdmi_init()
fail with -EINVAL during probe because the connector's hdmi_funcs are
missing these required scrambler callbacks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-dw-hdmi-qp=
-scramb-v10-0-294364b2cf15@collabora.com?part=3D15
