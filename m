Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AD7CD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 19:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01F9211A288;
	Thu,  4 Jun 2026 19:37:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="eDznaaoi";
	dkim-atps=neutral
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3144E11A288
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 19:37:03 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5aa64afcfdfso283e87.1
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 12:37:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780601821; cv=none;
 d=google.com; s=arc-20240605;
 b=Skb0ZesTwjq2YBFImaucpbjnOcT95wLHg2QBlgFVIlpv4pcM5dUa3/AmjqXaAAVw4R
 B4h4K8A8NU7gZgY2RWnz2379rgUYEhU0T98IRwD3Pi2ksqH/FFmNxhX5iNcVA4eJ5Ctc
 F2HOaSo1qxNc5rTe2ZVqrHcYOOfPBWKN+P64rTlNwGZY/fBSq7mfQ2c2PROFErDN3fi4
 S7J1FbchSIlnM2GPO4oYqjOt3Ypkk4avoparGqogz5fXIYbW67T9AY9dosiFTbXRwUNC
 EeM29NBOO5pyJlOA96TTLma/1+h3QuzyAzB7QzSWpKGfFAgYONr82Dh08I4ehQtEQAaw
 bZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KUiC23PK8EOFQC+N7GaZpdkePm+wStyLtAYgas7c/7M=;
 fh=QNElZscPGkeRoNSnfdTxxbFmfzwts4Y5Maz7DRLMRBg=;
 b=cnOZhx47SpgAMiOOccfBeKNJer1OUhcKg+sAKxrf36FglzShcaIT3uNyE/TXJY9TFs
 Uatq/oVZDGNcFdvB66Ptorzmbwl3gnwYvlfWc2ngtPhrtPQ9Re8GDzf7WBlCvaQ3rhLp
 7+vepL6cbsm1VOGybI6a8yUZKgg/byG5hNhphlvx/BsuWVFIaEcuHEJI4hQ/I+bTpIMK
 98W+95IsoQJ1ghqj/Ba2uH+PUja3552YqpPvd6t95nhWlP2PERQDvSZSEab3pqi4QX6a
 sKF1rwGS9hzT8xSQ+ZEbKFl4hsJMZnHYHknnRurzFBT1gqHrwo279OrqDYfVsMF9ybIn
 O55A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780601821; x=1781206621;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KUiC23PK8EOFQC+N7GaZpdkePm+wStyLtAYgas7c/7M=;
 b=eDznaaoijb8nvGzf0IBiR5+Wp5Zur/DhiB4nyYVsjNK4CicHSaCtx8bULTpLWW1GkU
 jIiyE/Pgbi8i2Yl4fBTwYfLrK4G4Tnx468TT7shA4mkDBj6sGjdwkX60dyUg3woYZtaJ
 5WxQ/BpJka2JY4Et4LRCWOaIULbDcNdVkJwQYJiaFPjW6D2Zpp1wqO2ye8G4DYPPAxo9
 Qn6nIYbvwaVtKeIFd7mySyb4A1HdqhxXKXOmkXj/5C/1+wlW/gHcklS3pKeZyTimBUZp
 DVensE99iueyZ2rMvNmjbMHS8c+sK83SecO910xd1Wx3/89gj9iUdVKEL4LGkuBkPt1N
 dCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780601821; x=1781206621;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KUiC23PK8EOFQC+N7GaZpdkePm+wStyLtAYgas7c/7M=;
 b=RDgx3LwoTKodrmbKquRDNbRMb4AreS/IKdXBT7RRVTgVo7vGfH5ZcDpOGRaLoxc4te
 gDwaiHMNWuAKTe2UT9JTzduWArwF9rjYdOceozMSvt/fyTgTBMXvz4zXpuOZu5HMvHMC
 HEQUpX70zd6bi8sSF2lL2sTUCD4diBHBfO5vxFnjQBcMbNM8eV9taGpMqdsNqOIV66Su
 zskM3Pd8G82RdXbd8tF45x1AU1nB3LEze1c6ET9Vm5r+owUj6GUzXAKVA8+2S9HJbAB2
 woeG5cQ4atbjxjnxWieCkJOfdUZJo4jvdQg6RkaFyugVOe7zSgYRV9SqZ/SJyfkAcSHY
 Mzww==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Mf+ZpBepFUIAWyNcY0jyCyRAwEHcBEQI/kiBKurPv/S/3gc8POMqxX1PouRwDWjd7KLgR4ELS38c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxihFFGGI/E/fIvKDC9sIauPe0EhaqcMCLYPcnS3UcvulHqMVs
 pgGAaX5p8LipZp4fRihAsGGwJ6tpMUpMVhDA+WwhzH7/9tmm+pRxGJ91FfxwYqIa+lNHfYm/Ziq
 K2CIMwzWd4tq/eqL2rzEE9AVTn8/Pm/ky8VfSAnw=
X-Gm-Gg: Acq92OGLhoKp4rFVvrO5xGkZayJt1o4gk+z4Unwv2egf7Y0fPwpyWIpv46sOQWxxeNE
 Q0CwhuLNme9iSNdE0Z7oDmMu9MZ7HDjZWKEl5y8S5rB2+4cXp1I3BGUGEgSsV+io5rAz9BMTZDX
 toY5PoRmi9RggXJU+0YE1U9hLbSBll5nBNIiUI++Esv7+z/ryac4qZkHm+1gX1JQ6rKRT4RTLBR
 JBhJjJ9Ys5R6/0niI7CKGqlFINIw+3FZsJs7qgIn/BMExstReFTR+YU2ZIBFNrrX5dp8//3obfD
 af5NAFQ2wZ2XCHdTHF+xL6r0X+pxQL5aNYQwT2vUGCxKpMw=
X-Received: by 2002:a05:6512:2446:b0:5aa:6ede:1a68 with SMTP id
 2adb3069b0e04-5aa877c6752mr44886e87.10.1780601820811; Thu, 04 Jun 2026
 12:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260601200012.3872274-1-xuehaohu@google.com>
 <20260604094344.GB245424@unreal>
In-Reply-To: <20260604094344.GB245424@unreal>
From: David Hu <xuehaohu@google.com>
Date: Thu, 4 Jun 2026 15:36:48 -0400
X-Gm-Features: AVHnY4I667s8Q-kTs7E7YlSR5Fzg5WrO7fnNQmow9VUJtwR-GDJeAyWDhu8beOk
Message-ID: <CAPd9Lg_JkRdtNa=n+HE9SP+NFCSB+X_97eiPBqiONVLwV0pHwQ@mail.gmail.com>
Subject: Re: [PATCH v5] dma-buf: Fix silent overflow for phys vec to sgt
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

On Thu, Jun 4, 2026 at 5:43=E2=80=AFAM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Mon, Jun 01, 2026 at 08:00:12PM +0000, David Hu wrote:
> > @@ -36,7 +36,7 @@ static unsigned int calc_sg_nents(struct dma_iova_sta=
te *state,
> >                                 struct phys_vec *phys_vec, size_t nr_ra=
nges,
> >                                 size_t size)
> >  {
> > -     unsigned int nents =3D 0;
> > +     size_t nents =3D 0;
> >       size_t i;
> >
> >       if (!state || !dma_use_iova(state)) {
> > @@ -51,6 +51,9 @@ static unsigned int calc_sg_nents(struct dma_iova_sta=
te *state,
> >               nents =3D DIV_ROUND_UP(size, UINT_MAX);
> >       }
> >
> > +     if (nents > UINT_MAX)
>
> I would suggest to use check_add_overflow() while calculating nents
> instead of this check.

Hi Leon,

Thank you for the review. Using `check_add_overflow()` is a great
suggestion and definitely
cleaner for the accumulation loop. I'll update this for v6.

> > @@ -133,6 +137,11 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dm=
a_buf_attachment *attach,
> >       }
> >
> >       nents =3D calc_sg_nents(dma->state, phys_vec, nr_ranges, size);
> > +     if (!nents) {
> > +             ret =3D -EINVAL;
> > +             goto err_free_state;
> > +     }
>
> Technically, this hunk is not necessary, since sg_alloc_table() will
> return -EINVAL when nents =3D=3D 0. At least, that is the behavior I reli=
ed on.

I originally added this explicit check in v5 to address Jason's
feedback, and to make the
failure explicit rather than relying on `sg_alloc_table()` failing
silently on `nents=3D0`.

Jason, do you have a strong preference here? I am happy to drop the
hunk and rely on
`sg_alloc_table()` returning `-EINVAL` if you are both comfortable with tha=
t.

Thanks,
David
