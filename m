Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB4AFD8779
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 00:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA90610E5F9;
	Wed, 18 Mar 2026 00:08:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N4TtEpuj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D377110E5F9;
 Wed, 18 Mar 2026 00:08:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A3815403E7;
 Wed, 18 Mar 2026 00:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9F3C19425;
 Wed, 18 Mar 2026 00:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773792521;
 bh=D1D/7ldl9hLSp78iQ6WgbBNELMb7wmGvz53rwt7WaEU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=N4TtEpuj2ofpYYk614ICJN/q/4cwIC81dgWQ31X3yLNCti+3QoqhZM0r8zR5rIf9M
 t7lZCqMWE5kEnZNPdemPxbCW8s7TWlN++s2eLVs4j19SHDykH3XmCoQK8dICIhrs12
 4Hno4caRMYbSYYGI34r65e3k7DCErH/eUDaQxo1OZ/cLhM0LWBt/R6Ds9ZdQPZZKZt
 H/9YX1l79o6IxDlL4SG4B3WHft/1wgmCeCyqZUCv+u110APJZ76fDP+YvD8DuYm7xC
 4h9FFiEAcgzGl3j6zj76uHKrfPMWUIZudEi0e5bWkdd4FTwZ9Td5lIEgbwv8KJkEfn
 WJK12HSUQwc4g==
Date: Wed, 18 Mar 2026 08:08:39 +0800
From: Yixun Lan <dlan@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 spacemit@lists.linux.dev, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v4 phy-next 06/24] phy: spacemit: include missing
 <linux/phy/phy.h>
Message-ID: <20260318000839-GKB453922@kernel.org>
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
 <20260317230500.2056077-7-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317230500.2056077-7-vladimir.oltean@nxp.com>
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

On 01:04 Wed 18 Mar     , Vladimir Oltean wrote:
> This driver relies on a transitive inclusion of the PHY API header
> through the USB headers.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Yixun Lan <dlan@kernel.org>

> ---
> Cc: Yixun Lan <dlan@kernel.org>
> 
> v1->v4: none
> ---
>  drivers/phy/spacemit/phy-k1-usb2.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/phy/spacemit/phy-k1-usb2.c b/drivers/phy/spacemit/phy-k1-usb2.c
> index 342061380012..14a02f554810 100644
> --- a/drivers/phy/spacemit/phy-k1-usb2.c
> +++ b/drivers/phy/spacemit/phy-k1-usb2.c
> @@ -9,6 +9,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/iopoll.h>
> +#include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/usb/of.h>
> -- 
> 2.43.0
> 

-- 
Yixun Lan (dlan)
