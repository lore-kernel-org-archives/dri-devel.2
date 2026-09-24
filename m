Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9CEC98317
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1411310F564;
	Thu, 24 Sep 2026 13:34:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tC/PyUrn";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBC0B10F564
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:34:51 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd4ba9f68so23595305e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790256890; x=1790861690; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t6AkLGE1oPn+7n3tb70RelMorb35N4qf1Ykw3uaiHDk=;
 b=tC/PyUrnnzDCuuUqNilj6OjtCIL0Mtj7R9octLPk58f+zLuRucjiHQxZfc4uCsBWRY
 XD4zoJ26mQL1D5ksQEeIGzkitqXLnWSVya4Hb54pERGAfDwny6PL3oVcui2DcHv6PiOm
 vi4NobfjXRgoCvXqli9ryL2GF0fTHPq9KzGLBKYTHBufKOPY/FZraookWyCWEdVcariw
 yus1IyLKApcTDWHWcV9hK2+Qa0DrIW6fYKTHHNZ+hmM8CHJkoewveUvhYuGjkgHfA2VH
 9qIjKy7B4dwtj8l1jGWFdZJEPqch1+sfig/lkK4KUcIlheSrOnDeGqCg7B72AB5M1WYt
 A3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790256890; x=1790861690;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t6AkLGE1oPn+7n3tb70RelMorb35N4qf1Ykw3uaiHDk=;
 b=oJ1glY7tEoJ/J/HfC7YEyheR8DV4gk1mvg+ZWBr/OpctGYT0bG3590SvfAnLf0mlTK
 wm001EHM/UTPdtLUPjPkxPRmCqNiaqJ/VgdTQQfa7bP9ovZxPg5K9/ZRJiuUfbJZGnG7
 gnDjJZfHRXXpaJannxTOebgq7+KHoS+aDvOjtSxh9Zt6ejDFIrdnGdHmeLl6zARkB2r5
 AR9zJcoOQc26aabHSxLZwckZPbU7DCq7stb/7p0X6My7svVR58sP7YvRZ3EtjauFXuwL
 ivrnf4aYDXWddLEdtl4A2WxWLpHhIIXyDpcv9NVeGxr0lsbDIMOXlwuQ25a/1482PcxZ
 JYzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0mZSLRsWjv9Gw0/G7DeumpkB1v3ig5vC0ahpluMrQwppFFPDTpNHRGmDAolAmPyyThP5xCP0sN4A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ksAAVbjjSHtqs0V4a9i+roh2Q9hoRCnaRE68t1FlVfSVHTq5tp
 p8L3H7dvmpMVcD5oLKKgTPfk8xwb6W2Ia8ldEVcSRadRG1AsfS8jhC/Xro1rV1LSofM=
X-Gm-Gg: AYBFou2Rn0AatJJvXxHrj+ZNSrUOqwLf9drz2puJZ1N3EkVh0DArAEa43vIT2WNvITQ
 O1X0Hgf20fM4jXejYGuR/FWpCe0BlyFz8Crd/C8L3O+4Qw0U8v3Qys/ghSJVYOEdqLY3CLp16D7
 dcfOhNkl0BkUTIj2jtqgM66n1KQZfAaUWBixtrlTb8zsoDI/F7GoMUv5DTLyH0cCNtbULJeYgsP
 qHkw13gDWUs5gywNl3SZLH5/gDnWBPO3FuFx78QgUiH36JTGO3I32c83W0aWfLR9g+e1pw1qSY5
 0nB4YJ/gcAFf20m5pwydAv65agugHdFWtos7X/hq6ipfZB+9WQiFxWr7SGK9buWp9zqyCZhOIG8
 L/z79JZm96tXU6UjPycY5eiiHqNiyMgLM2aG0zVVTMov8yySuN2se0ZEmcPQf4rsFqeHt65Jbb9
 SQpuTceVTA0Cy//mrifqrcK7N9IiLfdjKhH4hlCVMR/A0zyv5jYlt1s2lMhbDFYG2jp2ufLfEUI
 9Ow+vkzEuH9Q3oE0//mBjQMmHykcGWDKcMKpKJei+cweBFMP5GUiA==
X-Received: by 2002:a05:600c:a010:b0:49e:79c5:ee93 with SMTP id
 5b1f17b1804b1-49fe66b422emr43419115e9.8.1790256890140; 
 Thu, 24 Sep 2026 06:34:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a?
 ([2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe0c4054fsm112926555e9.3.2026.09.24.06.34.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 06:34:49 -0700 (PDT)
Message-ID: <898ff24b-8462-48b0-87ed-ba76f2608dd0@linaro.org>
Date: Thu, 24 Sep 2026 15:34:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 5/9] drm/panel: novatek-nt36672a: Combine two init
 callbacks into one
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
 phone-devel@vger.kernel.org
References: <20260917-nt36672a-panels-v2-0-f8de8be5b86f@minlexx.ru>
 <20260917-nt36672a-panels-v2-5-f8de8be5b86f@minlexx.ru>
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
In-Reply-To: <20260917-nt36672a-panels-v2-5-f8de8be5b86f@minlexx.ru>
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
> The split between .send_init_cmds_1 and _cmds_2 is completely artificial
> and unnecessary. Two command sets are split in between by the sequence:
>   - exit_sleep_mode
>   - delay
>   - set_display_on
> 
> But not every panel driver follows this "split" in their init sequence.
> Some may have different delay timer, or put exit_sleep_mode/display_on
> commands into other places in the sequence.
> 
> In order to make this driver more extensible, combine two init functions
> into one by puting exit_sleep_mode/delay/display_on in the middle,
> followed by commands from cmds_2. As part of this step, also move the
> tianma-beryllium specific deinit sequence with its delays from
> nt36672a_panel_unprepare() to tianma_fhd_video_send_deinit_cmds(), so
> that each panel model can have its deinit sequence with its own delays.
> 
> No functional change - full init sequence with all the delays for the
> tianma_fhd_video panel is kept the same in the end.
> 
> Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
> 
> ---
> v2: move tianma_fhd deinit commands into its own deinit function
>      (set_display_off, msleep, enter_sleep_mode, msleep)
> ---
>   drivers/gpu/drm/panel/panel-novatek-nt36672a.c | 61 ++++++++++----------------
>   1 file changed, 23 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> index 73bec4f47ec60..a445c8067aa5f 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> @@ -51,8 +51,7 @@ struct nt36672a_panel_desc {
>   	enum mipi_dsi_pixel_format format;
>   	unsigned int lanes;
>   
> -	void (*send_init_cmds_1)(struct mipi_dsi_multi_context *dsi_ctx);
> -	void (*send_init_cmds_2)(struct mipi_dsi_multi_context *dsi_ctx);
> +	void (*send_init_cmds)(struct mipi_dsi_multi_context *dsi_ctx);
>   	void (*send_deinit_cmds)(struct mipi_dsi_multi_context *dsi_ctx);
>   };
>   
> @@ -92,20 +91,6 @@ static int nt36672a_panel_unprepare(struct drm_panel *panel)
>   	if (pinfo->desc->send_deinit_cmds)
>   		pinfo->desc->send_deinit_cmds(&dsi_ctx);
>   
> -	/* Reset error to continue with display off even if send_cmds failed */
> -	dsi_ctx.accum_err = 0;
> -	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> -	/* Reset error to continue power-down even if display off failed */
> -	dsi_ctx.accum_err = 0;
> -
> -	/* 120ms delay required here as per DCS spec */
> -	msleep(120);
> -
> -	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> -
> -	/* 0x3C = 60ms delay */
> -	msleep(60);
> -
>   	nt36672a_panel_power_off(panel);
>   
>   	return 0;
> @@ -140,22 +125,9 @@ static int nt36672a_panel_prepare(struct drm_panel *panel)
>   
>   	dsi_ctx.accum_err = nt36672a_panel_power_on(pinfo);
>   
> -	/* send first part of init cmds */
> -	if (pinfo->desc->send_init_cmds_1)
> -		pinfo->desc->send_init_cmds_1(&dsi_ctx);
> -
> -	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> -
> -	/* 0x46 = 70 ms delay */
> -	mipi_dsi_msleep(&dsi_ctx, 70);
> -
> -	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> -
> -	/* Send rest of the init cmds */
> -	if (pinfo->desc->send_init_cmds_2)
> -		pinfo->desc->send_init_cmds_2(&dsi_ctx);
> -
> -	mipi_dsi_msleep(&dsi_ctx, 120);
> +	/* send init cmds */
> +	if (pinfo->desc->send_init_cmds)
> +		pinfo->desc->send_init_cmds(&dsi_ctx);
>   
>   	if (dsi_ctx.accum_err < 0)
>   		gpiod_set_value(pinfo->reset_gpio, 0);
> @@ -192,7 +164,7 @@ static const struct drm_panel_funcs panel_funcs = {
>   	.get_modes = nt36672a_panel_get_modes,
>   };
>   
> -static void tianma_fhd_video_send_init_cmds_1(struct mipi_dsi_multi_context *dsi_ctx)
> +static void tianma_fhd_video_send_init_cmds(struct mipi_dsi_multi_context *dsi_ctx)
>   {
>   	u8 reg;
>   
> @@ -352,15 +324,19 @@ static void tianma_fhd_video_send_init_cmds_1(struct mipi_dsi_multi_context *dsi
>   	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x51, 0xff);
>   	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x53, 0x24);
>   	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x55, 0x00);
> -}
>   
> -static void tianma_fhd_video_send_init_cmds_2(struct mipi_dsi_multi_context *dsi_ctx)
> -{
> +	mipi_dsi_dcs_exit_sleep_mode_multi(dsi_ctx);
> +	/* 0x46 = 70 ms delay */
> +	mipi_dsi_msleep(dsi_ctx, 70);
> +	mipi_dsi_dcs_set_display_on_multi(dsi_ctx);
> +
>   	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x24);
>   	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfb, 0x01);
>   	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc3, 0x01);
>   	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc4, 0x54);
>   	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x10);
> +
> +	mipi_dsi_msleep(dsi_ctx, 120);
>   }
>   
>   static void tianma_fhd_video_send_deinit_cmds(struct mipi_dsi_multi_context *dsi_ctx)
> @@ -369,6 +345,16 @@ static void tianma_fhd_video_send_deinit_cmds(struct mipi_dsi_multi_context *dsi
>   	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfb, 0x01);
>   	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc3, 0x01);
>   	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x10);
> +
> +	/* Reset error to continue with display off even if send_cmds failed */
> +	dsi_ctx->accum_err = 0;
> +	mipi_dsi_dcs_set_display_off_multi(dsi_ctx);
> +	/* Reset error to continue power-down even if display off failed */
> +	dsi_ctx->accum_err = 0;
> +	/* 120ms delay required here as per DCS spec */
> +	msleep(120);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(dsi_ctx);
> +	msleep(60); /* 0x3C = 60ms delay */
>   }
>   
>   static const struct drm_display_mode tianma_fhd_video_panel_default_mode = {
> @@ -399,8 +385,7 @@ static const struct nt36672a_panel_desc tianma_fhd_video_panel_desc = {
>   			| MIPI_DSI_MODE_VIDEO_BURST,
>   	.format = MIPI_DSI_FMT_RGB888,
>   	.lanes = 4,
> -	.send_init_cmds_1 = tianma_fhd_video_send_init_cmds_1,
> -	.send_init_cmds_2 = tianma_fhd_video_send_init_cmds_2,
> +	.send_init_cmds = tianma_fhd_video_send_init_cmds,
>   	.send_deinit_cmds = tianma_fhd_video_send_deinit_cmds,
>   };
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
