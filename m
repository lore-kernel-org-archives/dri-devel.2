Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6529C61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D389310F0B7;
	Wed,  2 Sep 2026 08:43:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="mJatn3Xa";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E916710F0B0
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 08:43:06 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-6a374bea882so1292973a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 01:43:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788338585; cv=none;
 d=google.com; s=arc-20260327;
 b=Bwyuaq59VKkkmNskiXV7lW+T3xlH+hcZuhDsBVtr0n6Z/fuWUJTCsdbIpFeuHKuQi4
 xlELI27InZq0BOIA6C5yoP4/Vn6V46pXySCKlUiJRKYQlvIpkcGzyeaHVzhJOsPS9Dpp
 Esbo1+wSQFnOpookMirtmbooM5yuUXdQbcCwnE+10YRowkG8T/Dp8PUgtFdb6oVhF4oX
 aQpwWYFJOx4ytOE+LE2ow4az6CcwoUrH1P/uPmwpX+iW6W1vBi+/disCumCE5SmLz3V0
 ASeRMc9eVjUEr+TfhambCgfLUAUA/a9c+/kmjXPllhHKLqv8Z5h+jKgglxN0Qpt15lUz
 WEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/501w4jjREjvvsgS+ZOz+uCZPO58x///HL9BUvCfOWM=;
 fh=7iD/YiWiRift7uSyEh6lin9l5b41pB2tFIShMHnje6w=;
 b=gyJ2YZeRlwuXlgIOqU4cjuZdgzD7J96XWPqS2WaCSCY0x53bJKjrqghQm2kpvW0bjT
 IRy2MeXNPzEFnvYNqG7WmKj1rYyawYLuaFfwclCOKna/iKKNrwQ7v7Ofuvp8NC74OpR8
 Y2dqU5sHk5+4ddc3OzvuUUKYbNfy3YldK7IbUIpIvtUvQY4O696i/MH9cBe/i4QtguhQ
 yWoFLLOILPJPC6LPX0HSmzOEosNuyKMCZMOE0NKt0YdeW6srDwN/HMdwHMv85+hVfVsv
 7bZhYGC1ItSl+F3b85sTSarXiVT68Gzc5F7kCdXZ6e6dOxUqFY2aKPTBZ2AsMAm87YLk
 feRw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1788338585; x=1788943385; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/501w4jjREjvvsgS+ZOz+uCZPO58x///HL9BUvCfOWM=;
 b=mJatn3XaJe3YlVD+9lHCtW5uF6gSlQPZ+iRlSSfTrjxcjCe9vp6+diqWMyDSYliNke
 g+hCX4yjkhMgDjX4rY1nz++xvqCgNUmxP6H8TrUEUaQLAP3p1pBgqAUpQ5k1MEeOYSv6
 Qg2/pS7dwA18W7D84LtcfDotqKEJ7OYgLcUaNtuOP1bWVMJQvf96ouepIerfxhdyyNgF
 7bbrP+J8G7lnkjDsWFY3mn3zSrMmXuaVxAsoCtENFkicBfsnxB1JE+yCL0Vbz80j9Uo2
 qo0x3F5f6K/D6O4bZ2F23aYOtjr8Uvs0Ie+ihFFq86KDNSCNh591t3K4uCW2SSd4pYdh
 k5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788338585; x=1788943385;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/501w4jjREjvvsgS+ZOz+uCZPO58x///HL9BUvCfOWM=;
 b=JXf9UMcDthYHJIC2Nf9Y40gaKbDu+R/XyTEqZ293Vko83c3KzXxmwyqyQfhA3S8bx0
 8r25CORaXPfN64UvjpHrdduq30VCBlY0T8DLsN/nL1WZsUPY5LcnX0302gxh2ze4uQSa
 mFe7BUg+PNT3WKetDlPZIUFR8dR3AFbAEFnPTeNViLqVt8e68R8rDLmktdn56gDV18cM
 rmGFOGuEzh3pMTuzNugkbYf2NJKfnLAniibkCV6FIVL2wuJCPZ1hOurh4y3GuBolRF9U
 IqErR6ext+gyx6yB1YJesz6UXdVNwLQ53av1f2KFQKyOmREGVoXALWhCVRD12covUfAY
 FOQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwi7YSkx1DrRszhy+yv4OFod7K6OphAs/ZYj7beJMk41JW8g6yFku2o94GWBSkPKFyyvM8OTfIEhn4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m3F43I74obSamSfZ1APTCdpViF53AxURlDpH/EMPSuJqwE4/0W
 6kHw5tY9A9avYvSqRPUeO4en/pHwuUwiQ5xpeCpkLTC3dqveEVEkDP+LsJWc038Tqs2qS64tBq8
 vdud6K21ovRmXG5Nq8Tx9NsUPsaY6yGp+P2xiPE/tgw==
X-Gm-Gg: AYBFou3qL3DFUnybfyGP1FewD17cYb4KLS5C3kI8uXSAQhv3vvT7QlhcvkK1CO1TPvU
 02PU/71oRZFlHIC7cMkVQZJgUqsWgHjHodDc46pOMTnXur0gYHsE83NuvqkVZMBWK2Tbng/sf6v
 XP5GYH2euYbHS5n44cSgjl59viRRA1VHvkicK2Y6rCK9pmJlVuc9NQ3RkuMx3DBwRFl1GcaSeGd
 u1p0yDwHUebJjesvV4jEq08DkcMYsPDfS9AkNj/vV1UMT1xy38hCxJScAk/X6hbNkDWoAL0hMD6
 2CYSu5WT7Liimkqf0718zO8I4IQbm55m8FPL+n6Os/eZqh9Q9PRHiegIIe7IJnRjDbdTovz94wL
 9
X-Received: by 2002:a17:907:9625:b0:c25:4f7c:8ec5 with SMTP id
 a640c23a62f3a-c25d5505c79mr194261566b.23.1788338585138; Wed, 02 Sep 2026
 01:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260901234351.190506-1-anarsoul@gmail.com>
In-Reply-To: <20260901234351.190506-1-anarsoul@gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 2 Sep 2026 12:42:57 +0400
X-Gm-Features: AcwNN1VBSx96Am5bMyza-3Z81_49VCDlB0IsZHW5X9pTU9Oq40nOjzgNhihFkBM
Message-ID: <CAKTNdwFqSBt4QVCuYJxTyEDsxkW96JbUirFNAgJYWVLHzGpk4A@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: rockchip: rk3399: add 85.5 MHz rate to PLL rate
 table
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Heiko Stuebner <heiko@sntech.de>, 
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Vasily,

On Wed, Sep 2, 2026 at 3:42=E2=80=AFAM Vasily Khoruzhick <anarsoul@gmail.co=
m> wrote:
>
> 85.5 MHz is the pixel clock of the standard DMT 1366x768@60 mode,
> which is the native mode of many cheap HDMI panels.
>
> Use a 1368 MHz VCO (24 MHz * 57, already used by the existing
> 1368 MHz entry) with postdiv1 =3D postdiv2 =3D 4 to hit 85.5 MHz
> exactly in integer mode.
>
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/clk/rockchip/clk-rk3399.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk=
-rk3399.c
> index c2b243d7a5e2..db241d2df625 100644
> --- a/drivers/clk/rockchip/clk-rk3399.c
> +++ b/drivers/clk/rockchip/clk-rk3399.c
> @@ -98,6 +98,7 @@ static struct rockchip_pll_rate_table rk3399_pll_rates[=
] =3D {
>         RK3036_PLL_RATE( 148500000, 1, 99, 4, 4, 1, 0),
>         RK3036_PLL_RATE( 106500000, 1, 71, 4, 4, 1, 0),
>         RK3036_PLL_RATE(  96000000, 1, 64, 4, 4, 1, 0),
> +       RK3036_PLL_RATE(  85500000, 1, 57, 4, 4, 1, 0),

There is already an entry for 1368000000, which is 16x your rate, and
the 16x divisor should fit comfortably into the downstream clock's
8-bit divisor field. Do you really need a separate PLL rate? Have you
checked what the hardware arrives at with the unmodified PLL table -
e.g. via /sys/kernel/debug/clk/clk_summary?

Best regards,
Alexey
