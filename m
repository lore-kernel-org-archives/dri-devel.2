Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91283C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 19:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5C5810F11C;
	Wed, 15 Jul 2026 19:13:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U6ip6KVW";
	dkim-atps=neutral
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com
 [209.85.217.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8531410F11C
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 19:13:49 +0000 (UTC)
Received: by mail-vs1-f50.google.com with SMTP id
 ada2fe7eead31-74019ed06aeso4504033137.3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 12:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784142828; x=1784747628;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lquTBM9em4PBZzG4uURb4zgz590xHyH1vRdFq1gXwQU=;
 b=U6ip6KVWXHQbc413fi23UNnOKTiQQkC100SvFOcK/hKFCbZXW1pieLAcyzz4DriG10
 GgasxM07BwsAoZ4x6yLzHlPL89ss0eYqDBWFfseF+z9O71Yhq5RTkTTdR2DAox0Nvjpt
 Q05JmD9V3P7sb6qy4E/WXHWau/VrJL5XRZ3eE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784142828; x=1784747628;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lquTBM9em4PBZzG4uURb4zgz590xHyH1vRdFq1gXwQU=;
 b=hpePrKeuz+qP9bu8ffkDlqzwVCQ71ujp3rEPRmZ4OtTUsyTAKU4inT70Zc7d/6QVxq
 hZ6sEW8l8H9RviPHmYKYHYJAdW9jyXHtiZMkib/4BVH0IwBWAISIcxQ0jMd6mE8Ivkvt
 dtq1afh//coD8Yg/JQzT7bfuKVkbjgcWB82m8HWIRh12SBGU0xylOIcC/T3bH86wcIlx
 /6lF3DQq5+xhploPaedUqFGixhuEjlSuEXTVMWYdXOCLF8RGO5Po8Zsh1Iw1imF5vtGk
 TQ1agTV0Ml6VPrL05dKkzGLvckFIhgS6WXT4OBG6hnt81A35VGnT+U60EYRNpoSe4m/O
 0wJQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqDr0vTLFaMqoTvgxCVk//gDfokvNpsXmH4375ZbOGhNweYvrM4a5kjcQWF3MBF82hCoDKI4vB4Yfo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyPdmWPzslWpC5cBCNPzd4MgVK9ai/6L+OPKx5URzd5aqk52Oom
 nkL8BvnwUh9CYJ7I+yTyQuvIdX/bpbAhqQrGkTZlYxi6Q58y2h60qs9+mH1QF1a9ym5KtPc2ZxB
 QVl0=
X-Gm-Gg: AfdE7ckGZVw+7+lhi2PmCA+yDVqwsjrWDnurVqP4hjrRwo8lddkB7tiKa0G30b8241B
 7Ev29GqelLfQlluHaxGD8utstfhVbL6Zx6q35/evaOsheQLLMwjaxZOC3RVWntpj7mSoK/H7YFv
 pvsOGMOBQgYM8rFBbMRLhw+dJH5sh/Co2JMoK4n0Yke8C7u1AufjLrWQLIPpaG7Y1g7Me+Jcgps
 QUcTW1py1/jdHzvN1t/S3xfAYweCb+vesCttxU2zSpQAtTH1H5sOtB1xWoko0NeCjo1mjaQLTgm
 mK2qWzlyaF4kaKqDhpUp0T1Mhe6GusxsAmd9wpJxmery8rUt+MlCjjPMU6tFMlXwt/7Ffsh9Waj
 04cb45qiCn0rgC1ztnVsT38ca+pp5kfEOlC8yXkm7WGGBvQAgezcBOWGDKolG/Wld2q9vcBgFRv
 XcfX5beI277i0EXi1E/T9vuT/Kc18SqzJH/+mckj1doqtcmAl0g7E=
X-Received: by 2002:a05:6102:4425:b0:738:2a8c:736b with SMTP id
 ada2fe7eead31-7459a045858mr2636570137.20.1784142828195; 
 Wed, 15 Jul 2026 12:13:48 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com.
 [209.85.217.43]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-744d6a90d0csm12923656137.4.2026.07.15.12.13.46
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 12:13:46 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id
 ada2fe7eead31-725cf9a923aso4722578137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 12:13:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Roa8B7kCzJkM2IMEShd6gCJirlBDfhTYEZvT2JcK1nKr6qVq1wwPqK8TMSNGkT4b9krM8Bn1IqXxIE=@lists.freedesktop.org
X-Received: by 2002:a05:6102:50a1:b0:740:4fd:1c40 with SMTP id
 ada2fe7eead31-7459a0d794dmr2852605137.25.1784142824330; Wed, 15 Jul 2026
 12:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260701064440.1541418-1-maoyixie.tju@gmail.com>
 <CAD=FV=UQwqoUyzWLBEYgXErwtAy8MRVX97yj1_nfiWptg0rCrg@mail.gmail.com>
In-Reply-To: <CAD=FV=UQwqoUyzWLBEYgXErwtAy8MRVX97yj1_nfiWptg0rCrg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 15 Jul 2026 12:13:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VgvjtMXNdG9E-tzmv8C4hp8uoGFrYqZEfot3J6rgWZDw@mail.gmail.com>
X-Gm-Features: AUfX_mw411R4SnolYgbqmhc2SYASeIM-xHu0nH1m9eWdVG9QlAdP7VcXmqTjTKs
Message-ID: <CAD=FV=VgvjtMXNdG9E-tzmv8C4hp8uoGFrYqZEfot3J6rgWZDw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: tc358767: clamp the reported AUX read size to
 the request
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Kaixuan Li <kaixuan.li@ntu.edu.sg>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

Hi,

On Thu, Jul 9, 2026 at 3:42=E2=80=AFPM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Tue, Jun 30, 2026 at 11:44=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.co=
m> wrote:
> >
> > tc_aux_transfer() clamps an AUX read to the payload limit:
> >
> >         size_t size =3D min_t(size_t, DP_AUX_MAX_PAYLOAD_BYTES - 1, msg=
->size);
> >
> > After the transfer it replaces size with the byte count the controller
> > reports in AUX_BYTES:
> >
> >         if (size)
> >                 size =3D FIELD_GET(AUX_BYTES, auxstatus);
> >
> > AUX_BYTES is GENMASK(15, 8), so it can be up to 255. Nothing clamps it
> > back to the request. tc_aux_read_data() reads that many bytes into the
> > 16-byte auxrdata stack buffer, then copies them into the caller buffer.=
 A
> > reported count of 255 makes the read run to 256 bytes and overruns both=
.
> >
> > The controller should never report more than it was asked to transfer, =
so
> > this is defense in depth rather than a live hole. The reported count is
> > only lightly trusted, and the check is cheap. Clamp it back to the requ=
est,
> > the same way ti-sn65dsi86 does in commit aca58eac52b8 ("drm/bridge:
> > ti-sn65dsi86: Never store more than msg->size bytes in AUX xfer").
> >
> > Fixes: 12dfe7c4d9c5 ("drm/bridge: tc358767: Use reported AUX transfer s=
ize")
> > Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> > Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> > Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> > ---
> >  drivers/gpu/drm/bridge/tc358767.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge=
/tc358767.c
> > index 4097fef4b8..26ba5a6c1b 100644
> > --- a/drivers/gpu/drm/bridge/tc358767.c
> > +++ b/drivers/gpu/drm/bridge/tc358767.c
> > @@ -527,7 +527,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *a=
ux,
> >          * address-only transfer
> >          */
> >         if (size)
> > -               size =3D FIELD_GET(AUX_BYTES, auxstatus);
> > +               size =3D min_t(size_t, size, FIELD_GET(AUX_BYTES, auxst=
atus));
>
> Being super nitty: we don't technically need the "if (size)" above
> anymore since it will be handled by the "min". Then again, if we
> remove it then we also ahve to rework the comment about the "if"
> test... :-P
>
> ...so I'm going to say this is fine the way it is.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> I'll try to land next week unless someone else objects. Another
> committer is free to land before that if they feel like it.

Even though this is a "Fix", it's a defense-in-depth fix and not
urgent IMO. I'm going to land it in -next instead of -fixes since bake
time is more important than urgency.

Pushed to drm-misc-next:

[1/1] drm/bridge: tc358767: clamp the reported AUX read size to the request
      commit: ec6444a00c49e6c2b5e9a507272a28126677f9ee
