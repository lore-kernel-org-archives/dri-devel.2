Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54166F9D0CA
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 12:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6098110E515;
	Tue, 14 Apr 2026 12:57:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ka7v/xNr";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E46110E607
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 12:57:25 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-483487335c2so61553125e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 05:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776171444; x=1776776244; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=HNKljDlGgBzgahYp2+OYLG0r/HqoCgAeLqufCE/G6VA=;
 b=Ka7v/xNr7OcADt0lWUIwNC4uLR85LTOZstSNv+FK42kx6TELHEVMBWz/Hu2TOBjiVC
 i4rbcGBDaeuh/z35GMOspbI+eC0SW8ZDyC9S9oTjUvFn3nTR/exr5JKywnpv03QqnN8u
 4gPsJ/hfBOP2hnpYAIGrTHtdwvNTn/4jAH1FSSrn1NV7XHzfyYGPgvEAuSVLVFF9Lqba
 lWSH1hpIlM7z5nWO6Ni81oaHCjHs4qV/wkfxZJnFitedtHR/d7wkdLtjvK5AY+iR1xXk
 q2+SAgdg2N7iF5dkxCkPP98Gn8SWPxnNSQ4WltVNptQ1c0mP/po+enygsbIpmWZMjrYs
 Bq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776171444; x=1776776244;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HNKljDlGgBzgahYp2+OYLG0r/HqoCgAeLqufCE/G6VA=;
 b=bADMFISDroiOo2bI1foilrr6BoeQ53c9EmG7A8qi4vX6ERbCxziVapNvhClbRskJzx
 NdbBEvgpuAw1tf85QoY5+cIFvioIFecBSc4onc2dlTLmjrlgYCehmCfZPnDb8GP1ShDS
 6A2/f+mgYvYs/ViKrCy1sdRNRFXXL5FqStiU9LUnEgAQAvXchJa1mD/GsRFNvt8CQ5fJ
 CKJnHIqqiFZhq4b7W+/xcS8dhRosFA/E0AtD0pC39kW1i3p3XaWPWACmdiqOpiq7OISH
 Qt50gXwqWilGqpitppKPsADA9xhPUvg5Xd0NuhHg5NRPq3M3ESARwgcywHsY1vcYd+7m
 VahQ==
X-Gm-Message-State: AOJu0YwM52TloKYmK7BbYSNUdNv9yMyjlS4L5Ca6gdrzaghM+dDD5hBz
 bbKhlj+H+qIKnI/R4XX9JBkDH1sJR1apvJ6TxyNGiJj92hABuf+IlP+8L+QvrCWElnM=
X-Gm-Gg: AeBDietCtEDdrPWEh6WmpzSCyP10Qd1RSZGrzlGpBsb289dwp/CRzSxDHxxFwiC9lm7
 xWi5p91Ga24kbTFGxSoS5JUb8EVTtsZaBWp5n9pP/DJFx2+c0pubh7oIfnhG0Iqdqik1C8z1KqL
 ak5tA+/q/VI2OwWXEmdasWM9RMQ8LQwOZUDTFNylEd0MxNAko6sdRmIrR7m5HCseIW0iudGLixP
 poQcMcw5S9N6Ukea3gTfysYhKTzOeTeS+++irxIBOyREzk2dl0Ub//okHitm9yFpSj+I2gb2GL4
 WNzhunveXd+q9xgeF8vNBbU5X6Gg+oqbgzTHMz3SsCgqAZeZSyYQ/ruby2isr5YLxqkbKMgzbMv
 ix2kS4kxuzke8PVgmCF5gSHj+HK0prA/Nfo2slszm/oRjgNO25CDnzKKzTC+xcIIK/v4vwSEWbA
 YaW5wdY0sSp7SoiBNc80AYfImxzoeziOyvi4Plx9CuBuk3V0wffqeHP/GnE2bK3zRmGGSN/OYHS
 a4HbNO8oPZsIxo=
X-Received: by 2002:a05:600c:8709:b0:488:945a:ed63 with SMTP id
 5b1f17b1804b1-488d6655adfmr241167395e9.0.1776171443536; 
 Tue, 14 Apr 2026 05:57:23 -0700 (PDT)
Received: from ?IPV6:2001:861:c12:13d0:5627:3bd0:f3ee:8a22?
 ([2001:861:c12:13d0:5627:3bd0:f3ee:8a22])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d67ced32sm168139455e9.7.2026.04.14.05.57.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 05:57:23 -0700 (PDT)
Message-ID: <b4f4d47f-b995-4554-81ed-9b47727582e7@linaro.org>
Date: Tue, 14 Apr 2026 14:57:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 07/21] drm/panel: himax-hx83102: support Waveshare
 12.3" DSI panel
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
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
 <20260413-waveshare-dsi-touch-v3-7-3aeb53022c32@oss.qualcomm.com>
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
In-Reply-To: <20260413-waveshare-dsi-touch-v3-7-3aeb53022c32@oss.qualcomm.com>
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
> Add support for the Waveshare 12.3" DSI TOUCH-A panel. According to the
> vendor driver, it uses different mode_flags, so let the panel
> descriptions override driver-wide defaults.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/panel/panel-himax-hx83102.c | 144 +++++++++++++++++++++++++++-
>   1 file changed, 142 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
> index 8b2a68ee851e..eab67893da86 100644
> --- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
> +++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
> @@ -29,11 +29,14 @@
>   #define HX83102_UNKNOWN_B8	0xb8
>   #define HX83102_SETEXTC		0xb9
>   #define HX83102_SETMIPI		0xba
> +#define HX83102_UNKNOWN_BB	0xbb
>   #define HX83102_SETVDC		0xbc
>   #define HX83102_SETBANK		0xbd
>   #define HX83102_UNKNOWN_BE	0xbe
>   #define HX83102_SETPTBA		0xbf
>   #define HX83102_SETSTBA		0xc0
> +#define HX83102_UNKNOWN_C2	0xc2
> +#define HX83102_UNKNOWN_C6	0xc6
>   #define HX83102_SETTCON		0xc7
>   #define HX83102_SETRAMDMY	0xc8
>   #define HX83102_SETPWM		0xc9
> @@ -78,6 +81,7 @@ struct hx83102_panel_desc {
>   	} size;
>   
>   	bool has_backlight;
> +	unsigned long mode_flags;
>   
>   	int (*init)(struct hx83102 *ctx);
>   };
> @@ -765,6 +769,111 @@ static int holitech_htf065h045_init(struct hx83102 *ctx)
>   	return dsi_ctx.accum_err;
>   }
>   
> +/* This is HX83102-E, assuming commands are the same as the normal HX83102 */
> +static int waveshare_12_3_a_init(struct hx83102 *ctx)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETEXTC, 0x83, 0x10, 0x2e);
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xcd);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_BB, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPCTRL, 0x67, 0x2c, 0xff, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_BE, 0x11, 0x96, 0x89);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_D9, 0x04, 0x03, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPOWER,
> +				     0x10, 0xfa, 0xaf, 0xaf, 0x33, 0x33, 0xb1, 0x4d, 0x2f, 0x36,
> +				     0x36, 0x36, 0x36, 0x22, 0x21, 0x15, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETDISP,
> +				     0x00, 0xd0, 0x27, 0x80, 0x00, 0x14, 0x40, 0x2c, 0x32, 0x02,
> +				     0x00, 0x00, 0x15, 0x20, 0xd7, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCYC,
> +				     0x98, 0xa0, 0x01, 0x01, 0x98, 0xa0, 0x68, 0x50, 0x01, 0xc7,
> +				     0x01, 0x58, 0x00, 0xff, 0x00, 0xff);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_B6, 0x4d, 0x4d, 0xe3);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPTBA, 0xfc, 0x85, 0x80);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_D2, 0x33, 0x33);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP0,
> +				     0x00, 0x00, 0x00, 0x00, 0x64, 0x04, 0x00, 0x08, 0x08, 0x27,
> +				     0x27, 0x22, 0x2f, 0x15, 0x15, 0x04, 0x04, 0x32, 0x10, 0x13,
> +				     0x00, 0x13, 0x32, 0x10, 0x1f, 0x00,
> +				     0x02, 0x32, 0x17, 0xfd, 0x00, 0x10, 0x00, 0x00, 0x20,
> +				     0x30, 0x01, 0x55, 0x21, 0x38, 0x01, 0x55, 0x0f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGMA,
> +				     0x00, 0x0c, 0x1a, 0x23, 0x2b, 0x4f, 0x64, 0x69, 0x6c, 0x64,
> +				     0x77, 0x77, 0x76, 0x80, 0x79, 0x7e, 0x85, 0x9a, 0x97, 0x4d,
> +				     0x56, 0x64, 0x70, 0x00, 0x0c, 0x1a, 0x23, 0x2b, 0x4f, 0x64,
> +				     0x69, 0x6c, 0x64, 0x77, 0x77, 0x76, 0x80, 0x79, 0x7e, 0x85,
> +				     0x9a, 0x97, 0x4d, 0x56, 0x64, 0x76);
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPOWER, 0x01, 0x9b, 0x01, 0x31);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCLOCK,
> +				     0x80, 0x36, 0x12, 0x16, 0xc0, 0x28, 0x40, 0x84, 0x22);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP0,
> +				     0x01, 0x00, 0xfc, 0x00, 0x00, 0x11, 0x10, 0x00, 0x0e, 0x00,
> +				     0x01);
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCYC, 0x4e, 0x00, 0x33, 0x11, 0x33, 0x88);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPTBA, 0xf2, 0x00, 0x02);
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSTBA,
> +				     0x23, 0x23, 0x22, 0x11, 0xa2, 0x17, 0x00, 0x80, 0x00, 0x00,
> +				     0x08, 0x00, 0x63, 0x63);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_C6, 0xf9);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETTCON, 0x30);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETRAMDMY,
> +				     0x00, 0x04, 0x04, 0x00, 0x00, 0x82, 0x13, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCASCADE, 0x07, 0x04, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP1,
> +				     0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x21, 0x20, 0x21, 0x20,
> +				     0x01, 0x00, 0x03, 0x02, 0x05, 0x04, 0x07, 0x06, 0x1a, 0x1a,
> +				     0x1a, 0x1a, 0x9a, 0x9a, 0x9a, 0x9a, 0x18, 0x18, 0x18, 0x18,
> +				     0x21, 0x20, 0x21, 0x20, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
> +				     0x18, 0x18, 0x18, 0x18);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP2,
> +				     0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x20, 0x21, 0x20, 0x21,
> +				     0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x1a, 0x1a,
> +				     0x1a, 0x1a, 0x1a, 0x1a, 0x1a, 0x1a, 0x18, 0x18, 0x18, 0x18,
> +				     0x20, 0x21, 0x20, 0x21, 0x98, 0x98, 0x98, 0x98, 0x98, 0x98,
> +				     0x98, 0x98, 0x98, 0x98);
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETTP1,
> +				     0x00, 0x34, 0x01, 0x88, 0x0e, 0xbe, 0x0f);
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_C2, 0x43, 0xff, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPANEL, 0x02);
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETDISP, 0x80);
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP3,
> +				     0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +				     0xaa, 0xaa, 0xaa, 0x80, 0x2a, 0xaa, 0xaa, 0xaa, 0xaa, 0x80,
> +				     0x2a, 0xaa, 0xaa, 0xaa);
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP3,
> +				     0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
> +				     0xaa, 0xaa);
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP3,
> +				     0xff, 0xff, 0xff, 0xff,
> +				     0xff, 0xf0, 0xff, 0xff,
> +				     0xff, 0xff, 0xff, 0xf0);
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x00);
> +
> +	return dsi_ctx.accum_err;
> +};
> +
>   static const struct drm_display_mode starry_mode = {
>   	.clock = 162680,
>   	.hdisplay = 1200,
> @@ -920,6 +1029,30 @@ static const struct hx83102_panel_desc holitech_htf065h045_desc = {
>   	.init = holitech_htf065h045_init,
>   };
>   
> +static const struct drm_display_mode waveshare_12_3_a_mode = {
> +	.clock = 95000,
> +	.hdisplay = 720,
> +	.hsync_start = 720 + 10,
> +	.hsync_end = 720 + 10 + 10,
> +	.htotal = 720 + 10 + 10 + 12,
> +	.vdisplay = 1920,
> +	.vsync_start = 1920 + 64,
> +	.vsync_end = 1920 + 64 + 18,
> +	.vtotal = 1920 + 64 + 18 + 4,
> +	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +};
> +
> +static const struct hx83102_panel_desc waveshare_12_3_inch_a_desc = {
> +	.modes = &waveshare_12_3_a_mode,
> +	.size = {
> +		.width_mm = 109,
> +		.height_mm = 292,
> +	},
> +	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> +		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.init = waveshare_12_3_a_init,
> +};
> +
>   static int hx83102_enable(struct drm_panel *panel)
>   {
>   	msleep(130);
> @@ -1168,8 +1301,12 @@ static int hx83102_probe(struct mipi_dsi_device *dsi)
>   	desc = of_device_get_match_data(&dsi->dev);
>   	dsi->lanes = 4;
>   	dsi->format = MIPI_DSI_FMT_RGB888;
> -	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> -					  MIPI_DSI_MODE_LPM;
> +	if (desc->mode_flags)
> +		dsi->mode_flags = desc->mode_flags;
> +	else
> +		dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
> +			MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> +			MIPI_DSI_MODE_LPM;
>   	ctx->desc = desc;
>   	ctx->dsi = dsi;
>   	ret = hx83102_panel_add(ctx);
> @@ -1220,6 +1357,9 @@ static const struct of_device_id hx83102_of_match[] = {
>   	{ .compatible = "holitech,htf065h045",
>   	  .data = &holitech_htf065h045_desc
>   	},
> +	{ .compatible = "waveshare,12.3-dsi-touch-a",
> +	  .data = &waveshare_12_3_inch_a_desc
> +	},
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, hx83102_of_match);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
