Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EE6CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33C3B10F58A;
	Wed,  7 Oct 2026 13:15:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YgHbQP1m";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9532310F58A
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 13:15:53 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a1698ea378so15449735e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 06:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791378952; x=1791983752; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EW8X3gEVwvz8TnUlSVxnV2D6JKCoagWnFJsGsc4tElU=;
 b=YgHbQP1mRZCHsKInrEQZE8mWheVMu7uy94kItHH852QZtzAddMj21MiKyoJjGWDFMz
 nDojKacVWsITXrMGTWxiw7U1Kleu6OssfwLpsyHiZOPgoA7g7eFh0XZeSrhUg6PAV27U
 CMICBXcLkGoMyta8rRdDRIrt0fk4l/2FzIAOzgmPsfXIrdHnke2X7QVWKPj9NxrnMGlW
 939ByunInGOEC1TZ2o/yiGgxffhQ9ufOgX1NdtW6cMeVPl7paZ/6k5RzuTPxTXTeHYWX
 cQwSNsDzCrSIqOojHyWgPHIWh8d3s91gi3b/7kTx5ioFHiAO2k+UHu+2RWrgH8URkSau
 AM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791378952; x=1791983752;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EW8X3gEVwvz8TnUlSVxnV2D6JKCoagWnFJsGsc4tElU=;
 b=vhqsvw0wrCv1HShWQveJKbnUCT+/DSQuHdsQXNF++sc/x0W2iOULp2pg4NPwOjgflT
 KcsvI/IlpMQVvYGPFSW9FBQuWdbx+J6XP45se8RS824QU/+Aft9no3LEgZnnHpBRnWgH
 ujtXf9+i9tgQBnEYIqhkVCqRdMrPNYqVNvJ1RO0r27PYO62vTdOb1h/mAKRcD+N2yNvW
 0YfE3P40arLQJvlGuvqXSCvIoBM6Cp1hxqIl8aZ81YkprSw/9wWkmrLGw+NhJg3IA+bj
 hnSHNw0oW4BLuh3MovOC9InO1lm/r1tA+tFSbobtRuCMAD635zPAMQ6eacb1fOgph06O
 zi8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzn4D+NshUxxUJ3R8eF68fmLy7RdHFb7K4D6UdPhGZhRC6cSii7+F+31GLyDcjBpSuegTfSHRujhEY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lYY5MX6tq/ThihJFGu74XnfK7ROFB2NJ0B1Hu+eDJ6y6VWKcfQ
 GmAlBBCtYxWGvqm5AiNI9S7K/x5p97LPdeWgLd2qAMPOU3QXmmsLspl/iy1n3lAcZZQ=
X-Gm-Gg: AYBFou2W8OPGcy+N/2aPJA+YS3afFEd6dF0DiaCoSYMQZQoy4nCuXrERRE1mEft7gF2
 xmJ+blCPeKPIe5pxx7HgSARwt7MWVR+mhAzlsdiHEMIkaukSYusxhDOK7yCfrkZk895sv06gwZ8
 eUJ80z9PrnWQ3gejPo0itKHh7UhMQZcrrH0bZfwwNzy24KqN9SB3Fqpsvg8x5/+u0gwJbNOSw4Z
 q11rN0c8xNf7C6pLUouwHB3LLE2HpwHzMpopFBqxv2QJkAYL6hoGxG23/4midaWrcUK83cXkWn/
 5JuIKEOLveZ9HwnkY9FeMw2Vc4DvUMBpld+PhReiMN/Jz8HdrEUfr0xz4Kt1q7OdRcVOzv94V41
 +PcTDFidLBG5K9B8kGzJasKzievZEl70hJYEn5+jiGw2v/ypa9O5Rw0Ko8J5kusN+04GiYf/zuM
 eylVIcMuy6f3cZettBWDwQVPqWLsjonqFd/pr0PPWCL6NBz6Fetn2cssN8p/0fdEwicewmRx6yn
 LOM8rg6oH+Ge1mKTuWOuReAFS49wm3U
X-Received: by 2002:a05:600c:5254:b0:4a0:1b15:8852 with SMTP id
 5b1f17b1804b1-4a180310d31mr34382675e9.16.1791378951771; 
 Wed, 07 Oct 2026 06:15:51 -0700 (PDT)
Received: from [192.168.151.46] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c53997sm218656225e9.12.2026.10.07.06.15.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 06:15:51 -0700 (PDT)
Message-ID: <58c28172-8275-4438-8a74-3cd9e6e0b11a@linaro.org>
Date: Wed, 7 Oct 2026 15:15:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] drm/panel: ilitek-ili9881c: Add DCLTek 300249 5.5in
 display
To: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jerome Oufella <jerome.oufella@savoirfairelinux.com>,
 Felix Boucher <felix.boucher@savoirfairelinux.com>,
 Quentin Lehoux <quentin.lehoux@savoirfairelinux.com>
References: <20261006183455.2350966-1-marc-olivier.champagne@savoirfairelinux.com>
 <20261006183455.2350966-3-marc-olivier.champagne@savoirfairelinux.com>
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
In-Reply-To: <20261006183455.2350966-3-marc-olivier.champagne@savoirfairelinux.com>
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

On 10/6/26 20:34, Marc-Olivier Champagne wrote:
> The DCLTek dt300249 is an LCD panel using the Ilitek ILI9881C controller.
> Add the panel to the driver.
> 
> Suggested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Signed-off-by: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
> ---
>   drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 216 ++++++++++++++++++
>   1 file changed, 216 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> index 7bf38e96678a..acc560dc5ea5 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> @@ -2198,6 +2198,195 @@ static const struct ili9881c_instr waveshare_7inch_a_init[] = {
>   	ILI9881C_COMMAND_INSTR(0x36, 0x00),
>   };
>   
> +static const struct ili9881c_instr dt300249_init[] = {
> +	ILI9881C_SWITCH_PAGE_INSTR(3),
> +	ILI9881C_COMMAND_INSTR(0x01, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x02, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x03, 0x72),
> +	ILI9881C_COMMAND_INSTR(0x04, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x05, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x06, 0x09),
> +	ILI9881C_COMMAND_INSTR(0x07, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x08, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x09, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x0a, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x0b, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x0c, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x0d, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x0e, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x0f, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x10, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x11, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x12, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x13, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x14, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x15, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x16, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x17, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x18, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x19, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x1a, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x1b, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x1c, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x1d, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x1e, 0x40),
> +	ILI9881C_COMMAND_INSTR(0x1f, 0x80),
> +	ILI9881C_COMMAND_INSTR(0x20, 0x05),
> +	ILI9881C_COMMAND_INSTR(0x21, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x22, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x23, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x24, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x25, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x26, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x27, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x28, 0x33),
> +	ILI9881C_COMMAND_INSTR(0x29, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x2a, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x2b, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x2c, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x2d, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x2e, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x2f, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x30, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x31, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x32, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x33, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x34, 0x04),
> +	ILI9881C_COMMAND_INSTR(0x35, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x36, 0x2a),
> +	ILI9881C_COMMAND_INSTR(0x37, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x38, 0x3c),
> +	ILI9881C_COMMAND_INSTR(0x39, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x3a, 0x40),
> +	ILI9881C_COMMAND_INSTR(0x3b, 0x40),
> +	ILI9881C_COMMAND_INSTR(0x3c, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x3d, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x3e, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x3f, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x40, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x41, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x42, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x43, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x44, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x50, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x51, 0x23),
> +	ILI9881C_COMMAND_INSTR(0x52, 0x45),
> +	ILI9881C_COMMAND_INSTR(0x53, 0x67),
> +	ILI9881C_COMMAND_INSTR(0x54, 0x89),
> +	ILI9881C_COMMAND_INSTR(0x55, 0xab),
> +	ILI9881C_COMMAND_INSTR(0x56, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x57, 0x23),
> +	ILI9881C_COMMAND_INSTR(0x58, 0x45),
> +	ILI9881C_COMMAND_INSTR(0x59, 0x67),
> +	ILI9881C_COMMAND_INSTR(0x5a, 0x89),
> +	ILI9881C_COMMAND_INSTR(0x5b, 0xab),
> +	ILI9881C_COMMAND_INSTR(0x5c, 0xcd),
> +	ILI9881C_COMMAND_INSTR(0x5d, 0xef),
> +	ILI9881C_COMMAND_INSTR(0x5e, 0x11),
> +	ILI9881C_COMMAND_INSTR(0x5f, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x60, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x61, 0x15),
> +	ILI9881C_COMMAND_INSTR(0x62, 0x14),
> +	ILI9881C_COMMAND_INSTR(0x63, 0x0e),
> +	ILI9881C_COMMAND_INSTR(0x64, 0x0f),
> +	ILI9881C_COMMAND_INSTR(0x65, 0x0c),
> +	ILI9881C_COMMAND_INSTR(0x66, 0x0d),
> +	ILI9881C_COMMAND_INSTR(0x67, 0x06),
> +	ILI9881C_COMMAND_INSTR(0x68, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x69, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x6a, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x6b, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x6c, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x6d, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x6e, 0x07),
> +	ILI9881C_COMMAND_INSTR(0x6f, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x70, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x71, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x72, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x73, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x74, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x75, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x76, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x77, 0x14),
> +	ILI9881C_COMMAND_INSTR(0x78, 0x15),
> +	ILI9881C_COMMAND_INSTR(0x79, 0x0e),
> +	ILI9881C_COMMAND_INSTR(0x7a, 0x0f),
> +	ILI9881C_COMMAND_INSTR(0x7b, 0x0c),
> +	ILI9881C_COMMAND_INSTR(0x7c, 0x0d),
> +	ILI9881C_COMMAND_INSTR(0x7d, 0x06),
> +	ILI9881C_COMMAND_INSTR(0x7e, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x7f, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x80, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x81, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x82, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x83, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x84, 0x07),
> +	ILI9881C_COMMAND_INSTR(0x85, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x86, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x87, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x88, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x89, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x8a, 0x02),
> +	ILI9881C_SWITCH_PAGE_INSTR(4),
> +	ILI9881C_COMMAND_INSTR(0x6c, 0x15),
> +	ILI9881C_COMMAND_INSTR(0x6e, 0x2a),
> +	ILI9881C_COMMAND_INSTR(0x6f, 0x33),
> +	ILI9881C_COMMAND_INSTR(0x3a, 0x94),
> +	ILI9881C_COMMAND_INSTR(0x8d, 0x1a),
> +	ILI9881C_COMMAND_INSTR(0x87, 0xba),
> +	ILI9881C_COMMAND_INSTR(0x26, 0x76),
> +	ILI9881C_COMMAND_INSTR(0xb2, 0xd1),
> +	ILI9881C_COMMAND_INSTR(0xb5, 0x06),
> +	ILI9881C_SWITCH_PAGE_INSTR(1),
> +	ILI9881C_COMMAND_INSTR(0x22, 0x0a),
> +	ILI9881C_COMMAND_INSTR(0x31, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x53, 0x84),
> +	ILI9881C_COMMAND_INSTR(0x55, 0x8f),
> +	ILI9881C_COMMAND_INSTR(0x50, 0xae),
> +	ILI9881C_COMMAND_INSTR(0x51, 0xae),
> +	ILI9881C_COMMAND_INSTR(0x60, 0x28),
> +	ILI9881C_COMMAND_INSTR(0xa0, 0x0f),
> +	ILI9881C_COMMAND_INSTR(0xa1, 0x1b),
> +	ILI9881C_COMMAND_INSTR(0xa2, 0x28),
> +	ILI9881C_COMMAND_INSTR(0xa3, 0x12),
> +	ILI9881C_COMMAND_INSTR(0xa4, 0x15),
> +	ILI9881C_COMMAND_INSTR(0xa5, 0x28),
> +	ILI9881C_COMMAND_INSTR(0xa6, 0x1b),
> +	ILI9881C_COMMAND_INSTR(0xa7, 0x1e),
> +	ILI9881C_COMMAND_INSTR(0xa8, 0x79),
> +	ILI9881C_COMMAND_INSTR(0xa9, 0x1b),
> +	ILI9881C_COMMAND_INSTR(0xaa, 0x27),
> +	ILI9881C_COMMAND_INSTR(0xab, 0x69),
> +	ILI9881C_COMMAND_INSTR(0xac, 0x19),
> +	ILI9881C_COMMAND_INSTR(0xad, 0x18),
> +	ILI9881C_COMMAND_INSTR(0xae, 0x4c),
> +	ILI9881C_COMMAND_INSTR(0xaf, 0x21),
> +	ILI9881C_COMMAND_INSTR(0xb0, 0x28),
> +	ILI9881C_COMMAND_INSTR(0xb1, 0x52),
> +	ILI9881C_COMMAND_INSTR(0xb2, 0x65),
> +	ILI9881C_COMMAND_INSTR(0xb3, 0x3f),
> +	ILI9881C_COMMAND_INSTR(0xc0, 0x04),
> +	ILI9881C_COMMAND_INSTR(0xc1, 0x1b),
> +	ILI9881C_COMMAND_INSTR(0xc2, 0x27),
> +	ILI9881C_COMMAND_INSTR(0xc3, 0x13),
> +	ILI9881C_COMMAND_INSTR(0xc4, 0x15),
> +	ILI9881C_COMMAND_INSTR(0xc5, 0x28),
> +	ILI9881C_COMMAND_INSTR(0xc6, 0x1c),
> +	ILI9881C_COMMAND_INSTR(0xc7, 0x1e),
> +	ILI9881C_COMMAND_INSTR(0xc8, 0x79),
> +	ILI9881C_COMMAND_INSTR(0xc9, 0x1a),
> +	ILI9881C_COMMAND_INSTR(0xca, 0x27),
> +	ILI9881C_COMMAND_INSTR(0xcb, 0x69),
> +	ILI9881C_COMMAND_INSTR(0xcc, 0x1a),
> +	ILI9881C_COMMAND_INSTR(0xcd, 0x18),
> +	ILI9881C_COMMAND_INSTR(0xce, 0x4c),
> +	ILI9881C_COMMAND_INSTR(0xcf, 0x21),
> +	ILI9881C_COMMAND_INSTR(0xd0, 0x27),
> +	ILI9881C_COMMAND_INSTR(0xd1, 0x52),
> +	ILI9881C_COMMAND_INSTR(0xd2, 0x65),
> +	ILI9881C_COMMAND_INSTR(0xd3, 0x3f),
> +};
> +
>   static inline struct ili9881c *panel_to_ili9881c(struct drm_panel *panel)
>   {
>   	return container_of(panel, struct ili9881c, panel);
> @@ -2493,6 +2682,23 @@ static const struct drm_display_mode waveshare_7inch_a_mode = {
>   	.height_mm	= 154,
>   };
>   
> +static const struct drm_display_mode dt300249_default_mode = {
> +	.clock		= 62000,
> +
> +	.hdisplay	= 720,
> +	.hsync_start	= 720 + 10,	/* HFP = 10 */
> +	.hsync_end	= 720 + 10 + 20,	/* HSYNC = 20 */
> +	.htotal		= 720 + 10 + 20 + 20,	/* HBP = 20, htotal = 770 */
> +
> +	.vdisplay	= 1280,
> +	.vsync_start	= 1280 + 10,	/* VFP = 10 */
> +	.vsync_end	= 1280 + 10 + 10,	/* VSYNC = 10 */
> +	.vtotal		= 1280 + 10 + 10 + 20,	/* VBP = 20, vtotal = 1320 */
> +
> +	.width_mm	= 68,
> +	.height_mm	= 121,
> +};
> +
>   static int ili9881c_get_modes(struct drm_panel *panel,
>   			      struct drm_connector *connector)
>   {
> @@ -2698,9 +2904,19 @@ static const struct ili9881c_desc waveshare_7inch_a_desc = {
>   	.lanes = 2,
>   };
>   
> +static const struct ili9881c_desc dt300249_desc = {
> +	.init = dt300249_init,
> +	.init_length = ARRAY_SIZE(dt300249_init),
> +	.mode = &dt300249_default_mode,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> +		      MIPI_DSI_MODE_LPM,
> +	.lanes = 4,
> +};
> +
>   static const struct of_device_id ili9881c_of_match[] = {
>   	{ .compatible = "bananapi,lhr050h41", .data = &lhr050h41_desc },
>   	{ .compatible = "bestar,bsd1218-a101kl68", .data = &bsd1218_a101kl68_desc },
> +	{ .compatible = "dcltek,dt300249", .data = &dt300249_desc },
>   	{ .compatible = "feixin,k101-im2byl02", .data = &k101_im2byl02_desc },
>   	{ .compatible = "startek,kd050hdfia020", .data = &kd050hdfia020_desc },
>   	{ .compatible = "tdo,tl050hdv35", .data = &tl050hdv35_desc },

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
