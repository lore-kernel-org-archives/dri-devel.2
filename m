Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7078CC982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDF3D10E05F;
	Mon, 21 Sep 2026 21:57:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="o+zHp8SG";
	dkim-atps=neutral
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D70F610E05F
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 21:57:48 +0000 (UTC)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-39dec5de01eso693629a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 14:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790027868; cv=none;
 d=google.com; s=arc-20260327;
 b=Dsh4PIqnNIhHRFLulES2MLfUHtJ7i5TIt8dl0EwK0snNzHV4zsltiHe4BYttM8BKMA
 wJXKR/FCkSwebm+Nlr4eP/de9BbKOAwBvO/jxFss78NjmnAgnEXR5HhnuC0ZDAq7jZW7
 ht6hjbzImzNWpv1qSk3pcTf5dsUNO3bMwV6apjwYY37DT+oFR83AxIKhWkYu4Xru+xO/
 oRYuQCTKR24+seYn82BXeZ6wiltSpNRTjLjDhLVkOzWDYsPqH3Lr7DqHDBgviCCjfVgu
 Zx5JvFWCGzoVQ7XbNZOVHn7Oi1/kc00Kp+BJZyigFx+J2zh89NVCZa/Pi0lkhWHjt87r
 O/5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RwYh6OjRPIh/KNj842KS6LrZRkmlRh26aRS3vty9X+g=;
 fh=4/SHoKaZ4LMyuhSgcHsBpZTeakBID5V1rXPXvuNsSbk=;
 b=rzwb7/eBH+1BkXrQbnqPB2lohXHShbFlfRQYlHlCT5QPu0AxVOmEf+/7FLE9v2fFFK
 Af5D54d2l24UEhBghI7NdfxR6EfX9S5BnOCgdbS6j7xMnlbnZqYc6zvBu5FswDDOgUzj
 RdefBUiAYgDzeuBYNFellXcTKRYaK2geZFWHxyEkgqkKc91SxL51yKJaUs9ywJVBUP0M
 Zpr5HTMPvdRRRoffZqj6UQO2oARxQbCwMg+2ZoZtAkohz0+1oUrFgVfDn5VbHlGD5rAs
 etmdGbeoXf8YJCkNyqnsAQ39a8sjsh7rphIusGht6LIWziYDILNPjqXarPZm87wuf0Ve
 z/Yg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027868; x=1790632668; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RwYh6OjRPIh/KNj842KS6LrZRkmlRh26aRS3vty9X+g=;
 b=o+zHp8SGO/9CpnbPr60yU/XVajbmSQxnDu4B/0h9pSoie8jzsE41KlwlPC+DvnfyEs
 8p1hQqnqtl6J5yJSK2y11lbW/ZFobIoUVykcUnQu0pYiwRs/TVGrFnpInbdIQlFoT1OY
 +NQ+2hEcc7FcXZSrJqLPYxlvT6v0bZPkapHa6iQLjms0ZNeUCTkJ1UWXNpkjckd+UFcH
 b+nukEcpx4EZLgH1IHYa+krpwhyOTuTXSmOkr1lBxLxwv2Y6nmk0bcStUqEOW/eEJGtC
 tYtgVxyVTpAmW0CLemrerZ/Eas6b+oTzWDWeVuPA9xPDA0MtVz1HNKvmYcgLdoS/NVuX
 9YYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027868; x=1790632668;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RwYh6OjRPIh/KNj842KS6LrZRkmlRh26aRS3vty9X+g=;
 b=hFXjJ10l93F219UJY58SD28tuHRii6p5lbvnbNCsc5skPWb0UCDpKGEYHD33DpfDow
 yHiCxSyEgjrkON5shiuvt2tSYRrIPUSOSgaO9b1DoijDwdXwq2XCd6CXst/ZfyE74oM3
 07TeA+L+QzZI6pwtyr8zx3Hu6RwwFN67815Ei2+of36JNsaecZ71WV9HTIMBQTvlT/fg
 000r1peZ5BAV4Vb+L52s8abqMs+SAvYgH8/bb7WBoAuq1BnBniFuC+8oCWWEiaA37tsj
 1po3m6kIpRiN6tiojlaF1TTArLm4bKjMP56N0I8Q9KGalOIEHgrk8CIRMPBPbQjnsJbR
 OllQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzdH2f/bsjH1wU7WBtme2J16dHeZcS2D4BoJtGTETrSctefqux74A+WSRmwKXZlk6uYaiOBnryXi1M=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nMPcGvWLViBxmMVWZ36PDGE4bxoxPP9BtizPNFmUb4WtV1Bst9
 hbtH/zf3GqfHVOuVf1F9zCfN7yQOFWGT5GOnPVR6Kc0PwOpbLiQPMknKYyjJduOCQw3z9orj4X1
 7FAFnmQvzEJwxIfMXJBjQ1bCjP+Ddvrw=
X-Gm-Gg: AYBFou1jn5r/ZIpw7Qq0GWOceLjw8ZnsKjPdLrXPYc0R+CjNpOgwt3lZUa26lP5JKJq
 AR5hFonQeliIHs/Q/Kd14nLtEwaj9y8OfE4Vg+3tKfhptKsD1mlWiNikg0HXdEqk0v31nRufs0E
 5cP8grzS7eeS1EC4SB99RpcHh+kNOWCIvCUyyuypslX4xvafWgUTl6JgRZn8TG8Yh/PB0oso6tT
 w9b8MpXlg5m8X+e/BggyitwqtZrevWGmTYzMlmOmS/BHAiXMK9IX9+siGSkjsssWwztLievKI+W
 nVnK5Vta5l5QOd7DFm/1sVVp45Tjrr23MEl9DllmrZSbJsJ5OW9WBidB4HJ7s/hDjgqW/CIBYBO
 XMnf4w5ewMM1s3bAnR/FESFWDqOh9rPjXcKYsfocG2A==
X-Received: by 2002:a17:90b:50c6:b0:39d:e1f2:3400 with SMTP id
 98e67ed59e1d1-39e599ff59cmr21734363a91.5.1790027868375; Mon, 21 Sep 2026
 14:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260919165511.3687822-1-lgs201920130244@gmail.com>
 <b483d12d-f34a-4740-929b-28423d9c9b17@amd.com>
In-Reply-To: <b483d12d-f34a-4740-929b-28423d9c9b17@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Sep 2026 17:57:35 -0400
X-Gm-Features: AcwNN1UohLrK7gSjDi2UGC9O6aoP5YtKGJPc1vCQfKTwGIeZ-NrCeJY0S5T4r_c
Message-ID: <CADnq5_MSwTURavbU8ryixhPdsUfgBf64brJpALhkCeLq12BhXg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix IP instance memory leak on kobject add
 failure
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>, 
 Tim Huang <tim.huang@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
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

Applied.  Thanks!

On Mon, Sep 21, 2026 at 1:16=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 19-Sep-26 10:25 PM, Guangshuo Li wrote:
> > amdgpu_discovery_sysfs_ips() allocates ip_hw_instance with
> > kzalloc_flex() and initializes its embedded kobject before calling
> > kobject_add().
> >
> > If kobject_add() fails, the return value is ignored and execution
> > continues without dropping the initial kobject reference. The failed
> > kobject is not retained in the kset list, so the normal sysfs teardown
> > path cannot find it. As a result, ip_hw_instance_release() is never
> > called and the ip_hw_instance allocation is leaked.
> >
> > Call kobject_put() when kobject_add() fails so the initial reference is
> > dropped and ip_hw_instance_release() can free the allocation. Keep the
> > existing best-effort sysfs behavior by continuing with the remaining IP
> > entries after the failed registration.
> >
> > The issue was identified by a static analysis tool I developed and
> > confirmed by manual review.
> >
> > Fixes: a6c40b178092 ("drm/amdgpu: Show IP discovery in sysfs")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_discovery.c
> > index a404d8aa13ee..4b1ad1c0a10b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -1314,6 +1314,8 @@ static int amdgpu_discovery_sysfs_ips(struct amdg=
pu_device *adev,
> >                       ip_hw_instance->kobj.kset =3D &ip_hw_id->hw_id_ks=
et;
> >                       res =3D kobject_add(&ip_hw_instance->kobj, NULL,
> >                                         "%d", ip_hw_instance->num_insta=
nce);
> > +                     if (res)
> > +                             kobject_put(&ip_hw_instance->kobj);
>
> Adding a message that this instance got skipped also will help.
>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>
> Thanks,
> Lijo
>
> >   next_ip:
> >                       if (reg_base_64)
> >                               ip_offset +=3D struct_size(ip, base_addre=
ss_64,
>
