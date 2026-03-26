Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1961610AB81D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 20:24:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DF9B10E1EC;
	Thu, 26 Mar 2026 20:24:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="mNeN+YLD";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E352D10E1EC
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 20:24:14 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id ECF6EC59;
 Thu, 26 Mar 2026 21:22:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774556572;
 bh=NVhX/uMxZkpkB/iqDu5JZGx9lhZ9UdPlPo1XBRq95bg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mNeN+YLDfw3MuX2TA+viY+TKCOWX3G9bMqKE64cCBilShGkf6X2SAvRqbSZ2O4tRD
 q5UjEYFaWlqDio3pkykZVhoVjQbxTeo3RWBFlcO4jIRyCOK/tMt15o9jTEoHODLBCw
 6gTsI4IWQgepC2mxAcjm/5zuryn6gDno7q/hl6uY=
Date: Thu, 26 Mar 2026 22:24:09 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Amin GATTOUT <amin.gattout@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rcar-du: Convert to of_drm_find_and_get_bridge()
Message-ID: <20260326202409.GE2770072@killaraus.ideasonboard.com>
References: <20260326-bridge-v1-1-c0c44b53f7b6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260326-bridge-v1-1-c0c44b53f7b6@gmail.com>
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

Hello Amin,

On Thu, Mar 26, 2026 at 09:10:15PM +0100, Amin GATTOUT wrote:
> of_drm_find_bridge() is deprecated.
> Replace it with of_drm_find_and_get_bridge() which increments
> the bridge refcount as required.
> 
> Signed-off-by: Amin GATTOUT <amin.gattout@gmail.com>
> ---
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
> index 7ecec7b04a8d..42253c1251b5 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
> @@ -72,7 +72,7 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
>  		if (IS_ERR(bridge))
>  			return PTR_ERR(bridge);
>  	} else {
> -		bridge = of_drm_find_bridge(enc_node);
> +		bridge = of_drm_find_and_get_bridge(enc_node);

How did you test this ?

>  		if (!bridge)
>  			return -EPROBE_DEFER;
>  
> 
> ---
> base-commit: d813f421930c5b01b9f61043932de02602dd6ae3
> change-id: 20260326-bridge-43ecbef9d39f

-- 
Regards,

Laurent Pinchart
