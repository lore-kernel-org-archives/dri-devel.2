Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A47C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4116210E1EC;
	Mon, 21 Sep 2026 16:09:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IQ7xIKnF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A286410E1EC
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 16:09:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 196DB60142;
 Mon, 21 Sep 2026 16:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5591F00893;
 Mon, 21 Sep 2026 16:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790006946;
 bh=43wGuqNUgv/BxGYm40N1io0SBUrViO8jBw+tg3JGMko=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IQ7xIKnFhLuFND965h938MU3OlJAiI357BmtNw/AiyOY5wrUXp2tuaA16SP1A70w3
 i/66KYYACm+oCOlYnA6e+HLhO94FLCyVXtRdno3k3lDHN2yTLx1pitCUp/ChPh+7vE
 brxfD/2Fcwc5vLwjiKvc6Rj9NOprNWSiBtDS1bUwGj6O8jHUi1i+yTQDxyJMUvh2CQ
 Lf/rmzVAeyVifIM1VTG3X4R5MoLnVffXoltheowPmKto3gP4ktHexvZbATv9mrzrI2
 QWhD01XdYOIihyyJ6KUxcwfaM+Mr/MM8qlcDQoKYUPBJAYHSleym6F7SxW/ROj5NTa
 IvDjx1JHYevFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 10/25] drm/rockchip: dw_hdmi_qp: Add VRR support
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921-vrr-limiter-uapi-v1-10-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-10-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:09:06 +0000
Message-Id: <20260921160906.9B5591F00893@smtp.kernel.org>
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
- [Medium] drm/rockchip: State mutation in atomic_check breaks DRM semantics
--

commit 0a43e1780a534b1f1de17fd89eca1b9b3bc5f434
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/rockchip: dw_hdmi_qp: Add VRR support

This commit registers the vrr_capable property on the connector for RK3588
and sets it during the encoder's atomic_check callback.

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index 9c4cf68d79d50..2b9432aa8c542 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c

[ ... ]

> @@ -238,6 +239,10 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_=
encoder *encoder,
>  		dev_err(hdmi->dev, "Failed to configure phy: %d\n", ret);
>  	}
> =20
> +	if (connector->vrr_capable_property)
> +		drm_connector_set_vrr_capable_property(connector,
> +			drm_display_info_is_vrr_capable(&connector->display_info));
> +

[Severity: Medium]
Does mutating global connector state here break DRM semantics?

The atomic_check callback is strictly required to be side-effect free, as
it is used for speculative TEST_ONLY commits. Calling
drm_connector_set_vrr_capable_property() synchronously mutates global,
visible connector state (the property array). This permanently leaks
proposed or temporary state into the visible global state.

Additionally, can this property update be entirely skipped in some paths?
Looking earlier in dw_hdmi_qp_rockchip_encoder_atomic_check():

    if (hdmi->tmds_char_rate =3D=3D conn_state->hdmi.tmds_char_rate &&
        s->output_bpc =3D=3D conn_state->hdmi.output_bpc &&
        s->bus_format =3D=3D ingest_fmt)
        return 0;

If the format is unchanged, the function returns early. This means the
update will be skipped completely. Since userspace typically queries=20
connector properties upon hotplug, deferring this property update to=20
atomic_check means userspace may read a stale (false) capability during=20
its initial probe and mistakenly conclude VRR is unsupported.

>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vrr-limite=
r-uapi-v1-0-2fcd7d011646@collabora.com?part=3D10
