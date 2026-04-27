Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87049FF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 17:40:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E277310E878;
	Mon, 27 Apr 2026 17:40:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Bjg+g7Yl";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E06E10E873
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 17:40:22 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4891ad5c074so8155e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 10:40:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777311621; cv=none;
 d=google.com; s=arc-20240605;
 b=UYMOC4gIaJKRXZanRUtZN7F5p9+TmkkTVFEqSaRY7UV9OL6UBeCM/BMphnRWQeGEKv
 OCi8eZY4rZR01UoHvAcy3C0n+Inpauxy4zYTYoYxjjaJsk9ebeOXe2Weaavkwsel7lu3
 eyWn75S4PRLutVH+GuuDJMH/vc8wo7hPXx0yydLXWQqnif6Vq8GLbVCsZKEBL3fu+xxp
 TGNteCXGTB4823ZLmGdL/Tl+Llc9n6rndGh2fal7X2m1QhgzE2Cx+HjVwQ1KIgxfUYt1
 ij+OShfDTm99LUa7Oxe6Jt6YjQV/1TP0nMwdhOn35MMOWHg8rHMKb1f5EL21UboGW4su
 UKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wQPYpl86S/o4OEYS0Pn9HHusXk6T/j3+DCtfMcETKIE=;
 fh=vRIXB6EKm8fHfYF84yj+BDs4hxv5TP2rC3iPIAWjNzw=;
 b=leHGlMqHAWMcAe4WYN0AOYc6SVFvtmSB2rMsQmF7RicX2wR6WjHv/sbTlMGu38Tv7j
 wxRisI9ssywnVpdPIK29qEdUym1RMF0Ren2BKdJpwWVtv9U/y/x5dTTgKB5jcg7Kg3Od
 sOVPJ+3eq9zMnL/1IE/AnreGzC6DN+ZxVTW+fTENOq1kMO2ilYKxbqfNismzAFSsjkes
 TmlPRrjRadfu0eKc4CLrwJ39KB0MJ3xSD29iaE0nid2iJs9vYz/uBTfqJz3NLadk6Sch
 FSQHS0f2xvzHN8L86UemVgraxcfBOAvWskNHesbPjkxX8+hSqHSKL6OG5JT+FTTmlo5J
 DSTw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777311621; x=1777916421;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQPYpl86S/o4OEYS0Pn9HHusXk6T/j3+DCtfMcETKIE=;
 b=Bjg+g7Yl6tBnmyupcS9J4TMF0s52vL6SDaZpJCdXa3e4HKy0JB+qQ02ASiLvddn4lq
 C7JPQ2jVWYKOpthXwSmNNxSTXkAgeEx+VIBqFYBwOh/NVPHracwb3NYbHq5E5/zSmohV
 iYdc+AjxyUwNxCL38s0xk5lKnbZtxhzE01UPQ1cG3o1yn9GwgAXqnQzwgC6jYcE5oy7d
 o/8Dub1Eqd7KTUDVMZ99nntjmqZIW0yFBvKVQt6D2Omx9Zn0hJBr8o7dBLAHHHJg2MtR
 Gmiwn5dWDAYtcF7UziaihkMJsgIADNnUSSbEaR2RAZzcVT10BX2OJlE0vI8qx1suDpmO
 2JNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777311621; x=1777916421;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wQPYpl86S/o4OEYS0Pn9HHusXk6T/j3+DCtfMcETKIE=;
 b=nAEjPv+Kp8/gPhxIlxCapyWgxYOOMzUWn41V6wAYs2tgOSi1pRf8QRajtIWEnEEsgp
 5n8jlJ2rDNJpGwn0XXnbOSwGJwfwRrVWS6bIlb24hY6gh8K1Q7Q50WzHxhozcem7jT23
 2egB4ixKJ+KkELcibnjoDaiVlHOtZ6rWvWZ0b1q9oR4ZsOJ3K41YWdxKcbKycqeACKHV
 zKKb9wAid1PLvTLjcJZ7kMQ9vGdtbkmRti3H0mhB1CED00eCbN10CmlSaqK0geLeRHYf
 X0gwWieBj9bkdCMpW2UkHpAHyhwrN2Ec9e1/xQlKN/a4FNIOJQ6i+nQ4GEttceiZowbh
 oYNQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7VlhGBYL5ETeGmTC5YoE5+xTKyzJgE0XMFTOanl6zgVHWQKRIrG+Ewzr3ouWu20UGnBZ936aGm7o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRFDnHGGXDQKPSGk+RAPh65zyA+nyukMX5UVJzZ1nnFAHMYwoF
 SU2Bf2lFPdqt7QVXgl5YkDFAoNtqMiP3nL4GKDeErzJOLmS8AFADayi3JgFCkxmf784xT2x32qc
 hmH8RE6GYapsH3SPzqa8YsNHAChgNoY341f8x4i/x
X-Gm-Gg: AeBDieuPb9WA0eFYFy7p7+7SefI/bh/X/qjADOQVFMuCAbjEkvDhPUyQoFHdVXB5mmN
 tz5wsAT8jE/I8fyFKBVT9/yz3v7NwccuT+t1TnLsDefKxsRMFzQo9JAk5LX267CIXvy1rur2Bgj
 MfnCKcJeu8+YSe4M78/oe50VisKgYSS4S6PbI2yOnCcaAJ0LisSj7uEajAB3BRQOHxl8Wa5kFoh
 AMG+u2tbEDY15Y3ZuK1If6/L7AHhoBWu5lMzssj6E14sviA2ztuuaq+ER94W+9ezzCTZx4tvnLX
 KHRmZOkV3ajkptGZKXNVAmoy6COzdvcLJ3n3CTDH6XFiTcJl4xWdFBdSk5o=
X-Received: by 2002:a05:600c:1e1c:b0:485:1a54:9407 with SMTP id
 5b1f17b1804b1-48a774024fbmr86295e9.0.1777311620577; Mon, 27 Apr 2026 10:40:20
 -0700 (PDT)
MIME-Version: 1.0
References: <20260427172519.417333-3-thorsten.blum@linux.dev>
In-Reply-To: <20260427172519.417333-3-thorsten.blum@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 27 Apr 2026 10:40:07 -0700
X-Gm-Features: AVHnY4KrC_-8s-6jQ3WU3OwQLdanE1VG9VKiglfUxWDdXiiJUp5ur2yhP2MZCrM
Message-ID: <CABdmKX1xp1=_EnicNGj1ZOp0dvma-YevvZk1_3V5FZ8ucUK32A@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: heaps: use max3() in dma_heap_ioctl
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
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

On Mon, Apr 27, 2026 at 10:26=E2=80=AFAM Thorsten Blum <thorsten.blum@linux=
.dev> wrote:
>
> Replace two nested max() calls with a single max3() in dma_heap_ioctl().
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/dma-buf/dma-heap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index ac5f8685a649..52eec2ebb2e8 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -153,7 +153,7 @@ static long dma_heap_ioctl(struct file *file, unsigne=
d int ucmd,
>                 in_size =3D 0;
>         if ((ucmd & kcmd & IOC_OUT) =3D=3D 0)
>                 out_size =3D 0;
> -       ksize =3D max(max(in_size, out_size), drv_size);
> +       ksize =3D max3(in_size, out_size, drv_size);

Hi,

Could you add #include <linux/minmax.h> as well? It's currently missing.

With that: Reviewed-by: T.J.Mercier <tjmercier@google.com>

Thanks,
T.J.
