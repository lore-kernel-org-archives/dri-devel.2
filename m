Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42CDCD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1397C10EABD;
	Tue, 19 May 2026 07:31:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sVpMOtzn";
	dkim-atps=neutral
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3438810EABD
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:31:43 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5a87edf88b3so3490320e87.0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 00:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779175901; x=1779780701; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=U3SA13elET4TYgmxY3hJVngIm5W/klIYH+PuWe1fxys=;
 b=sVpMOtznHGcU3Xi5/rQ5xStx6K+aSj/uGJsYY7ZK30c271sRI08CYu6pIUsybVbMpj
 mwnbXB7dsOMEoijtol7VtyDKxMMWiOce6ht7MjjPybhqDxPajUn6oaKcrVJumlqCE7wl
 V97RtIsygrX6DH4ol7TS1bWXms6e4ICPsNFFls5qZFetPJN9XC3lSL3+/ZGRBa/oD2jn
 787a38KV9WOVSUNp7Hjx9OFp9nWVyBzaVFCZhUZc6BOMM/4o5GQ+j/RmXsvm+Uud9qlg
 2cZNtJTlQ2KTXF5nW+BFN1EwcGLd16mo59weIqh1JCrGGLwKgMB+maXTH47Wd7blv34p
 moXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779175901; x=1779780701;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U3SA13elET4TYgmxY3hJVngIm5W/klIYH+PuWe1fxys=;
 b=ik+cOjIL1tStgpxbHcYqwcBlMBl5+hZFdmwZS3IVSKV+gd825JEqGm2MywmMXjN/fp
 PdHWJcjdoa/ev8q8M+awlZ2VYene0rCVdDOgy1z6duxlWMxH6em70V1IvH/ydSEbitt7
 3SwJUcf3JORvxQN5476JDtEah+NRd7TRhL9mbWhYdJaq+MZS6nglh9Rkp3dfKnKXhztv
 pJ5sl82HxWjgHyb+HcR5oim77yrMKFQb8Ca2JK6Lj8XURwEMEx6BogskI6vSKxK1Mpxu
 GJzR8TToSxkDT3rjSa74mG4bWR+2i03reTtsMvOKqDGnUUh1F3rDjLaRD2Gb+E4cBukt
 5Ydw==
X-Gm-Message-State: AOJu0Yyp1/rVUWgbqqy0alOMYu3PuNvjhMScfTg6zjDtZ4SQ7wCj6z+N
 mu8lieOUc1L42hXB1qjA3qECTDuUAIvZy6JED+sMrahvPsVRUYqCU3SKBOvcY20KihE=
X-Gm-Gg: Acq92OHNJuM383gQLjNsvz1Tcg299vVh576qUvYQ4qy/BXdApDT8MUoAUNJ8OcWun+Z
 gLI40uIln1z+vGcLWO7+Z4BYmE1svoIS2yE/a+xQd9XyEuR488nPuiYNMv3dmnT62Hc4lnwtfRy
 nAm+NTWDxPp0Dj6CJCR2/PlesolyERUOiTJzTgUmwp1RwGMnzHrPAsIoC8mCSWEHslcfN5rj6C8
 fEh4PYLxwuABcDJ71GFWZ2cN/h9edi9scV+8Idan/uPHwhCxmbfb5d17biPC/jcLyghnKF0Zy9Y
 ZLDzKht+QYTyGIuFOZfHwB/JZUqJZkkGWWgq3WMrrRXMej08gT+/qeXlrtSufBkc/ZT4myQgct4
 TB3eR3vc+6DGQyxlKrmLoAVMW+1oCZoSNU90MObKAcSERPkOqkHhc66b+eo9SDJ1QpIQg57EbVH
 FIfw6Vml9V8SKs2PnsFkuC4Nx7XxucAw7HiePgvnJSsR8h/xahi6y3ZCOVVN3A6rdCs3ijIeec1
 zt5
X-Received: by 2002:a05:6512:1317:b0:5a8:fbe0:bc71 with SMTP id
 2adb3069b0e04-5aa0e611478mr5339169e87.15.1779175901177; 
 Tue, 19 May 2026 00:31:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1d4b:274c:94d:a69f?
 ([2a01:e0a:106d:1080:1d4b:274c:94d:a69f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe2464sm44941676f8f.32.2026.05.19.00.31.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 00:31:40 -0700 (PDT)
Message-ID: <c6beeeb7-f764-4a84-aff7-5e29250027a1@linaro.org>
Date: Tue, 19 May 2026 09:31:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 07/13] drm/meson: encoder_hdmi: Report ycbcr_420_allowed
 from encoder
To: Jonas Karlman <jonas@kwiboo.se>, Kevin Hilman <khilman@baylibre.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org
References: <20260518194744.2483580-1-jonas@kwiboo.se>
 <20260518194744.2483580-8-jonas@kwiboo.se>
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
In-Reply-To: <20260518194744.2483580-8-jonas@kwiboo.se>
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

On 5/18/26 21:47, Jonas Karlman wrote:
> The bridge connector report ycbcr_420_allowed support when all bridges
> in the chain support ycbcr_420_allowed.
> 
> Report ycbcr_420_allowed on the encoder bridge so that the bridge
> connector automatically can report correct ycbcr_420_allowed support.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/gpu/drm/meson/meson_encoder_hdmi.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> index 45104ef35344..484675cb8284 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> @@ -354,6 +354,7 @@ int meson_encoder_hdmi_probe(struct meson_drm *priv)
>   	meson_encoder_hdmi->bridge.of_node = priv->dev->of_node;
>   	meson_encoder_hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
>   	meson_encoder_hdmi->bridge.interlace_allowed = true;
> +	meson_encoder_hdmi->bridge.ycbcr_420_allowed = true;
>   
>   	pdev = of_find_device_by_node(remote);
>   	of_node_put(remote);
> @@ -406,9 +407,6 @@ int meson_encoder_hdmi_probe(struct meson_drm *priv)
>   
>   	drm_connector_attach_max_bpc_property(meson_encoder_hdmi->connector, 8, 8);
>   
> -	/* Handle this here until handled by drm_bridge_connector_init() */
> -	meson_encoder_hdmi->connector->ycbcr_420_allowed = true;
> -
>   	priv->encoders[MESON_ENC_HDMI] = meson_encoder_hdmi;
>   
>   	dev_dbg(priv->dev, "HDMI encoder initialized\n");

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
