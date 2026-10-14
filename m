Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DC9C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3714F10FEB4;
	Wed, 14 Oct 2026 16:47:43 +0000 (UTC)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com
 [209.85.217.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44D4310FF2B
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:47:37 +0000 (UTC)
Received: by mail-vs1-f54.google.com with SMTP id
 ada2fe7eead31-7c7ffa979fdso103793137.2
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:47:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996456; cv=none;
 d=google.com; s=arc-20260327;
 b=ikihtDwSDxhW3nl5HdP/+SWQlQz9SLDu9NHwYqj/CMCyr2Mzy/AlbJmB3kthP/4RIk
 USduiP4bXLsrghu2Y3IQYYQA1Uv0szyKlVy2HPfhbpxsUPrMqRybkbt5rdlsFQHA4JuM
 mUnvdfPQcrmAagyKcPc/MY+Zu0Dr8+LXy5l7ROhkiviXWfv3UrGr9VWVohwEg2uVG0pR
 j017mWNpVJGv2XX1nAS/HwfGlBRJdJakMmStqxXUr4FNQhIjyhXdW8+iPuJog9q5yhgH
 zHB/Z7X0qSm2Gd/2iPi3TZFfKA+w3nBYJ4natQsoZWJDSjrvGSJ7OkwyruQdzhNJWRZq
 DGiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aY4wa9XVG4bLBUrDNf/alpBmZD4Uo9u08+8/BssSkZ0=;
 fh=gUMi4CSbIAKOu2OpuWKl9yy/5xevSjo/rfgeYkZuF+g=;
 b=st/bLj3r8+ME+TDtLIwnaMOTYuXREo2k2F7Phb/qhd+sHYsnuw2S0AOP+M+Q/9hzrZ
 D/k1pFUce6APRgfcRzB+bhpuwSzb82WVAih9kcqXDDlvOUeX7PF3W12WPOZycENjubnP
 JGvg/JhcIOLrUu/01j/0pFyd6fLTl+tn94YjUHp2OItN22X6nsj5xTfqosJSxjobM98y
 I5cFu5POES7RxI9QEcNC6FtcTvgH/fqYlqlHida/r6lSbnhZ67QQV9isCXLwNPqcXmaf
 zWNWHVca6KeUPjRJsJzujq+HRNyZ6phJ/akCtiw63fKApNCxdaM2BAnSc6PtA20qeIYp
 H96g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791996456; x=1792601256; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aY4wa9XVG4bLBUrDNf/alpBmZD4Uo9u08+8/BssSkZ0=;
 b=W3b0BlJZOD8HiXgUbLz+iyk8sjppk90//guEsFE4Z5xj6jCsXPoIb37c9Yy01ULo1L
 XaRM+G5DtlwAxs0z60sgen+loGoufdF3lJOmJ8LR6AnC4dYvyAfxMX/tPV0Edq6BEmoq
 6pkFFcify2aoy2Bf1i6ELlXXNPw6E4qVS/swe7GDzcB2jniZlk/wFMZrSqFKPqIpcJZC
 5ac+Lm7YLgH/KJ/4VknA9zaJBCB9IyvDQt11ziAd4mGf8DpGSGEkeEoLPjiPPlODG1rd
 7lhUZ7AkVv6qiFOUdxzPsRzTm7+d5Ttk+W12BWmZQpcsextD6sL/5jXes9WodxZYKw9r
 QM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996456; x=1792601256;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aY4wa9XVG4bLBUrDNf/alpBmZD4Uo9u08+8/BssSkZ0=;
 b=XBymysuTxIdgLtJ5aEfTRcGyEBop4yB4u6/mG9RVptGZDpi4zF9VUyjjkXVeryumJe
 oeSs6Na7R+s+vWk0l2i/dp1ZyUhMg0L3vJWfyZH0dU8K9NirJD6nKHGg9Q+A0PoCAOdF
 DxM5E2zWu1TywsJ+YaQU/EmxLhRYL+5esvso9ZRfDnSj7HigMQEWvkeuMSe/E0nZF8DG
 waCLbD05cicg2R+zytCet8SFrV8t4O+3Wu4y+WFgx3R6OPxQ13H85Nc0LYzST4kSoi2G
 lRcyMc6XH2U2TKe/XhIgoKN2YBb4SKy9JkLyzrQC0hcRJIojC25cG8nLlsYnvFf6m+Qa
 eeLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxe4Pc1ZZdhbxPlqRZy62DNMZb3sTz1waSpD0RtvLT/qhhjr7Zn9fiBefZL54jmciYYt3AgieQL5v4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI8mLci8ppLcm4NTTBeFapCwYHdMtOcdaFhkoRHQ8dD6+F1VLP3
 SkDF1XIQVhx49dzt7j/RsDPJsozOq/EpR/VlB6Z+pfrYDux7rJtRoGJjcvOx94Nm8lrG0/HV8u+
 FeW8Ds+hG520TbRSIpYq3gMDOXr6pad0=
X-Gm-Gg: AYBFou2u4ADZTedYZ9F2Y2HtsGAdUk2YyCcZFLc6TZ4M/+8Bork1fpi1UMc7dowCmtp
 trg2HyrZjtjEjibOBSNIQm/TFHazFgtK9wG4xv04NJYefHCULwVrz2O41qt9MUc8e3lCOV0WTln
 hQl83Ir0LWVBdIoEJiemNBfPIboDiEC4EZblOicAWrGG5GTbcxDFKYiLBLxYlefKSHI0Jy69WYI
 yf15NFuF9JsGrVaxhJvsmRg3w8Dp9AyPCBMJ1P1PYdRayhkStpTZJfMjevkNn0o6njtStZ17cvB
 o8iBbUo3z5XiPqrRb6/r8X+tscaMpNL1eHmFTM2IsoOUYlxfH9w2ZRwEKlxiYz5EzotXGJ3PJyK
 XiSCUy2PtYlpaEQQX4ZAtEFui9Ma/VamWCurWsvz8qcezbCkPi9Fu
X-Received: by 2002:a05:6102:a4d:b0:7c8:3b8c:82ae with SMTP id
 ada2fe7eead31-7cb372321bdmr4394184137.2.1791996455921; Wed, 14 Oct 2026
 09:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20261014002858.172853-1-williandossantosdeoliveira287@gmail.com>
In-Reply-To: <20261014002858.172853-1-williandossantosdeoliveira287@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Oct 2026 12:47:23 -0400
X-Gm-Features: AclHuK-US1t3rz7_G3sKamqA-AukmKWflQ6FjzYQPCWKb7Z5Q5Xcc6YpUewNkao
Message-ID: <CADnq5_O0gGsDD96KkCTc71rPh1QJsBnWPw_XVvuwRoRQ9Wbhjg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx8: remove redundant RLC cleanup
To: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

On Tue, Oct 13, 2026 at 8:46=E2=80=AFPM Willian Oliveira
<williandossantosdeoliveira287@gmail.com> wrote:
>
> gfx_v8_0_sw_fini() already releases the RLC objects used by gfx8
> (clear_state_obj and cp_table_obj). The generic
> amdgpu_gfx_rlc_fini() also frees save_restore_obj, which is not used
> by gfx8.
>
> Signed-off-by: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index 7f91186ef1d1..088428e41f44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -2059,7 +2059,6 @@ static int gfx_v8_0_sw_fini(struct amdgpu_ip_block =
*ip_block)
>         amdgpu_gfx_kiq_fini(adev, 0);
>
>         gfx_v8_0_mec_fini(adev);
> -       amdgpu_gfx_rlc_fini(adev);

I'd suggest dropping the explicit free calls and just use
amdgpu_gfx_rlc_fini() for symmetry with other gfx IPs and the rlc init
calls.

Alex

>         amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
>                                 &adev->gfx.rlc.clear_state_gpu_addr,
>                                 (void **)&adev->gfx.rlc.cs_ptr);
> --
> 2.47.3
>
