Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6E4C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 21:53:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F205710E09A;
	Wed, 22 Jul 2026 21:53:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="NBNCUfb/";
	dkim-atps=neutral
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E821310E09A
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 21:53:52 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-5b0129cf6ffso1910e87.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 14:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784757231; cv=none;
 d=google.com; s=arc-20260327;
 b=JuJI9NN6iX4JBz7n5IsfIoVYyKayMnpgSIFr3NiNvTnRzxIyI0GGF9QVza52Vp4p75
 7s0Uv+dTC2AQT0bNjRFaD0WKBK/awmkK5WODl4A2js34tSZbtxuHLj76WaWLImOM/SIA
 2AVokO6M3NdQD5/6pQh+Ux4JX8X4pFaFKDnsjYuI667BBfuMX03QkV1TRSHUQ40TrIBi
 1vL8p7y88XGsGcUXmuml+HtB0RM/sPTMYvHvvgUPck8XY4/rdul63aujntBdaKfzDmq9
 Y4rh2iYG/DQlpJagGtkdHmqiQQ3pzfSM3G2W/LCZ74YhRrg0zM57QOnXkveN1qYcA7e5
 hytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3UirpLV1ZtIxhwqN9P10MkPtE1lhmhI/AHpOOHSx3qE=;
 fh=b/rjQhxG21TYIGvKQH106LzBNfAr1OrmOrTEYgrLHt0=;
 b=OzO3uK+4Tm4+1NeqwRuqei2OIHiBdnXhRBNG0iGR8LBsuKS3G7cIRw/kHssYYBNshP
 GqRUCo0YJuvVxUkXV5G2lmyH8DXynx/kmdrrSuV5Xeygj88wqs+09LdzrQdaTaok1QU+
 /GHc02us2AKrPvLWSAFtNOPrFGVxg1ykrDmUqnwQ3VwOy2WDQuTXCYTKkqoVogJQlwQq
 Q8OFdrPymTQUt/976UTGrAALp8Nhsw1KCDh/UC55+hOdvUqNeNSSWhbg4KiANXuRYICq
 hIYcBGnCGEW9OXCUFofTmucGwXfXXT0FfBBtuFT6q/TMWopmR7VRh2sJnEqH1MmM2qh8
 Qv7A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1784757231; x=1785362031;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3UirpLV1ZtIxhwqN9P10MkPtE1lhmhI/AHpOOHSx3qE=;
 b=NBNCUfb/ruvqEOFm3l3BRwHxvNb0GkxHUbO1ies/NgtcOYwTnYnJtQmEfmZ1+HrP/2
 wpejUcafPik7DLDhtnPrdaSsceC1AEE72M09dUQCsEGxoWv3Xp8cT+CU0erkjTm+6UOS
 2rmHyyVF/RloYZLImTOP8uE8GiVyklbgArwjTDoUveUOBtQz83qbIVABa+DrtGacCsR1
 gNa5Qg/4Cq7hL7C6O4YNXBFaiX9g7Mh/ad7U2PM9dD9VQI12Oyt9m9V0TQvPdftvENLh
 2TXNm+pjJzc+r4y9L0rncJrMqQb+6/tU2gQr0ndUGzRQW1JzO0iS74KMazaAKbOCJrgv
 /IeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784757231; x=1785362031;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3UirpLV1ZtIxhwqN9P10MkPtE1lhmhI/AHpOOHSx3qE=;
 b=TsqKQ6NxlnAUqCL2P5U+YTF2Y0BXPJkyOnftfIlO9H8HWAIj85g+xRX8V+JH/lRbR9
 inKScCcflf3L3gE+YIL7SKA6duC2JsoUbSRE/GlgH+KXlqVQpuCqwUcja8SsWJlxqUQy
 VS/aAsVmONQ1le2mfadQaWbhEe33HCG/YRdd8H+39QG+tQNxQjVltQGSMZZbTG7czUdi
 mTq7P79IpY1DVRb0Ac2CSwZEVocy3PEGUtz4HsohuH/GhOaMCeSPQrxUdZjI6d1iEWBO
 PSVHsR7XR0nh3ei3V2jOw67EW96MQwwksntKJB59ojxCpPidJaIjiGP2ecwI9/HKg/2v
 w/7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOrHVxbw5NT4zzUegPjPEgj7thMx2UDa4etnxbuktzRxDZheynFwIAM0pGjzcceIVjN+MOZSsGM2w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvhPq5egvV8F2gfavc0/BhpULC0E/SrXVbVolaEMZeIusd0o64
 4cK7TrpmqZSpe9diCa1xyb9H1t8+SYsKlAPHvmxQNKKY/Ij1SG+qakW9C8g/fCjwzKp4ViyNgxj
 vz92U3R2/U2lH7Alz+mAVLrkuRVKiJPSjiy5YlzE=
X-Gm-Gg: AR+sD13/pzEdzoOSKAZ5WBWIziuPcmeztPpUykTruzVTS6Iw32a7yy+QJKuvcMSoqmL
 rrWYVXfu8nlQE9YfxFrwhPKIy43pkz2ZR/Zj+PUVN+iPa7n5NH5RpcBrrUqxoryfCuxu9DGj6CN
 RgsBWSey1FvUZqQzhex4ag1x+aKoByrthF0YEXXn3CKAKgmHNCyYPH59XPSW8P2OWDr+eN3WiGp
 meZCD1KcC7kZhqyJ39nnNpn29mvjbiRyP/5XPriSGGlVem95x5hNu9tBj0=
X-Received: by 2002:a05:6512:3e07:b0:5ae:ae6f:8b09 with SMTP id
 2adb3069b0e04-5b2b0e25fcdmr55344e87.10.1784757230622; Wed, 22 Jul 2026
 14:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260609164047.486227-1-xuehaohu@google.com>
In-Reply-To: <20260609164047.486227-1-xuehaohu@google.com>
From: David Hu <xuehaohu@google.com>
Date: Wed, 22 Jul 2026 17:53:37 -0400
X-Gm-Features: AUfX_mx6lXFHuf0Wgd2wPQM1BjAzgoxGSU-8B31GXW_8srvK8ZED4wSLL-WfrUA
Message-ID: <CAPd9Lg_30aqB6x342xLeFAc4exgXwWzwBc4KWh6+3p-N=yAwsw@mail.gmail.com>
Subject: Re: [PATCH v7] dma-buf: Fix silent overflow for phys vec to sgt
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, 
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, 
 Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
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

On Tue, Jun 9, 2026 at 12:40=E2=80=AFPM David Hu <xuehaohu@google.com> wrot=
e:
>
> In case MMIO size is bigger than 4G and peer2peer DMA goes
> through host bridge, we trigger a code path that assigns the
> total linked IOVA (which is greater than 4G) to mapped_len.
>
> Previously, `mapped_len` was declared as 32-bit `unsigned int`.
> When accumulating `size_t` lengths, this leads to a silent wrap-around.
> This truncation causes truncated lengths to be passed to functions
> like `fill_sg_entry()`.
>
> Fix this by changing `mapped_len` to `size_t` (64-bit). While
> at it, fix similar potential overflow issues in `calc_sg_nents`
> by using `check_add_overflow()` for `nents` and using
> `unsigned int` for the loop iterator in `fill_sg_entry` to match.
>
> Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping=
 routine")
> Cc: stable@vger.kernel.org
> Cc: iommu@lists.linux.dev
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: David Hu <xuehaohu@google.com>
> ---
> Changes in v7:
>  - Added a missing blank line after local variable declaration in
>    `calc_sg_nents()` (Leon).
>  - Collected Reviewed-by from Leon Romanovsky.
>
> Changes in v6:
>  - Used `check_add_overflow()` in `calc_sg_nents()` for safer
>    accumulation (Leon).
>  - Dropped explicit `!nents` check and added a comment noting that
>    `sg_alloc_table` handles `nents =3D=3D 0` (Leon).
>  - Collected Reviewed-by from Kevin Tian.
>
> Changes in v5:
>  - Removed WARN_ON_ONCE from calc_sg_nents() to avoid log noise (Jason).
>  - Added explicit check for `!nents` in dma_buf_phys_vec_to_sgt() to
>    cleanly return -EINVAL on overflow (Jason).
>
> Changes in v4:
>  - Added WARN_ON_ONCE() to the nents overflow check to prevent silent
>    failures (Claude Bot).
>
> Changes in v3:
>  - Removed leftover sentence fragment from the commit message.
>  - Kept `nents =3D 0` initialization (previously stated as removed in the
>    v2 changelog) as it is strictly required for the `+=3D` accumulation
>    loop in `calc_sg_nents()`.
>
> Changes in v2:
>  - Fixed 'IVOA' -> 'IOVA' typo and expanded commit message (Claude Bot).
>  - Added Reverse Xmas tree formatting (Pranjal).
>  - Folded in extra bounds checking for calc_sg_nents() (Pranjal).
>  - Folded in type consistency fix for fill_sg_entry() (Pranjal).
>  - Collected Reviewed-by from Pranjal Shrivastava.
>
>  drivers/dma-buf/dma-buf-mapping.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-=
mapping.c
> index 794acff2546a..80f6ab2f4809 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c
> @@ -5,12 +5,13 @@
>   */
>  #include <linux/dma-buf-mapping.h>
>  #include <linux/dma-resv.h>
> +#include <linux/overflow.h>
>
>  static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t=
 length,
>                                          dma_addr_t addr)
>  {
>         unsigned int len, nents;
> -       int i;
> +       unsigned int i;
>
>         nents =3D DIV_ROUND_UP(length, UINT_MAX);
>         for (i =3D 0; i < nents; i++) {
> @@ -40,8 +41,12 @@ static unsigned int calc_sg_nents(struct dma_iova_stat=
e *state,
>         size_t i;
>
>         if (!state || !dma_use_iova(state)) {
> -               for (i =3D 0; i < nr_ranges; i++)
> -                       nents +=3D DIV_ROUND_UP(phys_vec[i].len, UINT_MAX=
);
> +               for (i =3D 0; i < nr_ranges; i++) {
> +                       unsigned int added =3D DIV_ROUND_UP(phys_vec[i].l=
en, UINT_MAX);
> +
> +                       if (check_add_overflow(nents, added, &nents))
> +                               return 0;
> +               }
>         } else {
>                 /*
>                  * In IOVA case, there is only one SG entry which spans
> @@ -95,9 +100,10 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_b=
uf_attachment *attach,
>                                          size_t nr_ranges, size_t size,
>                                          enum dma_data_direction dir)
>  {
> -       unsigned int nents, mapped_len =3D 0;
>         struct dma_buf_dma *dma;
>         struct scatterlist *sgl;
> +       size_t mapped_len =3D 0;
> +       unsigned int nents;
>         dma_addr_t addr;
>         size_t i;
>         int ret;
> @@ -133,6 +139,8 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_b=
uf_attachment *attach,
>         }
>
>         nents =3D calc_sg_nents(dma->state, phys_vec, nr_ranges, size);
> +
> +       /* sg_alloc_table will cleanly fail and return -EINVAL if nents =
=3D=3D 0 */
>         ret =3D sg_alloc_table(&dma->sgt, nents, GFP_KERNEL | __GFP_ZERO)=
;
>         if (ret)
>                 goto err_free_state;
> --
> 2.54.0.1064.gd145956f57-goog
>

Hi Christian et al,

Gentle nudge on this. LMK if there is anything else needed.

Regards,
David
