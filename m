Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628B7C79F8C
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 06:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4579B10E35A;
	Sun,  6 Sep 2026 06:09:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KMrwiUtX";
	dkim-atps=neutral
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com
 [209.85.161.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9925710E352
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 06:09:06 +0000 (UTC)
Received: by mail-oo1-f48.google.com with SMTP id
 006d021491bc7-6b1b766bf01so1102469eaf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 23:09:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788674945; cv=none;
 d=google.com; s=arc-20260327;
 b=eQ0YyzdMUyUW5+8lR1CDi6fzu+e4OarFFmv9tyvWHbkW594BD2VTDvBClnd3CFBd1K
 NxRbIDpOsSmSljkGuZO3oHhF3xrtsDJoQL8CRa1uOz/wyiZLEJES1fcpGHmh2O40HUbn
 FQ9Iay7aPo+SPuZSR/fLTv+letioXXawLq+VywPjdvuNw0jto9RaN5TUXOJaOsEKK/n5
 LWqP9S913xvE31nwe8tweFPnAyzfkMrKuqZgKMTm9sXiKxQALVKmRTRHA5gP7X2NQ+E5
 a/mTYY3jPB8ieDLUx4iLQDaxGu4gVjq7ipRZVRhhuMqrLrEyZS47ckRm0RKk3NCGG+pZ
 WdWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vdC57ddqvGP0W5KwBTBkhOYJWRkgqf1DhL7jKk6+43U=;
 fh=9HNS2v5PSr7pSyM1AFLRpXmarPqWAgMGHZTuL9SQrP8=;
 b=QXM9PHeMCv/qMExqsSJC1+/7tFe9tDu/aabv8fudqfiya9OahLdQZOYgkvbCL7TJHf
 7Yv3F4ZG894ucuKOyRLU6AJmaBHCsA+3VbUpc7MFd3gOzbpjLW71iwiUPnLlImQrZ8lG
 s8DJkhU81wAPu2WoqZ7vJB8zVIZTuc+wOaC/vSTCTKPApVBkc6ZpY+8+r3vXEs44jgas
 74H8ov6g3vKZ57zVLqA2x3wMKwwn+SwuuHiqSeHd/YRavW173UQs5WCa1DzfxiyuM1ah
 XXbVMRCi6yffjt36ethTXHZnyWxtVbomNYygD4y8GFdsx41uCrBtewLrwLfGVD6xYnqB
 Y61A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788674945; x=1789279745; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vdC57ddqvGP0W5KwBTBkhOYJWRkgqf1DhL7jKk6+43U=;
 b=KMrwiUtXBWM7jYecZZfGm2eHwdM9zey7tVw/RvuokZdKgEUpFLn16wlzNOM+b8XAMH
 XqtxLJYUoxa/xlD5tDZgdLG5mGVgGhTJYgQc5ATdhtZ06Z3V+DJWAy/saHIR99pEZnNx
 li0lrvzKXNLkLSTt20yoRLQfmCAfqAGFfk6ao463/qVov83ymRzERqnpN6H7dQTL0RA2
 oeXVPBaO5U1EBAAh8SPYOrr4MLPUuqorFaPppXKUN5gaQ/7P4Oa+h+vWTXrHfpjnueBq
 NI7ofaurWDZShXMR63UWO5sVEwHKICem0KVn56It02+fJWSkquPuzX8/FS5oO9C3TAfU
 DkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788674945; x=1789279745;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vdC57ddqvGP0W5KwBTBkhOYJWRkgqf1DhL7jKk6+43U=;
 b=XB87tL/I0QEKreLsTFhKINUQxvO4ucYXRtVfXjT5J4G0lw4SbMGWm/VTdRbSTs5LBc
 dvlo1/rRLkep+JlcKc0bOLSrCuUjoH66EyLd/M6bgvSHCCwktnDK5rqmLGEvX/laW1dn
 ljtmEWbE91Uf69j27guj2KPG/Q0W3dSqb5PCMB6yXX8TFLGGKp4DmOvicUnOHfYWSzlR
 7bjSI9PSfKtAYtPUNVFWwuCERkajKQo+2xjtztK2wJe5PR4R8JEw4KxYDxZApWytafJp
 fEf1oOu+5BsjDpXN0Lw/yFJ1QRtVcleFw+4JN1a11tfUe/Zb6Se48rLsWT/GkAdYwVyu
 ZT6g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDfA7dzISf0dqtmPcEMGxhKloAKAl+fHvx/iLBADjXe1nsSVSUl7lZwtL+LCdUFpyuUkvy1mjN7mA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nOKFbm9t+3v2SUse+U/+lVw8SKr+Otfu0/EN38BOsR2HScWfWd
 ZIWpBFBb7yL4kxecM1iHgFndf7st9w4ZPfLhVfvzzAtkSbYNai2AfM0R8z0VcCu3mZOV0qi6qRq
 iUlwDdJv3qb6zviqvo99tCRS/uXj/1K0=
X-Gm-Gg: AYBFou23JBa8efGWuVAsgXOra8EZSlZ8B66mjK1o8SlfVPC6ASBPIOHAb5t7YQhtdiG
 1I8CQTBadhCK7jhNAm/+e90Rb4SoQQbZuKfKhmpvP94/zfeNkHNieENtNvGAykuvzSECb0MBe1U
 8ijRxgFVWbia/mLl046UDFy4taGM+2YQBJhYyKqI3s9TEUuPtaI4goRz1vGFYznhQKVeMYSsNKX
 P0b+x+T3Cv4CMoyKQbxGFvlpO79p3F/j3m+IG8rDyKCMYZpmmtIuKSCMdVkMVl1BGkh1sxyNV8z
 pEbR0ioEC3bqOh8cp6tcHVzsXUMIsSeFwKnwMqvMwXaof4hW9Zau2A==
X-Received: by 2002:a05:6820:1787:b0:6b7:8396:f3ce with SMTP id
 006d021491bc7-6b78396f87bmr7383804eaf.48.1788674945534; Sat, 05 Sep 2026
 23:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260901234351.190506-1-anarsoul@gmail.com>
 <CAKTNdwFqSBt4QVCuYJxTyEDsxkW96JbUirFNAgJYWVLHzGpk4A@mail.gmail.com>
 <CA+E=qVcizyQZytw8M6DA72YGrRDDNx_cCvYj565zf9wjMWh8tg@mail.gmail.com>
 <CAKTNdwFQvKtHQA0JD-GAq3bgr5Brq2NyLfccenkHcrKcjeptwg@mail.gmail.com>
In-Reply-To: <CAKTNdwFQvKtHQA0JD-GAq3bgr5Brq2NyLfccenkHcrKcjeptwg@mail.gmail.com>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Sat, 5 Sep 2026 23:08:39 -0700
X-Gm-Features: AcwNN1XV6eaC-hb5tnT2MKyn0nOE60V4HfLSORk_N-jEL_PXVgmbyJgM3d_DMic
Message-ID: <CA+E=qVcwtnU_Gg6_oFmWqMpCEF8vOvB_G+H-ihfbiAr0PpFUJw@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: rockchip: rk3399: add 85.5 MHz rate to PLL rate
 table
To: Alexey Charkov <alchark@flipper.net>
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

On Fri, Sep 4, 2026 at 2:36=E2=80=AFAM Alexey Charkov <alchark@flipper.net>=
 wrote:

> > See arch/arm64/boot/dts/rockchip/rk3399-base.dtsi, hdmi ref clock is
> > wired directly to VPLL, and dw_hdmi-rockchip calls clk_set_rate() with
> > pixel clock for ref clock, see
> > dw_hdmi_rockchip_encoder_atomic_mode_set(). So at least in the rk3399
> > case VPLL is supposed to support the required pixel clock. Without the
> > first patch 1366x768 mode with 85.5MHz pixel clock is just rejected.
>
> I strongly suspect that the dtsi doesn't describe the real clock usage
> here. The TRM for RK3399 doesn't show any "ref" clock for HDMI, and no
> TRM-documented VPLL users look like anything that could connect
> directly to the HDMI controller.

See "1.1.11 HDMI Interface", it explicitly mentions 13.5=E2=80=93600MHz inp=
ut
reference clock

> I believe something is hardcoding the divisor (or leaving it at the
> power-on default) in the actual DCLK of a VOP which the HDMI
> controller uses, instead of modelling it properly as a mux (frac/div)
> feeding off VPLL via another mux - both perfectly representable in the
> clock framework and already envisaged in the clock driver, making the
> PLL table patching unnecessary.
>
> Can you please try re-pointing the "ref" clock at DCLK_VOP0 (or 1,
> depending on which one your HDMI controller uses)? Your clock summary
> already shows that something is assigning its parent to DCLK_VOPx_DIV
> and the latter's parent to PLL_VPLL, so rate changes the current
> driver code does on VPLL propagate to the muxed and divided downstream
> consumer as a side-effect rather than as an actual rate request.

I don't think it is a reasonable ask. Wrong clock for the HDMI encoder
would just result in non-working HDMI output and no feasible way for
me to debug what is wrong.

Regards,
Vasily
