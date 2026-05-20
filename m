Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A71ECD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 09:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C312B10EFAF;
	Wed, 20 May 2026 09:58:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b6F1g/yX";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 313EA10EFAF
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:58:30 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so55100345e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 02:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779271109; x=1779875909; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=fdECDhsPbmxIQbhRIxq+WIlDy168HO+dUwyzYZe+8DA=;
 b=b6F1g/yXy/VxftDyt5lg6TKrypqgNu57Ekr4BIo5w5gRbOsybKYM3oVScLf4vzMBmL
 W9MMNZdiFo7EXcdRX5ndw8kIx+zig+6xtDAdq4PFafpfoOrJG5qxvPrFtyRyLMAyy28G
 ywLuJK0E+wn/K3C4lzALpdgebvhw4+gxMbg5HYzNNildwLTXw/k5f7JLHITfAis2lWUS
 pedihilcoX5K8qJ3e/cPWmORpmLJ/wJ5bUSNF1z/EQ8CZ/KaHG1cV9KtURuREHIvkYhI
 CrCSwg7E4Bg/k6uv0/wER3Bf51faq+XjSIETQKmWcAUePTACuC43OAkIvVZHFIzwKBi6
 uzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779271109; x=1779875909;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fdECDhsPbmxIQbhRIxq+WIlDy168HO+dUwyzYZe+8DA=;
 b=DZtA/DdQMweOQcr+/80uf0G/5JX7AfdMd0qayRMY6uBDa213qmIQB9RpUH0U8wVefU
 OFAz2FvWcLGQRtxsP7vGop9WtBg9izxMmRFr/HythgC8hg0Rp0RYCVK5h+x1j8RoTpnl
 q5KLADCxPbNFgJOX9isnT7iPQEfLOplIT+jyfpoAqZ2qjLown/dejR7fWpruykWHfZcx
 GkWswfYYumEQQK/HtwaxXM/L9NtuB8fDc5q8YGnbCjCTIObk7vsGlHbbGhD7XU6pHRvR
 NEM9k0oHcIjZMHRT5P2PLdLeBJgbteZeM1S7jF9h5vJZqhWJbKP7ChLfbRcqrubrcjoS
 MygA==
X-Forwarded-Encrypted: i=1;
 AFNElJ825muJ6xrvYH9CPEVn8DJvb2yEkJxzZJJ2ItUGXeEfnjokzpqixtyPxcvCQFY1QIg9n3RZZQUY6VM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwhkI/gzFp7I7dkCgLPHPds5x/cKI46mT4WTJbV7PZHfU6BbSg
 7nrCNfWwDxtdRqbagHwMZKZ9XxSA0vQ6EwhAXe+KLL/G5wd6sDT4zULr7QHrjq/kk6k=
X-Gm-Gg: Acq92OGmgRmtru6RBCcbTi74/O3T10YFfj300SKf98NMuGytihHp9/03isH9nOIBVMZ
 qb1pQvVl/uNJDtS5RcAd+tP5bV1/Czfrv35CkDP0fqx9GyQY3n8J8woYQe/gObMCh1sXqAHIF83
 arci127IJm01EUo/zDJtiLXb1EILy420vjjbJ4bsJpXpKvqwttHCp56Ob/J7wOMao3q+uczkBAU
 j61TbKBD1uUSc6AXBOe3ZY5UvChdCtUKqF9+mpaOAxdIXKGEVr7X62w9X6rPYUPQRNmdZCmLKzk
 ffwLhk+rgBZa0NS4gMKHAiXOIQ67nuFcuMfoe8uEmg99Sxd0YedEvUkAzaCKfO7BQQM6Xhn54np
 UakU0cZdfeNwIk1ULvw1eXZSgy+DOrDo3SGdLYHM8JT41fHjpRyrpSRPc4x2f871eQMkIpWICk/
 cn7esoyOveXwQEG5cHN6xrUhCEri4WApfASqj4tiLp2fRDwVYHacR43GEIZx7TSma7aOG1gOlUg
 VlH9BD7Yd3+jEU=
X-Received: by 2002:a05:600c:6206:b0:489:5022:39a4 with SMTP id
 5b1f17b1804b1-48fe60e79fdmr368845595e9.9.1779271108519; 
 Wed, 20 May 2026 02:58:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:5dda:3751:f88e:6ff?
 ([2a01:e0a:106d:1080:5dda:3751:f88e:6ff])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe83ba2sm126159225e9.35.2026.05.20.02.58.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 02:58:28 -0700 (PDT)
Message-ID: <e584ab2b-677d-4893-95c9-7b68165633c6@linaro.org>
Date: Wed, 20 May 2026 11:58:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v7 19/23] drm: bridge: dw_hdmi: Use delayed_work to
 debounce hotplug event
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
 <20260518180206.2480119-20-jonas@kwiboo.se>
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
In-Reply-To: <20260518180206.2480119-20-jonas@kwiboo.se>
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

Hi,

On 5/18/26 20:01, Jonas Karlman wrote:
> HDMI Specification Version 1.4b chapter 8.5 mentions:
> 
>    An HDMI Sink shall not assert high voltage level on its Hot Plug
>    Detect pin when the E-EDID is not available for reading.
> 
>    A Source may use a high voltage level Hot Plug Detect signal to
>    initiate the reading of E-EDID data.
> 
>    An HDMI Sink shall indicate any change to the contents of the E-EDID
>    by driving a low voltage level pulse on the Hot Plug Detect pin. This
>    pulse shall be at least 100 msec.
> 
> Use a delayed work to debounce reacting on HPD events to improve
> handling of a HPD low voltage level pulse when a sink changes the EDID.
> 
> The delayed work is only enabled between enable_hpd()/hpd_enable() and
> disable_hpd()/hpd_disable() calls from core, i.e. enabled after
> attach/bind/resume and disabled before detach/unbind/suspend.
> 
> The 1100 msec hotplug debounce timeout was arbitrarily picked to match
> other drivers using same const, and testing using a Raspberry Pi Monitor
> seem to use a 200-300 msec pulse when going from standby to power on
> state.

The logic looks ok, but I'm puzzled by the 1.1 sec debounce, which after
plugging in a monitor will only send an irq event after 1.1s which is very long.

Since the spec says 100ms and the real worls values are more like 200-300ms,
I would first reduce this to 500ms.

But as I understand the code right now, on the first HPD front the irq work
is programmed to run after the debounce time, but if it's a pulse the irq would
also trigger on the second HPD front and then delay again the work after the
debounce time.

My understanding of a debounce was that we "ignore" the pulse by only generating
a single irq event when the pulse is finished.

The current code does that, we will only have a single irq event and the HPD
will return as connected state, good. But this delays the irq event 1.1s _after_
the end of the pulse, which I would expect the event to be send at tht debounce
time after the start of the pulse.

Like, program the work at the beginning of the pulse, if somehow the pulse ends before
the debounce time, send the irq event immediately, otherwise let the debounce
work run after the debounce time which will trigger a disconnect event.

But the delay is too high, 1.1s could be a manual unplug/plug or bad connector
with false contact on the hpd pin.

I would rather reduce this to something more realistic like 500ms or less and
try to better handle the pulse somehow. But I don't have any idea if the scheme
I described is doable.

Neil

> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v7: Change to free irq before mute and clear using IH regs, also include
>      clear of STAT0_RX_SENSE
> v6: Change back to disable_delayed_work_sync() in hpd disable ops,
>      Ensure HPD interrupt is masked and IRQ handler is disabled early
>      in dw_hdmi_remove() to prevent any irq re-arming of delayed work,
>      Drop use of suspend helper
> v5: Change to none-sync disable_delayed_work() in hpd disable ops,
>      Change to cancel_delayed_work_sync() in remove,
>      Add cancel_delayed_work_sync() to new suspend helper
> v4: Disable/mask delayed_work until enable_hpd()/hpd_enable(),
>      Read connector status directly from HW regs in hpd_work
> v3: New patch
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 80 +++++++++++++++++++++--
>   1 file changed, 75 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 8afc9d240121..270db58a0e7c 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -50,6 +50,8 @@
>   
>   #define HDMI14_MAX_TMDSCLK	340000000
>   
> +#define HOTPLUG_DEBOUNCE_MS	1100
> +
>   static const u16 csc_coeff_default[3][4] = {
>   	{ 0x2000, 0x0000, 0x0000, 0x0000 },
>   	{ 0x0000, 0x2000, 0x0000, 0x0000 },
> @@ -185,6 +187,7 @@ struct dw_hdmi {
>   	hdmi_codec_plugged_cb plugged_cb;
>   	struct device *codec_dev;
>   	enum drm_connector_status last_connector_result;
> +	struct delayed_work hpd_work;
>   };
>   
>   const struct dw_hdmi_plat_data *dw_hdmi_to_plat_data(struct dw_hdmi *hdmi)
> @@ -2517,6 +2520,20 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
>   	dw_hdmi_connector_status_update(hdmi, connector, connector->status);
>   }
>   
> +static void dw_hdmi_connector_enable_hpd(struct drm_connector *connector)
> +{
> +	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi, connector);
> +
> +	enable_delayed_work(&hdmi->hpd_work);
> +}
> +
> +static void dw_hdmi_connector_disable_hpd(struct drm_connector *connector)
> +{
> +	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi, connector);
> +
> +	disable_delayed_work_sync(&hdmi->hpd_work);
> +}
> +
>   static void dw_hdmi_connector_destroy(struct drm_connector *connector)
>   {
>   	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi, connector);
> @@ -2538,6 +2555,8 @@ static const struct drm_connector_funcs dw_hdmi_connector_funcs = {
>   static const struct drm_connector_helper_funcs dw_hdmi_connector_helper_funcs = {
>   	.get_modes = dw_hdmi_connector_get_modes,
>   	.atomic_check = dw_hdmi_connector_atomic_check,
> +	.enable_hpd = dw_hdmi_connector_enable_hpd,
> +	.disable_hpd = dw_hdmi_connector_disable_hpd,
>   };
>   
>   static int dw_hdmi_connector_create(struct dw_hdmi *hdmi)
> @@ -2968,6 +2987,20 @@ static const struct drm_edid *dw_hdmi_bridge_edid_read(struct drm_bridge *bridge
>   	return dw_hdmi_edid_read(hdmi, connector);
>   }
>   
> +static void dw_hdmi_bridge_hpd_enable(struct drm_bridge *bridge)
> +{
> +	struct dw_hdmi *hdmi = bridge->driver_private;
> +
> +	enable_delayed_work(&hdmi->hpd_work);
> +}
> +
> +static void dw_hdmi_bridge_hpd_disable(struct drm_bridge *bridge)
> +{
> +	struct dw_hdmi *hdmi = bridge->driver_private;
> +
> +	disable_delayed_work_sync(&hdmi->hpd_work);
> +}
> +
>   static const struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
>   	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>   	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> @@ -2981,6 +3014,8 @@ static const struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
>   	.mode_valid = dw_hdmi_bridge_mode_valid,
>   	.detect = dw_hdmi_bridge_detect,
>   	.edid_read = dw_hdmi_bridge_edid_read,
> +	.hpd_enable = dw_hdmi_bridge_hpd_enable,
> +	.hpd_disable = dw_hdmi_bridge_hpd_disable,
>   };
>   
>   /* -----------------------------------------------------------------------------
> @@ -3101,8 +3136,8 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>   			status == connector_status_connected ?
>   			"plugin" : "plugout");
>   
> -		if (hdmi->bridge.dev)
> -			drm_helper_hpd_irq_event(hdmi->bridge.dev);
> +		mod_delayed_work(system_percpu_wq, &hdmi->hpd_work,
> +				 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
>   	}
>   
>   	hdmi_writeb(hdmi, intr_stat, HDMI_IH_PHY_STAT0);
> @@ -3112,6 +3147,29 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>   	return IRQ_HANDLED;
>   }
>   
> +static void dw_hdmi_hpd_work(struct work_struct *work)
> +{
> +	struct dw_hdmi *hdmi = container_of(work, struct dw_hdmi, hpd_work.work);
> +	struct drm_device *dev = hdmi->bridge.dev;
> +
> +	if (WARN_ON(!dev))
> +		return;
> +
> +	/*
> +	 * Notify the DRM core of the HPD event using drm_helper_hpd_irq_event()
> +	 * instead of drm_bridge_hpd_notify(). This will cause the DRM function
> +	 * check_connector_changed() to be called, which in turn calls the
> +	 * connector detect()/force() funcs to detect any connection status or
> +	 * epoch changes. The bridge connector detect() func also ensures that
> +	 * any hpd_notify() funcs are called for all bridges in the chain.
> +	 *
> +	 * drm_bridge_hpd_notify() shares a mutex with drm_bridge_hpd_disable(),
> +	 * and can result in a deadlock due to the disable_delayed_work_sync()
> +	 * call to wait on work to complete in dw_hdmi_bridge_hpd_disable().
> +	 */
> +	drm_helper_hpd_irq_event(dev);
> +}
> +
>   static const struct dw_hdmi_phy_data dw_hdmi_phys[] = {
>   	{
>   		.type = DW_HDMI_PHY_DWC_HDMI_TX_PHY,
> @@ -3396,6 +3454,9 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
>   		goto err_res;
>   	}
>   
> +	INIT_DELAYED_WORK(&hdmi->hpd_work, dw_hdmi_hpd_work);
> +	disable_delayed_work(&hdmi->hpd_work);
> +
>   	ret = devm_request_threaded_irq(dev, irq, dw_hdmi_hardirq,
>   					dw_hdmi_irq, IRQF_SHARED,
>   					dev_name(dev), hdmi);
> @@ -3532,6 +3593,18 @@ EXPORT_SYMBOL_GPL(dw_hdmi_probe);
>   
>   void dw_hdmi_remove(struct dw_hdmi *hdmi)
>   {
> +	struct platform_device *pdev = to_platform_device(hdmi->dev);
> +	int irq = platform_get_irq(pdev, 0);
> +
> +	/* Free, mute and clear phy interrupts */
> +	devm_free_irq(hdmi->dev, irq, hdmi);
> +	hdmi_writeb(hdmi, ~0, HDMI_IH_MUTE_PHY_STAT0);
> +	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE,
> +		    HDMI_IH_PHY_STAT0);
> +
> +	/* Cancel any pending hot plug work */
> +	cancel_delayed_work_sync(&hdmi->hpd_work);
> +
>   	drm_bridge_remove(&hdmi->bridge);
>   
>   	if (hdmi->audio && !IS_ERR(hdmi->audio))
> @@ -3539,9 +3612,6 @@ void dw_hdmi_remove(struct dw_hdmi *hdmi)
>   	if (!IS_ERR(hdmi->cec))
>   		platform_device_unregister(hdmi->cec);
>   
> -	/* Disable all interrupts */
> -	hdmi_writeb(hdmi, ~0, HDMI_IH_MUTE_PHY_STAT0);
> -
>   	if (hdmi->i2c)
>   		i2c_del_adapter(&hdmi->i2c->adap);
>   	else

