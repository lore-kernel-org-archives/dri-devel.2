Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F288C9830E
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88FF810E69A;
	Wed, 23 Sep 2026 15:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="dTfc5ECS";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 560F410ED47
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790178520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibL3vdJsdmHHQtVOWCaIDOmHeVB42ijie9E25CWgvfk=;
 b=dTfc5ECSwFC4rKZIB9ziSTLVeuhF5me57J1pLgN+kDY6NRWHO4AWGu/xFfCHSquvkccTpf
 eggb4Z4+oZejbCA0jDG2Lfq8JZ0gIgDdhLwFvcuGe8NE2vwILcWOykHTAHaSP82+pm878Y
 68OFelJqE8113xGElTxGnqoxVhDdFYw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-b_ZfVgK_M6yyKvUb4ke3IA-1; Wed, 23 Sep 2026 11:48:39 -0400
X-MC-Unique: b_ZfVgK_M6yyKvUb4ke3IA-1
X-Mimecast-MFC-AGG-ID: b_ZfVgK_M6yyKvUb4ke3IA_1790178518
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3a5d269faa0so5707821fa.2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790178517; x=1790783317;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ibL3vdJsdmHHQtVOWCaIDOmHeVB42ijie9E25CWgvfk=;
 b=Ws67f2/RdIV/3G8PJMVqeRfa+Z37hKfKvW5uRqtuP8vhMMm+vfi+jn9EX5UdIoh/Gq
 vSOtGLu+McBZ2OrF/eYJdyVhe5xJ/GEfy7mJ5jzQaK7eGKZf4VPwaqd7b0lbkMu+PU0h
 2kzSuX1ihtf7dgai2CmZoF0QbJRLQignmWpM97rCdOSWlW/w5Pipj1dSJ96AvMtVTZ42
 0lAUl1iereWKVhVuT+X1jizMEP9Nf8RI9KKTfFYkBKL3Sl2eNr0gXvrc+rf44oAW+1Il
 DxmOuygC+cM8JGzC2OOZBPxxKc5gxFYa8f2xJsyPAqFXQJzLMiYJZQfjI6zwOCzAJxZn
 xsGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzj/9PVot/5vcOeRuWoeoDDFwlsOmaspGJ8dlZAYf8h22Qp8G4atVihdJes/93xRN/Rb9opg0Ejl4c=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nNFxy81+ZwD8rOFtK7ehcXOytIbP+rTQMMAlKdQWoCeIGPzRhY
 FPxuOi8C81RrJHG2ZziqXFZh5vHJ94gQRw219BWSRq11h6ePSmdQ8IfXEuEvXi+czGnJQg+fX1U
 HlxBaDDf+ck/TxzEbQKK+hz9FhJH4Z7e1h4lgqm7xNnbJYXcAIONnsbFw5zg3y/Eh8RKStA==
X-Gm-Gg: AYBFou01/Q45l/X2GrxrHvbZlhoU0g2/wTZxDlzMmsiJj3iAp9R8Q1E1GeZyvWA7Kbr
 wPuJmUQFZBVMWpXB5Yv9+zQEH5TxGMuADpLEF4/ZNLFoQDu8o9bXHFv05W7tMkbStvL+zmAfNAI
 w1s5lR+SddX+dZuHAzrnm+nOycV/Zu6TJoNC62ns/ZlJhPi5pljCiJZjir2FLHWAkO/GjCNtITf
 XN9wjJLKjsMZRJ0hPZufutYAwTxkHVfw3iZx/cFqC1h0CzpBnRkZkIv23Z3UPYC40rnjNChfzPg
 2Hm5XUqO4rKsJhu2Ojcr3KdYQNozNLlgrtOA8Ys3iFYj1+HWBsJnn7ZCX9nxYCF+I2m30vMI5Jt
 AWfFz1Q==
X-Received: by 2002:a05:651c:1443:b0:3a3:2127:8ef3 with SMTP id
 38308e7fff4ca-3a6305e4783mr8472461fa.10.1790178517377; 
 Wed, 23 Sep 2026 08:48:37 -0700 (PDT)
X-Received: by 2002:a05:651c:1443:b0:3a3:2127:8ef3 with SMTP id
 38308e7fff4ca-3a6305e4783mr8472351fa.10.1790178516913; 
 Wed, 23 Sep 2026 08:48:36 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8d85958f1sm708391e87.81.2026.09.23.08.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 08:48:36 -0700 (PDT)
Message-ID: <2493dc57eb887650642ddb7858c7c2f4def67877.camel@redhat.com>
Subject: Re: [PATCH 0/3] drm/nouveau: HDMI Deep Color link depth (30/36/48 bpp)
From: lyude@redhat.com
To: Daniel Campos Ramos <Capitain_Jack@yahoo.com>, 
 dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, dakr@kernel.org
Date: Wed, 23 Sep 2026 11:48:34 -0400
In-Reply-To: <20260922192132.114546-1-Capitain_Jack@yahoo.com>
References: <20260922192132.114546-1-Capitain_Jack.ref@yahoo.com>
 <20260922192132.114546-1-Capitain_Jack@yahoo.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WtfKOpVEDdn789jMhTF6T3tMxAY7J2N94hXHtmFWjts_1790178518
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

On Tue, 2026-09-22 at 16:21 -0300, Daniel Campos Ramos wrote:
>=20
>=20
> AI partners were leveraged in the production of this work.

Can you please clarify how LLM tooling was used in the production of
this work? If you actually generated code with it that is part of this
submission, then you need to append a Assisted-by: tag to each commit
indicating that it was generated by an LLM. If it was only used for
research or analysis and the code is written by hand (also, this is
_vastly_ preferable to getting LLM submissions. consider trying it or
even better - try not using them at all.) then leaving the tags out is
fine.

>=20
> Daniel Campos Ramos (3):
> =C2=A0 drm/nouveau: select HDMI deep-color link depth
> =C2=A0 drm/nouveau: pass HDMI GCP deep-color state through NVIF
> =C2=A0 drm/nouveau: program HDMI deep-color GCP fields
>=20
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/disp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 80
> +++++++++++++++++--
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/headc37d.c=C2=A0=C2=A0 |=C2=A0 6 +=
+
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/headc57d.c=C2=A0=C2=A0 |=C2=A0 6 +=
+
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/headca7d.c=C2=A0=C2=A0 |=C2=A0 6 +=
+
> =C2=A0drivers/gpu/drm/nouveau/include/nvif/if0012.h |=C2=A0 3 +
> =C2=A0drivers/gpu/drm/nouveau/include/nvif/outp.h=C2=A0=C2=A0 |=C2=A0 2 +=
-
> =C2=A0drivers/gpu/drm/nouveau/nouveau_connector.c=C2=A0=C2=A0 |=C2=A0 9 +=
+-
> =C2=A0drivers/gpu/drm/nouveau/nouveau_connector.h=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0drivers/gpu/drm/nouveau/nvif/outp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +-
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/disp/gb202.c=C2=A0 | 12 +--
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/disp/gv100.c=C2=A0 |=C2=A0 4 +-
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/disp/ior.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 +
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/disp/tu102.c=C2=A0 |=C2=A0 4 +-
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/disp/uoutp.c=C2=A0 |=C2=A0 6 ++
> =C2=A014 files changed, 128 insertions(+), 20 deletions(-)

