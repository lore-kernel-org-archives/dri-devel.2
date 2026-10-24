Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209A5606A31D
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 07:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C6lSPrKN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB3D10E0E7;
	Sat, 24 Oct 2026 07:06:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 535BA10E78F
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 07:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792825564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oqxBdCmRUh/o3pj/13O6zevxwBIO3ke0ZjDeWjPvwqM=;
 b=C6lSPrKNRZt2+ZmLdcIO7sRXckFtfeC4LYmdZgV6MpoLLRWhi17IVUqWHuG6fvOj5fg2bQ
 RK4ZYpCG5YocfpmzBVFkX2ISAc1bz3GJpxVedtqS8H61Fz5R/ikWFTzyR1XxKi2dTNNi/o
 sBe77kc+dybRPHP2PiJXcbGATOvyKzg=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-0hmFvd4UMR-AgqJpiDNksA-1; Sat, 24 Oct 2026 03:06:02 -0400
X-MC-Unique: 0hmFvd4UMR-AgqJpiDNksA-1
X-Mimecast-MFC-AGG-ID: 0hmFvd4UMR-AgqJpiDNksA_1792825561
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3692c5b061bso5059391eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 00:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825561; x=1793430361;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oqxBdCmRUh/o3pj/13O6zevxwBIO3ke0ZjDeWjPvwqM=;
 b=pUKUqF46x4JMY3nJuJI4wctv417IO/hy8oz+312o54rWQlD5c0dqxznr/tRb4MbKoF
 /H0L0yVWwupHusrFgrQBAC0JqgktovYLY2yw00yYMN5UEPl+o9LzzQUnDnIJsx4CerZJ
 +x/Ua4eMkQynqSNeU6bX/GCUPqIJNVM1gn1VFygYauAcXwlTVPFALdIFhXuNopayn8Rz
 iR2vDw1gpYDN/YH3NDZVYHpgo1gqu2H58juue0fgZQ024jIo2t3owsWSOmUxsHS4n470
 9r7xncK0oxoGcCwBrRPF/043yoisypRZcXNsp13H4KCogty9AeYdYqQLMkma7AIukaft
 dZDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHB1o6NRg/hYa9LGId4mGOsWrqkCAn2yLUXnwu60YzzbG7b69zBiwlQWGaGZXoXG2+zOoaESXgZzQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIyP09JAIl6uoJU+yXdWXMcYTBex8wdTR4/hoDGc0Zf/YYv8dIB
 8QLpMA+kcIWq1muUp/eThMz9N4kUoSZN7rEdEj1oKyu3Molz0MkKQjSSQ3UlJmd9OY5w0kGSaPu
 5NyJkTO/ua0La9EjsTQx1LqF/66YsVe/N0rNiIt+9TDGqZt2W40pTrdJcLLXcU4mksXnhNZl38s
 i8eBQ4GihBcMmp7zSQMDDUc6JtQU4tdPxxJKLnCq/+S9x6
X-Gm-Gg: AYBFou0s0m3hGs7h+3OTv6Xwcgv4hfniBgHz35WV7ITDev37UYxiBYGSSXn3pB0yZqB
 rFwYK6ax4iYaRj8nnXp6QIwXYR9C5KhFn0s4jvi7+qfd6B56xbUkl5NY/X5NBaTg75/thy71HCm
 QCe76p+xvnhzQKVJY6oZ+vTCD2ErrS61tgge4nfJk2TloW+QaJORjOXW3Dp2lZgfMNmMt10w9ZB
 bepYnZiJVk+dLj+
X-Received: by 2002:a05:7022:f90e:b0:165:aced:1fde with SMTP id
 a92af1059eb24-1991b421e8dmr1507378c88.0.1792825560707; 
 Sat, 24 Oct 2026 00:06:00 -0700 (PDT)
X-Received: by 2002:a05:7022:f90e:b0:165:aced:1fde with SMTP id
 a92af1059eb24-1991b421e8dmr1507363c88.0.1792825560145; Sat, 24 Oct 2026
 00:06:00 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261023-nouveau-gsp-irqdest-v1-1-5dd6131faa14@sudmix.de>
In-Reply-To: <20261023-nouveau-gsp-irqdest-v1-1-5dd6131faa14@sudmix.de>
From: David Airlie <airlied@redhat.com>
Date: Sat, 24 Oct 2026 17:05:48 +1000
X-Gm-Features: AclHuK-0XItFovw3G1bBVKRVCBplwABReOzmq7h2Qp7p5fFLlK5pknGM07AUT98
Message-ID: <CAMwc25pyuJxHJnziCvorWvFb5awsgn9RZeYQ8GXpQ3Vzs7ro6A@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/gsp: only handle GSP interrupts routed to the
 host
To: joe@sudmix.de
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Ben Skeggs <bskeggs@nvidia.com>, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oyvMcAT2Y2ZNVO3pmH-eXqc8bHYZF03Sj0UkPXpbeDY_1792825561
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 7:38=E2=80=AFPM Joe Finzel via B4 Relay
<devnull+joe.sudmix.de@kernel.org> wrote:
>
> From: Joe Finzel <joe@sudmix.de>
>
> The GSP's interrupt handler takes every pending interrupt the RISC-V
> IRQMASK enables as its own, without looking at IRQDEST, which says
> whether an interrupt goes to the host or to the GSP itself. One that
> belongs to GSP-RM, pending when the host's handler runs for the message
> queue, is reported as unknown, cleared and masked off with IRQMCLR,
> taking it away from the firmware:
>
>   nouveau 0000:01:00.0: gsp: intr 00040000
>
> NVIDIA's driver reads the interrupts routed to the host as
> IRQSTAT & IRQMASK & IRQDEST (kflcnRiscvReadIntrStatus_TU102() and
> _GA102()). Do the same, with IRQDEST from NVIDIA's register headers
> next to IRQMASK on each falcon.
>
> Seen once in a few boots on an RTX 3070 Ti (GA104, GSP-RM 570.144),
> before the login prompt. There IRQMASK reads 0x01049042 and IRQDEST
> 0x01000040: 0x00040000 is enabled but routed to the GSP.
>
> Fixes: 830531e94712 ("drm/nouveau/gsp/r535: add interrupt handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joe Finzel <joe@sudmix.de>

This seems very reasonable.


Reviewed-by: Dave Airlie <airlied@redhat.com>

> ---
>  drivers/gpu/drm/nouveau/include/nvkm/engine/falcon.h  | 1 +
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga100.c       | 1 +
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c       | 1 +
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c | 4 +++-
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu102.c       | 1 +
>  5 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/include/nvkm/engine/falcon.h b/drive=
rs/gpu/drm/nouveau/include/nvkm/engine/falcon.h
> index 341f133dc38..eb8adaf07fe 100644
> --- a/drivers/gpu/drm/nouveau/include/nvkm/engine/falcon.h
> +++ b/drivers/gpu/drm/nouveau/include/nvkm/engine/falcon.h
> @@ -63,6 +63,7 @@ struct nvkm_falcon_func {
>         int (*select)(struct nvkm_falcon *);
>         u32 addr2;
>         u32 riscv_irqmask;
> +       u32 riscv_irqdest;
>         bool reset_pmc;
>         int (*reset_eng)(struct nvkm_falcon *);
>         int (*reset_prep)(struct nvkm_falcon *);
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga100.c b/drivers/gp=
u/drm/nouveau/nvkm/subdev/gsp/ga100.c
> index d5126fe39d2..10e2813a016 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga100.c
> @@ -27,6 +27,7 @@ ga100_gsp_flcn =3D {
>         .enable =3D gm200_flcn_enable,
>         .addr2 =3D 0x1000,
>         .riscv_irqmask =3D 0x2b4,
> +       .riscv_irqdest =3D 0x2b8,
>         .reset_eng =3D gp102_flcn_reset_eng,
>         .reset_wait_mem_scrubbing =3D gm200_flcn_reset_wait_mem_scrubbing=
,
>         .bind_inst =3D gm200_flcn_bind_inst,
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c b/drivers/gp=
u/drm/nouveau/nvkm/subdev/gsp/ga102.c
> index b6b3eb6f4c0..96fa26fa612 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c
> @@ -140,6 +140,7 @@ ga102_gsp_flcn =3D {
>         .select =3D ga102_flcn_select,
>         .addr2 =3D 0x1000,
>         .riscv_irqmask =3D 0x528,
> +       .riscv_irqdest =3D 0x52c,
>         .reset_eng =3D gp102_flcn_reset_eng,
>         .reset_prep =3D ga102_flcn_reset_prep,
>         .reset_wait_mem_scrubbing =3D ga102_flcn_reset_wait_mem_scrubbing=
,
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
> index 94925f1590e..463e463db24 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
> @@ -64,7 +64,9 @@ r535_gsp_intr(struct nvkm_inth *inth)
>         u32 intr =3D nvkm_falcon_rd32(&gsp->falcon, 0x0008);
>         u32 inte =3D nvkm_falcon_rd32(&gsp->falcon, gsp->falcon.func->add=
r2 +
>                                                   gsp->falcon.func->riscv=
_irqmask);
> -       u32 stat =3D intr & inte;
> +       u32 dest =3D nvkm_falcon_rd32(&gsp->falcon, gsp->falcon.func->add=
r2 +
> +                                                 gsp->falcon.func->riscv=
_irqdest);
> +       u32 stat =3D intr & inte & dest;
>
>         if (!stat) {
>                 nvkm_debug(subdev, "inte %08x %08x\n", intr, inte);
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu102.c b/drivers/gp=
u/drm/nouveau/nvkm/subdev/gsp/tu102.c
> index 11a37963bd4..823532758af 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu102.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu102.c
> @@ -420,6 +420,7 @@ tu102_gsp_flcn =3D {
>         .enable =3D gm200_flcn_enable,
>         .addr2 =3D 0x1000,
>         .riscv_irqmask =3D 0x2b4,
> +       .riscv_irqdest =3D 0x2b8,
>         .reset_eng =3D gp102_flcn_reset_eng,
>         .reset_wait_mem_scrubbing =3D gm200_flcn_reset_wait_mem_scrubbing=
,
>         .bind_inst =3D gm200_flcn_bind_inst,
>
> ---
> base-commit: fb26cf4f1df40a462ea65552a3fbcc8cfafab523
> change-id: 20261023-nouveau-gsp-irqdest-a0819d1eda96
>
> Best regards,
> --
> Joe Finzel <joe@sudmix.de>
>
>

