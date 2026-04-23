Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C171CF99356
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 08:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D2A210EFD8;
	Thu, 23 Apr 2026 08:51:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MvuARwPN";
	dkim-atps=neutral
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com
 [209.85.161.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10E4E10E0C3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 00:55:11 +0000 (UTC)
Received: by mail-oo1-f42.google.com with SMTP id
 006d021491bc7-679b072ed3aso2990935eaf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 17:55:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776905710; cv=none;
 d=google.com; s=arc-20240605;
 b=TpLp++Ub1WGzxP9CAS1ojIfeofMpFws+Ia1Trt0Ignlvig2ZzaVu3r3EdHdh+47HI3
 mTQu+1OChL8uvm2B2u4P+kCqWIxErXvOS6+n98W+/pOc4XwwxXHokj0+uAIThUNw1dHv
 U7mNKC/dibhNPsEa2dIgeV09fvwlP+eZLb09a2cYda+omu5nck/yUQNYmzk0FSPFMy0m
 z7TwgTZWLeofaFJltm3m6dypLzj8ler+qwtb8KCAscKYBQ2iG8KFICZ9pBMzVVZixsXc
 DHSpZC30bY1pHsuyil33VogWDFVvTjht++3zOgkOUFz2MGs63iNqtPKs95ae51p7Ls+R
 Qh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+UtLEa2foHKEHFU/SLXwh05Wz0Pck1xJ13q7G3dvIOM=;
 fh=R/GUfXL5mjkSSLoMWaZj7LJsMywp8s8mguDeTrG1nqY=;
 b=icXRFHAU4mo8vi56wjHLOWWpSJlW7GXK9wlCBzFOosfU332CG2jD6vOPNCiTnYINKE
 GxY1/clCetsfBYoWmYi0J8xRtU6sTiuM2MzwgMd+RS9yUMLjlLM/lENMvRxCEUyeXOZV
 c6yIO9j1aP4in/kXgBVmuzTwWSgb/fGk0JK3kpLhQwYKx84MFw/lWGIeHqNO4XCAhPei
 u1EayG3NTftXSjPE4FbpWwtA9Uty77S1yN6xyB0O8+AjIMrkwOA7qGy7qGXhjprC9xVF
 MLVUCQGzY73zvqmWAfSnYWN/EY7ZGu4lubH2aWC2W9bvzgVBqlxavLpLGMQdRJhwoshp
 hbRw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776905710; x=1777510510; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+UtLEa2foHKEHFU/SLXwh05Wz0Pck1xJ13q7G3dvIOM=;
 b=MvuARwPNSg241Z7FE4ajhPOyTpWC01zap8ltywiRD8sV82kAiRuV7UjLdR1j58G9ka
 VWf2khnYtNUPLFS97nuIRA3nbDRoSWObCvMIKUQIGFfInxAuF5LVsPpty2NLuEhiU9vB
 8wTN55GZeb+om8o7hUMoMSn2G2FWAgRac25FPj4152x/+iSBhvvKc2iJJur7eR5qfKTl
 /l8U34ISFOkk2wgFm4+aeIV4IEVKnOo83uRIvFwRKYSigJGOQDmI35Z/ujLLYwP0yG7A
 DYj7fGDNt4scbmfI/BIJyIrgGzemF6BJvtqY6NAqSK5Km2rLakWDiwBa9E20hUuWbf3v
 Qrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776905710; x=1777510510;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+UtLEa2foHKEHFU/SLXwh05Wz0Pck1xJ13q7G3dvIOM=;
 b=K3b6qbHg3y8taeG04NOk1yq5QqpFed4SvJ3Lotr4hyVM7uejdiraKaZytgOuoIr/S8
 f3gkLT13PHNi+is7xv8H1RYjvZOJ1RkjYa0KfnFWYfPm7xbwJFN3DMZq/szvEcYsa4rn
 tHNktRK5l0b8Dk3b0XphdEwfjkhK1Q5Meo4eSN6j8kqAd2YzpM7r4ONASRw/kfNYZBvf
 2WbiUTECj9zFt4Kn7Yi5TWt41nObXErFjDfQ0iMuzBLVXz0Xs55O9oDz8ZIbVU8LwY9w
 g036ZSAI/qHcqXHPPyO4RB+VOGxNiZ/N6S7ssPAbaxfq+NmbhwAuOh8slGSRM/IVSxlL
 uPyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9uwvfzWAe2mluopc5KrTjzBY2amH8o5DlF6287MRaLQzgYy2FB4SD/VqnTd0jF8Amc4kE7dN9p3GA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyKKwfr0BbX+vtMydoV7PUhUN0KOgspinblCNktaOvbAsE0mcW9
 Z1wR/HokFFrcUs0VIjt8jhI+PeMK2dOE7SLJLLlqxuQbW93xk99aAIO8w4tL6dMxl1Ux0Zze5xr
 i3mdUBZ+8z3k4arMn+HsQrUBquA2pb9w=
X-Gm-Gg: AeBDievHAhVx7RgStVPnYHiBTQHz8AWHJe6DMUO9s/38I7+w95Y3M7DZqQuAGyztZNH
 B5PUzoaNrAzGXc1lBGBcUD37jamDxUdUn1f1oZjL6+G9B6Fp9j+YFJDzgU5igTb4oDYdk5XatFj
 GIlI7P0iZsnSl7hCypLAbkK8RWMesoeyqzBZO++HW0Q7k6ca9+NIdQEWlSfyzkrEqqKn0/ZX1Fm
 2LhUWewZ+TAhhpAkkJKo4Vrg94kE7Wfhz/tOCDrh9lnibJGLHemD4m8ARDNdbnxWnteThxFrGDp
 1asRUXbeStqqnxSdUKusL84f6DZ/
X-Received: by 2002:a05:6820:4284:b0:680:6d72:9389 with SMTP id
 006d021491bc7-69462e62342mr9688484eaf.22.1776905709878; Wed, 22 Apr 2026
 17:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260420023354.1192642-1-syyang@lontium.com>
 <20260420023354.1192642-3-syyang@lontium.com>
 <CAO9ioeXDfTdETEBQknoLehk2aiabCgse109sDgJoPHuQ_07nKQ@mail.gmail.com>
 <CAFQXuNYV+wt2-+8R4m+mtby9TBwcX+vGdqvUvb_6wXkkBg6b=w@mail.gmail.com>
 <ed5u73a5lpsixqvm35zpmooolstjv22ygusorub2owbgz7cwj5@42uq6kl6run7>
 <CAFQXuNZXe0vXAr+dN4LQfC95pvJ5C+Z+b+AuSGZnG4Ui+Nbjww@mail.gmail.com>
 <3gzudodwvibrlzvzb4csbh5ljmhoxvexs4xef2jag5z7ih5nqw@ral5sgh5diso>
In-Reply-To: <3gzudodwvibrlzvzb4csbh5ljmhoxvexs4xef2jag5z7ih5nqw@ral5sgh5diso>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Thu, 23 Apr 2026 08:54:56 +0800
X-Gm-Features: AQROBzCge4WejUVf8NQQWOe-Uex68G1vhWDb55cQCiSB92inlzglDUjGgLlX5Y0
Message-ID: <CAFQXuNa9BWgKsJ6sjesU96FrUczKPcgdy3yaEy4uhd9kCF==4A@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/bridge: Add LT7911EXC edp to mipi bridge driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: syyang@lontium.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org, mripard@kernel.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, xmzhu@lontium.corp-partner.google.com, 
 tzimmermann@suse.de, xbpeng@lontium.com, rlyu@lontium.com, xmzhu@lontium.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 23 Apr 2026 08:51:37 +0000
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

Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=B9=B4=
4=E6=9C=8823=E6=97=A5=E5=91=A8=E5=9B=9B 02:58=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Apr 22, 2026 at 09:06:22AM +0800, =E6=9D=A8=E5=AD=99=E8=BF=90 wro=
te:
> > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=
=B9=B44=E6=9C=8821=E6=97=A5=E5=91=A8=E4=BA=8C 19:15=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > On Tue, Apr 21, 2026 at 11:13:30AM +0800, =E6=9D=A8=E5=AD=99=E8=BF=90=
 wrote:
> > > > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=
=E5=B9=B44=E6=9C=8820=E6=97=A5=E5=91=A8=E4=B8=80 11:57=E5=86=99=E9=81=93=EF=
=BC=9A
> > > > >
> > > > > On Mon, 20 Apr 2026 at 05:34, <syyang@lontium.com> wrote:
> > > > > >
> > > > > > From: Sunyun Yang <syyang@lontium.com>
>
> > > > > > +       int fw_version;
> > > > > > +       u32 fw_crc;
> > > > > > +
> > > > > > +       bool enabled;
> > > > >
> > > > > What for?
> > > > >
> > > > (bool enabled;) is used as a flag in the code to reduce the frequen=
cy
> > > > of power supply switching.
> > >
> > > How does it help to reduce the rate?
> > >
> > The enabled flag is used to track the hardware power state. In
> > lt7911exc_pre_enable(), we check if (lt7911exc->enabled) return; to
> > avoid redundant regulator enabling and reset pulses when the DRM
> > framework calls pre_enable multiple times.
> >
> > Similarly, lt7911exc_post_disable() uses it to prevent multiple
> > power-down sequences. This reduces unnecessary power supply switching
> > and potential side effects.
>
> Is there a code path leading to multiple enable or multiple disable calls=
?
>
Sorry, this is my mistake.
it will be fixed in next version.

Thanks,  Dmitry.

> >
> > However, if you consider this optimization unnecessary, I can remove
> > the flag and the related checks in the next version. Please let me
> > know your preference.
> >
>
> --
> With best wishes
> Dmitry
