Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952BBFE51F4
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06BD910F47D;
	Fri, 24 Apr 2026 09:34:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fo72JiOC";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E12E10F47D
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:34:09 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so62384495e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 02:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777023247; x=1777628047; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=yJUYORF5y0Fx0geYa0plDY5In8yDcQ4yezqh9fC2iH8=;
 b=fo72JiOCM3GVnWTHVD4nzLGaBX4SxRx2zKX20xZlhiwkAovdkSO+KUdMKzV3fyCn0e
 Qt7UKKlMidlZlGi3lOMMKSZtA+sQsjzsZVWDqLajzik3rfg7KdU3OFlRRF4GfgKJkVB+
 hTX4yvjNSsG5eA+Pv5mvBan+JjspYqZECTI691Vfmvt/qzZGkiPurnsx9wH7/qI6x6rp
 NevXlaamdKXUunNu6bj5yN9uynePNKyvcwzafmVXrzaL+8hNG3ic81+HGTMLNaqA0H1n
 ig7BI1WJQLEePsHI9cbksgTg2BN0VBHKOcLNfkTSzvKh6Eo0i5WV2EKVa9csDrda35E2
 zwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777023247; x=1777628047;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yJUYORF5y0Fx0geYa0plDY5In8yDcQ4yezqh9fC2iH8=;
 b=bKxRZc1Y3qldxvjUffAusP60Mj0+OOym/NQc4Xnp3MJ/KQndHT+Gf2fLxHGu4e1gXi
 T+2Gi7OVYEI1qgOHz9hx7k4EXSu1Sxqi9rqHz1o+FjMBhVoEs05BjyIUuhAcm8p7B+sh
 yZeDFAHqyO4+691FlLniB84INYzcQFHHWWq2bBj0oYug229YI3D5fOmaoqwPYv7gKqmS
 peiMEYRzohuo4l/RXABAqxFnv7BacYOq+5ES92Nf38EgyQlWpjuuYl7ykajd6p56/3IK
 BTafof4dpQLVmKdrntZvVvMv8G7/hbp6aOZooEeMR/Jx2Id1lPd9cYV3evITB0N3Ng1L
 6QYA==
X-Gm-Message-State: AOJu0YxsHgx9bAAPNLoGp0ohIaNlFMyfd7cyFcnXYk4v9kMr0RY287gF
 YoacWlWCL+P4Dq28IsqdR6ugsCNBAXdW7hHgr+kVkzMwT+o0l/ryjS2a8gCTwPLDe4E=
X-Gm-Gg: AeBDiesRBsVqZTWC3DEZre2ed70o79R7JrsUb6MTQq8JdGfSZOZZGQ2hn3SEErbsW5W
 GwKA2yL5qFur1Obo+kYptVI6dA3jUIY/jesazeVqldYbyK6TmoFUJzgKJrkSaSJOKBUgqoLiduh
 JfGs4C8gWPDFCy5sQW6Ba+1+YBvbrJQV+A28clC/JtrkYgbHh+aOpHxNET+WFxf0+GU8Yfmh+px
 7ETxMerBaYHRzb29cOISTuoK8rpQfxvUbmdmpgwFmfK8x/aZkdl1LcisM77Dzc5CVAX4skxd2CF
 S+Wo0Hj+tidRNUtKky7dwUJ9q59RRuPZfg2sFDYeEeNKPEyAtrNebs6lmsNmSvieLd/S1ItCUX0
 vLE/djjnlIbVSXGkUr96oAWjYL3+UgP4YrJL9Q/FJnB1yJzow8t2RR4iyF9BYfhNqoeE6rBS40L
 HJt8s0iT+Ql3TLIsqlCPJQnE41BQEH3+lYrAVCxdzmVuxu+FzFAPDnGbtQjowxnPXY6U7phuoKB
 ChC93argxTXXKAcRg==
X-Received: by 2002:a05:600c:41d6:b0:487:2439:b7c8 with SMTP id
 5b1f17b1804b1-488fb745294mr274628735e9.1.1777023247300; 
 Fri, 24 Apr 2026 02:34:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:79e1:f56b:445c:ca9c?
 ([2a01:e0a:106d:1080:79e1:f56b:445c:ca9c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891bba6276sm178881485e9.0.2026.04.24.02.34.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 02:34:06 -0700 (PDT)
Message-ID: <a98b6735-64b9-40a8-a52d-aef4b75f8261@linaro.org>
Date: Fri, 24 Apr 2026 11:34:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 2/2] drm/panel: jd9365da: Support for Zhunyi Z40046
 panels
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Jagan Teki <jagan@edgeble.ai>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Marek Vasut <marex@nabladev.com>, Kael D'Alcamo <dev@kael-k.io>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260417104740.259689-1-l.scorcia@gmail.com>
 <20260417104740.259689-3-l.scorcia@gmail.com>
 <gyacssx3h7oowxohwzeup7dvmtlrrm7oarb3zwne77rvfysxwd@cvlghspzfdcb>
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
In-Reply-To: <gyacssx3h7oowxohwzeup7dvmtlrrm7oarb3zwne77rvfysxwd@cvlghspzfdcb>
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

On 4/22/26 21:28, Dmitry Baryshkov wrote:
> On Fri, Apr 17, 2026 at 11:46:31AM +0100, Luca Leonardo Scorcia wrote:
>> The Zhunyi Z40046 is a 480x800 24-bit WVGA DSI panel based on the
>> Fitipower JD9161Z DSI controller found in the Xiaomi Mi Smart Clock
>> x04g, apparently in two different variants.
>>
>> The Fitipower JD9161Z LCD driver IC is very similar to the Jadard
>> JD9365DA-H3, it just uses different initialization sequences.
>>
>> The two initialization sequences for the panel have been extracted from
>> Android original firmware for the Xiaomi Smart Clock.
>>
>> Variant -ctc uses a CTC LCD panel and has been tested on device.
>> Variant -boe uses a BOE LCD panel and has not been tested.

If it hasn't been tested, please remove it and add it when tested.

Neil

>>
>> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
>> ---
>>   .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 313 ++++++++++++++++++
>>   1 file changed, 313 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
>> index c33c611e03c0..7da064567248 100644
>> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
>> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
>> @@ -46,11 +46,22 @@ struct jadard {
>>   	struct gpio_desc *reset;
>>   };
>>   
>> +#define JD9161Z_DCS_SWITCH_PAGE		0xde
>> +
>> +#define jd9161z_switch_page(dsi_ctx, page) \
>> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, JD9161Z_DCS_SWITCH_PAGE, (page))
>> +
> 
> Just my 2c. The code looks similar, but it's true for large enough
> number of controllers. Please consider splitting this to a separate
> driver. It would result in a cleaner and easier to follow code for both
> of them.
> 
>>   #define JD9365DA_DCS_SWITCH_PAGE	0xe0
>>   
>>   #define jd9365da_switch_page(dsi_ctx, page) \
>>   	mipi_dsi_dcs_write_seq_multi(dsi_ctx, JD9365DA_DCS_SWITCH_PAGE, (page))
>>   
>> +static void jd9161z_enable_standard_cmds(struct mipi_dsi_multi_context *dsi_ctx)
>> +{
>> +	// Enable access to DCS and internal commands
>> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xdf, 0x91, 0x62, 0xf3);
>> +}
>> +
>>   static void jadard_enable_standard_cmds(struct mipi_dsi_multi_context *dsi_ctx)
>>   {
>>   	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xe1, 0x93);
>> @@ -1606,6 +1617,300 @@ static const struct jadard_panel_desc taiguan_xti05101_01a_desc = {
>>   	.enter_sleep_to_reset_down_delay_ms = 100,
>>   };
>>   
>> +// Sequence retrieved from Xiaomi Mi Smart Clock x04g kernel in boot.bin
>> +static int zhunyi_z40046_init_cmds_ctc(struct jadard *jadard_data)
>> +{
>> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard_data->dsi };
>> +
>> +	// Init configuration sequence
>> +	jd9161z_switch_page(&dsi_ctx, 0x00);
>> +	jd9161z_enable_standard_cmds(&dsi_ctx);
>> +
>> +	// GAMMA_SET (pos/neg voltage of gamma power)
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb7,
>> +		0x10, 0x04, 0x86, 0x00, 0x1b, 0x35);
>> +
>> +	// DCDC_SEL (power mode and charge pump settings)
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xbb,
>> +		0x69, 0x0b, 0x30, 0xb2, 0xb2, 0xc0, 0xe0, 0x20,
>> +		0xf0, 0x50, 0x60);
>> +
>> +	mipi_dsi_msleep(&dsi_ctx, 1);
>> +
>> +	// VDDD_CTRL (control logic voltage setting)
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xbc,
>> +		0x73, 0x14);
>> +
>> +	mipi_dsi_msleep(&dsi_ctx, 1);
>> +
>> +	// SETRGBCYC (display waveform cycle of RGB mode)
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc3,
>> +		0x74, 0x04, 0x08, 0x0e, 0x00, 0x0e, 0x0c, 0x08,
>> +		0x0e, 0x00, 0x0e, 0x82, 0x0a, 0x82);
>> +
>> +	// SET_TCON (timing control setting)
>> +	// param[0][5:4] + param[1]: number of panel lines / 2
>> +	//   400 = 01 1001 0000 -> 0x10, 0x90
>> +	// param[2]: scan line time width
>> +	// param[3]: vfp: 14
>> +	// param[4]: vs + vbp - 1: 11
>> +	// param[5]: hbp: 4
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc4,
>> +		0x10, 0x90, 0x92, 0x0e, 0x0b, 0x04);
>> +
>> +	mipi_dsi_msleep(&dsi_ctx, 1);
>> +
>> +	// SET_R_GAMMA (set red gamma output voltage)
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc8,
>> +		0x7e, 0x76, 0x68, 0x57, 0x4c, 0x39, 0x3a, 0x23,
>> +		0x3d, 0x3d, 0x40, 0x61, 0x54, 0x64, 0x5d, 0x62,
>> +		0x5a, 0x50, 0x32, 0x7e, 0x76, 0x68, 0x57, 0x4c,
>> +		0x39, 0x3a, 0x23, 0x3d, 0x3d, 0x40, 0x61, 0x54,
>> +		0x64, 0x5d, 0x62, 0x5a, 0x50, 0x32);
>> +
>> +	// SET_GIP_L (CGOUTx_L signal mapping, gs_panel = 0)
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd0,
>> +		0x1f, 0x0a, 0x08, 0x06, 0x04, 0x1f, 0x00, 0x1f,
>> +		0x17, 0x1f, 0x18, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f);
>> +
>> +	// SET_GIP_R (CGOUTx_R signal mapping, gs_panel = 0)
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd1,
>> +		0x1f, 0x0b, 0x09, 0x07, 0x05, 0x1f, 0x01, 0x1f,
>> +		0x17, 0x1f, 0x18, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f);
>> +
>> +	// SETGIP1 (GIP signal timing 1)
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd4,
>> +		0x10, 0x00, 0x00, 0x03, 0x60, 0x05, 0x10, 0x00,
>> +		0x02, 0x06, 0x68, 0x00, 0x6c, 0x00, 0x00, 0x00,
>> +		0x00, 0x06, 0x78, 0x71, 0x07, 0x06, 0x68, 0x0c,
>> +		0x25, 0x00, 0x63, 0x03, 0x00);
>> +
>> +	// SETGIP2 (GIP signal timing 1)
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd5,
>> +		0x20, 0x10, 0x8c, 0x18, 0x00, 0x80, 0x00, 0x08,
>> +		0x00, 0x00, 0x06, 0x60, 0x00, 0x81, 0x70, 0x02,
>> +		0x30, 0x01, 0x00, 0x00, 0xc0, 0x00, 0x00, 0x00,
>> +		0x03, 0x60, 0x83, 0x90, 0x00, 0x00, 0x03, 0x4f,
>> +		0x03, 0x00, 0x1f, 0x3f, 0x00, 0x00, 0x00, 0x00);
>> +
>> +	jd9161z_switch_page(&dsi_ctx, 0x04);
>> +
>> +	mipi_dsi_msleep(&dsi_ctx, 1);
>> +
>> +	// Unknown command
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0,
>> +		0x24, 0x01);
>> +
>> +	mipi_dsi_msleep(&dsi_ctx, 1);
>> +
>> +	jd9161z_switch_page(&dsi_ctx, 0x02);
>> +
>> +	mipi_dsi_msleep(&dsi_ctx, 1);
>> +
>> +	// SETRGBCYC2 (RGB IF source switch control timing)
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc1,
>> +		0x71);
>> +
>> +	mipi_dsi_msleep(&dsi_ctx, 1);
>> +
>> +	// Unknown command
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc2,
>> +		0x00, 0x18, 0x08, 0x1e, 0x25, 0x7c, 0xc7);
>> +
>> +	mipi_dsi_msleep(&dsi_ctx, 1);
>> +
>> +	jd9161z_switch_page(&dsi_ctx, 0x00);
>> +
>> +	mipi_dsi_msleep(&dsi_ctx, 1);
>> +
>> +	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
>> +
>> +	mipi_dsi_msleep(&dsi_ctx, 1);
>> +
>> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>> +
>> +	mipi_dsi_msleep(&dsi_ctx, 120);
>> +
>> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
>> +
>> +	mipi_dsi_msleep(&dsi_ctx, 5);
>> +
>> +	return dsi_ctx.accum_err;
>> +};
>> +
>> +static const struct jadard_panel_desc zhunyi_z40046_ctc_desc = {
>> +	.mode = {
>> +		.clock		= (480 + 20 + 20 + 20) * (800 + 14 + 4 + 8) * 60 / 1000,
>> +
>> +		.hdisplay	= 480,
>> +		.hsync_start	= 480 + 20,
>> +		.hsync_end	= 480 + 20 + 20,
>> +		.htotal		= 480 + 20 + 20 + 20,
>> +
>> +		.vdisplay	= 800,
>> +		.vsync_start	= 800 + 14,
>> +		.vsync_end	= 800 + 14 + 4,
>> +		.vtotal		= 800 + 14 + 4 + 8,
>> +
>> +		.width_mm	= 52,
>> +		.height_mm	= 86,
>> +		.flags		= DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
>> +		.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
>> +	},
>> +	.lanes = 2,
>> +	.format = MIPI_DSI_FMT_RGB888,
>> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
>> +		MIPI_DSI_MODE_LPM,
>> +	.lp11_before_reset = true,
>> +	.reset_before_power_off_vcioo = true,
>> +	.vcioo_to_lp11_delay_ms = 5,
>> +	.lp11_to_reset_delay_ms = 10,
>> +	.backlight_off_to_display_off_delay_ms = 100,
>> +	.display_off_to_enter_sleep_delay_ms = 50,
>> +	.enter_sleep_to_reset_down_delay_ms = 100,
>> +	.init = zhunyi_z40046_init_cmds_ctc,
>> +};
>> +
>> +// Sequence retrieved from Xiaomi Mi Smart Clock x04g kernel in boot.bin
>> +static int zhunyi_z40046_init_cmds_boe(struct jadard *jadard_data)
>> +{
>> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard_data->dsi };
>> +
>> +	// Init configuration sequence
>> +	jd9161z_switch_page(&dsi_ctx, 0x00);
>> +	jd9161z_enable_standard_cmds(&dsi_ctx);
>> +
>> +	// GAMMA_SET (pos/neg voltage of gamma power)
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb7,
>> +		0x10, 0x08, 0x42, 0x00, 0x56, 0x42);
>> +
>> +	// DCDC_SEL (power mode and charge pump settings)
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xbb,
>> +		0x52, 0x0f, 0xb2, 0xb2, 0xb2, 0xc0, 0xd0, 0x50,
>> +		0xf0, 0x40, 0x50);
>> +
>> +	// VDDD_CTRL (control logic voltage setting)
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xbc,
>> +		0x73, 0x14);
>> +
>> +	// SETRGBCYC (display waveform cycle of RGB mode)
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc3,
>> +		0x04, 0x07, 0x0b, 0x17, 0x00, 0x17, 0x04, 0x17,
>> +		0x17, 0x00, 0x17, 0x82, 0x0b, 0x82);
>> +
>> +	// SET_TCON (timing control setting)
>> +	// param[0][5:4] + param[1]: number of panel lines / 2
>> +	//   400 = 01 1001 0000 -> 0x10, 0x90
>> +	// param[2]: scan line time width
>> +	// param[3]: vfp: 14
>> +	// param[4]: vs + vbp - 1: 11
>> +	// param[5]: hbp: 6
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc4,
>> +		0x10, 0x90, 0x92, 0x0e, 0x06);
>> +
>> +	// SET_R_GAMMA (set red gamma output voltage)
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc8,
>> +		0x7f, 0x78, 0x69, 0x56, 0x47, 0x33, 0x34, 0x1e,
>> +		0x3b, 0x3e, 0x43, 0x67, 0x5d, 0x6f, 0x68, 0x70,
>> +		0x6a, 0x61, 0x3c, 0x7f, 0x78, 0x69, 0x56, 0x47,
>> +		0x33, 0x34, 0x1e, 0x3b, 0x3e, 0x43, 0x67, 0x5d,
>> +		0x6f, 0x68, 0x70, 0x6a, 0x61, 0x3c);
>> +
>> +	// SET_GIP_L (CGOUTx_L signal mapping, gs_panel = 0)
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd0,
>> +		0x1f, 0x1e, 0x07, 0x05, 0x01, 0x1f, 0x1f, 0x1f,
>> +		0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f);
>> +
>> +	// SET_GIP_R (CGOUTx_R signal mapping, gs_panel = 0)
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd1,
>> +		0x1f, 0x1e, 0x06, 0x04, 0x00, 0x1f, 0x1f, 0x1f,
>> +		0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f);
>> +
>> +	// SET_GIP_L_GS (CGOUTx_L signal mapping, gs_panel = 1)
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd2,
>> +		0x1f, 0x1f, 0x04, 0x06, 0x00, 0x1e, 0x1f, 0x1f,
>> +		0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f);
>> +
>> +	// SET_GIP_R_GS (CGOUTx_R signal mapping, gs_panel = 1)
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd3,
>> +		0x1f, 0x1f, 0x05, 0x07, 0x01, 0x1e, 0x1f, 0x1f,
>> +		0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f);
>> +
>> +	// SETGIP1 (GIP signal timing 1)
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd4,
>> +		0x30, 0x00, 0x00, 0x00, 0x00, 0x01, 0x10, 0x00,
>> +		0x03, 0x03, 0x68, 0x03, 0x40, 0x05, 0x00, 0x00,
>> +		0x00, 0xcc, 0x2d, 0x31, 0x02, 0x03, 0x68, 0x0c,
>> +		0x25, 0x00, 0x63, 0x03, 0x00);
>> +
>> +	// SETGIP2 (GIP signal timing 1)
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd5,
>> +		0x30, 0x08, 0x80, 0x18, 0x00, 0x00, 0x00, 0x18,
>> +		0x00, 0x00, 0x06, 0x60, 0x00, 0x07, 0x50, 0x00,
>> +		0x33, 0xc0, 0x00, 0x60, 0xc0, 0x00, 0x00, 0x00,
>> +		0x03, 0x60, 0x06, 0x10, 0x00, 0x00, 0x0f, 0x4f,
>> +		0x00, 0x10, 0x1f, 0x3f);
>> +
>> +	jd9161z_switch_page(&dsi_ctx, 0x02);
>> +
>> +	// SETRGBCYC2 (RGB IF source switch control timing)
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc1,
>> +		0x60);
>> +
>> +	// Unknown command
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc2,
>> +		0x00, 0x18, 0x08, 0x1e, 0x25, 0x7c, 0xc7);
>> +
>> +	jd9161z_switch_page(&dsi_ctx, 0x00);
>> +
>> +	// GAS_CTRL (GAS function control)
>> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xbe,
>> +		0x4e);
>> +
>> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>> +
>> +	mipi_dsi_msleep(&dsi_ctx, 120);
>> +
>> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
>> +
>> +	mipi_dsi_msleep(&dsi_ctx, 10);
>> +
>> +	return dsi_ctx.accum_err;
>> +};
>> +
>> +static const struct jadard_panel_desc zhunyi_z40046_boe_desc = {
>> +	.mode = {
>> +		.clock		= (480 + 20 + 20 + 20) * (800 + 14 + 4 + 8) * 60 / 1000,
>> +
>> +		.hdisplay	= 480,
>> +		.hsync_start	= 480 + 20,
>> +		.hsync_end	= 480 + 20 + 20,
>> +		.htotal		= 480 + 20 + 20 + 20,
>> +
>> +		.vdisplay	= 800,
>> +		.vsync_start	= 800 + 14,
>> +		.vsync_end	= 800 + 14 + 4,
>> +		.vtotal		= 800 + 14 + 4 + 8,
>> +
>> +		.width_mm	= 52,
>> +		.height_mm	= 86,
>> +		.flags		= DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
>> +		.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
>> +	},
>> +	.lanes = 2,
>> +	.format = MIPI_DSI_FMT_RGB888,
>> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
>> +		MIPI_DSI_MODE_LPM,
>> +	.lp11_before_reset = true,
>> +	.reset_before_power_off_vcioo = true,
>> +	.vcioo_to_lp11_delay_ms = 5,
>> +	.lp11_to_reset_delay_ms = 10,
>> +	.backlight_off_to_display_off_delay_ms = 100,
>> +	.display_off_to_enter_sleep_delay_ms = 50,
>> +	.enter_sleep_to_reset_down_delay_ms = 100,
>> +	.init = zhunyi_z40046_init_cmds_boe,
>> +};
>> +
>>   static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
>>   {
>>   	struct device *dev = &dsi->dev;
>> @@ -1707,6 +2012,14 @@ static const struct of_device_id jadard_of_match[] = {
>>   		.compatible = "taiguanck,xti05101-01a",
>>   		.data = &taiguan_xti05101_01a_desc
>>   	},
>> +	{
>> +		.compatible = "zhunyikeji,z40046-ctc",
>> +		.data = &zhunyi_z40046_ctc_desc
>> +	},
>> +	{
>> +		.compatible = "zhunyikeji,z40046-boe",
>> +		.data = &zhunyi_z40046_boe_desc
>> +	},
>>   	{ /* sentinel */ }
>>   };
>>   MODULE_DEVICE_TABLE(of, jadard_of_match);
>> -- 
>> 2.43.0
>>
> 

