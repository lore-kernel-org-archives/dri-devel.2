Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D30CD4F58
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 06:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F0310EA9B;
	Tue, 19 May 2026 06:26:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RMYwvy8s";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68D3210EA9A
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 06:26:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F4D9419B3;
 Tue, 19 May 2026 06:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B113EC2BCB3;
 Tue, 19 May 2026 06:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779171995;
 bh=yJz6kF6yktan0ZdR7DH+L3nJHkS+Y3Esdo9Gtwg26cs=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=RMYwvy8swROQke8N0e2TqBc8zOrlDQamtQotEeY22Yxc/3y01vQGPf/8K1sRcQ1O9
 zCXlNCRrIFhHtpkoIqGbK3rFW+2+i4DgJrTFPz/XO4x3vydkAIdE2r8Bw/gsynHxIF
 YwFVxFW+ihtt16oIxRWxKz3EYin8UM9HjgojFrrHN141ADIDksoyiLOhKDfviuAvg3
 dk5X8uP6OLohZAOUKx1nwUn9k/ONp80UEeC8cC0Qaj2zi8XzqfkPPFUxfgBTaqzZF2
 2TecOurQSqX8f6CWSLUshdHyN4esSuCMtzKu33JVQ7be92+Lx1C7JgamB+j7eDA+U3
 C+eJab4uVXeuw==
Message-ID: <758d577f-cd03-4c41-a9f6-9d8ef909fd9a@kernel.org>
Date: Tue, 19 May 2026 08:26:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v7 12/23] drm: bridge: dw_hdmi: Extract
 dw_hdmi_connector_status_update()
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
 <20260518180206.2480119-13-jonas@kwiboo.se>
Content-Language: en-US, nl
In-Reply-To: <20260518180206.2480119-13-jonas@kwiboo.se>
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
> Move connector EDID update and CEC phys addr handling to a helper
> function as a preparation before moving EDID refresh from get_modes
> funcs to detect/force funcs.
> 
> Reviewed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # Rock64, RockPro64, Quartz64-B
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>

Regards,

	Hans

> ---
> v7: No change
> v6: Pass struct dw_hdmi as a parameter, to allow calls from bridge funcs,
>     Collect t-b tag
> v5: No change
> v4: Collect r-b tag
> v3: New patch
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 27 ++++++++++++++---------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 0dd4c823c60a..a056e147731b 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2466,6 +2466,21 @@ static const struct drm_edid *dw_hdmi_edid_read(struct dw_hdmi *hdmi,
>   * DRM Connector Operations
>   */
>  
> +static void
> +dw_hdmi_connector_status_update(struct dw_hdmi *hdmi,
> +				struct drm_connector *connector,
> +				enum drm_connector_status status)
> +{
> +	const struct drm_edid *drm_edid;
> +
> +	drm_edid = dw_hdmi_edid_read(hdmi, connector);
> +	drm_edid_connector_update(connector, drm_edid);
> +	drm_edid_free(drm_edid);
> +
> +	cec_notifier_set_phys_addr(hdmi->cec_notifier,
> +				   connector->display_info.source_physical_address);
> +}
> +
>  static enum drm_connector_status
>  dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
>  {
> @@ -2485,18 +2500,10 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
>  {
>  	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
>  					     connector);
> -	const struct drm_edid *drm_edid;
> -	int ret;
>  
> -	drm_edid = dw_hdmi_edid_read(hdmi, connector);
> +	dw_hdmi_connector_status_update(hdmi, connector, connector->status);
>  
> -	drm_edid_connector_update(connector, drm_edid);
> -	cec_notifier_set_phys_addr(hdmi->cec_notifier,
> -				   connector->display_info.source_physical_address);
> -	ret = drm_edid_connector_add_modes(connector);
> -	drm_edid_free(drm_edid);
> -
> -	return ret;
> +	return drm_edid_connector_add_modes(connector);
>  }
>  
>  static int dw_hdmi_connector_atomic_check(struct drm_connector *connector,

