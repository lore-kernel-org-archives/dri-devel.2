Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA73606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tomeuvizoso-net.20260707.gappssmtp.com header.i=@tomeuvizoso-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OHFBKr/l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FE171120B5;
	Thu,  5 Nov 2026 06:59:01 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C09F41120D0
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 06:58:54 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-93e6eb77f0bso165450985a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 22:58:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793861933; cv=none;
 d=google.com; s=arc-20260327;
 b=fS00Bt4AbGP35ubEOmK4it+N8p1N9zsdVilbc+3d5hTkOo0qkMnbBjy29xarkkXJLa
 yiMjk6CwGrJX3EwO2adJKkjx8+3pHvaAedzcz3pH8GIyDdwF71oHQYWxPp0S9DMjFiZr
 n0YMXnmQLq/VFABid7c4AmWkPciiLwuENIbZK19xLl7n3n0RPINFcJ+lkJ00b00j4WG6
 HulHXsfCm0GrAoDW0z9NZYa9j1DfQJkApdPJJbaDIGvLNvxQP3EBGJgto4F3wxigZqJ+
 7VFEOOogZgeBijpu90/EF5khhYMxl+12HmFzd4Palhcv7RykEALLxSdNka0kfz020OOc
 M3Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=F+6/WzYj37FJHzyiT5yPgdRk2s4gHYGoXvrEAh55Hig=;
 fh=V40uY7yeuxC5t0TzquBvEqvXpQTFo8xh8/v5QF3Dp8A=;
 b=J+yDYmwdX66xxQ8UTgnpSsggNaRn4pNzMVQa8+ZaoYre6VtnrzucHryNg+2HdFKmT1
 1yoVccrtfNVwOuUUz1cR/tqaEBPjMBkbMj/Bj/u9l4Cgs75TQKUlHn+pgaQgEQ+SixcH
 oonefstWB/5I04Q3ug5a74jLsrkSiezm3sRADqgahfGcn0kt3lE7Iz5AhX4rN/Ww+CJt
 O8vLaJaq8+8hqAC5iu8r3SjikFht1CllJXii9jCzmvCY4PIzGxyzSX1GmVHGXuhXzLpP
 yY6GSAmvwjLzdZJjs3309Oh3bXBSEWxpv65Z92UX6h0FEkF8p5z/RvTnHSNF3QDLbKzG
 KQBQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20260707.gappssmtp.com; s=20260707; t=1793861933;
 x=1794466733; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F+6/WzYj37FJHzyiT5yPgdRk2s4gHYGoXvrEAh55Hig=;
 b=OHFBKr/lurOtyObHpjbHRPN6fC98uUdFqkRf4ReRYUS4Su3f6MS2eU9g+07T9AFhww
 ImyOfyKnB8W3WEY/1aTbPiFU+oDh+O4uSAn3HJH8rtQcs3f0iMgN7pKOOXBjfMZ6Ly48
 bNdj/QxdcW+gOzAz02A5SHZ3/toiwzG04qq2Dh9M82KpwNf8+0Cf4MItERUxPZnwmqLP
 z5a4tfL0bqDZpZBoLAYopK0L3rpVHpsjLbVPjvV4K2DcKZ2+XFd8OlRGgXe/f99BzgLQ
 ULzoRKWPuQ6UC2K9RNg/ZL9hBtJ6KuGcUQ6Gq1ekFU6lyyZ1iZ8SzPu5JomdXWb0YhoJ
 QeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793861933; x=1794466733;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F+6/WzYj37FJHzyiT5yPgdRk2s4gHYGoXvrEAh55Hig=;
 b=VORZZe9ZyODQdmfW2pq84Rl9ziGu4t+Bi3LA/32myDfDij2IJxVICITXg3EYxWFZWY
 Vim2MT4A/CLDTpBsYUkDFKNET5aZ/00hVzsE+1Hq22fMtDHXsyqD8HF0nO8KzKPnbTS+
 SAVN9T5Z9LglSxKqIyGUduNKYIga+FPOmAvhslhYWJoea6+bdNA6pbi5vAQLOHvs3ocv
 4yFogTMpBiLvukxX2CsSvfRjKZ3+wLVepYyKHLTahaV30f6Lb42wzihL/CKotQY8j4dx
 7cEmiGQyF9H0bXiNaW083O++rL6IbAktuumleU7goBlraft3CywTrp70ly2g1+HTB6hY
 iZvg==
X-Forwarded-Encrypted: i=1;
 AKwUvByEEaXRgj6NTHaQtnT+5fOzCbQ8pElRYlIxuQ529PBdTi3AKfgtGCmADmycQLkfghEu8YpIq2cMG4c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/zr0i1NTdnpPu1YQp0/0A0rqaa5CILfknMMmvh/1vHizLRlD5C
 653L8JIbufu1BAINcz5f4m54hj2mGLqDaAzyTpyXGr2SwmVhzOLFulEoHiT5fnFktOW8cW5Hmb1
 OtGohjLONVX2Qn2L6TpBjKeFVJo5nLPjz1JAI9k9DFA==
X-Gm-Gg: AYBFou14qWjlbRone9k1IsOfj+vEiIbFSKBmHPxzC+DZQvreEijldFCQyvj77+Ck+e2
 QR1iefuzaHW6MmkHkcIGauLpn+kjbKoz/TRNsZMJsiK1u0sS9Ak9oqPDXavB+aYZRpdS+cBhxkH
 OZDRzY/MdGl0/HkXrzFYYkXsvsS7inL+0Nh50gG9DZaBOjoBak2nzP+G3G3tlnNbghjJ407pkSb
 2FDQJhW76sDKy6rqt2lTcesO8cc70XwANkHrRAja0HoUGLzC8zWxwF9Yiv52YeYQyf0LYIKvIpS
 TvW/AJm4zqkoZR/tZPTbUIU5+5nglzR48hziTemCtbcrnstyEoEyWcU2sV5XxaDryBTPgNb0658
 HL99b6HWb4SLMDwnbT3DhaJ/NedVt23ZmZEDXj9xNt7C16oe8OzlVBbKr/OqUebq2Nv4DRMdlN6
 keh2k/jpeSddzIjTTe27k=
X-Received: by 2002:a05:620a:4541:b0:93f:4d4e:ff66 with SMTP id
 af79cd13be357-9442158604emr3201847085a.5.1793861933502; Wed, 04 Nov 2026
 22:58:53 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103155338.1949294-1-sidong.yang@furiosa.ai>
 <CAKbEzns7nqMP0FSf+G9e31nXR-c+vy+Vv-gTyFV5jv46rAgwRw@mail.gmail.com>
In-Reply-To: <CAKbEzns7nqMP0FSf+G9e31nXR-c+vy+Vv-gTyFV5jv46rAgwRw@mail.gmail.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Thu, 5 Nov 2026 07:58:42 +0100
X-Gm-Features: AclHuK_bZHeJEa7e_9FUDx7rW7Uy1RIrUnE2siMSCiWZgpaSPYjC7zLaNmI7dzs
Message-ID: <CAPsqS2TTuYmDfBGgTt-EMJZBUW-jUJxhPVEh0=faDNLW3R9K7w@mail.gmail.com>
Subject: Re: [PATCH v4] accel/rocket: Report NPU usage through fdinfo
To: Gyeyoung Baek <gye976@gmail.com>
Cc: Sidong Yang <sidong.yang@furiosa.ai>, Oded Gabbay <ogabbay@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I agree with Gyeyoung.

With that:

Reviewed-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

Btw, I think we have had a backmerge already.

Thanks,

Tomeu

On Thu, Nov 5, 2026 at 4:22=E2=80=AFAM Gyeyoung Baek <gye976@gmail.com> wro=
te:
>
> Hi Sidong,
>
> On Wed, Nov 4, 2026 at 12:53=E2=80=AFAM Sidong Yang <sidong.yang@furiosa.=
ai> wrote:
> >
> > There is no way to tell how much of the NPU a client uses. Implement th=
e
> > DRM usage stats: account the time each job occupies a core and report
> > it per client as drm-engine-npu, along with drm_show_memory_stats() for
> > the BOs.
> >
> > The cores are identical, so they are reported as a single engine with
> > drm-engine-capacity-npu set to rdev->max_cores, the number of core
> > slots. The time is summed over all cores, with an atomic counter as the
> > cores complete jobs concurrently.
> >
> > Jobs can outlive the file that submitted them, so the counter is
> > refcounted and each job holds a reference. The time covers the whole
> > period a job owns a core, so it also includes handling the completion
> > interrupt and the gaps between the tasks of a multi-task job.
>
> nit: "the time completed jobs occupy a core" would be more accurate than
> "the whole period", as timed-out jobs are not accounted.
>
>
> >  * RK3588
> > +
> > +.. _rocket-usage-stats:
> > +
> > +Rocket DRM client usage stats implementation
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The accel/rocket driver implements the DRM client usage stats specific=
ation as
> > +documented in :ref:`drm-client-usage-stats`.
> > +
> > +The NPU cores are reported as a single engine, npu, with a capacity eq=
ual to the
> > +number of cores. The time is summed over all cores, and covers the who=
le period
> > +a job occupies a core.
>
> Same here
>
> > @@ -139,7 +183,28 @@ static const struct drm_ioctl_desc rocket_drm_driv=
er_ioctls[] =3D {
> >         ROCKET_IOCTL(FINI_BO, fini_bo),
> >  };
> >
> > -DEFINE_DRM_ACCEL_FOPS(rocket_accel_driver_fops);
> > +static void rocket_show_fdinfo(struct drm_printer *p, struct drm_file =
*file)
> > +{
> > +       struct rocket_device *rdev =3D to_rocket_device(file->minor->de=
v);
> > +       struct rocket_file_priv *rocket_priv =3D file->driver_priv;
> > +
> > +       /*
> > +        * This is an estimate: the time is taken around the whole peri=
od a job
> > +        * occupies a core, so it also covers handling the completion i=
nterrupt
> > +        * and, for a job made of several tasks, the gaps between them.
> > +        */
>
> And here.
>
> with these addressed:
>
> Tested on RK3588: no OOB access, and fdinfo reads correctly with several
> apps running concurrently.
>
> Reviewed-by: Gyeyoung Baek <gyeyoung7182@gmail.com>
> Tested-by: Gyeyoung Baek <gyeyoung7182@gmail.com>
>
> --
> Thanks,
> Gyeyoung
