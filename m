Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14E3CD98C5
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D0010E4AA;
	Tue,  9 Jun 2026 16:20:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="XZxNwlQT";
	dkim-atps=neutral
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39DAC10E508
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 16:20:09 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5aa62bd04fbso31131e87.0
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 09:20:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781022007; cv=none;
 d=google.com; s=arc-20240605;
 b=Sh/cDucNAdesUcAkcHstpzBuygeTG2Xs/bgDGcFQXnDLIda+L6tkhpVyt9zCBELOIA
 7/MRppgdDNiSvRBwMJQHj6T3ohkR2So6gDJcs1EzIyNfR1N7/b2ukEhOz7MjYWTKBYc8
 V+tolLPWQI/HJoGO1NMCHgcG+GfLwLn6Coa2RpGvJNXs9xKUU5GUq1qAtM77PSwNiOf8
 ERWDHqDFI+KybG5EcxeCpOEvtcSYEvo1rPQDDSeip/vqG0HHB42UucpLXoFKz8DbbXSg
 +SIYhGdIEeEDdX8KIJJVQfXPQCPV0VrmQMjgAJwcI5Smz6Kq6IBemj4AaIPkrb6OSDwS
 Lfcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pFgomi7XLhEYHICeogk3tk52w0iSafmEFBcU9HzZqyE=;
 fh=G/a0ZtEg+wdHfMdY5b+rgWbP0WHf5N9bT8PPqGaELJs=;
 b=EPsA8utn4Cl+eIl35BmINICgXbfYMyxgpOusdWBu8LPYYprjkdFBA+C6mSgHmzGiyb
 z07YNO0KDAbdsdxup+dXQW98sbe7Ig7wb6mC2DsQYCCdk3TNCJ1aIGwjS07O8OIRBvn+
 d+LnTwVwMzLbmQMSg741OVKVfMNWKZ7aWTDhrjOpUwtM788UOsZfrkGufumW4FzPqMQL
 P0lmq8PBXls0veT7I082tpXThtuhW3brrKanZtW4xzLT6fTZf2ugK/Jf9aQi9ygt/XEX
 i/ukDrRSZ9LLM7Qto4eY2H9839NME2wgAr5BW3NjGbdadZ/FOjJbyUkHxycyzbM7sJqs
 FhEA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781022007; x=1781626807;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pFgomi7XLhEYHICeogk3tk52w0iSafmEFBcU9HzZqyE=;
 b=XZxNwlQT817VcsBToWQ/qOOHbKaMJ4GhW+DDkEwHD0IFmL5RF886JjSLisnCHPoX+c
 Cqtidh0SHH7B9UHeagdDCCDSaLcOYVa37iSUyYizlxZ6ojRLiIY8cBWdfRKdB8ZH8im2
 1swDxExUXt7QpuSO+gQ7pcYzSXg3v7FI49UA5OTMgegMi5wVOLrXXnmNkvk46uzxQGaD
 PEBp5Pc3Qf3bfAqfVGCozR5gwD8x18jdA68gCiLtZcsL8xnaoy1D0X+4JWiw0Ls8sxaW
 w8c1DpZN6v7ahHEFwiqHPgZe1iEv48NvlkD92YP3eNZnqmZQ8g1X71TIhu14Rt16jwyy
 OQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781022007; x=1781626807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pFgomi7XLhEYHICeogk3tk52w0iSafmEFBcU9HzZqyE=;
 b=PHvGnTR9TT2tJVyol0rH7QN4bvewW03T9YJ2AmYa86V40LHHCo9/q4w3Zvd4H8/8Ry
 0ZbtPCWPf/Hx6gb73VeeUTV1Gck27arrHXQ8DQzANKv0vlP22xuG2nfAbttbZevpf2gy
 4vopq9bDOoVJj5VaGFzKd+AKuiWzYhJpvXW1vENzSx6mZeOYXizb5udCTEdvr8h1uHk4
 zSrGEA6My3BHgCdOe/J54/T+4IaPcuGTNnXmmzHuSKVhEKpllZiVBBPgiI6AHb81f7n6
 ariB+97l3U2QKdUZxEJeuFiEGqWUJXfO5tollb0ln9rNNROf6N2+lUQgyZBfjoKYNJUQ
 hUmQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+PnAGtjw1yKZrwP1yZf8ahrnayilDTYge5m+3s7BL0wB5G60NAwTfg2ouNRtFQdpNIZvLFy/ku5zc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxT6pI8eMObQaGCni6X6cQtAfC2tIZfEjHwwrNH6JOh8OFrO8eX
 n97O9A9yHuli6Jj6f22pIeo0dp81qoRWk2XzsVGL8ZNmA7bZZTYw8gSiZjAqtS7wR+YNbnc4M3A
 FwgfHr+URYQMsTEjw1lId2Iod/F8mPcfjKrCas/cKUYUwfcF8Qj0LyerorhfL
X-Gm-Gg: Acq92OFBoEkVsFr4oshDvhrX/DKV8i8XNE7ibWb3AzcfCTgxYO8Osfem4Tf039SCE/l
 WMXErOCjHPioFRtUGfNwrEmQ1b6kvbfb6jJ7VxEuxmODPi5QzBtDLzQgpZfkPD0c3R9iZbsR9PG
 tk8Q9hUzmLROHD0D6AJzojaMctNbZHPH8wlijkWOAuMGHY1A7c+TquIPgMD5iu45HvIa7znigPC
 w7hllCPRlCr33R6o6P6ClZcw9dISZgnFCpT+pow0cPYCKD2BPfgUa7UX4lpKHwdg3lTmXZorirl
 +cBpSG3UYBvaaCmdxH+A+1Q7BLJgjsSF8YNVBuSQBfst9GbAa07cDM8sWw==
X-Received: by 2002:a05:6512:33ce:b0:5aa:883f:5da6 with SMTP id
 2adb3069b0e04-5aa8864f3c8mr624107e87.13.1781022006976; Tue, 09 Jun 2026
 09:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260608194321.150838-1-xuehaohu@google.com>
 <20260609072234.GB327369@unreal>
In-Reply-To: <20260609072234.GB327369@unreal>
From: David Hu <xuehaohu@google.com>
Date: Tue, 9 Jun 2026 12:19:54 -0400
X-Gm-Features: AVVi8CfbRleRRxp7xUhMkzyUOKJRPcnke7OqLp1gc287gSv21XbS3wDiRLvDI1I
Message-ID: <CAPd9Lg8OtW+qekntqcuL_Yz97=e9bD1gacbyB5uQijL6FpFqYw@mail.gmail.com>
Subject: Re: [PATCH v6] dma-buf: Fix silent overflow for phys vec to sgt
To: Leon Romanovsky <leon@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, 
 Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
 praan@google.com, stable@vger.kernel.org
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

On Tue, Jun 9, 2026 at 3:22=E2=80=AFAM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Mon, Jun 08, 2026 at 07:43:21PM +0000, David Hu wrote:
> > diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-bu=
f-mapping.c
> > index 794acff2546a..67a8ff52fb8f 100644
> > --- a/drivers/dma-buf/dma-buf-mapping.c
> > +++ b/drivers/dma-buf/dma-buf-mapping.c
> > @@ -40,8 +41,11 @@ static unsigned int calc_sg_nents(struct dma_iova_st=
ate *state,
> >       size_t i;
> >
> >       if (!state || !dma_use_iova(state)) {
> > -             for (i =3D 0; i < nr_ranges; i++)
> > -                     nents +=3D DIV_ROUND_UP(phys_vec[i].len, UINT_MAX=
);
> > +             for (i =3D 0; i < nr_ranges; i++) {
> > +                     unsigned int added =3D DIV_ROUND_UP(phys_vec[i].l=
en, UINT_MAX);
> > +                     if (check_add_overflow(nents, added, &nents))
>
> An additional blank line should be inserted between variable initializati=
on
> and the subsequent code block.
>
> Aside from that,
> Reviewed-by: Leon Romanovsky <leon@kernel.org>

Thank you, Leon, for the review and for catching the formatting
detail. I'll add a blank line, include your Reviewed-by tag, and send
out v7 shortly.

Regards,
David
