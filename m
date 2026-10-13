Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3B3CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85BB910F7C5;
	Tue, 13 Oct 2026 12:10:59 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC5210E7CA
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 12:10:53 +0000 (UTC)
Received: from killaraus.ideasonboard.com (unknown [185.104.138.147])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6EE021E4;
 Tue, 13 Oct 2026 14:08:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1791893330;
 bh=a1p10/uR/IHwvnBKDLlNO5lRIxzSDvGbG4EgaUu7ilY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SlsOlOku9VLZ/0sgrm4xw6YwzJnWIC1tdmjT+W4c4tEtQpwzTg9sS1/y++iH0MD4r
 O7MnJ3jFQW3ohf8YIGdcPZ2qasPErcWoD0D0dWZu+K3hCLh4kOJPSXIrERI3f7Ckf4
 TxKYV9avp0AT/b3d1hPo2mY5oic2FQWPDaY6efKo=
Date: Tue, 13 Oct 2026 14:10:40 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Hui Pu <Hui.Pu@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/bridge: stop mentioning deprecated
 devm_drm_of_get_bridge() in docs
Message-ID: <20261013121040.GK56180@killaraus.ideasonboard.com>
References: <20261012-drm-bridge-every-panel-cleanups-v1-0-0fd272f486b6@bootlin.com>
 <20261012-drm-bridge-every-panel-cleanups-v1-1-0fd272f486b6@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261012-drm-bridge-every-panel-cleanups-v1-1-0fd272f486b6@bootlin.com>
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

On Mon, Oct 12, 2026 at 04:29:51PM +0200, Luca Ceresoli wrote:
> devm_drm_of_get_bridge() is deprecated. Update the "display driver
> integration" docs by mentioning the currently recommended API.
> 
> Link: https://lore.kernel.org/all/c1b065c8bd926708500b7c42864279e055ed95d0.camel@iscas.ac.cn/
> Suggested-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/drm_bridge.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index e7f9e6d58927..e259d078f7de 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -68,8 +68,9 @@
>   *
>   * Display drivers are responsible for linking encoders with the first bridge
>   * in the chains. This is done by acquiring the appropriate bridge with
> - * devm_drm_of_get_bridge(). Once acquired, the bridge shall be attached to the
> - * encoder with a call to drm_bridge_attach().
> + * of_drm_get_bridge_by_endpoint() or of_drm_find_and_get_bridge(). Once
> + * acquired, the bridge shall be attached to the encoder with a call to
> + * drm_bridge_attach().
>   *
>   * Bridges are responsible for linking themselves with the next bridge in the
>   * chain, if any. This is done the same way as for encoders, with the call to

-- 
Regards,

Laurent Pinchart
