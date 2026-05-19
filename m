Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3D0CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 06:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA82E10EA77;
	Tue, 19 May 2026 06:25:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jo9E0rC6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EBA910EA77
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 06:25:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 677F2601FD;
 Tue, 19 May 2026 06:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906AEC2BCF6;
 Tue, 19 May 2026 06:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779171914;
 bh=MpgzPBqE/fWyBM0VdbQHNzKaNFoOyD/JuCeyGfbplSs=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=jo9E0rC68t/vIL+8vT1U3oPlIMgYNtoE9ZXok8N9x6ULV/N8mqfPdAyrI1tQRnzQ4
 b6QTyyd+G3c/kCJsgwdMx3M3d8HKPSkkH8hmd8EVqnNoIm82itL7fLwFpAjTZs2NKI
 oP6dVzJRWYA4pTC1US5z6FoZgtHmFCvoJcG1iQ9dFyImwn6Jsp547vwZEkqH+lOrUF
 9YdQgczrAATdePQFoJZud3qudrVVW1A6x4Me4zNLcZscep3QjS9UFEjYDKuS/Yd16y
 szYTcOAY6zjO62mRMRlVNgTxWvs5+GY6+blpY87MbZiB5sgBbeWR76O0RsXqC7klT+
 lzTnBLfMrCnlg==
Message-ID: <cdd3d7ba-fa73-41d0-be1b-76f1fccad1dc@kernel.org>
Date: Tue, 19 May 2026 08:25:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v7 10/23] drm: bridge: dw_hdmi: Invalidate CEC phys addr
 from connector detect
To: Jonas Karlman <jonas@kwiboo.se>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Liu Ying <victor.liu@nxp.com>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@kernel.org>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-sunxi@lists.linux.dev, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260518180206.2480119-1-jonas@kwiboo.se>
 <20260518180206.2480119-11-jonas@kwiboo.se>
Content-Language: en-US, nl
In-Reply-To: <20260518180206.2480119-11-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 18/05/2026 20:01, Jonas Karlman wrote:
> Wait until the connector detect ops is called to invalidate CEC phys
> addr instead of doing it directly from the irq handler.
> 
> The CEC notifier is only registered for the dw-hdmi connector so this
> has no impact when the bridge connector is used.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # Rock64, RockPro64, Quartz64-B
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>

Regards,

	Hans

> ---
> v7: Update commit message
> v6: Collect t-b tag
> v5: No change
> v4: No change
> v3: No change
> v2: Collect r-b tag
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 5fd26ff8f55b..aae1b890167b 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2472,7 +2472,17 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
>  {
>  	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
>  					     connector);
> -	return dw_hdmi_detect(hdmi);
> +	enum drm_connector_status status;
> +
> +	status = dw_hdmi_detect(hdmi);
> +
> +	if (status == connector_status_disconnected) {
> +		mutex_lock(&hdmi->cec_notifier_mutex);
> +		cec_notifier_phys_addr_invalidate(hdmi->cec_notifier);
> +		mutex_unlock(&hdmi->cec_notifier_mutex);
> +	}
> +
> +	return status;
>  }
>  
>  static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
> @@ -3106,12 +3116,6 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>  				       phy_stat & HDMI_PHY_HPD,
>  				       phy_stat & HDMI_PHY_RX_SENSE);
>  
> -		if ((phy_stat & (HDMI_PHY_RX_SENSE | HDMI_PHY_HPD)) == 0) {
> -			mutex_lock(&hdmi->cec_notifier_mutex);
> -			cec_notifier_phys_addr_invalidate(hdmi->cec_notifier);
> -			mutex_unlock(&hdmi->cec_notifier_mutex);
> -		}
> -
>  		if ((intr_stat & HDMI_IH_PHY_STAT0_HPD) &&
>  		    (phy_stat & HDMI_PHY_HPD))
>  			status = connector_status_connected;

