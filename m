Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74334CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 15:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9F0710ED62;
	Tue, 19 May 2026 15:12:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i4DjXQXj";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 142C110ED62
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 15:12:47 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so21850415e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779203565; x=1779808365; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=TVQp/cA7Et9VS7l3eduBKFhTtN4ZONdXEaRfRIEiTJc=;
 b=i4DjXQXjQPKrxKIUnZfHRQ3SXowwFNlFcS6XQS2HchJIvVOuXP9MFI1qyOBht26Ir4
 ssrVZSA+bbYxLGyS9/DQlUBJONdVAcTfO/R4GmwSXCF+7TtpZH2i2UiitbAJLXPpMp5M
 uyOKUlxD0OmrySCDrwMZXAxnl2ysandC30AMV50B4lYB2H2z3Fd1XLM1etsVGXEBtNN7
 jIZwGjtr1fFcGknN297WFSb+3+RpguS/cOZwCqkxfBgcnIw8ISzKQm9YevedShgog0DF
 sL5POcV9ypNOTgHfM5x3YTgrfEZPBvDVeoPBvDGe5WIBc6vJYS25D/qYyayfvanRfoc0
 s7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779203565; x=1779808365;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TVQp/cA7Et9VS7l3eduBKFhTtN4ZONdXEaRfRIEiTJc=;
 b=O3X+PsQDZlANAu3lttVM5g1xv2DC+muRzHdWJxT3+2ae8/N8jNgwCQvmKvXXQ9197i
 uy0+WoN702W/EANSZcUrbUuySa6GXABlnRPJrQ0kfevRowGnIwxl4amDPZhcFUnm0acz
 bN9Ack1XqrNTFsmsY4quv9qcgSSmYDkBZA2Pi7tt6PRk2UN3mPxlXrV7z5oBJUYqG4/F
 8HtdolFx814u+1PH9rHOc+n8FfjsOxUYxLOGurpuz3pU+izGeC9uVagC8y3zW8YXvOJL
 CLL/KQl39AFDfpUJAEUv5wqTR11Amno5YKySyb2If+2bnlD6iXSBUK/JnomK2FhsrVWk
 eCFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ941CfYuEvl7Fj1puF71TMLHvBIn6RWz0nf7wJyQ+QRmHDXaNnNr2YJVE4ysXWXyErE51+WglFCQGU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXOvT8LRxIAcoYkrHzDLSm362BBkRXqy0SYBhM5Hbb5c488nsB
 u2vNqtlXM6siTvDiGjzhRpqi4kscsyLIyTBxl0aA8qbzw8zrWCjHs+UuyfS2JMisJGA=
X-Gm-Gg: Acq92OFvhRh6KV0bCXccws8oIoNeoBP5LORyZyuPxHywM/7dNLOznCp1tqXqVtBu0LU
 Wt7eXrPRYfxWh4XC1PkIbAtSYxNb8FGFW8eEBD0qazf6RzDmpScIR56+JiTQ+xA3IEFsst4F6IN
 AywvXf4i4XCilS8J1C+kodnSjC2Vyu92DCgKkB1bWvZKMNo/KcVYea2VFN9X0k2XakONAPrrAQO
 VCtWnEeUiyxH2OjtETWiOEBZEMw88c1redPqc/+v1dP5fQWphR9tbYJEh0Q8zvna60EJmJoHPf5
 QBFyoa+sFCBFFM7g8O8Ypr3NWtgH2qX+lPPsOE09NuVR9BX4odSTPyAd0EFMdzrZlmVOQtH5CZq
 zd7iaXAhSJaGqz9Dx0480Mw+W7I4/tSrkN3nQkPpsPCmjYvNgroXcM4NDUopGkG1I9aM2Xk0Vzs
 kekN/sfCtjM1H8e6elkF2AOKVE2ZW+lXGPX1z7cGVVr/n5cUeNAahFCvRFJL6qVddjYDyh7OTnx
 GjrVdU=
X-Received: by 2002:a05:600c:314f:b0:490:389:7644 with SMTP id
 5b1f17b1804b1-49006db5bc0mr175326005e9.17.1779203565446; 
 Tue, 19 May 2026 08:12:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:45b7:1191:7413:7781?
 ([2a01:e0a:106d:1080:45b7:1191:7413:7781])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5cab7c5sm354389755e9.12.2026.05.19.08.12.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 08:12:45 -0700 (PDT)
Message-ID: <2de87295-aa31-404a-8e69-5ee7b14bf8c1@linaro.org>
Date: Tue, 19 May 2026 17:12:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 31/37] drm/bridge: panel: implement .is_tail
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Marek Vasut <marex@denx.de>,
 Stefan Agner <stefan@agner.ch>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
 <20260519-drm-bridge-hotplug-v1-31-45e2bdb3dfb4@bootlin.com>
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
In-Reply-To: <20260519-drm-bridge-hotplug-v1-31-45e2bdb3dfb4@bootlin.com>
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

On 5/19/26 12:37, Luca Ceresoli wrote:
> This bridge is always a tail bridge, i.e. it never needs a following bridge
> to complete the pipeline. Add a is_tail func to expose this.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>   drivers/gpu/drm/bridge/panel.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index 4978ec98a082..102f987b1235 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -58,6 +58,11 @@ static const struct drm_connector_funcs panel_bridge_connector_funcs = {
>   	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>   };
>   
> +static bool panel_bridge_is_tail(struct drm_bridge *bridge)
> +{
> +	return true;
> +}
> +
>   static int panel_bridge_attach(struct drm_bridge *bridge,
>   			       struct drm_encoder *encoder,
>   			       enum drm_bridge_attach_flags flags)
> @@ -206,6 +211,7 @@ static void panel_bridge_debugfs_init(struct drm_bridge *bridge,
>   }
>   
>   static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
> +	.is_tail = panel_bridge_is_tail,
>   	.attach = panel_bridge_attach,
>   	.detach = panel_bridge_detach,
>   	.atomic_pre_enable = panel_bridge_atomic_pre_enable,
> @@ -297,7 +303,7 @@ struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
>   	panel_bridge->panel = panel;
>   
>   	panel_bridge->bridge.of_node = panel->dev->of_node;
> -	panel_bridge->bridge.ops = DRM_BRIDGE_OP_MODES;
> +	panel_bridge->bridge.ops = DRM_BRIDGE_OP_MODES | DRM_BRIDGE_OP_IS_TAIL;
>   	panel_bridge->bridge.type = connector_type;
>   	panel_bridge->bridge.pre_enable_prev_first = panel->prepare_prev_first;
>   
> 

This looks reasonable

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
