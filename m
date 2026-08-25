Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E231C61DC2
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09E2410EA5F;
	Tue, 25 Aug 2026 13:40:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="i+uAiirl";
	dkim-atps=neutral
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch
 [109.224.244.106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8FEB10EA6A
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 13:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail; t=1787665230; x=1787924430;
 bh=MnFo6aft2Hia4ynHkRSKrZ6ZoG41Jy7JGffv0qeTE1Q=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=i+uAiirlDwV0kE9TPmjrOowVWrvmeTwymKmn5v5QU118GOCFfc870RiAw8meV6Inr
 ykxII8GQT7qGuJOLnRZ4bmmqcPlo0Z23VBUMU0He9CQJ+HrbSH0mrIU7cjsT17ecl8
 Th7egJl7qyAZUg0P2uHvH9cXM9VuRpj1csJEViAlASS7Op385bKgnA16ZWLmdWv6nj
 T5QYxkBcZNtvrlHdBBM7Yy3zKYrplf49S8ZWd/JTUc3quf6zAjWxh/kjcKS40lsP+f
 hm4ry+rlz4LuCeeSncMwPcdEzVNwQaAZ6eIKyDx6rWBLEZ4ldhsE1YSvaUedK9LLuV
 4PAwijYJmuDZQ==
X-Pm-Submission-Id: 4hTpnN1fTNz2Sd57
From: Esben Haabendal <esben@geanix.com>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>,  "Neil Armstrong"
 <neil.armstrong@linaro.org>,  "Robert Foss" <rfoss@kernel.org>,  "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>,  "Jonas Karlman"
 <jonas@kwiboo.se>,  "Jernej Skrabec" <jernej.skrabec@gmail.com>,  "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,  "Maxime Ripard"
 <mripard@kernel.org>,  "Thomas Zimmermann" <tzimmermann@suse.de>,  "David
 Airlie" <airlied@gmail.com>,  "Simona Vetter" <simona@ffwll.ch>,
 "Matthias Brugger" <matthias.bgg@gmail.com>,  "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>,  "Hui Pu"
 <Hui.Pu@gehealthcare.com>,  "Ian Ray" <ian.ray@gehealthcare.com>,  "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>,
 <dri-devel@lists.freedesktop.org>,  <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>,  "Marek Vasut" <marex@denx.de>,
 "Sudarshan Shetty" <tessolveupstream@gmail.com>,  "Alexander Stein"
 <alexander.stein@ew.tq-group.com>,  "Herve Codina"
 <herve.codina@bootlin.com>
Subject: Re: [PATCH v2 05/12] drm/bridge: ti-sn65dsi83: select DRM_PANEL_BRIDGE
In-Reply-To: <20260825-drm-bridge-drm_panel-cleanup-v2-5-c6c88ba7ffd2@bootlin.com>
 (Luca Ceresoli's message of "Tue, 25 Aug 2026 12:09:38 +0200")
References: <20260825-drm-bridge-drm_panel-cleanup-v2-0-c6c88ba7ffd2@bootlin.com>
 <COq_BAI4NWaVy-NBuHWUwkkIB1rDDvgFsm6RbFinywA20vsnC6ObH70xZON16F61KkbCk1EW9KyxxQKO5A_LxQ==@protonmail.internalid>
 <20260825-drm-bridge-drm_panel-cleanup-v2-5-c6c88ba7ffd2@bootlin.com>
Date: Tue, 25 Aug 2026 15:40:23 +0200
Message-ID: <87tsoimi7s.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

"Luca Ceresoli" <luca.ceresoli@bootlin.com> writes:

> This driver uses the drm_panel_bridge API and not the drm_panel API so it
> should select DRM_PANEL_BRIDGE and not DRM_PANEL.
>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Sudarshan Shetty <tessolveupstream@gmail.com>
> Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
> Cc: Herve Codina <herve.codina@bootlin.com>
> Cc: Esben Haabendal <esben@geanix.com>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index d46aa2eb01b5..03f52dcbba6f 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -461,7 +461,7 @@ config DRM_TI_SN65DSI83
>  	depends on OF
>  	select DRM_KMS_HELPER
>  	select REGMAP_I2C
> -	select DRM_PANEL
> +	select DRM_PANEL_BRIDGE
>  	select DRM_MIPI_DSI
>  	help
>  	  Texas Instruments SN65DSI83 and SN65DSI84 DSI to LVDS Bridge driver
>
> --
> 2.55.0

Acked-by: Esben Haabendal <esben@geanix.com>
