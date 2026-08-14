Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373E2C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 00:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4179810E061;
	Fri, 14 Aug 2026 00:51:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mITKlQaT";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39A0C10E098
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 00:51:35 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38f0f3c8da5so48671a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 17:51:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786668695; cv=none;
 d=google.com; s=arc-20260327;
 b=KE5UfG1bE/jEYWd4vpQ3z+Z8I2SGoYYh7t+ZOskU5Ygot0SYaEIR1SF8OMuwpCnGLF
 MZQZV1AXzHsU1GYgBR99arCcfKduJZ0+AEVG62nSvAwmCA3F40pz2pWkJGAPFWEtfS7f
 icx8y393NwZAhy7RHfCtbsy+CEmbdziU8j+FsiGjc3vyklK7S93CQkdNL8x+TEZY6OeZ
 /DguDY6RcXjLBHPGi73bjbDP2oW8ZMb7qJUgHHTymxUA54ZK2H9ZxDw4fLTi9y2jcJLb
 6v037leofoB/pU2ZKmad1WExjnK9GT7fKKu6LhyqMLfM2Lwjpm/LYgAlQIbn8FyAMj7b
 Pjjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yxCYRgUfiupLw1ZARQEtlHxBkRDTpGsKuDLKUmEpvGY=;
 fh=EbSqJvCBSua0/PkQ90fIpSTJJQyXNW86HgRO4W6CTAs=;
 b=UWTgZLXonxIwhuhddSH4Bb1eWwjiOCGutOBwvJwTIg2Eu+1RBOCPdSfO+h0K/Ivyay
 rdPrhzrZ7ANiF14xSErcDZRwGNEZO/2Bk7dGgafL+UFwqA99vnjZxogKjr2V9tCkpl2S
 3zpGsyAay+kU/O9E39KLPW2WPiCL71j6dINQIpex+nszhvE2BkeNcRbkct8xegUjAQL7
 ZP2QgD8M5Mw6jbmNBGytM5b8nZPzXkFtl5i5UnPgYsZUamNB5udqQWl6m7l/yyit88Yx
 G1ImUeHIv5qP8qIBKbobB7p9lyL5qUfSk1vKdcG1QAWf5Nb8GV3KkwGyUk5GB013x5sk
 GHZQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786668695; x=1787273495; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yxCYRgUfiupLw1ZARQEtlHxBkRDTpGsKuDLKUmEpvGY=;
 b=mITKlQaT11reGOIrSfzi0hjHbRVZum4JiSODcS4K8wNsSoUzkvUXvQXl84QqZrUS7J
 JH4rcD1J+TsBMt9y1XyyuchyIDFbefrWkXSUVMST9dRS+ZnOL/FWAAirWeEWTi+6oMur
 hRHvbYfdA4mxHvntwfbwrqPNoWG2OCaKXC8yyPkDhICca5Tw0zZ55V/T2uue7OIX3nrD
 WCiXqq9rILVwDSzmutH1XDBJXHtybmjuyZyy8SnP37XD6h21hbfP1Q8DgOdbF/l50ZaB
 0g6FtdIsgSYJ5vT6RafiWrQXByEco1+zFBujdUa+KcKrdgoBnCfARisCzjlZVXtQ52RI
 Llng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786668695; x=1787273495;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yxCYRgUfiupLw1ZARQEtlHxBkRDTpGsKuDLKUmEpvGY=;
 b=kzu2VLs0LUfhsVAq8o7c4QuZmsQeYzWF5psD+YSmJ3uuyURgr3iv+uVfmmjP8t9c1u
 kL0+5RXLqyzMjmoImtkPtebnuHA+nNI0FgMExFChXWr1ZDy1RFIAzuCZ+mKabu6eOXh/
 OpT3QSnlAX3lH/3gPqEqOl0184gyZmWBh8+VS1I7kwVhZinls3JC5bJUEhpCt9XjdNTt
 FWuUcL1QabSU0y5S8axZ6U1JGOHVyIl4Ut9HoqQscEv7RXaNYRwIzSICWEAtouP0X2ru
 jxnRR+IrkCsiYi9tIhKlNkDobDpJ7XtuTvhPSduG3lMA8vl3a2zcUFgbUGrAU8WBm3rH
 u8GQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr4qkum0prYTFcHEYp3wItoqu1/uQIHFXgwx5leinCBMzcKK5jQk6gWMVqLvKQ86Gbi7ABGq753t/A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9cADUouEKsa3NDxEUqMrFfc0Av7hUu70MQ6/KtH9OuAF/7Htv
 yjjJdo3Mmtadb/iRayuisk9DAs63KIpNQYy4cgwMT2pFYkOYNnNzrlLTkzInLe9vcobGPv5YnbP
 mj78j10/EXgXIkj2n1zaxQYkWABF94Jc=
X-Gm-Gg: AR+sD11DvPxWr4U+xiQKsr+jyA8L3vzVOcGVI3Ui5royZCusXQGqL2XQa+xJ9ioyxpU
 q+q5hOtrjvvBfRB+HTGd4oJYYLPuFdFUGuANTZ4j20Ij3MR4UmGU8GEY4sJqxMB1xGgcOFJg8Ln
 3SfjVmA3gBpQI+fYwQswyUk2RSAgk8IEzRMjMrx14bWnNflMRfFd6h1fKGSKJtb2oicdbYwxexE
 1gHzdQ/uRI6r5YCLvBDnnpRxCZTMVBfrgoNWb04X1+eP+noNzxLdSSKhjdJex0IbkESpjbFUMZV
 jvMOryX1uMlSDwBtUfHLVhYjaG0IDh00LQWlnrd5jcbxooLLyB4wfxOcoHvWTlNBPmTQMdjYciu
 NuX1aLts5VdQf35f7iFgWyPkyVvmc+Hc=
X-Received: by 2002:a17:90b:1c91:b0:390:3936:8760 with SMTP id
 98e67ed59e1d1-3933b4d0640mr1460281a91.0.1786668694607; Thu, 13 Aug 2026
 17:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260805140227.44868-1-boqun@kernel.org>
 <an44yIv7WG7vqTqQ@tardis.local>
 <CADnq5_PLV1rDw8DSawdHfQxyk8XgPp94TQa0HuFVdZVvZo+zmQ@mail.gmail.com>
 <an5ESxy8-OMYvD4d@tardis.local>
In-Reply-To: <an5ESxy8-OMYvD4d@tardis.local>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Aug 2026 20:51:22 -0400
X-Gm-Features: AUfX_mwyptKu7Aa9Xb0KCbzA8D3qBwzeTvuqVJBVUaxF9RhYYZfTMTOpr3yCJc0
Message-ID: <CADnq5_PQgYboc8pPCRYimpf7fALgSPid-GGJzNsA+TuODsa8gA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Fix incorrect avg vcn utilization in
 gpu_metrics
To: Boqun Feng <boqun@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, Mark Janes <mjanes@netflix.com>, 
 Kenneth Feng <kenneth.feng@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lijo Lazar <lijo.lazar@amd.com>, 
 Asad Kamal <asad.kamal@amd.com>, Yang Wang <kevinyang.wang@amd.com>, 
 Priya Hosur <Priya.Hosur@amd.com>, mythilam <mythilam@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Umio Yasuno <coelacanth_dream@protonmail.com>
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

On Thu, Aug 13, 2026 at 6:25=E2=80=AFPM Boqun Feng <boqun@kernel.org> wrote=
:
>
> On Thu, Aug 13, 2026 at 06:01:47PM -0400, Alex Deucher wrote:
> > On Thu, Aug 13, 2026 at 5:36=E2=80=AFPM Boqun Feng <boqun@kernel.org> w=
rote:
> > >
> > > On Wed, Aug 05, 2026 at 07:02:21AM -0700, Boqun Feng wrote:
> > > > In a Strix Halo system, a >100 average_vcn_activity in gpu_metrics =
can
> > > > be observed by running the following command:
> > > >
> > > >     ffmpeg -hwaccel vappi -vappi_device /dev/dri/renderD128 -i \
> > > >     ~/sample-10s.mp4 -vf hwupload,scale_vappi=3Dformat=3Dnv12 -c:v =
\
> > > >     h264_vappi /tmp/output.mp4
> > > >
> > > > This is incorrect because the value is supposed to be in [0-100] ra=
nge.
> > > >
> > > > The cause of the issue is that the metrics.VcnActivity reported by
> > > > smu_cmn_get_metrics_table() is a permyriad value instead of a perce=
ntage
> > > > value (e.g. smu_v14_0_0_get_smu_metrics_data() has a division by 10=
0 to
> > > > report the vcn_busy_percent). Therefore fix this by applying the sa=
me
> > > > division in smu_v14_0_0_get_gpu_metrics().
> >
> > I think this is correct as is.  smu_v14_0_0_get_smu_metrics_data() is
> > used to fetch data for standardized formats like hwmon while
> > smu_v14_0_0_get_gpu_metrics() is for dumping the raw metrics data.
> >
>
> Well, then kgd_pp_interface.h needs some help?
>
> struct gpu_metrics_v3_0 {
>         ...
>         /* Utilization */
>         /* time filtered GFX busy % [0-100] */
>         uint16_t                        average_gfx_activity;
>         /* time filtered VCN busy % [0-100] */
>         uint16_t                        average_vcn_activity;
>         ...
> }
>
> Clearly it's not true.

That was likely copy and pasted from the firmware interface
(smu14_driver_if_v14_0_0.h):
uint16_t VcnActivity;                //Time filtered VCN busy % [0-100]

Other generations seem to do the same thing (raw data in metrics table
and % in the hwmon type interfaces). E.g., smu_v13_0_4_ppt.c:
smu_v13_0_4_get_gpu_metrics()
gpu_metrics->average_mm_activity =3D metrics.UvdActivity;
vs smu_v13_0_4_get_smu_metrics_data():
*value =3D metrics->UvdActivity / 100;

Alex

>
> [Cc amdgpu_top]
>
> Regards,
> Boqun
>
> > Alex
> >
> > > >
> > > > Reported-by: Mark Janes <mjanes@netflix.com>
> > > > Signed-off-by: Boqun Feng <boqun@kernel.org>
> > >
> > > Ping?
> > >
> > > Regards,
> > > Boqun
> > >
> > > > ---
> > > >  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b=
/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > > > index 568665265a13..1058338344b0 100644
> > > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > > > @@ -566,7 +566,8 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(stru=
ct smu_context *smu,
> > > >       gpu_metrics->temperature_skin =3D metrics.SkinTemp;
> > > >
> > > >       gpu_metrics->average_gfx_activity =3D metrics.GfxActivity;
> > > > -     gpu_metrics->average_vcn_activity =3D metrics.VcnActivity;
> > > > +     /* metrics.VcnActivity is permyriad, convert it to percentage=
. */
> > > > +     gpu_metrics->average_vcn_activity =3D metrics.VcnActivity / 1=
00;
> > > >       memcpy(&gpu_metrics->average_ipu_activity[0],
> > > >               &metrics.IpuBusy[0],
> > > >               sizeof(uint16_t) * 8);
> > > > --
> > > > 2.50.1 (Apple Git-155)
> > > >
