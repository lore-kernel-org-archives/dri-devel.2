Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BD4606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=D+7lRQT3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47D0F10FF19;
	Wed, 25 Nov 2026 18:50:12 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5966010FF16
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:49:59 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so48076725e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795632598; x=1796237398; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jFupvv06LsXCAl0vGBUfBexOAZyEYwTtWknj0ciKxIk=;
 b=D+7lRQT3tK1YMGPFjaG8bOPsg+VGIqPaYzr6waMB8AugNID22p6MJw9lDiY753cdVZ
 K3BLUDRmxCdQ1Y/WuNSgQZZ6cQ1hB87kBkZrk6IVI38tufSNVI4A0d9igOp7Mull83jw
 6zzNjnaFTnLxZ/l64TlGxamiRiUE1so8nL4l+1vsp1HjmVye14fl8ZS7AaKE5aK6BN25
 6UkBovCCe2ZmDuRDHxlshPquuxdDYxqNgUun0hxUwphqIs65RUIpIjlybCOxl3W/8KV0
 MWHsaPL3jPHZW3VzcT+Fs8dnuM71KF0CH4gNKsVDQo01o/7OQtmZi5wmLb/e01XwJT39
 1V3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795632598; x=1796237398;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jFupvv06LsXCAl0vGBUfBexOAZyEYwTtWknj0ciKxIk=;
 b=n/SO04OY/bfwpwpXVma9akTFaAHASfGD4L3tBrT2fcVTrRNXyoOVcv7yalQ1gnznlO
 3z4LPe4BWn4DZ65aA66DOU1tyCUGPIDXwIwYUTpNDXdu2Znvqfm6SjU/NcplwbGTbCaR
 3qCyDhUKezpNuZXICILRaha3P+OWPtZcPNnNlGN2tdrBBs7PQ/8iVLRdYDc0taX5zFpD
 R7FO7k7qYbrP6g/sRZpmxN1dJmF5QDR2eKqPbqjbNE+JsEZvH6xaPMQ6He9bJIWpWPhv
 gKaOE6Wmba0iLd4hMufZE/zdeq2FfJdZt8AU4bYvLv871sh+f5nsgGDbfCJ+cfQ7M2jH
 g/Kw==
X-Forwarded-Encrypted: i=1;
 AL+hErFWPecCkeb6ltU6ai8F7DZyc50xhWlTfIsFEFnr8VN0zI2pwUNJLgUe2D8c6JmZ4hCTdI84hWmWA7w=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/TnbRpPY+w9eX2QTgYlxa2suHqFS28cNRhp4hdgkLelmcacQLA
 3LPIN3Q/XnpN5dMnynPxKQG5PjkPLXvnHMUFCbQFZ+nlp5/9jKPt2f8XA39xv6kRWpc=
X-Gm-Gg: AZFdTZeyH7adZ3maZFOegU9G1xvH1oTZct0nGTvD6Wj1YTIowlp2fcKHhIJmLEvmApB
 be4qUvfpjXTNsnq4/hdyM+049vv+3Vpyv99UhXSNIuhnR1yFfg71phXPclNahrI601r82rimxG9
 YF70yeK4Zb4dW2qhIOpS0iDUmdacaNGI1kyxhPuFT2AOhqdojJBGXR2AXPC1iV408X92QV/j1r8
 yIKf9grM/uKWKlktKP+oB7LdjYRUQJ1ePQaB/3DAT9FS+s77Yk18gHa3nOs1K7pqu37jLYD6GIS
 fA7icPPBIuPvnuleYag1MMsdpUGUp6fmgHKvXJw2BWbAhvOWXtOJuh+yTcihnN8grsGDZjNDQH1
 E3JB8DHWRUNY8unJa9g+9pXQXLu1oc+Bo2tBSe9OdEYr14ohYryhldKJhyTtx0od4MeSGiYQSrn
 RE1lDJsemhO/zid6hNoirofRXEeFuSDsqf1qWqY/PrBUKKKXsNNrxcRsZrk+IQ86p2vpRgHzzrq
 bibrZCtC+kYHzC3FDlTKtrp8ZNKADvCVlf1+mpgZgiQZZ4Eoehs8GmrkgudPo4BQPgb8FlOeQCJ
 JBiNwZwVYT/oBZ44NlnJhpoC49xXy+M4+XX6XowG2sFHwgj7ZbGOErKnnxtCPfIWG8O6pF+0Nzs
 znn/ld8dGKQ==
X-Received: by 2002:a05:600c:3b1a:b0:4a7:8fe8:130c with SMTP id
 5b1f17b1804b1-4bb8881d4damr393393525e9.28.1795632597466; 
 Wed, 25 Nov 2026 10:49:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:84b7:1ee8:d497:908f?
 ([2a01:e0a:106d:1080:84b7:1ee8:d497:908f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865a2sm555244145e9.3.2026.11.25.10.49.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 10:49:57 -0800 (PST)
Message-ID: <9dcb4721-a756-43b9-a8c6-34922dd4a115@linaro.org>
Date: Wed, 25 Nov 2026 19:49:56 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] drm/panel: lg-sw43408: skip backlight updates when
 unprepared
To: david@ixit.cz, Abel Vesa <abelvesa@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Vinod Koul <vkoul@kernel.org>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20261125-fix-blueline-panel-v3-0-914b4a30b73e@ixit.cz>
 <20261125-fix-blueline-panel-v3-2-914b4a30b73e@ixit.cz>
From: Neil Armstrong <neil.armstrong@linaro.org>
Content-Language: en-US
In-Reply-To: <20261125-fix-blueline-panel-v3-2-914b4a30b73e@ixit.cz>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/25/26 14:08, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> sw43408_backlight_update_status() unconditionally sends a MIPI DSI DCS
> brightness command even when the panel is unprepared and the DSI host is
> powered down, causing sysfs brightness writes while blanked to fail with
> -EIO.
> 
> Pass struct sw43408_panel as the backlight device private data and return
> early when !ctx->base.prepared, matching other mainline MIPI DSI panel
> drivers.
> 
> Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/gpu/drm/panel/panel-lg-sw43408.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> index 92cab6478ea61..7f7d7b6b17f61 100644
> --- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
> +++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> @@ -181,20 +181,23 @@ static const struct drm_display_mode lh546wf1_ed01_mode = {
>   static int sw43408_get_modes(struct drm_panel *panel,
>   			     struct drm_connector *connector)
>   {
>   	return drm_connector_helper_get_modes_fixed(connector, &lh546wf1_ed01_mode);
>   }
>   
>   static int sw43408_backlight_update_status(struct backlight_device *bl)
>   {
> -	struct mipi_dsi_device *dsi = bl_get_data(bl);
> +	struct sw43408_panel *ctx = bl_get_data(bl);
>   	u16 brightness = backlight_get_brightness(bl);
>   
> -	return mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
> +	if (!ctx->base.prepared)
> +		return 0;
> +
> +	return mipi_dsi_dcs_set_display_brightness_large(ctx->link, brightness);
>   }
>   
>   static const struct backlight_ops sw43408_backlight_ops = {
>   	.update_status = sw43408_backlight_update_status,
>   };
>   
>   static int sw43408_backlight_init(struct sw43408_panel *ctx)
>   {
> @@ -202,17 +205,17 @@ static int sw43408_backlight_init(struct sw43408_panel *ctx)
>   	const struct backlight_properties props = {
>   		.type = BACKLIGHT_PLATFORM,
>   		.brightness = 255,
>   		/* HBM can go up to 1023, stay safe for now */
>   		.max_brightness = 900,
>   	};
>   
>   	ctx->base.backlight = devm_backlight_device_register(dev, dev_name(dev), dev,
> -							     ctx->link,
> +							     ctx,
>   							     &sw43408_backlight_ops,
>   							     &props);
>   
>   	if (IS_ERR(ctx->base.backlight))
>   		return dev_err_probe(dev, PTR_ERR(ctx->base.backlight),
>   				     "Failed to create backlight\n");
>   
>   	return 0;
> 


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
