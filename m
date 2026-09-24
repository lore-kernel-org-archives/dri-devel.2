Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162EBC98317
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B2E010F569;
	Thu, 24 Sep 2026 13:36:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X22oSTyf";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15C3410F569
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:36:47 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912e64ccso13605565e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790257005; x=1790861805; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xXlP/969CHxJtU22HfzbT0qcpswupuWX/2g/r8D5tLk=;
 b=X22oSTyfaZwoEAu3/0deD081i8H2nMf24A4dard04cU6K25CQTEo2I8lcnkcwsgVjb
 OOU+qMrvVFn2Orzro9MDi43/RgNRwEY4Mvq1kzl23HVRVcF2myUs5ggrMcQbYhScbeVU
 Th8UT+s5OzydgqlnPuJGXbFG1+918/XR1oyMJKgsyKArbSLKYtxFiPXxsFN4oYxc+k9x
 sUHGHNVJOjtIJvO6dw2QTQm/JCSNBShdtIzukAusmZ2k+fiuyrtIU5eAuyQ33XxmtQaZ
 yCBKY4xz5URmuGqX5Rc/3NhXRoUBKf6lWCiUpw7SPL8zHP5Zy9d9UZbxT1PNjtQVmIDM
 udUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790257005; x=1790861805;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xXlP/969CHxJtU22HfzbT0qcpswupuWX/2g/r8D5tLk=;
 b=SDC5WRuJItsI4VCs8lpXUFjDmUT0PuSZBqb1D38ruh186CIsPfqXPWCnRHTDgGo3Ad
 RNIt6+X67w8lgr8dejEM/qXtcyDDIJWikU61f9nv9hA8ggza+DeOyI3fLMk3JN5Q8CMw
 +d6gXiES9iwUM6cyGw0JCu66y8yoF5sY+YEw8moIVDJKhCjwN9Ny28OZo31ZxgC4GV8K
 f8dHUQQj8mylz2SsYLCYImyPNpigSnZVMC9bjoag18+eq+i+1HDqHuSanC9TlFn4YYbd
 c8ykc7rgNzZ749CnmEftsrPci6uxcPsmtRNhmLJGtKtqpUEsYUnNXVm9Jl9Aalq7XXLU
 FGZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYXlq6RnaNTFH5nYw8+HO7W7lpljWUL4L5ldLSMrb8u26IieSoBsay87jv5uI8+xcIX5yQa7BdUA8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lwzedBbmm+ChgxWE+00v8//eizWFWuuQJvogczyQ0kfDOiQ+zR
 fRxsFcXY/zVShN+Xj48Ldow2npHmrNaYtc3l1aVGJPLm+H/1cFcDtw15JVVId/V6E44=
X-Gm-Gg: AYBFou1GiZQIZ6o3skQ22mCsDMd5yG0pJVgPSz5ISoVfsZPRSAHdYzBlBd0IJCIACXq
 F+XZTyA1fQ6WDniiMSpxMzDb08mxZkCsJroPDgbP3nAUtJR9jwkn2cM8BuBAfNFZdf2yDLnyCW4
 4hpW6pyLoPlQ2EV50CwakmdwXt+rILRrOwcgOxcUy9nNWXB1KcGUrbm71aIGOKGa23LxzVjNzRn
 YemfPpUaWtzJvHuw5amYEq+gai2UkeJecOGg9EAja61wdRA0hyTWyzcYU5UxnZChaJdmcbT9IXQ
 xRUfJamTZefkA+z4ESLvcg9jzvFAY8MDd1kPVKoD7XH0H8AsFgaXGlRVXHxslmECSs/KebrOm0x
 oEGsV4cMoF3gHMy1+igT5TjpgqtlstCIQWRCF/dEFPVPmDjk76PTbFQCBqzt7YUEPRwhItpx31U
 o7VJphXoYSzZONHZkjZP8ofxU+3reIHjGWroz8Iq0BIKh7YC8frowW2irT1laL+9RHx5mJlEWJa
 1fKJ7FnUx9NaC7c6x3OYdtJG1daOOWTBV67lfzwTIcPJEsxN0A4vdI=
X-Received: by 2002:a05:600c:468c:b0:49f:bd3c:bc19 with SMTP id
 5b1f17b1804b1-49fe66f4cabmr40024985e9.20.1790257005322; 
 Thu, 24 Sep 2026 06:36:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a?
 ([2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48868889130sm14521695f8f.37.2026.09.24.06.36.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 06:36:44 -0700 (PDT)
Message-ID: <8f18e32d-07a7-46d9-9e6b-55c8fd25ede6@linaro.org>
Date: Thu, 24 Sep 2026 15:36:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: Fix node reference leak in
 rpi_touchscreen_probe()
To: Wentao Liang <vulab@iscas.ac.cn>, airlied@gmail.com
Cc: architt@codeaurora.org, bcm-kernel-feedback-list@broadcom.com,
 dri-devel@lists.freedesktop.org, eric@anholt.net,
 florian.fainelli@broadcom.com, jesszhan0024@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, treding@nvidia.com,
 tzimmermann@suse.de, stable@vger.kernel.org
References: <20260916180549.2090497-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20260916180549.2090497-1-vulab@iscas.ac.cn>
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

On 9/16/26 20:05, Wentao Liang wrote:
> of_graph_get_remote_port() returns a reference to the remote port
> node.  On the success path that reference is passed to the registered
> DSI device and released with it, but if mipi_dsi_device_register_full()
> fails the reference is never dropped.  Release it on the error path.
> 
> Fixes: 2f733d6194bd ("drm/panel: Add support for the Raspberry Pi 7" Touchscreen.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> index dc4bb8ad9131..c14776561623 100644
> --- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> +++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> @@ -428,6 +428,7 @@ static int rpi_touchscreen_probe(struct i2c_client *i2c)
>   	if (IS_ERR(ts->dsi)) {
>   		dev_err(dev, "DSI device registration failed: %ld\n",
>   			PTR_ERR(ts->dsi));
> +		of_node_put(info.node);
>   		return PTR_ERR(ts->dsi);
>   	}
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
