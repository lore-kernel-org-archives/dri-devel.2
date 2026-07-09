Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F0EC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 13:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA01E10F5E3;
	Thu,  9 Jul 2026 13:56:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="akSsflIe";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B345810F5E5
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 13:56:32 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-698bf053053so3207611a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 06:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783605388; cv=none;
 d=google.com; s=arc-20260327;
 b=X/+goiqJvwCdGkXilPCF6Ws0ZN+prYKv1v3qNXbvK4NROVafGyXcrQnXScg2bfDGIx
 phYJ7swpltvo3li1yriTp7yagssWcZ2zpbL4/d5YH3XaiyxDf5j2MqjFYGQpotYY8UG4
 dzk+utR5qzKd1xFcYs0Kkc1IJH0fg/GzZpFmR5pGKJY+/IOW9oQMgPIhGNxbQ9Lp/XMV
 jA9S/219uA+1kDHKVOhxtIjMrAglBBSAjTOtpx6/LEAAKgWyrsdsa5fNzb8i75omlHmR
 NzY0ikm3ES7DtxHE2gOtv/hW9UrzVvAiDXQiNe72KFn4pm/9EHUPhYSKuvgbChSysA4l
 lUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oz3TqcSob1iz2HoY3RmXUMkFz0uE9O3/sgBJyKO/p9k=;
 fh=b/H3WJBXyjnpZ6/mT1yeCS3rXgdItMF3LMEbLkgJTco=;
 b=Spja2IkGdbwMDv0aimaNPX9Y946cZY4H9CDJJkgHc3s4b22iqIPmeylsJe8/ZR751f
 KnXzhUl5pdHaknowvDIlwn6+zcahLp2Xp/juSa6b3YBqVE91CQavk8D2PVgYdAOUCfcx
 T3yeTftP3H2AwgggpFUbwEDIrDgnVb26jqGnX7CKwv7qdLIQmFyNRWraQxNO6sBcUHLX
 YP2HLSyEjnXkt21rEsCUcUqtHbVB0LN3oSoqCXZ3GzI6C48UDifxDcs9yzqvRIuTOZ8h
 mHzhn8/n58HoRbXSVoWHHQuuOjbruzCOwDhX6MyozlVXqyqgCovWGS8brH0TTebEkfIM
 24Iw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783605388; x=1784210188; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oz3TqcSob1iz2HoY3RmXUMkFz0uE9O3/sgBJyKO/p9k=;
 b=akSsflIe6Uz2QCmwOSC82Qszw7uIp1wkRNdvpKBWohoUVUg2TmvQCfXV/LmdfuP9Wb
 3q3yeFICeSBCUGC17uuxxgVUQFSwOBhI6lM6PlL3YpaYMFKymTRRoebIyU7ou95BJmxx
 jrgdW4b8Z3w5XHjGOj3dBqTTun+PqglDZYTgffjHJCw2bHP6LNxjbLRewydUnc6Aa77s
 p8UbFfkJASQZSlm/JDNgM5al6esCSPAGFyvPcPSHnbLKcwEZaQOj3vcwBy76ZfMLpkI9
 6ib8JNrh4nUkBIPoR6DUp46M7YRzHMvgysUmzMOiOC0C1A90R+Yaq5mwywSfJpAjWyRP
 Xz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783605388; x=1784210188;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oz3TqcSob1iz2HoY3RmXUMkFz0uE9O3/sgBJyKO/p9k=;
 b=EAiltZ6019FGe4JpYr8pnjuDqkjphWg2gtncTv1js2k1Yg6KDLDBC5XzNnwnvEeQNs
 ztClJdkcz8DyUExLHq+8SNFs6HZjqVgspBUki/K3ZcbnihRmg7VIL1vlEN9KSoZdedD/
 fKYz95E+SbHJobwlfP7rov3aqLflWl8ZHF/ESWWE5DHqETViJcMeUiUzGeYj9MAiEph6
 8qx+wJJrXLnfUlhnuIPbDnogXCJBmiwnffUEB7rVQcgbGVUyabZWMVvAS+x0VFyEeOYC
 ug4vNzMA3NF2vVK3oWk2sGrj3ErN0Ag8U5injTRcrUyvLumPUwYFN3ywLknQvQ/JCC94
 2O/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqO1CB4yzAf6sNeTQreJrJIcp5DmE9kNF0b2uHPsl7jb6FRlPANSWLyHL5YmxvbUjf6CLZtRFE8Fms=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyuaL3FsapfM4eN8oIZaRASeJ9R4xxmvATAnWiPQPJSER0HQwfk
 lAKvInu2IHvMYqIFsKQOJF+WqMUFqBlaTZNgtjEw8NC6o7BUCfo6VHYJKFnTJd+muvhLchvtmKg
 2jiUMSXq7aHEyU1D5RjpKQk4VtoX8o46zDkech7jNiA==
X-Gm-Gg: AfdE7cnCCK4LKqew4Y08Ueen11QLqDcvTyPLCAFpOIL5bt2aI/ss5drAJPRtPa2SmEp
 9aWsQcW3irtwmONkRSny7lTM8t85zPkGymKPYufWGnq+MX3m7VISA6BhODL2R8p+JLwCPsvC/ga
 J1ZllyCOrgzIJMwHcV6oj5nvuYyhut2OlSAZZFGMeaceJ+1v2MmM+717YEuDhNgbGQi+VRUbSKB
 a4IPmwI0VJLHc2MYEOy0R7XKChfzQTSX0nHRJlkYusGN97rAsZh79FTpsnukLq3w2ff84Xj37aM
 sNk3hTll8DujZETC3cIot7zjFA049ok=
X-Received: by 2002:a05:6402:40c2:b0:698:b23a:e54a with SMTP id
 4fb4d7f45d1cf-69ab44aacecmr3514542a12.31.1783605388037; Thu, 09 Jul 2026
 06:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260622101606.485961-3-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260622101606.485961-3-krzysztof.kozlowski@oss.qualcomm.com>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 9 Jul 2026 14:56:16 +0100
X-Gm-Features: AUfX_mxUaPHGHSwGPApExHwwkEIMRb86nyTcHDhIh4vb3wVsK3rDljrNHUI70aE
Message-ID: <CADrjBPoJn2OFcU3ojRhgow-1vOo40z8tfiP3rJrJcGUOoHyavg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: Drop incorrect usage of double
 '::'
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ulf Hansson <ulfh@kernel.org>, 
 Peter Rosin <peda@lysator.liu.se>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linusw@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Sebastian Reichel <sre@kernel.org>,
 Javier Martinez Canillas <javier@dowhile0.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Jonathan Marek <jonathan@marek.ca>, Taniya Das <quic_tdas@quicinc.com>, 
 Robert Marko <robimarko@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Adam Skladowski <a_skl39@protonmail.com>,
 Sireesh Kodali <sireeshkodali@protonmail.com>, 
 Barnabas Czeman <barnabas.czeman@mainlining.org>,
 Imran Shaik <quic_imrashai@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Anusha Rao <quic_anusha@quicinc.com>, 
 Luo Jie <quic_luoj@quicinc.com>, Tomasz Figa <tomasz.figa@gmail.com>, 
 Chanho Park <chanho61.park@samsung.com>,
 Sunyeal Hong <sunyeal.hong@samsung.com>, 
 Shin Son <shin.son@samsung.com>, Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Alina Yu <alina_yu@richtek.com>, 
 Andy Gross <agross@kernel.org>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
 Wesley Cheng <quic_wcheng@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-i2c@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-gpio@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 22 Jun 2026 at 11:16, Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
>
> There is no use of double colon '::' in YAML. OTOH, the literal style
> block, e.g. using '|' treats all characters as content [1] therefore
> single use of ':' in descriptions is perfectly fine, whenever '|' is
> used.
>
> Cleanup existing code, so the confusing style won't be re-used in new
> contributions.
>
> Link: https://yaml.org/spec/1.2.2/#literal-style [1]
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>
> ---
>
> I split the patches to avoid bounces from mailing list due to email size.
>
> This can go via clock tree (no dependencies)... or both could go via
> Rob's tree.
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org> (for Samsung parts)

>  .../devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml       | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-apq8064.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-apq8084.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-ipq6018.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-ipq8064.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-mdm9607.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-mdm9615.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-msm8660.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-msm8909.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-msm8916.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-msm8953.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-msm8974.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-sdm660.yaml          | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,gpucc.yaml     | 2 +-
>  .../devicetree/bindings/clock/qcom,ipq5018-gcc.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,ipq9574-gcc.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,qca8k-nsscc.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,qcm2290-gpucc.yaml       | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml     | 2 +-
>  .../devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml  | 2 +-
>  .../devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml    | 2 +-
>  .../devicetree/bindings/clock/qcom,sm6115-lpasscc.yaml      | 2 +-
>  .../devicetree/bindings/clock/qcom,sm8350-videocc.yaml      | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,videocc.yaml   | 2 +-
>  .../devicetree/bindings/clock/samsung,exynos5260-clock.yaml | 6 +++---
>  .../devicetree/bindings/clock/samsung,exynos5410-clock.yaml | 2 +-
>  .../devicetree/bindings/clock/samsung,exynos5433-clock.yaml | 2 +-
>  .../devicetree/bindings/clock/samsung,exynos7-clock.yaml    | 2 +-
>  .../devicetree/bindings/clock/samsung,exynos850-clock.yaml  | 2 +-
>  .../bindings/clock/samsung,exynosautov9-clock.yaml          | 2 +-
>  .../bindings/clock/samsung,exynosautov920-clock.yaml        | 2 +-
>  .../devicetree/bindings/clock/samsung,s5pv210-clock.yaml    | 2 +-
>  32 files changed, 34 insertions(+), 34 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
> index 53a5ab319159..6863db9bd092 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
> @@ -13,7 +13,7 @@ description: |
>    Qualcomm display clock control module provides the clocks, resets and power
>    domains on SM8150/SM8250/SM8350.
>
> -  See also::
> +  See also:
>      include/dt-bindings/clock/qcom,dispcc-sm8150.h
>      include/dt-bindings/clock/qcom,dispcc-sm8250.h
>      include/dt-bindings/clock/qcom,dispcc-sm8350.h
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> index 27df7e3e5bf3..68532244901e 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> @@ -14,7 +14,7 @@ description: |
>    Qualcomm global clock control module provides the clocks, resets and power
>    domains on APQ8064.
>
> -  See also::
> +  See also:
>      include/dt-bindings/clock/qcom,gcc-msm8960.h
>      include/dt-bindings/reset/qcom,gcc-msm8960.h
>
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8084.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8084.yaml
> index 0a0a26d9beab..1c022e75fd71 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8084.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8084.yaml
> @@ -14,7 +14,7 @@ description: |
>    Qualcomm global clock control module provides the clocks, resets and power
>    domains on APQ8084.
>
> -  See also::
> +  See also:
>      include/dt-bindings/clock/qcom,gcc-apq8084.h
>      include/dt-bindings/reset/qcom,gcc-apq8084.h
>
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq6018.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq6018.yaml
> index 4d2614d4f368..c7fb84438db7 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq6018.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq6018.yaml
> @@ -15,7 +15,7 @@ description: |
>    Qualcomm global clock control module provides the clocks, resets and power
>    domains on IPQ6018.
>
> -  See also::
> +  See also:
>      include/dt-bindings/clock/qcom,gcc-ipq6018.h
>      include/dt-bindings/reset/qcom,gcc-ipq6018.h
>
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
> index a71557395c01..b4d3175780bc 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
> @@ -13,7 +13,7 @@ description: |
>    Qualcomm global clock control module provides the clocks, resets and power
>    domains on IPQ8064.
>
> -  See also::
> +  See also:
>      include/dt-bindings/clock/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
>      include/dt-bindings/reset/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
>
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-mdm9607.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-mdm9607.yaml
> index d7da30b0e7ee..0a7be7583bdd 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-mdm9607.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-mdm9607.yaml
> @@ -14,7 +14,7 @@ description: |
>    Qualcomm global clock control module provides the clocks, resets and power
>    domains.
>
> -  See also::
> +  See also:
>      include/dt-bindings/clock/qcom,gcc-mdm9607.h
>
>  allOf:
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-mdm9615.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-mdm9615.yaml
> index 418dea31eb62..0656d5ee448d 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-mdm9615.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-mdm9615.yaml
> @@ -14,7 +14,7 @@ description: |
>    Qualcomm global clock control module provides the clocks, resets and power
>    domains.
>
> -  See also::
> +  See also:
>      include/dt-bindings/clock/qcom,gcc-mdm9615.h
>
>  allOf:
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8660.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8660.yaml
> index e03b6d0acdb6..70c9da1f35c2 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8660.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8660.yaml
> @@ -14,7 +14,7 @@ description: |
>    Qualcomm global clock control module provides the clocks and resets on
>    MSM8660
>
> -  See also::
> +  See also:
>      include/dt-bindings/clock/qcom,gcc-msm8660.h
>      include/dt-bindings/reset/qcom,gcc-msm8660.h
>
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8909.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8909.yaml
> index ce1f5a60bd8c..2edb6c251d99 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8909.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8909.yaml
> @@ -13,7 +13,7 @@ description: |
>    Qualcomm global clock control module provides the clocks, resets and power
>    domains on MSM8909, MSM8917 or QM215.
>
> -  See also::
> +  See also:
>      include/dt-bindings/clock/qcom,gcc-msm8909.h
>      include/dt-bindings/clock/qcom,gcc-msm8917.h
>
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8916.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8916.yaml
> index 258b6b93deca..af4b639ea8c3 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8916.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8916.yaml
> @@ -14,7 +14,7 @@ description: |
>    Qualcomm global clock control module provides the clocks, resets and power
>    domains on MSM8916 or MSM8939.
>
> -  See also::
> +  See also:
>      include/dt-bindings/clock/qcom,gcc-msm8916.h
>      include/dt-bindings/clock/qcom,gcc-msm8939.h
>      include/dt-bindings/reset/qcom,gcc-msm8916.h
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8953.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8953.yaml
> index ced3118c8580..fc0360554f68 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8953.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8953.yaml
> @@ -15,7 +15,7 @@ description: |
>    Qualcomm global clock control module provides the clocks, resets and power
>    domains on MSM8937, MSM8940, MSM8953 or SDM439.
>
> -  See also::
> +  See also:
>      include/dt-bindings/clock/qcom,gcc-msm8917.h
>      include/dt-bindings/clock/qcom,gcc-msm8953.h
>
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8974.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8974.yaml
> index 929fafc84c19..378dfe7854ac 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8974.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8974.yaml
> @@ -15,7 +15,7 @@ description: |
>    Qualcomm global clock control module provides the clocks, resets and power
>    domains on MSM8974 (all variants) and MSM8226.
>
> -  See also::
> +  See also:
>      include/dt-bindings/clock/qcom,gcc-msm8974.h (qcom,gcc-msm8226 and qcom,gcc-msm8974)
>      include/dt-bindings/reset/qcom,gcc-msm8974.h (qcom,gcc-msm8226 and qcom,gcc-msm8974)
>
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sdm660.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sdm660.yaml
> index 724ce0491118..72aaf699cf70 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-sdm660.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sdm660.yaml
> @@ -14,7 +14,7 @@ description: |
>    Qualcomm global clock control module provides the clocks, resets and power
>    domains on SDM630, SDM636 and SDM660
>
> -  See also::
> +  See also:
>      include/dt-bindings/clock/qcom,gcc-sdm660.h  (qcom,gcc-sdm630 and qcom,gcc-sdm660)
>
>  $ref: qcom,gcc.yaml#
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> index 4cdff6161bf0..3ac4419009a9 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> @@ -14,7 +14,7 @@ description: |
>    Qualcomm graphics clock control module provides the clocks, resets and power
>    domains on Qualcomm SoCs.
>
> -  See also::
> +  See also:
>      include/dt-bindings/clock/qcom,gpucc-sdm845.h
>      include/dt-bindings/clock/qcom,gpucc-sa8775p.h
>      include/dt-bindings/clock/qcom,gpucc-sc7180.h
> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5018-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5018-gcc.yaml
> index 489d0fc5607c..9925b931ecad 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,ipq5018-gcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq5018-gcc.yaml
> @@ -13,7 +13,7 @@ description: |
>    Qualcomm global clock control module provides the clocks, resets and power
>    domains on IPQ5018
>
> -  See also::
> +  See also:
>      include/dt-bindings/clock/qcom,ipq5018-gcc.h
>      include/dt-bindings/reset/qcom,ipq5018-gcc.h
>
> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
> index 27ae9938febc..5b128fa841aa 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
> @@ -14,7 +14,7 @@ description: |
>    Qualcomm global clock control module provides the clocks, resets and power
>    domains on IPQ9574
>
> -  See also::
> +  See also:
>      include/dt-bindings/clock/qcom,ipq9574-gcc.h
>      include/dt-bindings/reset/qcom,ipq9574-gcc.h
>
> diff --git a/Documentation/devicetree/bindings/clock/qcom,qca8k-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,qca8k-nsscc.yaml
> index 61473385da2d..3da10c364a85 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,qca8k-nsscc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,qca8k-nsscc.yaml
> @@ -14,7 +14,7 @@ description: |
>    Qualcomm NSS clock control module provides the clocks and resets
>    on QCA8386(switch mode)/QCA8084(PHY mode)
>
> -  See also::
> +  See also:
>      include/dt-bindings/clock/qcom,qca8k-nsscc.h
>      include/dt-bindings/reset/qcom,qca8k-nsscc.h
>
> diff --git a/Documentation/devicetree/bindings/clock/qcom,qcm2290-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,qcm2290-gpucc.yaml
> index 734880805c1b..bedbdabef672 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,qcm2290-gpucc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,qcm2290-gpucc.yaml
> @@ -13,7 +13,7 @@ description: |
>    Qualcomm graphics clock control module provides the clocks, resets and power
>    domains on Qualcomm SoCs.
>
> -  See also::
> +  See also:
>      include/dt-bindings/clock/qcom,qcm2290-gpucc.h
>
>  properties:
> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> index ab97d4b7dba8..b6c835bfd0d9 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> @@ -12,7 +12,7 @@ maintainers:
>
>  description: |
>    The clock enumerators are defined in <dt-bindings/clock/qcom,rpmcc.h> and
> -  come in pairs:: FOO_CLK followed by FOO_A_CLK. The latter clock is
> +  come in pairs: FOO_CLK followed by FOO_A_CLK. The latter clock is
>    an "active" clock, which means that the consumer only care that the clock is
>    available when the apps CPU subsystem is active, i.e. not suspended or in
>    deep idle. If it is important that the clock keeps running during system
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
> index 99ab9106009f..fd06ac9bceb9 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
> @@ -13,7 +13,7 @@ description: |
>    Qualcomm LPASS core and audio clock control module provides the clocks and
>    power domains on SC7280.
>
> -  See also::
> +  See also:
>      include/dt-bindings/clock/qcom,lpasscorecc-sc7280.h
>      include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h
>
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
> index 273d66e245c5..f235b4e24cc7 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
> @@ -13,7 +13,7 @@ description: |
>    Qualcomm LPASS core and audio clock control module provides the clocks,
>    and reset on SC8280XP.
>
> -  See also::
> +  See also:
>      include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h
>
>  properties:
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6115-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6115-lpasscc.yaml
> index 8cbab3fbb660..d7e1938b5e1b 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sm6115-lpasscc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm6115-lpasscc.yaml
> @@ -14,7 +14,7 @@ description: |
>    Qualcomm LPASS core and audio clock controllers provide audio-related resets
>    on SM6115 and its derivatives.
>
> -  See also::
> +  See also:
>      include/dt-bindings/clock/qcom,sm6115-lpasscc.h
>
>  properties:
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml
> index 5c2ecec0624e..a986ab4ce7c7 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml
> @@ -13,7 +13,7 @@ description: |
>    Qualcomm video clock control module provides the clocks, resets and power
>    domains on Qualcomm SoCs.
>
> -  See also::
> +  See also:
>      include/dt-bindings/clock/qcom,videocc-sm8350.h
>      include/dt-bindings/reset/qcom,videocc-sm8350.h
>
> diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
> index f4ff9acef9d5..124d259fc85e 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
> @@ -13,7 +13,7 @@ description: |
>    Qualcomm video clock control module provides the clocks, resets and power
>    domains on Qualcomm SoCs.
>
> -  See also::
> +  See also:
>      include/dt-bindings/clock/qcom,sm6350-videocc.h
>      include/dt-bindings/clock/qcom,videocc-sc7180.h
>      include/dt-bindings/clock/qcom,videocc-sc7280.h
> diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos5260-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos5260-clock.yaml
> index b05f83533e3d..56ab972c3da5 100644
> --- a/Documentation/devicetree/bindings/clock/samsung,exynos5260-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/samsung,exynos5260-clock.yaml
> @@ -14,17 +14,17 @@ maintainers:
>
>  description: |
>    Expected external clocks, defined in DTS as fixed-rate clocks with a matching
> -  name::
> +  name:
>      - "fin_pll" - PLL input clock from XXTI
>      - "xrtcxti" - input clock from XRTCXTI
>      - "ioclk_pcm_extclk" - pcm external operation clock
>      - "ioclk_spdif_extclk" - spdif external operation clock
>      - "ioclk_i2s_cdclk" - i2s0 codec clock
>
> -  Phy clocks::
> +  Phy clocks:
>    There are several clocks which are generated by specific PHYs.  These clocks
>    are fed into the clock controller and then routed to the hardware blocks.
> -  These clocks are defined as fixed clocks in the driver with following names::
> +  These clocks are defined as fixed clocks in the driver with following names:
>      - "phyclk_dptx_phy_ch3_txd_clk" - dp phy clock for channel 3
>      - "phyclk_dptx_phy_ch2_txd_clk" - dp phy clock for channel 2
>      - "phyclk_dptx_phy_ch1_txd_clk" - dp phy clock for channel 1
> diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos5410-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos5410-clock.yaml
> index b737c9d35a1c..1d907dd8fbf1 100644
> --- a/Documentation/devicetree/bindings/clock/samsung,exynos5410-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/samsung,exynos5410-clock.yaml
> @@ -14,7 +14,7 @@ maintainers:
>
>  description: |
>    Expected external clocks, defined in DTS as fixed-rate clocks with a matching
> -  name::
> +  name:
>      - "fin_pll" - PLL input clock from XXTI
>
>    All available clocks are defined as preprocessor macros in
> diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos5433-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos5433-clock.yaml
> index 3f9326e09f79..8a289f1e2ace 100644
> --- a/Documentation/devicetree/bindings/clock/samsung,exynos5433-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/samsung,exynos5433-clock.yaml
> @@ -14,7 +14,7 @@ maintainers:
>
>  description: |
>    Expected external clocks, defined in DTS as fixed-rate clocks with a matching
> -  name::
> +  name:
>      - "oscclk" - PLL input clock from XXTI
>
>    All available clocks are defined as preprocessor macros in
> diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml
> index c137c6744ef9..a51cd4fafb41 100644
> --- a/Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml
> @@ -14,7 +14,7 @@ maintainers:
>
>  description: |
>    Expected external clocks, defined in DTS as fixed-rate clocks with a matching
> -  name::
> +  name:
>      - "fin_pll" - PLL input clock from XXTI
>
>    All available clocks are defined as preprocessor macros in
> diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
> index cdc5ded59fe5..68c2fd318765 100644
> --- a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
> @@ -17,7 +17,7 @@ description: |
>    Exynos850 clock controller is comprised of several CMU units, generating
>    clocks for different domains. Those CMU units are modeled as separate device
>    tree nodes, and might depend on each other. Root clocks in that clock tree are
> -  two external clocks:: OSCCLK (26 MHz) and RTCCLK (32768 Hz). Those external
> +  two external clocks: OSCCLK (26 MHz) and RTCCLK (32768 Hz). Those external
>    clocks must be defined as fixed-rate clocks in dts.
>
>    CMU_TOP is a top-level CMU, where all base clocks are prepared using PLLs and
> diff --git a/Documentation/devicetree/bindings/clock/samsung,exynosautov9-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynosautov9-clock.yaml
> index 32f39e543b36..e9d17d48b4f3 100644
> --- a/Documentation/devicetree/bindings/clock/samsung,exynosautov9-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/samsung,exynosautov9-clock.yaml
> @@ -17,7 +17,7 @@ description: |
>    Exynos Auto v9 clock controller is comprised of several CMU units, generating
>    clocks for different domains. Those CMU units are modeled as separate device
>    tree nodes, and might depend on each other. Root clocks in that clock tree are
> -  two external clocks:: OSCCLK/XTCXO (26 MHz) and RTCCLK/XrtcXTI (32768 Hz).
> +  two external clocks: OSCCLK/XTCXO (26 MHz) and RTCCLK/XrtcXTI (32768 Hz).
>    The external OSCCLK must be defined as fixed-rate clock in dts.
>
>    CMU_TOP is a top-level CMU, where all base clocks are prepared using PLLs and
> diff --git a/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml
> index 6b1fc61a2ff9..475db824d4d3 100644
> --- a/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml
> @@ -17,7 +17,7 @@ description: |
>    ExynosAuto v920 clock controller is comprised of several CMU units, generating
>    clocks for different domains. Those CMU units are modeled as separate device
>    tree nodes, and might depend on each other. Root clocks in that clock tree are
> -  two external clocks:: OSCCLK/XTCXO (38.4 MHz) and RTCCLK/XrtcXTI (32768 Hz).
> +  two external clocks: OSCCLK/XTCXO (38.4 MHz) and RTCCLK/XrtcXTI (32768 Hz).
>    The external OSCCLK must be defined as fixed-rate clock in dts.
>
>    CMU_TOP is a top-level CMU, where all base clocks are prepared using PLLs and
> diff --git a/Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.yaml
> index 67a33665cf00..b1617d96d3fb 100644
> --- a/Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.yaml
> @@ -14,7 +14,7 @@ maintainers:
>
>  description: |
>    Expected external clocks, defined in DTS as fixed-rate clocks with a matching
> -  name::
> +  name:
>      - "xxti" - external crystal oscillator connected to XXTI and XXTO pins of
>        the SoC,
>      - "xusbxti" - external crystal oscillator connected to XUSBXTI and XUSBXTO
> --
> 2.53.0
>
