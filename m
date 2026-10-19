Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D91606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L5dwpzjo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14DBF10F302;
	Tue, 20 Oct 2026 07:36:38 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03ACB10EE3C
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 14:56:53 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso145304466b.2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 07:56:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792421811; cv=none;
 d=google.com; s=arc-20260327;
 b=AZ/tWPNG6EZA8PweIkDzpQQzPi2f4JlQ4yKtlPB5VI6UTOR+lqd3AF6DA1VJXaXqcB
 BCxe2gulLXZR5NkaPjN3Ds79B4iIEAt802Y2+2wNdcEldBdINA89ik8YOzBcXbItYwDt
 9mrASJG9Hdz4HPqNce4XmabwUABhylQb6H675avh14XrpbY+u1nlsMK/mo69Uei6WNq/
 yJ279U2LN7QpuqK8vqyEFm7UWCMeJjqp8YBvAsejXbz6IO6OIDg07UI8QgVdyERoPqQL
 aNs2Fz74Z8WldFtAfgrajOBGhQE2C+6Y2F3Id4sjCk9le61gLg1T9PrHGzJeiSYK1x5P
 rmoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YyVJu0EGkl/YFs7ApE6DeIsSQCa9Krhf/9Ms1uzPE1A=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=VuFq6VTogAY18Bhi7cVpzRrezhuTnmAzk8KQ9+ZcIxN0g4jBxQlQDbFruANvhbQl7K
 1MsPt1CzvvayKG5KEJtYjl3Zt65QvFCfVSD/ALfVyDrlmK8DSNAvHPoIXQySSFNtSzg5
 4yk8DZMxijKOzSboxCWWgMuE/yI++9xLUkjeato7Zh+bMuPdFzUQZb/5OMLQiDiSu4Pi
 7sus/SgPGCnBL05WSyCf7yXkxZMNuZrLkwCA0axZ92v/eLEGCXoAtZni4OCbqBZywFju
 aejQsopd8Qgvq6AcCda4pvxjcbm/RcFz0tUsoyUdSWMc4gJnHZ2LhPN4irlAmHmhvuh3
 /SjQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792421811; x=1793026611; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YyVJu0EGkl/YFs7ApE6DeIsSQCa9Krhf/9Ms1uzPE1A=;
 b=L5dwpzjow+qYPw5Ywbtf1QGhqTObnGktngXhmmq+2JjEjup1kug6AlUDnkbMt4jqkw
 4Ygs3E12rkpNHxYKEF9pk1Vl8jqP0O5Sb6KFmas5fWXVX87eZAw8gH4Wnc5gjOD3oi2J
 sTegwUCdKG18a7UwiahfjkJvi9NxyEk/bL+NMjSWzolj/eu0EaENMeI4J4kXtDY87OtR
 QEpP8ZE83qXUvkewvM6w8IT+zhqadlgEfyjjqwL1Fzh399gxaBZSZHETSuERl47SajKq
 eqT26ENwQnly/8/lV7RoXMRJfX7rA5koeJPWv32Ys20eX/ARTzKnzB56PWZ0bepgUJPW
 /vWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792421811; x=1793026611;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YyVJu0EGkl/YFs7ApE6DeIsSQCa9Krhf/9Ms1uzPE1A=;
 b=LyeKcaMzQep/3tYo2r6taT6OoWGeF2z1d31fjGvMUDj+4K5eCSS51axeO+8vorFxwS
 2c7Nr0FLOlsOVgQP3xwEGwkAakNKHQNt+RAQq95M6mYqrxA6pTORcVh5IST8g4UrlvYg
 g9NYQOvB2V9NNk9VLen5RD7em7yhloehOXiMSJKvauKkmeKKPBe+Tp+IeSD+woZZSyQ0
 ELx4cx2B/g9aFdkP4379ZS5s2NYMtm9sntA5UPZqoU/jHCVw6IOfUSevPyVJ2X4QiHOA
 fCHu8uNTgyeaj1I7pscRU3oayEH/FxRNj9By1U7We8zLb7pZlaevylHqKPRIwL0pxdB+
 ItNg==
X-Gm-Message-State: AFq9FYIKJ4+PI+YYnNBcfzD4loRHWioHm2hVwpaGyjHvU2dxQ2hIkKTV
 vJG6BKV4pe/UJALnzpRYlfuBU/eiLT+YFP8Rgf5YMvyAFE1th7D70uPXVRDNYAUZrnQe/B1ARGQ
 l4XhlUFQefvz887SSrLLTSnLWH1OW3cQlZWwBOvs=
X-Gm-Gg: AYBFou0yNMOCpPHlE2hQoTARbWYPYp0AS/5JSPv9sRh0EMSl7p0R6vxYl2yuenZ7w0O
 VuYoy4ghqkeQnHbtLu2S3wsJzfbRApefCr61/MPKCMYvoS9ntAgXBXC+JbT0mGkdEj7PlR46PqC
 5OZOuP6/Y3Enr7MSO94YHSWtGeDSEKfMLocET4xCrm5/fkcau4tCICm5kWw4pLaXgbEEFeGs9dm
 dIwmFLTc0932QmMP8xpjOn+D/TLWzcB27KkvIxIHWG+Vrk+SoWRkTwxHv1bEUXiKxhXLVKW0ro/
 zVbvAo9MAdrXFvffV7Cfa4/HtmZt9wxFBLNvebhWyPpMN1Xm3qjO1mlgFFglWxkAyTn4TvRHiZn
 qe31knZOnXB8y2yARUZBYm3OBcA6Q21w5Qiczmj2o0Q==
X-Received: by 2002:a17:906:d552:b0:c40:9839:c892 with SMTP id
 a640c23a62f3a-c419e2326demr628363866b.19.1792421811095; Mon, 19 Oct 2026
 07:56:51 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261013175753.37344-1-kolomiiec@gmail.com>
 <sashiko-outbox-172448@kernel.org>
In-Reply-To: <sashiko-outbox-172448@kernel.org>
From: =?UTF-8?B?0J4g0Jo=?= <kolomiiec@gmail.com>
Date: Mon, 19 Oct 2026 17:56:14 +0300
X-Gm-Features: AclHuK8tloVCSjQ2U5-UDqRf3TB8_YW4TWwVk5crnPLxYw9n6ka3_9zIXu7hdC8
Message-ID: <CA+e2gLs8Q3Y-ow=PdYqhQyq0Gax9rp8PktA7fgzannG8OU8XFA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: retry UVD v1 init on failure after resume
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,
You are right, and thank you for the precise catch. On my hardware the
failure mode is different =E2=80=94 clock setup has never failed across 42+
suspend/resume cycles; what fails is the ring test =E2=80=94 so the unguard=
ed
uvd_v1_0_stop() never fired in practice. But that is luck, not design:
if radeon_set_uvd_clocks() ever fails, the retry loop would issue MMIO
writes to an unclocked UVD block, with exactly the bus-abort/hang risk
you describe. The guard is cheap and obviously correct: v2 keeps the
clock-setup result in a separate variable and calls uvd_v1_0_stop() only
when clocks were actually raised. I have sent [PATCH v2] with this fix
to dri-devel. Thanks again for the review.

Regards
Oleg


=D1=87=D1=82, 15 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11:1=
1 <sashiko-bot@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:

>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] drm/radeon: system hang due to unclocked UVD register access on =
clock setup failure
> --
>
> commit 9840a4a45eacb2033c0f3f3ceb29f75910196145
> Author: ukrainer8 <kolomiiec@gmail.com>
> Subject: drm/radeon: retry UVD v1 init on failure after resume
>
> This commit introduces a retry loop for UVD v1 initialization during resu=
me,
> as the ring test can sometimes fail due to racing with hardware. On failu=
re,
> it stops UVD, waits 20ms, and retries the initialization steps up to 3 ti=
mes.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1867
> Link: https://bugs.launchpad.net/bugs/1865130
>
> > --- a/drivers/gpu/drm/radeon/uvd_v1_0.c
> > +++ b/drivers/gpu/drm/radeon/uvd_v1_0.c
> > @@ -158,24 +158,45 @@ int uvd_v1_0_init(struct radeon_device *rdev)
> >  {
> >       struct radeon_ring *ring =3D &rdev->ring[R600_RING_TYPE_UVD_INDEX=
];
> >       uint32_t tmp;
> > -     int r;
> > +     int r, retry;
> > +
> > +     /* after resume the first ring test can race with the hardware; r=
etry */
> > +     for (retry =3D 0; retry < 3; retry++) {
> > +             /* raise clocks while booting up the VCPU */
> > +             if (rdev->family < CHIP_RV740)
> > +                     r =3D radeon_set_uvd_clocks(rdev, 10000, 10000);
> > +             else
> > +                     r =3D radeon_set_uvd_clocks(rdev, 53300, 40000);
> > +             if (r)
> > +                     drm_warn(&rdev->ddev, "radeon: raising UVD clocks=
 failed (%d), attempt %d\n",
> > +                              r, retry + 1);
>
> [ ... ]
>
> > +             if (!r)
> > +                     break;
> >
> > -     ring->ready =3D true;
> > -     r =3D radeon_ring_test(rdev, R600_RING_TYPE_UVD_INDEX, ring);
> > -     if (r) {
> > -             ring->ready =3D false;
> > -             goto done;
> > +             uvd_v1_0_stop(rdev);
>                 ^^^^^^^^^^^^^^^^^^^
> [Severity: High]
> Is it safe to call uvd_v1_0_stop() when radeon_set_uvd_clocks() fails?
>
> If clock setup fails, r is non-zero, and the loop bypasses the break
> condition to unconditionally call uvd_v1_0_stop().
>
> This function performs MMIO writes to UVD registers like UVD_RBC_RB_CNTL:
>
> drivers/gpu/drm/radeon/uvd_v1_0.c:uvd_v1_0_stop() {
>         /* force RBC into idle state */
>         WREG32(UVD_RBC_RB_CNTL, 0x11010101);
>     ...
> }
>
> Accessing these registers when the UVD IP block is unclocked can cause a =
PCI
> bus master abort and lead to a hard system hang. Should there be a check =
to
> ensure clocks are successfully raised before attempting to stop the hardw=
are?
>
> > +             if (retry < 2)
> > +                     mdelay(20);
> >       }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013175753.37=
344-1-kolomiiec@gmail.com?part=3D1
