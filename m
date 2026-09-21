Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FABC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C8A710E7B2;
	Mon, 21 Sep 2026 16:06:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h1C+LHJF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 305DA10E75F
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 16:06:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6692C60120;
 Mon, 21 Sep 2026 16:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27341F000FF;
 Mon, 21 Sep 2026 16:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790006763;
 bh=SMwYUdLB3raEiZbaKeVWihIMk/iCUfNIfcV0SP67EAU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h1C+LHJFW7Dj407o5YotRGPARx1SE3mj+KJlTruqQG6dRxYUnT+lAlXd+/0zsfiIG
 w/+yaXCTvOlHkkZIXl3vJ8tY9AyHur+TJ7hvTlRFKXjq5umvEMNASrbdh+MOa0q+0w
 6wpWp0dm5BhW/VkwZimowkeOxbWbVHu3QnvRn9HZN48ac9TaCI/ZoQ1PTCfXLjVWAP
 egvPJlsJP2Rd/bZP8Yjz54HOWd/mb9m9DtovClJ7n45WHmUXLj792g6k8EWXXynWY+
 jKE6DCVVBgcCsP4z/wm7rv+RAXPkuylSET7TwwXEb+bamWfWxHXuB6vaLz110t8pWY
 vqFNe+XJBdUAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 08/25] drm/bridge: synopsys: Add VTEM EMP support
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921-vrr-limiter-uapi-v1-8-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-8-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:06:02 +0000
Message-Id: <20260921160602.F27341F000FF@smtp.kernel.org>
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
- [Medium] drm/bridge: synopsys: missing clear before updating VTEM EMP pac=
ket
--

commit f01e70b0b31bb2936c32cbd70054c3941b7363a9
Author: Derek Foreman <derek.foreman@collabora.com>

drm/bridge: synopsys: Add VTEM EMP support

Add code to pack and schedule VTEM EMPs.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/d=
rm/bridge/synopsys/dw-hdmi-qp.c
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c

[ ... ]

> @@ -775,6 +784,42 @@ static int dw_hdmi_qp_bridge_write_spd_infoframe(str=
uct drm_bridge *bridge,
>  	return 0;
>  }
> =20
> +static int dw_hdmi_qp_bridge_write_vtem_emp(struct drm_bridge *bridge,
> +					    const u8 *buffer, size_t len)
> +{
> +	struct dw_hdmi_qp *hdmi =3D bridge->driver_private;
> +	u32 val, i;
> +
> +	if (len !=3D HDMI_INFOFRAME_SIZE(VTEM)) {
> +		dev_err(hdmi->dev, "unsupported vtem emp packet size of %zu\n", len);
> +		return -EINVAL;
> +	}
> +
> +	val =3D buffer[1] << 8 | buffer[2] << 16;
> +	dw_hdmi_qp_write(hdmi, val, PKT_EMP_VTEM_CONTENTS0);

[Severity: Medium]
Should dw_hdmi_qp_bridge_clear_vtem_emp() be called here before writing the
new packet contents to the hardware registers?

The DRM HDMI state helper does not automatically call the clear function=20
before writing when updating an existing frame. Modifying the packet
scheduler contents across multiple register writes while transmission is
active might cause a hardware race condition, where the hardware could
transmit a torn VTEM EMP packet containing a mix of old and new data. This
could result in transient glitches or desynchronization in the sink's VRR
state.

Other infoframe writers in this driver, such as=20
dw_hdmi_qp_bridge_write_spd_infoframe(), explicitly call their respective
clear functions before writing new contents.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vrr-limite=
r-uapi-v1-0-2fcd7d011646@collabora.com?part=3D8
