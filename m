Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B86FF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 11:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEE8810EB31;
	Tue, 28 Apr 2026 11:43:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="TMxJ+KoQ";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E37A10EB2B
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777376580; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=M8SJNFjjWP9OohOj1L5U/Ak4kn2dAl7BnntUyIPQVcXSiq6dh5PrXHs+IznEQBpu1qnhgNWmqYC6bTb+/MFQbrtMQDXcLjUljR1Ip5c2ZnYv0fnNruJx6Av7QOwRmA8Kpy7VzqeeF3tT7CyNQ1DN/5wKi5RVbQg91U3PgYUmI/Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777376580;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=TlhFPL8ND+WbfcUGfTmCK2EdpsIx2XJ/qy/5oRg5djc=; 
 b=Ou58zUfUJJJjh8pKc3x942+vgKqV9Y0h5klakiHiZz6f/3GSRy5N2gy7fw13Bw2aVoNkUaLU61x6rB445r3Pr8O3fQQbDWgVe+tlD8p0T2SnHTx0kXxsOV6QQoINkipA6bM73wB4V8c1CdnnTRnBCWBUn/gkeZdjWfKNL4Tui5Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777376580; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=TlhFPL8ND+WbfcUGfTmCK2EdpsIx2XJ/qy/5oRg5djc=;
 b=TMxJ+KoQESywS2WFOZsDEHeSkQX7kq79HVwVINdBJMYJf54FxAXsa39Wzqi+K6n5
 3W6MuK2HoCJybpJhJkYCIaH57WMAm3v66lq4RGf7x8lcRGc/++5l0NNfOZEs+GXuJtr
 2SVYdt5ecKKV2ccBqWMLNtOXM9tn+SnEKgNtgA/E=
Received: by mx.zohomail.com with SMTPS id 1777376578422414.75549572481907;
 Tue, 28 Apr 2026 04:42:58 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Cc: Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v3 11/13] drm: bridge: dw_hdmi: Extract
 dw_hdmi_connector_status_update()
Date: Tue, 28 Apr 2026 13:42:52 +0200
Message-ID: <MCyx2kr8R1WgP_qCLhpKuA@collabora.com>
In-Reply-To: <20260403185303.80748-12-jonas@kwiboo.se>
References: <20260403185303.80748-1-jonas@kwiboo.se>
 <20260403185303.80748-12-jonas@kwiboo.se>
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

On Friday, 3 April 2026 20:52:57 Central European Summer Time Jonas Karlman wrote:
> Move connector EDID update and CEC phys addr handling to a helper
> function as a preparation before moving EDID refresh from get_modes
> funcs to detect/force funcs.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v3: New patch
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 30 +++++++++++++----------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 4a0498922476..0d42fdf9a386 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2467,6 +2467,21 @@ static const struct drm_edid *dw_hdmi_edid_read(struct dw_hdmi *hdmi,
>   * DRM Connector Operations
>   */
>  
> +static void
> +dw_hdmi_connector_status_update(struct drm_connector *connector,
> +				enum drm_connector_status status)
> +{
> +	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi, connector);
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
> @@ -2484,20 +2499,9 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
>  
>  static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
>  {
> -	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
> -					     connector);
> -	const struct drm_edid *drm_edid;
> -	int ret;
> +	dw_hdmi_connector_status_update(connector, connector->status);
>  
> -	drm_edid = dw_hdmi_edid_read(hdmi, connector);
> -
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
> 

Reviewed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>



