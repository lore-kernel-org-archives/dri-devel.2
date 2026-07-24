Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91BCC531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:02:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ACF510F3F0;
	Fri, 24 Jul 2026 15:02:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BVqYR1vS";
	dkim-atps=neutral
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com
 [209.85.221.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F16810F3F0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 15:02:02 +0000 (UTC)
Received: by mail-vk1-f170.google.com with SMTP id
 71dfb90a1353d-5c2c0e261aeso143782e0c.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 08:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784905321; x=1785510121;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RIgmCj66tNw1clv6mHU3c/fxIczuL5eauaO+8CdlWEQ=;
 b=BVqYR1vSFRZg8vaoBRLmEsnT0leV4KjrmBSuGrJe/ivsddQc/FWwmFMoPehZHT4O+7
 4wA8SlQgDv1paSWLkpoedzUe5mgIYpp8dNAFJeXMXR40YLgmnXQYYegKpYICAho8ntFm
 9xegZKrUZNKQ8WQa7ZJ4US3Ghjqucc8owsT/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784905321; x=1785510121;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RIgmCj66tNw1clv6mHU3c/fxIczuL5eauaO+8CdlWEQ=;
 b=ptALW5Ye99Zx0FGtG/yyfq4gKrzrGI2kr2ndVJQyHZomoCxi7zDKlOHqnftMcPgoTe
 Yf3q8BB4ldBjpkgUlGpY+toaF2a+rscraDMdVsslFkFZNt+zKc08WV+m3BU+3hNb5FrF
 NDnaVCKPRO11Gwhj5bSBg0jxBLu9fDxKmKU3OVYREUL50d49G4q5f04CzBou2nUSeaOk
 tyD/x6iBZo2hlNF7Blhe05k/JFTOPdGDBW6eXzHXCdp9dOGEhT2UbBxGGFGjlC/poCGt
 KfaYehCYhnse2LFFGZ3EFFob0N+6kzFFlP7lfplvqDBXYgsbtgQ/s+kkG2hYfbo1s+s6
 F7Bg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpz2JuDMwabkyFJ9FUcja50Jtk1NVVJnDjQ4O6QAUFLGm0qHrOibqd0wFgPryurR0Pj8uZJo/utowA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxW20f2QyNHP6VAgyIBcgYpMZEqUL2J0v84NBxGPiWGX10MKTUo
 qVGSg9VQZN5zaizRNy/Kt656lSPDXWIV6NlEnmI9cbcAg3w7IJrZYi5Txu8ZxCUGdB49Y2/GO3n
 LV+o=
X-Gm-Gg: AR+sD13hVXXkiLm+iZYZ2xbEoG319zDECVlkYvk0Y2D9sxV9SkWVST0Q8ruSSooVXCo
 YmGX27HW/pYuEgpDaCf+mcRMJUFMPD4e44Nh2n0Vc7ThX6ZlvqeLTqZ4hPGZ4i3vXhf2behCSzB
 8EgbKueG0Czr+i3+AB2YH2uQ3fqiONoVQ6ULL9AVSSJJxz6J0PHreVSpGtYr1F5pz9tnjlwsTvu
 24TNrJwaXEOyXcPy9S1VGjuCNWCiGEU+r4XlDDFSqQjY6836s3EQBmh/mvtJS5qOmcVP9vWaJOU
 HffN/6RF2cWqvoY5xdGlgQtf4Dtc2XtmR0UASZMkWsWLQ68+PX4FbjPXxn2IZgaF63PM5CLfAZE
 Z1ikV/1T+uT5+x8mbVKahyzBmBsjvymS2oKy8DUU+Osi+dZKbPxAjuIdFxoNjRjxiCkJLKygcIa
 5Wup7cNCPAwO0ACdxEDbF17iNWK3ns9mruK82ScxWV1ArJphRsSU7T7SQ=
X-Received: by 2002:a05:6122:1811:b0:5bd:a7e6:10bd with SMTP id
 71dfb90a1353d-5c2d9d5e0eamr3534381e0c.0.1784905314951; 
 Fri, 24 Jul 2026 08:01:54 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com.
 [209.85.221.179]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c2c627682dsm9444366e0c.2.2026.07.24.08.01.52
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 08:01:52 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-5c2b798d3a6so113295e0c.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 08:01:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RpjQOmb6N243XptKvTJd5yTmroFUbI4GnP715nh4+GkKN/Vd5q+uePn9OPDHQp9haTXWKI4xP1x/WA=@lists.freedesktop.org
X-Received: by 2002:a05:6122:458b:b0:5bf:b500:c4fa with SMTP id
 71dfb90a1353d-5c2d9fad6d9mr3426249e0c.2.1784905311020; Fri, 24 Jul 2026
 08:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260717143119.1815106-1-johan@kernel.org>
 <20260717143119.1815106-2-johan@kernel.org>
 <CAD=FV=X33HQcz3atmFzor2oLJzxzcRBJsnsSu_ewErduSxy0gQ@mail.gmail.com>
 <al3Sa-l3Hq9fxZJp@hovoldconsulting.com>
In-Reply-To: <al3Sa-l3Hq9fxZJp@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 24 Jul 2026 08:01:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V11GAw211Lz5cuUQ7B5GQQSGvxORPeBAMz7dsCd+2CDg@mail.gmail.com>
X-Gm-Features: AUfX_mz8FsFYort56Yg4BUHp4NJjirUzx8eymnJU0jTrPekxP4TnKisnoQZfF3k
Message-ID: <CAD=FV=V11GAw211Lz5cuUQ7B5GQQSGvxORPeBAMz7dsCd+2CDg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/panel-edp: fix i2c adapter leak on probe
 failure
To: Johan Hovold <johan@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
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

Hi,

On Mon, Jul 20, 2026 at 12:46=E2=80=AFAM Johan Hovold <johan@kernel.org> wr=
ote:
>
> On Fri, Jul 17, 2026 at 10:03:42AM -0700, Doug Anderson wrote:
>
> > > @@ -878,6 +885,11 @@ static int panel_edp_probe(struct device *dev, c=
onst struct panel_desc *desc,
> > >
> > >                 if (!panel->ddc)
> > >                         return -EPROBE_DEFER;
> > > +
> > > +               err =3D devm_add_action_or_reset(dev, panel_edp_put_a=
dapter,
> > > +                                              panel->ddc);
> > > +               if (err)
> > > +                       return err;
> >
> > Yeah, devm makes this so much nicer. Thanks for fixing!
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> > I'll plan to apply this, probably to drm-misc-next next week. Unless
> > someone objects, I won't land it -fixes because it's such a corner
> > case.
>
> Sounds good. Thanks.

Pushed to drm-misc-next:

[1/2] drm/panel-edp: fix i2c adapter leak on probe failure
      commit: e2a9e291275a74e309a21cbb1def6296a72d6aed
