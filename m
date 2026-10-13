Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00B3CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2EF910E48B;
	Tue, 13 Oct 2026 12:51:38 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF5F89DFC
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 12:51:33 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a17baef589so24828105e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 05:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791895891; x=1792500691; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C/SKzSR1FlaBjksY3ryxPox+t/cHlKOTxdG+EHLnF8M=;
 b=nFiBHr4cUx9lXJNYTCSu1XtQZ+sJ0AIMB2dd/k2MSkRFGzI4oVhOWvECm/UTIxdeUF
 QPL4LugLdRkEuVt/qFyh1gS/Ic5T7cy8iuXDXJzf1a9Pr4dCotNUaZgQtz5g9K2W4jw0
 oScZ+tpKkFHl80u7hrR6ia7dgn+SIxQGWHv0aGn+1TYzS4VaEYVuAOFmOStl3/XMGHAO
 X6Qy5DkS0lvTxie6ltslW+PHuGHQQ1eF41nly5G9zR0hjhna8fAC+R5A7dgmB0apzdHd
 NjQwVE42inVYlgMcBM+V4mUym6ikzuv0TDe47AUTL07NHFU5fl90wC+W3Io+/eRG5/D/
 kMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791895891; x=1792500691;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=C/SKzSR1FlaBjksY3ryxPox+t/cHlKOTxdG+EHLnF8M=;
 b=QLXIdd8aUKWp6PqR71WCyakdUhnNlwNcLsw3wPW21kHOt8AIEHwj+tLxbFj8a+Py3Q
 zDToQTVpqIqFiZii7/u4IbPMjm99zbUzZEsC6bA6ZeBk35miT9ymf533SuHrGkRdtNQH
 CNYxw34DQCN7m/7zaMzevbY1c5NdxyeFcxb2pCKbG38cZ0iUdQRNJexxHEc0okwWAMtT
 kGYtAYEEmFhqeh3A3e0R6iPHrJnXkP5ymJtUQGQy9R4UBAoHN/d+B+c/3RCDmniZedy8
 4MjC3PMtRmgLA6KXcbN3bv/HX8PfvaWtxNsbvjAWc1O3JHcVKiFjPY+PM1eafDztqYD7
 2pBQ==
X-Gm-Message-State: AFq9FYJXwStxlllMmtDVmfaZZuMq/NymwwhxNx7NOBL0Rju3V4wGwTTe
 /7lloyuC59eV/hFZ8txaVCuNSYg8h3fty/xXmcvcHUX4Ei1ASBpfGoN+I/s4IMR4xVk=
X-Gm-Gg: AYBFou08JTbz/Ic1DrGkr0fyPcvPnboIsD2sf2x2qxwNMi/9a/t8tWCsERj/M5jU3wX
 EI+f4ELc1ne794Cf+CVEGzwVbvIZQdLpbwb6jPGQ/BS9ekysuw3cr2gDwSJ+lX9ZZAe1ZWhkdCb
 VoYpFo7zKtD4UjLrn9gDFUJwfpj9C8KBXkO8ybU5zQf+5xG1r+VKr04IQ5zhoYyN+9Ej/k80MJF
 VX8P5IzzkSqRSMMudOTLZA1EGeKgooJfADro+hV0FV1cBW2Hhtg8k2Sk1XZ3P1Mu8qqcUDPeS/C
 sfWy4PaDgZ/kX/5sn/gvhd46Pp86wTHPQqSbde8SX23wfaufG/yE/t654HcFLqDCw0lzb3p3hqm
 vn30bUdGc3yV4UFoHXV8nGcl/HbVQTpv6aYZ0uWygiJP4c851ED8zKea40O3JVOLKjwSPPBoYYG
 INzmhTxJhklZ8Gqb23fmggniA6Ns1tpSTwO+mE5/V+dDiTji84C2/mvHFWWalPmqOKIKm2sJyiG
 XTN9+cbCQ7neNCRPkcEdr9ZmBhj0CfFQe2/paa4CTuRcr4cduaKOw==
X-Received: by 2002:a05:600c:620f:b0:49f:dc71:e609 with SMTP id
 5b1f17b1804b1-4a18e499874mr232245505e9.20.1791895891216; 
 Tue, 13 Oct 2026 05:51:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:ef1f:5ab3:36fa:3ccb?
 ([2a01:e0a:106d:1080:ef1f:5ab3:36fa:3ccb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a19f249692sm306840785e9.3.2026.10.13.05.51.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 05:51:30 -0700 (PDT)
Message-ID: <f05474f8-89a0-4ad7-bf00-58b9a12770f8@linaro.org>
Date: Tue, 13 Oct 2026 14:51:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC 9/9] drm/panel: novatek-nt35950: use the atomic state
 to select the mode
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Jessica Zhang
 <jesszhan0024@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>,
 Val Packett <val@packett.cool>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20261008-panel-atomic-state-v1-0-b157fddb8de1@oss.qualcomm.com>
 <20261008-panel-atomic-state-v1-9-b157fddb8de1@oss.qualcomm.com>
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
In-Reply-To: <20261008-panel-atomic-state-v1-9-b157fddb8de1@oss.qualcomm.com>
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

On 10/8/26 15:14, Dmitry Baryshkov wrote:
> The compression, scaler and display output settings of the NT35950
> depend on the mode being set. As the panel has no access to the
> configuration being committed, the driver saves the connector pointer in
> get_modes() and then dereferences connector->state->crtc->state from the
> prepare() callback. This is done without holding the modeset locks and
> it reads the current state of the objects rather than the state being
> committed. Moreover, if none of the panel modes match, the driver
> silently programs the panel for the first mode instead of rejecting the
> configuration.
> 
> Subclass the panel state to store the parameters of the selected mode.
> Look the mode up in atomic_check(), failing the commit if the panel
> doesn't support it, and use the stored parameters in atomic_prepare().
> Switch unprepare() to its atomic variant too, so that the driver uses a
> single set of callbacks.
> 
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/panel/panel-novatek-nt35950.c | 159 +++++++++++++++++++-------
>   1 file changed, 117 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
> index 94aa6489d99f..f5161f11b1f5 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
> @@ -11,12 +11,15 @@
>   #include <linux/of.h>
>   #include <linux/of_graph.h>
>   #include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
>   
> +#include <drm/drm_atomic.h>
>   #include <drm/drm_connector.h>
>   #include <drm/drm_crtc.h>
>   #include <drm/drm_mipi_dsi.h>
>   #include <drm/drm_modes.h>
>   #include <drm/drm_panel.h>
> +#include <drm/drm_print.h>
>   
>   #define MCS_CMD_MAUCCTR			0xf0 /* Manufacturer command enable */
>   #define MCS_PARAM_SCALER_FUNCTION	0x58 /* Scale-up function */
> @@ -51,16 +54,19 @@
>   
>   struct nt35950 {
>   	struct drm_panel panel;
> -	struct drm_connector *connector;
>   	struct mipi_dsi_device *dsi[2];
>   	struct regulator_bulk_data vregs[NT35950_VREG_MAX];
>   	struct gpio_desc *reset_gpio;
>   	const struct nt35950_panel_desc *desc;
>   
> -	int cur_mode;
>   	u8 last_page;
>   };
>   
> +struct nt35950_state {
> +	struct drm_panel_state base;
> +	const struct nt35950_panel_mode *mode_data;
> +};
> +
>   struct nt35950_panel_mode {
>   	const struct drm_display_mode mode;
>   
> @@ -88,6 +94,9 @@ static inline struct nt35950 *to_nt35950(struct drm_panel *panel)
>   	return container_of(panel, struct nt35950, panel);
>   }
>   
> +#define to_nt35950_state(panel_state) \
> +	container_of_const(panel_state, struct nt35950_state, base)
> +
>   static void nt35950_reset(struct nt35950 *nt)
>   {
>   	gpiod_set_value_cansleep(nt->reset_gpio, 1);
> @@ -212,61 +221,37 @@ static void nt35950_inject_black_image(struct mipi_dsi_multi_context *dsi_ctx)
>   
>   /*
>    * nt35950_set_dispout - Set Display Output register parameters
> - * @nt:    Main driver structure
>    * @dsi_ctx: context for mipi_dsi functions
> + * @mode_data: Parameters of the mode being set
>    */
>   static void nt35950_set_dispout(struct mipi_dsi_multi_context *dsi_ctx,
> -				struct nt35950 *nt)
> +				const struct nt35950_panel_mode *mode_data)
>   {
>   	u8 cmd_dispout[] = { MCS_PARAM_DISP_OUTPUT_CTRL, 0x00 };
> -	const struct nt35950_panel_mode *mode_data = nt->desc->mode_data;
>   
> -	if (mode_data[nt->cur_mode].is_video_mode)
> +	if (mode_data->is_video_mode)
>   		cmd_dispout[1] |= MCS_DISP_OUT_VIDEO_MODE;
> -	if (mode_data[nt->cur_mode].enable_sram)
> +	if (mode_data->enable_sram)
>   		cmd_dispout[1] |= MCS_DISP_OUT_SRAM_EN;
>   
>   	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, cmd_dispout,
>   					ARRAY_SIZE(cmd_dispout));
>   }
>   
> -static int nt35950_get_current_mode(struct nt35950 *nt)
> -{
> -	struct drm_connector *connector = nt->connector;
> -	struct drm_crtc_state *crtc_state;
> -	int i;
> -
> -	/* Return the default (first) mode if no info available yet */
> -	if (!connector->state || !connector->state->crtc)
> -		return 0;
> -
> -	crtc_state = connector->state->crtc->state;
> -
> -	for (i = 0; i < nt->desc->num_modes; i++) {
> -		if (drm_mode_match(&crtc_state->mode,
> -				   &nt->desc->mode_data[i].mode,
> -				   DRM_MODE_MATCH_TIMINGS | DRM_MODE_MATCH_CLOCK))
> -			return i;
> -	}
> -
> -	return 0;
> -}
> -
> -static int nt35950_on(struct nt35950 *nt)
> +static int nt35950_on(struct nt35950 *nt,
> +		      const struct nt35950_panel_mode *mode_data)
>   {
> -	const struct nt35950_panel_mode *mode_data = nt->desc->mode_data;
>   	struct mipi_dsi_device *dsi = nt->dsi[0];
>   	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>   
> -	nt->cur_mode = nt35950_get_current_mode(nt);
>   	nt->dsi[0]->mode_flags |= MIPI_DSI_MODE_LPM;
>   	nt->dsi[1]->mode_flags |= MIPI_DSI_MODE_LPM;
>   
>   	nt35950_set_cmd2_page(&dsi_ctx, nt, 0);
> -	nt35950_set_data_compression(&dsi_ctx, nt, mode_data[nt->cur_mode].compression);
> -	nt35950_set_scale_mode(&dsi_ctx, mode_data[nt->cur_mode].scaler_mode);
> -	nt35950_set_scaler(&dsi_ctx, mode_data[nt->cur_mode].scaler_on);
> -	nt35950_set_dispout(&dsi_ctx, nt);
> +	nt35950_set_data_compression(&dsi_ctx, nt, mode_data->compression);
> +	nt35950_set_scale_mode(&dsi_ctx, mode_data->scaler_mode);
> +	nt35950_set_scaler(&dsi_ctx, mode_data->scaler_on);
> +	nt35950_set_dispout(&dsi_ctx, mode_data);
>   
>   	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
>   	mipi_dsi_dcs_set_tear_scanline_multi(&dsi_ctx, 0);
> @@ -354,11 +339,43 @@ static int nt35950_sharp_init_vregs(struct nt35950 *nt, struct device *dev)
>   	return 0;
>   }
>   
> -static int nt35950_prepare(struct drm_panel *panel)
> +static int nt35950_atomic_check(struct drm_panel *panel,
> +				struct drm_atomic_commit *commit)
> +{
> +	struct nt35950 *nt = to_nt35950(panel);
> +	struct drm_panel_state *panel_state;
> +	struct drm_crtc_state *crtc_state;
> +	int i;
> +
> +	panel_state = drm_atomic_get_new_panel_state(commit, panel);
> +	crtc_state = drm_atomic_get_new_crtc_state_for_panel(commit, panel);
> +	if (!panel_state || !crtc_state)
> +		return -EINVAL;
> +
> +	for (i = 0; i < nt->desc->num_modes; i++) {
> +		if (drm_mode_match(&crtc_state->mode,
> +				   &nt->desc->mode_data[i].mode,
> +				   DRM_MODE_MATCH_TIMINGS | DRM_MODE_MATCH_CLOCK)) {
> +			to_nt35950_state(panel_state)->mode_data =
> +				&nt->desc->mode_data[i];
> +			return 0;
> +		}
> +	}


This looks like a boilerplate which could be moved to the drm_panel if atomic_check is
not defined.

Neil

> +
> +	return -EINVAL;
> +}
> +
> +static int nt35950_atomic_prepare(struct drm_panel *panel,
> +				  struct drm_atomic_commit *commit)
>   {
>   	struct nt35950 *nt = to_nt35950(panel);
> +	struct drm_panel_state *panel_state;
>   	int ret;
>   
> +	panel_state = drm_atomic_get_new_panel_state(commit, panel);
> +	if (!panel_state || !to_nt35950_state(panel_state)->mode_data)
> +		return -EINVAL;
> +
>   	ret = regulator_enable(nt->vregs[0].consumer);
>   	if (ret)
>   		return ret;
> @@ -380,7 +397,7 @@ static int nt35950_prepare(struct drm_panel *panel)
>   
>   	nt35950_reset(nt);
>   
> -	ret = nt35950_on(nt);
> +	ret = nt35950_on(nt, to_nt35950_state(panel_state)->mode_data);
>   
>   end:
>   	if (ret < 0) {
> @@ -391,7 +408,8 @@ static int nt35950_prepare(struct drm_panel *panel)
>   	return 0;
>   }
>   
> -static int nt35950_unprepare(struct drm_panel *panel)
> +static int nt35950_atomic_unprepare(struct drm_panel *panel,
> +				    struct drm_atomic_commit *commit)
>   {
>   	struct nt35950 *nt = to_nt35950(panel);
>   
> @@ -429,15 +447,72 @@ static int nt35950_get_modes(struct drm_panel *panel,
>   	connector->display_info.bpc = 8;
>   	connector->display_info.height_mm = nt->desc->mode_data[0].mode.height_mm;
>   	connector->display_info.width_mm = nt->desc->mode_data[0].mode.width_mm;
> -	nt->connector = connector;
>   
>   	return nt->desc->num_modes;
>   }
>   
> +static struct drm_panel_state *
> +nt35950_atomic_create_state(struct drm_panel *panel)
> +{
> +	struct nt35950_state *state;
> +
> +	state = kzalloc_obj(*state);
> +	if (!state)
> +		return ERR_PTR(-ENOMEM);
> +
> +	__drm_atomic_helper_panel_state_init(&state->base, panel);
> +
> +	return &state->base;
> +}
> +
> +static struct drm_panel_state *
> +nt35950_atomic_duplicate_state(struct drm_panel *panel)
> +{
> +	struct drm_panel_state *old_state = drm_panel_get_current_state(panel);
> +	struct nt35950_state *state;
> +
> +	if (!old_state)
> +		return NULL;
> +
> +	state = kzalloc_obj(*state);
> +	if (!state)
> +		return NULL;
> +
> +	__drm_atomic_helper_panel_duplicate_state(panel, &state->base);
> +	state->mode_data = to_nt35950_state(old_state)->mode_data;
> +
> +	return &state->base;
> +}
> +
> +static void nt35950_atomic_destroy_state(struct drm_panel *panel,
> +					 struct drm_panel_state *state)
> +{
> +	kfree(to_nt35950_state(state));
> +}
> +
> +static void nt35950_atomic_print_state(struct drm_printer *p,
> +				       const struct drm_panel_state *state)
> +{
> +	const struct nt35950_panel_mode *mode_data =
> +		to_nt35950_state(state)->mode_data;
> +
> +	if (!mode_data)
> +		return;
> +
> +	drm_printf_indent(p, 1, "compression: %02x\n", mode_data->compression);
> +	drm_printf_indent(p, 1, "scaler: %u, mode %02x\n",
> +			  mode_data->scaler_on, mode_data->scaler_mode);
> +}
> +
>   static const struct drm_panel_funcs nt35950_panel_funcs = {
> -	.prepare = nt35950_prepare,
> -	.unprepare = nt35950_unprepare,
> +	.atomic_check = nt35950_atomic_check,
> +	.atomic_prepare = nt35950_atomic_prepare,
> +	.atomic_unprepare = nt35950_atomic_unprepare,
>   	.get_modes = nt35950_get_modes,
> +	.atomic_create_state = nt35950_atomic_create_state,
> +	.atomic_duplicate_state = nt35950_atomic_duplicate_state,
> +	.atomic_destroy_state = nt35950_atomic_destroy_state,
> +	.atomic_print_state = nt35950_atomic_print_state,
>   };
>   
>   static int nt35950_probe(struct mipi_dsi_device *dsi)
> 

