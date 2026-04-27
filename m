Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98511FF8868
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 18:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03CF710E8C5;
	Mon, 27 Apr 2026 18:28:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="IdCG6f3E";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F86E10E8C5
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 18:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777314485; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FrmMSc0fozgscWvKszWOcrRi2fXjPcWvSQZt4y7Bc/1iiiwYjUx2j8hvm9g5fPGr0vD4al/H4EsFP0NQYbi7TpCP9P0ZuKVeqydw+iT5LlfhJlZznVQC4mF72Bz2qcK88++aUsPHAU7eW4+ij9XL9JP3JQr5sbghi+9Y/UJOAAc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777314485;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=MgfLegG7FRAKWEkqVXfJrJQZt2+npwuUV6ms8XivFhk=; 
 b=g5xRx1/U05V4VRYBIMEvE42JbEUc2r2ZwQdaSB0nExyXP1ARy9VBRzBeaOlatQ1PRe6qIImlaOl24JmSGAZ9PhU5Syi7Iw68zrK6VvvFqbhSb9x5u0grogNAKX6qNuyBzEAZCY7huQiu3pjc2nG9d9voTG7H7SOGXKlzRwpug7Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777314485; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=MgfLegG7FRAKWEkqVXfJrJQZt2+npwuUV6ms8XivFhk=;
 b=IdCG6f3EbHuV+iYNYyp2jCDP0SQsdYmPFzg3SDWWFAtedeDdIksPpGmoaXazjA7j
 fAK/vqLLTBEx7yeEK5/+N5+bUYBJjf7LsUjGmAJkZNg15AaL+WnBW7FR04gjBfPKtP7
 CkzblIk/rdHw2FgRt5AlZ1hj3coESB3Cpr4sejBs=
Received: by mx.zohomail.com with SMTPS id 1777314483711367.61612657326896;
 Mon, 27 Apr 2026 11:28:03 -0700 (PDT)
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
Subject: Re: [PATCH v3 09/13] drm: bridge: dw_hdmi: Use delayed_work to
 debounce hotplug event
Date: Mon, 27 Apr 2026 20:27:58 +0200
Message-ID: <y1d99UBuRDyCACvs45dokA@collabora.com>
In-Reply-To: <20260403185303.80748-10-jonas@kwiboo.se>
References: <20260403185303.80748-1-jonas@kwiboo.se>
 <20260403185303.80748-10-jonas@kwiboo.se>
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

On Friday, 3 April 2026 20:52:55 Central European Summer Time Jonas Karlman wrote:
> HDMI Specification Version 1.4b chapter 8.5 mentions:
> 
>   An HDMI Sink shall not assert high voltage level on its Hot Plug
>   Detect pin when the E-EDID is not available for reading.
> 
>   A Source may use a high voltage level Hot Plug Detect signal to
>   initiate the reading of E-EDID data.
> 
>   An HDMI Sink shall indicate any change to the contents of the E-EDID
>   by driving a low voltage level pulse on the Hot Plug Detect pin. This
>   pulse shall be at least 100 msec.
> 
> Use a work queue to debounce reacting on HPD events to better handle a
> HPD low voltage level pulse when a sink changes the EDID.
> 
> The 1100 msec hotplug debounce timeout was arbitrarily picked to match
> other drivers using same const, and testing using a Raspberry Pi Monitor
> seem to use a 200-300 msec pulse when going from standby to power on
> state.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v3: New patch
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 24 +++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index f3f8144ae98e..4d079b689b3b 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -51,6 +51,8 @@
>  
>  #define HDMI14_MAX_TMDSCLK	340000000
>  
> +#define HOTPLUG_DEBOUNCE_MS	1100
> +
>  static const u16 csc_coeff_default[3][4] = {
>  	{ 0x2000, 0x0000, 0x0000, 0x0000 },
>  	{ 0x0000, 0x2000, 0x0000, 0x0000 },
> @@ -192,6 +194,7 @@ struct dw_hdmi {
>  	hdmi_codec_plugged_cb plugged_cb;
>  	struct device *codec_dev;
>  	enum drm_connector_status last_connector_result;
> +	struct delayed_work hpd_work;
>  };
>  
>  const struct dw_hdmi_plat_data *dw_hdmi_to_plat_data(struct dw_hdmi *hdmi)
> @@ -2528,6 +2531,7 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
>  
>  	mutex_lock(&hdmi->mutex);
>  	hdmi->force = connector->force;
> +	hdmi->last_connector_result = connector->status;
>  	dw_hdmi_update_phy_mask(hdmi);
>  	mutex_unlock(&hdmi->mutex);
>  }
> @@ -3046,6 +3050,16 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense)
>  }
>  EXPORT_SYMBOL_GPL(dw_hdmi_setup_rx_sense);
>  
> +static void dw_hdmi_hpd_work(struct work_struct *work)
> +{
> +	struct dw_hdmi *hdmi = container_of(work, struct dw_hdmi, hpd_work.work);
> +
> +	if (hdmi->bridge.dev) {
> +		drm_helper_hpd_irq_event(hdmi->bridge.dev);
> +		drm_bridge_hpd_notify(&hdmi->bridge, hdmi->last_connector_result);

I think you'll want to `mutex_lock(&hdmi->mutex);` (or better yet,
`guard(mutex)(&hdmi->mutex)` or `scoped_guard(mutex, &hdmi->mutex) {`)
here before reading last_connector_result, otherwise you'll have a
data race with any writers.

> +	}
> +}
> +
>  static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>  {
>  	struct dw_hdmi *hdmi = dev_id;
> @@ -3097,10 +3111,8 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>  			status == connector_status_connected ?
>  			"plugin" : "plugout");
>  
> -		if (hdmi->bridge.dev) {
> -			drm_helper_hpd_irq_event(hdmi->bridge.dev);
> -			drm_bridge_hpd_notify(&hdmi->bridge, status);
> -		}
> +		mod_delayed_work(system_percpu_wq, &hdmi->hpd_work,
> +				 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
>  	}
>  
>  	hdmi_writeb(hdmi, intr_stat, HDMI_IH_PHY_STAT0);
> @@ -3420,6 +3432,8 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
>  		goto err_res;
>  	}
>  
> +	INIT_DELAYED_WORK(&hdmi->hpd_work, dw_hdmi_hpd_work);
> +
>  	ret = devm_request_threaded_irq(dev, irq, dw_hdmi_hardirq,
>  					dw_hdmi_irq, IRQF_SHARED,
>  					dev_name(dev), hdmi);
> @@ -3552,6 +3566,8 @@ EXPORT_SYMBOL_GPL(dw_hdmi_probe);
>  
>  void dw_hdmi_remove(struct dw_hdmi *hdmi)
>  {
> +	disable_delayed_work_sync(&hdmi->hpd_work);
> +
>  	drm_bridge_remove(&hdmi->bridge);
>  
>  	if (hdmi->audio && !IS_ERR(hdmi->audio))
> 

Kind regards,
Nicolas Frattaroli


