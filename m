Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94300C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 19:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC11C10E3BA;
	Tue, 21 Jul 2026 19:37:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D2IyRNnm";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F8A810E3C0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 19:37:10 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cbb8b54fcf8so663039a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 12:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784662630; cv=none;
 d=google.com; s=arc-20260327;
 b=K38zR4So3JD0YmbQM9yA+XzdB8Ln/OFFhjRFPeMmY3QlJA/4WRjYkHW5pQW6pj1BiL
 gm8F13pXeYebN6BkoZ+iCQxfepiPF5J8rkhiIqo73M1HdNKRcXSlDmqCKN3eLuD1bnL4
 EOox9TolbdKghzJ2fKeDR3nWLxj9t873oINmvp3OsD0p5QaK91OegrhL8Co83cfXuc6I
 QDGDfdzRTRjtHsFw9mf45ZaUAZGUjnhf87twDVL8Wqdu+Zk+ybSu96v+8usIy6Awl0op
 XAL1PN9lw0TLBRm4MkI6D6RlOLdHfqIiPu1XdJLblqEYINpPwHzUtsJWOZzu+/kb5C4x
 08tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sOY7eReV4Z5bcCLysipftskzwGQCZFqDBhkocCq/BoY=;
 fh=Mhq+i45JTEUdnr0MIInOdnrOMdgRwK1JWKTOaEfwob0=;
 b=DfNvhkzZHmmQQQWij8KYhtZseK1zpvaKTPZXDRj6aAnLRt5yk1y6rD0NY0/gpEcCJd
 c1rWknVzUCQMDz5IhZXDLkjCvgoMTqJotFOaq6Q6Wn+Mza6S/k7Qiyv0i+x5PWD50N/T
 v3pW86DYS40Gx4nv6vYQW2WEiTr2xEx+GXLMo3BZ9iHvKJYNmqldVK5WveBhpPiG70tV
 OR2ES7wGs92TfxTuM6OV13SV8ErGb+wyl9HFWr97wdxEC4TfjARF5M65xhzPuL6clbpj
 eCsLabjtgFFHy1yz3dcxvBo92vetnQlh2gsW48OxNmHamhj10VyDiWryIoQqd5FZo2cu
 So1A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784662630; x=1785267430; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sOY7eReV4Z5bcCLysipftskzwGQCZFqDBhkocCq/BoY=;
 b=D2IyRNnmFKcc7Q2EVeB0Rmt/KyPrcfZRi3V+G4na9g3nZhwKCvpcP1JKDRz2lnqh/E
 YSmWDcpKFN/OqlKxLmmrMm26AxwByMl5K041ezJ3y39yqJrrysRRAgcJP+1w/vmZ3kPz
 yK9lyIcILA2pDIfmvVR6lsZH9YkhonC/Tzglm2nhSt9A5LHc69GOOJyBU0607Vf0iSN/
 ACBHMLk/i3VvjIfegzsvPyYPIW4MB9bjeoxSJ7pl5rGyaF2/qjMaGg6bJYntVtS/2qUT
 5oMeLzYl9A0/Wrmv4HDNUVHEKKRnBFxe+ykDG6hlwoqfjdvYILnyFLQ27EXf8nS0DIb/
 zbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784662630; x=1785267430;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sOY7eReV4Z5bcCLysipftskzwGQCZFqDBhkocCq/BoY=;
 b=VKZ4fhJd/jL/XCUToUR5t66Sxa7YcsBMmUeR3ZASNRhV98B7wuR++VeRvDNBvPHoya
 QtC2rtkk4BswZ6uFnD7ZfRU5Eisr1i8SZzdVK4HOdVRgwhO4QupKQlk306BLqTnc8zLn
 mcNAOi9F4Sy6tVlju0tputN+52ZcExfRVEi7Zp+0PiybCE+7ClI6h/r7q/zv40lyQv8C
 Qs9aRRe/C7dIY3yBOyounV5zOE30vvkCSOJ7rXAfT9b5bPFIY89jkLm5CeiQXIh+tb5P
 9MKwofHDX0b8qr6Xj7D0FJTBvM3lxu/lRQZ5hgFThQbHWCt1/CrZCuJa/0lO02Gse1hs
 0uOA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrOtVsfsd55hq2KpUQhJSgb0sutrqQDCuVC1pgiqcKVBDSDkad9zm7DCAt7ckPsw6/tNMshB3Xt7fY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwBk/zgzC03iF64qyZ4z+H5wR4qbJmI+LiBENa5495B54tMCEn8
 2XAlxkX57T4Rl4p+Ek6AhVAzS/MSujBCZs9R1G+FipXzIntsty54ckDM3TlV8PdQAOO7Ag0k6pp
 i/ByjQWG4rVPzIfSllzd3x6SEHHjpOKI=
X-Gm-Gg: AR+sD10oZLe3Hr4ufRZQlQ+nwPMCfAphYA1qJwY5UQS8z0PGQ+Dl6+zcqKohSWkBmoG
 ktFEpjyd3rAbntAiEYysDImEv3WxUVa/RXLeQpFY/VLDm9dy4kaswczKTJHy500LXl0Won230FI
 5MccA+i32hQ+xc1TA8KplUYUWT6xMGe1XXH/tFrRs9mmAGHISn547QwPZNzg+NyacL2mgGOkj/w
 F+Og6H0BC0RIslTBK/4VwbkqtcEdtVmDC/0f17Wu//Z5MhN7/Fj7trHWjGszU9Z/TMeoz0F27bm
 izqt
X-Received: by 2002:a05:6a20:7487:b0:3bf:6c05:ab with SMTP id
 adf61e73a8af0-3c3ad9d632bmr21640259637.58.1784662629564; Tue, 21 Jul 2026
 12:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
 <20260714211429.238355-4-mohamedahmedegypt2001@gmail.com>
 <78ca5c308ce81465956e839c82e1bba46a9f0686.camel@redhat.com>
In-Reply-To: <78ca5c308ce81465956e839c82e1bba46a9f0686.camel@redhat.com>
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Date: Tue, 21 Jul 2026 23:36:58 +0400
X-Gm-Features: AUfX_mzGwUNpX520bsNPEhX1qvh744PJolN7Udftq3CicklwG3Y8nVM_WZ-pl_4
Message-ID: <CAA+WOBuLgkKy_BAgEWgN7jgxDrJYchO1D+B44u6VVMPsGJ-AEA@mail.gmail.com>
Subject: Re: [PATCH 3/6] drm/nouveau: add GSP hwmon support
To: lyude@redhat.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mary Guillemard <mary@mary.zone>, 
 Milos Tijanic <mtijanic@nvidia.com>, nouveau@lists.freedesktop.org
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

On Tue, Jul 21, 2026 at 10:36=E2=80=AFPM <lyude@redhat.com> wrote:
>
> On Wed, 2026-07-15 at 01:14 +0400, Mohamed Ahmed wrote:
> > +static int
> > +nouveau_power_read(struct device *dev, u32 attr, int channel, long
> > *val)
> > +{
> > +     struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> > +     struct nouveau_drm *drm =3D nouveau_drm(drm_dev);
> > +     struct nvkm_iccsense *iccsense =3D nvxx_iccsense(drm);
> > +     struct nvkm_device *device =3D drm->nvkm;
> > +     struct nvkm_gsp *gsp =3D device->gsp;
> > +
> > +     if (nvkm_gsp_rusd(gsp))
> > +             return nouveau_rusd_power_read(drm_dev, gsp, attr,
> > channel, val);
>
> IMO - let's add braces to this conditional
>
> > +     else {
> > +             if (!iccsense)
> > +                     return -EOPNOTSUPP;
> > +
> > +             switch (attr) {
> > +             case hwmon_power_input:
> > +                     if (drm_dev->switch_power_state !=3D
> > DRM_SWITCH_POWER_ON)
> > +                             return -EINVAL;
> > +                     *val =3D nvkm_iccsense_read_all(iccsense);
> > +                     break;
> > +             case hwmon_power_max:
> > +                     *val =3D iccsense->power_w_max;
> > +                     break;
> > +             case hwmon_power_crit:
> > +                     *val =3D iccsense->power_w_crit;
> > +                     break;
> > +             default:
> > +                     return -EOPNOTSUPP;
> > +             }
> > +
> > +             return 0;
> > +     }
> > +}
> > +
>
> ...
>
> >  static int
> >  nouveau_temp_write(struct device *dev, u32 attr, int channel, long
> > val)
> >  {
> > @@ -667,13 +854,39 @@ nouveau_hwmon_init(struct drm_device *dev)
> >       struct nvkm_iccsense *iccsense =3D nvxx_iccsense(drm);
> >       struct nvkm_therm *therm =3D nvxx_therm(drm);
> >       struct nvkm_volt *volt =3D nvxx_volt(drm);
> > +     struct nvkm_device *device =3D drm->nvkm;
> > +     struct nvkm_gsp *gsp =3D device->gsp;
> >       const struct attribute_group *special_groups[N_ATTR_GROUPS];
> >       struct nouveau_hwmon *hwmon;
> >       struct device *hwmon_dev;
> > +     bool rusd_active =3D false;
> >       int ret =3D 0;
> >       int i =3D 0;
> >
> > -     if (!iccsense && !therm && !volt) {
> > +     if (nvkm_gsp_rusd(gsp)) {
> > +             /* Per-channel visibility is latched below from live
> > RUSD
> > +              * section validity, so wait for GSP-RM's first poll
> > of both
> > +              * requested groups (thermal, power). It is normally
> > completed
> > +              * long before we get here and this is a last
> > resort.
> > +              */
> > +             unsigned long timeout =3D jiffies +
> > +                     msecs_to_jiffies(2 * gsp->rusd.poll_ms);
> > +             bool thermal, power;
> > +
> > +             for (;;) {
> > +                     thermal =3D nouveau_rusd_ok(gsp,
> > NVKM_GSP_RUSD_TEMP_GPU);
> > +                     power =3D nouveau_rusd_ok(gsp,
> > NVKM_GSP_RUSD_POWER_GPU) ||
> > +                             nouveau_rusd_ok(gsp,
> > NVKM_GSP_RUSD_POWER_GPU_AVG) ||
> > +                             nouveau_rusd_ok(gsp,
> > NVKM_GSP_RUSD_POWER_CAP);
> > +                     if ((thermal && power) ||
> > !time_before(jiffies, timeout))
> > +                             break;
> > +                     msleep(20);
> > +             }
>
> Is it possible to use nvif_msec() here?
>

It can work but it's strictly worse than this. nvif_msec() does busy
looping, which would be overkill for this as it would be doing a lot
more reading for something that changes at most once per 500ms poll
cycle, and it keeps the CPU fully occupied with every read. It also
couples us to GPU timing while the main thing we are waiting here on
is whether the GSP's buffer writes are now visible in RAM so GPU side
time doesn't offer us anything. I actually wasn't sure at first how to
properly wait and did go over all the possible timing alternatives and
jiffies looked to be the best here.

That said, to address what Milos mentioned (the weirdness of files
being -ENODATA), I am going to have to move this into nvkm/rusd,
inside r570_rusd_supported()/r570_rusd_read() which doesn't have any
other alternative available to do a similar style waiting loop.

> > +
> > +             rusd_active =3D thermal || power;
> > +     }
> > +
> > +     if (!iccsense && !therm && !volt && !rusd_active) {
> >               NV_DEBUG(drm, "Skipping hwmon registration\n");
> >               return 0;
> >       }
>
