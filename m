Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7403CA9EBB
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 21:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31F7F10EB56;
	Fri,  9 Oct 2026 21:35:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="bFmsylpo";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A20210EB5E
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 21:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791581717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6R4EFUAHUDCX8d6aulmc7ko33547TuiAQEh+npBg0W0=;
 b=bFmsylpoBcEZBKa+Qs/ey1CAicj6oE2cWSdfUQbxH1MpzaQDMtEuPryr65IIS5fwEmNeZt
 T3rRCUNmkuxqnHJCqAAQmaQHaBtY7szV1WSj7OkBbWSt9TnO8ZRKc2CevYv4zM5BUvFJ10
 1psATC33qS03c+mymk4aW1sXdC75P3c=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-UYFL4QDFM4qaY2VCEwFF_g-1; Fri, 9 Oct 2026 21:35:16 +0000
X-MC-Unique: UYFL4QDFM4qaY2VCEwFF_g-1
X-Mimecast-MFC-AGG-ID: UYFL4QDFM4qaY2VCEwFF_g_1791581716
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-53390e79a19so2769321cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 14:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791581716; x=1792186516;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NZbd6xFkyNScCfIhKBOuLvqJ7Rh/HkXO4uKgVfA+mJo=;
 b=CEUogO61DnzB7+Vrl70962aFvbzj45pgAHAwtIPNe8I3hXcypWp/qKAtLuEDlP+t25
 2eh2Bv7COgp9M5NB0MAVRcIsqpGwArniSVrXLxY9yvuJ9dnSmA1gtztedThE30UwTvmX
 HDwl8ehOfwJN+iZyucA9voYl/EWKuhEQ23JX3oOdUFzx6Z468zPmHwX3ZNqNeowzvpLd
 HCLfmD0fA7Va86GASgjwGVGRyNVaWHgG/I31/bowaHxFV3+8LOfkGFlGX2htivYhmG0b
 ZfqeTtgNP1T4bt2xix6OgWi/jCtbEfnmo0S7NMD8OsLJzKpNJvuLQwiWGtwV0f3M8IMt
 GekQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpScdKqgWVAdmSSkgIzs982p0HXX5SzPQN8pn25HA8I6KuntqVOkRjW5f75aX7PZg//lkG1tc3pFk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJDLDcI2kAXenq3DeCLsnRg/Esw7gMnyMKgTKQ2O7mOLnKtVf71
 kVaG+l/a3IHvCo+pny1JZIhRcmRvmnf5kRR9sQg2mNYu8vxe+QLFr+r6zaRkAcJxkvAvvPxZ3+t
 lW9OGWWMrfRNzjBlJNPUxcsdVrf3nK9lWa4cxigTOGaBiY1ZX8HQdwb6l9tD20BGtrF25Lg==
X-Gm-Gg: AYBFou00YcvvTLOIiLQ40d5vki0V2nekhcgAVWD2jUKz/Rm+hovJUQcaO7SvChnYUnb
 Y/LsXsxeF+nga1ioGQ00fg1fV+JPGfy5dwtUbeVM3PX23ALaL/3Oh2jWkCqVhUVm3eKdho5zkSW
 Dfha6zP1OdY83iYY1VLSPRKJDYHOPGuqKGaPY6KWYjyFG9X4PUEdtm9Bz63H/i1eXlO38d0Rj8f
 JxbZdWnUIofn6QV3odpYL0QGvE7OutlMF4uVVsptPNrrPjEx8UXTVZCc/P0IGffTao4SmdHge/i
 mMU9YeZADb9nEt1mOetEJAQ/Cxz6WWfnAFTjtRM0Z5VWXx+HfX41b7V/BfYlPp2qLohP4oY=
X-Received: by 2002:a05:622a:58c4:b0:535:a5fb:67fc with SMTP id
 d75a77b69052e-535a5fb850cmr34635081cf.72.1791581715811; 
 Fri, 09 Oct 2026 14:35:15 -0700 (PDT)
X-Received: by 2002:a05:622a:58c4:b0:535:a5fb:67fc with SMTP id
 d75a77b69052e-535a5fb850cmr34634721cf.72.1791581715415; 
 Fri, 09 Oct 2026 14:35:15 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b6fa0f9sm27073771cf.8.2026.10.09.14.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 14:35:13 -0700 (PDT)
Message-ID: <25778dca265f58185917c5948490e76184c778d3.camel@redhat.com>
Subject: Re: [PATCH v3] drm/nouveau: Fix memory leaks in debugfs and hwmon
 init error paths
From: lyude@redhat.com
To: liupeng <liupeng01@kylinos.cn>, dakr@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, 	airlied@gmail.com, simona@ffwll.ch,
 linux@roeck-us.net, nouveau@karolherbst.de, 	bskeggs@redhat.com,
 dri-devel@lists.freedesktop.org, 	nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 	linux-hwmon@vger.kernel.org,
 stable@vger.kernel.org
Date: Fri, 09 Oct 2026 17:35:12 -0400
In-Reply-To: <20261009115151.13877-1-liupeng01@kylinos.cn>
References: <ea9a1d374cf3127e5047bc73807ce821022e026e.camel@redhat.com>
 <20261009115151.13877-1-liupeng01@kylinos.cn>
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BZcObMFpFCGOf5TLw4oOPXJFXSa-YO3aQnhwCtio688_1791581716
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

Will push to drm-misc-fixes in a moment

On Fri, 2026-10-09 at 19:51 +0800, liupeng wrote:
> In nouveau_debugfs_init(), if nvif_object_ctor() fails, the
> previously
> allocated drm->debugfs is leaked because the function returns the
> error code directly.
>=20
> In nouveau_hwmon_init(), if hwmon_device_register_with_info() fails,
> the allocated hwmon structure is leaked because the function returns
> the error code directly.
>=20
> Fix both by freeing the allocated memory and clearing the pointer on
> the error paths.
>=20
> Fixes: b126a200e9db ("drm/nouveau/debugfs: we need a ctrl object for
> debugfs")
> Fixes: b9ed919f1c8f ("drm/nouveau/drm/pm: remove everything except
> the hwmon interfaces to THERM")
> Cc: stable@vger.kernel.org
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: liupeng <liupeng01@kylinos.cn>
> ---
> Changes in v3:
> - Drop the extra return in nouveau_debugfs_init() as suggested by
> Lyude.
> - Add Reviewed-by tag.
>=20
> =C2=A0drivers/gpu/drm/nouveau/nouveau_debugfs.c | 14 +++++++++++---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_hwmon.c=C2=A0=C2=A0 |=C2=A0 2 ++
> =C2=A02 files changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> index 47d5579c568d..338421e52f69 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> @@ -295,13 +295,21 @@ nouveau_drm_debugfs_init(struct drm_minor
> *minor)
> =C2=A0int
> =C2=A0nouveau_debugfs_init(struct nouveau_drm *drm)
> =C2=A0{
> +=09int ret;
> +
> =C2=A0=09drm->debugfs =3D kzalloc_obj(*drm->debugfs);
> =C2=A0=09if (!drm->debugfs)
> =C2=A0=09=09return -ENOMEM;
> =C2=A0
> -=09return nvif_object_ctor(&drm->client.device.object,
> "debugfsCtrl", 0,
> -=09=09=09=09NVIF_CLASS_CONTROL, NULL, 0,
> -=09=09=09=09&drm->debugfs->ctrl);
> +=09ret =3D nvif_object_ctor(&drm->client.device.object,
> "debugfsCtrl", 0,
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NVIF_CLASS_CONTROL, NULL, =
0,
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &drm->debugfs->ctrl);
> +=09if (ret) {
> +=09=09kfree(drm->debugfs);
> +=09=09drm->debugfs =3D NULL;
> +=09}
> +
> +=09return ret;
> =C2=A0}
> =C2=A0
> =C2=A0void
> diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> index 726397ab035d..ffbe7f542ab0 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> @@ -697,6 +697,8 @@ nouveau_hwmon_init(struct drm_device *dev)
> =C2=A0=09if (IS_ERR(hwmon_dev)) {
> =C2=A0=09=09ret =3D PTR_ERR(hwmon_dev);
> =C2=A0=09=09NV_ERROR(drm, "Unable to register hwmon device:
> %d\n", ret);
> +=09=09drm->hwmon =3D NULL;
> +=09=09kfree(hwmon);
> =C2=A0=09=09return ret;
> =C2=A0=09}
> =C2=A0

