Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E43C5DF8C
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 20:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 058A210F3B7;
	Fri, 21 Aug 2026 20:51:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="i84U6bLv";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 525C510F3B7
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 20:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787345488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PzCEUAktNVyTUwyGPW28kl433w6GLdC5R8ss5vQ/ovQ=;
 b=i84U6bLvlgrdSJIMD4rQ+5IgVoJNHoCKoze6cpC1NN1CDMQuKYNDQUggcIYsvUIcAC4OhI
 HCi7M2q4VRp3fVfn08Wih6IF8YC+q9Y8r9z0phMmvcsLgXHRlwrVOj6CPj3Jf7llwbAr4S
 sLuVB0oMMnp4XkrdV5IyDU4GJUFPYQQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-5s93nVEQMBukyyUmQ5M7uQ-1; Fri, 21 Aug 2026 16:51:22 -0400
X-MC-Unique: 5s93nVEQMBukyyUmQ5M7uQ-1
X-Mimecast-MFC-AGG-ID: 5s93nVEQMBukyyUmQ5M7uQ_1787345482
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-930b571432fso140284285a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 13:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787345482; x=1787950282;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HuDs7Luw/ROxX0xq8KmbfLJDfZoplTUYH6mJcBNERqU=;
 b=hffehGzHIviABFt3agBGx0vfS/s9UbUBMOmT4gj/MZ2IT9mdf0f9ZL6rTY/TprNzzx
 kveZBxfI5uXw5WN3ZY7JbgFVby3mgE1JOtnXAaHuBJL4jT0Pokx9PT4hISZHsKMEvmXv
 AN6GQmtfQ3OvNFXXdXfptpZH1l0qCW5iRimdPki5mcTK25/pOieURT61IN30MP45gLBt
 G0jxqNz5EmcSSL+4PKv0ZCoNDz09tBE1bwFir/Mo6vvR+72wHnUe2m4oOEO1t++nSsC5
 95vyIW5rVLJ9gko1WX9OfOlYpasjFTTtZmA9wWLNFCH6hFLizSz/sOLhQhxQge5MCRo3
 RYiw==
X-Gm-Message-State: AFuF++lw5yUOegyUlAwv+BnmP/NyYebvyr9zhLgDYy3ufeKyzYmuoYVk
 DFpVUq4Rj3hrPHNagsaJqEGC+znioOt4BT263H/foEuXDPDMd1+lgl1CglTx1Ini1Ya4E4zuTY4
 aM2Lq9RlYrvEBvbpgKZ2qeGPQ0lZ5KqMRIs1eA3B+5zxtmHC4s7aRu+UV8DJN/FI420aXNQ==
X-Gm-Gg: AR+sD13EuNmlMSKxS68RuRXxzr7BgdwkpbhBYaY+T+Jzbtc6lyBtT2n5CWdI8TzChYO
 Z8FwcQJeANRAK8UgHHx65WXMqWC0SOmdsMwlj8AMPsDWfDksYE96RsLG/TimghLJbaq1aXNoSGo
 1riM4sZUrZb0aTtU/m3l0/BgzLyPaMhjbla0ZL6TuERi4YmwRzNdWGQ2n//DAitVABwMS5x6IDZ
 FPj2nfbs5qo0IiOEm8LgoDo1QOiH3W+wV24TANshsIoN70NpMtkByPCrC58bpMi0zzNdP8EUdKd
 hTwRKhma0GdBrfIJoBr3+tOMbX8KJfqvngs+bit6E4gyuh0NcVTH7FH7ZqLTkwAcBpFwh78q
X-Received: by 2002:a05:620a:3707:b0:936:a8a0:cdf0 with SMTP id
 af79cd13be357-937284a0c5dmr1631689885a.15.1787345481909; 
 Fri, 21 Aug 2026 13:51:21 -0700 (PDT)
X-Received: by 2002:a05:620a:3707:b0:936:a8a0:cdf0 with SMTP id
 af79cd13be357-937284a0c5dmr1631686185a.15.1787345481490; 
 Fri, 21 Aug 2026 13:51:21 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93720582185sm682233485a.37.2026.08.21.13.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 13:51:20 -0700 (PDT)
Message-ID: <07f751b262a74e9c5dffabcec78753ea7efd3805.camel@redhat.com>
Subject: Re: [PATCH 57/70] drm/nouveau: Convert to atomic_create_state
From: lyude@redhat.com
To: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>,  David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>, 
 nouveau@lists.freedesktop.org
Date: Fri, 21 Aug 2026 16:51:20 -0400
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-57-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-57-fb793475c05a@kernel.org>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sUSTElgO5nioeXwOycIriUjalfTo_Bdo75h6WUX0WY0_1787345482
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

On Fri, 2026-08-21 at 16:39 +0200, Maxime Ripard wrote:
> The nouveau nv50 head implementation provides a custom reset hook.
> However, this hook only allocates the state, initializes it with
> __drm_atomic_helper_crtc_reset(), and frees the previous state. It
> does not perform any hardware reset.
>=20
> Since this is exactly what the atomic_create_state hook is meant to
> do, minus the old state cleanup which the caller handles, convert the
> implementation to use atomic_create_state with
> __drm_atomic_helper_crtc_state_init() instead.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: nouveau@lists.freedesktop.org
> ---
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/head.c | 14 ++++++--------
> =C2=A01 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/head.c
> b/drivers/gpu/drm/nouveau/dispnv50/head.c
> index 1affa0378bd0..6a3a93de0cbf 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/head.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/head.c
> @@ -489,22 +489,20 @@ nv50_head_atomic_duplicate_state(struct
> drm_crtc *crtc)
> =C2=A0=09asyh->clr.mask =3D 0;
> =C2=A0=09asyh->set.mask =3D 0;
> =C2=A0=09return &asyh->state;
> =C2=A0}
> =C2=A0
> -static void
> -nv50_head_reset(struct drm_crtc *crtc)
> +static struct drm_crtc_state *nv50_head_create_state(struct drm_crtc
> *crtc)
> =C2=A0{
> =C2=A0=09struct nv50_head_atom *asyh;
> =C2=A0
> =C2=A0=09if (WARN_ON(!(asyh =3D kzalloc_obj(*asyh))))
> -=09=09return;
> +=09=09return ERR_PTR(-ENOMEM);
> =C2=A0
> -=09if (crtc->state)
> -=09=09nv50_head_atomic_destroy_state(crtc, crtc->state);
> +=09__drm_atomic_helper_crtc_state_init(&asyh->state, crtc);
> =C2=A0
> -=09__drm_atomic_helper_crtc_reset(crtc, &asyh->state);
> +=09return &asyh->state;
> =C2=A0}
> =C2=A0
> =C2=A0static int
> =C2=A0nv50_head_late_register(struct drm_crtc *crtc)
> =C2=A0{
> @@ -523,11 +521,11 @@ nv50_head_destroy(struct drm_crtc *crtc)
> =C2=A0=09kfree(head);
> =C2=A0}
> =C2=A0
> =C2=A0static const struct drm_crtc_funcs
> =C2=A0nv50_head_func =3D {
> -=09.reset =3D nv50_head_reset,
> +=09.atomic_create_state =3D nv50_head_create_state,
> =C2=A0=09.destroy =3D nv50_head_destroy,
> =C2=A0=09.set_config =3D drm_atomic_helper_set_config,
> =C2=A0=09.page_flip =3D drm_atomic_helper_page_flip,
> =C2=A0=09.atomic_duplicate_state =3D nv50_head_atomic_duplicate_state,
> =C2=A0=09.atomic_destroy_state =3D nv50_head_atomic_destroy_state,
> @@ -537,11 +535,11 @@ nv50_head_func =3D {
> =C2=A0=09.late_register =3D nv50_head_late_register,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct drm_crtc_funcs
> =C2=A0nvd9_head_func =3D {
> -=09.reset =3D nv50_head_reset,
> +=09.atomic_create_state =3D nv50_head_create_state,
> =C2=A0=09.destroy =3D nv50_head_destroy,
> =C2=A0=09.set_config =3D drm_atomic_helper_set_config,
> =C2=A0=09.page_flip =3D drm_atomic_helper_page_flip,
> =C2=A0=09.atomic_duplicate_state =3D nv50_head_atomic_duplicate_state,
> =C2=A0=09.atomic_destroy_state =3D nv50_head_atomic_destroy_state,

