Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789C7CD4F57
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E0610EADC;
	Tue, 19 May 2026 07:33:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JQXQrG1R";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 192AD10EADC
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:33:25 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-449de065cb3so3025421f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 00:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779176003; x=1779780803; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=CptfMWX/OnKpQAZK1ljSyYDr+otcGVWKuHyIusA7+I4=;
 b=JQXQrG1RN9Z211jWLHmxWGVwp4l68b9/BQot6vhwlOwb5yhtWEEnmHSw5x4+JwuM1i
 d8qtsknW6TcBQ1TegsCpfvGDpWfgFMHMoeCbsFfMlwBB9AndbLc0zLxcettb5L7+aMYw
 zjFYYeXl6dAmghN0CsYfZZHQ5Z5FO46xFFCt2/9Xyv+a1UjV9FrTZYE1p8+yEYRjVNTa
 eIMGNo5vU/0zHHdrnuDJUx0pS2PDrpUvbSo0gduwXLaZ6/t9xBIy5pCr6xuV/5BCpEqg
 34pQd5bfEzKbKFHy6yKPUHiPGVoxlXjdbgxSXy+DBCoDTbSPdvYZYxjLtPyyX7ULDscf
 itgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779176003; x=1779780803;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CptfMWX/OnKpQAZK1ljSyYDr+otcGVWKuHyIusA7+I4=;
 b=f5v1wPkbQTbF6KXcLpkDy/LYpe0iVUotOI7yZPUaxVf68aCzqgsH61WiBfq/qwBzPI
 oCFMCqR5YiIcRARBOq5BuCIyGpPlKMqmu1DZS/y2kZBaRdixSC1lE8B+CG1kij0ZX9rV
 UyxAR0KIc6opY7/+neeKKgelgqXex3HuTc5GBJQPwz1uJzvy68gTP/9iSV3ziJZSNIMh
 zSNPnHBFLJAwrOrMPoYkJlBU5JdcXKtZlTXu1zQLn/Fhg2SsW9VDJhk2y9m/nLOWTkPW
 PUtyDXg7i5puff1a64XBIRTf0PnXBWDGmEeWNbxzwIRQF62XI9iyCO6qiIfdKs/7ZABK
 u8CA==
X-Gm-Message-State: AOJu0YxBf+MdGdsEQm8k2jz9B5PjdT9ekhuiyTVnNevlhiLQVUSNGmJ6
 nrdddjx2QCYoxycgOo1MYSHXU4/IozK6fd2p9xTV2go9CJCEYwanu6CSHSiA1MNZTTY=
X-Gm-Gg: Acq92OGWhb/23Qbpt9W4D7rrf6LzrDYcGon/WwTVMlf1A4SBri9MLYDgVy1pQ0Je9+O
 SLEHJCwKp/Am4Bm6HPLB5/HYe1X0EBZ1sTQhWAAcIIAY30T0y13qV8hKiZZJyXqLprqziAkrCQ8
 O2XKK8RTfT+jDY5T4RWA8SBUQ4NvLS2toYznjfOoCZK3kr/kzL2B8vFmvmxtO/33ywIJOcm/D+C
 e+Cki+yIaza430z1kk0f4OiXoB15+TgD90b91FTLIGMwGuyY1mJccog8QFsqtmi9Qx9Y4jdIdcM
 fdr+2A2Xi2VcFrlUVXVJebuzfkq9xgtx2pf4PIg9xLEOoXXpmBYC4PYoitMCl895lVKX6pjYvut
 MvjIwzusD+jFkj9wfYtt4Ok6PAxNQOs21+a/Yx5m7XSZKyjnZRvveq7ePA9gsSX4FIVSLLOnjB/
 LwfBXbVPsSn0TjA1iXFhzlywytn1qnt6wyunJ9wOfRP/hp+AZaioXS6BvDlzLhSurC9WOSP/G90
 Jtb
X-Received: by 2002:a05:600c:a406:b0:48a:9540:1a3a with SMTP id
 5b1f17b1804b1-48fe60e56abmr233108995e9.8.1779176003502; 
 Tue, 19 May 2026 00:33:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1d4b:274c:94d:a69f?
 ([2a01:e0a:106d:1080:1d4b:274c:94d:a69f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe537ccf5sm301918365e9.14.2026.05.19.00.33.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 00:33:23 -0700 (PDT)
Message-ID: <59760925-a19d-460e-afc9-015dd210f193@linaro.org>
Date: Tue, 19 May 2026 09:33:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 09/13] drm/meson: dw-hdmi: Use devm_clk_get_enabled()
 helper
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
 <20260518194744.2483580-10-jonas@kwiboo.se>
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
In-Reply-To: <20260518194744.2483580-10-jonas@kwiboo.se>
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
> Change to use the devm_clk_get_enabled() helper instead of using an
> open-coded variant.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/gpu/drm/meson/meson_dw_hdmi.c | 48 +++++++++------------------
>   1 file changed, 16 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index fcd2426af9fc..d0cf2042d41c 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -634,29 +634,6 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi *meson_dw_hdmi)
>   
>   }
>   
> -static void meson_disable_clk(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
> -static int meson_enable_clk(struct device *dev, char *name)
> -{
> -	struct clk *clk;
> -	int ret;
> -
> -	clk = devm_clk_get(dev, name);
> -	if (IS_ERR(clk)) {
> -		dev_err(dev, "Unable to get %s pclk\n", name);
> -		return PTR_ERR(clk);
> -	}
> -
> -	ret = clk_prepare_enable(clk);
> -	if (!ret)
> -		ret = devm_add_action_or_reset(dev, meson_disable_clk, clk);
> -
> -	return ret;
> -}
> -
>   static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>   				void *data)
>   {
> @@ -666,6 +643,7 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>   	struct drm_device *drm = data;
>   	struct meson_drm *priv = drm->dev_private;
>   	struct dw_hdmi_plat_data *dw_plat_data;
> +	struct clk *clk;
>   	int irq;
>   	int ret;
>   
> @@ -716,17 +694,23 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>   	if (IS_ERR(meson_dw_hdmi->hdmitx))
>   		return PTR_ERR(meson_dw_hdmi->hdmitx);
>   
> -	ret = meson_enable_clk(dev, "isfr");
> -	if (ret)
> -		return ret;
> +	clk = devm_clk_get_enabled(dev, "isfr");
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "Unable to get isfr pclk\n");
> +		return PTR_ERR(clk);
> +	}
>   
> -	ret = meson_enable_clk(dev, "iahb");
> -	if (ret)
> -		return ret;
> +	clk = devm_clk_get_enabled(dev, "iahb");
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "Unable to get iahb pclk\n");
> +		return PTR_ERR(clk);
> +	}
>   
> -	ret = meson_enable_clk(dev, "venci");
> -	if (ret)
> -		return ret;
> +	clk = devm_clk_get_enabled(dev, "venci");
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "Unable to get venci pclk\n");
> +		return PTR_ERR(clk);
> +	}
>   
>   	dw_plat_data->regm = devm_regmap_init(dev, NULL, meson_dw_hdmi,
>   					      &meson_dw_hdmi_regmap_config);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
