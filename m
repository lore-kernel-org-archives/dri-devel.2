Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE02CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:02:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D70E10E78E;
	Tue, 13 Oct 2026 11:01:56 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE5DD10E4E2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 11:01:49 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-93e6f83f0bbso263922385a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 04:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791889309; cv=none;
 d=google.com; s=arc-20260327;
 b=omHvjiqLjwx51v6+9VH9jdjw9Vw/LEQHwTN7AaIOQctddaNHuqsg/eYJyTA19qbfCm
 L4F2x+TSGHuJhHbLUGi/+VY/6qYcRw9pvOavCe1/b86Z19Y5p1ZKaGVE+d6YBS1wmvcf
 TlG0BoxmEGPzocbmNk7ODTj5KmmjvH4eRyRhvTfBfNHuTamL4s/dctt5a4LnwUWh2y2e
 0RDk3y1Ml3WqJIr9IRMAkHQt09udPuDyAfPMJM5+VhevKIviBuMU9xK/1tnTUpyMTHYx
 2fBWZiqle+Q2L4BVzyJ6LoetyVR548FBmb/tIjl3+ufcZLCqqG4XLDtw7OcCrfXkeCeq
 VhVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MPeUtAJ7ANM2l/UEvr5JHBbhId2X2NEg+0Hp1CXBhho=;
 fh=UMTxKM5tbO3+L5Gk2bQ3y0Mty7a+wCjJhcJmHUBEU8M=;
 b=MCBoybkIt2z9Lz5XYI+0XoTuvSuiJ959G5k8658ZOPrOU/Yy8bRB3Dd/6v5cBlCsBv
 cVhPCiG+RJKQ7PEMdH5emMZs8p4cCyoTf9VEkGuuk4qWa26eAbcaMJ341HD1VBclRG4y
 L77evqTCyhrSdCqP1EDNY7oT4NxMwcJ3BKMcZkHqr2LTc2pvQWVwwN4xu8I3GjN9cSOc
 K2KJ6ryaO3S3FWiilb8acaPxK9kwtEDVtP3El34cbvIocZ9OOPd5PerXkM59FMA3oBEH
 nqdlbpz3k/jMgYBhITfjR5p49vOD5FWe828dfzvYK3GdXzCOohoAYV11A2+dk2PSucVE
 O5/g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20251104.gappssmtp.com; s=20251104; t=1791889309;
 x=1792494109; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MPeUtAJ7ANM2l/UEvr5JHBbhId2X2NEg+0Hp1CXBhho=;
 b=ME5rG6Zn7/1jzPEIfu8uMmZbTZ3gfSEjx1xTjLGVqLaOPp/xSaonB7k2qa1RGSFeQG
 FeU5uWXfdC6mMDgqsoeIJzOkc9fWCf8iXN23Iy9Xs8dxcMhUHF8z1EDu5Vn1HE0dSs5n
 hFvrR7VgNKk1qH63EFCqPmWAs0NW48KyDF7Fy3t8fUWWNM7yBUtmSBDLaE7zjs0ag8+D
 b7vyOFklAFaWy6SCbqoQTz9zPXazjSZmgXEF3Z60XZkrPMHd3JGoPGPbZoMWyATLFRvz
 4ChT+pHX48se/Mjx00l5pNjcdsfu4H/GOTDZret0UUCmCeQHs/b2BIyYG/3wY7kjuOHt
 rypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791889309; x=1792494109;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MPeUtAJ7ANM2l/UEvr5JHBbhId2X2NEg+0Hp1CXBhho=;
 b=XvvKY01hxHA5O+9n0xeXKxJpN+4s5sZ2eFkY5bPwyvlAxadvSGHO/qCEYEIiREHKGj
 Lo70fYmzxnAV9H81Wxou8nJaOf4/3EXTHKt5ED8Sio9+JeKF4C7AnRwhSmPqGYLxcGt8
 3n2yxkcz7uz5/ifi2/7rGmEdgnzvT45fz0mdGMwkekb1eyVRPRzVwQTnZGigzc9+OKcj
 7oMkzIN4+YetXAws4yHdhWoKPF9hLATuBkZT+XeHX0ivG1s4rAIjIkmOITsYmTYHkYDV
 krgbMp3jYUIQruGE5M5TF4knopM/X2VDimfO1nSfs+i3PuSRUrvCPkkl0ycVnaTKlR4V
 Q7AQ==
X-Gm-Message-State: AFq9FYLj7hcw4abRAfaDzu7GKeksZnGbywvB9T5ALwzW3N8dxOA5yVXh
 Z6OxkXeWoh+ffymaPxj+yFTKuPsbR6i37fHt0zZWufZZfe/3nCWpqBh2q/6n/NYerTzirTrVSwe
 kTLnWs4GxhjKN5OkPrIJk9x19x7CjTWDpCL4YVEZsa558/z0NInIHsOrfuQ==
X-Gm-Gg: AYBFou3pTjB+fLOI+bg9sL+99nox2fXpS4lgflTTM0SF5mmti7uKJWTr6WiCMsIU4sm
 yuFwbvsx1EF730SihDMz5/cByUdUFMFtGVVG5JbzXAfI8Bm8Bte2FnAqI/uGs6FpWHSL89EPDKN
 lOb8oO2gE3nQ9njqaoKGBu8xarshYdGi9CZPHc4Z41wDfVucdR3zOytlJBbTRzzBqIlp0cSNsDh
 H5uXcYOBPB/IuyKgfZQjZzmJauo8vAsxzJ3lwqi1w+veldsFN/9UmKQc3hCtu8HlcZSu348tWw3
 srfvac4B9vBjrXzeVe7GccRcq3VwoQVrQs/hqUY0akKBHdJPehH+QJVEPBZ4trUbEvc=
X-Received: by 2002:a05:620a:44c8:b0:939:fde0:a71b with SMTP id
 af79cd13be357-93ebcd2c13amr1980330085a.0.1791889308687; Tue, 13 Oct 2026
 04:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20261013105757.3924282-1-heiko@sntech.de>
In-Reply-To: <20261013105757.3924282-1-heiko@sntech.de>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Tue, 13 Oct 2026 13:01:37 +0200
X-Gm-Features: AclHuK9_oH3XnfSXQyDadUbvwpWzf0A2Rv_6dw9LGaratIlyZwd6LJpQq2SBH0U
Message-ID: <CAPsqS2TXBdo7Y0eP7J=Y3E-0G3VL0zkh3pgHv=mOHPo39fatBA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as reviewer for the Rocket NPU
 driver
To: Heiko Stuebner <heiko@sntech.de>
Cc: dri-devel@lists.freedesktop.org
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

On Tue, Oct 13, 2026 at 12:58=E2=80=AFPM Heiko Stuebner <heiko@sntech.de> w=
rote:
>
> While I definitly do not feel qualified (yet?) to tackle the changes
> to deeply IP-related parts, I can at least help Tomeu with the more
> basic changes.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Thanks, Heiko,

Reviewed-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

It will be great to have your help here. You certainly know more than
me about how this IP is integrated in the rest of the SoC.

Tomeu

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a08087fb6e67..5fc5eaaebaed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8011,6 +8011,7 @@ F:        include/uapi/drm/ivpu_accel.h
>
>  DRM ACCEL DRIVER FOR ROCKCHIP NPU
>  M:     Tomeu Vizoso <tomeu@tomeuvizoso.net>
> +R:     Heiko Stuebner <heiko@sntech.de>
>  L:     dri-devel@lists.freedesktop.org
>  S:     Supported
>  T:     git https://gitlab.freedesktop.org/drm/misc/kernel.git
> --
> 2.47.3
>
