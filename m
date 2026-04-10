Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2845F44873
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 14:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE0410E960;
	Fri, 10 Apr 2026 14:07:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XkpjP0vx";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FE1910E960
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 14:07:12 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-b982b0889d8so286851466b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 07:07:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775830031; cv=none;
 d=google.com; s=arc-20240605;
 b=QIhetYpr41AKlsvyc4rCBLLuCoZPuDXB8U1Sqjs8s6femcAe6DqAL5Qw1z711LM3Fp
 5zOi+SZTf83OML4xfUwdzkqtw/PrzGOvuePfs2m3I76VtMAM1IfOzStzpYuj0baCUfL4
 UVN8l83Gp8Cob45T6zHRIuSpc1WQa5pCyC+SLhlr26u+HO1e+DOlxJuElgEgj0xv09yF
 pY418dzFaTBwD1dUx0BcPZcXsB//p1c9a59RSU39IVKCodDt06M0VJrq9F2GMg2t9rEj
 8CXYkTw8lP79YRU9NzB8F2e0gkeUmJ5q+qMr+5ZkVQNd4FgzsUbW/UKSAcudBe6slelI
 R0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=J7QztuYj2+YPxHFsqeBj8RkIsj0A+J82n8lSDLxBNak=;
 fh=zHnxozcO+C4oB/rNCyVq+YR11wbihlyp0dXNTaOup3k=;
 b=ky2NGRImSACPNDuXh5oN7bFYRykI7hNYsYQacGZSyf1JHlBQZx35XJNI7+OfZGVqph
 3NGFr74Z5Mwg3u2W/hd6AbIS+5aYAlkwCvBPPVIEc7h6qVO951ZvK+j5pCRNzu+s4x8U
 sWlpRzWiERifdZABIs1dwe7A5my2cDGZ1W6lZ9TTEPWqmL4F+CKN2wXgm2OQUq2K1a/R
 6gyXsJDCyCii11HOH6AMJoBmKaY6pROjMnb64lJeNOX4MH+1PBXJh31mxxMFv1tuqy2t
 0DAO1mqQIBSAV4pw/1uUnL1oo2KUhf5ae0kz4usJaiSmhoCctCVKEKUe9qAArO709bI3
 YHaA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775830031; x=1776434831; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7QztuYj2+YPxHFsqeBj8RkIsj0A+J82n8lSDLxBNak=;
 b=XkpjP0vxKiyxyC5Msi0tU4NsPHIyT1TiUpGE6FsB4+Trs93bTP3sDIO9yFNsKmZjuL
 o2fMASbCLuTjCmg0FiKUQzfu7ygjuSkjZjEuT/1g5Zhe3A3JTXbZUjDEPsL1swdl0kYQ
 6P3QLjZxdmz1TwNUkDvJNu0cSRTw5NmavxwCP2xgaNOhxuJwFXMqk0JG/0x//zE3e4SI
 1su2IW0AIUWi6/2BFpSqyNXzdObK1FW3QQwbf0RhO/nltD9LRv3ubH5GhCG6UJl+6AC1
 XIw7DTyLZrd3xatCVG2WWRXMQutf7uKe4xSrPYDp1qSLJ6+xD/BzI7ORDgm+18ZdD/+j
 zHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775830031; x=1776434831;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J7QztuYj2+YPxHFsqeBj8RkIsj0A+J82n8lSDLxBNak=;
 b=KByv8eRccQYseHOTev27auYttjLclotitG0RB/1Fq89SNOIIu1YzPsGmN3igjLYJQk
 9OcLh0+7x+6YM3gWNHZyDg5pSJpD8FkSQZRw69PFck0vUXEB2mMZ2njN7yt7g6LS97BJ
 GOJtoMjX1yBKcgWHreVkkxLLR5wck8YdjrGvkDe1H7r2ix2zZAy2TbGZJ4MniOlNbwRJ
 xf42YWSN54QUMCV9v5iUaq7gwyRO8E7rsV8IBbnqT8o/5tGmnn/7bk5Zl/M4eI92+xSS
 D9mKlG66ku7WGzXdCrGzG+qNRDljXdcFi3VaiPw2h1oi8MQi7lCLlgTHxF/kokLJZrfg
 Dgcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHu5twow7Iki88DYbjOMTY00aXBHhPsVXwhoyAMd6kRHCkDMncLR8vTwRzwYsGgfPGmdPvSdeHOM4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwA/dKOQNbeUkQDtjgXs9Abnic4NrM+Pt2GycO2nQvUFwBx3Uek
 t4J01zkVQBB5WUsUGZ6DblMrVtTCLK+3KGLPOavnFRHZ4ui4xyht6nHJuhxnPh1mz1VZ2iMhbRp
 1isJ7GQ6RnJoRea+LfhZFngK5yxd8bz/ImHi97tA55g==
X-Gm-Gg: AeBDietFBTVe+4ytcQsCWcRM65Z1ZaKyYaiSU1lhyxJ5ETbR1lxJ8lKmTGvFlJanCGl
 XL371z6N6sb95rx8I65YbNvmW0qEoExsS3oSuPxReFVLXclRRN0I5UuvAcnR3/APHIzxbTKTU6p
 Pe1l3+uTWp0YctsPyVfLc2AjG6/osnY8N5KUbFn7uxlU06THkzWvG2W6JMVw+a6CXVDwXTkwufT
 kaMoZn56Lll6NO3q32etfR2m8Bs1dxp99SZG4a7JrG8Vk5Fc/j7n4KZ1V5Y5ap0gh1RzYwAa5ch
 pjreASp2oYIfxwv96+uV4PeZyrzydOUV/WwRFFo=
X-Received: by 2002:a17:907:26ce:b0:b9b:7f2d:923d with SMTP id
 a640c23a62f3a-b9d72661536mr207795366b.27.1775830030380; Fri, 10 Apr 2026
 07:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260410123703.937822-1-sumit.semwal@linaro.org>
 <c427afeb-15eb-4a46-aa6c-fe24631d24ae@amd.com>
In-Reply-To: <c427afeb-15eb-4a46-aa6c-fe24631d24ae@amd.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Fri, 10 Apr 2026 19:36:59 +0530
X-Gm-Features: AQROBzDTpEfzR4ryK5YAY1RA4qEovpocT3VJx89MYLkdYmV0Mtz-BnQUmSjc1y0
Message-ID: <CAO_48GHyBz-CEap=icQDKqVsBgCy+DNazd6ANzf0NucE5yc1cg@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: fix htmldocs error for dma_buf_attach_revocable
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: leon@kernel.org, broonie@kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-next@vger.kernel.org
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

On Fri, 10 Apr 2026 at 18:14, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> On 4/10/26 14:37, Sumit Semwal wrote:
> > linux-next testing showed this htmldoc error due to a missing extra
> > line in the comments; add it.
> >
> > Fixes: be6d4c9e9d714 ("dma-buf: Add dma_buf_attach_revocable()")
> > Reported-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Thank you; pushed to drm-misc-next-fixes!

Best,
Sumit
>
> > ---
> >  drivers/dma-buf/dma-buf.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index a202a308c079..532c3f14bf9d 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -1353,6 +1353,7 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_attach_revocable, "D=
MA_BUF");
> >   * Upon return importers may continue to access the DMA-buf memory. Th=
e caller
> >   * must do two additional waits to ensure that the memory is no longer=
 being
> >   * accessed:
> > + *
> >   *  1) Until dma_resv_wait_timeout() retires fences the importer is al=
lowed to
> >   *     fully access the memory.
> >   *  2) Until the importer calls unmap it is allowed to speculatively
>
