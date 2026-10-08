Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DDDCA6015
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E29FE10E998;
	Thu,  8 Oct 2026 21:46:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="QmTvg/jS";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B963610EA51
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 21:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791495948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EyNzZz6RcBzpojw9dgyUDFR/P3xHcOkXjGk7Z+KkOWc=;
 b=QmTvg/jS2vRNBIv851kxuYwA2VyI68I4HGymtN4JDcFYnK4OpoZvjylBxSSc8YQCULaezf
 Hx0e/MqHNiZU4c7vZdP9BDqQMGC4tzHAog7cANr3w+R7zgJyI2MUtnCQIUh9QBvagmPFmI
 Gy2YVrxbHOd1yoAFl+4R8mk0Gjsk//8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-We2YcI_oNxGKvfxwfbrD6Q-1; Thu, 8 Oct 2026 21:45:47 +0000
X-MC-Unique: We2YcI_oNxGKvfxwfbrD6Q-1
X-Mimecast-MFC-AGG-ID: We2YcI_oNxGKvfxwfbrD6Q_1791495947
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-917b7dd3f1dso97122596d6.3
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 14:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791495947; x=1792100747;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JS+En9JyGsTr3AjbcaJ6blNY5U2s+JVwhjESLMBOqZQ=;
 b=UJL5fLVyaSrdIk7rVUuKy2zlpqfR60o7J+49TUbEow7OatU+hNcHipsJA6nCUzuUwQ
 Mis3o9G0wzZ6RHUrHSsfFaLANu5v9PMFoMNhzkDJgSOxAPDM4whUfT7eZ6YdqvyFXlKf
 5OUQlbFTjSE3u/mjyQRiqW2Wy55ZM46eeF82BgAKDusF12FXcO7xQfeFBStqR8BLfuad
 QJvHD6PrUTA5m3/0O9kgy0LXq+JmmkkzPkTM+bjdaRcF2EnCf4P/UuAqjZloKzjMPYmi
 1rqbYLzLMQq+6Vc0BGMKGG/D62G4S1pkmEWhHGBgpUAcvgc0UEeqLVE7c9RoN1S1xEXD
 77Qg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXLGby9PUbvN8/rd6qnNSjgLFJeSUOfYuDwA99ia7GyKEusAr7UaAxMNHNgqgG96GYJXLRquaHHTY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJAmhkrigy0FZNch70K0frUSpO9rDSSq57cu4+ksHH43HDGe7Dz
 RJXxFktIZy6k9MK5cy2SZd03Y4b4k0dUOG+Qjs2mxN9Z35ruKg7STF/l5yjxshWCOuYtt2NPhF2
 D0QvCLl2U5diOKFITqJBo0Neqsyj5zsCZZEH8TrJ2He4RYIyU+I0NYLnbF6yN/ncu+aqkzw==
X-Gm-Gg: AYBFou3t+rRCEDjtLrXRZIgJqj9oSq+eaDR9Um2SAXg0EmVJdVSvdF2n4iMOubAfhJI
 14LqjQJO8VvTzkfuNZqfHIMXLckqHPzXuvDXQTgWqHHXuiO/R8IBbSO4lsGEj+A4ST/qdaR7NQa
 gQlPsGXGktTezC7NWQMLwulD7/FBL+FTwC8zSZ0VXH/HaV+MBTmj8vXGYvsgwhHF7lg4sGE2lC2
 G09DDNYBtZPSeDJJqJvoxUv1AgRIMHq3WIiJhBl7i0k9JB4GQQzHv7YQ5w5+2ynsD06mzPPzDPK
 eRzsXzgE7vbttXwANl/zi6t72gnvjrQXJjHXO2qCpkYxMUbZoTk+b53foMkaESRL1vVBdcs=
X-Received: by 2002:a05:6214:1d0d:b0:918:d743:fd92 with SMTP id
 6a1803df08f44-91b555354f7mr894356d6.24.1791495946475; 
 Thu, 08 Oct 2026 14:45:46 -0700 (PDT)
X-Received: by 2002:a05:6214:1d0d:b0:918:d743:fd92 with SMTP id
 6a1803df08f44-91b555354f7mr893776d6.24.1791495945817; 
 Thu, 08 Oct 2026 14:45:45 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b550ca9a7sm949466d6.38.2026.10.08.14.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 14:45:45 -0700 (PDT)
Message-ID: <ea9a1d374cf3127e5047bc73807ce821022e026e.camel@redhat.com>
Subject: Re: [PATCH v2] drm/nouveau: Fix memory leaks in debugfs and hwmon
 init error paths
From: lyude@redhat.com
To: liupeng <liupeng01@kylinos.cn>, dakr@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, 	airlied@gmail.com, simona@ffwll.ch,
 linux@roeck-us.net, nouveau@karolherbst.de, 	bskeggs@redhat.com,
 dri-devel@lists.freedesktop.org, 	nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 	linux-hwmon@vger.kernel.org,
 stable@vger.kernel.org
Date: Thu, 08 Oct 2026 17:45:44 -0400
In-Reply-To: <20260922044044.21442-1-liupeng01@kylinos.cn>
References: <ff3015a1c4b08088b0638b00670e86d612a27978.camel@redhat.com>
 <20260922044044.21442-1-liupeng01@kylinos.cn>
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Tgg9wN2ENrr7vlqAhVfNBjOC2B1gESPxPuZiEW1zVWU_1791495947
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

One nit-pick below:

On Tue, 2026-09-22 at 12:40 +0800, liupeng wrote:
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
> Signed-off-by: liupeng <liupeng01@kylinos.cn>
> ---
> Changes in v2:
> - Add Fixes: tags for the commits that introduced the leaks
> - Add Cc: stable@vger.kernel.org=C2=A0for stable backporting
>=20
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

^ We could get rid of this extra return=E2=80=A6

> +=09}
> +
> +=09return 0;

=E2=80=A6and just return ret here

With that fixed:

Reviewed-by: Lyude Paul <lyude@redhat.com>
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

