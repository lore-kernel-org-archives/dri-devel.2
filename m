Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E3F606A339
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=v2QiIOuo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FB0310EDC0;
	Mon,  2 Nov 2026 13:24:19 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0C2910EDC0
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:24:12 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a2084d62cdso26595425e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793625851; x=1794230651; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wrlc0uPOpWufY4Ha9PM3YaR+47hyRCDT/vlwyZbcxAs=;
 b=v2QiIOuoUNtXb7z3e5+ReGGmvPCMQ0ASSbqizSx1+8wdIgAjgiAAW+nFEt3SnrKWvR
 c/PxQW5RfAXpGIZn2I9+cTpXFoAlET26YZ7Ngw/SWi5tQuP1O86QLWt6SdNIJIJ55OX4
 HGqPrV+lO5/ooH3t8h2nMD8A7wpyaXGbpPWjxY72Ict3avOdfhZb7Hx9QVKKmc2kEQMY
 fysZUGrau9/HMTVwiiEWWdg3uV7wqsPXbeiNQd8AbkXwiTHiy2/Y5nXu1IVThqmFNAhX
 Zw1UrLQWuZw5I7KM39dk7uaofCHcxmgIUsbVAdEsWuVoWGuLXTI/He50/CAYg7SvxYKj
 OwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793625851; x=1794230651;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wrlc0uPOpWufY4Ha9PM3YaR+47hyRCDT/vlwyZbcxAs=;
 b=TTN/vKdf1FWtbsFx6rkBWHhL3gMRaFVkBNEHSXXmljeZeYqz+nrduYjZPATMlcCNpp
 sMW45+La//2LOeB3BZmPRy25YHlQNiXLnGHFJrmgjcP92g3O0wBb01Li3mQkn2N8Punc
 gmeMujRzcq66lmtvBklUq/aZprQiQjsdQv4j4Vji86oL0+6sVrIZZ4zUNv3tPvFVBOXY
 KZGz4JDMY5AUIxf742w50jBG+KbWSZ1NinLUOP7zXrnqWo1hPS17t/8aR6/noNNmP/sI
 6C5JpF3oUwNxG3Am+qI/46XiZRoCL9TOxurkrwjeGhFizZKKKjuiemz/crGLSGsC8FzF
 Tjgg==
X-Gm-Message-State: AFq9FYJXRvA++8ufh/OmQdR0EsFUl0ZW/j7RT9ye3rXddy0w+TaFsUtz
 0b3fbSO7lyNY3j43Sl68rcXKQLBRqIwWg1lqf1aNBWJX6N1ZJRcaTt0hR5uysjcCFzY=
X-Gm-Gg: AYBFou287Y75e7NHOre+AUG1yIegGQdgd0stiREc9fWyItND0WaVnTU3C6BftsswJCT
 Guhfm0ToDsTnz7dyXIolX8coudUrJkklmOEVJndsXnNLyXVUEYEDUiK6WY4WpA+5HKIlOdV3BUC
 3AaXg9QdyBG6CejzPt2zs3GhZZUYc1hXzFbGoqlRT+e+dvbGrkTYiVFobhkfuu4Cc7i+e+7OmNv
 oPp9gADDzc7oTpq+XKdl/riOADU9LF8fRvtEjgs1v7tt3kfgKN0maVG5QMbxOB+DrzhhLQvvKYk
 0Z7oQRl87zHeJ0jHqZiOCtSgkCQDPh0/WYIfpjhOTqxgyiPzb6MKVdwyIlqY3/kajSVnzKi2RzG
 dqkHG2XW2gZXUfCjmbD2amTa+aloCOeKQRyiWCc7ztNVcwWETXZrQQ+wleJBUm556A9mciZ+LrG
 CY14ghZqEraTzEtyCUtqDfsS/UdaDNiA5SWdgRHi4A61zsDbNW4VYCHJBiUnhjZdE5iQZLruAKG
 mCQcKgLvi/TI7vQXnE4wHaHvWAA5I/s/G0H1Pstc3KXRe5R7z9EdzkvVXWzI0DzMivoLbqIH3sj
 9rwnMVkFwquLRu4kSYvOUuH1qEH48SZiN1JqTEliuTBOiY7/D08fEL6AU8DqEDBrL2kZuvhvzrI
 ByT54
X-Received: by 2002:a05:600c:4e88:b0:4a3:59c7:f226 with SMTP id
 5b1f17b1804b1-4ac16bc4713mr239062835e9.6.1793625850979; 
 Mon, 02 Nov 2026 05:24:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9476:5165:3a16:262?
 ([2a01:e0a:106d:1080:9476:5165:3a16:262])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf7146621sm276611165e9.13.2026.11.02.05.24.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 05:24:10 -0800 (PST)
Message-ID: <620eb58a-bd8a-4679-84de-0285f10e0262@linaro.org>
Date: Mon, 2 Nov 2026 14:24:09 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/4] drm/panel: himax-hx8279: add the VDDP supply
To: David Lechner <dlechner@baylibre.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20261006-panel-himax-hx8279-vddp-v1-0-50d884b42aae@baylibre.com>
 <20261006-panel-himax-hx8279-vddp-v1-2-50d884b42aae@baylibre.com>
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
In-Reply-To: <20261006-panel-himax-hx8279-vddp-v1-2-50d884b42aae@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/6/26 22:25, David Lechner wrote:
> Get and enable the vddp-supply along with VDD and IOVCC.
> 
> The Startek KD070FHFID078 panel has a VDDP power input, which the
> MediaTek Genio 520 and 720 EVKs switch with a regulator of its own, so
> the driver has to enable it for the panel to be powered on those boards.
> 
> On boards that do not describe vddp-supply, the regulator core provides
> a dummy regulator, so they only see a "using dummy regulator" message.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>   drivers/gpu/drm/panel/panel-himax-hx8279.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-himax-hx8279.c b/drivers/gpu/drm/panel/panel-himax-hx8279.c
> index 9e443c719843..fe665cd3a3d2 100644
> --- a/drivers/gpu/drm/panel/panel-himax-hx8279.c
> +++ b/drivers/gpu/drm/panel/panel-himax-hx8279.c
> @@ -112,7 +112,7 @@
>   struct hx8279 {
>   	struct drm_panel panel;
>   	struct mipi_dsi_device *dsi[2];
> -	struct regulator_bulk_data vregs[2];
> +	struct regulator_bulk_data vregs[3];
>   	struct gpio_desc *enable_gpio;
>   	struct gpio_desc *reset_gpio;
>   	const struct hx8279_panel_desc *desc;
> @@ -769,6 +769,7 @@ static int hx8279_init_vregs(struct hx8279 *hx, struct device *dev)
>   
>   	hx->vregs[0].supply = "vdd";
>   	hx->vregs[1].supply = "iovcc";
> +	hx->vregs[2].supply = "vddp";
>   	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(hx->vregs),
>   				      hx->vregs);
>   	if (ret < 0)
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
