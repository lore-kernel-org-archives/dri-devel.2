Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A2FCD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 09:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6916D10E03F;
	Wed, 20 May 2026 09:17:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vM0uJuip";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD5A510E03F
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:17:18 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-45562c41ec7so2824624f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 02:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779268637; x=1779873437; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=MQM11Mg1okAZbmmFPoevnMUA1OvrXb8LaWj00KaDlLQ=;
 b=vM0uJuip+e3ml+jKmW4XNr6cz7Ga5omcLiiRbnSMBuogUuOG4v57Cr0hnvsiBBAmA8
 YjnTMQyvbhzUS7FXEoe6yGiuhleBzlbI/PR8R25yBfnlMzjAzH8/n2v9BHuTTb2OK20k
 qVfyabFBs/T1cO018CK1hJh5muFLM9o5gtS+Zmb87EUErBHdIIkz1KCSKoF3PJyVOnsR
 ADx1uEpB75UFUsspb8RNy9wNfVeqEh08c85PmSqFGNk0SBJA3ica2N3octB+SR7l0S5g
 wUBR/542qtL9R2a1PblwYfCzauHfYKTi7ncLisZ5Vp6n69DdDIibZNpCh7/ImoWCZBZN
 ptzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779268637; x=1779873437;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MQM11Mg1okAZbmmFPoevnMUA1OvrXb8LaWj00KaDlLQ=;
 b=bwAepyUB4ls8qMjEqFBLeVjFH9+ACEYsKfGLoXvQhfdfaWkfMs5aJF87kZclegvTOq
 cEjDrl6fZ5C6WV2oyrWcM+ETNTYtNWURuKGQesxThUsGNDi3T0eQXEruYYQqvS57xMAO
 IX26i1n3vTcP1icA98egppu9yXoB/Ze31TrUsWhnaAkFr8nK9lbG6GrZEEhOiHRZSdvq
 BrjiPgFgpkLWQdZbAM10/MI6+vdCo3RTGFcZYN2eiFBeNVFSiCd86BiZFo6KPn5ypYgA
 3TgRORggycZr6yN+KRInR7WG13VVwBeMqnJSs++bXbT5OPlcud3S+aq/i1gdoberGrIa
 SJgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/aJzN/srGk9zYSyu7MD6n4WrzyR6irwVIIvx+ekR8x/htiX9D+S+q3yUJOiv+eVoJrzP+g/Pq4g54=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyt+obgFUT5FS9oQjTE8ntSdQSKYxPEOJ1xO7TohcOQLVLc6gwM
 3Zp1s4+8So5zrCEvLuZjMS+7oRhJ2qwm2XdcNWHwdFf2RMFk5fKkNlT/xBMiFiYqyTY=
X-Gm-Gg: Acq92OH/+qr/9QQZv9hPUnbiJfYaf+jPkDpnI6S64edYu/Lidn3TpejazphIcrwN2Ct
 FaSyK1wzRXxf3Aazc+wYBS/m/1SRjkjUu+f/HbLklGWu4jV/4FddbTRnLUzjI6LMWMki+VphkH7
 Hrg67WS2RMUdAk2D/cN6/Fu/0lR5k84JhGnQqnk42l1uCZNdHJ/emKve7hEeXpPeDlV3ozQ3ovU
 L0RDeYKWLD+t1fIfDKTBvG1piH5eCUhv6O26Ja+HNeLZzt6lh4rnWV9nYNeGaaLv45YP507iyrP
 V0ZECXhawFfqukabw7NvCykLXWeIf5+u70lefwyiLzxKQ2yEqFBZWTHyL+ZEbKackVt9EUBM5aE
 Ctb2bdQTB9V36VHi/00sedFs7FxRFe5iTq0vdahxLQdYfqQus4O9IfMCgPZ8o1SeCwwmBereG54
 2DB4iPsAh7AW4dZeSUTTaflji/R6bCMJBPB1hrKLJRq+eQImw33QQMi/PN4Iz22IkNtB225Re92
 DK6
X-Received: by 2002:a05:600c:4e87:b0:48a:768b:eea9 with SMTP id
 5b1f17b1804b1-48fe60e51bamr379132105e9.4.1779268636948; 
 Wed, 20 May 2026 02:17:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:5dda:3751:f88e:6ff?
 ([2a01:e0a:106d:1080:5dda:3751:f88e:6ff])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe7543asm127859995e9.28.2026.05.20.02.17.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 02:17:16 -0700 (PDT)
Message-ID: <b9499456-3fd5-4c0b-a0a4-7a6344f21708@linaro.org>
Date: Wed, 20 May 2026 11:17:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v7 16/23] drm: bridge: dw_hdmi: Update EDID and CEC phys
 addr in bridge detect()
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
 <20260518180206.2480119-17-jonas@kwiboo.se>
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
In-Reply-To: <20260518180206.2480119-17-jonas@kwiboo.se>
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
> Update EDID and CEC phys addr in the bridge detect() func to closely
> match the behavior of a bridge connector with a HDMI bridge attached
> and the dw-hdmi connector.
> 
> This change introduce a slight delay to the bridge connector detect()
> and get_modes() funcs due to multiple EDID reads. This is an acceptable
> added delay to help ensure EDID and CEC phys addr always are correct.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v7: Update commit message
> v6: New patch
> 
> This is a temporary change until dw-hdmi is fully converted into a
> HDMI bridge in a future part of this multi-series effort.
> 
> The patch "drm/bridge-connector: Use cached connector status in
> .get_modes()" [1] can help remove one unnecessary EDID read until
> dw-hdmi is fully converted into a HDMI bridge.
> 
> [1] https://lore.kernel.org/dri-devel/20260426-dw-hdmi-qp-scramb-v5-3-d778e70c317b@collabora.com/
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 37406555af7b..0c4388e7aa5e 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2947,8 +2947,17 @@ static enum drm_connector_status
>   dw_hdmi_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector)
>   {
>   	struct dw_hdmi *hdmi = bridge->driver_private;
> +	enum drm_connector_status status;
>   
> -	return dw_hdmi_detect(hdmi);
> +	status = dw_hdmi_detect(hdmi);
> +
> +	/*
> +	 * Update EDID and CEC phys addr to match the behavior of a bridge
> +	 * connector with a HDMI bridge attached and the dw-hdmi connector.
> +	 */
> +	dw_hdmi_connector_status_update(hdmi, connector, status);
> +
> +	return status;
>   }
>   
>   static const struct drm_edid *dw_hdmi_bridge_edid_read(struct drm_bridge *bridge,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
