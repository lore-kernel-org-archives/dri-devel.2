Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7274BC61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5C5910EA4C;
	Mon, 31 Aug 2026 18:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="VBnzFIbX";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92B4C10E494
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 18:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788199315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1dQ0R9ob+mA/FCDM4U6hP93Z6+K8llHiiFSOPCJL90U=;
 b=VBnzFIbXGnRHnlAFMfp4lm7ic4CuavbelUudw0TBEOI0CYq2lL+pFKjIyKqliGzp+IYSvi
 soulUP0Lu7Pjfd66gAi7uD3R8cFpKGfw/hSKcZyXpjJHdPxPwu+grop1fH+4zmF4WKwSuf
 FwRUDEB+frr8QVcswv+YD0DyxHoIg/I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-AqFDUw1qPjGRSKJ8GPefKQ-1; Mon, 31 Aug 2026 14:01:54 -0400
X-MC-Unique: AqFDUw1qPjGRSKJ8GPefKQ-1
X-Mimecast-MFC-AGG-ID: AqFDUw1qPjGRSKJ8GPefKQ_1788199314
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936e393061dso424779985a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 11:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788199314; x=1788804114;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IydsfYgveubFKZpRxbshazB/ks9+hZoRPru/03kQ0MM=;
 b=GCa+zN055PhZUCO3+1gWCilCRnUk4n8G88AcTHg/7wyueVrna7ISvQa5T/SfppMKsG
 SuiTWOvGHv9pz0UrRcIjZlgUJRsGJzymrUxY5M7dChrfo8e1r3ciV0yoKw6YoIToRs9C
 6iYZqQV8IrSrIHeiedfossPHoD/AmjmfEHmbBjLB67uJZULaqsZdw5MNsYvOIjl+frRj
 jSrKdD4nvk0GfxN3Z5SvYC8kXAOZ1JBFEW9rskvSg48kIbWUsm5XC/juPQXdc/hVY2/K
 33rYh5DZc7+opc5WiraLPF7QaD/YV/yZi6UKSJGvizLwhn2T8+J2pG+m3Fu2Jl6Zds4I
 +Knw==
X-Gm-Message-State: AFuF++lNvvIhLP1RDgDig9xCKvbYmaGh0xodDZvwTNXKFlPQVURSJrQl
 LM+WdpWnVzv9pL7CzGNQlhdwUbewPjEUZ+DsNUJ/vp212vMI2ZXf0XIDkteuZoa4Qz0OVgCfuee
 5GY41+JcAgO/JELDCZsClUolKheT4n+zzbF250LWeB/eS5qAhmQmaJy4q2WqIZOuH6oF5qwRdvS
 3IEw==
X-Gm-Gg: AR+sD127U6m+X831oTvAOKJgaYtwxcMrLQjPUHiUz0axJplV5DMBmY8grkWer4lqBSY
 FSofS9dV91xE8OJesl6eeC/BPJDej3UGnY6990LifkHok24Qt/kID5MfTI1SzS4g45IfYkJc/vG
 T3RP7CvZsEFeVy06QCH/dHVODmNvBMaWVLmDnHF9Eit+XXFWR2eMMPcvgwR8enUD/oafAxvxy8u
 hzRuDiOKIPUzUSSRZY8hato9ADa8gABbSzrHC/dgMyfLgW33gkupwgmMzcoHodaHvkGgV6gGpzF
 2buMxdXb6/UuziT6jRKXnOD18m+KvG4i0Z1MQoGCliQ7UqNmbMmqyriHWGhy6b2sn1JCd9xO
X-Received: by 2002:a05:620a:2991:b0:939:36f3:fea8 with SMTP id
 af79cd13be357-93936f400d5mr1116969185a.25.1788199313589; 
 Mon, 31 Aug 2026 11:01:53 -0700 (PDT)
X-Received: by 2002:a05:620a:2991:b0:939:36f3:fea8 with SMTP id
 af79cd13be357-93936f400d5mr1116956085a.25.1788199312920; 
 Mon, 31 Aug 2026 11:01:52 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9391700a637sm840604785a.5.2026.08.31.11.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 11:01:51 -0700 (PDT)
Message-ID: <6c3656fb11362f9011fa71febfb5e55c96404d78.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/clk/gk20a: fix undefined behaviour in
 signed left shift
From: lyude@redhat.com
To: Muhammed Sariyildiz <asiyee994@gmail.com>, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Date: Mon, 31 Aug 2026 14:01:50 -0400
In-Reply-To: <20260810214247.21416-1-asiyee994@gmail.com>
References: <20260810214247.21416-1-asiyee994@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nF9X8wcxywLfm4hJ3akqtRu4Ldpzhb55y3UaCqUrNiQ_1788199314
X-Mimecast-Originator: redhat.com
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

Sorry for the delay, this one slipped through the cracks.

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to drm-misc-next in a moment

On Mon, 2026-08-10 at 22:42 +0100, Muhammed Sariyildiz wrote:
> MASK(w) expands as ((1 << (w)) - 1), and
> GPC2CLK_OUT_SDIV14_INDIV4_MODE
> is defined as plain 1. Both are used, via GPC2CLK_OUT_INIT_MASK and
> GPC2CLK_OUT_INIT_VAL in gk20a_clk_prog() (and reused by gm20b, which
> includes gk20a.h), to compute:
>=20
> =091 << 31
>=20
> Left-shifting a signed int into its sign bit is undefined behaviour
> per the C standard (ISO C11 6.5.7p4), and is flagged by UBSan and
> static analysis tools such as cppcheck (shiftTooManyBitsSigned). Make
> the shifted operand unsigned to fix it, matching the pattern used
> elsewhere in the kernel for register bitfield masks.
>=20
> No functional change intended.
>=20
> Found via static analysis (cppcheck --enable=3Dportability) while
> auditing nvkm/subdev/clk for correctness issues.
>=20
> Signed-off-by: Muhammed Sariyildiz <asiyee994@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.h | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.h
> b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.h
> index ea5b0ba..7a93f9f 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.h
> @@ -27,7 +27,7 @@
> =C2=A0#define KHZ (1000)
> =C2=A0#define MHZ (KHZ * 1000)
> =C2=A0
> -#define MASK(w)=09((1 << (w)) - 1)
> +#define MASK(w)=09((1U << (w)) - 1)
> =C2=A0
> =C2=A0#define GK20A_CLK_GPC_MDIV 1000
> =C2=A0
> @@ -79,7 +79,7 @@
> =C2=A0#define GPC2CLK_OUT=09=09=09(SYS_GPCPLL_CFG_BASE +
> 0x250)
> =C2=A0#define GPC2CLK_OUT_SDIV14_INDIV4_WIDTH=091
> =C2=A0#define GPC2CLK_OUT_SDIV14_INDIV4_SHIFT=0931
> -#define GPC2CLK_OUT_SDIV14_INDIV4_MODE=091
> +#define GPC2CLK_OUT_SDIV14_INDIV4_MODE=091U
> =C2=A0#define GPC2CLK_OUT_VCODIV_WIDTH=096
> =C2=A0#define GPC2CLK_OUT_VCODIV_SHIFT=098
> =C2=A0#define GPC2CLK_OUT_VCODIV1=09=090

