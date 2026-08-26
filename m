Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6A5C61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 09:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A47310EC8E;
	Wed, 26 Aug 2026 09:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L8ymaPTH";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C83910EC8E
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:54:24 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso3715835e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 02:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787738063; x=1788342863; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SDtTT4dCnjJ69lmBAdXwlid3ixyj5+6saySsWKlL1vI=;
 b=L8ymaPTHw/oFEwxtZvKzx3QGWW3i2ERMiqe1jRb+0oESNi70P+zI7/0O+BxMFvjgvj
 /B3dLszGh7ESLCeRYxH9wET4LqDIDqaioVPJQRGJWKmBxlmH1A3sekFIvQIEqrdocu3V
 3kVVZoVO9DRNc9rlNj6IOSHsx6dqqB3W0fnLZZ4z0cDRLY6Tgi3p0fVgmSKShYtoCHQI
 bMniwUeajoEJ3E/ZTABE0uI9ziRYc1TcIHdMviveHnr3Z5syP4L+cBAwy0vl8zuMyGI6
 8lrRG1TafqgXrZLLBWHX8UdRT7YrFLWbOu8TzJaWLwSoQ9ZyUFT1bH0Cg+1hCfmYM2Qo
 4HBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787738063; x=1788342863;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SDtTT4dCnjJ69lmBAdXwlid3ixyj5+6saySsWKlL1vI=;
 b=lp7WYiETOZ5a2DDZT7nzVa5Bnh3mQ3LnPFlw78ZcmUJ4zQ5O0ZUNMF+DpeYBUSEcqp
 fQBl62wtvPnB4ZpDDBCBouXdqt3aijL8z3Eslux159GxQ8ylxw/tMsgHSYMraaIhVeY0
 Iqc4CJmISuZTZpS91s7Kf4oz8pBCXoZ3e2FDOzKNXhdcVBfqPjdlx1QIch0E0sgrnVv7
 6x5RWi9t52oxDnaSXxjdve/OL3fbU6FksbMLKUh4Tckwf2n02tet/So+pMG8T+b4mofK
 GPP056ebCeR0pvqf+OF9u7kAmIMORrSbzQGWY3mlSbTQodIcL65KhMTDuTAobZsLK2wX
 V1hA==
X-Gm-Message-State: AFuF++k0EgS7R5lOV1VP97QIACWmROKhH65x2V4uoW5A4b5vYn+R/d4l
 AHPQ+/9O9VgwQPG8wMXjs2kISuIRhKue54CY6HOKCCpzcxakNv4PO5fx7x5IJZuXfHI=
X-Gm-Gg: AR+sD115oua4J/ZRFM24OheU3iSOBhTu9ReGGrCVvXP67BjI3v5nTgmRd45T79gjnfv
 6+oGizbNFSZUUyIAHtbURM+NQjuxf5lI+3l4Iaw5Ffb7nmYOQNGZSHR22OZxBowxk1NJlVTK8ft
 pol3zH/BQRO/MjkUFC91GOnksvPJk3ZbPH+IhadguAvQ/4UXJ31eBg1IaM5XNiQ8v4bLlPWbnv+
 ID382oh6DCu42ChoIhWQfar9TAik2wbcKTJqprZ4YkEBBXTC/iLhIFbxnkxYVUd25MbDDJN5T0U
 sPsWAo0IxMm7k82YgkwsjCK564jqYnJDeoCmYX83OOF4Pyl7X4oM2iVUdQ2yLow+VxM0IFToPyG
 NlUWEWCYNFPXp7LzfxnOU/Z43mEk/1DPRM5Gj9jNd2HePVsGUJabe3jrlFOjhfF7GWuBpwEgACS
 MhhW/rjxEeDOPMkNTiuMZV2clWbQ2mA4MRd+TV7AHT2U6pvb/WLEeIBVfmKlO8ZF6Dp7z5f2sue
 1spd7kmeEVI8EPgk1E2UIYT3tFsXOlf4ZElva4kaO3RSQ==
X-Received: by 2002:a05:600c:a43:b0:497:fecd:5b00 with SMTP id
 5b1f17b1804b1-499dc717e27mr42328835e9.9.1787738062562; 
 Wed, 26 Aug 2026 02:54:22 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:135f:84f0:37f7:9223:8e7a:9b5f?
 ([2a0d:e487:135f:84f0:37f7:9223:8e7a:9b5f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm21065975e9.2.2026.08.26.02.54.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 02:54:22 -0700 (PDT)
Message-ID: <40d0cb7c-eabd-45e0-aa4c-5638cc71b8db@linaro.org>
Date: Wed, 26 Aug 2026 11:54:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 4/4] drm/panel: visionox-vtdr6130: Add Retroid Pocket 6
 panel
To: webgeek1234@gmail.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260814-rp6-panel-v1-0-111c1aeccf0f@gmail.com>
 <20260814-rp6-panel-v1-4-111c1aeccf0f@gmail.com>
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
In-Reply-To: <20260814-rp6-panel-v1-4-111c1aeccf0f@gmail.com>
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

On 8/14/26 20:17, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> Add support for the 1080x1920 panel used in the Retroid Pocket 6.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 114 ++++++++++++++++++++++++
>   1 file changed, 114 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> index 805c9846c2a0b..5c826f95ec478 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> @@ -64,6 +64,82 @@ static void visionox_vtdr6130_reset(struct visionox_vtdr6130 *ctx)
>   	usleep_range(10000, 11000);
>   }
>   
> +static int retroidpocket_rp6_on(struct visionox_vtdr6130 *ctx)
> +{
> +	struct mipi_dsi_device *dsi = ctx->dsi;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
> +	struct drm_dsc_picture_parameter_set pps;
> +
> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x01);
> +	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx,
> +				     MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x20);
> +	mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx, 0xff07);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_ADDRESS_MODE, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x00);
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x11, 0x00, 0x00, 0x89,
> +				     0x30, 0x80, 0x07, 0x80, 0x04, 0x38, 0x00,
> +				     0x14, 0x02, 0x1c, 0x02, 0x1c, 0x02, 0x00,
> +				     0x02, 0x25, 0x00, 0x20, 0x01, 0xd5, 0x00,
> +				     0x07, 0x00, 0x0d, 0x05, 0x7a, 0x05, 0x16,
> +				     0x18, 0x00, 0x10, 0xf0, 0x03, 0x0c, 0x20,
> +				     0x00, 0x06, 0x0b, 0x0b, 0x33, 0x0e, 0x1c,
> +				     0x2a, 0x38, 0x46, 0x54, 0x62, 0x69, 0x70,
> +				     0x77, 0x79, 0x7b, 0x7d, 0x7e, 0x01, 0x02,
> +				     0x01, 0x00, 0x09, 0x40, 0x09, 0xbe, 0x19,
> +				     0xfc, 0x19, 0xfa, 0x19, 0xf8, 0x1a, 0x38,
> +				     0x1a, 0x78, 0x1a, 0xb6, 0x2a, 0xb6, 0x2a,
> +				     0xf4, 0x2a, 0xf4, 0x4b, 0x34, 0x63, 0x74,
> +				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0xaa, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb1, 0x02, 0x15, 0x00, 0x14,
> +				     0x00, 0x20, 0x00, 0x02, 0x16, 0x00, 0x14,
> +				     0x07, 0xb4, 0x00, 0x02, 0x16, 0x00, 0x14,
> +				     0x00, 0x10, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0xaa, 0x14);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb2, 0x03, 0x33);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb4, 0x0a, 0x72, 0x00, 0x00,
> +				     0x0a, 0x72, 0x00, 0x00, 0x0a, 0x72, 0x00,
> +				     0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb5, 0x00, 0x1e, 0x1e, 0x1e,
> +				     0x1e, 0x1e, 0x1e, 0x06, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb9, 0x00, 0x00, 0x08, 0x1e,
> +				     0x1e, 0x1e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xbc, 0x10, 0x00, 0x00, 0x08,
> +				     0x11, 0x1e, 0x7c, 0x1e, 0x7c, 0x1e, 0x7c);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xbe, 0x10, 0x10, 0x00, 0x0c,
> +				     0x22, 0x1e, 0x62, 0x1e, 0x62, 0x1e, 0x62);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xff, 0x5a, 0x80);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x13);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfd, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xff, 0x5a, 0x81);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf9, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xff, 0x5a, 0x83);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf8, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0xaa, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xff, 0x5a, 0x00);
> +
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 150);
> +
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 50);
> +
> +	drm_dsc_pps_payload_pack(&pps, dsi->dsc);
> +	mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
> +	mipi_dsi_compression_mode_multi(&dsi_ctx, true);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
>   static int visionox_vtdr6130_on(struct visionox_vtdr6130 *ctx)
>   {
>   	struct mipi_dsi_device *dsi = ctx->dsi;
> @@ -204,6 +280,43 @@ static int visionox_vtdr6130_unprepare(struct drm_panel *panel)
>   	return 0;
>   }
>   
> +static const struct drm_display_mode retroidpocket_rp6_modes[] = {
> +	{
> +		.clock = (1080 + 22 + 2 + 16) * (1920 + 16 + 2 + 20) * 120 / 1000,
> +		.hdisplay = 1080,
> +		.hsync_start = 1080 + 22,
> +		.hsync_end = 1080 + 22 + 2,
> +		.htotal = 1080 + 22 + 2 + 16,
> +		.vdisplay = 1920,
> +		.vsync_start = 1920 + 16,
> +		.vsync_end = 1920 + 16 + 2,
> +		.vtotal = 1920 + 16 + 2 + 20,
> +	},
> +};
> +
> +static struct visionox_vtdr6130_desc retroidpocket_rp6_panel_desc = {
> +	.modes = retroidpocket_rp6_modes,
> +	.num_modes = ARRAY_SIZE(retroidpocket_rp6_modes),
> +	.width_mm = 69,
> +	.height_mm = 122,

With the dimension in the mode:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

> +	.bpc = 8,
> +	.lanes = 4,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.mode_flags = MIPI_DSI_MODE_NO_EOT_PACKET |
> +		      MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.init_sequence = retroidpocket_rp6_on,
> +	.dsc = {
> +		.dsc_version_major = 0x1,
> +		.dsc_version_minor = 0x1,
> +		.slice_height = 12,
> +		.slice_width = 540,
> +		.slice_count = 2,
> +		.bits_per_component = 8,
> +		.bits_per_pixel = 8 << 4,
> +		.block_pred_enable = true,
> +	},
> +};
> +
>   static const struct drm_display_mode visionox_vtdr6130_modes[] = {
>   	{
>   		.clock = (1080 + 20 + 2 + 20) * (2400 + 20 + 2 + 18) * 144 / 1000,
> @@ -357,6 +470,7 @@ static int visionox_vtdr6130_probe(struct mipi_dsi_device *dsi)
>   }
>   
>   static const struct of_device_id visionox_vtdr6130_of_match[] = {
> +	{ .compatible = "retroidpocket,rp6-panel", .data = &retroidpocket_rp6_panel_desc },
>   	{ .compatible = "visionox,vtdr6130", .data = &visionox_vtdr6130_panel_desc },
>   	{ /* sentinel */ }
>   };
> 

