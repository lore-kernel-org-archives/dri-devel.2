Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564371099B28
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 17:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C209810EA6F;
	Fri, 20 Mar 2026 17:48:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aR8GJdfQ";
	dkim-atps=neutral
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E91710EBAA
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 17:48:31 +0000 (UTC)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-64aedd812baso2449884d50.3
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 10:48:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774028910; cv=none;
 d=google.com; s=arc-20240605;
 b=X3JZuySg7xOvxJYGzNFJjP7uNI6HeHhS6V65mbgrGhAPpt86C4lJek7yVvOHlUOZRJ
 +e/oyp1FGn96BKMc6seuU3t6VTmDoiRoRo764YkHeKZ6pttAe6mXJgeyf+8EVGZas8PW
 i9ApMCZoNX8rbuYExNn2V0yMbx65Xvab266e6MJNR7zNeg/PyvQEyDpp6B+p4pKRKYMt
 A4rVLhdR/JTp9Wpd1bi2D84PtKZNjHeocYAxVd5TBSTW084XvYcCW9ViD2rsPwRst6qH
 /BtVS3X62bTofE2HNYnrcDMHLKIDO3Uj3m42BP9ecCwDpBQgSBWTnigJN8UlMFwvOTyK
 r/LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+0Ef+wM9iBGnlAV74+t5ecaaFq7fGhBfxH9EipXPT+0=;
 fh=cQUX9cp/RDKyOLsUPYjrbaua/Jzn/466oScQhvOJXpo=;
 b=I4km1oXNWDHKdGD0xIU/3CvM+B4ksFLJDbD5U7ZMnFjQxegcsiTWqjCZMMzo6m4fnj
 ffxYe16OGOL+5YpnA3O4OGet1UVNvcP8oLMSp9tmt62yiFOalMfOZU4/I86IInDNQASw
 1P9Wq7sCbf6fizDecoq1+BdJ39fkzEC+u+LmrPkjDX8JDH/6HvOSAZ9uG+q1ybF5Qjao
 xGM971NLtV0XBJDhJfLFzMgZ9W2O4+ZFkBt9/PZL2szMYHzE14OGPKIifoBHymot+Arw
 mJiPm7GGXBw0Q0f601Hg0DQWQ2b6GxQZWm0EgiIjfCpM5RKbMkrc0XtGlZJf4714t8Qd
 EOIg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774028910; x=1774633710; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+0Ef+wM9iBGnlAV74+t5ecaaFq7fGhBfxH9EipXPT+0=;
 b=aR8GJdfQHp5DtS0OsfAPafh10gpfyew81AJsWoYQGjH4kunZyKCK1m0sENjx4nk9uo
 p9iZHxhf6MwCUDgvpUQFs3zMccQKmltGaUJZM+AK3hj2LMfOe6d0HQ5DBZ9PRW73DJiS
 /3yMDFdjMppgRyDcQ8CO2c1u3aItcbpNlCdgjOJ25ImmYfjTfxTmj4r24Ffi+9mDZDp4
 LjdoBN7HznsJMMb0h1ETx5LvQvgNbsw/Cfn057OB1RRRwamoIc3X1utcVcPi318wAwBz
 UwItBrlHrNhlbQ5PPsCjdDAt+2fZ3bnj2PqakylVdkzUe3G2bPfFP5noG/PVyqg9T0V0
 EwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774028910; x=1774633710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+0Ef+wM9iBGnlAV74+t5ecaaFq7fGhBfxH9EipXPT+0=;
 b=hvcLTUHfm0Ad0eA1AILnT6CrZxhY8+5bN4iz4pFDAGecTEBjskUAX9BJxG1ChJQTTm
 1wl61oSG9fgqxmVnLHTCgtbuSUb9qbRKtJtxfhi2kxMxB1fFyghYds96oss/kEwAWr2u
 AJ294z+/LBQd0xLYAhqgmeKOLpFUYN+U/lj54ddA0ztqaBXr3Gnd9hTbmpY9kWfG70Qr
 7Q+4HefryfbaTLLviLLXoEppyM2u2Z72AaR/QYH59N53B2dcQI6B/pgx8oKkZtYkY4P0
 PSRv6RsgAEg9FtX89zj/JuAmqZo7rN6ev4hCjtvmuqR1AgAvCZvAWoQht3Ml6Is1SBfe
 DhqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhuynRqGedOe005g2Bm9aNT99xX/PFqPLQ13qq6umU5DefWCIxOPOXIwQXcnWUkgSDViXGmFQzpqY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzElEcmSb5DVtxrUmOcS6NC6+T3SvKNNjM1vGX+qBE2vpD3YIta
 TWwKmEw2xq+ZbK0yxnMHFEVOzKZ9bSJUcq973GlES1PebcRRoa3hqP1tymj8Bz7PdWD5gOCBXEY
 3QLH2jcNWIL//4NKCwryePSN22GbPMf4=
X-Gm-Gg: ATEYQzz6MlFFDnHc+UxeRcfv6RNZBWsn62raLWyS+1r6UyDC0K5MWEX3/fQD1+HpHIm
 C8oincVB6kgeyv+VwgHB4nU+q+4Pc1evsWWWzFFRDiRSn0rk1cKvQ4DAQ2qz95tL5w14F1iD8bV
 o7o9/t8ZiBk9tDmFZEW8Qm+bsCH+GbHTRmOVwsowl3ys6efzxBu2WUs7Y/wnm6XKyntHMipPhlE
 jB054Xh+8nMtlDdQYQR13CqHYQxOW1Z7rLTzEx/w+hgpo803Q9i9WvpMBZx+sWmxN4HraLAdepd
 relp
X-Received: by 2002:a53:ec8b:0:b0:64c:b12f:f02f with SMTP id
 956f58d0204a3-64eaa85b7bemr2817354d50.76.1774028910527; Fri, 20 Mar 2026
 10:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-23-jim.cromie@gmail.com>
 <177402491440.6181.10370884123666440440.b4-review@b4>
In-Reply-To: <177402491440.6181.10370884123666440440.b4-review@b4>
From: jim.cromie@gmail.com
Date: Fri, 20 Mar 2026 11:48:04 -0600
X-Gm-Features: AaiRm53q7raCfT2VIY8VRpmfB57j5ltDj3LlcQ8Lkb1cOQPVeem0bJxBrAwha0Y
Message-ID: <CAJfuBxzAuWYMs32FUcz7TAHzQxr3Pmo8xeZ=-c4BpVG-zpAMQw@mail.gmail.com>
Subject: Re: [PATCH v11 22/65] dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com, 
 gregkh@linuxfoundation.org, mripard@kernel.org, tzimmermann@suse.de, 
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com, 
 ville.syrjala@linux.intel.com, christian.koenig@amd.com, 
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com, 
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
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

On Fri, Mar 20, 2026 at 10:42=E2=80=AFAM Louis Chauvet
<louis.chauvet@bootlin.com> wrote:
>
> On Fri, 13 Mar 2026 07:19:47 -0600, Jim Cromie <jim.cromie@gmail.com> wro=
te:
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debu=
g.h
> > index 80160028461a..74ed18a038bd 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> > @@ -81,10 +84,18 @@ struct _ddebug_class_map {
> >       enum ddebug_class_map_type map_type;
> >  };
> >
> > +struct _ddebug_class_user {
> > +     char *mod_name;
> > +     struct _ddebug_class_map *map;
> > +     const int offset;       /* user offset to re-number the used map =
*/
> > +};
>
> Is it usefull at this point?
>
> > @@ -137,6 +223,25 @@ struct _ddebug_class_param {
> > [ ... skip 14 lines ... ]
> > +     extern struct _ddebug_class_map _var;                           \
> > +     static struct _ddebug_class_user __aligned(8) __used            \
> > +     __section("__dyndbg_class_users") _uname =3D {                   =
 \
> > +             .mod_name =3D KBUILD_MODNAME,                            =
 \
> > +             .map =3D &(_var),                                        =
 \
> > +             .offset =3D _offset                                      =
 \
>
> I think this offset is useless at this point, or did I miss something?

It is unused yet, it gets used later (patch ~31) in _USE_
to deconflict class-ids when its needed.

I squashed it in here to reduce churn later, and because it is closely
related in function to the offset in class_maps, so I thought it would be
easier to explain in context.

>
> >
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index e8ffc2b5b330..66f4bfe39e89 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -1190,6 +1292,22 @@ static void ddebug_attach_module_classes(struct =
ddebug_table *dt, struct _ddebug
> > [ ... skip 13 lines ... ]
> > +             return -EINVAL;
> > +     }
> > +     *reserved_ids |=3D range;
> > +     return 0;
> > +}
> > +
>
> Can you introduce this function when it is used?
>

not sure I follow,
the ddebug_attach_module_classes is from v1 (committed code),
its basically going away in v2 (candidate, at rev11 now)

> --
> Louis Chauvet <louis.chauvet@bootlin.com>
