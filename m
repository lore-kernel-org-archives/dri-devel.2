Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62658C98326
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A48A110F90C;
	Fri, 25 Sep 2026 07:30:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FQ6SLDR2";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9069810F22E
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:51:15 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-488615e6cfcso150066f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790203874; x=1790808674; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mI1/ZYE5YHBF2sXaFTZzYUzCnN//3DiBm/zH9LcBkPw=;
 b=FQ6SLDR2w5y0Q/8vxb9oRf1TKZg1S5D5Vq2khSqN1RXRhoxCaSxZrmrVe+mALRt77k
 XmNE9cZeKo8KU6qjpqEK5K5R1l2kqtic4QyGof+6BvYHeMUN+z79x8OAuML/qAxG8OKk
 zWOCLiMGjWIP4C1DO9k2M5M2G3n9V701a9dRrozHTG9HrSJLZ/QeTWT2mNN6x+915Ffh
 HKH81JV6O054vZvNj2/V0dEcEn0Um1q4AX9H8x10ZhTnobu4DQPwKOd2iasljHyK14+A
 cK3L7ebzl2H9gDZqfcHaeWf3dS7bARb0121YnYnJb9Xk+rqxwY71ZEJYyOPQK0xpUrZr
 umNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790203874; x=1790808674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mI1/ZYE5YHBF2sXaFTZzYUzCnN//3DiBm/zH9LcBkPw=;
 b=RtXK/aHJMBbI6v5KsP5yvztBwizR16dR8h7oIz3rV1jBsdaz7zR1JKMb2BU8zm7gMZ
 mlduhn/ttdsRWVqCAw13UbdYId7iZ+RrnEaGuaLpUoex3pW3012BFVXBHhXRULp75wtJ
 BaNIW10EvrxpmLIack9myN1AMPXEqR417tfzdOeHlevh306HvYJklrEW5ijsTyGVqYie
 nyoI0Qgc98HqlYOVeK/aiAiWuyJB2Dbb/KFpg1Pe3k5METBo9pAzXAUAnNFhNB5bMmox
 OH2CCuuzwj9AmCpRBLUfaqmF/tFP6wA33BZGOnjQjCOHEK2DXDoYR42xb0RJvRvQ3cnO
 lxdw==
X-Forwarded-Encrypted: i=1;
 AKwUvBybKjcf6dkIGH+dabR+p05geXT/NP1qo2sk9THSBGSsL7/7rSOv9SRTSDZ19iWmHzmiiFO0UjwkQ/A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lkvFyHtnejvMyxaUHkTEj6EYYYewbahLm573ce9wcWcMIj+Up3
 c9CRZZPl/349XGCF5h5JZjWPs8nx1vyadQm73Jw4e/rR2lvLGC+XVVvG
X-Gm-Gg: AYBFou3JtL7WXum/m4MQxbEJpNKTV43HHRK8eIUGPp4CVDckzs/1m6eBUep+KAZtyfm
 UCPMExcoST44RSKb5voxIikSPlon9254KmO+yHr+1tock1Tq59C2xa1sDeI/MC3qkYB5g+c6A6P
 DRAlOiwboah/jOc53CkhDiwgo1LEBJSu+MY68gc1DUHr/HwCurDlVm5JFDzf6H6YlWC/gW1BfkU
 lwPPAs8O3c6LwfsgoDqzto7WbrcvVFBHohs6c/S3dylCkf7JrifiABa0VKfRw0qDgDZxBDp6zUb
 qNxmpHVomtQ1rVB+3HhYOlPOM0ersERBpMec68lFcwXhf7wvMOw7jR5ipMFjNV3NkUSNTSAd8Bm
 cPxwE9PP4C87stD9M8S7Zg5ktXbMmRUz8OF4a+j1pXcD9f1jDW/oFb3qh/d3y281L6FULtIRKHZ
 YVcucb0AQ9YAHv/yyOcbHbvbcHSqH/UVvkT7w1nUHtorNuTNEmt+zxOHz+lf/BenbprqX1ePdL4
 4NFoNN2wCdPjeE5C5bev39dwLOW8jSX8w==
X-Received: by 2002:a05:600d:8642:10b0:49f:c305:f4ce with SMTP id
 5b1f17b1804b1-49fe6705708mr6898435e9.16.1790203873928; 
 Wed, 23 Sep 2026 15:51:13 -0700 (PDT)
Received: from x230 (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488682673bdsm9822109f8f.2.2026.09.23.15.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:51:12 -0700 (PDT)
From: Petr Vorel <petr.vorel@gmail.com>
To: devnull+david.ixit.cz@kernel.org
Cc: abelvesa@kernel.org, airlied@gmail.com, andersson@kernel.org,
 conor+dt@kernel.org, david@ixit.cz, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dsankouski@gmail.com,
 jesszhan0024@gmail.com, konradybcio@kernel.org, krzk+dt@kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, phone-devel@vger.kernel.org, robh@kernel.org,
 simona@ffwll.ch, tzimmermann@suse.de, Petr Vorel <petr.vorel@gmail.com>
Subject: Re: [PATCH 04/11] drm/panel: s6e3ha8: Introduce AMB577PX01 panel
Date: Thu, 24 Sep 2026 00:51:07 +0200
Message-ID: <20260923225107.191388-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920-crosshatch-panel-v1-4-de6e9512da96@ixit.cz>
References: <20260920-crosshatch-panel-v1-4-de6e9512da96@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

...
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
...
>  static const struct of_device_id s6e3ha8_amb577px01_wqhd_of_match[] = {
> -	{ .compatible = "samsung,s6e3ha8" },
> +	{ .compatible = "samsung,s6e3ha8" }, /* deprecated */
> +	{ .compatible = "samsung,s6e3ha8-amb577px01" },

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Kind regards,
Petr
