Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01230C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:02:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B05010F3C0;
	Fri, 28 Aug 2026 14:02:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="dkbPNzY0";
	dkim-atps=neutral
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B26C210F3C0
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:02:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787925747; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CkdrSK+t6z6SdsXa/+YswjsfkKz6vkB7f4zOJZiGd/L0A5xCXZtK8CSfDkxjidRWoQAJU0Tcipu6SkLnpkIE8/5zPL1C7qQe9PDTrCyPI5UZtlQ5sxKV4cm+f0zWEYN8lILhsJbgj2N6OdH2ET/HDnC35HZJO/yOV95UPbn8wzg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787925747;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=AcXzEC2kuqIzhwnq20y2zRMGD6N0f33XkiLL/jNqsGw=; 
 b=FJ+T2YzD+KAu4aq1ICrOUu7v8JNEfoEmTq3OoYQ7mx3N3Y1jMWnmrEbjIeAf2RX3wvKetzJfHkgHcICyfCH3lwJmTJqtZODehgO830XRLNNUxLvVGD38K370k2Ed6py7WDCSoQRKl/PnpjJMXHQJtYG1Dg0kgTmA9o8ri0Bf8Ks=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787925747; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=AcXzEC2kuqIzhwnq20y2zRMGD6N0f33XkiLL/jNqsGw=;
 b=dkbPNzY0Ew4xwpeqis9CoFDU6p+GAyjuPvJyBTFv3WIcYF/zhG7b/QntFccUgGti
 Ik7KORNmkF7/EWl9I+Vaf5BJqKyPWmgXdlVc4xqLQ/MZAWyJMAR7kynyWndqlg/N6F5
 4+JVm9l6Pd9mZlqPj0Z9jfj0DDpnTawRWbQH8BwZAGL7kbTyU+DYhc4lDTjeA6KTHn2
 QY9nMcrAYUw3FPBGld8Q21fXAeB8gnIYSZMvcK0vMeyQ19Aov1Uzh/kfSKK+wpe0nOB
 TWinRhJEuMh6/nVMromEWrT5RSRoXfpZ4/ZbqWVEoR0g08S6rZwgptEUL3d+GRkEkTk
 IFMcGy8jeQ==
Received: by mx.zohomail.com with SMTPS id 1787925743638449.66154944275536;
 Fri, 28 Aug 2026 07:02:23 -0700 (PDT)
Message-ID: <d64ff3f2a03473e4263e2f68823c2cb0f7fd1599.camel@icenowy.me>
Subject: Re: [PATCH v2 15/15] MAINTAINERS: Add StarFive JH7110 display
 subsystem entry
From: Icenowy Zheng <uwu@icenowy.me>
To: Michal Wilczynski <m.wilczynski@samsung.com>, Vinod Koul
 <vkoul@kernel.org>,  Neil Armstrong <neil.armstrong@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Andrzej Hajda	 <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart	
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, David Airlie	 <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>, Andy
 Yan <andy.yan@rock-chips.com>, Philipp Zabel	 <p.zabel@pengutronix.de>,
 Emil Renner Berthing <kernel@esmil.dk>, Hal Feng	
 <hal.feng@starfivetech.com>, Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Heiko
 Stuebner <heiko@sntech.de>,  Conor Dooley <conor@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Dominique
 Belhachemi <db@domibel.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 mfd@lists.linux.dev, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org, Andy Yan <andyshrk@163.com>, Marek
 Szyprowski	 <m.szyprowski@samsung.com>, Maud Spierings
 <maudspierings@gocontroll.com>,  Graham Markall <hello@big-grey.co.uk>
Date: Fri, 28 Aug 2026 22:01:58 +0800
In-Reply-To: <20260828-jh7110-clean-send-v2-15-331680c8b9d1@samsung.com>
References: <20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com>
 <CGME20260828134841eucas1p100590973cc6808103c41d0b0fc82573a@eucas1p1.samsung.com>
 <20260828-jh7110-clean-send-v2-15-331680c8b9d1@samsung.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-ZohoMailClient: External
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

=E5=9C=A8 2026-08-28=E4=BA=94=E7=9A=84 15:47 +0200=EF=BC=8CMichal Wilczynsk=
i=E5=86=99=E9=81=93=EF=BC=9A
> The JH7110 display subsystem spans a PHY driver, a DRM bridge driver,
> a parent device and their bindings, and has no existing maintainer
> entry.
>=20
> Add an entry covering them so patches reach someone who can review
> them.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
> =C2=A0MAINTAINERS | 10 ++++++++++
> =C2=A01 file changed, 10 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index
> 8014b9f8253edf15231df215d1b14063a54a55ec..84ac5cfe61cdf775167cf903386
> 2724c37946a5f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25778,6 +25778,16 @@ S:	Maintained
> =C2=A0F:	Documentation/devicetree/bindings/net/starfive,jh7110-
> dwmac.yaml
> =C2=A0F:	drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> =C2=A0
> +STARFIVE JH7110 DISPLAY SUBSYSTEM
> +M:	Michal Wilczynski <m.wilczynski@samsung.com>

Feel free to add

```
R: Icenowy Zheng <zhengxingda@iscas.ac.cn>
```

if you want. I am interested in this.

Thanks,
Icenowy

> +S:	Maintained
> +F:	Documentation/devicetree/bindings/display/bridge/starfive,jh
> 7110-inno-hdmi-controller.yaml
> +F:	Documentation/devicetree/bindings/mfd/starfive,jh7110-hdmi-
> subsystem.yaml
> +F:	Documentation/devicetree/bindings/phy/starfive,jh7110-inno-
> hdmi-phy.yaml
> +F:	drivers/gpu/drm/bridge/jh7110-inno-hdmi.c
> +F:	drivers/phy/starfive/phy-jh7110-inno-hdmi.c
> +F:	drivers/soc/starfive/jh7110-hdmi-subsystem.c
> +
> =C2=A0STARFIVE JH7110 DPHY RX DRIVER
> =C2=A0M:	Jack Zhu <jack.zhu@starfivetech.com>
> =C2=A0M:	Changhuang Liang <changhuang.liang@starfivetech.com>
