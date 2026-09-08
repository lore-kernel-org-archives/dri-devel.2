Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2133DC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 12:17:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 509EF10EBAA;
	Tue,  8 Sep 2026 12:17:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ixit.cz header.i=@ixit.cz header.b="TBp+Qlt+";
	dkim-atps=neutral
Received: from ixit.cz (ixit.cz [84.42.129.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5F3910EBAA
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 12:17:56 +0000 (UTC)
Received: from [172.16.124.192] (ip-78-44-13-22.bb.vodafone.cz [78.44.13.22])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ixit.cz (Postfix) with ESMTPSA id 170125340333;
 Tue, 08 Sep 2026 14:17:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
 t=1788869874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pCGS7QFek799eYvFtCYM8Z1cMo6BbumL8qntZvDYcks=;
 b=TBp+Qlt+GRv/buIuJ69rXb73XHqHAGbbk8U2xxfEvZDXjZwD1gfiDmPLPuKjg+UpRntRkp
 C2eAJenjtbNdueVNCxkRJlDf2vnk05MHTv1iOJ6EJPPdLpxEPUU8xLS7F0AXnSwyPz8uOU
 T62O5qM5b+6xa5lNzNU+eUN3vyXZCKM=
Message-ID: <7f9def9e-1c2c-4856-9b92-e6417499ed74@ixit.cz>
Date: Tue, 8 Sep 2026 14:17:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/panel: ebbg-ft8719: Split initialization into
 enable/disable fn
To: Neil Armstrong <neil.armstrong@linaro.org>, Joel Selvaraj
 <jo@jsfamily.in>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>, Marco Mattiolo <marco.mattiolo@hotmail.it>,
 Linus Walleij <linusw@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20260906-ebbg-ft8719-fixups-v1-0-4e846510cad1@ixit.cz>
 <20260906-ebbg-ft8719-fixups-v1-3-4e846510cad1@ixit.cz>
 <7d1d7726-aff1-40cf-a958-6e825a1b50eb@linaro.org>
Content-Language: en-US, cs-CZ
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <7d1d7726-aff1-40cf-a958-6e825a1b50eb@linaro.org>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 08/09/2026 14:15, Neil Armstrong wrote:
> On 9/6/26 15:19, David Heidelberg via B4 Relay wrote:
>> From: David Heidelberg <david@ixit.cz>
>>
>> Efficiently this already happens with prepare/unprepare calls.
>> Remove unnecessary login and just use enable/disable functions.
> 
> I would replace with:
> 
> Move the MIPI commands into enable/disable callbacks since they
> are called between prepare/unprepare callbacks.
> 

I'll adjust.

> Or similar.
> 
>>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>> ---
>>   drivers/gpu/drm/panel/panel-ebbg-ft8719.c | 17 +++++++----------
>>   1 file changed, 7 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c b/drivers/gpu/drm/ 
>> panel/panel-ebbg-ft8719.c
>> index 14982263a94f1..9965f46f1a316 100644
>> --- a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
>> +++ b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
>> @@ -49,40 +49,42 @@ static void ebbg_ft8719_reset(struct ebbg_ft8719 *ctx)
>>       gpiod_set_value_cansleep(ctx->reset_gpio, 0);
>>       usleep_range(4000, 5000);
>>       gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>>       usleep_range(1000, 2000);
>>       gpiod_set_value_cansleep(ctx->reset_gpio, 0);
>>       usleep_range(15000, 16000);
>>   }
>> -static int ebbg_ft8719_on(struct ebbg_ft8719 *ctx)
>> +static int ebbg_ft8719_enable(struct drm_panel *panel)
>>   {
>> +    struct ebbg_ft8719 *ctx = to_ebbg_ft8719(panel);
>>       struct mipi_dsi_device *dsi = ctx->dsi;
>>       struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>>       dsi->mode_flags |= MIPI_DSI_MODE_LPM;
>>       mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx, 0x00ff);
>>       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 
>> 0x24);
>>       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
>>       mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>>       mipi_dsi_msleep(&dsi_ctx, 90);
>>       mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
>>       return dsi_ctx.accum_err;
>>   }
>> -static int ebbg_ft8719_off(struct ebbg_ft8719 *ctx)
>> +static int ebbg_ft8719_disable(struct drm_panel *panel)
>>   {
>> +    struct ebbg_ft8719 *ctx = to_ebbg_ft8719(panel);
>>       struct mipi_dsi_device *dsi = ctx->dsi;
>>       struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>> -    dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
>> +    ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
>>       mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>>       mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
>>       mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>>       mipi_dsi_msleep(&dsi_ctx, 90);
>>       return dsi_ctx.accum_err;
> 
> Before the ebbg_ft8719_off() return error was ignored, perhaps you still want to 
> ignore the disable return error.

Sure, make sense. Next revision will land in minutes!
Thanks
David

> 
> Neil
> 
>>   }
>> @@ -93,30 +95,23 @@ static int ebbg_ft8719_prepare(struct drm_panel *panel)
>>       int ret;
>>       ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>>       if (ret < 0)
>>           return ret;
>>       ebbg_ft8719_reset(ctx);
>> -    ret = ebbg_ft8719_on(ctx);
>> -    if (ret < 0) {
>> -        gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>> -        return ret;
>> -    }
>> -
>>       return 0;
>>   }
>>   static int ebbg_ft8719_unprepare(struct drm_panel *panel)
>>   {
>>       struct ebbg_ft8719 *ctx = to_ebbg_ft8719(panel);
>> -    ebbg_ft8719_off(ctx);
>>       gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>>       regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>>       return 0;
>>   }
>>   static const struct drm_display_mode ebbg_ft8719_mode = {
>>       .clock = (1080 + 28 + 4 + 16) * (2246 + 120 + 4 + 12) * 60 / 1000,
>> @@ -148,16 +143,18 @@ static int ebbg_ft8719_get_modes(struct drm_panel *panel,
>>       connector->display_info.height_mm = mode->height_mm;
>>       drm_mode_probed_add(connector, mode);
>>       return 1;
>>   }
>>   static const struct drm_panel_funcs ebbg_ft8719_panel_funcs = {
>>       .prepare = ebbg_ft8719_prepare,
>> +    .enable = ebbg_ft8719_enable,
>> +    .disable = ebbg_ft8719_disable,
>>       .unprepare = ebbg_ft8719_unprepare,
>>       .get_modes = ebbg_ft8719_get_modes,
>>   };
>>   static int ebbg_ft8719_probe(struct mipi_dsi_device *dsi)
>>   {
>>       struct device *dev = &dsi->dev;
>>       struct ebbg_ft8719 *ctx;
>>
> 

