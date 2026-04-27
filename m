Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE5DFF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 18:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C079010E0C7;
	Mon, 27 Apr 2026 18:04:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="avCR022q";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C2E10E0C7
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 18:04:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777313057; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nAvcNvQpM+gfhn2/3HLRBs0Lxyq9g3izU3YePHe4GZ9OWKwQ3UX69okS4N/2ImL5Bebzq6PPWL9034cwg51C0Bww3/A0kAcbIbCr7rS3irVTomncxzhNzCsTOcE6n14/ZmS4V9Q/urzR1wSGW2+DDiBkp7GdtyBtXW4c//Yh1X8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777313057;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=NSEXEwx9S+OeVaRRjXS9ZK8EIwQIZrHT5PwNt4KV1SE=; 
 b=EsY0cGqnRzk/RCyADweX9Vyn05CU/UpD+rzGnwnm3dDK7Kxp7/v7YLlZCWTHcXEng5L6vg4sn+YWTeoEC6AyBMB38ZKAj2XVokIRpshMGagbxvyOdes+wCQXuyuCCUkEErYDBTh48mb4UD0L5EuaCBb4PrsPKF9REfAuNbKft6I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777313057; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=NSEXEwx9S+OeVaRRjXS9ZK8EIwQIZrHT5PwNt4KV1SE=;
 b=avCR022qeDlbdkeJAGU3zhJUbIsjF8r9yuEc101tqxnIqbwLOS290IExQMzV8nU6
 9PuAaFJUVgDUupEz16UKzQ36fAYx8vuk4U7EfzUXPwyJ52EmGMXcD0gcKHVtj8ttxHp
 YZWf2q1Oas3TD8+sCgRRjkTB15U4OVSND959Nr+g=
Received: by mx.zohomail.com with SMTPS id 1777313055502484.3747463385729;
 Mon, 27 Apr 2026 11:04:15 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lucas Stach <l.stach@pengutronix.de>, dri-devel@lists.freedesktop.org
Cc: Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v3 02/13] drm: bridge: dw_hdmi: Only notify connected
 status on HPD interrupt
Date: Mon, 27 Apr 2026 20:04:10 +0200
Message-ID: <5ozaSaKzQeSilqZavTuKOw@collabora.com>
In-Reply-To: <20260403185303.80748-3-jonas@kwiboo.se>
References: <20260403185303.80748-1-jonas@kwiboo.se>
 <20260403185303.80748-3-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
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

On Friday, 3 April 2026 20:52:48 Central European Summer Time Jonas Karlman wrote:
> drm_helper_hpd_irq_event() and drm_bridge_hpd_notify() may incorrectly
> be called with a connected status when HPD is high and RX sense is
> changed. This typically happens when the HDMI cable is unplugged,
> shortly before the HPD is changed to low.
> 
> The original intent of commit da09daf88108 ("drm: bridge: dw_hdmi: only
> trigger hotplug event on link change") was to signal hotplug event at
> correct interrupt states.
> 
> Based on the commit message the intent was to trigger hotplug event:
> - when HPD goes high (plugin)
> - when both HPD and RX sense has gone low (plugout)
> 
> However, following interrupt state changes can typically be observed
> when the HDMI cable is unplugged:
> - RX interrupt:  HPD=high RX=low  -> triggers a connected event
> - HPD interrupt: HPD=low  RX=low  -> triggers a disconnected event
> 
> Fix this by only notify connected status on the HPD interrupt when HPD
> is going high, not on the RX sense interrupt when RX sense is changed.
> 
> After this a connected event should be triggered when HPD=high at HPD
> interrupt, and a disconnected event should be triggered when both
> HPD=low and RX=low at either HPD or RX interrupt.
> 
> Fixes: da09daf88108 ("drm: bridge: dw_hdmi: only trigger hotplug event on link change")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v3: Update commit message
> v2: New patch
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 9febcb58a1df..3b851f12adfe 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -3140,7 +3140,8 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>  			mutex_unlock(&hdmi->cec_notifier_mutex);
>  		}
>  
> -		if (phy_stat & HDMI_PHY_HPD)
> +		if ((intr_stat & HDMI_IH_PHY_STAT0_HPD) &&
> +		    (phy_stat & HDMI_PHY_HPD))
>  			status = connector_status_connected;
>  
>  		if (!(phy_stat & (HDMI_PHY_HPD | HDMI_PHY_RX_SENSE)))
> 

Reviewed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>



