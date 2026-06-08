Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBBBCD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 18:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A39CA10F8DC;
	Mon,  8 Jun 2026 18:55:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="To9mvB3k";
	dkim-atps=neutral
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0AAA10F8DC
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 18:55:14 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5aa62bd04fbso22921e87.0
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 11:55:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780944913; cv=none;
 d=google.com; s=arc-20240605;
 b=MCmK3kwDgH3yRUsXILpfC/UDXUae99vX2r1VVThicHdzGF8LBOem9WFhy87/ClGHxV
 Kdm3X45xJX1JDhSSzAL1vhihAuNXsjlDpQLb3xX0afNncozYFTLRALKVaykzgX/Xuz8J
 5u8PJlxqQOh1dh/JZIfSPFMHg/0YEtTVftZPPSS1proVyjuP7f6sGD3lMlPThFrLUo9n
 j+FgOWc3HZcbaPOErR4V2hDMwsKjXYe+40REQIbuyyKMxX2FbKpzUtVmArk6x9oAAKV4
 L/zuafneCKp/GNvqwwRyjve10GRrzgkq8On8ysGw3Dxa/6IDFFdoHRXMUn0KvHx2LPWg
 u6Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Dw+WR3kgPsmomU5BDy/wi1DbnucrDq50YuLE+lo/Shg=;
 fh=Rdo5syaPKaW2ihdFyS9lq2oMRpsl45AcAgtMJPzAzkY=;
 b=bfKqwbdr8fCC5Qy746UIzspsoPRlm1yI1OnO/kTEykmuoDa3UljPZmASEWdlGETBSC
 nFuMOlJx2ymGOeEXatL714LtmfQMApH9C2VAuN0q9YCltjROSwfcykpMmnOmOeAMkXEo
 wWg48ATmsvQGLPfTXYQSsleqyMtai8Keme877SL6RN1TzXZ8vq+ZNiFoFqeY5hgv5+5w
 Ccm8oiXsDV5fKWWHkXmAAunn5QIyo/dsCGpBwBdfqs0Ks+XMfv0ha1qLPyleRsx8wIQS
 xn7p7MSygBM4UxPcGYmht1/DTAgf0vd9dsijX1XqJjbajJXQk+zrVXB+pIbjgkmFFELJ
 +Jpw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780944913; x=1781549713;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dw+WR3kgPsmomU5BDy/wi1DbnucrDq50YuLE+lo/Shg=;
 b=To9mvB3kdtw54ZZ6hYvw+zQHhz7RK36UdZDhKVAPW5OSr/KpmnVYxPU+0/YaQzjomO
 i8+PIiZrDQ15npGVTOW3gt+F1NTsg/WYPuBuMyhrxeecUK+ACKzjDgnoGdwSkxpl3le9
 Evvx00VwfDP6kntpxytDEowEhZBgB+AlRRl+7RNTfXJQ5tVPARULf73wd9K+v2DSEwcg
 Eia+5TYhlp3HsGn8mJYAYBtfGXFc+RLu2xPE0VhCjPITybH5MLQBXUIW8vezYd9kelip
 cpFv75Nce4iIf6mA/TVVBP5+pk+QKpYVFR1TA/W6AafZpTGt5MwNU3jgm+sw0oOCD3He
 8qzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780944913; x=1781549713;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dw+WR3kgPsmomU5BDy/wi1DbnucrDq50YuLE+lo/Shg=;
 b=dVQKqG3/lZjshwzOAYAFWezWYN6lnWxiQQCAs45sEetxbHKew0Jn6USLpBgpX6QewJ
 smzi+8mY3gFEgehD699JRr+MixsisG6JKxXiU0qjrTHKvyDA0MlDBQTLnhK2lO4kdW/7
 lPa+eHILlMuvYKN41NEngV/3BzNCUWDtEQyjgicUliYWRwLJ3rbXZUCYoMKHcZdCTU4H
 p7E1wKPirXlY1B0g8YCM2KYlP+tqTz3ZqNL8DMLeykmD6siYHHS3qmif7pYu7y3t6Zuf
 XB5H5S3WHuAE5Du7KXb+cf6V+8JeQlPLdteyPctsx1E61jsV4dcGgw1goS+CpNbl58X6
 5FXQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hEge+vOBAGxl8Yko8xmBouypr9sMg9RQ1HoBVCwRt0kNFm61A1qKGu5DNm//7QDoM5TQKCVFPI3U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXa+SdMJBWoaqG8hZmQ6IVqRNFlJNOl19mF6ayA8lRD8IGzhy+
 pWnim9NTS6T6v3nasaCS6D14CoK/3fQqPDHPyp7bBGMzebeOtJoTFFev3Lm9o5p+HCfxvGtRzgx
 Y/+F8pieMwTxbWfZX2O7yUfwvK7ko0YycnT6L4iA=
X-Gm-Gg: Acq92OE57G1f1+sKcNtt9XHuoUDBp/yS9qjxUIBxyg2iuboWwNjQ7gDIiNw/OPK8ZW4
 brwQJwlRIGBIAs/m6wHUHwN/rkW0ZSIf1K/CqQ4w/dAP678UaV+h1Ig2SeppZSBvuwZsBO6PgOU
 rrYj653g5plA/8LslvweoapmYtthyDFhsuwcTAIrLEDYjgOGHF99a66XLtMFbO0AGUNDSeRYP1j
 H6iGayYptk/6qSRagZgLKKMuSTZvjXtorUVuNfgRUQiLmyqc+c2fL2ULXpwHemW/JH6TVEXgb4J
 GsGhqPOtrNMAtuKrcgQjsGGGYqi2ALeQ3OXHBvwmbGaLuhHX8KW9wkU=
X-Received: by 2002:a05:6512:3341:b0:5a1:274b:de2b with SMTP id
 2adb3069b0e04-5aa88640402mr537440e87.9.1780944912435; Mon, 08 Jun 2026
 11:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260601200012.3872274-1-xuehaohu@google.com>
 <20260604094344.GB245424@unreal>
 <CAPd9Lg_JkRdtNa=n+HE9SP+NFCSB+X_97eiPBqiONVLwV0pHwQ@mail.gmail.com>
 <20260607080244.GA327369@unreal>
In-Reply-To: <20260607080244.GA327369@unreal>
From: David Hu <xuehaohu@google.com>
Date: Mon, 8 Jun 2026 14:54:59 -0400
X-Gm-Features: AVVi8CcrgIqNX---JRMNN-9SsXpCXMWpb_Y08c-v1_nrKhDd232Ciz6Ae661o0I
Message-ID: <CAPd9Lg94nGnn7HQPNiSS7w2QQjVAuJ_FkMggR=JfSGVJyAsgeg@mail.gmail.com>
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

On Sun, Jun 7, 2026 at 4:02=E2=80=AFAM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Thu, Jun 04, 2026 at 03:36:48PM -0400, David Hu wrote:
> > On Thu, Jun 4, 2026 at 5:43=E2=80=AFAM Leon Romanovsky <leon@kernel.org=
> wrote:
> > >
> > > On Mon, Jun 01, 2026 at 08:00:12PM +0000, David Hu wrote:
> > > > @@ -133,6 +137,11 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struc=
t dma_buf_attachment *attach,
> > > >       }
> > > >
> > > >       nents =3D calc_sg_nents(dma->state, phys_vec, nr_ranges, size=
);
> > > > +     if (!nents) {
> > > > +             ret =3D -EINVAL;
> > > > +             goto err_free_state;
> > > > +     }
> > >
> > > Technically, this hunk is not necessary, since sg_alloc_table() will
> > > return -EINVAL when nents =3D=3D 0. At least, that is the behavior I =
relied on.
> >
> > I originally added this explicit check in v5 to address Jason's
> > feedback, and to make the
> > failure explicit rather than relying on `sg_alloc_table()` failing
> > silently on `nents=3D0`.
>
> I prefer explicit checks, but I am not in favor of duplicating them.
> Since sg_alloc_table() already validates this condition, we do not need
> to repeat the same check in dma-buf. A comment should be sufficient to
> inform future reviewers that nents =3D=3D 0 is already handled.
>
> Thanks

Hi Leon,

Thank you for clarifying this further. Removing the duplication here
sounds good to
me. I'll drop the hunk, add a comment for posterity noting that `nents
=3D 0` is
handled by `sg_alloc_table()`, and send out a v6 shortly.

Thanks a bunch,
David
