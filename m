Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EA8C98314
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 685C510F539;
	Thu, 24 Sep 2026 13:16:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yiqSqWlK";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C6BF10F539
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:16:08 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so11787315e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790255767; x=1790860567; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+czt7/72SlNARTvCjeBzQxzz1TYQqgUflPUYzqR+nLc=;
 b=yiqSqWlKCm25DgpczwjrI3Dm6TeTQLdhnAVjed9ManUM6RX4qOTX5N0fQfagw+/Ope
 HSSR2s3CjSJ8bdxaWrnfS55NxBjlyA7KO+4aP7jAI/zkTdoFTDhNrvH9kv0jPE+c2yAW
 nYP9lM/WxGlt7uSiiO9+GJd5wfPzlrVCCSodwS7TI8q5zZsIjXMjUnMn0kohCGhFVA1/
 IvwVQcPu7XdBBcstXa+P5+amLjqbTHkdEC9X97yj9sACBngKg82wNS/3dAe7Y8xxEEXO
 OuOiZNvw1RbYYid3CrSfKb4a0DyD2UjpjsnYqqA2R88YNoOdNrd0BQXoZC6FsNkzr2Ea
 /khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790255767; x=1790860567;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+czt7/72SlNARTvCjeBzQxzz1TYQqgUflPUYzqR+nLc=;
 b=i9x70ExlZAT4KZXfl8gIcipZRv5MoILxU07ilwBZZcLwO1QY2lQuyfSikwt0KAHIX4
 ED4IWcPKgngTcex/lNfO6eIwPk1rXx3OYY0eVgyow0sJ3/Ll4l1akWqu9EtAQSqr3Hss
 2Et0Q5/QlxdTHl0mKyfactOble2WF+6zBBn/9LfW87oY3wufGDEcwTh0T3Gy6UciLlsf
 tSKBP/4JkiYt0UlQz6DCQdiVU1mTeVVGiR22G98jkYX9YmNTInu/0n3uaeEyU++iP2kd
 C6pzlqi8hNBfJdec2urDGzidjjjez/aQiNv64LS42qQRdGPsVpla9zZQ0NWSUUezjRAQ
 GTlw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYwoDPuqbZ/F1fQ92aVGZtkObU6sR4hv1rO8kSZBEKgM8fQdi76FUccnnR4vYu0TdAZ5dLvbOT0uI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++npbV3fHxX7dPBJo7Bh7yHZcpx4vlydSiKUVVYJdQoyRfsNpxnW
 38zit1WqEiT7yvlVNjqf0wCWfy7CJAr3CLnqqAJDjNvX5XFzH4+BB9RsO7Bx/vhF/FI=
X-Gm-Gg: AYBFou1CM0pok1lFG9+RferFcPB2BEittTS6N2VxUbhXYQmKxnWDhqrtDP+isi4LJN9
 eO0rgoKnDjSaxOxq3GYBQVp5DPXLnApiXwIp+v9fLEM/xMc5gD3b/kyH2KT/L0Jjr/XcqFEA7Bi
 Qb0cUCkLoIMhTx2U/B+9o/u++UtW+jal4hRK7S5nXVW3QAZ7qoiEDaUh8Uxnasl6d+xZ6kTcAKZ
 YJyelXit314xLZWc3zyn3CeJ0mBiHky+dx3oVULtL7b6CblpQFolB+iYULOvDGlsFwsGcYM0DSz
 3uWqD9ufnth1Woej5rUo0us1Y4JEfTr3GomLbPFSQjHSsPThdSLV0rdG+SgnvTRKwXFan+1yqV+
 fbz/fvkj/qWqiE6q/JDFYjbVUMiwwrGjFE2kp3xsgqWPjsJcgs7/bLzXI1WZpAfhBqfbehQqObd
 cYU2KNMdiyRgyMvPEaBuQddDBPzOqYTugcwOO7CTbPCt2E6YViG84EegAtfpXzLGGC1nIBK1TFM
 xhi4ygMTi4Q03q0DUygZ+XYU185WV+YI533EISEvtHB2XeYFdCDA/rgb7q1jUUSTA==
X-Received: by 2002:a05:600c:4689:b0:49f:bc8a:b103 with SMTP id
 5b1f17b1804b1-49fe66841f8mr42447295e9.0.1790255766702; 
 Thu, 24 Sep 2026 06:16:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a?
 ([2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdf9691e2sm140428665e9.1.2026.09.24.06.16.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 06:16:06 -0700 (PDT)
Message-ID: <856dbc37-20cb-42f2-8bfd-675014f7dec8@linaro.org>
Date: Thu, 24 Sep 2026 15:16:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 4/4] drm/panel: ilitek-ili9882t: Add support for Ilitek
 IL79600A-based panels
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 dri-devel@lists.freedesktop.org
Cc: Conor Dooley <conor+dt@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20260910181918.31551-1-marek.vasut+renesas@mailbox.org>
 <20260910181918.31551-4-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20260910181918.31551-4-marek.vasut+renesas@mailbox.org>
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

On 9/10/26 20:18, Marek Vasut wrote:
> The Ilitek IL79600A display controller is similar to the ILI9882T and can
> be supported within the existing `panel-ilitek-ili9882t.c` driver.
> 
> This patch extends the ILI9882T driver to handle IL79600A-based panels,
> such as the 10" Raspberry Pi Touch Display 2. The IL79600A uses a similar
> command sequence and initialization flow, with minor differences in power
> supply configuration and timing.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Jessica Zhang <jesszhan0024@gmail.com>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: devicetree@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: No change
> V3: - Rename ILI79600A to IL79600A, there is really no ILI anymore, just IL
> ---
>   drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 231 ++++++++++++++++++
>   1 file changed, 231 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> index 862b1c81a609b..bea5ca70c775d 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> @@ -133,6 +133,207 @@ static const struct drm_dsc_config tianma_il79900a_dsc = {
>   	.flatness_min_qp = 3,
>   };
>   
> +static int rpi_10inch_init(struct ili9882t *ili)
> +{
> +	struct mipi_dsi_multi_context ctx = { .dsi = ili->dsi };
> +
> +	mipi_dsi_usleep_range(&ctx, 5000, 5100);
> +
> +	il79900a_switch_page(&ctx, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x00, 0x42);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x01, 0x11);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x02, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x03, 0x00);
> +
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x04, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x05, 0x11);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x06, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x07, 0x00);
> +
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x08, 0x80);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x09, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0a, 0x71);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0c, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0e, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0d, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0f, 0x00);
> +
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x30, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x31, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x32, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x33, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x34, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x35, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x36, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x37, 0x28);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x38, 0x29);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x39, 0x11);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3A, 0x13);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3B, 0x15);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3C, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3D, 0x09);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3E, 0x0D);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3F, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x40, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x41, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x42, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x43, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x44, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x45, 0x02);
> +
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x48, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x49, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x4A, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x4B, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x4C, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x4D, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x4E, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x4F, 0x28);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x50, 0x29);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x51, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x52, 0x12);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x53, 0x14);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x54, 0x16);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x55, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x56, 0x0C);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x57, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x58, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x59, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5A, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5B, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5C, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5D, 0x02);
> +
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x2C, 0xB0);
> +
> +	il79900a_switch_page(&ctx, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x07, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x06, 0xD2);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x53, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5E, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x84, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x29, 0x3A);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x2A, 0x3B);
> +
> +	il79900a_switch_page(&ctx, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x20, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x21, 0x3C);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x22, 0xFA);
> +
> +	il79900a_switch_page(&ctx, 0x12);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x87, 0x2C);
> +
> +	il79900a_switch_page(&ctx, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x61, 0x8F);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x6D, 0xBB);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5A, 0x7C);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x67, 0x7C);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x54, 0x92);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x55, 0x92);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x40, 0xD2);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x46, 0x70);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x30, 0x47);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7A, 0x89);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xA4, 0x0B);
> +
> +	il79900a_switch_page(&ctx, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xC0, 0x80);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xC1, 0x7);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xCA, 0x58);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xCB, 0x2);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xCE, 0x58);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xCF, 0x2);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x10, 0x0);
> +
> +	il79900a_switch_page(&ctx, 0x0b);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x76, 0x55);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x78, 0x68);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x77, 0x0D);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x79, 0x60);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x7A, 0x10);
> +
> +	il79900a_switch_page(&ctx, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&ctx,
> +				     0xE0, 0x00, 0x1E, 0x3F,
> +				     0x68, 0x7D, 0x72, 0x86,
> +				     0x89, 0x92, 0x8E, 0xA5,
> +				     0xA8, 0xAA, 0xBD, 0xB8,
> +				     0xBE, 0xC5, 0xD6, 0xCD,
> +				     0xC3, 0xDA, 0xEB, 0xED);
> +	mipi_dsi_dcs_write_seq_multi(&ctx,
> +				     0xE1, 0x00, 0x1E, 0x3F,
> +				     0x68, 0x7D, 0x72, 0x86,
> +				     0x89, 0x92, 0x8E, 0xA5,
> +				     0xA8, 0xAA, 0xBD, 0xB8,
> +				     0xBE, 0xC5, 0xD6, 0xCD,
> +				     0xC3, 0xDA, 0xEB, 0xED);
> +
> +	il79900a_switch_page(&ctx, 0x14);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x85, 0xCC);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x87, 0x91);
> +
> +	il79900a_switch_page(&ctx, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x11, 0x3);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x12, 0x34);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x10, 0x1);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x13, 0x4);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x14, 0xBB);
> +
> +	il79900a_switch_page(&ctx, 0x0b);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x94, 0x88);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x95, 0x23);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x96, 0x0B);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x97, 0x0B);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x98, 0xC6);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x99, 0xC6);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xA6, 0x47);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xA7, 0x77);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xA8, 0x5);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xA9, 0x5);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xAA, 0xBA);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xAB, 0xBA);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xBD, 0x92);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0xBE, 0xE0);
> +
> +	il79900a_switch_page(&ctx, 0x0e);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0, 0x80);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x14, 0x3);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x12, 0x0);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x13, 0x4);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x11, 0x1);
> +
> +	il79900a_switch_page(&ctx, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x80, 0x11);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x82, 0x11);
> +	il79900a_switch_page(&ctx, 0x12);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x82, 0x2C);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x85, 0x2C);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x87, 0x2C);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x88, 0xEC);
> +	il79900a_switch_page(&ctx, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x4, 0x1);
> +	il79900a_switch_page(&ctx, 0x11);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0C, 0x80);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3C, 0x80);
> +
> +	il79900a_switch_page(&ctx, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0E, 0x0);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0E, 0x3F);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, 0x10, 0x0);
> +
> +	il79900a_switch_page(&ctx, 0x00);
> +	mipi_dsi_dcs_set_tear_on_multi(&ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&ctx);
> +
> +	mipi_dsi_msleep(&ctx, 120);
> +
> +	mipi_dsi_dcs_set_display_on_multi(&ctx);
> +
> +	mipi_dsi_msleep(&ctx, 20);
> +
> +	return ctx.accum_err;
> +};
> +
>   static int starry_ili9882t_init(struct ili9882t *ili)
>   {
>   	struct mipi_dsi_multi_context ctx = { .dsi = ili->dsi };
> @@ -670,6 +871,19 @@ static int ili9882t_enable(struct drm_panel *panel)
>   	return 0;
>   }
>   
> +static const struct drm_display_mode rpi_10inch_default_mode = {
> +	.clock = 166666,
> +	.hdisplay = 1200,
> +	.hsync_start = 1200 + 28,
> +	.hsync_end = 1200 + 28 + 10,
> +	.htotal = 1200 + 28 + 10 + 30,
> +	.vdisplay = 1920,
> +	.vsync_start = 1920 + 238,
> +	.vsync_end = 1920 + 238 + 4,
> +	.vtotal = 1920 + 238 + 4 + 28,
> +	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +};
> +
>   static const struct drm_display_mode starry_ili9882t_default_mode = {
>   	.clock = 165280,
>   	.hdisplay = 1200,
> @@ -696,6 +910,20 @@ static const struct drm_display_mode tianma_il79900a_default_mode = {
>   	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
>   };
>   
> +static const struct panel_desc rpi_10inch_desc = {
> +	.modes = &rpi_10inch_default_mode,
> +	.bpc = 8,
> +	.size = {
> +		.width_mm = 135,
> +		.height_mm = 216,
> +	},
> +	.lanes = 4,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> +		      MIPI_DSI_MODE_LPM,
> +	.init = rpi_10inch_init,
> +};
> +
>   static const struct panel_desc starry_ili9882t_desc = {
>   	.modes = &starry_ili9882t_default_mode,
>   	.bpc = 8,
> @@ -847,6 +1075,9 @@ static int ili9882t_probe(struct mipi_dsi_device *dsi)
>   }
>   
>   static const struct of_device_id ili9882t_of_match[] = {
> +	{ .compatible = "raspberrypi,dsi-10inch",
> +	  .data = &rpi_10inch_desc
> +	},
>   	{ .compatible = "starry,ili9882t",
>   	  .data = &starry_ili9882t_desc
>   	},

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
