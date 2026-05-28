Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D51CD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 11:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07D7D10F01F;
	Thu, 28 May 2026 11:05:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lH9HNh4S";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E180510F01F
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 11:05:20 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-45edc09f51bso1103864f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 04:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779966319; x=1780571119; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=/WBV2stTi+BoMvjTn+6Wdm0ar2Vhc8k/vzOLTV4C0Ts=;
 b=lH9HNh4Svhxu1xAmTB88Cr0NGZi2r/opK5H/7ys2LqPFxXDZ2VDXmX1PkCQU3Gt31i
 f3tYDZviGNaYNuw/7aTtx1Zjgs8pnVyCxcKIz0qcivh5oH33RPoxviG3l0R0+aWjj49K
 /5oK+jfTkCdsoKzUak0DwzFOwyixl7AtWb059UoRhkfPHNjlKUOMuSFEKE/G3UeuE0dm
 LWVL2bHZCmA53GFEYNeB9gxs+A9gVdHApY+zK3YxVN/z5DFnyZ+Uj/q8O5hHPXFdpDxx
 himkDwA+SiUIcmPDQeFsjYenyDCI8ec2VKJ4D4ZMZCYLZwPBiJq6Mef/RphPmsA7Pw19
 L6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779966319; x=1780571119;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/WBV2stTi+BoMvjTn+6Wdm0ar2Vhc8k/vzOLTV4C0Ts=;
 b=ea0CfuWqvPRAZJwyhsJ0htRdw0UtJA9B4WiigM4S+lfAtgoRhy0UHT24pBAU8712RA
 SvXmwjrgHpgfEaBDgY4hXLc6yWzDMEqmhi5TtSle+wMi2ETxd6IzLy0z7XIRTlTky1+E
 jKX2hm3kpboMa6h8ZpN2Gx94/ardTMVulLTPw4CPpHuguaOmBVGunVXo1zVic/8aiwms
 v8Z6oaEt9WHPmZq7VfQbNqXxJrQfSaDdcff1mfpKkVOwjy33FNsj0hfgQuBTgSHDUcmy
 3k6vxf9wCxC2rN4+tlVpZOSoTzIoPe7FBeoa02t7hYvnQF3Zgounry4WBOY7xGETbNhb
 lIbQ==
X-Gm-Message-State: AOJu0Yym+L6wNUf3AeslVELuNcfRAnIrRA7kQROkr79lq55TjiCYWCge
 u75J4t7rAOlJvsseNFBKxA/1aw4UaGa+52Tg6PWTVjBfkzB0P5/I5hYdDP+73AYaceE=
X-Gm-Gg: Acq92OFWBZrV7MzwXPNx/o7azNGTETY5zeiZuY2romIj+Ag44t6OzOw3PGlJKZsKRFn
 Uefy4n3fZFvAuU2/4xlpgPE6Xg6yS7vvXXZYd0hdDZoolUzJLA7o6v/dIW5hj5qgLxq9kq4vzzH
 WoRnQufO470sifAHWD8WwdbAFHp0DUTUB83/5V1KP+Qd+ehOg6o0/iD7SYoEQFPmEvpqvb8nSC2
 f+oGKoFTGAhlZdOa5rDcZ3c8Cf/7B55jq+bM84FS4BppQlADgpBAfef3miy4UXN9ENrNCIQpIPW
 o/SkpMc/Hrw43ojRY+cWft/nkTI6NN7Sc/yUm1A+CmwUNRc2z95qaAnaaFH4iCsRBjU4EwNcoRl
 I7lGKMJGiCwh5a6MPepyLaisef1IHFRwnbarlWmva3pMhelTbD6geHH6tM0K/nH2UHEpvzowFnm
 swDT2y/OdhXsYSfjbdm0AicIAPP9w8ZxIxgUZEFFGd1Gw=
X-Received: by 2002:a05:600c:4f52:b0:490:4f91:5519 with SMTP id
 5b1f17b1804b1-4904f91568dmr456980265e9.18.1779966318522; 
 Thu, 28 May 2026 04:05:18 -0700 (PDT)
Received: from [172.20.10.2] ([37.167.60.147])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5584b8sm12243364f8f.11.2026.05.28.04.05.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 04:05:18 -0700 (PDT)
Message-ID: <e8526e33-d34b-4900-81f1-f0a16edca388@linaro.org>
Date: Thu, 28 May 2026 13:05:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 2/2] drm/panel: Add Ilitek ILI9488 controller driver
To: Igor Reznichenko <igor@reznichenko.net>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Kael D'Alcamo <dev@kael-k.io>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260527062300.88928-1-igor@reznichenko.net>
 <20260527062300.88928-3-igor@reznichenko.net>
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
In-Reply-To: <20260527062300.88928-3-igor@reznichenko.net>
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

Hi,

On 5/27/26 08:23, Igor Reznichenko wrote:
> Add support for Ilitek ILI9488 DSI controller which is used in
> FocusLCDs E35GH-I-MW800-CB 320x480 MIPI DSI panel. The mode timing
> was adjusted after STM32MP157 testing. The previous 14.256 MHz mode
> worked on AM62P, but was awkward for STM32 DSI/LTDC clock synthesis.
> 
> Signed-off-by: Igor Reznichenko <igor@reznichenko.net>
> ---
>   MAINTAINERS                                  |   6 +
>   drivers/gpu/drm/panel/Kconfig                |   9 +
>   drivers/gpu/drm/panel/Makefile               |   1 +
>   drivers/gpu/drm/panel/panel-ilitek-ili9488.c | 299 +++++++++++++++++++
>   4 files changed, 315 insertions(+)
>   create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9488.c

<snip>

> +
> +static int ili9488_dsi_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	struct ili9488 *ili;
> +	int i, ret;
> +
> +	ili = devm_drm_panel_alloc(dev, struct ili9488, panel, &ili9488_funcs,
> +				   DRM_MODE_CONNECTOR_DSI);
> +	if (IS_ERR(ili))
> +		return PTR_ERR(ili);
> +
> +	ili->desc = device_get_match_data(dev);
> +	mipi_dsi_set_drvdata(dsi, ili);
> +	ili->dsi = dsi;
> +
> +	dsi->mode_flags = ili->desc->mode_flags;
> +	dsi->format = ili->desc->format;
> +	dsi->lanes = ili->desc->lanes;
> +
> +	ili->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(ili->reset))
> +		return dev_err_probe(dev, PTR_ERR(ili->reset),
> +				     "failed to get reset-gpios\n");
> +
> +	for (i = 0; i < ARRAY_SIZE(ili->supplies); i++)
> +		ili->supplies[i].supply = regulator_names[i];
> +
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ili->supplies),
> +				      ili->supplies);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to get regulators\n");
> +
> +	ret = of_drm_get_panel_orientation(dev->of_node, &ili->orientation);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get orientation\n");
> +
> +	ret = drm_panel_of_backlight(&ili->panel);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get backlight\n");
> +
> +	ili->panel.prepare_prev_first = true;
> +	drm_panel_add(&ili->panel);
> +
> +	ret = mipi_dsi_attach(dsi);
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "failed to attach to DSI host\n");
> +		drm_panel_remove(&ili->panel);
> +		return ret;
> +	}

Please switch to devm_drm_panel_add() and devm_mipi_dsi_attach() and drop the remove callback.

> +
> +	return 0;
> +}
> +
> +static void ili9488_dsi_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct ili9488 *ili = mipi_dsi_get_drvdata(dsi);
> +	int ret;
> +
> +	ret = mipi_dsi_detach(dsi);
> +	if (ret < 0)
> +		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
> +
> +	drm_panel_remove(&ili->panel);
> +}
> +
> +static const struct ili9488_desc e35gh_i_mw800cb_desc = {
> +	.init_sequence = e35gh_i_mw800cb_init,
> +	.display_mode = &e35gh_i_mw800cb_display_mode,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> +		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.format = MIPI_DSI_FMT_RGB666_PACKED,
> +	.lanes = 1,
> +};
> +
> +static const struct of_device_id ili9488_of_match[] = {
> +	{ .compatible = "focuslcds,e35gh-i-mw800cb", .data = &e35gh_i_mw800cb_desc },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, ili9488_of_match);
> +
> +static struct mipi_dsi_driver ili9488_dsi_driver = {
> +	.probe	= ili9488_dsi_probe,
> +	.remove	= ili9488_dsi_remove,
> +	.driver = {
> +		.name		= "ili9488-dsi",
> +		.of_match_table	= ili9488_of_match,
> +	},
> +};
> +module_mipi_dsi_driver(ili9488_dsi_driver);
> +
> +MODULE_AUTHOR("Igor Reznichenko <igor@reznichenko.net>");
> +MODULE_DESCRIPTION("Ilitek ILI9488 Controller Driver");
> +MODULE_LICENSE("GPL");

Thanks,
Neil
