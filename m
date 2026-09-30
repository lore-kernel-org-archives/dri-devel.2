Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2667CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 09:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CE28896E9;
	Wed, 30 Sep 2026 09:02:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W/WV73hA";
	dkim-atps=neutral
Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com
 [74.125.229.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32A48896E9
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 09:02:26 +0000 (UTC)
Received: by mail-dy2-f41.google.com with SMTP id
 5a478bee46e88-34b590a5b5eso1825316eec.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 02:02:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790758945; cv=none;
 d=google.com; s=arc-20260327;
 b=FacW/pk45Ve4+Maa9VSB7IQXzAE9dRyreE4CO7NcWyvOv4XrWKqXmcfZSQUG6NjGAX
 GQ9yqGQfyJ5Vxp5v1W2gWG3DCYubprZgCVDfaFxvmPOvav+ItiEmByTystB2BQj/cStZ
 q/qyfTzD+cDImbSy3eeKye1hbf7/0eiY/sL7px4FvEnILkD9H/GeUbXWxgSPL5131di3
 0lUcrRK6i6iZcCpJUp5t1RhY3+Fz0eMjMbhTq7fuQSJDlfpQRWbf29ereC57f5l5bjK7
 LXOUMxItTdhiJnYczmgtbRqKyEJvideJSs8KMJ58AbCUBbBXALlEg/iXWP92JvI6cSoo
 4cZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kC5lpJodoKWj+ThkQS/GDtjtBRuSiV1pCUjMNbQXHOY=;
 fh=DJsbMy451zr0mh/Z0V4bRpjr87Y8B2l0s11WbT+nsIg=;
 b=rQCJo5q3X2slSOc/L0Yrqw0bmgk7FKFSYF+sjcFe84c+vU/OHqMFxrhzg7Xpba6sZq
 3qWPi/Wp2WYumJ9ve3EuyMGiNd3m5bFlW+rMr3sy7oTF3EcEcQpQQZVJ8DhPCEcISIJC
 l6P2tZ4d3uUelQ/vHJO0IEZsgM0Cxri4UPcAvPrcgC33UPbqn/8FvyUUcfAaC3N101RR
 H2dhtE0vne233GjiVAF1ypJHsVJg2+QtTJWhzib3HmSIIFPWpB2fMMWC0WApQ15rGX73
 9G9Fjqa6R5ZdPhb6PSChtDXkY8i3+4jI8OXLWQxIpVz11XFHgoHYQYbBrDX4cYsTy302
 ZPPg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790758945; x=1791363745; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kC5lpJodoKWj+ThkQS/GDtjtBRuSiV1pCUjMNbQXHOY=;
 b=W/WV73hAhjwLW0/sgzZ3s1ot5/2u/yFoHPRygr9Qab9pALL1aUNarEPeV/IhHXuLrp
 Qv1RgG3rIBhR5c14HPzPVJU/e5YoYSTHIYxzoG5VWQlKnN9dIgLMyoBv9K9wTWgC6547
 NX6dTIliawH+vbes4rYUOjpqtAaL0KAhaLTvnHo1l95eygtIlqjCiI2GWiSMDYaLB7+Q
 1MpWu7SBeW+mAaENfTQqR+/oca/ByHMFwIxYpVNhV1aw38AI4if/9Nqws1BzS7mFpPYD
 D07wHhm4jwk9L5Fj/8byqk14YzyuaxuTjECHzlDmiygulbhSo/TF9QC+eR9gMKjfTRFJ
 l00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790758945; x=1791363745;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kC5lpJodoKWj+ThkQS/GDtjtBRuSiV1pCUjMNbQXHOY=;
 b=pK54PT/t++jQonKFqnUrrvulRqjn5zHF4OCl1VHA+GsKtfhgsklQmMuv4gm+uyzoBG
 uYMqxnEnSbtIU50XimHIcg0bWUjRgVBh2OccUE6wNB77Ix9VVcEmM+UHgaw/JnLHklr/
 dGIL98yW0hxdXv8caSqRtqrWklQEEjcNVSvWp1W1eBVgv+lRydah4om7cnOfTxG5euBj
 5nVvEgIxM1PmfEl3i7tyTOfCgZUoxcHqQJ4cbFBfHxG8D3hk8aMu/pk2qawQoth5sRzR
 Cyynzg/6eDcpFhJg3ws4p1QvJsx5eQOt+1OsG0rp0zQviweZcLf9+0GQzv+3FORqP/E+
 EtvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwopO38BzFtVNY/PuVFmthXOTPzEvtLIhi2yUzLOR9CTiWCi3/wEpOyvbEmEvXYuNTAAOFhTx/oCAw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI3YDY6XDLAeCxMx2F4AJWoDqZ+WLuChMZqZRDwUiON+cJaHZJL
 6g69yEbtBhDWVLfuhy4Wf7BJCH4mZBVS5mt3aI9t2vsnyZ8/SP64tQ4SJPQee/w2Xm6eZry1qSS
 +Sw0+o1uXVlpjMqn3NYq/9MgkVW17RNWOCg==
X-Gm-Gg: AYBFou3/YqWLAcxp82lzskzRspWIM+AfQ83K92I0n+QOotjPQ7hSPAvo4CU8DX5MU5q
 Hsz5HaYSaXZxHQFa8ZR2FQ3IJOm/ajOPi1RV6flt1S58++UhbH5sNAOJWrIr4T9+aD3cDXkRfGO
 hPCQloZPLG1ysv1m9FAOVvdT7hnLMzyj06GAxGkTZ9yfNhU0ZaaHejVUePo3p6IDIdAK+c3VKQN
 FmWrHCCIEA91kdXnNHtpTBvqR3GctOj0StbFayaIz+5tg1ICqkjEON6EtOGJOHDqYKLD8Stha0M
 VhAkttKm3X4PaTseM89oSZdevg0opEfKOWUODuCLXLCzTnGRA4TPjW7MP0KboyTTNON6x1fq6PT
 FM23ahzB15y0EBSJaKnJp8+c=
X-Received: by 2002:a05:7301:4b12:b0:34c:85c:da56 with SMTP id
 5a478bee46e88-34cdc1ce152mr1130423eec.17.1790758945369; Wed, 30 Sep 2026
 02:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-5-clamor95@gmail.com>
 <arzMjoi2LcyfxCzN@orome>
In-Reply-To: <arzMjoi2LcyfxCzN@orome>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 30 Sep 2026 12:02:14 +0300
X-Gm-Features: AclHuK9Pghb36l-P22g_3lrlycHGrleGAXYX6a3Jb3oFvTmErepUHWwZ9_v-FXc
Message-ID: <CAPVz0n1WnhwOqz2xOp_0SsbgUFuYAf5YBByoMv_+XUDPANvhFw@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] drm/tegra: Add support for 8-bit CPU interface
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
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

=D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 11:48 Thie=
rry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Sep 30, 2026 at 10:05:33AM +0300, Svyatoslav Ryhel wrote:
> > The display controller in Tegra20/30 SoCs features an 8-bit SPI interfa=
ce
> > that closely resembles the MIPI DBI Type B protocol and is referred to =
as
> > '8-bit CPU'. Each display controller provides two such interfaces, whic=
h
> > can be used to send MIPI DCS commands to initialize and control the pan=
el
> > while image data is transmitted via 16/18/24-line RGB.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/gpu/drm/tegra/Kconfig      |   7 +
> >  drivers/gpu/drm/tegra/Makefile     |   1 +
> >  drivers/gpu/drm/tegra/cpu-bridge.c | 427 +++++++++++++++++++++++++++++
> >  3 files changed, 435 insertions(+)
> >  create mode 100644 drivers/gpu/drm/tegra/cpu-bridge.c
>
> This doesn't need to be a separate driver. It should all live in dc.c.
> Or maybe even rgb.c, since it uses pretty much the same pins and is
> quite similar to it.
>

I don't mind moving this to dc or rgb, my intention was to avoid
bloating them with smth that is not used often and is present only on
Tegra20 and Tegra30.

> Thierry
