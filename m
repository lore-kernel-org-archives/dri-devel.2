Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F82606A33B
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VNP4rcLS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84E3510EDC3;
	Mon,  2 Nov 2026 13:02:45 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB60F10EDC5
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:02:39 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so19285335e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793624558; x=1794229358; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pIqMIl5P68FoJDPXapJtVaGLG35bqCOVpQoFQ2sppUs=;
 b=VNP4rcLSGrKmEfn+HTLFBdgdAxKgeIbV/b4RgWuv7OnX1gjBennUTZN+J4WTfavDKS
 p075dS+Oc2mMSyOojnh9qCaJeur3oVDzQlWVvotwatfZtmYxJ5pZhJ+i2T3KhkPHksU7
 E3IVTc8sg7HEz5xnTnzTkyw1LymaJS3pxiUimX5oGrqF/gEkrRoeKD1nOp+/vnsOrzvo
 dBznMDbNYnqF6ElsxjYoWHYxi6AWoiwRB3rkYjIi0HskGb0bnMVzPzxnGbBJpNLBkbvx
 5AmHgu0MWxc9yHfNeQB8J6jfgm0prl2jYHDErMiugaC5bMb8G0NFv5SmFVrDyYOrOqYs
 2M0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793624558; x=1794229358;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pIqMIl5P68FoJDPXapJtVaGLG35bqCOVpQoFQ2sppUs=;
 b=EhwQ1MCIUhhbIuYFP/NTo5tZo+gZNoUXeSKBEgfZPUcpZdMZ5y9tFF0OuDPQNN138+
 hMal7K8eP+eJ8I4OCIjWwlUag8BfmT97mHFyPtB001wPPEAQ6hnEd2mE0KGDx3DZ0cea
 SG2RBGaRbGc9En7lGEfFSnuM7Lmew57C39kaFMezEhM/F1USG5b2a40XBdLotqNvomBc
 z/fRA21UIIRDCMz8c8FyDZX68jztQ67Ya9NXaPyoNiMtDNhqTg5hpUnNTzzMM25sNF3k
 mJ263p+R0WYUpWxOyjSEKCE0GYexwixgTVpZmRsx0tzr79F2wTV0F8Mc2jgtEdihbr8O
 XfJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmH5CwfrT3tfFVtRxepJGzAY9aYamsSzoN/lFyce9lX60eF2ZsrXs2bZ7c9nE0fCE7qF8+LpWbMMw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKZ7Bxi6EJoJhEa/68t4BY2o6gNRwYYk8WjqVbzdkCHn8X+4gCv
 sBF0rywn/T4TmNYGf30Ge9dlNYZVIX/BYBSFaYTB4/QlPtcA68PILSVOYVFuH5uMtYn2N1agsrP
 9ZVpF
X-Gm-Gg: AYBFou3Q0q1Vdw8GKNB054JV6qqseE5MgD4hlQicAtqIAkNfeXPHcDdU3SUCyGZ7Czm
 CvPKLe58SA0TeooGDWHJ3sQ8BL+N7IqO7Fgq52Qu+DsKMxFbptUJr6RwZHkFp4qQGpdtOZdxapF
 rZOK3vM1AUnJZeGimCDen+sFQNKWdWnLEJZcSSZyGpxwYrpoRKTSZZ6h7CcxrqdTIhdRM3V8mpV
 pAh2od9KHrYhJObDltv+KM69Ioh9nh6Pt1q/MZEt+P2Aw9CVPSctDsvpq2lkRSyFphAKxwr64Q1
 gTTn+ioC/f36/YFxmoYpe6SDTebGfloVh1bFlNVSE8kxYze85bMQbsBleI9fk7UNzvA4IaAMXyS
 lGQyf4gRhdJQ7b/6AyHC3ln9iBfTwAXhnhTh8TkoIx3RrrSHG/FQIxPxr4i/NE17U67zA+tRgkV
 t51tREYbok2e0tQXQv28RDNAQ0ukVd3yUMqr2S+XmHEtsNUDZzSeT0Hz1pRCn8JHqjdoDwYPMT4
 +Smon6PK9ZLo6J9B4TCmML5x4NbNorpSG1MEY/jetgl4BQtbfNlMKeKzq6ZW0iJadYqt0z+ERd2
 9f0xe2OjHnDHQ2LO563G0BTrgbI895WS8uK5mGAGeUUdwUi4yyjmf4QgYCyqCuoARuw2KdLZxX4
 WCaam
X-Received: by 2002:a05:600c:608d:b0:4a2:1197:1de0 with SMTP id
 5b1f17b1804b1-4ac18b7dcdbmr233597745e9.19.1793624557914; 
 Mon, 02 Nov 2026 05:02:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9476:5165:3a16:262?
 ([2a01:e0a:106d:1080:9476:5165:3a16:262])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf7146621sm275614585e9.13.2026.11.02.05.02.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 05:02:37 -0800 (PST)
Message-ID: <7ba2f6b7-a9b8-4558-b62e-84261f1c3e9b@linaro.org>
Date: Mon, 2 Nov 2026 14:02:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 4/5] drm/panel: raydium-rm68200: Use mipi_dsi_*_multi()
 functions
To: Hsieh Hung-En <hungen3108@gmail.com>, dianders@chromium.org,
 jesszhan0024@gmail.com
Cc: jagan@amarulasolutions.com, osama.abdelkader@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
References: <20261102043215.990351-1-hungen3108@gmail.com>
 <20261102043215.990351-5-hungen3108@gmail.com>
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
In-Reply-To: <20261102043215.990351-5-hungen3108@gmail.com>
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
> Replace the deprecated MIPI DSI DCS helpers and custom DCS write
> wrappers with their multi-context equivalents.
> 
> Preserve individual DCS transactions for registers that do not support
> auto-increment. Share the multi-context with rm68200_init_sequence()
> so that initialization failures stop subsequent DCS transfers and
> cause prepare() to fail instead of only being logged. Errors are
> handled by the cleanup path in prepare().
> 
> Use mipi_dsi_msleep() to skip delays after a failed command. In
> unprepare(), clear accum_err between commands so that ENTER_SLEEP_MODE
> is still attempted if SET_DISPLAY_OFF fails.
> 
> The new helpers log failures at error level. Initialization write
> errors are no longer rate-limited.
> 
> Signed-off-by: Hsieh Hung-En <hungen3108@gmail.com>
> ---
> 
> Notes:
>      Changes in v2:
>      - Merge v1 patches 2/3 and 3/3, as suggested by Doug.
>      - Route initialization and DCS command failures through the prepare()
>        error cleanup path introduced earlier in this series.
>      - Drop Doug's Reviewed-by tag from v1 3/3 because the patches were
>        merged and the error handling was reworked.
>      
>      Validation:
>      - Mechanically compared all 58 initialization calls against v1.
>        Command addresses, payloads, and ordering are unchanged.
>      - Verified the expansion of dcs_write_cmd_seq() in v1 using
>        preprocessed output, confirming that each register address is
>        written in a separate DCS transaction. The macro is unchanged
>        from v1.
>      
>      The uppercase hexadecimal literals are retained in this patch.
>      Their formatting will be addressed separately in the next patch.
> 
>   drivers/gpu/drm/panel/panel-raydium-rm68200.c | 208 ++++++++----------
>   1 file changed, 91 insertions(+), 117 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-raydium-rm68200.c b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
> index 3a59eb00274d..8ce89f09540c 100644
> --- a/drivers/gpu/drm/panel/panel-raydium-rm68200.c
> +++ b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
> @@ -98,149 +98,123 @@ static inline struct rm68200 *panel_to_rm68200(struct drm_panel *panel)
>   	return container_of(panel, struct rm68200, panel);
>   }
>   
> -static void rm68200_dcs_write_buf(struct rm68200 *ctx, const void *data,
> -				  size_t len)
> -{
> -	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> -	int err;
> -
> -	err = mipi_dsi_dcs_write_buffer(dsi, data, len);
> -	if (err < 0)
> -		dev_err_ratelimited(ctx->dev, "MIPI DSI DCS write buffer failed: %d\n", err);
> -}
> -
> -static void rm68200_dcs_write_cmd(struct rm68200 *ctx, u8 cmd, u8 value)
> -{
> -	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> -	int err;
> -
> -	err = mipi_dsi_dcs_write(dsi, cmd, &value, 1);
> -	if (err < 0)
> -		dev_err_ratelimited(ctx->dev, "MIPI DSI DCS write failed: %d\n", err);
> -}
> -
> -#define dcs_write_seq(ctx, seq...)				\
> -({								\
> -	static const u8 d[] = { seq };				\
> -								\
> -	rm68200_dcs_write_buf(ctx, d, ARRAY_SIZE(d));		\
> -})
> -
>   /*
>    * This panel is not able to auto-increment all cmd addresses so for some of
>    * them, we need to send them one by one...
> + *
> + * Use arr instead of d to avoid shadowing the local d[] declared by
> + * mipi_dsi_dcs_write_var_seq_multi().
>    */
> -#define dcs_write_cmd_seq(ctx, cmd, seq...)			\
> -({								\
> -	static const u8 d[] = { seq };				\
> -	unsigned int i;						\
> -								\
> -	for (i = 0; i < ARRAY_SIZE(d) ; i++)			\
> -		rm68200_dcs_write_cmd(ctx, cmd + i, d[i]);	\
> -})
> -
> -static void rm68200_init_sequence(struct rm68200 *ctx)
> +#define dcs_write_cmd_seq(dsi_ctx, cmd, seq...)			\
> +	do {								\
> +		static const u8 arr[] = { seq };			\
> +		unsigned int i;						\
> +									\
> +		for (i = 0; i < ARRAY_SIZE(arr); i++)		\
> +			mipi_dsi_dcs_write_var_seq_multi(dsi_ctx,	\
> +							(cmd) + i, arr[i]); \
> +	} while (0)
> +
> +static void rm68200_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
>   {
>   	/* Enter CMD2 with page 0 */
> -	dcs_write_seq(ctx, MCS_CMD_MODE_SW, MCS_CMD2_P0);
> -	dcs_write_cmd_seq(ctx, MCS_EXT_PWR_IC, 0xC0, 0x53, 0x00);
> -	dcs_write_seq(ctx, MCS_BT2CTR, 0xE5);
> -	dcs_write_seq(ctx, MCS_SETAVDD, 0x0A);
> -	dcs_write_seq(ctx, MCS_SETAVEE, 0x0A);
> -	dcs_write_seq(ctx, MCS_SGOPCTR, 0x52);
> -	dcs_write_seq(ctx, MCS_BT3CTR, 0x53);
> -	dcs_write_seq(ctx, MCS_BT4CTR, 0x5A);
> -	dcs_write_seq(ctx, MCS_INVCTR, 0x00);
> -	dcs_write_seq(ctx, MCS_STBCTR, 0x0A);
> -	dcs_write_seq(ctx, MCS_SDCTR, 0x06);
> -	dcs_write_seq(ctx, MCS_VCMCTR, 0x56);
> -	dcs_write_seq(ctx, MCS_SETVGN, 0xA0, 0x00);
> -	dcs_write_seq(ctx, MCS_SETVGP, 0xA0, 0x00);
> -	dcs_write_seq(ctx, MCS_SW_CTRL, 0x11); /* 2 data lanes, see doc */
> -
> -	dcs_write_seq(ctx, MCS_CMD_MODE_SW, MCS_CMD2_P2);
> -	dcs_write_seq(ctx, GOA_VSTV1, 0x05);
> -	dcs_write_seq(ctx, 0x02, 0x0B);
> -	dcs_write_seq(ctx, 0x03, 0x0F);
> -	dcs_write_seq(ctx, 0x04, 0x7D, 0x00, 0x50);
> -	dcs_write_cmd_seq(ctx, GOA_VSTV2, 0x05, 0x16, 0x0D, 0x11, 0x7D, 0x00,
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_CMD_MODE_SW, MCS_CMD2_P0);
> +	dcs_write_cmd_seq(dsi_ctx, MCS_EXT_PWR_IC, 0xC0, 0x53, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_BT2CTR, 0xE5);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SETAVDD, 0x0A);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SETAVEE, 0x0A);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SGOPCTR, 0x52);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_BT3CTR, 0x53);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_BT4CTR, 0x5A);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_INVCTR, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_STBCTR, 0x0A);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SDCTR, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_VCMCTR, 0x56);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SETVGN, 0xA0, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SETVGP, 0xA0, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_SW_CTRL, 0x11); /* 2 data lanes, see doc */
> +
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_CMD_MODE_SW, MCS_CMD2_P2);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, GOA_VSTV1, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x02, 0x0B);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x03, 0x0F);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x04, 0x7D, 0x00, 0x50);
> +	dcs_write_cmd_seq(dsi_ctx, GOA_VSTV2, 0x05, 0x16, 0x0D, 0x11, 0x7D, 0x00,
>   			  0x50);
> -	dcs_write_cmd_seq(ctx, GOA_VCLK1, 0x07, 0x08, 0x01, 0x02, 0x00, 0x7D,
> +	dcs_write_cmd_seq(dsi_ctx, GOA_VCLK1, 0x07, 0x08, 0x01, 0x02, 0x00, 0x7D,
>   			  0x00, 0x85, 0x08);
> -	dcs_write_cmd_seq(ctx, GOA_VCLK2, 0x03, 0x04, 0x05, 0x06, 0x00, 0x7D,
> +	dcs_write_cmd_seq(dsi_ctx, GOA_VCLK2, 0x03, 0x04, 0x05, 0x06, 0x00, 0x7D,
>   			  0x00, 0x85, 0x08);
> -	dcs_write_seq(ctx, GOA_VCLK_OPT1, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -		      0x00, 0x00, 0x00, 0x00);
> -	dcs_write_cmd_seq(ctx, GOA_BICLK1, 0x07, 0x08);
> -	dcs_write_seq(ctx, 0x2D, 0x01);
> -	dcs_write_seq(ctx, 0x2F, 0x02, 0x00, 0x40, 0x05, 0x08, 0x54, 0x7D,
> -		      0x00);
> -	dcs_write_cmd_seq(ctx, GOA_BICLK2, 0x03, 0x04, 0x05, 0x06, 0x00);
> -	dcs_write_seq(ctx, 0x3D, 0x40);
> -	dcs_write_seq(ctx, 0x3F, 0x05, 0x08, 0x54, 0x7D, 0x00);
> -	dcs_write_seq(ctx, GOA_BICLK3, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -		      0x00, 0x00, 0x00, 0x00, 0x00);
> -	dcs_write_seq(ctx, GOA_BICLK4, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -		      0x00, 0x00);
> -	dcs_write_seq(ctx, 0x58, 0x00, 0x00, 0x00);
> -	dcs_write_seq(ctx, GOA_BICLK_OPT1, 0x00, 0x00, 0x00, 0x00, 0x00);
> -	dcs_write_seq(ctx, GOA_BICLK_OPT2, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -		      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
> -	dcs_write_seq(ctx, MCS_GOA_GPO1, 0x00, 0x00, 0x00, 0x00);
> -	dcs_write_seq(ctx, MCS_GOA_GPO2, 0x00, 0x20, 0x00);
> -	dcs_write_seq(ctx, MCS_GOA_EQ, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08,
> -		      0x00, 0x00);
> -	dcs_write_seq(ctx, MCS_GOA_CLK_GALLON, 0x00, 0x00);
> -	dcs_write_cmd_seq(ctx, MCS_GOA_FS_SEL0, 0xBF, 0x02, 0x06, 0x14, 0x10,
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, GOA_VCLK_OPT1, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +				     0x00, 0x00, 0x00, 0x00);
> +	dcs_write_cmd_seq(dsi_ctx, GOA_BICLK1, 0x07, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x2D, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x2F, 0x02, 0x00, 0x40, 0x05, 0x08, 0x54, 0x7D,
> +				     0x00);
> +	dcs_write_cmd_seq(dsi_ctx, GOA_BICLK2, 0x03, 0x04, 0x05, 0x06, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x3D, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x3F, 0x05, 0x08, 0x54, 0x7D, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, GOA_BICLK3, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +				     0x00, 0x00, 0x00, 0x00, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, GOA_BICLK4, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +				     0x00, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x58, 0x00, 0x00, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, GOA_BICLK_OPT1, 0x00, 0x00, 0x00, 0x00, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, GOA_BICLK_OPT2, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_GOA_GPO1, 0x00, 0x00, 0x00, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_GOA_GPO2, 0x00, 0x20, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_GOA_EQ, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08,
> +				     0x00, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_GOA_CLK_GALLON, 0x00, 0x00);
> +	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_FS_SEL0, 0xBF, 0x02, 0x06, 0x14, 0x10,
>   			  0x16, 0x12, 0x08, 0x3F);
> -	dcs_write_cmd_seq(ctx, MCS_GOA_FS_SEL1, 0x3F, 0x3F, 0x3F, 0x3F, 0x0C,
> +	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_FS_SEL1, 0x3F, 0x3F, 0x3F, 0x3F, 0x0C,
>   			  0x0A, 0x0E, 0x3F, 0x3F, 0x00);
> -	dcs_write_cmd_seq(ctx, MCS_GOA_FS_SEL2, 0x04, 0x3F, 0x3F, 0x3F, 0x3F,
> +	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_FS_SEL2, 0x04, 0x3F, 0x3F, 0x3F, 0x3F,
>   			  0x05, 0x01, 0x3F, 0x3F, 0x0F);
> -	dcs_write_cmd_seq(ctx, MCS_GOA_FS_SEL3, 0x0B, 0x0D, 0x3F, 0x3F, 0x3F,
> +	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_FS_SEL3, 0x0B, 0x0D, 0x3F, 0x3F, 0x3F,
>   			  0x3F);
> -	dcs_write_cmd_seq(ctx, 0xA2, 0x3F, 0x09, 0x13, 0x17, 0x11, 0x15);
> -	dcs_write_cmd_seq(ctx, 0xA9, 0x07, 0x03, 0x3F);
> -	dcs_write_cmd_seq(ctx, MCS_GOA_BS_SEL0, 0x3F, 0x05, 0x01, 0x17, 0x13,
> +	dcs_write_cmd_seq(dsi_ctx, 0xA2, 0x3F, 0x09, 0x13, 0x17, 0x11, 0x15);
> +	dcs_write_cmd_seq(dsi_ctx, 0xA9, 0x07, 0x03, 0x3F);
> +	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_BS_SEL0, 0x3F, 0x05, 0x01, 0x17, 0x13,
>   			  0x15, 0x11, 0x0F, 0x3F);
> -	dcs_write_cmd_seq(ctx, MCS_GOA_BS_SEL1, 0x3F, 0x3F, 0x3F, 0x3F, 0x0B,
> +	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_BS_SEL1, 0x3F, 0x3F, 0x3F, 0x3F, 0x0B,
>   			  0x0D, 0x09, 0x3F, 0x3F, 0x07);
> -	dcs_write_cmd_seq(ctx, MCS_GOA_BS_SEL2, 0x03, 0x3F, 0x3F, 0x3F, 0x3F,
> +	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_BS_SEL2, 0x03, 0x3F, 0x3F, 0x3F, 0x3F,
>   			  0x02, 0x06, 0x3F, 0x3F, 0x08);
> -	dcs_write_cmd_seq(ctx, MCS_GOA_BS_SEL3, 0x0C, 0x0A, 0x3F, 0x3F, 0x3F,
> +	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_BS_SEL3, 0x0C, 0x0A, 0x3F, 0x3F, 0x3F,
>   			  0x3F, 0x3F, 0x0E, 0x10, 0x14);
> -	dcs_write_cmd_seq(ctx, MCS_GOA_BS_SEL4, 0x12, 0x16, 0x00, 0x04, 0x3F);
> -	dcs_write_seq(ctx, 0xDC, 0x02);
> -	dcs_write_seq(ctx, 0xDE, 0x12);
> +	dcs_write_cmd_seq(dsi_ctx, MCS_GOA_BS_SEL4, 0x12, 0x16, 0x00, 0x04, 0x3F);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xDC, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xDE, 0x12);
>   
> -	dcs_write_seq(ctx, MCS_CMD_MODE_SW, 0x0E); /* No documentation */
> -	dcs_write_seq(ctx, 0x01, 0x75);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_CMD_MODE_SW, 0x0E); /* No documentation */
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x01, 0x75);
>   
> -	dcs_write_seq(ctx, MCS_CMD_MODE_SW, MCS_CMD2_P3);
> -	dcs_write_cmd_seq(ctx, MCS_GAMMA_VP, 0x00, 0x0C, 0x12, 0x0E, 0x06,
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_CMD_MODE_SW, MCS_CMD2_P3);
> +	dcs_write_cmd_seq(dsi_ctx, MCS_GAMMA_VP, 0x00, 0x0C, 0x12, 0x0E, 0x06,
>   			  0x12, 0x0E, 0x0B, 0x15, 0x0B, 0x10, 0x07, 0x0F,
>   			  0x12, 0x0C, 0x00);
> -	dcs_write_cmd_seq(ctx, MCS_GAMMA_VN, 0x00, 0x0C, 0x12, 0x0E, 0x06,
> +	dcs_write_cmd_seq(dsi_ctx, MCS_GAMMA_VN, 0x00, 0x0C, 0x12, 0x0E, 0x06,
>   			  0x12, 0x0E, 0x0B, 0x15, 0x0B, 0x10, 0x07, 0x0F,
>   			  0x12, 0x0C, 0x00);
>   
>   	/* Exit CMD2 */
> -	dcs_write_seq(ctx, MCS_CMD_MODE_SW, MCS_CMD1_UCS);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_CMD_MODE_SW, MCS_CMD1_UCS);
>   }
>   
>   static int rm68200_unprepare(struct drm_panel *panel)
>   {
>   	struct rm68200 *ctx = panel_to_rm68200(panel);
>   	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> -	int ret;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>   
> -	ret = mipi_dsi_dcs_set_display_off(dsi);
> -	if (ret)
> -		dev_warn(panel->dev, "failed to set display off: %d\n", ret);
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>   
> -	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
> -	if (ret)
> -		dev_warn(panel->dev, "failed to enter sleep mode: %d\n", ret);
> +	/* Attempt to enter sleep mode even if display off failed. */
> +	dsi_ctx.accum_err = 0;
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>   
>   	msleep(120);
>   
> @@ -258,6 +232,7 @@ static int rm68200_prepare(struct drm_panel *panel)
>   {
>   	struct rm68200 *ctx = panel_to_rm68200(panel);
>   	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>   	int ret;
>   
>   	ret = regulator_enable(ctx->supply);
> @@ -273,19 +248,18 @@ static int rm68200_prepare(struct drm_panel *panel)
>   		msleep(100);
>   	}
>   
> -	rm68200_init_sequence(ctx);
> +	rm68200_init_sequence(&dsi_ctx);
>   
> -	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> -	if (ret)
> -		goto assert_reset;
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>   
> -	msleep(125);
> +	mipi_dsi_msleep(&dsi_ctx, 125);
>   
> -	ret = mipi_dsi_dcs_set_display_on(dsi);
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +	ret = dsi_ctx.accum_err;
>   	if (ret)
>   		goto assert_reset;
>   
> -	msleep(20);
> +	mipi_dsi_msleep(&dsi_ctx, 20);
>   
>   	return 0;
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
