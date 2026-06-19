Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33D1CD98F8
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 07:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 128DB10F48A;
	Fri, 19 Jun 2026 07:47:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iHaarjTQ";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 301A310F495
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 07:47:33 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-491b390f9e9so15854295e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 00:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781855251; x=1782460051; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=nH28/Om8Ss0rdBR726jh0dxFJDusTqEawXLpUiRuPsw=;
 b=iHaarjTQ8/BZMnPyqZzJ8qUf4czzIERsYfUCtGKJ7pWhz+Q9LQEzk4BdwV6E9S0ZX0
 12c0OlyFrzjwhib1NatT4MfBB36BWoly4rVnguahyiS3LtneYKkVLJZJEbGoFSie9mW0
 vMSlPYeHgXXX3YPTYTOp7UVqMtDdw3tjEXlyXJIWxi5hRqY+PovUx49Bp5R0q0j/Lm20
 xLZXmB78Lx8nSN45uKZSurLzCD4vrIa38fNwHQRqEH2MmpmgQwE5P24b5VLg3xVfKbdo
 BbCZH7yUpm0mUE/9iyn6WsK5WPoDsAtfcqBnIDVA3AE05TjNxbJ+ceZwOOvQi003iyWU
 Rwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781855251; x=1782460051;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nH28/Om8Ss0rdBR726jh0dxFJDusTqEawXLpUiRuPsw=;
 b=tEDwsGbl/upRnPX2ozm9i0Mi1IZmoioSWinMmaIiTkfvgekXJAcw8oWUDHA9haSne/
 qWnRXb7f4+IWqbruO3mDIPCtOBBwyHwrzL7VHFRnUaQAuG00tS9V/fPf7yatQMqitMTT
 5MCcq1t+SecIWCoP1MeNL5CBrDpd1Y5wfmub9Zog5eBNFaV8YB7KUucp+/B9rl3G+7r9
 uNeiGmSbhClfUpEuA2ixdXqULtWHUR32r9rYRli5dClyg5zxdT006WnbiQSC/DyM931g
 LajQZ/ANipkXoFmDA1l+7x89Qfukxu81Z2iVlBp5bN6NMEjuXPZIfCu4d1S3L9oLH07o
 TaMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9uRrbkEiTts3P+/cCu5QSFjmGFmyKwfATQ+RIqAu95/2+frVcny56SxHhi8blS6KyGDIZxu6dROIo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9YxU3QsgmU/2GrzmYY9Ml2ANtJWBQ0O0V2DxTQKcHuJruCmHA
 N0Czhd6Pz/d6+8pMbIVSuRTnCDGoXMqzQS7gvqJoF0+qf+PqEEhxFDPnW8VPp+lDcyg=
X-Gm-Gg: AfdE7clDjn2dgG/v5D80qjA4fMkqyvIOhSwmktVUpqnr6rUfApprxwMid9e/mFMNHMq
 pwehz4rerWPDmuTEOUq94XCnJOYKBAVZRMC70TNQy4k+/H05fDKNc+kb/bIc2abqXJAxhCWPapK
 9Q0S+pp6MJ7xt+eS7kFo5llMgXUXhMo4lHpkZyL9bA+dg3j+XtTqPpRdk0CNPsGYhGN1Bz2zPT0
 pIlZZTpuR992uusAMkzH3lfWx4BUA0W6nRJZY/m7HiQ38GYgTAAuqXt9E7OJlFmFCl1ysBhY7xE
 oRlImqAP5AFIJU3orKYJCCUQTi57gINuyJJfwcZladCm5pNpikyufQ2QxEkF8rO66J9JIrGVejH
 XLQ1IPl2tOMHUmtfkllqRyT/KrG7we6bQrBvO0Jua914vGHrAIegQ06Giy1SnkbBQsnAjJbjZZs
 zYchenSzFyX/cLfoBT2h0ukg==
X-Received: by 2002:a05:600c:2305:b0:492:2f59:4969 with SMTP id
 5b1f17b1804b1-49240e5b469mr30410745e9.22.1781855251337; 
 Fri, 19 Jun 2026 00:47:31 -0700 (PDT)
Received: from [172.20.10.2] ([37.167.16.215])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd1fe8esm54076915e9.13.2026.06.19.00.47.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2026 00:47:30 -0700 (PDT)
Message-ID: <d1d81638-3d7b-4613-9e49-3cb236002f9a@linaro.org>
Date: Fri, 19 Jun 2026 09:47:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v7 2/2] drm: panel: add support for the Renesas R63419
 based dual-DSI video mode Display Panels
To: Doug Anderson <dianders@chromium.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 KancyJoe <kancy2333@outlook.com>
References: <20260605-topic-sm8650-ayaneo-pocket-s2-r63419-v7-0-b84b6da84293@linaro.org>
 <20260605-topic-sm8650-ayaneo-pocket-s2-r63419-v7-2-b84b6da84293@linaro.org>
 <CAD=FV=W5FgXGznH1+SA74WOfAUXaAggaJi=ds8udqZ69K3i=Ow@mail.gmail.com>
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
In-Reply-To: <CAD=FV=W5FgXGznH1+SA74WOfAUXaAggaJi=ds8udqZ69K3i=Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 6/18/26 19:00, Doug Anderson wrote:
> Hi,
> 
> On Fri, Jun 5, 2026 at 7:51 AM Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> From: KancyJoe <kancy2333@outlook.com>
>>
>> Implement support for the Renesas 63419 based dual-DSI video mode
>> Display Panels found in the Ayaneo gaming handled devices.
>>
>> Signed-off-by: KancyJoe <kancy2333@outlook.com>
> 
> I notice "Kancy Joe" has a space in the source files, but not in the
> signoff. I guess Signed-off-by isn't necessarily required to be real
> names these days, but still seems odd...

Yeah I kept all the signoff and names as in the the source files,
it wasn't an issue for other patches, so I left it....

> 
> 
>> +/*
>> + * Helper to switch between DSI links, so we share a single dsi_ctx
>> + * for both links, so in case of an error all writes & sleep for
>> + * both links are ignored.
>> + */
>> +static inline void dsi_link_switch(struct renesas_r63419_panel *ctx,
>> +                                  struct mipi_dsi_multi_context *dsi_ctx,
>> +                                  unsigned int link)
>> +{
>> +       dsi_ctx->dsi = ctx->dsi[link];
>> +}
>> +
>> +static int renesas_r63419_on(struct renesas_r63419_panel *ctx)
>> +{
>> +       struct mipi_dsi_multi_context dsi_ctx = { 0 };
>> +
>> +       /* Panel registers are loaded from DDIC Non Volatile Memory */
>> +
>> +       dsi_link_switch(ctx, &dsi_ctx, 0);
>> +       mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>> +       dsi_link_switch(ctx, &dsi_ctx, 1);
>> +       mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> 
> Instead of dsi_link_switch(), can't you use the mipi_dsi_dual()
> function? I think it would be:
> 
> mipi_dsi_dual(mipi_dsi_dcs_exit_sleep_mode_multi, dsi_ctx,
> ctx->dsi[0], ctx->dsi[1]);

Right, indeed will switch

> 
> 
>> +static int renesas_r63419_disable(struct drm_panel *panel)
>> +{
>> +       struct renesas_r63419_panel *ctx = to_renesas_r63419_panel(panel);
>> +       struct mipi_dsi_multi_context dsi_ctx = { 0 };
>> +
>> +       dsi_link_switch(ctx, &dsi_ctx, 0);
>> +       mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>> +       dsi_link_switch(ctx, &dsi_ctx, 1);
>> +       mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>> +       mipi_dsi_msleep(&dsi_ctx, 50);
>> +
>> +       dsi_link_switch(ctx, &dsi_ctx, 0);
>> +       mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>> +       dsi_link_switch(ctx, &dsi_ctx, 1);
>> +       mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>> +       mipi_dsi_msleep(&dsi_ctx, 120);
>> +
>> +       return dsi_ctx.accum_err;
> 
> I'm not sure we've been terribly consistent, but should the above be
> "return 0"? I'm not actually sure there's any benefit to a panel's
> disable() function returning an error to begin with.
> drm_panel_disable() doesn't return an error, so all this does is skip
> setting "panel->enabled" to false and make it harder for the system to
> recover.

Yep you're right, there's no sense to return the error here.

> 
> 
>> +static int renesas_r63419_prepare(struct drm_panel *panel)
>> +{
>> +       struct renesas_r63419_panel *ctx = to_renesas_r63419_panel(panel);
>> +       int ret;
>> +
>> +       ret = regulator_bulk_enable(ARRAY_SIZE(renesas_r63419_vdd_supplies),
>> +                                   ctx->vdd_supplies);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       usleep_range(1000, 2000);
>> +
>> +       ret = regulator_bulk_enable(ARRAY_SIZE(renesas_r63419_vcc_supplies),
>> +                                   ctx->vcc_supplies);
>> +       if (ret < 0) {
>> +               regulator_bulk_disable(ARRAY_SIZE(renesas_r63419_vdd_supplies),
>> +                                      ctx->vdd_supplies);
>> +               return ret;
>> +       }
>> +
>> +       usleep_range(1000, 2000);
>> +
>> +       gpiod_set_value_cansleep(ctx->reset_gpio, 0);
>> +
>> +       usleep_range(3000, 4000);
>> +
>> +       ret = renesas_r63419_on(ctx);
>> +       if (ret < 0) {
>> +               dev_err(panel->dev, "Failed to initialize panel: %d\n", ret);
>> +
>> +               /* Power off sequence from the r63419 datasheet */
>> +               regulator_bulk_disable(ARRAY_SIZE(renesas_r63419_vcc_supplies),
>> +                                      ctx->vcc_supplies);
>> +               regulator_bulk_disable(ARRAY_SIZE(renesas_r63419_vdd_supplies),
>> +                                      ctx->vdd_supplies);
>> +
>> +               gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> 
> To make de-init opposite to init, shouldn't the reset come before you
> turn the regulators off? Depending on the design of the panel, I'd
> imagine this could prevent back-powering some logic?
> 
> I'd also expect vdd supplies to be turned off first?

I did follow the DDIC spec here, and yeah Sashiko already
pointed it to me but reset needs to be switched to low _after_
the vdd supplies goes low. Perhaps indeed the vcc one should be
turned off after the reset. I'll do that.

> 
> 
>> +static int renesas_r63419_unprepare(struct drm_panel *panel)
>> +{
>> +       struct renesas_r63419_panel *ctx = to_renesas_r63419_panel(panel);
>> +
>> +       /* Power off sequence from the r63419 datasheet */
>> +       regulator_bulk_disable(ARRAY_SIZE(renesas_r63419_vcc_supplies), ctx->vcc_supplies);
>> +       regulator_bulk_disable(ARRAY_SIZE(renesas_r63419_vdd_supplies), ctx->vdd_supplies);
>> +
>> +       gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> 
> Similar: shouldn't the reset come before the regulators to make
> power-off the opposite of init.

Yep I'll move vcc disable after the reset to match the spec more closely.

> 
> 
>> +static int renesas_r63419_get_modes(struct drm_panel *panel,
>> +                                   struct drm_connector *connector)
>> +{
>> +       struct renesas_r63419_panel *ctx = to_renesas_r63419_panel(panel);
>> +       const struct drm_display_mode *mode = ctx->desc->mode;
>> +
>> +       drm_connector_set_panel_orientation(connector, ctx->orientation);
> 
> IIRC, the above was a workaround that caused a warning splat. Is your
> panel used on a system that actually needs it? Could your DRM driver
> be fixed rather than persisting this hack? For context, see commit
> 47bef230225b ("drm/panel: panel-edp: Implement .get_orientation
> callback")

No need, I'll drop it

> 
> 
>> +static int renesas_r63419_probe(struct mipi_dsi_device *dsi)
>> +{
>> +       struct mipi_dsi_device_info info = { };
>> +       struct device *dev = &dsi->dev;
>> +       struct renesas_r63419_panel *ctx;
>> +       struct device_node *dsi1_node;
>> +       struct mipi_dsi_host *dsi1_host;
>> +       int ret, i;
>> +
>> +       ctx = devm_drm_panel_alloc(dev, struct renesas_r63419_panel, panel,
>> +                                  &renesas_r63419_panel_funcs, DRM_MODE_CONNECTOR_DSI);
>> +       if (IS_ERR(ctx))
>> +               return PTR_ERR(ctx);
>> +
>> +       ctx->desc = of_device_get_match_data(dev);
>> +       if (!ctx->desc)
>> +               return dev_err_probe(dev, -ENODEV,
>> +                                    "Failed to get panel description\n");
>> +
>> +       ret = devm_regulator_bulk_get_const(&dsi->dev,
>> +                                           ARRAY_SIZE(renesas_r63419_vdd_supplies),
>> +                                           renesas_r63419_vdd_supplies, &ctx->vdd_supplies);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       ret = devm_regulator_bulk_get_const(&dsi->dev,
>> +                                           ARRAY_SIZE(renesas_r63419_vcc_supplies),
>> +                                           renesas_r63419_vcc_supplies, &ctx->vcc_supplies);
>> +       if (ret < 0)
>> +               return ret;
> 
> It seems like both sets of supplies are always enabled / disabled
> together with no delay between them. Do you truly need two lists, or
> can this be combined to one list of regulators. That would simplify a
> bunch of logic.

You need a delay between enabling vcc and vdd according to the spec,
this is why I did a split.

> 
> 
>> +       ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
>> +       if (IS_ERR(ctx->reset_gpio))
>> +               return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
>> +                                    "Failed to get reset gpio\n");
>> +
>> +       /* Get second DSI host */
>> +       dsi1_node = of_graph_get_remote_node(dsi->dev.of_node, 1, -1);
>> +       if (!dsi1_node)
>> +               return dev_err_probe(dev, -ENODEV,
>> +                                    "Failed to get remote node for second DSI\n");
>> +
>> +       dsi1_host = of_find_mipi_dsi_host_by_node(dsi1_node);
>> +       of_node_put(dsi1_node);
>> +       if (!dsi1_host)
>> +               return dev_err_probe(dev, -EPROBE_DEFER,
>> +                                    "Failed to find second DSI host\n");
>> +
>> +       /* Copy current DSI info, do not provide OF node since no driver needs to be attached */
>> +       strscpy(info.type, dsi->name, sizeof(info.type));
> 
> Can't you use the two-argument form of strscpy()?

Yeah sure

> 
> FWIW, I also notice that the Sashiko AI bot had some comments. Did you
> already look all of those over and decide they don't need fixing? I
> have a vague recollection that there's no need to worry about someone
> calling disable() and then enable() without going through the
> unprepare() / prepare(). If my memory is correct, I guess that would
> be nice to document... I didn't analyze some of the other claims that
> the AI bot had.

Yep I fixed the real issues, the remaining issues are about the init
sequence and some impossible init sequence between drm and dsi.

Thanks,
Neil

> 
> 
> -Doug

