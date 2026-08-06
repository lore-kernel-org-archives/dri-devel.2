Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21B5C55174
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 00:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0274F10F071;
	Thu,  6 Aug 2026 00:59:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O0VYUGaB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F6D810F071
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 00:59:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 22DD242A6B;
 Thu,  6 Aug 2026 00:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBDA1F000E9;
 Thu,  6 Aug 2026 00:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785977994;
 bh=pS+P18M4YCQaGgyeHVNf9f6W7bQF4tFliiTmqd8jyJs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O0VYUGaBW/7z3YOr9qtL7HnVeQlmwRWtTseQ70HUlUz9fI6qV3eaSZH53CZjtohrm
 Yr9NRtqVMqNdsvCJhnInQ/G4BvuYsjzuDPAgtYCbCkBtEvv15Fb25NQsIlOq5jZzrR
 VCD/twVSpX82WKUaVAZOBF5ZTzxVlv9EEMJHUYNks2G10E26cbwjDCm4FcWPOVh+pq
 a5hUHo1m3+hJapLeQpd3GuyhvPEj2Z3AH3Awkr7qevbgSEu8tkYsI/FNjSoQGBLQ+9
 6KfyX/ui+K3d11/tj/cq78uhTr0qCwRBUYvO0sPYwuvVqGyv0APLQg7qAgoIH64uI6
 nNtisp60y/uFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 03/21] drm/bridge: synopsys: dw-dp: Fix error
 handling for DP link enablement
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v10-3-d84a26c303d6@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v10-0-d84a26c303d6@collabora.com>
 <20260806-synopsys-dw-dp-improvements-v10-3-d84a26c303d6@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 00:59:53 +0000
Message-Id: <20260806005953.ACBDA1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The new error handling path in `dw_dp_link_enable()` fails to cl=
ear the PHY transmit enable bit (`XMIT_ENABLE`) before powering off the PHY.
- [Medium] The error path in `dw_dp_link_enable()` unconditionally calls `d=
rm_dp_link_power_down()` without checking if the display is still connected.
--

--- Patch [3]: [PATCH v10 03/21] drm/bridge: synopsys: dw-dp: Fix error han=
dling for DP link enablement ---
commit 8b0823cf002b6b94f89ce0d8276e50b1fc919ef4
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Fix error handling for DP link enablement

This patch introduces a new enabled state in the link structure to ensure
the link disabling only happens if it has been properly enabled. It also ad=
ds
missing error handling in dw_dp_link_enable() to power off the PHY and link
if training fails.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index f8ca464d43717..dd951fd447227 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
[ ... ]
> @@ -1615,6 +1616,9 @@ static void dw_dp_link_disable(struct dw_dp *dp)
>  {
>  	struct dw_dp_link *link =3D &dp->link;
> =20
> +	if (!link->enabled)
> +		return;
> +

[Severity: Medium]
Does this early return prevent cleaning up the hardware state if link
enablement fails partway through?

If dw_dp_link_train() fails, the PHY transmit enable bit (XMIT_ENABLE) might
be set, but link->enabled will remain false. Bypassing the teardown here me=
ans
we could leave the MAC configured to transmit while the PHY is eventually
powered down, potentially causing hardware lockups.

[ ... ]
>  static int dw_dp_link_enable(struct dw_dp *dp)
> @@ -1636,10 +1641,21 @@ static int dw_dp_link_enable(struct dw_dp *dp)
> =20
>  	ret =3D drm_dp_link_power_up(&dp->aux, dp->link.revision);
>  	if (ret < 0)
> -		return ret;
> +		goto err_phy_power_off;
> =20
>  	ret =3D dw_dp_link_train(dp);
> +	if (ret < 0)
> +		goto err_link_power_down;
> +
> +	dp->link.enabled =3D true;
> =20
> +	return 0;
> +
> +err_link_power_down:
> +	drm_dp_link_power_down(&dp->aux, dp->link.revision);

[Severity: Medium]
Could this unconditional call to drm_dp_link_power_down() cause a
performance regression on hot-unplugs?

If link training fails because the DP cable is physically disconnected,
attempting an AUX transaction on an unplugged display causes timeout delays
which unnecessarily block the atomic commit thread. Should this call be
guarded with dw_dp_hpd_detect(dp) just as it is in dw_dp_link_disable()?

[Severity: Medium]
Additionally, should there be a call to dw_dp_phy_xmit_enable(dp, 0) in this
error path?

If dw_dp_link_train() fails, the hardware might still have the PHY transmit
enable bit set. Shutting down the PHY before clearing the XMIT_ENABLE state
can lead to undefined hardware states.

> +
> +err_phy_power_off:
> +	phy_power_off(dp->phy);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-synopsys-d=
w-dp-improvements-v10-0-d84a26c303d6@collabora.com?part=3D3
