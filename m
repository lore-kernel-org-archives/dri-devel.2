Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F1BC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C63610ED9D;
	Wed, 19 Aug 2026 15:56:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="QclrBM62";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD5210ED9D
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 15:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787154990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/+ZNOWjMTgJ3M827GFuxVRkM7lP467KrCdNhcMzDs4U=;
 b=QclrBM62TH/984yryNnoA1+j9ldX1Bc6B8H7ElRQEiXfNf+QYpSvZKkpqaEoA50h1N/ZH4
 q2/LJfob76p9CrbikofePSd3FPBs9PIxHXwnGRldNlivLHm5tOWryJ7UGEX8gHlUL6ksRf
 2N3yD4S7MJuTIBd6hBG65oMu2l/TgJ8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-VwMxlhD6PdWwYtPEpeK5bw-1; Wed, 19 Aug 2026 11:56:29 -0400
X-MC-Unique: VwMxlhD6PdWwYtPEpeK5bw-1
X-Mimecast-MFC-AGG-ID: VwMxlhD6PdWwYtPEpeK5bw_1787154989
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e52306621so132256785a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 08:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787154989; x=1787759789;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F5vUKJd+Fx6qdwgKK5H/zWSFLopJUSNyg1KMkU6sF0w=;
 b=mqePAasAJteGa9t6o8DEaonRicbpDtyB1ipR7jjdkKadMB7/qEmX3gPheFZrIV85wp
 N1SrhSXOr45lu4Ghw75rr/eRPdV9S3gsQbmNFyulzhKjLoUodJlHwgicBL7mJlOYeSdX
 AaRm+tVpb24gq2m2YscaqjV6nA3Wb4mEUKJ1ZJa1a0Ci6aFCiO7fOWUMR059vK4cJGtd
 xl3Eo/DYbGyswRCVdkCsGzHsrNT6qjtzfdwkaVS3I59Sl6oy8Yv/9XxmyFrQunJQcygV
 SwpQd2w+hU8fzBcd7fEAK0Q9g8rpNWUCHYO9p+++JxZFQOgx3RhUM/MHe9nHHKYvy0a9
 p/2A==
X-Gm-Message-State: AOJu0YyXDmPi7/bc0aKt/vs8ym48Zvr554ZV0/sVGqti6k4bpceWJuE6
 W/wNhI028mTvc+Je/WdFKG6G4KE1KrFiHcWshCjd9VCepKtZPkv5NhJBKkGwczWfhbYHqYuGyES
 26NRRCnNzDBnrHg58TBRRbM6xwtLkqVSWdlL6Uoppq1xFmgCudNPo3pT5WvVi/aQwK4zPbw==
X-Gm-Gg: AR+sD12tX94wDPHZ63p+X+yz4iWMVD7pfGjFV1WpHK1YrBdbr425k2k/tEHlLqfH6I9
 w5eFqEbRE3xfMqUyr7JE8m2hFrr6d8mMOx4URuDsA3M7cb45kgBkJuM6VJ7JFBUbo8wvYJ4TbcV
 sgzRP2Pfz/FaALzu8gMId3HSYWZn6+vr6wQybHGdbyrBQwuL2RWuE3iswg7bNME7X5UBW536i4Z
 v/+vTD8MeX6iYp9YNPjaBr7xd3JGGZBjvr8Y6qQhOgdRuSxPq3Cv4Zoot2sDRoYTbP4xKDAhhIk
 GFRVLoAVYOzE/5bY6jEIkhF6YY6uepLKlqw8bEVw2S4jeHJxPSHaMCqOzOeKvQRfWGcLodUD
X-Received: by 2002:a05:620a:4892:b0:936:e938:b07a with SMTP id
 af79cd13be357-9371e2034camr505739085a.8.1787154988705; 
 Wed, 19 Aug 2026 08:56:28 -0700 (PDT)
X-Received: by 2002:a05:620a:4892:b0:936:e938:b07a with SMTP id
 af79cd13be357-9371e2034camr505734685a.8.1787154988067; 
 Wed, 19 Aug 2026 08:56:28 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-937204a8a12sm163619685a.14.2026.08.19.08.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:56:27 -0700 (PDT)
Message-ID: <0a92094178471f577c76f497ed9e42913f74bf57.camel@redhat.com>
Subject: Re: [PATCH 5/6] drm/nouveau/kms/nv50-: Add nouveau_encoder->audio.crtc
From: lyude@redhat.com
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Date: Wed, 19 Aug 2026 11:56:27 -0400
In-Reply-To: <20260819001052.A7B0E1F000E9@smtp.kernel.org>
References: <20260818235637.1738055-1-lyude@redhat.com>
 <20260818235637.1738055-6-lyude@redhat.com>
 <20260819001052.A7B0E1F000E9@smtp.kernel.org>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mXYfINbDsNA1Vn3D0c5yqDJ8r3NukYtTXoHqXkjnhd4_1787154989
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

This is also a hallucination. We don't have any kind of audio support
for PIOR.

On Wed, 2026-08-19 at 00:10 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [Medium] PIOR encoders do not clear `audio.crtc` on disable,
> leading to stale audio state being reported.
> --
>=20
> --- Patch [5]: [PATCH 5/6] drm/nouveau/kms/nv50-: Add
> nouveau_encoder->audio.crtc ---
> commit d00b281328e092a25d08552356c0a7fc11880073
> Author: Lyude Paul <lyude@redhat.com>
>=20
> drm/nouveau/kms/nv50-: Add nouveau_encoder->audio.crtc
>=20
> This commit adds an audio.crtc pointer to track the assigned CRTC for
> an
> encoder outside of modesetting locks. It replaces the usage of
> nouveau_encoder->crtc in the audio ELD retrieval path.
>=20
> > diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > index 63d554e97fb62..3bfc04f7ef602 100644
> > --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > @@ -636,7 +636,7 @@ nv50_audio_component_get_eld(struct device
> > *kdev, int port, int dev_id,
> > =C2=A0
> > =C2=A0=09=09nv_encoder =3D nouveau_encoder(encoder);
> > =C2=A0=09=09nv_connector =3D nv_encoder->conn;
> > -=09=09nv_crtc =3D nouveau_crtc(nv_encoder->crtc);
> > +=09=09nv_crtc =3D nv_encoder->audio.crtc;
> > =C2=A0
> > =C2=A0=09=09if (!nv_crtc || nv_encoder->outp.or.id !=3D port ||
> > nv_crtc->index !=3D dev_id)
> > =C2=A0=09=09=09continue;
>=20
> [Severity: Medium]
> Will this cause stale audio state to be reported when PIOR encoders
> are
> disabled?
>=20
> Before this patch, checking the cleared crtc pointer successfully
> skipped
> the disabled encoder. However, it looks like
> nv50_pior_atomic_disable()
> only clears the old crtc pointer, but not the new audio.crtc pointer:
>=20
> nv50_pior_atomic_disable()
> {
> =09...
> =09core->func->pior->ctrl(core, nv_encoder->outp.or.id, ctrl,
> NULL);
> =09nv_encoder->crtc =3D NULL;
> }
>=20
> Does nv_encoder->audio.crtc also need to be cleared here, or does
> nv50_audio_disable() need to be called in nv50_pior_atomic_disable()
> to
> prevent userspace from receiving stale ELD data for a deactivated
> display?
>=20
> [ ... ]

