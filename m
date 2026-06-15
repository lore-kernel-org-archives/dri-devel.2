Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C96CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 15:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79D1C10E4AF;
	Mon, 15 Jun 2026 15:42:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DN7NMKFn";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51F4310E42D
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 15:42:35 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-304f9bc869aso375387eec.2
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 08:42:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781538154; cv=none;
 d=google.com; s=arc-20240605;
 b=RIR7ouhquD6ekvhsimhJOAvxifMQtyTz+cfzNJ1xPq/VB/jtxQInoiG+8T1vlHyoOc
 UV9+xL0MvyKG8ZaxuIirftsjzBfrg7s9FQryCAJfmxWEqm9EQQGkhAq0+pClTyVBO1R2
 hM5O7Z3sBhnC06Eh9pJjDBSAksP3Lwy5c3mm2PxH6+PPzzQV8bMamjJVKYLeYDH3e2K9
 CWaVWh77VQqC9UUvpq8C/8t62RR9VhateGmGmnCHV4/cN0UteYhc8K9rErsNtKaGYq0t
 3np77kvHWRpcFxWW6lqhb7bcWS3NaIRD/9cnTQh/64Z/+WQp2J+YixX+WDfotMl1IYcZ
 EWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HB5OTOAis4aNREHBYkXcEkOC2lkh0rrUy7H3L0anj/A=;
 fh=c2Bb8eIFIVij6L5S0UgJh0lHWukc57Li13qSrS++gFM=;
 b=aE6z4lvzECAmAlrDBlLrp0XcVgtq6WeG6tVgBZ4ShhGka7d7HrESsfFn1hEPMqVCDe
 P3L9EHvYu7X1Cc9+yX30ZHrUdef16obPoeWy2/6osjW+8+ongITKNPJyN98ib2TI0FAF
 +kXcD//zUp9SSOIwfn2kcdskglzokXDS1u3E1kjBvq9cBz2sEsg++UeHlHAK2CUZLIkL
 VwswYf2Cjuofp6APoHqnAndHD1Tqg/LKzB2GYwi0uR5zpttBJWdtZyXzoYZotFvwXPFR
 sqGL9BKKBZT6Clt7LBHWxDgirl11SXSKY9EJX0s1IUdH+xjdHUVNtfhDU2hltpSkjpwx
 C0BQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781538154; x=1782142954; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HB5OTOAis4aNREHBYkXcEkOC2lkh0rrUy7H3L0anj/A=;
 b=DN7NMKFnyz+nxGGmjOz1tIdXF3uSbj3NHTINwNlzeJfeKbJ9orusRqvtRiBpjIbDw4
 Grv7OTgUWJtp1aG1U8qED2b1cSJ541Y80AGLahMvV4wcHibqnZL5rZue4uQYAOgadaDK
 lJfA/nkcyF4lW7o/OhBe9D8+EPzoza44TSPRgo6oO/l8m5sARwBBFysIb5KekJrI1NXg
 THSNNvyxK1I3gXTu+hSoimUFzsk66ZIovpHH09A40dFq1KM0S3ieIzOnr4vRhqth1JOc
 vdidoB4/6ic6i3SiwaqZggQUQP+CCFYAd9gXZQzwITwWQjAtjAGM2ov7lctq6M0OeTSN
 JxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781538154; x=1782142954;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HB5OTOAis4aNREHBYkXcEkOC2lkh0rrUy7H3L0anj/A=;
 b=lsrbhmCXeLoR/hUojvUJnBp/XlrA3e8Aw5H1MITEzgzxqfHn5peeB4zFlLwjfHEJXc
 N5ueiJk5lc/+TzfiFlnwMofM8d8Izqg4xrTa4MEk9jaXBYbymh7GCAXw2dHDAbcA99ap
 mgj2YpyOP9pLTfskV8r6Y9ZQQT8YfWndjHzuCKzmhdMEs9+GKMoUrxMIBdbeS72QVILD
 TF6aM98Q1dIdlfFDicqT5/g42lNk+cuUhZ+hxNXovQcaUIg4d+ua9Vm58rpqrYm57SWV
 GG4/phag2r9GOK/Z0lGsww0qWLUVo+sd9zX+ekvcJ4wvEhGqliLZGexf6Ai72tk43s6F
 NPUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8E8+OQe2FN6lRp8Jhub4Ij0/snTz4PgaLBa4X4zMk9BvUg1bKkHZouAGtLYctxbiayXwLIdivcD2k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwqjSPPIamgMhJBQWtH7KwIjt3PsS7yYMI2v8sZgONlR3Je5L7N
 uZRKam5rASMa/1WtDcJCzRYDDF2RT3h36hSovkTNTopnfq43x/snB4k0l9PVJzSTgahEiKT6BAs
 lD9JHjkki3xG4917PGjX3/wxEaFeF0l4=
X-Gm-Gg: Acq92OHW8tYDcEoZSCLBh8Dy3IJgxrStc8yRrPBqu38X/wD3NIyXesVlDj82vnBPAOt
 qBzXkyc+VhOgPm+IOrl5dokJ4RyeEs8DtBtaSV1S+rYwqDS+vTIcaF6v3R5ujv+ZS3XB7BOW5+S
 qKF4CAWlHixcYYkdmdOZAsfcfQGCYMdzicsrKg3dkjX7a3HbzbJzu61xbUMamlFfZyTgMfYZDdx
 9FwcxjaAGWKCEfW1UvSqfR77Y26DsIkj7D3OpHizK8I111nvm1qYqsGYRJs/+sN5Lc3MIKk1iLL
 fctbBL7ke12/OMd8TjtKWtxagY1+YP0XJ8Dr9vrNqmC11xHLT5IgIr/xPzeC+DmDCCqh+Jz9pht
 ljr0k
X-Received: by 2002:a05:7022:68a0:b0:137:ef27:e297 with SMTP id
 a92af1059eb24-139724e2eaamr2051152c88.3.1781538154433; Mon, 15 Jun 2026
 08:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260610083245.1057241-1-pavel.ondracka@gmail.com>
 <f0041fae-2703-480b-be9a-51a1df964a01@amd.com>
In-Reply-To: <f0041fae-2703-480b-be9a-51a1df964a01@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Jun 2026 11:42:21 -0400
X-Gm-Features: AVVi8CfkqX2jHXjaMSoirH3Cv4qa5toEnvBVc9Ay0ocL4YvWUTf4hiVAjEFqETY
Message-ID: <CADnq5_MxrcO7GX+jGQbkuaF40QipnkxSq_+P1cbDmanO2K05uA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix r100_copy_blit for large BOs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Pavel_Ondra=C4=8Dka?= <pavel.ondracka@gmail.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 alexander.deucher@amd.com, stable@vger.kernel.org
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

Applied.  Thanks!

On Wed, Jun 10, 2026 at 5:24=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 6/10/26 10:32, Pavel Ondra=C4=8Dka wrote:
> >
> > r100_copy_blit() copies BOs as 1024-pixel-wide ARGB8888 blits, so one
> > GPU page becomes one blit row. Large copies are split into chunks of at
> > most 8191 rows.
> >
> > The kernel register header names the packet coordinate dwords SRC_Y_X
> > and DST_Y_X. In the BITBLT_MULTI description in
> > R5xx_Acceleration_v1.5.pdf docs, these correspond to [SRC_X1 | SRC_Y1]
> > and [DST_X1 | DST_Y1], which are signed 13-bit coordinates in the
> > -8192..8191 range. The old code kept SRC/DST_PITCH_OFFSET at the BO bas=
e
> > and used SRC_Y_X/DST_Y_X as the chunk address, so large BO moves could
> > exceed that coordinate range.
> >
> > Compute per-chunk SRC/DST_PITCH_OFFSET bases and emit zero source and
> > destination coordinates. r100_copy_blit() already packs
> > SRC/DST_PITCH_OFFSET as pitch plus base offset, so large chunk addresse=
s
> > belong there rather than in the coordinate fields.
> >
> > This fixes Prison Architect corruption with 4096x4096 mipped textures
> > after they are evicted to GTT under memory pressure on RV530.
>
> Wow, impressive piece of work.
>
> > Closes: https://gitlab.freedesktop.org/mesa/mesa/-/work_items/6716
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Pavel Ondra=C4=8Dka <pavel.ondracka@gmail.com>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Thanks a lot for digging into this,
> Christian.
>
> > ---
> >  drivers/gpu/drm/radeon/r100.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r10=
0.c
> > index 3ac1a79b6f13..533215d6e9cb 100644
> > --- a/drivers/gpu/drm/radeon/r100.c
> > +++ b/drivers/gpu/drm/radeon/r100.c
> > @@ -906,6 +906,7 @@ struct radeon_fence *r100_copy_blit(struct radeon_d=
evice *rdev,
> >  {
> >         struct radeon_ring *ring =3D &rdev->ring[RADEON_RING_TYPE_GFX_I=
NDEX];
> >         struct radeon_fence *fence;
> > +       uint64_t cur_src_offset, cur_dst_offset;
> >         uint32_t cur_pages;
> >         uint32_t stride_bytes =3D RADEON_GPU_PAGE_SIZE;
> >         uint32_t pitch;
> > @@ -934,6 +935,10 @@ struct radeon_fence *r100_copy_blit(struct radeon_=
device *rdev,
> >                         cur_pages =3D 8191;
> >                 }
> >                 num_gpu_pages -=3D cur_pages;
> > +               cur_src_offset =3D src_offset +
> > +                       (uint64_t)num_gpu_pages * RADEON_GPU_PAGE_SIZE;
> > +               cur_dst_offset =3D dst_offset +
> > +                       (uint64_t)num_gpu_pages * RADEON_GPU_PAGE_SIZE;
> >
> >                 /* pages are in Y direction - height
> >                    page width in X direction - width */
> > @@ -950,13 +955,13 @@ struct radeon_fence *r100_copy_blit(struct radeon=
_device *rdev,
> >                                   RADEON_DP_SRC_SOURCE_MEMORY |
> >                                   RADEON_GMC_CLR_CMP_CNTL_DIS |
> >                                   RADEON_GMC_WR_MSK_DIS);
> > -               radeon_ring_write(ring, (pitch << 22) | (src_offset >> =
10));
> > -               radeon_ring_write(ring, (pitch << 22) | (dst_offset >> =
10));
> > +               radeon_ring_write(ring, (pitch << 22) | (cur_src_offset=
 >> 10));
> > +               radeon_ring_write(ring, (pitch << 22) | (cur_dst_offset=
 >> 10));
> >                 radeon_ring_write(ring, (0x1fff) | (0x1fff << 16));
> >                 radeon_ring_write(ring, 0);
> >                 radeon_ring_write(ring, (0x1fff) | (0x1fff << 16));
> > -               radeon_ring_write(ring, num_gpu_pages);
> > -               radeon_ring_write(ring, num_gpu_pages);
> > +               radeon_ring_write(ring, 0);
> > +               radeon_ring_write(ring, 0);
> >                 radeon_ring_write(ring, cur_pages | (stride_pixels << 1=
6));
> >         }
> >         radeon_ring_write(ring, PACKET0(RADEON_DSTCACHE_CTLSTAT, 0));
> > --
> > 2.52.0
> >
>
