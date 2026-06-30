Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2058C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 17:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8668D10E22E;
	Tue, 30 Jun 2026 17:27:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XbHQV/Xo";
	dkim-atps=neutral
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C04710E222
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 17:27:27 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-51c149c5722so10633241cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 10:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782840446; x=1783445246;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xjlDrMRoPYYkrW6DmAw6cn1cINOF/LZ70UTrDBTu1Oc=;
 b=XbHQV/XoPiBHIUrxLCywf8n49YhQrRUQMicCwXbPvYIk1fb93la5x6N2J0XQR/z4Mb
 ZXD9bAkz5nPzzNmx0cfxLLWFlPNXbY28vMrniiWk88b0ceuuyHZMO1plwAbEYithLfkk
 JhowtRRyflmivO69/N3PfhAeoNVsCWIy2VlMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782840446; x=1783445246;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xjlDrMRoPYYkrW6DmAw6cn1cINOF/LZ70UTrDBTu1Oc=;
 b=jUfMcjw4HHek87937XaiW2S3Jm9EN5iWjToTI72dFQMKnbW5nOAhHeC4p9/VSLY4Ku
 kdyc6fnDMDQNhj1Hg5Ye4FU2V9dGx/fYSYpKhaYZHIzzHByeC4yq1BCPIcgAhN+jkaqw
 wvesVcsAcMy3Ype2YItGlDNc3MUQhd8q1LDuFe/FZRimTE+/PuUUtH8+i2I/gw+fHQ9R
 dYHQohmqzhZgTqw+uqsAF5OIKIUuvuGJ+xNMEed84kab2arSWvDiTTV34doPtjhITwfK
 +xQoaxmGrQZ9U4ecNaY4ksO3M7ZkNeTyLkM1mFXuAPz4m+pkIEJxzW2X9nju+ZEWvi5X
 N7bA==
X-Gm-Message-State: AOJu0YxNMsN40Aao84HOaXGykxT2O12T8q8z9iNH8qYisvv/sahCvMFi
 fu/DWRrVzyKTakcd6PVebJGDyaiLjh89lgYc+I0zQpReXH0Afv7HYZKMJzrahW2muNPme07Im2W
 X9PU=
X-Gm-Gg: AfdE7cmwYj9382+Q4nNVz+B5425oibR2ukw7Luf+CTKaPOx/K36btNPDZU6FxfRT4cS
 efI+XTg3E5NNizy028DFNygTd12Nu9pkzsv+Tf2QkKPm+frp1JJIfAq0NOQUefGVEUZwtidvxGO
 8IRg0ke2UPUoMFNYUyxG+NhejMfB6ai4KObYMUON1Yt+JmNyNu6oiz5iOP0XAsdqGXu+wFDonKF
 3pkfCn3ktBzg1fw8RoEgmwofszz3X4tB9kgRFZQgJB+mbnmJGj6ex2rNFCvmMOipVGjCMqs0uYi
 fYR/T66TsdJiMRYuzUsAsiaXWHgWHpGzj+Jlddv2RQGEYDyzHlCUiGS3BCQU3nQw9zLUvYGGkdN
 wDRoKwkhSFC1v+Ba3mvK57n8EVTX3FQmgzDOjN1Jq4L4XyflNVf4Bkajqm7qvcUgGXG8pzURv2Z
 dG2KT9SR1vLcZ183UmUM1N0XtaifzWY4xEwxEV7u/LOpGdOGkyBuU=
X-Received: by 2002:a05:622a:15d2:b0:50e:474a:47e1 with SMTP id
 d75a77b69052e-51c17d68794mr31146981cf.10.1782840445776; 
 Tue, 30 Jun 2026 10:27:25 -0700 (PDT)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com.
 [209.85.219.41]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c1080d4dcsm22631741cf.5.2026.06.30.10.27.24
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 10:27:24 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-8eaa7b5e31eso7784976d6.0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 10:27:24 -0700 (PDT)
X-Received: by 2002:a05:6214:2a4a:b0:8f1:5e32:9b06 with SMTP id
 6a1803df08f44-8f2526fae93mr34640366d6.13.1782840443561; Tue, 30 Jun 2026
 10:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260629012200.248066-1-zhouhaikun5@huaqin.corp-partner.google.com>
 <20260629012755.613EC1F000E9@smtp.kernel.org>
In-Reply-To: <20260629012755.613EC1F000E9@smtp.kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 30 Jun 2026 10:27:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XHxvW6+wWGz7zRHwxusfaMonDQT+gD2v7HHY_K7yGD+A@mail.gmail.com>
X-Gm-Features: AVVi8CdfztTOVwUr0FcV6Z32wSoWmheiYIh35uOdZjrqLBaiLQ-1koiT0DGa2Cc
Message-ID: <CAD=FV=XHxvW6+wWGz7zRHwxusfaMonDQT+gD2v7HHY_K7yGD+A@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Support MB116AS01-3 edp panel
To: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev
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

On Sun, Jun 28, 2026 at 6:28=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The panel name string in `EDP_PANEL_ENTRY` does not match the =
actual hardware EDID, breaking the primary identity match.
> --
>
> commit 0f4c5c953c19a29919cb343c3bc25a2803059da7
> Author: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
> drm/panel-edp: Support MB116AS01-3 edp panel
>
> This commit adds support for the HKC MB116AS01-3 eDP panel to the generic
> panel-edp driver. It introduces the necessary delay configuration and EDI=
D
> identifiers for this display.
>
> > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/=
panel-edp.c
> > --- a/drivers/gpu/drm/panel/panel-edp.c
> > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > @@ -2099,6 +2099,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
> >
> >       EDP_PANEL_ENTRY('E', 'T', 'C', 0x0000, &delay_50_500_e200_d200_po=
2e335, "LP079QX1-SP0V"),
> >
> > +     EDP_PANEL_ENTRY('H', 'K', 'C', 0x1203, &delay_200_500_e80, "MB116=
AS01-3"),
>
> [Severity: Medium]
> Does the panel name string in this entry match the actual hardware EDID?
>
> Looking at the raw EDID payload provided in the commit message:
> 00 4d 42 31 31 36 41 53 30 31 27 33 20 20 01 cb
>
> The byte 0x27 translates to an apostrophe ('), which makes the hardware n=
ame
> "MB116AS01'3" rather than "MB116AS01-3" (which would use a hyphen, 0x2d).
>
> Because drm_edid_match() strictly compares this string against the EDID
> payload using strncmp(), this character mismatch will cause the primary
> identity match to fail during panel probe. While the code will currently =
fall
> back to a secondary panel ID match, this completely bypasses the primary =
name
> matching mechanism designed to distinguish panels when vendors incorrectl=
y
> reuse panel IDs.

Please fix the AI's review feedback and send a v2.

-Doug
