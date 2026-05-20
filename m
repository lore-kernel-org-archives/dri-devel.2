Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DCFCD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C11BE10E626;
	Wed, 20 May 2026 14:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="qKOs1rSH";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C7CB10E626
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=GDgiypVIwA/PQvdX7RyrKY/+g5n+NMwhEKvQxfGp7xE=; b=qKOs1rSHUfFyQjQ2QU90qLmsEG
 E4rO+KqFDvZdMnNVkhT2xM9SqMD/CMUMADckAN8zJzIgHiiRGrfYvDLfVYwvte7zRaDJPjinr9dN7
 W41mCtDYikWfvkdAm1kyTt5Ns2JB93TsQ4vLGQVdLdw8UDj+b5s76SDCSf59Tvpostexn9puA2nth
 1WSXxPyw1cawkSEQwtUp6XpmyN9Z6+X49zn1Jkj0dxFSvWFTrY7Udx+xmwDa/G9o8rsguZyCHlSmu
 oG53XHOV5DRGeBYTKUVFMdMkD5aBSLI4rVQszy9k+eZF8tHtjXWW6HmPSv6IqLIL+WyoyuC5IVfQI
 V1VVfT8w==;
From: Heiko Stuebner <heiko@sntech.de>
To: linux-phy@lists.infradead.org, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, spacemit@lists.linux.dev,
 UNGLinuxDriver@microchip.com, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v8 phy-next 15/31] drm/rockchip: dw_hdmi: avoid direct
 dereference of phy->dev.of_node
Date: Wed, 20 May 2026 16:21:24 +0200
Message-ID: <3758596.1xdlsreqCQ@phil>
In-Reply-To: <20260505100523.1922388-16-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
 <20260505100523.1922388-16-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Hi Vladimir,

Am Dienstag, 5. Mai 2026, 12:05:07 Mitteleurop=C3=A4ische Sommerzeit schrie=
b Vladimir Oltean:
> The dw_hdmi-rockchip driver validates pixel clock rates against the
> HDMI PHY's internal clock provider on certain SoCs like RK3328.
> This is currently achieved by dereferencing hdmi->phy->dev.of_node
> to obtain the provider node, which violates the Generic PHY API's
> encapsulation (the goal is for struct phy to be an opaque pointer
> with a hidden definition, to be interacted with only using API
> functions or NULL pointer checks, for the case where optional variants
> of phy_get() did not find a PHY).
>=20
> Refactor dw_hdmi_rockchip_bind() to perform a manual phandle lookup
> on the "hdmi" PHY index within the controller's DT node. This provides
> a parallel path to the clock provider's OF node without relying on the
> internal structure of the struct phy handle.
>=20
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Heiko Stueber <heiko@sntech.de>

there is now already more stuff depending on this change [0], and
the change itself also is sort of independent of the whole
phy-series. And somehow this series itself sadly hasn't gotten
much review yet.

So would you be ok with me just picking this one patch for the
drm-misc-tree?


Thanks
Heiko

[0] https://lore.kernel.org/dri-devel/20260518193748.2482823-1-jonas@kwiboo=
=2Ese/


