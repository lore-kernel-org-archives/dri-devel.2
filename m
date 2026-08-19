Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1773C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 09:39:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB9AF10ED88;
	Wed, 19 Aug 2026 09:39:09 +0000 (UTC)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com
 [209.85.217.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 332BF10E123
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 09:39:08 +0000 (UTC)
Received: by mail-vs1-f53.google.com with SMTP id
 ada2fe7eead31-74d55dac06dso266412137.1
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 02:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787132347; x=1787737147;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dIMgKn9ssmwMdJVgg9MfbDylpozJGdyvq0xNOf3CW1Q=;
 b=KyjIolUD2okD8FfeacbCbg4oIawJbVpTRjUvjo0B4JKTJq2JAGNETs4ktV62N6PGVC
 BcpEVv+a/SqW4uku3jrqBIWe//UZV7QLTpTfXoG7ausYLyAotE9a5isj4c94tvXg2qpw
 CS9/DLaV+3PhUlylDbwiBuQ+T2TrjJVYZUmrGH7nOuiquvL0OJFJv+HLf4g9y1ElQbvY
 CNesp2sSfPI8WuLBFrte2+IG9WZi/fXKs++OCt/qswL1yljfEKCVNEb+tICANwOD/O9u
 0MtLJEs1e5pDinYRd0vy2wUx8+o9Ais/BJaKMppow3JXjutvIIqJfwN7nkXsvqokJW0w
 rX6A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKfk2UfAWo85eTqRB+rf5OV0l+Sd9PLugLpJhwsLz6FXQ84mmMAi3JB8jPbzpKJp2w41RNahN8uIk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxUTU6NdSD59Jp9uG+4TF6R88d9JWT0eCgLOoigHjXifYjQEHQz
 kFAgE7NyjPM2eEIM0PyG2/P8CeZW71Xm8G/ytlHgW7e8uj+ASclwMxRjD2qvwI8nkPQ=
X-Gm-Gg: AR+sD127ct6+KxGZwlhBGMitg8lMHxW2QX2sW7tzP+hVk/fMbBcpx0sU7x4DhiRksGG
 InzKVAELtRK4Vy4RVPzoS29K4sBBZkP5T/LLT9yq9/EmGNTsYHmst2mEh3BvPXXR5AgXjkvtYM7
 xxsar0OJqZX7eIpMqD7Qc2RQELjawG9i2ceQP938lfyvP11/IbDov/VHLvSy1PJpWS98xI0eo+F
 KPZmJCTUdoS3OIZb12q2K3Alr7aDVrJrfLP1bF0RLnn7vJKmDjicNIqoJXmGZKqw22vog0Wcz79
 NSKREdtzunaEPeKEzYcUlGDl/BjbSLyiFHNVKxg+Jsk8Qo1rz1rgqYMYLm3NplsoesAjg9qykGc
 sgbt6Ke4xIjyZabqGpqhp5PkDo64QWZ/3MQ3wedDRfO99gSxhf99MLFslX5jQHbQhbif3f1CSef
 cub4QD5SHaRS0XpJrDxBl1E0t3cRxd89QrCwq5nOTnY8jk8qdWTSXWpnn7DPV/o1D2O9aAs31fG
 uqHNm+6HK4BXqoIimUbJmHntA==
X-Received: by 2002:a05:6102:580e:b0:65a:fcea:5a8 with SMTP id
 ada2fe7eead31-777f897c331mr971591137.3.1787132346770; 
 Wed, 19 Aug 2026 02:39:06 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com.
 [209.85.217.53]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-777ddc7edfasm1678554137.12.2026.08.19.02.39.06
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 02:39:06 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id
 ada2fe7eead31-74d55dac06dso266407137.1
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 02:39:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RopoC7x8i2wDGCupKt3z52FC2AUuPDccXbVlpEVnuq0WNWCFl0pmhKWF94k1ZnVcLT1dqy2c/H6tM4=@lists.freedesktop.org
X-Received: by 2002:a67:e04e:0:b0:777:ffe0:a10b with SMTP id
 ada2fe7eead31-777ffe0a6b7mr539021137.4.1787132346344; Wed, 19 Aug 2026
 02:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-2-tzimmermann@suse.de>
In-Reply-To: <20260818125012.468092-2-tzimmermann@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Aug 2026 11:38:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWYVjvGM2pOzWoDq8LUSrkFtzOQwdmosHYQuBLnSn3D-Q@mail.gmail.com>
X-Gm-Features: AcwNN1Uwr-MWNK1wEAyEr8Z9JNVhxk4jrnSNE7dazUpWIvLo30uHHQJP967oerw
Message-ID: <CAMuHMdWYVjvGM2pOzWoDq8LUSrkFtzOQwdmosHYQuBLnSn3D-Q@mail.gmail.com>
Subject: Re: [PATCH 01/12] drm/panic: Allocate QR-code buffers statically
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: jfalempe@redhat.com, javierm@redhat.com, airlied@gmail.com, 
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org, 
 linux-renesas-soc@vger.kernel.org, virtualization@lists.linux.dev, 
 sashiko-reviews@lists.linux.dev
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

Hi Thomas,

On Tue, 18 Aug 2026 at 15:00, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Declare qrbuf1 and qrbuf2 as static arrays so that the module loader
> allocates them for us. Avoids the kmalloc later on. Also allows for
> using sizeof() to get the number of bytes in each array. Access the
> arrays once with memset, so that the physical pages are available on
> a panic.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for your patch!

> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -628,24 +628,23 @@ MODULE_PARM_DESC(panic_qr_version, "maximum version (size) of the QR code");
>  #define WINDOW_BITS 12
>  #define MEM_LEVEL 4
>
> -static char *qrbuf1;
> -static char *qrbuf2;
> +static u8 qrbuf1[QR_BUFFER1_SIZE];
> +static u8 qrbuf2[QR_BUFFER2_SIZE];

I am not a big fan of increasing kernel size like this.
You may run (faster) into boot loader limitations.

>  static struct z_stream_s stream;
>
>  static void __init drm_panic_qr_init(void)
>  {
> -       qrbuf1 = kmalloc(QR_BUFFER1_SIZE, GFP_KERNEL);
> -       qrbuf2 = kmalloc(QR_BUFFER2_SIZE, GFP_KERNEL);
> +       /* best-effort allocation; can be NULL */
>         stream.workspace = kmalloc(zlib_deflate_workspacesize(WINDOW_BITS, MEM_LEVEL),
>                                    GFP_KERNEL);

<ironic>Why not use a static array for this, too?</ironic>

> +
> +       /* touch memory so that pages are there in the case of a panic */
> +       memset(qrbuf1, 0, sizeof(qrbuf1));
> +       memset(qrbuf2, 0, sizeof(qrbuf2));

Please clarify "there"?
In cache? Not all systems have sufficient data cache, so it may be
evicted at any time.
In RAM? AFAIK kernel and module memory is not demand-paged.
In TLB? Like cache, it may be evicted at any time.

So IMHO this is futile.

>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
