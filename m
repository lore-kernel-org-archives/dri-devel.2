Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499B5F99C65
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 20:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C15810E123;
	Fri, 17 Apr 2026 20:44:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DO9GzH3F";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9332A10E123
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 20:44:00 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4890098abbaso2097195e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 13:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776458639; x=1777063439; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=GykXHjP8M0rUgHOGzpq0qNFdXJfF+fQqp16aXUB0wy4=;
 b=DO9GzH3F0N7im8JPBDWAFypPryJ0frcQuwGEQeRt7SW33q6UepG3DcwoiGzlVgsE58
 RJ131PuDwXk9Fm+PGATjys5F1hzQRJQtpeZxZZcQPTZQpm6yFczHPAJj+jqwn45qCVcL
 oKRvaamqXWCuAZsgsFQOkSGeOCBXcfDlAzF1Cju7LEyLjJsHttCFVKP8Sgcb2oSk8MsF
 pzz3Jv51hny0mBfb3NhNvzNgqVTw5jL0QtXVkVBh57W1GpR/rJIezdT8DyOOHVnksgl8
 uh9xC0C+YJw/yLxHRmR9ZMsRx1xgrnLJ8c5s4h65Cm0kE8QM4sVK8isOEHtqm90zmp07
 qtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776458639; x=1777063439;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GykXHjP8M0rUgHOGzpq0qNFdXJfF+fQqp16aXUB0wy4=;
 b=Xo5xEkKNtwXCzTqDDsFy6HNIKJVqgQ3GZJNfRke1OOhv42wGtiybBrc2Vo9w5tJgS1
 OzwkDmUsC4R8JsEJSeWZ1F3BHo3rC+PBCgAhflf2ASa0z3TO7+7ob9JfTkxVTCvr1BNq
 hg5Wpd92DHTYEj0zyCHoWymMV50JZpCHxW9SNbB13i65X1Z9vvD0OxbWtekqlszkxF69
 WFnb7mW1tWOFlx4xx1hgioV1ke/mj/VFTyYW0mwJ3UVWc0ELdATMa9m69fD1GdQW/e1F
 Y0HVt3ARdU3zYqYaxTbMzkUsP44nUZ7rClHMx5uLD7fEG+RY0SllegRUmbVfqlC1aGD0
 1I5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/WR+fngZuHggjqSKdrCAYOR6muIo6p/A3beFGfDia6rjgkIAezqaeVC7IAvvF6lU29f8v+dHBWpi0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwkLes2IJS1qBCGdHbbVFXU3ilV03EyQzbqHJa59xnjrfQmXGWK
 tWpZqxM/4oTEYsZ//9Qt3w0l7godZ+ayawBtbNWY75ZI9yKdk32rBWV4xDvltkQlCps=
X-Gm-Gg: AeBDievEZPEjTgwCMjC2Ws96vL3ALSFnuphHV8cMyCG694Fl44VGZxVHri4YxczumaI
 Iw3kgG0bNNNNEnOVq4/hQ2gugaijX8Q3FEa9XPwCdEQ+7KI7dcy/jj/a6PvE74I9oTAZdKv5CkG
 TDwUKZD1vd4333iOSBrXqJo5W4cGM6vg7ixdMkSMHKr2Utoe4BMWTPY1OVZBF8P0BPLpBG82x67
 VElUdUH5caQKlHJ+wvrsNmiDFYs9Oxle70jtviVBwm4sLuJWpZEJEfohcLavKx0By1mvpIQW92/
 q0jbZVk++DZUw7wRLI+SwRz+eHcHw+bQ+xxCsgmiF6WlcZnDmQotDKNXPuriQEEqKoLsmkFfG4D
 Kb/5/F6r8wyslcOohiZnuMxHu5tEehWJl1aWYn2567voeyWY+VBJwFJoZ2fVhRhWvaMkxVNATqY
 CYqixYoiQfbix0mr1ExREZUruAK4Zv6Tjg9kKx/bADaaD2MU/i4O/cM8i804zD0i0/QP+h9GpJx
 et/Fts1D2S1V3kEfLkBD8d+8g==
X-Received: by 2002:a05:600c:3515:b0:488:8b99:54a1 with SMTP id
 5b1f17b1804b1-488fb78e7c5mr57434415e9.28.1776458638883; 
 Fri, 17 Apr 2026 13:43:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:5eba:ccd:a999:f2b3?
 ([2a01:e0a:106d:1080:5eba:ccd:a999:f2b3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb6e0b15sm25517385e9.0.2026.04.17.13.43.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 13:43:58 -0700 (PDT)
Message-ID: <84c654d7-2777-49ba-a7e2-1f80e9efe7aa@linaro.org>
Date: Fri, 17 Apr 2026 22:43:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 1/2] drm/mipi-dsi: add
 mipi_dsi_shutdown_peripheral_multi
To: Avinal Kumar <avinal.xlvii@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dianders@chromium.org
Cc: lumag@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
References: <20260417061842.66631-1-avinal.xlvii@gmail.com>
 <20260417061842.66631-2-avinal.xlvii@gmail.com>
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
In-Reply-To: <20260417061842.66631-2-avinal.xlvii@gmail.com>
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

On 4/17/26 08:18, Avinal Kumar wrote:
> Add mipi_dsi_shutdown_peripheral_multi function and mark
> mipi_dsi_shutdown_peripheral function as deprecated.
> 
> Signed-off-by: Avinal Kumar <avinal.xlvii@gmail.com>
> ---
>   drivers/gpu/drm/drm_mipi_dsi.c | 28 ++++++++++++++++++++++++++++
>   include/drm/drm_mipi_dsi.h     |  1 +
>   2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> index 0390e14d3157..3ac1dd5ad640 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -587,6 +587,9 @@ EXPORT_SYMBOL(mipi_dsi_create_packet);
>    * mipi_dsi_shutdown_peripheral() - sends a Shutdown Peripheral command
>    * @dsi: DSI peripheral device
>    *
> + * This function is deprecated. Use mipi_dsi_shutdown_peripheral_multi()
> + * instead.
> + *
>    * Return: 0 on success or a negative error code on failure.
>    */
>   int mipi_dsi_shutdown_peripheral(struct mipi_dsi_device *dsi)
> @@ -1980,6 +1983,31 @@ void mipi_dsi_dcs_set_tear_scanline_multi(struct mipi_dsi_multi_context *ctx,
>   }
>   EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_scanline_multi);
>   
> +/**
> + * mipi_dsi_shutdown_peripheral_multi() - sends a Shutdown Peripheral command
> + * @ctx: Context for multiple DSI transactions
> + *
> + * Like mipi_dsi_shutdown_peripheral() but deals with errors in a way that
> + * makes it convenient to make several calls in a row.
> + */
> +void mipi_dsi_shutdown_peripheral_multi(struct mipi_dsi_multi_context *ctx)
> +{
> +	struct mipi_dsi_device *dsi = ctx->dsi;
> +	struct device *dev = &dsi->dev;
> +	int ret;
> +
> +	if (ctx->accum_err)
> +		return;
> +
> +	ret = mipi_dsi_shutdown_peripheral(dsi);
> +	if (ret < 0) {
> +		ctx->accum_err = ret;
> +		dev_err(dev, "Failed to shutdown peripheral: %d\n",
> +			ctx->accum_err);
> +	}
> +}
> +EXPORT_SYMBOL(mipi_dsi_shutdown_peripheral_multi);
> +
>   static int mipi_dsi_drv_probe(struct device *dev)
>   {
>   	struct mipi_dsi_driver *drv = to_mipi_dsi_driver(dev->driver);
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index 2ab651a36115..b429acde4f71 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -393,6 +393,7 @@ void mipi_dsi_dcs_set_page_address_multi(struct mipi_dsi_multi_context *ctx,
>   void mipi_dsi_dcs_set_tear_scanline_multi(struct mipi_dsi_multi_context *ctx,
>   					  u16 scanline);
>   void mipi_dsi_dcs_set_tear_off_multi(struct mipi_dsi_multi_context *ctx);
> +void mipi_dsi_shutdown_peripheral_multi(struct mipi_dsi_multi_context *ctx);
>   
>   /**
>    * mipi_dsi_generic_write_seq_multi - transmit data using a generic write packet

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
