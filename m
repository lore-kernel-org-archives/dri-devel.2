Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2082CCD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 10:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82E2010EFCE;
	Wed, 20 May 2026 09:59:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fiYBW3eL";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6631110EFCE
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:59:57 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-45e8a834cc2so1451248f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 02:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779271196; x=1779875996; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Ftqjr2c9P2PPCEd88S/Oil8e3fYUvE62NodfKYwliwA=;
 b=fiYBW3eLudneY11uhFT9m6FJ4/GVMkPiRP5NKQP0EuPxn1vFD3NJuMIghslmV7EkU/
 /NkU2d8ni1Uf59ZrNo2HHzXshRsyb//rOCiCW0ly1PCraZhBA30gKkFLezmdggF63yEk
 WB/f5BtF+dkgWoHasQbWqk96LApHf7yoZ2DODCSre3ZhHMIuxtYqe3B6OwDcSTfAGsCR
 vbDHDodTqhVET3QtRvZfrDcgEM2Pi9HQUHYp5FnKC09RKvBZHJnvTBu+OOwbQdqPadFc
 eZUkkch4YPC5wyyb55LWbsGhoqfNQ4WEwZUEOJrZytRviuK13rURQIxPgDhLGgQJKnbC
 Komw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779271196; x=1779875996;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ftqjr2c9P2PPCEd88S/Oil8e3fYUvE62NodfKYwliwA=;
 b=gsu3pgSGUmgl72LPnpJSx4rzsQu8zAB+IuZLKRxH2o+QlHTgOCSalShUTIwEFXu3O9
 Vk+aHIsxeAthf2KPsIYnDvCI9B3M4KMBBXsiE6gAitHyP0iOElnS96Nqo59J3G8ChvHp
 4GLA/SNqLirwWQG3+deG0lhVjCzq7F7VtFyoMWV5Faux6MH/kP7bbreQtqlDiU2+9cvM
 LA9/FKzZdxaTb60CTErSk1jmhjAYlYVLOLFEgqmM1JWaEOr42FKTkoVzLc/LiRDpdlGA
 DaotkekrfQG4rh6pjX/diXn9hbM6lr5wXc1svUHqtJ0xE6hKyurvQZfR0cVwVskrETuV
 hWHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8C5+hY3UMk+z3SnavJdLUjO4e/7J8OTmtyKQtZ7FNf6n44r3bDqys2ZsKEh0mFCmyxGUj6w1J11Ew=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUW3IVtWc8327rJVp07rW1+yJkwlveXFN4nYx+Z1X1pT8+nS30
 02rFT3kZwSz3dV3CpfdKJ1Dj/lxAvji7z10P3lJDO4+tHcCCfNI9Dpv2uc62WtmhJfI=
X-Gm-Gg: Acq92OHszKV9iL11XprOvRseKX5nFl9JLgdHsemQxQpeoeYKAzCVeCrK2nNP3VSP3G7
 6AzYUo5CiWdBbZp2xgO/RqB1d7DkW/PgSzbYC+ypQiIfsMl5C9mVRXW8UD7kq+twfTcLdOBf1B1
 0/JRsPiCKkE+cHZJApxpsNKB/gYRJ6QZlYhukxJU4heHFxqHJUzHLBdWB1xZa1mtNBdC4gAVgDx
 ygXRlpKIhzN1L0PQy7njo8cTRiG9ZSP4JG2NonrEmIy8X9260ff7rtGLh7xtV8CL/RgHxWhQifh
 l1a9mcfWKvTeguGnREihLL7qisiern2vyRPYvCRlpbQ8Mz9S3omqtGegerjmuWLgvDEmf9AcTg4
 2w3XQ9oX9S7XupTKBQ/7GMWkGH8jWPNOo38r75JnHm8uRjQ5ymNZjGTtT7l/pNvBCK9d9uAPkXC
 6RdnWsGulqVLnQAuX6VF5NYZgagAaME6IFdD+RgMxFbwA0tPgkLDJzR/X9ylVFJtMOWxWLu+U/k
 wqc
X-Received: by 2002:a05:600c:698d:b0:48f:e230:2a1c with SMTP id
 5b1f17b1804b1-48fe6631158mr379762695e9.31.1779271195765; 
 Wed, 20 May 2026 02:59:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:5dda:3751:f88e:6ff?
 ([2a01:e0a:106d:1080:5dda:3751:f88e:6ff])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe537ccf5sm378154185e9.14.2026.05.20.02.59.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 02:59:55 -0700 (PDT)
Message-ID: <24594ab4-6865-48b7-9e92-ae6a744c8d58@linaro.org>
Date: Wed, 20 May 2026 11:59:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v7 20/23] drm: bridge: dw_hdmi: Rework HDP and RXSENSE
 interrupt handling
To: Jonas Karlman <jonas@kwiboo.se>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Robert Foss <rfoss@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
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
 <20260518180206.2480119-21-jonas@kwiboo.se>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260518180206.2480119-21-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 5/18/26 20:01, Jonas Karlman wrote:
> The commit aeac23bda87f ("drm: bridge/dw_hdmi: improve HDMI
> enable/disable handling") added use of PHY RXSENSE indications to avoid
> triggering a full enable/disable of the HDMI block when a sink use a HPD
> low voltage level pulse to indicate changes of the EDID.
> 
> HDMI Specification Version 1.4b chapter 8.5 mentions:
> 
>    An HDMI Sink shall indicate any change to the contents of the E-EDID
>    by driving a low voltage level pulse on the Hot Plug Detect pin. This
>    pulse shall be at least 100 msec.
> 
> A delayed work is now used to debounce reacting on a HPD low voltage
> level pulse when a sink changes the EDID. The delayed work triggers a
> hotplug uevent every time the connection status or EDID has changed.
> 
> Remove RXSENSE handling to simplify the HPD interrupt handling and
> instead depend on the delayed work to detect any connection status or
> EDID changes.
> 
> This also ensures the initial HPD interrupt polarity is based on current
> HPD status to avoid an unnecessary interrupt from being triggered
> immediately at probe or resume when a sink is connected.

I'm still puzzled of the removal of RX_SENSE entirely as v1, and I since the
rx_sense code is not easy to understand I don't have an opinion on that.

Can someone with more knowledge can comment on that ?

Neil

> 
> Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # Rock64, RockPro64, Quartz64-B
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v7: Remove clear of STAT0_RX_SENSE in dw_hdmi_remove() added in prior
>      patch
> v6: Update commit message,
>      Collect t-b tag
> v5: Add comment about interrupt generation
> v4: New patch
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 147 ++++------------------
>   1 file changed, 22 insertions(+), 125 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 270db58a0e7c..2e09bff5faf7 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -161,11 +161,7 @@ struct dw_hdmi {
>   	struct pinctrl_state *unwedge_state;
>   
>   	struct mutex mutex;		/* for state below */
> -	enum drm_connector_force force;	/* mutex-protected force state */
>   	struct drm_connector *curr_conn;/* current connector (only valid when !disabled) */
> -	bool disabled;			/* DRM has disabled our bridge */
> -	bool rxsense;			/* rxsense state */
> -	u8 phy_mask;			/* desired phy int mask settings */
>   	u8 mc_clkdis;			/* clock disable register */
>   
>   	spinlock_t audio_lock;
> @@ -196,14 +192,6 @@ const struct dw_hdmi_plat_data *dw_hdmi_to_plat_data(struct dw_hdmi *hdmi)
>   }
>   EXPORT_SYMBOL_GPL(dw_hdmi_to_plat_data);
>   
> -#define HDMI_IH_PHY_STAT0_RX_SENSE \
> -	(HDMI_IH_PHY_STAT0_RX_SENSE0 | HDMI_IH_PHY_STAT0_RX_SENSE1 | \
> -	 HDMI_IH_PHY_STAT0_RX_SENSE2 | HDMI_IH_PHY_STAT0_RX_SENSE3)
> -
> -#define HDMI_PHY_RX_SENSE \
> -	(HDMI_PHY_RX_SENSE0 | HDMI_PHY_RX_SENSE1 | \
> -	 HDMI_PHY_RX_SENSE2 | HDMI_PHY_RX_SENSE3)
> -
>   static inline void hdmi_writeb(struct dw_hdmi *hdmi, u8 val, int offset)
>   {
>   	regmap_write(hdmi->regm, offset << hdmi->reg_shift, val);
> @@ -1702,36 +1690,25 @@ EXPORT_SYMBOL_GPL(dw_hdmi_phy_read_hpd);
>   void dw_hdmi_phy_update_hpd(struct dw_hdmi *hdmi, void *data,
>   			    bool force, bool disabled, bool rxsense)
>   {
> -	u8 old_mask = hdmi->phy_mask;
> -
> -	if (force || disabled || !rxsense)
> -		hdmi->phy_mask |= HDMI_PHY_RX_SENSE;
> -	else
> -		hdmi->phy_mask &= ~HDMI_PHY_RX_SENSE;
> -
> -	if (old_mask != hdmi->phy_mask)
> -		hdmi_writeb(hdmi, hdmi->phy_mask, HDMI_PHY_MASK0);
>   }
>   EXPORT_SYMBOL_GPL(dw_hdmi_phy_update_hpd);
>   
>   void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, void *data)
>   {
>   	/*
> -	 * Configure the PHY RX SENSE and HPD interrupts polarities and clear
> -	 * any pending interrupt.
> +	 * Configure the PHY HPD interrupt polarity based on current HPD status
> +	 * and clear any pending interrupt.
>   	 */
> -	hdmi_writeb(hdmi, HDMI_PHY_HPD | HDMI_PHY_RX_SENSE, HDMI_PHY_POL0);
> -	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE,
> -		    HDMI_IH_PHY_STAT0);
> +	hdmi_modb(hdmi, hdmi_readb(hdmi, HDMI_PHY_STAT0) & HDMI_PHY_HPD ?
> +		  0 : HDMI_PHY_HPD, HDMI_PHY_HPD, HDMI_PHY_POL0);
> +	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD, HDMI_IH_PHY_STAT0);
>   
>   	/* Enable cable hot plug irq. */
> -	hdmi_writeb(hdmi, hdmi->phy_mask, HDMI_PHY_MASK0);
> +	hdmi_writeb(hdmi, ~HDMI_PHY_HPD, HDMI_PHY_MASK0);
>   
>   	/* Clear and unmute interrupts. */
> -	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE,
> -		    HDMI_IH_PHY_STAT0);
> -	hdmi_writeb(hdmi, ~(HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE),
> -		    HDMI_IH_MUTE_PHY_STAT0);
> +	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD, HDMI_IH_PHY_STAT0);
> +	hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_HPD, HDMI_IH_MUTE_PHY_STAT0);
>   }
>   EXPORT_SYMBOL_GPL(dw_hdmi_phy_setup_hpd);
>   
> @@ -2395,26 +2372,6 @@ static void dw_hdmi_poweroff(struct dw_hdmi *hdmi)
>   	}
>   }
>   
> -/*
> - * Adjust the detection of RXSENSE according to whether we have a forced
> - * connection mode enabled, or whether we have been disabled.  There is
> - * no point processing RXSENSE interrupts if we have a forced connection
> - * state, or DRM has us disabled.
> - *
> - * We also disable rxsense interrupts when we think we're disconnected
> - * to avoid floating TDMS signals giving false rxsense interrupts.
> - *
> - * Note: we still need to listen for HPD interrupts even when DRM has us
> - * disabled so that we can detect a connect event.
> - */
> -static void dw_hdmi_update_phy_mask(struct dw_hdmi *hdmi)
> -{
> -	if (hdmi->phy.ops->update_hpd)
> -		hdmi->phy.ops->update_hpd(hdmi, hdmi->phy.data,
> -					  hdmi->force, hdmi->disabled,
> -					  hdmi->rxsense);
> -}
> -
>   static enum drm_connector_status dw_hdmi_detect(struct dw_hdmi *hdmi)
>   {
>   	enum drm_connector_status result;
> @@ -2512,9 +2469,7 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
>   	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi, connector);
>   
>   	mutex_lock(&hdmi->mutex);
> -	hdmi->force = connector->force;
>   	hdmi->last_connector_result = connector->status;
> -	dw_hdmi_update_phy_mask(hdmi);
>   	mutex_unlock(&hdmi->mutex);
>   
>   	dw_hdmi_connector_status_update(hdmi, connector, connector->status);
> @@ -2932,10 +2887,8 @@ static void dw_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
>   	struct dw_hdmi *hdmi = bridge->driver_private;
>   
>   	mutex_lock(&hdmi->mutex);
> -	hdmi->disabled = true;
>   	hdmi->curr_conn = NULL;
>   	dw_hdmi_poweroff(hdmi);
> -	dw_hdmi_update_phy_mask(hdmi);
>   	handle_plugged_change(hdmi, false);
>   	mutex_unlock(&hdmi->mutex);
>   }
> @@ -2954,10 +2907,8 @@ static void dw_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
>   	mode = &drm_atomic_get_new_crtc_state(state, crtc)->adjusted_mode;
>   
>   	mutex_lock(&hdmi->mutex);
> -	hdmi->disabled = false;
>   	hdmi->curr_conn = connector;
>   	dw_hdmi_poweron(hdmi, connector, mode);
> -	dw_hdmi_update_phy_mask(hdmi);
>   	handle_plugged_change(hdmi, true);
>   	mutex_unlock(&hdmi->mutex);
>   }
> @@ -3060,78 +3011,29 @@ static irqreturn_t dw_hdmi_hardirq(int irq, void *dev_id)
>   
>   void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense)
>   {
> -	mutex_lock(&hdmi->mutex);
> -
> -	if (!hdmi->force) {
> -		/*
> -		 * If the RX sense status indicates we're disconnected,
> -		 * clear the software rxsense status.
> -		 */
> -		if (!rx_sense)
> -			hdmi->rxsense = false;
> -
> -		/*
> -		 * Only set the software rxsense status when both
> -		 * rxsense and hpd indicates we're connected.
> -		 * This avoids what seems to be bad behaviour in
> -		 * at least iMX6S versions of the phy.
> -		 */
> -		if (hpd)
> -			hdmi->rxsense = true;
> -
> -		dw_hdmi_update_phy_mask(hdmi);
> -	}
> -	mutex_unlock(&hdmi->mutex);
>   }
>   EXPORT_SYMBOL_GPL(dw_hdmi_setup_rx_sense);
>   
>   static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>   {
>   	struct dw_hdmi *hdmi = dev_id;
> -	u8 intr_stat, phy_int_pol, phy_pol_mask, phy_stat;
> -	enum drm_connector_status status = connector_status_unknown;
> -
> -	intr_stat = hdmi_readb(hdmi, HDMI_IH_PHY_STAT0);
> -	phy_int_pol = hdmi_readb(hdmi, HDMI_PHY_POL0);
> -	phy_stat = hdmi_readb(hdmi, HDMI_PHY_STAT0);
> -
> -	phy_pol_mask = 0;
> -	if (intr_stat & HDMI_IH_PHY_STAT0_HPD)
> -		phy_pol_mask |= HDMI_PHY_HPD;
> -	if (intr_stat & HDMI_IH_PHY_STAT0_RX_SENSE0)
> -		phy_pol_mask |= HDMI_PHY_RX_SENSE0;
> -	if (intr_stat & HDMI_IH_PHY_STAT0_RX_SENSE1)
> -		phy_pol_mask |= HDMI_PHY_RX_SENSE1;
> -	if (intr_stat & HDMI_IH_PHY_STAT0_RX_SENSE2)
> -		phy_pol_mask |= HDMI_PHY_RX_SENSE2;
> -	if (intr_stat & HDMI_IH_PHY_STAT0_RX_SENSE3)
> -		phy_pol_mask |= HDMI_PHY_RX_SENSE3;
> -
> -	if (phy_pol_mask)
> -		hdmi_modb(hdmi, ~phy_int_pol, phy_pol_mask, HDMI_PHY_POL0);
> +	u8 intr_stat;
>   
>   	/*
> -	 * RX sense tells us whether the TDMS transmitters are detecting
> -	 * load - in other words, there's something listening on the
> -	 * other end of the link.  Use this to decide whether we should
> -	 * power on the phy as HPD may be toggled by the sink to merely
> -	 * ask the source to re-read the EDID.
> +	 * Interrupt generation is accomplished in the following way:
> +	 *   interrupt = (mask == 0) && (polarity == status)
> +	 * All interrupts are forwarded to the Interrupt Handler sticky bit
> +	 * register ih_phy_stat0 and muted using the register ih_mute_phy_stat0.
>   	 */
> -	if (intr_stat &
> -	    (HDMI_IH_PHY_STAT0_RX_SENSE | HDMI_IH_PHY_STAT0_HPD)) {
> -		dw_hdmi_setup_rx_sense(hdmi,
> -				       phy_stat & HDMI_PHY_HPD,
> -				       phy_stat & HDMI_PHY_RX_SENSE);
> +	intr_stat = hdmi_readb(hdmi, HDMI_IH_PHY_STAT0);
> +	if (intr_stat & HDMI_IH_PHY_STAT0_HPD) {
> +		enum drm_connector_status status;
>   
> -		if ((intr_stat & HDMI_IH_PHY_STAT0_HPD) &&
> -		    (phy_stat & HDMI_PHY_HPD))
> -			status = connector_status_connected;
> +		/* Set HPD interrupt polarity based on current HPD status. */
> +		status = dw_hdmi_phy_read_hpd(hdmi, hdmi->phy.data);
> +		hdmi_modb(hdmi, status == connector_status_connected ?
> +			  0 : HDMI_PHY_HPD, HDMI_PHY_HPD, HDMI_PHY_POL0);
>   
> -		if (!(phy_stat & (HDMI_PHY_HPD | HDMI_PHY_RX_SENSE)))
> -			status = connector_status_disconnected;
> -	}
> -
> -	if (status != connector_status_unknown) {
>   		dev_dbg(hdmi->dev, "EVENT=%s\n",
>   			status == connector_status_connected ?
>   			"plugin" : "plugout");
> @@ -3141,8 +3043,7 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>   	}
>   
>   	hdmi_writeb(hdmi, intr_stat, HDMI_IH_PHY_STAT0);
> -	hdmi_writeb(hdmi, ~(HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE),
> -		    HDMI_IH_MUTE_PHY_STAT0);
> +	hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_HPD, HDMI_IH_MUTE_PHY_STAT0);
>   
>   	return IRQ_HANDLED;
>   }
> @@ -3343,9 +3244,6 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
>   	hdmi->dev = dev;
>   	hdmi->sample_rate = 48000;
>   	hdmi->channels = 2;
> -	hdmi->disabled = true;
> -	hdmi->rxsense = true;
> -	hdmi->phy_mask = (u8)~(HDMI_PHY_HPD | HDMI_PHY_RX_SENSE);
>   	hdmi->mc_clkdis = 0x7f;
>   	hdmi->last_connector_result = connector_status_disconnected;
>   
> @@ -3599,8 +3497,7 @@ void dw_hdmi_remove(struct dw_hdmi *hdmi)
>   	/* Free, mute and clear phy interrupts */
>   	devm_free_irq(hdmi->dev, irq, hdmi);
>   	hdmi_writeb(hdmi, ~0, HDMI_IH_MUTE_PHY_STAT0);
> -	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE,
> -		    HDMI_IH_PHY_STAT0);
> +	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD, HDMI_IH_PHY_STAT0);
>   
>   	/* Cancel any pending hot plug work */
>   	cancel_delayed_work_sync(&hdmi->hpd_work);

