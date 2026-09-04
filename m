Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442A0C624D3
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72B1B10F990;
	Fri,  4 Sep 2026 13:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hsuPaBNl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 728B210F990
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:49:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 25DF341A0C;
 Fri,  4 Sep 2026 13:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5944F1F00A3D;
 Fri,  4 Sep 2026 13:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788529756;
 bh=Kc0jjiNx6Kq8ngc29fQqe8dP+shw+RZ+vD1GVe3R4AQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hsuPaBNlbrjz5g+9i85O5q/yR8Q6LkFhDoPvRU2JHxuTyXryLdg+Wd6WG4I6CLlXI
 7VA07bBwh/q46u5NBjqN6Mz/SLBdKbrp3UdPvNA1afKyUF9jWSA0bgOkO9/9Le1OJ4
 YIFLGnm/0HliUrpBrOWGoqxj00AV5lDTAfPKTLA783scNa0kCstiF6YGUVah6ufWj/
 zwxY5XeE+DByIQctFnwEp5Jf6xCbEwXFpn/ZbpLSDtglDEj39lg0NIYD8XL0Ie0iub
 9YbIzkmAfe5vXKlZEWvnCedeVAIgKgnCCpTkBQQ9Al6rG2uG7/nLmaU+UYL9VGNUW6
 sG2PyVdzFU1Uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/19] drm/bridge: inno-hdmi: Add .disable platform
 operation
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: vkoul@kernel.org, dri-devel@lists.freedesktop.org,
 neil.armstrong@linaro.org, olteanv@gmail.com, lee@kernel.org,
 linux-clk@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 mfd@lists.linux.dev, linux-phy@lists.infradead.org, robh@kernel.org
In-Reply-To: <20260904-jh7110-clean-send-v3-9-484f9ae72715@samsung.com>
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132725eucas1p19c8f66b7844108641dec1d2c39989dd5@eucas1p1.samsung.com>
 <20260904-jh7110-clean-send-v3-9-484f9ae72715@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 13:49:14 +0000
Message-Id: <20260904134915.5944F1F00A3D@smtp.kernel.org>
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
- [High] Hardware Teardown Order Inversion Risking MMIO Aborts
--

commit 3edb8b3d87e91fedec7589ce07bc351965b21765
Author: Michal Wilczynski <m.wilczynski@samsung.com>

drm/bridge: inno-hdmi: Add .disable platform operation

This commit adds a new .disable platform operation to the Innosilicon HDMI
driver to support platform-specific power down sequences. The new callback
is executed during the bridge's atomic disable phase.

> diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/=
inno-hdmi.c
> --- a/drivers/gpu/drm/bridge/inno-hdmi.c
> +++ b/drivers/gpu/drm/bridge/inno-hdmi.c
[ ... ]
> @@ -886,6 +886,10 @@ static void inno_hdmi_bridge_atomic_disable(struct d=
rm_bridge *bridge,
>  					    struct drm_atomic_commit *state)
>  {
>  	struct inno_hdmi *hdmi =3D bridge_to_inno_hdmi(bridge);
> +	const struct inno_hdmi_plat_ops *plat_ops =3D hdmi->plat_data->ops;
> +
> +	if (plat_ops && plat_ops->disable)
> +		plat_ops->disable(hdmi->dev);
> =20
>  	inno_hdmi_standby(hdmi);

[Severity: High]
Does calling the platform disable callback before inno_hdmi_standby() risk
MMIO aborts?

The platform disable hook (such as the JH7110 implementation mentioned in t=
he
commit message) typically powers off the PHY and disables clocks. However,
inno_hdmi_standby() attempts to perform MMIO writes to PHY registers like
HDMI_PHY_DRIVER and HDMI_PHY_PRE_EMPHASIS.

Accessing hardware registers after the PHY has been powered off and clocks
disabled can cause a synchronous external abort (bus hang) or silent
failures on many SoC architectures.

Since plat_ops->enable() is called prior to configuring the PHY registers
during setup, should the teardown follow a strict LIFO order where
inno_hdmi_standby() is called before plat_ops->disable()?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-jh7110-cle=
an-send-v3-0-484f9ae72715@samsung.com?part=3D9
