Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3ABCA9EBE
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 21:43:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC78F1122CE;
	Fri,  9 Oct 2026 21:43:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="QgT/hw70";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25E8A1122D3
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 21:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791582237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+fG0/9M7RFD3O+uQHFvadJlGPM44bJAg3Gi/iApoV4=;
 b=QgT/hw70xAyqtSa8dcYJQfJm7cpCp/5rC0Thq5lfSqF8xI2Y06+KHf2Z+Nnk9wEka9Ccqd
 kbg2wIEXy6RJXpBW+6DyhtbEQBmCj1SZYHV3a+kcHc9kPV1XvT2D1OrLAM06Mk/A3DvTnO
 09uxiaqNEfYmwSKqTNfwhLszhSlAvGU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-7Um-roa9NOmb8KICzwsnug-1; Fri, 9 Oct 2026 21:43:56 +0000
X-MC-Unique: 7Um-roa9NOmb8KICzwsnug-1
X-Mimecast-MFC-AGG-ID: 7Um-roa9NOmb8KICzwsnug_1791582235
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5338cfe567eso3312711cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 14:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791582235; x=1792187035;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DlNSozwHWelaDwiAeqzmQRLEfEKU54b/1DRu7LW/zDY=;
 b=FOLUSXdZZIZeijhXr1201Rn6+pvscfDuT12TF9Vy1sLsDPeVc7pnxAC0CvmtF3qeFN
 IJjHyKHhzuXlMM6f6cEQ7mpzfR1kLlEb5tLJ0nAqZzHMdPo18JtoCdfK4p3uEXthoe+d
 71YNeuwtnWHtrdAwIc+alc2z2qHJXxP8AXUzNrkfbR804R3Ee1AyMR9bViJ+jpb/Z4vt
 BCbeu+/WfJK5fnR0XYQkcWyq9gXw/uBm8SEacRP41wnrSlmLmPINCCPfzfYQKpSUzW/g
 5xMGEzzRhjZ80aU8lyobtXLp7CwG+DvqJcD1NlkcbkCUQP2JMjFWOrA10aMjjPkeN/yB
 dKYw==
X-Forwarded-Encrypted: i=1;
 AKwUvByVD7G2IX8KsePjA610uIvEMkG8QptpUwG0eEW1qCeMZLHo4WqvJrz9ohplAbE+mMK99xyfHbPxSWs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKAql9uvnXSAP4nbPM14mbUPqkBvIxA5eHj2KE862jLThf3VUFS
 VajGo0RqTVS5wryH411Z4OeGiYYRcqTHKayMFBwqlBEk7qg9lQmYbhqXnyd8HSvfmOUSX7YC5kY
 KTVOu7zqs5fhHdYJevZVYFjpNojW1HgfsBLxQrCgHTrZ87A/irXI40uiBaCbzEXOWD2mXQg==
X-Gm-Gg: AYBFou3o8gmS9iWMhsvBpCG31LWgBcVZ6982Vb3WZiC1lKzvhOagkM9cZ/GY2GUA0Vo
 D/rHeyRujzbDNOrvcMbfEtbQQsdlORWDybljfgcu3G6zAMkaLhaTWxTtVcxpDp96P28jAm0zjou
 UyQhmF5ZlOVMYyvvp2WKRDEBTIwEsXavhTD5bpHJnuK5XZHhjQDFKvApRur80khCUmoEPhwNOTL
 Y/4N9iE1gOE8JgGnj6mTB3p15vcFvGEH9SlKtZxzznhQllK5eAj4smN4a4YbyzSFj1vsQlEDEah
 mQPID+kAMSiIOWNwWlRjpLPwA9U/iZkkHyYCf/VLhysyvmTPonMICe6WDVG2cjrAhdbV8Kg=
X-Received: by 2002:a05:622a:58c4:b0:535:a5fb:67fb with SMTP id
 d75a77b69052e-535a5fb8494mr34446281cf.71.1791582235418; 
 Fri, 09 Oct 2026 14:43:55 -0700 (PDT)
X-Received: by 2002:a05:622a:58c4:b0:535:a5fb:67fb with SMTP id
 d75a77b69052e-535a5fb8494mr34446061cf.71.1791582234996; 
 Fri, 09 Oct 2026 14:43:54 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b55092856sm28672986d6.35.2026.10.09.14.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 14:43:54 -0700 (PDT)
Message-ID: <b4cd38b48d85298a7a99cf30fbd8cbbdb34a347f.camel@redhat.com>
Subject: Re: [PATCH v3] drm/nouveau: Fix memory leaks in debugfs and hwmon
 init error paths
From: lyude@redhat.com
To: Danilo Krummrich <dakr@kernel.org>
Cc: liupeng <liupeng01@kylinos.cn>, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, 	linux@roeck-us.net, nouveau@karolherbst.de,
 bskeggs@redhat.com, 	dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, 	linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, 	stable@vger.kernel.org
Date: Fri, 09 Oct 2026 17:43:53 -0400
In-Reply-To: <DM0MU0O43EB9.3EEKZ4C2IUP9J@kernel.org>
References: <ea9a1d374cf3127e5047bc73807ce821022e026e.camel@redhat.com>
 <20261009115151.13877-1-liupeng01@kylinos.cn>
 <25778dca265f58185917c5948490e76184c778d3.camel@redhat.com>
 <DM0MU0O43EB9.3EEKZ4C2IUP9J@kernel.org>
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: COULm_1z_mIcNYMR5sHGa9H_n07Wirkb1hyg1CqW854_1791582235
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

On Fri, 2026-10-09 at 23:40 +0200, Danilo Krummrich wrote:
> On Fri Oct 9, 2026 at 11:35 PM CEST, lyude wrote:
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
> >=20
> > Will push to drm-misc-fixes in a moment
>=20
> Please wait, those are two unrelated fixes with two different Fixes:
> tags, so
> those should be two separate patches.

Thanks, I think my brain just glossed over the tags while looking at
this.

liupeng, could you split these patches up?

>=20
> I'm also not sure this is -fixes material. A memory leak in an unwind
> path for
> -rc7 feels wrong.
>=20
> Thanks,
> Danilo
>=20
> > On Fri, 2026-10-09 at 19:51 +0800, liupeng wrote:
> > > In nouveau_debugfs_init(), if nvif_object_ctor() fails, the
> > > previously
> > > allocated drm->debugfs is leaked because the function returns the
> > > error code directly.
> > >=20
> > > In nouveau_hwmon_init(), if hwmon_device_register_with_info()
> > > fails,
> > > the allocated hwmon structure is leaked because the function
> > > returns
> > > the error code directly.
> > >=20
> > > Fix both by freeing the allocated memory and clearing the pointer
> > > on
> > > the error paths.
> > >=20
> > > Fixes: b126a200e9db ("drm/nouveau/debugfs: we need a ctrl object
> > > for
> > > debugfs")
> > > Fixes: b9ed919f1c8f ("drm/nouveau/drm/pm: remove everything
> > > except
> > > the hwmon interfaces to THERM")
> > > Cc: stable@vger.kernel.org
> > > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > > Signed-off-by: liupeng <liupeng01@kylinos.cn>
> > > ---
> > > Changes in v3:
> > > - Drop the extra return in nouveau_debugfs_init() as suggested by
> > > Lyude.
> > > - Add Reviewed-by tag.
> > >=20
> > > =C2=A0drivers/gpu/drm/nouveau/nouveau_debugfs.c | 14 +++++++++++---
> > > =C2=A0drivers/gpu/drm/nouveau/nouveau_hwmon.c=C2=A0=C2=A0 |=C2=A0 2 +=
+
> > > =C2=A02 files changed, 13 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> > > b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> > > index 47d5579c568d..338421e52f69 100644
> > > --- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> > > +++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> > > @@ -295,13 +295,21 @@ nouveau_drm_debugfs_init(struct drm_minor
> > > *minor)
> > > =C2=A0int
> > > =C2=A0nouveau_debugfs_init(struct nouveau_drm *drm)
> > > =C2=A0{
> > > +=09int ret;
> > > +
> > > =C2=A0=09drm->debugfs =3D kzalloc_obj(*drm->debugfs);
> > > =C2=A0=09if (!drm->debugfs)
> > > =C2=A0=09=09return -ENOMEM;
> > > =C2=A0
> > > -=09return nvif_object_ctor(&drm->client.device.object,
> > > "debugfsCtrl", 0,
> > > -=09=09=09=09NVIF_CLASS_CONTROL, NULL, 0,
> > > -=09=09=09=09&drm->debugfs->ctrl);
> > > +=09ret =3D nvif_object_ctor(&drm->client.device.object,
> > > "debugfsCtrl", 0,
> > > +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NVIF_CLASS_CONTROL, NU=
LL, 0,
> > > +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &drm->debugfs->ctrl);
> > > +=09if (ret) {
> > > +=09=09kfree(drm->debugfs);
> > > +=09=09drm->debugfs =3D NULL;
> > > +=09}
> > > +
> > > +=09return ret;
> > > =C2=A0}
> > > =C2=A0
> > > =C2=A0void
> > > diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> > > b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> > > index 726397ab035d..ffbe7f542ab0 100644
> > > --- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> > > +++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> > > @@ -697,6 +697,8 @@ nouveau_hwmon_init(struct drm_device *dev)
> > > =C2=A0=09if (IS_ERR(hwmon_dev)) {
> > > =C2=A0=09=09ret =3D PTR_ERR(hwmon_dev);
> > > =C2=A0=09=09NV_ERROR(drm, "Unable to register hwmon device:
> > > %d\n", ret);
> > > +=09=09drm->hwmon =3D NULL;
> > > +=09=09kfree(hwmon);
> > > =C2=A0=09=09return ret;
> > > =C2=A0=09}
> > > =C2=A0

