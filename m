Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A85CD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:48:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F49010E077;
	Fri, 19 Jun 2026 11:48:41 +0000 (UTC)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com
 [209.85.221.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C472E10E077
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 11:48:39 +0000 (UTC)
Received: by mail-vk1-f178.google.com with SMTP id
 71dfb90a1353d-5bbc6c99b5cso601100e0c.1
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 04:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781869719; x=1782474519;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ItJpWj1GNu2tcZXuQZG+sYbJ7oV+gLF69bBweX98kac=;
 b=PvsqCdWAqBKCgCry4FzFT2CFuc27emE3sK4GczYCuSAUx+kvbmtRg2R9Ypf5/0A9KB
 gEiYdkUuwhhLFBh+LyGGQurb5kg8r60l2zyRxNaA5aaNjdQbzoJ+dReMt5YTXIID1DHX
 zIc9gYPOMPWpIWBM6XL8+HGskAE7yXZg5YHATcVHbUJ4d+gElQLUoeRUxBv6YF+HASvM
 EcHxQTy0WhkekJbwyHP5p1wh1IFvx/8WNdJfoYxThVkEY7uuFx8kBjRghIPCOIMQRkfj
 PhSaCBMFx2sPx5mU8Xi9PGDW6EX06JQVgu/dBN3mtn4BxT3sojfMwZvvMvAdq+KcAXax
 pyJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9OExjato9bFGytR5A5DgXjpGlxBJYIie7cwsGcxwrNdT/FEQF6b6bMvdgXowhU/3M+0hUVCmI4BYw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTA5jyC937EJSiI8CPEHzpR12X1qrf+3RFiZjxNw63Pp1p+yoM
 SQRAb97xaSykTHCGSx+M7A8ln57xM9noc2+d1JEQZJUVIGYZIXXZpKliyRZe6lml7Ng=
X-Gm-Gg: AfdE7ckUiB8sRaSsyx1fkjiROkGPDQhWKvFq3A0d4JhgR5FQIUYEh1dY5/64nXFy1fG
 k0pHJFkW1lwDNHytywvhrdvzZ6Qns6QPtAkl0DNWM//faCjkRCFTE477vh0y9oG/1PRTwUnMDNI
 u2UR5hbvDvTy4sHBS7IvDbbwKYySxTDm/xefZ5rrznMTe4HCgwCjA/rrvvCXLyZJEhuHUqUSt94
 DE+tTP2in0yVTrTj4ybhhe/zTXLvps7h6YCcpXYz75JhwTr9qOWeHp1yz6bsnQZ2gyNELpv7u6p
 A6Fyez2wPnmyRFfc5VTFMkaQnG0USJqyWvUSfYWTwEVt4OUIHuJLLN/esyDMHqv0iVQYB0O+z0B
 bFoMsaLTv1PGhlJbaC0XXZ7RQYIZJIM5UHCqCX9rC/zq3wSNhHyDrc7kaPW5SAgAQUu+fZiYM8d
 2vO3QOTnxXV99A9bdlsnUkJlyqldEClW1fKOAeKO8mVZy0JuZBpA==
X-Received: by 2002:a05:6122:458b:b0:575:29ef:7e13 with SMTP id
 71dfb90a1353d-5bbebb1052bmr1157598e0c.3.1781869718479; 
 Fri, 19 Jun 2026 04:48:38 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com.
 [209.85.217.53]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bbea366eeasm1652607e0c.11.2026.06.19.04.48.37
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2026 04:48:37 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id
 ada2fe7eead31-729d8f9238dso356235137.0
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 04:48:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9hX5x6+XJMjNCAk/jzPt2tQHi9O36XMGIR8wyXLhERL0BMb+vPxmcyLg6tkLNFc/ygfpiNLrdjBSY=@lists.freedesktop.org
X-Received: by 2002:a05:6102:448b:b0:650:aa33:5dd7 with SMTP id
 ada2fe7eead31-72a01884599mr2039005137.2.1781869717237; Fri, 19 Jun 2026
 04:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <16fb40ded203d1e2b72f4eeecad3fd0c0d23ad6f.1781863296.git.geert@linux-m68k.org>
 <9503e60a-5e8a-40f3-b5cf-1d8d0f71c9a5@amd.com>
In-Reply-To: <9503e60a-5e8a-40f3-b5cf-1d8d0f71c9a5@amd.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 19 Jun 2026 13:48:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWoR6UNBC-hsi1V=vwx+9AWzRw9bT_OR0AO2L87nCnn1A@mail.gmail.com>
X-Gm-Features: AVVi8CdQDwS6tzm65LzLlS49GN4M-NumImqTWT8BmI9blTIGfCV8oYLJQhKk5Ak
Message-ID: <CAMuHMdWoR6UNBC-hsi1V=vwx+9AWzRw9bT_OR0AO2L87nCnn1A@mail.gmail.com>
Subject: Re: [PATCH] base: Remove unused DMA_FENCE_TRACE Kconfig symbol
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 driver-core@lists.linux.dev, 
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

Hi Christian,

On Fri, 19 Jun 2026 at 12:39, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
> On 6/19/26 12:03, Geert Uytterhoeven wrote:
> > Commit d72277b6c37db66b ("dma-buf: nuke DMA_FENCE_TRACE macros v2") in
> > v5.16 removed all users of DMA_FENCE_TRACE on the premise that the
> > Kconfig symbol did not exist.  Apparently one failed to notice the
> > symbol did exist since almost five years before: it was renamed from
> > FENCE_TRACE to DMA_FENCE_TRACE in commit f54d1867005c3323 ("dma-buf:
> > Rename struct fence to dma_fence") in v4.10.
> >
> > Time passed by, so remove the Kconfig symbol, as no one seems to have
> > missed the functionality.
>
> Yeah that functionality should be fully covered by trace points.
>
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Thanks!

> Do you have commit right to drm-misc-next to push this?

No, I have not.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
