Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D3AC531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 18:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DC6B10E083;
	Fri, 24 Jul 2026 18:27:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cOrQxY/f";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97F2A10E080
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 18:27:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1C5F0600AD;
 Fri, 24 Jul 2026 18:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7934B1F000E9;
 Fri, 24 Jul 2026 18:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784917656;
 bh=RK0pJA6FI5zk+xBpHtAiSTkxqbPxYzZaoCr0aVhOkew=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cOrQxY/fDgX2pM3Q/ll1oWV4BtRBKcId7fhtEXCGKPtT6rywPRyVjnu+o+LK0lofQ
 OIZKncZYBFeILR8uP3FmMQSGS7ENGSGNgPmTfSlHR62RuL4JrFhqR0CXISc1qiMXV6
 j+hcLtPvLamq4ERE471YHmORaiVa8oUsls8psUWcdsTv7Vdna0LqGhOXhTuHD60yzr
 DnC+DnZ2MlB6cpSu7DjRfeDJw06oIChJ7Pf9o5WxbgOfO6zQOSUvBBSRqXYz8Ye75m
 JBAX5P51oL0V2C5tRlBqYRzEmysd4zZwjLeow7LUKj7vw2MI5AxW8D8D7QV8DhB/1P
 8G0jNGow5MalQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/16] drm/rockchip: dw_dp: Add runtime PM support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260724-synopsys-dw-dp-improvements-v6-12-041d99a19c4e@collabora.com>
References: <20260724-synopsys-dw-dp-improvements-v6-0-041d99a19c4e@collabora.com>
 <20260724-synopsys-dw-dp-improvements-v6-12-041d99a19c4e@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 18:27:36 +0000
Message-Id: <20260724182736.7934B1F000E9@smtp.kernel.org>
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
- [High] The DW DP core driver uses `guard(pm_runtime_noresume)` in its int=
errupt handler, allowing hardware register accesses while the device is sus=
pended and its clocks are disabled.
--

--- Patch [12]: [PATCH v6 12/16] drm/rockchip: dw_dp: Add runtime PM suppor=
t ---
commit 76fb970e196b210c9742e601b51113d5f65dd02f
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/rockchip: dw_dp: Add runtime PM support

This commit adds support for runtime PM to the Rockchip RK3576/3588 Synopsys
DesignWare DisplayPort driver.

> diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/=
rockchip/dw_dp-rockchip.c
> index ee0bd696064eb..b8138e796c4d5 100644
> --- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c

[ ... ]

> @@ -247,6 +260,12 @@ static int dw_dp_rockchip_probe(struct platform_devi=
ce *pdev)
>  	if (IS_ERR(dp->base))
>  		return PTR_ERR(dp->base);
> =20
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 500);
> +	ret =3D devm_pm_runtime_enable(dev);

[Severity: High]
Does enabling runtime PM here expose a bus fault in the core dw_dp_irq
handler on suspended devices?

The core DW DP driver uses guard(pm_runtime_noresume) which only increments
the PM usage counter without checking the actual power state:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_irq() {
	/* interrupt can only trigger for running device */
	guard(pm_runtime_noresume)(dp->dev);

	regmap_read(dp->regmap, DW_DP_GENERAL_INTERRUPT, &value);
	...
}

If a spurious or delayed interrupt fires while the DP controller is
suspended and its clocks are disabled, this allows the handler to execute
and read from DW_DP_GENERAL_INTERRUPT.

Accessing memory-mapped registers over a disabled APB bus can cause a bus
fault (such as an SError on ARM) resulting in a kernel panic.

Should the core driver be updated to use pm_runtime_get_if_active()
to safely verify the device is active before accessing hardware registers?

> +	if (ret)
> +		return ret;
> +
>  	return component_add(&pdev->dev, &dw_dp_rockchip_component_ops);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-synopsys-d=
w-dp-improvements-v6-0-041d99a19c4e@collabora.com?part=3D12
