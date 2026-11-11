Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356AF606A889
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E56DZk/G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F59510FE24;
	Wed, 11 Nov 2026 21:00:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C02710FE49
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 21:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794430842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l5s5mjDwH4MmiZfdgGusyFoAW8kVOLNRcUp5vNbEtB4=;
 b=E56DZk/GSVi06L6HcoeiLa7TDAmqambFsx7UoARBanfW7LR9QAqRwTCpC3B0UPJMOMkcdK
 UmiJvpIv6Zf7wIDu7yVEfMCHZD8HLTLYDz2B1fGzVY9zUM5IBqM2Ugloy5VIr5J/5AUhbJ
 WXHt0mFoS7aUvqHC8TCkFSl766GRf+E=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-lu-9qbVHMrKidMHqdDH4ow-1; Wed, 11 Nov 2026 16:00:41 -0500
X-MC-Unique: lu-9qbVHMrKidMHqdDH4ow-1
X-Mimecast-MFC-AGG-ID: lu-9qbVHMrKidMHqdDH4ow_1794430841
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5363763b556so67656771cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:00:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794430840; x=1795035640;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bfwzc0Soc5yMmxMHyRdKnO8B25Ja28l1t2oGS6mpFwU=;
 b=0RegsDo6fUm4lK5gBDXxJFA8WcLB+MYaYs8irRj7KTWWbZv41NZJfBoExqp++FG96n
 TlCnMcZIEkV90zl9CcZg1lKfoBj2nsyNz/MFBBpgJAh2Rhs/04vuEYVIadDlbJqWc6fG
 Jgukb0FVNaF2paEHGHvtuQbJd+++GumNyDkVRuVJg5l256k5cZWXs6bNEqiHg5vyVPJx
 eGSeLOWp2Q0DR33KIDalzhGVvrtcPf9afSwXX3FTHOZGERWEEWmIFJQ4q6CwK1ax6nab
 8ywtE5yVAA0spb97iVaZ1ryUWtvuaTeR+IEA9XAQTEkBvN0hMXbGO0DwyLCHoecjAwqB
 TFDA==
X-Gm-Message-State: APuU4Z+I+sDcFkqwhrcZ8jCdCQqMURBXLO9Zh+a3oPor/nMQ5P9nqWQH
 3ui6GpWzt6wsW8WkC7Qt03upKm77t++G/PpGZ8jY4mxVFeZX6hbTk3gvQESVSBErzkDQn+6YjDa
 Mamf3IRNbCtRL4tEVsJ3ZLQauEFVgWymhqYd4RuiL9NTmDXMRJa7E25PdyduffwAbXo3Hyg==
X-Gm-Gg: AYBFou1W6QeptDP4Gi0hxHoIaRAFxkXW0alQd7ZN3gT19F4w7+MaX0x99yBxfyK8RvE
 negYJ3KIwXgxE8mUyXMHpyvUQB+WRW+3aqCBMSbFWNiSWZAJVVnvmhHItnM2k2G5mmgvcnuNYyP
 DDPLo3uCdeqNIsvapCDMJaEWvsbLiHqBTG2aUqra2uvnn3HQ5NoW8xOtzCHPMsTDkoim2TG9pcY
 pBiyvWuhd3wSdpek4EyjcpK5qSVCQvN+tdfdDN0xwt2SV0wQ6Ii56JxiZ+g4AgfZ2zyZZXzkTrM
 lmbVUoADx0YHXpFm0x3uZL2LWRZ/TVEXwE6SCBfo2lDmiQ2V7+7p9ShBIJ0mpE+ikuQRT3ISGxV
 2eRAvegbuvQrYEVpRagEfbbTRWSnKJfJGbyo3SjfJ008j51BJtYLUlebl+/p1+BrUX7qzuhr4RE
 6WjnYcjD1QYiBW9A==
X-Received: by 2002:a05:622a:590b:b0:536:663d:18ca with SMTP id
 d75a77b69052e-556c0ea966fmr54823091cf.48.1794430840045; 
 Wed, 11 Nov 2026 13:00:40 -0800 (PST)
X-Received: by 2002:a05:622a:590b:b0:536:663d:18ca with SMTP id
 d75a77b69052e-556c0ea966fmr54822201cf.48.1794430839462; 
 Wed, 11 Nov 2026 13:00:39 -0800 (PST)
Received: from [192.168.5.11] (pool-108-49-8-41.bstnma.east.verizon.net.
 [108.49.8.41]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f03ca6548sm29611306d6.9.2026.11.11.13.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 13:00:38 -0800 (PST)
Message-ID: <5b9d4fa7e29fa7ef780f5a6386de6ce9f6ee7bab.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/disp: Set
 drm_mode_config_funcs.atomic_(check|commit) (attempt 2)
From: lyude@redhat.com
To: airlied@redhat.com, Danilo Krummrich <dakr@kernel.org>, David Airlie
 <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, Ruben
 Wauters <rubenru09@aol.com>, stable@vger.kernel.org
Date: Wed, 11 Nov 2026 16:00:35 -0500
In-Reply-To: <20261111-nouveau-atomic-fix-v1-1-118e65d3a2f5@redhat.com>
References: <20261111-nouveau-atomic-fix-v1-1-118e65d3a2f5@redhat.com>
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nVIdAum4sU8hKo6GUfw6-sMYoQlZfFeQwuAnbVXhVnc_1794430841
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Wed, 2026-11-11 at 16:00 +1000, Dave Airlie via B4 Relay wrote:
> From: Dave Airlie <airlied@redhat.com>
>=20
> commit 604826acb3f5 attempted to add these flags but
> commit 6c65db809796 reverted it due to it
> failing on hw from pre-atomic times.
>=20
> So use a second set of functions.
>=20
> original commit msg from Lyude:
> "Apparently we never actually filled these in, despite the fact that
> we do
> in fact technically support atomic modesetting.
>=20
> Since not having these filled in causes us to potentially forget to
> disable
> fbdev and friends during suspend/resume, let's fix it."
>=20
> Reported-by: Ruben Wauters <rubenru09@aol.com>
> Closes: https://gitlab.freedesktop.org/drm/nouveau/-/work_items/517
> Fixes: 6c65db809796 ("Revert "drm/nouveau/disp: Set
> drm_mode_config_funcs.atomic_(check|commit)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_display.c | 11 ++++++++++-
> =C2=A01 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c
> b/drivers/gpu/drm/nouveau/nouveau_display.c
> index d71dcfc6ee66..07882624a7f6 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_display.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_display.c
> @@ -354,6 +354,11 @@ static const struct drm_mode_config_funcs
> nouveau_mode_config_funcs =3D {
> =C2=A0=09.fb_create =3D nouveau_user_framebuffer_create,
> =C2=A0};
> =C2=A0
> +static const struct drm_mode_config_funcs
> nouveau_mode_config_funcs_atomic =3D {
> +=09.fb_create =3D nouveau_user_framebuffer_create,
> +=09.atomic_commit =3D drm_atomic_helper_commit,
> +=09.atomic_check =3D drm_atomic_helper_check,
> +};
> =C2=A0
> =C2=A0struct nouveau_drm_prop_enum_list {
> =C2=A0=09u8 gen_mask;
> @@ -654,7 +659,11 @@ nouveau_display_create(struct drm_device *dev)
> =C2=A0=09drm_mode_create_scaling_mode_property(dev);
> =C2=A0=09drm_mode_create_dvi_i_properties(dev);
> =C2=A0
> -=09dev->mode_config.funcs =3D &nouveau_mode_config_funcs;
> +=09/* this only gets set if the driver has the ATOMIC flag */
> +=09if (drm_drv_uses_atomic_modeset(dev))
> +=09=09dev->mode_config.funcs =3D
> &nouveau_mode_config_funcs_atomic;
> +=09else
> +=09=09dev->mode_config.funcs =3D &nouveau_mode_config_funcs;
> =C2=A0
> =C2=A0=09dev->mode_config.min_width =3D 0;
> =C2=A0=09dev->mode_config.min_height =3D 0;
>=20
> ---
> base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
> change-id: 20261111-nouveau-atomic-fix-7478260ce6a7
>=20
> Best regards,

