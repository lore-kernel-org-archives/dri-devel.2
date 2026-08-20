Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EB2C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:28:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BEBE10EF06;
	Thu, 20 Aug 2026 18:28:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Ans3K7ua";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C694410EF06
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 18:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787250531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=02IMZbxlNo+CxyHurTZ+VFbVjMkSF2HhHDF+1YC6pG8=;
 b=Ans3K7uappHBBUS3wX84YQFsx5lqtXjdI94RJG5rIawond3+FuiDb98wNtdhnQxjRtmKPb
 SeGcuiJmHCIKfnmWWCHeqNKI/aYxnQnLOdrqS/MLaql0Ajh8HU/ljPpRX/17blMEED7RWz
 On2D112VbxAzFJknYaxMSZIwQb6m0XQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-RguTDryENQaNRTBgK92I9A-1; Thu, 20 Aug 2026 14:28:37 -0400
X-MC-Unique: RguTDryENQaNRTBgK92I9A-1
X-Mimecast-MFC-AGG-ID: RguTDryENQaNRTBgK92I9A_1787250517
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c01ff996dso1311641cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 11:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787250517; x=1787855317;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fvFKAPRcQcLsGMFTo6jCZYlK8au7/chi2AjGH/KyknY=;
 b=fsJX8qolqHoftM1MrXKP35oxhmjmYrwxEx56uZj1Kscv6g0r5IzLrDYmTU2ml+/ONq
 +whSC1slkieZ2tPsG8tYsq90UWGc3Gf/ZA6t9Wl5d5lxGa5Js+QdKhh6o6AJ3WpMIbPG
 ND5mSbZjtN4lEsPF49mUGnrNc9G9FQBIAGyWkKD28FVnEJhGwFqc6crSwImgbhEpcQug
 3Qb6f5KAyK3AN5iBChgZjltpQecZNUvoDKy5qaK3cPUnBsI3tH5cM5fFZGf6SMh4JaP3
 NY+vlA3ZvjioxvqbA9/jMARkeAzNywcLPUUNCHWNOQmMa0vIC59cIP4Uzn2b8ALeHxFr
 J9lA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFqDJomv5J+j09NISHAmVIpaga9zo3u5KvEXDi2QzL7+Z/VvhASgNJQ9VrsL+kF8h8i2eNnkcMC3w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQ2s4c7b23fImYwUyTN/KHHMR5GP8DpkZOcFtcKfrBezTzJGs+
 3fI82doMHCeCihkFX1mSrP6k03o4l5pOldj1gOs91nYDk1VOpFwn2cb37DilvkwJX14vlzExOkY
 sRr4zOaihn0zRFYo/THExwz+Tx8uBGwKMP4DyOndcl8RGhCRzv+byoQYoL/ZKyuEiE4Mm6Q==
X-Gm-Gg: AR+sD13i6sPqhXR07+oEXtIoZ53qSp58GpRp+/q5f58wClypfeX53LSIv2iNCFUj+Gt
 3UpW544L52IRjZYUJpUdAM98BeMBEFpVUXPMrBoodlqNB9THU6/DLxogH1g8/8vO2CgfcHWMO7W
 Kxh5jl8wnYCVO/lg95ItmJnjZjQxed37itoSjcra1TnSos3kmUThez9V7h3lRdCljNNsdm0yPTu
 D2sfH6fFpK9kZB2B1TR1Q9rCtRj895Pz8+L/NgurXemHOKjfGF0YZrJConcGqmTcgHYQoLWlIO8
 qmEafzR3+qyLVDw48gAtCQHowxD9PXwS5wRSFWvj6cBuslZMcPZ/+8r97usljWA+bmXII7OX
X-Received: by 2002:ac8:5e06:0:b0:52d:4f43:d5b0 with SMTP id
 d75a77b69052e-52df5a07b41mr2811041cf.22.1787250516723; 
 Thu, 20 Aug 2026 11:28:36 -0700 (PDT)
X-Received: by 2002:ac8:5e06:0:b0:52d:4f43:d5b0 with SMTP id
 d75a77b69052e-52df5a07b41mr2810391cf.22.1787250515984; 
 Thu, 20 Aug 2026 11:28:35 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9372056b781sm421572785a.24.2026.08.20.11.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 11:28:34 -0700 (PDT)
Message-ID: <ad9b449657ab3abe4537ed8d8beb393101d46bda.camel@redhat.com>
Subject: Re: [PATCH 3/3] drm/nouveau: don't dereference outp before checking
 it in nouveau_dp_irq
From: lyude@redhat.com
To: Marek Czernohous <mczernohous@gmail.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Date: Thu, 20 Aug 2026 14:28:33 -0400
In-Reply-To: <178682366004.3748010.14933649768375463967@gmail.com>
References: <178682366001.3748010.7798811159846779765@gmail.com>
 <178682366004.3748010.14933649768375463967@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UYV1_XZpafUnQfTkQWFqdU00eFm2ZovbSBJEJMrpKDA_1787250517
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

On Sat, 2026-08-15 at 21:54 +0200, Marek Czernohous wrote:
> From: Marek Czernohous <marek@czernohous.de>
>=20
> nouveau_dp_irq() looks the encoder up and dereferences it in the same
> breath, five lines before testing it:
>=20
> =09struct nouveau_encoder *outp =3D find_encoder(connector,
> DCB_OUTPUT_DP);
> =09struct nouveau_drm *drm =3D nouveau_drm(outp->base.base.dev);
> =09...
> =09if (!outp)
> =09=09return;
>=20
> find_encoder() walks the connector's possible encoders and returns
> NULL
> when none of them matches the requested type, so the NULL test is not
> decoration: it is the author saying this can happen. The initialiser
> above it dereferences the same pointer regardless.
>=20
> The NULL test predates the dereference. commit 773eb04d14a1
> ("drm/nouveau/disp: expose conn event class") turned nouveau_dp_irq()
> into a work callback, and since the drm pointer was no longer passed
> in
> as an argument it was recovered from the encoder in the declaration
> block, which put the dereference above the existing test.
>=20
> Move the drm lookup below the test. No functional change when outp is
> non-NULL.
>=20
> Fixes: 773eb04d14a1 ("drm/nouveau/disp: expose conn event class")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Marek Czernohous <marek@czernohous.de>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_dp.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c
> b/drivers/gpu/drm/nouveau/nouveau_dp.c
> index 55691ec44aba..738802358d85 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dp.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
> @@ -486,7 +486,7 @@ nouveau_dp_irq(struct work_struct *work)
> =C2=A0=09=09container_of(work, typeof(*nv_connector), irq_work);
> =C2=A0=09struct drm_connector *connector =3D &nv_connector->base;
> =C2=A0=09struct nouveau_encoder *outp =3D find_encoder(connector,
> DCB_OUTPUT_DP);
> -=09struct nouveau_drm *drm =3D nouveau_drm(outp->base.base.dev);
> +=09struct nouveau_drm *drm;
> =C2=A0=09struct nv50_mstm *mstm;
> =C2=A0=09u64 hpd =3D 0;
> =C2=A0=09int ret;
> @@ -494,6 +494,8 @@ nouveau_dp_irq(struct work_struct *work)
> =C2=A0=09if (!outp)
> =C2=A0=09=09return;
> =C2=A0
> +=09drm =3D nouveau_drm(outp->base.base.dev);
> +
> =C2=A0=09mstm =3D outp->dp.mstm;
> =C2=A0=09NV_DEBUG(drm, "service %s\n", connector->name);
> =C2=A0

