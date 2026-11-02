Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB30606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iW7hgCsG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA1BF10EDCB;
	Mon,  2 Nov 2026 13:06:43 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54D0710EDEF
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:06:38 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso1793993f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793624797; x=1794229597; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yfR/i7hbDTZSQ2eYRf8n8O8zPjvztuU6httsCjBeO3Y=;
 b=iW7hgCsGiH6Dz1/pZ7Ct+YwRgO7xvnxoobdiX+0KWwoYx2OznGa3ldF8e5YoTwwoAg
 NJK2P7oRsRFumnraeI/AapOM2UPCHyb/dP6E8RiwlUyVsFwcFdLgSujKzJrpGM5ErFIu
 Ac9dk23Fw7n9GE/bfPjwmpnhYFtAKxFzEKNn6poZI0PJziysqo/j9YXkbkD+pbhRVoRx
 7eT0r+TRaGVnWdDjCKNG8PgKrw0dhfXhuFJztNry5LJeHOHDYXpfOeFl41fVCt5e7xbh
 HokXTLRc+1PlL9uShaFZdgV+fQEOxJW6Irvny8lL40ISlHGpWVgEVlGRC3velI7hHibp
 W37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793624797; x=1794229597;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yfR/i7hbDTZSQ2eYRf8n8O8zPjvztuU6httsCjBeO3Y=;
 b=27ctniRWAqbQeE7uMWfJmr5DwoG+oC+V0XIv2HfCSpC+pN8I2USviOGidDb5/HLdFZ
 EaWEUNb0BiO6sgvfOuOyRTp4aO8xXblZlQJK1uK1+piS8nxHn+EPVLxjnw87XVzJ1/Y0
 3FJrbVweoG9FqlVJ1b8qxLb/SLOEq2cg/GKIj83hvIn8rCJQlXCWg+un4tpqcdO2YfKZ
 SknhVWP6+P0fDs8enkFk9dYgBqZF+9P0C9rkhI8KEAX/Wthb4HhAlQGnh2iVoHFSfEMK
 03vCo+tVsFuy9Vxjnc0Bv7eKXsBn7cWoPjBn3MXdgKA1G0zOB6qccdRuyLMSFUK6QuRP
 WKng==
X-Forwarded-Encrypted: i=1;
 AKwUvBz74xGgtihmt+9I+dtII1+SrmGQRsv8dAlVbfL17JQpgMwOQq3gTsu/WkyI3Pu/h0nMmJFOCA2uBug=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK4htpqV8t2VF1lxx0JWO+2trFoivp4rRY4N18H20JhscZb7Niv
 3q6/zJMKYLLJ/DB8G3naG7sGjfUg2hSrepIagimI7V2HHCZgMM4sogDAIVT2qgkluv0=
X-Gm-Gg: AYBFou2mAZRp4oneAWpRNBnU9KUM4KFW9OmwOV/wL2w7vSCOIJBHIUvb2D3cpPeL2lH
 VsJwjFTNqGJ15MRx995BPXTthqNOEUfoVy2LZsVuB1TtOQxN94rfa7oh2HFuJ8MmH45bE7nhf1X
 bkBId35+odmnKjXQNuPgLWZ2YTToGLP1BcfdlIaML2ss1cZbATgLvVqixqZu8Qc7qq6cofM5RQv
 6Cs5O2XPkySjyOZ66M3anE8NKfCrHlLJSiYhlO4HHLtYAVEu2ZTMdWDz0w8eaMQshSazDDxaWMX
 cuSmwadWO5TPaaR5AANEdKGDuij7umIjOi55prdNwggatww7DaFlImBBXt/zWg60Sj0YVNh2OZv
 OXkwBlN0A3DYkfrMqxxFYCSHWV8aiG2x98JvGz5dXq/XQALCUWQW7cX2N+x+cDcTVSHBKRyTxei
 LRtmQaK5O8y2r3GtA7hdz0m1nkzpCUIcTqrfb0vtP5qTuco8v2LhAkP4W8UkIpIsAJbu9iTuOvj
 3KLFzjTjAlLqjLsTzeCr6PF1vzDQlTPNg52HKR+I2pTXhlx6uh+VBup507yquF80ascmd2j2wM4
 FiGK2TWK8U/ccueGCJsCWzp4X8Z1Lpp//U5h61XbBwJCpVQfO2SBQnJZO2Eu93FrvEbA8q3rB4z
 cLE+TCA==
X-Received: by 2002:a05:600c:5397:b0:4a4:7a8d:c736 with SMTP id
 5b1f17b1804b1-4ac16acfceamr220111445e9.9.1793624796374; 
 Mon, 02 Nov 2026 05:06:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9476:5165:3a16:262?
 ([2a01:e0a:106d:1080:9476:5165:3a16:262])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba7168sm21696052f8f.55.2026.11.02.05.06.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 05:06:35 -0800 (PST)
Message-ID: <c456f163-2309-425e-90c8-66380f8174ed@linaro.org>
Date: Mon, 2 Nov 2026 14:06:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 4/4] drm/panel: ilitek-ili9881c: do a soft reset in
 unprepare callback
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Icenowy Zheng <uwu@icenowy.me>,
 Han Gao <gaohan@iscas.ac.cn>
References: <20261030-mj070bi30ia2-v1-0-a0f65b65c290@iscas.ac.cn>
 <20261030-mj070bi30ia2-v1-4-a0f65b65c290@iscas.ac.cn>
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
In-Reply-To: <20261030-mj070bi30ia2-v1-4-a0f65b65c290@iscas.ac.cn>
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

On 10/30/26 06:44, Icenowy Zheng wrote:
> In case of neither reset pin nor switchable power supply is available,
> the LCD module could be DC polarized (which is harmful) when the MIPI
> DSI host is shut down.
> 
> It seems that do a soft reset for the LCD controller could stop the LCD
> controller from biasing the liquid crystal, thus preventing the harm.
> 
> Add a soft reset after putting the LCD controller into sleep mode.
> 
> Tested on a Sipeed Lichee Console 4A, which has no LCD reset pin, and
> the LCD supply is an always-on one.
> 
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ---
>   drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> index 83148c40e25ca..8b874c6f7d37c 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> @@ -2493,6 +2493,10 @@ static int ili9881c_unprepare(struct drm_panel *panel)
>   
>   	mipi_dsi_dcs_set_display_off_multi(&mctx);
>   	mipi_dsi_dcs_enter_sleep_mode_multi(&mctx);
> +	mipi_dsi_msleep(&mctx, 120);
> +	mipi_dsi_dcs_soft_reset_multi(&mctx);
> +	mipi_dsi_msleep(&mctx, 5);
> +
>   	regulator_disable(ctx->power);
>   	if (ctx->iovcc)
>   		regulator_disable(ctx->iovcc);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
