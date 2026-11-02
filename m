Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938A6606A32C
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vvp46bTB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0C1910EDBB;
	Mon,  2 Nov 2026 13:02:23 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0CAD10EDC2
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:02:17 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so25837295e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793624536; x=1794229336; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OCwjDl9SqaD1n0bx2YhNRBtWOo95W909nhaKEEF1fA8=;
 b=vvp46bTBxnDnPFJKVNW1ThlXCDMwmSQgXKxVJNxpRAfNgrSogXxvM4ReNXbEKa91+D
 gSFAdcEHmOfKS7EjgJXpRgx4Osz2nYIRcI0hsB7EoJgC2XLq/bNW7VSvLhmw/6jJlbdh
 LaQh/phGwYYAK02uOAfbTVhsTT1/jf5DsPAm8BLz4NQDyKsaPaQ1x815xFs+5nFxOKZM
 SkncvpeJGTWLjL5sfS09uf1LxrdBmuSsVxwC9DUsggUa5ZrR8oryGpNbxOE7ulLYCNDb
 AOFTnKwtX3dMPQQA0JNzAUG+/9CWkGa85dF+PXjGRNks7wcRzkFMxLoQ1Yx3t6kOWNjz
 1vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793624536; x=1794229336;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OCwjDl9SqaD1n0bx2YhNRBtWOo95W909nhaKEEF1fA8=;
 b=dNfOQL2ih5ojUU2GG9QlAI7+RbHiKFB5CxylkwZV/UGANmECngrcBlOemzhiYSL4N2
 YNSFrh7ye8FndXJiBHTUuVZZZReFCtmJHAniy3wmmH5qKac8HVKaiooFHz2phvfro4mO
 j1c0kXtNEvL4qO+lyXTU+jIW71cqNZMfld0Bwtt7EYSXYV5cTixrmUnqe6BG1AaBVg/j
 U7zbKuwBycqXqLIBRCKvdeKeKWoskMKB4WIOw7AkDxPWzRUsslJyoSY3D+3N8gJra4/P
 2pKD71J07RZ2fNdWPzVhbsSmfZo9wKDiMK10ZLg4I70D3PLXKGcuwi7wkHQawHax5Odd
 flxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzihKxeQJ/8uzA4a7cEs2fjJ85kVKvWUlINgMnVByRt4o9vjIkI9kDtkz9KPiRAgXU7XMkXGkw/lfs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJgCCd0Q01yr0bJAgZhRVcW9v+DqohJ/ZqyH29TTplfU22fL8ye
 oHw2DhvMwGpGr4szDmwc3O24a1HTVsngPWncymxBLlNPA/AbLwu7dPgDe/XPAgkfKAU=
X-Gm-Gg: AYBFou0llYUFWdDJQ0u/IZtHYpb7OUZM4JJ+N8Zx9j+K4p+NRb5Uin4zWZJeX+3jjwz
 b7MTVn2FGBVTSCj+OSToEkyAc2NxbyoT5y8er4SzwgrvsWd5wt0XVluag9D0L/8D2hsMu01LfEU
 1GsxZQuYHxlSBbjHWi5zz/M7lzVt4qJZ4KmW4n4cT2+LT3L8ZzNIrnIu1yAbUCCVsGcN/uCATHc
 uF2WCh+RFqfQYL/KvEo9lltM1tgz+W3m2sa/1yVbP5cpA6aufsq0ZQqtXZBV+jKDPQLvrBMyasq
 8xkWaSuPKTSENMN/5fj5GXWClP/a+Ia47I+72pp+ELzmLJr8il25jWBeYhmUL7sNFq+c6OI2+bz
 Ter1Isrl9UtlBI2+wE5dDG/n4R36NiBAMaPaeB4ZevQHZPX9M40kxF64ESq7ew04um3wKNbI7pC
 Dt1FIiXY5Aq60mciFNiW7fWHU8/n5VSVpM6F/GV/UHHExxvovU0cHD/rJ15LQbi1HjoNFCUbI1/
 8R1kfHSYCaYzlqKZATRnA7giaeZ6lPUAMsECKCDOXUf8RbNx4g4wj9Y7PUfv/N/vlAXQSiEderp
 FZVGNRzn9Fwvim5AyfM6muZuDdQyqD3faX481PGshcl1J0IZrrcCuInyBB+BN0a5LVhqUFuxNG3
 unUtS
X-Received: by 2002:a05:600c:c0d4:b0:4b1:2026:6b31 with SMTP id
 5b1f17b1804b1-4b12026723bmr41745155e9.28.1793624532870; 
 Mon, 02 Nov 2026 05:02:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9476:5165:3a16:262?
 ([2a01:e0a:106d:1080:9476:5165:3a16:262])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09cc3e9asm119273755e9.3.2026.11.02.05.02.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 05:02:12 -0800 (PST)
Message-ID: <389b4336-395c-48ee-a2ed-5396fc8fe58a@linaro.org>
Date: Mon, 2 Nov 2026 14:02:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 3/5] drm/panel: feiyang-fy07024di26a30d: Use
 mipi_dsi_*_multi() functions
To: Hsieh Hung-En <hungen3108@gmail.com>, dianders@chromium.org,
 jesszhan0024@gmail.com
Cc: jagan@amarulasolutions.com, osama.abdelkader@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
References: <20261102043215.990351-1-hungen3108@gmail.com>
 <20261102043215.990351-4-hungen3108@gmail.com>
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
In-Reply-To: <20261102043215.990351-4-hungen3108@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 05:32, Hsieh Hung-En wrote:
> Replace the deprecated MIPI DSI DCS helpers with their _multi variants,
> as suggested in Documentation/gpu/todo.rst.
> 
> Replace the initialization command table and loop with seven direct
> mipi_dsi_dcs_write_seq_multi() calls. Preserve the original command
> order and values, using lowercase hexadecimal literals.
> 
> In prepare(), the first failed DCS write prevents subsequent transfers
> and its error is propagated through the cleanup path added by the
> preceding patch. The helpers also log command failures.
> 
> In unprepare(), clear accum_err between commands so that ENTER_SLEEP_MODE
> is still attempted if SET_DISPLAY_OFF fails, preserving the original
> error handling behavior.
> 
> In disable(), ignore SET_DISPLAY_OFF errors to allow drm_panel_disable()
> to clear panel->enabled, avoiding a stale enabled state after the panel
> is powered off. This follows commit 00efe8a68565 ("drm/panel:
> ronbo-rb070d30: Ignore DCS errors in disable()"). Command failures
> remain logged by the helper.
> 
> Signed-off-by: Hsieh Hung-En <hungen3108@gmail.com>
> ---
> 
> Notes:
>      Changes in v2:
>      - Replace the initialization command table with direct
>        mipi_dsi_dcs_write_seq_multi() calls, as suggested by Doug.
>      - Route initialization errors through the cleanup path added in 1/5.
>      - Convert initialization command values to lowercase hex.
>      - Drop the previous Reviewed-by tag due to the initialization rework.
>      
>      The seven initialization commands were checked against the original
>      table; their order and values are unchanged.
> 
>   .../drm/panel/panel-feiyang-fy07024di26a30d.c | 68 +++++++++----------
>   1 file changed, 33 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> index bb4cc1ea2ece..fa304eb7453b 100644
> --- a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> +++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> @@ -13,8 +13,6 @@
>   #include <linux/module.h>
>   #include <linux/regulator/consumer.h>
>   
> -#define FEIYANG_INIT_CMD_LEN	2
> -
>   struct feiyang {
>   	struct drm_panel	panel;
>   	struct mipi_dsi_device	*dsi;
> @@ -29,25 +27,21 @@ static inline struct feiyang *panel_to_feiyang(struct drm_panel *panel)
>   	return container_of(panel, struct feiyang, panel);
>   }
>   
> -struct feiyang_init_cmd {
> -	u8 data[FEIYANG_INIT_CMD_LEN];
> -};
> -
> -static const struct feiyang_init_cmd feiyang_init_cmds[] = {
> -	{ .data = { 0x80, 0x58 } },
> -	{ .data = { 0x81, 0x47 } },
> -	{ .data = { 0x82, 0xD4 } },
> -	{ .data = { 0x83, 0x88 } },
> -	{ .data = { 0x84, 0xA9 } },
> -	{ .data = { 0x85, 0xC3 } },
> -	{ .data = { 0x86, 0x82 } },
> -};
> +static void feiyang_init(struct mipi_dsi_multi_context *dsi_ctx)
> +{
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x80, 0x58);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x81, 0x47);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x82, 0xd4);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x83, 0x88);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x84, 0xa9);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x85, 0xc3);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x86, 0x82);
> +}
>   
>   static int feiyang_prepare(struct drm_panel *panel)
>   {
>   	struct feiyang *ctx = panel_to_feiyang(panel);
> -	struct mipi_dsi_device *dsi = ctx->dsi;
> -	unsigned int i;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
>   	int ret;
>   
>   	ret = regulator_enable(ctx->dvdd);
> @@ -77,15 +71,10 @@ static int feiyang_prepare(struct drm_panel *panel)
>   	/* T12 (video & logic signal rise + backlight rise) T12 >= 200ms */
>   	msleep(200);
>   
> -	for (i = 0; i < ARRAY_SIZE(feiyang_init_cmds); i++) {
> -		const struct feiyang_init_cmd *cmd =
> -						&feiyang_init_cmds[i];
> -
> -		ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data,
> -						FEIYANG_INIT_CMD_LEN);
> -		if (ret < 0)
> -			goto assert_reset;
> -	}
> +	feiyang_init(&dsi_ctx);
> +	ret = dsi_ctx.accum_err;
> +	if (ret < 0)
> +		goto assert_reset;
>   
>   	return 0;
>   
> @@ -104,32 +93,41 @@ static int feiyang_prepare(struct drm_panel *panel)
>   static int feiyang_enable(struct drm_panel *panel)
>   {
>   	struct feiyang *ctx = panel_to_feiyang(panel);
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
>   
>   	/* T12 (video & logic signal rise + backlight rise) T12 >= 200ms */
>   	msleep(200);
>   
> -	return mipi_dsi_dcs_set_display_on(ctx->dsi);
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +
> +	return dsi_ctx.accum_err;
>   }
>   
>   static int feiyang_disable(struct drm_panel *panel)
>   {
>   	struct feiyang *ctx = panel_to_feiyang(panel);
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> +
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>   
> -	return mipi_dsi_dcs_set_display_off(ctx->dsi);
> +	/*
> +	 * Returning an error would leave panel->enabled set, causing the
> +	 * next enable to be skipped even after unprepare powers off the panel.
> +	 * The helper above already logs any command failure.
> +	 */
> +	return 0;
>   }
>   
>   static int feiyang_unprepare(struct drm_panel *panel)
>   {
>   	struct feiyang *ctx = panel_to_feiyang(panel);
> -	int ret;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
>   
> -	ret = mipi_dsi_dcs_set_display_off(ctx->dsi);
> -	if (ret < 0)
> -		dev_err(panel->dev, "failed to set display off: %d\n", ret);
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>   
> -	ret = mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
> -	if (ret < 0)
> -		dev_err(panel->dev, "failed to enter sleep mode: %d\n", ret);
> +	/* Attempt to enter sleep mode even if display off failed. */
> +	dsi_ctx.accum_err = 0;
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>   
>   	/* T13 (backlight fall + video & logic signal fall) T13 >= 200ms */
>   	msleep(200);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
