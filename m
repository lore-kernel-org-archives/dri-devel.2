Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0C2C5DF7E
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DB5010E032;
	Tue, 18 Aug 2026 13:01:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ncf9CSgv";
	dkim-atps=neutral
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 389D110EB2E
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 13:01:56 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-4ab3c6f7f44so240133b6e.3
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 06:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787058115; cv=none;
 d=google.com; s=arc-20260327;
 b=FBZazvyib1Jv2Lp4DcPcZojIWF9gonGEGHc45lgzHSGA1tTAbNEpygAjdtuaU8mP77
 vGwhmGyeiFJ6/Yz6RZ7NCYJcu1c5nrABC6/Ba/SHSsHU6g1xkO50djxZwo6BnGjjFEzE
 cw75CbaxVNpS7pJjFIbOWVfccJHS6zv8xn9ne0it2qRFa98yf12AOiu17GO3vw5FFQVi
 ELsFzzFsjLZkJkQPwZ6o1OzafTf00Gc6H//IEmLtkGq+j3OA0Irq29Arfcm8N1hp3hCB
 A2D3DtWZx9ccUEtWr6xoZGC1/P0DykatfqxKVMSRDuFQE1TI9gkf+qEehTPEXmolTq16
 A8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2sR3aNG32XYVP0yTYM0eLVTqpaeukTauG89+RJpryw4=;
 fh=NewRLJIr+MQM+Kbn9EsRiKhcRTmu8hAOMO+CdkvU9Dw=;
 b=id8nOKf/5qcdTk9/Kvsa/hl5MJS8ncj6gftWUHu66452Qr1CTwapT3NjyLWUP6DviR
 R8iMMhoEMhUa0gMJkQu0SgVLZJvw4fcrGeqTJoKoJ3ZIp+aJHOZKTXKUszEptk+kmffb
 If28ckyEpKEkJdQwEAu1FQ8TbALEyVEAV7xRIJvzL2n1VTGH0z5KbSjA5y3nfoPfjS8B
 bJaXpDuQvlKigpwkjM+Gh76WPQtHjhcguUlHAdUudLachLef96pTV7XwG/huITYiF/u+
 Bul+mxyJwbvZzvIrqrBRq4mtLcpZW27K8k8JGw8PWhWQK78zyeZfDczwmcytwdpzKdkj
 KMgg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787058115; x=1787662915; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2sR3aNG32XYVP0yTYM0eLVTqpaeukTauG89+RJpryw4=;
 b=Ncf9CSgvV2IIFjoHBGw7LAax9y/iosgbJ8wiAEGIpIcIo2WOhkqvw0eTi553kIUYmO
 9NRLBOhpFkBjljgsZpv2+EveOyBjxZIDzieo/jZA6L87TNLIhY1RaLPiERV/vZR51LLM
 Gf+JjcDMVbyEnK0tpnpgg6WKfGvgOH5nChPe9DOMSl/Vgz54tIdHu6+/KocAjuQTrcmw
 sSicne08rVd7C+9opH8xVmzbxOPBxvgwf1I2UNfOqDsTDAtPbytQE7OEkabxmasRomaA
 8QDF2W9+Lr/kZnfgX73jTpXsgKL8R9/2ypGYzqm4xYIiiFkF5nthNgqyeOrguScJ4uRA
 qh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787058115; x=1787662915;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2sR3aNG32XYVP0yTYM0eLVTqpaeukTauG89+RJpryw4=;
 b=fGFBW4eSBdOgu9IEU5FYseaFDIgBEin2ZWMqvXArJv3Pg1oOBphxqNhvgreIX0vCZC
 OrRCQaaNBBGLI3ZbisNCLJpBr4XF1sWJhd2dlqm6bKzYGfkyuAbp9eOIf55IA69mk4Nn
 MK3W3W1GzW9D3upxxpWmB9XJEkZ47zSbDV4382m1IFK3LeCkle3lm/D12V+VOX6tk8lz
 6g8ciNkT0auPX/zlIEH1kBiwEol/e1QGH1KKz14p75flp7rk0tTZ77mSSI4AMn4rTMl9
 9lu1FWQJ5LVQcL1Z+g8sMA3NIsLbxn2k0yBcaXT08vLINKDBHbHDnGjyobw1WicaSxw3
 K/vg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrypPwBi+uFO4CM9pxTihVcqrfU+lfPwOWA3RJwvHs4xUN1SM+QSM490Ybxxjsu8rRT2/kzU+q/xWI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yww5FBNyVB/pt5LTbTM2p4mzZSSVO/rWAVGBRClJbd8QqF7qAMh
 6BJf8W2KHGxasl9zIpDGZHEFJncThVJXhnBMmKehkET6Av+ixnyIXFecvkJObpoc71dza7ufJ+a
 sJMnJOhSJICmb3SK1WXbo2lK8PIqLlec=
X-Gm-Gg: AR+sD12KquVxZ517Ab+ypT6UtgDBxCknPHw97vMFRhRXApt1HSJZ8U0yyC7TFmSL8Y7
 7imSHp0V01hEm3gTNQv4pPkT1SwO8GE0djZMXdvAicMrracmaY2p2HTwBvZ/bMdyJeXeZM/kN2b
 1P9f3ZCHC2RHr+AGZFwDG33KRIgo5yVeTjWCkitlY//Y8sQv4ecp1DLwj/rGASszZQ7aIOjPcXP
 sJMrJnU+/D9vXlYqp6QX5/gBWLkBYZg9xbcPRYr3F21Cqm/VnH41CXVbwPGvhHY4bYX4pNsH4w0
 fDr+OozKDxp3BtYuGBahmeT4ZgRUYEi+C4atvIRqbb9TezGg2lx4dlzI8jv72SzQSfNtwmfkAXc
 7/u0kn1X6WUPNK0rZIsTAJY9jmN0zNW8=
X-Received: by 2002:a05:6808:c3ec:b0:4a4:866:c2c0 with SMTP id
 5614622812f47-4b241e6d577mr17018295b6e.4.1787058114852; Tue, 18 Aug 2026
 06:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260818-amdgpu-strcpy-v1-1-3ee9b111fafe@gmail.com>
In-Reply-To: <20260818-amdgpu-strcpy-v1-1-3ee9b111fafe@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Aug 2026 09:01:43 -0400
X-Gm-Features: AcwNN1UXAiURzTZQGebzSaY2iCS4gaObvwtT6Z8fqDgop-twaX7uT_DzQ37n52g
Message-ID: <CADnq5_NZQrSAqV4cTz8HaJYsatb9VWgc4J3--gTWvF8NTz6-xg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Replace deprecated strcpy with strscpy
To: Amin Gattout <amin.gattout@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Tue, Aug 18, 2026 at 7:10=E2=80=AFAM Amin Gattout <amin.gattout@gmail.co=
m> wrote:
>
> strcpy() has been deprecated because it performs no bounds checking
> on the destination buffer, which can lead to buffer overflows. Replace
> it with the safer strscpy().  No functional changes.
>
> Signed-off-by: Amin Gattout <amin.gattout@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mca.c
> index cc6d1a4e4c3a..1caa393c44d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> @@ -97,7 +97,7 @@ int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_device *ad=
ev)
>                 return err;
>         }
>
> -       strcpy(ras->ras_block.ras_comm.name, "mca.mp0");
> +       strscpy(ras->ras_block.ras_comm.name, "mca.mp0");
>         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
>         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_BLOCK_=
_MP0;
>         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCORREC=
TABLE;
> @@ -122,7 +122,7 @@ int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_device *=
adev)
>                 return err;
>         }
>
> -       strcpy(ras->ras_block.ras_comm.name, "mca.mp1");
> +       strscpy(ras->ras_block.ras_comm.name, "mca.mp1");
>         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
>         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_BLOCK_=
_MP1;
>         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCORREC=
TABLE;
> @@ -147,7 +147,7 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device =
*adev)
>                 return err;
>         }
>
> -       strcpy(ras->ras_block.ras_comm.name, "mca.mpio");
> +       strscpy(ras->ras_block.ras_comm.name, "mca.mpio");
>         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
>         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_BLOCK_=
_MPIO;
>         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCORREC=
TABLE;
>
> ---
> base-commit: 0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
> change-id: 20260818-amdgpu-strcpy-0e92d18299c6
>
> Best regards,
> --
> Amin Gattout <amin.gattout@gmail.com>
>
