Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482F2C982CC
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 21:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7DF510E0DB;
	Sat, 19 Sep 2026 21:26:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BuUX1aGn";
	dkim-atps=neutral
Received: from mail-qk2-f35.google.com (mail-qk2-f35.google.com
 [74.125.230.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2750E10E0DB
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 21:26:27 +0000 (UTC)
Received: by mail-qk2-f35.google.com with SMTP id
 af79cd13be357-93910cadeb3so143477085a.0
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 14:26:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789853186; cv=none;
 d=google.com; s=arc-20260327;
 b=EE3PONv8d20lhgugH2Orz4DmNeKZzu6p9JodQjwUx693c8lUVkMMTIBK2fMm36iw3l
 gQbSStlZOh3aeQc7HyUYtHi8IEC5zdDDTpGLAARSMUy3GLHa9E66SeSquiXCQWxjhTgh
 37rgPjdW4Tx/trW/u+s94pXRj/pDhkZti25cD086k7mYtgBLyifYKvFYL4GG5e6B639y
 N/qjU9C3irfXnxzr45NTjsw50Mzpisd+4O89AJeNw43GLbreXsOrhxkQo4o8OnKD+v+k
 NfxPHl5PgULvSKLSNVR4VSKYeYXD71S1tMxY9T4POso/+HeJL4PZgprl6M6ka+7hCG8R
 5PIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=W82cP2eM7LOKZLRzXX4bEVLA8ivt1Vz2Z6PZnWSs15Q=;
 fh=oZUnYBkXeBsTtRrBckLF9uhtNf7G69A2KKp14z48E5I=;
 b=poEWxMYadDUz8xwa1u33DEhrvwPUn6YiXE4ffE89ceiJEXSVCz9zfE8vi88K5fX0uK
 vuJHOnNgGopFmStbOxyOlA9I89CHCMrc3iasLP2/yenytn0Nze7KWPwA190uo6mF3dhD
 tA2+Aozaja67cIQnjtONcSz9lollJMx4dGeV7ENCISLgfiqhpCLvrsStMQsWPJB472IE
 QtNQPREBCAtG+1/JM1F/g/IaWO+QFuCKNfRnIq3vMbVVUoKhQm51YUNPsQd916PV5ZTf
 ZWTk7FoFATXpOavFshGXcr82gxjc79qagEtEXTdUYJWvw5tGBiFiztRG2q1IStDHSABT
 doNA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789853186; x=1790457986; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=W82cP2eM7LOKZLRzXX4bEVLA8ivt1Vz2Z6PZnWSs15Q=;
 b=BuUX1aGn7Z/F7WiG/JJwQD7+MAL2vFxNkxAMw7Y9C/gSbvvkEvZ28ACmzXvcxb70FM
 mVCFiiPqGB1/TJJnn0npJIvQYMmnlIF7Cl7mnOqv6wIfqsjCG+hDplcghni4aQ3ORz8a
 2ENQwMLEqJmh898fF8VN5kpTqUzmlutVZfmeZDF/VfQAn2IpyFEt92C3VvEcatjhIAM0
 m9co7nE5aOk+dg+zy1FoTsBaVurSCd0EjvYyD9IFtgfSsgoAfulaSX2X+0beGi1Wen6Q
 NragD7rcuNo076zjnFnJ5VNmdJaYfW6Fe00hfX6q3OM7CYP+XSF+C6zeBwSwPgW8H5dy
 rV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789853186; x=1790457986;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=W82cP2eM7LOKZLRzXX4bEVLA8ivt1Vz2Z6PZnWSs15Q=;
 b=VumfOjZe9YSnGTPc7/I6ma51Bd4lduPPHd4ED2H8BqROt7CNuX7esGLXkT4Hj2ZLQH
 Cb4hikew95LKzu1tVx4nqp5RIT9/WKxTbFnFs5GlYAJl5iihTAmJHGe6MMDRoGb6FCZ/
 XhbKiuDQS09MO2NrnIQhwbP0kI7lZ7RhJfqBi1tPE5Sx6jBxJv+5IoUWroOvjRMwrAff
 Ub+SI8UAGRPONH18BzvmlVP0P7Si8Jy/M+qNYwRMX0UBL/wCapRYUhbMg6RVO4tqMdzA
 SaxtY2LoLOEN9xOXIkEk/fudg9u4xf5MqfQjfC/12LQzlFETcsU9Y2uaB2s+ctnA/neO
 JjLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5jO1tOicDPTuFgw3I43TV90EyXcxEqzSzk/hTgwnlr47BDXG2jCSjBYMfFijm+WIrm3hq6bBum7M=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lW70MDIpY1nvMJYcn5Fn3kNEjnEG9W4chxcQcTuXJug+JwRrel
 iFptUKDca8UuJBq3Kqdu5RQdEAadB+SMTUZ9TUviD1LXFyRwt+OaH1DPbcFcC3yyJ2meMWle5So
 21YXpRGuuLLK3Dn7+YrqEVsWt46WrpBE=
X-Gm-Gg: AYBFou1KTY37ldObW4og0251OB7Z9iDqlnH+rniWcnQQL/h4UQHRSysjp9vxbkY7BRG
 9Ofg7mdc+mcgZC39e5x8WUf9P5eX4Ujnl9z5XZEY65uslTlG+QAZwjp8wpLUKZS0C/NVEBVgwBa
 JodlvYHTUlDeplVSexZrR4EbounB1ybZhV1jJzmkcvVlEnnnhB5+93fFHIxY7KzdAb5MLKVblx1
 xve8Q5yRik1gm6eViBbJY8aNscdWqz7GvhMOdTa1b89yF0VnMaOIG3nU+niRKDXVgc34Jm6tDTC
 LKyYD8xqxjVhhWY6MHnP9jtA48Qrdf7gDB/qTEbsOsLzvvaSn0KdS0MKJmTyv2q7RD6LwlIqzRA
 VQ3futzYhA0Qlt4wdtcakTZJAs39nibjqKf2Z/GNApwGJtxmmK8U=
X-Received: by 2002:a05:620a:1d03:b0:939:6df7:73f0 with SMTP id
 af79cd13be357-93bf5761513mr301041185a.50.1789853185944; Sat, 19 Sep 2026
 14:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
 <20260909-mmrebase-v1-15-8dd5d4225d2e@nvidia.com>
 <CAPM=9tweFRWWjCrkBKvR03BaRVs=N+-qw2ju0g-dgMj+S7Q=ZA@mail.gmail.com>
 <DLJDV72PBGVA.1M0RZ780ZPJR0@nvidia.com>
 <165ab493-9de9-43bb-a53b-3fa82f8013cf@nvidia.com>
In-Reply-To: <165ab493-9de9-43bb-a53b-3fa82f8013cf@nvidia.com>
From: Dave Airlie <airlied@gmail.com>
Date: Sun, 20 Sep 2026 07:26:13 +1000
X-Gm-Features: AcwNN1UIoSlXyTA_I5dOxTH1mKYz8_NXz8Pq7spnjuOWiDNpvrhOSQYr0h3NdB0
Message-ID: <CAPM=9tzFaYp6=3nJ3yxEhjaHzUOnyQT0eV884eKR7ma2sHp73w@mail.gmail.com>
Subject: Re: [PATCH 15/16] gpu: nova-core: mm: Add BAR1 user interface
To: John Hubbard <jhubbard@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Eliot Courtney <ecourtney@nvidia.com>, 
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Joel Fernandes <joelagnelf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
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

On Sun, 20 Sept 2026 at 06:13, John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 9/19/26 8:03 AM, Alexandre Courbot wrote:
> > On Fri Sep 18, 2026 at 12:38 PM JST, Dave Airlie wrote:
> >> On Wed, 9 Sept 2026 at 14:25, Eliot Courtney <ecourtney@nvidia.com> wrote:
> >>>
> >>> From: Joel Fernandes <joelagnelf@nvidia.com>
> >>>
> >>> Add the BAR1 user interface for CPU access to GPU virtual memory through
> >>> the BAR1 aperture.
> >>>
> >>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> >>> [ecourtney: map BAR1 in NovaCore, borrow it in Gpu and BarUser, no Devres]
> >>> [ecourtney: update for the VramAddress raw API and gsp_resources chipset]
> >>> [ecourtney: drop the owned GpuMm, pass it mutably through map and release]
> >>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> >>> ---
> >>
> >> BAR 1 and 2 need to be optionally detected and used. At least on SPARK
> >> there is only BAR0.
> >>
> >> I've been playing with John's branch on spark and had to rework this
> >> code to make BAR 1 optional.
> >
> > Thanks Dave - indeed we also hit an issue on a device where the FB
> > console was enabled (?), which preventing BAR1 from being used.
> >
>
> That's different: another device driver was using the GPU. People
> should Kconfig their system to avoid having two device drivers
> trying to claim the same hardware.

At some point nova-core needs to call the remove_conflicting interface
to make sure we kick off the overlapping drivers properly.

>
> Once Nova get a bit further along, it will be a non-issue too,
> because Nova can drive either an fbdev, or whatever the modern
> alternative to that is.
>
>
> > I know Eliot has a bunch of follow-ups in the pipe, Eliot can we make
> > sure to dynamically detect and enable BAR1?

Also I'm asking for this now as it it might be easier to make that
sort of design decision earlier, rather than trying to revisit it
later.

Dave.
