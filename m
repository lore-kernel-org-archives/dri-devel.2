Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB975C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1594510E8FD;
	Mon, 20 Jul 2026 12:41:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZJycX4C/";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C01F610E8FD
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 12:41:14 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso17060575e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 05:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784551273; x=1785156073; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=02PeqF3rbp1hsOzW2e5ny6E3Yj+EmyQ/4DKajWJOxPY=;
 b=ZJycX4C/Sk1AtK/uEh8M0O0KdGTP1+BOQ0qay3tXf0fsXeTABMXHtxQCrBZFv8c5hJ
 14Mv9G6jDkUFUExWGBExQWHeKmyPsALM6MPhgN45MDDfxX5hJM0cTDJSXiOReCSe1K9E
 2JkAF4vbkqkNKGEMMUTCLzNSMLtISqIgaHYrlx74u84W+M8w3PXrx10o6k/MBpVbG8vX
 78CTcJn9ArI8sgXlc3WYQsz1wLQjpRPFUHOPD8GzrxR7msTjMPlZBPO7dm7tt+OvVaPg
 1WCFmjD1LZbHXQvkpY0fd70bH4/UljKtKHd6Hk73I7xkOg2IIhNq9lTZBft68FVYojd+
 +cbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784551273; x=1785156073;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=02PeqF3rbp1hsOzW2e5ny6E3Yj+EmyQ/4DKajWJOxPY=;
 b=LcouIh6UX4nwbwIYG6JZX58pulUtv+ZoaxWEQN0N+ktn7EV9XnkLEffCiJh3afaArf
 tXgvDywgq+MGtU+9/4kRky3CBKxtDd+cE+d3hC/wxts5IHIvsMAwFLCD1AF6YKiyG27t
 mUewZWQYhB50CVkCw23izQtLxPXJC+BgKz4tGYneVhmKLXLZtf8WNxAr1HbzQG0nm8GW
 l9aOx2mHFeXrtBgQMqVBmzeoepmYikxV0Rn87xMJ+voMTbeWU8Q5BDLsFudjKDO0UVs8
 b2+Y8UfcU+Zi01+FGK3PfdhPPLNGrdOhOOLPA7Zgg75h3qd9+1QIjlV92OdAh5PBKOOC
 n+1A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoHXyvcJdtF7sJOdYwIQb8cluQ/r5miKIh+ebpv+O3ZUL3bf+r+w9NbVFJbZo52yZ5Gb6LJgs+8Ss8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsMsAc0JCxUxUKa0nGB5Ue/zibFH+vmamryXIZnku0Fpuv3dj3
 3aEcBtJS9mYLet4sAQ+Z5iH1X877PxOwD0X443Qb0NIGbJYkVrYhwXBMViAPo5y899Y=
X-Gm-Gg: AfdE7cmQ1htH8Eo41KhmZ4zjAx5PsJKtPZEqZNLTs7ORZQ0K9rpuRe/JQLxnB8mnKRw
 cyW/w/jDgNVyVEGhhx9KZTHYfHHiONKDKzooDndRQG/C8KfgxgsIsrhnqGG8W0MLZi4RZW+qLxI
 qHxhCL6vFKxf4IEkXX5oiHvo6QYIccYJipdrh13b+YY2b+O24y5QLxyEFgr4ACju/OKA+qjZq1N
 QCQvySr+P6oM0AaPyAqFtmFx8FBny96iv5oIDK97RzyIFWgXz2ZgQDhVQTIVunHCA/lRQQ2ycnT
 61zdiKf85n9iRK7wjuiKYADTqYDYHBYNvppsOtwCl69asPA3OT7j9ZTOQD+WIaH8gHQihJqFm+D
 IoPEgxVhLRLR/tVGMxDkaSMBVnV8eOoUaKjjbYbs/JN6drwDi7GmBR4kVm2jSMYTdYhVrP+Syiw
 hkGUQO+Nl9FZCC3g/0LH60qpHP+utd75qi8KgoRr3DTk56OjOgICGVPsidz/+xE9ml7gjr
X-Received: by 2002:a05:600c:6a0b:b0:493:c453:6002 with SMTP id
 5b1f17b1804b1-4954a516453mr90764735e9.35.1784551272978; 
 Mon, 20 Jul 2026 05:41:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:544a:2852:f257:ebc5?
 ([2a01:e0a:106d:1080:544a:2852:f257:ebc5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549a36312sm300850935e9.2.2026.07.20.05.41.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 05:41:12 -0700 (PDT)
Message-ID: <7b7e6b86-e14f-4d84-89b8-73e689c00ab6@linaro.org>
Date: Mon, 20 Jul 2026 14:41:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/5] drm: panel: jd9365da: Add prepare_prev_first flag to
 drm_panel
To: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>,
 Jagan Teki <jagan@edgeble.ai>, Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jerome Oufella <jerome.oufella@savoirfairelinux.com>,
 Felix Boucher <felix.boucher@savoirfairelinux.com>,
 Quentin Lehoux <quentin.lehoux@savoirfairelinux.com>
References: <20260708213500.1867092-1-marc-olivier.champagne@savoirfairelinux.com>
 <20260708213500.1867092-3-marc-olivier.champagne@savoirfairelinux.com>
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
In-Reply-To: <20260708213500.1867092-3-marc-olivier.champagne@savoirfairelinux.com>
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

On 7/8/26 23:34, Marc-Olivier Champagne wrote:
> The DSI host must be enabled for the panel to be initialized in
> prepare(). Set the prepare_prev_first flag to guarantee this.
> This fixes the panel operation on Renesas RZ/G2LC SoC DSI host.
> 
> Suggested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Signed-off-by: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
> ---
>   drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> index 1ef0c937863a..a79dc8f8d5af 100644
> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> @@ -2993,6 +2993,8 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
>   		return dev_err_probe(&dsi->dev, PTR_ERR(jadard->vccio),
>   				"failed to get vccio regulator\n");
>   
> +	jadard->panel.prepare_prev_first = true;
> +
>   	ret = of_drm_get_panel_orientation(dev->of_node, &jadard->orientation);
>   	if (ret < 0)
>   		return dev_err_probe(dev, ret, "failed to get orientation\n");

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
