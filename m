Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DFAC982D2
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 22:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA8510E4B8;
	Thu, 17 Sep 2026 22:10:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="EcZ1oSDL";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97AC710E4B8
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 22:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789683009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ud4TYwbWHYsVK5PwKqeeWvh3vyT9zE8Y/zwj3gXwLMk=;
 b=EcZ1oSDLZAStU9v/LLLJAZtazjMdGRvJ678CiDpmIP/LXH7v2BT4NFxmnIcTGGZGV6s7E3
 p1YfS156nQxlOWI46l726nQfRBhW1CZmoQEHKFt11MU42dsfWc1C1zmRcrrhMxBL2IsUsG
 Pb2ho5ocUbvdTJHcmxZeMty9DgHYY94=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-RxKAtppeP9iZdAp1ltzMKQ-1; Thu, 17 Sep 2026 18:10:08 -0400
X-MC-Unique: RxKAtppeP9iZdAp1ltzMKQ-1
X-Mimecast-MFC-AGG-ID: RxKAtppeP9iZdAp1ltzMKQ_1789683008
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a07b5b5efso269332185a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 15:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789683008; x=1790287808;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8z7jGkncFvYX44ONKGgmNu9yUifGbhbRMAl3u7dsO+Y=;
 b=rcHmQRJW3s8M8Q9yl//A5WMPLxKhTMHF0ppxA2/htr7kL1RPL4LTrQtMQxG9uDS/Qv
 M8OSsilUpgkf5Iq4d36/fk6jbr2whY2/++y3slojyKCUCVc+Eg+ts6Lj29Dl/V0beY8q
 mohDp/eYDOB85O8myC65P+0dxstJfLEBop54Hd8ja7HRmrwwOANkPPqfaMqlemD4lzoD
 rsDZZXAxenR4SqizhlOnlrREhhiL4bhM6cxR30+cMne8Zh+yG8cDd113w8r7rysS0bkZ
 +WgY6XmOK9LjRceDi4sEyWGTciUUOEdPU7OrpdMll8NbN+FnTOXDfCtUvxgw7DfLTgkf
 zcNg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7zjkBuunwaxPpl1IlwguY2ii0ECKAQv33o7yUkKQsVSlJkbyJKVLPaICmTqP8oj2Kug/Vo1NuDsI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nFAeV64V6Yo8K0M6OPKhh6UVA//dxItiDguyq+7g/DDWX8Oe0g
 bspZ5QhpeZKtAsejwf/9ErraBDsS7G2/GPybMEq3tkoQ3Ftl19I35UmPYu9FvOFpzvQfex2ZdRE
 ISO0rwYbMiVCmFkYCkHAZSyqAIe4YA1+FnfHEnspZFY93wcLExsu3vho2Iw2vUuGwuNlMpA==
X-Gm-Gg: AYBFou10olp6MO73H1zZt1UIZDCwMOGc1a3SDQGcpBRNq5kUhhEi7mVZnaxqVxmwZ/B
 ZlaZjII3OtzuI+HzM54njxSrpqcGU0gn2XFqLzjZkl2MN6TlygDm17VC8+bpkBo641+R2IpUoGd
 t23In1I80jMxktcsHsuhsjQPmhdtx2eeWM1gm/9StHSTTl+MpAI59YQtC5m4dIpv4SftzbbUzhQ
 8mbwEASRU13aBqCAdEEM8FfmOsYq9oqpbauic/XP3MaDQbbSpoHSjyVcSs1liMFGOkpj25h4gSc
 RGt/+5LIFHIQgZvtnN9X+GwKlhf386J1++DUWzqBfCCW6in+AnFUm4a8cbBByA5qH5zVl9SY
X-Received: by 2002:a05:620a:1a17:b0:93a:1091:e692 with SMTP id
 af79cd13be357-93bdbaa321dmr92009785a.7.1789683007747; 
 Thu, 17 Sep 2026 15:10:07 -0700 (PDT)
X-Received: by 2002:a05:620a:1a17:b0:93a:1091:e692 with SMTP id
 af79cd13be357-93bdbaa321dmr92006185a.7.1789683007243; 
 Thu, 17 Sep 2026 15:10:07 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93b781dfde3sm572372785a.12.2026.09.17.15.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 15:10:06 -0700 (PDT)
Message-ID: <ff3015a1c4b08088b0638b00670e86d612a27978.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: Fix memory leaks in debugfs and hwmon init
 error paths
From: lyude@redhat.com
To: liupeng <liupeng01@kylinos.cn>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Guenter Roeck
 <linux@roeck-us.net>, "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS"
 <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR NVIDIA
 GEFORCE/QUADRO GPUS" <nouveau@lists.freedesktop.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:HARDWARE 
 ""MONITORING:Keyword:(devm_)?hwmon_device_(un)?register(|_with_groups|_with_info)"
 <linux-hwmon@vger.kernel.org>
Date: Thu, 17 Sep 2026 18:10:05 -0400
In-Reply-To: <20260824090505.49913-1-liupeng01@kylinos.cn>
References: <20260824090505.49913-1-liupeng01@kylinos.cn>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yLnyuUepqcdd3cR1EkJv5LjbQ20lqbSPhpL4RhZ2vuc_1789683008
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

Mind adding the proper Fixes: tags and Cc: tags here?

On Mon, 2026-08-24 at 17:05 +0800, liupeng wrote:
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
> Signed-off-by: liupeng <liupeng01@kylinos.cn>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_debugfs.c | 15 ++++++++++++---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_hwmon.c=C2=A0=C2=A0 |=C2=A0 2 ++
> =C2=A02 files changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> index 47d5579c568d..88223931f382 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> @@ -295,13 +295,22 @@ nouveau_drm_debugfs_init(struct drm_minor
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
> +=09=09return ret;
> +=09}
> +
> +=09return 0;
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

