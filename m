Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19353FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 12:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8402910EB38;
	Tue, 28 Apr 2026 12:01:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="WPsKUJoG";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FF2F10EB38
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:01:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777377671; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CN4pxCtUUVGpTfrzUDyJfbTLH4s8/tpFuMLAxW8G90Wa9CZt0Z4QJarN5kZAUtfgFhExqDviwO7AefyfP+Wxg4/RISE6YRJwfkIetoEXmj8+uY1j01ZUAx2MBjjckQQp5aDrUUuwGlaCc9LTtZ/eKNAjgHXyaH0/OFSbICVG9ik=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777377671;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=FTa+bhOIUZ9NLGbouoiVpcviMKYULGVEyu46vzCX0ak=; 
 b=NWs5aH3ZUCFF2t+3OXfazE2xh6dMHZ3djVICxNGGtccm8x5S/7d66LlRqewdbWJYJEWW7mKUV7IfPRR0lJUq8oqNavVUaNy4ft9cs6HBD63SdIhX550YT9gPPLjce2zZluwbBZs2gwWlh7Usd3wlDOSKj+BTD6cYudWfvlbm0tY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777377670; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=FTa+bhOIUZ9NLGbouoiVpcviMKYULGVEyu46vzCX0ak=;
 b=WPsKUJoGUMpM+Fjl9IrkluTAyBvZNlP9yYPJRZw00szYb3NhAr3JxLDuGyW+9iFF
 FXsOLETMPYSLdLoPszTsv/0rvs9+Jn/70TUAle8ytzS9D0sqb1wuTcIJ3uWgCuHJT8Q
 t1M72HbXSZfj9HYYJaNTl2AhZ9dVPci1MIlgoujo=
Received: by mx.zohomail.com with SMTPS id 1777377670034753.6935464985934;
 Tue, 28 Apr 2026 05:01:10 -0700 (PDT)
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
Subject: Re: [PATCH v3 13/13] drm: bridge: dw_hdmi: Use display_info is_hdmi
 and has_audio
Date: Tue, 28 Apr 2026 14:01:04 +0200
Message-ID: <Ett9239dT8CYvJWa5dmvqA@collabora.com>
In-Reply-To: <20260403185303.80748-14-jonas@kwiboo.se>
References: <20260403185303.80748-1-jonas@kwiboo.se>
 <20260403185303.80748-14-jonas@kwiboo.se>
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

On Friday, 3 April 2026 20:52:59 Central European Summer Time Jonas Karlman wrote:
> drm_edid_connector_update() is being called from bridge connector funcs
> and from detect and force funcs for dw-hdmi connector.
> 
> Change to use is_hdmi and has_audio from display_info directly instead
> of keeping our own state in sink_is_hdmi and sink_has_audio.
> 
> Also remove the old and unused edid struct member and related define.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v3: No change
> v2: Collect r-b tag
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 32 ++++-------------------
>  1 file changed, 5 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 5b5654ef6015..fecbc386871d 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -44,8 +44,6 @@
>  #define DDC_CI_ADDR		0x37
>  #define DDC_SEGMENT_ADDR	0x30
>  
> -#define HDMI_EDID_LEN		512
> -
>  /* DW-HDMI Controller >= 0x200a are at least compliant with SCDC version 1 */
>  #define SCDC_MIN_SOURCE_VERSION	0x1
>  
> @@ -147,8 +145,6 @@ struct dw_hdmi {
>  
>  	int vic;
>  
> -	u8 edid[HDMI_EDID_LEN];
> -
>  	struct {
>  		const struct dw_hdmi_phy_ops *ops;
>  		const char *name;
> @@ -158,8 +154,6 @@ struct dw_hdmi {
>  
>  	struct i2c_adapter *ddc;
>  	void __iomem *regs;
> -	bool sink_is_hdmi;
> -	bool sink_has_audio;
>  
>  	struct pinctrl *pinctrl;
>  	struct pinctrl_state *default_state;
> @@ -2057,7 +2051,7 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>  		HDMI_FC_INVIDCONF_IN_I_P_INTERLACED :
>  		HDMI_FC_INVIDCONF_IN_I_P_PROGRESSIVE;
>  
> -	inv_val |= hdmi->sink_is_hdmi ?
> +	inv_val |= display->is_hdmi ?
>  		HDMI_FC_INVIDCONF_DVI_MODEZ_HDMI_MODE :
>  		HDMI_FC_INVIDCONF_DVI_MODEZ_DVI_MODE;
>  
> @@ -2293,7 +2287,7 @@ static int dw_hdmi_poweron(struct dw_hdmi *hdmi,
>  	if (hdmi->hdmi_data.enc_out_bus_format == MEDIA_BUS_FMT_FIXED)
>  		hdmi->hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
>  
> -	hdmi->hdmi_data.rgb_limited_range = hdmi->sink_is_hdmi &&
> +	hdmi->hdmi_data.rgb_limited_range = display->is_hdmi &&
>  		drm_default_rgb_quant_range(mode) ==
>  		HDMI_QUANTIZATION_RANGE_LIMITED;
>  
> @@ -2313,7 +2307,7 @@ static int dw_hdmi_poweron(struct dw_hdmi *hdmi,
>  	/* HDMI Initialization Step B.3 */
>  	dw_hdmi_enable_video_path(hdmi);
>  
> -	if (hdmi->sink_has_audio) {
> +	if (display->has_audio) {
>  		dev_dbg(hdmi->dev, "sink has audio support\n");
>  
>  		/* HDMI Initialization Step E - Configure audio */
> @@ -2322,7 +2316,7 @@ static int dw_hdmi_poweron(struct dw_hdmi *hdmi,
>  	}
>  
>  	/* not for DVI mode */
> -	if (hdmi->sink_is_hdmi) {
> +	if (display->is_hdmi) {
>  		dev_dbg(hdmi->dev, "%s HDMI mode\n", __func__);
>  
>  		/* HDMI Initialization Step F - Configure AVI InfoFrame */
> @@ -2436,29 +2430,13 @@ static const struct drm_edid *dw_hdmi_edid_read(struct dw_hdmi *hdmi,
>  						struct drm_connector *connector)
>  {
>  	const struct drm_edid *drm_edid;
> -	const struct edid *edid;
>  
>  	if (!hdmi->ddc)
>  		return NULL;
>  
>  	drm_edid = drm_edid_read_ddc(connector, hdmi->ddc);
> -	if (!drm_edid) {
> +	if (!drm_edid)
>  		dev_dbg(hdmi->dev, "failed to get edid\n");
> -		return NULL;
> -	}
> -
> -	/*
> -	 * FIXME: This should use connector->display_info.is_hdmi and
> -	 * connector->display_info.has_audio from a path that has read the EDID
> -	 * and called drm_edid_connector_update().
> -	 */
> -	edid = drm_edid_raw(drm_edid);
> -
> -	dev_dbg(hdmi->dev, "got edid: width[%d] x height[%d]\n",
> -		edid->width_cm, edid->height_cm);
> -
> -	hdmi->sink_is_hdmi = drm_detect_hdmi_monitor(edid);
> -	hdmi->sink_has_audio = drm_detect_monitor_audio(edid);
>  
>  	return drm_edid;
>  }
> 

Reviewed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>



