Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56802C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E068F10F925;
	Fri, 25 Sep 2026 07:30:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e9NzG1Nq";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62B5B10E8E2
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 20:00:41 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso1537925e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790280040; x=1790884840; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:reply-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Waq+q+bs9tZHLy6mj9/0dS73pghCJzNJ2Bb0y33c6Wk=;
 b=e9NzG1Nq2ZcnvGetAHhf/2d7zMZLr5t4sC3x/+LR+089nnl5GR9RC2P5CyYbC4lN2K
 qfj1AezMH0QAezjRF6hsfR451rt11KXY4aamdO1Cv2ezwMOd2HuYTwt8VOwKPE1OzWcm
 E1r07HDmEy43IXJbWCBK1G2FvZcTtNiIxTDW++4F20e4CQXBRWK7TaQvsrqxFouqe8en
 LWpC9DVh713KmEG+A+y+QS0EnDceE3Vls5W3by0oj25eG1tNFe61SQFJCM1UWKpwDi2m
 44JKppvE6gJM3jjZh7TBxh7M38uE1zhzXAocACn2jmob576cBXvGppuponHQczJ02+tu
 WT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790280040; x=1790884840;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Waq+q+bs9tZHLy6mj9/0dS73pghCJzNJ2Bb0y33c6Wk=;
 b=H8Fp9Wak5bsLad5+o0nswxQ/QTLnS8TDAxworq8KPbtEE2fyZz2V+yPX80nhknS/Im
 Vr1VYBRIHHwMM0ao9vpHBJjKEqgNSXx9Es5GQ6f5J1jSeUs6dob9IwUDPrN4ZP2gnCgK
 j04PAAPLlog6LgAkeM8l8neRMeoYr3TPvKvT9hqw2FYMNz2Mf9/qcMW7ScIpN6BYJQZL
 7KpfzL6Ptl6NI6IjHs52GPRtX7jdVDMoAwH/4Pw6uCzz4GJTsio7SfIwth4Xy64H1Y+g
 NolSKGhxyJUbx+cFZdmqdh+3amPWeVKTXAAboGGbICMN6O1t4McQg+SFceWPAy5FACTH
 zKKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzINozVm5/v1ggzQHJJZk2gBaGpoNqIJ61i+Ariz6NplFunH5SNb0QvTCGchtYheiiZdw+EsXtt/7k=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lpxDt5z4sgbsR2sPu0M1XzS2SdlQ1Pb38p1NAcjVxQSsIrAYNN
 /b1MpZlm5nXpLYqhW0+fjvNk6YjmD2F+HeVxa85uJroI9CbI0WmqEnAC
X-Gm-Gg: AYBFou0/ksGlag4Z61pTNKebA2VqHeT+nCjMg3hST8OdHmqKlIS0bsOt2IkPqDtxCNM
 OXgGjSwMFdhfKVfSA9gRDD09Rn+30srf1jIP+IYswa/qvE+vq8ZEW9mzdkSPR5pTpWiRa11DdJF
 mc6x3CUHO4w16Qj8zz8RgMTwjUIRFQGqPUJCVcT60TSCprzoqJit5rVhbAJAahzF6l99wNrhSwn
 cLZI4I1hCE/fOoptnnKpK/m/ILvjE4JwzATDIUtaLxQkBsqAiaAxuC7B0fnYvvgkFQBGkphFHj0
 3yqtcbDI6FkF/JssYCaJrBBn07y+2Q+vjxIvZzKbFYkbGsclmi7wlxjWCgtfLFTTZRsrqEqBEdW
 q2KDKuPETqEAdY4/PP73uGobvFeds6nnq0ci5tt9xa2Mh00JpOt6J0omEFhuSFpD2aB4NVecxSR
 fUYq3C/GIc1z1NkXZFiT3y7y8lcN4JihcdNI4cSC8NjBScb9jx2BxP7RcnIEuph41xJcM5Jc78A
 nzPmkNElaZwKVNbEI+dXlPux3GmuwUo9pY=
X-Received: by 2002:a05:600c:6207:b0:49f:bd3c:bc20 with SMTP id
 5b1f17b1804b1-49fe66ff476mr67110105e9.27.1790280039460; 
 Thu, 24 Sep 2026 13:00:39 -0700 (PDT)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff069ceebsm1872715e9.3.2026.09.24.13.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 13:00:38 -0700 (PDT)
Date: Thu, 24 Sep 2026 22:00:35 +0200
From: Petr Vorel <petr.vorel@gmail.com>
To: david@ixit.cz
Cc: Dzmitry Sankouski <dsankouski@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 03/11] drm/panel: s6e3ha8: Really assert reset on the
 failure
Message-ID: <20260924200035.GA194087@pevik>
References: <20260924-crosshatch-panel-v2-0-08d5c7bf72fc@ixit.cz>
 <20260924-crosshatch-panel-v2-3-08d5c7bf72fc@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924-crosshatch-panel-v2-3-08d5c7bf72fc@ixit.cz>
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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
Reply-To: Petr Vorel <petr.vorel@gmail.com>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi all,

LGTM.
Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Kind regards,
Petr

> Due to incorrect implementation 0 == asserted, thus when driver fails it
> needs to assert reset.

> Minimal fix for stable; the polarity convention is corrected properly
> later in this series.

> Fixes: 779679d3c1640 ("drm/panel: Add support for S6E3HA8 panel driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
> index 078523df48860..835121b322f4a 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
> @@ -179,17 +179,17 @@ static int s6e3ha8_amb577px01_wqhd_prepare(struct drm_panel *panel)
>  	ret = regulator_bulk_enable(ARRAY_SIZE(s6e3ha8_supplies), priv->supplies);
>  	if (ret < 0)
>  		return ret;
>  	mipi_dsi_msleep(&ctx, 120);
>  	s6e3ha8_amb577px01_wqhd_reset(priv);

>  	ret = s6e3ha8_amb577px01_wqhd_on(priv);
>  	if (ret < 0) {
> -		gpiod_set_value_cansleep(priv->reset_gpio, 1);
> +		gpiod_set_value_cansleep(priv->reset_gpio, 0);
>  		goto err;
>  	}

>  	drm_dsc_pps_payload_pack(&pps, &priv->dsc);

>  	samsung_dsi_test_key_on_lvl1(&ctx);
>  	mipi_dsi_picture_parameter_set_multi(&ctx, &pps);
>  	samsung_dsi_test_key_off_lvl1(&ctx);
