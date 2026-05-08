Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5075BCD342F
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 18:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE37110E177;
	Fri,  8 May 2026 18:54:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="YM8Q0dQ+";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABABB10E177
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 18:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778266445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0YhjsTWluBMG0VD0yeK46oKsqKSKzhoowDRLmjDkdWY=;
 b=YM8Q0dQ+G8o/STSMFbW1T0bFxs8RslC2Z/D3SPjahhDj9aFGr2g837bWuJDbGUA9WcC7Hu
 PKS0zdaOTxNFBf+GddubJhhVcuMwVBrJDkssPH9ksmZ/yteY2775+12epbLIcqXOzIFK7m
 cCAPaqlrlg1IhfCsZHG2gn+sFpELNmc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-vMC9O8ApMweIPitFJ78JsQ-1; Fri, 08 May 2026 14:54:04 -0400
X-MC-Unique: vMC9O8ApMweIPitFJ78JsQ-1
X-Mimecast-MFC-AGG-ID: vMC9O8ApMweIPitFJ78JsQ_1778266444
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50edf0245b0so41062991cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 11:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778266444; x=1778871244;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nw5Hfi8KU2h83icRdaxsQgdWasba3ZiPDgOGZW2eFxA=;
 b=IlxW0bSEK9LHJ/zHjt+Ra+J5vii5Wkhd6kllGhXWsuxm4amNDPvTYwBelTYuOYwj+C
 ljHgyUFPFdPvzuMesojUyxP9lEa5BoVJmgeVrollKt2S0rUSFcAR3LhA5vE1gOF2DdVS
 R077TrsED3wbI9foYFrS2ZcRdmgR7syJPqitKmm50veaoUZhP994vX95fr8ZTECEo6jw
 b3RW8xCygzzrxP5zDR2GVdEx+f/9ujYQNvHC8G7HJdip6OEZfRthDKHYw+4UfSBNZE4z
 arxaX+a7J2Qe2D47kFTMydV9HVcrYtfvdzMfCSimkjcPphoSoEKlmyUjnkPQLm8J5bcq
 Z/cg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+h8MUdQOyNSVbplWf8ea2VrCIKwCqeERW+MUQ/jhIwFPWMdXyNnP5wlOfjic2vLVNmwzi6R26B96U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjBy92c09pGCtn0mzfKYjOrUu1FP3by1xqaETKXFQlAfZojDI1
 O+wYduX6YFtdfkKff8JDgW6waok/GV7UQQT2SQDzGq4TBgRHBQLM+jRtPTwnfLbCF2A4uqzypYV
 s9jDr4lWw8HCGRjC3IJr3plfsPPrdTMDWT9CWrqTcN8tmwlsTfBEw2Ttl6tIOp79DuHcCFw==
X-Gm-Gg: AeBDieu78FFaMStDHvy/yuQwN9zxtUpGabTrlKFhW9DBIo2oKmz2fRw105+kwEmJoVR
 p1Nlb8Y7+Nn7D9d10KB5obWJHU2XcMXqGJR96P/9u/mzrDBdvdgdWa7DU6vslh6w0M+jp3HmX6w
 jsvjiYFCbVv9bvixSwQgC93ZHB2BgHGC8JbCf6Jvw3AqtIWQVYxaqYwQJ3ffMZoFUvV7T+gA85F
 l9POD0fHCiWimhw5Wt5h6K7/sAJ/cEfzyReFU/Akd8+haqL0jXaUOc5UqwwOAt2V2t7MO138j8D
 H9w3mDeVQCQAIWy5/yuCuVsc38ddbjQrMP+8Mkk+mx9iL1rIuleH1gowmaoxLJz6kkfwa5RdnOM
 G8WECwI+zfeqONp6Ey6KQztmndrie
X-Received: by 2002:ac8:59d3:0:b0:509:23ee:b9a5 with SMTP id
 d75a77b69052e-514619ddbddmr188660041cf.5.1778266443450; 
 Fri, 08 May 2026 11:54:03 -0700 (PDT)
X-Received: by 2002:ac8:59d3:0:b0:509:23ee:b9a5 with SMTP id
 d75a77b69052e-514619ddbddmr188659591cf.5.1778266442983; 
 Fri, 08 May 2026 11:54:02 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5148e7c0289sm27365411cf.18.2026.05.08.11.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 11:54:02 -0700 (PDT)
Message-ID: <e76465b097afa44f472294b0fdf775b7abd7da95.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/gsp: Use kzalloc_flex() for r535 display funcs
From: lyude@redhat.com
To: Rosen Penev <rosenp@gmail.com>, nouveau@lists.freedesktop.org
Cc: Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, "open list:DRM DRIVER FOR NVIDIA
 GEFORCE/QUADRO GPUS"	 <dri-devel@lists.freedesktop.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Fri, 08 May 2026 14:54:01 -0400
In-Reply-To: <20260508052056.1744665-1-rosenp@gmail.com>
References: <20260508052056.1744665-1-rosenp@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PzTxPOUbgBxh0LOGpAeVw1hIrG18sfQBDcTuLy_JGiw_1778266444
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

Reviewed-by: Lyude Paul <lyude@redhat.com>

There's one change to make below, but I will just handle it locally
before pushing:

On Thu, 2026-05-07 at 22:20 -0700, Rosen Penev wrote:
> struct nvkm_disp_func ends with the user flexible array member.
> Allocate the
> r535 display function table with kzalloc_flex() instead of open-
> coding the
> size calculation with sizeof().
>=20
> This makes the allocation describe the object being allocated
> directly and
> keeps the fixed six user entries unchanged.
>=20

I assume this was the AI talking, but this sentence seems like a
nothing-burger. Will just drop it from the commit.

> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> index 6e63df816d85..1155f079b0c3 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> @@ -1734,7 +1734,8 @@ r535_disp_new(const struct nvkm_disp_func *hw,
> struct nvkm_device *device,
> =C2=A0=09struct nvkm_disp_func *rm;
> =C2=A0=09int ret;
> =C2=A0
> -=09if (!(rm =3D kzalloc(sizeof(*rm) + 6 * sizeof(rm->user[0]),
> GFP_KERNEL)))
> +=09rm =3D kzalloc_flex(*rm, user, 6);
> +=09if (!rm)
> =C2=A0=09=09return -ENOMEM;
> =C2=A0
> =C2=A0=09rm->dtor =3D r535_disp_dtor;

