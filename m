Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39915CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 10:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EF7010E4B8;
	Mon, 22 Jun 2026 10:39:31 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2F3710E4B8
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 10:39:29 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-37d826e9811so469848a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 03:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782124769; x=1782729569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6sEwup8vrGtzg0eQ+zIA6Kd2oTy+XBY9jxS2BNcFzC0=;
 b=YoYRbnQrSGZIFXGs25AQ5MULFPGwAcAx4Jv8CPhZskQjVUmCFOUze+810RQS+pcFmK
 KYVrZQK0uP8RHx+9mpa28CZ459NWq73y89e/bFcGfYodiCPLpmKZ3r8yR08XdYhuRTHA
 yDqrNgCwon9RU+hPrvTr+yL64xDJzlRpB2vCdm2uNK6CC783USFLBFwi8pl0kw4yVx/o
 OUvXIUOC+8X1ZZxuDGkO/J5vf8tMwG6f120+W5tSiXQxb0ls74yxHtNyM17q+4SPEssg
 LkKIQZHjE5JvFaN+2DZsm9aKtiXGo2Ii5TB5bD9rs1PEjTOsxvC6XxOd59Vgu1sw4TLf
 E3MA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJPsV+LfMcYbfUvWCeIvnDZo8HUH7Y7YR1KegIjcOlWtSnFs6xMjoHjKGYV50m63wQAvDF5rJGbko=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdcvVutUzGmkb0H3KAK2/VEVQFM03hweYR17sU6zbpuJMPHYzI
 /2O6I4/qM7AqKHgDI4JMEjhdq+o82prwpn+9Zm8+2F82BEbl9wbPDxotU5aCl4sr
X-Gm-Gg: AfdE7ckVtzMW4lNNZA4Hr4+EDEyUnNdOhKsFn8JGcsTQSgZWRvDQy12opRuTrN1SxHJ
 D/DFDzNB643ZAqH74NyRKy/2Hc5aWnyIWqSATQRsHC/DjykNC+yysnN2Qb+6NhhY+pb2C8CIMhm
 54kpiVDt2Azg+fcIeHphDNCcfLDtDmKq9J0ut88bR0AnRz9PZhgMZCr4m+TEfzL5P8fQbYxN4EY
 pj1sWppuflr8/z4+hnW092bcSbexzHzL1I9zpqJ9A2op40RbsQsX4U7swALpzgRFzO40vqbk2/a
 5wF9XAmXQn0iLEytxxwMFh8xETfB9GyfjmGQrXOeCbhdrh3XEfMG0CFkDjKbu0vn6Cbf59UMWEY
 EkDoCGUIzWVeaPz3VEw/kbfFWntzvAE73dgXMRdATUtkIgrlCuPDgnmX6Xkl3zbbdFJ0u0u5LTN
 xW0/zjegiFi28kirMr3RBhhjexv0jbisiauhpnj3VK/3PB7nT3NKxV
X-Received: by 2002:a17:90b:274d:b0:36a:8240:2477 with SMTP id
 98e67ed59e1d1-37d15e8b6bcmr15398675a91.19.1782124768930; 
 Mon, 22 Jun 2026 03:39:28 -0700 (PDT)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com.
 [74.125.82.175]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37d135e2031sm9742606a91.0.2026.06.22.03.39.28
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 03:39:28 -0700 (PDT)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-30bf854d5feso8262778eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 03:39:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RocSRhCTfQkBuv7FhXYsJC2mlYg41zOnmMp/jEXZrNjAs2ouucPG3S+WHtOJ05OTvGBWgZyRYmc4yA=@lists.freedesktop.org
X-Received: by 2002:a05:6102:3314:b0:6ef:f6cf:1b32 with SMTP id
 ada2fe7eead31-72a043c9af3mr8022945137.27.1782124344043; Mon, 22 Jun 2026
 03:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260622101606.485961-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20260622101606.485961-4-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260622101606.485961-4-krzysztof.kozlowski@oss.qualcomm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Jun 2026 12:32:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWw4+-YZRx2icp_t3OQt3cb9osjac7gziiyRZcHa3zMbQ@mail.gmail.com>
X-Gm-Features: AVVi8CeRh5uGKoGdWXUVe0e4sYYTgs7H91cw7cP665l5Rz_E8v79r8eSiiAY4SE
Message-ID: <CAMuHMdWw4+-YZRx2icp_t3OQt3cb9osjac7gziiyRZcHa3zMbQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: Drop incorrect usage of double '::'
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney@redhat.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Andi Shyti <andi.shyti@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Peter Rosin <peda@lysator.liu.se>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Linus Walleij <linusw@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Sebastian Reichel <sre@kernel.org>, 
 Javier Martinez Canillas <javier@dowhile0.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Jonathan Marek <jonathan@marek.ca>, 
 Taniya Das <quic_tdas@quicinc.com>, Robert Marko <robimarko@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Stephan Gerhold <stephan@gerhold.net>,
 Adam Skladowski <a_skl39@protonmail.com>,
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

On Mon, 22 Jun 2026 at 12:16, Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
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
> Intention for this patch is to go via Rob's tree.

>  .../bindings/power/renesas,rcar-sysc.yaml     |  2 +-
>  .../bindings/soc/renesas/renesas-soc.yaml     |  4 ++--

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be> # renesas

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
