Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EA3C4452D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:36:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 055CD10EB0F;
	Tue, 21 Jul 2026 18:36:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="GvtmS48f";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE1B310EB0F
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784658974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P9P5vu0pXSNnYy1ZhJcG4vlkpcsOS3Vq5kYWiQ9nQWQ=;
 b=GvtmS48fLm6oQDm23xQQzRuiaiz72u1jb8yWHSpIdCK0vn625zNqxiZDMFtZlPbZpSYVSP
 zW321wx3ez/KOnc1Ny6Bs2MwyWU+RUsS+5vRNUkkQdS+djonhXXnk9SiKz3laVpAUuIC0Z
 BUDcMnRR+HhYpC9TBw9Eap5hUKAEZbw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-W_QDQyGdNfikz5gOWUOBlw-1; Tue, 21 Jul 2026 14:36:13 -0400
X-MC-Unique: W_QDQyGdNfikz5gOWUOBlw-1
X-Mimecast-MFC-AGG-ID: W_QDQyGdNfikz5gOWUOBlw_1784658973
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e52306621so128178385a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784658973; x=1785263773;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Go1C81ar5fv4t+FHR7Abtxew7sOcjBDPFGnY7kzk9t0=;
 b=rUzQ9LXl/u94Q6//ObQWZ0craHPXi1Gj6oIyutB7FNbL4ShngJwPgIw3q9G3S6ZtpQ
 nVNPVnDkgwmfqIPj/gi2o62xmqYsQSDkz+Z10BPLVnuqZGiOEyvr2UhTzTcnGihhC1jy
 oqvXjQc3jlRJH4T7QmTvOZuHdZ6RWpU6uXhSwGhIkuOvag2wMAeJcvldBuvG61jRTDIp
 rMqPKeB7/qe2Uy6x6psnimfXeNl6+ak4j0GVVD4WgmsQsK4rGwDG03efQqXA9qWKrwmd
 MTey5cUxI+ImEVYx4YSKhtBF8IGRJDpyth/JWLMEvFWgXxaIP1HKTfRaaeQAhrNv3l/b
 XnZw==
X-Gm-Message-State: AOJu0YzTnsMGX0z4LM85nqOrNLmPus3CP1znb1NTA3HdkvgTVn8JaUWV
 pNCmRWigWRV3mZYxUWSGlPetpJ5EAkQea2jmXdXGvPxhJM7FeFayXfBcFQmjvlmRmwILFbLL4JF
 b122ye3HLN6cKwQj+ZT2oYBCcCzeC5dlNzkLoM6B7aFvy0k3/W5aJFB/xG34ppTaIm1+k5w==
X-Gm-Gg: AfdE7ckZP79Fzr5zasKcIWQ4U5yXgDVPACifnCvMs/M/jpnMKufj2e+OOwgtSUFWpPq
 Frw2gA0kIt/ZBP1hPMPcW2zTXxYqX7ZEZY+GwW4nzcTecBSk8uoYWKsH6qeO4s5WIXEmtdrpqeJ
 VZnvyiZ3zJCVqb6u53DwwngElB0EpYtV/5WchzS1gjq1ZnFdPrs2fULa/JJZBrEUBDikMp232Cj
 kzH/Q/Wk1A6rs+rNvXCfAQr6ukPMfOPWF1xJFbFkjamxR3umrzPZqFv0VrAnepxFbYRoSoTRPpY
 s39DfcHdypaiztVi8s5Y7JzMqzKbDpQ3hQS/d7dEUH/s9Oo08M0Uw8DUjy2uf6zKXgMpvcwS
X-Received: by 2002:a05:620a:2905:b0:92e:8734:b833 with SMTP id
 af79cd13be357-930b416d543mr1930902785a.59.1784658972797; 
 Tue, 21 Jul 2026 11:36:12 -0700 (PDT)
X-Received: by 2002:a05:620a:2905:b0:92e:8734:b833 with SMTP id
 af79cd13be357-930b416d543mr1930899885a.59.1784658972324; 
 Tue, 21 Jul 2026 11:36:12 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930b52faa8fsm1188355885a.12.2026.07.21.11.36.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:36:11 -0700 (PDT)
Message-ID: <78ca5c308ce81465956e839c82e1bba46a9f0686.camel@redhat.com>
Subject: Re: [PATCH 3/6] drm/nouveau: add GSP hwmon support
From: lyude@redhat.com
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Mary
 Guillemard <mary@mary.zone>, Milos Tijanic	 <mtijanic@nvidia.com>,
 nouveau@lists.freedesktop.org
Date: Tue, 21 Jul 2026 14:36:11 -0400
In-Reply-To: <20260714211429.238355-4-mohamedahmedegypt2001@gmail.com>
References: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
 <20260714211429.238355-4-mohamedahmedegypt2001@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TDK28ZN6hxQnQ1-yNdoTowjyjg9LIS26AxJjICnSzfo_1784658973
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

On Wed, 2026-07-15 at 01:14 +0400, Mohamed Ahmed wrote:
> +static int
> +nouveau_power_read(struct device *dev, u32 attr, int channel, long
> *val)
> +{
> +=09struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> +=09struct nouveau_drm *drm =3D nouveau_drm(drm_dev);
> +=09struct nvkm_iccsense *iccsense =3D nvxx_iccsense(drm);
> +=09struct nvkm_device *device =3D drm->nvkm;
> +=09struct nvkm_gsp *gsp =3D device->gsp;
> +
> +=09if (nvkm_gsp_rusd(gsp))
> +=09=09return nouveau_rusd_power_read(drm_dev, gsp, attr,
> channel, val);

IMO - let's add braces to this conditional

> +=09else {
> +=09=09if (!iccsense)
> +=09=09=09return -EOPNOTSUPP;
> +
> +=09=09switch (attr) {
> +=09=09case hwmon_power_input:
> +=09=09=09if (drm_dev->switch_power_state !=3D
> DRM_SWITCH_POWER_ON)
> +=09=09=09=09return -EINVAL;
> +=09=09=09*val =3D nvkm_iccsense_read_all(iccsense);
> +=09=09=09break;
> +=09=09case hwmon_power_max:
> +=09=09=09*val =3D iccsense->power_w_max;
> +=09=09=09break;
> +=09=09case hwmon_power_crit:
> +=09=09=09*val =3D iccsense->power_w_crit;
> +=09=09=09break;
> +=09=09default:
> +=09=09=09return -EOPNOTSUPP;
> +=09=09}
> +
> +=09=09return 0;
> +=09}
> +}
> +

...

> =C2=A0static int
> =C2=A0nouveau_temp_write(struct device *dev, u32 attr, int channel, long
> val)
> =C2=A0{
> @@ -667,13 +854,39 @@ nouveau_hwmon_init(struct drm_device *dev)
> =C2=A0=09struct nvkm_iccsense *iccsense =3D nvxx_iccsense(drm);
> =C2=A0=09struct nvkm_therm *therm =3D nvxx_therm(drm);
> =C2=A0=09struct nvkm_volt *volt =3D nvxx_volt(drm);
> +=09struct nvkm_device *device =3D drm->nvkm;
> +=09struct nvkm_gsp *gsp =3D device->gsp;
> =C2=A0=09const struct attribute_group *special_groups[N_ATTR_GROUPS];
> =C2=A0=09struct nouveau_hwmon *hwmon;
> =C2=A0=09struct device *hwmon_dev;
> +=09bool rusd_active =3D false;
> =C2=A0=09int ret =3D 0;
> =C2=A0=09int i =3D 0;
> =C2=A0
> -=09if (!iccsense && !therm && !volt) {
> +=09if (nvkm_gsp_rusd(gsp)) {
> +=09=09/* Per-channel visibility is latched below from live
> RUSD
> +=09=09 * section validity, so wait for GSP-RM's first poll
> of both
> +=09=09 * requested groups (thermal, power). It is normally
> completed
> +=09=09 * long before we get here and this is a last
> resort.
> +=09=09 */
> +=09=09unsigned long timeout =3D jiffies +
> +=09=09=09msecs_to_jiffies(2 * gsp->rusd.poll_ms);
> +=09=09bool thermal, power;
> +
> +=09=09for (;;) {
> +=09=09=09thermal =3D nouveau_rusd_ok(gsp,
> NVKM_GSP_RUSD_TEMP_GPU);
> +=09=09=09power =3D nouveau_rusd_ok(gsp,
> NVKM_GSP_RUSD_POWER_GPU) ||
> +=09=09=09=09nouveau_rusd_ok(gsp,
> NVKM_GSP_RUSD_POWER_GPU_AVG) ||
> +=09=09=09=09nouveau_rusd_ok(gsp,
> NVKM_GSP_RUSD_POWER_CAP);
> +=09=09=09if ((thermal && power) ||
> !time_before(jiffies, timeout))
> +=09=09=09=09break;
> +=09=09=09msleep(20);
> +=09=09}

Is it possible to use nvif_msec() here?

> +
> +=09=09rusd_active =3D thermal || power;
> +=09}
> +
> +=09if (!iccsense && !therm && !volt && !rusd_active) {
> =C2=A0=09=09NV_DEBUG(drm, "Skipping hwmon registration\n");
> =C2=A0=09=09return 0;
> =C2=A0=09}

