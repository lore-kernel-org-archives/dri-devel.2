Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31E2C4452A
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:39:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E36810E196;
	Mon, 20 Jul 2026 12:39:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qppplrcz";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F254110E196
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 12:39:44 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49557167508so15745345e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 05:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784551183; x=1785155983; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L5zUponltIjn1ApAM74wz7JqTYwcqK5nj1eOLyYOd1c=;
 b=qppplrczxbBy5HmLMDzKGQtbJo05NELGv86ytZfDIL7G5SLBYDkp0OTH+3LLP6bIGC
 jgO6/pOZMTDnzzdg8d65/XuOm6sZWz9UpV68xco/Mzs1FwZUWJ5edJJxwiah5Q0T/6w1
 CAOufN7x2iMVl2v18rrqGTOiQjlliHHygZFK6Kgn89+n6ZlAUwFFUTWrFGKj9csbPNck
 WkB7V91/Fc3SE6Ef9mNlZU92aIP/68UCPj8ZHoQYRxBgnagPI/Z8ZaH5z6ch87DYN4vm
 jNyq8EgvQOcfEyu2ynFmmo6rLgnNdKaDVXud2DhSFeEQUnPHnpq3CLrdOPWRvpOTegHV
 7PWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784551183; x=1785155983;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=L5zUponltIjn1ApAM74wz7JqTYwcqK5nj1eOLyYOd1c=;
 b=UVpbxqGQ87iiDlPmVPdocmLZBeuAVwT79dhPOpl+MlOQeLF636mLTU35FmpMvRDchH
 /LT1XdgteWNyDzZMKQ+A7Leq6vzFw6vN/tJEtIYQHox65eB/RmuBNSs3t+mTOZsyp4No
 5Y9syeh23I0RtQu7N78UDc+3K2b5A2NBEP48B7K/6CO1BE05oGNF/C3TVAOosSYkYa1w
 Se/FNDzMffQ9MXmnrxH9AqWdj0FFszPt+yHSMiam6yipVVtmSgRYD4d0uDDJM5xnRhi8
 Pfcr4uhllq4iE3SzXI5JEXsFOz9S1s/VrL37rjhwWAVmKR5E6Z428GGtJUAGvDCSMJD0
 8sQA==
X-Gm-Message-State: AOJu0YxXArpexg2Swf44aA41qN4Ml/VHUezMjc96QVBirvUEJ9inti/j
 Npb4xlAtEp7bTHuCQDu4IzuOBjUhisNutCgAqEfF6clXAafmqsO6cINeejyzdQVPyJKG/7cNgLr
 j0L47Jzk=
X-Gm-Gg: AfdE7cl+vNofkTLaLFD6pDuGy+melNsCdwZvz172Yee/zIxTdT1KkVH7JfE5K0pHBRx
 +8FFceYg7DSwCFMAtk///3Gny6CIOVkcm3CE8I36H8+XCZI+LDvbUMBV8vuQxx11RqEEnzBB/xE
 pq1rUtlf0Eq5oc2PKtONy4LtaE5QPJkKcYnxm2rnuvJEwTfglwuTZQZmxf84WS2wTz7TK05UJw4
 f9SDjha9unitu1sXqTFHSO8x9DMuEwPC7umVpVxf666fkBxhWaWgcYi3+rU2IYBU5mkb2K0Shhe
 FCDx/fnVnjmFfGCuQdznNZLTAQyTLk7sh31i9MJ1v/P6OSQlIitmZpkFmPC0fw0Hkz07K1KZfqc
 pauAcjWAY0cs4f3M3X4PU942ltobSHK5j9gMQau440EV3pTmVux5qErh01fAiHarn5fmpRZ0sJn
 qSkVxHYxujUUjeusYeJV+FG7peILYyDfId3Qid/kUzBodNXNu6otO2D/ab/g==
X-Received: by 2002:a05:600c:63c5:b0:495:5d5b:7533 with SMTP id
 5b1f17b1804b1-4955d5b760fmr41009505e9.13.1784551183085; 
 Mon, 20 Jul 2026 05:39:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:544a:2852:f257:ebc5?
 ([2a01:e0a:106d:1080:544a:2852:f257:ebc5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49563eee22esm18488705e9.1.2026.07.20.05.39.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 05:39:42 -0700 (PDT)
Message-ID: <c03c3574-4df1-4fdc-9a7f-2f1736b8e261@linaro.org>
Date: Mon, 20 Jul 2026 14:39:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/3] drm/panel: ilitek-ili9805: Use dsi_multi in init
To: Michail Tatas <michail.tatas@gmail.com>, michael@amarulasolutions.com,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dianders@chromium.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260719190358.438699-1-michail.tatas@gmail.com>
 <20260719190358.438699-3-michail.tatas@gmail.com>
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
In-Reply-To: <20260719190358.438699-3-michail.tatas@gmail.com>
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

On 7/19/26 21:03, Michail Tatas wrote:
> Drop the struct ili9805_instr and the init table
> and use init functions.
> 
> Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 156 +++++++++----------
>   1 file changed, 73 insertions(+), 83 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
> index 7e9587afebbe..a70b9512746a 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
> @@ -25,22 +25,9 @@
>   #define ILI9805_SETEXTC_PARAMETER2		(0x98)
>   #define ILI9805_SETEXTC_PARAMETER3		(0x05)
>   
> -#define ILI9805_INSTR(_delay, ...) { \
> -		.delay = (_delay), \
> -		.len = sizeof((u8[]) {__VA_ARGS__}), \
> -		.data = (u8[]){__VA_ARGS__} \
> -	}
> -
> -struct ili9805_instr {
> -	size_t len;
> -	const u8 *data;
> -	u32 delay;
> -};
> -
>   struct ili9805_desc {
>   	const char *name;
> -	const struct ili9805_instr *init;
> -	const size_t init_length;
> +	void (*init)(struct mipi_dsi_multi_context *ctx);
>   	const struct drm_display_mode *mode;
>   	u32 width_mm;
>   	u32 height_mm;
> @@ -56,65 +43,78 @@ struct ili9805 {
>   	struct gpio_desc	*reset_gpio;
>   };
>   
> -static const struct ili9805_instr gpm1780a0_init[] = {
> -	ILI9805_INSTR(100, ILI9805_EXTCMD_CMD_SET_ENABLE_REG, ILI9805_SETEXTC_PARAMETER1,
> -		      ILI9805_SETEXTC_PARAMETER2, ILI9805_SETEXTC_PARAMETER3),
> -	ILI9805_INSTR(100, 0xFD, 0x0F, 0x10, 0x44, 0x00),
> -	ILI9805_INSTR(0, 0xf8, 0x18, 0x02, 0x02, 0x18, 0x02, 0x02, 0x30, 0x00,
> -		      0x00, 0x30, 0x00, 0x00, 0x30, 0x00, 0x00),
> -	ILI9805_INSTR(0, 0xB8, 0x62),
> -	ILI9805_INSTR(0, 0xF1, 0x00),
> -	ILI9805_INSTR(0, 0xF2, 0x00, 0x58, 0x40),
> -	ILI9805_INSTR(0, 0xF3, 0x60, 0x83, 0x04),
> -	ILI9805_INSTR(0, 0xFC, 0x04, 0x0F, 0x01),
> -	ILI9805_INSTR(0, 0xEB, 0x08, 0x0F),
> -	ILI9805_INSTR(0, 0xe0, 0x00, 0x08, 0x0d, 0x0e, 0x0e, 0x0d, 0x0a, 0x08, 0x04,
> -		      0x08, 0x0d, 0x0f, 0x0b, 0x1c, 0x14, 0x0a),
> -	ILI9805_INSTR(0, 0xe1, 0x00, 0x08, 0x0d, 0x0e, 0x0e, 0x0d, 0x0a, 0x08, 0x04,
> -		      0x08, 0x0d, 0x0f, 0x0b, 0x1c, 0x14, 0x0a),
> -	ILI9805_INSTR(10, 0xc1, 0x13, 0x39, 0x19, 0x06),
> -	ILI9805_INSTR(10, 0xc7, 0xe5),
> -	ILI9805_INSTR(10, 0xB1, 0x00, 0x12, 0x14),
> -	ILI9805_INSTR(10, 0xB4, 0x02),
> -	ILI9805_INSTR(0, 0xBB, 0x14, 0x55),
> -	ILI9805_INSTR(0, MIPI_DCS_SET_ADDRESS_MODE, 0x08),
> -	ILI9805_INSTR(0, MIPI_DCS_SET_PIXEL_FORMAT, 0x77),
> -	ILI9805_INSTR(0, 0x20),
> -	ILI9805_INSTR(0, 0xB0, 0x01),
> -	ILI9805_INSTR(0, 0xB6, 0x31, 0x00, 0xef),
> -	ILI9805_INSTR(0, 0xDF, 0x23),
> -	ILI9805_INSTR(0, 0xB9, 0x02, 0x00),
> -};
> +static void gpm1780a0_init(struct mipi_dsi_multi_context *ctx)
> +{
> +	mipi_dsi_dcs_write_seq_multi(ctx, ILI9805_EXTCMD_CMD_SET_ENABLE_REG, ILI9805_SETEXTC_PARAMETER1,
> +							ILI9805_SETEXTC_PARAMETER2, ILI9805_SETEXTC_PARAMETER3);
> +	mipi_dsi_msleep(ctx, 100);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xFD, 0x0F, 0x10, 0x44, 0x00);
> +	mipi_dsi_msleep(ctx, 100);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xf8, 0x18, 0x02, 0x02, 0x18, 0x02, 0x02, 0x30, 0x00,
> +							0x00, 0x30, 0x00, 0x00, 0x30, 0x00, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xB8, 0x62);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xF1, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xF2, 0x00, 0x58, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xF3, 0x60, 0x83, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xFC, 0x04, 0x0F, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xEB, 0x08, 0x0F);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xe0, 0x00, 0x08, 0x0d, 0x0e, 0x0e, 0x0d, 0x0a, 0x08, 0x04,
> +							0x08, 0x0d, 0x0f, 0x0b, 0x1c, 0x14, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xe1, 0x00, 0x08, 0x0d, 0x0e, 0x0e, 0x0d, 0x0a, 0x08, 0x04,
> +							0x08, 0x0d, 0x0f, 0x0b, 0x1c, 0x14, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xc1, 0x13, 0x39, 0x19, 0x06);
> +	mipi_dsi_msleep(ctx, 10);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xc7, 0xe5);
> +	mipi_dsi_msleep(ctx, 10);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xB1, 0x00, 0x12, 0x14);
> +	mipi_dsi_msleep(ctx, 10);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xB4, 0x02);
> +	mipi_dsi_msleep(ctx, 10);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xBB, 0x14, 0x55);
> +	mipi_dsi_dcs_write_seq_multi(ctx, MIPI_DCS_SET_ADDRESS_MODE, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(ctx, MIPI_DCS_SET_PIXEL_FORMAT, 0x77);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xB0, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xB6, 0x31, 0x00, 0xef);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xDF, 0x23);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xB9, 0x02, 0x00);
> +}
>   
> -static const struct ili9805_instr tm041xdhg01_init[] = {
> -	ILI9805_INSTR(100, ILI9805_EXTCMD_CMD_SET_ENABLE_REG, ILI9805_SETEXTC_PARAMETER1,
> -		      ILI9805_SETEXTC_PARAMETER2, ILI9805_SETEXTC_PARAMETER3),
> -	ILI9805_INSTR(100, 0xFD, 0x0F, 0x13, 0x44, 0x00),
> -	ILI9805_INSTR(0, 0xf8, 0x18, 0x02, 0x02, 0x18, 0x02, 0x02, 0x30, 0x01,
> -		      0x01, 0x30, 0x01, 0x01, 0x30, 0x01, 0x01),
> -	ILI9805_INSTR(0, 0xB8, 0x74),
> -	ILI9805_INSTR(0, 0xF1, 0x00),
> -	ILI9805_INSTR(0, 0xF2, 0x00, 0x58, 0x40),
> -	ILI9805_INSTR(0, 0xFC, 0x04, 0x0F, 0x01),
> -	ILI9805_INSTR(0, 0xEB, 0x08, 0x0F),
> -	ILI9805_INSTR(0, 0xe0, 0x01, 0x0d, 0x15, 0x0e, 0x0f, 0x0f, 0x0b, 0x08, 0x04,
> -		      0x07, 0x0a, 0x0d, 0x0c, 0x15, 0x0f, 0x08),
> -	ILI9805_INSTR(0, 0xe1, 0x01, 0x0d, 0x15, 0x0e, 0x0f, 0x0f, 0x0b, 0x08, 0x04,
> -		      0x07, 0x0a, 0x0d, 0x0c, 0x15, 0x0f, 0x08),
> -	ILI9805_INSTR(10, 0xc1, 0x15, 0x03, 0x03, 0x31),
> -	ILI9805_INSTR(10, 0xB1, 0x00, 0x12, 0x14),
> -	ILI9805_INSTR(10, 0xB4, 0x02),
> -	ILI9805_INSTR(0, 0xBB, 0x14, 0x55),
> -	ILI9805_INSTR(0, MIPI_DCS_SET_ADDRESS_MODE, 0x0a),
> -	ILI9805_INSTR(0, MIPI_DCS_SET_PIXEL_FORMAT, 0x77),
> -	ILI9805_INSTR(0, 0x20),
> -	ILI9805_INSTR(0, 0xB0, 0x00),
> -	ILI9805_INSTR(0, 0xB6, 0x01),
> -	ILI9805_INSTR(0, 0xc2, 0x11),
> -	ILI9805_INSTR(0, 0x51, 0xFF),
> -	ILI9805_INSTR(0, 0x53, 0x24),
> -	ILI9805_INSTR(0, 0x55, 0x00),
> -};
> +static void tm041xdhg01_init(struct mipi_dsi_multi_context *ctx)
> +{
> +	mipi_dsi_dcs_write_seq_multi(ctx, ILI9805_EXTCMD_CMD_SET_ENABLE_REG, ILI9805_SETEXTC_PARAMETER1,
> +							ILI9805_SETEXTC_PARAMETER2, ILI9805_SETEXTC_PARAMETER3);
> +	mipi_dsi_msleep(ctx, 100);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xFD, 0x0F, 0x13, 0x44, 0x00);
> +	mipi_dsi_msleep(ctx, 100);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xf8, 0x18, 0x02, 0x02, 0x18, 0x02, 0x02, 0x30, 0x01,
> +							0x01, 0x30, 0x01, 0x01, 0x30, 0x01, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xB8, 0x74);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xF1, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xF2, 0x00, 0x58, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xFC, 0x04, 0x0F, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xEB, 0x08, 0x0F);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xe0, 0x01, 0x0d, 0x15, 0x0e, 0x0f, 0x0f, 0x0b, 0x08, 0x04,
> +							0x07, 0x0a, 0x0d, 0x0c, 0x15, 0x0f, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xe1, 0x01, 0x0d, 0x15, 0x0e, 0x0f, 0x0f, 0x0b, 0x08, 0x04,
> +							0x07, 0x0a, 0x0d, 0x0c, 0x15, 0x0f, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xc1, 0x15, 0x03, 0x03, 0x31);
> +	mipi_dsi_msleep(ctx, 10);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xB1, 0x00, 0x12, 0x14);
> +	mipi_dsi_msleep(ctx, 10);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xB4, 0x02);
> +	mipi_dsi_msleep(ctx, 10);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xBB, 0x14, 0x55);
> +	mipi_dsi_dcs_write_seq_multi(ctx, MIPI_DCS_SET_ADDRESS_MODE, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(ctx, MIPI_DCS_SET_PIXEL_FORMAT, 0x77);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xB0, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xB6, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0xc2, 0x11);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x51, 0xFF);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x53, 0x24);
> +	mipi_dsi_dcs_write_seq_multi(ctx, 0x55, 0x00);
> +}
>   
>   static inline struct ili9805 *panel_to_ili9805(struct drm_panel *panel)
>   {
> @@ -160,16 +160,8 @@ static int ili9805_power_off(struct ili9805 *ctx)
>   static int ili9805_activate(struct ili9805 *ctx)
>   {
>   	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> -	int i;
>   
> -	for (i = 0; i < ctx->desc->init_length; i++) {
> -		const struct ili9805_instr *instr = &ctx->desc->init[i];
> -
> -		mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, instr->data, instr->len);
> -
> -		if (instr->delay > 0)
> -			mipi_dsi_msleep(&dsi_ctx, instr->delay);
> -	}
> +	ctx->desc->init(&dsi_ctx);
>   
>   	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>   	mipi_dsi_usleep_range(&dsi_ctx, 5000, 6000);
> @@ -343,7 +335,6 @@ static void ili9805_dsi_remove(struct mipi_dsi_device *dsi)
>   
>   static const struct ili9805_desc gpm1780a0_desc = {
>   	.init = gpm1780a0_init,
> -	.init_length = ARRAY_SIZE(gpm1780a0_init),
>   	.mode = &gpm1780a0_timing,
>   	.width_mm = 65,
>   	.height_mm = 65,
> @@ -351,7 +342,6 @@ static const struct ili9805_desc gpm1780a0_desc = {
>   
>   static const struct ili9805_desc tm041xdhg01_desc = {
>   	.init = tm041xdhg01_init,
> -	.init_length = ARRAY_SIZE(tm041xdhg01_init),
>   	.mode = &tm041xdhg01_timing,
>   	.width_mm = 42,
>   	.height_mm = 96,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
