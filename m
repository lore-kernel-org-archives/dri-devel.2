Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C726960A5BFE
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EPfDS2If
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 072EE10E24F;
	Wed, 25 Nov 2026 15:40:08 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE95710E24F
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:40:00 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so55378095e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 07:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795621199; x=1796225999; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gqUeEhyGjKq93ahPeMI4CffMFtMuuHUd8X1hC7MuE8c=;
 b=EPfDS2IfLBR/bbDOWaeT8UhIc4W9QsWM9yjU8eIXJeehNOsVFoVODfMHXmNbgTaXNP
 ZscFGGJFqU4sO74eFwRnXP6Gn+pF2J06/FH25r94uilu+opLXhdtCDoNxpdZvkef5TZL
 y74pBGKhguW9L+YyoC+EqOpUtyMJbEnyQRwxAbt824TAt6wqlolrpMgx378us7NS0xS3
 0PMAfj73FzoTkfgbtLTNFU1GcCbMRr2NEgOfZRajG1lTuNEX4psd3NAT8Vej5nON4aAl
 4gfw6gS00wB01SgCyQlpC8KcLD5sOcAMCr4vFOZ+7I1v5bW9UOMo8uN9wvo7GAMZVpgs
 0VFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795621199; x=1796225999;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gqUeEhyGjKq93ahPeMI4CffMFtMuuHUd8X1hC7MuE8c=;
 b=H/N/IBS/3zYB7LDRmolXC2w6LhwFLOn/MVoUmVHigNOxa69eAjPz5KKJDhISetBR8N
 RqzweiIg58k0rUkpW+trGldO437PpV8RT0JZ/ASrPQH+s/0iymCUjQdnd3hjSrSUgOjf
 bHm6x3wfupVA0yyM4W+mNZ6+rICSRu2xoB6iwdP2kazG/KuJ2gND4Ib8CywEfCPEDVCW
 YEEkJUwluCkl9yWvL3wDTws6YAyEY/Bf4VJak9pKGG5xCtJCHchfbjkUF/cSDN6/c/Rf
 kLcTq/cuT+KgjhbQDM4nn54Xjwhe77s01qHxwYoweb6SDd0W9SyHx6XBrdNJU8tc17Xi
 RO2g==
X-Forwarded-Encrypted: i=1;
 AL+hErHIJl11B+twuHRVHds4hU6a7SlQRKLb4Eu5f3VSR1ykDGVvlSdr/6UWjKh1dO3yC1XafXpx3y8gY70=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8PiuI7j9VglQsHIOyXZGJ+lC5JNKaNZfEfxdUgujzdzle+6BJI
 /XjsxrQqBWBRgcOWDly0bul9VGp5KKweINjPkgnxYyEbjxwjGUPZ2ao/f/h1c7KdyK0=
X-Gm-Gg: AZFdTZcCA3dZuT4ou62L4PMrrEZO7GZ2+wj4x3Arr8MGbMPI4h0IQ/X2gs0fneMhxg0
 DqfB2rqagxlY4eroACBbb8wYKGyILwbV8RvPcVBQg9KdCxJbyGNI7ddpTZZPQSHmgL3EIuSG77+
 AQPc2YGM4pDua36PW+KFIPmFBKyq2skCEpAjIyhUu/CF+kfi8GebwsiEHT1tWI7xn5dytynD/oc
 VN1eJ6xeR55xlQnc5Yl9PZvavljYQG/vsqr01+5DLQGKrdQi5E+BUIis3gNqhw3OTs1ZRtIcOin
 3Oznp1xEbSxHrcyUCQdtLPWO3rGOjhZxY3elGclWeEU8tfMwXixf/bh/xmCoM18LqDdRmYcQO4D
 k6ytBxZAo+AeZw8EbbwTxeSlSdtaOOoTfAyHJ67cdYgb4M1+G2qCeYapG8ik5ddvwl+9rGd7eeE
 rCMzHg0UTl573ADGAdWzmkFuV5DU0SIFTWSvf4Vfp3OIwOLIqsqo6y4ylUZ8D8a5NJQ4bIsrrAu
 GDibsJVQxVE+i8rXXKzpFlelN77tqpBYaFZMJiniDx76UmVjymjSeNRWTy+YPDDAlrd8NneGQO7
 sqgWaLZ/flNzd1SgzbEry4g9vxR1ohasxWfcLA==
X-Received: by 2002:a05:600c:3ba9:b0:4a2:1050:aff with SMTP id
 5b1f17b1804b1-4bb8881c741mr427623865e9.6.1795621199120; 
 Wed, 25 Nov 2026 07:39:59 -0800 (PST)
Received: from [10.229.50.9] ([90.82.202.178])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b3415763f7sm14255031f8f.9.2026.11.25.07.39.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 07:39:58 -0800 (PST)
Message-ID: <8a9a4fe1-0fa5-4c48-aa88-f61b3a01739f@linaro.org>
Date: Wed, 25 Nov 2026 16:39:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] drm/panel: lg-sw43408: use the full DCS brightness
 range
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
 <20261125-fix-blueline-panel-v3-1-914b4a30b73e@ixit.cz>
From: Neil Armstrong <neil.armstrong@linaro.org>
Content-Language: en-US
In-Reply-To: <20261125-fix-blueline-panel-v3-1-914b4a30b73e@ixit.cz>
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
> The vendor changed the value multiple times. Last value for production
> devices was 900. HBM can go up to 1023, but keep value safe for now.
> 
> Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/gpu/drm/panel/panel-lg-sw43408.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> index 822318f546ef3..92cab6478ea61 100644
> --- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
> +++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> @@ -197,17 +197,18 @@ static const struct backlight_ops sw43408_backlight_ops = {
>   };
>   
>   static int sw43408_backlight_init(struct sw43408_panel *ctx)
>   {
>   	struct device *dev = &ctx->link->dev;
>   	const struct backlight_properties props = {
>   		.type = BACKLIGHT_PLATFORM,
>   		.brightness = 255,
> -		.max_brightness = 255,
> +		/* HBM can go up to 1023, stay safe for now */
> +		.max_brightness = 900,
>   	};
>   
>   	ctx->base.backlight = devm_backlight_device_register(dev, dev_name(dev), dev,
>   							     ctx->link,
>   							     &sw43408_backlight_ops,
>   							     &props);
>   
>   	if (IS_ERR(ctx->base.backlight))
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
