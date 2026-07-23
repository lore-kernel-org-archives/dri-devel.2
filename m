Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE90BC44536
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45DAD10EF5C;
	Thu, 23 Jul 2026 01:57:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PteqLDvH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7775110EF5C
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 01:57:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B0104600AB;
 Thu, 23 Jul 2026 01:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE061F000E9;
 Thu, 23 Jul 2026 01:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784771857;
 bh=flyAF6dPiFK1NlLjNnw6W9jLjtEMu4HfgGX5vw7hbRY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PteqLDvH3yGyZrnrOMKXSQZBv+JkhQUFY12C8Ovn06d7oKDzLxoSTggDav4PMtHCo
 hVdXzpG6FkzsCxF7dNGA+fai/mb8tO9W6gBJhiwNLyJUJvs1K40fvprhXudlsfyeIb
 Z9s4tQHN4cmI6HzIBZPE2lRMeDqZC8S6G5pcVEZsd4mLJUyZesx2CEJsava4ZvGG4i
 wUzq9b+5RYnl0vpPJZYN+gEzHNmW68PUJM44LcRN9RwTsxaOgegE1dM/imyOYn2Um0
 x/2gMqxwgX7h9qFISRtQiUkeCcaSmpzVcl/ajxMATOo7Kn3JBe4HMQZ4UDIo8xnXuN
 3hJeVyI35iB1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 46/61] drm/rockchip: rk3066_hdmi: Advertise HDMI 1.4
 capabilities
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-46-4fb12ea22ac9@collabora.com>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
 <20260723-dw-hdmi-qp-scramb-v9-46-4fb12ea22ac9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 01:57:36 +0000
Message-Id: <20260723015737.3DE061F000E9@smtp.kernel.org>
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
- [Medium] The code assigns `HDMI_VERSION_1_3` instead of `HDMI_VERSION_1_4=
`, directly contradicting the patch's stated intent to advertise HDMI 1.4 c=
apabilities.
--

--- Patch [46]: [PATCH v9 46/61] drm/rockchip: rk3066_hdmi: Advertise HDMI =
1.4 capabilities ---
commit 8a400446251ad4e071bf0a6818a9b90370bc4528
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: rk3066_hdmi: Advertise HDMI 1.4 capabilities

This commit updates the rk3066_hdmi driver to populate the
supported_hdmi_ver field in the drm_bridge structure. The stated goal in
the commit message is to advertise HDMI 1.4 capabilities so that the core
can correctly reject modes exceeding the TMDS character rate limit.

> diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/roc=
kchip/rk3066_hdmi.c
> index f28d6a883e099..c080abe676c42 100644
> --- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
> +++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
[ ... ]
> @@ -712,6 +713,7 @@ rk3066_hdmi_register(struct drm_device *drm, struct r=
k3066_hdmi *hdmi)
>  	hdmi->bridge.type =3D DRM_MODE_CONNECTOR_HDMIA;
>  	hdmi->bridge.vendor =3D "Rockchip";
>  	hdmi->bridge.product =3D "RK3066 HDMI";
> +	hdmi->bridge.supported_hdmi_ver =3D HDMI_VERSION_1_3;

[Severity: Medium]
The commit message states the intent is to advertise HDMI 1.4 capabilities,
but in rk3066_hdmi_register(), this line assigns HDMI_VERSION_1_3 instead.

Does this cause the bridge to unconditionally advertise HDMI 1.3 capabiliti=
es
to the DRM core during initialization, potentially disabling HDMI 1.4 featu=
res?
Should this be set to HDMI_VERSION_1_4 to match the commit description?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-dw-hdmi-qp=
-scramb-v9-0-4fb12ea22ac9@collabora.com?part=3D46
