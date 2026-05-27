Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D1ACD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 20:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F05E10E9DF;
	Wed, 27 May 2026 20:37:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="rS20odPz";
	dkim-atps=neutral
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D91B10E9DF
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 20:37:09 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5a86d384ca6so36e87.1
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 13:37:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779914227; cv=none;
 d=google.com; s=arc-20240605;
 b=dj8H9MI8lOy/woAQr/zJLVnAfHEObSBCxhF+kTQ2dGjP6XirzQNm+wCOXFEzuiIA6N
 DyT2+z27kjAj5Ll6pICwdvyyk4ZVra8/5/BhY2E5rcLtrNG0IDDGkQrDe8TEstjDEK04
 px2+x+V4wUosztxW7G+MTQ8mA77+NVmOSmxU2U3ohZV375jEAHVy0wYEKoHXfdOHUYKu
 GqUr0bq+MZZUoTIENKpfT3pqwiOZEn1EnHLZIYjHFPZ6Lu4vgQS8oKq5zgVDWIjqqEYj
 aW2X94IjMefMOgcre/QhGfkrK1ozExlGvPGJh/4jJj9DnQky+7PXgy2R1XsqP6M7tvJ3
 kFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FiFa1Df4saC1J/ZGIYY64ADBjJ4UDzy5361EO2Lv5uM=;
 fh=6RajussRuR1Bbjn4/l3ltI0wUEsjFM7bz3VH9RP49gU=;
 b=WHZreIwE8P+Us8uYyciUXDfu5kvWtM0zIm/ixmmZUM3wOsgr1uMuc1RReiJcEJ69q7
 K7zfjOzRmGN2QB9AgeYYmKGduPz9zGznLzYPAzhBJR9Rv0XgoRZ/606vSoKJ78YZHMoj
 8Tpx/axo1jWKWqJFIdmbneG+IO3Fch9sx//ywUQjxjJzgPIa/HmB/ti1ngO6twqmtKf8
 iXfwe7rr2LzNLzASBnzN6cgYrBvWF6zf9ogzKUF/787YNZW9Z8BcjOL437yO53VZkcg6
 wLry46FKMuTyNd6j8KEGgNiXxSD4d7vGJOx3pBe77d9kmsNXVVTGaWCKGpXjvUgf2hmk
 A1Sg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1779914227; x=1780519027;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FiFa1Df4saC1J/ZGIYY64ADBjJ4UDzy5361EO2Lv5uM=;
 b=rS20odPzcpeN+8MdsYleA17RejvMArwQRgjMpXQdUqxEkHIwpDdgjEkVGW045Yu+R8
 5jpGy1NUYAJR6qtHmwOtCxbd9YpQKNIKNg3qa95ctFxMl4AucDPx9Fj7S87eTUb8GNOQ
 zWSwMCCUVE/H55TVQf+hxHuXLGbKZ3OkMiOPdqXPCst2GHnM4XD2rH+DGwG5smxdBbyl
 8vFIpI0Vyx6ip1b+RN2KkLTX5nQxe8BL07fbwgBdiMsnKAwj9RpVwZMisV4xAgVpqCRt
 Nvg38sWv6WnP3m1QUehkPScQarToZllrEwecDTcvxS7pL7NmrJkJHYe67bqkJ09jbDjY
 mjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779914227; x=1780519027;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FiFa1Df4saC1J/ZGIYY64ADBjJ4UDzy5361EO2Lv5uM=;
 b=hTg63oONa4J5CrqqeTzCNmW8r3GjoTdxVuha4rl+K4QvM8KZhPDwS618EL2eEozxVj
 0vdPCibm+xlUBe30E2MxwpcBOH5xWD1e16K3NpJ15ct2T/s01BjQqNK58njK8QugXiUU
 8g0ujm/URehCNw6Er42Nefe+gPxlZS+jM2hRd9J9SWi3qdxTKfFUyHK32afgnbQxVUqS
 RX9UpO9K36i8qbUcpfCKpzELcVY3J+9WJM+YKEdXRe/NGK5RFBBCaAnvxlsy4MC9uv5t
 +lVOudiSKF7zWdZ8w+XXZRn8yR0DXqA7QkvGYb2sFB2RJ8hJxevMe19tPBJYpucK1hXd
 c4MQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9b0f6nhIEXFQ86TAMf2nI2Opwly/VQLOq5MG8iM2wter/T7WNI8ffGVAx4BqDTa5nU882diShkgK4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzbtHqE+H8tlTIrEfYDGaEpcumecVVy3NeZk49vgFJUENK/tXgx
 5RA82gYb8hawa+z/0qUR9cfO5LQO0Uf7V/gjypK97IP2UnMhoUBCwuLhX771V1XejgnGXIwtJfU
 s8scQZcw/VGpryq+JDMn8TddjFuICfwUdUPCs4Fg=
X-Gm-Gg: Acq92OHRKMpqGYvyoIgj+wACZ64vIFqkb+2y6X9asbK3ZfhZUYn1uRKL9fqrgkqyrPD
 D9KcCG0gnY6w2FY52XKcBFX2wizCpwB76E7ZagwZGjAV3tJP+HZwzZSRtWsp2UjEneYUkFJ63OQ
 6QrLUfN1VzERtFMiFFe1lzaZgypN9vaT5Nt1P/IXUeCG3diMmY8sNRTzpDhJtr3xsCpkDeb2ec9
 lt7+jH6i5XkbeXrY1xaH3ow5mnYeGOUNcIZcUPq4hdgiKaxzwLpQGt9k8Ph8HrVc+sPLjZtKcd8
 kgLYPgXq4Pajc+haX/igfPhq4FHaXl7D+MDwnG1FTosMoOA=
X-Received: by 2002:a05:6512:134a:b0:5a4:462:a470 with SMTP id
 2adb3069b0e04-5aa4ff92e07mr24638e87.7.1779914226791; Wed, 27 May 2026
 13:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260511214243.349487-1-xuehaohu@google.com>
 <20260526173350.2359263-1-praan@google.com>
In-Reply-To: <20260526173350.2359263-1-praan@google.com>
From: David Hu <xuehaohu@google.com>
Date: Wed, 27 May 2026 16:36:54 -0400
X-Gm-Features: AVHnY4IF3I2qsMWkH6V2x0MBlfaofpaRNxk4VxA3EVoNIlcP5hkGNNAtRYxgcFU
Message-ID: <CAPd9Lg_aXizh0R1wnRitwVRMdh5SmfUmLiQLyF+EJ31yFeLYJg@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: Fix silent overflow for phys vec to sgt
To: Pranjal Shrivastava <praan@google.com>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, kevin.tian@intel.com, 
 ankita@nvidia.com, jgg@ziepe.ca, alex@shazbot.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 jmoroni@google.com
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

On Tue, May 26, 2026 at 1:33=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Mon, May 11, 2026, David Hu wrote:
> > In case MMIO size is bigger than 4G, and peer2peer
> > dma goes through host bridge, we trigger the code
> > path to assign total linked IVOA, greater than 4G
>
> Nit: s/IVOA/IOVA
>
> > to mapped_len, and leading to a silent overflow
>
> > Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mappi=
ng routine")
> > Signed-off-by: David Hu <xuehaohu@google.com>
> > ---
> > drivers/dma-buf/dma-buf-mapping.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
>
> > diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-bu=
f-mapping.c
> > index 794acff2546a..658064140357 100644
> > --- a/drivers/dma-buf/dma-buf-mapping.c
> > +++ b/drivers/dma-buf/dma-buf-mapping.c
> > @@ -95,7 +95,8 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_b=
uf_attachment *attach,
> >                                        size_t nr_ranges, size_t size,
> >                                        enum dma_data_direction dir)
> > {
> > -     unsigned int nents, mapped_len =3D 0;
> > +     unsigned int nents =3D 0;
> > +     size_t mapped_len =3D 0;
> >       struct dma_buf_dma *dma;
> >       struct scatterlist *sgl;
> >       dma_addr_t addr;
>
> Minor nit: Let's follow the reverse xmas tree format?
> This looks correct to me, for this change:
>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
>
> Apart from this, I see similar issues at other places:
>
>   1. In calc_sg_nents(), nents is accumulated as an unsigned int. [1]
>      If nr_ranges is very large, nents could also overflow, potentially
>      leading to a small allocation in sg_alloc_table() and a subsequent
>      out-of-bounds access in the mapping loop. It might be worth changing
>      nents to size_t there and adding a check against UINT_MAX.
>
>    2. In fill_sg_entry(), the loop variable i is an int [2]. Changing
>      it to unsigned int would be more consistent with the nents type
>      and safer for extremely large mappings.
>
>
> Maybe, we should also fix these? For example:
>
> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-=
mapping.c
> index 794acff2546a..ecf07ffca2b9 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c
> @@ -10,7 +10,7 @@ static struct scatterlist *fill_sg_entry(struct scatter=
list *sgl, size_t length,
>                                          dma_addr_t addr)
>  {
>         unsigned int len, nents;
> -       int i;
> +       unsigned int i;
>
>         nents =3D DIV_ROUND_UP(length, UINT_MAX);
>         for (i =3D 0; i < nents; i++) {
> @@ -36,7 +36,7 @@ static unsigned int calc_sg_nents(struct dma_iova_state=
 *state,
>                                   struct phys_vec *phys_vec, size_t nr_ra=
nges,
>                                   size_t size)
>  {
> -       unsigned int nents =3D 0;
> +       size_t nents =3D 0;
>         size_t i;
>
>         if (!state || !dma_use_iova(state)) {
> @@ -51,6 +51,9 @@ static unsigned int calc_sg_nents(struct dma_iova_state=
 *state,
>                 nents =3D DIV_ROUND_UP(size, UINT_MAX);
>         }
>
> +       if (nents > UINT_MAX)
> +               return 0;
> +
>         return nents;
>  }
>
> Thanks,
> Praan
>
> [1] https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/dma-buf/dma-=
buf-mapping.c#L39
> [2] https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/dma-buf/dma-=
buf-mapping.c#L13
Thank you Pranjal for the review ! Good catch on other potential
overflow sites. I have folded in your suggestions for calc_sg_nents(),
and fill_sg_entry(), and applied reverse xmas tree formatting. Sending
out a v2 shortly.
