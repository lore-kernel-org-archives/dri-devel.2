Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2952FC531F7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 16:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 662D310E5BA;
	Thu, 23 Jul 2026 16:07:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="PmCSnxoa";
	dkim-atps=neutral
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77CCD10E5BA
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 16:07:19 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5b2a73da7e1so10908e87.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 09:07:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784822837; cv=none;
 d=google.com; s=arc-20260327;
 b=MK/OilXIkJnwybrRRx73aIQkrCR/kMLwjl9obi487Ac/2FFfv785B5fP3qKELv7UFW
 jr6gZiW3FZhC5cakLDRt3/96eM8m6m/ZpjWktFZ7dNnZx2INJsSt/hLVJLAHh4kcTanR
 sQfpXhB+dzLz3rFascNPNK27hWY+3l8vOCxlIYDlwVYNSTSWDIpOLct1KxHjXqBuGf6l
 1iuvWZ8x9t+frvIX03ARyFXtdU6fd7rkb6t0IrbgeUXrCyUJ4o6dkkTGcEyZHWcLbDM4
 I9SFt3qKDXoOwo/PFxiVOBIKJuTACu1IcbRht8TcrvOrBaj5mocc9OsWJ1ULA3jYX5pk
 Johw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lLj8QIPDjw+wrnYmjqmWidOihzraKtluDpbS+qkgPXU=;
 fh=OXHgIBeGL8aI6di25khw45sreZ9hu/YMw4A9qwm9XW4=;
 b=QRHhOBoHOmfSr9ud0LTV4/lj2I4Otmu4xJpUPUcnPAPzr6z5bHdqmJLkb33gcSaOoy
 ayt/zfTPwv3qloPpjDOkYOL2OxptfTYJbyGJvSF03yIiJwJQsxkT2SGyDvoofkzbWnzo
 DBAUOtSG6c4diO4sEQ8CJ3Iu3zTxVbHSxREWHCT3ngTpKcglTQDZBRNOu0KUanghy699
 rcMjT3icDv2ELwPYtxCXh80Ik2u8uMPtQE8fX1B93ZuWhmYFa4istG7ZceSmkOqMR29z
 iQaXKIfluqaAFs8dSapyAcLUhX/TJ8xTwyOc/1/esY3r+qT7l7SGx8TXAhm575AOsgUq
 Gvwg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1784822837; x=1785427637;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lLj8QIPDjw+wrnYmjqmWidOihzraKtluDpbS+qkgPXU=;
 b=PmCSnxoaVqqJeFY+jTmU4ZfpM7cmbM6tPTA4ijmC3BgAcAPHvUMO5LefRsV79rvuzo
 tVKPEqNuEkSxR0x6kFbpn8v+Lsj+lIGEwrLQSGQqsKImr9jNSRV5E5prLUylTbnPZa5b
 gzkRrdBRBqHgf2VrDsdCDmFj+Ue4i42UzAAWJOXUkwPR4+mpzf23w/5e5M37MGqlbkDX
 rouzKzGCnz/kvBFfWOCuNZDaa4xi0GCcYrPnxgpFrZoGu6MPSpEET8UOvu/0i5tMaqEW
 HemxutNxFCAXHRac0cTH+xQjzYxFCGGUNcfR0ZoewuhNeeChpjFfyvqdZTmBt8/d3eQ8
 25OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784822837; x=1785427637;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lLj8QIPDjw+wrnYmjqmWidOihzraKtluDpbS+qkgPXU=;
 b=IX8awqepOi3YkW21YxaLnMJKwf97MQT+sujN6g2KJm+aq2ibTSuMeFlXuLfACXxgT2
 YCaKy92Wcq0hoBHafdje8+K0VgynJ1B6vP16+c/eV81+d2KRbzyOABeLE/BTNyaB5gKj
 LcZAcvuLWN/4C5eGBZFblIfPO381G05/9vTWSPVNArb8IAgrFSufl/VhmBMD84mSRQur
 5yVGaNRa7B9DJGRbHtR/rcKkDlWgIsgdBgmlNepu8FgHz4WYrsi0R75Xi8wsX9cAys3k
 3N7RE8CDk6DrPkkCHLsM8+mwkjS923ZTCgbdk2v9kTQYSBO0W1tPf5HzB7Jr/Nqwngum
 KruA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrNMKqfh7gp2MABuZX8aup5sTiW/fEoTBAeBTTYVbShzrNYn2AO1WY2XF4omBlRwW1Kw9l0TbCjEmU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YynSOzrKVaKBFeJTPuYwGr2fWg8B+sZTPZDAF/Y6UBnBlZUfXLV
 dqRh4axKa9pBJbyztFbRYyzwvf0Z/dwufer+DbG8jA+a4cF4aK/HxbGqwHm/nOWKczSLTda9oth
 BWz9kWfWNuTS6OeJFnbJ71knHLOgdSJdNz+pal3E=
X-Gm-Gg: AR+sD1073SCdyetWndhg6tvwF57zeN185UPsGoSXw1qAUJhhPaJuvvpO7R5zBRTOg5I
 tEOB6/5EZalVRj3Y8yXZKIqWGUsGzv0SO2i7XeJhu+/p4p8TGv10U0svZqGYhfHudan7pqFFPua
 NvVl/cXf1nvrHEFefMFadDeyKz+y0IQtesBDlPFs6ptfto/ZMQJKPyphYgxUUMXBEn72I6KFugt
 r6AyNzWVWK6gJf9zzznf4Hvump+bsY/FV0Gl/5K5AAh/NbWhEmp+9DexNUoXkBHL5DwxPXWmM8d
 Fnc6H4IomWzNw/E=
X-Received: by 2002:a05:6512:3c8f:b0:5ae:a4e8:47be with SMTP id
 2adb3069b0e04-5b2b2968164mr196065e87.7.1784822836866; Thu, 23 Jul 2026
 09:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260623015459.1153884-1-xuehaohu@google.com>
 <20260722233932.3997681-1-dhu@x6u.co>
 <20260723094625.GE110966@unreal>
In-Reply-To: <20260723094625.GE110966@unreal>
From: David Hu <xuehaohu@google.com>
Date: Thu, 23 Jul 2026 12:07:04 -0400
X-Gm-Features: AUfX_mxZfBk3L4aJdDJNuS21FbP4tt0j-EIQJVeIi7KxTXcs6-s6PmQ53scVb6g
Message-ID: <CAPd9Lg9ZL9VwubYbn350pdUbQnnfc7FwXoPU3nPgvBHWRxLOyA@mail.gmail.com>
Subject: Re: [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk
To: Leon Romanovsky <leon@kernel.org>
Cc: dhu@x6u.co, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, David Laight <david.laight.linux@gmail.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
 Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>, 
 Pranjal Shrivastava <praan@google.com>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, stable@vger.kernel.org, 
 jmoroni@google.com, kpberry@google.com, chriscli@google.com, 
 viursachi@google.com, sashiko-bot <sashiko-bot@kernel.org>
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

On Thu, Jul 23, 2026 at 5:46=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Wed, Jul 22, 2026 at 11:39:32PM +0000, dhu@x6u.co wrote:
> > From: David Hu <xuehaohu@google.com>
> >
> > Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> > This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
[ ... ]
> >
> >  drivers/dma-buf/dma-buf-mapping.c | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
>
> Could you please avoid sending patches as replies? It severely disrupts
> the reading flow when using mutt's threaded view.
>
> Regarding the patch,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
>

Hi Leon,

Understood. In the future, I'll start a new thread for new patch revisions.

Thank you for your review.

Regards,
David
