Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D089606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nYZ9omEw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2EA410F2F0;
	Tue, 20 Oct 2026 07:36:31 +0000 (UTC)
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C88F10E4DF
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 07:52:10 +0000 (UTC)
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-679aeeddc6bso1832747d50.2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 00:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792396329; cv=none;
 d=google.com; s=arc-20260327;
 b=a9oKPs/3blJvrvNAfyjevA9l1iQ3LeibKtWsCZZiKvSf0JfkoG3qWopAx/wFDNXbEE
 zH+WHDb206V3PWsYNX3CFB4SkhMsV2FZGA/KmpNQGvC55q0hvWi3Bh8PLZD8Hd42ymQb
 ATGnO19OtfmUczdw7H2rk+akx45UOKxUBDVYt++iYgQ6MVb8S1wCrvdekSY9d7eyngXV
 XLrc1eF8XXWLsnDlHHVAGFrKB0bTvouTYVmyCe7x6ncjSOYl2YOrs5VHHv2yqiyO/e+L
 lK3JsMuiRj2cgEPR0sdReCoj73D+fS/4TpqjBfsWDl24HDQrx4WrybaIDnpxZaFsjHzB
 dHQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6Hu/C8DuVAfrXVfEdGESTNZFy9FgHIiZtc7UqY19xf0=;
 fh=CNAOfNkfykerjy2ojd6LpOvNi+ay06SM37f2gxLjOow=;
 b=j1mhacKeqxWAbpHKYShy/DZa8/u+5+Qx9/gX0rOCTEWXr4WIObwsibyskUP5Fln5sS
 4UF6m1cPayptLKpGGKdMKX5xyRN/3clncn6yNlhwhE8AVzbATYgaKhmYYdEJkOry6JNR
 ajqw9BK8tyu0pNARHjnISvvZxjjkBbNExh9hag6Wtl5c1gY1GtnmKSUGc8lMaXT89jLL
 8N7HMcwsQhpUWNLlRPu2KtMDjVj7iFvC442x1a1Ny6bp7I4XExuFQRG2XLtBcIuXkQrW
 HW1GJYvx9fuTmSB1gxgDgB7T5tmAPEXWiDNdn9idWF1+suzCLbAi/4nND7Xy80bQBu0G
 NHHA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792396329; x=1793001129; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6Hu/C8DuVAfrXVfEdGESTNZFy9FgHIiZtc7UqY19xf0=;
 b=nYZ9omEwRVzBdXCipqmNtrwhfz7YvrKZpO5AWNML6+fdyOdOxLXsIwUyQ3wT/mmVhj
 XAIu+WHRhKESwDgBpRvyW2Nlo1o8/BGESpR8wTY8bgTKS+bhUrhuKO/dlogom0CMeFY0
 KqlPCtE3xyHGgct4c0acI3PG+oFeELq9eFK8jPlk/X/grgkCuibmaorvw5nxN+Dx4Pyn
 co9gEhs583fIGdOHZp7xAfN03En2hVnyJzZ223BFe59FmW/b/vu6SUMPXznSoV1d+zrj
 tAENZi8HTeQh/2WJow3xWvoPMzmfeGLcEKDfyLacYKlUGyOSiBxc0f++Fg5QDCGh8CYA
 5Mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792396329; x=1793001129;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6Hu/C8DuVAfrXVfEdGESTNZFy9FgHIiZtc7UqY19xf0=;
 b=VgKYhojVZktAb6ZA99OKmOT1PSECUKSkD1VLvmGDlo0GXjnfxCpUuMAWl2LqZhaFVO
 M1CdBpXpRGFelhKTxyz/p8VHshstCvhuvcuxQFpZtZ6TTy0NCuRUvc+KDd9pgCIisRnq
 9mNsffnPfjIB3WevHzr4gY37/35L69Cf3b2k0MikXf3NiqP6Ee55O/yh1ThBYQ1cYPvE
 KY28tvzQ/G5ZFeyo8btu3eNDz2Kxr0SQsn0/pulu3kgKnVWMk7k6e9jsBOO6foHIA3Gr
 5wfwyEQJO0vPjAybPr4P0DVhk+69ssVqsUaKmhCtyHRCEiqY9ADOEZnKU5tVc8Mq1A+Z
 xr7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBycP8pbfkx/iiZeyKzlTlbKcPnk/KOKImp+28QmaXgx8JXjp3S/aCuWVZ1pwpEwQEyAvoiAWjYmnpI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJB/D3/3eXX5CwpZJxvbLiZ+hzytlKMYi1zAP6Hw4HU3+l7qsqt
 WtubC95jj+QnCWBgFzxiDBh8UfSd+jMHyTtlVAne18d60tqZz5Y376ViFOB5WWbrt8r3hoKmkrC
 d9vYljnOFepb+U+4nIFrkCJtraLiDaBQ=
X-Gm-Gg: AYBFou0z+GKPA9bI3EucO7XvCLOpaONFS/owbj/kbpfu+wRPDAl6AVhejAinc8B+j+r
 XQmhk9/ff9ojtUpG/0fl0D8R4u2ae0/RrcUM+FPU902kNHF/2vDLzKN7VBBLnc1MgwUBO9FN6De
 DliFBAw6G9Y51QggMx/zTYw/IfmTu9iZpJJG7DP09G4hbLTNcs0Wq+hcJqwHUScAxVnA8ZFJZ/V
 FzjWpSbJfojTxc/29GVK+NfZ3iO5gSBe5bkU4vSo/FGFdWhT/2qX7XSw2Sw5wpP28w4/H+j8MDi
 5uH0yRmiZ2Dx5OMmeoAPwrRorTUfFrcuvSuCaAMqDI2wRRl/v+D9gJJ+70ospYcUf5w2PaK80cH
 HN1zKddJTT3xb2r0QMWXC1FmAc5MIWXRL4L0+mFuR1pphbqx1RDNdUb9qwyNv71GizTRxY/wvfC
 jJTTuhcg==
X-Received: by 2002:a05:690e:12c4:b0:677:cccf:445f with SMTP id
 956f58d0204a3-679ca7ca9e3mr2034762d50.46.1792396328411; Mon, 19 Oct 2026
 00:52:08 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261016162912.64581-1-lukapanio@gmail.com>
 <20261016162912.64581-2-lukapanio@gmail.com>
 <20261019-yak-of-subtle-protection-8ed0da@quoll>
In-Reply-To: <20261019-yak-of-subtle-protection-8ed0da@quoll>
From: Luka Panio <lukapanio@gmail.com>
Date: Mon, 19 Oct 2026 09:51:57 +0200
X-Gm-Features: AclHuK_A1TQjZsCV3MVlGkJ8tdfOzXTmuHWmMEHG7bKSsC6HnztuOLMJSgs52SY
Message-ID: <CACi=Ov5C9xuFvaYTcPapc=DzCFqrKng-V53voFHGWptvvs8c1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: leds: backlight: Add Awinic AW99703
 backlight
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, pavel@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, deller@gmx.de, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Krzysztof,

On Mon, Oct 19, 2026 at 9:02=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Fri, Oct 16, 2026 at 06:29:11PM +0200, Luka Panio wrote:
> > +  awinic,iled-max-microamp:
> > +    description:
> > +      Full-scale current of each LED string, reached at the maximum
> > +      brightness code (and 100% PWM duty cycle if PWM dimming is used)=
.
> > +    minimum: 4800
> > +    maximum: 29600
> > +    multipleOf: 800
> > +    default: 20000
> > +
> > +  awinic,ramp-on-time-us:
> > +    description: Current sink ramp-up time when leaving standby.
> > +    enum: [512, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000,
> > +           256000, 512000, 1024000, 2048000, 4096000, 8192000, 1638400=
0]
> > +    default: 8000
> > +
> > +  awinic,ramp-off-time-us:
> > +    description: Current sink ramp-down time when entering standby.
> > +    enum: [512, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000,
> > +           256000, 512000, 1024000, 2048000, 4096000, 8192000, 1638400=
0]
> > +    default: 8000
> > +
> > +  awinic,pwm-trans-time-ms:
> > +    description:
> > +      Transition time between brightness levels set by the PWM input,
> > +      for a change over the full duty cycle range.
> > +    enum: [2, 4, 8, 16, 32, 64, 128, 256]
> > +    default: 2
>
> Feels like you are re-implementing triggers. Several properties actually
> feel duplicating standard LED ones.
>
Thanks for the review. Agreed, the ramp/transition timings and the
mapping mode are not really hardware descriptions. In v2
I'll drop them and leave the chip defaults, and switch to the standard
led-sources and led-max-microamp properties instead of
awinic,led-strings and awinic,iled-max-microamp.

> > +
> > +  awinic,i2c-trans-time-ms:
> > +    description:
> > +      Fixed transition time between brightness levels set over I2C,
> > +      independent of the size of the change. When absent the brightnes=
s
> > +      ramps with a fixed slope of 1 us per brightness code instead.
> > +    enum: [128, 192, 256, 320, 384, 448, 512, 576, 640, 768, 1024, 128=
0,
> > +           1536, 2560, 4096]
>
> Best regards,
> Krzysztof
>
Thanks,
Luka
