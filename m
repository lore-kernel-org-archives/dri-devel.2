Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27DBC98317
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0590610F576;
	Thu, 24 Sep 2026 13:36:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fxxsEMoW";
	dkim-atps=neutral
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com
 [74.125.225.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BA4310F576
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:36:22 +0000 (UTC)
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-4885a1480a2so1214107f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790256981; x=1790861781; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GOE7UhoK4tCn9iUhFUN5ojV92TGV3EOzfICN/tCRR3o=;
 b=fxxsEMoWV+1wwrOHVr0tK5Fv9dez8mhJdiDAzBqrxX62wQl6d5Qx8iXIam4ZET9udW
 w4uf7jILHD5NK/aOc7KcSy3Hul4t95qb1OiF1VtNtcX/OMnLRaaP1b96Cq4zhPzf9byz
 3A9KWZvw+YwvlAy0XFq/UHfEK/s4g0rAPVDvjLutAd8D994Tq72RwsPYYwTBtm7Ia7KR
 pYbPUCvKEEjPxaSSpL6R8wmcSbKmBSzB30iti+cosRnzq8UFEf7VgNR3oXzTY/YhV6Pb
 ZKLQjo0pdG5oIH1jhA6/49N96mor4yoZvdLf7h0T0uiof9pt+HIZxZNdH6TMZ+MPB75z
 8TZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790256981; x=1790861781;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GOE7UhoK4tCn9iUhFUN5ojV92TGV3EOzfICN/tCRR3o=;
 b=PAmz7RZFfMXBHZZJGnYH1lSELPnD/Sok3C2Yo/4DqYbHFTYW5L4bsy578ytr7aXQJ8
 dfTAWALnkn+5Hur1jRgH0j5DKxvSfOYVMYtcFXjddvwSTxA8bz8L4NJrXyRAWxtizC4C
 NvP/hYbbGy6CYl3Gc/yedCpZuTYlLoChCuIgc+BZGTLZNHarO4VkfcoBDVfoZ7XrQ2Gn
 2SFhqSmBHb7y1xaqv2Gm++oULsnlYYycyayXxstQwrhWQOQG1YYIRZHOAnQnMqZjYWH6
 zb+wntjbJnIGWTkE9R156G857o7wYOToiSNS0rT+reqVrqWE6FCfCtX8q6gB1eclyDJc
 uh4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzk6jdGdRdvAktKgykDlIjtZA555/4xdjKHHaTK+USN5oTCierR1WXsr+dAMOMxMbsjDQxa0Ke4U7E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m5cxpAgLwYATMTXa4lYoeAtD1FhNeC3kERzzSZ6+QcFYO/wH0G
 S4VlMFrU6+Fdzkb0/qgjRKVmT+xnr1asMOY+0AU4KmEUtMFQDtdOSNjIvmcxh7BL7VE=
X-Gm-Gg: AYBFou2XE7zGfENvuCZTD8s7gZx5+rWv9nQJHeRZkLGMKHudTKb+55FJOpQvCzUmVk4
 kLtyn6vfq9eugxQLsmxSCOLe8RT0wbNL33ixjF9457w382jDtZJZDD/HcLeQyJa3CFG3i6EdNRI
 cFh34YJp5fNaO8LB+4zvQsdJdLmNKPWNOGSlcI1G31fbsDVYz1b/3+39ZgoWxi+Yxxs8zpqaQyL
 6PeS+gPHoGtTCoJEdQIQrHTm9lgqtY57zjnuKPhyla5FYsnNF3vnhWB62VT3r3c2HSvA8INsPKr
 3d5rPf4Lc0bAHLjYjRh0tTjCcMA0lMj5YII1XenceBo02T2QgLOG7wV/XxhkVcG2v6F52sYtLA+
 xv9WmQ+vs+Yv5ZiOXYgscCPdubJcZAAM9EuJrhCGMkK5Zj3fzdAVP2eIwiRiyXE4qelFWvGvhL4
 jfR0m91ZxZ3NKS5I2BVnzc+rpStb5hLAqhEJMrteVfiLFPnd2wotzgYuaqFLJJwU2+iEH8EgDk5
 urMbqxrX/wu9iO/vq1juZTLZC7eHTQ/AmOMjYBGIQeA5dHjg6iKkbA=
X-Received: by 2002:a05:6000:491e:b0:487:8ba:8aa9 with SMTP id
 ffacd0b85a97d-488716cfedemr4392066f8f.23.1790256980460; 
 Thu, 24 Sep 2026 06:36:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a?
 ([2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886877a2d5sm14387149f8f.27.2026.09.24.06.36.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 06:36:19 -0700 (PDT)
Message-ID: <7847ae8d-b330-4add-b39d-bd12b9a611cd@linaro.org>
Date: Thu, 24 Sep 2026 15:36:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 8/9] drm/panel: novatek-nt36672a: Add panel for Asus
 Zenfone Max Pro M1
To: Alexey Minnekhanov <alexeymin@minlexx.ru>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: David Heidelberg <david@ixit.cz>, Joel Selvaraj <foss@joelselvaraj.com>,
 Chintan Patel <chintanlike@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 phone-devel@vger.kernel.org, Aboothahir U <aboothahirpkd@gmail.com>
References: <20260917-nt36672a-panels-v2-0-f8de8be5b86f@minlexx.ru>
 <20260917-nt36672a-panels-v2-8-f8de8be5b86f@minlexx.ru>
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
In-Reply-To: <20260917-nt36672a-panels-v2-8-f8de8be5b86f@minlexx.ru>
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

On 9/17/26 18:43, Alexey Minnekhanov wrote:
> Add support for TXD TXDI600YANPA-43V3 video mode panel based on
> Novatek NT36672A, used in Asus Zenfone Max Pro M1 smartphone
> (asus-x00td).
> 
> Co-developed-by: Aboothahir U <aboothahirpkd@gmail.com>
> Signed-off-by: Aboothahir U <aboothahirpkd@gmail.com>
> Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
> 
> ---
> v2:
>   * change compatible prefix "txd" -> "txdkj"
>   * use co-author's real name in trailers
> ---
>   drivers/gpu/drm/panel/panel-novatek-nt36672a.c | 281 +++++++++++++++++++++++++
>   1 file changed, 281 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> index 48dff2279b0e9..7d7c79d2502d2 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> @@ -464,6 +464,252 @@ static void tianma_jasmine_init_cmds(struct mipi_dsi_multi_context *dsi_ctx)
>   	mipi_dsi_usleep_range(dsi_ctx, 5000, 6000);
>   }
>   
> +static void txd_x00td_init_cmds(struct mipi_dsi_multi_context *dsi_ctx)
> +{
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfb, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x06, 0x9e);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x07, 0x94);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0e, 0x35);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0f, 0x24);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x6d, 0x66);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x69, 0x99);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x95, 0xf5);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x96, 0xf5);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x23);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfb, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x12, 0x6c);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x15, 0xe6);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x16, 0x0c);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x24);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfb, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x00, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x01, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x02, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x03, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x04, 0x0b);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x05, 0x0c);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x06, 0xa9);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x07, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x08, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x09, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0a, 0x0f);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0b, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0c, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0d, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0e, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0f, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x10, 0x15);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x11, 0x13);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x12, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x13, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x14, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x15, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x16, 0x0b);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x17, 0x0c);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x18, 0xa9);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x19, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x1a, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x1b, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x1c, 0x0f);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x1d, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x1e, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x1f, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x20, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x21, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x22, 0x15);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x23, 0x13);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x2f, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x30, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x31, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x32, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x33, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x34, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x35, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x37, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x38, 0x72);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x39, 0x72);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x3b, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x3f, 0x72);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x60, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x61, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x68, 0x83);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x78, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x79, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x7a, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x7b, 0x9c);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x7d, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x7e, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x80, 0x45);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x81, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x8e, 0xf0);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x90, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x92, 0x76);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x93, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x94, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x99, 0x33);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x9b, 0xff);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb3, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb4, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb5, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xdc, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xdd, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xde, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xdf, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xe0, 0x75);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xe9, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xed, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfb, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb0,
> +				     0x00, 0x00, 0x00, 0x15, 0x00, 0x37, 0x00,
> +				     0x54, 0x00, 0x6d, 0x00, 0x84, 0x00, 0x98,
> +				     0x00, 0xac);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb1,
> +				     0x00, 0xbd, 0x00, 0xf9, 0x01, 0x25, 0x01,
> +				     0x6b, 0x01, 0x9c, 0x01, 0xec, 0x02, 0x22,
> +				     0x02, 0x25);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb2,
> +				     0x02, 0x5e, 0x02, 0x9e, 0x02, 0xc9, 0x02,
> +				     0xfd, 0x03, 0x21, 0x03, 0x4d, 0x03, 0x5a,
> +				     0x03, 0x68);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb3,
> +				     0x03, 0x78, 0x03, 0x8b, 0x03, 0xa1, 0x03,
> +				     0xbd, 0x03, 0xd6, 0x03, 0xda);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb4,
> +				     0x00, 0x00, 0x00, 0x15, 0x00, 0x37, 0x00,
> +				     0x54, 0x00, 0x6d, 0x00, 0x84, 0x00, 0x98,
> +				     0x00, 0xac);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb5,
> +				     0x00, 0xbd, 0x00, 0xf9, 0x01, 0x25, 0x01,
> +				     0x6b, 0x01, 0x9c, 0x01, 0xec, 0x02, 0x22,
> +				     0x02, 0x25);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb6,
> +				     0x02, 0x5e, 0x02, 0x9e, 0x02, 0xc9, 0x02,
> +				     0xfd, 0x03, 0x21, 0x03, 0x4d, 0x03, 0x5a,
> +				     0x03, 0x68);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb7,
> +				     0x03, 0x78, 0x03, 0x8b, 0x03, 0xa1, 0x03,
> +				     0xbd, 0x03, 0xd6, 0x03, 0xda);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb8,
> +				     0x00, 0x00, 0x00, 0x15, 0x00, 0x37, 0x00,
> +				     0x54, 0x00, 0x6d, 0x00, 0x84, 0x00, 0x98,
> +				     0x00, 0xac);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb9,
> +				     0x00, 0xbd, 0x00, 0xf9, 0x01, 0x25, 0x01,
> +				     0x6b, 0x01, 0x9c, 0x01, 0xec, 0x02, 0x22,
> +				     0x02, 0x25);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xba,
> +				     0x02, 0x5e, 0x02, 0x9e, 0x02, 0xc9, 0x02,
> +				     0xfd, 0x03, 0x21, 0x03, 0x4d, 0x03, 0x5a,
> +				     0x03, 0x68);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xbb,
> +				     0x03, 0x78, 0x03, 0x8b, 0x03, 0xa1, 0x03,
> +				     0xbd, 0x03, 0xd6, 0x03, 0xda);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x21);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfb, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb0,
> +				     0x00, 0x00, 0x00, 0x15, 0x00, 0x37, 0x00,
> +				     0x54, 0x00, 0x6d, 0x00, 0x84, 0x00, 0x98,
> +				     0x00, 0xac);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb1,
> +				     0x00, 0xbd, 0x00, 0xf9, 0x01, 0x25, 0x01,
> +				     0x6b, 0x01, 0x9c, 0x01, 0xec, 0x02, 0x22,
> +				     0x02, 0x25);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb2,
> +				     0x02, 0x5e, 0x02, 0x9e, 0x02, 0xc9, 0x02,
> +				     0xfd, 0x03, 0x21, 0x03, 0x4d, 0x03, 0x5a,
> +				     0x03, 0x68);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb3,
> +				     0x03, 0x78, 0x03, 0x8b, 0x03, 0xa1, 0x03,
> +				     0xbd, 0x03, 0xd6, 0x03, 0xda);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb4,
> +				     0x00, 0x00, 0x00, 0x15, 0x00, 0x37, 0x00,
> +				     0x54, 0x00, 0x6d, 0x00, 0x84, 0x00, 0x98,
> +				     0x00, 0xac);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb5,
> +				     0x00, 0xbd, 0x00, 0xf9, 0x01, 0x25, 0x01,
> +				     0x6b, 0x01, 0x9c, 0x01, 0xec, 0x02, 0x22,
> +				     0x02, 0x25);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb6,
> +				     0x02, 0x5e, 0x02, 0x9e, 0x02, 0xc9, 0x02,
> +				     0xfd, 0x03, 0x21, 0x03, 0x4d, 0x03, 0x5a,
> +				     0x03, 0x68);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb7,
> +				     0x03, 0x78, 0x03, 0x8b, 0x03, 0xa1, 0x03,
> +				     0xbd, 0x03, 0xd6, 0x03, 0xda);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb8,
> +				     0x00, 0x00, 0x00, 0x15, 0x00, 0x37, 0x00,
> +				     0x54, 0x00, 0x6d, 0x00, 0x84, 0x00, 0x98,
> +				     0x00, 0xac);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb9,
> +				     0x00, 0xbd, 0x00, 0xf9, 0x01, 0x25, 0x01,
> +				     0x6b, 0x01, 0x9c, 0x01, 0xec, 0x02, 0x22,
> +				     0x02, 0x25);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xba,
> +				     0x02, 0x5e, 0x02, 0x9e, 0x02, 0xc9, 0x02,
> +				     0xfd, 0x03, 0x21, 0x03, 0x4d, 0x03, 0x5a,
> +				     0x03, 0x68);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xbb,
> +				     0x03, 0x78, 0x03, 0x8b, 0x03, 0xa1, 0x03,
> +				     0xbd, 0x03, 0xd6, 0x03, 0xda);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x25);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfb, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x05, 0x0c);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0a, 0x81);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0b, 0xd7);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x0c, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x17, 0x82);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x21, 0x1c);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x22, 0x1c);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x24, 0x76);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x25, 0x76);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x5c, 0x25);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x5d, 0x80);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x5e, 0x80);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x5f, 0x22);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x65, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x69, 0x60);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x6b, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x71, 0x2d);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x80, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x8d, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xd7, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xd8, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xd9, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xda, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xdb, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xdc, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x26);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfb, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x06, 0xc8);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x12, 0x5a);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x19, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x1a, 0x97);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x1d, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x1e, 0x1e);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x99, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x27);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfb, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x13, 0x0e);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x16, 0xb0);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x17, 0xd0);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfb, 0x01);
> +	mipi_dsi_dcs_exit_sleep_mode_multi(dsi_ctx);
> +	mipi_dsi_msleep(dsi_ctx, 70);
> +	mipi_dsi_dcs_set_display_on_multi(dsi_ctx);
> +	mipi_dsi_usleep_range(dsi_ctx, 10000, 11000);
> +}
> +
> +static void txd_x00td_deinit_cmds(struct mipi_dsi_multi_context *dsi_ctx)
> +{
> +	mipi_dsi_dcs_set_display_off_multi(dsi_ctx);
> +	mipi_dsi_msleep(dsi_ctx, 50);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(dsi_ctx);
> +	mipi_dsi_msleep(dsi_ctx, 120);
> +}
> +
>   static const struct drm_display_mode tianma_fhd_video_panel_default_mode = {
>   	.clock		= 161331,
>   
> @@ -608,6 +854,40 @@ static const struct nt36672a_panel_desc tianma_jasmine_panel_desc = {
>   	.send_deinit_cmds = lavender_tulip_deinit_cmds,
>   };
>   
> +static const struct drm_display_mode txd_x00td_mode = {
> +	.clock		= (1080 + 122 + 8 + 76) * (2160 + 20 + 4 + 28) * 60 / 1000,
> +
> +	.hdisplay	= 1080,
> +	.hsync_start	= 1080 + 122,
> +	.hsync_end	= 1080 + 122 + 8,
> +	.htotal		= 1080 + 122 + 8 + 76,
> +
> +	.vdisplay	= 2160,
> +	.vsync_start	= 2160 + 20,
> +	.vsync_end	= 2160 + 20 + 4,
> +	.vtotal		= 2160 + 20 + 4 + 28,
> +
> +	.width_mm	= 68,
> +	.height_mm	= 136,
> +
> +	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +};
> +
> +static const struct nt36672a_panel_desc txd_x00td_panel_desc = {
> +	.display_mode = &txd_x00td_mode,
> +
> +	.width_mm = 68,
> +	.height_mm = 136,
> +
> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> +			  MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_NO_EOT_PACKET |
> +			  MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.lanes = 4,
> +	.send_init_cmds = txd_x00td_init_cmds,
> +	.send_deinit_cmds = txd_x00td_deinit_cmds,
> +};
> +
>   static int nt36672a_panel_add(struct nt36672a_panel *pinfo)
>   {
>   	struct device *dev = &pinfo->link->dev;
> @@ -689,6 +969,7 @@ static const struct of_device_id panel_nt36672a_match[] = {
>   	{ .compatible = "tianma,tl060fvxs16-00", .data = &tianma_jasmine_panel_desc },
>   	{ .compatible = "tianma,tl063fvmc43-02", .data = &tianmaplus_e7t_tulip_panel_desc },
>   	{ .compatible = "tianma,tl063fvmca01-00", .data = &tianma_lavender_panel_desc },
> +	{ .compatible = "txdkj,txdi600yanpa-43v3", .data = &txd_x00td_panel_desc },
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(of, panel_nt36672a_match);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
