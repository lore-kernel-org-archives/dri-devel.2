Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA0ACD8CB2
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6007910E60D;
	Thu, 11 Jun 2026 05:28:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BOUXTnxh";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCF1510E60D
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 05:28:13 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-36bb3551f6eso6627440a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 22:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781155693; x=1781760493; darn=lists.freedesktop.org;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gsRiWOtrhmLQhSwDTt/EB1kdzkedDtA7OBAUiNrmwW4=;
 b=BOUXTnxht4K6H8GtTnYQ6ANSytIkzkXj6jTA0GQW1/uwA+st/DboPslJi6LKorZgTu
 0XwjDjI5zQax6VBMJa/U23HkuQ38KxPWNo6jT4zb1+0/dowhyfRE11LBd++Y2qE7JgWF
 Sk8fPk3u/sk6wuxvFG7CgwNy1fzupyaoSBf20Z86JmjcKWpFA8P/RdS+QmZNM1QCUpEk
 YJhHApulzbBMhrzEzLCp18cNLF0+O355TwZZ/8ypsiTrU5WAGnTPCxn74XmVhMQW8hXF
 2Du78bJuFL57O8e0rEgLoWVTbqAdKWMi7MEkn72Bsn7k6/7oN+Gkq1ujQwyEujXmUvmp
 RaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155693; x=1781760493;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gsRiWOtrhmLQhSwDTt/EB1kdzkedDtA7OBAUiNrmwW4=;
 b=MdtUqz8qhKYPR1aKxFNYsb3WQQsE+5/dCU02DrP93G4CwADwYei7/cEc4swGV+7GlL
 G9mOa9aTFrDOSCxfPeXKq1SUNeQxecIhN8B7axKjWn4TVJ7/uDhH3wYgItjah0WNX+C4
 obzFvNpZHHxeG+XykTrMhobHg5kUvZjvWqxypFR3uA9DLzUsq++KLc3EsScu94HOH6FP
 I+t1SWbt+nAmcD7COn5Gbe4ai7BpFOYx+Jj1tekX5YLCV4BhHdguATV25WNqzs8YmbDD
 tpiBDCobxjwkSmTATV9wZdjgqEwyTraSNzNh+wdDLMZOLbGKCEHLzAm+q3Ws4RVdiy9u
 kUtQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8pvSsT4WdmrkS5WI5XopEDRqFX69aEoX2S2G6Ij9YjLHTWjptknhtJSRCxLiiSsqRuwDewA7kz/6o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YywJagusVlFDEJsJfWCWHwt/OvgnYuRsaCNu0HYvSbUy7SWecY9
 3GOJqHqwm/Bo8TuYWJNWmmMezWsUYtvtZlc+fkbZXcvs8UL4wT2HWDRE
X-Gm-Gg: Acq92OF+q+jr7xZmwF5DfWRBtnlHhOE+N142cJi8Bqr/QltEbm8D8IqNE7Mr2/lkUcZ
 9tXwqqY3HqmEqAyOETKGcDGMWrj38PqCbsMSecwwX2fz7xtfffmOcWvLenX7RI2HQAZIZDEzmQd
 8M+66I2o+Cz+xNOG5pwFXd5VLaRTAaBf28rTT/Z50NnQDtxwk8+AloRvbxDXbxSbsW4TVj/DJGu
 GpuCHBzbRZfImv7K5oOAHa/cl0F8sdWpX0+8KcKxI2WUgAc254kNOSFWmmXxQroqTJ5M5mgXIdh
 HqnkbjQ84UfZeopmjyowfTjy9Dfdq0TbFFGCSYjrHXM41fsU2VpveGqG0KM8j03ks75RBF7GRmk
 Cq1ZGlMihItDZPCe9J22CyAv7bp+WSOh23Zqkud8c4d4a8mcPI8DdeEeSwXYBOnY406D5ID5cs8
 LbWy6nBzCikxGcPQpH7Ja2oNbedvv5baMEpyqBfwrLn5izgA==
X-Received: by 2002:a17:90b:4acb:b0:368:7c0f:ebf7 with SMTP id
 98e67ed59e1d1-377a73e2750mr1577907a91.16.1781155693118; 
 Wed, 10 Jun 2026 22:28:13 -0700 (PDT)
Received: from [10.188.227.203] ([2408:844f:2361:d7cd:deb7:4e0e:26d0:4076])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-377522a1a9esm1144589a91.4.2026.06.10.22.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:28:12 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] dt-bindings: display: panel: himax,hx83121a: add
 optional bl supply
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Pengyu Luo <mitltlatltl@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260608162622.403713-1-zhengxingda@iscas.ac.cn>
References: <20260608162622.403713-1-zhengxingda@iscas.ac.cn>
Date: Thu, 11 Jun 2026 13:26:47 +0800
Message-Id: <178115560756.199930.11183711627429440356.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Tue, 09 Jun 2026 00:26:20 +0800, Icenowy Zheng <zhengxingda@iscas.ac.cn> wrote:
> When the backlight is managed by the panel controller IC, an external
> power rail might be powering the backlight.
> 
> Add an optional `bl-supply` property to describe such power rail, thus
> allow disabling the backlight.
> 

Please add it as a hwen pin, this will simplify your code later.

>
>
> diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83121a.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83121a.yaml
> index e067a2f6d0b2..aeca3c9a599c 100644
> --- a/Documentation/devicetree/bindings/display/panel/himax,hx83121a.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/himax,hx83121a.yaml
> @@ -40,6 +40,9 @@ properties:
>    vddi-supply:
>      description: power supply for IC
>  
> +  bl-supply:
> +    description: power supply for backlight, in case it's managed via DSC
> +

s/DSC/DCS/

Best wishes,
Pengyu

-- 
Best wishes,
Pengyu

