Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC10EC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 21:37:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ACB910E12F;
	Mon, 29 Jun 2026 21:37:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="VPFptE5i";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C44810E12F
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 21:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782769041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7uutpCNWAahXhInXrsjarJ8XhuURUcRvN4QenNk1700=;
 b=VPFptE5iICJNyse5GPQT+Y49psNWy39VUExIJudv/rGtzppS/QQ755TFQDGIBGWdAiJZ8R
 8ttWRJHqQjQvsyNYaVFL0a+LNBOoxOUZkqvm8+AjdVRCmbi06mcN5BjWk0bM5NrlDmVbwk
 seMwb2BiaxSJp/501gYA2YAa1a3xgjM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-28UDEn0qN_6UiLvxNSCgAA-1; Mon, 29 Jun 2026 17:37:19 -0400
X-MC-Unique: 28UDEn0qN_6UiLvxNSCgAA-1
X-Mimecast-MFC-AGG-ID: 28UDEn0qN_6UiLvxNSCgAA_1782769039
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51bf321d786so19874651cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782769039; x=1783373839;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4h5QDGQfeC12aIw9GPepcb1Zj6xE1bUvcgth2ziWe1A=;
 b=CrbX/IToSy5DsciufwHv6r5aZywcUAKlfHUACHyslzAXCoDnO8WAvF0R9UAgjlhch0
 SqEPCMfevWt4n1vKUnlF2vQjm089Ll/1B3mYqcGGctLd3ZxrWCjjS+b69/d2pEvI5vEW
 l3FcoCacm4tMfK56MVNNjNHP/lmqV+KblzVjPdO/+W5GEf+AA7MAML+/N0AGrZX2q6E9
 X0KZeexZmRIH50yMUxErO0+MoN0cE+hL1gzoH8LgbSenqSVTu6wX1cSo/rBZJUQT7Eot
 M1OiQPpa4q/VLD12fKo1U72RZW5qJc3xgwKqg9p999/BhLVXeMN/kqzAZBSvWqL1GpyE
 zIxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bGKPdY6hj9NeehBJ1MZWGdBl42L9fnAbnQ/UmeQSs9PKnG0brnCjfSLVys9jG97OInpvIwQbQKFg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyOg9cOpfQJjsdLI+qsFklN/1GXeyUEsg7Aa+iAbI24PYmOP4gV
 Lt92eJtxl0eTyvysSFvx5Xua394PnH3CxMAIpEG4JWI8tEITV3eOTxr7NM4laSwwA1KLctJXYTX
 I4TOtB5icNDp1unIY5ELGHsk7Lp5marNzFHwxv1onJeSFeoE2oLSldr8x6Mo2OPgS53z+vQ==
X-Gm-Gg: AfdE7cnFZmduNfWBtZKrdgbdmtWdUvRjmAhjwxO70IrJuC5JLLe6xukdhnkzq/OM9Ye
 PsrZeBGKsDRwyIAt8NzVk31EdK/VGtTPAD5NXqi4pDPJf3dayM1iiiGksYvBtLzXk6bVgWmPU5J
 7Foj34ihL+kcJ+OJZqTv1TpeSuaHl+yyzApemkH7WtNtw1m7vIdqvV4j2RN+iAIBiXvDfvk6KQs
 mQzdfLQ4S80+Z2/el1d6uxvcp7PuE414Kb/KhQ/hk61VYxPki4e9jBXVUNQhNbnp750xIrvZ96A
 VyIocqERdSWYCtbPrcdYxdUQG6Vmbjg6SA2I7YflF47NTktv9GurUa0DPfn7GKB4RLEgFqZb/UZ
 0uzOOgW0=
X-Received: by 2002:ac8:5811:0:b0:51c:1d9:e95c with SMTP id
 d75a77b69052e-51c10716e14mr16826151cf.5.1782769039166; 
 Mon, 29 Jun 2026 14:37:19 -0700 (PDT)
X-Received: by 2002:ac8:5811:0:b0:51c:1d9:e95c with SMTP id
 d75a77b69052e-51c10716e14mr16825551cf.5.1782769038320; 
 Mon, 29 Jun 2026 14:37:18 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f1a69c25absm7952766d6.27.2026.06.29.14.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 14:37:17 -0700 (PDT)
Message-ID: <88003b81e8dc83f675ab94280409a1202a0c2959.camel@redhat.com>
Subject: Re: [PATCH v5 16/19] drm: fix race between partial
 drm_dev_register() failure and ioctl
From: lyude@redhat.com
To: Danilo Krummrich <dakr@kernel.org>, aliceryhl@google.com, 
 daniel.almeida@collabora.com, acourbot@nvidia.com, ecourtney@nvidia.com, 
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, 	lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, 	deborah.brouwer@collabora.com,
 boris.brezillon@collabora.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, stable@vger.kernel.org,
 sashiko-bot@kernel.org
Date: Mon, 29 Jun 2026 17:37:17 -0400
In-Reply-To: <20260628145406.2107056-17-dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-17-dakr@kernel.org>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SdnsqofIXN2Ft3aPysqJgwSH_8ukB05TEjz5qHejjvA_1782769039
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

On Sun, 2026-06-28 at 16:53 +0200, Danilo Krummrich wrote:
> If drm_dev_register() fails after registering a minor (e.g. render
> minor
> registered, primary minor fails), userspace could have opened the
> first
> minor and entered a drm_dev_enter() critical section. Since the
> unplugged flag was never set, the ioctl proceeds while the error path
> tears down device resources.
>=20
> Fix this by introducing drm_dev_synchronize_unplug(), which sets the
> unplugged flag and waits for the SRCU barrier, ensuring all in-flight
> drm_dev_enter() critical sections complete before cleanup proceeds;
> call
> it on the error path of drm_dev_register().
>=20
> Fixes: bee330f3d672 ("drm: Use srcu to protect drm_device.unplugged")
> Cc: stable@vger.kernel.org
> Reported-by: sashiko-bot@kernel.org
> Closes:
> https://lore.kernel.org/all/20260620190648.2E9F61F000E9@smtp.kernel.org/
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> =C2=A0drivers/gpu/drm/drm_drv.c | 34 +++++++++++++++++++++++++---------
> =C2=A01 file changed, 25 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 675675480da4..e890052061f3 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -473,6 +473,22 @@ void drm_dev_exit(int idx)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(drm_dev_exit);
> =C2=A0
> +/*
> + * Mark the device as unplugged and wait for any in-flight
> drm_dev_enter()
> + * critical sections to complete.
> + */
> +static void drm_dev_synchronize_unplug(struct drm_device *dev)
> +{
> +=09/*
> +=09 * After synchronizing any critical read section is
> guaranteed to see
> +=09 * the new value of ->unplugged, and any critical section
> which might
> +=09 * still have seen the old value of ->unplugged is
> guaranteed to have
> +=09 * finished.
> +=09 */
> +=09dev->unplugged =3D true;
> +=09synchronize_srcu(&drm_unplug_srcu);
> +}
> +
> =C2=A0/**
> =C2=A0 * drm_dev_unplug - unplug a DRM device
> =C2=A0 * @dev: DRM device
> @@ -485,15 +501,7 @@ EXPORT_SYMBOL(drm_dev_exit);
> =C2=A0 */
> =C2=A0void drm_dev_unplug(struct drm_device *dev)
> =C2=A0{
> -=09/*
> -=09 * After synchronizing any critical read section is
> guaranteed to see
> -=09 * the new value of ->unplugged, and any critical section
> which might
> -=09 * still have seen the old value of ->unplugged is
> guaranteed to have
> -=09 * finished.
> -=09 */
> -=09dev->unplugged =3D true;
> -=09synchronize_srcu(&drm_unplug_srcu);
> -
> +=09drm_dev_synchronize_unplug(dev);
> =C2=A0=09drm_dev_unregister(dev);
> =C2=A0
> =C2=A0=09/* Clear all CPU mappings pointing to this device */
> @@ -1091,6 +1099,7 @@ int drm_dev_register(struct drm_device *dev,
> unsigned long flags)
> =C2=A0=09=09goto err_minors;
> =C2=A0
> =C2=A0=09dev->registered =3D true;
> +=09dev->unplugged =3D false;
> =C2=A0
> =C2=A0=09if (driver->load) {
> =C2=A0=09=09ret =3D driver->load(dev, flags);
> @@ -1118,6 +1127,13 @@ int drm_dev_register(struct drm_device *dev,
> unsigned long flags)
> =C2=A0=09if (dev->driver->unload)
> =C2=A0=09=09dev->driver->unload(dev);
> =C2=A0err_minors:
> +=09/*
> +=09 * If a minor was registered before the failure, userspace
> could have
> +=09 * opened it and entered a drm_dev_enter() critical section.
> Ensure all
> +=09 * such sections complete before we clean up.
> +=09 */
> +=09drm_dev_synchronize_unplug(dev);
> +
> =C2=A0=09remove_compat_control_link(dev);
> =C2=A0=09drm_minor_unregister(dev, DRM_MINOR_ACCEL);
> =C2=A0=09drm_minor_unregister(dev, DRM_MINOR_PRIMARY);

