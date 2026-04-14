Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F7FF9D0CA
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 12:58:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF42E10E5A2;
	Tue, 14 Apr 2026 12:58:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dQMKgDK/";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEA9F10E5A2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 12:58:16 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-488ad135063so53878275e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 05:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776171495; x=1776776295; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=p21MIER5uy4Fua/gjgmr0WO7mkoCiyl364lxNom68rw=;
 b=dQMKgDK/YlvzEMCzNQTyp3xY9ro2Bycpn3b1XFjd+ZKrcnGHaDHHP+9si4p7FM+cDd
 cPomcAtLU4PnrUmU+k2vDkHUxha9/qhRFPSgSAcus/YtcDzDsvEWokCTHyN/skjg2nG3
 eYeHjbt4hbbyS3i3brKlKo6W1qYHR613q6hQB8hggLo17Yc+sqCKgzrIx36XpAk+xY/F
 S3Vx+jK+LHKojmdbUDrV7MkPt62+36jTdqpgUWyaV/UbEc1dUQZcevI6jNuZILRF7nUX
 JszaVbK6XN6bU8sYpHxWp/npfxoXliBFpeojI0aMJsUYPTfYUX/KlPDxj3bk5PzBnJtS
 BuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776171495; x=1776776295;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p21MIER5uy4Fua/gjgmr0WO7mkoCiyl364lxNom68rw=;
 b=HT3yA8VTjIoJvI87ncJybX5eXiFS4dA4ymAoAGVSOqZD8ZTwvYZ7Y+hkDH5KdRIQZD
 QBYyC09hCfqPH6oNx5mPeq4Hy9ozzdIWYrlpkFfmNp9yULmzwoBR15Vz3cacoh3GQ6XU
 oeas9C+Z0MRmhR9Bz55HEbIec+F8QsRkwAgwWmDi+QgvksstVO9Ps6TLr/ah51pldE0T
 vXnl8Upvq32kif9BbFAWvhukxAG0daf7jJ7fnIMEhNJgGmzgOtbzxOSjeDEMeWZgdpPl
 M1YbkLJ/0qqU+k+ZJf/Mv6OhKoE8i75mke27AQi2zQAaIADfezIe6hyYVgL4ZCNOCDTT
 ChJA==
X-Gm-Message-State: AOJu0YxT+3/ib75FmB3sY9a8rQv5PPFxRK55FAf5BtjjcQK7Ze+WtLaS
 vAPBOSKr3SjBpKtFqOIKfV+qGJcKkfUAHehLCfWC51nGCziKT7rzJoCj4zD18FlAnck=
X-Gm-Gg: AeBDiesjlYaLcUEDk1FxTSEaK2E/rK0ELlVZag16/g9VOBEIr0Q23vgw4158hXdWDS4
 jlidO785ofrxrfdz+SGe2OXB1IvsVutrP3+tacrGDSMfh1AZdfjykYpBWRi0mDlVWI9906sbfrS
 k2W/UFWpS/eny8iRorCD+T9dqisHo+Q9rJ6QXy4rx7pwGE0OKr3wAqkhoVyEOClTBx3ukEglgtn
 9zHbV+crM9B8lm0yTxyc5QgVRcXz+C8guVWVqJhA/C2mGAjzH95rqfmfQaE0HYWC3J8RAOAxGjj
 +lZyAKiLmxp4AAb0brxr8dYVu+0Y7LC771eQtJvsNvJX9mhJ4ox3W/UHWztVt3Miypr7m3TVXiX
 u/T1IIsjWBsY1QJ8qorYSLr/QZtd4EVr1w0svvSI4WNf11uxAA1LwOZHQ0bz5RyO1DLBulXNdpb
 q20bsrSyyag2D3CqZkhIUsN6yArSZcGU8BU8C1tqKUPXIrAADdp5H/M0hWClSSsD/A2/+EoDJcY
 FcQMn9g/saZbf8QJuT4vXuvJA==
X-Received: by 2002:a05:600c:19cf:b0:485:2a4b:7bc3 with SMTP id
 5b1f17b1804b1-488d67ebc6emr216740025e9.4.1776171495129; 
 Tue, 14 Apr 2026 05:58:15 -0700 (PDT)
Received: from ?IPV6:2001:861:c12:13d0:5627:3bd0:f3ee:8a22?
 ([2001:861:c12:13d0:5627:3bd0:f3ee:8a22])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede2ba5asm46036435e9.12.2026.04.14.05.58.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 05:58:14 -0700 (PDT)
Message-ID: <3e711e29-c587-4b32-af47-0343f75004d8@linaro.org>
Date: Tue, 14 Apr 2026 14:58:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 14/21] drm/panel: jadard-jd9365da-h3: support Waveshare
 round DSI panels
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Jie Gan <jie.gan@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Riccardo Mereu <r.mereu@arduino.cc>
References: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
 <20260413-waveshare-dsi-touch-v3-14-3aeb53022c32@oss.qualcomm.com>
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
In-Reply-To: <20260413-waveshare-dsi-touch-v3-14-3aeb53022c32@oss.qualcomm.com>
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

On 4/13/26 16:05, Dmitry Baryshkov wrote:
> Add configuration for Waveshare 3.4" and 4.0" round DSI panels using
> JD9365 controller.
> 
> Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 476 +++++++++++++++++++++++
>   1 file changed, 476 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> index bc079b97cfb3..61d67efed379 100644
> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> @@ -1599,6 +1599,474 @@ static const struct jadard_panel_desc taiguan_xti05101_01a_desc = {
>   	.enter_sleep_to_reset_down_delay_ms = 100,
>   };
>   
> +static int waveshare_3_4_c_init(struct jadard *jadard)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x00);
> +	jadard_enable_standard_cmds(&dsi_ctx);
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x41);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xd0);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0xd0);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0xfe);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x26);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x09);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x78);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0xff);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0xff);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0xff);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0x64);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0xc7);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x18);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x0b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x14);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x1b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x19);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x7f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x56);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x37);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x33);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x25);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x2a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x16);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x30);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x2f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x32);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x53);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x4c);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x3d);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x31);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x0f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x7f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x56);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x37);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x33);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x25);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x2a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x16);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x30);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x2f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x32);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x53);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x4c);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0x3d);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x31);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x0f);
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x5e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x5e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x50);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x48);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x48);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x4a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x4a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0a, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0b, 0x46);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x46);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0d, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0f, 0x57);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x57);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x77);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x12, 0x77);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x13, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x14, 0x42);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0x5e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x5e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x50);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1d, 0x4b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1e, 0x4b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1f, 0x45);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x45);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x47);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x47);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x23, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x25, 0x57);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x26, 0x57);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x27, 0x77);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x77);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x41);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2a, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2c, 0x1e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2d, 0x1e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2e, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x30, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x31, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x32, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x33, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x34, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x0b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x0b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x09);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x09);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3b, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x1e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x1e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x46, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x47, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x48, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x49, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4a, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4b, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4c, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4d, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4e, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4f, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x50, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x51, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x52, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x53, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x54, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x1f);
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x30);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x30);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x30);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0xa6);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x30);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x73);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x7f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x88);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0xd9);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x33);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x43);
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x00);
> +
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +	msleep(120);
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +	msleep(5);
> +	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static const struct jadard_panel_desc waveshare_3_4_inch_c_desc = {
> +	.mode_2ln = &(const struct drm_display_mode) {
> +		.clock		= (800 + 40 + 20 + 20) * (800 + 24 + 4 + 12) * 60 / 1000,
> +
> +		.hdisplay	= 800,
> +		.hsync_start	= 800 + 40,
> +		.hsync_end	= 800 + 40 + 20,
> +		.htotal		= 800 + 40 + 20 + 20,
> +
> +		.vdisplay	= 800,
> +		.vsync_start	= 800 + 24,
> +		.vsync_end	= 800 + 24 + 4,
> +		.vtotal		= 800 + 24 + 4 + 12,
> +
> +		.width_mm	= 88,
> +		.height_mm	= 88,
> +		.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +	},
> +	.lanes = 2,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.init = waveshare_3_4_c_init,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> +		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +};
> +
> +static int waveshare_4_0_c_init(struct jadard *jadard)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x00);
> +	jadard_enable_standard_cmds(&dsi_ctx);
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x41);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xd0);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0xd0);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0xfe);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x26);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x09);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x78);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0xff);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0xff);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0xff);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0x64);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0xc7);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x18);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x0b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x14);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x1b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x19);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x7f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x56);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x37);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x33);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x25);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x2a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x16);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x30);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x2f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x32);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x53);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x4c);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x3d);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x31);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x0f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x7f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x56);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x37);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x33);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x25);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x2a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x16);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x30);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x2f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x32);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x53);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x4c);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0x3d);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x31);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x0f);
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x5e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x5e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x50);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x48);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x48);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x4a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x4a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0a, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0b, 0x46);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x46);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0d, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0f, 0x57);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x57);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x77);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x12, 0x77);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x13, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x14, 0x42);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0x5e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x5e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x50);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1d, 0x4b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1e, 0x4b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1f, 0x45);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x45);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x47);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x47);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x23, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x25, 0x57);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x26, 0x57);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x27, 0x77);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x77);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x41);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2a, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2c, 0x1e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2d, 0x1e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2e, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x30, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x31, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x32, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x33, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x34, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x0b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x0b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x09);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x09);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3b, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x1e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x1e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x46, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x47, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x48, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x49, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4a, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4b, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4c, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4d, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4e, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4f, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x50, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x51, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x52, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x53, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x54, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x1f);
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x30);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x30);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x30);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0xa6);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x30);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x73);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x7f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x88);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0xd9);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x33);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x43);
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x00);
> +
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +	msleep(120);
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +	msleep(5);
> +	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static const struct jadard_panel_desc waveshare_4_0_inch_c_desc = {
> +	.mode_2ln = &(const struct drm_display_mode) {
> +		.clock		= (720 + 40 + 20 + 20) * (720 + 24 + 4 + 12) * 60 / 1000,
> +
> +		.hdisplay	= 720,
> +		.hsync_start	= 720 + 40,
> +		.hsync_end	= 720 + 40 + 20,
> +		.htotal		= 720 + 40 + 20 + 20,
> +
> +		.vdisplay	= 720,
> +		.vsync_start	= 720 + 24,
> +		.vsync_end	= 720 + 24 + 4,
> +		.vtotal		= 720 + 24 + 4 + 12,
> +
> +		.width_mm	= 88,
> +		.height_mm	= 88,
> +		.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +	},
> +	.lanes = 2,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.init = waveshare_4_0_c_init,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> +		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +};
> +
>   static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
>   {
>   	struct device *dev = &dsi->dev;
> @@ -1722,6 +2190,14 @@ static const struct of_device_id jadard_of_match[] = {
>   		.compatible = "taiguanck,xti05101-01a",
>   		.data = &taiguan_xti05101_01a_desc
>   	},
> +	{
> +		.compatible = "waveshare,3.4-dsi-touch-c",
> +		.data = &waveshare_3_4_inch_c_desc
> +	},
> +	{
> +		.compatible = "waveshare,4.0-dsi-touch-c",
> +		.data = &waveshare_4_0_inch_c_desc
> +	},
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, jadard_of_match);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
