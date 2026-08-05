Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B4BC561E6
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 13:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09AB110EE9B;
	Wed,  5 Aug 2026 13:55:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I4yu93y3";
	dkim-atps=neutral
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com
 [209.85.160.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9804710EE80
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 13:55:40 +0000 (UTC)
Received: by mail-oa1-f41.google.com with SMTP id
 586e51a60fabf-448b89f700fso937853fac.2
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 06:55:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785938140; cv=none;
 d=google.com; s=arc-20260327;
 b=sK4DokkLNpeplH9SFVF9fNdnj5CfLhiv/ZicdTXlduXdwu3r2kJgotfLQ1+kyJyUpO
 prHZEIl3nSiT5NgKTsHddKBEKXhmX73hjMc8AkBXuXV9eBSnKsizUfyAHfb49Ip6+e5S
 I412bF4vk+Wm/LkDPBjUzsOQkFNGZ/E197QNPSw60PFuYUiA0c4k9n98wmjgmda/+W8v
 GWznqryeOsXpGMwouGdVXQz0BvxIGqZ5LyNOwHS+QIQCX7S7AE7BQmJB5ng9PChAC8zH
 jfyhnZ2oI3/jtnBc1SunW6mk3z6AjJy45h4EDGItjPqiIjzClhmjQ65DH/2w/1Cmv5VQ
 AGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0T5/BwMbKCVTLYDKO3fObDhqOfeGegG11SJ0r26Jq64=;
 fh=AJ2AkGJUbe4FQ8EN8Zdt0k+1RX5SBdAIjBvPaMDaEVc=;
 b=GVTmyboYMSFfR1rKf7M+C8o8TRUzeErcY6YgcwrV6NmB+45CfgY6IK/F13T/qH62uu
 BtN+6fq6u2IiNaEnuu3mkMyCe0ItDaZcHvpnAFuwjGRDCh6cOgHSKkWVzhSDorXpyEj5
 Qb4Lr+af4mnpStMx+5LItwZeIjjjnpuk1U+wqAZBxshwQZu2krV+YemAuzAOzkyM0Pno
 f+6iiE41XqD7zKR6RoHKXbXEwqZXRrMwwEcWTHEUQm8BW9aMttFwT+OFUzYPdgXk2V7P
 Qvh56vPH0r2BKvsQy5NIGNjjKNd8Pi46eRi3DGpUeQH/2RqaRNozlr7UCORyNS4pf+fM
 Z1jQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785938140; x=1786542940; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0T5/BwMbKCVTLYDKO3fObDhqOfeGegG11SJ0r26Jq64=;
 b=I4yu93y3/JKLqwoM8ILW8cNJmy4ZEX7zll+x/Kz/lkJtEjmKkFaebMEsrb/JCZzWvx
 PHYus5PW8rdnwZCcbWFuSCxJMGb5aHtY05s+rD7kWRB6S0Cp/zx/09rJ/AkpJYhpc20T
 fi3c43hh/6nqA37uoke5B2i8icfpTpH+H5ofd35Yo5SwKz/zkzcn8GVOUYD3vl99iOIq
 6CRyNNm7G5oNCVEj6dnKT+Jhs/tDaIMKvSo64aEc3Wo/8ba7fvRo6x/rupcblIcTi/kA
 HwLQmWBcwH96+K45wDuWMRu8uwkurprMBC7kvM/VQ386JA3cNBT0ku++MjcKlPcVkadb
 v5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785938140; x=1786542940;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0T5/BwMbKCVTLYDKO3fObDhqOfeGegG11SJ0r26Jq64=;
 b=LhQwGdGKAqHiSQdybczsbvTBDG+diy4Pf75F7q6aY3D1D4MZp4uo6fkd1MNEcqT6mE
 cjAI3jDF0hNAqYVx9KZoYpOtI0JpYh8QS1d1tkIUnTLTb7ii8h3QoNEjS7IhQPvGp7aX
 ZQrJlr+NlM+AohoJ/jTOPHDEonP+bKPPAo3pSeLym2CQ4438CCw4BcBhCQ59xAHKuMQd
 vHxKS2bgEP9bxzqhz+dByDjmFUMNJqZKf9G16wjA9ajgUALdwLmsjti4PeuzgSRlG2Yz
 TnKW67XXTnHh/Dtv4qG/6chlnbRt20fQheYk9gRkLMXWRdvqljy6AbaZBDhiU+AuPTMh
 xXjw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrA0yh1CkGGH5WifMSNHBXcEFwT/3o5Uh1XoYg7/dPQwnTgJ/M2OQlAQBBmPiJ69gTgH0+tkrP1EDE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcNFY9wxKTiO/90WWOaVj+KY7AOldSdWHUqTRCiD0EC5Cl9AlI
 bbDBOzwQBHhSi9kv9XsgjM8Tq+4ylgz0RpUk14zUbEhMkokTXp1XjRm+T9FR0ggAgxGaTnPEgcp
 su3WdSfWnxs6xV1kdm7Qp4x4PuKn0WtA=
X-Gm-Gg: AR+sD13Upyblk5as+leznuWH1DtqFff2ZFHJ2Q7f5KcQCUYrBq5OB+3p9yO2PsvK9yH
 9jgkLA3zjN7i9SFTAh0IGh7A2tzlotiSlRIEQgBnYw7nIGUo/8YUxXfd+sS+Q8C0rW9kM6SGY8s
 FarhEvgbcSjv16is1Fdyc47nURz03bqnBHLI+Q0mOraV/gHodR0/5qDnCnAJG/am62tdsuCX5zN
 GggcU6O+itwdt/3Ac2mpj0wqTwIJ1AumM9+pUnTF3hEWldLONC5EnerHYqDFpaDWodtF/9zO9Lu
 2Etnlk/+I4jTLn00metypuWwUgOxDoG8OuNgsIZ8PjUQ3g==
X-Received: by 2002:a05:6870:c145:b0:448:7ecd:583c with SMTP id
 586e51a60fabf-4599ef66e57mr3421197fac.17.1785938139558; Wed, 05 Aug 2026
 06:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <15b28cafab1b55f3e4cad9bb542847d22e776bda.1785616749.git.nlucasgit@gmail.com>
 <20260803152533.9008-1-royalnet026@gmail.com>
In-Reply-To: <20260803152533.9008-1-royalnet026@gmail.com>
From: Nathan Lucas <nlucasgit@gmail.com>
Date: Wed, 5 Aug 2026 07:55:28 -0600
X-Gm-Features: AUfX_mzExbPGJJsBny-YZnnSr1GCs-6bfdue8MaTV1Rrsd66Jj3Gf72et43uSvY
Message-ID: <CACNCB+=APzutjqirzBCfkt-t5QRMOnr9j3pWT0RxEOkH3mkEug@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/display: fix BT.2020 YCbCr output CSC
 matrices for DCE
To: Igor Paunovic <royalnet026@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com, sunpeng.li@amd.com, 
 siqueira@igalia.com, alexander.deucher@amd.com, joshua@froggi.es, 
 mwen@igalia.com, leorize+oss@disroot.org, alex.hung@amd.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Hi Igor,

Thank you for taking the time to test the patches.  Your RX 580 should hit
the new limited-range matrix in dce_transform.c which I was not able to
directly test.

Thanks again,
Nathan

On Mon, Aug 3, 2026 at 9:25=E2=80=AFAM Igor Paunovic <royalnet026@gmail.com=
> wrote:
>
> Hi Nathan,
>
> I hit exactly this on a DCE 11.2 part, so here is a data point for the
> path you could not test.
>
> Setup: XFX RX 580 8GB (Polaris10, DCE 11.2) as an external GPU on an
> Orange Pi 5 Plus (RK3588, arm64) over PCIe Gen3 x4, driving a Sony 65"
> HDR10 TV at 3840x2160@60 with HDR enabled under KWin/Wayland. The sink
> lists 3840x2160@60 only in its YCbCr 4:2:0 video data block and caps
> TMDS at 300 MHz, so the stream comes out as PIXEL_ENCODING_YCBCR420
> (confirmed in hardware: FMT_CONTROL =3D 0x002a0000, FMT_PIXEL_ENCODING =
=3D 2),
> and with the compositor setting Colorspace=3DBT2020_RGB the output color
> space ends up COLOR_SPACE_2020_YCBCR_LIMITED.
>
> My tree predates 51e6668ab4ba, so global_color_matrix[] had no BT.2020
> row at all. That is worth recording as its own failure mode: with no
> matching entry, dce110_opp_set_csc_default() programs no matrix and
> configure_graphics_mode() leaves OUTPUT_CSC_GRPH_MODE at 0, so the
> output CSC stays bypassed and plain RGB is fed to the 4:2:0 formatter
> while the AVI infoframe declares YCbCr 4:2:0 with BT.2020 colorimetry.
> The sink then applies a BT.2020 YCbCr to RGB matrix to RGB data: luma
> lands on green, Cb/Cr sit near mid scale, and the picture is washed out
> with a heavy green cast. SDR on the same link was fine, since it stays
> on the BT.709 entry.
>
> Applying 51e6668ab4ba plus this series on top of 7.0 fixes it: colors
> are correct on that TV in HDR, across a reboot, with no amdgpu errors in
> the log. As a cross-check, the same desktop on a second monitor driven
> by a completely different pipeline (the SoC's own display controller)
> now matches it.
>
> I also booted 51e6668ab4ba without this series on the same setup and
> could not tell the two apart by eye. That is not a counter-argument to
> the fix, just a note on sensitivity: the compositor maps SDR content to
> around 350 nits, so nothing gets near the top of the PQ range where the
> full-range luma scaling would clip, and the residual difference stays
> below what this TV's processing reveals.
>
> Tested-by: Igor Paunovic <royalnet026@gmail.com>
>
> Thanks,
> Igor
