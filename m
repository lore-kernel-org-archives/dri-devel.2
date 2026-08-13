Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119F3C5DF66
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 22:02:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18D6810F569;
	Thu, 13 Aug 2026 22:02:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n42abIMK";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9703810F569
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 22:01:59 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-383fff6e8b6so38094a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 15:01:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786658519; cv=none;
 d=google.com; s=arc-20260327;
 b=HirjZRi0gV3hIqrNUVPxg062ACo77IWtL+bwokBOZSoR3EADlETZy64IP0D3vx5yBX
 AJ1kad+k9q5lwEKm/hQHK6WgO47GN2VX0+jmA9G/JY2Vcrm0MwRUjkmvYnJD1e7yHHL8
 tfw/qMvA0RSKDDqTbNncy9BuiEOj25/7yQlc4Vty8cUqcxrcKG66sEWd6fmnq5ST0/s+
 Vn91d9hEmdxlNT30J8GNsdhV2r0li6ZJgcT6vXjoxy6dZ585rLH6u4zLTIJLM++B/Lyk
 4h+OEPMphSTVNPF39u/icINnqYCLnh0FrqaqmTMMleDzYRjFvIFOWsYiNqjZYv6GXSaC
 2hZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4Mq4lnCpPXsLK97g8OxvoVmu/P5LTp2GxHOYzB464gE=;
 fh=zNpD3jocJwiJFHvXSZQlUDvI9j/zZy0s1LRIFdBQ9TI=;
 b=Shy+fNpeCReo1a+d0Og+xSl3lueqvvriZH1lmUaXsRtKmnvaohtu5kpGvzV2XHzmJT
 VBjtoJ+mGqOrB0LhJYycc5K5tOY9WLbRUnSLS6RosijFHPWZrcZ2sRpBYDYy/vM89S0X
 XGimYAh/ua5DDgj/ZqoB+z0CZz+Hl1kQrioIoisigAsk8hsIb9dFs6Rp1rmz5fPdBAka
 aUNz4G7L6MZ+82KMvr1S1xu/B6OE87matAU/6mm78V2aGjOF/WSrUfJWZO19SyX0jVdF
 kLC+H8+SSsBJ/CdLxbv0bUUzK7fHLY6hLLACECccSgvMfOjngL0S5Kzp+qviiLd3EPzt
 Vstw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786658519; x=1787263319; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4Mq4lnCpPXsLK97g8OxvoVmu/P5LTp2GxHOYzB464gE=;
 b=n42abIMK1o3+ZheEgPyFVIlRApzlC61KJouOqILFlPWV9lomc2jA0UJ6iN3/1o8N5q
 z402PkyNk935W2Kv7MYaFP5Rfpmfak4PWjk9HyMzfLPFek9xiUPPIuPzyBmqetiGVoSV
 N+HDfDeHn8WqelTPFP9hYj4KVYsmXYAv8bb8nTdqhgXdrrNJSDt2q3X5UR7T44C0wjX1
 mrn3ETE+PDWZHdfaoN1dw+Gcj7odbMnoQHu5qpjm6st+Z9GHQpreXrT0uB2wTvVt8mea
 GKFHl6TziBiB6EC1l1ZBnKh9YypCDsxGupsvXHYqWE2TNXxbwWbc1hpaFzTOvcrEMpDr
 7srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786658519; x=1787263319;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4Mq4lnCpPXsLK97g8OxvoVmu/P5LTp2GxHOYzB464gE=;
 b=KX8Ui0NqxKrxVD4NjeYN2t1M7Qo+ekaiUncTTkzElXt8OTshECWeFzjxfs9FIvdPOt
 8cTMySPp86YK0+PEJYKze9Zx+GNuFCYadh7dI3N7Roe2kKV779aSEtB/GMG/RFLqG+Mw
 mzJ7hJdtZvAcWlBs/2N7CE2IFDOaTN9Xh3UD50mhsvywojOzUh4dr4r0c/2EDs90QRID
 Z2xSw4f1IcWnoSDqFelr9ZlmAkiDkpMWrNllwXjFsMRK/VO+iuHTjM4nlH076MmOUv8m
 zNY5Bccds9ROP5A2q83F6z0xLJX+uoNjrMvvmsgR8iYU6lxvHGombzLKMLeXny0/0tgq
 PlPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpdj4/SwQ0EwelB66H93GvQakEwSnFpMYb9rnX7zLxCVP0HBVut2llu/l/GXTpkqYdHQAWURyQrVBk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTu90LpyoOFRg0XzeaS7TrHpGF0Xs6VX7qRjQstwCFzgyaJsmz
 vA462HM3mVyT9DiQQNvP1r9JFRHQwbQ3Plu1oIhE51Bk8+TZJv3aoNAFGJdUSZrYQaGZ5OsdmXL
 slmqWDMdpiTKI3mSISeqmzSE+iIMGUF8=
X-Gm-Gg: AR+sD12uF/aSaDgCkQ1VCRgiXBYH99iAXt65sO6SC/71mST4j6awvqM5Zq6bp++LG8K
 1VayruvOo8S1bhOc15I78efeflzAxdwP12pN13hFP+sA95Pcjh0OnzTAUtAvZLAj1ZhOH6bfkA7
 yIYLAkpcuwFVEEzvWxwEYTWPo1LpbPuABr5dx+VMixl32yh0h12gI6zQ+irxUDBCE31Y/1AVg3A
 7vnjnjMKf8wZjWXBjBtWhPXvLHRdaNV/SX4eLrLjoUUTFA4uh3piOavxaax6GW415zAShOJC215
 8CqXvbaSMsITe4YQu8B6fKMJgLQwyeBBuCNogGBrRkekRnfK9i6HXaPHPoDCe4Howb4WYNhLkPn
 aYJ6yW8lZT3tXSzuTky0CaWMgh+Fq1X0=
X-Received: by 2002:a17:90b:1fc8:b0:38e:7069:7117 with SMTP id
 98e67ed59e1d1-3933b50729fmr918723a91.0.1786658518991; Thu, 13 Aug 2026
 15:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260805140227.44868-1-boqun@kernel.org>
 <an44yIv7WG7vqTqQ@tardis.local>
In-Reply-To: <an44yIv7WG7vqTqQ@tardis.local>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Aug 2026 18:01:47 -0400
X-Gm-Features: AUfX_mwrCLsatx0Sle_Nl-2BbcnZsP50vwFu_lWeNoqprpd0PhoDhEdHVhOZSkw
Message-ID: <CADnq5_PLV1rDw8DSawdHfQxyk8XgPp94TQa0HuFVdZVvZo+zmQ@mail.gmail.com>
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
 linux-kernel@vger.kernel.org
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

On Thu, Aug 13, 2026 at 5:36=E2=80=AFPM Boqun Feng <boqun@kernel.org> wrote=
:
>
> On Wed, Aug 05, 2026 at 07:02:21AM -0700, Boqun Feng wrote:
> > In a Strix Halo system, a >100 average_vcn_activity in gpu_metrics can
> > be observed by running the following command:
> >
> >     ffmpeg -hwaccel vappi -vappi_device /dev/dri/renderD128 -i \
> >     ~/sample-10s.mp4 -vf hwupload,scale_vappi=3Dformat=3Dnv12 -c:v \
> >     h264_vappi /tmp/output.mp4
> >
> > This is incorrect because the value is supposed to be in [0-100] range.
> >
> > The cause of the issue is that the metrics.VcnActivity reported by
> > smu_cmn_get_metrics_table() is a permyriad value instead of a percentag=
e
> > value (e.g. smu_v14_0_0_get_smu_metrics_data() has a division by 100 to
> > report the vcn_busy_percent). Therefore fix this by applying the same
> > division in smu_v14_0_0_get_gpu_metrics().

I think this is correct as is.  smu_v14_0_0_get_smu_metrics_data() is
used to fetch data for standardized formats like hwmon while
smu_v14_0_0_get_gpu_metrics() is for dumping the raw metrics data.

Alex

> >
> > Reported-by: Mark Janes <mjanes@netflix.com>
> > Signed-off-by: Boqun Feng <boqun@kernel.org>
>
> Ping?
>
> Regards,
> Boqun
>
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/dri=
vers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > index 568665265a13..1058338344b0 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > @@ -566,7 +566,8 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct s=
mu_context *smu,
> >       gpu_metrics->temperature_skin =3D metrics.SkinTemp;
> >
> >       gpu_metrics->average_gfx_activity =3D metrics.GfxActivity;
> > -     gpu_metrics->average_vcn_activity =3D metrics.VcnActivity;
> > +     /* metrics.VcnActivity is permyriad, convert it to percentage. */
> > +     gpu_metrics->average_vcn_activity =3D metrics.VcnActivity / 100;
> >       memcpy(&gpu_metrics->average_ipu_activity[0],
> >               &metrics.IpuBusy[0],
> >               sizeof(uint16_t) * 8);
> > --
> > 2.50.1 (Apple Git-155)
> >
